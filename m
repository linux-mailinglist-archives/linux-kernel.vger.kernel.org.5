Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA67CBEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjJQJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjJQJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:11:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAEF5;
        Tue, 17 Oct 2023 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533909; x=1729069909;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sACA/TZ3E1bc6D+vqMw81MOu76YAYJwnOpJImhsrA84=;
  b=CfuSZC8cGosBH9VwXOHZyYwsff9d9ARDKl47EmE1LZFtE/cJykjbxS4e
   FByyyiqJ5TqGQHiqmD8FrglIvG+w4VkAzLWOL5dcGT3zNSQ46UCy7G1or
   xuOVC6zYkq2QESjRIzqACnjOJjZtdj72eHlpjM+5tboj4Hmqvziz+02AD
   d7mdWUHgtlpx7qtn0jj0pU9O2EioSrLL2ouXFnE9sFTuhSrF/YAsFZRCt
   xWKPmjKaaAEFYLdQOkks3IjpqHGUMCYgBPEHr7q4mfRRZS7b2IxqLJz7p
   k351UOQrVZUSP0cSdQT/J/Qn631ReBvZ0Bqc7TqIvABBmC5j5e7807tcr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452215140"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="452215140"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="872481558"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="872481558"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:11:44 -0700
Date:   Tue, 17 Oct 2023 12:11:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ma Jun <Jun.Ma2@amd.com>
cc:     amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, majun@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Evan Quan <quanliangl@hotmail.com>
Subject: Re: [PATCH v12 4/9] wifi: mac80211: Add support for WBRF features
In-Reply-To: <20231017025358.1773598-5-Jun.Ma2@amd.com>
Message-ID: <e83985cc-5a82-7ece-366-7a3b1997ed90@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com> <20231017025358.1773598-5-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023, Ma Jun wrote:

> From: Evan Quan <quanliangl@hotmail.com>
> 
> To support the WBRF mechanism, Wifi adapters utilized in the system must
> register the frequencies in use(or unregister those frequencies no longer
> used) via the dedicated calls. So that, other drivers responding to the
> frequencies can take proper actions to mitigate possible interference.
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Evan Quan <quanliangl@hotmail.com>
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> --
> v1->v2:
>   - place the new added member(`wbrf_supported`) in
>     ieee80211_local(Johannes)
>   - handle chandefs change scenario properly(Johannes)
>   - some minor fixes around code sharing and possible invalid input
>     checks(Johannes)
> v2->v3:
>   - drop unnecessary input checks and intermediate APIs(Mario)
>   - Separate some mac80211 common code(Mario, Johannes)
> v3->v4:
>   - some minor fixes around return values(Johannes)
> v9->v10:
>   - get ranges_in->num_of_ranges set and passed in(Johannes)
> v12:
>   - use acpi_amd_wbrf_add_remove to replace the acpi_amd_wbrf_add_exclusion
>     acpi_amd_wbrf_remove_exclusion
> ---
>  include/linux/ieee80211.h  |   1 +
>  net/mac80211/Makefile      |   2 +
>  net/mac80211/chan.c        |   9 ++++
>  net/mac80211/ieee80211_i.h |   9 ++++
>  net/mac80211/main.c        |   2 +
>  net/mac80211/wbrf.c        | 105 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 128 insertions(+)
>  create mode 100644 net/mac80211/wbrf.c
> 
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index 4b998090898e..f995d06da87f 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -4335,6 +4335,7 @@ static inline int ieee80211_get_tdls_action(struct sk_buff *skb, u32 hdr_size)
>  /* convert frequencies */
>  #define MHZ_TO_KHZ(freq) ((freq) * 1000)
>  #define KHZ_TO_MHZ(freq) ((freq) / 1000)
> +#define KHZ_TO_HZ(freq)  ((freq) * 1000)

It would be better to not add more of these per subsystem but use the 
generic include/linux/units.h constants instead.

