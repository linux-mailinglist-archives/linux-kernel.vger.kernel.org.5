Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD3768B52
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGaFko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGaFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:40:43 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87F5E76
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690782022; x=1722318022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qxFz2UwvnFHJYzgei+xCEu7KR04+AmG77qcHQUxmLjY=;
  b=i224ZnxWUUF+md9GHbbAgakHqF3hMPNSqJwpQgcfud7K/Ju8pbXo5/kB
   CnRHqV8g/0jODvp/aBXEduexYaSyCSlAFKIioWPs9yECGH7meB/bWOE9H
   FmfDJ0yMnLV1A0kObQkw18FldHWv69EKVI/ExWDpdo3EE0cui20QPBExn
   9QCJMMIFGiKxfODIRVUY+X5ftUzzpSoPu56tUKBSRWweYabkWg27sJl3X
   Zo1PolZzGj9qY4u3jsZO3G/VKp5i/mqM1ez0MAAV8wQxaf9B1DZwo+cBs
   qcvjFJSe0tWsaEZw6KA/09tJ003oletSB8QQIEJ6BfvQd+5FONX+xy8X5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="368938065"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="368938065"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 22:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678193915"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678193915"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.92.2.114]) ([10.92.2.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 22:40:00 -0700
Message-ID: <70ff624f-75d3-d6b1-e709-97d7c75ea3da@linux.intel.com>
Date:   Mon, 31 Jul 2023 13:39:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/1] ASoC: Intel: maxim-common: get codec number from
 ACPI table
Content-Language: en-US
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
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230731103419.2536036-1-brent.lu@intel.com>
 <20230731103419.2536036-2-brent.lu@intel.com>
From:   "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20230731103419.2536036-2-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/31/2023 6:34 PM, Brent Lu wrote:
> We implement a helper function to get number of codecs from ACPI
> subsystem instead of using quirk flag in machine driver. Also refactor
> module interface by adding max_98390_dai_link() function.
>
> On the sof_rt5682 machine driver side, we remove the quirk flag
> SOF_MAX98390_TWEETER_SPEAKER_PRESENT and use the new interface of
> max98390 to setup dai link.
>
> Signed-off-by: Brent Lu <brent.lu@intel.com>


Looks good to me.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>


