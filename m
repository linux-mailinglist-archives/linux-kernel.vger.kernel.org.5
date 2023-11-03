Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EFA7E2746
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjKFOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjKFOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:42:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA71D7C;
        Mon,  6 Nov 2023 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699281720; x=1730817720;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nX/Ie0anw1ndgN0YJjqHJnFFjUKSdxLFOe79el+klzo=;
  b=BPUy3v1szCXzKpje8qNzXhPVASOZUo913hOaXkeeWRRkOXOMvQFGRQTK
   NS2khE5pVM41ZP85PlYc2CeM8ig27Cf9gjicCT4cEqaGxV7psVm1TbtBt
   XsgL3lBLKzSFBue1kOiP/nm7DTSEPAVZXIp2VH0t20bJjmscfk7MoGBYs
   GP3ukWxgqtFOD30nWQRsE0C2ojC7ts0n3WC533AdNCBNgeGMYtwLMsvRo
   qswpOcLMntFW1hx3LWIJPBvShJstF9gpOW1wUen9xaS98xEPMBi+rv2V+
   ayAETlDorlvR/gsaNVY16cacNbWo5ToSg1eB2K5EEfaHjLWhGHjASsXQl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379677775"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="379677775"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:41:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1093799396"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="1093799396"
Received: from dpidwerb-mobl.amr.corp.intel.com (HELO [10.209.77.27]) ([10.209.77.27])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:41:58 -0800
Message-ID: <30f0f5ef-a148-444f-924f-594f4cbd48a4@linux.intel.com>
Date:   Fri, 3 Nov 2023 10:39:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: codecs: wsa884x: check if set_stream is called
 for proper bus
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
 <20231025144601.268645-3-krzysztof.kozlowski@linaro.org>
 <8b9db87b-0f61-4824-acf1-6b5ebdf45e63@linux.intel.com>
 <160752cb-7772-4b1d-9096-8be25e76213c@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <160752cb-7772-4b1d-9096-8be25e76213c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> We have two Soundwire controllers swr0 and swr3, each with two WSA884x
> speakers (codecs):
> 
> -------------
> &swr0 {
> 	status = "okay";
> 
> 	left_woofer: speaker@0,0 {
> 		compatible = "sdw20217020400";
> 		reg = <0 0>;
> 		// ...
> 	};
> 
> 	/* WSA8845, Left Tweeter */
> 	left_tweeter: speaker@0,1 {
> 		compatible = "sdw20217020400";
> 		reg = <0 1>;
> 		// ...
> 	};
> };
> 
> &swr3 {
> 	status = "okay";
> 
> 	/* WSA8845, Right Woofer */
> 	right_woofer: speaker@0,0 {
> 		compatible = "sdw20217020400";
> 		reg = <0 0>;
> 		// ...
> 	};
> 
> 	/* WSA8845, Right Tweeter */
> 	right_tweeter: speaker@0,1 {
> 		compatible = "sdw20217020400";
> 		reg = <0 1>;
> 		// ...
> 	};
> };
> -------------
> 
> Now, for four-speaker playback, we have sound card with links like:
> 
> -------------
> wsa-dai-link {
> 	link-name = "WSA Playback";
> 
> 	cpu {
> 		sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> 	};
> 
> 	codec {
> 		sound-dai = <&left_woofer>, <&left_tweeter>,
> 			    <&swr0 0>, <&lpass_wsamacro 0>,
> 			    <&right_woofer>, <&right_tweeter>,
> 			    <&swr3 0>, <&lpass_wsa2macro 0>;
> 	};
> 
> 	platform {
> 		sound-dai = <&q6apm>;
> 	};
> };
> -------------
> 
> We need to prepare the stream for all four speakers and two soundwire
> controllers (so two different soundwire buses), however without the
> patches here, the stream (sdw_stream_runtime *sruntime) right
> woofer/twitter is set to swr0 (the other bus!). But it should stay as
> swr3 (their bus).
> 
> Does it help a bit? I hope I am able to properly explain it.

The configuration seems fine, but the problem is the
"sdw_stream_runtime" definition.

You need *ONE* sdw_stream_runtime, and multiple m_rt contexts added in
the linked lists of this sdw_stream_runtime. In other words, you need to
call sdw_stream_add_master() twice, for swr0 and swr3 respectively.

Put differently, a sdw_stream_runtime does not point to a specific bus,
it provides a top-level structure which can use multiple buses.

The best way to allocate the sdw_stream_runtime is to rely on the
dailink .startup callback. From the description above that's where you
have all the needed information, and then each DAI .startup (or
hw_params) can call sdw_stream_add_master() to update the linked lists.



