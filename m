Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAA7CC59E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJQOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjJQOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:11:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDEF0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:11:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F0FC433C8;
        Tue, 17 Oct 2023 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697551873;
        bh=C+zGadaHwfOd74zIWHTHTzMU6aRU34ew/PXDW8ogT5w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tugooydZmUt5cJGnJ6rQmHx8hq0BedzTJK2w+XwhNQypjTYFQbBZYP04G4vOEf8mx
         Q8JWv+5o984m/LEuPmU0xcWyYtOxPpXWReczc3runKKsUsbVTyeZI/c2HkIZan3YUF
         fyUZ6cUSYUexU0gsTPbK4YuF4BXs7ZN7GA72c+LmmptccLWFmkbOCPo9Sgg+4vKVm4
         AQ1MHmjcXvyMiG19gxe4ePWDXm6HR+VinUSypeZ40Cqzlf0rCk4NS2wA8qlH5w9a/C
         hvk1Q1Oi99JVDfYVzsjBbKUvZj2aXEMFTbKWT2jdDIzCvGnSWODYOnANQC8eXghaqs
         tEt/LVdcyRN5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 98B56CE03B0; Tue, 17 Oct 2023 07:11:13 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:11:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Message-ID: <d76da5a6-d4fa-405b-8fec-7b87cb776e71@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <ae4e5836-bc42-42fa-bd41-2a2fd483acb5@paulmck-laptop>
 <8734y97ng5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734y97ng5.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:49:46AM +0200, Thomas Gleixner wrote:
> On Mon, Oct 16 2023 at 16:03, Paul E. McKenney wrote:
> > On Mon, Oct 16, 2023 at 11:47:55PM +0200, Thomas Gleixner wrote:
> >> That said, this whole clocksource watchdog mess wants a proper
> >> overhaul. It has become a pile of warts and duct tape by now and after
> >> staring at it long enough there is no real reason to run it in a timer
> >> callback anymore. It just can move into delayed work and the whole
> >> locking problem can be reduced to the clocksource_mutex and some well
> >> thought out atomic operations to handle the mark unstable case. But
> >> that's a different story and not relevant for curing the problem at
> >> hand.
> >
> > Moving the code to delayed work seems quite reasonable.
> >
> > But Thomas, you do understand that the way things have been going for
> > the clocksource watchdog, pushing it out to delayed work will no doubt
> > add yet more hair on large busy systems, right?  Yeah, yeah, I know,
> > delayed work shouldn't be any worse than ksoftirqd.  The key word of
> > course being "shouldn't".  ;-)
> 
> Yes, I'm aware of that. I still think it's worth at least to try it.

OK, good.  And again, agreed.

							Thanx, Paul
