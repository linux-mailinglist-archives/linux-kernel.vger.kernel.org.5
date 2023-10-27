Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB19B7D8E80
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjJ0GLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:11:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1631AD;
        Thu, 26 Oct 2023 23:11:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39R6Bb6C010971;
        Fri, 27 Oct 2023 01:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698387097;
        bh=NA4L4brfJcyEh6tN4VGt18esOxDUl5IjCG/PrXygxBE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=YMxH9GITElSn2Do/BU+meNMI6xdntssDoCvl+bwlrO8fOAQJEIzWht1084M1HNynW
         wgWeKOMG8L8+7FQsbCIwApyg6jg4nRy3ZZlaPkHVTtO/dHx8ENfThPTscHYE+cVVxt
         BSiV1xrQ+gu2GQVcQshd2aRIjCH9ftMWLwE4ZvUU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39R6Bb34029277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 01:11:37 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 01:11:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 01:11:36 -0500
Received: from [10.24.69.29] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39R6BYbE120724;
        Fri, 27 Oct 2023 01:11:35 -0500
Message-ID: <7054b3bb-de99-3fb0-5f17-78249f31c53f@ti.com>
Date:   Fri, 27 Oct 2023 11:41:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mmc: sdhci_am654: fix start loop index for TAP value
 parsing
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231026061458.1116276-1-n-yadav@ti.com>
 <8b7f948d-316c-4135-875a-de455ff4849c@intel.com>
 <8148dae9-e3fc-4589-ba57-a3f7a3e63b80@intel.com>
From:   Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <8148dae9-e3fc-4589-ba57-a3f7a3e63b80@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 26/10/23 12:33, Adrian Hunter wrote:
> On 26/10/23 10:00, Adrian Hunter wrote:
>> On 26/10/23 09:14, Nitin Yadav wrote:
>>> ti,otap-del-sel-legacy/ti,itap-del-sel-legacy passed from DT
>>> are currently ignored for all SD/MMC and eMMC modes. Fix this
>>> by making start loop index to MMC_TIMING_LEGACY.
>>>
>>> Fixes: 8ee5fc0e0b3be ("mmc: sdhci_am654: Update OTAPDLY writes")
>>>
>>
>> There isn't usually a blank line here
>>
>> Perhaps a Cc: stable@vger.kernel.org tag?
>>
>>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>>
>> Nevertheless:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Sorry, sent that prematurely - see comment below
> 
>>
>>
>>> ---
>>>  drivers/mmc/host/sdhci_am654.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>> index 544aaaf5cb0f..aae9d255c6a1 100644
>>> --- a/drivers/mmc/host/sdhci_am654.c
>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>> @@ -606,7 +606,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>>>  		return 0;
>>>  	}
>>>  
> 
> Isn't the MMC_TIMING_LEGACY information read at the top of
> sdhci_am654_get_otap_delay()?
Loop also take care of ITAP. Looks like at some point single property
ti,otap-del-sel was used for all modes and then we moved to one property
per mode:
https://lore.kernel.org/r/20200108150920.14547-3-faiz_abbas@ti.com
(since v5.7)
> 
>>> -	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
>>> +	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>>>  
>>>  		ret = device_property_read_u32(dev, td[i].otap_binding,
>>>  					       &sdhci_am654->otap_del_sel[i]);
>>
> 

-- 
Regards,
Nitin
