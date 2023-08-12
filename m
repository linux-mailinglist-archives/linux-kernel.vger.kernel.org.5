Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E477A0EF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjHLP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHLP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:56:35 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 88207E4D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:56:37 -0700 (PDT)
Received: (qmail 317565 invoked by uid 1000); 12 Aug 2023 11:56:36 -0400
Date:   Sat, 12 Aug 2023 11:56:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     arnd@arndb.de, christian.brauner@ubuntu.com,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, web@syzkaller.appspotmail.com
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in
 usb_anchor_suspend_wakeups
Message-ID: <1134d446-3189-4f2d-81b4-10142e751320@rowland.harvard.edu>
References: <0000000000007c27e105faa4aa99@google.com>
 <00000000000014678c0602b6c643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000014678c0602b6c643@google.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 02:51:30AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 9b4feb630e8e9801603f3cab3a36369e3c1cf88d
> Author: Christian Brauner <christian.brauner@ubuntu.com>
> Date:   Fri May 24 09:31:44 2019 +0000
> 
>     arch: wire-up close_range()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1323329ba80000
> start commit:   89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a3329ba80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1723329ba80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d963e7536cbe545e
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6b0b0ea0781c14b2ecf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11471b84280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b98e2c280000
> 
> Reported-by: syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com
> Fixes: 9b4feb630e8e ("arch: wire-up close_range()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

This attribution is extremely unlikely.

The real problem seems to be some sort of race in usbtmc and the core 
between URBs being added to an anchor, file I/O being stopped, and URBs 
being killed or scuttled when the file is flushed.

The bug is caused by an URB completing after (or while) its anchor is 
deallocated.  Note that __usb_hcd_giveback_urb() removes an URB from its 
anchor before calling the completion routine, but dereferences the 
anchor afterward.  The anchor could easily be deallocated during that 
window.

Alan Stern
