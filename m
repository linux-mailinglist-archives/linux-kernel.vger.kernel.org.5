Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B2A7C5510
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbjJKNPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjJKNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:15:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CA293
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697030103; x=1728566103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DVj1IAQaMNXzKm35tzE0vtrTuSeRAxpGGOqdY2NfLZ8=;
  b=QUFKq1q3r+IlEvuEz8y83el89ToG0wCjwagfgjYn5Hm5DjB65G2NZWSL
   MoHat+lD+RObJZrhieA4JYNjPkoFcxsHXXeWSj9+/ui3n43bhbDAkZvlq
   H9Pxq+Nw9jsRFzbh7nmh4uo9XmGzEBphH6E8FH02ldJZE30THqkUv6Vn9
   WLDYO4JIftca31keim86iuaA+21dif3oS1hVHk3HiESD+7OZRQq09mGzp
   VS9JWNmE1Gt1JHoFJowBraalY3cdmmH0o/D86wlrE6JQBwYJQnXIVdEuv
   /U3/ZlUPgdugPKw58pkpB94ebZlcOIQ2r9kHzfGVK3vRtpXol6Wf8h6Ko
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388525164"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="388525164"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870138127"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="870138127"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:14:56 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D5B19109FB5; Wed, 11 Oct 2023 16:14:52 +0300 (+03)
Date:   Wed, 11 Oct 2023 16:14:52 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 09/13] x86/tdx: Account shared memory
Message-ID: <20231011131452.r42nemcajjcj77hq@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-10-kirill.shutemov@linux.intel.com>
 <f3776d2b6d45e74b4d0e62eb4e788c578132c21c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3776d2b6d45e74b4d0e62eb4e788c578132c21c.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:05:21AM +0000, Huang, Kai wrote:
> 
> > +#ifdef CONFIG_DEBUG_FS
> > +static int tdx_shared_memory_show(struct seq_file *m, void *p)
> > +{
> > +	unsigned long addr, end;
> > +	unsigned long found = 0;
> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte))
> > +			found += size / PAGE_SIZE;
> > +
> > +		addr += size;
> 
> This could be a long loop, perhaps add cond_resched() here?

Sure.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
