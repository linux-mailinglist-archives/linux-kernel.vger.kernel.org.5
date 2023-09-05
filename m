Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83179264C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347675AbjIEQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354847AbjIEPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:02:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5F6F18D;
        Tue,  5 Sep 2023 08:02:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA4E106F;
        Tue,  5 Sep 2023 08:03:04 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 397863F64C;
        Tue,  5 Sep 2023 08:02:25 -0700 (PDT)
Message-ID: <0dea99d9-3334-3fd3-3776-074ecace0259@arm.com>
Date:   Tue, 5 Sep 2023 16:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [arm?] [netfilter?] KASAN: slab-out-of-bounds Read in
 do_csum
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        syzbot <syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com>
Cc:     catalin.marinas@arm.com, fw@strlen.de, kadlec@netfilter.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
References: <000000000000e0e94c0603f8d213@google.com>
 <20230905143711.GB3322@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230905143711.GB3322@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 3:37 pm, Will Deacon wrote:
> [+Robin as he's had fun with the checksum code in the past]
> 
> On Mon, Aug 28, 2023 at 03:04:44AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    908f31f2a05b Merge branch 'for-next/core', remote-tracking..
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=155e0463280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c1058fe68f4b7b2c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4a9f9820bd8d302e22f7
>> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc548d280000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135bba3b280000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/87d095820229/disk-908f31f2.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/a1bf67af9675/vmlinux-908f31f2.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/7784a88b37e8/Image-908f31f2.gz.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com
>>
>> netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
>> netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in do_csum+0x44/0x254 arch/arm64/lib/csum.c:39
>> Read of size 4294966928 at addr ffff0000d7ac0170 by task syz-executor412/5975

Yup, that looks suspiciously "-368"-shaped...

> Judging by the UBSAN errors:
> 
> | shift exponent 3008 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> 
> We're probably being passed a negative 'len' argument. It looks like the
> generic version in lib/checksum.c rejects that early, so maybe we should
> do the same in the arch code?

Hmm, indeed I can offer no explanation as to why I put "if (len == 0)" 
there rather than "if (len <= 0)" like literally every other C 
implementation* :/

Cheers,
Robin.


*apart from Loongarch who didn't exist at the time, but appear to have 
dutifully copy-pasted the same bug.
