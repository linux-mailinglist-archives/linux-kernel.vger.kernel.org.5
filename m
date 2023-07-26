Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37F6762C50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjGZHBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjGZHA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:00:57 -0400
X-Greylist: delayed 525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 00:00:13 PDT
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950DC2D5A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:00:13 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 36590452BD;
        Wed, 26 Jul 2023 08:51:26 +0200 (CEST)
Message-ID: <85876d36-ca1f-4ba4-9065-4e7fc58329c0@proxmox.com>
Date:   Wed, 26 Jul 2023 08:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: segfaults of processes while being killed after commit "mm: make
 the page fault mmap locking killable"
Content-Language: en-GB
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Fiona Ebner <f.ebner@proxmox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     akpm@linux-foundation.org,
        Wolfgang Bumiller <w.bumiller@proxmox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
 <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
From:   Thomas Lamprecht <t.lamprecht@proxmox.com>
In-Reply-To: <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 18:38, Linus Torvalds wrote:
> But before we revert it, would you mind trying out the attached
> trivial patch instead?

Not Fiona, but as I was still online yesterday I got around to already
try that patch out, after adding the missing `tsk` task_struct param
to the fatal_signal_pending call.
With the patched kernel booted, the original case we found in the wild
went from logging a segfault roughly twice per hour before, to none
afterward, and that with a bit more than 10h of boot time.
Fiona might have a more definitive confirmation, as IIRC she got a
better (= faster) reproducer used for bisecting.

> 
> I'd also still be interested if the symptoms were anything else than
> 'show_unhandled_signals' causing the show_signal_msg() dance, and
> resulting in a message something like
> 
>     a.out[1567]: segfault at xyz ip [..] likely on CPU X
> 
> in dmesg...

exactly, it was just like that with no actual fall out. The messages
were like:

> pverados[2183248]: segfault at 55e5a00f9ae0 ip 000055e5a00f9ae0 sp 00007ffc0720bea8 error 14 in perl[55e5a00d4000+195000] likely on CPU 10 (core 4, socket 0)

And the slightly odd code triggering this was basically a fork, where
the child wrote a message to the parent via a unix socket pair and
then called exit. The parent read that message and then send a SIGKILL
to the child process, i.e., the child exit and parent killing the
child process would be pretty closely aligned, basically racing with
each other.

cheers,
 Thomas

