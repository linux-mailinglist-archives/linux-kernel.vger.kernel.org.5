Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CA77CF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbjHOPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbjHOPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:45:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC210FF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114328; x=1723650328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24HZ+W3/BPWICRHz4YSlTU3HA8tS2LdPxwy0RPTELLA=;
  b=OUwHMgNAtlWPfwOsrU7BWNcqvxwINj71NJ/LOe7peOFgEM8XaSXkQk2q
   q+kUOgoxZwLb8Ndf8M/tmCamihCy492uc9YC7kvIBc9TeEDNwpUFTGW5e
   QxaaRr5O2efRysMlIHxowEJQ/QbXuq58nZv0P9A26vnu355YN+gCEYJ6/
   adyiU38Gxz9P7IFiabPseh9/6b3Qyvvs9AL54Ha0JTiQLO6ERCbkDuElv
   cy8OHQkvTu0TQ+laRKWk4c1HvUw+Fc8mb+/AQl+g37B8p4oIP+eH3dkD9
   N7acpw81IjvTq4MBpGUH+5Tc2E6mM+UylPxhBZypDc0FxDK7wZK/aHJRQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362458983"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362458983"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733882453"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733882453"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 08:45:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qVwEV-007spR-1c;
        Tue, 15 Aug 2023 18:45:23 +0300
Date:   Tue, 15 Aug 2023 18:45:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/25] ASoC: dmaengine: Convert to generic PCM copy ops
Message-ID: <ZNudk4147ByqSNdP@smile.fi.intel.com>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-22-tiwai@suse.de>
 <ZNuE5UunDd40e8vW@smile.fi.intel.com>
 <87wmxwxsmb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmxwxsmb.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:55:24PM +0200, Takashi Iwai wrote:
> On Tue, 15 Aug 2023 16:00:05 +0200,
> Andy Shevchenko wrote:
> > 
> > Can be compressed to a single conditional:
> > 
> > 	if (is_playback && copy_from_iter(dma_ptr, bytes, buf) != bytes)
> 
> I prefer keeping the changes minimalistic in this kind of conversion
> unless it becomes too ugly.  Then it's more clearer what's actually
> changed.

Fine by me!

-- 
With Best Regards,
Andy Shevchenko


