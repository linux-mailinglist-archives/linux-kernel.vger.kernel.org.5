Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F9803AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjLDQvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjLDQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B4ED5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701708714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SapyimUGQGe0EmDwo46jv79iRuNiKKAe6T4mJuTcQno=;
        b=RDyhkhfGrJQmUF2EccCVz98tjt7Y5xV1jnKOIUMSp2spTQA52wdqoyNe4AR5i2FFOmTAC5
        6LtlDFuNeEaVmRZ26qC/w90KDMSvCmq1vK6OOBBGeyDFJo0FicxnjECkNo3KWpuK1P+qbf
        NjJJUrQJeVaw/MKmqP9Dg2BwH9524sQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-YFgFF2rIM3mGorQQrIMuew-1; Mon, 04 Dec 2023 11:51:53 -0500
X-MC-Unique: YFgFF2rIM3mGorQQrIMuew-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4083717431eso33191665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708712; x=1702313512;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SapyimUGQGe0EmDwo46jv79iRuNiKKAe6T4mJuTcQno=;
        b=w4Z5D/7cD9PweNbZjSyEDuSCJ8D6Ju8LUOau6TQAb9ietp4vv3juZAHAb69RfQkR7k
         MRKEOS9g08hPb8eNDL6JmWhK0G/mea5on/uehzM2KoYLOwgDRgMaLdnyNVORpHGA3QIZ
         RsUtaJF/yJdjQa88qauDS/OROb8iZTKUWo6SBKjaJkt6YwNxFLDoUkoPaM0R25vjVOSd
         rpbEfjJ2m4DZUnXWjyvJfq0LDY5Iv61f+9gBJHHJFcDb07f5JuElKlHmaJhsJ8U2ra6Q
         klcODA7QbEplKhc7BFHIqgda/v9VJzAy8+y1kHMBRdrXAo1o6/eDcgWswowFQ4kWtm9W
         +Qsw==
X-Gm-Message-State: AOJu0YzPit6fcYJUJlNqlCIN2rI/n7SZc4UZmGvAJiPd+9nNqM2bvU8L
        jEEOdBnaOvwT7rHI6gAYRYcen+5VIQdzQxGKNbtBVud1Wx18MN5p8XSgqupkf/TiYIQNrVe44iu
        vLeGwCJfCZejrir+VDoxFOylU
X-Received: by 2002:a05:600c:4f94:b0:40b:5e22:97e with SMTP id n20-20020a05600c4f9400b0040b5e22097emr3262126wmq.109.1701708712618;
        Mon, 04 Dec 2023 08:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh+TMH3imf5AUgkN8K1YnumS25NnssEHJszx6xAz27K36WgGTXX/q2RDadA1i84yY8uwaxOA==
X-Received: by 2002:a05:600c:4f94:b0:40b:5e22:97e with SMTP id n20-20020a05600c4f9400b0040b5e22097emr3262113wmq.109.1701708712303;
        Mon, 04 Dec 2023 08:51:52 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id bg36-20020a05600c3ca400b003fe1fe56202sm15897195wmb.33.2023.12.04.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:51:51 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH 5/5] x86/tsc: Make __use_tsc __ro_after_init
In-Reply-To: <20231120120553.GU8262@noisy.programming.kicks-ass.net>
References: <20231120105528.760306-1-vschneid@redhat.com>
 <20231120105528.760306-6-vschneid@redhat.com>
 <20231120120553.GU8262@noisy.programming.kicks-ass.net>
Date:   Mon, 04 Dec 2023 17:51:49 +0100
Message-ID: <xhsmhcyvlc3mi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/23 13:05, Peter Zijlstra wrote:
> On Mon, Nov 20, 2023 at 11:55:28AM +0100, Valentin Schneider wrote:
>> __use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
>> it as __ro_after_init.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  arch/x86/kernel/tsc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index 15f97c0abc9d0..f19b42ea40573 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
>>  static int __read_mostly tsc_unstable;
>>  static unsigned int __initdata tsc_early_khz;
>>
>> -static DEFINE_STATIC_KEY_FALSE(__use_tsc);
>> +static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
>
> So sure, we can absolutely do that, but do we want to take this one
> further perhaps? "notsc" on x86_64 makes no sense what so ever. Lets
> drag things into this millennium.
>

Just to make sure I follow: currently, for the static key to be enabled, we
(mostly) need:
o X86_FEATURE_TSC is in CPUID
o determine_cpu_tsc_frequencies()->pit_hpet_ptimer_calibrate_cpu() passes

IIUC all X86_64 systems have a TSC, so the CPUID feature should be a given.

AFAICT pit_hpt_ptimer_calibrate_cpu() relies on having either HPET or the
ACPI PM timer, the latter should be widely available, though X86_PM_TIMER
can be disabled via EXPERT - is that a fringe case we don't care about, or
did I miss something? I don't really know this stuff, and I'm trying to
write a changelog...

