Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A587D7324
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjJYSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJYSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:21:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D81E5;
        Wed, 25 Oct 2023 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698258079; x=1729794079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1XxRYZev688GItXPqGvO0ocX1uiRbGTVxSVwMDhhgRM=;
  b=gocPp/+NV/0biID18u4XD5TMjjrQSked8lNk7k/TZ4pCyW5qO1AcExtk
   ki6E07cZLQCvfvpCUTqpvTSM+ls2cVu/nDWZVlj0SQeqWOK2IykT+s0qM
   9WuO2dgjlO9JumKcbnt6Ot/8YMT5mF1xDVKNDkWyZM3FF1vcmTdnIj4mq
   t2RJyQE5WhECrjR+0JG4ubvwE+WmRCyIt4EZVCY6TJ+Cjn7m7R1yt/g/G
   U2XGL801wntGxU1ud/RY8DjZc4XOTyTtkJNbeIOLWhRj92+BKHFECFCgl
   XFBWjTdzH4KQ4sDdGQgAlrm+2XolYHRjDN1V7J58yJyLEbsCNq78HldPC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="155295"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="155295"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735475743"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="735475743"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:21:15 -0700
Date:   Wed, 25 Oct 2023 21:21:12 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        len.brown@intel.com, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTlcmA0VpE2jsbUQ@black.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
 <20231025055345.GI3208943@black.fi.intel.com>
 <CAJZ5v0iYA3Qh=KQm_+XGm=jvLO=ZN-AyYx7DW=-EiqkE5LS19Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iYA3Qh=KQm_+XGm=jvLO=ZN-AyYx7DW=-EiqkE5LS19Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:04:44PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 25, 2023 at 7:53 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> > > Use acpi_dev_uid_match() for matching _UID instead of treating it
> > > as an integer.
> > >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I was about to apply this, but then I realized that it might change
> the behavior in a subtle way, because what if the _UID string is
> something like "01"?

I checked the git history and found below.

commit 2a036e489eb1571810126d6fa47bd8af1e237c08
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Sep 13 19:31:41 2022 +0300

    ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()

    ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
    an integer. Use it instead of custom approach.

    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Hans de Goede <hdegoede@redhat.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c4d4d21391d7..4d415e210c32 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,10 +167,10 @@ static struct pwm_lookup byt_pwm_lookup[] = {

 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-       struct acpi_device *adev = pdata->adev;
+       u64 uid;

        /* Only call pwm_add_table for the first PWM controller */
-       if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
+       if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
                return;

        pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));

So if we consider the original logic with strcmp, which is more inline
with acpi_dev_uid_match(), "01" should not be the case here in my opinion.

Thanks for sharing your concern though.

Raag
