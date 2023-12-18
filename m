Return-Path: <linux-kernel+bounces-4284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3FE817AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796691F244E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF55D75F;
	Mon, 18 Dec 2023 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YywxrTGN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29AB1DDFC;
	Mon, 18 Dec 2023 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FJBZrezoVGkJyFJBarJZXy; Mon, 18 Dec 2023 20:21:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702927316;
	bh=R0E53xEOkOyaSgxwTXFOHqJWvJif/gPrVwQobEP7FuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YywxrTGNKPzHK5lin/i/QTDeR+tBeaxZhCVqXEBRbGDeRRuGHMekkyrymfBPn763A
	 NFhTpgnTXHwUoE4AUzXYMGOrCWDXR+YoxBnlpbgXY+jUwgiNa5ryJ9XyZF6AbAH7vO
	 ZC5UItB35tt9UglNRV9aiUbsFc/DcXzLBlfPQd92G16xItO8nQyIUHIi4tCpDfo494
	 vPtgqbkAeS4Qf/FPlgFRrukiQyU0GVU5RxbRUAR+Hnr6jX++xa6XHQgRvDQ1YYa5jd
	 +F1GwnAMaNA2KQodmrrR1JkcxNFYMIE+Y30rqoh/dmyPrZ+jgY1trbRmr9Mym00AFF
	 sfyZlXA/AT7Ow==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Dec 2023 20:21:56 +0100
X-ME-IP: 92.140.202.140
Message-ID: <42c6ed78-75bd-4b4b-8b59-e0562d4968aa@wanadoo.fr>
Date: Mon, 18 Dec 2023 20:21:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Content-Language: fr
To: Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, avadhut.naik@amd.com, tony.luck@intel.com,
 john.allen@amd.com, william.roche@oracle.com, muralidhara.mk@amd.com
References: <20231218190406.27479-1-yazen.ghannam@amd.com>
 <20231218190406.27479-2-yazen.ghannam@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231218190406.27479-2-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/12/2023 à 20:04, Yazen Ghannam a écrit :
> AMD Zen-based systems report memory errors through Machine Check banks
> representing Unified Memory Controllers (UMCs). The address value
> reported for DRAM ECC errors is a "normalized address" that is relative
> to the UMC. This normalized address must be converted to a system
> physical address to be usable by the OS.
> 
> Support for this address translation was introduced to the MCA subsystem
> with Zen1 systems. The code was later moved to the AMD64 EDAC module,
> since this was the only user of the code at the time.
> 
> However, there are uses for this translation outside of EDAC. The system
> physical address can be used in MCA for preemptive page offlining as done
> in some MCA notifier functions. Also, this translation is needed as the
> basis of similar functionality needed for some CXL configurations on AMD
> systems.
> 
> Introduce a common address translation library that can be used for
> multiple subsystems including MCA, EDAC, and CXL.
> 
> Include support for UMC normalized to system physical address
> translation for current CPU systems.
> 
> The Data Fabric Indirect register access offsets and one of the register
> fields were changed. Default to the current offsets and register field
> definition. And fallback to the older values if running on a "legacy"
> system.
> 
> Provide built-in code to facilitate the loading and unloading of the
> library module without affecting other modules or built-in code.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---

...

> +int get_address_map(struct addr_ctx *ctx)
> +{
> +	int ret = 0;

Nit: unneeded init

> +
> +	ret = get_address_map_common(ctx);
> +	if (ret)
> +		goto out;
> +
> +	ret = get_global_map_data(ctx);
> +	if (ret)
> +		goto out;
> +
> +	dump_address_map(&ctx->map);
> +
> +out:
> +	return ret;
> +}
> diff --git a/drivers/ras/amd/atl/reg_fields.h b/drivers/ras/amd/atl/reg_fields.h
> new file mode 100644
> index 000000000000..6aaa5093f42c
> --- /dev/null
> +++ b/drivers/ras/amd/atl/reg_fields.h
> @@ -0,0 +1,603 @@

...

> +static void get_num_maps(void)
> +{
> +	switch (df_cfg.rev) {
> +	case DF2:
> +	case DF3:
> +	case DF3p5:
> +		df_cfg.num_coh_st_maps	= 2;
> +		break;
> +	case DF4:
> +		df_cfg.num_coh_st_maps	= 4;
> +		break;

If 4 is the correct value in both cases, DF4 and DF4p5 cases could be 
merged.

CJ

> +	case DF4p5:
> +		df_cfg.num_coh_st_maps	= 4;
> +		break;
> +	default:
> +		atl_debug_on_bad_df_rev();
> +	}
> +}

...


