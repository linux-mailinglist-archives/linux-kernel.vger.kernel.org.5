Return-Path: <linux-kernel+bounces-135157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2145F89BBCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523C01C21F56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9D481AE;
	Mon,  8 Apr 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJ2iZZN8"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3F4438F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568866; cv=none; b=LZnrUX9RL/LwNTr2S6x/bQZ8gNlcUiu9+lQA6zJyejpmnFMy6gdJIpZMTWhUssQDAq6KcQIXOxI1713xgLzcsoCn9WqXVhu/fXJAjRXmUlxe3Tmx3qj2gSowtuIe4usidNJwaXq6oMgQzzrZKApvy50K5c5oqie+KbeQ3CUc24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568866; c=relaxed/simple;
	bh=jVEBoWe0mok+ita+GP0jIRcLrJNCSnNIFQYdeB4TPlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWY3JGVFzKpousU8HdbDvaWHzlaL8dpF+COOWHc6qMqqamzv9ecXRt9gSxyWIrw2RzUATS806uP3TOgghpTu6J1bnJf+mgepAyJDFdnO63bC8w5YcYqDROu1NiCER8FRyAlLB5m2isbxLbDYeVNi0Fx66iTeTgYKb1qAsyvLYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJ2iZZN8; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-614ec7ee902so43335097b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712568864; x=1713173664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccdZGemQtAOmH95htQ33GvCmGD7g1WiaWWMlzba2fiM=;
        b=MJ2iZZN8HBc5vtcr3vfCg8JXmFZo4FWwVC+/up+QVypwah28G/aydLWDAmCmAt1Pd+
         Cv0FQO0k/e66F48/83NCfRfmpr4G5sC2O4EP+qYKm5XapotU8E4Fw1C4mPYBlCGbjMru
         sjRV2HsbdZwfhfNEbHeLItY3/bQhiAmkMuAb4mWlBm12o5z7T7FjcHoYmUOhu23mVrXI
         SG4FMEjBapsR6aodwYnnHXBNPUoXc9HM0NcYplj752PRwOP1tVq9JRqE3+K2eDw7Z7YT
         YZ+1UuC5wPBEWZxAQ/kAgvJlj5YmMJbJS6BPKeA7Z3B4bFIEHoEyVsYTkrNGK6BYWsuu
         33mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712568864; x=1713173664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccdZGemQtAOmH95htQ33GvCmGD7g1WiaWWMlzba2fiM=;
        b=F7SeQwDTX851il/vSDE/+wHzgvzdjMn6kBqi3BKegkYeVEYoz6RnYF0HsGy6YekCsh
         CAZIQgexNuhTWF+h1df7Kkq7tkdkCVlg+DBlbCgdjdmvJ0jf+00Aqxk5B1FzxsjjETvP
         hQ0J0jy63a8eZS8eqwDFCQN4IbqpAtC6moka0l7VbjjjI6fWtmMilfacmV6HpGOS6tue
         Gc2tTEZFVfYaNasymVdbyXVaNzQn5o41Bi6EXoF/BSaTtLk//Fmh2r/A7UEHfhn3eULE
         BuggEF5d1/Vn8sOpyRlK7BJvJm8+09SD6sRQz5O0fmT0IPV4+briMdZRO31dx5pzPkVe
         cJqw==
X-Forwarded-Encrypted: i=1; AJvYcCXYf+ozCfVIWEuDo33CX87Ub9ptRREqTYYKybAZTwT55ft8baTzOVHaY+v7y20yFAfwRaz+4k6OlIs4B93wBGX4Cek09lLs2dwmqnme
X-Gm-Message-State: AOJu0Yz/ybk1h9JKC2TTa5R+nd1/bPJYTV9165HAK2zkYwsoxN8z3PC1
	a6HgUfO9eclkMyDHt8T0rOIMbyusoAI+VV9c6BkHwKLsENaj2jSvLBzqj72KuwWJlXMHdxWGdJv
	PjVQLXtCKSyAdV0LpBCCohnQc6dpfeUNBtPPz2w==
X-Google-Smtp-Source: AGHT+IEeD23qNLKI4LzgG0ATSfJAy0faf9nFICLsUBkFLtFuNSQXk1zU83q6cji04DCofUDq/+oONg6lZ40XGPwiIJg=
X-Received: by 2002:a25:aea3:0:b0:dc6:d093:8622 with SMTP id
 b35-20020a25aea3000000b00dc6d0938622mr6172768ybj.15.1712568863856; Mon, 08
 Apr 2024 02:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408093023.506-1-johan+linaro@kernel.org>
In-Reply-To: <20240408093023.506-1-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 8 Apr 2024 12:34:12 +0300
Message-ID: <CAA8EJpob42m4p_REGyjpM2KrdE02x91pGgCLGVhpW_i1vXSScA@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 12:30, Johan Hovold <johan+linaro@kernel.org> wrote:
>
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
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 2 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h | 1 +
>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h | 1 +
>  3 files changed, 4 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

