Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9B7DCAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjJaKem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjJaKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:34:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4ECDF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698748478; x=1730284478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=drEjHJjWXZMR/XUiO722JIutxhlwnJwcJu9RoDsC5kQ=;
  b=JXIYBQEzUiNsenxgrpdvx1kAkHekynu0JUDbw14BNVz/eV1C4n7f9UgJ
   POxWUW7n5CT0XGlL+fOMYy7KHwfgKp/yfYO2/HXUeV0ShL4NmyfgmLV8h
   49Ee93fQhOwQrqAZUaALzwHMgIsMpxTHDZrIyoDsBbu5wAG/D1ewdXoNO
   b9UF40G4CRIo1WTI5Ejq50xf4epW6qH8uNwYxhpl0Hu/rrm/01iyre8fN
   eKT6elOULGszpMKCNpRP2gDw09PwiyOy9CxJ1gFaen76w58XH1ftWejrZ
   uevhROMjDA9ctyLIDXySbZ3ybHsrPuZ6IYqiq7uyFoeCp1BCiRs2BlaEw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474499814"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="474499814"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007747162"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1007747162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:34:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxm4w-0000000A79C-1031;
        Tue, 31 Oct 2023 12:34:34 +0200
Date:   Tue, 31 Oct 2023 12:34:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chen Ni <nichen@iscas.ac.cn>
Cc:     lee@kernel.org, mika.westerberg@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Add check for platform_get_irq
Message-ID: <ZUDYOa0hrc5qif4k@smile.fi.intel.com>
References: <20231031063642.3041682-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031063642.3041682-1-nichen@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 06:36:42AM +0000, Chen Ni wrote:
> The platform_get_irq() might be failed and return a negative result.
> So there should have an error handling code.

NAK.

Have you checked the implementation of intel_lpcc_probe()?

> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")

It does not fix anything, except maybe an error code.
Also it misses PCI counterpart.

...

That said, I would expect that in intel_lpss_probe() the unset / erroneous IRQ
(which actually shouldn't be checked against 0 at all) should be returned as is.


i.e.

	if (!info || !info->mem || info->irq <= 0)
		return -EINVAL;

be converted to

	if (!info || !info->mem)
		return -EINVAL;

	if (info->irq < 0)
		return info->irq;

That kind of patch I will accept.

-- 
With Best Regards,
Andy Shevchenko


