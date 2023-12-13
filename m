Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D378121A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjLMWlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjLMWlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D61E0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702507279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2+gANqYaaLdYYgveblRGTM3hibzzgFDQkJzNX9XmDo=;
        b=COc3pc11HQndts9gb8Gakqm60AFg9GZU4hMAhN2pcWsInWBLgbL7CZHrqi7TWrNvzsUxdX
        4IEqJRLKEHKIoBEtKfy5CiFQuic2BnNwiJFsMtFyMYpH6xHR2/S/uwS9zdqrmzjw5U7qtF
        6WcqMu2qV9aBp5yYDMeEx2gJif5vNAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-LChaOG48OTCc1WqTcdwDdw-1; Wed, 13 Dec 2023 17:41:17 -0500
X-MC-Unique: LChaOG48OTCc1WqTcdwDdw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c193fca81so56511075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507276; x=1703112076;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2+gANqYaaLdYYgveblRGTM3hibzzgFDQkJzNX9XmDo=;
        b=QLn+ZclosjfD9osOI/QVdine4BR7EQ4SCTcVgD7djTyHtDa0j/39MEfNyGOoRdoZEW
         huUpB/0/P3HntcRz3vXjMBHynoxH47m67jkwQA/fAf73mloUbiEYfVRQy59ZcslwxCd5
         HdTbUc/QVqdBw0zNm5a57Z7LXbyiDErEC3YJQN8bsI4YiG9n0I8KkjgF9J1DJDeKhqrW
         Uwgt6grNA3C2BUj7qzA9CaIAb8lXSPpV2fXzpa/mIqPF/GSP1dSSwXhCSMkAg8m7e0SM
         2jUIvMBwQcpNjeKkK2lv3L7GCAp/WzW4JkFibXdUg7Ffvgu0aYy/kAWX44oVXq7m/bR2
         61ew==
X-Gm-Message-State: AOJu0YwM1c/GH/tFUacaEdjtGYb8yByUxHtSlV7infWC1xFkrdTxrjmi
        rfxqIpFEYTf8W5EdENQA1xp3UsGBNT9yiNgyD8SDwhvRypEIWpjTciBHf9mz2DL8sH7UJX9VUtr
        pEbmJkkyBg+LiPQkjekKNGtSt
X-Received: by 2002:a05:600c:3657:b0:405:3dbc:8823 with SMTP id y23-20020a05600c365700b004053dbc8823mr4565042wmq.12.1702507275905;
        Wed, 13 Dec 2023 14:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPeoXgJ1m5loGo8b/MSpc0RprvLai9peGkQgwRld1gJiMso4rhJuv4FejExGomAKeO4B7mYQ==
X-Received: by 2002:a05:600c:3657:b0:405:3dbc:8823 with SMTP id y23-20020a05600c365700b004053dbc8823mr4565036wmq.12.1702507275552;
        Wed, 13 Dec 2023 14:41:15 -0800 (PST)
Received: from starship ([77.137.131.62])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040c11fbe581sm21912565wmq.27.2023.12.13.14.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:15 -0800 (PST)
Message-ID: <e837b1964e5615e5a1e5a0113889b507a3d4970d.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] KVM: selftests: Add test case for x86
 apic_bus_clock_frequency
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Jim Mattson <jmattson@google.com>
Date:   Thu, 14 Dec 2023 00:41:13 +0200
In-Reply-To: <232d64219c6df684f99f9072d41e8783f1a4fe46.1699936040.git.isaku.yamahata@intel.com>
References: <cover.1699936040.git.isaku.yamahata@intel.com>
         <232d64219c6df684f99f9072d41e8783f1a4fe46.1699936040.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-13 at 20:35 -0800, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Test if the apic bus clock frequency is exptected to the configured value.
> Set APIC TMICT to the maximum value and busy wait for 100 msec (any value
> is okay) with tsc value, and read TMCCT. Calculate apic bus clock frequency
> based on TSC frequency.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
> Changes v2:
> - Newly added
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/apic.h       |   7 +
>  .../kvm/x86_64/apic_bus_clock_test.c          | 132 ++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a5963ab9215b..74ed3f71b6e8 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -115,6 +115,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_invalid_nested_guest_state
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_nested_tsc_scaling_test
> +TEST_GEN_PROGS_x86_64 += x86_64/apic_bus_clock_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xapic_ipi_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xapic_state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xcr0_cpuid_test
> diff --git a/tools/testing/selftests/kvm/include/x86_64/apic.h b/tools/testing/selftests/kvm/include/x86_64/apic.h
> index bed316fdecd5..866a58d5fa11 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/apic.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/apic.h
> @@ -60,6 +60,13 @@
>  #define		APIC_VECTOR_MASK	0x000FF
>  #define	APIC_ICR2	0x310
>  #define		SET_APIC_DEST_FIELD(x)	((x) << 24)
> +#define APIC_LVT0       0x350
> +#define         APIC_LVT_TIMER_ONESHOT          (0 << 17)
> +#define         APIC_LVT_TIMER_PERIODIC         (1 << 17)
> +#define         APIC_LVT_TIMER_TSCDEADLINE      (2 << 17)
> +#define APIC_TMICT	0x380
> +#define APIC_TMCCT	0x390
> +#define APIC_TDCR	0x3E0
>  
>  void apic_disable(void);
>  void xapic_enable(void);
> diff --git a/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c b/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> new file mode 100644
> index 000000000000..91f558d7c624
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +
> +#include "apic.h"
> +#include "test_util.h"
> +
> +/* Pick one convenient value, 1Ghz.  No special meaning. */
Tiny nitpick: to be 100% honest, 1Ghz does have a special meaning, it's the default APIC bus frequency.
It might be slightly better to use say 1.5Ghz or something like that.

