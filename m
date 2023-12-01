Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE61C800F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjLAPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLAPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:48:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63355F3;
        Fri,  1 Dec 2023 07:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701445714; x=1732981714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S1Dd8iISz5gAjTwi1OBZoZTrthWL/j69ur54GuLmsic=;
  b=kyT1GHMBe/n4qvhwJtshUbrgGU3WxrNNbWzBsztO5qd/5K7P2L3f82v5
   y7b0NbZFgUHE4gukuO6EGzR2Q/xlcjJ+Mrz+WvOByX9egAEEjsyoHsz28
   otINppgYH5osZPwCDXSQ8/+Y0v72HVIr2289NGyvvSPxT/kUR5Rm/OpQ8
   UUW0H0E6fFpKQKZQz9MdD4wUnB9HNXMHlVoQUyg7Q37VUYb9soCDlZQGv
   anEdzLRRKG4pG8GbzF4lc++MZB9/hHv0LN6Kk5Sp6aOu6y3hu1Mtg79uc
   bC822ikgqseAEXiuZ2b3JcBs2rWUUKaHlGuGdtxLacPg6GcIvec4T6V8a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="392376910"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="392376910"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:48:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887693817"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="887693817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:48:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r95kk-000000011m6-1Lyg;
        Fri, 01 Dec 2023 17:48:30 +0200
Date:   Fri, 1 Dec 2023 17:48:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] parport: Save a few bytes of memory
Message-ID: <ZWoATrl_K-xIjzw7@smile.fi.intel.com>
References: <0eba5f2ddd142ab0f577f67e482d1152b40ee720.1700860416.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eba5f2ddd142ab0f577f67e482d1152b40ee720.1700860416.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:14:36PM +0100, Christophe JAILLET wrote:
> Most of parport_register_dev_model() callers pass a 'name' that is a
> constant string.
> 
> So kstrdup_const() can be used to save the duplication of this string
> when it is not needed. This saves a few bytes of memory.
> 
> Use kfree_const() accordingly when this string is freed.

Looks good to have, hence no objection from me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


