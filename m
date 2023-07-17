Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED080755FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGQJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjGQJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:50:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39218136;
        Mon, 17 Jul 2023 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689587403; x=1721123403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QtTtGQw/S+xvGJPqdfDQEwcHBcc9XjHWbImgud/zv/0=;
  b=Lcys8TKM50N1XSsg8+cGVn66ZPSai+ZOw3UbY9PMPBYLr44g8lNqNj7e
   Apjd4pWCg2LGuzpQ7J7XkiYs5+NxCinOWGz0M3cJAFnvDi6iSlQ0iXYzY
   GNkP53vHIXNUW6JlOHD0G4Y2XqoIs/wW0/rNJiOl0V09/yY1I295LIHxz
   UAKjk+emnzYam0K3lpEWfqtWcc1MGjXY9zBg17qJVjJlKmcuCvX7FVdN9
   vVXjYaj5gdefIr4v5YI0zKQGI6nW7+1b6Das5AD4dUvLvvzIKmnQDsErG
   LqzXzkG/W9cu+KjeY2QDz3bK3l1PuiW6iQxRfyQ5qx0RWRtpi/LoBSzLv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="355827001"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355827001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866684630"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2023 02:50:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLKrf-0087YO-0R;
        Mon, 17 Jul 2023 12:49:59 +0300
Date:   Mon, 17 Jul 2023 12:49:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with
 invalid GUID
Message-ID: <ZLUOxnE58wUgZXWx@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230715211604.1272227-1-pobrn@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 09:24:16PM +0000, Barnabás Pőcze wrote:
> Since a WMI driver's ID table contains strings it is relatively
> easy to make mistakes. At the moment, there is no feedback
> if any of the specified GUIDs are invalid (since
> 028e6e204ace1f080cfeacd72c50397eb8ae8883).
> 
> So check if the GUIDs in the driver's ID table are valid,
> print all invalid ones, and refuse to register the driver
> if any of the GUIDs are invalid.

Besides using wrong API (uuid_*() vs. guid_*() one), I don't
think we need to validate it here. Why not in file2alias.c?

-- 
With Best Regards,
Andy Shevchenko