> +#define TSC_HZ			(1 * 1000 * 1000 * 1000ULL)
> +
> +/* Wait for 100 msec, not too long, not too short value. */
> +#define LOOP_MSEC		100ULL
> +#define TSC_WAIT_DELTA		(TSC_HZ / 1000 * LOOP_MSEC)
> +
> +/* Pick up typical value.  Different enough from the default value, 1GHz.  */
> +#define APIC_BUS_CLOCK_FREQ	(25 * 1000 * 1000ULL)
> +
> +static void guest_code(void)
> +{
> +	/* Possible tdcr values and its divide count. */
> +	struct {
> +		u32 tdcr;
> +		u32 divide_count;
> +	} tdcrs[] = {
> +		{0x0, 2},
> +		{0x1, 4},
> +		{0x2, 8},
> +		{0x3, 16},
> +		{0x8, 32},
> +		{0x9, 64},
> +		{0xa, 128},
> +		{0xb, 1},
> +	};
> +
> +	u32 tmict, tmcct;
> +	u64 tsc0, tsc1;
> +	int i;
> +
> +	asm volatile("cli");
> +
> +	xapic_enable();
> +
> +	/*
> +	 * Setup one-shot timer.  Because we don't fire the interrupt, the
> +	 * vector doesn't matter.
> +	 */
> +	xapic_write_reg(APIC_LVT0, APIC_LVT_TIMER_ONESHOT);
> +
> +	for (i = 0; i < ARRAY_SIZE(tdcrs); i++) {
> +		xapic_write_reg(APIC_TDCR, tdcrs[i].tdcr);
> +
> +		/* Set the largest value to not trigger the interrupt. */
> +		tmict = ~0;
> +		xapic_write_reg(APIC_TMICT, tmict);
> +
> +		/* Busy wait for LOOP_MSEC */
> +		tsc0 = rdtsc();
> +		tsc1 = tsc0;
> +		while (tsc1 - tsc0 < TSC_WAIT_DELTA)
> +			tsc1 = rdtsc();
> +
> +		/* Read apic timer and tsc */
> +		tmcct = xapic_read_reg(APIC_TMCCT);
> +		tsc1 = rdtsc();
> +
> +		/* Stop timer */
> +		xapic_write_reg(APIC_TMICT, 0);
> +
> +		/* Report it. */
> +		GUEST_SYNC_ARGS(tdcrs[i].divide_count, tmict - tmcct,
> +				tsc1 - tsc0, 0, 0);
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +void test_apic_bus_clock(struct kvm_vcpu *vcpu)
> +{
> +	bool done = false;
> +	struct ucall uc;
> +
> +	while (!done) {
> +		vcpu_run(vcpu);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_DONE:
> +			done = true;
> +			break;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			break;
> +		case UCALL_SYNC: {
> +			u32 divide_counter = uc.args[1];
> +			u32 apic_cycles = uc.args[2];
> +			u64 tsc_cycles = uc.args[3];
> +			u64 freq;
> +
> +			TEST_ASSERT(tsc_cycles > 0,
> +				    "tsc cycles must not be zero.");
> +
> +			/* Allow 1% slack. */
> +			freq = apic_cycles * divide_counter * TSC_HZ / tsc_cycles;
> +			TEST_ASSERT(freq < APIC_BUS_CLOCK_FREQ * 101 / 100,
> +				    "APIC bus clock frequency is too large");
> +			TEST_ASSERT(freq > APIC_BUS_CLOCK_FREQ * 99 / 100,
> +				    "APIC bus clock frequency is too small");
> +			break;
> +		}
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +			break;
> +		}
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = __vm_create(VM_MODE_DEFAULT, 1, 0);
> +	vm_ioctl(vm, KVM_SET_TSC_KHZ, (void *) (TSC_HZ / 1000));
> +	/*  KVM_CAP_X86_BUS_FREQUENCY_CONTROL requires that no vcpu is created. */
> +	vm_enable_cap(vm, KVM_CAP_X86_BUS_FREQUENCY_CONTROL,
> +		      APIC_BUS_CLOCK_FREQ);
> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
> +
> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
> +
> +	test_apic_bus_clock(vcpu);
> +	kvm_vm_free(vm);
> +}

Looks good overall.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


