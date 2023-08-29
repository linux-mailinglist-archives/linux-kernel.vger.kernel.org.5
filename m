Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1136278C66B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjH2Nrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjH2Nrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A545E5A;
        Tue, 29 Aug 2023 06:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38EA63E22;
        Tue, 29 Aug 2023 13:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BDCC433C7;
        Tue, 29 Aug 2023 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316783;
        bh=mxUSGoaiwDu9p3NHVkQW2/eRUPS+fI4b+7+yluZCnZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTBNFf91Si/pjCRqCKIwNMeD7UY8htfyBKc+B+DV45VggRervqbx3MDnbkEcjeYyb
         XLX4R2uvdznzl3fy/E4L/E+Xn/FDbd3I4bwAVVi6PKKdXij5MECU4Aa8SbCI9cqzi1
         M+8vQ+pOR1M2W98JCUamxm28VRWo3iP6iWDWbrCu2nO/lE0Qxl8Ij1nr0b05TyozXf
         gOZZfT07ge+JLQ0hYzUXtS9JQu1JTo/Y+2QrEtO0xSeloR8S8XpIFWhKahMEpqNQaQ
         YK2KMYjsZC2/9sk34g6EEC3KIAVg2A3vg3XWD3IDS6GThkag+C+G1Hzy0395IKxN28
         cve3TJVy1b0aA==
Date:   Tue, 29 Aug 2023 14:46:16 +0100
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
Message-ID: <20230829134616.GA215597@google.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230815100844.GA495519@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815100844.GA495519@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023, Lee Jones wrote:

> On Tue, 25 Jul 2023, Zheng Wang wrote:
> 
> > In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> > If timeout occurs, it will start the work. And if we call
> > ravb_remove without finishing the work, there may be a
> > use-after-free bug on ndev.
> > 
> > Fix it by finishing the job before cleanup in ravb_remove.
> > 
> > Note that this bug is found by static analysis, it might be
> > false positive.
> > 
> > Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > ---
> > v4:
> > - add information about the bug was found suggested by Yunsheng Lin
> > v3:
> > - fix typo in commit message
> > v2:
> > - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> > add an empty line to make code clear suggested by Sergey Shtylyov
> > ---
> >  drivers/net/ethernet/renesas/ravb_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Trying my best not to sound like a broken record, but ...
> 
> What's the latest with this fix?  Is a v5 en route?

Any update please Zheng Wang?

-- 
Lee Jones [李琼斯]
