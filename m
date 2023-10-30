Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09647DB4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjJ3IHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjJ3IHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:07:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F0C9;
        Mon, 30 Oct 2023 01:07:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39U87Owj088839;
        Mon, 30 Oct 2023 03:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698653244;
        bh=ODz0sm3tFst2rQ5PTq9uui03oHrQZkgoaoB5cf+ILv8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=wTP32IrQMkkSBn9xTkoQcaQlFnXhVBZIuLrAPc1zgQJ41DDuSd3ivhSRHkwMWWy01
         PSda22g/uya9t+pl15cuH4DHSegG+ExReyI/Y8LT9TVZxBKV73g8CCqjEYeaA8l2LZ
         9Z9YfbZ1L/UTT+IfDlysQGFERaeasvSTG760xgqg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39U87OAg094512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Oct 2023 03:07:24 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 03:07:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 03:07:23 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39U87LVw013556;
        Mon, 30 Oct 2023 03:07:21 -0500
Message-ID: <42f1b9a6-2dad-42ca-a41c-3a57f87323cc@ti.com>
Date:   Mon, 30 Oct 2023 13:37:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci_am654: fix start loop index for TAP value
 parsing
Content-Language: en-US
To:     Nitin Yadav <n-yadav@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231026061458.1116276-1-n-yadav@ti.com>
 <8b7f948d-316c-4135-875a-de455ff4849c@intel.com>
 <8148dae9-e3fc-4589-ba57-a3f7a3e63b80@intel.com>
 <7054b3bb-de99-3fb0-5f17-78249f31c53f@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <7054b3bb-de99-3fb0-5f17-78249f31c53f@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitin, Adrian

On 27/10/23 11:41, Nitin Yadav wrote:
> Hi Adrian,
> 
> On 26/10/23 12:33, Adrian Hunter wrote:
>> On 26/10/23 10:00, Adrian Hunter wrote:
>>> On 26/10/23 09:14, Nitin Yadav wrote:
>>>> ti,otap-del-sel-legacy/ti,itap-del-sel-legacy passed from DT
>>>> are currently ignored for all SD/MMC and eMMC modes. Fix this
>>>> by making start loop index to MMC_TIMING_LEGACY.
>>>>
>>>> Fixes: 8ee5fc0e0b3be ("mmc: sdhci_am654: Update OTAPDLY writes")
>>>>
>>>
>>> There isn't usually a blank line here
>>>
>>> Perhaps a Cc: stable@vger.kernel.org tag?
>>>
>>>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>>>
>>> Nevertheless:
>>>
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Sorry, sent that prematurely - see comment below
>>
>>>
>>>
>>>> ---
>>>>  drivers/mmc/host/sdhci_am654.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>> index 544aaaf5cb0f..aae9d255c6a1 100644
>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>> @@ -606,7 +606,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>>>>  		return 0;
>>>>  	}
>>>>  
>>
>> Isn't the MMC_TIMING_LEGACY information read at the top of
>> sdhci_am654_get_otap_delay()?
> Loop also take care of ITAP. Looks like at some point single property
> ti,otap-del-sel was used for all modes and then we moved to one property
> per mode:
> https://lore.kernel.org/r/20200108150920.14547-3-faiz_abbas@ti.com
> (since v5.7)

Looks like ti,otap-del-sel is deprecated for a while now (since v5.7+). 
I think that's sufficient enough time to drop it now (don't see any in 
kernel DT use this property). Lets drop the above code which handles 
MMC_TIMING_LEGACY separately, so that below for() loop can handle the 
whole set of bindings efficiently.

Since this patch is marked for stable, can we get rid of the check for 
deprecated property in a follow up patch?

Something like below? (completely untested):


diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index c125485ba80e..50c8d3051096 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -577,32 +577,17 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 	int i;
 	int ret;
 
-	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
-				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
-	if (ret) {
-		/*
-		 * ti,otap-del-sel-legacy is mandatory, look for old binding
-		 * if not found.
-		 */
-		ret = device_property_read_u32(dev, "ti,otap-del-sel",
-					       &sdhci_am654->otap_del_sel[0]);
-		if (ret) {
-			dev_err(dev, "Couldn't find otap-del-sel\n");
-
-			return ret;
-		}
-
-		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
-		sdhci_am654->legacy_otapdly = true;
-
-		return 0;
-	}
-
-	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
+	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
 
 		ret = device_property_read_u32(dev, td[i].otap_binding,
 					       &sdhci_am654->otap_del_sel[i]);
 		if (ret) {
+			if (i == MMC_TIMING_LEGACY) {
+				dev_err(dev, "ti,otap-del-sel-legacy is mandatory");
+				return ret;
+			}
+
 			dev_dbg(dev, "Couldn't find %s\n",
 				td[i].otap_binding);
 			/*



>>
>>>> -	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
>>>> +	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>>>>  
>>>>  		ret = device_property_read_u32(dev, td[i].otap_binding,
>>>>  					       &sdhci_am654->otap_del_sel[i]);
>>>
>>
> 

-- 
Regards
Vignesh
