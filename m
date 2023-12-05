Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22352805BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbjLERQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjLERQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:16:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B48D41
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701796608; x=1733332608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+3ZqesXVy8GB3x255vfft0g1wTDCIpWjiLA4RZ264PA=;
  b=mtXNJbbxKreTXBsMeM8fJbFyGMORE/FQoNuKsJKtxTyeOpY7l1ijl5LD
   b44KWFrVifsvZk6+OrMBbvIYh+err3AHbmnv0qq7jyLfcQ9d17Pl+kWXH
   9MnFuVzBhiFRvsSnVlIjk2o3FBsOvSworH57s0OmLw/kgCgzeDleGT+lS
   bru/2t/2BycpIHQgKyBL/HDAfNlShIo3NbDIWTsSNbdY2yRoo8hfr12r6
   eW3dXEu+6lDZrZW5YkVxQJvKwiIG+2nWDr9pVZtOUXtyLYKCONDu6g5z7
   mSAozckzViYvY7+9Xrpgvzey4hUkI66tNwiECpycHgXILNkGDGgf+ZKS9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="425084809"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="425084809"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841544380"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="841544380"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.235])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:16:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7402310A43A; Tue,  5 Dec 2023 20:16:43 +0300 (+03)
Date:   Tue, 5 Dec 2023 20:16:43 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect
 SEV guest flavor
Message-ID: <20231205171643.zg7fwxjyccab53kf@box.shutemov.name>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
 <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
 <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
 <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
 <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:00:35PM +0100, Borislav Petkov wrote:
> On Tue, Dec 05, 2023 at 06:14:37PM +0300, Kirill A. Shutemov wrote:
> > My point is that if you need to check for SEV you need to check SEV, not
> > CC_ATTR. CC_ATTRs only make sense in generic code that deals with multiple
> > CoCo environments.
> 
> That makes more sense.
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

What's wrong with using X86_FEATURE_* here?

X86_FEATURE_SEV_GUEST is set for all SEVs. X86_FEATURE_SEV_ES_GUEST and
X86_FEATURE_SEV_SNP_GUEST can be used to test specific flavor.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
