Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44E2772840
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHGOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHGOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:54:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E710CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:54:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691420044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWPWCeO32Ooz2qU+ay/je0IMsANVu/pNL7syLVoePSQ=;
        b=F8UAS1H2nTThs6X6voolX/Rn/DN0B0TQqBa527ADk/LMxy+hv+Tr+JVSGV3oP5F942lWsx
        TN5IXwDs5OAfMpxSxLaSWzchMtZymhoSVtZqQ1gPRNYTgw+7eM+f7lwch+eNynqDWiXSZm
        ebbT85k/qOX9lDWbGwZqWhSxH6W+/sZ7p5OzWL6JNgJBbgOPSDSEK4e2nrLnkzbEUQnxnH
        tfiTAV5tTfL5rtkt6C9TyH9wH/M8UkEUwrKP7dwkz43NsX8z7YLGXxp55cbTw8ghobD+ln
        W5JV2c68KbgZgszeS27TI31zCUrAuES5mVb/i5eUz3q7LemhtINxqXXQ86147g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691420044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWPWCeO32Ooz2qU+ay/je0IMsANVu/pNL7syLVoePSQ=;
        b=uTkP1nZBwhoskT5ObsbqbZFAjb026R/rU1gA5ZqKLvpPNPe4y7aqXOXQwiKswTvHj8BfwZ
        nvR17JW9byOjG4AQ==
To:     Arjan van de Ven <arjan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 02/53] x86/cpu/topology: Make the APIC mismatch warnings
 complete
In-Reply-To: <c21f9f42-d270-d9be-b94e-de4d4b6e5ad5@linux.intel.com>
References: <20230807130108.853357011@linutronix.de>
 <20230807135026.528433010@linutronix.de>
 <c21f9f42-d270-d9be-b94e-de4d4b6e5ad5@linux.intel.com>
Date:   Mon, 07 Aug 2023 16:54:03 +0200
Message-ID: <877cq6vr78.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07 2023 at 07:28, Arjan van de Ven wrote:

> On 8/7/2023 6:52 AM, T
>>   
>> --- a/arch/x86/kernel/cpu/topology_common.c
>> +++ b/arch/x86/kernel/cpu/topology_common.c
>> @@ -176,6 +176,16 @@ void cpu_parse_topology(struct cpuinfo_x
>>   
>>   	parse_topology(&tscan, false);
>>   
>> +	if (c->topo.initial_apicid != c->topo.apicid) {
>> +		pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x\n",
>> +		       cpu, c->topo.initial_apicid, c->topo.apicid);
>> +	}
>> +
>> +	if (c->topo.apicid != cpuid_to_apicid[cpu]) {
>> +		pr_err(FW_BUG "CPU%4u: APIC ID mismatch. Firmware: 0x%04x APIC: 0x%04x\n",
>> +		       cpu, cpuid_to_apicid[cpu], c->topo.apicid);
>> +	}
>> +
>
> while these messages are basically the same as current ones they are short one key thing for the user
> ... which one of the two will be used. Yes one can look up in the source code where the message comes from
> and reverse engineer that... or we can just add this to these pr_err() messages
>
>
> like
>
> pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x. APIC value will be used.\n",
> 		       cpu, c->topo.initial_apicid, c->topo.apicid);

Good point.
