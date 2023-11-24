Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D47F7261
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjKXLFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjKXLE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:04:56 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5564D6E;
        Fri, 24 Nov 2023 03:05:02 -0800 (PST)
Received: from [192.168.1.150] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3571420B74C0;
        Fri, 24 Nov 2023 03:04:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3571420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700823902;
        bh=7jaZ0scpk4NByvTCBB0IHW+wWWfI9aApWVslFKRIx8s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nXqb+Bzu6O/7N3ZWRXOm99TsvtglFjoQqN8btxWl2cQbPDnKJ9cZzWM7WP7FHqaoT
         k88jeDK15/O683dzQsHAukzlISzzRMID+4EIwy7BaWmKrJ+F+3EoTZrXSwEEWi3mjh
         Up+Dq/LtF41FV+wluqOVtVWxCr9o5lgV1AbxcJe8=
Message-ID: <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
Date:   Fri, 24 Nov 2023 12:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org, stable@vger.kernel.org
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 11:43, Kirill A. Shutemov wrote:
> On Fri, Nov 24, 2023 at 11:31:44AM +0100, Jeremi Piotrowski wrote:
>> On 23/11/2023 14:58, Kirill A. Shutemov wrote:
>>> On Wed, Nov 22, 2023 at 06:01:04PM +0100, Jeremi Piotrowski wrote:
>>>> Check for additional CPUID bits to identify TDX guests running with Trust
>>>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
>>>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
>>>>
>>>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
>>>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
>>>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
>>>> aware mechanisms for what's left. So currently such guests do not have
>>>> X86_FEATURE_TDX_GUEST set.
>>>>
>>>> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
>>>> need to check these additional CPUID bits, but we skip further initialization
>>>> in the function as we aren't guaranteed access to TDX module calls.
>>>
>>> I don't follow. The idea of partitioning is that L2 OS can be
>>> unenlightened and have no idea if it runs indide of TD. But this patch
>>> tries to enumerate TDX anyway.
>>>
>>> Why?
>>>
>>
>> That's not the only idea of partitioning. Partitioning provides different privilege
>> levels within the TD, and unenlightened L2 OS can be made to work but are inefficient.
>> In our case Linux always runs enlightened (both with and without TD partitioning), and
>> uses TDX functionality where applicable (TDX vmcalls, PTE encryption bit).
> 
> What value L1 adds in this case? If L2 has to be enlightened just run the
> enlightened OS directly as L1 and ditch half-measures. I think you can
> gain some performance this way.
> 

It's primarily about the privilege separation, performance is a reason
one doesn't want to run unenlightened. The L1 makes the following possible:
- TPM emulation within the trust domain but isolated from the OS
- infrastructure interfaces for things like VM live migration
- support for Virtual Trust Levels[1], Virtual Secure Mode[2]

These provide a lot of value to users, it's not at all about half-measures.

[1]: https://lore.kernel.org/lkml/1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com/
[2]: https://lore.kernel.org/lkml/20231108111806.92604-1-nsaenz@amazon.com/

