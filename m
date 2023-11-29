Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5957FD406
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjK2KVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjK2KVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:21:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9AFC4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701253302; x=1732789302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1OANlnFyegrkKeeSHVlg2MtjIVJpeTaih5wCKnJLk6Y=;
  b=AjkAgYWfCbIJulmT4RmBLhgC1o82YBBM7xyR9caV8IMwdkLh+NJnNEuD
   tUdqlPdOJg4X6pvsLE/p8KdQE3j0sn5YsdOEAfOhkpZb62JabDbbkhh28
   IHCkyS9sqqOMth3RVnWc0EXvVfCoxJ6wcRT9lwDB3xeawMI3N3/HwcLML
   +Q+UoIadbJ4WeOsd1eCnrobTaHMVRis24VvaYFRzbWKmO7rTYZVnI94iR
   wPEJYMHhp5C6bx40Z2bnHYSNhIsY5+yX5+/8nJaBQM2bhcXUvJPL/2M8v
   CDZpvbAIm+lJGuAZrtwqUt3Fl/AmImOwAxzF4/uO6VnMN0vsWKm3U2qAY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="122551"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="122551"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:21:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1100477119"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1100477119"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:21:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8HhE-00000000PiH-2qiz;
        Wed, 29 Nov 2023 12:21:32 +0200
Date:   Wed, 29 Nov 2023 12:21:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Wentong Wu <wentong.wu@intel.com>, gregkh@linuxfoundation.org,
        tomas.winkler@intel.com, hdegoede@redhat.com,
        alexander.usyskin@intel.com, zhifeng.wang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Message-ID: <ZWcQrHs_fpqo80iX@smile.fi.intel.com>
References: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
 <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
 <ZWcD18B916Xs1JiU@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcD18B916Xs1JiU@kekkonen.localdomain>
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

On Wed, Nov 29, 2023 at 09:26:47AM +0000, Sakari Ailus wrote:
> On Tue, Nov 28, 2023 at 08:34:06PM +0800, Wentong Wu wrote:

...

> I wouldn't mind having a single Kconfig option for the two drivers either.
> They're always used together, aren't they?

As far as I understand the topology, here we have one "core" driver and
one "leaf" driver. So, in my understanding they may not go together as
it will bring unneeded code in the future in some configurations.

-- 
With Best Regards,
Andy Shevchenko


