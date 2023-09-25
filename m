Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5957ADCF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjIYQU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjIYQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:20:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B952B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695658849; x=1727194849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Yf7IcjRJVtzW/bXfGeBPr9SsluJ6EaaPaNr8xdAnOcQ=;
  b=P9Ud3M5PX4tWZVOhrX96nlHP0RRdKeS648Imq6zkrb4bksAaF9y/uQyX
   1NhzTG9Vpmj1G3hjGu2eWfosNtAMwH8JOiLYc8uU9hLulkG3mPUYSTRVf
   lbxko1/jRGlXLmjo09vmbrnywuA8WJLV6J33Cm7UE7SKF7ZiynA6hii7e
   3ObL7OZ6UWgZNZazVflYV4Kzjm+KuVnykIDe2RdYmN20aMtaqQZHvic9n
   AkzMJU4XcjfmhckBJzM+XmZHn+aRzZlFGnt+WghOxhbGXDNOKTtplXH07
   /Ctq+O6uzSw2VCkndzC2KPhP394+1krK4BA8/Op2cZf6wjqwqXe2xbER5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378576643"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378576643"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 09:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838610701"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="838610701"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 09:20:39 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     arjan@linux.intel.com, ashok.raj@intel.com, bp@alien8.de,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch V3 30/30] x86/microcode/intel: Add a minimum required revision for late-loads
Date:   Tue, 26 Sep 2023 00:20:32 +0800
Message-Id: <20230925162032.56408-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912065502.631634574@linutronix.de>
References: <20230912065502.631634574@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> From: Ashok Raj <ashok.raj@intel.com>
> 
> In general users don't have the necessary information to determine whether
> late loading of a new microcode version is safe and does not modify
> anything which the currently running kernel uses already, e.g. removal of
> CPUID bits or behavioural changes of MSRs.
> ...
> 
> The check is always enabled, but by default not enforced. It can be
> enforced via Kconfig or kernel command line.
> 
> If enforced, the kernel refuses to late load microcode with a minium

s/minium/minimum/

> required version field which is zero or when the currently loaded microcode
> revision is smaller than the minimum required revision.
> 
> ...
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -463,16 +463,40 @@ static enum ucode_state apply_microcode_
>  	return ret;
>  }
>  
> +static bool ucode_validate_minrev(struct microcode_header_intel *mc_header)
> +{
> +	int cur_rev = boot_cpu_data.microcode;
> +
> +	/*
> +	 * When late-loading, ensure the header declares a minimum revision
> +	 * required to perform a late-load. The previously reserved field
> +	 * is 0 in older microcode blobs.
> +	 */
> +	if (!mc_header->min_req_ver) {
> +		pr_info("Unsafe microcode update: Microcode header does not specify a required min version\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Check whether the minimum revision specified in the header is either
> +	 * greater or equal to the current revision.
> +	 */

Seems like the above comment doesn't match the following 'if' check.
Perhaps the comment is:

   "Check whether the current revision is either greater or
    equal to the minimum revision specified in the header."

> +	if (cur_rev < mc_header->min_req_ver) {
> +		pr_info("Unsafe microcode update: Current revision 0x%x too old\n", cur_rev);
> +		pr_info("Current should be at 0x%x or higher. Use early loading instead\n", mc_header->min_req_ver);
> +		return false;
> +	}
> +	return true;
> +}
> ...
