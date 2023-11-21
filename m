Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097A97F27C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjKUIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjKUInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:43:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB41D4B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700556210; x=1732092210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZvXdjvxl4OFx/rOJ2HyXP09UhjsWaOEHhJzpQc00a48=;
  b=UWgXUeZPPDsQ5cxEDHQLg3nDj+BlYtgr6YnEhGKGoRpT6ALE1fU2UaAL
   4+Dr9wH0/dsRa4lLua2WQ5r+hS7YoaAgsHu6LwofrGX6u0yGtB7pb+LmH
   RtHPUZAYYILtTwUyfTqANvUkc+mciN0PvYxm/dwMVZPkf3XzMfvCOFKnn
   FLwGzsxEQzS+IOg3TyD9YoHhL4X6JSqPXugsGtZrPvyW+l4yFcMqlVG1s
   106tDb0uM67aznLNbJY94IMPp8YArVN/QJ3ZbkdJQlCASHLgtvAhz2V0F
   SxRKgdbgOamtcYmDeOMRQSzzmJvvSrTdTXGqSgPyp0fsqmD8nqX55mxJB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4919947"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4919947"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:43:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097998545"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097998545"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:43:24 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7AD2510A36E; Tue, 21 Nov 2023 11:43:21 +0300 (+03)
Date:   Tue, 21 Nov 2023 11:43:21 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, ltao@redhat.com,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:41:08PM +0800, Baoquan He wrote:
> > > 
> > > Still failed. And I found the normal reboot does't work either. I will
> > > do more testing tomorrow, e.g use the tdx-tools's own rhel9 kernel
> > > config and rebuild, and update host kernel too.
> 
> I did more tests, resuls are summarized as below: 
> 
> 1) kexec reboot works, but always fallback to 1 cpu even though multiple
> cpus are specified;

That's expected. Until you have new BIOS. See below.

> 2) kdump kernel need more crashkernel memory to boot up,
>    crashkernel=512M works well in our case.

I guess it is due to SWIOTLB memory which requres at least 64M.

>  But it failed in vmcore
>    saving process, either makedumpfile or cp can't access the 1st
>    kernel's old memory;

Will look into it.

> 3) Normal reboot always failed;

It is expected. TD vCPUs are not resettable. So we need to destroy TD and
construct a new one to emulate "reboot".

I guess we can try to add some glue on QEMU side to make reboot more
seamless.

> My colleague Tao helped to double check this, he got the same testing result.
> Plesae 
> 1) what can we do to enable the multiple cpu support for kexec reboot?

You would need a patched BIOS image. I've hacked one[1] for my testing.
But it only works if kernel runs in 4-level paging mode (specify no5lvl in
kernel command line).

BIOS folks work on proper patch, but it is not ready yet.

[1] https://gist.github.com/kiryl/e1dc1719e0c990b3ceee5d8de8dbf332

> 2) anything missing to allow makedumpfile/cp access 1st kernel's memory?

It worked before for us, but I have not checked for a while.

I expected you've dropped my "if (crash) return;" debug patch I asked you
to tested before, right? If not, failure is expected.

> 3) not sure if this is particular case on the system we tested on.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
