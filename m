Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34057D971C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjJ0MAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345794AbjJ0MAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:00:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A80C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698408027; x=1729944027;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vCWGb3NID6ueGa6L0eaadpPpzWEMuC4ODDsq8efeWGk=;
  b=Xpu2/duW0shsVj5MihIPw1FLR5AaQpH1EFiWFtmIB21gYmBBo7mWetWb
   pY+orkaEfmE1ZAqirgk6xDd/EZc3gsb2CeL0okcGH+ZYe5k58iWiA8EEO
   EuYVylH2VCu+D4BVSfJn8uT8iwt5kXQOAKjB5WnExLm/777fq2epXeYL8
   TAEqY2XCfyplrhWu0hfjxw17Y5tMr9S0snmsbcMafkW529FjxZ6/tHsjI
   wLmhiR5VNiG7UIe54zJ1Zux6Wrdd80fvYcx+y7kwZM7rjykfijJ2EP0mD
   0Aw/cX46W8VC+1bIxMw6izzoF2a0/oZv2P4cLvgU3ezBj4sDwc4SfHvQ5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367971401"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="367971401"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876315699"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="876315699"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:00:16 -0700
Message-ID: <54c44548-c2e4-466d-bfe4-b48db9e5d20c@linux.intel.com>
Date:   Fri, 27 Oct 2023 14:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute stream
 during trigger.
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     johan@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
Content-Language: en-US
In-Reply-To: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 12:57 PM, Srinivas Kandagatla wrote:
> Click/Pop Noise was a long pending issue with WSA Codecs which are prone
> to accumlate DC when ports are active but without any data streams.
> There are multiple places in the current setup, where this could happen
> in both startup as well as shutdown path.
> 
> This patchset adds a new flag mute_unmute_on_trigger to dai_ops to let
> generic code do the mute/unmute on trigger.
> 
> This patches help fix those issues by making sure the PA is Muted/Unmuted
> inline with the stream start/stop events.
> 
> 
> Srinivas Kandagatla (2):
>    ASoC: soc-dai: add flag to mute and unmute stream during trigger
>    ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag
> 
>   include/sound/soc-dai.h    |  1 +
>   sound/soc/codecs/wsa883x.c |  7 +------
>   sound/soc/soc-dai.c        |  7 +++++++
>   sound/soc/soc-pcm.c        | 12 ++++++++----
>   4 files changed, 17 insertions(+), 10 deletions(-)
> 

Have you tried something like:
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index e40d583a1ce6..f02362cf95dc 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1229,6 +1229,8 @@ static int wsa883x_spkr_event(struct 
snd_soc_dapm_widget *w,
                 snd_soc_component_write_field(component, 
WSA883X_VBAT_ADC_FLT_CTL,
 
WSA883X_VBAT_ADC_COEF_SEL_MASK,
 
WSA883X_VBAT_ADC_COEF_F_1DIV2);
+               snd_soc_component_write_field(component, WSA883X_DRE_CTL_1,
+                                             WSA883X_DRE_GAIN_EN_MASK, 0);
                 snd_soc_component_write_field(component, 
WSA883X_PA_FSM_CTL,
 
WSA883X_GLOBAL_PA_EN_MASK, 0);
                 snd_soc_component_write_field(component, 
WSA883X_PDM_WD_CTL,


As it is one thing from wsa883x_digital_mute() which seems missing in 
SND_SOC_DAPM_PRE_PMD switch case, so it seems to leave GAIN always enabled?

Anyway this seems like something that if possible should be fixed on 
codec driver side instead of introducing global flag?
