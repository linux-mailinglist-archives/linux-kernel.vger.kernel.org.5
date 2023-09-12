Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0679C648
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjILFay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjILFax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:30:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831FAA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pOmLWIw3f42oY6r0FprJ4GU/jYGQV5Prcd0Ezz08Nb0=; b=Q1B1uniPeTbt8adeldz9ohu+yl
        mOGkYN1Ejb5yo5sHQ6iMK/1s125VV0/wEVg7mQi7tqTnpD7/b6Wf6PRq3dgiNFsMoIxXnFJj64MZy
        3moAPD7FMFkwPifHxQ4pB7/75bmCMN5IQvSn7TnnooB5gSWoyCSB5NSHdWTF+e4gccHzNa+rOdvIa
        zaErjtI34SPDvQCoI36JUmN7kxmsqDbDzTPm2BNo5rXIHkzkH1caqi6Ug2HHtq4PMGBlUAhIlUEO4
        p46CYTu5RUOzWF4ZYqSOawy/0czw4tq8QLzxSMrtwJUhe20RRKa+Uevvs2qmsIS5SQKPkQn1YN7Ex
        ibzberPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfvz4-005khz-7L; Tue, 12 Sep 2023 05:30:46 +0000
Date:   Tue, 12 Sep 2023 06:30:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
Message-ID: <ZP/3hgDCXeceE9uU@casper.infradead.org>
References: <000000000000f392a60604a65085@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f392a60604a65085@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 06:03:49PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20230831
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16502ddba80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6ecd2a74f20953b9
> dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120e7d70680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1523f9c0680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b2e8f4217527/disk-a47fc304.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc09339/vmlinux-a47fc304.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bd9b2475bf5a/bzImage-a47fc304.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com

#syz test

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..90ad5fe60824 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1342,6 +1342,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	vma_iter_init(&vmi, mm, start);
 	prev = vma_prev(&vmi);
 	for_each_vma_range(vmi, vma, end) {
+		vma_start_write(vma);
 		err = mbind_range(&vmi, vma, &prev, start, end, new);
 		if (err)
 			break;
