Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717107F3ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjKVH0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjKVH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:26:01 -0500
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CABD98;
        Tue, 21 Nov 2023 23:25:54 -0800 (PST)
X-QQ-mid: bizesmtp90t1700637925tzulhvmw
Received: from [127.0.0.1] ( [121.8.34.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Nov 2023 15:25:23 +0800 (CST)
X-QQ-SSF: 01400000000000409000000A0000000
X-QQ-FEAT: 3M0okmaRx3gWbAZsppbqFXOgd+ASBlrd9OFaP+k9ueK1HKF7gWC1foXGe+EqS
        5s6Lqk4gZyRfovsWbuSJZ6iEmY9Q/CaPZofkp99N4oOXlUK89nrxiSjyNQAgFazULJvGX7j
        WNKx9qE+yZGk5Afi+kgu5gMhqPbVkXoE2DPLtYXbABX997agyfD7UySSnu67oRaaB6ExlVX
        2oS0xrlmTAcMOPt/uR0/Vyv9jXSIIfqit/lEYZ9gUPAyXn/5bqIwe9I7NRDi+N2egMU3LTq
        0iplZfUmlVo6VOWXkHddbWDdro4A/RdLH/uc4J5tu9zuSc0Lg0keAOuWdD+2ABk9RzXvnd0
        VxQ2lGVdQaaHhztyAecc7vztzu4Ve7h6jy9E1cIKWok0n69pqWqlf090A7zV+Ue8lcHGPCh
        JRbJJGS63Zc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9463445068661459453
Message-ID: <52743BC52E07B486+dcb66331-0993-462b-ac03-6de69a3e1fac@shingroup.cn>
Date:   Wed, 22 Nov 2023 15:25:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Add PVN support for HeXin C2000 processor
To:     Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
References: <20231117075215.647-1-ke.zhao@shingroup.cn>
 <87sf4yk19w.fsf@mail.lhotse>
Content-Language: en-US
From:   =?UTF-8?B?WmhhbyBLZSDotbUg5Y+v?= <ke.zhao@shingroup.cn>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, shenghui.qu@shingroup.cn,
        luming.yu@shingroup.cn, dawei.li@shingroup.cn
In-Reply-To: <87sf4yk19w.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 2023/11/22 9:46, Michael Ellerman wrote:
> Zhao Ke <ke.zhao@shingroup.cn> writes:
>> HeXin Tech Co. has applied for a new PVN from the OpenPower Community
>> for its new processor C2000. The OpenPower has assigned a new PVN
>> and this newly assigned PVN is 0x0066, add pvr register related
>> support for this PVN.
>>
>> Signed-off-by: Zhao Ke <ke.zhao@shingroup.cn>
>> Link: https://discuss.openpower.foundation/t/how-to-get-a-new-pvr-for-processors-follow-power-isa/477/10
>   
> Hi Zhao Ke,
>
> Thanks for the patch. Just a few questions.
>
> Are you able to provide any further detail on the processor?
>
> Your cputable entry claims that it's identical to the original Power8
> core, can you comment at all on how true that is in practice?

Basically, we made lots of design change for the new processor.

For example:

     1. redesign the interconnect of the fabric, from crossbar to mesh

     2. redesign the memory subsystem, including the modification of L2 
and L3 architecture

     3. redesign the SMP bus

     4. upgrade PCIe to gen5 and increase the number of lanes

     5. upgrade ddr to DDR5, dimm direct connected, and the number of 
channels

     6. redesign the pervasive architecture, including debug/trace, 
clock&power management, etc.


> Unfortunately the kernel has some hard-coded knowledge of various
> non-architected features, which are not controlled via the CPU table,
> and are instead controlled by firmware. So you'll need to make sure you
> set those correctly, see init_fw_feat_flags() for details.

Thanks for telling me, we have a firmware team and we will work together

on this.

> One other comment below ...
>
>> diff --git a/arch/powerpc/kernel/cpu_specs_book3s_64.h b/arch/powerpc/kernel/cpu_specs_book3s_64.h
>> index c370c1b804a9..4f604934da7c 100644
>> --- a/arch/powerpc/kernel/cpu_specs_book3s_64.h
>> +++ b/arch/powerpc/kernel/cpu_specs_book3s_64.h
>> @@ -238,6 +238,21 @@ static struct cpu_spec cpu_specs[] __initdata = {
>>   		.machine_check_early	= __machine_check_early_realmode_p8,
>>   		.platform		= "power8",
>>   	},
>> +	{	/* 2.07-compliant processor, HeXin C2000 processor */
>> +		.pvr_mask		= 0xffffffff,
>> +		.pvr_value		= 0x00660000,
>> +		.cpu_name		= "POWER8 (architected)",
>   
> Using "(architected)" here is not right. That's reserved for the
> 0x0f00000x range of PVRs.
>
> You should use "POWER8 (raw)", or you could actually use the marketing
> name there if you want to, eg. "HeXin C2000" or whatever.
I will update this asap.
> cheers
>

