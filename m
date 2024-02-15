Return-Path: <linux-kernel+bounces-66828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006488561F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B910B283C31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14212B172;
	Thu, 15 Feb 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIxvIFkI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442712B15C;
	Thu, 15 Feb 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997503; cv=none; b=lTfD/F3OzDjc5rknpFMaBI+yCrBPSk5RzX/xDy2p8HoMAS62yobEQHiDD4UiiU1FG1fN3XygL5NxcdksCyXX0gjF1h+5R44mLlu0889jy18GcmMX46p1rsS0CycIufTn2FOwR9NL8dWqG9r5BKOErkJw/OT3YKMcce9X17728qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997503; c=relaxed/simple;
	bh=E38KSe5rcCXjcKiFq0QIkELRysT7jPLEi6+QeMypuMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOiQYmeITEwa6hFh44vyLTidFIO1x+jvGhO7+pWSSqmFavW8fhY+HFtWkB/CjHpCnnKlaDcO5FpiHOzj+VGFRGTVkF8MoEunGbXvICWQkoCKYOUxpZqCc2F/WHTC4iaMCZy1hf9Q5Yxqn4mQoOBikBVDyRz1jeQlA8czEAdPKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIxvIFkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C4C433F1;
	Thu, 15 Feb 2024 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997502;
	bh=E38KSe5rcCXjcKiFq0QIkELRysT7jPLEi6+QeMypuMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIxvIFkINUJi5cRZ4xP8NhUn1Zw8pTPkI4yqnyjOG7YfH78IzIm6L3pT7IaY4pUJL
	 rTevdBQ/kcLowHDOPgGDqW2uHh8vlpGz5SZLxoftBGuXNgCEP/7bkPrG4W/F3SvGQV
	 t4pcnS79vMvXsOj58bwJOfAAndEZ3AAqAf7aN7kEe3f8vBRlGXJIS2Zdi5j7tf+WbL
	 0ijPBAmn/72+lsFmtk/bJRC4JqBSoOV2wJ5rNXojSuEJ2YpXqaVeZTrrPzRpw36sqb
	 JhoIAWzrQDtSf9eQihJjIXQnlWZHF80OZ1n94JDCp4/qW0zRHJJpc9QSL5vquxYJ4m
	 8G0mV6HExSDwQ==
Date: Thu, 15 Feb 2024 11:44:57 +0000
From: Will Deacon <will@kernel.org>
To: Hojin Nam <hj96.nam@samsung.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	KyungSan Kim <ks0204.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2] perf: CXL: fix CPMU filter value mask length
Message-ID: <20240215114457.GB358@willie-the-truck>
References: <CGME20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>
 <20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Hojin,

On Thu, Feb 15, 2024 at 05:09:06PM +0900, Hojin Nam wrote:
> CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
> However, it is used as 2B length in code and comments.
> 
> Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
> ---
> 
> Hi Jonathan,
> as you said, I didn't actually hit this. I just found it by simply
> comparing the code to the CXL Spec. I removed Fixes tag and 
> repaired broken sign off, Thank you!
> 
> Changes since v1:
> - Remove Fixes tag (Jonathan)
> - Repair broken sign off (Jonathan)
> 
>  drivers/perf/cxl_pmu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 365d964b0f6a..ca5e92f28b4a 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -59,7 +59,7 @@
>  #define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK     GENMASK_ULL(63, 59)
> 
>  #define CXL_PMU_FILTER_CFG_REG(n, f)   (0x400 + 4 * ((f) + (n) * 8))
> -#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(15, 0)
> +#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(31, 0)

Unfortunately, your patch appears to be whitespace-damaged (missing space,
tabs converted to space) so I'm not able to apply it :(

Will

