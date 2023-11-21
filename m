Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F377F28E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjKUJ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjKUJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:25:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2FA30E5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700558679; x=1732094679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0iULeuKaoxQzM+nvqZcr9KorfV2vMGDu+VliBW15P98=;
  b=FaJyZsE3rAieEq5/GLz+gAu+zTUuH8Z4WNxCo006XBD7/yfCwV+l+/p+
   IPndxJG0+ahc4shgGOmIdM/z+f36TumNbF6KCk6Ue8L/6eYjdrNJPh27+
   Dm/ZrqLZeCe/iof56s280LpoOVtj2LgxRK4v7XzDXYFqeCK8YeH+YVloK
   NVEPuSEPA9QQmCUp9yosq00VbBZ8/z+obkrJhjLvXBDVRc8juJH21PCUw
   kiEGHAldAt6eFAvWnuxlWVw1CFnXqqt02RpjGvuevJfh0EGrpM62kCztO
   +iY/ei3A/aM+kQi1WV5U900lrM0bvshqoVQw7BNrqi5rx29lVfk3qiHVL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422899085"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="422899085"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766582524"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766582524"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:24:33 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B2EB110A36E; Tue, 21 Nov 2023 12:24:30 +0300 (+03)
Date:   Tue, 21 Nov 2023 12:24:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tao Liu <ltao@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20231121092430.fmkzpcjwhidkiqjv@box.shutemov.name>
References: <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
 <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
 <CAO7dBbWb2UWJRm1LLXOq7MM1K6BxDetL8tTmW93H589FGz8n9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7dBbWb2UWJRm1LLXOq7MM1K6BxDetL8tTmW93H589FGz8n9g@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 05:10:01PM +0800, Tao Liu wrote:
> > > My colleague Tao helped to double check this, he got the same testing result.
> > > Plesae
> > > 1) what can we do to enable the multiple cpu support for kexec reboot?
> >
> > You would need a patched BIOS image. I've hacked one[1] for my testing.
> > But it only works if kernel runs in 4-level paging mode (specify no5lvl in
> > kernel command line).
> >
> > BIOS folks work on proper patch, but it is not ready yet.
> >
> > [1] https://gist.github.com/kiryl/e1dc1719e0c990b3ceee5d8de8dbf332
> >
> Thanks a lot for providing the BIOS patch. One more question, is the
> patched BIOS image for the host physical machine or for the tdx guest
> vm?

For the guest.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
