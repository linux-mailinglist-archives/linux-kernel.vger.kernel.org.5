Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A24811ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379108AbjLMRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:24:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A8C99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702488248; x=1734024248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axOd2gFtOVuNLnNaLR6jwzhzW7u9PcfcbFjtLnQveuU=;
  b=OY09HHkWcjQqUMf3mfJlny2P+jwOZ5jDmxFT0b0152N08BXVDhlHg4oV
   JUdNGCRJNH0Iz2jr3Z1WJ7JLemsAYnBhqwN0XxvT/fUbGL5MpSEGpjKep
   Q/loPdx+HZWEWlEyw9Y4RxObGXvsc93mq1DPlhsAAdLypCAEQEcpNzpuC
   bHIiaR4uT8xMkizQKDVge4/Dzd66TuXQUtlgJeayRjG1eOvjwHDyOpYib
   +JMcQdjfymzE4Au0deGrRUAn28aQqVET9RKeFckeNXB9SQgYdMDqqzzbM
   S+f1EoGnudnzsenUElsYeEoRS7Vlnz3NQgQ9kxZlvMaL0s07sUZFnBUq/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481194357"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="481194357"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808233941"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="808233941"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:24:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDSxm-00000005aul-3OdT;
        Wed, 13 Dec 2023 19:24:02 +0200
Date:   Wed, 13 Dec 2023 19:24:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 01/40] ARM: ep93xx: Add terminator to
 gpiod_lookup_table
Message-ID: <ZXnosnuRKFQL5XDo@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-1-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-1-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:18AM +0300, Nikita Shubin wrote:
> Without the terminator, if a con_id is passed to gpio_find() that
> does not exist in the lookup table the function will not stop looping
> correctly, and eventually cause an oops.

Reported-by?
Fixes?

-- 
With Best Regards,
Andy Shevchenko


