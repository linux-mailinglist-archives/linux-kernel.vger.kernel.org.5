Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C685E77D4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbjHOVQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbjHOVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:15:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812CEE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692134155; x=1723670155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y+0sxdAXFvj4xFDvWfTnVWq1b4OLI3F8WYzL9idS8Bc=;
  b=FRTpmdAMo9DMHHa+NKqQJEeLt5/IKi2y62J5FBIhzRX9So5+3uuR32dl
   HMk/T78lhxmVau/yzDmzZISyPRnUeP9+HxegMCr003YxV1fjh2eOjdK7H
   1JQ5B+vbIY5K4ci78U22OlYJyaKOyP4UlAPlFJocazaQYhvxQdMwQoM/L
   gkHNYZFQfAkOZQN6aPD14G4X0E0TpI/gg9HJdxeOjXaIEoMxJpiPTEr42
   UaXWkfmDpPPYeJHCza/p3XRogTkbno9IdGbtZU05VWnzFxBrq4FdS6vr5
   IloxH9Avw7/7EZcHN5uTs9DmQbh1gSyYy3Ba/9QHt+LR+Rnr1auSAa6v1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357359663"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="357359663"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799321533"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="799321533"
Received: from zhenkuny-mobl.amr.corp.intel.com (HELO [10.209.39.170]) ([10.209.39.170])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:15:54 -0700
Message-ID: <3b9518f5-8b92-1c24-286c-47bf9e8b8a2e@intel.com>
Date:   Tue, 15 Aug 2023 14:15:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V4 02/41] cpu/SMT: Make SMT control more robust against
 enumeration failures
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085112.149440843@linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230814085112.149440843@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 01:53, Thomas Gleixner wrote:
> -static inline bool cpu_smt_allowed(unsigned int cpu)
> +static inline bool cpu_bootable(unsigned int cpu)
>  {
>  	if (cpu_smt_control == CPU_SMT_ENABLED)
>  		return true;
>  
> +	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
> +		return true;

I found this new pair of if()'s rather counterintuitive to read.

The first one reads like:

	"If SMT is not supported, the CPU is always bootable"

but "supported" could easily mean CONFIG_SMP==n (which is actually
covered in the next case).  Would this be better named:

	CPU_SMT_NOT_ENUMERATED
or
	CPU_SMT_NOT_DETECTED

?

	/* Every CPU is bootable on non-SMT systems: */
	if (cpu_smt_control == CPU_SMT_NOT_DETECTED)
		return true;

For the next one:

> +	if (cpu_smt_control == CPU_SMT_NOT_IMPLEMENTED)
> +		return true;

This reads a bit like "SMT is not implemented" rather than "SMT controls
are not implemented".  Maybe a comment would help:

	/* All CPUs are bootable if controls are not implemented: */
