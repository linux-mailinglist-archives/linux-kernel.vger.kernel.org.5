Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2768B7B4693
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjJAJ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjJAJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:26:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F33C5;
        Sun,  1 Oct 2023 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696152363; x=1727688363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yEtFqc31BYHmQugRYmLnl7wLrdlolit/SsBWc+E4vIs=;
  b=Kh+bCi0BxuAesCdsXg1hK4aTW0ABJNtb14lJBqkuKTJC6txDiWrF+AJw
   Ny/HBU13RQ5rIFwCNTJcC1/wL8gU1SYgxZgM9vv8Guru2t8zSumD0By3L
   bhFGl4odnl4tpDxwWtAT6W1xYR6wo2m+JpjRfraswephw8aFiFW674TkA
   EAOz1XIlQenrJjzFwZnryENdLxZMAcwe8JwmSZAqsg0Ejn17tjJiXUTFL
   /BN7zIAKOWw3CIJONaBLlSyCK/bc3JdODh1CVaBJ2HZ1xP8DeHsQlxR6y
   yvNpgRKoqr0laRUytRYp+GM2y2RWyekYDxC/XJpSJNE7xd7EoJpUJh7ea
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="449001274"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="449001274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 02:26:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="743850890"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="743850890"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 02:26:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qmsi6-00000001rbs-3naz;
        Sun, 01 Oct 2023 12:25:58 +0300
Date:   Sun, 1 Oct 2023 12:25:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wentong Wu <wentong.wu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ipu-bridge: Add missing acpi_dev_put() in
 ipu_bridge_get_ivsc_acpi_dev()
Message-ID: <ZRk7JrCxUhgJ/zhf@smile.fi.intel.com>
References: <0e8fa862e2d3da5897d0f895322d469e7d5aa052.1695979848.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8fa862e2d3da5897d0f895322d469e7d5aa052.1695979848.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:31:33AM +0200, Geert Uytterhoeven wrote:
> In ipu_bridge_get_ivsc_acpi_dev(), the "ivsc_adev" acpi_device pointer
> from the outer loop is handed over to the caller, which takes proper
> care of its reference count.
> However, the "consumer" acpi_device pointer from the inner loop is lost,
> without decrementing its reference count.
> 
> Fix this by adding the missing call to acpi_dev_put().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


