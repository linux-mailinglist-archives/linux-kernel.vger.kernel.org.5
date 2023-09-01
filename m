Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC0378FD5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347262AbjIAMhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjIAMhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:37:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB5107
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693571839; x=1725107839;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MbSejPpVcn39K0suwGrMS6r7UtjeFPJhMP61frqFDgI=;
  b=a2h912M6eAo6I+4J2JWH0ukjGnpNzcBxfIckw1FICCnSoavHLu4ugtDM
   Wrkw34Qz0K3tHYrEYFS6VUB7tM/4MntOWYIvG1YNLQZ221Oj5gS1DAjUn
   DYn2+jAVyJ57tpZbleWpSTbwCAcEgNCtUKhs8Z+llaZzNXYs4G+gT6dN/
   tD4+POD2F6gnsCmmCHcgEofiwlur2oaB9OMIYc5hgAoORvY9HL2KXNRIw
   62t4OuN9U/4LtfABieEjvTgmq1BpkAPPLdrm00RQdivbLzUbdcBUr9i+x
   8L+stuk7TtLoT529Q7Zo2pvTE0WzLyKcq9L1nUZDtYFKnZpzjShbF8xIS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375111162"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="375111162"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689752177"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="689752177"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:37:14 -0700
Date:   Fri, 1 Sep 2023 15:33:19 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
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
Subject: Re: [PATCH v4 10/11] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
In-Reply-To: <20230830153652.217855-11-maarten.lankhorst@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2309011526300.3390143@eliteleevi.tm.intel.com>
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com> <20230830153652.217855-11-maarten.lankhorst@linux.intel.com>
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

Hey,

On Wed, 30 Aug 2023, Maarten Lankhorst wrote:

> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue.
> 
> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
> probe function.
> 
> The previously added probe_no_wq can be used for this,
> and we also use the newly added remove_no_wq for unbinding afterwards.
[...]
> @@ -1317,7 +1313,6 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
>  {
>  	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
>  	const struct sof_intel_dsp_desc *chip = hda->desc;
> -	struct hdac_bus *bus = sof_to_bus(sdev);
>  	struct pci_dev *pci = to_pci_dev(sdev->dev);
>  	struct nhlt_acpi_table *nhlt = hda->nhlt;
>  
> @@ -1368,10 +1363,12 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
>  	if (!sdev->dspless_mode_selected)
>  		iounmap(sdev->bar[HDA_DSP_BAR]);
>  
> -	iounmap(bus->remap_addr);
> -
> -	sof_hda_bus_exit(sdev);
> +	return 0;
> +}
>  
> +int hda_dsp_remove_no_wq(struct snd_sof_dev *sdev)
> +{
> +	iounmap(sof_to_bus(sdev)->remap_addr);
>  	hda_codec_i915_exit(sdev);

I think here we drop the call to sof_hda_bus_exit() which should be done 
in hda_dsp_remove_no_wq() to counter hda_init().

Rest looks good to me, the "no_wq" variants do symmetric ops,
so we can handle both wq an non-wq cases.

Br, Kai
