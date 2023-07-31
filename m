Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A088769AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGaPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGaPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:18:36 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CA10E3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690816715; x=1722352715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tHseUDP5ewIZ91U0WgZQH8SlyWmcwyeqJNAjRGZdQ4c=;
  b=WYoUadmwKPo634XFchdtos1Qpj4E/QGrJCr/FRi3HjRMsN4QTFIkbhQ7
   K9NA5r42SVxavdOZGEhSsDSa6oGQshPM0gRxIc7T7AsTlvTN0k9ppa9MO
   03yn3K1wabX6IyJBnrQOmS/z+IBwZrBeIOrNCsmwlfvXycr17NIqAaqvU
   NeOrgsyyPI438scsFfLVRSBoB4WvWCDNszX6xR+n8qy802dkucIgKMb60
   sQgxKW/LPAU3uev8IiXIhOdqPT4nY2e75lF+6gvmSFgExSlCGrt+FLnoB
   PHEhcCgZSWSHEzWGCGSbvr7cW1i2NdoJYtw0Ptx4em2VYXhukFithHGyx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="432863977"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="432863977"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 08:18:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852095057"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="852095057"
Received: from sambriz-mobl.amr.corp.intel.com (HELO [10.212.68.117]) ([10.212.68.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 08:18:33 -0700
Message-ID: <f3b6e859-3cf1-e12c-4de7-83cce04a122f@linux.intel.com>
Date:   Mon, 31 Jul 2023 09:53:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/1] ASoC: Intel: maxim-common: get codec number from
 ACPI table
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230731103419.2536036-2-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
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



On 7/31/23 05:34, Brent Lu wrote:
> We implement a helper function to get number of codecs from ACPI
> subsystem instead of using quirk flag in machine driver. Also refactor
> module interface by adding max_98390_dai_link() function.
> 
> On the sof_rt5682 machine driver side, we remove the quirk flag
> SOF_MAX98390_TWEETER_SPEAKER_PRESENT and use the new interface of
> max98390 to setup dai link.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
