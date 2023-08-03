Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF55876E7F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjHCMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjHCMMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:12:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A082D5F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691064733; x=1722600733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8TUaEQZbSICclUzIiNKbuR74lraYMEOLLGwfyI28U74=;
  b=cg1DoC0g03SW7lPqdw2OXBKlk71LbnF47SPeZ3ATGBIS0/aR+RvITYDR
   8VKAFv3IMikbPXqHjc+gs58Ifr0qSbCoQvJ4RgH0HqYhFE2uvjs3I7w7a
   zlrU4tHIbUXBhJ/gGZHSS1dc9RAatfrnR5Zpbb81d3qL7oInlQAXnY+q4
   7pADnpas8K0necyVjFXoyUOYZdCjfCuLK/IffrriPLCn258T5h4jHnXqE
   IQkQNT2dz5DFlq3TNXnKFc6ABJKzz1hePP7Ni8WdpHaE876nRM5munwA4
   FGnnX5DqdzQvQBq/hgRf3qmeG6ntKqm4WValoP2Ym+h2JDdF0VCvFIu2+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456229671"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="456229671"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976043495"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="976043495"
Received: from gvarshne-mobl2.gar.corp.intel.com (HELO box.shutemov.name) ([10.252.63.106])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:12:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B343A109FCF; Thu,  3 Aug 2023 15:12:07 +0300 (+03)
Date:   Thu, 3 Aug 2023 15:12:07 +0300
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
Message-ID: <20230803121207.krvcuj22mdxhugog@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
 <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
 <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
 <20230803114546.em5qsjs33i5b7ogh@box.shutemov.name>
 <332547a2332121313bf6d00c9eaf71136b48696b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332547a2332121313bf6d00c9eaf71136b48696b.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:56:40AM +0000, Huang, Kai wrote:
> On Thu, 2023-08-03 at 14:45 +0300, kirill.shutemov@linux.intel.com wrote:
> > > > I would rather keep the struct
> > > > read-only where possible.
> > > > 
> > > 
> > > We can achieve this if there's a clean way to do, but I don't see that.
> > 
> > Keep _ret() and non-_ret() versions?
> 
> The problem is the assembly needs to always turn on the "\ret" so that the R10
> (used as VP.VMCALL leaf return code) can be saved to the structure.  Otherwise
> we are not able to return VP.VMCALL leaf return code.

Yeah. This is downside of single assembly macro for all calls.

One possible way is to make it in C: non-_ret() version pass to the
assembly helper copy of the caller's struct, keeping original intact.
But, yeah, it is ugly.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
