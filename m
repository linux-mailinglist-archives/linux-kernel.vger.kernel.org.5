Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E670E7F5B86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjKWJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjKWJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:43:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DFC2107
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:41:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0F2C433C7;
        Thu, 23 Nov 2023 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700732513;
        bh=L1HU47elgDtXBHr6aW6J+6GyoSBIGTHAwEytneSgsx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIl4xvQN+8xZnm3sHyWuYtjeO5nCx8uM1ub3wg70cVOGJVP1CGBUJSfg1gnvjONj1
         9WN+0sTeXcG/s4qPNSqbumcS2xHPuoskC/UzjA/CpMK3qma0L7bcbtAvkUkVSDN8VP
         m1HF4OB4zJpI2sF95dj7+XIGrCkXKDB2ZHAEf3Do=
Date:   Thu, 23 Nov 2023 09:41:49 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     xingwei lee <xrivendell7@gmail.com>,
        "syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com" 
        <syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in joydev_connect
Message-ID: <2023112306-diner-jawline-c7dc@gregkh>
References: <CABOYnLyCRyK4qpS2X8ssA6yxCDtEWR3dSsee2Lm6VCQUyD07VQ@mail.gmail.com>
 <2023112332-award-fanciness-2bcf@gregkh>
 <CANp29Y6ge-AhM+Byt3imGOpctRsgWiqBN-reuKvOJAzxBsTYLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y6ge-AhM+Byt3imGOpctRsgWiqBN-reuKvOJAzxBsTYLw@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:32:26AM +0100, Aleksandr Nogikh wrote:
> On Thu, Nov 23, 2023 at 9:55 AM gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 22, 2023 at 07:55:50PM +0800, xingwei lee wrote:
> > > Hi. I have reproduced this bug with repro.txt and repro.c below:
> > >
> > > repro.txt
> > > r0 = openat$uinput(0xffffffffffffff9c, &(0x7f0000000500), 0x802, 0x0)
> > > ioctl$UI_DEV_SETUP(r0, 0x405c5503, &(0x7f0000000080)={{0x0, 0xffff,
> > > 0x3}, 'syz0\x00'})
> > > ioctl$UI_DEV_CREATE(r0, 0x5501) (fail_nth: 51)
> >
> > You are using fault injection, which, by it's very name, causes faults :)
> 
> But those injected failures (that do not break the kernel, but just
> emulate an error returned from a function that should be expected to
> sometimes return an error) still should not lead to general protection
> fault panics, shouldn't they?

It all depends on what exactly the fault is happening for.  Some
allocations in the kernel just "will not fail ever" so when you add
fault injection testing, you are doing things that really can not ever
happen.

So the proof is first on the reporter, prove that this type of fault
_can_ actually happen, and then, make a fix to properly handle it.
Don't expect us to make a fix for something that can not actually occur,
as that would be pointless (hint, we have been down this path before, it
doesn't work...)

thanks,

greg k-h
