Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF17ADBF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjIYPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjIYPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:44:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6E10C8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695656643; x=1727192643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IsKAFDVkc6Yshx99cT54U4R8LdSEzrQJc7xqTqqxN3g=;
  b=eBkZJQ0x5WMb3pHzkvCZcV1eR1rI97OVxx8Ejzay4rc9FFaetBOWE7sw
   3PN+IbaOWYBQX32F0xIFYfgV8cuPqVQdHrHx/DoC9rrKtCJkdbcu5hH8C
   rYfrkE2AP4REJJGaOZmSyg6mrHd28kJCXiglvJ5grcokngMyZOM/ayUql
   CV4wTy9LtKSu9WxDCP02ZSA8AVgLcyiDjGU2Kb9Mh52XRu/r1TtePphkD
   I0g19nsIR0pb4wPDEp40a0tH3CpVzn54zELH+7+Y5MTszc5IVVi9K01XX
   Kj6hyd7dbgXqEsUGU2OvdzTo5gjD+c9V0JL3YXtFOYU0Y3zEN0iOX6Tiu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360664873"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="360664873"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818661690"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="818661690"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:43:39 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     arjan@linux.intel.com, bp@alien8.de, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com, x86@kernel.org,
        qiuxu.zhuo@intel.com
Subject: Re: Subject: [patch V3 09/30] x86/microcode/intel: Switch to kvmalloc()
Date:   Mon, 25 Sep 2023 23:43:33 +0800
Message-Id: <20230925154333.55668-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912065501.335403273@linutronix.de>
References: <20230912065501.335403273@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Microcode blobs are getting larger and might soon reach the kmalloc()
> limit. Switch over kvmalloc().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/cpu/microcode/intel.c |   50 +++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> ---
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> ... 
>  static void save_microcode_patch(struct microcode_intel *patch)
>  {
> -	struct microcode_intel *mc;
> +	unsigned int size = get_totalsize(&patch->hdr);
> +	struct microcode_intel *mc = NULL;

No need to initialize the 'mc' to NULL as it's unconditionally
set by the following kmemdup().

>  
> -	mc = kmemdup(patch, get_totalsize(&patch->hdr), GFP_KERNEL);
> +	mc = kvmemdup(patch, size, GFP_KERNEL);
>  	if (mc)
>  		update_ucode_pointer(mc);
> +	else
> +		pr_err("Unable to allocate microcode memory size: %u\n", size);
>  }
>  
> ...
