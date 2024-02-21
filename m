Return-Path: <linux-kernel+bounces-74570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF0A85D61E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C4A1C208E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF13DB89;
	Wed, 21 Feb 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRxolPFq"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60336AF1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513019; cv=none; b=EuxDPiVVvlUGqrudpL4gh/mEZzuGVobpcP+Joqqv9VRDhuRxxtW9/bSwC2qXkey89kQ/D1Gd7UxN0dL5q8AftVuZkVT4518pWVCiGLk/5W1d57y9/LIpseWFq6+U+O4xHRhxbwiBHq79AphgWoWQkcYAFk1hnwSfq0e/W+806zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513019; c=relaxed/simple;
	bh=vbWMRmS1rFnN3OCYfqHmxe0l6A9GOkYIALwfyrOlRrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVmCBmyMQTzPcyAmWWYKwFwu1OYlCIC8dXQRcYRt5rw/tWfI6nTGN9pCuVet0xNk4p/90bOfBsfbHrfzLN5X1kJVqMc1R20Dls90w/ib86dfrSwa7BY2GXWVrozX5PvNiUE8tZ655PH9iQAMddaCp0jxwQxKWpTDtCNOGnynDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRxolPFq; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso6315986276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708513011; x=1709117811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ncsQZDtkxlo5wIjHq/CdTQpHc5QZi5GaNWKD+dMSg=;
        b=wRxolPFqKJ5spFJS732SEnqTalMhyxzyquFjBtWb+qkY7Cypys45JzvxUGEXZLdrw5
         2/5q4Xpmb4zC5WvN46F83scAmDdhzuzl1X5M/oyNg10SvMhFN/fdFe4WanS0JAm41IkJ
         9lidcGyPe5Jodb8iBuYNzl8Pf3d2TIVISkmu+RhoDhVIVNBEanN+xqGxv4C8O5UPsv5f
         MLbtCALp7IZoP14OaMR33PNR2m3oeNv/6PFsKpVTgUItQPnwxWbYKyH4lkOWXulpTaMs
         ItK2qV4GosRMHbujN/RnNCRX/G+osmDJDy+jnL3aMUO3kYnobzYVP+QX61FkgOq6bPpu
         HA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513011; x=1709117811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+ncsQZDtkxlo5wIjHq/CdTQpHc5QZi5GaNWKD+dMSg=;
        b=oygk5PCYvIISGL9W+uOrmJcb1UAg9a0vI1/fID/bP2DhWbkpFx7l+IAgaRaKlnuPNc
         eorNPhagSmiV84w03VT8h+/XLuxJVgXwnoABY/0roFOeJgDHTMyCYXcLcEFSLkpMpqF6
         AJsns3R5Xeb1MspHq5UkAQotWHWTVeH8+nOpmC1w14naP9IHfUAHeJSQrAXfXHn9B+rV
         Pd0yUDxmvtcuyTaZ8DIGux2egMjWH+054qubRk8laiTj6GvLiw9gH1LlLgPPKjIWbcF2
         t/GI4syK6Zr35RQet8hIDNSxrOi7wteh2lQdZjGQGK8V/BNJGsBqQzQ9DYZT/2Z8L9Wu
         6ANQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjlMFvr18A2EYh5xCdImDLq9VLP4ERXwt5Ir004sE77azpah86eD5oEGVpCbqp35ZNDzti3+RBDCspnVTgSuuPEZTw2d8iCdB5CWMB
X-Gm-Message-State: AOJu0YwFRkEGeWl5F3Gyy/5UmRA6ERRzX8l6XL6vOX5oQ2byS1ZfxaBe
	dX16UFUNywdmKygWQ/tbjlRlG7IAaHSWYzmekhEgW4tN2woIg0POPiQJq9G2P62xH5p1QjcLs3x
	um1/a0FXY756RAwRBKU8vOYmzia0U0sONCMroRw==
X-Google-Smtp-Source: AGHT+IEAHnosrh2HKr+vWyBNOZNSN17fCMu1+F8oggttg0/XQH/nIN/mS6ozHi+E8ndqPb5619KYo2+L25hzHEBSDrU=
X-Received: by 2002:a25:b347:0:b0:dcc:5a25:ae88 with SMTP id
 k7-20020a25b347000000b00dcc5a25ae88mr15176976ybg.19.1708513011384; Wed, 21
 Feb 2024 02:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221103202.3628142-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240221103202.3628142-1-quic_kriskura@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 12:56:40 +0200
Message-ID: <CAA8EJprMd5tr91gm99GyP1oefO_=tNQzxKA6hmB-xtBNVTbeeQ@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-snps: Fixed order of enabling regulators
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 12:32, Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> The SNPS Femto phy has 3 supplies, vdda-pll (0.88V), vdd18 (1.8V),
> vdd33 (3.3V). The driver enables these in order of 0.88 -> 3.3 -> 1.88.
> But on phy instances which have EUD attached, it is seen that not enabling
> the regulators in the order of (0.88 -> 1.8V -> 3.3V) is causing the EUD to
> reset the phy (issue seen rarely) thereby disturbing enumeration.
>
> This change doesn't disturb operation of phy's where EUD is not present.
> According to the some of the applicable power-supply ramp scenarios present
> in data book: (DVDD is 0.88V, VDDH is 1.8V)
>
> a) VDDH<#> and VDD33<#> held to 0 V (cannot be left floating) with DVDD
> ramped to a valid level
> b) VDD33<#> held to 0 V (cannot be left floating) with DVDD and VDDH<#>
> ramped to their respective, valid levels
>
> Modify the driver to power up the phy regulators in order of:
> 0.88 -> 1.8 -> 3.3 respectively.
>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>
> Downstream kernels on QC targets use this sequence to power up
> the phy and this has been tested extensively on multiple targets.
> This change has been tested with upstream kernel on QCM6490-IDP
> without EUD to ensure there is no loss or breakage of functionality.
>
>  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> index eb0b0f61d98e..e86d221b7397 100644
> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> @@ -79,7 +79,7 @@
>  #define LS_FS_OUTPUT_IMPEDANCE_MASK            GENMASK(3, 0)
>
>  static const char * const qcom_snps_hsphy_vreg_names[] = {
> -       "vdda-pll", "vdda33", "vdda18",
> +       "vdda-pll", "vdda18", "vdda33",

NAK.
The driver uses regulator_bulk_enable, which enables all three
regulators simultaneously via async calls, thus your change doesn't
have any effect.

Also note, that these regulators are frequently shared between
different consumers. As such, even if you have tight control of
regulator ordering in the driver, other drivers might enable
corresponding regulators on their own, breaking the ordering.

-- 
With best wishes
Dmitry

