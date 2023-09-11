Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AFA79A3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjIKGwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIKGwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:52:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80C106
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694415145; x=1725951145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4vB32nanE+MDEqTy1CJdYDHQ1Wfx+YCcuQAd0vYkfI0=;
  b=WKua4m95IaMDYpXoH7yZroqz2WnLcZYw+gfRZZmKsg9Fvgbh4+XKY+AX
   UTMBQEQQQJLu4I8VRCxl6CvJxKbNVrWBdxxXNbAtBmMAGzljMx81F5Y3Y
   /XaT3D/SNjv+0DmPJU3kbvJQpWy81llZHfhgjpTfqVS00jr83j+fPoehX
   WNoSTPSia3DH2m8GtKdoyRsEjNDBga/8WzXlPBtRdPme8CPHz08bnJoGi
   7ejVDMoFfBTtmJMJrXACoRhpa2hUWDXEladGB5nnGvH0RDckWgh6Dca02
   6OxGL9QYabVCFF1AQ7PZkIUph5N4AQ/BUCW22AgR9My/6xsVP+JgT7wkv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="380707657"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="380707657"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 23:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="746303083"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="746303083"
Received: from vcouthon-mobl1.ger.corp.intel.com (HELO [10.251.216.222]) ([10.251.216.222])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 23:51:52 -0700
Message-ID: <e8880daf-8f74-4350-96c4-d625272aed35@linux.intel.com>
Date:   Mon, 11 Sep 2023 09:51:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <6d39eac7-06c7-45f0-0318-72be1753641f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 20:29, Pierre-Louis Bossart wrote:
>> I think find all this very confusing, because there is no workqueue used
>> in the remove steps. The workqueue is only used ONCE during the probe.
> 
> Maybe we should just remove any references to workqueues, and have
> 
> probe_start (cannot run in a wq)
> probe (may run in a wq)
> remove (cannot run in a wq, needs to call cancel_work_sync() if the
> probe runs in a wq)
> remove_last (cannot run in a wq, releases all resources acquired in
> probe_start)
> 
> Or something similar that shows the symmetry between steps and when the
> wq is allowed.

What we have atm:
snd_sof_probe - might be called from wq
snd_sof_remove - might be called from wq (cleans up the snd_sof_probe
		 step)

We want a callbacks for hardware/device probing, right, split the
snd_sof_probe (and remove) to be able to support a sane level of
deferred probing support.

With that in mind:
snd_sof_device_probe - Not called from wq (to handle deferred probing)
snd_sof_probe - might be called from wq

snd_sof_remove - might be called from wq (cleans up the snd_sof_probe
		 step)
snd_sof_device_remove - Not called from wq (to up the
			snd_sof_device_probe step)

Naming option: s/device/hardware

However, I think the snd_sof_device_remove itself is redundant and we
might not need it at all as in case we have wq and there is a failure in
there we do want to release resources as much as possible. The module
will be kept loaded (no deferred handling in wq) and that might block
PM, other devices to behave correctly. Iow, if the wq has failure we
should do a cleanup to the best effort to reach a level like the driver
is not even loaded.

Doable? I thin it is.

-- 
Péter
