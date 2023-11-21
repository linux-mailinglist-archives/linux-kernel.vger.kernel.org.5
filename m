Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2981F7F2A60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjKUK2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjKUK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:28:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D840DBA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700562524; x=1732098524;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JdJQAgpEzO62bU5aQympYnma9KVKNc9ObKEUCoAvNPM=;
  b=CDj7BFTjV1mfHuhrj2o9quJMG9BBorLMBfQbQNsaWRsRiDamNrTuzyYV
   XkKl8SE0pMRg3O91ywZD+0L2aAg6iK+le5WBHFrHcA9r6vWtx8WoAduop
   JHrP01Ml+POFbxka8zdr5Rz2X7UpelIUHm9MGfC/+SG+d6OYz8k2xcpSQ
   6KvPrUkgEYQCuP3h5NDzMgiiZ+pICXoo/Jc1wt/lqL8AwQIdssnyMNAG5
   jKSyNpLiOJXgJC1qrbbK0p14d1E4W2HDmYD0e7H6NCbc6gxRuSvi8y/X9
   glPcITgng8qrumY4cP1i+k+QUNy65VQuR2ql07PWD3Didd7U7cLFMxqWy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371984825"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371984825"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:28:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716485408"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="716485408"
Received: from cdeakx-mobl.amr.corp.intel.com (HELO localhost) ([10.252.58.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:28:40 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [rft, PATCH v4 00/16] drm/i915/dsi: 4th attempt to get rid of
 IOSF GPIO
In-Reply-To: <ZVfVsVDQ9j7nMsnW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
 <e66638b0-bbad-4ac7-ad93-6fb0c6147005@redhat.com>
 <871qcqqa1k.fsf@intel.com> <ZVfVsVDQ9j7nMsnW@smile.fi.intel.com>
Date:   Tue, 21 Nov 2023 12:28:37 +0200
Message-ID: <875y1vo0x6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Nov 16, 2023 at 12:15:03PM +0200, Jani Nikula wrote:
>> On Thu, 16 Nov 2023, Hans de Goede <hdegoede@redhat.com> wrote:
>> > Ok, this now has been testen on both a BYT and a CHT device which
>> > actually use GPIO controls in their MIPI sequences so this
>> > series is:
>> >
>> > Tested-by: Hans de Goede <hdegoede@redhat.com>
>> >
>> > And the code of the entire series also looks good to me:
>> >
>> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> >
>> > for the series.
>> 
>> Thanks Andy & Hans!
>> 
>> I'll merge this once the test results are in. The BAT results have been
>> a bit flaky recently, so needed to do a rerun.
>> 
>> That said, I'm not sure if we have any hardware in CI that would
>> actually exercise the modifications, so in that sense I trust Hans'
>> testing much more.
>
> Thank you!
> Should I fix checkpatch warnings CI reported about?

Nah, they're benign.

BR,
Jani.

-- 
Jani Nikula, Intel
