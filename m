Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3177DF02E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346950AbjKBKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346951AbjKBKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:33:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343A131;
        Thu,  2 Nov 2023 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698921193; x=1730457193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SLairH+CCw3ORzUP44W20Kvl7uWrU7IvwIG+cWwSFUk=;
  b=RKbSOMJxC2TrvtdhS/Yfl1oNg2f15wttoBePOvqXmMxWofZENsZCiGGV
   rJ/tMxl+IKcTdLD8KJZKy6V91mbQHABEVNWaNXvMc9htilgJHFFggGyg4
   p75SYfQnOqIQ1tnSoFxOUwvUH16t3ycZ0+AvMeGOuLkNluNe9s9siBdRy
   HeASXWmugcXAFTucPQf8dpho3iEro1MLpoUww5rWDzpmsspHqXbA9ErM+
   o4iVSoeUZThurbPOpSqaRgFCX515gma895xSb55cujnv2pwS0N7LU9FuY
   ubcVWzg6hMCtDnySp9kf2eQV7yjI5J5s5tVHqqKye7f9fwu3sYWC4+eHV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="379076149"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="379076149"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="934745072"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="934745072"
Received: from arajan-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.215.101])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:33:09 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2F0B4109AF7; Thu,  2 Nov 2023 13:33:06 +0300 (+03)
Date:   Thu, 2 Nov 2023 13:33:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, dionnaglaze@google.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com
Subject: Re: [PATCH v5 13/14] x86/tsc: Mark Secure TSC as reliable clocksource
Message-ID: <20231102103306.v7ydmrobd5ibs4yn@box.shutemov.name>
References: <20231030063652.68675-1-nikunj@amd.com>
 <20231030063652.68675-14-nikunj@amd.com>
 <57d63309-51cd-4138-889d-43fbdf5ec790@intel.com>
 <ae267e31-5722-4784-9146-28bb13ca7cf5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae267e31-5722-4784-9146-28bb13ca7cf5@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:23:34AM +0530, Nikunj A. Dadhania wrote:
> On 10/30/2023 10:48 PM, Dave Hansen wrote:
> > On 10/29/23 23:36, Nikunj A Dadhania wrote:
> > ...
> >> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> >> index 15f97c0abc9d..b0a8546d3703 100644
> >> --- a/arch/x86/kernel/tsc.c
> >> +++ b/arch/x86/kernel/tsc.c
> >> @@ -1241,7 +1241,7 @@ static void __init check_system_tsc_reliable(void)
> >>  			tsc_clocksource_reliable = 1;
> >>  	}
> >>  #endif
> >> -	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
> >> +	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE) || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
> >>  		tsc_clocksource_reliable = 1;
> > 
> > Why can't you just set X86_FEATURE_TSC_RELIABLE?
> 
> Last time when I tried, I had removed my kvmclock changes and I had set
> the X86_FEATURE_TSC_RELIABLE similar to Kirill's patch[1], this did not
> select the SecureTSC.
> 
> Let me try setting X86_FEATURE_TSC_RELIABLE and retaining my patch for
> skipping kvmclock.

kvmclock lowers its rating if TSC is good enough:

	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
	    !check_tsc_unstable())
		kvm_clock.rating = 299;

Does your TSC meet the requirements?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
