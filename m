Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9407E7888CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbjHYNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHYNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E1E1FDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692970720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hp+dwrjm08maIC6UIz3hCS0FhfcqIdNuEbRN7HDLNyk=;
        b=DVvcnF8BWAspF3D6NLxvj7xaac6PtwU5SPspVFo7ZWaGBJuWtHZpeKvLmPEqnbc4h34rNh
        RuxqBQJWe1edm6DubN1pawywXBN9RfSAIou8YZdr1fUuIsa2W7FRBiCENMEu0Pgn4iRwKY
        xPba2idLVooI7EawciH4UVhhdBJHofE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-50kYKzsJONSBDQ0Sy0imVg-1; Fri, 25 Aug 2023 09:38:36 -0400
X-MC-Unique: 50kYKzsJONSBDQ0Sy0imVg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8960E10F9884;
        Fri, 25 Aug 2023 13:38:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1BD13492C14;
        Fri, 25 Aug 2023 13:38:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Aug 2023 15:37:50 +0200 (CEST)
Date:   Fri, 25 Aug 2023 15:37:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterz@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] introduce __next_thread(), change next_thread()
Message-ID: <20230825133747.GA29260@redhat.com>
References: <20230824143112.GA31208@redhat.com>
 <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
 <87y1hzs2e4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1hzs2e4.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25, Eric W. Biederman wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > One of the main users is while_each_thread(), which certainly wants
> > that NULL case, both for an easier loop condition, but also because
> > the only user that uses the 't' pointer after the loop is
> > fs/proc/base.c, which wants it to be NULL.
>
> Sort of.
>
> I have found 3 loops that want to loop through all of the threads of
> a process starting with the current thread.
>
> The loop in do_wait.
> The loop finding the thread to signal in complete_signal.
> The loop in retarget_shared_pending finding which threads
> to wake up.

Yes, plus check_unsafe_exec() and zap_other_threads() which want to
skip the initial thread.

> > And kernel/bpf/task_iter.c seems to *expect* NULL at the end?

Yes. I'll (try to) send the patches today. This code needs cleanups
first.

> > End result: if you're changing next_thread() anyway, please just
> > change it to be a completely new thing that returns NULL at the end,
> > which is what everybody really seems to want, and don't add a new
> > __next_thread() helper. Ok?
>
> So I would say Oleg please build the helper that do_wait wants
> and use it in do_wait, complete_signal, and retarget_shared_pending.

Later. But so far I am not 100% sure this makes sense... I guess we
will need to discuss this again.

> Change the rest of the loops can use for_each_thread (skipping
> the current task if needed) or for_each_process_thread.

Yes, I was going to do this.

> Change next_thread to be your __next_thread, and update the 2 callers
> appropriately.

But I can't do this until I change the current users of next_thread()
and while_each_thread().

Oleg.

