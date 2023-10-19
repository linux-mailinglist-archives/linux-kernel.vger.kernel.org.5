Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BA7CFC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbjJSOW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbjJSOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:22:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F9119;
        Thu, 19 Oct 2023 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697725346; x=1729261346;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wt+aX4la4eXjHv+2TrkEeyyK7itYRmgyqM39uYkX+0o=;
  b=HV0j+wP+b6n4Z9neZi4VfVeZ/oucqr3oJGKD5w9VG+ggMosE6xQ6BZrA
   qM60kNTGkVlQ6qjPB9Zhs7Vt38sb5wLhmLzy/fru9C6PagIjDNRqDFwhO
   QMpMGdBXuFyz650m5SXTrDk5DqFpPYz1lZaqotXW7UYad2lpeQSYTAzRL
   0OnuZFEI0ihcllgphN3EPN6YjS7cRuwywfkpW+4Mt/enDWWt89YIfzfC6
   jXA/VQAtV3e2B1ryaIxMybcn2bGloerbwM76D0CfPKZuFAgnAp/jkBNJl
   11e2pZM9TxNcZd78fzCx5N5wgZFMqrAD+T2DieG1WBeRkpA3apsyAs6lU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385136636"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="385136636"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="786402701"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="786402701"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:22:22 -0700
Message-ID: <7b08520e-8f36-45a1-9b7a-316a33c8e8c4@linux.intel.com>
Date:   Thu, 19 Oct 2023 16:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk
 detection
To:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20231018235944.1860717-1-markhas@chromium.org>
Content-Language: en-US
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20231018235944.1860717-1-markhas@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2023 1:59 AM, Mark Hasemeyer wrote:
> Some Jasperlake Chromebooks overwrite the system vendor DMI value to the
> name of the OEM that manufactured the device. This breaks Chromebook
> quirk detection as it expects the system vendor to be "Google".
> 
> Add another quirk detection entry that looks for "Google" in the BIOS
> version.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
>   sound/hda/intel-dsp-config.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> index 24a948baf1bc..756fa0aa69bb 100644
> --- a/sound/hda/intel-dsp-config.c
> +++ b/sound/hda/intel-dsp-config.c
> @@ -336,6 +336,12 @@ static const struct config_entry config_table[] = {
>   					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
>   				}
>   			},
> +			{
> +				.ident = "Google firmware",
> +				.matches = {
> +					DMI_MATCH(DMI_BIOS_VERSION, "Google"),
> +				}
> +			},
>   			{}
>   		}
>   	},

I would assume that platform that has DMI_SYS_VENDOR set to "Google", 
also has DMI_BIOS_VERSION set to "Google", so perhaps just replace 
DMI_SYS_VENDOR match with DMI_BIOS_VERSION, to keep table small? Or is 
that not a case?
