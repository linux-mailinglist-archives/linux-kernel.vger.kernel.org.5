Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C927D9B90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbjJ0Ofw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346136AbjJ0Ofu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:35:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05801B3;
        Fri, 27 Oct 2023 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698417348; x=1729953348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fH8jf7Ty5A/dlTOoUqTjFRJ6N8Oq7tW+7xDYH8Bdocg=;
  b=U2RZ8Skep3/EDTDaM/5/jWxhjkwHB9qTz3F55qSlK32ApUNsiWr63olH
   7CSeT6fahBwwxjGzfg8vmOUjeYoYxbhSMZ1LGHPXXLXKBiUEtecPkZj1u
   /KZT8Pzc/oUX8542cRqkeMltHzoHsgLqq5AQWDgjhjGCTHPoST1nFWGkQ
   wOEDBIkJB9mFRjQD4FA2j4yyWtPBTVPY7m/CZjLaqfc0um+6UsMg8UiSD
   0Es+UeTzRr18CtoZQALbAZs0WCB4QZiAEq+D4AAn72uxNWKOTIk4/R/UQ
   Ebf1cTJQn0XulF065ZbBSyyGzB38BpyBQqhzlkbvL5SBs7gMAQMatPFsf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="367127575"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="367127575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="709428757"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="709428757"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2023 07:35:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 72E65263; Fri, 27 Oct 2023 17:28:56 +0300 (EEST)
Date:   Fri, 27 Oct 2023 17:28:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <20231027142856.GL3208943@black.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
 <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>
 <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:17:12PM +0300, Raag Jadav wrote:
> On Fri, Oct 27, 2023 at 01:12:02PM +0300, Raag Jadav wrote:
> > On Fri, Oct 27, 2023 at 11:18:55AM +0300, Mika Westerberg wrote:
> > > On Thu, Oct 26, 2023 at 02:03:35PM +0530, Raag Jadav wrote:
> > > > Now that we have a standard ACPI helper, we can use acpi_dev_uid_match()
> > > > for matching _UID as per the original logic before commit 2a036e489eb1
> > > > ("ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()"),
> > > > instead of treating it as an integer.
> > > > 
> > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > The change still looks good to me, however I wonder if we could maybe
> > > improve acpi_dev_uid_match() to support both data types possible for
> > > _UID? This of course is separate patch (unless there are objections).
> > > 
> > > There is the _Generic() thing and I think that can be used to make
> > > 
> > >   acpi_dev_uid_match()
> > > 
> > > which takes either u64 (or maybe even unsigned int) or const char * and
> > > based on that picks the correct implementation. Not sure if that's
> > > possible, did not check but it would allow us to use one function
> > > everywhere instead of acpi_dev_uid_to_integer() and
> > > acpi_dev_uid_match().
> > 
> > The way I see it, acpi_dev_uid_to_integer() is useful when drivers want to
> > parse _UID and store it in their private data, so that it is available for
> > making various decisions throughout the lifetime of the driver, as opposed
> > to acpi_dev_uid_match() which is more useful for oneshot comparisons in my
> > opinion.
> > 
> > So I'm a bit conflicted about merging them into a single helper, unless
> > ofcourse there is a way to serve both purposes.
> 
> Or perhaps something like,
> 
> bool acpi_dev_uid_match(struct acpi_device *adev, const void *uid2, enum uid_type type)
> {
>         u64 uid1_d, uid2_d;
> 
>         if (type == UID_TYPE_STR) {
>                 char *uid2_s = (char *)uid2;
>                 if (!(uid2_s && !kstrtou64(uid2_s, 0, &uid2_d)))
>                         return false;
>         } else if (type == UID_TYPE_INT) {
>                 u64 *uid2_p;
>                 uid2_p = (u64 *)uid2;
>                 uid2_d = *uid2_p;
>         } else {
>                 return false;
>         }
> 
>         if (!acpi_dev_uid_to_integer(adev, &uid1_d) && uid1_d == uid2_d)
>                 return true;
>         else
>                 return false;
> }
> 
> Although this looks unnecessarily hideous.

Indeed, but using the _Generic() you should be able to have
a single acpi_dev_uid_match() to work for either type so:

acpi_dev_uid_match(adev, "1")

and

acpi_dev_uid_match(adev, 1)

would both work with type checkings etc.

Not sure if this is worth the trouble though.
