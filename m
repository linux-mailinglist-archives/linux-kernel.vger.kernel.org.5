Return-Path: <linux-kernel+bounces-75671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF3685ED31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC7E282826
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518112D754;
	Wed, 21 Feb 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G08zCkDY"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39612BEAE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558885; cv=none; b=bKhpb6+aN/WWohZnipm52fHUZ6Nul+982Odhu4QnqQWPX47J1JwmLZ8Zd2rOi+dJW4Xzo82C7Wg4Mu4DGQk0Wk1tb+EgLf/yQnEMfyuO2nkGVVuAvKytTJ9Lzgj4HF/K26ppzI7HEla0A3v2wjGcRIZSArTXFLXiJvAeTCcKp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558885; c=relaxed/simple;
	bh=FvoifoPM//IS5W9kYck02wtlG994BL//wpfQlUkE/K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS7wN+PMAq6j0lg+7e6ff3cj/dHBWPwEdi2WCiwdhFDOTqeppUXbay335l0PwyPn4XsETYu5z0HTE16JHFISIEVNfrona4pbPaREC6/nUKnUrhaeRGikB0zcphFVCJks7u7TYKexDekZ+rpT6neXAsDdLVgGlWuYm+q6oLOoIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G08zCkDY; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso7044392276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708558882; x=1709163682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gum7JHLE82lB2obWuKI41M7h3ZETASXy1kYfBRSiY+0=;
        b=G08zCkDYlqw/9S1rH01XI3kWg8V47pcXeYM8Yb98f87tB76bQOTcQoOu24yC5I/cqh
         gspGQgZF6BESd3xj71tLYjzxcG9HAShs/sGc0rKyWCB8+RLoybur/nLJEk/2FQGX9qFj
         lGIoPop8ZA4J752mrjNtzeYLhFv9G29E2Aocr118HzU4pn6KqWu1riSKIcM4WQRF5N7C
         Gkp1TJIIdKum7ntue5zzDzviLhZ/jCeDIDjdvBKOHdJRAD8+u7lG0+L5MoqER4lofpAT
         yR0ZogRwfCZCtvXzKo5pJRaBUdvWhlZLXQTvxZATQTX7rtwcXAogFJM6jxYRxLE8B3Zg
         z0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558882; x=1709163682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gum7JHLE82lB2obWuKI41M7h3ZETASXy1kYfBRSiY+0=;
        b=A5XvUzycac1z8gIPMs6vIpJe+BFU4CtFWEkpCVpgjjDY4w1HK0zvy6ZDQIBhIXdq3s
         3PzkCd5Zty95OA7nUv67JyMfMrfhwZHTdgabgLe7ilGhD6ARg1iD6ps2htURfqCPY5vv
         3laWXBOtziWAIHtnuO65uVqv7fOpbNc3b/5wUxga/KungWZ2hJl3FDRuKWP4UzAm1O6Q
         +Ii+kOn7Byk4/IHClPebK4zkhvB4K3H+v175/H6tip4zGso2w8uuEX2n3uMqdG1zft84
         4yFzAERoM/09nO+VokfZhTjrxnlwyQfdM/rgJUfkjBaWiQ27r/4y7MCZk4zV+CiuHVVR
         eQtg==
X-Forwarded-Encrypted: i=1; AJvYcCWEqOPGcERrpN4jesfpVFXngf8e6DNvceoyFS7/FtqFy1To5izOP7ODxDe5yiGOswNtHQkp72n/zeO+iI5xIcEHkfJdj35LJNiehTn9
X-Gm-Message-State: AOJu0YzXxdidGyVn08IFDRSYZFpxf3C6YLzvzisfykxxyB2gt4iHfxD5
	GIVA/LX0DPz/im6JSJNNelUI/nLQlBhwbPQVEtQkgWCN3ed/InLdRD5b3+IRHQjDNCORr+kdnfK
	/5irTUiXpaBc5OaVhQSK/h4bza0mqaCARBD/Fdw==
X-Google-Smtp-Source: AGHT+IEAyXZCJmUxworvOHx5M4iyWXoKGn83vXU9An74FKMewTDmsI1ABCTIrzsggAoLQPNkOHTcA/u8/Q2R45yYeFk=
X-Received: by 2002:a25:48c8:0:b0:dcc:f8e5:c8c8 with SMTP id
 v191-20020a2548c8000000b00dccf8e5c8c8mr763050yba.45.1708558882169; Wed, 21
 Feb 2024 15:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com> <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 01:41:11 +0200
Message-ID: <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
To: Bjorn Andersson <quic_bjorande@quicinc.com>, Douglas Anderson <dianders@chromium.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> The max frequency listed in the DPU opp-table is 506MHz, this is not
> sufficient to drive a 4k@60 display, resulting in constant underrun.
>
> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
> fix this.

I think we might want to keep this disabled for ChromeOS devices. Doug?

>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index a19c278ebec9..a2a6717c6c87 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4417,6 +4417,11 @@ opp-506666667 {
>                                                 opp-hz = /bits/ 64 <506666667>;
>                                                 required-opps = <&rpmhpd_opp_nom>;
>                                         };
> +
> +                                       opp-608000000 {
> +                                               opp-hz = /bits/ 64 <608000000>;
> +                                               required-opps = <&rpmhpd_opp_turbo>;
> +                                       };
>                                 };
>                         };
>
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

