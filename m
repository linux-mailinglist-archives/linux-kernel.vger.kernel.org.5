Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F867D09A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376442AbjJTHlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:41:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AAF93;
        Fri, 20 Oct 2023 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697787660; x=1729323660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fS62KeVFtHKj3IzMszL8FfoyimzWJ7T3TmklfnrmAnk=;
  b=BCxt5KraMbWQnOCN9YpgwNy2AC+TU6/sZN+hyB+FxkUKZd/nm/qV8Kth
   5K5Av4/tVCoYfP3rtxJSt/vjtUsWOR7HT2P1jX+TOn/rxKmSyZ7olrkmx
   OcMb1ZT4NuUiGSzT7MCh4mEKTzvaxK8ohUlgL2MOKGBPY6tLhGKm8z7fd
   Wp1/VZrnBhmbwcABa77kS/MdMVoxiXJx4i1ncTprSyGPw/6261QJ2gFEf
   gvhgUAfQ/BBbaABsOvlkKYyppcfzC51cfOD+Crwhaq7oid4+MRHlcdRjq
   P2W3vWjPtB8vreAcOmvIldqqrHb9c1rpohYtCZnzVQnCSsva9fhsiZm9M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="376829458"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="376829458"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="5028885"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.209.150])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:39:46 -0700
Message-ID: <613c51f0-c32e-4de5-9627-525d92fb06ed@intel.com>
Date:   Fri, 20 Oct 2023 10:40:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: cqhci: Be more verbose in error irq handler
Content-Language: en-US
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, upstream@semihalf.com
References: <20231016095610.1095084-1-korneld@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231016095610.1095084-1-korneld@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/23 12:56, Kornel Dulęba wrote:
> There are several reasons for controller to generate an error interrupt.
> They include controller<->card timeout, and CRC mismatch error.
> Right now we only get one line in the logs stating that CQE recovery was
> triggered, but with no information about what caused it.
> To figure out what happened be more verbose and dump the registers from
> irq error handler logic.
> This matches the behaviour of the software timeout logic, see
> cqhci_timeout.
> 
> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
> ---
>  drivers/mmc/host/cqhci-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index b3d7d6d8d654..33abb4bd53b5 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>  
>  	terri = cqhci_readl(cq_host, CQHCI_TERRI);
>  
> -	pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d TERRI: 0x%08x\n",
> -		 mmc_hostname(mmc), status, cmd_error, data_error, terri);
> +	pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d\n",
> +		 mmc_hostname(mmc), status, cmd_error, data_error);
> +	cqhci_dumpregs(cq_host);

For debugging, isn't dynamic debug seems more appropriate?

>  
>  	/* Forget about errors when recovery has already been triggered */
>  	if (cq_host->recovery_halt)

