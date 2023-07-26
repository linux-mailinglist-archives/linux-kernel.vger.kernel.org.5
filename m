Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64644762FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjGZI3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjGZI3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:29:15 -0400
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFCE65BA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:19:11 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9BE1B45369;
        Wed, 26 Jul 2023 10:19:09 +0200 (CEST)
Message-ID: <cc502fe7-716b-8114-c9e6-439e3b9cf0f6@proxmox.com>
Date:   Wed, 26 Jul 2023 10:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: segfaults of processes while being killed after commit "mm: make
 the page fault mmap locking killable"
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     akpm@linux-foundation.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
 <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
From:   Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.07.23 um 18:38 schrieb Linus Torvalds:
> On Tue, 25 Jul 2023 at 04:16, Fiona Ebner <f.ebner@proxmox.com> wrote:
>>
>> will end up without a vma and cause/log the segfault. Of course the
>> process is already being killed, but I'd argue it is very confusing to
>> users when apparent segfaults from such processes are being logged by
>> the kernel.
> 
> Ahh. Yes, that wasn't the intent. A process that is being killed
> should exit with the lethal signal, not SIGSEGV.
> 

Checking the status from waitpid, it does show that the process was
terminated by signal 9, even if the segfault was logged.

> But before we revert it, would you mind trying out the attached
> trivial patch instead?
> 

The patch works for me too :) (after adding the missing tsk argument
like Thomas pointed out)

> I'd also still be interested if the symptoms were anything else than
> 'show_unhandled_signals' causing the show_signal_msg() dance, and
> resulting in a message something like
> 
>     a.out[1567]: segfault at xyz ip [..] likely on CPU X
> 
> in dmesg...
> 
Yes, AFAICS, it is just those messages and nothing else.

Best Regards,
Fiona

