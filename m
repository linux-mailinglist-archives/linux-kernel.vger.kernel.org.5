Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6F76A735
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHACxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjHACxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:53:46 -0400
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DCF1FCA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:53:40 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:53:41 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Harald van Dijk <harald@gigawatt.nl>,
        Andy Lutomirski <luto@kernel.org>,
        linux-x86_64@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
Message-ID: <20230801025340.GA20403@brightrain.aerifal.cx>
References: <20201101015013.GN534@brightrain.aerifal.cx>
 <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
 <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
 <20201101210102.GO534@brightrain.aerifal.cx>
 <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
 <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
 <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
 <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
 <5C330BFF-A81A-465D-BE7D-6DB6A7B263AF@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5C330BFF-A81A-465D-BE7D-6DB6A7B263AF@jrtc27.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:38:47AM +0100, Jessica Clarke wrote:
> On 1 Aug 2023, at 01:43, Harald van Dijk <harald@gigawatt.nl> wrote:
> > 
> > On 06/12/2020 22:55, Andy Lutomirski wrote:
> >> On Sat, Dec 5, 2020 at 4:01 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> >>> 
> >>> Ping?
> >> Can you submit patches implementing my proposal?  One is your existing
> >> patch plus fixing struct msghdr, with Cc: stable@vger.kernel.org at
> >> the bottom.  The second is a removal of struct msghdr from uapi,
> >> moving it into include/inux (no uapi) if needed.  The second should
> >> not cc stable.
> > 
> > Hi,
> > 
> > This looks like it was forgotten, but it is still needed. Jessica,
> > are you interested in submitting the requested change? If not,
> > would it be okay if I do so? I have been running this locally for
> > a long time now.
> 
> Hi,
> Please feel free to; sorry that it dropped off my radar. Part of the
> issue is my laptop no longer being x86, making it more annoying to test.
> 
> > There is one complication that I think has not been mentioned yet:
> > when _GNU_SOURCE is defined, glibc does provide a definition of
> > struct msghdr in <sys/msg.h> with a field "__syscall_slong_t
> > mtype;". This makes it slightly more likely that there is code out
> > there in the wild that works fine with current kernels and would
> > be broken by the fix. Given how rare x32 is, and how rare message
> > queues are, this may still be acceptable, but I am mentioning it
> > just in case this would cause a different approach to be
> > preferred. And whatever is done, a fix should also be submitted to
> > glibc.
> 
> Given POSIX is very clear on how msghdr works I think we have to break
> whatever oddball code out there might be using this. The alternative is
> violating POSIX in a way that makes correct code compile fine but fail
> at run time on x32, which is a terrible place to be, especially when
> the “fix” is to special-case x32 to go against what POSIX says. I just
> can’t see how that’s a good place to stay in, even if something might
> break when we fix this bug.

Absolutely. The application-facing API absolutely needs to have the
type of mtype be whatever long is in the application-facing C ABI.
However, I'm not sure how best to fix this. A fix now still leaves
applications broken on all existing kernels in the wild. This might be
a place where libc should have x32-specific translation code to work
around the wrong kernel ABI that became the contract with the kernel.
I'm not sure how practical this is, since it seems like it would
require a temp buffer. Is the message size sufficiently bounded to
make that reasonable? Should there me a new x32-specific syscall that
takes the right ABI so that translation is only needed on old kernels?

Rich
