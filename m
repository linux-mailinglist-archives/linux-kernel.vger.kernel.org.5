Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0807670AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbjG1Pgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjG1Pg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2DD10FA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE5362179
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD475C433C8;
        Fri, 28 Jul 2023 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690558582;
        bh=g4K5vq4lPyGBYhqgJJE0//L14vL/7BRJwDrh2+NOlqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0/2qOh9DNQM/zNi5r9udD62Tuu5Uosyrt7S4golN5beku3HBItbqx/hsmFGSsjso
         /K78hYySn6CsOKCp40tUlRsYRNgEQR/ZSeR3x2gxM6/SvBC/W1YQyj7muSEibPxpt4
         9fx5kaG5gptMsk367e7ditSVFDcX2XzKOQai8PgIupG70U0dRp3wNZW74zkoQPzZ/g
         DdsyYULweQssqFoRfX7p2gW8o4eVxrtPtFqJjxOjm0Ib1hFQBJULx5RV4D8BgBxHCD
         dMb7FJIYJfoGEcIG/KcIdeYFlcF4Pb77Kzu9Gez3zZTCGgrk3wvZLSiigrkx4o4R2s
         S/qZhlXIcMYCQ==
Date:   Fri, 28 Jul 2023 16:36:12 +0100
From:   Will Deacon <will@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
        Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the TXC clock
 in fixed-link
Message-ID: <20230728153611.GH21718@willie-the-truck>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
 <20230727152503.2199550-3-shenwei.wang@nxp.com>
 <4govb566nypifbtqp5lcbsjhvoyble5luww3onaa2liinboguf@4kgihys6vhrg>
 <ZMPdKyOtpZKEMLsO@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMPdKyOtpZKEMLsO@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:22:19PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 27, 2023 at 01:36:45PM -0500, Andrew Halaney wrote:
> > I don't have any documentation for the registers here, and as you can
> > see I'm an amateur with respect to memory ordering based on my prior
> > comment.
> > 
> > But you:
> > 
> >     1. Read intf_reg_off into variable iface
> >     2. Write the RESET_SPEED for the appropriate mode to MAC_CTRL_REG
> >     3. wmb() to ensure that write goes through
> 
> I wonder about whether that wmb() is required. If the mapping is
> device-like rather than memory-like, the write should be committed
> before the read that regmap_update_bits() does according to the ARM
> memory model. Maybe a bit of information about where this barrier
> has come from would be good, and maybe getting it reviewed by the
> arm64 barrier specialist, Will Deacon. :)
> 
> wmb() is normally required to be paired with a rmb(), but we're not
> talking about system memory here, so I also wonder whether wmb() is
> the correct barrier to use.

Yes, I don't think wmb() is the right thing here. If you need to ensure
that the write to MAC_CTRL_REG has taken effect, then you'll need to go
through some device-specific sequence which probably involves reading
something back. If you just need things to arrive in order eventually,
the memory type already gives you that.

It's also worth pointing out that udelay() isn't necessarily ordered wrt
MMIO writes, so that usleep_range() might need some help as well.
Non-relaxed MMIO reads, however, _are_ ordered against a subsequent
udelay(), so if you add the readback then this might all work out.

I gave a (slightly dated) talk about some of this at ELC a while back:

https://www.youtube.com/watch?v=i6DayghhA8Q

which might help.

Will
