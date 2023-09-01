Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B4778FD27
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349413AbjIAM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347272AbjIAM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:26:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF0E7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693571215; x=1725107215;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5IwvKZUL4r+o1Dkpg2+N1HzSJYIChqWKmULOQ9RkBY0=;
  b=Ppe4QTkUXzAMP10bzYVp2sLZCfh391mjvbY2PBqUefLTn49p0FVZShYo
   2tZEvcmqIifMQWUAU1mhEel0WqyAWb7TwzbWq1IH3iEKyvsgslr+gd9ga
   rq4Xehp4RIaE3hJpRdwEZguF4ldqg6eOKw2pu7xD78Ook3AIoL4HYM3Xu
   jJSXmTbzjwE3KE3VskFJOsKiL25Yc3iLRcvGTZTmBvgef9bEZCY52Wxil
   v26w6/Yk5KRfj4SEIm6viYviRePWcWklUPzO/jfS8nM3eQUdL7r+1kbrN
   6vcAlkNeKzKMjtvdUtBk+FOrzvni6RJYsRWE1wL7ZJkVWew5O8gl/ssIT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442602208"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="442602208"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070732852"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070732852"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:26:49 -0700
Date:   Fri, 1 Sep 2023 15:22:50 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
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
In-Reply-To: <ac21f644-dedc-289b-3783-0cf2db8c0a73@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2309011516110.3532114@eliteleevi.tm.intel.com>
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com> <20230830153652.217855-2-maarten.lankhorst@linux.intel.com> <ac21f644-dedc-289b-3783-0cf2db8c0a73@linux.intel.com>
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

On Wed, 30 Aug 2023, Pierre-Louis Bossart wrote:

> >  	/* probe/remove/shutdown */
> > +	int (*probe_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
> > +	int (*remove_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
> 
> My initial PR didn't have this remove_no_wq() callback.
> 
> For symmetry it could be useful if it is meant to undo what the
> probe_no_wq() did, but conceptually the first thing we do in the remove
> is make sure that workqueue is either not scheduled or we wait until it
> completes.

I think that's exactly what the patch ends up with, remove_no_wq releases 
resources acquired in probe_no_wq, i.e. they are symmetrical.
 
> int snd_sof_device_remove(struct device *dev)
> {
> 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
> 	struct snd_sof_pdata *pdata = sdev->pdata;
> 	int ret;
> 
> 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
> 		cancel_work_sync(&sdev->probe_work);

So this seems ok as well:
 - if wq is used, at remove, we first wait wq to be finished 
   and only then proceed with removal
 - the remove_no_wq is run only when the first step is completed

Br, Kai
