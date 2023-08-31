Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941D278EE73
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjHaNVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHaNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:21:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F7BCEB;
        Thu, 31 Aug 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693488096; x=1725024096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HCLaDrmLaIsFO9VZ6gs0Y8FPC++yBu4gaEkTIHM/aXs=;
  b=Cg5e3huP6dxg8UaYk1EIRx1to9Z8oL4sHAbV6AdlUJD+KC7UULZBZBDv
   Td+jRVRjaxALvQNBdW/paqLNfJqlH4Flnym8RC9+W4el8euolRBM9aW05
   DBJ8jyZO51WioV7ol7dJNgGlIkAhLKc6xkSrOdCbdvFkwCR/HNxwb6bQq
   JBV82Op4tNU1seuo1z1ZYUU82b3gJUtT8+mW3PJSB1b+pnP/+dPvODmDS
   ojZ7jW432cdObpnOaz0GZzAj8eojgvlULeHG4KemZoA/ooYuT7uwoXhXr
   LyDY0M5goJSTWMIhRPfdfeR8ueFCIM33rlp10+T3vYandK7vV3J+5fsRQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355440088"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="355440088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="733085316"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="733085316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:21:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbhc3-005Obk-0f;
        Thu, 31 Aug 2023 16:21:31 +0300
Date:   Thu, 31 Aug 2023 16:21:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Message-ID: <ZPCT2vV0r8l/wxim@smile.fi.intel.com>
References: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
 <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 04:49:07PM +0200, Alexander Lobakin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Thu, 24 Aug 2023 15:37:28 +0300
> 
> > It may be new callers for the same macro, share it.
> > 
> > Note, it's unknown why it's represented in the current form instead of
> > simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
> > bitfield type") doesn't explain that neither. Let leave it as is and
> > we may improve it in the future.
> 
> Maybe symmetrical change in tools/ like I did[0] an aeon ago?

Hmm... Why can't you simply upstream your version? It seems better than mine.

> [0]
> https://github.com/alobakin/linux/commit/fd308001fe6d38837fe820427209a6a99e4850a8

-- 
With Best Regards,
Andy Shevchenko


