Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19734787494
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbjHXPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242331AbjHXPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F584198D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692892099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vDQ79m75Ea7f8TkkeLIzYM8yhOuVP1k7i71grVACcmI=;
        b=ac3fOKiMARoyFn4d08nGUc/xibu4EqFAUUN5dkC0iU4v1aPYHPIyepfag/wJb6llIVqI0j
        6+3TPOMGgPNdJ4EwNGEuB7GhfT58ZUsEARjVO/HU5ueqkryb7Pqcz+C1B/UyC7XTC0gnOT
        oh8CBFSJMxLcIPtRDWmX2KTEqAMMMaM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-h4rPwFdYNH-Ks7BkYJMPyA-1; Thu, 24 Aug 2023 11:48:16 -0400
X-MC-Unique: h4rPwFdYNH-Ks7BkYJMPyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BDE71C06931;
        Thu, 24 Aug 2023 15:47:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC14D1453AEF;
        Thu, 24 Aug 2023 15:47:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 24 Aug 2023 17:47:05 +0200 (CEST)
Date:   Thu, 24 Aug 2023 17:47:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] introduce __next_thread(), change next_thread()
Message-ID: <20230824154702.GA11832@redhat.com>
References: <20230824143112.GA31208@redhat.com>
 <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24, Linus Torvalds wrote:
>
> On Thu, 24 Aug 2023 at 07:32, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > After document-while_each_thread-change-first_tid-to-use-for_each_thread.patch
> > in mm tree + this series
>
> Looking at your patch 2/2, I started looking at users ("Maybe we
> *want* NULL for the end case, and make next_thread() and __next_thread
> be the same?").

Yes, but see below.

> One of the main users is while_each_thread(), which certainly wants
> that NULL case, both for an easier loop condition,

No. Please note that, say,

	do {
		do_something(t);
	} while_each_thread(current, t);

differs from for_each_thread() in that it loops starting from current,
not current->parent. I guess in most cases the order doesn't matter,
and I am going to audit the users and change them to use
for_each_thread() when possible.

Or,
	while_each_thread(current, t)
		do_something(t);

means do_something for every thread except current. And this have a
couple of valid users (say, zap_other_threads), but perhaps we can
change them too.

> but also because
> the only user that uses the 't' pointer after the loop is
> fs/proc/base.c, which wants it to be NULL.

Do you mean first_tid() ? Not only it is the only user that uses
the 't' pointer after the loop, it is the only user of lockless
while_each_thread() which (in general) is NOT rcu-safe.

But I have already changed it to use for_each_thread(), see
https://lore.kernel.org/all/20230823170806.GA11724@redhat.com/

This is
document-while_each_thread-change-first_tid-to-use-for_each_thread.patch
in mm tree.

> And kernel/bpf/task_iter.c seems to *expect* NULL at the end?

Yes! I think the same and I even documented this in 1/2.
To me this code looks simply wrong, but so far I don't understand
it enough. Currently I am trying to push the initial cleanups into
this code. See the

	https://lore.kernel.org/all/20230821150909.GA2431@redhat.com/

thread.

> End result: if you're changing next_thread() anyway, please just
> change it to be a completely new thing that returns NULL at the end,

See above.

I'd prefer to audit/change the current users of while_each_thread()
and next_thread(), then (perhaps) kill while_each_thread() and/or
next_thread().

Oleg.

