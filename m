Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F57CDC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjJRMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjJRMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:52:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0A116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697633562; x=1729169562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFRykA9qO6f1M+eErBq6qWJ1MUa45/kg2R+tq08YzPo=;
  b=DiofOomW+ky5qV0qL8qjdeJkt/S1YNDXuZr8pGOKqw2c9l9x0g5U2znS
   G9LxS90W1/OwcVNYZciExb/8NBIlKgpBFMSE/1lyqeCLQRYODnlT5vW0v
   BJ64jkhVLDRjRBupDp2Q6qkmvn64zaAymWSp1qHKNDBbkbNflXABcQS9j
   0E+5g2DFmbtk3fREVSoTbmoLYjtSK9eYYnQNySpIEGiSXVveL0v3cIwtr
   CHuRPNEWqfMqhFsmclCV5Ikfrml326AWkqZ73FbtrVntw3NqFiI/cBXXx
   ugfEINWhgLJ1EwZ2MwRbP2rtQUYCYRC6DoIzVTTixVRbFjnV2Cxv/HiWh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="371067697"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="371067697"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="750082057"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="750082057"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:52:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qt62O-00000006ajn-0ppx;
        Wed, 18 Oct 2023 15:52:36 +0300
Date:   Wed, 18 Oct 2023 15:52:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [rft, PATCH v1 0/2] drm/i915/dsi: An attempt to get rid of IOSF
 GPIO on VLV
Message-ID: <ZS/VE3w7bafj+Kuu@smile.fi.intel.com>
References: <20231018051052.1328852-1-andriy.shevchenko@linux.intel.com>
 <0c88666a-ff36-b649-d244-ccce500b6c2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c88666a-ff36-b649-d244-ccce500b6c2f@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:09:35AM +0200, Hans de Goede wrote:
> On 10/18/23 07:10, Andy Shevchenko wrote:
> > DSI code for VBT has a set of ugly GPIO hacks, one of which is direct
> > talking to GPIO IP behind the actual driver's back. An attempt to fix
> > that is here.
> > 
> > If I understood correctly, my approach should work in the similar way as
> > the current IOSF GPIO. 
> > 
> > Hans, I believe you have some devices that use this piece of code,
> > is it possible to give a test run on (one of) them?
> 
> Yes I should be able to find a device or 2 which poke GPIOs from the
> VBT MIPI sequences. Unfortunately I don't know from the top of my head
> which devices actually use this, so I may need to try quite a few devices
> before finding one which actually uses this.
> 
> I'll try to get this series tested sometime the coming weeks,
> depending on when I can schedule some time for this.

No hurry. maybe you simply can add into your usual tree you run on your
devices?

-- 
With Best Regards,
Andy Shevchenko


