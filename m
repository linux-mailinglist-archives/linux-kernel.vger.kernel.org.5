Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA5C78FBEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbjIAKuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjIAKuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:50:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9E10CE;
        Fri,  1 Sep 2023 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693565406; x=1725101406;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L/uLuZeboGzKjlFIWvQqacqx9NwrlrJDn8jGpBy5COM=;
  b=iSp5BsJEulw2dGCj4V0HRURg6u8FezkJcEi2WlVJPwb/z1yHjdKMDCPE
   6qS4qJJ4oemEIRZEuDzNtZ4M7LXD1T6+HWc/ViTpE+rXyGPc+4ZMmF3Rj
   OiNwSa9bHTFwSp25niY8RI0VrH46GFcbPfX+vQv/bN2Jv6BPkOgyHfeoP
   AemRmfG2FCGKzOOEcUmtZ3pDil5VwhSf9YCH6NpVG/gd8jvKZCU28CkwI
   4pSCuE6JwMtFfotGYYZQqfr4taDC9p4zU6VtSGKVE9nisI9h1V2nAgDuu
   TznRVVsVgj0cn5jnOSUKt50VtjCiojtXodTaVUpQV60xZBtaNQIpq8k3r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366420794"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="366420794"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 03:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070705753"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070705753"
Received: from pboudier-mobl.ger.corp.intel.com ([10.252.47.249])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 03:50:02 -0700
Date:   Fri, 1 Sep 2023 13:50:00 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] platform/mellanox: mlxbf-pmc: Add support for
 BlueField-3
In-Reply-To: <94d48f57b3625ff7021e11ebdf9facf5cfec36cc.1693545970.git.shravankr@nvidia.com>
Message-ID: <1cff33c7-176f-4da7-98cd-bacea1b09b@linux.intel.com>
References: <cover.1693545970.git.shravankr@nvidia.com> <94d48f57b3625ff7021e11ebdf9facf5cfec36cc.1693545970.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023, Shravan Kumar Ramani wrote:

> Add new access mechanism and list of supported events to program
> and read the counters in BlueField-3.
> Performance counter blocks being added for BlueField-3 include:
>   - Memory Sub-system (mss) which has counters for monitoring
> various DRAM and related skylib events
>   - Last level Tile, which has 2 sets of counters (llt, llt_miss)
> for monitoring Tile and cache metrics
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 685 ++++++++++++++++++++++++--
>  1 file changed, 653 insertions(+), 32 deletions(-)

> -	ret = device_property_read_u32(dev, "tile_num", &pmc->tile_count);
> -	if (ret)
> -		return ret;
> +	if (device_property_read_u32(dev, "tile_num", &pmc->tile_count)) {
> +		if (device_property_read_u8(dev, "llt_enable",
> +					    &pmc->llt_enable)) {

Just put this into a single line.

> +			dev_err(dev, "Number of tiles/LLTs undefined\n");
> +			return -EINVAL;
> +		}
> +		if (device_property_read_u8(dev, "mss_enable",
> +					    &pmc->mss_enable)) {

Ditto.

-- 
 i.

