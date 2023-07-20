Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5175A6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGTGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGTGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:45:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E25B268C;
        Wed, 19 Jul 2023 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689835517; x=1721371517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TfkzamveMbxl7osZRf/DBt0QPKBNI6ZOlRULHeBX3RI=;
  b=EQenF/8dkNkt+AT4vyXKxEuDvWkGcdmVeRix2H+i20u9FkNMNAYQoIXS
   4iG1W6FMsqClzffE+EN2lAucP7OeigR5Gh9LaBLi9byJcVpLwIkt/Bu9a
   6z/dV8G2YSAs6jJdn7Z2lBuZVmVNR2To5ynHxjkG4MX762YagyX3WPuT0
   KU46lJ3r1lbGhD2boxKdFEfZPeiR6YWZ0BDQnSrkN4F5y7Tv8DCQgC4yj
   2wAwDsb7Vjo4juwo58k3htCXRE45nC+Axh8G+uM6SdK/XpiB77xRiPKpZ
   PyEOQWa/fS+XLDC2d5/Sx04LMWZGoId5s1ajEYJwcRde/m3F9yxTl1IN1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356614779"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356614779"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674584718"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="674584718"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:45:05 -0700
Message-ID: <ff06bd46-bf43-d2dc-751f-47f41ccc1821@intel.com>
Date:   Thu, 20 Jul 2023 09:44:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] mmc: core: Remove FW revision from CID check
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
References: <20230718011504.10947-1-wenchao.chen@unisoc.com>
 <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com>
 <CA+Da2qxOhK7Uc8_ONVgkR=3pTnTo7KgcJi-yS3Cv730+J0pAxA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+Da2qxOhK7Uc8_ONVgkR=3pTnTo7KgcJi-yS3Cv730+J0pAxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/23 05:46, Wenchao Chen wrote:
> On Tue, Jul 18, 2023 at 2:13 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 18/07/23 04:15, Wenchao Chen wrote:
>>> When the card is reset, mmc_card_init() will check if this
>>> card is the previous card by comparing the CID.
>>>
>>> If the firmware is upgraded, the product version may change,
>>> so we remove the product version from the CID check.
>>
>> What is the use-case for this?  I would have thought it is safer
>> not to assume anything about the card after the firmware has been
>> upgraded.
>>
> Hi adrian
>     Understood, but we have case:
>     1.Before the firmware upgrade
>         [T5745@C0] mmc0 oldcard raw->cid[2]: 32691160, raw->cid[3]: d9241800
>         PRV=69
>     2.After the firmware upgrade
>         [T5745@C0] mmc0 cid[2]: 32011160 cid[3]: d9241800
>         PRV=01
>     If the PRV is not excluded in the CID check, then the mmc
> initialization will fail after the mmc reset.
>     In addition, CRC is excluded because some controllers support
> SDHCI_QUIRK2_RSP_136_HAS_CRC.

I do not know what others are doing in this regard, nor what
circumstances are leading to the re-initialization.

Presumably a clean re-initialization could be done by
unbinding and rebinding the host controller.

> 
>>>
>>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>>> ---
>>>  drivers/mmc/core/mmc.c | 18 +++++++++++++++++-
>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 89cd48fcec79..32a73378d5c3 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -32,6 +32,9 @@
>>>  #define MIN_CACHE_EN_TIMEOUT_MS 1600
>>>  #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
>>>
>>> +#define MMC_CID_PRV_MASK GENMASK(23, 16)
>>> +#define MMC_CID_CRC_MASK GENMASK(7, 0)
>>> +
>>>  static const unsigned int tran_exp[] = {
>>>       10000,          100000,         1000000,        10000000,
>>>       0,              0,              0,              0
>>> @@ -126,6 +129,19 @@ static int mmc_decode_cid(struct mmc_card *card)
>>>       return 0;
>>>  }
>>>
>>> +static int mmc_check_cid(u32 *cid, u32 *raw_cid)
>>> +{
>>> +     /*
>>> +      * When comparing CID, we need to remove the product
>>> +      * version (Field PRV, offset 55:48) and CRC. Because
>>> +      * the product version will change when the firmware
>>> +      * is upgraded. Also, the new CRC is different.
>>> +      */
>>> +     return cid[0] != raw_cid[0] || cid[1] != raw_cid[1] ||
>>> +             (cid[2] & ~MMC_CID_PRV_MASK) != (raw_cid[2] & ~MMC_CID_PRV_MASK) ||
>>> +             (cid[3] & ~MMC_CID_CRC_MASK) != (raw_cid[3] & ~MMC_CID_CRC_MASK);
>>> +}
>>> +
>>>  static void mmc_set_erase_size(struct mmc_card *card)
>>>  {
>>>       if (card->ext_csd.erase_group_def & 1)
>>> @@ -1640,7 +1656,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>               goto err;
>>>
>>>       if (oldcard) {
>>> -             if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
>>> +             if (mmc_check_cid(cid, oldcard->raw_cid)) {
>>>                       pr_debug("%s: Perhaps the card was replaced\n",
>>>                               mmc_hostname(host));
>>>                       err = -ENOENT;
>>

