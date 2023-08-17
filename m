Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67677F86F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351652AbjHQONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351732AbjHQOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:12:54 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E76C910C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:12:52 -0700 (PDT)
Received: (qmail 475574 invoked by uid 1000); 17 Aug 2023 10:12:52 -0400
Date:   Thu, 17 Aug 2023 10:12:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com>,
        arnd@arndb.de, christian.brauner@ubuntu.com,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, web@syzkaller.appspotmail.com
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in
 usb_anchor_suspend_wakeups
Message-ID: <6c58e18b-1a66-4853-af33-17bc6f9f7ebd@rowland.harvard.edu>
References: <0000000000007c27e105faa4aa99@google.com>
 <00000000000014678c0602b6c643@google.com>
 <1134d446-3189-4f2d-81b4-10142e751320@rowland.harvard.edu>
 <5919c39c-1ee4-262b-4ba1-f0e58088611d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5919c39c-1ee4-262b-4ba1-f0e58088611d@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:16:26PM +0200, Oliver Neukum wrote:
> On 12.08.23 17:56, Alan Stern wrote:
> Hi,
> > The real problem seems to be some sort of race in usbtmc and the core
> > between URBs being added to an anchor, file I/O being stopped, and URBs
> > being killed or scuttled when the file is flushed.
> 
> just to make sure, you think it is failing here:
> 
> usb_anchor_resume_wakeups(anchor);

That's what the syzbot console log output shows in the stack dump.

> because we cannot guarantee that the anchor pointer
> is still valid,

That's my conclusion.  There don't seem to be any other candidates for a 
bad pointer.

>  unless we refcount anchors, which would
> make embedding them impossible?

Whether the validity is ensured by refcounting or by some other 
mechanism is up to the implementor (i.e., you).  I'm merely trying to 
restate and explain the syzbot results in terms understandable by 
humans.

Alan Stern
