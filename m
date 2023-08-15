Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D477CDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbjHON5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjHON5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:57:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC7EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692107822; x=1723643822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5boj+fMC+VijeKK6y8yvEseWJ2SPZpwxEoI0tsFjS0=;
  b=ZoCKRXPSGDCexAkxc3wb8oxou8EriyktBcR8BXPrhxW9Df+ontJEOwe/
   6Jjz4Ax+E2coBAqcoYEoZBStIJfKRWru3ulnxR7ghkg3qAEtKoUq+A2nC
   5Y5pPrk0ZFPY7y6Wzz3/NyjFOG4UOvbERXJnYcvz5IuuoSuixhjYIdlN8
   voETQdfOQ2BENDLvZfe797UgiTo8qmrq3fQUrhTdhII3wSlJ7QR7el6LM
   U6XEYTSelgws3IMhCu67U/LFHz9Ma5n7JbiJQ0v1aiUrmL629R+hQstnn
   +6LOY1nhTC6rMPUaOGN3lq37saT3EJyyCEna6XlLoINXr+NojXPpqv2jM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403259501"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403259501"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 06:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733854769"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733854769"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 06:57:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qVuXb-0048Sm-09;
        Tue, 15 Aug 2023 16:56:59 +0300
Date:   Tue, 15 Aug 2023 16:56:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/25] ASoC: component: Add generic PCM copy ops
Message-ID: <ZNuEKmBUN3VPg8IO@smile.fi.intel.com>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-19-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-19-tiwai@suse.de>
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

On Mon, Aug 14, 2023 at 01:55:16PM +0200, Takashi Iwai wrote:
> For following the ALSA PCM core change, a new PCM copy ops is added
> toe ASoC component framework: snd_soc_component_driver receives the
> copy ops, and snd_soc_pcm_component_copy() helper is provided.
> 
> This also fixes a long-standing potential bug where the ASoC driver
> covers only copy_user PCM callback and misses the copy from kernel
> pointers (such as OSS PCM layer), too.
> 
> As of this patch, the old copy_user is still kept, but it'll be
> dropped later after all drivers are converted.

...

> +	/* FIXME. it returns 1st copy now */
> +	for_each_rtd_components(rtd, i, component)
> +		if (component->driver->copy)
> +			return soc_component_ret(
> +				component,

This can be on the previous line.

> +				component->driver->copy(
> +					component, substream, channel,

Ditto for the component parameter.

> +					pos, buf, bytes));

-- 
With Best Regards,
Andy Shevchenko


