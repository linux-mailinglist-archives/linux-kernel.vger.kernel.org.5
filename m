Return-Path: <linux-kernel+bounces-92340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E0871ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9353C1F23C05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61C5B67C;
	Tue,  5 Mar 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlwGSpUt"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177965B5B5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640916; cv=none; b=msu9CaofcmSdlqSnEEEEGXuNA+67dScmiPlH4j4fxI7+1IiLYSqOTZmYPZx1yzV1O3J7feNgiUfPFQWS0wZHlNjMFk2k2NBA6Gk1LcvM0JMS7b9CzLPZcvSlUWCsIyNzgAe1MKkMC7e2wTiZ1+HsK8sUmWKEP5bkx2izyQ6kPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640916; c=relaxed/simple;
	bh=g7XHUxRHu85gEg3FW1hsjzi+N1cNjvNBBFKV+KzP3B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1jdo70MKjwdGZF6uHSk9Hk8+5lrOVlSHo6ZPAgX7ObB89r4/e/Gk83rDnrvOqnIXOygQcLYk+BZ3j+lHOlNsYB/yQe7fac+xd/Ax6eQMwNH5cI+tfQr/CoGHZpSERL3q9oCi3rB1gfMb87og9I8Vn1Yzhpm3/WYFOLxhdVVopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wlwGSpUt; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso566821276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640914; x=1710245714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6ktVqDmV7ss5l9SPN0xrD5/Tg3eFMGNcebSziUH+H4=;
        b=wlwGSpUtcQfN2v6GKRwzs64vl/MMHf4ERNAhx/2dLZbLFQ/8MsWTehTQh8hXvvx91p
         FFHpGdMoAMVvgm3Gfqco6XRnwy9+f8uzfFV938ImW4UdRqTI5yt+znA5idhrUbHUHZ0/
         Oz3j7NA2VOetrc+b1V8Xd9myZf24xZoLeipmPAvUaQGLViHRS64fn8YSB9tWbGYjDwX3
         5tpqQx1upjUtV3X/TZaq3aIVwY/bnsRCHKSZKSDCgE7r8k4CY8ppafy+Qdiu+vRh/i3M
         Ot4QZ3sVycuBEVQMVyOf4KfUK0fg6Y0grzomydKA4Iv9hdjFAKn1NSRS+3yuLYHJVnqu
         h3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640914; x=1710245714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6ktVqDmV7ss5l9SPN0xrD5/Tg3eFMGNcebSziUH+H4=;
        b=JdKkrI3ZBZPs7StktSoUmEJEpuxXF7G3EjynnBXrtMZtha3mlW4dqT0LDgma55Lf7l
         DuDAgjWXhv+9ygk8lXM2WgrMAvoU+4985dZOrOU7yJstqWWQtRCehZf5jAnCP1LY20Er
         5fi9JQ8cc9+WPR2xhqYfzJmpA4hccLOSUtnziQg6ESStAPVfSyhBgRcaQyPIYZLDuBj1
         od8WOVI0PJhuMEIjDCFNfYN1DiaFTLTJVfpbx1kKOVNiro3UDk4OnzVCAk9F6FmT+777
         2Z5gLcT5EiYf+PQx2+qseVVQS7LG/czX8lrezQxbwo4YVkTpDZ6RHpU2Cgaqep/0SWT8
         9jDA==
X-Forwarded-Encrypted: i=1; AJvYcCXRQyfyuHpNSxtJZKdvheHFLpkwc323eQfuHv5MpTv9MM6EyZyFIm+xWYY8SaSfNwBLuUI6xzIyv3iTp/Vv4bS8ES3WsShWwB4RyCku
X-Gm-Message-State: AOJu0YyJLn3quzKkcbIUI8WB4ekoRf4/ay/FpMEFAn6p9cdbmgmDnLtT
	NX2spzowrDkXMIppKZXhUAM/gQws2fAD+ZIeHF3e/w99kmqXWL5tKcXMn+4rA7/KUCqNClPNaFz
	KUrn/F3/ZGLO249b6DMuTfh2rX8TnJ+Iqmr5t2g==
