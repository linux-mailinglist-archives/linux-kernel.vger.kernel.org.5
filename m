Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9137F70AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjKXKAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:00:40 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 560891AB;
        Fri, 24 Nov 2023 02:00:46 -0800 (PST)
Received: from [192.168.1.150] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9844C20B74C0;
        Fri, 24 Nov 2023 02:00:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9844C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700820045;
        bh=TeRTeq8Ab0NebTdEjigLF0N3D06Mm51J5Eb7h9xqKQI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jO7vNFx2Waub77EPXbAmhsNTXDyhvYWhqOAPtHY+m3ubeSojbzit0I9PjznVQq7GW
         ke26RpAECLS423AmH3ggOuh0kgd5DCthbDjP8LcwyjRFOycoknBLZzrR01KeztWxP4
         qCOt6plQL8At7N1nDKogqCrmysq8fAmreYQ/x8G0=
Message-ID: <281e1f13-811b-4897-b3d9-18d233af25f7@linux.microsoft.com>
Date:   Fri, 24 Nov 2023 11:00:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] x86/tdx: Provide stub tdx_accept_memory() for
 non-TDX configs
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
 <20231122170106.270266-3-jpiotrowski@linux.microsoft.com>
 <20231123141113.l3kwputphhj3hxub@box.shutemov.name>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231123141113.l3kwputphhj3hxub@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 15:11, Kirill A. Shutemov wrote:
> On Wed, Nov 22, 2023 at 06:01:06PM +0100, Jeremi Piotrowski wrote:
>> When CONFIG_INTEL_TDX_GUEST is not defined but CONFIG_UNACCEPTED_MEMORY=y is,
>> the kernel fails to link with an undefined reference to tdx_accept_memory from
>> arch_accept_memory. Provide a stub for tdx_accept_memory to fix the build for
>> that configuration.
>>
>> CONFIG_UNACCEPTED_MEMORY is also selected by CONFIG_AMD_MEM_ENCRYPT, and there
>> are stubs for snp_accept_memory for when it is not defined. Previously this did
>> not result in an error when CONFIG_INTEL_TDX_GUEST was not defined because the
>> branch that references tdx_accept_memory() was being discarded due to
>> DISABLE_TDX_GUEST being set.
> 
> And who unsets it now?
> 

Who unsets what now? DISABLE_TDX_GUEST still works the same as before, but patch 2
changed the check in arch_accept_memory() to be more specific
(cc_platform_has(CC_ATTR_TDX_MODULE_CALLS)). The stub should have been there all
along for CONFIG_AMD_MEM_ENCRPYT=y && CONFIG_INTEL_TDX_GUEST=n configs, but it
happened to work without it.
