Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1A78DFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbjH3TZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbjH3RNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:13:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B617FF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693415601; x=1724951601;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ANfXAO5TdW9bfyaLHG5RVf/5RWD0EfUwUeq0Rle47AU=;
  b=InkAbp2U41YZx7phOLdlUsNjgiG9mKMubhGRImI7bGtemCj3NUlcJ289
   DURiHLCsqMgGCWqs5lSAJO1dOhN4T1Zvs+LzQQzjBvOGN6+kRqVpMj9jD
   lcctLzgk1z/Ys2VNmtc8aTZZWBE6d4ssM26vzsF4mgioYHjY9S1UIWyDj
   wkQmJhZdDF/wFZY7/jheYSLMytFc4W9LlZ1Gmb8Mzv/5n4HpyQO5N2udp
   v2FLSiPp07vGSWORUHAXNI9bn/vGyMkDu1QiHsO2Gc2zq2GmTsgK+emAt
   CqKVfeFIiJVRtgnf33PDBX/kPuBI8B1pPJKD3X7Ybp934gat4oGfL29x0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356019140"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="356019140"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774175297"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774175297"
Received: from cunningh-mobl.amr.corp.intel.com (HELO [10.212.55.116]) ([10.212.55.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:13:18 -0700
Message-ID: <ac21f644-dedc-289b-3783-0cf2db8c0a73@linux.intel.com>
Date:   Wed, 30 Aug 2023 12:13:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static inline int snd_sof_remove_no_wq(struct snd_sof_dev *sdev)
> +{
> +	if (sof_ops(sdev)->remove_no_wq)
> +		return sof_ops(sdev)->remove_no_wq(sdev);
> +
> +	return 0;
> +}

>  	/* probe/remove/shutdown */
> +	int (*probe_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
> +	int (*remove_no_wq)(struct snd_sof_dev *sof_dev); /* optional */

My initial PR didn't have this remove_no_wq() callback.

For symmetry it could be useful if it is meant to undo what the
probe_no_wq() did, but conceptually the first thing we do in the remove
is make sure that workqueue is either not scheduled or we wait until it
completes.

int snd_sof_device_remove(struct device *dev)
{
	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
	struct snd_sof_pdata *pdata = sdev->pdata;
	int ret;

	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
		cancel_work_sync(&sdev->probe_work);

