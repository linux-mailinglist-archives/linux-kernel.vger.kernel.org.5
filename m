Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229197573ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGRGRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGRGQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:16:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A74198C;
        Mon, 17 Jul 2023 23:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689660953; x=1721196953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9g/w+OtA/tXE1l89Sm+GplUHhYROa8NkCFZNpGL+W30=;
  b=hrji8Rey7ZpD1SqFgrsrIIE66X+5RfkjZcRhT6VZrS0jVExFP4IxlKg7
   j7CxSe/qz9kFUONXOcHsiIPpqHFDGkOi41lCgvuck5GUcCfJVyXQxIJCB
   oGB6EqmxfaQpC5YfAnwyMJ6TJ3KEGapRXRKrrkGW9v7/FP+h08Vy5p3au
   Ft3y014s8Y8UXpQPbXRkFpLGjwjOtvYnr2LedT9go/XVgsYCVVb2B3WFp
   lnfW1k0jihtofRmSk8NRk8cvltD0aYi1WYoP4ev5W+Zl9bKl6jRgIgZy+
   OkuOmw6pOfJSW2W0dF9QR8FLNZUF0E6T3gSaKfcSxENzkU7y8sCa7xwnK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368763974"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="368763974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788927576"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="788927576"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.138])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:13:42 -0700
Message-ID: <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com>
Date:   Tue, 18 Jul 2023 09:13:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] mmc: core: Remove FW revision from CID check
To:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
References: <20230718011504.10947-1-wenchao.chen@unisoc.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230718011504.10947-1-wenchao.chen@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/23 04:15, Wenchao Chen wrote:
> When the card is reset, mmc_card_init() will check if this
> card is the previous card by comparing the CID.
> 
> If the firmware is upgraded, the product version may change,
> so we remove the product version from the CID check.

What is the use-case for this?  I would have thought it is safer
not to assume anything about the card after the firmware has been
upgraded.

> 
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/mmc.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..32a73378d5c3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -32,6 +32,9 @@
>  #define MIN_CACHE_EN_TIMEOUT_MS 1600
>  #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
>  
> +#define MMC_CID_PRV_MASK GENMASK(23, 16)
> +#define MMC_CID_CRC_MASK GENMASK(7, 0)
> +
>  static const unsigned int tran_exp[] = {
>  	10000,		100000,		1000000,	10000000,
>  	0,		0,		0,		0
> @@ -126,6 +129,19 @@ static int mmc_decode_cid(struct mmc_card *card)
>  	return 0;
>  }
>  
> +static int mmc_check_cid(u32 *cid, u32 *raw_cid)
> +{
> +	/*
> +	 * When comparing CID, we need to remove the product
> +	 * version (Field PRV, offset 55:48) and CRC. Because
> +	 * the product version will change when the firmware
> +	 * is upgraded. Also, the new CRC is different.
> +	 */
> +	return cid[0] != raw_cid[0] || cid[1] != raw_cid[1] ||
> +		(cid[2] & ~MMC_CID_PRV_MASK) != (raw_cid[2] & ~MMC_CID_PRV_MASK) ||
> +		(cid[3] & ~MMC_CID_CRC_MASK) != (raw_cid[3] & ~MMC_CID_CRC_MASK);
> +}
> +
>  static void mmc_set_erase_size(struct mmc_card *card)
>  {
>  	if (card->ext_csd.erase_group_def & 1)
> @@ -1640,7 +1656,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		goto err;
>  
>  	if (oldcard) {
> -		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
> +		if (mmc_check_cid(cid, oldcard->raw_cid)) {
>  			pr_debug("%s: Perhaps the card was replaced\n",
>  				mmc_hostname(host));
>  			err = -ENOENT;

