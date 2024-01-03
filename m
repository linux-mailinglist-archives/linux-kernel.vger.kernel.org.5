Return-Path: <linux-kernel+bounces-15889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690982350B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ADA1C20C15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968001CAB2;
	Wed,  3 Jan 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5AV5lBO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192171CAA9;
	Wed,  3 Jan 2024 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704307985; x=1735843985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xb3JCgo4iqLo11WVKyNpxqIH6S3YvPj930p7OczgVDQ=;
  b=A5AV5lBOPtJz9CJDlOM8YOrjz9tDuH74rPYZC/bVlGYnxkxSkwuX8auP
   Df2s0r2N30eXOj7q3oTuoq2gbFCdSPk86y37/q8OyNVA9JVeSuvm8NEFl
   7idoUXe/oHNSq0Qy6rxdEjPtD2LV4CPWuxZDcJqpepM5IFfbjqrF2dSBY
   52MQhTGGO/gSyHVxjm3w3vzg3i3xsTHi/DuWI6RJA9vyXwB6KSbokppy3
   D9i7YJCpIKoFz7zon9xBaChf0vAiGOzuJGyPX0co44qdmNre+S4c17EY+
   CI1/FCCkswzlfPiCOXmBfI5THugfljFoCRYEo55wfHc1Ybw6YaM6gAZ6s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="382009519"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="382009519"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="850508459"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="850508459"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:53:01 -0800
Message-ID: <ee017245-fec1-4492-9ce0-bb4a515d15a5@intel.com>
Date: Wed, 3 Jan 2024 20:52:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mmc: cqhci: Add cqhci set_tran_desc() callback
Content-Language: en-US
To: Sergey Khimich <serghox@gmail.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jyan Chou <jyanchou@realtek.com>
References: <20231231144619.758290-1-serghox@gmail.com>
 <20231231144619.758290-2-serghox@gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231231144619.758290-2-serghox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/23 16:46, Sergey Khimich wrote:
> From: Sergey Khimich <serghox@gmail.com>
> 
> There are could be specific limitations for some mmc
> controllers for setting cqhci transfer descriptors.
> So add callback to allow implement driver specific function.
> 
> Signed-off-by: Sergey Khimich <serghox@gmail.com>
> ---
>  drivers/mmc/host/cqhci-core.c | 10 +++++++---
>  drivers/mmc/host/cqhci.h      |  5 +++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 41e94cd14109..d12870b124cc 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -474,8 +474,8 @@ static int cqhci_dma_map(struct mmc_host *host, struct mmc_request *mrq)
>  	return sg_count;
>  }
>  
> -static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
> -				bool dma64)
> +void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,

Needs to be exported also i.e.
EXPORT_SYMBOL(cqhci_set_tran_desc);

> +			 bool dma64)
>  {
>  	__le32 *attr = (__le32 __force *)desc;
>  
> @@ -522,7 +522,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
>  
>  		if ((i+1) == sg_count)
>  			end = true;
> -		cqhci_set_tran_desc(desc, addr, len, end, dma64);
> +		if (cq_host->ops->set_tran_desc)
> +			cq_host->ops->set_tran_desc(cq_host, &desc, addr, len, end, dma64);
> +		else
> +			cqhci_set_tran_desc(desc, addr, len, end, dma64);
> +
>  		desc += cq_host->trans_desc_len;
>  	}
>  
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 1a12e40a02e6..703d5af6c49e 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -217,6 +217,7 @@ struct cqhci_host_ops;
>  struct mmc_host;
>  struct mmc_request;
>  struct cqhci_slot;
> +struct mmc_data;

Not used

>  
>  struct cqhci_host {
>  	const struct cqhci_host_ops *ops;
> @@ -293,6 +294,9 @@ struct cqhci_host_ops {
>  	int (*program_key)(struct cqhci_host *cq_host,
>  			   const union cqhci_crypto_cfg_entry *cfg, int slot);
>  #endif
> +	void (*set_tran_desc)(struct cqhci_host *cq_host, u8 **desc,
> +			      dma_addr_t addr, int len, bool end, bool dma64);
> +
>  };
>  
>  static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
> @@ -318,6 +322,7 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>  int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
>  struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
>  int cqhci_deactivate(struct mmc_host *mmc);
> +void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
>  static inline int cqhci_suspend(struct mmc_host *mmc)
>  {
>  	return cqhci_deactivate(mmc);


