Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C327E6EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbjKIQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjKIQfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:35:47 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9D0435AC;
        Thu,  9 Nov 2023 08:35:44 -0800 (PST)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id CFE6220B74C0;
        Thu,  9 Nov 2023 08:35:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFE6220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699547744;
        bh=Xb4zVDtxtGdwPAnhyMCxbu916b6ZbtJVbUTOWrLT7jo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P5g32T/iCUi+XzdE2yIB7+Vk+y1jkYXsQZYnJOFUhNKHROzXMtOx3p0JqrFmtn6mQ
         JfDkvj2ken97iBJ+MYvWg//v0Pz6tJec3nkjhMcL2NGjcEkHKys7LtbYpJUVnG8uCD
         qoGG9PQzDqf1fZte+HO/oSu9w2O9G32v1HQEjhMU=
Message-ID: <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
Date:   Thu, 9 Nov 2023 17:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
        tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
        cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, kirill.shutemov@linux.intel.com,
        sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 17:25, Dave Hansen wrote:
> On 11/9/23 08:14, Jeremi Piotrowski wrote:
> ...
>>  	pr_info("Memory Encryption Features active:");
>>  
>> -	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>> +	if (cc_vendor == CC_VENDOR_INTEL) {
>>  		pr_cont(" Intel TDX\n");
>>  		return;
>>  	}
> 
> Why aren't these guests setting X86_FEATURE_TDX_GUEST?

They could if we can confirm that the code gated behind
cpu_feature_enabled(X86_FEATURE_TDX_GUEST) is correct when running with TD partitioning.

It still makes sense to have these prints based on the cc_xxx abstractions.

Jeremi
