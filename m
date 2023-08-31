Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C84278EAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbjHaKpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjHaKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:45:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6840E45
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693478729; x=1725014729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yun5X9T9+HnywGIcjOuXjIT92QS/FS0Ffu2qEslGeDk=;
  b=XD4lI9PHm64YaIKUpKBNtIkyaYSSEHhSAZukJXg67kUjyesXDpxzjVU4
   uNMisrpvSMFo9TZvQJHzZOPM3I7hCT66l6jN5GRvonN0//dyFhWk3xTeu
   RLT59yv9MeqFpfddHdZ9CcW8KupEz/AnIxogVuLRC3y6d792UHX0bQe9r
   XB4twUOiu12yDs8kCaT6xXtnElqV43+nTeBntJZEZ6iZUnoBm69lLppLO
   hN3tzusmvyFFshndzFZ5D1C6VQE9i1KB22WZfsaUpdbfJLPR5HD5pu878
   SQSmZuJAuGI5BvvYAEf+MG4eyFsY5PeA51H/S4+Z3hlHEgj+JIsOD6eCz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373298446"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="373298446"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716293357"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="716293357"
Received: from sorenthe-mobl.ger.corp.intel.com (HELO [10.249.254.108]) ([10.249.254.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:44:15 -0700
Message-ID: <d0aeae4e-0766-4879-9b06-46c78ffdb165@linux.intel.com>
Date:   Thu, 31 Aug 2023 12:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
 <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
 <ac21f644-dedc-289b-3783-0cf2db8c0a73@linux.intel.com>
Content-Language: en-US
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <ac21f644-dedc-289b-3783-0cf2db8c0a73@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Den 2023-08-30 kl. 19:13, skrev Pierre-Louis Bossart:
>> +static inline int snd_sof_remove_no_wq(struct snd_sof_dev *sdev)
>> +{
>> +	if (sof_ops(sdev)->remove_no_wq)
>> +		return sof_ops(sdev)->remove_no_wq(sdev);
>> +
>> +	return 0;
>> +}
>>   	/* probe/remove/shutdown */
>> +	int (*probe_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
>> +	int (*remove_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
> My initial PR didn't have this remove_no_wq() callback.
>
> For symmetry it could be useful if it is meant to undo what the
> probe_no_wq() did, but conceptually the first thing we do in the remove
> is make sure that workqueue is either not scheduled or we wait until it
> completes.
>
> int snd_sof_device_remove(struct device *dev)
> {
> 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
> 	struct snd_sof_pdata *pdata = sdev->pdata;
> 	int ret;
>
> 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
> 		cancel_work_sync(&sdev->probe_work);

That is exactly what I was using it for later on.

I had to have a counter to hda_init() in patch 10/11.

Cheers,
Maarten



