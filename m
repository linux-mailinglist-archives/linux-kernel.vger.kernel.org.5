Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A207FC14E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346535AbjK1Rx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346517AbjK1Rxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:53:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC962C1;
        Tue, 28 Nov 2023 09:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701194041; x=1732730041;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ChXBVBqsS5xdsQgc7KH0fBuDsClye8kOccQk8AVBPTw=;
  b=M+3okfD4QsWlMOq0Gs5bGvspqg7k3grNVXenKtWTszf+IVbT3DfIF5wR
   CYOJ7QE1m2uBHA/6uN8YyhXLLnGEoZNlIBu1k83h3S6ghbFHjOocHu+Vk
   qvkt+vyXlo+Yy0bpjPuBZdSNh4z4Lj4PrHWVsue3RH/sRgsHoO+Uh2MAb
   L/nRk3miSEGRx0LrBsg0p+gJ8pQ5+5aGysEKZVFxZjW6JV+tNKrY0/nX7
   9Xb0gcpCt1xRt7jbCGBjaVJqx04WxNH1r1OEusMDX/Z/N2YI6Ux2isJOl
   x6+RFHDp65kvXXktHZkQ1ajwTGZdJ+5NGKlz22hPyy+oKU/+y6vvk5EFc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424127108"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424127108"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834715335"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834715335"
Received: from skumarso-mobl33.amr.corp.intel.com (HELO [10.255.231.208]) ([10.255.231.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:53:59 -0800
Message-ID: <56b8175d-ce80-44b5-a738-22a0802e520f@linux.intel.com>
Date:   Tue, 28 Nov 2023 11:47:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: qcom: Move Soundwire runtime stream alloc to
 soundcards
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
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
References: <20231128165638.757665-1-krzysztof.kozlowski@linaro.org>
 <20231128165638.757665-2-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231128165638.757665-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 10:56, Krzysztof Kozlowski wrote:
> Currently the Qualcomm Soundwire controller in its DAI startup op
> allocates the Soundwire stream runtime.  This works fine for existing
> designs, but has limitations for stream runtimes with multiple
> controllers, like upcoming Qualcomm X1E80100 SoC with four WSA8840
> speakers on two Soundwire controllers.
> 
> When two Soundwire controllers are added to sound card codecs, Soundwire
> startup() is called twice, one for each Soundwire controller, and second
> execution overwrites what was set before.  During shutdown() this causes
> double free.
> 
> It is expected to have only one Soundwire stream runtime, thus it should
> be allocated from SoC soundcard context startup(), not from each
> Soundwire startup().  Such way will properly handle both cases: one and
> two Soundwire controllers in the stream runtime.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This is an entirely different approach than my previous try here:
> https://lore.kernel.org/all/20231025144601.268645-1-krzysztof.kozlowski@linaro.org/

LGTM

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

