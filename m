Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AC675EEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGXJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGXJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:11:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AE8F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690189866; x=1721725866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R8MoBTG8FHXPKYM/dy8lKyFiiYXOSBv/75gFE2jR2Y4=;
  b=cTSIbyPwY5wM3exTIfZSkqbeX515TOhAuVtBsTMo2boQTnm4geDSU/OG
   7SbwCNDFHK+brmxe4BUITHWdJUFNCffrhLOpK4jkMaktxJJWzk6VoQ7ky
   ooH8YyxzjYtTbmZzFjcuIJO7JNUTtqqhYSxjjalBzq7o2PjA4bPc/fzzy
   g4YRSJxhDBRsHDHFuN2+51BEBmOnvgRilY1xxYHuSlgXVtV+m1wi/UVb3
   e0EjHULfZIaMm0iAZjkBEscp7n3ImB9uMUdrM9SY50ktT4Ic6KEX8rmBy
   rFIiyrqsKGIizfznTFcb96dQuSlW4OdXBm7MlCkPRzIq8N3iAZGWRQGC+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="370060521"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370060521"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="1056353705"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="1056353705"
Received: from sosterlu-mobl.ger.corp.intel.com (HELO [10.249.37.56]) ([10.249.37.56])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:11:02 -0700
Message-ID: <10dc2616-0cc3-8827-b46b-ebea8874ac73@linux.intel.com>
Date:   Mon, 24 Jul 2023 11:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: fix application of sizeof to
 pointer
Content-Language: en-US
To:     sunran001@208suo.com, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
References: <20230720073836.3285-1-xujianghui@cdjrlc.com>
 <74739aaaa05f52084757b526bc8348c8@208suo.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <74739aaaa05f52084757b526bc8348c8@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/23 10:43, sunran001@208suo.com wrote:
> The coccinelle check report:
> ./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application of
> sizeof to pointer
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  sound/soc/sof/ipc4-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index a4e1a70b607d..2dbe87dbd239 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -218,7 +218,7 @@ static int sof_ipc4_get_audio_fmt(struct
> snd_soc_component *scomp,
> 
>      ret = sof_update_ipc_object(scomp, available_fmt,
>                      SOF_AUDIO_FMT_NUM_TOKENS, swidget->tuples,
> -                    swidget->num_tuples, sizeof(available_fmt), 1);
> +                    swidget->num_tuples, sizeof(*available_fmt), 1);
>      if (ret) {
>          dev_err(scomp->dev, "Failed to parse audio format token count\n");
>          return ret;

you need to Cc: maintainers and SOF folks who are knowledgeable on IPC4.
