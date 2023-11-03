Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195617E0162
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjKCGlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjKCGlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:41:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA01AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698993703; x=1730529703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNbYZ7OmaM1yZArVuv5RFFMsOCpLosCpzVseJlUykus=;
  b=REnQ3Wlkuxq5+HYbHHtIM9JIQGuS/x5T2vxtqPBxsmNB0VD3qq8bt3Ib
   WAzV1LjNI5PoS/TKPaCVz0/VbH0V74u1ahdCSML/CYPHUGfrVZB235KNt
   wjt/DUAdnhLph2oj1KFU2X65qf23qJYRT3dUdvr53BWdXM//9YqxBXPH0
   vjBytXFttIwjctZj7kHYxgRiuAEgXI4vkUDkOi0uvMGS7ELmUbWVwE8r3
   kngHxf2lV0UTd4rMg3f1JJot0W5arM0gHy7eLv53FWkM7Kt8NSBR2jq3d
   EpIyo1jpkoiNLtt6thZO1DOwkgSrq5cbdd7XIHQgAwK7GO8f15rpiISd0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391757978"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391757978"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 23:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="905251661"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="905251661"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2023 23:41:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4E5972A6; Fri,  3 Nov 2023 08:41:40 +0200 (EET)
Date:   Fri, 3 Nov 2023 08:41:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Chen Ni <nichen@iscas.ac.cn>, lee@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix IRQ check
Message-ID: <20231103064140.GP17433@black.fi.intel.com>
References: <20231101062643.507983-1-nichen@iscas.ac.cn>
 <20231101070310.GF17433@black.fi.intel.com>
 <ZUIclOuVocLUUk7_@smile.fi.intel.com>
 <20231101104717.GH17433@black.fi.intel.com>
 <ZUOYR1l9D5s3bI37@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUOYR1l9D5s3bI37@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 02:38:31PM +0200, Andy Shevchenko wrote:
> > > > > -	if (!info || !info->mem || info->irq <= 0)
> > > > > +	if (!info || !info->mem)
> > > > 
> > > > This check (info->irq <= 0) covers both "invalid" interrupt numbers
> > > > (that's the negative errno and 0 as no interrupt) so I don't see how
> > > > this change makes it any better and the changelog does not clarify it
> > > > either.
> > > 
> > > It makes sense. The IRQ here may not be 0. We should actually fix
> > > the PCI code to guarantee that (platform_get_irq() guarantees that
> > > in platform driver).
> > 
> > Yeah but I mean the check above handles any "invalid" interrupt number
> > just fine regardless. I don't see any point changing that.
> 
> The point is to have proper error code to be returned. Currently it's shadowed
> in this check.

Looking at this more, this patch actually introduces a bug.

We pass pci_dev->irq from intel-lpss-pci.c and that comes directly from
PCI core that assigns it in pci_read_irq(). This value is unsigned int
for starters so it is not designed to contain an error code, secondly it
can be 0 meaning "no IRQ" either if is SRIOV device or the interrupt
line is not assigned. I actually think SRIOV is a possibility for future
LPSS devices so we should be dealing with this properly.
