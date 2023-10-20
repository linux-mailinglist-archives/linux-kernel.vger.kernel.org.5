Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50537D0D89
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376945AbjJTKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376699AbjJTKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:42:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7A106
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798562; x=1729334562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I1QT8NLCZxYYRpmRYZW3+A0VC3zncef/y0csj15rovI=;
  b=lO3MWNFST67vA6kHNliZD9hXNuo6hTi4ffxYZItKQwBZ7jPjC3glLgGE
   xC9NjeSwxr44CU3uyVSKJmVBUOnXLxNuChgbsRcQHCQywP4pi6vMADP7Z
   6MHltj+JOvUpoyOVGcO53dX2EExZSwUJzxSMwb/0oiTJ/bxqOxmHhC8S4
   ehci0Ci+GH90/Jdxtsi98ok7i2otaJhGTPGVu0Lo+CB28lEyvsVMLbMDn
   uvyB+iN564Lz5xbG+jPqOqgeYoBb+39XXJoI+kf1ScXSSUxSxQS/AN6Xm
   GGBUaJvcn9w/xYNebGK9lSqwAlM/lFq8kUQg+84VDWn5293B7CshYNWbv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="8039380"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="8039380"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707200102"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707200102"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:42:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 20789109D0A; Fri, 20 Oct 2023 13:42:34 +0300 (+03)
Date:   Fri, 20 Oct 2023 13:42:34 +0300
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
Subject: Re: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231020104234.s2qqfssultevcnlr@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
 <f0317ec1f52b96c76d8feeb3f21c16dec1de81c8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0317ec1f52b96c76d8feeb3f21c16dec1de81c8.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:49:59AM +0000, Huang, Kai wrote:
> On Thu, 2023-10-05 at 16:14 +0300, Kirill A. Shutemov wrote:
> >  struct acpi_madt_multiproc_wakeup {
> >  	struct acpi_subtable_header header;
> > -	u16 mailbox_version;
> > +	u16 version;
> >  	u32 reserved;		/* reserved - must be zero */
> > -	u64 base_address;
> > +	u64 mailbox_address;
> > +	u64 reset_vector;
> >  };
> 
> I don't quite understand the connection between the renaming and what this patch
> wants to achieve?  What's the reason to rename?

Names are bad: the version field guides version of the structure, not
version of the mailbox. And it is not clear what base base_address
specifies.

> If needed, perhaps put into a separate patch with proper justification?

Hm. Okay...

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
