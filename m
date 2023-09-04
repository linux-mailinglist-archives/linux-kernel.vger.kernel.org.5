Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB1791AC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351869AbjIDPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIDPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:40:32 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E183;
        Mon,  4 Sep 2023 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uA8feDnfGHOk6NcJ6jrXFKT175jb13DVc+EiyDbwTPA=; b=xuzUWMHsXGqAZRQ52Hk+bYd9vb
        8qK4wqmRuiiU0q60skq3F8zPEhiOJ7czhr4HDQ2yRd9me0L4jZ6SARUmzhlGioPmzkS6lul7wUcNU
        k0zZofi0DMgZ0yoa60hSdW7e7Aree+n1vaDr+SAmi67V2oGrRFkn6FYFU+yu1yMalkdqqpZkzN2wl
        eqN+xTJ57FQ5N6C3VR+G8e0+CAqvLZdR+2oLdFZXaVdnJXC9SQc7h+VM/qTCRKqmbIkLwSazH3Cm4
        v7cxYzxjH1pO0y6CaqahzWUDVKPjGRT+pbicU3B7pFg96uIIPVAGKPy6qC+/xisjPS+OcwLhXeF3C
        jmu48B2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40242)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qdBgT-00071H-35;
        Mon, 04 Sep 2023 16:40:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qdBgR-0002fG-PD; Mon, 04 Sep 2023 16:40:11 +0100
Date:   Mon, 4 Sep 2023 16:40:11 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Waiman Long <longman@redhat.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
Message-ID: <ZPX6W6q4+ECPbBmq@shell.armlinux.org.uk>
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <c98e6c5b-d334-075f-71b8-1c2a3b73b205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c98e6c5b-d334-075f-71b8-1c2a3b73b205@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 11:25:57AM -0400, Waiman Long wrote:
> 
> On 9/4/23 04:33, Rafał Miłecki wrote:
> > As those hangs/lockups are related to so many different changes it's
> > really hard to debug them.
> > 
> > This bug seems to be specific to the slow arch clock that affects
> > stability only when kernel locking code and symbols layout trigger some
> > very specific timing.
> > 
> > Enabling CONFIG_PROVE_LOCKING seems to make issue go away but it affects
> > so much code it's hard to tell why it actually matters.
> > 
> > Same for disabling CONFIG_SMP. I noticed Broadcom's SDK keeps it
> > disabled. I tried it and it improves stability (I had 3 devices with 6
> > days of uptime and counting) indeed. Again it affects a lot of kernel
> > parts so it's hard to tell why it helps.
> > 
> > Unless someone comes up with some magic solution I'll probably try
> > building BCM53573 images without CONFIG_SMP for my personal needs.
> 
> All the locking operations rely on the fact that the instruction to acquire
> or release a lock is atomic. Is it possible that it may not be the case
> under certain circumstances for this ARM BCM53573 SoC? Or maybe some Kconfig
> options are not set correctly like missing some errata that are needed.
> 
> I don't know enough about the 32-bit arm architecture to say whether this is
> the case or not, but that is my best guess.

So, BCM53573 is Cortex-A7, which is ARMv7, which has the exclusive
load/store instructions. Whether the SoC has the necessary exclusive
monitors to support these instructions is another matter, and I
suspect someone with documentation would need to check that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
