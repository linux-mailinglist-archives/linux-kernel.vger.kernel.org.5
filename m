Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24807EB516
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjKNQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjKNQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449A112
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699980211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cok8Q3IObYPFL+9sXuypqM5Ca4C9SOJD0kAH42Df6o=;
        b=jQ2yMA59ZVRxdX9eq2Qtdmy0PtyWvT+kq/yKVoVhEq1UEayfk6KI9RbeqDvW7ASczokgRm
        7Wp+6qnAADcqJya2eQXlkodexPm9+brtVW0gg60pi2S7LGVHVkWMXY9IOe0qiyZpcgKnx0
        TVmx5ZH7rybz58gvOjmru8SE7567JYs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-KeUFTFdVMxGEvUF3WrroaQ-1; Tue,
 14 Nov 2023 11:43:25 -0500
X-MC-Unique: KeUFTFdVMxGEvUF3WrroaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 508C63827962;
        Tue, 14 Nov 2023 16:43:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 248331121307;
        Tue, 14 Nov 2023 16:43:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
        <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
        <20231114153100.GY8262@noisy.programming.kicks-ass.net>
        <20231114154017.GI4779@noisy.programming.kicks-ass.net>
Date:   Tue, 14 Nov 2023 17:43:20 +0100
In-Reply-To: <20231114154017.GI4779@noisy.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 14 Nov 2023 16:40:17 +0100")
Message-ID: <87ttpowajb.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

>> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
>> index b5379c0e6d6d..1a1f9301251f 100644
>> --- a/kernel/futex/futex.h
>> +++ b/kernel/futex/futex.h
>> @@ -17,7 +17,7 @@
>>   * restarts.
>>   */
>>  #ifdef CONFIG_MMU
>> -# define FLAGS_SHARED		0x01
>> +# define FLAGS_SHARED		0x10
>>  #else
>>  /*
>>   * NOMMU does not have per process address space. Let the compiler optimize
>
> Just the above seems sufficient.

There are a few futex_wake calls which hard-code the flags argument as
1:

kernel/futex/core.c=637=static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
--
kernel/futex/core.c-686-         * this.
kernel/futex/core.c-687-         */
kernel/futex/core.c-688-        owner = uval & FUTEX_TID_MASK;
kernel/futex/core.c-689-
kernel/futex/core.c-690-        if (pending_op && !pi && !owner) {
kernel/futex/core.c:691:                futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
kernel/futex/core.c-692-                return 0;
kernel/futex/core.c-693-        }
kernel/futex/core.c-694-
kernel/futex/core.c-695-        if (owner != task_pid_vnr(curr))
kernel/futex/core.c-696-                return 0;
--
kernel/futex/core.c-739-        /*
kernel/futex/core.c-740-         * Wake robust non-PI futexes here. The wakeup of
kernel/futex/core.c-741-         * PI futexes happens in exit_pi_state():
kernel/futex/core.c-742-         */
kernel/futex/core.c-743-        if (!pi && (uval & FUTEX_WAITERS))
kernel/futex/core.c:744:                futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
kernel/futex/core.c-745-
kernel/futex/core.c-746-        return 0;
kernel/futex/core.c-747-}
kernel/futex/core.c-748-
kernel/futex/core.c-749-/*


Thanks,
Florian

