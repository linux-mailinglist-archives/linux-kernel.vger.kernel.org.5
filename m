Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734747C54D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjJKNH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJKNHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:07:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE3EA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697029670; x=1728565670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLhN9KgQsZyg0n8Ly1Pb7b8a/0TBjyZmAM7hyIaqDU0=;
  b=J6fs9sLyRoI03cWWBHvxDYGmvSjZ9fbOUsYOMa5VTkXBWhy0W4ep3sG4
   t/B5SpDOoTluUhn1q/aIZ+okZ5VQfhE3PJ9wBOd9MSNOm1WbM24B+Tafm
   miaA/CqhjysrZnGoPXqPDjXH9qF9RKTDPnJuc4YAXcaY8GVaNpYp1bvVS
   42ddhRzAZRVCV7GER5NU7vnQGCyKawVQbltCgNJeaxHjKVpAyPrQlRTTO
   gqTNbY3CZA/u7ziiAhkuwGGqnXdWtXmGI2Nsf5uEHO29CvJpuZE92DhY5
   Mi6q6P7CveRowvwjTi2G4vmD2dBkyoMm2NOm/UCr7bsl78vAshjQ2oE8+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415703647"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="415703647"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="788987517"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="788987517"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:07:46 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0FD8B109FB5; Wed, 11 Oct 2023 16:07:43 +0300 (+03)
Date:   Wed, 11 Oct 2023 16:07:43 +0300
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
Subject: Re: [PATCH 02/13] kernel/cpu: Add support for declaring CPU hotplug
 not supported
Message-ID: <20231011130743.mdfi27pdwktefbsv@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
 <dcf9317e-5557-4fe7-889c-1a02783fa894@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf9317e-5557-4fe7-889c-1a02783fa894@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:35:59AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> > The function cpu_hotplug_not_supported() can be called to indicate that
> > CPU hotplug should be disabled. It does not prevent the initial bring up
> > of the CPU, but it stops subsequent offlining.
> > 
> > This function is intended to replace CC_ATTR_HOTPLUG_DISABLED.
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks.

> > @@ -543,6 +546,18 @@ static void lockdep_release_cpus_lock(void)
> >  	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
> >  }
> >  
> > +/*
> > + * Declare CPU hotplug not supported.
> > + *
> > + * It doesn't prevent initial bring up of the CPU, but stops offlining.
> > + */
> > +void cpu_hotplug_not_supported(void)
> > +{
> > +	cpu_maps_update_begin();
> > +	cpu_hotplug_supported = false;
> > +	cpu_maps_update_done();
> > +}
> 
> Since this function is not used in this patch, do you need to add __maybe_unused to
> avoid warnings?

Hm? I don't think compiler complains about non-static unused functions. It
has no visibility if it is used.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
