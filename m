Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C501975EEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGXJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGXJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:11:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6646F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690189889; x=1721725889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IJuS2NPpHW5yxPKPbFGIfcOiW3Jkp5gRaCUPlulOu7Y=;
  b=Ix2gkj4ATs03SgwGw3ViW9CMfslG5LHjnlJnrNwfcIv+KR39UgND21g0
   F0+useCF/I9pJO1/2nIgBKuQi6xrjZT8YW8724mxosrewjjuY2hOO20Et
   d2azxPtjDLICJQLkeR0F3PStNqSvU6u1lJb4Zjy37jHCpQ4IpknAm/SV2
   5sxFgRF+Yv1a4RC+3mfN+ZUjsy5tD9YOp8f9rDlZzD4x6259UtLIaNqXb
   n69pJMaok3moA+H+terTyfLnJW9xrFEfQOyZTCTxlwj9OlWBjnEDsHpIS
   HRDpR+WcWX6AtuYmw2TJI0uW90sbh0Zi/1LI4TXTr2t6Wt75Q3YN3IDKu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="370060617"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370060617"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="1056353961"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="1056353961"
Received: from sosterlu-mobl.ger.corp.intel.com (HELO [10.249.37.56]) ([10.249.37.56])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:11:24 -0700
Message-ID: <dc6de509-6984-1434-b53f-9600e8bc7c49@linux.intel.com>
Date:   Mon, 24 Jul 2023 11:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
 <20230720092628.758834-2-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230720092628.758834-2-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/23 11:26, Brent Lu wrote:
> Implement a helper function to get number of codecs from ACPI
> subsystem to remove the need of quirk flag in machine driver.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/intel/boards/sof_maxim_common.c | 174 +++++++++++++---------
>  sound/soc/intel/boards/sof_maxim_common.h |  21 ++-
>  2 files changed, 113 insertions(+), 82 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
> index 112e89951da0..f8b44a81fec1 100644
> --- a/sound/soc/intel/boards/sof_maxim_common.c
> +++ b/sound/soc/intel/boards/sof_maxim_common.c
> @@ -4,6 +4,7 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>  #include <sound/pcm.h>
> +#include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include <sound/soc-acpi.h>
>  #include <sound/soc-dai.h>
> @@ -11,6 +12,21 @@
>  #include <uapi/sound/asound.h>
>  #include "sof_maxim_common.h"
>  
> +/* helper function to get the number of specific codec */
> +static int get_num_codecs(const char *hid)
> +{
> +	struct acpi_device *adev = NULL;
> +	int dev_num = 0;
> +
> +	do {
> +		adev = acpi_dev_get_next_match_dev(adev, hid, NULL, -1);

Humm, I am a bit worried about reference counts.

See
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/utils.c#L916,
it's not clear to me where the get() is done.

Adding Andy to make sure this is done right.

> +		if (adev)
> +			dev_num++;
> +	} while (adev != NULL);
> +
> +	return dev_num;
> +}