>  #define PR_KHZ(f) KHZ_TO_MHZ(f), f % 1000
>  #define KHZ_F "%d.%03d"
>  
> diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
> index b8de44da1fb8..d46c36f55fd3 100644
> --- a/net/mac80211/Makefile
> +++ b/net/mac80211/Makefile
> @@ -65,4 +65,6 @@ rc80211_minstrel-$(CONFIG_MAC80211_DEBUGFS) += \
>  
>  mac80211-$(CONFIG_MAC80211_RC_MINSTREL) += $(rc80211_minstrel-y)
>  
> +mac80211-y += wbrf.o
> +
>  ccflags-y += -DDEBUG
> diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
> index 68952752b599..458469c224ae 100644
> --- a/net/mac80211/chan.c
> +++ b/net/mac80211/chan.c
> @@ -506,11 +506,16 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
>  
>  	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
>  
> +	ieee80211_remove_wbrf(local, &ctx->conf.def);
> +
>  	ctx->conf.def = *chandef;
>  
>  	/* check if min chanctx also changed */
>  	changed = IEEE80211_CHANCTX_CHANGE_WIDTH |
>  		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
> +
> +	ieee80211_add_wbrf(local, &ctx->conf.def);
> +
>  	drv_change_chanctx(local, ctx, changed);
>  
>  	if (!local->use_chanctx) {
> @@ -668,6 +673,8 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
>  	lockdep_assert_held(&local->mtx);
>  	lockdep_assert_held(&local->chanctx_mtx);
>  
> +	ieee80211_add_wbrf(local, &ctx->conf.def);
> +
>  	if (!local->use_chanctx)
>  		local->hw.conf.radar_enabled = ctx->conf.radar_enabled;
>  
> @@ -748,6 +755,8 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
>  	}
>  
>  	ieee80211_recalc_idle(local);
> +
> +	ieee80211_remove_wbrf(local, &ctx->conf.def);
>  }
>  
>  static void ieee80211_free_chanctx(struct ieee80211_local *local,
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 91633a0b723e..719f2c892132 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1600,6 +1600,8 @@ struct ieee80211_local {
>  
>  	/* extended capabilities provided by mac80211 */
>  	u8 ext_capa[8];
> +
> +	bool wbrf_supported;
>  };
>  
>  static inline struct ieee80211_sub_if_data *
> @@ -2638,4 +2640,11 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
>  				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
>  				    u8 eht_cap_len,
>  				    struct link_sta_info *link_sta);
> +
> +void ieee80211_check_wbrf_support(struct ieee80211_local *local);
> +void ieee80211_add_wbrf(struct ieee80211_local *local,
> +			struct cfg80211_chan_def *chandef);
> +void ieee80211_remove_wbrf(struct ieee80211_local *local,
> +			   struct cfg80211_chan_def *chandef);
> +
>  #endif /* IEEE80211_I_H */
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 24315d7b3126..b20bdaac84db 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1396,6 +1396,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  	debugfs_hw_add(local);
>  	rate_control_add_debugfs(local);
>  
> +	ieee80211_check_wbrf_support(local);
> +
>  	rtnl_lock();
>  	wiphy_lock(hw->wiphy);
>  
> diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
> new file mode 100644
> index 000000000000..7329f554c7af
> --- /dev/null
> +++ b/net/mac80211/wbrf.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wifi Band Exclusion Interface for WLAN
> + * Copyright (C) 2023 Advanced Micro Devices
> + *
> + */
> +
> +#include <linux/acpi_amd_wbrf.h>
> +#include <net/cfg80211.h>
> +#include "ieee80211_i.h"
> +
> +void ieee80211_check_wbrf_support(struct ieee80211_local *local)
> +{
> +	struct wiphy *wiphy = local->hw.wiphy;
> +	struct device *dev;
> +
> +	if (!wiphy)
> +		return;
> +
> +	dev = wiphy->dev.parent;
> +	if (!dev)
> +		return;
> +
> +	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
> +	dev_dbg(dev, "WBRF is %s supported\n",
> +		local->wbrf_supported ? "" : "not");

Add a new static inline into include/linux/string_choices.h for 
"supported" / "not supported" and use it here.

> +}
> +
> +static void get_chan_freq_boundary(u32 center_freq,
> +				   u32 bandwidth,
> +				   u64 *start,
> +				   u64 *end)

Use less lines.

> +{
> +	bandwidth = MHZ_TO_KHZ(bandwidth);
> +	center_freq = MHZ_TO_KHZ(center_freq);
> +
> +	*start = center_freq - bandwidth / 2;
> +	*end = center_freq + bandwidth / 2;
> +
> +	/* Frequency in HZ is expected */

No, it's not in HZ but Hz. HZ has a special meaning in kernel.

-- 
 i.

> +	*start = KHZ_TO_HZ(*start);
> +	*end = KHZ_TO_HZ(*end);
> +}
> +
> +static void get_ranges_from_chandef(struct cfg80211_chan_def *chandef,
> +				    struct wbrf_ranges_in_out *ranges_in)
> +{
> +	u64 start_freq1, end_freq1;
> +	u64 start_freq2, end_freq2;
> +	int bandwidth;
> +
> +	bandwidth = nl80211_chan_width_to_mhz(chandef->width);
> +
> +	get_chan_freq_boundary(chandef->center_freq1,
> +			       bandwidth,
> +			       &start_freq1,
> +			       &end_freq1);
> +
> +	ranges_in->band_list[0].start = start_freq1;
> +	ranges_in->band_list[0].end = end_freq1;
> +	ranges_in->num_of_ranges = 1;
> +
> +	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
> +		get_chan_freq_boundary(chandef->center_freq2,
> +				       bandwidth,
> +				       &start_freq2,
> +				       &end_freq2);
> +
> +		ranges_in->band_list[1].start = start_freq2;
> +		ranges_in->band_list[1].end = end_freq2;
> +		ranges_in->num_of_ranges++;
> +	}
> +}
> +
> +void ieee80211_add_wbrf(struct ieee80211_local *local,
> +			struct cfg80211_chan_def *chandef)
> +{
> +	struct wbrf_ranges_in_out ranges_in = {0};
> +	struct device *dev;
> +
> +	if (!local->wbrf_supported)
> +		return;
> +
> +	dev = local->hw.wiphy->dev.parent;
> +
> +	get_ranges_from_chandef(chandef, &ranges_in);
> +
> +	acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_ADD, &ranges_in);
> +}
> +
> +void ieee80211_remove_wbrf(struct ieee80211_local *local,
> +			   struct cfg80211_chan_def *chandef)
> +{
> +	struct wbrf_ranges_in_out ranges_in = {0};
> +	struct device *dev;
> +
> +	if (!local->wbrf_supported)
> +		return;
> +
> +	dev = local->hw.wiphy->dev.parent;
> +
> +	get_ranges_from_chandef(chandef, &ranges_in);
> +
> +	acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_REMOVE, &ranges_in);
> +}
> 
