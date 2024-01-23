Return-Path: <linux-kernel+bounces-35239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08024838E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBF1C22DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A625DF2F;
	Tue, 23 Jan 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaFv2H3l"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFC5C909
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012311; cv=none; b=qcZBdR2eZ1733UakXjyOZHtPmK6EDjF2LNRqsN9PSJ4ANonvE6fn+P+3aK8QBZnSsoc6VMbxyZWQIAgq699thYFSv/+4t8gtpSBnRwtg2D2se28SIq8n7qB0dRkMXMzlYwWo/a30KT/bI1W7kVbR1S+Xg3TuI9F8kXtD2SX0Cig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012311; c=relaxed/simple;
	bh=2V+Bx4FIrH1pc364z+9nImn5SzIBGQp/BaM/gj1sj74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBQ3CoynWmE6Etv00FpKP9s+ia6IQkpyady9qlV1tguolY7kVFjokPQuntj+Cw6eqK3I7iTw7Yqv1IEQV5YvXrkJXoIxGmb/caW0HlwbiSXHEpYWaHHD8lHWger8qBAQRH0RnmqyGC2hGa8kHkZgatRV/UkzQstFe5wyiC+RqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaFv2H3l; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2798879276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706012308; x=1706617108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh62vRSBG030L7L0RyJ3ueU0okLJVyWTJjLMCyBYbyQ=;
        b=zaFv2H3lY3gABTnim+cZ7p7QZGduWasw8MPaooj0p39PDsq41Juu/MbsiS3eLvGWDC
         UoUzDK64eFNlK88tnlfhzSekUweYP1csobrEpfVVPoiH53zaXmRkiwkQh13bAQxuyEJB
         gJ+97+7BIrLannpyPKn+lXFtGnSCyiGa5wK5uOFPnmydgS1tZEJWnzmuzqfILH+/H40z
         y/GcaRL5oH9aE4HrQHl3XKcSatiRq8s6XYgHo1bLUIY0/mI1U/d76NHpIqfNfC7Rlhob
         rXLX5Og9wjuDFEyZ7Ip8NrjqcfMQ1bFBWyzErVq5vCVL7Y6hVFNKUz5XdHd5QfFNwO/P
         JC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012308; x=1706617108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gh62vRSBG030L7L0RyJ3ueU0okLJVyWTJjLMCyBYbyQ=;
        b=F9XPi1XqcUeSnBwkuZqMHbbINeGK9AJa+KWUtiGeE5rE3UtMuDDDxSvx6sqTMhhotx
         YqCxy8vOJEkMCFqLTaUolouF5RJ0g0FGHUwmuC6P6N3ZV7H8f+Vsl6wxlrVUL/f11SuU
         qMnKx2yZ8lS/VUX3R24U/tIs3neHrj+Rbu1m8XhmK3GamN5a6gR63sKdZ+fMMLNPmTpC
         s1msoT/A2Om4mpbVh5KRpAZ3GOBMcRz3437iimXtTjpizW2ZRptCfNQhK485INe4O8jg
         rRslmX2CvkxKdx5FhmiEGyY2cNgma6EBAarfOFmT9s5pCA+dgD1hJHhEtMtzxa2qm4D7
         vutA==
X-Gm-Message-State: AOJu0YzHAyOacRn71/Sfj4DsAqxqlBxzDffA+Cu+TVmp/wZAAijFfpI+
	F5wQgCiuI6Cl3ryB25MeRe17ocaveAhPTAQ5FSqEcPomWJxotxgYbdJP2YZVztKAmrBTheO+GXP
	jOmYdTcZk22hHYLq+y2A7g2AueNud+y2Nvtcprw==
X-Google-Smtp-Source: AGHT+IE3HOE1WBjbwtEXORZxD29BZLU+G+gsdsCkXBrEeww2LPidC5QdtJcqX1/Wzpcr8U8LXecicY1xPGse7G9nY4E=
X-Received: by 2002:a25:c791:0:b0:dc2:3cf6:9bc3 with SMTP id
 w139-20020a25c791000000b00dc23cf69bc3mr2811724ybe.58.1706012308255; Tue, 23
 Jan 2024 04:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123102817.2414155-1-quic_uchheda@quicinc.com>
In-Reply-To: <20240123102817.2414155-1-quic_uchheda@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 14:18:17 +0200
Message-ID: <CAA8EJppwboaEbKFFACr3LO0OHg4iOJPapKRqoH2EGEYcjV6HfA@mail.gmail.com>
Subject: Re: [PATCH RESEND] arm64: dts: qcom: qcm6490-idp: Add support for
 PM7250B PMIC
To: Umang Chheda <quic_uchheda@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kamal Wadhwa <quic_kamalw@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 12:28, Umang Chheda <quic_uchheda@quicinc.com> wrote:
>
> qcm6490-idp platform supports PM7250B PMIC as well.
> Add support for the same.

The platform can not "support" PMIC. Please fix the commit message.

>
> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 03e97e27d16d..2a6e4907c5ee 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -5,8 +5,13 @@
>
>  /dts-v1/;
>
> +/* PM7250B is configured to use SID8/9 */
> +#define PM7250B_SID 8
> +#define PM7250B_SID1 9
> +
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
> +#include "pm7250b.dtsi"
>  #include "pm7325.dtsi"
>  #include "pm8350c.dtsi"
>  #include "pmk8350.dtsi"
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

