Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946887E9D69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjKMNmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjKMNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:42:35 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D81132;
        Mon, 13 Nov 2023 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wkQ+FgkxzquG4ewqTMGe1TjLComVqGRo/gT/ErcIyws=; b=Ab61DgyiBMrtfK/GFu50kLtzw4
        mOwSt1FMbbLMf3mLB9xKpsm65+FD0L5WzNll3NYYqZWtphtAaJ2F5fzkIPDwCjdWokjLdM4pCquGh
        IVzyCLfvm7xfo+wLT7H1kSLys5BXl8oUuWf5S9Lx27LKmwO0z7n2pabyrfGj7zMj0pm1YJqpE9S2j
        WFy8hqzfGLp8VVaTw9LTRpAdHVOhZHeknu6dgAWN0hZCfh/A7g3EUMGr2qrOSK0H1b7c1YJceK0eT
        ktusTIptHxgzdmPgcvC7XBOHY57CcS8dkC+oz9XF1mbTehTLLOwTm8Fcn5kPE2ghiDnYRtlj5JSJI
        2OqDTWiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35884)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r2XCm-0006eG-2S;
        Mon, 13 Nov 2023 13:42:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r2XCm-0004aG-Gr; Mon, 13 Nov 2023 13:42:20 +0000
Date:   Mon, 13 Nov 2023 13:42:20 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Jie Luo <quic_luoj@quicinc.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZVInvOqh6QAvNJtw@shell.armlinux.org.uk>
References: <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
 <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
 <20231111225441.vpcosrowzcudb5jg@skbuf>
 <39a8341f-04df-4eba-9cc2-433e9e6a798e@quicinc.com>
 <20231112235852.k36lpxw66nt7wh2e@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112235852.k36lpxw66nt7wh2e@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:58:52AM +0200, Vladimir Oltean wrote:
> On Sun, Nov 12, 2023 at 07:27:50PM +0800, Jie Luo wrote:
> > Sure Vladimir, Thanks for sharing this patch.
> > 
> > BTW, When do you upstream this patch? or Maybe you can upstream the
> > separate patch for introducing the new interface mode 10g-qxgmii firstly? if
> > that, i can also update qca8084 phy driver based on
> > your patch.
> 
> I've removed the driver changes from the patch and formatted it on
> net-next. There's also one more dependency patch. Both are attached to
> this email.
> 
> I don't think I will find the time to upstream them by the time you
> need them. I think it would be best if you could take these patches,
> add your Signed-off-by: tag below mine, and submit them as the first 2
> patches of your own series.

> From 17fd68123d78f39a971f800de6da66522f71dc71 Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Tue, 3 Oct 2023 22:16:25 +0300
> Subject: [PATCH 1/2] net: phylink: move phylink_pcs_neg_mode() to phylink.c
> 
> Russell points out that there is no user of phylink_pcs_neg_mode()
> outside of phylink.c, nor is there planned to be any, so we can just
> move it there.

Looks familiar...

http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=c2aa9d3846c218d28a8a3457b0447998b0d84c5d


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
