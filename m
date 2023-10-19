Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE37D1074
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377405AbjJTNYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjJTNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:24:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81D19E;
        Fri, 20 Oct 2023 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697808278; x=1729344278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k6ndI6jcwy64xNeCRwxhVgSos4puSIbLOL6kbeJBH7s=;
  b=KrY84MeWUn2joZ8mdQaWKyBvM6+RiIX87I1NRSEUlEjltT28aj8ZzplK
   a1qSDYuX0C34WHKgv4Rvtfb2rFLeq7ftcFbGjTPdVb+KraORMzrY8AAz3
   B6hH8Dbnqaz2djMosEFIlWAv4WzGCz49nM/WicEy5W4mYbODb2OYSQWGH
   TRQ+BW8fyVWGZmRh++0rWIPqwRQg8VHrYviHkqJZwo5wLtCy9OvNbPvu4
   vAxcuXAsyNdLgTh1jt/ih2DPXmj1qcaVnuFbN2nq08BbDISBuNZZAwLxZ
   DEladML93+8SnPMRYIlF1g4ZExNZb142fHgJ8YNujT1Gs2PhUcHRgI7xX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385372620"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385372620"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 06:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881083826"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881083826"
Received: from mtadesse-mobl.amr.corp.intel.com (HELO [10.209.140.77]) ([10.209.140.77])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 06:24:36 -0700
Message-ID: <5bc82aca-04f2-463b-ba52-34bcae6724d5@linux.intel.com>
Date:   Thu, 19 Oct 2023 12:00:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk
 detection
Content-Language: en-US
To:     Mark Hasemeyer <markhas@chromium.org>,
        =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
References: <20231018235944.1860717-1-markhas@chromium.org>
 <7b08520e-8f36-45a1-9b7a-316a33c8e8c4@linux.intel.com>
 <CANg-bXDvZ00ZHEgbUf1NwDrOKfDF4vpBOxZ4hGEp-ohs6-pZpw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CANg-bXDvZ00ZHEgbUf1NwDrOKfDF4vpBOxZ4hGEp-ohs6-pZpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 11:43, Mark Hasemeyer wrote:
>> I would assume that platform that has DMI_SYS_VENDOR set to "Google",
>> also has DMI_BIOS_VERSION set to "Google", so perhaps just replace
>> DMI_SYS_VENDOR match with DMI_BIOS_VERSION, to keep table small? Or is
>> that not a case?
> 
> That is the case. But I'm inclined to keep it for two reasons:
> 1. There is precedent in the kernel to use DMI_SYS_VENDOR=="Google"
> for Chromebook detection.
> 2. If the coreboot version schema for Chromebooks were to change, this
> check would fail for all JSL Chromebooks instead of just a few models.

I also prefer a low-risk addition to a higher-risk change. It's not like
we really care about the size of the table at this point.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

FWIW we use this other quirk:
DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),

How many engineers does it take to identify a Chromebook, eh?
