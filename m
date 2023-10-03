Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACA7B6255
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjJCHPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjJCHPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:15:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B5AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696317315; x=1727853315;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=EVtKTrfrbj1XCTOf55slOIXSe1B7F9FizV0UJfRCpN0=;
  b=PqHDW4LFuAN5wv+GWFPmqLWrltd17qacfIsK1FtHEdYxlUbSPbs1RAUT
   pqAZxW7Jw0Vhdle+NvXJLOcc9zZ54xcWYQ14506PIIeim6amMzRcBWoox
   DfCw2i4rHOjj0JDwmMQgHAXVWDlw5OOIdRAAu1T8i35W7gQI71utN+EDj
   ZQxFyyHbnvlXZ86lawbcWXGZbzviG54DON7FA068fnhPsucFoPUSpLHhF
   jgngmVHOIpV7sQd/agK2u1RSEClF1b6K8klFeYKLCdozxkGG3xnS2UUlN
   6IUZxbLA7BH15Rzw1QkdDxq0hiZzhxSG6FT3JutvLdP1ONWm507tXNKCw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385632746"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="385632746"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 00:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816579985"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="816579985"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 00:15:08 -0700
Message-ID: <881c99b5-f64e-4c74-1420-8eec08cca0ce@linux.intel.com>
Date:   Tue, 3 Oct 2023 09:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 10/12] ASoC: Intel: Skylake: Move snd_hdac_i915_init to
 before probe_work.
Content-Language: en-US
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
 <20231002165202.17863-1-maarten.lankhorst@linux.intel.com>
 <8a506cfa-7274-b760-1fc1-60d0e5b75a8b@linux.intel.com>
In-Reply-To: <8a506cfa-7274-b760-1fc1-60d0e5b75a8b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/2023 8:55 AM, Amadeusz Sławiński wrote:
> On 10/2/2023 6:52 PM, Maarten Lankhorst wrote:
>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
>> the snd_hdac_i915_init into a workqueue. It's likely the whole workqueue
>> can be destroyed, but I don't have the means to test this.
>>
>> Removing the workqueue would simplify init even further, but is left
>> as exercise for the reviewer.
>>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
> 
> Isn't the convention that your Signed-off should be last when you are 
> sending the patches? Or does it only apply to Signed-off lines 
> themselves and other lines can be anywhere?
> 
And rereading kernel documentation, it really seems to be a bit 
ambiguous, well ignore the comment then.
