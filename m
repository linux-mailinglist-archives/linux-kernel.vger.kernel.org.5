Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D48770327
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjHDObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjHDOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:31:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC349E1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159487; x=1722695487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eJzJo9AR2BodOCVYp/r933ED2YT4HHaNcfP+gWBSxys=;
  b=EcUceeDYYh/bVqArtFmkJcMUeZDJBzzwPvGGdXJngR3En+MOTeRAFhDp
   3rKLdyW8VpSGozSCD3U9b6J7uHC0jFkyRrwLxTeEDLaw/6fsWqv/Xefr/
   C9AKlMK4ve0DYCCTmv/iJUrMzIpwAFDwBy0dTLtPCchsyv+D03OrXgnBB
   5sfCrtuym0PZBEGGK7V+Ckp8mS0P1McjbzNfrMDokaxl0mOZYC8iY59ym
   ezt2O3dautCTNYMUKWa5AjSFheogvD56FifC3zHwiFk3gg+XP9+PU1Frn
   pc+9LdD/tgHXAmd7VEdv81yTpuO4CnfFjkgG73y1+TLEV2QwPVR/fjTR3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="367625031"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="367625031"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="1060751622"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="1060751622"
Received: from kwhite1-mobl.ger.corp.intel.com (HELO [10.251.210.112]) ([10.251.210.112])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:31:23 -0700
Message-ID: <6469f503-df51-f25f-28ec-6ade51fda5a6@linux.intel.com>
Date:   Fri, 4 Aug 2023 16:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: SOF: Intel: Move binding to display driver outside
 of deferred probe
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <87r0oohyea.wl-tiwai@suse.de>
 <ec653abc-f2f8-8a9d-4b8a-ea9d985d32fe@linux.intel.com>
 <f6efb6f9-11ae-e901-f2a5-a4ef94590290@linux.intel.com>
 <2719a8fc-d2e5-f499-ac4d-cf322941526c@linux.intel.com>
 <383ebe0e-e333-4b6e-8688-98a20977d03c@sirena.org.uk>
Content-Language: en-US
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <383ebe0e-e333-4b6e-8688-98a20977d03c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Den 2023-08-04 kl. 13:59, skrev Mark Brown:
> On Fri, Aug 04, 2023 at 12:47:54PM +0200, Maarten Lankhorst wrote:
>> On 2023-08-01 18:32, Pierre-Louis Bossart wrote:
>> This mail can be applied with git am -c.
>> ------8<---------
>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> Don't do this, it breaks my automation and means I very nearly just
> skipped the patch entirely since it looked like the middle of some x86
> discussion.

Yeah, it's replacing the patch from earlier. I can resend, but means 
having to add all acks, r-b'd, etc. :)

If you have scripts that do that, all the better.

Cheers,

~Maarten

