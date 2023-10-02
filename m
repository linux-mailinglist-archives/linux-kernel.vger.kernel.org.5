Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410FD7B5AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjJBS5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJBS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:57:40 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 11:57:37 PDT
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06435AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:57:36 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 42026 invoked from network); 2 Oct 2023 20:50:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1696272654; bh=GepljF1EQTI9r70EH4tqi9RpNkoQyh/hyQxu9GZweVk=;
          h=From:To:Cc:Subject;
          b=IWGGnhxfjpYf6rC2AzOjOIHwe/vB1LOrIcefmkfFh25VqtFS5EqdYTiKGun2Fim6t
           rTPdESj/5rszSFz5/JDkHBVs0QDnjJSN+F+QucwuMfLkcDqws+Zccvr28B811SM+SV
           IKXeZi6JJC6kq7HQCU6AgaNDi7yYEwQz4EmcmTsc=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <bagasdotme@gmail.com>; 2 Oct 2023 20:50:54 +0200
Date:   Mon, 2 Oct 2023 20:50:53 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     enc0der <enc0der@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
Message-ID: <20231002185053.GB402943@wp.pl>
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRj_ovMi-Xbb8i-D@debian.me>
X-WP-MailID: 5ca95ff5381d87fae914a0949b3625fa
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IWPl]                               
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(cc list is too big, I shrink it)

On Sun, Oct 01, 2023 at 12:12:02PM +0700, Bagas Sanjaya wrote:
> On Sat, Sep 30, 2023 at 06:04:22PM -0400, enc0der wrote:
> > Hello all!
> > 
> > This is the first time I have ever reported anything linux related, so
> > if this is not the proper way, please let me know what the correct way
> > is.
> > 
> > I am using an NVIDIA Jetson Orin Nano developer platform.  They
> > release what they call a jetpack that comes with linux and their
> > additions on top.  We are using the latest version they release (just
> > released about a month ago)
> 
> Something like a distro? What version?
> 
> > 
> > When I plug in a USB WiFi adapter that uses the rt8000usb driver, if I
> > connect to a network it sees, I get a kernel panic.  If I have
> > "automatically connect" it kernel panics when I plug the USB in.
> > 
> > The version of the kernel they ship is:
> > 
> > 5.10.120-tegra. (tegra is their additions)
> > 
> > I talked with NVIDIA first on what I was seeing and after looking at
> > my log, they said it is likely a driver problem.

Is possible that this is rt2800usb or usb host driver issue. But without
full logs we can not be sure.  

> > Right after I plug in the device, this is the sequence of messages I see:
> > 
> > [  264.400281] BUG: scheduling while atomic: NetworkManager/622/0x00000203

After that message there should be stack trace visible. To debug this
you would need to find a way to see the full logs (dmesg/kmsg) after the crash.
It can be serial console, netconsole, pstore or some other thing. Perhaps
your platform allow to boot debug kernel with various check, which will
not panic when the bug occures and will show useful info in the logs.

> > [   28.071586] lr : arm_smmu_dma_sync+0x40/0x70
> > [   28.075965] sp : ffff8000100231a0
> > [   28.079365] x29: 0000000000001000 x28: ffff4655c01d0ec0
> > [   28.084817] x27: ffffaced1f227000 x26: ffff4655c6ee32c0
> > [   28.090270] x25: 0000000000000000 x24: ffffaced1e405858
> > [   28.095718] x23: ffff46572e84ae00 x22: ffff4655c6ee2c40
> > [   28.101165] x21: ffff4655c82c3480 x20: ffffaced1db49e08
> > [   28.106618] x19: ffff8000100231c0 x18: 0000000000010101
> > [   28.112073] x17: 0000000000cccccc x16: ffffaced1d23382c
> > [   28.117520] x15: 0000000000000000 x14: 0000000000000000
> > [   28.122970] x13: 0000000000000001 x12: 0000000000000000
> > [   28.128421] x11: 0000000000000008 x10: 0000000000000ab0
> > [   28.133863] x9 : ffff800010023180 x8 : ffff4655c6ee3750
> > [   28.139309] x7 : 000000067eb29c20 x6 : 0000000000000238
> > [   28.144763] x5 : 00000000410fd420 x4 : 0000000000f0000f
> > [   28.150214] x3 : 0000000000001000 x2 : ffff4655c82c3480
> > [   28.155658] x1 : ffffaced1db49e08 x0 : ffff465704c37558
> > [   28.161107] Call trace:
> > [   28.163620]  0x1000
> > [   28.165777] Code: bad PC value
> > [   28.168911] ---[ end trace 62dc42c98ec427ca ]---
> > [   28.183964] Kernel panic - not syncing: Oops: Fatal exception
> > [   28.189864] SMP: stopping secondary CPUs
> > [   29.275883] SMP: failed to stop secondary CPUs 0-5
> > [   29.280811] Kernel Offset: 0x2ced0d200000 from 0xffff800010000000

This actually suggest that the issue is somewhere in the core.
But again, without full logs we can not be sure.

> > [   29.287066] PHYS_OFFSET: 0xffffb9ab40000000
> > [   29.291360] CPU features: 0x08040006,4a80aa38
> > [   29.295832] Memory Limit: none
> > [   29.309234] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> > 
> > (This one I believe when I started with the wifi adapter connected to
> > USB3 and networking was set to automatically connect.
> > 
> > I see in the git repo that these drivers have been changed over the
> > last few years.  Given the age of the kernel that NVIDIA is using, I
> > am not sure how to correlate changes listed in the history of the
> > files with the release.  I guess I could download and diff them until
> > I figure out where.

The rt2800 driver wasn't modified for ages. It's rater stable, but
perhaps there are issues in other involved modules i.e. mac80211.

Regards
Stanislaw

