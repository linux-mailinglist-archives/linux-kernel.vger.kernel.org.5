Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59A79C289
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjILCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjILCQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:16:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E21B883E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694481145; x=1726017145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NT0igPUaqXUrlEzLPjsu0IEnx8SqEPXynrBlbgMaU38=;
  b=hsEm2V16Gh2iIXNKqA+U13U1xmLLXleU7AplJXiKfrOOWMtXfmZwZdxs
   gBLQUTdtt5UqKE56Hj2HszI6sw+9vGMEjRxnSIho4uI3jW1tVXNqdBknh
   mOAZdTeuMvlUrpjgx0njQW6fw2J84IqW52kbByZ9X/GtF52GCxnUiCeNd
   opHsSKt8LKiZvqJR2xjbwXGr122zIPqYxdppznJap7LEKX+/hvCsyoduT
   /0U3qE2W8wQSLydyKAx3pv7AUq3KS2Wanh+R2vZQN95dQOB1y3HkYA+V4
   BK0AYIStl+NfcNvpP6bB6Hp+cRZhTSOhfpCP0JnvlxmzDgOOH+Ym5tsD0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357676956"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357676956"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="886739584"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="886739584"
Received: from sbeyer-mobl.amr.corp.intel.com (HELO [10.212.76.33]) ([10.212.76.33])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:29:05 -0700
Message-ID: <34d34e99-c6a3-2d08-2c4b-c548b6b87e9a@linux.intel.com>
Date:   Mon, 11 Sep 2023 20:25:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
 <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
 <alpine.DEB.2.22.394.2309011509200.3532114@eliteleevi.tm.intel.com>
 <4252a4dc-0cf3-4ff2-aa55-c03e56345276@linux.intel.com>
 <4d84a799-c07e-e917-7c82-2f24456e3ac2@linux.intel.com>
 <6d39eac7-06c7-45f0-0318-72be1753641f@linux.intel.com>
 <e8880daf-8f74-4350-96c4-d625272aed35@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <e8880daf-8f74-4350-96c4-d625272aed35@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> What we have atm:
> snd_sof_probe - might be called from wq
> snd_sof_remove - might be called from wq (cleans up the snd_sof_probe
> 		 step)

I don't think it's correct, snd_sof_remove cannot be called from a wq.
The device core knows nothing about workqueues.

> We want a callbacks for hardware/device probing, right, split the
> snd_sof_probe (and remove) to be able to support a sane level of
> deferred probing support.
> 
> With that in mind:
> snd_sof_device_probe - Not called from wq (to handle deferred probing)
> snd_sof_probe - might be called from wq
> 
> snd_sof_remove - might be called from wq (cleans up the snd_sof_probe
> 		 step)
> snd_sof_device_remove - Not called from wq (to up the
> 			snd_sof_device_probe step)
> 
> Naming option: s/device/hardware

I like the 'device' hint since it's directly related to the device (or
subsystem) callbacks.

> However, I think the snd_sof_device_remove itself is redundant and we
> might not need it at all as in case we have wq and there is a failure in
> there we do want to release resources as much as possible. The module
> will be kept loaded (no deferred handling in wq) and that might block
> PM, other devices to behave correctly. Iow, if the wq has failure we
> should do a cleanup to the best effort to reach a level like the driver
> is not even loaded.

If we have a failure in a workqueue used for probe, then we have to
clean-up everything since nothing in the device core will do so for us.
