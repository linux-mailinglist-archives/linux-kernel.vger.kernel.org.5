Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9F7F16A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjKTPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjKTPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:03:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF3D72;
        Mon, 20 Nov 2023 07:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700492600; x=1732028600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XD144tY1SUS/e9n/Sng5IXSmD15Fyn6Y6l/2wUYcIcA=;
  b=N52dy9MuVynoSi1a0JOj/yfPVjk9FM+ejVgGRvapQw9tVRYcqmG2WRNv
   1S07kWrZ6LiUl//+aXqx1hmWGPfH4/9zNMjb+1B4kh4tptTD+yskQLfrG
   YHPWud8izSyyGVreZ9ziaqFZLR7wY+vMetqYv46wh25UJizy1Lp1ZlOe5
   ui09HEWSgBiQj3rjAor0ze9KFj5gXeowccUaMpvPLyPQKlzgtINschDZO
   rgInK5limZEyE83JTJZ8SGcBUji34mzenuM7cE5sTfJtBYJVEscOk899z
   R7Def9ti6Ww4M3Z68Lc6OWZr+VdmqOhnV3CXMyPs0zJ1rX/fEhJEiqzYz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4820555"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4820555"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939814693"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="939814693"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:03:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r55nj-0000000FZzA-2YQd;
        Mon, 20 Nov 2023 17:03:03 +0200
Date:   Mon, 20 Nov 2023 17:03:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <ZVt1J_14iJjnSln9@smile.fi.intel.com>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
 <6531d1e01d0e1_7258329440@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6531d1e01d0e1_7258329440@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 06:03:28PM -0700, Dan Williams wrote:
> Andy Shevchenko wrote:
> > The acpi_evaluate_dsm_typed() provides a way to check the type of the
> > object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Looks good to me.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thank you!

Who is taking care of this? Rafael?

-- 
With Best Regards,
Andy Shevchenko


