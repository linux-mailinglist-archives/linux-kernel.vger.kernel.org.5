Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89717C5502
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjJKNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjJKNLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:11:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A858F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697029871; x=1728565871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B53XM39BYMuTT2q7Eh2SVAroSIYenFGSlmbpBE0jnKI=;
  b=fyS/Nwc9ryfLgeO013yOmFLO/uKiSk5J0C8pOHrxgK6JIqnVLrXjB9oW
   Z6f9FjqL6zukx25s3JbCxRRSQ3rpJNNndrx3CEZOZnD7FOt63xeGBKqEE
   ly4xHnU9qZNMqnaXiuVW2wChfdsub/Kb/E2CqL4GWusgGnJzWwdRUI/oM
   AhoV1nDmDh/qcQ0J7HACBW3BNGQUpkGe5drkTHujxf5pTAGUD9Lc/37db
   eNx20Y8jYhhwoQB8Ikb4liryryZc+Gzrft2kpEX4s/UuYnJSBAazHY1ob
   8jOuyPLacq+JwP9q0Hjjz4fPydfGIeDH4GKUemmWHVRian8iy1yeZDQkD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383522366"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="383522366"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747443328"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="747443328"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:11:06 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C1E03109FB5; Wed, 11 Oct 2023 16:11:03 +0300 (+03)
Date:   Wed, 11 Oct 2023 16:11:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
Message-ID: <20231011131103.6p6l3gpklsaybygy@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
 <b69b21b8-7915-4854-b5f7-5124cd4e5bbf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69b21b8-7915-4854-b5f7-5124cd4e5bbf@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:53:27AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > present in the VM. It leads to write to a MSR that doesn't exist on some
> > configurations, namely in TDX guest:
> > 
> > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > 
> > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > features.
> > 
> > Do not disable kvmclock if it was not enumerated or disabled by user
> > from kernel command line.
> 
> For the above warning,  check for CLOCKSOURCE and CLOCKSOURCE2
> feature is sufficient, right? Do we need to include user/command-line
> disable check here?

The command line disables kvmclock, even if it is enumerated, so disabling
it is not needed.

Anyway, I reworked the patch already based on Sean's feedback. No need in
taking parameter into account directly now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
