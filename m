Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D047A8FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjITWyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjITWyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:54:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2DFAB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695250466; x=1726786466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rsUGUNTImlteVNQfnPuQwMwdTYicAuHzhtIdJ1lBzd4=;
  b=Xe+nLhIPxojw75rWP1oaddCNRt6CNrLxtkJVclcLfrpW2/j7mH69t4+d
   gnj26cD0PtjuoPQa84nmzZwgrzwE7NEZcenxK+jKg3seMlJYosO5A/j9+
   2b46+vV1NPvfAIqIhEh63a5vJVL6Ig/p+ixlo9h01TTm5kvx6U+PJJ832
   tXYQJcPQGYeH8CZn3ImFtjSxgn4wB/EGJKPEpbRv+EWxAKwykmOsUtk3c
   7d/ko1BOEGJdcRZ/l7zvWsRpHK/T29N5HZL9ILoqfL5DOCXjJdy8wRuIs
   hjwVXQhToqTbYzW0ZVGpwgWG2rtTzeNs8RGFQ3VvVL4F20CLvA/twFxJS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="380273940"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="380273940"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 15:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870556288"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870556288"
Received: from sindhu5-mobl1.amr.corp.intel.com (HELO [10.209.4.149]) ([10.209.4.149])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 15:54:14 -0700
Message-ID: <519a5116-a48a-61f9-9a93-d30d21eb7e75@intel.com>
Date:   Wed, 20 Sep 2023 15:54:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] x86/sev-es: Allow copy_from_kernel_nofault in
 earlier boot
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
        David Rientjes <rientjes@google.com>,
        Khalid ElMously <khalid.elmously@canonical.com>,
        Jacob Xu <jacobhxu@google.com>
References: <20230912002703.3924521-1-acdunlap@google.com>
 <20230912002703.3924521-2-acdunlap@google.com> <ZQtYFAA9vD7gJM1t@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZQtYFAA9vD7gJM1t@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 13:37, Sean Christopherson wrote:
> On Mon, Sep 11, 2023, Adam Dunlap wrote:
>> Previously, if copy_from_kernel_nofault was called before
>> boot_cpu_data.x86_virt_bits was set up, then it would trigger undefined
>> behavior due to a shift by 64. This ended up causing boot failures in
>> the latest version of ubuntu2204 in the gcp project when using SEV-SNP.
>> Specifically, this function is called during an early #VC handler which
>> is triggered by a cpuid to check if nx is implemented.
> Why not stuff boot_cpu_data.x86_virt_bits to a "default" value that is guaranteed
> to be accurate (or at least safe) for the purposes of the early boot code.  I.e.
> set it to 48 for 64-bit kernels.
> 
> That'd avoid the extra conditional, and would avoid laying whack-a-mole with
> anything else that consumes x86_virt_bits.

I'd be worried that could break things even more subtly.

If we're truly worried about whack-a-mole, we should stick
'x86_virt_bits' in a wrapper, whine if it's accessed inadvertently, and
*then* return some mostly sane data.

That way we can actually go look at the caller and see what the heck
it's doing.

I did poke around and managed to convince myself that this site _is_ the
only one at the moment.

