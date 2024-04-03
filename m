Return-Path: <linux-kernel+bounces-129626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CF896D85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25391C23DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4014388E;
	Wed,  3 Apr 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcpbtgOc"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279E14386C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141929; cv=none; b=F+F7HxKFc9ulF8GJFW1wtM+Bt4kZJjR45PcEB8Uxgu6cKDKEiw1Ne0zNlJzlIx6oYdSKBlwnmvQQNWhYApnzFt5cTFRFTuVMzCzVPWR/SW2BaElhgUa723D/IXD+kGo+XTDrwt0HJocdP92art95SVVsmEjYDm+MViL8hg3uUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141929; c=relaxed/simple;
	bh=oG53gv1bYnsR+3oYThoPLEkc/yA62gyWOpQkeX36Bao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0ATQkQgpQfDVJLaSJPCkCBjEXBtnlxv0HZ6GKTAC1E9hEi1Vabyh1RaQcwk2bSq5q/o1TTNtI1cF41nDtOPmMhJRb7o6dF0l1C5C8wnBEWPV/ygYfkvFAWkf2i3DNoxxE5H2epSKJgK9OtGyeZhvP0q9CF9/76LT4PnKNkLQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcpbtgOc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so5790805276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712141927; x=1712746727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijhuxt38E/t9v5OAptUPvE420yRI30lm4kqS14TcTKI=;
        b=KcpbtgOcin1YJUw2voqTuz4GzSNJTv7tRLRH3/dh0FUGMokjo73Ej6mf9rhP1x+kNJ
         ImSPtUx3HT/V94Qm1zpX4t7q0wavH1WYo7JLVWMccMujELeP4Kn0kHYr0YP7/FndVq5d
         MmY9AfOZIewYUzVQy9hXqkj3X1ltzkBgifW5FvsxBB3wx6ulfQ85CQS1CY6Yve9OFVQA
         Vei9CxBLhRkAw0DntSgfJn6CLqC/9JF0+sSMTDdTK/FvwcfeW3n9jMTshcn/l5/u84J5
         H4IuS2Gc1mD0Pp/XGONcqJHylAn5rY1IBHJ9O6umMrREXzw+zbc1YPMxWy61QwfIEaFJ
         Z1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712141927; x=1712746727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ijhuxt38E/t9v5OAptUPvE420yRI30lm4kqS14TcTKI=;
        b=KOF5wzSZYKSq37ON+5/BrSc50Emb+FmQHZaeXALdQ8wqND3q6gM10aZcTIsFxgxhUz
         z0Zu0xvxP4y6WaB7FoVnbpDQTxtMAkfXeadKJK4fd8WorIBP56EIE45ZCX1kswk+f2zZ
         yVSQN2EYqoMVVDE8EoYwZ/vYEXI7VXsNNGfCTfq4hzy/nl3k7TNeyjrrfSXX2CYtPK7V
         tvmJVPWOpEYKRiqdzTjQv2uMHQBO1lMejcV671LqlsO/8bOiQZ+egba1NDFCCR/w40wh
         EcEWSurNS5eiNouKA75fvDpkKnZceWPOJ0HsVvp7HJngG/wvt2r6bzHmrwjwums0ZqYn
         GLPA==
X-Forwarded-Encrypted: i=1; AJvYcCUxujA3fKGTzxnaEgNBVJnbzPYj3oHx2g3YoB4yj4JR/YHnyAuOliszzCD4DIkTFgx5yMWKYahwzU5/zMZTMd4LT+/xNl/o1Njj4aAK
X-Gm-Message-State: AOJu0YwWI990B6szu4sRq/GOTuI9v52I3M13bbz5+dwICynzIUdNwNmo
	OtJxOpeVYVfMleamDfZN9SwOE6JgNC88FidAS/N2q9/WNB3A9L6UbEF68cSR6v+J+l73KhrgUsR
	anlf4Ydn9tIsxO2MXR6NVkqEWkrST5HcFKXhqHA==
X-Google-Smtp-Source: AGHT+IFEu76HLwecIeLSCiVfG/XZFd2SSZMu7g2xdSAy4gC49xNdZap/m1Re9s5c7HES1skUINx8X+hL0OWOQbdBjrY=
X-Received: by 2002:a25:3a04:0:b0:dcb:aa26:50fe with SMTP id
 h4-20020a253a04000000b00dcbaa2650femr12927089yba.15.1712141926715; Wed, 03
 Apr 2024 03:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403094422.15140-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240403094422.15140-1-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 13:58:35 +0300
Message-ID: <CAA8EJpoeh0sP9iHWU8Q6z9F3_aSGV9qw-WAWtrCTM0nHEdzAVg@mail.gmail.com>
Subject: Re: [PATCH RESEND] arm64: defconfig: qcom: enable X1E80100 sound card
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 12:45, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Enable the sound machine driver for Qualcomm X1E80100 sound card, used
> on several boards with X1E80100 (e.g. X1E80100 CRD).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> The driver and bindings were posted here:
> https://lore.kernel.org/alsa-devel/20231204100116.211898-1-krzysztof.kozlowski@linaro.org/T/#t
>
> Resending because I did not Cc Bjorn/Konrad/MSM.
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

