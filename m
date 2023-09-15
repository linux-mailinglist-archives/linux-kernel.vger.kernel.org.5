Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BACA7A1A35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjIOJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjIOJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:17:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F89B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694769423; x=1726305423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CDwlISH8mA5+8r/atwWQjOKJK6Fu8LdmLkEDKau+iAQ=;
  b=JWQIAFApH3GGoBn3pvQUZfRLO9GDySGopMroH1IdlVgUJnuSxae4jbqU
   2RDdWvJcQxNtyuq/y8XsyVeni46D3g6Pfh+fcYHkXWgi0sAuv3UnsdxSN
   t/KInZ8uxW+ZHme0bV/ZPYPF8hE2j73DCf81VBYQOt4NCPWHxZwLFwQgQ
   37jxJGQZjAoBqGnRrqD5oYTWpDUznP40bE+amAfIsPSMCDPuy/oAZJKv7
   EMM7SV00oHg+uPFg2599jQP693HJpWR6fwjs1FTrIpraZ7OjABqyragUr
   NuNlOQvUBoTg5+YNoSCYVV4hNmJA/6Pe/Zdb+HvrkvAIrebwr88ZVYUgw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369524147"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="369524147"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744906235"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744906235"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:16:59 -0700
Message-ID: <1c887615-0e59-8556-e2ab-b985033519d7@linux.intel.com>
Date:   Fri, 15 Sep 2023 11:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ASoC: hdaudio.c: Add missing check for devm_kstrdup
Content-Language: en-US
To:     Chen Ni <nichen@iscas.ac.cn>, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        brent.lu@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230915021344.3078-1-nichen@iscas.ac.cn>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230915021344.3078-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2023 4:13 AM, Chen Ni wrote:
> Because of the potential failure of the devm_kstrdup(), the
> dl[i].codecs->name could be NULL.
> Therefore, we need to check it and return -ENOMEM in order to transfer
> the error.
> 
> Fixes: 97030a43371e ("ASoC: Intel: avs: Add HDAudio machine board")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   sound/soc/intel/avs/boards/hdaudio.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/intel/avs/boards/hdaudio.c b/sound/soc/intel/avs/boards/hdaudio.c
> index cb00bc86ac94..8876558f19a1 100644
> --- a/sound/soc/intel/avs/boards/hdaudio.c
> +++ b/sound/soc/intel/avs/boards/hdaudio.c
> @@ -55,6 +55,9 @@ static int avs_create_dai_links(struct device *dev, struct hda_codec *codec, int
>   			return -ENOMEM;
>   
>   		dl[i].codecs->name = devm_kstrdup(dev, cname, GFP_KERNEL);
> +		if (!dl[i].codecs->name)
> +			return -ENOMEM;
> +
>   		dl[i].codecs->dai_name = pcm->name;
>   		dl[i].num_codecs = 1;
>   		dl[i].num_cpus = 1;

Good catch

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
