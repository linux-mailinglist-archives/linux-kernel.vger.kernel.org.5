Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1C8039F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjLDQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjLDQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:17:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D24A95
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:17:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AB8152B;
        Mon,  4 Dec 2023 08:18:32 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F3C73F6C4;
        Mon,  4 Dec 2023 08:17:42 -0800 (PST)
Message-ID: <1aca6009-9943-d0ee-0fa9-b88b33fd0540@arm.com>
Date:   Mon, 4 Dec 2023 16:17:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/6] arm64: KVM: Move SPE and trace registers to the
 sysreg array
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, suzuki.poulose@arm.com, broonie@kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231019165510.1966367-1-james.clark@arm.com>
 <20231019165510.1966367-3-james.clark@arm.com> <86plzmb9jj.wl-maz@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <86plzmb9jj.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2023 09:29, Marc Zyngier wrote:
> On Thu, 19 Oct 2023 17:55:00 +0100,
> James Clark <james.clark@arm.com> wrote:
>>
>> pmscr_el1 and trfcr_el1 are currently special cased in the
>> host_debug_state struct, but they're just registers after all so give
>> them entries in the sysreg array and refer to them through the host
>> context.
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_host.h  |  6 ++--
>>  arch/arm64/include/asm/kvm_hyp.h   |  4 +--
>>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 44 +++++++++++++++---------------
>>  arch/arm64/kvm/hyp/nvhe/switch.c   |  4 +--
>>  4 files changed, 28 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 4a966c0d7373..7c82927ddaf2 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -437,6 +437,8 @@ enum vcpu_sysreg {
>>  	CNTHP_CVAL_EL2,
>>  	CNTHV_CTL_EL2,
>>  	CNTHV_CVAL_EL2,
>> +	PMSCR_EL1,	/* Statistical profiling extension */
>> +	TRFCR_EL1,	/* Self-hosted trace filters */
> 
> Why this move? Are you also adding guest support for SPE?
> 
> Until you do, I don't see the need to pollute the guest's sysreg
> namespace.
> 
> 	M.
> 

Ah ok yes, I think I misunderstood your previous review comment. You're
right I don't touch SPE and it's only ever for the host so I can leave
it where it was in struct host_debug_state.

James
