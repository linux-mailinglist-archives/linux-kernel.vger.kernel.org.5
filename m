Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1F7DDF82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjKAKeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKAKeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:34:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4CF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698834847; x=1730370847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gMjCzoMaHKDg/qjAgdM7VeECdzyLoxglZ7tETDrkcUA=;
  b=fWQVUy7yC+/LrB5KhLJsNpWKVCOhcqTKs9OdZvFxE+lGr6J0HTOqJgCH
   ca6SwLAoLcIAVi92EnBPh1lBHz5gZClO0Bnrp07ayq8eczGlm4WkJu/FJ
   oRz1oFFt7JxGTWVl8XGKUOi2PIFe1WD+f/9H6CD6qiTkpIb0XP7x+oEtz
   fV9ptbXCMoX852GobVrMvR979Cl/4YN3IvSVMpkA+WGvjDKubqn+dKiHp
   CGJK2A7hHHWUcjtqMqFpOAdLMzgV1pKNzis0fNoJ+n2c7ZJeffOotWa5Q
   vmygBoRyg7TszfXxAHvJ7IEvywVcl3XTbcAn7zX7ch773XzHVm6bg29mw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="392331343"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="392331343"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754438297"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="754438297"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 01 Nov 2023 03:34:03 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 01 Nov 2023 12:34:02 +0200
Date:   Wed, 1 Nov 2023 12:34:02 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV
 GPIOs behind the driver's back
Message-ID: <ZUIpmhYlqMXroHfV@intel.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
 <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
 <ZUIbPtEEbl6pjdqg@smile.fi.intel.com>
 <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:20:23AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/1/23 10:32, Andy Shevchenko wrote:
> > On Tue, Oct 31, 2023 at 10:15:52PM +0100, Hans de Goede wrote:
> >> On 10/31/23 17:07, Hans de Goede wrote:
> >>> On 10/24/23 18:11, Andy Shevchenko wrote:
> >>>> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
> > 
> > ...
> > 
> >>> As for the CHT support, I have not added that to my tree yet, I would
> >>> prefer to directly test the correct/fixed patch.
> >>
> >> And I hit the "jackpot" on the first device I tried and the code needed
> >> some fixing to actually work, so here is something to fold into v3 to
> >> fix things:
> > 
> > Thanks!
> > 
> > But let me first send current v3 as it quite differs to v2 in the sense
> > of how I do instantiate GPIO lookup tables.
> 
> The problem is there already is a GPIO lookup table registered for
> the "0000:00:02.0" device by intel_dsi_vbt_gpio_init() and there can
> be only be one GPIO lookup table per device. So no matter how you
> instantiate GPIO lookup tables it will not work.
> 
> The solution that I chose is to not instantiate a GPIO lookup table
> at all and instead to extend the existing table with an extra entry.
> 
> Although thinking more about it I must admit that this is racy.
> 
> So a better idea would be to unregister the GPIO lookup
> table registered by intel_dsi_vbt_gpio_init() after getting
> the GPIOs there, that would allow instantiating a new one
> from soc_exec_opaque_gpio() as it currently does and that
> would be race free.

The proper solution would likely be be to pre-parse the sequences
to determine which GPIOs are actually needed. That would also get
rid of the bxt_gpio_table[] eyesore.

-- 
Ville Syrjälä
Intel
