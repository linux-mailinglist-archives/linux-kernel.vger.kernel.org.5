Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B927EE0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjKPM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjKPM42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:56:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C02FAD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700139385; x=1731675385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wtBlYnCBpLMRFflG+XcS8mBKaNnwDHWxPq3R8KR24Y=;
  b=YCr5MW8tU1A1Jjhj3Xn9LsNz8BYd03sFi2jGizv/getduVzvfxkXppqv
   A39J2QagcY2oejtzlO5xU3lqPA/TJGZH2WO+ALntwVgM8/mI3YuRmBnUz
   rYNfqOdDiO4bY/HfBJf6GIFilhxmo8EuSPpXshotX+Bq3MsAoxm+2otTH
   Zd9TTA7wpUusEjVjJqMmW1eGAANxZarSb9xLXL9VzIrmld5JG/pEZ8fYw
   4u+4DZw8xmlSAJBP9qotuos4qrORMCKuoYibJ+IfyQetaV0D8lEviztOa
   shmGmFAL79aC/XGSIDjSW8tOlE9ULoFYY6A8ukHMNxaSu7i+ZsTKWzmjX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="12630480"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="12630480"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765289679"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="765289679"
Received: from tlonnber-mobl3.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.57.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:56:15 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 58CE510A325; Thu, 16 Nov 2023 15:56:12 +0300 (+03)
Date:   Thu, 16 Nov 2023 15:56:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <20231116125612.daxettqcapled7ac@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 08:10:47PM +0800, Baoquan He wrote:
> On 11/15/23 at 03:00pm, Kirill A. Shutemov wrote:
> > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > TDX guest.
> 
> I finally got a machine of intel-eaglestream-spr as host and built a
> tdx guest to give it a shot, the kexec reboot is working very well,
> while kdump kernel always failed to boot up. I only built kernel and
> installed it on tdx guest.
> ------------------------------------------
> [    1.422500] Run /init as init process
> [    1.423073] Failed to execute /init (error -2)
> [    1.423759] Run /sbin/init as init process
> [    1.424370] Run /etc/init as init process
> [    1.424969] Run /bin/init as init process
> [    1.425588] Run /bin/sh as init process
> [    1.426150] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
> [    1.428122] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00014-gbdba31ba3cec #3
> [    1.429232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> [    1.430328] Call Trace:
> [    1.430717]  <TASK>
> [    1.431041]  dump_stack_lvl+0x33/0x50
> [    1.431581]  panic+0x324/0x340
> [    1.432037]  ? __pfx_kernel_init+0x10/0x10
> [    1.432629]  kernel_init+0x174/0x1c0
> [    1.433149]  ret_from_fork+0x2d/0x50
> [    1.433690]  ? __pfx_kernel_init+0x10/0x10
> [    1.434277]  ret_from_fork_asm+0x1b/0x30
> [    1.434850]  </TASK>
> [    1.435345] Kernel Offset: disabled
> [    1.439216] Rebooting in 10 seconds..
> qemu-kvm: cpus are not resettable, terminating

Could you shared your kernel config and details about your setup (qemu
command, kernel command line, ...)?


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
