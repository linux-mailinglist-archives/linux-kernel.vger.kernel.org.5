Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01D77E499
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjHPPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbjHPPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F902D4D;
        Wed, 16 Aug 2023 08:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E3066AA1;
        Wed, 16 Aug 2023 15:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F794C433C8;
        Wed, 16 Aug 2023 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692198223;
        bh=ybS6uqvUJjZUOrjpJirDQxk6fGQf8MUbm6m3qINtles=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljEsF4ZyI0sF50+4wHtnjRTLWK+sgJA8Dtlz7c/FGGq7vSw8VUd5t/eGcbx7ea77F
         KQjefUoRyQqAdvthzEzwbF6Hf8+j62t08/R7DDINL/AQt48ONzKpmJ5Xz/10WXST9Q
         EffHv/DFsEb/38B0BsMdroXYnySupq4FPmiruDn8=
Date:   Wed, 16 Aug 2023 17:03:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     saravanak@google.com, stable@vger.kernel.org,
        John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= Navarro 
        <ricardo.canuelo@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        usama.anjum@collabora.com, kernelci@lists.linux.dev
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
Message-ID: <2023081619-slapping-congrats-8e85@gregkh>
References: <20220613094924.913340374@linuxfoundation.org>
 <20220613094928.793712131@linuxfoundation.org>
 <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:09:27PM +0530, Shreeya Patel wrote:
> On 13/06/22 15:40, Greg Kroah-Hartman wrote:
> > From: Saravana Kannan<saravanak@google.com>
> > 
> > [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
> > 
> > Mounting NFS rootfs was timing out when deferred_probe_timeout was
> > non-zero [1].  This was because ip_auto_config() initcall times out
> > waiting for the network interfaces to show up when
> > deferred_probe_timeout was non-zero. While ip_auto_config() calls
> > wait_for_device_probe() to make sure any currently running deferred
> > probe work or asynchronous probe finishes, that wasn't sufficient to
> > account for devices being deferred until deferred_probe_timeout.
> > 
> > Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
> > until the deferred_probe_timeout fires") tried to fix that by making
> > sure wait_for_device_probe() waits for deferred_probe_timeout to expire
> > before returning.
> > 
> > However, if wait_for_device_probe() is called from the kernel_init()
> > context:
> > 
> > - Before deferred_probe_initcall() [2], it causes the boot process to
> >    hang due to a deadlock.
> > 
> > - After deferred_probe_initcall() [3], it blocks kernel_init() from
> >    continuing till deferred_probe_timeout expires and beats the point of
> >    deferred_probe_timeout that's trying to wait for userspace to load
> >    modules.
> > 
> > Neither of this is good. So revert the changes to
> > wait_for_device_probe().
> > 
> > [1] -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> > [2] -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
> > [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
> 
> Hi Saravana, Greg,
> 
> 
> KernelCI found this patch causes the baseline.bootrr.deferred-probe-empty test to fail on r8a77960-ulcb,
> see the following details for more information.
> 
> KernelCI dashboard link:
> https://linux.kernelci.org/test/plan/id/64d2a6be8c1a8435e535b264/
> 
> Error messages from the logs :-
> 
> + UUID=11236495_1.5.2.4.5
> + set +x
> + export 'PATH=/opt/bootrr/libexec/bootrr/helpers:/lava-11236495/1/../bin:/sbin:/usr/sbin:/bin:/usr/bin'
> + cd /opt/bootrr/libexec/bootrr
> + sh helpers/bootrr-auto
> e6800000.ethernet	
> e6700000.dma-controller	
> e7300000.dma-controller	
> e7310000.dma-controller	
> ec700000.dma-controller	
> ec720000.dma-controller	
> fea20000.vsp	
> feb00000.display	
> fea28000.vsp	
> fea30000.vsp	
> fe9a0000.vsp	
> fe9af000.fcp	
> fea27000.fcp	
> fea2f000.fcp	
> fea37000.fcp	
> sound	
> ee100000.mmc	
> ee140000.mmc	
> ec500000.sound	
> /lava-11236495/1/../bin/lava-test-case
> <8>[   17.476741] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=deferred-probe-empty RESULT=fail>
> 
> Test case failing :-
> Baseline Bootrr deferred-probe-empty test -https://github.com/kernelci/bootrr/blob/main/helpers/bootrr-generic-tests
> 
> Regression Reproduced :-
> 
> Lava job after reverting the commit 5ee76c256e92
> https://lava.collabora.dev/scheduler/job/11292890
> 
> 
> Bisection report from KernelCI can be found at the bottom of the email.
> 
> Thanks,
> Shreeya Patel
> 
> #regzbot introduced: 5ee76c256e92
> #regzbot title: KernelCI: Multiple devices deferring on r8a77960-ulcb
> 
> ---------------------------------------------------------------------------------------------------------------------------------------------------
> 
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
> * If you do send a fix, please include this trailer: *
> * Reported-by: "kernelci.org bot" <bot@...> *
> * *
> * Hope this helps! *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> stable-rc/linux-5.10.y bisection: baseline.bootrr.deferred-probe-empty on
> r8a77960-ulcb

You are testing 5.10.y, yet the subject says 5.17?

Which is it here?

confused,

greg k-h
