Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA37E7EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjKJRqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjKJRpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:36 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11BD43B328;
        Fri, 10 Nov 2023 07:51:49 -0800 (PST)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id D14D220B74C0;
        Fri, 10 Nov 2023 07:51:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D14D220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699631508;
        bh=GUjVGqNVu7d4fvxVqt/6V3ZEo+hYIJHaOrVg7KkMyso=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XT+5CtK1/lHZ/9RzAt+v+Lnkte27rdQtrTdOScIhTjMKBDV+zw7iJQYaiqjjcHz1Y
         1X7ik9coUml3O3Qb3efw6JDD+VpkiGwO+VTNgFDwP4kiG0JQOifmfZwVK08H+NFe3i
         yiC2bIfKu+qZbWagc9iKRmj4/72zgO+7HaLmIVFY=
Message-ID: <73b51be2-cc60-4818-bdba-14b33576366d@linux.microsoft.com>
Date:   Fri, 10 Nov 2023 16:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        kirill.shutemov@linux.intel.com, sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110131715.GAZU4tW2cJrGoLPmKl@fat_crate.local>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231110131715.GAZU4tW2cJrGoLPmKl@fat_crate.local>
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

On 10/11/2023 14:17, Borislav Petkov wrote:
> On Thu, Nov 09, 2023 at 07:41:33PM +0100, Jeremi Piotrowski wrote:
>> tdx_early_init() changes kernel behavior with the assumption that it
>> can talk directly to the TD module or change page visibility in
>> a certain way, instead of talking to a paravisor. So that CPUID is
>> hidden to prevent this.  Otherwise tdx_early_init() would need to be
>> modified to check "am I running with TD partitioning and if so
>> - switch to other implementations".
> 
> Here we go with the virt zoo again. If you hide TDX_CPUID_LEAF_ID from
> it, then it of course doesn't know that it is a TDX guest. This is the
> same thing as the SNP vTom thing: the only viable way going forward is
> for the guest kernel to detect correctly what it runs on and act
> accordingly.

That part already works correctly. The kernel knows very well that it is a
TDX guest because TD partitioning (same as SNP vTOM) support uses the standard
coco mechanisms to indicate that to the kernel. The kernel is well aware of
how to operate in this case: use bounce buffers, flip page visibility by calling
the correct hoosk, etc. Same flow as for every other flavor of confidential guest.

> 
> You can't just do some semi-correct tests for vendor - correct only
> if you squint hard enough - and hope that it works because it'll break
> apart eventually, when that second-level TDX fun needs to add more
> hackery to the guest kernel.
> 

What's semi-correct about checking for CC_VENDOR_INTEL and then printing Intel?
I can post a v2 that checks CC_ATTR_GUEST_MEM_ENCRYPT before printing "TDX".
Feature printing needs to evolve as new technologies come along.

> So, instead, think about how the paravisor tells the guest it is running
> on one - a special CPUID leaf or an MSR in the AMD case - and use that> to detect it properly.

The paravisor *is* telling the guest it is running on one - using a CPUID leaf
(HYPERV_CPUID_ISOLATION_CONFIG). A paravisor is a hypervisor for a confidential
guest, that's why paravisor detection shares logic with hypervisor detection.

tdx_early_init() runs extremely early, way before hypervisor(/paravisor) detection.
If the TDX_CPUID_LEAF_ID leaf were present it would require duplicating hypervisor/paravisor
logic in that function (and in sme_early_init()). As soon as we'd detect the
paravisor we'd need to avoid performing tdx_module_calls() (because they're not
allowed) so the function would return without doing anything useful:

void __init tdx_early_init(void)
{
        u64 cc_mask;
        u32 eax, sig[3];

        cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);

        if (memcmp(TDX_IDENT, sig, sizeof(sig)))
                return;

        setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);

        cc_vendor = CC_VENDOR_INTEL;

        /* Can't perform tdx_module_calls when a paravisor is present */
        if (early_detect_paravisor())
                goto exit;

        ....
exit:
        pr_info("Guest detected\n");
}

Additionally we'd need to sprinkle paravisor checks along with existing X86_FEATURE_TDX_GUEST
checks. And any time someone adds a new feature that depends solely on X86_FEATURE_TDX_GUEST
we'd run the chance of it breaking things.

That would be a mess.

Jeremi


> 
> Everything else is a mess waiting to happen.
> 
> Thx.
> 


