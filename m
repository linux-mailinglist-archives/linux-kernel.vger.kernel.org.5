Return-Path: <linux-kernel+bounces-132354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8804A89937B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDBFB218CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4D17BAF;
	Fri,  5 Apr 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azAwXyZu"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E5171AD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285793; cv=none; b=ufgahhoAZbmVCmJifkSJPLOAt2XJWNHGTP3Uahy/l07wtmqOSUVCcT+kXRk0SIyOdpw+G9gTkU5A9leKInr7zc+TqUILCs2lgETgsgvf/766+ySFukdmk/VSabn096mvRoCGow4StU8+ow4DOhitx5T4LBh9VWqxJzPcWqEvSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285793; c=relaxed/simple;
	bh=kM6XH+bKgyVxIo9DuSq7aqXJXv9/t19xjoc9OIcTDSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTmSuDDM3Lwrqjidab6VusAh05tYvkGQfhhpDp0KqOsvczFhZlAgKlUQqW15Mv/Yb8aQuU6VGmCJ/exFQKb1fu9WVLXjoJFJPKZ1Zebq80MBYV0oNLQUhP58EygnjfXC/fSXBXveQYHVm2bVOzXRjqjZk7KA5mkIlSt/AH06UnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=azAwXyZu; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso1794514276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712285790; x=1712890590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEsqNh0qk6wjxNfe1EBS/5T4PtCYN6iMohqr+1wRzko=;
        b=azAwXyZuUXce94YC0Umv2/ExAqJ+7SymgHbihppuPlaZVOpvv+wU+2kQpPmuZu+DhD
         Ns71h9e25/Qn/GtHj2x7JU0Eg5XCTcerMF9nwv632Vi3q4p/fQ9QecNJhYI2U+y6BNQr
         1MUDkhw7DZDjJT8tW2JwBRCQJRaTsb1Vd8Kg82ex+Dbp0OqhLTPX5nv1bHCQNa7fMEyW
         kRsjYNlNmKjcRtWYlN2ycLCWXuRTNTLdm7s/6SBvcBFV9+IOdIMGwuneEMkYvKFxs2yn
         1XmyJHx6YKZlLowfb6UltGOsKDyAPUJoznIKTEy6g2BsLd+AcjGAVqAdcjLogZGhn3V8
         Kirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712285790; x=1712890590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEsqNh0qk6wjxNfe1EBS/5T4PtCYN6iMohqr+1wRzko=;
        b=GXPN8D+nzKO9KA44Lc5F/hbb4BwmFxkQcslmeVhz99g8qeiR3eVx5Sda6M5vJww+5Y
         pVQZUvsrLhN3QBRW8PtoYWq/ykJXoDKkBYqeMZZ5W8yRtvokzbGzK/tV/H+Fy4nYB6KD
         0/VFLXJEiUadxhnv7ZnPrl6wH9vdfK69eaZmqS5jJKc5PsmloONVqSPreFxLpi8fJfHu
         +R5lA0IItW+sCmdzJUAMjAjdnIMRwRYJa9GKc0Vx6RX/ndasi/UV8Bwq4cx6RfRZFhhr
         oDq0YfSVoSeATHATxPyBMbbKp9fL4okWaz/oOcZ1nseOEmHaASZyWTX60WrXcbmvtEzu
         FRYg==
X-Forwarded-Encrypted: i=1; AJvYcCWz6tHpMIOAhhRIdZRFspTCNqMfYi13LlnzsNtcS8aXiW4FSM5qUlOtiCKRrZlBhb/IzkGF/ooyRbqeBKTKUX+5SoCox3D+I3UUJUQp
X-Gm-Message-State: AOJu0YxAE4gYjEQ/hsMGmsDTf5LafvzNMgK/hUfW5KLc8yTrtuzNgMiw
	R//70NCv5AREE2VuF8R/dt28Qf8ki7zF7HV479eryrnRPn0ylvkhJI39w4cBeq8DnnUlz/pgwRh
	sKNWgDYqWcgvc72B7N6hPfTNw4gt/RPlio3zdxg==
X-Google-Smtp-Source: AGHT+IG4u2Lg5AEQseN8XhnyCdvNikS9yjicoQQjhDBxxVZhO/lMnvhSuSj5pAzYdpOCxOv9gcRM1CyMxY7VDXAbmhM=
X-Received: by 2002:a25:aace:0:b0:dcc:c279:d2fa with SMTP id
 t72-20020a25aace000000b00dccc279d2famr88256ybi.30.1712285790527; Thu, 04 Apr
 2024 19:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000111.1450598-1-swboyd@chromium.org>
In-Reply-To: <20240405000111.1450598-1-swboyd@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Apr 2024 05:56:19 +0300
Message-ID: <CAA8EJppHXkTNSNaCoYWZaRmKw=AfWL4N0WCqR6uFgNdbkw4VUw@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix register base for QSERDES_DP_PHY_MODE
To: Stephen Boyd <swboyd@chromium.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-phy@lists.infradead.org, 
	freedreno@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Steev Klimaszewski <steev@kali.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 03:01, Stephen Boyd <swboyd@chromium.org> wrote:
>
> The register base that was used to write to the QSERDES_DP_PHY_MODE
> register was 'dp_dp_phy' before commit 815891eee668 ("phy:
> qcom-qmp-combo: Introduce orientation variable"). There isn't any
> explanation in the commit why this is changed, so I suspect it was an
> oversight or happened while being extracted from some other series.
> Oddly the value being 0x4c or 0x5c doesn't seem to matter for me, so I
> suspect this is dead code, but that can be fixed in another patch. It's
> not good to write to the wrong register space, and maybe some other
> version of this phy relies on this.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Steev Klimaszewski <steev@kali.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

