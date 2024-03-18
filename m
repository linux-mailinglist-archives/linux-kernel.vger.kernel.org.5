Return-Path: <linux-kernel+bounces-106206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34A887EABD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E086281840
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441844BA94;
	Mon, 18 Mar 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UP0WJzz3"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562B4AECA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771541; cv=none; b=iGkXsw6SJ05MhCZWcvo1XO7URtfPE5nA/jTCTYbrJ9VpdXOYZNaIkXERFlkBNDrUUIULKQMLMf/h96zcOxp+VQy23kny00945JTzp5YwuDYXaOyEat8ON2I/cuHezC0KvbM+oJXQiYS4hM36B3SGoXflFqJvP7AgggBUc5t9A5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771541; c=relaxed/simple;
	bh=UtoQrV8V4WHcjC1HvrWHCQs9LMwKtT9GXyBCr3rwGhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzFqEYvXGgR2XGfDapG3eSC/JBiD7hFBpsyJNooBHBwJYvmolmGgBzXsnyNS+1jPJQveiu7kIH7s8dvjsYj3H3Ed6IPgel/mH2nB9lmFUPkTT4BFKyL4U7Dr7Z0JiPDmeqnQ8X6eyEW/wZGQZ8t5pxUpgHpw5SCt+mu8RmDJAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UP0WJzz3; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609fb19ae76so47035457b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710771539; x=1711376339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T8/eBwVdC8e/Zu5B3miETRaLCkLZGjLcGDUAWsXNX/E=;
        b=UP0WJzz3CZz8Gzd7s3GryUi7wfBHASAXDIEovRDrKKr8QZdgEQJHLz2ffjugBu/l3B
         bRFtmjq/ARNmiR9eLc+teYW6IUK9gBl8Kuk1h/aGAkShPczPbUFcmoPN5HK0xeOq+zwG
         K0wTYxu5PTZyZv5Elzh/BCMXGRuH943/2SRNrzDFbiIB2B2tY+CT5Odn0E5RoAdq9x6v
         hBbfJJhcCVEYDFt4Om5G9HuGuWRaS4iBAt8u8fab6ivogs7Fc7xra7R3I9yt4gthlDax
         I9JMgTNCQ7L2YVsfKu5vfvZtNmb5DAv/7CduGcbsJzlk4H+uGEX3eu3ZGyu6NDAYqlgK
         7+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771539; x=1711376339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8/eBwVdC8e/Zu5B3miETRaLCkLZGjLcGDUAWsXNX/E=;
        b=chFISsvFw7n0ofASPnU5hbOveM2blu5TxsZ4Kh7HxbDxbFWsC03siXwEnhJVmwoiO2
         o/B0jo46h00tf9CcJ62f1qo9ief10gg8FWwmYxB1bPs/YRwnZugd4kvAMV19XLUp9Kuw
         WABuRyZ5mNGlAbUH4IQ8Vm6eHlhADGleYZlS9nC9iuvgIhVHUt4VyauULYl3LZXKOZ27
         FZpHKwHxAvAAlAVdMDOGBFrv+19ZfiSjVzS7ib78US6ii8QYb7GwL1kEymT6pmRMpLW7
         U6llILkH2WTro7LZYQ9i9T2GglWY/jazzBsyxCWYFz2rGC6KzX03HEpta1QxUAEthGOU
         qxjg==
X-Forwarded-Encrypted: i=1; AJvYcCVfkydhMZh2mff78C6XOFrYKtmVwUqVcidQmrzdyhMvkvTHkjqHrFh1NcPOv0r6CvSEauCofp45KzthPrAfpDGt9ncqj2stOlrdG5K1
X-Gm-Message-State: AOJu0Yy88Ls5R4l096QDxzST3aA6qMgkj7ZqOm2ef7jggSBHzjCmc+EB
	LDiVCBTCVt8/7lBoHHEAhacil2XmXpC9i5/Vd4OkOZ/N2Oq/wCgRb/2po7YqlxL8LcnfWWqvAk5
	qnbmrMhTSYcr6nVs62IS6ESRmdKQ4zY2SkGzN2Q==
X-Google-Smtp-Source: AGHT+IF3f/CCR3DdCW9EhoZwH11fEMIYWHeUtnck7qTC0x9yNt+rbxfUfkX98XpGGqmd3SSienqf8G8v4kmrNcJEdj0=
X-Received: by 2002:a81:d514:0:b0:609:f062:a9af with SMTP id
 i20-20020a81d514000000b00609f062a9afmr12882787ywj.19.1710771539185; Mon, 18
 Mar 2024 07:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com> <20240318-apss-ipq-pll-cleanup-v1-4-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-4-52f795429d5d@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 18 Mar 2024 16:18:48 +0200
Message-ID: <CAA8EJppzBpsLwU6Uk4LxWCL=EK14=NG5Wdpq01wSdWQp6wGKsw@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: qcom: apss-ipq-pll: constify match data structures
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 13:20, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The match data structures are used only by the apss_ipq_pll_probe()
> function and are never modified so mark those as constant.
>
> No functional changes.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

