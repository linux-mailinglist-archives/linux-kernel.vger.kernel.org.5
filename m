Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD27DF62F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346801AbjKBPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345957AbjKBPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:19:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2798E13D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698938378; x=1730474378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DX5pR7NmAB/MEaCN3ICH5f/PRJdWLrIDgdmhT6o1n2A=;
  b=EREIjL0zhBZyyfXaSLt9Y/Bq3/fNSDywjwm3Xy45RkEc9IhEeVpPiJJF
   iZm3rmuCjKRw32HntnO1ZTtg52kXGLzw7P4wM3N74ElEt5ZsaZTvHwvl2
   HhHYoOnw3ot54bOrH56vVDQFLGcDObDTkMsDkIRUKEhSz0m5AK8nVyjk2
   eeThqlzbIyTfAi6TD3h4QzYqVQnhDH37oRZX+zmUsnhtiN0rPFEyH+k+v
   dsDn+YpoOFEcvRBCtmxW1/eR/U4dunxbh43BX7+VOYqpqpOPClFZDpOd6
   ZtqPphRcvVLQcnuNMZEREKoeuNMjyIAvRhw7OAjxz7oLkTdBd2klQw+MF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1662575"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1662575"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="737785729"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="737785729"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:19:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyZTm-0000000AiqE-1HmD;
        Thu, 02 Nov 2023 17:19:30 +0200
Date:   Thu, 2 Nov 2023 17:19:29 +0200
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
Subject: Re: [PATCH v3 10/15] drm/i915/dsi: Fix wrong initial value for GPIOs
 in bxt_exec_gpio()
Message-ID: <ZUO-AbXmr7mpiJuI@smile.fi.intel.com>
References: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
 <20231102151228.668842-11-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102151228.668842-11-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:12:23PM +0200, Andy Shevchenko wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> Fix wrong initial value for GPIOs in bxt_exec_gpio().

Oh, and forgot to update the function name in this patch.

In any case I would wait for Hans to confirm it works (and probably he may give
a formal Tested-by tag) and then will send v4 to be applied for real.

-- 
With Best Regards,
Andy Shevchenko


