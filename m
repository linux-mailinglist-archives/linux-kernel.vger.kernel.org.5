Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A30761818
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjGYMSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjGYMSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:18:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB1A7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690287480; x=1721823480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Ocevg64N0aIV9rG69RXaUubDlT2/mkhIyMR1Q1WkzY=;
  b=B1h8VPOsqYgnBTADgLdBS3eu0xQq5rjFsvgYjdQOttYVTwk7AjV48n9P
   Gb1+8Je0qzVCfFtBZb7aa0sOiKVqAchgSSS2l/+ApKjiz+yaLGIPHWjjd
   U634xFEJBBqBdvBiYDfjN+D/ffnglKbqvjI1kP4OBZgSP00bd8dFqvLMU
   Y67iLuAjmecKj/VKH1nt6VSF3Lm9P7CpqqdGi22SBFJ5m2e6zzzbNjb2x
   sulBzt+GKW2DIiqDiJgzO6Clrjjn+fzHygtRywahiFHe0GwZx6XOqAFYo
   2SOKAGreQuPTHhAyshma83stan/ZfWovQpAAJ+nz0dEhq90nWPQbsC3s+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="352601903"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352601903"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="791367909"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="791367909"
Received: from mongola-mobl.ger.corp.intel.com (HELO [10.249.37.129]) ([10.249.37.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:17:56 -0700
Message-ID: <b0037097-b917-9069-7d8f-07e0317d6b9f@linux.intel.com>
Date:   Tue, 25 Jul 2023 13:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/9] ALSA: hda/i915: Allow override of gpu binding.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
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
 <20230719164141.228073-3-maarten.lankhorst@linux.intel.com>
 <9b285ede-eaeb-40a2-086d-30cf74185784@linux.intel.com>
 <d75c1902-b715-4a33-1965-ec06d625e3ac@linux.intel.com>
 <932c4293-375f-685c-2cfd-0bc80fd80683@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <932c4293-375f-685c-2cfd-0bc80fd80683@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> @@ -121,6 +128,9 @@ static int i915_gfx_present(struct pci_dev
>>>> *hdac_pci)
>>>>   {
>>>>       struct pci_dev *display_dev = NULL;
>>>>   +    if (!gpu_bind || (gpu_bind < 0 &&
>>>> video_firmware_drivers_only()))
>>>> +        return false;
>>
>>
>> Bear with me since I am just going back to work mode but I can't figure
>> out what the second part of the test does
>>
>> bool video_firmware_drivers_only(void)
>> {
>>     return video_nomodeset;
>> }
>> EXPORT_SYMBOL(video_firmware_drivers_only);
>>
>> and video_nomodeset=1 by default, so why would we return false when
>> gpu_bind = -1?
>>
>> This seems to be a change of functionality, what am I missing?
> video_nomodeset is 0 by default, only when nomodeset is given as
> argument is it set to 1. :-)


I must be missing something on how the default is handled.

bool video_firmware_drivers_only(void)
{
	return video_nomodeset;
}
EXPORT_SYMBOL(video_firmware_drivers_only);

static int __init disable_modeset(char *str)
{
	video_nomodeset = true;

isn't default 'true' then?
