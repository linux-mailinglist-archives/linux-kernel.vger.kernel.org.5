Return-Path: <linux-kernel+bounces-107534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022887FDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C49281B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CF3BBF5;
	Tue, 19 Mar 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lU15CASj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425A7FBBA;
	Tue, 19 Mar 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852500; cv=none; b=ltUWubAkK+d+iqbOZukNJgPvdE71+HfBReXSi5W4o3Z1u8dHx0rGi31T3sbknrVPGCJhvL6AODyQOL9hIK6T2NZ5+Ystj48St//b2DWO5uC/lwuppDHjaJfLSTGUYKyd+UbY1OjwkNMi+Gp2xYP5B0WZv5tVVZ3geutSdG3fqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852500; c=relaxed/simple;
	bh=dYFfE6sd4QLhWgCyaOXzmlVmqRJDqsG8Mi0PQ1Zy/vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6yelpf0uc5+SWUZ+kHrGswPLdl5YBDlDhgFxdkP7d+qZunfvKuQ5f67wBUpbeheGVrD1WYKxI3kDYHHvGGTigpgfLHgU6sHyTnK4Kzj7XYlIWLIP5Lk7bKVF8h6ra3QIGMhkaXrNEPzHjlFMKoKxJ90ILTTDUlrPsWI+mcfewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lU15CASj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710852491; x=1742388491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dYFfE6sd4QLhWgCyaOXzmlVmqRJDqsG8Mi0PQ1Zy/vc=;
  b=lU15CASjao1Jy9/aF6ovdFg9snQedBjTTGuh1fAGoomvVdlVSFHJ7O8e
   bGxdPtjEz0vnZ508JYRpkZXIpfTTsrrgBK4q7PNVc+3wyKSsG8F1ahJSF
   z+yFsWwbpYWmgtqHwQOre+jhB5bzi3BykP1gVrITjbB2dgqVjut78Uy2+
   757b9dlQBW2zoqJuSLzgutXfu/tA76jxKKREAppDvJNA9faXh0atxQzvV
   jyyKA5gOmXX+J+wl9uYxZjE0TS8QOnbNMhrG3+DhW/Cwc90A5lndVwDGC
   OMVTpknw73g8jwERAHnd6In7POcmnwD4wOwb2yA/QhB/blxS95qj2fdfz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5555317"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5555317"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="14183342"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.47.203])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:48:08 -0700
Message-ID: <63a5d146-9ef7-4a2d-8c9b-619d3e42ea38@intel.com>
Date: Tue, 19 Mar 2024 14:48:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] mmc: cqhci: Add cqhci set_tran_desc() callback
To: Sergey Khimich <serghox@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jyan Chou <jyanchou@realtek.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>
References: <20240319115932.4108904-1-serghox@gmail.com>
 <20240319115932.4108904-2-serghox@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240319115932.4108904-2-serghox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/24 13:59, Sergey Khimich wrote:
> From: Sergey Khimich <serghox@gmail.com>
> 
> There are could be specific limitations for some mmc
> controllers for setting cqhci transfer descriptors.
> So add callback to allow implement driver specific function.
> 
> Signed-off-by: Sergey Khimich <serghox@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 11 ++++++++---
>  drivers/mmc/host/cqhci.h      |  4 ++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 41e94cd14109..c14d7251d0bb 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -474,8 +474,8 @@ static int cqhci_dma_map(struct mmc_host *host, struct mmc_request *mrq)
>  	return sg_count;
>  }
>  
> -static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
> -				bool dma64)
> +void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
> +			 bool dma64)
>  {
>  	__le32 *attr = (__le32 __force *)desc;
>  
> @@ -495,6 +495,7 @@ static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
>  		dataddr[0] = cpu_to_le32(addr);
>  	}
>  }
> +EXPORT_SYMBOL(cqhci_set_tran_desc);
>  
>  static int cqhci_prep_tran_desc(struct mmc_request *mrq,
>  			       struct cqhci_host *cq_host, int tag)
> @@ -522,7 +523,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
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
> index 1a12e40a02e6..fab9d74445ba 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -293,6 +293,9 @@ struct cqhci_host_ops {
>  	int (*program_key)(struct cqhci_host *cq_host,
>  			   const union cqhci_crypto_cfg_entry *cfg, int slot);
>  #endif
> +	void (*set_tran_desc)(struct cqhci_host *cq_host, u8 **desc,
> +			      dma_addr_t addr, int len, bool end, bool dma64);
> +
>  };
>  
>  static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
> @@ -318,6 +321,7 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>  int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
>  struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
>  int cqhci_deactivate(struct mmc_host *mmc);
> +void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
>  static inline int cqhci_suspend(struct mmc_host *mmc)
>  {
>  	return cqhci_deactivate(mmc);


