Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F57DB513
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjJ3I1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJ3I12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:27:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD38FDB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698654445; x=1730190445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=828OvXrs9PdoWGIXIPb2TnTbIBNCk6E4CQqB1JZEUSU=;
  b=kJ04ANZCD+C67QSaIKUzZjeUFzrzojMfow0lfQzhy4ZI+8hD482U6QLy
   P7lHs5AmwqbBi9khS422OVNphiJE0CTfjGaZ4/eOL549XeijOFup1K6so
   o99N7MMBtNFr2lTjXmnzv702GMDQz+W77Mgal66VmxDQGZzV351ATFiGU
   9IZc76K24fJpVzalmvhxP92gNzeR6LNqj6TSqEAKqPxuWdWSnTNq2otYl
   5s6zq21qALRlWa8mr2tNzjsGjKoZ0/HNoay7CAOhJ8El2totJi8rhr5pU
   WVFdcjtnPbUHJdTcZKDG8OyZ5zOTVvsf06n6GeDUYK5HGyOmwaxkiJem4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="391895167"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="391895167"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="7889715"
Received: from barumuga-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.50.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:27:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 888AE10A2B2; Mon, 30 Oct 2023 11:27:14 +0300 (+03)
Date:   Mon, 30 Oct 2023 11:27:14 +0300
From:   kirill.shutemov@linux.intel.com
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, elena.reshetova@intel.com,
        isaku.yamahata@intel.com, seanjc@google.com,
        Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Message-ID: <20231030082714.pbma2bg2p354cuft@box.shutemov.name>
References: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 02:47:44PM -0700, Rick Edgecombe wrote:
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to take
> care to handle these errors to avoid returning decrypted (shared) memory to
> the page allocator, which could lead to functional or security issues.
> In terms of security, the problematic case is guest PTEs mapping the
> shared alias GFNs, since the VMM has control of the shared mapping in the
> EPT/NPT.
> 
> Such conversion errors may herald future system instability, but are
> temporarily survivable with proper handling in the caller. The kernel
> traditionally makes every effort to keep running, but it is expected that
> some coco guests may prefer to play it safe security-wise, and panic in
> this case. To accommodate both cases, warn when the arch breakouts for
> converting memory at the VMM layer return an error to CPA. Security focused
> users can rely on panic_on_warn to defend against bugs in the callers. Some
> VMMs are not known to behave in the troublesome way, so users that would
> like to terminate on any unusual behavior by the VMM around this will be
> covered as well.
> 
> Since the arch breakouts host the logic for handling coco implementation
> specific errors, an error returned from them means that the set_memory()
> call is out of options for handling the error internally. Make this the
> condition to warn about.
> 
> It is possible that very rarely these functions could fail due to guest
> memory pressure (in the case of failing to allocate a huge page when
> splitting a page table). Don't warn in this case because it is a lot less
> likely to indicate an attack by the host and it is not clear which
> set_memory() calls should get the same treatment. That corner should be
> addressed by future work that considers the more general problem and not
> just papers over a single set_memory() variant.
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Tha patch looks good:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

It intended to get upstream alongside with the caller fixes to leak memory
on failure, right? Maybe get it into one patchset?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
