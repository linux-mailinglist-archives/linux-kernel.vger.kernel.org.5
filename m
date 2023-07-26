Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3911F762EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjGZH51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjGZH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:56:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415C6EB8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690357755; x=1721893755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/R38XYog4+QpG82OrQJ3Z95EuFCn1/IVFT2UrPu1ZJ4=;
  b=H82Fvu42PZJvGZlzTCh4sCNHHS0vxyFlg2lCEM9PYfPqXQ7EIP9ItD9s
   HrbLZaOp5zMPQtOB8ss7xXO2LzEBVy9QwQ+Mno93UY8Cknrr6U5mLo2C/
   TDu2M6cYgV0O9hrAKqIce0uSikyMpaQOzKukNu/01mfCUZxrDUeJmicDf
   D1zExGOvMzqLggrqOKadN916xDMykWMerlLRaRNBSnpgysRZXhGmXcRx2
   B4walXIN+H+WYAM/wTr1QJYEboM+PafAYMeYvpA4Oup5ZoFFY4a6WmeZf
   BS8+iWXDbwn0GzoMiVA7WaYnutzlrgXZKsCho8If0KgNrQNVoyoCuNWdO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434205663"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="434205663"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 00:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="850366942"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="850366942"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 00:49:10 -0700
Message-ID: <cce17be6-acdf-9737-f2cb-3559712e4c56@linux.intel.com>
Date:   Wed, 26 Jul 2023 09:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: intel: avs: refactor strncpy usage in topology
Content-Language: en-US
To:     justinstitt@google.com,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2023 12:08 AM, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1].
> 
> A suitable replacement is `strscpy` [2].
> 
> There are some hopes that someday the `strncpy` api could be ripped out
> due to the vast number of suitable replacements (strscpy, strscpy_pad,
> strtomem, strtomem_pad, strlcpy) [1].
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> ---
> 
> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>   sound/soc/intel/avs/topology.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
> index cdb4ec500261..45d0eb2a8e71 100644
> --- a/sound/soc/intel/avs/topology.c
> +++ b/sound/soc/intel/avs/topology.c
> @@ -1388,12 +1388,12 @@ static int avs_route_load(struct snd_soc_component *comp, int index,
>   		port = __ffs(mach->mach_params.i2s_link_mask);
>   
>   		snprintf(buf, len, route->source, port);
> -		strncpy((char *)route->source, buf, len);
> +		strscpy((char *)route->source, buf, len);
>   		snprintf(buf, len, route->sink, port);
> -		strncpy((char *)route->sink, buf, len);
> +		strscpy((char *)route->sink, buf, len);
>   		if (route->control) {
>   			snprintf(buf, len, route->control, port);
> -			strncpy((char *)route->control, buf, len);
> +			strscpy((char *)route->control, buf, len);
>   		}
>   	}
>   
> 

In this case snprintf adds NUL at the end and we strncpy using same 
size, so there should always be NUL at the end, so replacing it with 
strscpy shouldn't really change anything, so

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
