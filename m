Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4ED7A0B45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbjINRHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjINRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:07:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B191FE1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694711253; x=1726247253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/eQr3ybfflzRpAXDDtun+U9e54s/8RMewMOTgkhAo/s=;
  b=UtSBiv2bmIg9fjI/9x+9/d/P+3b5Hsxlegq4vtLROeluNt9UcDlQkjq0
   fUpzW5RYcPtI35m2YOVRVKEzHBFndmmPUuo7CD0YV2LTEM6q3uavNUMDZ
   7osvMlVJLVZDPncrdeJ3hPb2G5WEwkU2mCwVInOp3W+9qJXex2ZnaI6To
   3UEAcvnJ+7AYaVoAEahphuSHCCgqQDhzfw0Vfc5WFvZK4DY9dIjdvzh/L
   d69EBoicsCyyX3OyY6x8o8cT1owNbHiPyaIzIRuBRd1aIHj/mBSsKQap/
   5TQ3eoid7vGO0TYKiBGpXfkVJmpx38sqFOH175v8Xd2onjSK4VwM0yNsj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="382832868"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="382832868"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075471230"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="1075471230"
Received: from njayagop-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:07:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5E48B109D89; Thu, 14 Sep 2023 20:07:26 +0300 (+03)
Date:   Thu, 14 Sep 2023 20:07:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.de
Subject: Re: [PATCH] x86/boot/compressed: Reserve more memory for page tables
Message-ID: <20230914170726.4am7xi36m4hdgiyk@box>
References: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
 <45cdb5ae-986e-d186-f0fd-a308f946ce8d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45cdb5ae-986e-d186-f0fd-a308f946ce8d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:51:50AM -0700, Dave Hansen wrote:
> On 9/14/23 05:30, Kirill A. Shutemov wrote:
> > +/*
> > + * Total number of page table kernel_add_identity_map() can allocate,
> > + * including page tables consumed by startup_32().
> > + */
> > +# define BOOT_PGT_SIZE		(32*4096)
> 
> I agree that needing to know this in advance *exactly* is troublesome.
> 
> But I do think that we should preserve the comment about the worst-case
> scenario.

Want me to send v2 for that?

> Also, I thought this was triggered by unaccepted memory.  Am
> I remembering it wrong?  How was it in play?

Unaccepted memory touched EFI system table. I was able to reproduce
without unaccepted memory enabled: if get_rsdp_addr() takes
efi_get_rsdp_addr() path. So it is not the root cause, just a trigger.

So we need several things to run into the problem:

- System supports 5-level paging and it is enabled;

- Decompressor takes control in 64-bit mode, so it uses page tables
  inherited from bootloader until initialize_identity_maps().

  In initialize_identity_maps() kernel resets page tables, rebuilding them
  from scratch. Here we only map what is definitely required: kernel,
  cmdline, boot_patams, setup_data.

  Entering in 32-bit mode would make startup_32() map the first 4G
  unconditionally, but in this setup we rely more on #PF to fill page
  table. It masks problem as we rarely need all four PMD tables.

- Make kernel touch at least one page per-gigabyte in the first 4G.

  In our case, unaccepted memory path was the last straw: it triggered
  allocation of the fourth PMD table which failed. 

We can increase the constant by one and it will work as long as nobody
need anything beyond the first 4G (or any 1G-aligned 4G region where we've
got loaded, I guess). I am not sure we can guarantee this with
(potentially buggy) ACPI and EFI in the picture.

> Either way, I think your general approach here is sound.  But let's add
> one little tweak to at least warn when we're getting close to the limit.

Yeah, makes sense.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
