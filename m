Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50027ADC46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjIYPsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjIYPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C4CE3;
        Mon, 25 Sep 2023 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695656858; x=1727192858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+K5Fipx1dZqTJlRL8mpcXqKkwlqbuDzbtNFslPySHKo=;
  b=Df785+r9pwtw9+jKeRX2x1aIjh4b+jN+bMkuHwUGalKPq2tNpbajenCV
   U16XpGRVBrQikPbUAAvSEU8CO/DUuif1095tb33lrgPa3OKo+6uxzQ3AU
   F+MwlxDkp8n7DVErRcunH3udqKpK2VGKglrwTIkcnvjBTFbKz+svCl+zd
   vWke0SQT3pJ0Z3aau5Ae/e9QOJGurnmV2vtZL6kXPPNeKOxAXB0bmxOF6
   AVi9RBSubYyzAUpJRUuKy/MB6vzbqwjtbIbGirf599m5O5sYQzip9uWFB
   Gf8rVvkKH41QwPKIA78Q2btbWvvTQ9hJvr04eG1RrMo/FrSSi+FfFOL0N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445394509"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="445394509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814019337"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="814019337"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:47:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qkno3-00000000Nnc-1SGH;
        Mon, 25 Sep 2023 18:47:31 +0300
Date:   Mon, 25 Sep 2023 18:47:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com
Subject: Re: [PATCH v1 9/9] ACPI: NFIT: Don't use KBUILD_MODNAME for driver
 name
Message-ID: <ZRGrk8/0UMd9FuFH@smile.fi.intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-10-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925144842.586829-10-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:48:42PM +0300, Michal Wilczynski wrote:
> Driver name is part of the ABI, so it should be hard-coded, as ABI
> should be always kept backward compatible. Prevent ABI from changing
> accidentally in case KBUILD_MODNAME change.

This is up to maintainers, probably we won't have any users outside of existing
model (instantiating via ACPI ID). All the above is "strictly speaking"...

-- 
With Best Regards,
Andy Shevchenko


