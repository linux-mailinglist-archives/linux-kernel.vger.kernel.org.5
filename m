Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C479E6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbjIML17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjIML15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:27:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E01726;
        Wed, 13 Sep 2023 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694604472; x=1726140472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvyS9h29rxXO++HG5tqnYH6VKjq9TUqHDJ6u+kr5SYI=;
  b=Zq/3X9w5Mm/ccbl87ImuK5qaQ1xWCM/76hkVcxMyyEhbFGL7IzJovyUf
   5jEBJdYvK4jJV2wXoI8Ergcqsi9dop8LbCTxZxwkHGOD2ImkOzqowrhge
   PBWx9FL913HbxJzs/y9wAfXruiLzv/YkMDDtzzHNrx5z4rlk6eec/PivM
   u/EsLIF89MfhdL6Yph7bgVQArJ4XFlNPPdyZqOzhgrbNlhNBD8Z4P9RWV
   ThNWQRldaSez95diY7pxVHa6Nx+mMZE8vRlE3x9m+U07Y+CBUiZx+WY+N
   f5bxMmfMvXId/N5ek+vISZ+o0XmHd8tnxAbRnvandmWQlshoaMsbolbgZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="465003474"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="465003474"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="859234116"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="859234116"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:27:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qgO26-008qmJ-2v;
        Wed, 13 Sep 2023 14:27:46 +0300
Date:   Wed, 13 Sep 2023 14:27:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael.j.wysocki@intel.com, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [RFC v1 0/2] Fix symbol export for _SIMPLE_ variants of _PM_OPS()
Message-ID: <ZQGcss2G0hSAM5OR@smile.fi.intel.com>
References: <20230913074032.27927-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913074032.27927-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:10:30PM +0530, Raag Jadav wrote:
> Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS() set of
> macros to export dev_pm_ops symbol, which export the symbol in case
> CONFIG_PM=y but don't take CONFIG_PM_SLEEP into consideration.
> 
> Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM handles
> and are only used in case CONFIG_PM_SLEEP=y, we should not be exporting
> dev_pm_ops symbol for them in case CONFIG_PM_SLEEP=n.
> 
> This can be fixed by having two distinct set of export macros for both
> _RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the export of
> dev_pm_ops symbol used in each variant depends on CONFIG_PM and
> CONFIG_PM_SLEEP respectively.

From my point of view this cleans up a bit the initial idea and
maybe a good stuff to apply. But I leave this to the maintainers
and Paul to decide.

-- 
With Best Regards,
Andy Shevchenko


