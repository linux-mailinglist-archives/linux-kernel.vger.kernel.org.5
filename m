Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986817F70CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbjKXKGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345401AbjKXKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:06:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA44010F0;
        Fri, 24 Nov 2023 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700820395; x=1732356395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohoDw7JZUTv1RjPou6a4xNAn3GHL7KxVPsE5YzKJdKk=;
  b=BGQv4CNMGbgTkzoYhne64szpj0gFZ4rf9vxH0sYOFl0YPUwjFfRlWi39
   0DdYL77ZHNX5S9yHHALJn+WN6vIx8YHX+DWK167DvqKl3icE3aPCWVz65
   laLujl9Fjk8oBNmn4jVGD9SRZ6P1Lb+cbOwXe4PSzrf8qpUzK/veEH1uI
   LNLoQ39NehRXspUQIX61QvoJtwZp5yGRCi/+m/xz2tU9/Ea6Wbg8smYNE
   7jyckZgdO+3jZOyM42KeGtmgj3FkNoNuiqZd2xljU1D8XaIU49BUfiCU/
   aSoT45kMybsoQwaIXt6AC7Nmi8+IYUFcLAauGBN+im8nv+y+1up02GnxY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377430632"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="377430632"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 02:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014863922"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="1014863922"
Received: from dlemiech-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 02:06:29 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6460210A38A; Fri, 24 Nov 2023 13:06:27 +0300 (+03)
Date:   Fri, 24 Nov 2023 13:06:27 +0300
From:   kirill.shutemov@linux.intel.com
To:     mhklinux@outlook.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, luto@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
        lstoakes@gmail.com, thomas.lendacky@amd.com, ardb@kernel.org,
        jroedel@suse.de, seanjc@google.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/8] x86/coco: Mark CoCo VM pages not present when
 changing encrypted state
Message-ID: <20231124100627.avltdnuhminwuzax@box>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121212016.1154303-1-mhklinux@outlook.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:20:08PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In a CoCo VM when a page transitions from encrypted to decrypted, or vice
> versa, attributes in the PTE must be updated *and* the hypervisor must
> be notified of the change.

Strictly speaking it is not true for TDX. Conversion to shared can be
implicit: set shared bit and touch the page will do the conversion. MapGPA
is optional.

> Because there are two separate steps, there's
> a window where the settings are inconsistent.  Normally the code that
> initiates the transition (via set_memory_decrypted() or
> set_memory_encrypted()) ensures that the memory is not being accessed
> during a transition, so the window of inconsistency is not a problem.
> However, the load_unaligned_zeropad() function can read arbitrary memory
> pages at arbitrary times, which could read a transitioning page during
> the window.  In such a case, CoCo VM specific exceptions are taken
> (depending on the CoCo architecture in use).  Current code in those
> exception handlers recovers and does "fixup" on the result returned by
> load_unaligned_zeropad().  Unfortunately, this exception handling can't
> work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode)
> if the exceptions are routed to the paravisor.  The paravisor can't
> do load_unaligned_zeropad() fixup, so the exceptions would need to
> be forwarded from the paravisor to the Linux guest, but there are
> no architectural specs for how to do that.

Hm. Can't we inject #PF (or #GP) into L2 if #VE/#VC handler in L1 sees
cross-page access to shared memory while no fixup entry for the page in
L1. It would give L2 chance to handle the situation in a transparent way.

Maybe I miss something, I donno.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
