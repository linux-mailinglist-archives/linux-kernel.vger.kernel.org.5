Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B2810946
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378510AbjLME4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjLME4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:56:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40F929A;
        Tue, 12 Dec 2023 20:56:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41A9C15;
        Tue, 12 Dec 2023 20:57:11 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905483F5A1;
        Tue, 12 Dec 2023 20:56:19 -0800 (PST)
Message-ID: <26ab1190-f437-477b-b09c-6522a1d3fe1d@arm.com>
Date:   Wed, 13 Dec 2023 10:26:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 5/8] KVM: arm64: nvhe: Disable branch generation in
 nVHE guests
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
 <20231201053906.1261704-6-anshuman.khandual@arm.com>
 <86ttoybbp4.wl-maz@kernel.org> <e48f5cdc-2711-4a03-a074-da87d84b3caf@arm.com>
In-Reply-To: <e48f5cdc-2711-4a03-a074-da87d84b3caf@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/23 11:30, Anshuman Khandual wrote:
> On 12/4/23 14:12, Marc Zyngier wrote:
>> On Fri, 01 Dec 2023 05:39:03 +0000,
>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>> Disable the BRBE before we enter the guest, saving the status and enable it
>>> back once we get out of the guest. This is just to avoid capturing records
>>> in the guest kernel/userspace, which would be confusing the samples.
>> Why does it have to be limited to non-VHE? What protects host EL0
>> records from guest's EL0 execution when the host is VHE?
> In a scenario when running the host in VHE mode
>  
> - The host might have enabled branch records for host EL0 through BRBCR_EL2.E0HBRE
>   indirectly via accessing BRBCR_EL1.E0BRE
> 
> - But after the guest switches in on the cpu - BRBCR_EL2.E0HBRE will still remain
>   set and enable branch records in guest EL0 as well because BRBCR_EL1.E0BRE will
>   not have any effect when EL2 is implemented and HCR_EL2.TGE == 1. The guest EL0
>   execution branch records will find their way into branch records being captured
>   for host EL0
> 
> You are right. The host EL0 branch records too need to be protected from guest EL0
> execution. A similar BRBCR_EL1 save/restore mechanism is needed for VHE as well ?

Looking at this again, seems like host EL0 records will be protected from
guest EL0 execution as HCR_EL2.TGE toggles when th guest switches in thus
enforcing BRBCR_EL1.E0BRE (which is clear) requirement for capturing guest
EL0 branch records.

arch/arm64/kvm/hyp/vhe/tlb.c

__tlb_switch_to_guest() {
	....
	val = read_sysreg(hcr_el2);
        val &= ~HCR_TGE;
        write_sysreg(val, hcr_el2);
	isb();
}

HCR_TGE comes back via HCR_HOST_VHE_FLAGS when the host switches back in.

__tlb_switch_to_host() {
	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
        isb();
	....
}
