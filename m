Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472077AC218
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjIWMo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjIWMo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:44:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA01127;
        Sat, 23 Sep 2023 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695473092; x=1727009092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hu5RoWjkAL+0NsE2efBSQIgp8d2u2PNDE0fCKAETueQ=;
  b=TH+ihEJwnYTS1fwotVj8vFma5YCJJtrPnCcOYrvypDvNQ5fwMYjPDrlD
   4kWgj+csStf/vzusf3iLLAYW5FloNKtmJv8FMw87BKNaYb2NvvRJ1Fjgd
   1JnJCC0tD/IvOCtRLb9ONVhwCteFrVQ0p9caaPyCWNVye8un3KUAlninH
   UQydZgLUvWT/F3IEb4ZBVia1zpzfnWTvAXetdQqsb4GhLBYWhAKvIqavx
   +YCvwb9RRJ9tZ0o8QD8WaNx326Nq10HwKw4uZAGLvrMAo1r+SSy3ptrsa
   K0ff3l2fzv5P5CfBfL/7rWdKzX6IKZTQ8INyJn4vd/akm/I40TqaMKsb8
   g==;
X-CSE-ConnectionGUID: AP7+RHyPQpK3JA0Ko4wGwA==
X-CSE-MsgGUID: wDhoZVAPQGi3bNolcUsGUw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="6214214"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2023 05:44:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 23 Sep 2023 05:44:51 -0700
Received: from [10.171.248.13] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Sat, 23 Sep 2023 05:44:49 -0700
Message-ID: <9a311ce3-0d29-af39-5533-c1cad6de1300@microchip.com>
Date:   Sat, 23 Sep 2023 14:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] mmc: Fix force card detect in sdhci
Content-Language: en-US
To:     Mathieu Moneyron <mathieu.moneyron@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230830092314.624212-1-mathieu.moneyron@gmail.com>
 <096e9122-23b8-5a36-7779-28994187c620@intel.com>
From:   Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <096e9122-23b8-5a36-7779-28994187c620@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 09:38, Adrian Hunter wrote:
> + Eugen Hristev  > > On 30/08/23 12:23, mathieu wrote: >> On the ATMEL at91 when using 
the non-removable flag in device tree >> and not using the card-detect 
pin inside the device-tree pinctrl, >> the card detect pin is physically 
still used which can cause >> unknown behaviour when this pin is used 
for other purposes.
Hi Mathieu,

On which SoC(s) exactly, has this behaviour been observed?

Also, has this issue been discussed in any separate support request, in such
case we could retrieve some background from it?

By "unknown behaviour", do you mean "the card insertion status would
follow whatever electrical level is seen on the card-detect pin"?

>>  >> From my interpretation this seems to be caused by a hardware design 
 >> flaw and the real hardware is not working as intended by the >> 
documentation. >>
>>
>> Signed-off-by: Mathieu Moneyron <mathieu.moneyron@gmail.com>
>>
>> ---
>>  drivers/mmc/host/sdhci-of-at91.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-at91.c 
>> b/drivers/mmc/host/sdhci-of-at91.c
>> index 69fef88e7..4fd6bfbf6 100644
>> --- a/drivers/mmc/host/sdhci-of-at91.c
>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>> @@ -51,10 +51,15 @@ struct sdhci_at91_priv {
>>  static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
>>  {
>>      u8 mc1r;
>> +    u8 ctrl;
>>
>>      mc1r = readb(host->ioaddr + SDMMC_MC1R);
>>      mc1r |= SDMMC_MC1R_FCD;
>>      writeb(mc1r, host->ioaddr + SDMMC_MC1R);
>> +
>> +    ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
>> +    ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
>> +    writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>>  }
>>
>>  static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned 
>> int clock)

Kind regards,
Aubin

