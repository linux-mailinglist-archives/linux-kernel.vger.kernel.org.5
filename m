Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F89805BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjLER1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbjLER1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:27:48 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A161BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:27:54 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
        by linux.microsoft.com (Postfix) with ESMTPSA id 16D9520B74C0;
        Tue,  5 Dec 2023 09:27:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16D9520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701797273;
        bh=R4EPJuqe1SbTGVkqEXJdX4TmDi8/mFk2BAKrvXRHNG8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XoNJqJ0cK69JkasM3Je2NOzz4cni22BY8X4jQjuB/1+6qUC9XgVkQpRx3ZUnIckjL
         4YZTISmOLxBed5Hal2ZpVzfLfbFQT0KaMjAPFnGpoZ2Ubw+YY6uiRfdxqvwK1tJUtJ
         TrebrHoCG++xDJVyixfpKcLH1lCfPbsbarCFP/kg=
Message-ID: <ae9e37c2-3f50-4098-9b0e-771d10262c6b@linux.microsoft.com>
Date:   Tue, 5 Dec 2023 18:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect
 SEV guest flavor
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
 <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
 <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
 <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
 <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
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

On 05/12/2023 17:00, Borislav Petkov wrote:
> On Tue, Dec 05, 2023 at 06:14:37PM +0300, Kirill A. Shutemov wrote:
>> My point is that if you need to check for SEV you need to check SEV, not
>> CC_ATTR. CC_ATTRs only make sense in generic code that deals with multiple
>> CoCo environments.
> 
> That makes more sense.

So given this series, what is the canonical way to expose sub-features of
TDX/SNP going forward? X86_FEATURE_xxx for every one that needs to be queried
in TDX/SNP specific code?

I see that in [1] X86_FEATURE_SNP_SECURE_TSC is being proposed. How about the
CC_ATTR_TDX_MODULE_CALLS (perhaps better called TDX_TDCALL or something) that
I'm proposing in the other thread [2]? VTOM? SVSM?

We can also export amd_cc_platform_has() and intel_cc_platform_has() for such cases.
But we really need is to agree which to use when (X86_FEATURE vs CC_ATTR).

[1]: https://lore.kernel.org/lkml/20231128125959.1810039-10-nikunj@amd.com/
[2]: https://lore.kernel.org/lkml/20231122170106.270266-2-jpiotrowski@linux.microsoft.com/

Jeremi

> 
> So that commit already says "If future support is added for other
> memory encryption technologies, the use of CC_ATTR_GUEST_MEM_ENCRYPT
> can be updated, as required."
> 
> And what this test needs to do is to check:
> 
> 	if (guest type >= SEV)
> 
> meaning SEV and -ES and -SNP.
> 
> I'm wondering if we should export amd_cc_platform_has() for such
> cases...
> 
> The logic being, we're calling a SEV-specific function so using
> cc_platform_has() in there is the wrong layer.
> 
> Tom?
> 

