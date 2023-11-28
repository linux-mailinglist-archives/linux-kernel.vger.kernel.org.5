Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66847FB88A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjK1Ksn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjK1KkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:40:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB44182;
        Tue, 28 Nov 2023 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701167949; x=1732703949;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MXwHFEX9kq9p9CKpYfhWlu3F+DrEniFzh7s8EukFtrw=;
  b=JLWn5U/5nrgCEUJm+hT+CdPXdkQ+tnIqBcPSAKsZK4U/ep3PrdY7f2ZZ
   uV5tB1AFV6v1xYeY4kzrLiYAXzsZ9jbRw+dRHO0Kvrp/+09KmT1hRbiFb
   vgOMs4ds2j2Fz40t1UHPLD0w9jWLYg8eDXi/rAGDQ1Uu12BFTmld5j8f+
   QezsABJISwpkxko0Or2cyuGvPEcifd1l6H5SKpKX7Z8/WVmL+D40RPJr6
   FtEaYlF46ZREXXu42FuEveTruwopYJpT8pe/mBWU2LIMhsEcLo41UHa7J
   w0zvgVmtmB3jXD19Kily2j4SsGrOo/80MRe0NAxzrAAw9hUG+AoYrAN/H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="377923317"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="377923317"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="16898587"
Received: from mravivx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:39:05 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vignesh Raman <vignesh.raman@collabora.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     daniels@collabora.com, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, helen.koike@collabora.com
Subject: Re: [PATCH] PCI: qcom: Fix compile error
In-Reply-To: <20231128065104.GK3088@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
 <20231128051456.GA3088@thinkpad>
 <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>
 <20231128065104.GK3088@thinkpad>
Date:   Tue, 28 Nov 2023 12:39:02 +0200
Message-ID: <87a5qy88mx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> On Tue, Nov 28, 2023 at 11:44:26AM +0530, Vignesh Raman wrote:
>> Hi Mani,
>> 
>> On 28/11/23 10:44, Manivannan Sadhasivam wrote:
>> > On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
>> > > Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
>> > > to acquire bus lock") has added an argument to acquire bus lock
>> > > in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
>> > > without this argument, resulting in below build error.
>> > > 
>> > 
>> > Where do you see this error? That patch is not even merged. Looks like you are
>> > sending the patch against some downstream tree.
>> 
>> I got this error with drm-tip - git://anongit.freedesktop.org/drm-tip
>> 
>> This commit is merged in drm-intel/topic/core-for-CI -
>> https://cgit.freedesktop.org/drm-intel/log/?h=topic/core-for-CI
>> 
>
> Okay. Since this patch is just for CI, please do not CC linux-pci as it causes
> confusion.

Agreed. More on-topic for linux-pci is what happened with [1].

We've been running CI with that for months now to avoid lockdep splats,
and it's obviously in everyone's best interest to get a fix upstream.

David, Bjorn?


BR,
Jani.


[1] https://lore.kernel.org/all/20230321233849.3408339-1-david.e.box@linux.intel.com/




>
> - Mani
>
>> Regards,
>> Vignesh

-- 
Jani Nikula, Intel
