Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C017D15F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJTSmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJTSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:42:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521B112;
        Fri, 20 Oct 2023 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697827365; x=1729363365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WMfwakjNhmNMrO7ju65Y5cogR7+j5gRlCvM47x+qd3o=;
  b=Ot9VgRz3E/MWvuFWLT6JXAQ5WvqCrOML7nvaJcLzQyJWc0j1RQFg0uIN
   BD/uspEMGw3bIkqg3wWrRvtYfJwQ/FmFQEwO/vGFI4heCMcATj9B7/5/y
   qPw6KEIABuCvA0kxHzS1rbzfhmPLStOJVzXGOOQrxlGGNjYT79cp3EROJ
   wlgW/DH+c1o1IrRitfb/oGfirFQfZAR8wCxXzZwjeT8Js6fMyRVskNA/V
   AydIP+OyJcBC2cMGbYxrBU9VHaiLKTGXOVoLf8WetNAyxUy6bhzVsyo4j
   fcVuju0KL6VyyLRcUYIdPcbrjq8OAQi8buz6N6BpkF6wtFwzYx+0yQKZ8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="472777694"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="472777694"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 11:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="901210420"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="901210420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 11:40:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtuSD-00000007ENH-29p8;
        Fri, 20 Oct 2023 21:42:37 +0300
Date:   Fri, 20 Oct 2023 21:42:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Raag Jadav <raag.jadav@intel.com>, len.brown@intel.com,
        robert.moore@intel.com, mika.westerberg@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 5/8] ACPI: x86: use acpi_dev_uid_match() for matching
 _UID
Message-ID: <ZTLKHULe1DlKs5BX@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-6-raag.jadav@intel.com>
 <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
 <CAJZ5v0gqFgkhPHudqYUdg8ZgbEtF0Jf1ATbYACYEq3fNyaDW2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gqFgkhPHudqYUdg8ZgbEtF0Jf1ATbYACYEq3fNyaDW2w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 07:05:37PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 20, 2023 at 12:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 20, 2023 at 02:17:29PM +0530, Raag Jadav wrote:

...

> > > -                     if (!adev->pnp.unique_id ||
> > > -                         strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
> > > +                     if (!acpi_dev_uid_match(adev, override_status_ids[i].uid))
> >
> > The check for NULL argument inside that API does not affect the behaviour as
> > otherwise it will be a crash with the current implementation.
> 
> What current implementation do you mean, exactly?

strcmp() against NULL will crash the system.

-- 
With Best Regards,
Andy Shevchenko


