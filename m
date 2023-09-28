Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D757B1676
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjI1Ixl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjI1Ixj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D2CD0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695891169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OpehfsLNdnWDXwgsJXAhObAfPPPu4yNavy5AfAnduVc=;
        b=IP4WyCpDKFBfM9n0SVG5ktE2Fy74q6LsvZdhcebRXoAUx9/amZbmNVTn+4nEgxqaAefFFR
        2gNdKHutjaE3YNpMw8b4IpTnS/upqpu/GHdN5sQ7F4FFzOLqWSphFxYfb26+c1LuqGpx/D
        wpru7twEmihOa+JKvxKy64o38xvi2CA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-a54w6CI9O5-tYMYBdYgbmQ-1; Thu, 28 Sep 2023 04:52:45 -0400
X-MC-Unique: a54w6CI9O5-tYMYBdYgbmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BB5E38012F7;
        Thu, 28 Sep 2023 08:52:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26C4210EE402;
        Thu, 28 Sep 2023 08:52:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     mathieu.desnoyers@efficios.com, David.Laight@aculab.com,
        alexander@mihalicyn.com, andrealmeid@igalia.com,
        boqun.feng@gmail.com, brauner@kernel.org, carlos@redhat.com,
        ckennelly@google.com, corbet@lwn.net, dave@stgolabs.net,
        dvhart@infradead.org, goldstein.w.n@gmail.com, hpa@zytor.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        paulmck@kernel.org, peterz@infradead.org, pjt@google.com,
        posk@posk.io, rostedt@goodmis.org, tglx@linutronix.de
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
        <20230926205215.472650-1-dvyukov@google.com>
        <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
        <875y3wp6au.fsf@oldenburg.str.redhat.com>
        <CACT4Y+aVY+KPmBXYDBpA+JmLHvk=o5bt9d4tV5L41e813e0SVw@mail.gmail.com>
Date:   Thu, 28 Sep 2023 10:52:37 +0200
In-Reply-To: <CACT4Y+aVY+KPmBXYDBpA+JmLHvk=o5bt9d4tV5L41e813e0SVw@mail.gmail.com>
        (Dmitry Vyukov's message of "Wed, 27 Sep 2023 08:58:16 -0700")
Message-ID: <87bkdmznl6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Vyukov:

> On Tue, 26 Sept 2023 at 21:51, Florian Weimer <fweimer@redhat.com> wrote:
>>
>> * Dmitry Vyukov:
>>
>> > In reality it's a bit more involved since the field is actually 8
>> > bytes and only partially overlaps with rseq.cpu_id_start (it's an
>> > 8-byte pointer with high 4 bytes overlap rseq.cpu_id_start):
>> >
>> > https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/percpu.h#L101-L165
>>
>> This does not compose with other rseq users, as noted in the sources:
>>
>>   // Note: this makes __rseq_abi.cpu_id_start unusable for its original purpose.
>>
>> For a core library such a malloc replacement, that is a very bad trap.
>
> I agree. I wouldn't do this if there were other options. That's why I
> am looking for official kernel support for this.
> If we would have a separate 8 bytes that are overwritten with 0 when a
> thread is descheduled, that would be perfect.

That only solves part of the problem because these fields would still
have to be locked to tcmalloc.  I think you'd need a rescheduling
counter, then every library could keep their reference values in
library-private thread-local storage.

Thanks,
Florian

