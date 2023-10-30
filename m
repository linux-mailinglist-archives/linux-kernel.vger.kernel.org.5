Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF57DB780
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjJ3KMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjJ3KMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:12:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C488A65;
        Mon, 30 Oct 2023 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698660753; x=1730196753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7z2DxabdPBp6OSDf1FLw7CkIaI9qXRgDC3qvx+ROjjM=;
  b=lAiQ6hFOg00fU9r6o58k4Pa+VKl7SUecCpxahTivE0l1zjQoI+vvJdCN
   ZcdmfrMqON/S03RruzDoUvu20ArjHhszqPBmIJ0uLOY772qBZQ7dGzBs0
   4tnEQ4044syn1sRoZ5Jh4+fEd73MBEA+yDxmoB/mZyPiKdDrGRQd+OR3t
   BI2s9QSKcu4b/LGCi0Rh377M7BfJ5P5zl1E6hiMHCznG5tXML7aVJtRA5
   ni/QqZcrHRN37mguTAEB9PnkC3HD4EJn1UgyRPQlQ48e8Om5tHD0l4oB0
   7UBqwK3P9m/pTSGOEUL+UKlhU4ByGfAqJ80unQJ7BubbGGBxJXl7WLeju
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="378418140"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="378418140"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 03:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="736695839"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="736695839"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 03:12:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxPFz-00000009rLX-2VKR;
        Mon, 30 Oct 2023 12:12:27 +0200
Date:   Mon, 30 Oct 2023 12:12:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        len.brown@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZT+BiykmKepdAA8K@smile.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
 <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>
 <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
 <20231027142856.GL3208943@black.fi.intel.com>
 <ZTvqYwFWm9PQeKIU@black.fi.intel.com>
 <CAJZ5v0hkB6Lm82ie6hfzFVDaqEj7DYxnYxD5NRQNXZxKZjL+xg@mail.gmail.com>
 <CAJZ5v0i6H3aaDv1pPoygSHLLNA9YUr2AkMus=Cbb=KvyV5BEpg@mail.gmail.com>
 <ZTzNBAPe0ToFUqIw@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTzNBAPe0ToFUqIw@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 11:58:12AM +0300, Raag Jadav wrote:
> On Fri, Oct 27, 2023 at 07:40:38PM +0200, Rafael J. Wysocki wrote:

...

> We'd probably end up with an oops trying to strcmp into a random address
> without knowing its type, so I think Mika's would be a better approach.
> 
> #define acpi_dev_uid_match(adev, uid2)                                                          \
> ({                                                                                              \
>         const char *uid1 = acpi_device_uid(adev);                                               \
>         u64 __uid1;                                                                             \
>                                                                                                 \
>         _Generic(uid2,                                                                          \
>                  int: uid1 && !kstrtou64(uid1, 0, &__uid1) && (typeof(uid2))__uid1 == uid2,     \
>                  const char *: uid1 && uid2 && !strcmp(uid1, (const char *)uid2),               \
>                  default: false);                                                               \
>                                                                                                 \
> })
> 
> This one I atleast got to compile, but I'm not very well versed with _Generic,
> so this could definitely use some comments.

If you go this way, make _Generic() use simple in the macro with a help of two
additional functions (per type). Also you need to take care about uid2 type to
be _any_ unsigned integer. Or if you want to complicate things, then you need
to distinguish signed and unsigned cases.

P.S.
All to me it seems way too overengineered w/o any potential prospective user.

-- 
With Best Regards,
Andy Shevchenko


