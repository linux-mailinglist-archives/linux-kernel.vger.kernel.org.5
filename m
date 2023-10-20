Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE67D10A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377419AbjJTNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377327AbjJTNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:42:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688D19E;
        Fri, 20 Oct 2023 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697809337; x=1729345337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5II17EGmJAiyNI3Q5XungjMq7Um49xLUOEDi/+9mSCY=;
  b=NAxTgd4r9MzpxP1FvLhVXHeY++F9KEy7WTlj0QA4LAYXJ9qfqbdvYjNp
   mCnO3Xesxv6B6gT2rVv0cejIyb7hgyPy23hbLRNlso4tVlnsqgRZZRS4s
   kOKMM30rNt+ocOqA7n5YHokg0frBpFHJ0DDQxVeNeGRcPRPHCHFklkCDe
   JSxFF2EWkaeOk8J4el6MU53xn9pVBNDS/K7wH6o803J5oXjFrSEh2EGAS
   JfIRiM380K87bc5hFh81CGz6gSA2elratP8xqA0RKzZP455AMEa8dmOPE
   0YTczm+ANi2TReZH00ZhxftGt6xvzMBN+6ZAD1yvv3FDgkiH0jVGJM8re
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="5107841"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="5107841"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 06:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1004612299"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1004612299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 06:42:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtplQ-000000079Xz-42iV;
        Fri, 20 Oct 2023 16:42:08 +0300
Date:   Fri, 20 Oct 2023 16:42:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTKDsBPraERaautV@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
 <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 02:38:06PM +0300, Raag Jadav wrote:
> On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use standard ACPI helpers.
> > 
> > Yes, while not so obvious this is the correct replacement.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think this is the only case which would suffer from the more obvious
> behaviour, i.e.

No, that's not true. The same with override CPU in the other patch, where the
check is simply absent, but the result will be the same. So, all with negation
will suffer from the "obvious" implementation.

> bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> {
>         const char *uid1 = acpi_device_uid(adev);
> 
>         return uid1 && uid2 && !strcmp(uid1, uid2);
> }
> 
> That said, we can't be particularly sure about it's potential future users,
> especially when the usage will not be limited to just ACPI core since we're
> exporting it.

-- 
With Best Regards,
Andy Shevchenko


