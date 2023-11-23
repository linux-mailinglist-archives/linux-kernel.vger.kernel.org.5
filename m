Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEAB7F57F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbjKWGAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbjKWGAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:00:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297571B6;
        Wed, 22 Nov 2023 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700719208; x=1732255208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6LBOW9QKW6MVFMF8UDZAp66PznLow/kH73T029jb9U=;
  b=n6SS2z24QWMQsBxeY/a0fIgcnUg+FFrF6ElDsjwkqdyOcOxNPBTcsnFR
   13rIp+NkQC8M1zPSUYnQJpTGrzEQPQ6Wk7nGNW+rGG9cGutjQb2S/HqFU
   97S/G1PsJZcs9LO3ZcnEgADw9jZT87FlWvOWUmjqDhGFU/HbWIBW2DsC8
   Qw5+Pkis8G0sOnGyLVi7mOA1YoD55BEDOeCc5RvDCzhmBDDTm5qoKubSv
   pDzHcsxKZthScOwVR/5CWF+q8zQZUO4d9kmYb+qKErL0WHTSnm9lvHmP7
   eTA1/piSVC2qtJmvt2+gIfM+lb8Y3YIYj8DKKY6t/T+GtZF4XxjcrccIx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396111881"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="396111881"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:00:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767105467"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="767105467"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2023 22:00:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 46A012A6; Thu, 23 Nov 2023 08:00:04 +0200 (EET)
Date:   Thu, 23 Nov 2023 08:00:04 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
Message-ID: <20231123060004.GA1074920@black.fi.intel.com>
References: <20231122050639.19651-1-Sanath.S@amd.com>
 <20231122060316.GT1074920@black.fi.intel.com>
 <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:43:55AM -0600, Mario Limonciello wrote:
> On 11/22/2023 00:03, Mika Westerberg wrote:
> > Hi,
> > 
> > On Wed, Nov 22, 2023 at 10:36:39AM +0530, Sanath S wrote:
> > > Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
> > > very minimal buses for PCIe downstream ports. This results in
> > > failure to extend the daisy chain.
> > > 
> > > Add quirk to reset the downstream port to help reset the topology
> > > created by boot firmware.
> > 
> > But this resets the USB4 side of ports, how does this help with the PCIe
> > side? Or this also resets the PCIe side? Please add this information to
> > the changelog too.
> 
> IIUC the PCIe side will be implicitly reset as well.
> 
> > 
> > I suppose it is not possible to fix the boot firmware?
> 
> It's a really difficult case to make with firmware team.  Windows and Linux
> have a different behavior here.  The Windows CM doesn't take the existing
> tunnels from firmware and instead always resets them.
> So Windows "isn't affected" by this problem.
> 
> Furthermore there are already lots of systems out "in the wild" as these are
> already both production silicon with shipping OEM products.

Yeah that's what I was afraid :( Okay we've been there before so let's
work it around in the kernel then.
