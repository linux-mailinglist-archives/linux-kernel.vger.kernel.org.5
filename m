Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378A803E14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbjLDTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjLDTHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:07:42 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78497D5;
        Mon,  4 Dec 2023 11:07:48 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0451C20B74C0;
        Mon,  4 Dec 2023 11:07:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0451C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701716867;
        bh=DhialEwGNDg3mrw6IMaHyyz1UwnTPP9nz7f6+UkxtYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hc1WA4TBrCB1KkvAbyYjJyBppPtRTRbsfBKpT419aWpy2ztkcPxAb/s6f2G+exsrM
         Rra8BHMT2mlyE8abLbGIfD6tyWJEGywaPkcO1Wd2sC6gI6QxTOQq6/xq0vRw9wuGCe
         cqn9Wyx22UN4A4vtLznpkQS6Qe4uCaEiPin01ypA=
Message-ID: <9ab71fee-be9f-4afc-8098-ad9d6b667d46@linux.microsoft.com>
Date:   Mon, 4 Dec 2023 20:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Content-Language: en-US
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
        "cascardo@canonical.com" <cascardo@canonical.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <DM8PR11MB575090573031AD9888D4738AE786A@DM8PR11MB5750.namprd11.prod.outlook.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <DM8PR11MB575090573031AD9888D4738AE786A@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 10:17, Reshetova, Elena wrote:
>> Check for additional CPUID bits to identify TDX guests running with Trust
>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
>>
>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is
>> visible
>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
>> aware mechanisms for what's left. So currently such guests do not have
>> X86_FEATURE_TDX_GUEST set.
> 
> Back to this concrete patch. Why cannot L1 VMM emulate the correct value of
> the TDX_CPUID_LEAF_ID to L2 VM? It can do this per TDX partitioning arch.
> How do you handle this and other CPUID calls call currently in L1? Per spec,
> all CPUIDs calls from L2 will cause L2 --> L1 exit, so what do you do in L1?
The disclaimer here is that I don't have access to the paravisor (L1) code. But
to the best of my knowledge the L1 handles CPUID calls by calling into the TDX
module, or synthesizing a response itself. TDX_CPUID_LEAF_ID is not provided to
the L2 guest in order to discriminate a guest that is solely responsible for every
TDX mechanism (running at L1) from one running at L2 that has to cooperate with L1.
More below.

> 
> Given that you do that simple emulation, you already end up with TDX guest
> code being activated. Next you can check what features you wont be able to
> provide in L1 and create simple emulation calls for the TDG calls that must be
> supported and cannot return error. The biggest TDG call (TDVMCALL) is already
> direct call into L0 VMM, so this part doesn’t require L1 VMM support. 

I don't see anything in the TD-partitioning spec that gives the TDX guest a way
to detect if it's running at L2 or L1, or check whether TDVMCALLs go to L0/L1.
So in any case this requires an extra cpuid call to establish the environment.
Given that, exposing TDX_CPUID_LEAF_ID to the guest doesn't help.

I'll give some examples of where the idea of emulating a TDX environment
without attempting L1-L2 cooperation breaks down.

hlt: if the guest issues a hlt TDVMCALL it goes to L0, but if it issues a classic hlt
it traps to L1. The hlt should definitely go to L1 so that L1 has a chance to do
housekeeping.

map gpa: say the guest uses MAP_GPA TDVMCALL. This goes to L0, not L1 which is the actual
entity that needs to have a say in performing the conversion. L1 can't act on the request
if L0 would forward it because of the CoCo threat model. So L1 and L2 get out of sync.
The only safe approach is for L2 to use a different mechanism to trap to L1 explicitly.

Having a paravisor is required to support a TPM and having TDVMCALLs go to L0 is
required to make performance viable for real workloads.

> 
> Until we really see what breaks with this approach, I don’t think it is worth to
> take in the complexity to support different L1 hypervisors view on partitioning.
> 

I'm not asking to support different L1 hypervisors view on partitioning, I want to
clean up the code (by fixing assumptions that no longer hold) for the model that I'm
describing that: the kernel already supports, has an implementation that works and
has actual users. This is also a model that Intel intentionally created the TD-partitioning
spec to support.

So lets work together to make X86_FEATURE_TDX_GUEST match reality.

Best regards,
Jeremi

> Best Regards,
> Elena.
> 
> 

