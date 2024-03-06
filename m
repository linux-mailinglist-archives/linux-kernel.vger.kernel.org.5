Return-Path: <linux-kernel+bounces-93487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FB873087
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E0B267E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D95D499;
	Wed,  6 Mar 2024 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlieIIjx"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C45CDC2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713168; cv=none; b=si9AKDgkLaFkFAtRgoYA6DtNjnFbsNI4RKIqGfl2AEu/G4ATjo1ggXfoVBRa02zk9KzlspMD0TgZo53PnQvAo65zc1Z4CfnArQDUYqmzwlPnIyqN8U9nTyjBZUPB/+w01RkUEXn+/QrcgxFgvP4T8+xNpKhIQUs9Bw2K7Z9imi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713168; c=relaxed/simple;
	bh=dnIZwZqxXCXcBxKA9fSsUTi+xcmsYC0FICFHX3lYD/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeYZaZlkkTUuM6eQ4WF6Bz2Ch0EKlQ9VTUlT21IezkqRtmjnZRZQJ/7fRym77RrW90SyrIjT7gAGidXFEbUy1z/eT0d/loiosmMJZD8X6YDuHAdnfwd4hbZg/e/Mu+kRW/XXHJkNRULHY4WLXm98epWh6jdcfc5brdIk9XT22ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wlieIIjx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6093e067220so62271547b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713166; x=1710317966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoKuwXMEvsZ8GzqAgZzSLOfu2yUWrCyM8WtXmP98Z6I=;
        b=wlieIIjxYtJE4k0vhWD9b2MWzWqtDs5YXzKp7XHDH0wDOcWM6tqzrIY6NlGUqd2pyQ
         AKmc3Yqz+WNCGCIfMDpla/AwZ83X9j4/MYEQTgOQlQwHfpIH3FvFDXpu9985EvGQbOnp
         wXLDezXFYoh2r2TIeM8GUKmkRDkERQIjnTHRooXH20G4oNZd2JNAuBuutr69L4A37teG
         Fxl+c/3a26ICJKHV1ofK7h5JIiKcTBD9TN1rX2yZMAX+8ri3fE4Abmar1953ZzIIT9g7
         4ZuL01auyQyVeO68Bwmep5xgxGm2RmDIT44fW0Y7XezxSQGi0lGg2AKSpii8FyJEMyNV
         oPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713166; x=1710317966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoKuwXMEvsZ8GzqAgZzSLOfu2yUWrCyM8WtXmP98Z6I=;
        b=qFfqg5Ss3jipbiGsbvqovtq5CKTsT2cxk2FxYuLtbZMEJJzBNxAPmBdtts3wNv3MR0
         TVCl1hRKh2M5DR4I3d0sJSZZdlg02T4y1vW2tOyiKAhAK5WwVvHmFBrE/sps6MfC/0ma
         w5myMY4ZN9rQhnoJTAauqLE3LlKweHsVb8rSum4dp2OvWeEC3S4zvuMTFMgZ+fiB5d2Y
         OChxS82rq6QMgi9RZd19si1o041CYlmHDETAIaqvsmu6f0qfXft/DMI8C4gGbOuFXJAY
         ChDLXt/9Ka3o1yVIpz57J1ZTQ3DCbROsdcJOslKyq10cqnr8CrRi1UeQaAxCwSbAyO+v
         6Kfw==
X-Forwarded-Encrypted: i=1; AJvYcCUJzx5L9KXfddkQN2YH8WKPBy0xC1J5oHD+wfQSb60D3mr6FRldZ13x6hWTPaG3cMq7JqShwRzou62c/DSfMrbCCANNfKO6oxEQeAxh
X-Gm-Message-State: AOJu0YyGkDgCh9yDO2WwapuzvCghlSR/UyEoC+SuZyUkWdC8DUaN4iVT
	U8o8yxgVM6BK6r/QpmiRzpgPItg9bGVQkbNoF23IfhTbDff/5ZHYCNdFRU/iH7dZtkeS5KEmKzU
	CYCcnz1fXr90Qgj2jSMnQSFcx+fJ3tDTI2WgImA==
X-Google-Smtp-Source: AGHT+IElFEojtdTOEWHxvLU4AlUsAf4idoItp77LksSXRcXLDan78ssF5m3Ud++5mk9YINDXssdh1ZVmthJv/1gjt0Q=
X-Received: by 2002:a25:bccc:0:b0:dc7:4776:e31 with SMTP id
 l12-20020a25bccc000000b00dc747760e31mr11485475ybm.24.1709713165691; Wed, 06
 Mar 2024 00:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz> <20240306-castor-changes-v1-5-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-5-2286eaf85fff@z3ntu.xyz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 10:19:14 +0200
Message-ID: <CAA8EJprMWbfYuXPi_6e2HjM0W5y7BocLsCUDDu40=xG7eDwK1g@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974pro-castor: Rename wifi node name
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 01:18, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Give the wifi node a generic node name 'wifi'.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>




-- 
With best wishes
Dmitry

