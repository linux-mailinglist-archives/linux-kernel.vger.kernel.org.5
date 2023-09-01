Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE278FD0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbjIAMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbjIAMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:19:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A088810E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693570769; x=1725106769;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6fhqpXo0/Z0lw7VbNhZ+LrcTlrYs6pwKdmefppNW2kg=;
  b=UjkoZtvJRA6FcInjXKX6dAjxh+nB/trbM7YAj/e2YX5PhIBVC7z97KnW
   l7b8Hu0JIkrpywlJ/0Dbhxd7cN0S2H9Ghn0CN7ScK4v7B259VzNFUzcJO
   OIYbA/ME7Orjj8xR3rJXTvVj9FZ2nEkulQSWIAOPXtwoNQ4OA2/T2wRB8
   A88QxEL39tmjY5GgtciVkqN3b4QWyBFfuuVt0Nhngf9y2H1uwmm0dT2eb
   BqFM8KCU0exZ1h4IZAsrJpXEv0brZxLJVkWS+zuAhi/3wAj7O4BERI6Sh
   F3u2C0RZkgnPP7AjJ+8wKyGaDod4qQYhKSThB0D41CqARqYrLJArvEaOO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373605722"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373605722"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986659994"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="986659994"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:19:23 -0700
Date:   Fri, 1 Sep 2023 15:15:25 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
In-Reply-To: <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2309011509200.3532114@eliteleevi.tm.intel.com>
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com> <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Aug 2023, Maarten Lankhorst wrote:

> With the upcoming changes for i915/Xe driver relying on the
> -EPROBE_DEFER mechanism, we need to have a first pass of the probe
> which cannot be pushed to a workqueue. Introduce 2 new optional
> callbacks.
[...]
> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
> index 30db685cc5f4b..54c384a5d6140 100644
> --- a/sound/soc/sof/core.c
> +++ b/sound/soc/sof/core.c
> @@ -327,8 +327,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>  dsp_err:
>  	snd_sof_remove(sdev);
>  probe_err:
> -	sof_ops_free(sdev);
> -

this seems a bit out-of-place in this patch. It seems a valid change,
but not really related to this patch, right?

We seem to have a related fix waiting to be sent to alsa-devel, by
Peter:
"ASoC: SOF: core: Only call sof_ops_free() on remove if the probe wa"
https://github.com/thesofproject/linux/pull/4515

... not yet in Mark's tree.

Otherwise patch looks good to me.

Br, Kai