X-Google-Smtp-Source: AGHT+IHJmE+6b6Odnde6C3f/sbKVeXzyy1wl+EKNqVOXCbMbm3t6RelV+5/PPHkUcAMaI42bBn2Jf21OcLZDfzyvrZM=
X-Received: by 2002:a25:d883:0:b0:dcc:e9d:4a22 with SMTP id
 p125-20020a25d883000000b00dcc0e9d4a22mr8993815ybg.12.1709640913987; Tue, 05
 Mar 2024 04:15:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-b4-mmc-hi3798mv200-v7-0-10c03f316285@outlook.com>
In-Reply-To: <20240229-b4-mmc-hi3798mv200-v7-0-10c03f316285@outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:38 +0100
Message-ID: <CAPDyKFrKiJBONLhOj2KDWZug_BSZngUUxtrEnF+H+imfEctETg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] mmc: add hi3798mv200 specific extensions of DWMMC
To: forbidden405@outlook.com
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Igor Opaniuk <igor.opaniuk@linaro.org>, 
	tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 02:36, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> it's modified from hi3798cv200 driver, but quite a lot of code gets
> rewritten because of the hardware differences. Actually cv200 DWMMC core
> is called HIMCIV200 while mv200 DWMMC core is called HIMCIV300 in
> downstream.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

The series, applied for next, thanks!

Note that, I took the liberty of updating/clarifying the commit
message of patch1, please let me know if there is anything you don't
like with that.

Kind regards
Uffe


> ---
> Changes in v7:
> - driver: simplify tuning logic (Ulf Hansson)
> - bindings: fix patch order (Ulf Hansson)
> - Link to v6: https://lore.kernel.org/r/20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com
>
> Changes in v6:
> - apply the comments to the first patch, add their trailers
> - Link to v5: https://lore.kernel.org/r/20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com
>
> Changes in v5:
> - pick the dependant patch: https://lore.kernel.org/all/20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com/
>   to fix the bot build error.
> - edit the semantic meaning of hisilicon,sap-dll-reg property (Rob Herring)
>   The suggestion is from the CRG driver side:
>   https://lore.kernel.org/all/20240218205741.GA1561527-robh@kernel.org/
> - Link to v4: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com
>
> Changes in v4:
> - rename dw_mmc-hi3798 back to hi3798cv200 - Suggested by Krzysztof Kozlowski.
> - add r-bs to patch 1 and 2 - Reviewed by Krzysztof Kozlowski.
> - Link to v3: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com
>
> Changes in v3:
> - dw_mmc-hi3798: fix bot error (Rob Herring)
> - Link to v2: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com
>
> Changes in v2:
> - dw_mmc-hi3798mv200: use dev_err_probe() helper - Suggested by Krzysztof Kozlowski.
> - dw_mmc-hi3798mv200: add missing err=0;
> - dw_mmc-hi3798c(m)v200: remove unused MODULE_ALIAS() - Suggested by Krzysztof Kozlowski.
> - binding: rename the binding, a lot of tweaks suggested by Krzysztof Kozlowski.
> - Link to v1: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com
>
> ---
> Yang Xiwen (5):
>       mmc: host: mmc_of_parse_clk_phase(): Pass struct device * instead of mmc_host *
>       mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
>       dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
>       dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: add Hi3798MV200 binding
>       mmc: dw_mmc: add support for hi3798mv200
>
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
>  .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         |  97 ++++++++
>  drivers/mmc/core/host.c                            |   4 +-
>  drivers/mmc/host/Kconfig                           |   9 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
>  drivers/mmc/host/dw_mmc-hi3798mv200.c              | 251 +++++++++++++++++++++
>  drivers/mmc/host/sdhci-of-aspeed.c                 |   2 +-
>  include/linux/mmc/host.h                           |   2 +-
>  9 files changed, 361 insertions(+), 46 deletions(-)
> ---
> base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
> change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c
>
> Best regards,
> --
> Yang Xiwen <forbidden405@outlook.com>
>

