Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BB77CF2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjJSIbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:31:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FB711F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:31:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFD82F4;
        Thu, 19 Oct 2023 01:32:17 -0700 (PDT)
Received: from [10.163.36.185] (unknown [10.163.36.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4F8F3F762;
        Thu, 19 Oct 2023 01:31:34 -0700 (PDT)
Message-ID: <96e31c6a-8de6-43dd-842e-ca56146d91d0@arm.com>
Date:   Thu, 19 Oct 2023 14:01:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Independently update HDFGRTR_EL2 and HDFGWTR_EL2
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20231018030007.1968317-1-anshuman.khandual@arm.com>
 <86r0lsm7cq.wl-maz@kernel.org> <d8db313d-1161-4a6e-9edc-7dc1e22d2018@arm.com>
 <8734y76q2w.wl-maz@kernel.org>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8734y76q2w.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 12:45, Marc Zyngier wrote:
> On Thu, 19 Oct 2023 04:36:15 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 10/18/23 18:10, Marc Zyngier wrote:
>>> On Wed, 18 Oct 2023 04:00:07 +0100,
>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>> Currently PMSNEVFR_EL1 system register read, and write access EL2 traps are
>>>> disabled, via setting the same bit (i.e 62) in HDFGRTR_EL2, and HDFGWTR_EL2
>>>> respectively. Although very similar, bit fields are not exact same in these
>>>> two EL2 trap configure registers particularly when it comes to read-only or
>>>> write-only accesses such as ready-only 'HDFGRTR_EL2.nBRBIDR' which needs to
>>>> be set while enabling BRBE on NVHE platforms. Using the exact same bit mask
>>>> fields for both these trap register risk writing into their RESERVED areas,
>>>> which is undesirable.
>>>
>>> Sorry, I don't understand at all what you are describing. You seem to
>>> imply that the read and write effects of the FGT doesn't apply the
>>> same way. But my reading of the ARM ARM is that  behave completely
>>> symmetrically.
>>>
>>> Also, what is nBRBIDR doing here? It is still set to 0. What
>>> 'RESERVED' state are you talking about?
>>
>> Let's observe the following example which includes the nBRBIDR problem,
>> mentioned earlier.
>>
>> Read access trap configure
>>
>> HDFGRTR_EL2[59]	   - nBRBIDR
>> HDFGRTR_EL2[58]	   - PMCEIDn_EL0
>>
>> Write access trap configure
>>
>> HDFGWTR_EL2[59:58] - RES0
>>
>> Because BRBIDR_EL1 and PMCEID<N>_EL0 are read only registers they don't
>> have corresponding entries in HDFGWTR_EL2 for write trap configuration.
>>
>> Using the exact same value contained in 'x0' both for HDFGRTR_EL2, and
>> HDFGWTR_EL2 will be problematic in case it contains bit fields that are
>> available only in one of the registers but not in the other.
>>
>> If 'x0' contains nBRBIDR being set, it will be okay for HDFGRTR_EL2 but
>> might not be okay for HDFGWTR_EL2 where it will get into RESERVED areas.
> 
> None of which matters for this patch. You keep arguing about something
> that does not exist in the change you're proposing.
> 
> [...]
> 
>> I should have given more details in the commit message but hope
>> you have some context now, but please do let me know if there
>> is something still missing.
> 
> What is missing is a useful patch. This one just obfuscates things for
> no particular purpose. If you have a useful change to contribute,
> please send that instead (your BRBE change). We don't need an extra,
> standalone and pointless patch such as this one.

I will fold this patch with other BRBE changes as mentioned earlier but
thought that - separating out updates for HDFGRTR_EL2, and HDFGWTR_EL2
should be done as stand alone change in a preparatory patch. Seems like
that was an incorrect assumption.
