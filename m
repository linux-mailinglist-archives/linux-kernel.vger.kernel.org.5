Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8C7E516E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjKHHya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjKHHy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:54:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A204D41
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:54:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8215D2195A;
        Wed,  8 Nov 2023 07:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699430064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VU+vM5wUGc3EL8t1LtNAItoM3MFPNs2TVeGo5dvhce0=;
        b=VU9R2+xQb+pEXnmjRL7Aym/VHrTErvAiuEXkQDp1nkXQEzSvV5Y8iWYE46lOLH7GBPSqdl
        M8dS4pm8xMTkrVzZCVMZL9xguLNsoIY9lxbNe8tKDe7mpahBdeWxjVhLq28iekqekNhs4k
        pNkwobAwTytks0uDOxJW4DtFDMyGVGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699430064;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VU+vM5wUGc3EL8t1LtNAItoM3MFPNs2TVeGo5dvhce0=;
        b=SfIbiV43iX5HrqQqaDTrzENDpNtfnvoImuf7rABn05iZLZTeC029l/RShirbp9PywIhKBC
        hjFQQG3tG05J/JDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77AA4133F5;
        Wed,  8 Nov 2023 07:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +buBG68+S2XBJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Nov 2023 07:54:23 +0000
Message-ID: <ba99f6d1-c034-5153-d2ad-02d244f9db10@suse.cz>
Date:   Wed, 8 Nov 2023 08:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <549c1cba-5cad-7706-de85-d61376db25cc@linux.com> <87bkc4vp89.fsf@oracle.com>
 <385909b5-3077-42d4-07ef-7ae915d24b5a@linux.com>
 <20231108001217.068d20da@gandalf.local.home>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231108001217.068d20da@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 06:12, Steven Rostedt wrote:
> On Tue, 7 Nov 2023 20:52:39 -0800 (PST)
> Christoph Lameter <cl@linux.com> wrote:
> 
>> On Tue, 7 Nov 2023, Ankur Arora wrote:
>> 
>> > This came up in an earlier discussion (See
>> > https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/) and Thomas mentioned
>> > that preempt_enable/_disable() overhead was relatively minimal.
>> >
>> > Is your point that always-on preempt_count is far too expensive?  
>> 
>> Yes over the years distros have traditionally delivered their kernels by 
>> default without preemption because of these issues. If the overhead has 
>> been minimized then that may have changed. Even if so there is still a lot 
>> of code being generated that has questionable benefit and just 
>> bloats the kernel.
>> 
>> >> These are needed to avoid adding preempt_enable/disable to a lot of primitives
>> >> that are used for synchronization. You cannot remove those without changing a
>> >> lot of synchronization primitives to always have to consider being preempted
>> >> while operating.  
>> >
>> > I'm afraid I don't understand why you would need to change any
>> > synchronization primitives. The code that does preempt_enable/_disable()
>> > is compiled out because CONFIG_PREEMPT_NONE/_VOLUNTARY don't define
>> > CONFIG_PREEMPT_COUNT.  
>> 
>> In the trivial cases it is simple like that. But look f.e.
>> in the slub allocator at the #ifdef CONFIG_PREEMPTION section. There is a 
>> overhead added to be able to allow the cpu to change under us. There are 
>> likely other examples in the source.
>> 
> 
> preempt_disable() and preempt_enable() are much lower overhead today than
> it use to be.
> 
> If you are worried about changing CPUs, there's also migrate_disable() too.

Note that while migrate_disable() would be often sufficient, the
implementation of it has actually more overhead (function call, does
preempt_disable()/enable() as part of it) than just preempt_disable(). See
for example the pcpu_task_pin() definition in mm/page_alloc.c



