Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209D7E518C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKHIBW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 03:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjKHIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:01:18 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66BAF;
        Wed,  8 Nov 2023 00:01:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SQHHp0p1cz9xFPp;
        Wed,  8 Nov 2023 15:47:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAnFXUqQEtlDKtDAA--.34S2;
        Wed, 08 Nov 2023 09:00:54 +0100 (CET)
Message-ID: <110badd28083322d8895730bcd353d6d398f2db2.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>,
        jack@suse.cz, jeffm@suse.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        linux-security-module@vger.kernel.org
Date:   Wed, 08 Nov 2023 09:00:38 +0100
In-Reply-To: <CAHC9VhSH-WED1kM4UQrttJb6-ZQHpB0VceW0YGX1rz8NsZrVHA@mail.gmail.com>
References: <000000000000cfe6f305ee84ff1f@google.com>
         <000000000000a8d8e7060977b741@google.com>
         <CAHC9VhTFs=AHtsdzas-XXq2-Ub4V9Tbkcp4_HBspmGaARzWanw@mail.gmail.com>
         <b560ed9477d9d03f0bf13af2ffddfeebbbf7712b.camel@huaweicloud.com>
         <CAHC9VhSH-WED1kM4UQrttJb6-ZQHpB0VceW0YGX1rz8NsZrVHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwAnFXUqQEtlDKtDAA--.34S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkXFyfuFWxKw1rZw15CFg_yoW5JF4fpF
        W5KFW5KF4vvr4xJrn2yw13Ga4I9wnxXFy7X3s3Kw1DAFW5XFyIvr4xKr43uFyY9rs3Kr1j
        qanrKas8C3srAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5YirwACsi
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-07 at 17:26 -0500, Paul Moore wrote:
> On Tue, Nov 7, 2023 at 6:03 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2023-11-06 at 17:53 -0500, Paul Moore wrote:
> > > Hi Roberto,
> > > 
> > > I know you were looking at this over the summer[1], did you ever find
> > > a resolution to this?  If not, what do you think of just dropping
> > > security xattr support on reiserfs?  Normally that wouldn't be
> > > something we could consider, but given the likelihood that this hadn't
> > > been working in *years* (if ever), and reiserfs is deprecated, I think
> > > this is a viable option if there isn't an obvious fix.
> > > 
> > > [1] https://lore.kernel.org/linux-security-module/CAHC9VhTM0a7jnhxpCyonepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com/
> > 
> > Hi Paul
> > 
> > at the time, I did some investigation and came with a patch that
> > (likely) solves some of the problems:
> > 
> > https://lore.kernel.org/linux-fsdevel/4aa799a0b87d4e2ecf3fa74079402074dc42b3c5.camel@huaweicloud.com/#t
> 
> Ah, thanks for the link, it looks like that was swallowed by my inbox.
> In general if you feel it is worth adding my email to a patch, you
> should probably also CC the LSM list.  If nothing else there is a
> patchwork watching the LSM list that I use to make sure I don't
> miss/forget about patches.
> 
> > I did a more advanced patch (to be validated), trying to fix the root
> > cause:
> > 
> > https://lore.kernel.org/linux-fsdevel/ffde7908-be73-cc56-2646-72f4f94cb51b@huaweicloud.com/
> > 
> > However, Jeff Mahoney (that did a lot of work in this area) suggested
> > that maybe we should not try invasive changes, as anyway reiserfs will
> > be removed from the kernel in 2025.
> 
> I tend to agree with Jeff, which is one of the reasons I was
> suggesting simply removing LSM xattr support from reiserfs, although
> depending on what that involves it might be a big enough change that
> we are better off simply leaving it broken.  I think we need to see
> what that patch would look like first.
> 
> > It wouldn't be a problem to move the first patch forward.
> 
> I worry that the first patch you mentioned above doesn't really solve
> anything, it only makes it the responsibility of the user to choose
> either A) a broken system where LSM xattrs don't work or B) a system
> that will likely deadlock/panic.  I think I would rather revert the
> original commit and just leave the LSM xattrs broken than ask a user
> to make that choice.

Ok, that would be fine for me.

Thanks

Roberto

