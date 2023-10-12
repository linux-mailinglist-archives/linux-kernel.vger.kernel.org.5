Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A677C77EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442767AbjJLUgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347403AbjJLUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:36:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC8ACA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:36:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E70C433C7;
        Thu, 12 Oct 2023 20:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697142996;
        bh=qfX1SodUJMazOEDs5JlmUHg0AtVW+L6/EyjHuDRfotg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/IGlDQLSLZXodptqjPsCe0oLd2w5yn2DZDLWytelFLxee011GUtQir3kcxKUaCJt
         QDUCbnHpHixhfPdP82/TmVJdQ8xrjgDlJFM7vjfqvLl/3P7fLO4O4KrCwVTMBjS2Rm
         zAPfOcgM2km+8dzmSJaeD5SOmeJyNh/2SnkbnO3di5ESRFN++0WNbmT/9fsQvPuLY4
         oT3PQ3dVuYA4aPCq2nN/tdbVe+/4WllbwBoTncgi8bwSjq95gWlLKoF9k9q5BZNZlk
         QFraeoe2QTtRDPVPCYTRtmhKwu2jgHzCNTVOVuwNmjgAcp3WqLqmY/i5Gpz4zIns97
         Kb1ngR6GQ0XMA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qr2Q6-003eHp-47;
        Thu, 12 Oct 2023 21:36:34 +0100
MIME-Version: 1.0
Date:   Thu, 12 Oct 2023 21:36:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     eric.auger@redhat.com
Cc:     Miguel Luis <miguel.luis@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 3/3] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
In-Reply-To: <7df53e6b-9141-de85-b7a3-b9eb092ef7b4@redhat.com>
References: <20231011180103.91774-1-miguel.luis@oracle.com>
 <20231011180103.91774-4-miguel.luis@oracle.com>
 <7df53e6b-9141-de85-b7a3-b9eb092ef7b4@redhat.com>
User-Agent: Roundcube Webmail/1.4.14
Message-ID: <e6f3002c10848e911c4bfee3a1d472aa@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, miguel.luis@oracle.com, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, jingzhangos@google.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-12 16:22, Eric Auger wrote:
> Hi Miguel,
> 
> On 10/11/23 20:01, Miguel Luis wrote:
>> Implement a fine grained approach in the _EL2 sysreg ranges.
>> 
>> Fixes: d0fc0a2519a6 ("KVM: arm64: nv: Add trap forwarding for 
>> HCR_EL2")
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> ---
>>  arch/arm64/kvm/emulate-nested.c | 88 
>> ++++++++++++++++++++++++++++++---
>>  1 file changed, 82 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/emulate-nested.c 
>> b/arch/arm64/kvm/emulate-nested.c
>> index 9ced1bf0c2b7..3af49e130ee6 100644
>> --- a/arch/arm64/kvm/emulate-nested.c
>> +++ b/arch/arm64/kvm/emulate-nested.c
>> @@ -648,15 +648,91 @@ static const struct encoding_to_trap_config 
>> encoding_to_cgt[] __initconst = {
>>  	SR_TRAP(SYS_APGAKEYLO_EL1,	CGT_HCR_APK),
>>  	SR_TRAP(SYS_APGAKEYHI_EL1,	CGT_HCR_APK),
>>  	/* All _EL2 registers */
>> -	SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
>> -		      sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
>> +	SR_TRAP(SYS_VPIDR_EL2,		CGT_HCR_NV),
> I think you miss DBGVCR32_EL2

I don't think this register should be part of this list. We don't
support AArch32 with NV, and the spec says that DBGVCR32_EL2 UNDEFs
when EL1 doesn't support AArch32.

So the change that needs to happen is to inject an UNDEF when trapping
a DBGVCR32_EL2and not forward the trap to the guest.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
