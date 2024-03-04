Return-Path: <linux-kernel+bounces-91246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2C870BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E9CB229AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C349473;
	Mon,  4 Mar 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnIfYEF2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3546FA9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584706; cv=none; b=C3VonknMZSPg9CBo1sKc5oHAICwGnkP9bmCCt1FZmD6IwIhrNk0T98RaNv3MYCnBdQa/FlJgcISNe1VsQYI541T0Yx7s4GGSFKGmLI9WpoNz6wCt7p2OdGtSXii5NPgQn01nFlyNxkN9rnMtghNBNqSsygE6Bb/ZWZFT5WM6Ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584706; c=relaxed/simple;
	bh=hADy2w2RsgZzbmD0YhXh1NuyAvvGzzITpAmpZ5GBokM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ru1/pNUGErIZVBQtXAshGgyLdIj167UM/7LKtHFZuAM4Tnct8tzRi7ZLc59TeR5N2VlI8hGrU0KGi+KltpSwVuN/Q/Wss9mkzjR24Nrheg/qvgqJlrsIHGrpYDiXmSzhqLmTADaMQNXwMQk7iH6+KIh22UE9MzfXVcndicT2wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnIfYEF2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709584704; x=1741120704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hADy2w2RsgZzbmD0YhXh1NuyAvvGzzITpAmpZ5GBokM=;
  b=BnIfYEF2QSkbUAGk/yahK0QFKG1+uBozxZakCdhdk0PtBG0EAENaZPC9
   d1htwz/t3gS7h4h0YVyLGoR7qpF8aSnazvQsZ1uPz0KHI504PDoewSE+c
   YwzHBzTXti3FRrPCbPlLRAqzT0nTXi3nKAhd6DDfCZm8doActmlNekEE0
   fwHHWAk0ZAlf6W8lerWzYzLMi8jNDK8j8rIX2racgsjp5PbkNPA3sXlLg
   ByErdxEH4i8xA3KnTt5KUMT6/P2g3rQQ9KuJsAJ4qPhKtXBz5avxjTw48
   e6gkJGfUiGZ0uxHKqrK/0pbSLb/NKV3Je9AKfXm4aTfnfDPJPs18/LxsZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="29528147"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="29528147"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9539229"
Received: from syakovle-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.3])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:38:19 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
In-Reply-To: <20240304195214.14563-3-hsinyi@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240304195214.14563-1-hsinyi@chromium.org>
 <20240304195214.14563-3-hsinyi@chromium.org>
Date: Mon, 04 Mar 2024 22:38:07 +0200
Message-ID: <87a5nd4tsg.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> Add a function to check if the EDID base block contains a given string.
>
> One of the use cases is fetching panel from a list of panel names, since
> some panel vendors put the monitor name after EDID_DETAIL_MONITOR_STRING
> instead of EDID_DETAIL_MONITOR_NAME.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2->v3: move string matching to drm_edid
> ---
>  drivers/gpu/drm/drm_edid.c | 49 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_edid.h     |  1 +
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 13454bc64ca2..fcdc2bd143dd 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2789,6 +2789,55 @@ u32 drm_edid_get_panel_id(struct edid_base_block *base_block)
>  }
>  EXPORT_SYMBOL(drm_edid_get_panel_id);
>  
> +/**
> + * drm_edid_has_monitor_string - Check if a EDID base block has certain string.
> + * @base_block: EDID base block to check.
> + * @str: pointer to a character array to hold the string to be checked.
> + *
> + * Check if the detailed timings section of a EDID base block has the given
> + * string.
> + *
> + * Return: True if the EDID base block contains the string, false otherwise.
> + */
> +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, const char *str)
> +{
> +	unsigned int i, j, k, buflen = strlen(str);
> +
> +	for (i = 0; i < EDID_DETAILED_TIMINGS; i++) {
> +		struct detailed_timing *timing = &base_block->edid.detailed_timings[i];
> +		unsigned int size = ARRAY_SIZE(timing->data.other_data.data.str.str);
> +
> +		if (buflen > size || timing->pixel_clock != 0 ||
> +		    timing->data.other_data.pad1 != 0 ||
> +		    (timing->data.other_data.type != EDID_DETAIL_MONITOR_NAME &&
> +		     timing->data.other_data.type != EDID_DETAIL_MONITOR_STRING))
> +			continue;
> +
> +		for (j = 0; j < buflen; j++) {
> +			char c = timing->data.other_data.data.str.str[j];
> +
> +			if (c != str[j] ||  c == '\n')
> +				break;
> +		}
> +
> +		if (j == buflen) {
> +			/* Allow trailing white spaces. */
> +			for (k = j; k < size; k++) {
> +				char c = timing->data.other_data.data.str.str[k];
> +
> +				if (c == '\n')
> +					return true;
> +				else if (c != ' ')
> +					break;
> +			}
> +			if (k == size)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +

So we've put a lot of effort into converting from struct edid to struct
drm_edid, passing that around in drm_edid.c, with the allocation size it
provides, and generally cleaning stuff up.

I'm not at all happy to see *another* struct added just for the base
block, and detailed timing iteration as well as monitor name parsing
duplicated.

With struct drm_edid you can actually return an EDID that only has the
base block and size 128, even if the EDID indicates more
extensions. Because the whole thing is *designed* to handle that
gracefully. The allocated size matters, not what the blob originating
outside of the kernel tells you.

What I'm thinking is:

- Add some struct drm_edid_ident or similar. Add all the information
  that's needed to identify a panel there. I guess initially that's
  panel_id and name.

    struct drm_edid_ident {
        u32 panel_id;
        const char *name;
    };

- Add function:

    bool drm_edid_match(const struct drm_edid *drm_edid, const struct drm_edid_ident *ident);

  Check if stuff in ident matches drm_edid. You can use and extend the
  existing drm_edid based iteration etc. in
  drm_edid.c. Straightforward. The fields in ident can trivially be
  extended later, and the stuff can be useful for other drivers and
  quirks etc.

- Restructure struct edp_panel_entry to contain struct
  drm_edid_ident. Change the iteration of edp_panels array to use
  drm_edid_match() on the array elements and the edid.

- Add a function to read the EDID base block *but* make it return const
  struct drm_edid *. Add warnings in the comments that it's only for
  panel and for transition until it switches to reading full EDIDs.

    const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *adapter);

  This is the *only* hackish part of the whole thing, and it's nicely
  isolated. For the most part you can use drm_edid_get_panel_id() code
  for this, just return the blob wrapped in a struct drm_edid envelope.

- Remove function:

    u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);

- Refactor edid_quirk_list to use the same id struct and match function
  and mechanism within drm_edid.c (can be follow-up too).

- Once you change the panel code to read the whole EDID using
  drm_edid_read family of functions in the future, you don't have to
  change *anything* about the iteration or matching or anything, because
  it's already passing struct drm_edid around.


I hope this covers everything.

BR,
Jani.


>  /**
>   * drm_edid_get_base_block - Get a panel's EDID base block
>   * @adapter: I2C adapter to use for DDC
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 2455d6ab2221..248ddb0a6b5d 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -416,6 +416,7 @@ struct edid *drm_get_edid(struct drm_connector *connector,
>  			  struct i2c_adapter *adapter);
>  struct edid_base_block *drm_edid_get_base_block(struct i2c_adapter *adapter);
>  u32 drm_edid_get_panel_id(struct edid_base_block *base_block);
> +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, const char *str);
>  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
>  				     struct i2c_adapter *adapter);
>  struct edid *drm_edid_duplicate(const struct edid *edid);

-- 
Jani Nikula, Intel

