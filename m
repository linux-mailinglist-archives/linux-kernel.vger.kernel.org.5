Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1859782768
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjHUKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjHUKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:51:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7843EE3;
        Mon, 21 Aug 2023 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692615098; x=1724151098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kSG+XXyvbQxg3qzWFZP2mEtfWeYqITpEykRJ6FYUFgc=;
  b=gtW+6oYFVZzPr0pGImPvGQk8WX6qgUWmJyD7IhiDpCN0aYMfGCO27WbL
   arm61yeA5nDuokJnsjb4CWM0vZJutclcPXz10buTwIS5GjPuDj+CkNS0e
   uYw93DXIrO+DQ9Ml/n4/jAp98T4UEI1xMUiblDLnntUx+s2odDgyyM/10
   gPsjrf6pD85ztwmDB4I8TwvEYg9szvCkF/xHrGD+5ZEufdb+TqK6/3fUw
   gH8gjjY5LbT73zBaOx0gZMBmYhg2KQe1mfAE9rJYrhsjLAG0CKFq77yUT
   jwt3L6O4ZBlSexiu6xZDRiKJlZCpBhg7oUQFOXWEzK/yDs7hAcl0eBGpL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="373528805"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="373528805"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="805885766"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="805885766"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 03:51:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY2VR-00AWD3-28;
        Mon, 21 Aug 2023 13:51:33 +0300
Date:   Mon, 21 Aug 2023 13:51:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] of: Refactor node and property manipulation
 function locking
Message-ID: <ZONBtfGVtzno6pY3@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
 <20230801-dt-changeset-fixes-v3-6-5f0410e007dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v3-6-5f0410e007dd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:41:01PM -0500, Rob Herring wrote:
> All callers of __of_{add,remove,update}_property() and
> __of_{attach,detach}_node() wrap the call with the devtree_lock
> spinlock. Let's move the spinlock into the functions. This allows moving
> the sysfs update functions into those functions as well.

With help of cleanup.h this may be made shorter and less error-prone.

-- 
With Best Regards,
Andy Shevchenko


