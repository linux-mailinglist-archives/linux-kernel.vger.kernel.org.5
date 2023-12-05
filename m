Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D63805B53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjLEPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346031AbjLEPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:14:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2577BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701789282; x=1733325282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rWhM9A7WpcEtY4eQ9VQUlvS9vCQ5mG2Y67yAqwJoeew=;
  b=nVF77N2II/LlA0hM5lZxCR8Ej0cK5Nq79YC9EFjeOKL2ZQRN7Yo3QJIv
   LCHNAcezV+W464ZI0LgUp5EUMKMhKsy2k3y/btAlgS3PUSUQ6b6fpjOMt
   EjzFmN/ieY/RWCJVR427xAoZGOL9+VhmlMhofq2VlgLiWI3jI94PinRHn
   M4c/F4XXcKJBFNk8P0Nj1cl18x5JE6P9oXfQOGBf2ywdHq3R0n9IwKPQ6
   94HQGhtlaOFOboOMXCBXvScPPJF9jFIU7TXMBf/mlmwaMuajGNrcOxZIk
   UURGBkA1Nau0mNdcZIpK17vfVCepZ8n+t2Z908nikADCtY2AH4P112H2g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="460393561"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="460393561"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774661313"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="774661313"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:14:39 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1EAE910A43A; Tue,  5 Dec 2023 18:14:37 +0300 (+03)
Date:   Tue, 5 Dec 2023 18:14:37 +0300
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
Message-ID: <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
 <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
 <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 04:06:48PM +0100, Borislav Petkov wrote:
> On Tue, Dec 05, 2023 at 06:00:12PM +0300, Kirill A. Shutemov wrote:
> > I don't think cc_platform_has() is the right check. On TDX side we use
> > X86_FEATURE_TDX_GUEST for this and it works better than stretching
> > CC_ATTRs beyond their meaning.
> 
> You don't think it is the right check because you do something else on
> Intel?
> 
> I can't follow that argument.

My point is that if you need to check for SEV you need to check SEV, not
CC_ATTR. CC_ATTRs only make sense in generic code that deals with multiple
CoCo environments.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
