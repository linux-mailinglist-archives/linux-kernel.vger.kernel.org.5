Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF312772852
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHGO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHGO4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:56:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78889107
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420198; x=1722956198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zgsHC0JFOAd4lgK0/kb45iQ6so6mT+vI8fCzwDnh0Yk=;
  b=fYFPf0L0TTQvu6it184lAijKGsGIK1/Ag8u6A2d7P8Bc3p4h0aPS1XGt
   kB2IL/wzAwrb6iZsqlAM8njm8gFDUENMY6UR5IVUOH6cByMkubkGQvcdo
   GrIFp8EQVRKDowfEtzinhgCay9k+hVDUh+NpYEbNS2kRL3Oierpmz7Qrk
   fgPFlbi3gdsWs3fCXkr7ONAYyQZqYJXi0P+ujUidTnCgSUr7W9X8tpR5Y
   yB8qHWU6Yu3TClfpZNg0BA3X9sEI4QseZBQWoY03uyWpoBStBM+Nr8mrb
   lAE7XEbys52yzwSe0Mvtz0zxoRL22vSGqBiuMLAtH5nsrQ/rtsBhO2bkW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434410583"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434410583"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061623859"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="1061623859"
Received: from hweelee-mobl.amr.corp.intel.com (HELO [10.209.181.215]) ([10.209.181.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:35 -0700
Message-ID: <cd826184-0a94-425b-8a6e-0988c997bf6f@linux.intel.com>
Date:   Mon, 7 Aug 2023 09:06:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/9] ALSA: hda/i915: Allow override of gpu binding.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
 <20230807090045.198993-3-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230807090045.198993-3-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/23 04:00, Maarten Lankhorst wrote:
> Selecting CONFIG_DRM selects CONFIG_VIDEO_NOMODESET, which exports
> video_firmware_drivers_only(). This can be used as a first
> approximation on whether i915 will be available. It's safe to use as
> this is only built when CONFIG_SND_HDA_I915 is selected by CONFIG_I915.
> 
> It's not completely fool proof, as you can boot with "nomodeset
> i915.modeset=1" to make i915 load regardless, or use
> "i915.force_probe=!*" to never load i915, but the common case of
> booting with nomodeset to disable all GPU drivers this will work as
> intended.
> 
> Because of this, we add an extra module parameter,
> snd_hda_core.gpu_bind that can be used to signal users intent.
> -1 follows nomodeset, 0 disables binding, 1 forces wait/-EPROBE_DEFER
> on binding.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

