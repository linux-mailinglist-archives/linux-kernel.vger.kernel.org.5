Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684FB7D1474
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJTRAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJTRAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:00:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640618F;
        Fri, 20 Oct 2023 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697821198; x=1729357198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DFuYk/iZFo38XXz5QEJHG+rb8/gZLVBaR1l70X7qLgQ=;
  b=Gs4mHLh80z2r1jvcMi98LLUXii/dNC/kDQNlgW7IgaNbUo/qF1yKnnnk
   u2M5ZpvKP60bkP40qQNaHtWEhE12Vz/XggnbnipXYsoiVc9cw2SQMqw+T
   uQ9pfWnKPwAD6O0vjSaHpzrQWRfChTDH8p7suwvhIDfa10wY2ZhCDIC4T
   sh94UP+a1bqlitG8T1lF63RPc025o9QTz3YE1GKOm1aIMJpuX3d33v0Ii
   Pzk63BXwh/r7PJcqPqyhIgNsVGobYPOQErmjM/5jScAPBd/T7DPMVlpWT
   vizOSRQtcRUFhPoIwhZ3QcnK+6CnTK01Fzj1cZeusZqbsSX9pbTFd5FAh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="5144946"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="5144946"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="901189445"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="901189445"
Received: from mtadesse-mobl.amr.corp.intel.com (HELO [10.209.140.77]) ([10.209.140.77])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:57:46 -0700
Message-ID: <80f8a742-4a60-4c75-9093-dcd63de70b66@linux.intel.com>
Date:   Fri, 20 Oct 2023 11:59:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk
 detection
Content-Language: en-US
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Curtis Malainey <cujomalainey@chromium.org>
References: <20231018235944.1860717-1-markhas@chromium.org>
 <7b08520e-8f36-45a1-9b7a-316a33c8e8c4@linux.intel.com>
 <CANg-bXDvZ00ZHEgbUf1NwDrOKfDF4vpBOxZ4hGEp-ohs6-pZpw@mail.gmail.com>
 <5bc82aca-04f2-463b-ba52-34bcae6724d5@linux.intel.com>
 <CANg-bXCaUOxSTfR1oXKrdnDozA9Hn-NL7mqg+zvLASLQyouChA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CANg-bXCaUOxSTfR1oXKrdnDozA9Hn-NL7mqg+zvLASLQyouChA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/23 10:36, Mark Hasemeyer wrote:
>> FWIW we use this other quirk:
>> DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
> 
> Unfortunately DMI_PRODUCT_FAMILY is empty on these particular devices.
> The coreboot version field is the only entry that has "Google" in it.

well then you have additional issues with the DMI quirk for the firmware
selection in sound/soc/sof/sof-pci-dev.c,

      {
		.ident = "Google Chromebooks",
		.callback = chromebook_use_community_key,
		.matches = {
			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
		}
	},

which means you need additional kernel parameters to provide the
location of the firmware....

>> How many engineers does it take to identify a Chromebook, eh?
> 
> Ha! There has been some discussion about this: to come up with a
> canonical way for Chromebook identification throughout the kernel. But
> nothing has been settled on AFAIK.

There's been multiple rounds of discussions with Curtis, we introduced
DMI_OEM_STRING but it's still not good enough, and now the previous
conventions are not being followed on what is a relatively old platform
already...
