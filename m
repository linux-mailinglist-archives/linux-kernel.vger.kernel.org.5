Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47B76292F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGZDT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGZDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E8121;
        Tue, 25 Jul 2023 20:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC4261193;
        Wed, 26 Jul 2023 03:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA1CC433C8;
        Wed, 26 Jul 2023 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690341594;
        bh=BltmyiPPQL6jRY2ec5NbwR1NWR52L0x3e86Gyw3VwFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sRLJWeKnY5Prjmq6rcAVuByDIv+Vu2t4hA62N6jiPmR4xRcbYY5hc/8pQvMfPfBqo
         9yVaIqQt2dCaQ4L41jLXV/MYSNF7z3xNws13KgC5yz6QE1XADxdbn+aW510JW8Pkp8
         0mwZXCTrF28FkbS3L2VmOV0Q2w0YTMVg6mvLCU/5qET9LlBQohkw0tiu34VicLz73B
         tQzAcseuNpD7J5VFFMljXkAMkH6Y6zM660NHMFnGvB2NyYThXJ3ByPU6azy1wyV+bd
         Sr4UhK9K4fIvCGaYQZhVwA2JMf2KTgeoyweTffKH2cP/Ia77ekFwlKZLeM3S19crKB
         yMHY8vESxt8Nw==
Date:   Tue, 25 Jul 2023 20:19:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     s.shtylyov@omp.ru, lee@kernel.org, linyunsheng@huawei.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        richardcochran@gmail.com, p.zabel@pengutronix.de,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
        wsa+renesas@sang-engineering.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230725201952.2f23bb3b@kernel.org>
In-Reply-To: <20230725030026.1664873-1-zyytlz.wz@163.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 11:00:26 +0800 Zheng Wang wrote:
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 4d6b3b7d6abb..ce2da5101e51 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pdev)
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  
> +	netif_carrier_off(ndev);
> +	netif_tx_disable(ndev);
> +	cancel_work_sync(&priv->work);

Still racy, the carrier can come back up after canceling the work.
But whatever, this is a non-issue in the first place.
The fact that ravb_tx_timeout_work doesn't take any locks seems much
more suspicious.
