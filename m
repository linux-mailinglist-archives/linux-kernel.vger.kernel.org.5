Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2A7A4F24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjIRQez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIRQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:34:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D821E8E;
        Mon, 18 Sep 2023 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053686; x=1726589686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rz7hwpvPJr7EsX6bLHvizHZrUJ5CLw4yAUS+Akg4Xt8=;
  b=BMdsWY4tgYK4f9ObblMqytaJ6k6ZHh22TWOa8E71jg2p3yQER4OpCmSS
   VzC20WoKD2PHGYscQrnCdYpPxmRZIQbDD77a9U7LEa0feRINCAAxOL5LT
   S4sXgmABgCVJc7RxlVNdC0qEU5qZmN3svqbB80y49Y6dFqHYq2ZC+1zxI
   YaZcu46iNV3yi2xPLMuky57LPnGxYz40DtaOxNQcU8YOLg7PRM6RcZdT/
   3kbKfMXR5O834tMZV69HdOhDFAGsxXVgZPecI/RbbDbLZ8v6tlnHLJoQY
   pHxyJbKykX1lBbqEDrYcFK7dOJcC9GsAZJM5TUourvnWzPzHnzKguoD4o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379566445"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="379566445"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076597159"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076597159"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 18 Sep 2023 06:57:50 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Sep 2023 16:57:49 +0300
Date:   Mon, 18 Sep 2023 16:57:49 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 00/15] Add TPS25750 USB type-C PD controller support
Message-ID: <ZQhXXeVo6LaZe20a@kuha.fi.intel.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 11:26:24AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 USB type-C PD controller has the same register offsets as
> tps6598x. The following is a summary of incorporating TPS25750 into
> TPS6598x driver:
> 
> - Only Check VID register (0x00) for TPS6598x and cd321x, as TPS25750 doesn't
>   have VID register.
> 
> - TypeC port registration will be registered differently for each PD
>   controller. TPS6598x uses system configuration register (0x28) to get
>   pr/dr capabilities. On the other hand, TPS25750 will use data role property
>   and PD status register (0x40) to get pr/dr capabilities as TPS25750 doesn't
>   have register 0x28 supported.
> 
> - TPS25750 requires writing a binary configuration to switch PD
>   controller from PTCH mode to APP mode which needs the following changes:
>   - Add PTCH mode to the modes list.
>   - Add an argument to tps6598x_check_mode to return the current mode.
>   - Currently, tps6598x_exec_cmd has cmd timeout hardcoded to 1 second,
>     and doesn't wait before checking DATA_OUT response. In TPS25750, patch 4CCs
>     take longer than 1 second to execute and some requires a delay before
>     checking DATA_OUT. To accommodate that, cmd_timeout and response_delay will
>     be added as arguments to tps6598x_exec_cmd.
>   - Implement applying patch sequence for TPS25750.
> 
> - In pm suspend callback, patch mode needs to be checked and the binary
>   configuration should be applied if needed.
> 
> - For interrupt, TPS25750 has only one event register (0x14) and one mask
>   register (0x16) of 11 bytes each, where TPS6598x has two event
>   and two mask registers of 8 bytes each. Both TPS25750 and TPS65986x
>   shares the same bit field offsets for events/masks/clear but many of
>   there fields are reserved in TPS25750, the following needs to be done in
>   tps6598x_interrupt:
>   - Read EVENT1 register as a block of 11 bytes when tps25750 is present
>   - Write CLEAR1 register as a block of 11 bytes when tps25750 is present
>   - Add trace_tps25750_irq
>   - During testing, I noticed that when a cable is plugged into the PD
>     controller and before PD controller switches to APP mode, there is a
>     lag between dr/pr updates and PlugInsertOrRemoval Event, so a check
>     for dr/pr change needs to be added along TPS_REG_INT_PLUG_EVENT check
> 
> - Add TPS25750 traces for status and power status registers. Trace for
>   data register won't be added as it doesn't exist in the device.
> 
> - Configure sleep mode for TPS25750.

This looks mostly okay, but I'm a bit uncomfortable with flags like
is_tps25750.

I think a better way would be to supply driver data. In it you would
have a callback for everything that needs to be customised.

struct tipd_data {
        int (*interrupt)(int irq, void *data);
        ...
};
...
static const struct tipd_data tps25750_data = {
        .interrupt = tps25750_interrupt,
...

Something like that. You can on top of that still check
device_is_compatible(dev, "...") in some places.


thanks,

-- 
heikki
