Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C217BB9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjJFODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjJFODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:03:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A321B6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696600982; x=1728136982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ewD5kzNxcEnCXxH4YfAN7BLpYeNQYIs6YHElrCZx5sE=;
  b=nPM+EmMD3Wf9YFp9ozJRVueygp8Ag2B7+K306F7fg2OWgUxmE8OOmPQ5
   1G3LcE5/tcOSEN7ACpYc0XrJqQNkFtxKtevNzAGBTigLCtP3xw4I9mlua
   0hRNUY8DSpPhRqxUQYiHP0lR7VECodBI4VaA56RCoJgkUHF1P2oG2/Su4
   e2qBGfKrl7WqqHa4nWhue25EyFi2LY2SkaEVVYZFfuc64ohLkfe3PvgSe
   8pF0stqBdv4UXdWD9mHo4Qg2z1oKiTdT3hC8HKbsypRtZthMF2zXFJ1Wd
   IoqFjHZD0KA0VurqYCk9IIUb8+w7QJkBLC89lnR102mkK13IJwIv+Gv4l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368831335"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="368831335"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745873746"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745873746"
Received: from dhimanbh-mobl1.amr.corp.intel.com (HELO [10.209.88.92]) ([10.209.88.92])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:02:49 -0700
Message-ID: <2d952c6b-2357-208b-e816-bca19c2a7ca6@intel.com>
Date:   Fri, 6 Oct 2023 07:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
Content-Language: en-US
To:     Vishal Annapurve <vannapurve@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231006011255.4163884-1-vannapurve@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20231006011255.4163884-1-vannapurve@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 18:12, Vishal Annapurve wrote:
> +/**
> + * Determine TSC frequency via CPUID, else return 0.
> + */
> +static unsigned long tdx_calibrate_tsc(void)
> +{
> +	unsigned int eax_denominator = 0, ebx_numerator = 0, ecx_hz = 0, edx = 0;
> +	unsigned int crystal_khz;
> +
> +	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
> +	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
> +
> +	if (ebx_numerator == 0 || eax_denominator == 0)
> +		return 0;
> +
> +	crystal_khz = ecx_hz / 1000;
> +
> +	/*
> +	 * TSC frequency reported directly by CPUID is a "hardware reported"
> +	 * frequency and is the most accurate one so far we have. This
> +	 * is considered a known frequency.
> +	 */
> +	if (crystal_khz != 0)
> +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +
> +	return crystal_khz * ebx_numerator / eax_denominator;
> +}
> +

Would it be possible to do this by refactoring the existing code and
calling it directly instead of copying and pasting so much?
