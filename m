Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5472D7B2274
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjI1Qe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1QeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:34:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C298
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695918862; x=1727454862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/En6src2yBjfLB73UxoebHkWKBYmlPqPdsl7xQH5iRc=;
  b=WUNnNFbLI3bmo6q7d59C7QnSUP8RwGcp3SkorTkfXJBeSt7w61OFJCKR
   sGIAZRzh/S11r4BrA/B/GlLsMQcOe3oYDV2YZCMxZDNKWvduPKknzVVDs
   1tH+25ttJO5Z7+oyZqy2j5yHZMqj0WoyMjMWbeUZkA96uvqRE0fpYrLF8
   8PX8SktNABR3u+yOQRSJi2NlCXxnlMhuVryTHQW/8oxucNCn8H5oJSuPn
   0oj4x0ValezQi0qmtNSoAqOhhl3i/NAYTG2owikTVzxZBRtTttF8bMeYI
   NbN9eJSAv+89comWvZLi7Qqah7u58gLNjbeuvLy5bjeb2a9pYyRrYNnbw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="468394055"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="468394055"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="1080629124"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="1080629124"
Received: from speraval-mobl.amr.corp.intel.com (HELO desk) ([10.209.33.83])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:34:01 -0700
Date:   Thu, 28 Sep 2023 09:33:46 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Breno Leitao <leitao@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Message-ID: <20230928163346.3xuawz7zrvdlyizo@desk>
References: <20230628142129.2468174-1-leitao@debian.org>
 <ZRV1bIuSXjZ+uPKB@gmail.com>
 <a5fbcf09-2445-28f1-4113-0de4f72b7f90@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5fbcf09-2445-28f1-4113-0de4f72b7f90@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 06:40:18AM -0700, Dave Hansen wrote:
> On 9/28/23 05:45, Breno Leitao wrote:
> > 1) Create one Kconfig entry per mitigation, so, the user can pick and
> > choose what to enable and disable. (Version 3 of this patch. May need a
> > re-spin due to the new mitigations being added.)
> 
> This means, what, roughly 18 today?
> 
> #define X86_BUG_CPU_MELTDOWN		X86_BUG(14)
> ...
> #define X86_BUG_GDS                     X86_BUG(30)
> 
> Plus two bonus ones:
> 
> #define X86_BUG_SRSO                    X86_BUG(1*32 + 0)
> #define X86_BUG_DIV0                    X86_BUG(1*32 + 1)
> 
> ... and we've slowed down the rate at which we're adding these, but
> we're still seeing a couple a year.
> 
> Perhaps Pawan and the others actually _doing_ the patches for these can
> speak up, but I don't think adding a Kconfig option will be too much
> additional work for each new X86_BUG.

It is trivial, but seems unnecessary IMO.

> I still think it's highly unlikely that someone will come through and
> pick and choose among a few dozen vulnerabilities.

Second that.

If we do want to provide more control, personally I would like:

 - Global control for all mitigations
	- Enable only cheap mitigations

This could enable mitigations as long as it doesn't hurt the performance
too badly. The challenge being whether a mitigation is cheap or costly
is subjective and highly depends on workloads. Without a standard way of
categorizing a mitigation it will be hard to reach a consensus. OTOH,
there are mitigations that are relatively cheaper e.g. Enhanced IBRS.

Other way to categorize could be:

 - Global control for all mitigations
	- Guest only mitigations (host userspace is trusted)

This control can disable all mitigation for userspace, but will continue
to mitigate host against a rouge guests. This could be quite a lot of
work.
