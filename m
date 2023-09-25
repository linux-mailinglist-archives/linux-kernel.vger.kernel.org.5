Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1117AD5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjIYKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIYKVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:21:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC2EA3;
        Mon, 25 Sep 2023 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695637277; x=1727173277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=25xM1GGX99FaJI1a7/sAeMNfBZdYigkRiv9j1kibCCQ=;
  b=A/m678kNZzOT7y+Ao43vOkO8C6174uW3ZgaHhcdwTttYHdHc3JP5Ysn+
   DOCZa/3EhVIMF6EZEtKkK50W7MjnAtVKBYtk1SQEc7NlZA6UiodZexSp9
   PUPA3A25rtXxyQRS0gmHWphyyPUUZP1NxdF82uLy6SKIYG5h/3X376Y0I
   Csmue9gPmklqM7ZDcA/rtRF66ZiQXGZIb6Guk5gmH6LZGeOAXsXi7X5Cp
   Qkjw/RuO4pW7O+wHNEsw97OiihWwhRhNkBlyYTjvsr9XqyYZMUS3uXKtJ
   sMVG/+b8gLIb9N5MRGYdHBoNgKuTUwNoCutsPyQrR5DwA/kdxoW0HcO1W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="381126628"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="381126628"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872002635"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="872002635"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.180])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:21:09 -0700
Message-ID: <4ef60ffd-3661-4bca-91a3-b49d6189c71b@intel.com>
Date:   Mon, 25 Sep 2023 13:21:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mmc: sdhci: add __sdhci_execute_tuning() to header
Content-Language: en-US
To:     Drew Fustini <dfustini@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-2-49f76c274fb3@baylibre.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230921-th1520-mmc-v1-2-49f76c274fb3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/23 04:49, Drew Fustini wrote:
> Expose __sdhci_execute_tuning() so that it can be called from the
> mmc host controller drivers.
> 
> In the sdhci-of-dwcmshc driver, sdhci_dwcmshc_th1520_ops sets
> platform_execute_tuning to th1520_execute_tuning(). That function has
> to manipulate phy registers before tuning can be performed. To avoid
> copying the code verbatim from __sdhci_execute_tuning() into
> th1520_execute_tuning(), make it possible for __sdhci_execute_tuning()
> to be called from sdhci-of-dwcmshc.
> 
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ff41aa56564e..fd607058d176 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2841,7 +2841,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_send_tuning);
>  
> -static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> +int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)

Also need
	EXPORT_SYMBOL_GPL(__sdhci_execute_tuning);

>  {
>  	int i;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f219bdea8f28..a20864fc0641 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -793,6 +793,7 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> +int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
> 

