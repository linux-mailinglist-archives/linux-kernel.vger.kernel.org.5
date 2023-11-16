Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337267EDE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbjKPKPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjKPKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:15:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0ABD6F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700129727; x=1731665727;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5BlnmANSnRsKUHJF/sb0ywtqgmtFH8pDdWcj5GLx5m4=;
  b=S5wdy5uTwnNC8a8ZzyCeAZT8+eM52EOMKFIhRbqYRESYElwgOce6eRXM
   FtCxIuVNxb+E2royrZoGn8CGLOqQpUWatXwMddXcaBqy9bXYvlGQbfu+k
   sS3X7/mbZ38veMMDPc+5esSghwNTNgCW1MZMJYK01ScAjg3bCsqTjJGuG
   nUhcli0qdGySJH+8WWoo7uhtL3FpFzMWfqGipZVTl3QosE2luEU4eLsZ+
   Jc1sx4Kmu05Ttw5y6W5tdohnQJ33JkBBOT1tSrgzzuNmVmjcDgBATjf0L
   /+gdEJX4pb8NeA5/yNmL3TXe6u1eic+M9edAajogA8RtbcMxCEIIXndbW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9701219"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="9701219"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 02:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096746142"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="1096746142"
Received: from oroos-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.41.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 02:15:05 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [rft, PATCH v4 00/16] drm/i915/dsi: 4th attempt to get rid of
 IOSF GPIO
In-Reply-To: <e66638b0-bbad-4ac7-ad93-6fb0c6147005@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
 <e66638b0-bbad-4ac7-ad93-6fb0c6147005@redhat.com>
Date:   Thu, 16 Nov 2023 12:15:03 +0200
Message-ID: <871qcqqa1k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023, Hans de Goede <hdegoede@redhat.com> wrote:
> Ok, this now has been testen on both a BYT and a CHT device which
> actually use GPIO controls in their MIPI sequences so this
> series is:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
>
> And the code of the entire series also looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> for the series.

Thanks Andy & Hans!

I'll merge this once the test results are in. The BAT results have been
a bit flaky recently, so needed to do a rerun.

That said, I'm not sure if we have any hardware in CI that would
actually exercise the modifications, so in that sense I trust Hans'
testing much more.

BR,
Jani.


-- 
Jani Nikula, Intel
