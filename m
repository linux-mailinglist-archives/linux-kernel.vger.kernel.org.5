Return-Path: <linux-kernel+bounces-95130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11787498C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2231F223EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92E63411;
	Thu,  7 Mar 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOv7QaC4"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696E63108
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799971; cv=none; b=PFG46InwiLMx7EU8JVF8V0mf0GPZbGXMrmxF/7HYjv69X+D2phIFy7GxfOm7dxHi+Li/fjgQgUfh15R4DzNyXwso2wnfj9F5AWjjWXZsyhZEE9zxhHD69rfsqps9gIq2qqyVcYibrBVfqNH0EITbGbYV2bKoV53Sx1TX7+MqxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799971; c=relaxed/simple;
	bh=PBrebkdCpvbZ4ZAMRT2TxIwYjjN/Xr9LjZ96/P/xG7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+D5qbXdhm6hapyYgafBUBlLx/7/0hoN4Nawb3FWimC/ZLnGGAasnk5Esv42CCDlWwoNasDlNH1xaNLxilwqJEfQjMDQVQwXPkOkTIpIrWPRSJiLfoMzbRCyeqYaxKie1xp+PKrWoN/PwwZuO+o91YtqMmhsbD/M+Rmu1RFrLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOv7QaC4; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so563017276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709799967; x=1710404767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6DcLOdltzgyu5CHIfol09n+T7xDDM7p3Zl6EDPmpyrY=;
        b=TOv7QaC4rJJ5yU9DOEzIn8E9ux7bx42y8xWkuxpz3aCcuOLu/aYo5Abpa9kVV0Qn9r
         wuaSPyP13ZFcDRkxZi1F+VKs5ppsHNk4C5I096E7bbSVbCoWJAGx4KWnGPiNQA576QjG
         CwDTfTsW4QxBMiIyq8RJmoOd/k1ARC/RzhTz++RbFLwynHJuG/7BcufPCDJflPoJCR2b
         yUMCCQX4HPQn7Bq5ddslmW/TDUfcOR0ix3CxP86k1sxRZ8583WR4XRX0s0tsdnU6eB2s
         IeUCAJG24n5ZC9mueDIaolAUKxWpUVnTDH390p+sNQkQoKlOiCllT6Ldu5xMT+IED0oM
         KffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799967; x=1710404767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DcLOdltzgyu5CHIfol09n+T7xDDM7p3Zl6EDPmpyrY=;
        b=sd+niA5v/qLMSCOyvOX+UpcKhu+oRRrL8sEHfiiIZpH+1Wl9CrlbMEWZcCS8Ll+IWi
         8VxEQtWDl1j1EB2aGKrOecVNpzYz1Z51TE+LpUCXZKKAd0kMudTDFGrSrL0xOc7sxsUL
         gbxBK+YycgfcdPKj7XrHFnL9t8c+FzMmQr0YUe3HvNKbuAgJnF2SJVahyN/H3cH1T63q
         RDmvYZL/Hh4ZgWIC5ujeCQ4UTpIKE4fsLBrS2cRjoy5RrXlvpzz0FDg1Diye3LqiHZdd
         SxtP7xlPJfrr6JVRX4BmuzK6JT7gZ+LrseuQZE5dQrwuftqNz/WCF4ciLdadVLVhTQvq
         joaw==
X-Forwarded-Encrypted: i=1; AJvYcCVkbifCvhZwnrAtoQD7VxV0xjHJSWuSLTz/TFULWV1FH6EvbNuzTZA8ybrIAzE4zJ3431HyQ+L4XtZIkzB44d9CWXWQ1x1Gf4cC0g9v
X-Gm-Message-State: AOJu0YxEWEZH2q1Mds1wA2wLrJ+lfGWeX+Cjds+9VnW0vMQTVtP8L01b
	nTYn6e/NVsxrCPAHDVaBz306lAlCFX8R5tEOH7gqAMpPlLRQz2rTtqikTv3IrDPkVZS0U6oRWW7
	1TkxzZphPuVCPKZkFIxb7rNIQvwO2wiMouFojNw==
X-Google-Smtp-Source: AGHT+IGHsOCpTCeuA1MgZHwchJtg+1eD6vRYmvHQnpMoHVvzORgTKaoNedGZXQv0+HzxqBuShcp/yC3fC0jYLU57JeA=
X-Received: by 2002:a25:9745:0:b0:dcd:3663:b5e5 with SMTP id
 h5-20020a259745000000b00dcd3663b5e5mr13333447ybo.25.1709799967726; Thu, 07
 Mar 2024 00:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215103929.19357-1-quic_riteshk@quicinc.com> <20240215103929.19357-3-quic_riteshk@quicinc.com>
In-Reply-To: <20240215103929.19357-3-quic_riteshk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 10:25:56 +0200
Message-ID: <CAA8EJpoYi3qSrukuFouGeLNrH5fB6MXcKJ33h=g_OQ2k8SV-ig@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	nfraprado@collabora.com, m.szyprowski@samsung.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 12:39, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
> Enable Display Subsystem with Novatek NT36672E Panel
> on qcm6490 idp platform.
>
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
>
> ---
> v2: Fixed review comments from Dmitry and Konrad
>       - moved pinctrl-names after pinctrl-0 property.
>       - removed gpu disablement change after validating gpu.
>     Rebased the patch
>       - rebased the patch to resolve conflicts.
> v3: Fixed review comments from Dmitry
>       - renamed panel supply to regulator-lcd-disp-bias.
>       - moved backlight as per sort order.
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 92 ++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

