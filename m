Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6F76604F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjG0XsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG0XsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58530F7;
        Thu, 27 Jul 2023 16:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E749061EFF;
        Thu, 27 Jul 2023 23:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB57C433C7;
        Thu, 27 Jul 2023 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690501702;
        bh=leAC5f+fPlZ/cfu7jAxbCYBzhzOHtZlQG/UH+1WwYJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k0s7B5clwMRIUnKXxzjuwBkCWS4MLUNGeaj8MCrix0Inaxm9GcXL01oJrC+TDOlTg
         ArMX+warqSug5XXdNKHTZ+WX+q0fXx7DfyExGtR38N4NQkgnDQN334EWobNwkDFXzh
         9lruDdJRfoyOwZBR3iYUL0anjcSSh/ouNhV9UhGYauq3idrDurIAb9ZJGOUDNezQ+h
         TT2BJYT6OMZ4L+TjeYbUMLrDuNN8QjsnvgmKLIPThgDbfVxf5MZ9mL/SZXfVU8E+uG
         R1SMBWAVNuHQNbUcS4otOrKg7FPdPx2r52OeUp59iL+dspB9gSnzatRN0Z0Mv+/yoZ
         P4ezf3AdhlvcA==
Date:   Thu, 27 Jul 2023 16:48:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Paolo Abeni <pabeni@redhat.com>, Zheng Wang <zyytlz.wz@163.com>,
        <lee@kernel.org>, <linyunsheng@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <richardcochran@gmail.com>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <magnus.damm@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
        <biju.das.jz@bp.renesas.com>, <wsa+renesas@sang-engineering.com>,
        <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hackerzheng666@gmail.com>,
        <1395428693sheep@gmail.com>, <alex000young@gmail.com>
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230727164820.48c9e685@kernel.org>
In-Reply-To: <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
        <20230725201952.2f23bb3b@kernel.org>
        <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
        <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 21:48:41 +0300 Sergey Shtylyov wrote:
> >> Still racy, the carrier can come back up after canceling the work.  
> > 
> > I must admit I don't see how/when this driver sets the carrier on ?!?  
> 
>    The phylib code does it for this MAC driver, see the call tree of
> phy_link_change(), on e.g. https://elixir.bootlin.com/linux/v6.5-rc3/source/...
> 
> >> But whatever, this is a non-issue in the first place.  
> > 
> > Do you mean the UaF can't happen? I think that is real.   
> 
>    Looks possible to me, at least now... and anyway, shouldn't we clean up
> after ourselves if we call schedule_work()?However my current impression is
> that cancel_work_sync() should be called from ravb_close(), after calling
> phy_{stop|disconnect}()...
>
> >> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> >> more suspicious.  
> > 
> > Indeed! But that should be a different patch, right?  
> 
>    Yes.
> 
> > Waiting a little more for feedback from renesas.  
> 
>    Renesas historically hasn't shown much interest to reviewing the sh_eth/ravb
> driver patches, so I took that task upon myself. I also happen to be a nominal
> author of this driver... :-)

Simplest fix I can think of is to take a reference on the netdev before
scheduling the work, and then check if it's still registered in the work
itself. Wrap the timeout work in rtnl_lock() to avoid any races there.
