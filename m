Return-Path: <linux-kernel+bounces-107433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF587FC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FED01C2233B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1B7F7C4;
	Tue, 19 Mar 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rF/OU4cB"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EF7F7C6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845833; cv=none; b=PPf6wQzFX/mcjkFCWg9ckByC/c5HkpRf9BBbq17j1IUJLL8RR1vcVOHXDTjlgtXCgv0ELls9+I7hgdRY4pxcUu0yzAxjO09T2JXmSIRI+Tek6lU/wGiEOwNufzT4/uyM1GZXheQxNgFjHMupzS4QO2JMGeTCsg1ZtFShmsEWY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845833; c=relaxed/simple;
	bh=cNAGzh5GSei7x1oCy67Dj8gDtsHa88fXDuEJkAfcQ6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIbjHQCkFx67yJaGBITKNKCIqmpoqaTXnE8pqhWj3bWesafO2nQNQNQcXdv06Fw02hl5h6bJLBguxgWuy7mj8iiDhfNIgD9dDjATo0GtEpZy1YU9GBLznw1zLE/IQ4K7kNAQc+FTVjc/tYbHS0ip+EcGETria/Tm6m9cXFpUBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rF/OU4cB; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4201756276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710845831; x=1711450631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lrvF/ITWTLZMt7k1zbPxhpoK+Pg/DG+kvR7sAP9yq+c=;
        b=rF/OU4cB7V1OTqxzO0+iTSl10EkA98jk27nTW9UJWzlrEgiaM37tNbYZi2xHLPISTW
         0wBgYXq6R5K9Lv723GOtX5zAdY3sOqf4g6sZQizjLUZyQJP8zVe5TqXcvq/aJWr61LAg
         MqdsVEIWT3iWuHgxtiiWBynxPkLDeNJ3Aq2oIKVBclN3V1E+a4g9hWzvyohBUFrP0Ffy
         wOcaKMXX4sYB22/6l92B06b7EM7QO5bhTCXtYarJRdCFVfgI1ZHwrU2iwpwHrKJl/phP
         GpC9YXuHMG1nosRGJJI5XXpKx5EolCoUyHwRDI+k7636y4k6zDNaI+GoEDM9qIDCS8Kg
         CUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845831; x=1711450631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrvF/ITWTLZMt7k1zbPxhpoK+Pg/DG+kvR7sAP9yq+c=;
        b=bkl3cRc40ZdW32X/qK+LhcAKV+FtK4dqU20T9ehFcb7RBSgJhMVAo2pPDVtyL+u6rm
         2TSOR71cm7p8htZiUASgZ9Fz4Y/oggdQmTSSXKHoa5t5a5mvEBlVRGHrmLe7Le8ieul9
         NrR3bIDvTohmxsZZ83GO72aJ70AT3yMrZ6RZoXOVskdwGdwuqLtn5P5xeegEPRpfnHIU
         zajXNzqlgm2e860jBSrIYmqzFzWZkMikL/l1CAjfW+cgwwJ52TnCtfJ26/2PAF2WZMKA
         TEmHaa1EF5D6auWrrRKVRoGrj1D/DWZZBa6Lnw2m4RviT4jntMknxk1ygHOTcpLV6LQY
         WyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURWgmXmTcxs5NlBMh3lGMKaEQDG7/53WgqYArbGfPwzWxwYqVqM6yJtJCWP8bUMfcHMm8slfM0gZFIWJlpxxbKg10QRhJSuTukcF1K
X-Gm-Message-State: AOJu0YztRdv3XqSD6fpXwmYcZSX2LfhRiAfuoLHpPnl01sO+BOcGlZ6x
	oN0MqGCvi2kZ3DPtar07Fc1QnMZ8brrMkySenvnEH/gxN4MYkqnrxyT0BBfR8pE5baFapubZzfK
	kcn18J9Pdz7bYlZ4zcR9PlqiD+2iAk8FX5GroRmgzvGNT5mp3Hi0=
X-Google-Smtp-Source: AGHT+IFWahUbPbZ0gt9IIGvtcCSEaFVaaIjj/JI8BQjE3K74Qn0khAsyE4Dy379EPMpN+d6EFyJ04gOY3GwCbnEfYU0=
X-Received: by 2002:a25:b21d:0:b0:dcc:58ed:6ecc with SMTP id
 i29-20020a25b21d000000b00dcc58ed6eccmr9940482ybj.41.1710845831327; Tue, 19
 Mar 2024 03:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
 <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-7-926d7a4ccd80@linaro.org>
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-7-926d7a4ccd80@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 12:57:00 +0200
Message-ID: <CAA8EJpqTvkb3bea4RxeG4zSMe0Yae209Z_xxLn7DXQi0RZhaiA@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 12:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Remove the dummy pcie-1-phy-aux-clk clock and replace with the pcie1_phy
> provided QMP_PCIE_PHY_AUX_CLK.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8650.dtsi    | 13 ++++---------
>  3 files changed, 4 insertions(+), 17 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

