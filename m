Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B217694B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGaLV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjGaLVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7910CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690802454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47HAhqvJlrFOjF3d3mT+sXNh9SqjQbM0s/wrTjkOtJg=;
        b=i884zA/q0qcP8cVnklnRkqGFucfkUGfvK7wvaYeRfGvH0v5btCjeJko+jL59jUXEjgv2qJ
        MPRE9bRchFfjhtldOnlZjW/z4MQfoKk9X3i254FEmWGuMp6bis0uH3kD2TJVA9OVvafBdu
        cvHkLTqJEERxMkTOxNDOZBYeEqHfCf8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-hK5rRkUDPQi-qvdSn2CHoA-1; Mon, 31 Jul 2023 07:20:52 -0400
X-MC-Unique: hK5rRkUDPQi-qvdSn2CHoA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d09e8bc06so33398406d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802452; x=1691407252;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47HAhqvJlrFOjF3d3mT+sXNh9SqjQbM0s/wrTjkOtJg=;
        b=jrOhfHz1VpWTg6brCxcz5BDV5WDHWuNzJSucRInd8zL5surDtCJTQz4bf5mjMyMsfP
         IgGTY8G64FIDhG4PvTtUIvkGXxf7cBwY3KkfHDWOWAv3/aBtZ4DIp9un4CDVP406l4sK
         0MzMY1iKM9gcT+ZnwSc9mnZW3OEpk59BR+iJLrUu9sKCCwNNlcqJAb85g9lrv4whMcbD
         nbtDRlpbWEc5C7Sp1tlVjUEO1ipbY35cxQnviAEbLIee37mn06Ml2c2i0oTxuef/PMKb
         bcbt+jBpy2gQ89lIdK15dGNrJXLFgZa/uX6wASpIWFBC03mvDdgA6k1Q5mAa3J7CbUYf
         tuyg==
X-Gm-Message-State: ABy/qLbWsOryvyBF3YN7tWTz6hnC2wK+Ldlpm0v4xjmbzsWdOllGRLJ8
        mprxOGrezEODmEl9vRwupKLlOQJejhkxxtzLyJARlcAFmyTly5IHb7O5sC/80yIQGicLW5Wzydn
        PW/xR/twboGp2wp/0B3xKSbFL
X-Received: by 2002:a0c:e14d:0:b0:634:20f:471c with SMTP id c13-20020a0ce14d000000b00634020f471cmr6609355qvl.14.1690802451988;
        Mon, 31 Jul 2023 04:20:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQmknuNkpt4OdqMMs+lcZsPQfXQHCOzlkWOeCIE2fDz4iRThyIeyibV6Yi3WqcRw7uGfKfaw==
X-Received: by 2002:a0c:e14d:0:b0:634:20f:471c with SMTP id c13-20020a0ce14d000000b00634020f471cmr6609334qvl.14.1690802451661;
        Mon, 31 Jul 2023 04:20:51 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id n2-20020a0ce542000000b0061b5dbf1994sm3583834qvm.146.2023.07.31.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:20:51 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 06/20] tracing/filters: Optimise scalar vs
 cpumask filtering when the user mask is a single CPU
In-Reply-To: <20230729155547.35719a1f@rorschach.local.home>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-7-vschneid@redhat.com>
 <20230729155547.35719a1f@rorschach.local.home>
Date:   Mon, 31 Jul 2023 12:20:41 +0100
Message-ID: <xhsmh1qgos4xi.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

On 29/07/23 15:55, Steven Rostedt wrote:
> On Thu, 20 Jul 2023 17:30:42 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> Steven noted that when the user-provided cpumask contains a single CPU,
>> then the filtering function can use a scalar as input instead of a
>> full-fledged cpumask.
>>
>> When the mask contains a single CPU, directly re-use the unsigned field
>> predicate functions. Transform '&' into '==' beforehand.
>>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/trace/trace_events_filter.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
>> index 2fe65ddeb34ef..54d642fabb7f1 100644
>> --- a/kernel/trace/trace_events_filter.c
>> +++ b/kernel/trace/trace_events_filter.c
>> @@ -1750,7 +1750,7 @@ static int parse_pred(const char *str, void *data,
>>               * then we can treat it as a scalar input.
>>               */
>>              single = cpumask_weight(pred->mask) == 1;
>> -		if (single && field->filter_type == FILTER_CPUMASK) {
>> +		if (single && field->filter_type != FILTER_CPU) {
>>                      pred->val = cpumask_first(pred->mask);
>>                      kfree(pred->mask);
>>              }
>> @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void *data,
>>                              FILTER_PRED_FN_CPUMASK;
>>              } else if (field->filter_type == FILTER_CPU) {
>>                      pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
>> +		} else if (single) {
>> +			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
>
> Nit, the above can be written as:
>
>                       pred->op = pret->op != OP_BAND ? : OP_EQ;
>

That's neater, thanks!

> -- Steve
>
>
>> +			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
>> +			if (pred->op == OP_NE)
>> +				pred->not = 1;
>>              } else {
>>                      switch (field->size) {
>>                      case 8:

