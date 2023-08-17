Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8877F3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbjHQJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349110AbjHQJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:43:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295E82D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265426; x=1723801426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XbwI3JyLlomrBLFGmIHOSWGtp5Mg7Zvt6rSwaY/KlnQ=;
  b=DDYYq/5Hd2MlnR7CEmm6kqDMm8CWwn3/ku53P0EFoe4xAwHXHnZLu9TH
   zCIEoUAMzZj1TMHjCXV+ynxJ0e2ryT0uRMImNV1M1qHWAGx1hZAwMwLDU
   qULcYr//u9Ixml2x41WM6p63jpMYx/na8H4tJ5aHODEAyR3TsjHqY711H
   OHWfZgLs1KF2elfS0mPRv+sNo3Q7g/JMMhWDzf6uD6HWFoTRwogjKIYjj
   MZvh4YSeA6xlL7X3caEDMi4n3QexiUVWbSkDB0pl/UgsIa6cTm4Xy1xIE
   uD2d8zx2nqHGMZLnwt3GnlDX83EPMiqKgHEe8W2OiYy/CLy9lt4xL3rbt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403744604"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403744604"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="728074000"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="728074000"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2023 02:43:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZXa-005hVL-2o;
        Thu, 17 Aug 2023 12:43:42 +0300
Date:   Thu, 17 Aug 2023 12:43:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 2/8] bitmap: add test for bitmap_*_region() functions
Message-ID: <ZN3rzu7HVxx4pUbR@smile.fi.intel.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815233628.45016-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:36:22PM -0700, Yury Norov wrote:
> Test basic functionality of bitmap_{allocate,release,find_free}_region()
> functions.

...

> +	for (order = 0; order < 10; order++) {
> +		pos = bitmap_find_free_region(bmap, 1000, order);
> +		if (order == 0)
> +			expect_eq_uint(pos, 0);
> +		else
> +			expect_eq_uint(pos, BIT(order) < 512 ? BIT(order) : -ENOMEM);

			expect_eq_uint(pos, order < 9 ? BIT(order) : -ENOMEM);

or if the intention to show the relation to 1000,

			expect_eq_uint(pos, order < ilog2(1000) ? BIT(order) : -ENOMEM);

> +	}

-- 
With Best Regards,
Andy Shevchenko


