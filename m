Return-Path: <linux-kernel+bounces-44844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10011842812
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F2A1F26C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B3823C9;
	Tue, 30 Jan 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTdPSF9a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6CE823B2;
	Tue, 30 Jan 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628702; cv=none; b=PeaFlqIsPujAaYmFB/9awAWcYwNtWihhdI3z39qFhjnZlXfsfcAwOl/nG0DI8jnY/m3u8BRcAtzSk/xpPouck6+0a3as3VvMSHBpObY+Oe8W8RVKjn2gUl1iGyvkk0QQgOMhszrxgJcrcMzLiTyAq69OLVfRmFhsDQl0EMX/s88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628702; c=relaxed/simple;
	bh=VFfXaMuM13ijuWEdNiaaHRki070Tzjou8g7ItrpOecQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3+cUJ+c5m+DAh+f9gicPOnb7lFk3G++DX4AAerE4jwQXDw2Rl086PLIDHEvuEzKk9G5wwhA8kTHJOsvguvcIVMrYqxjPYP4Q1iMi2Qat47jWR/faXWLZjUvvX6YaZNjStFkGESoL6hcqp6Ze9x6cFtaKncKe8juE6JF8vIOq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTdPSF9a; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706628700; x=1738164700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VFfXaMuM13ijuWEdNiaaHRki070Tzjou8g7ItrpOecQ=;
  b=MTdPSF9aj0LkcJICMVwwWqTmh1G2vTU4moD2gwX+zdZAjSqK4QwPEvN/
   HlJHQl+wZETDgmqeQ9f/3QJHH4P1nePUGqMl5JqZxYxQk/d95I0Ly5fDS
   Be2RQ5eRpuguvXJcxlI/jaFJUL9UNsLbk6mXTIYJef4GU60SEp1KWRZms
   wUIdODvHXduh2FvtLt0HTfRosHeOSNzRzjU9VotB063yxux/lLAWltJyN
   qw+8fJ6k+sNouPXq4zKaanuitgc1kndnIEJBnZcaddbHnvBUu9l1h7Ejo
   LXD8rj/cw+3a7V7CQLhD7ny4/qnQW5hr9j4EPA9noAMhvO6kAetAyFUZA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10059014"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10059014"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3749601"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.217.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:31:32 -0800
Message-ID: <e7d7a434-665b-4912-a2ae-a51e10e332d5@intel.com>
Date: Tue, 30 Jan 2024 17:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V14 16/21] mmc: sdhci-uhs2: add request() and others
Content-Language: en-US
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
 <20240123062827.8525-17-victorshihgli@gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240123062827.8525-17-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/24 08:28, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a sdhci version of mmc's request operation.
> It covers both UHS-I and UHS-II.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V14:
>  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
>    sdhci_uhs2_request().
> 
> Updates in V13:
>  - Re-order function to avoid declaration.
>  - Remove unnecessary function.
> 
> Updates in V11:
>  - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
>    in sdhci_uhs2_set_transfer_mode().
> 
> Updates in V10:
>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
>    in sdhci_uhs2_set_transfer_mode().
> 
> Updates in V9:
>  - Modify the annotations in __sdhci_uhs2_send_command().
> 
> Updates in V8:
>  - Adjust the position of matching brackets in
>    sdhci_uhs2_send_command_retry().
>  - Modify CameCase definition in __sdhci_uhs2_finish_command().
>  - Modify error message in __sdhci_uhs2_finish_command().
>  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_command()
>    in sdhci_uhs2_request().
>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic().
>  - Add forward declaration for sdhci_send_command().
> 
> Updates in V7:
>  - Cancel export state of some functions.
>  - Remove unnecessary whitespace changes.
> 
> Updates in V6:
>  - Add uhs2_dev_cmd() to simplify code.
>  - Remove unnecessary functions.
>  - Cancel export state of some functions.
>  - Drop use CONFIG_MMC_DEBUG().
>  - Wrap at 100 columns in some functions.
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 379 +++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c      |  49 +++--
>  drivers/mmc/host/sdhci.h      |   8 +
>  3 files changed, 420 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 0c543899ed6c..b47bcf6f890f 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -14,6 +14,8 @@
>  #include <linux/module.h>
>  #include <linux/iopoll.h>
>  #include <linux/bitfield.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -29,6 +31,8 @@
>  #define UHS2_INTERFACE_DETECT_TIMEOUT_100MS	100000
>  #define UHS2_LANE_SYNC_TIMEOUT_150MS		150000
>  
> +#define UHS2_ARG_IOADR_MASK 0xfff
> +
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  {
>  	if (!(mmc_card_uhs2(host->mmc)))
> @@ -63,6 +67,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> +{
> +	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
> +}
> +
>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
>  					    struct regulator *supply,
>  					    unsigned short vdd_bit)
> @@ -140,7 +149,7 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
>  
>  static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
>  {
> -	/* timeout in us */
> +	/* timeout in us */#define UHS2_ARG_IOADR_MASK 0xfff

Extraneous "#define UHS2_ARG_IOADR_MASK 0xfff"



