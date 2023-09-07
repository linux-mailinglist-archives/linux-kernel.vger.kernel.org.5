Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1098797371
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbjIGPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjIGPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5533710DF;
        Thu,  7 Sep 2023 08:22:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04C7C433AD;
        Thu,  7 Sep 2023 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694078718;
        bh=ofrREB+XRbUYVS5Sh20JAfhhFAJ49iPxwIALV7BFZUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzRT/Gb9kx8nzgECyIcfiRkD2AdsyIVnMTBz9cQ27fJUfdlg1iooQk7r/6WpR34t0
         HCDlqYGGyBjosugpXaUcBnJ+eeS4r1PAa+L5iTtN962KVlv5C3P2bCjfBAjCMGzBCm
         u32uZQTdd2mBdzStbWxHi3rwHmb8OVb3jNeLZ0x6yMpHhOkSYKQO1mALmcpyfA2Aoh
         7uSvAF/GdMZu34z4xCcMxqNEqfFofBGxJ7gTx2BGggBqwt4ECDXuw6wYp+uWDCAjJt
         cHoiuOWo3YhSdk67dQQXUmY15b+IwwOnd/j+VM/Bn/rjSA1KXHBpl7ge3JOl0gWa/6
         e8cuMErprpgNA==
Date:   Thu, 7 Sep 2023 10:25:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     syzbot <syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com>,
        catalin.marinas@arm.com, fw@strlen.de, kadlec@netfilter.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [arm?] [netfilter?] KASAN: slab-out-of-bounds Read in
 do_csum
Message-ID: <20230907092511.GB5731@willie-the-truck>
References: <000000000000e0e94c0603f8d213@google.com>
 <20230905143711.GB3322@willie-the-truck>
 <0dea99d9-3334-3fd3-3776-074ecace0259@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dea99d9-3334-3fd3-3776-074ecace0259@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 04:02:19PM +0100, Robin Murphy wrote:
> On 05/09/2023 3:37 pm, Will Deacon wrote:
> > On Mon, Aug 28, 2023 at 03:04:44AM -0700, syzbot wrote:
> > > HEAD commit:    908f31f2a05b Merge branch 'for-next/core', remote-tracking..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=155e0463280000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c1058fe68f4b7b2c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4a9f9820bd8d302e22f7
> > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc548d280000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135bba3b280000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/87d095820229/disk-908f31f2.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/a1bf67af9675/vmlinux-908f31f2.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/7784a88b37e8/Image-908f31f2.gz.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com
> > > 
> > > netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> > > netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> > > ==================================================================
> > > BUG: KASAN: slab-out-of-bounds in do_csum+0x44/0x254 arch/arm64/lib/csum.c:39
> > > Read of size 4294966928 at addr ffff0000d7ac0170 by task syz-executor412/5975
> 
> Yup, that looks suspiciously "-368"-shaped...
> 
> > Judging by the UBSAN errors:
> > 
> > | shift exponent 3008 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> > 
> > We're probably being passed a negative 'len' argument. It looks like the
> > generic version in lib/checksum.c rejects that early, so maybe we should
> > do the same in the arch code?
> 
> Hmm, indeed I can offer no explanation as to why I put "if (len == 0)" there
> rather than "if (len <= 0)" like literally every other C implementation* :/

I've made that change:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/fixes&id=8bd795fedb8450ecbef18eeadbd23ed8fc7630f5

Cheers,

Will
