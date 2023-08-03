Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE776EC27
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjHCOQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjHCOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:16:10 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A801C1B2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691072169; x=1722608169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hAFMMXOAM2pzpIk5VcLNkbp6zrSaafTVSYc31s+0CAU=;
  b=Y1ZhSP1kuOmj3Em6PvGoBcMxzd5KHLhz6cWnm1GF1+JuG2uNZxKx/YhQ
   cDd6VCUR2TOqmqNmzeKF0k7eVYtC1whzcdu7DeU5EdLTkRCk+huYH1W90
   wTu/RogUyQG5MYpAkuawGTHDakoHgNWkLUy+aEDdVhcPGU+74Ud3XrDF2
   riE+6NjmerD+GF4vRLTGBJTcZAw6hSuEJfap7HOsi2fsE9/G9UWRuHZlz
   guM/PbVsSpQzO70eQzyIwXRoC/SI/sRrL70wsOcN2k+qQSf+o2LqD16Um
   dQVpdfHmCOxMEZN4mpnDP6lXp167wixw2W8Pa8bVZ7L2BG2WR2EXCjx9V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373519579"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="373519579"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 06:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="843593493"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="843593493"
Received: from sosterlu-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.233])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 06:47:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 43226109FCF; Thu,  3 Aug 2023 16:47:25 +0300 (+03)
Date:   Thu, 3 Aug 2023 16:47:25 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Message-ID: <20230803134725.eq4uliddd7rlu3ac@box>
References: <cover.1690369495.git.kai.huang@intel.com>
 <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
 <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
 <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
 <20230803114546.em5qsjs33i5b7ogh@box.shutemov.name>
 <332547a2332121313bf6d00c9eaf71136b48696b.camel@intel.com>
 <20230803121207.krvcuj22mdxhugog@box.shutemov.name>
 <ce045f6ccf9451d177581280c35092de7bd71488.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce045f6ccf9451d177581280c35092de7bd71488.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:41:25PM +0000, Huang, Kai wrote:
> On Thu, 2023-08-03 at 15:12 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Thu, Aug 03, 2023 at 11:56:40AM +0000, Huang, Kai wrote:
> > > On Thu, 2023-08-03 at 14:45 +0300, kirill.shutemov@linux.intel.com wrote:
> > > > > > I would rather keep the struct
> > > > > > read-only where possible.
> > > > > > 
> > > > > 
> > > > > We can achieve this if there's a clean way to do, but I don't see that.
> > > > 
> > > > Keep _ret() and non-_ret() versions?
> > > 
> > > The problem is the assembly needs to always turn on the "\ret" so that the R10
> > > (used as VP.VMCALL leaf return code) can be saved to the structure.  Otherwise
> > > we are not able to return VP.VMCALL leaf return code.
> > 
> > Yeah. This is downside of single assembly macro for all calls.
> > 
> > One possible way is to make it in C: non-_ret() version pass to the
> > assembly helper copy of the caller's struct, keeping original intact.
> > But, yeah, it is ugly.
> > 
> 
> You sure you want to do this? :-)

No, I am not.

Maybe somebody else has better ideas.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
