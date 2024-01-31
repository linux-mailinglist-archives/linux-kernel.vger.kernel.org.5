Return-Path: <linux-kernel+bounces-46226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA9B843C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0D2286FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5914E7869E;
	Wed, 31 Jan 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+S11v/L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CC67E90;
	Wed, 31 Jan 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696622; cv=none; b=aYgXeX9icAfVenatl7LXmqoMMs6ULlIWvLTfAaslifvKEZ763jpT8QFR8SFlxvvDYz21t052qt4SCVPV8Nv6NU+qWP5hLU8ENtrl9XehFCxymisENZElbkbZKTD+KA/BncEXh0H8Om8BZDiXOFKoCufI36wL2+eL36Qi3GgOTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696622; c=relaxed/simple;
	bh=7Lcx/39ROovjpD11Ao0inB8Wfx//pHGwLLkiWzQ8osw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=snGEE0y2jQOj5+M5Hu7pj3sYdYSpBMaK3WTdnlPJt9qCDAJigazjf9dHom5L/N2T7KA2iz/WK+cDPfS0Ze1qzhiyB6LcqG+O/DZnWPvXSTppopzxzwjfmCiRdyS2NXEI6I2wD9om7Td6wcVD7O5BzJ9tRY0xVUSPG+k2tObylko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+S11v/L; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706696621; x=1738232621;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7Lcx/39ROovjpD11Ao0inB8Wfx//pHGwLLkiWzQ8osw=;
  b=V+S11v/LTDUkheXNPetTiKypbfS9kzo9pqHPFuenkDnNtqOpTIqSpvsg
   eLpzZOn1bci022+s6om39XJ8Nae+6roa2h86DVEmbhBnh3E3NcKcsBdty
   lTAWE3mcuTwuhoeoxSi+lhhstcVoilLB+eknR1jbaZnHZ7jIdZqAVT8YS
   +/bz+YfjRJYE9/g05ZvwK3+9Nr1EAsOKK3DeNm3GB4kiq6E6VYINeqkSi
   vhFxRNWaud9ZIBrb+O8gseq7Gk2T0VkWhUmMWXos4gP86Nn29zJMhJ8RA
   nLsmxzMvOHk+e/cUM/H06vvg/uNq5otLh86udw5C6L6wmHGomi1aKSDzw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22069114"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="22069114"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="36813063"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:23:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Jan 2024 12:23:33 +0200 (EET)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] platform/mellanox: mlxbf-pmc: Add support for
 clock_measure performance block
In-Reply-To: <c818d6398b8f702a978ce4dbffa58bb8b08f36b2.1706607635.git.shravankr@nvidia.com>
Message-ID: <dfb528f2-a46e-bb73-3fdf-0a9eae788f73@linux.intel.com>
References: <cover.1706607635.git.shravankr@nvidia.com> <c818d6398b8f702a978ce4dbffa58bb8b08f36b2.1706607635.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jan 2024, Shravan Kumar Ramani wrote:

> The HW clock_measure counter info is passed to the driver from ACPI.
> Create a new sub-directory for clock_measure events and provide
> read access to the user. Writes are blocked since the fields are RO.
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 46 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 906dfa96f783..e1c0e2f04abb 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -865,6 +865,37 @@ static const struct mlxbf_pmc_events mlxbf_pmc_llt_miss_events[] = {
>  	{75, "HISTOGRAM_HISTOGRAM_BIN9"},
>  };
>  
> +static const struct mlxbf_pmc_events mlxbf_pmc_clock_events[] = {
> +	{ 0x0, "FMON_CLK_LAST_COUNT_PLL_D1_INST0" },
> +	{ 0x4, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST0" },
> +	{ 0x8, "FMON_CLK_LAST_COUNT_PLL_D1_INST1" },
> +	{ 0xc, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST1" },
> +	{ 0x10, "FMON_CLK_LAST_COUNT_PLL_G1" },
> +	{ 0x14, "REFERENCE_WINDOW_WIDTH_PLL_G1" },
> +	{ 0x18, "FMON_CLK_LAST_COUNT_PLL_W1" },
> +	{ 0x1c, "REFERENCE_WINDOW_WIDTH_PLL_W1" },
> +	{ 0x20, "FMON_CLK_LAST_COUNT_PLL_T1" },
> +	{ 0x24, "REFERENCE_WINDOW_WIDTH_PLL_T1" },
> +	{ 0x28, "FMON_CLK_LAST_COUNT_PLL_A0" },
> +	{ 0x2c, "REFERENCE_WINDOW_WIDTH_PLL_A0" },
> +	{ 0x30, "FMON_CLK_LAST_COUNT_PLL_C0" },
> +	{ 0x34, "REFERENCE_WINDOW_WIDTH_PLL_C0" },
> +	{ 0x38, "FMON_CLK_LAST_COUNT_PLL_N1" },
> +	{ 0x3c, "REFERENCE_WINDOW_WIDTH_PLL_N1" },
> +	{ 0x40, "FMON_CLK_LAST_COUNT_PLL_I1" },
> +	{ 0x44, "REFERENCE_WINDOW_WIDTH_PLL_I1" },
> +	{ 0x48, "FMON_CLK_LAST_COUNT_PLL_R1" },
> +	{ 0x4c, "REFERENCE_WINDOW_WIDTH_PLL_R1" },
> +	{ 0x50, "FMON_CLK_LAST_COUNT_PLL_P1" },
> +	{ 0x54, "REFERENCE_WINDOW_WIDTH_PLL_P1" },
> +	{ 0x58, "FMON_CLK_LAST_COUNT_REF_100_INST0" },
> +	{ 0x5c, "REFERENCE_WINDOW_WIDTH_REF_100_INST0" },
> +	{ 0x60, "FMON_CLK_LAST_COUNT_REF_100_INST1" },
> +	{ 0x64, "REFERENCE_WINDOW_WIDTH_REF_100_INST1" },
> +	{ 0x68, "FMON_CLK_LAST_COUNT_REF_156" },
> +	{ 0x6c, "REFERENCE_WINDOW_WIDTH_REF_156" },
> +};
> +
>  static struct mlxbf_pmc_context *pmc;
>  
>  /* UUID used to probe ATF service. */
> @@ -1041,6 +1072,9 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
>  	} else if (strstr(blk, "llt")) {
>  		events = mlxbf_pmc_llt_events;
>  		*size = ARRAY_SIZE(mlxbf_pmc_llt_events);
> +	} else if (strstr(blk, "clock_measure")) {
> +		events = mlxbf_pmc_clock_events;
> +		*size = ARRAY_SIZE(mlxbf_pmc_clock_events);
>  	} else {
>  		events = NULL;
>  		*size = 0;
> @@ -1477,14 +1511,15 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
>  /* Method to read a register */
>  static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t *result)
>  {
> -	uint32_t ecc_out;
> +	uint32_t reg;

While at it, change to u32.

-- 
 i.


