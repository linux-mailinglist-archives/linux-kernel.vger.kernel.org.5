Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CC79C6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjILGLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjILGKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:10:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2510F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694499008; x=1726035008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/82m/eWXPto7V4rYgjFmteBnbWE+vgoAqqytm5FOt80=;
  b=i79nX7rlb2VaSL3OjeHvRPlidz7Y0cdU2zJT69Hs2NcZnKJMslZ5F0Cc
   Lq034jadc527x35e58PkLiyCQcDBs68h4HqulrP3n8VYdQWRB8qjaU8mh
   DVcDuS+aTaJ2zDCNHsXcvRYKyxguFP2niwPpoKUpBkiuBp3ua+mhLX2d9
   3n16gMSmIdWcRC6hKGWVvXBmclF9s18461YlzAkpbrLPCMGeAUbUhFRNz
   eHrxzi434mqLfEOi7Gi4RIiWj63BJsexsHFEKrQJmfGoM5tRbN2gi3idd
   e0gQzYnL15D+/xn9Byne/++k0m2mWex7YYFHz6k9RRnp/1ZfI29vAH2Qk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378197004"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="378197004"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693373022"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="693373022"
Received: from mkidd-mobl.ger.corp.intel.com (HELO [10.251.217.72]) ([10.251.217.72])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:10:00 -0700
Message-ID: <b878b564-8c18-4103-88d6-4f7b5fe01dba@linux.intel.com>
Date:   Tue, 12 Sep 2023 09:10:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
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
 <e8880daf-8f74-4350-96c4-d625272aed35@linux.intel.com>
 <34d34e99-c6a3-2d08-2c4b-c548b6b87e9a@linux.intel.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <34d34e99-c6a3-2d08-2c4b-c548b6b87e9a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2023 03:25, Pierre-Louis Bossart wrote:
> 
> 
>> What we have atm:
>> snd_sof_probe - might be called from wq
>> snd_sof_remove - might be called from wq (cleans up the snd_sof_probe
>> 		 step)
> 
> I don't think it's correct, snd_sof_remove cannot be called from a wq.
> The device core knows nothing about workqueues.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/sof/core.c#n328

it is called on the error path of sof_probe_continue(), which can be run
in a workque.

>> We want a callbacks for hardware/device probing, right, split the
>> snd_sof_probe (and remove) to be able to support a sane level of
>> deferred probing support.
>>
>> With that in mind:
>> snd_sof_device_probe - Not called from wq (to handle deferred probing)
>> snd_sof_probe - might be called from wq
>>
>> snd_sof_remove - might be called from wq (cleans up the snd_sof_probe
>> 		 step)
>> snd_sof_device_remove - Not called from wq (to up the
>> 			snd_sof_device_probe step)
>>
>> Naming option: s/device/hardware
> 
> I like the 'device' hint since it's directly related to the device (or
> subsystem) callbacks.
> 
>> However, I think the snd_sof_device_remove itself is redundant and we
>> might not need it at all as in case we have wq and there is a failure in
>> there we do want to release resources as much as possible. The module
>> will be kept loaded (no deferred handling in wq) and that might block
>> PM, other devices to behave correctly. Iow, if the wq has failure we
>> should do a cleanup to the best effort to reach a level like the driver
>> is not even loaded.
> 
> If we have a failure in a workqueue used for probe, then we have to
> clean-up everything since nothing in the device core will do so for us.

Yes, this makes the snd_sof_device_remove() redundant or at least the
definition of it is no longer a mirror of snd_sof_device_probe():

snd_sof_device_remove - might be called from wq (cleans up the
			snd_sof_device_probe step)

Any failure in sof_probe_continue() should execute the
snd_sof_device_remove(), snd_sof_remove() is only involved after the
snd_sof_probe() have returned with success.

I think this makes actually makes sense and it is well defined.
On module remove we need to take into account the case when we have
failed in wq similarly as we do currently (the resources have been freed
up already).

-- 
Péter
