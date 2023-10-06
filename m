Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745257BB5A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjJFKvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjJFKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:51:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CD783;
        Fri,  6 Oct 2023 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696589473; x=1728125473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Debr6U/oJdxI33pRy4gxgYMy4vatAy9uxPfOkwc3jvk=;
  b=OF8YD5u5K4FP6QOe6sQCfz5aYeem+fFPmSMWBe4zmX8VqesA9rxa5T4w
   BsuPYfBW+nU9e2Qa2OJzrBqag7ab59fB3PFaAokPONw5Rguj2HLrUE08a
   2S57m4wCm1z6sS5OIDRDS+p33ZFJfy8RIooiCoxYV4TMTHeamUDQ+VB0i
   0s7HAtSJfhNQxZH0ayHEHFO0usOOo8nh+QS00xGwNCHzz8P2KIioIdCbV
   F5AvbyfiUNSv4zmNBfWuXBla5CAxVb0P2gT4y83Njy93P9c+QXNHCosuY
   OJt1lRq5fGhYx4HNeU1sE/f6cT7kcwum0SE9/BvkwzcYhVvAJZy7ED7Go
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450220641"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450220641"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083411636"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083411636"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.64])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:51:04 -0700
Message-ID: <8c80f712-45c3-4c7a-a694-11efa4591078@intel.com>
Date:   Fri, 6 Oct 2023 13:50:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
To:     Victor Shih <victorshihgli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-13-victorshihgli@gmail.com>
 <CAPDyKFpzuds6Ttbhw1cqZwisa+M6167DT3DUihcDqFjYJX95eA@mail.gmail.com>
 <CAK00qKDtXR2aV_h4KhAaWqjUfn8M2-yMsDHeFmz0ztjaF4wB=g@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKDtXR2aV_h4KhAaWqjUfn8M2-yMsDHeFmz0ztjaF4wB=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 13:30, Victor Shih wrote:
> On Tue, Oct 3, 2023 at 5:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>>>
>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>
>>> For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
>>> so no voltage switch required.
>>
>> Can you please elaborate on this? I don't get anything of the above, sorry.
>>
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>
>>> Updates in V5:
>>>  - Use sdhci_uhs2_mode() to simplify code in
>>>    sdhci_uhs2_start_signal_voltage_switch().
>>>
>>> ---
>>>
>>>  drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>> index fc37a34629c2..92fb69b7e209 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>> @@ -142,6 +142,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
>>>         }
>>>  }
>>>
>>> +/*****************************************************************************\
>>> + *                                                                           *
>>> + * MMC callbacks                                                             *
>>> + *                                                                           *
>>> +\*****************************************************************************/
>>> +
>>> +static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
>>> +                                                 struct mmc_ios *ios)
>>> +{
>>> +       struct sdhci_host *host = mmc_priv(mmc);
>>> +
>>> +       /*
>>> +        * For UHS2, the signal voltage is supplied by vdd2 which is
>>> +        * already 1.8v so no voltage switch required.
>>> +        */
>>> +       if (sdhci_uhs2_mode(host))
>>> +               return 0;
>>
>> This is just wrong. If we are initializing a uhs2 card, we certainly
>> should call ->start_signal_voltage_switch() callback at all. This is
>> for UHS-I cards, right?
>>
> 
> Hi, Ulf
> 
> UHS-II does not need single_voltage.
> I will modify the commit message in the next version.
> sdhci_uhs2_start_signal_voltage_switch() is under
> mmc_host_ops.start_signal_voltage_switch host ops,
> therefore, we need to keep the UHS-I path here.

You should be able to leave out the patch entirely
because ->start_signal_voltage_switch() is not called
for UHS2 mode

> 
> Thanks, Victor Shih
> 
>>> +
>>> +       return sdhci_start_signal_voltage_switch(mmc, ios);
>>> +}
>>> +
>>>  /*****************************************************************************\
>>>   *                                                                           *
>>>   * Driver init/exit                                                          *
>>> @@ -150,6 +171,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
>>>
>>>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>>>  {
>>> +       host->mmc_host_ops.start_signal_voltage_switch =
>>> +               sdhci_uhs2_start_signal_voltage_switch;
>>> +
>>>         return 0;
>>>  }
>>>
>>
>> Kind regards
>> Uffe

