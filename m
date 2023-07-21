Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C775C5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGULdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGULdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:33:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE01FD7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689939228; x=1721475228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgP7XFYudIRUfF8wSd8qKahDYm0g7JaTcDAF/BBMutY=;
  b=Ay7luUe0opQ1i6fA+dfNUtzQ7zLhySJIdXIJkOZsmtb236aASgvqGXon
   sJ43Aw+j2F8HjJCimKI+bOXRXeaZvGxcUZqURh2Kfnpo6YLLq1NRfFBli
   V4xg82aQ8gj3nCKJMtP0OHFYwfAqplX3xxD+NC1rwXgT91rmdYr77escI
   b6NBvTQiW++OnQRNNKQ4yqUVF9ySzhndO1b222RSHVhTZ0qcrXiMjC5s/
   P2KcZuYwRS8KJCR2W+nLGmAKXXCIz5FWzSaBPBnTkr43MHed8ZVLEdwbj
   waDx4pv8ElVg3T3ES2GllPhvtoZ/2D0H68KUrQlm+hAANccCYrZ6vaT70
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370602518"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370602518"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="675008378"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="675008378"
Received: from dhardfel-mobl1.ger.corp.intel.com (HELO [10.251.223.78]) ([10.251.223.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:33:33 -0700
Message-ID: <98af3d56-0efe-8b35-246e-0fa28cf6966b@linux.intel.com>
Date:   Fri, 21 Jul 2023 14:34:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/9] ALSA: hda/intel: Fix error handling in azx_probe()
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-2-maarten.lankhorst@linux.intel.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230719164141.228073-2-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2023 19:41, Maarten Lankhorst wrote:
> Add missing pci_set_drv to NULL call on error.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  sound/pci/hda/hda_intel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index ef831770ca7da..0d2d6bc6c75ef 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2188,6 +2188,7 @@ static int azx_probe(struct pci_dev *pci,
>  	return 0;
>  
>  out_free:
> +	pci_set_drvdata(pci, NULL);
The original patch added this:
f4c482a4d0b3 ("ALSA: hda - Fix yet another race of vga_switcheroo registration")

but got removed later by:
20a24225d8f9 ("ALSA: PCI: Remove superfluous pci_set_drvdata(pci, NULL) at remove")

and partially added back (to azx_remove) by:
e81478bbe7a1 ("ALSA: hda: fix general protection fault in azx_runtime_idle")

I guess, it should do not harm to add it back...

>  	snd_card_free(card);
>  	return err;
>  }

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
