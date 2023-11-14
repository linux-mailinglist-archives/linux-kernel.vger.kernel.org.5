Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE617EB702
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjKNTtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNTtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:49:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6988DC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:49:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CA8C433C8;
        Tue, 14 Nov 2023 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699991368;
        bh=DN5Wr4F+DfVrA4YTg0lZGYNXWUnvcZpMIpwoKCNGtts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mN277XcJWDD1mwWqIHkGVR//AvS7j7t4dqv3Zxe5qYEelse/EinS0YeIOALLgM9tV
         q+Zu9kRktOB8xEx3KSjeUooI2mw0Lp3vr4CW9/6iVdZhRfF48un8qRKr0EKuUxnu0k
         U84BBuzJViYS2BbbFeP3zGwcgtlTXtD5JdwVi3NyxenGkfvO/Velay3M6W+KkqZc7b
         r3nJwQOe+mBSe9XfG97evkR2WurhlKH2YCYmWU07JBW0FqIVHs3KFvtJfCSMfrri7j
         HlQC3IW2nPYeYsp7TaUJ57U0DWpe/lkn7AkRgyXQKvl0bzEHVpr8HGSED6FoH7s4Oe
         qkWg7k0Vn2c/w==
Date:   Tue, 14 Nov 2023 19:49:24 +0000
From:   Simon Horman <horms@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: |PATCH] stmmac: dwmac-loongson: Add architecture dependency
Message-ID: <20231114194924.GH74656@kernel.org>
References: <20231113154522.0bca3521@endymion.delvare>
 <20231113180107.GA52493@kernel.org>
 <20231113193347.67dd7f75@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113193347.67dd7f75@endymion.delvare>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 07:33:47PM +0100, Jean Delvare wrote:
> Hi Simon,
> 
> On Mon, 13 Nov 2023 18:01:07 +0000, Simon Horman wrote:
> > On Mon, Nov 13, 2023 at 03:45:22PM +0100, Jean Delvare wrote:
> > > Only present the DWMAC_LOONGSON option on architectures where it can
> > > actually be used.
> > > 
> > > This follows the same logic as the DWMAC_INTEL option.
> > > 
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Cc: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > > I'm not familiar with the hardware, so please let me know if the
> > > dependency needs to be adjusted somehow.
> > > 
> > >  drivers/net/ethernet/stmicro/stmmac/Kconfig |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- linux-6.6.orig/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > +++ linux-6.6/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > @@ -269,7 +269,7 @@ config DWMAC_INTEL
> > >  config DWMAC_LOONGSON
> > >  	tristate "Loongson PCI DWMAC support"
> > >  	default MACH_LOONGSON64
> > > -	depends on STMMAC_ETH && PCI
> > > +	depends on MACH_LOONGSON64 && STMMAC_ETH && PCI  
> > 
> > Could we consider also allowing the build to occur if COMPILE_TEST is set?
> > This would maintain the current level of build test coverage.
> > 
> > Something line this (completely untested!):
> > 
> > 	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
> 
> Sure, that would be totally fine with me.

Thanks,

I think that if no one objects within the next day or so then posting a v2
would be a good next step.
