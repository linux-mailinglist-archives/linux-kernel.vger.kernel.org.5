Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3E57D02EC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346543AbjJSUBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjJSUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:01:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC411F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697745679; x=1729281679;
  h=from:to:cc:subject:references:date:message-id:
   mime-version;
  bh=eTrNGgnGoiSbHPAIyEZREiSS1yun9wOTRVlg/YxilNE=;
  b=QwpVSNB1ZleT+k0vxBpp9QwkFvN295nsAZPlnfA1+d8tRv6+5ypwV3dl
   DdfTP3D0yLpWOdWZbNaRfTv3JjQUbae3hsTSBxjPxBdIZZvXbhBCSXuqQ
   sFyiw6xtNFVyH739DCXUjjAucdKDTTMc8uKPoBvZe6koSBjBfjrye/VDH
   Zb021Tn7+e8qG5OAW4M7NTjF2SSjMDk9dLM4c6HnNYEqKWIEVpsKF8RUP
   ylf7GxGJVPBMgnfb513UCM0+6M67yhie/1vcfqL5hP77II8254/v55VfH
   5SBfc04z1rLJvsUFUqJdsgmOPzhdp78Ru4SveRvES0jexXk+BxQmAgldu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="376734033"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="376734033"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="822963660"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="822963660"
Received: from driley-mobl2.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.86.49])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:01:17 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Felix Held <felix-coreboot@felixheld.de>
Subject: Re: Reserved bits and commit x86/sev-es: Set x86_virt_bits to the
 correct value straight away, instead of a two-phase approach
References: <87r0lry3bs.fsf@jcompost-mobl.amr.corp.intel.com>
        <CAMBK9=ZAzKyxuxdsDXNeA8xyPufwFoMxJaHwuh-z+eOmrGD1qQ@mail.gmail.com>
        <87fs27xzxz.fsf@jcompost-mobl.amr.corp.intel.com>
Date:   Thu, 19 Oct 2023 13:01:16 -0700
Message-ID: <87jzribcvn.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
        CA 95052. USA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"Compostella, Jeremy" <jeremy.compostella@intel.com> writes:

> Adam Dunlap <acdunlap@google.com> writes:
>
>> On Wed, Oct 18, 2023 at 3:27=E2=80=AFPM Compostella, Jeremy
>> <jeremy.compostella@intel.com> wrote:
>>> In the light of commit fbf6449f84bf I am wondering what is the right
>>> approach to fix the regression for AMD and then fix the MTRR check for
>>> Intel. Should we introduce a new cpu_dev callback to read the number
>>> of reserved bits and take it into account in get_cpu_address_sizes() ?
>>
>> I think this approach makes sense. It seems better to have one
>> function that simply sets it to the right thing rather than setting
>> it to one value and then adjusting it (fbf6449f84bf did that for
>> x86_virt_bits, although it caused some other problems). However, I'm
>> not sure it would solve the problem your original patch tried to
>> fix, since x86_phys_bits would still be set after intel_init, which
>> apparently uses the value.
>
> Using cscope, I don't see any evidence of any vendor init code using
> `x86_phys_bits'. To my knowledge, they seem to be only setting
> x86_phys_bits or adjusting it.
>
>
>> Would it work to move the call to get_cpu_address_sizes() to nearer
>> the start of early_identify_cpu()?  We could also add a cpu_dev
>> callback so it doesn't need the 2-phase approach, but this would at
>> least bring it back into parity with v6.6-rc6.
>
> Such a change should resolve the issue I reported on this thread. I
> can run a quick smoke test later tonight or tomorrow.

It turns out that your suggestion does not work because
`get_cpu_address_sizes()' relies on `c->extended_cpuid_level' (set by
`get_cpu_cap(c)') and the `X86_FEATURE_CPUID' cpu capability (set by
`setup_force_cpu_cap(X86_FEATURE_CPUID)').

The following change works perfectly well for me:

,----
| @@ -1589,6 +1591,7 @@ static void __init early_identify_cpu(struct cpuinf=
o_x86 *c)
| 		get_cpu_vendor(c);
| 		get_cpu_cap(c);
| 		setup_force_cpu_cap(X86_FEATURE_CPUID);
| +		get_cpu_address_sizes(c);
| 		cpu_parse_early_param();
|=20
| 		if (this_cpu->c_early_init)
| @@ -1603,7 +1606,6 @@ static void __init early_identify_cpu(struct cpuinf=
o_x86 *c)
| 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
| 	}
|=20
| -	get_cpu_address_sizes(c);
|=20
| 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
`----

Looking at fbf6449f84bf I am under the impression it should not hurt
it either but I'll let you verify.

--=20
*Jeremy*
/One Emacs to rule them all/

--=-=-=--
