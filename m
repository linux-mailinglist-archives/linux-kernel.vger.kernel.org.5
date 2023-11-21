Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9747F2ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjKUKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjKUKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:40:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450ECF4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563219; x=1732099219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NaeYZlAyfEszL4Mboch+ASOVeF+qoSwNlJCREj7p544=;
  b=QtBAvQF1N/6b4zhZN5Yy1IH45XKEH7PjCA+poYYUxzy3lFiwELbrOy0v
   Lr1T8YLl6Zewso53fIHP+CnY1ABCUOW0EqUp8PVr0k6Z9+a0MJkinnR3S
   yiXT/0RTznxVRo0z63FOu5g+rMgVNeXkoUo5CZmX8MZh+ScuLuJLY3cGW
   jYgIYaxu3UAYI+3VB3WmJBw6tDQphM60eI8rCYbckZ94L8neS9MqHjIhI
   wae2+RudB2/ayX3r//q9QxTfkIWF4p2A62j6lgdy9sGYnP41z9kzbp6s8
   C6bCIvvGxTjN4yYmDrJvZ4/bAU0nf9FjXe45hQa+CsEGpFUQC8dPl7Jv4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371987299"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371987299"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14872307"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:40:14 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DDCE010A36E; Tue, 21 Nov 2023 13:40:11 +0300 (+03)
Date:   Tue, 21 Nov 2023 13:40:11 +0300
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
Message-ID: <20231121104011.jfe6fzmxgl7onlfi@box.shutemov.name>
References: <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
 <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
 <ZVyDMTrbPwe/0yRd@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVyDMTrbPwe/0yRd@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 06:15:13PM +0800, Baoquan He wrote:
> > > 2) anything missing to allow makedumpfile/cp access 1st kernel's memory?
> > 
> > It worked before for us, but I have not checked for a while.
> > 
> > I expected you've dropped my "if (crash) return;" debug patch I asked you
> > to tested before, right? If not, failure is expected.
> 
> Ah, my bad. I didn't actually.
> 
> Just now I rebuilt kernel and retested, vmcore saving works. Just when
> it finished kdump work and tried to reboot, the rebooting failed because
> cpus are not resettable like kexec reboot does. Not sure if this is seen
> in your test.

Yes. It is the same reboot limitation I've mentioned before.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
