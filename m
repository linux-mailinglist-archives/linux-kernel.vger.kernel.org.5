Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA47DF624
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbjKBPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjKBPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:18:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1C5186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698938279; x=1730474279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Uzrbvx48qGjXpbAuwhyeliMci7jTovYf/GA8M3d6Rc=;
  b=aNx4RTGfDygODm/zwNVcGq6zmK0pyPQkCcA2ud3YvhogwAG0xwr4F6Fv
   tdSQIknAtu0E7OGcBIjQMhUOFAtARDFTvhI2NE//TkfE83X/ip8WkD8Hg
   39hKr9YHG1xUHejLO177qy0JIqHTRFA310LbxUhWP6yn4WqRrHjaWL3aN
   1NlvGBr10Q47esUc5sbHeG4tLhurEdO4kgqbQY7i0RA0Ps9ln+i5pMH6N
   GtWoWmZD3/KL5bMBo5pLOySzin8fLKfidg4qTZUZ9NxlwxQkjG7oQYhai
   bf66X9mF6XqkYpB43K4X5LSy7RRBbC7dY8EALRDD3cHnZoHY5sAazdaQL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="474977794"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="474977794"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1008491941"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1008491941"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:17:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyZRi-0000000Aind-3Sfa;
        Thu, 02 Nov 2023 17:17:22 +0200
Date:   Thu, 2 Nov 2023 17:17:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [rft, PATCH v3 00/15] drm/i915/dsi: 2nd attempt to get rid of
 IOSF GPIO
Message-ID: <ZUO9grtE_jLnBBjW@smile.fi.intel.com>
References: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:12:13PM +0200, Andy Shevchenko wrote:
> DSI code for VBT has a set of ugly GPIO hacks, one of which is direct
> talking to GPIO IP behind the actual driver's back. A second attempt
> to fix that is here.
> 
> If I understood correctly, my approach should work in the similar way as
> the current IOSF GPIO.
> 
> Hans, I believe you have some devices that use this piece of code,
> is it possible to give a test run on (one of) them?

Subject should be "3rd attempt ..." :-)

> In v3:
> - incorporated series by Jani
> - incorporated couple of precursor patches by Hans
> - added Rb tag for used to be first three patches (Andi)
> - rebased on top of the above changes
> - fixed indexing for multi-community devices, such as Cherry View
> 
> In v2:
> - added a few cleanup patches
> - reworked to use dynamic GPIO lookup tables
> - converted CHV as well


-- 
With Best Regards,
Andy Shevchenko


