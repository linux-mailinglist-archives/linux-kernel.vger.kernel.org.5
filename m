Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB437CEC33
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJRXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRXjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:39:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A5113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697672393; x=1729208393;
  h=from:to:cc:subject:references:date:message-id:
   mime-version;
  bh=xgFWl2rXb/I69jDXli1dPyeDD7q/ghfCKAfw9VyTEzE=;
  b=NGzBFJjghWJRoshqLDmw9PTbpNVUkgUhEFx0qDoGGzvPeV076VHvE5Qb
   EWchZrirrARRty/YjPp+qDk7rjOib6w/K+mwlyywzNoof1PGG6wJzMVPG
   DnG3QV42gbHCMS1ayX5I7ivvaR9veP3hKEjBzBn6d1cGiZnPUcmTOyq6u
   NOwDRQuTxAVnSik0+Ie5p8Y5iQ+Spn/8f47bWy6f11mqinZQDndHYJSg6
   MR+wqo5Ma2MpNvf7EbeZsEaWrJyJ8x/A2dn80q8stfkrQxVY2DrdFLUoG
   qGnVV2GagCwhM5LSaaDT3vgxkku1CdwioqE13uvm4XmcdVQyN5uAC5FA0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452609747"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452609747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004005377"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="1004005377"
Received: from minhjohn-mobl.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.43.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:39:52 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, kirill.shutemov@linux.intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Felix Held <felix-coreboot@felixheld.de>
Subject: Re: Reserved bits and commit x86/sev-es: Set x86_virt_bits to the
 correct value straight away, instead of a two-phase approach
References: <87r0lry3bs.fsf@jcompost-mobl.amr.corp.intel.com>
        <CAMBK9=ZAzKyxuxdsDXNeA8xyPufwFoMxJaHwuh-z+eOmrGD1qQ@mail.gmail.com>
Date:   Wed, 18 Oct 2023 16:39:52 -0700
Message-ID: <87fs27xzxz.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
        CA 95052. USA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adam Dunlap <acdunlap@google.com> writes:

> On Wed, Oct 18, 2023 at 3:27=E2=80=AFPM Compostella, Jeremy
> <jeremy.compostella@intel.com> wrote:
>> In the light of commit fbf6449f84bf I am wondering what is the right
>> approach to fix the regression for AMD and then fix the MTRR check for
>> Intel. Should we introduce a new cpu_dev callback to read the number
>> of reserved bits and take it into account in get_cpu_address_sizes() ?
>
> I think this approach makes sense. It seems better to have one
> function that simply sets it to the right thing rather than setting
> it to one value and then adjusting it (fbf6449f84bf did that for
> x86_virt_bits, although it caused some other problems). However, I'm
> not sure it would solve the problem your original patch tried to
> fix, since x86_phys_bits would still be set after intel_init, which
> apparently uses the value.

Using cscope, I don't see any evidence of any vendor init code using
`x86_phys_bits'. To my knowledge, they seem to be only setting
x86_phys_bits or adjusting it.


> Would it work to move the call to get_cpu_address_sizes() to nearer
> the start of early_identify_cpu()?  We could also add a cpu_dev
> callback so it doesn't need the 2-phase approach, but this would at
> least bring it back into parity with v6.6-rc6.

Such a change should resolve the issue I reported on this thread. I
can run a quick smoke test later tonight or tomorrow.

> Ex (untested):
>
> ---
>  arch/x86/kernel/cpu/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index bcd3b2df83bb..cdbe8241e250 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1592,6 +1592,8 @@ static void __init early_identify_cpu(struct
> cpuinfo_x86 *c)
>   if (!have_cpuid_p())
>   identify_cpu_without_cpuid(c);
>
> + get_cpu_address_sizes(c);
> +
>   /* cyrix could have cpuid enabled via c_identify()*/
>   if (have_cpuid_p()) {
>   cpu_detect(c);
> @@ -1612,8 +1614,6 @@ static void __init early_identify_cpu(struct
> cpuinfo_x86 *c)
>   setup_clear_cpu_cap(X86_FEATURE_CPUID);
>   }
>
> - get_cpu_address_sizes(c);
> -
>   setup_force_cpu_cap(X86_FEATURE_ALWAYS);
>
>   cpu_set_bug_bits(c);

--=-=-=--
