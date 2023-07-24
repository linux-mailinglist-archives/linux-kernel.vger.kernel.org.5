Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6875F55F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGXLqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGXLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:46:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A7E42
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690199167; x=1721735167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fhZel62+8xGqW7JvNVoWADK8SmdGZHFTifhbfTYCCcI=;
  b=fgu049UL81T1O9CKChabEVcrClwmSuKZn1NIbYQNKT+xabRti2G5Rp+w
   69cHdjduawglB6RJ4ChNa5vdOfozyj1UHQQqDjqOmki+UxhHjVbLCC3Mc
   cr1FCuWNTzMsoUQCTmlei6Sfa1BYZo21vEBjHLJxlQXrxk5UEYnLMMLSE
   N8KsWMfMUTJ3Eky2RYSkszPkjRXsHxHzvGa1YAvgBkWC5A95qqnUcVMsh
   B1zdrEALHcG3ESO860kXZWo2nUjCU7xyoOesxqvKXWIH4Jf4VbQU7427N
   uskx8etuCBuMirGJgPqXwQ0yUADmt64cRSr297Sgt8bd9gitiESKwJj9c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398322156"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398322156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760761948"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760761948"
Received: from sosterlu-mobl.ger.corp.intel.com (HELO [10.249.37.56]) ([10.249.37.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:03 -0700
Message-ID: <10216a8e-c29c-fc24-e4b5-240743fadd5e@linux.intel.com>
Date:   Mon, 24 Jul 2023 12:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/9] ALSA: hda/intel: Fix error handling in azx_probe()
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-2-maarten.lankhorst@linux.intel.com>
 <98af3d56-0efe-8b35-246e-0fa28cf6966b@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <98af3d56-0efe-8b35-246e-0fa28cf6966b@linux.intel.com>
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



On 7/21/23 13:34, Péter Ujfalusi wrote:
> 
> 
> On 19/07/2023 19:41, Maarten Lankhorst wrote:
>> Add missing pci_set_drv to NULL call on error.
>>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> ---
>>  sound/pci/hda/hda_intel.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index ef831770ca7da..0d2d6bc6c75ef 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -2188,6 +2188,7 @@ static int azx_probe(struct pci_dev *pci,
>>  	return 0;
>>  
>>  out_free:
>> +	pci_set_drvdata(pci, NULL);
> The original patch added this:
> f4c482a4d0b3 ("ALSA: hda - Fix yet another race of vga_switcheroo registration")
> 
> but got removed later by:
> 20a24225d8f9 ("ALSA: PCI: Remove superfluous pci_set_drvdata(pci, NULL) at remove")
> 
> and partially added back (to azx_remove) by:
> e81478bbe7a1 ("ALSA: hda: fix general protection fault in azx_runtime_idle")
> 
> I guess, it should do not harm to add it back...
> 
>>  	snd_card_free(card);
>>  	return err;
>>  }
> 
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

