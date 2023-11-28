Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BCE7FC29B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbjK1RyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbjK1Rx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:53:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB278AB;
        Tue, 28 Nov 2023 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701194043; x=1732730043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U7SHRv8kT+n7b9v0GPnWjN8fPXLgdna0HJB40XzjEaE=;
  b=XmmeJA668oj5wlrR1op3ftWM+hNrTkF9WzqLhxdGSVWje9J4vGobtQoE
   TTWIrPxMUuf9z7BHrUTd1fRtTY+fRDByVXYEuMcwCFjOZcCUP93AZ33Xw
   nGwzVSs7CAEMMgUocsMzNg6ag8m8lWq3NEQQHY5xSzAfsjgQnzXbI+kKt
   5a3NT8hUmuVPR3LHpf+2eQyHknIHKz4O6lrHwuE0gcLRQXVYBmZ0a4zYN
   /yLZc3rAcCRJsC0Pyf5tJEEupPaHLVm9iYk8EqBn8gPmtxYRl3XADJ0zX
   yF1ZgU6duAgCdMKEup3txbBB99KARLpBu4O07mzdIo8Dxykif12yHH2Qa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424127120"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424127120"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834715363"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834715363"
Received: from skumarso-mobl33.amr.corp.intel.com (HELO [10.255.231.208]) ([10.255.231.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:54:01 -0800
Message-ID: <d3a2eb33-ea3e-43ac-a872-a7182404eee6@linux.intel.com>
Date:   Tue, 28 Nov 2023 11:49:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: qcom: Move Soundwire runtime stream alloc to
 soundcards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
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
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20231128165638.757665-1-krzysztof.kozlowski@linaro.org>
 <20231128165638.757665-2-krzysztof.kozlowski@linaro.org>
 <4317ec5d-8eb8-4a2f-aebc-cc04f2aba145@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <4317ec5d-8eb8-4a2f-aebc-cc04f2aba145@linaro.org>
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



On 11/28/23 10:59, Krzysztof Kozlowski wrote:
> On 28/11/2023 17:56, Krzysztof Kozlowski wrote:
>> Currently the Qualcomm Soundwire controller in its DAI startup op
>> allocates the Soundwire stream runtime.  This works fine for existing
>> designs, but has limitations for stream runtimes with multiple
>> controllers, like upcoming Qualcomm X1E80100 SoC with four WSA8840
>> speakers on two Soundwire controllers.
>>
>> When two Soundwire controllers are added to sound card codecs, Soundwire
>> startup() is called twice, one for each Soundwire controller, and second
>> execution overwrites what was set before.  During shutdown() this causes
>> double free.
>>
>> It is expected to have only one Soundwire stream runtime, thus it should
>> be allocated from SoC soundcard context startup(), not from each
>> Soundwire startup().  Such way will properly handle both cases: one and
>> two Soundwire controllers in the stream runtime.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> This is an entirely different approach than my previous try here:
>> https://lore.kernel.org/all/20231025144601.268645-1-krzysztof.kozlowski@linaro.org/
> 
> ... and I forgot to thank you Pierre-Louis for patient explanation of
> the case in my previous try. Your review was much appreciated!

You're welcome. It's good if we have multiple platforms using the
'stream' concept in similar ways.
