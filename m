Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2477CAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjHOKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjHOKIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E0E65;
        Tue, 15 Aug 2023 03:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E58A64198;
        Tue, 15 Aug 2023 10:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A8AC433C7;
        Tue, 15 Aug 2023 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692094131;
        bh=WXxWFK899KIgLhrs+YGjc/laHsehwNLisxtjpNW6J/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvgP8muNwp07RnaQ0dcY4SFvNTuZwpyxYcLkIPYOlcP4sK9knXZm1pbF9ta6TxIKY
         LjY8L7LrO/sXH5Yihk9BVPi15qkVk/U3/Z/xvbS5PJJrVGNMTy9R48nAEiF7G81K0M
         2ngiHSvzNWnWzklRmrUfbfsSjEIukoqy1YQLvpId/GAVL9yUCcapJPQulBOGbtBq5X
         cLhb7HOo/Y3W/zv1Kqphn0jFXJl2Ezju10Is/H2qjBzljRAs5ZZaGVt8QbfHH/6bYG
         kRtDYZgWjuEXfb30hFtYw+U9Qh8CdOw2buRyK65OWhokkwxBpRL1+ndDsq6NyrHgx5
         lgubSVX4m2bRA==
Date:   Tue, 15 Aug 2023 11:08:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     s.shtylyov@omp.ru, linyunsheng@huawei.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, p.zabel@pengutronix.de,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
        wsa+renesas@sang-engineering.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230815100844.GA495519@google.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725030026.1664873-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023, Zheng Wang wrote:

> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> If timeout occurs, it will start the work. And if we call
> ravb_remove without finishing the work, there may be a
> use-after-free bug on ndev.
> 
> Fix it by finishing the job before cleanup in ravb_remove.
> 
> Note that this bug is found by static analysis, it might be
> false positive.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> v4:
> - add information about the bug was found suggested by Yunsheng Lin
> v3:
> - fix typo in commit message
> v2:
> - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> add an empty line to make code clear suggested by Sergey Shtylyov
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Trying my best not to sound like a broken record, but ...

What's the latest with this fix?  Is a v5 en route?

-- 
Lee Jones [李琼斯]
