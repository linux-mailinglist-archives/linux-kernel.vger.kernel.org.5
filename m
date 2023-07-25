Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09576206E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGYRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGYRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:47:15 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3701FDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:47:12 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-79a2216a22fso775864241.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690307232; x=1690912032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjxGQ97jdZy+msttaE6/InGye12w/eRXu8aDXNaXRhA=;
        b=mJItfjJo0J8vq8ZI7eQRqgBugJTE/Qjls8F9j5zJT4/6drjQg4QRDl54H4s/m4+/B6
         OdBZ9Wq1QAC//eamW92We5bVMlBhbiRysXzmrEde6b6WilxsOOxfPGb41E5gLvLxIRQd
         mG8WW9RKwkhn1rvhmTvmgDcKKzEniO9bQreDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307232; x=1690912032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjxGQ97jdZy+msttaE6/InGye12w/eRXu8aDXNaXRhA=;
        b=LpLGfWD5esN8uBUIBcXNWvU0jsX4HWFK6YOlcMgjKn4kCfxodlTheFPxSDIvKmlqwc
         rvSCTIKRnlgAYdnQpBX87HYyybx3mBCKdZj3SQUVZBnsL/mHDG/L8bmjmUSLVdY54Ezn
         t84H/NBrCup00JqOOG+K10xceXxQgCgkTkEoMZEpbDK3vzZoAuqrG4ogetdu+FFJYEAc
         FT6bDBB1QQhEEzOtkdXfDSc5/lHVq6Ku8s9wFzlpcg5B5ZVM+puUDaXWxlDLr9EZvZni
         84MwZZfChPbG+phQ0KrO9mV/VDrevLfgS72fFOLMw9vQ1BDx0UHK40sltvprJ4+bCkH/
         9Plw==
X-Gm-Message-State: ABy/qLYNYkkV6ebF9eTeJIR4h5nZPGKiGthuA3yNwjE17JF2UrphAenR
        VcGq0vDD4kn7rWxTYIaDJgXouA==
X-Google-Smtp-Source: APBJJlFxF234D/M5tS2Q+/KCUeJ8ymhGYnmYBO9RSoGjcR24zk88rZomSukAB6JnjgPjlb4vStmdHw==
X-Received: by 2002:a67:b106:0:b0:443:60d7:3925 with SMTP id w6-20020a67b106000000b0044360d73925mr5444114vsl.20.1690307231746;
        Tue, 25 Jul 2023 10:47:11 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id c11-20020a0cf2cb000000b0063d1f967268sm404045qvm.111.2023.07.25.10.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:47:11 -0700 (PDT)
Message-ID: <c72c1089-f5ac-9ed2-3412-cdb310cf5b51@joelfernandes.org>
Date:   Tue, 25 Jul 2023 13:47:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 18/20] context_tracking,x86: Defer kernel text
 patching IPIs
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
References: <20230720163056.2564824-19-vschneid@redhat.com>
 <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
 <20230725133936.GM3765278@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230725133936.GM3765278@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 09:39, Peter Zijlstra wrote:
> On Tue, Jul 25, 2023 at 06:49:45AM -0400, Joel Fernandes wrote:
>> Interesting series Valentin. Some high-level question/comments on this one:
>>
>>> On Jul 20, 2023, at 12:34 PM, Valentin Schneider <vschneid@redhat.com> wrote:
>>>
>>> ﻿text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
>>> them vs the newly patched instruction. CPUs that are executing in userspace
>>> do not need this synchronization to happen immediately, and this is
>>> actually harmful interference for NOHZ_FULL CPUs.
>>
>> Does the amount of harm not correspond to practical frequency of text_poke? 
>> How often does instruction patching really happen? If it is very infrequent
>> then I am not sure if it is that harmful.
> 
> Well, it can happen quite a bit, also from things people would not
> typically 'expect' it.
> 
> For instance, the moment you create the first per-task perf event we
> frob some jump-labels (and again some second after the last one goes
> away).
> 
> The same for a bunch of runtime network configurations.

Ok cool. I guess I still have memories of that old ARM device I had
where modifications to kernel text was forbidden by hardware (was a
security feature). That was making kprobes unusable...

>>> As the synchronization IPIs are sent using a blocking call, returning from
>>> text_poke_bp_batch() implies all CPUs will observe the patched
>>> instruction(s), and this should be preserved even if the IPI is deferred.
>>> In other words, to safely defer this synchronization, any kernel
>>> instruction leading to the execution of the deferred instruction
>>> sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.
>>
>> If it is not infrequent, then are you handling the case where userland
>> spends multiple seconds before entering the kernel, and all this while
>> the blocking call waits? Perhaps in such situation you want the real IPI
>> to be sent out instead of the deferred one?
> 
> Please re-read what Valentin wrote -- nobody is waiting on anything.

Makes sense. To be fair I received his email 3 minutes before yours ;-).
But thank you both for clarifying!

 - Joel


