Return-Path: <linux-kernel+bounces-67131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3D8566C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09971F282B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E69132C18;
	Thu, 15 Feb 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpjcItyx"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B7132491
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009252; cv=none; b=h8ztVeig46HVVwrLTLmCjKrfHjb+252sp7DYyPDCa/tjRxv0pRSe8LEliW73GIloHCbcAsoe8ksLf8oLrQclnwOIASlS5fz9xKJ7j7XbaOLa5tTvciTiuvbcyxqInQKYbLXU5QK6bPJ5NqZ/rq6xEIucaVtMfSS9ZRg5gv0bM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009252; c=relaxed/simple;
	bh=TuiNAUvyq1clV8TcQUgStWd7GbVGRghSxXf3rSzZwzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miysz6fGXMnV0WHDxscv6ND5FExu5nz+2dEkpZupAIxb/l8875R7WpkPqG3nBe70E1F1nP1mjMIuxtN0Dx9nxi6kqImSDjw8g2bvMXPhX1sQ+cw4A+5UfC/Cuj+rphKI4R5Bp5RTlNnPw46p1xNEwIEk1NhDpHMaf/FCmAGjGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MpjcItyx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6078c4cadd7so10245667b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708009250; x=1708614050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ0BMQ4fbAPxFZIL+ExAw2UZkWvzvacKzKpaYXVa9bs=;
        b=MpjcItyxaCUbywq2/eFa9EpNJTbqxHjYzxiGUvadyJ4OpD2g3m4X/lGDCmwdji0F89
         ZI3iiZzXixEt5Ceq2UT/wY6vmjXC6KX5du0vxdF+ZnJH0R4cB96e0DF9PgVExW/+PJ9G
         owZiDKQ4YK3LEngMTT6K1FVQmx2pltalCWdLGmxV766sl7oax+LSo/5H2dJ7jIBfOCG+
         NfeLZACVrTmdxU4rSK1ptNPKzImM3PtzV3W03K/9imOLSjYcvzQJcVGA7a+cKKrbzfVE
         KvGCKypdYp7V70/ltmKfLfVkw2SUm5ku6/RfV+DUnaCYMBLfJG5LnMRxHfhK7cfXTWBx
         Y/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009250; x=1708614050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJ0BMQ4fbAPxFZIL+ExAw2UZkWvzvacKzKpaYXVa9bs=;
        b=bCt4FkIb12Vur8WC+BCiJPKQ9UtD8xmxI0cagKZPcQR7X/0ILBVCfncLE5sHhqBny+
         3wKw1JR/3V1Yoa8Mc6duCP0+utyHvGePqBwifJjjyRwt1tfPTY7i9bQUDwVoyxdaU0Rv
         47vev1KIitL4162F9uD/4AO+zXUcixhv7vXyb59K2v22uAD4ahDI/pMZIJz+g+jxNYLQ
         s4pwmZBwvpSlO2zGdIPlb9I26z2vidTN3MIUewymvhKKneFC5swCrPMJntWy1nFl02OV
         4YjdrswD4XNyK6F0k0BL8qvFmh7jnGj0P7h6uQnfc2Kla+HLlKQuzLw3fClXFr4mX3da
         2rOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI/r8If7D4TrSeD2zEk5kv9gA+n8VocOtSwpLejZJ+Edll4NTLgdo7oDVGNdGJRo4zMltD/ADDyAwQbtLMWfghxviTmvZZloraw9uQ
X-Gm-Message-State: AOJu0YxkbhdKL1atdyoGPX4Rc6faGeE9aBqEaxUKJj2r8FdtMrsc0QU2
	7tuqGUljScSSONRvgGZd3dxiB/02++imZ3qjrU989i3WIbGcFl23eZSYNOjJBpA3FzZN2lg05cq
	ii0F+SIWhhBsOzfmbxPg8OGCUUpp2jamuqYWshA==
X-Google-Smtp-Source: AGHT+IH1iXXNMam85attnJ7ZRIB2/4oXnewhRdPWa1d/MOJ9E89Emu3qeIMg52lohwW+P6inqZ48cubKQOYzlT5hKRw=
X-Received: by 2002:a81:7994:0:b0:607:7e73:fce1 with SMTP id
 u142-20020a817994000000b006077e73fce1mr2063382ywc.26.1708009249786; Thu, 15
 Feb 2024 07:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com> <20240215134856.1313239-6-quic_mdalam@quicinc.com>
In-Reply-To: <20240215134856.1313239-6-quic_mdalam@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 15 Feb 2024 17:00:37 +0200
Message-ID: <CAA8EJpqV=w38TqjfTp6OurAwHjR87PpmQTs2jUo6O7vF1-T-WQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq9574: Disable eMMC node
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 15:49, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>
> Disable eMMC node for rdp433, since rdp433 default boot mode
> is norplusnand.

Are they exclusive?

>
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 1bb8d96c9a82..e33e7fafd695 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -24,7 +24,7 @@ &sdhc_1 {
>         mmc-hs400-enhanced-strobe;
>         max-frequency = <384000000>;
>         bus-width = <8>;
> -       status = "okay";
> +       status = "disabled";
>  };
>
>  &tlmm {
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

