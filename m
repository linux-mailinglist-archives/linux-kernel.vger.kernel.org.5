Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025B77D10A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377405AbjJTNkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377295AbjJTNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:40:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1901A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:40:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391DCC433C8;
        Fri, 20 Oct 2023 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697809218;
        bh=QUgIszFC9PR7hifADV9OwR7xg5JhFJQzv8VBLmCiESQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eujd29yVfk+SOEkhiuPXF8LytUJSBe8qoAB2586oO53c9Y3yNLBCzsSt5j3iELZKO
         1LPfsqymImsItP8mOq07PtltWGt5imCsH004Vh33N4Mt7OzRny+quRuAqW41u+nuBj
         wAUrbM7hZ8GvrlGsCQeYL6Zx+rYcc8gd4XbX9HBPOhWLCM4jI6R16zfVlDSBCUpDr/
         ziLw+TMy6Xhm5q8fEOm5iw3DN0OhbaDbVBDa1I3DF+6ngtvP/7Sa+ee0SP1d1fBWrj
         OU+vHE/9qOY5rqPrGlacjyyXmhkz0c8jDvltAdboVVKo7+1Vk5J0WpxUeWv9P9rvui
         J4IFjXJ1516Gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC667CE0B9F; Fri, 20 Oct 2023 06:40:17 -0700 (PDT)
Date:   Fri, 20 Oct 2023 06:40:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org, frederic@kernel.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Message-ID: <585a49dc-4594-42be-9bb9-c52d5189058b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
 <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
 <87r0lq3j2t.ffs@tglx>
 <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
 <83c9317a-b1d2-4741-b955-98e7cd23595c@paulmck-laptop>
 <108abe1f-56bc-42d1-90c5-180a3d66b5ab@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108abe1f-56bc-42d1-90c5-180a3d66b5ab@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:50:48PM +0900, Tetsuo Handa wrote:
> On 2023/10/20 12:30, Paul E. McKenney wrote:
> > A bit of a long shot, but given your earlier console log, could you
> > please try Frederic's patches?
> > 
> > https://lore.kernel.org/lkml/20231019233543.1243121-1-frederic@kernel.org/
> 
> Didn't make difference.

Huh.  Thank you for trying it out!

							Thanx, Paul

> I booted another Ubuntu kernel used by installation ISO image, and found no problem.
> Maybe the only way to narrow down is to build various kernel configurations?
> 
> ubuntu-23.10-live-server-amd64.iso
> [    0.000000] Linux version 6.5.0-9-generic (buildd@bos03-amd64-043) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.41) #9-Ubuntu SMP PREEMPT_DYNAMIC Sat Oct  7 01:35:40 UTC 2023 (Ubuntu 6.5.0-9.9-generic 6.5.3)
> [    0.000000] Command line: BOOT_IMAGE=/casper/vmlinuz console=ttyS0,115200n8 console=tty0 ---
> (...snipped...)
> [    0.896948] smp: Bringing up secondary CPUs ...
> [    0.899571] smpboot: x86: Booting SMP configuration:
> [    0.901912] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> [    0.914558] TSC synchronization [CPU#0 -> CPU#1]:
> [    0.916496] Measured 62205 cycles TSC warp between CPUs, turning off TSC clock.
> [    0.916496] tsc: Marking TSC unstable due to check_tsc_sync_source failed
> [    0.940504] smp: Brought up 1 node, 8 CPUs
> [    0.944498] smpboot: Max logical packages: 1
> [    0.946468] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)
> 
