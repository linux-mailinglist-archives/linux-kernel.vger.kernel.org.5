Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCF7F60E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbjKWN6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbjKWN6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:58:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB5B9;
        Thu, 23 Nov 2023 05:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700747938; x=1732283938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gsKhARH6M+Qxpmd1HDVzRLZJSN3VSTi/EeytQHXYsVE=;
  b=C8tDDYT1c1CuwCEi6mkL2+qaFs+n56aSpfAF/wbHgqzJG+yBhF2xCVr8
   c+TMoOijxUmPKgX+CZtoBKziwTvsG+qNJVe1U1/fpGr4gUQcqJ9njTF3P
   kpzjIqnPN+4vTfP1xerFudM6wD5GI+MLOCsb0e1y6rDqLdgwjBD/2UPsR
   nwkVj7livnGeUlxFii15QmlQ1oDIQUjVTzCIS7nHoD/IV1ekFao1lpO49
   K4DN2T06ghp09Q5AgNl8+cKKk+Pasg0IRgCa0w8N2okmsC+vkwYwcnHVB
   /FAz9fDGP0FVT8wyBe4V39rxYFPj+2ICin2JdRdO5jJWOkAzx77NFAYyX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="371622353"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="371622353"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 05:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911175812"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="911175812"
Received: from ckochhof-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.117])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 05:58:49 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9B24C10A38A; Thu, 23 Nov 2023 16:58:46 +0300 (+03)
Date:   Thu, 23 Nov 2023 16:58:46 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Message-ID: <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:01:04PM +0100, Jeremi Piotrowski wrote:
> Check for additional CPUID bits to identify TDX guests running with Trust
> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
> 
> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
> aware mechanisms for what's left. So currently such guests do not have
> X86_FEATURE_TDX_GUEST set.
> 
> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
> need to check these additional CPUID bits, but we skip further initialization
> in the function as we aren't guaranteed access to TDX module calls.

I don't follow. The idea of partitioning is that L2 OS can be
unenlightened and have no idea if it runs indide of TD. But this patch
tries to enumerate TDX anyway.

Why?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
