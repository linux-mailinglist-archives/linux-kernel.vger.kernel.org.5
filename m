Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F054A7634D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjGZLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGZLZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:25:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736B2131
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690370738; x=1721906738;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mnQJuBYjxws9dKF7YJmo1pX1cJQyyI8SIC/3VVKu3MI=;
  b=ljM7kJzv+AA4JLsQCrpOT3Kf4EzWQiWwIE8MwgJliMGhRjMHUK5gFM25
   L2BZwnAQtw/5rBw4DknI8/qDc541FEFWPszGQRd51ucjjdqcuRj1E+LNW
   6prytfT7Qj79wnWo79TW/IwExzKjSuTsNRifm0QEGBFLGdKZhrNQ+Tu38
   3/Qe7xMeXAVExPRo35E7wYnLqpmFWPhPw5u8LlIzxLJ/ogRPYtQ0Br0lm
   7oR8WrwXuTH4GCz6HC7hRZsyC/cbMeGJi5EDXhTTJXShniQ53gkyiujys
   Xl7WRnhsiXE076ajZr1jEYwLA+wKVaVILJ/dL6xhQze1nOjgPlsQMhV+q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="454362780"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="454362780"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="840221570"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="840221570"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.92.2.114]) ([10.92.2.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:25:34 -0700
Message-ID: <00321a54-2c13-2a93-a6ab-7a76f1a87a3d@linux.intel.com>
Date:   Wed, 26 Jul 2023 19:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
Content-Language: en-US
From:   "Liao, Bard" <yung-chuan.liao@linux.intel.com>
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
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
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
 <20230720092628.758834-2-brent.lu@intel.com>
 <ff55e63f-1c17-12ef-57e6-144a5bea4480@linux.intel.com>
In-Reply-To: <ff55e63f-1c17-12ef-57e6-144a5bea4480@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/26/2023 4:47 PM, Liao, Bard wrote:
> ;
>>   -    /* add regular speakers dapm route */
>> -    ret = snd_soc_dapm_add_routes(&card->dapm, max_98390_dapm_routes,
>> -                      ARRAY_SIZE(max_98390_dapm_routes));
>
> Don't we need to add max_98390_dapm_routes for the 4 speakers case?
>
Please ignore this comment. I didn't notice that it is a fallthrough not

break in the end of case 4.


