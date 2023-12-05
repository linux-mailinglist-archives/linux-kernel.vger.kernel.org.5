Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36A805D96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjLESIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbjLESIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:08:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D297D1B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701799699; x=1733335699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nU6+ltTP+gOUvBsLEAvcLUqPG2SP0oUe7thQXPa5nUo=;
  b=DruW0T1UTHoqYqYdjH+iHtPNOQSBCJC1sGp2qKNIVWP4UaSgAqDOt17i
   jIybeu+GSpFw0/2w7nrVO0kVn5+X6wHzpRfVaKwD5BVPi9S0vu5vgYeoK
   L2z96doOsDXH3Z96fYnk5hSf1ZNi85VwVYbEIPbSlZ9trJkauwvmQg2WH
   3RtQv4Dze9dwjBR0JuaVL1ndztBqnQR5kiYxK6vk4gnrb6q5nFoK0G9kd
   OM6h9SCfq3m1kVK5XlIMXVOf4hJgjYW3IEmcsIk1vSGknsX20ct/Nm/2H
   F/NpQHnzJsfzbhuH+nPlY3sP3daqcjuiQZPnje3d9IO2F8fIAm6FuxL2n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="992287"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="992287"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 10:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="747327088"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="747327088"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.235])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 10:08:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3A14A10A43A; Tue,  5 Dec 2023 21:08:13 +0300 (+03)
Date:   Tue, 5 Dec 2023 21:08:13 +0300
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
Message-ID: <20231205180813.phbxg5jdumfovshz@box.shutemov.name>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
 <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
 <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
 <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
 <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
 <20231205171643.zg7fwxjyccab53kf@box.shutemov.name>
 <20231205172436.GFZW9c1EaCaguGhglb@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205172436.GFZW9c1EaCaguGhglb@fat_crate.local>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 06:24:36PM +0100, Borislav Petkov wrote:
> On Tue, Dec 05, 2023 at 08:16:43PM +0300, Kirill A. Shutemov wrote:
> > What's wrong with using X86_FEATURE_* here?
> 
> What's wrong with using something which is already there?

It is here and it is broken.

I think legitimate use case for cc_platfrom_has() is to check platform
capability, not specific implementation. CC_ATTR_GUEST_MEM_ENCRYPT makes
sense, CC_ATTR_GUEST_SEV_SNP doesn't.

And we have much more mature infrastructure around X86_FEATURE_ comparing
to CC_ATRR_. If we can use it, we should.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
