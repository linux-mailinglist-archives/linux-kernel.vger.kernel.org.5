Return-Path: <linux-kernel+bounces-165709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605128B9007
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921A41C213F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F2161937;
	Wed,  1 May 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mtNr6Bui"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFA1C287
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591425; cv=none; b=Pc6frUUW3zFFnI4YSqi/Vw0ogwMQmN4RaQfHNzPmWkZugVYs/WBI5uQhsVbpkNIpAKgKg7ZylL+TkNjFIHU/RSvwXZ4jhQYvTCFpYhLB5wtCuir+o6P4ZG/piCw3ngWrnovqhUOspIIZ5ocroscoJlf0v/ZPzAeGKJcj/CFSt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591425; c=relaxed/simple;
	bh=ZhyoVBBIHgstfRuGDnnjMiKeVhXKdonZKZf22uLclA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjn0TuHKOyIZG67eXYjz5vbEJ3EBGeVwoWDfXUG+x1c69HdqWq3S8qYUvv+SGqlqkfn02TiuBZm8ASC6wZ4jRPBeXGVxT47Ch91IfimQuyNOenKykfEkpFPXTQu3vZtTu6o36dioZhsWjDVRt1Wvls/KGic5RHnbsFlr0S+RRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mtNr6Bui; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecddf96313so704015ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714591423; x=1715196223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbubMcULTqXEpjOw1/tNxpjigRY/QT4JGEZ8U1qfXOo=;
        b=mtNr6BuiTFOm8/3utSLHviO7vJkPB6Ik6FlgBlJ6WV5PFM6C/z4Trc/IYhaRBWCiIB
         zECmQ/REPPhA0MQeJr/luhcQKsWXW0hAPLEeriaLsGWLfaoTpnFRAAoRZkjdi8hCgaXR
         Ly3xXsa/YpzB2CGoGGvfFIgRyZCLp0icjqXrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591423; x=1715196223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbubMcULTqXEpjOw1/tNxpjigRY/QT4JGEZ8U1qfXOo=;
        b=wnpT3hoEmTMC79ZZyu9B3hJXNPy86QgAXOPPXh97LYKPld5FR+ptzyDp6ygOrheEQ5
         k+DjI3GrAMUUICvZqRPKPn1rRcEQk3ND62Ujv9fcadTezYF2QQgI8F//8ZZqiFlfUt3G
         algPnI1hv8ZYVwuEsGiLeNwaprZSRzuVKH7Ky5QOsHC8bbrsN7PAEoDyjDWz/F6Bq5Ac
         9JjBj9YwujSW6CYWl3oIQ6OUeMgOu3h3usFE20VXRIrOuB2Y8pFGMG1IaopjcgKfVHVU
         PkRc5FQbG4SulApF3gFaxTDNAs/Ops0M00LRtZOaWN+B8CBxnp4DmYm6WeXJfQ09gnvX
         p++w==
X-Forwarded-Encrypted: i=1; AJvYcCU+Jqe9shFT9PgdNwUT2sKQl69PjMYvczdAlWOPtjEfzRSUtkIVekEfueZuw5ndeF5liIdG3vT+X1V0SmvVCfwdw/IggzAGnGGzDyws
X-Gm-Message-State: AOJu0YyoKoo2ZunEEo1+wIUNXdkyrDa5ULv8CMWUWaKIO3fZ3M1YLRCb
	ZTD8EKPOGgvgqkuHjF5uT9jDN0EmOMckvpKhHCGiXI5OzJAf3KAKUva1QeLkc5Ym7L0r8CsOZ4M
	=
X-Google-Smtp-Source: AGHT+IE+g5jeyjhztmDRZ067VzaLSvowKGOjQ8RoK93pyH31AnrzybSzw8K+25PfBlaN9GewS/IBvA==
X-Received: by 2002:a17:902:f681:b0:1eb:1240:1aea with SMTP id l1-20020a170902f68100b001eb12401aeamr4508856plg.20.1714591423041;
        Wed, 01 May 2024 12:23:43 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id jy14-20020a17090342ce00b001ecacdd23a7sm1201134plb.281.2024.05.01.12.23.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 12:23:42 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eb1cb1a8f1so1725ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn5/M1wr9nsEoVnFkrA+x0hHS7ZiaBeuVt1F1NSvD2lv5owMxcDerljG/mKX4j3oxC0JcviO1UU3Ixq6lhXW70lEWru127Pb4tXABI
X-Received: by 2002:ac8:7f03:0:b0:43a:f821:5b17 with SMTP id
 f3-20020ac87f03000000b0043af8215b17mr33651qtk.3.1714591400761; Wed, 01 May
 2024 12:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org> <20240501-qcom-phy-fixes-v1-4-f1fd15c33fb3@linaro.org>
In-Reply-To: <20240501-qcom-phy-fixes-v1-4-f1fd15c33fb3@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 May 2024 12:23:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VYKELU-xBjMUqLSASC+m+eGCxHCgueCFjxwphxggNAww@mail.gmail.com>
Message-ID: <CAD=FV=VYKELU-xBjMUqLSASC+m+eGCxHCgueCFjxwphxggNAww@mail.gmail.com>
Subject: Re: [PATCH 04/13] arm64: dts: qcom: sc7180: drop extra UFS PHY compat
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, David Wronek <davidwronek@gmail.com>, 
	Andy Gross <andy.gross@linaro.org>, Evan Green <evgreen@chromium.org>, 
	Iskren Chernev <me@iskren.info>, Luca Weiss <luca.weiss@fairphone.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Yassine Oudjana <y.oudjana@protonmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 1, 2024 at 9:19=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The DT schema doesn't have a fallback compatible for
> qcom,sc7180-qmp-ufs-phy. Drop it from the dtsi too.
>
> Fixes: 858536d9dc94 ("arm64: dts: qcom: sc7180: Add UFS nodes")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index 4774a859bd7e..52d074a4fbf3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1582,8 +1582,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>                 };
>
>                 ufs_mem_phy: phy@1d87000 {
> -                       compatible =3D "qcom,sc7180-qmp-ufs-phy",
> -                                    "qcom,sm7150-qmp-ufs-phy";
> +                       compatible =3D "qcom,sc7180-qmp-ufs-phy";

Seems OK to me. It looks like UFS support for sc7180 is new enough
that we're not breaking any sort of compatbility by changing this.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

