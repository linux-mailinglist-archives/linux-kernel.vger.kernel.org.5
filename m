Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB77752A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjHIGN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHIGNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:13:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C061BF3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691561634; x=1723097634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I89NpMm1BmDvQjFSjgEsliwddKY7luHiKWODVdUb6e0=;
  b=ItX/UCo67oYGUSgSswNnJVSO30l8BRndluyYzHjNJmpZhSOvCQ7K5v3t
   XzknT/tnjxXNnkIGYdq81w/72iKsFUxMg4Wm06IHrzvB92aYqfNWlf0JL
   FwcUg5GXDquaVavgn71ECROTb454g01IdEYiSoiRQ2iihWH1xZwUwzeUX
   X9zyBA1+ojNDWfSHOvp2XRofJ/IYQaaQDdRGAYXOKTaaqsQF4qP2bF+d8
   3KS2rhaVcUeIRJ7TpEIcN3Nztsz1Ruz55OwTOj4v3LfYKGw8F7o007kKQ
   mXT8YK6AWm/I8YPmmbPp0svQpoXyPqKyavnW6Sa/3eUaEC+UF2HGvvC2j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457410111"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="457410111"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 23:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731680732"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="731680732"
Received: from jmhendri-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.58])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 23:13:51 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D9E2C10A11A; Wed,  9 Aug 2023 09:13:48 +0300 (+03)
Date:   Wed, 9 Aug 2023 09:13:48 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
Message-ID: <20230809061348.vhm5ie4uzystwfya@box.shutemov.name>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box>
 <DM8PR11MB5750DEFF988068EFAFE28667E712A@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750DEFF988068EFAFE28667E712A@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:44:37AM +0000, Reshetova, Elena wrote:
> > 
> > I don't know what the rules here. As far as I can see, all other clock
> > sources relevant for TDX guest have lower rating. I guess we are fine?
> 
> What about acpi_pm? 
> See this:
> https://github.com/intel/tdx/commit/045692772ab4ef75062a83cc6e4ffa22cab40226

clocksource_acpi_pm.rating is 200 while TSC is 300.

> > There's notable exception to the rating order is kvmclock which is higher
> > than tsc. It has to be disabled, but it is not clear to me how. This topic
> > is related to how we are going to filter allowed devices/drivers, so I
> > would postpone the decision until we settle on wider filtering schema.
> 
> One option is to include "no-kvmclock" into kernel command line, which
> is attested. Another option is to try to disable it explicitly, like we had
> in past: 
> https://github.com/intel/tdx/commit/6b0357f2115c1bdd158c0c8836f4f541517bf375
> 
> The obvious issues with command line is that it is going to 1) grow 
> considerably if we try to disable everything we can via command line
> and 2) there is a high chance that in practice people will not use secure default
> and/or forget to verify the correct status of cmd line. But this is to be
> expected I guess for any security method that involves attestation unfortunately.

I guess command line is fine, until we have coherent solution on
filtering.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
