Return-Path: <linux-kernel+bounces-69035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A285839C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C031F283A18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D5131726;
	Fri, 16 Feb 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfWMpEYC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3C130E2C;
	Fri, 16 Feb 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103413; cv=none; b=UTpILSMEhhI73PI4SKPLzAaDreP36I3ISIMaMzHPLtbWCX1Yb7Xp4G4yw8/rg2Dij4GvGkhW/LeKewkZXQgH/PXSFu1u2lS6l8DiK9IvR/uPHt9uiMH1x2eBaAQrbk0d/q0mUYnU/XNMxgdCDws7OWKl054tb6UrhcbSEPG/ul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103413; c=relaxed/simple;
	bh=p4Knm5c67do6YY7tRiskUV2IRtPbKnIA9o0VdhlKiU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp2M909pbsjWEyboyPAgnh5rbSDXKnlMXpsrez+IDI/fzV3TXjtCFRUste7uQMAvz4czjPAaArFNNpiwKFgwI0tnDPbbDcMz2o55HtmvvOcXZ7B2k9NNvMXcwccrcMhjMV3OE0+kebp+Z2jnTKle5AWrtaRRWLh/ypJFrF48OUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfWMpEYC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708103412; x=1739639412;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p4Knm5c67do6YY7tRiskUV2IRtPbKnIA9o0VdhlKiU4=;
  b=WfWMpEYCj2ZbMKNeFiVmtL3yroury882JGNCkpm/Uejyicy9qhI5QixG
   BCrejwleEJSgpFgyoXrQkZgb9/A+L/bnfgrB98n2VwPq/Li4trKJTIP3B
   /ARs7+R2nfLv+F0rhKMmWW+UGfewqnzcfx09GZo4Cf5TAC4fLo+cNl/km
   /jyx8BJfwOj+w9X+Q234FKyQ/HVuiyhr9kO6ON+BEx1iY0o3eq2QK5g8Y
   vsYuXE6iN/k6y703QHmKkp3twl9lJDqSnM6V8REqnYH7cTs0XeUZGuRsP
   jPbQSNX+MoacjJB2SqJ2GOj9vyzO3xnNItMI1Qgwr59Us8lZ297bSph+J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6065406"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6065406"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8578501"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.122])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:10:09 -0800
Message-ID: <ea3f337b-8e8f-4813-b0d7-aff0f08c5a5c@intel.com>
Date: Fri, 16 Feb 2024 19:10:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mmc: sdhci_am654: Fix itapdly/otapdly array type
Content-Language: en-US
To: Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-5-jm@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240207011520.3128382-5-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/02/24 03:15, Judith Mendez wrote:
> While integer type works, the otap_del_sel and itap_del_sel
> arrays are manipulated as u32, so change array types to u32.

If it doesn't make any practical difference, then it is not
generally considered a "fix", at least according to stable
kernel rules, so Fixes tags are probably not warranted here.

> 
> Fixes: 8ee5fc0e0b3b ("mmc: sdhci_am654: Update OTAPDLY writes")
> Fixes: a0a62497f6aa ("mmc: sdhci_am654: Add support for input tap delay")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 935f581c05d8..35ba7d921690 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -141,8 +141,8 @@ static const struct timing_data td[] = {
>  
>  struct sdhci_am654_data {
>  	struct regmap *base;
> -	int otap_del_sel[ARRAY_SIZE(td)];
> -	int itap_del_sel[ARRAY_SIZE(td)];
> +	u32 otap_del_sel[ARRAY_SIZE(td)];
> +	u32 itap_del_sel[ARRAY_SIZE(td)];
>  	u32 itap_del_ena[ARRAY_SIZE(td)];
>  	int clkbuf_sel;
>  	int trm_icp;


