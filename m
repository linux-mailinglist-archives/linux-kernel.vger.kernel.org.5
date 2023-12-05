Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46E805B66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442298AbjLEPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbjLEPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:00:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFDAA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701788418; x=1733324418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MnPLBQgc9Jr4eHHjTeEgqwSFgYc46mDEnA2okGxhpj0=;
  b=av5WQ51aDaGvlHviOFgzNviTxUMNRFEDwQliR1sOfCvcnIVBMlaN26gB
   R0Y8yLRLcStU0sgLhlAA+J8jtMrrJEk7smOgR7a3L9gZ4ukUfGNif8f3s
   mZHPk6x5cNWem28vOOz4vjq7QQ5+B+MXtlNGuRowRsYkHs7P4ALjkhMG2
   chqIxpP2waV6iAvgaKSjde/hGLHVjxmjSmGXocY/93VIz+bfTUK2zLqnO
   jdroV36NjeAh+YA1t0TNwMGmTmb81kpWj8Z+MvyLp6Lpmc4btmY60ZPo/
   iPEbB4SqJGc3HJRUGXHMAdMw5g8Cq5wLh0HlsGyyBlk2ymk2y4ehRPepR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="15452977"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="15452977"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12354420"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.235])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:00:15 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 86EC110A43A; Tue,  5 Dec 2023 18:00:12 +0300 (+03)
Date:   Tue, 5 Dec 2023 18:00:12 +0300
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
Message-ID: <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
 <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:46:19PM +0100, Borislav Petkov wrote:
> On Tue, Dec 05, 2023 at 05:37:38PM +0300, Kirill A. Shutemov wrote:
> > The SEV code uses cc_platform_has() checks to detect the SEV flavor.
> > However, these checks can sometimes produce false positives depending on
> > the context.
> > 
> > For example, sev_map_percpu_data() uses CC_ATTR_GUEST_MEM_ENCRYPT to
> > detect SEV guest, but this check will also pass for TDX guests.
> 
> Well, a function prefixed with "sev_" should check cc_vendor first...

I don't think cc_platform_has() is the right check. On TDX side we use
X86_FEATURE_TDX_GUEST for this and it works better than stretching
CC_ATTRs beyond their meaning.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
