Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1212E7BC5E0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbjJGH40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbjJGH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:56:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2889F0;
        Sat,  7 Oct 2023 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696665376; x=1728201376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w37Uw2egK4TMI1TPq7330xWPQb1w+wAKmOmwEmrT3m8=;
  b=KxQPJxvSJ7vrl00Wpujm7aNarHRDKPbrhBXv4qCBbVyyG4u7Z99DkiQe
   xm/WUTnH7dnvva+TNQ8xN7U8zOffqkVdWJ5+gWu1kmJ3pBdpMxJQIJlP5
   Ju9hshBQWoOLiLvLaIk6hozVT/pSUK45nb29rcTyjnP1byNPKvDOvQHuC
   7DRfsewY9NfKaM67oRKj5X0kXbRx0NS3kXoe1tPVMAOA9PDREUMh95jJy
   EvRfJjSV5MCErAX6ybmIcKmLdSkCRBrHqZ8bxHRaoa4WNqs1FAo6xPlbO
   sGcr7x76aZ95ShVvyJ8xLDvH2kh/D8Y1/a5PBd/dOEYOY8fuQ2NdfsR32
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="364189414"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="364189414"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="702318560"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="702318560"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:56:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qp2AV-00000003Y0V-01aV;
        Sat, 07 Oct 2023 10:56:11 +0300
Date:   Sat, 7 Oct 2023 10:56:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
Message-ID: <ZSEPGmCyhgSlMGRK@smile.fi.intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com>
 <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:47:57PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 6, 2023 at 8:33 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:

...

> >  struct acpi_ac {
> >         struct power_supply *charger;
> >         struct power_supply_desc charger_desc;
> > -       struct acpi_device *device;
> > +       struct device *dev;
> 
> I'm not convinced about this change.
> 
> If I'm not mistaken, you only use the dev pointer above to get the
> ACPI_COMPANION() of it, but the latter is already found in _probe(),
> so it can be stored in struct acpi_ac for later use and then the dev
> pointer in there will not be necessary any more.
> 
> That will save you a bunch of ACPI_HANDLE() evaluations and there's
> nothing wrong with using ac->device->handle.  The patch will then
> become almost trivial AFAICS and if you really need to get from ac to
> the underlying platform device, a pointer to it can be added to struct
> acpi_ac without removing the ACPI device pointer from it.

The idea behind is to eliminate data duplication.

> >         unsigned long long state;
> >         struct notifier_block battery_nb;
> >  };

-- 
With Best Regards,
Andy Shevchenko


