Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55B97B7CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjJDJ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjJDJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:56:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64F3A7;
        Wed,  4 Oct 2023 02:55:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F78C433C8;
        Wed,  4 Oct 2023 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696413358;
        bh=ouUMXO7K1wCqXRZ4GutaFLqIvGJCCMRwD43JyOd/pUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHNwB6heXhBIXTcj/wknBS8iI2hgNkeLuFi+todd4aCu6FvNDv5FZsXjVPF1c8gl8
         3Z5gllC+4xZwJ4gzSFiXWcVk8k5NleE6j2/R164aUKLmantGBPUFHiau6iMvqQ0GIC
         Pe4ItUiglC2/z6lllp4oxa1wCSgSRPLl76LdScKk=
Date:   Wed, 4 Oct 2023 11:55:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <2023100424-liquefy-collapse-140e@gregkh>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <20231003185500.GD8453@google.com>
 <2023100457-entail-freefall-06fd@gregkh>
 <20231004090918.GB9374@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004090918.GB9374@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:09:18AM +0100, Lee Jones wrote:
> On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:
> 
> > On Tue, Oct 03, 2023 at 07:55:00PM +0100, Lee Jones wrote:
> > > On Tue, 03 Oct 2023, Greg Kroah-Hartman wrote:
> > > 
> > > > On Tue, Oct 03, 2023 at 06:00:20PM +0100, Lee Jones wrote:
> > > > > The important part of the call stack being:
> > > > > 
> > > > >   gsmld_write()             # Takes a lock and disables IRQs
> > > > >     con_write()
> > > > >       console_lock()
> > > > 
> > > > Wait, why is the n_gsm line discipline being used for a console?
> > > > 
> > > > What hardware/protocol wants this to happen?
> > > > 
> > > > gsm I thought was for a very specific type of device, not a console.
> > > > 
> > > > As per:
> > > > 	https://www.kernel.org/doc/html/v5.9/driver-api/serial/n_gsm.html
> > > > this is a specific modem protocol, why is con_write() being called?
> > > 
> > > What it's meant for and what random users can make it do are likely to
> > > be quite separate questions.  This scenario is user driven and can be
> > > replicated simply by issuing a few syscalls (open, ioctl, write).
> > 
> > I would recommend that any distro/system that does not want to support
> > this specific hardware protocol, just disable it for now (it's marked as
> > experimental too), if they don't want to deal with the potential
> > sleep-while-atomic issue.
> 
> n_gsm is available on all the systems I have available.

Then file a bug with your distro to disable it?  No real general purpose
distro should enable it from what I can tell.

> The mention of
> 'EXPERIMENTAL' in the module description appears to have zero effect on
> whether distros choose to make it available or not.  If you're saying
> that we know this module is BROKEN however, then perhaps we should mark
> it as such.

Or we just prevent it from being bound to a console as that's not
something that should be happening.

And again, the "worst" that can happen is the calling process locks up,
due to a lock inversion, right?

> > > > And Lee, you really don't have this hardware, right?  So why are you
> > > > dealing with bug reports for it?  :)
> > > 
> > > 'cos Syzkaller.
> > 
> > Ah, yeah, fake report, no real issue here then :)
> 
> Ouch!  The way I see it, the present issue with Syzkaller is that we do
> not have the resources to remedy all of the issues it flags.  Passing
> off all reports as 'not real issues' is going to make engineers who
> decide to work on them feel undervalued and is likely have a detrimental
> effect overall.  As an ambassador for young and new people trying to get
> into Kernel Engineering in general, is that really the outcome you're
> after?

That's not what I'm saying here at all, what I'm saying is "pick issues
that are real".  syzbot does not always make it obvious what is, and is
not, a real issue.  There have been long threads and discussions about
this and some developers are now just ignoring all syzbot reports (see
the filesystem thread on the ksummit discuss list for more details.)

For this specific issue, it's been much-reported, and is not trivial,
and I would argue, not a "real" problem in the grand scheme of things
for normal users to worry about.

thanks,

greg k-h
