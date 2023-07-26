Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A81762B60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGZG0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGZG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:26:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2569D13E;
        Tue, 25 Jul 2023 23:26:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02BF11FB;
        Tue, 25 Jul 2023 23:27:04 -0700 (PDT)
Received: from [10.162.40.16] (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB723F5A1;
        Tue, 25 Jul 2023 23:26:17 -0700 (PDT)
Message-ID: <b987c2df-0c3a-e728-e531-5a862c6076d3@arm.com>
Date:   Wed, 26 Jul 2023 11:56:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V13 - RESEND 06/10] arm64/perf: Enable branch stack events
 via FEAT_BRBE
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-7-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230711082455.215983-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/23 13:54, Anshuman Khandual wrote:
> +static void capture_brbe_flags(struct perf_branch_entry *entry, struct perf_event *event,
> +			       u64 brbinf)
> +{
> +	if (branch_sample_type(event))
> +		brbe_set_perf_entry_type(entry, brbinf);
> +
> +	if (!branch_sample_no_cycles(event))
> +		entry->cycles = brbe_get_cycles(brbinf);

Just revisiting the branch records cycle capture process in BRBE.

'cycles' field is a 16 bit field in struct perf_branch_entry.

struct perf_branch_entry {
        __u64   from;
        __u64   to;
        __u64   mispred:1,  /* target mispredicted */
                predicted:1,/* target predicted */
                in_tx:1,    /* in transaction */
                abort:1,    /* transaction abort */
                cycles:16,  /* cycle count to last branch */
                type:4,     /* branch type */
                spec:2,     /* branch speculation info */
                new_type:4, /* additional branch type */
                priv:3,     /* privilege level */
                reserved:31;
};

static inline int brbe_get_cycles(u64 brbinf)
{
	/*
	 * Captured cycle count is unknown and hence
	 * should not be passed on to the user space.
	 */
	if (brbinf & BRBINFx_EL1_CCU)
		return 0;

	return FIELD_GET(BRBINFx_EL1_CC_MASK, brbinf);
}

capture_brbe_flags()
{

	.....
	if (!branch_sample_no_cycles(event))
		entry->cycles = brbe_get_cycles(brbinf);
	.....

}

BRBINF<N>_EL1.CC[45:32] is a 14 bits field which gets assigned into
perf_branch_entry->cycles field which is 16 bits wide. Although the
cycle count representation here is mantissa and exponent based one.

CC bits[7:0] indicate the mantissa M
CC bits[13:8] indicate the exponent E

The actual cycle count is based on the following formula as the per
the spec [1], which needs to be derived from BRBINF<N>_EL1.CC field.

-------------------------------------------------------------------
The cycle count is expressed using the following function:

if IsZero(E) then UInt(M) else UInt('1':M:Zeros(UInt(E)-1))

If required, the cycle count is rounded to a multiple of 2(E-1) towards zero before being encoded.

A value of all ones in both the mantissa and exponent indicates the cycle count value exceeded the size of the cycle counter.
-------------------------------------------------------------------

Given that there is only 16 bits in perf_branch_entry structure for
cycles count, I assume that it needs to be derived in the user perf
tool (per the above calculation) before being interpreted ?

[1] https://developer.arm.com/documentation/ddi0601/2023-06/AArch64-Registers/BRBINF-n--EL1--Branch-Record-Buffer-Information-Register--n-?lang=en

- Anshuman


