Return-Path: <linux-kernel+bounces-135169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95E89BC1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62F3282C76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073394D5AB;
	Mon,  8 Apr 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jueTwUG9"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33748792
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569307; cv=none; b=a5tZ7O6yKcXGOu5tsnYfxElTQBSjo3IPmqeJg/BJYXA/qwN7R/13SaNlPBESFPYWXG7FVPYn8sdqgS+sTdVe53xZuZCh4qZ1Afvf4Etwihhta39QPSibHbxGs0MfbOn2vBIf/h8TLdoNBCHqMgthtz2A0b74d9BdlEP19uPG7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569307; c=relaxed/simple;
	bh=2OSuI87qeGvpN4vzsuqcY61LwKCgIvnMstgmBULzKjc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1zEsbMxIxNB9LmiLF6dnLJoJTkEagIa44z2yB727CUIS6BULDtZHOmcdCwMNalQF0+oKOrhCncm+Q64/7wrESiL0wGpQKYAjjnOtfVHikwyFANdW/oGo8DnSLMRJsq9v5FNb2dP5H3yYi/jb35gE1cMXgPtXJ15RbFsIP80gOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jueTwUG9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso53560061fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712569304; x=1713174104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1sjyF9zPEl2TEamRL6KiFbzsyaAM9a2KSULoVj+d9A=;
        b=jueTwUG9hNYGikyha+uMGTbLG5g43pwY/7JHCeMZkTaizz9DuCVjG8sKWTciiDMc8x
         A0kdBc+KcCRky2XyPawS937Shcz1NHCnengA32ZqrRx+VrWsitesxxCUYf+1c08NkBvf
         cJblrxfC6JNx/9l1OSg1IwpCBinuk0txLwCZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569304; x=1713174104;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1sjyF9zPEl2TEamRL6KiFbzsyaAM9a2KSULoVj+d9A=;
        b=EehJSnVVHKD4XKaOhdyCnP1knDDJ8M+Phu+S5XgByPW6SjwgMUixKipxnj1wMv8nh7
         zgjaFYNqplabBjmn/2OMBOg2a4jBP7QE8DGJIv7P/hIlCTM72RnyUmQv8T/paZEhIbos
         dhTSCK9G30QfrEng7GdZkgoQwJCl88JVkGy4NvtGxORj3HohnOTqTwI6K/AIkQzwus3Z
         YfgPYT+K5zWbKnzfi0itYDHVot5XeLVLzTEUdaQ9MAq5XGMZYXaPy2/g1/Rv9MATdFCh
         /S4ozP3qUwbnz2HYj06fHfS5otv5xAyv+2BR6wTosNkzboMVfWzRifuNo821xbESDZ7u
         FP1A==
X-Forwarded-Encrypted: i=1; AJvYcCW9xWQXLbB5kKAfHV1teQTsFrN0PJbrIEqrdBCZtMW6VJK46MUM3segBNVXGnthErtyFjJhuZiU3RMAhLPn2Qwsqt6zrcAfbAvtd8AF
X-Gm-Message-State: AOJu0YyqejUDtifcZ8aY/ajbdGYGxB/AhvQhxEPGX1CMpxMKDfQahBOz
	SOS06FOBZpQzfSe8CpsHDmYCrSXxN0LvBNA7VFFZgOnqwq0l1i3Pwu2lVweLupjWc0LwQ6en6qw
	DhL0NEsShdqZTqRbFmcPSBMSLlQfWtsflb21N
X-Google-Smtp-Source: AGHT+IF9NjrwqKlld09cONkAoXbGH6b8es74pe1Um/RUmrsKTi3n/+lKueJeNAGkqsUBxbs47mKMH0KhlmofkKRnCCk=
X-Received: by 2002:a05:651c:42:b0:2d4:77c0:d61c with SMTP id
 d2-20020a05651c004200b002d477c0d61cmr4901918ljd.35.1712569303584; Mon, 08 Apr
 2024 02:41:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Apr 2024 02:41:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240408093023.506-1-johan+linaro@kernel.org>
References: <20240408093023.506-1-johan+linaro@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 8 Apr 2024 02:41:42 -0700
Message-ID: <CAE-0n50cZ0MoT6M97NAXPNfejk46MkLxQgvBELxFVGgNRRaP9g@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Johan Hovold (2024-04-08 02:30:23)
> Commit 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
> fixed a regression introduced in 6.5 by making sure that the correct
> offset is used for the DP_PHY_VCO_DIV register on v3 hardware.
>
> Unfortunately, that fix instead broke DisplayPort on v5_5nm and v6
> hardware as it failed to add the corresponding offsets also to those
> register tables.
>
> Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> Fixes: 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
> Cc: stable@vger.kernel.org      # 6.5: 5abed58a8bde
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Thanks! I didn't know the qmp_v4_configure_dp_phy() function was used by
v5 or v6, but upon further inspection that seems to be the case. Maybe
that should be renamed to qmp_v456_configure_dp_phy() to match and then
qmp_v456_configure_dp_phy() get inlined into qmp_v4_configure_dp_phy().
Either way:

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

