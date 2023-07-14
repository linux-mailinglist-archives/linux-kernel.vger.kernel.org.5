Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E167753717
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjGNJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjGNJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:50:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348783AA8;
        Fri, 14 Jul 2023 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689328196; x=1720864196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3F1gJUZuwGS/+WhrOPDx6vo6HdvA/IOcyCdKuC7K65g=;
  b=j6VGNL60jqczI4B2aFdELMDzQNATqfD+1WdIdT/wJtNsnvf7omryd3OZ
   EQh9BarpsaZjLdR0dN9Wrwg2kfkDB/B1ob6P1RWNdRx5c5p5l6lnVP7m5
   kMVViHYAbJ5ZjSNnXrtrgJ3mZbPJmt3rRzFCUzOXmrRdRv6nsCb8bieXS
   g1INdMZmIbetItvFkmg9oK7Nw3MwVSDA1Ssc30YY35EMU4wJtkS0rK3Oj
   t74gNG2KNjgQbu1r8/UbKy+o/44GxqvsQGrCDo6roe05MClExF09yi5xD
   cdPlpcEZGV10/ssbLESY9d6J9lX4NbNSFvs1v92EEUp/cSFSG2nvcWebt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368985776"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="368985776"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716284935"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716284935"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.109])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:49:53 -0700
Message-ID: <af01d060-dbaa-aa54-8203-3da5fcbc0a79@intel.com>
Date:   Fri, 14 Jul 2023 12:49:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 09/58] mmc: sdhci-pic32: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-9-frank.li@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230713080807.69999-9-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/23 11:07, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

For the following patches:

[PATCH 09_58] mmc: sdhci-pic32: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 10_58] mmc: sdhci: milbeaut: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 12_58] mmc: sdhci-of-at91: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 15_58] mmc: sdhci-pxav3: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 19_58] mmc: xenon: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 20_58] mmc: sdhci-s3c: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 27_58] mmc: sdhci-of-arasan: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 28_58] mmc: sdhci-of-dwcmshc: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 33_58] mmc: sdhci-omap: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 34_58] mmc: sdhci-of-aspeed: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 36_58] mmc: sdhci-sprd: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 37_58] mmc: sdhci-tegra: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 38_58] mmc: sdhci-acpi: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 39_58] mmc: sdhci-esdhc-imx: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 40_58] mmc: sdhci-msm: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 47_58] mmc: sdhci-st: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 49_58] mmc: sdhci-esdhc-mcf: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1107
[PATCH 51_58] mmc: sdhci-spear: Convert to platform remove callback returning void - Yangtao Li <frank.li@vivo.com> - 2023-07-13 1108

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

