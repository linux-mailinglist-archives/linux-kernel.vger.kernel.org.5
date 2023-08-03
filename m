Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5076DFD8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjHCFqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHCFqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:46:18 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15118B;
        Wed,  2 Aug 2023 22:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691041577; x=1722577577;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mFCkt2CtHZxzVcF/LPkPl1Ap9M2EBzEL1E1MgW6RjIg=;
  b=QGu6EsRLFhqvPOdEQ0ffwilAKlCjCSauuxZSu7anY40jhoApcWRBMxv/
   buKSBRVbA/hkDiS0OytTSuQWf2TVaZ1PneYWADW8F5YgIEj2t3LiyLB/S
   7KnW9fSifDGLgQ0Ed9RcimVCrvg1TqsVxfTf5w5TYg9FoxwMBmq+318AD
   2RZ4r2QBMsWgkduhH386BT9qmztLnerKNA71VB63gxSuhFe7SP1nWT7kr
   jedsmWWYX78SqAV8es98h9D3W6wb/ce/DP4mfK6sqi344NuaTI6ks31ki
   hctUMJx4xcnaI7w5K0JZmHi58ElEATmwzWUFbB3r40odBJ0JAlp3A+saW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368676893"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="368676893"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 22:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="853114340"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="853114340"
Received: from mehlinma-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.36.218])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 22:46:13 -0700
Message-ID: <643e844b-2640-e2c8-d8a7-1cd91d453ccc@intel.com>
Date:   Thu, 3 Aug 2023 08:46:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v3 62/62] mmc: f-sdh30: fix order of function calls in
 sdhci_f_sdh30_remove
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-62-frank.li@vivo.com>
 <90febfa5-b520-05f5-53ca-af0e1f3fc7c4@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <90febfa5-b520-05f5-53ca-af0e1f3fc7c4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/23 16:55, Adrian Hunter wrote:
> On 27/07/23 10:00, Yangtao Li wrote:
>> The order of function calls in sdhci_f_sdh30_remove is wrong,
>> let's call sdhci_pltfm_unregister first.
>>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Fixes: 5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>  drivers/mmc/host/sdhci_f_sdh30.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
>> index 840084ee72e6..964fa18a61a4 100644
>> --- a/drivers/mmc/host/sdhci_f_sdh30.c
>> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
>> @@ -211,11 +211,11 @@ static void sdhci_f_sdh30_remove(struct platform_device *pdev)
>>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>>  	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>>  
>> +	sdhci_pltfm_unregister(pdev);
> 
> That also frees priv
> 
>> +
>>  	reset_control_assert(priv->rst);
>>  	clk_disable_unprepare(priv->clk);
>>  	clk_disable_unprepare(priv->clk_iface);
>> -
>> -	sdhci_pltfm_unregister(pdev);
>>  }
>>  
>>  #ifdef CONFIG_OF
> 

So it needs to end up looking something like below, right?

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 840084ee72e6..47ae853f51aa 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -210,12 +210,15 @@ static void sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
-
-	reset_control_assert(priv->rst);
-	clk_disable_unprepare(priv->clk);
-	clk_disable_unprepare(priv->clk_iface);
+	struct clk *clk_iface = priv->clk_iface;
+	struct reset_control *rst = priv->rst;
+	struct clk *clk = priv->clk;
 
 	sdhci_pltfm_unregister(pdev);
+
+	reset_control_assert(rst);
+	clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk_iface);
 }
 
 #ifdef CONFIG_OF

