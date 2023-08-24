Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CAF786C96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjHXKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjHXKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:11:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BC381985;
        Thu, 24 Aug 2023 03:11:43 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4D11C2127C7C;
        Thu, 24 Aug 2023 03:11:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D11C2127C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692871902;
        bh=wTL4n6RO/pSWsfS18SzRvJJMqeO2s4ooiItSpkg0MWQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EizwWg/LJoesLN5ikB/qxJIqjQ/Rce8ZK1aEeTK1iZUhDOJrgvZwzjDSPhmeljdXS
         x16eJuz2y9rq+c8IpzQRmrlag1YECBsIPgqlzzkuqtc33gCMgfonlhkLWfJrxvEg/R
         fY0cY+aBpI6cSCPtVOO3UHrFj1sDY7J5nC1TSJQM=
Message-ID: <06070c5d-c236-46a6-a2c1-f6d6c332b06d@linux.microsoft.com>
Date:   Thu, 24 Aug 2023 12:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] Revert "KVM: x86: enable TDP MMU by default"
To:     Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Mathias Krause <minipli@grsecurity.net>
References: <20230824010512.2714931-1-seanjc@google.com>
 <ZOavFlKo2/sixUTk@google.com>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <ZOavFlKo2/sixUTk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/2023 3:15 AM, Sean Christopherson wrote:
> +Jeremi and Mathias, my scripts for sending patches to stable don't auto-cc :-/
> 
> On Wed, Aug 23, 2023, Sean Christopherson wrote:
>> Disable the TDP MMU by default in v5.15 kernels to "fix" several severe
>> performance bugs that have since been found and fixed in the TDP MMU, but
>> are unsuitable for backporting to v5.15.
>>
>> The problematic bugs are fixed by upstream commit edbdb43fc96b ("KVM:
>> x86: Preserve TDP MMU roots until they are explicitly invalidated") and
>> commit 01b31714bd90 ("KVM: x86: Do not unload MMU roots when only toggling
>> CR0.WP with TDP enabled").  Both commits fix scenarios where KVM will
>> rebuild all TDP MMU page tables in paths that are frequently hit by
>> certain guest workloads.  While not exactly common, the guest workloads
>> are far from rare.  The fallout of rebuilding TDP MMU page tables can be
>> so severe in some cases that it induces soft lockups in the guest.
>>
>> Commit edbdb43fc96b would require _significant_ effort and churn to
>> backport due it depending on a major rework that was done in v5.18.
>>
>> Commit 01b31714bd90 has far fewer direct conflicts, but has several subtle
>> _known_ dependencies, and it's unclear whether or not there are more
>> unknown dependencies that have been missed.
>>
>> Lastly, disabling the TDP MMU in v5.15 kernels also fixes a lurking train
>> wreck started by upstream commit a955cad84cda ("KVM: x86/mmu: Retry page
>> fault if root is invalidated by memslot update").  That commit was tagged
>> for stable to fix a memory leak, but didn't cherry-pick cleanly and was
>> never backported to v5.15.  Which is extremely fortunate, as it introduced
>> not one but two bugs, one of which was fixed by upstream commit
>> 18c841e1f411 ("KVM: x86: Retry page fault if MMU reload is pending and
>> root has no sp"), while the other was unknowingly fixed by upstream
>> commit ba6e3fe25543 ("KVM: x86/mmu: Grab mmu_invalidate_seq in
>> kvm_faultin_pfn()") in v6.3 (a one-off fix will be made for v6.1 kernels,
>> which did receive a backport for a955cad84cda).  Disabling the TDP MMU
>> by default reduces the probability of breaking v5.15 kernels by
>> backporting only a subset of the fixes.
>>
>> As far as what is lost by disabling the TDP MMU, the main selling point of
>> the TDP MMU is its ability to service page fault VM-Exits in parallel,
>> i.e. the main benefactors of the TDP MMU are deployments of large VMs
>> (hundreds of vCPUs), and in particular delployments that live-migrate such
>> VMs and thus need to fault-in huge amounts of memory on many vCPUs after
>> restarting the VM after migration.
>>
>> Smaller VMs can see performance improvements, but nowhere enough to make
>> up for the TDP MMU (in v5.15) absolutely cratering performance for some
>> workloads.  And practically speaking, anyone that is deploying and
>> migrating VMs with hundreds of vCPUs is likely rolling their own kernel,
>> not using a stock v5.15 series kernel.
>>
>> This reverts commit 71ba3f3189c78f756a659568fb473600fd78f207.
>>
>> Link: https://lore.kernel.org/all/ZDmEGM+CgYpvDLh6@google.com
>> Link: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@gameservers.com
>> Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> Cc: Mathias Krause <minipli@grsecurity.net>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
>> index 6c2bb60ccd88..7a64fb238044 100644
>> --- a/arch/x86/kvm/mmu/tdp_mmu.c
>> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
>> @@ -10,7 +10,7 @@
>>  #include <asm/cmpxchg.h>
>>  #include <trace/events/kvm.h>
>>  
>> -static bool __read_mostly tdp_mmu_enabled = true;
>> +static bool __read_mostly tdp_mmu_enabled = false;
>>  module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
>>  
>>  /* Initializes the TDP MMU for the VM, if enabled. */
>>
>> base-commit: f6f7927ac664ba23447f8dd3c3dfe2f4ee39272f
>> -- 
>> 2.42.0.rc2.253.gd59a3bf2b4-goog
>>

Thanks, I've been meaning to poke you about this again but things got in the way.
Have my ack:

Acked-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
