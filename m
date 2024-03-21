Return-Path: <linux-kernel+bounces-109890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07552885767
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FACC283BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638F56768;
	Thu, 21 Mar 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kg+5ZZLh"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720542A90
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016796; cv=none; b=uNCOK5ML3gm2oeoKvzFDJ+rxNqnsreSgBwbiw0Hvpx/0lXShvIODNcbAlEH14jn/xIdf+pKI1FFPQqcCU9o5ZcXd68qs7cdH9b5XWds7J2YYj4ilMUIdIl5DeYyZq2Fy4LjUEUYwa4w2jl0xRxWiTRDSOHRHedsPIqQXASkORbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016796; c=relaxed/simple;
	bh=+884RlU/GlvwTUa+q87xsqia51wLJdHzo+MtTS+qfuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/4K1W1INegaxY6x2M+xKHAUpWthQNqODdRZFKMEQvI13hNtBj7cK/2XQHA0RW/Ut9lfXpLESAYk45nKpf3yMiF90cMyx9z200bV7SdzX9AAuz2RIGxwdqUdtNM9poWgL19tAZute1NkpIjkRQuqq6MZFrk5f2e5SjEfy6swpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kg+5ZZLh; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1335252276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711016794; x=1711621594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G1DsQsCfjVXlcreC9mkpHOUXs3G0EDhLcSU9dnMnmlI=;
        b=kg+5ZZLh+doRgTaLkijY08SgBBLjl9YUBJ3oUe9BEryI7Ud81dZkGMzUsR3GI8dIvZ
         Mq/jTO2KhL7ferxBN/HoUIkDXzkjczA1Qzu5+a5+rH+zy/8dNjUPmBHOju8RXLkSuf+G
         J5jBJ4n3ZmbR37wH9pmSu4aqcV6m3ougqSZx8gwPjxEzz0PehxhclKPKUafKBOiku7Yz
         pOEph7nvmuFY15RfYBZCQ8/VO1Hb99KMcFnNFRasyElNltmHdi9Dvi6F1oe1Th5WG+Tr
         EuprPQ7t/Li/2Bn1m3MFDh7pjNzcFZsYkd8jwMkYM3ogqt1WlZ75oihg0vJRv3iNp12N
         Ux+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711016794; x=1711621594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1DsQsCfjVXlcreC9mkpHOUXs3G0EDhLcSU9dnMnmlI=;
        b=JEOuYHEo1l7AgxWDpFXB7u+7glxusBkWTEqy5BFMvDdt71HIgsDGigcWFUB672V9C/
         q/DsGI8CO6nLiJB3cSjZyvPcPZXEkJvQJG+stpX7k8kUfapz6JYaMWdE9QUeiFr0pNd3
         RYL2/RP64FjSyvimqpPZJbn1dtumBwitKq3yLxsji5nB+qyrZglC1LX4O2/jHoYN9X86
         4Uomxbt70zTwyuwEWfILLlSyyAMlYpq5Am5uarXsVelT+jFehwr8kyF+3jTpSmvSnDzU
         A9dOZIRbmTawvEIeZO4LNu5OUFa66z/q83JeyYTtPgdGbAMseug3oBk+WMvqSFb4r47r
         zYpw==
X-Forwarded-Encrypted: i=1; AJvYcCUIx9pIZpwU1HLiDxWmvXblFTLur+W78aw9Ji5xXlCbqKSqvA0I/UXWQJKifoMnvnPlVhc8Nh8QsOFgL3+jpC1wr9nb+cUPFtV0gzRp
X-Gm-Message-State: AOJu0YwaIIQHPVibM7F3vgBTNkod5ssQOlsa3eEnak2a6UMWti/yUoRC
	HudNiTs69iLEAzZ3HTltJM9ML+2jK8r2byueialsCP6HFqD3GNllXyUuQEEojdYGbFjXT3BA7dw
	qUfJ9hR0CTuBRs3b1cC8ZRX4AgjLay8dN+jW2vg==
X-Google-Smtp-Source: AGHT+IExb+vzGD2UTaSisA7Z8I+voE+Wf1d1MMMQfTeCa1gMgMMvvTYLlKLB30P2jM8a1OlAg5BhSTY31uqzspWQZBA=
X-Received: by 2002:a25:7208:0:b0:dc6:e7f6:254a with SMTP id
 n8-20020a257208000000b00dc6e7f6254amr1505416ybc.8.1711016794255; Thu, 21 Mar
 2024 03:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321092529.13362-1-quic_jkona@quicinc.com> <20240321092529.13362-6-quic_jkona@quicinc.com>
In-Reply-To: <20240321092529.13362-6-quic_jkona@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Mar 2024 12:26:23 +0200
Message-ID: <CAA8EJppoeOgcEoaoAYs0cS9yVTPOOwa7J47GvZ=OHNRZzj69FQ@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 5/6] clk: qcom: camcc-sm8650: Add SM8650 camera
 clock controller driver
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 11:27, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
> Add support for the camera clock controller for camera clients to
> be able to request for camcc clocks on SM8650 platform.
>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig        |    8 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/camcc-sm8650.c | 3591 +++++++++++++++++++++++++++++++
>  3 files changed, 3600 insertions(+)
>  create mode 100644 drivers/clk/qcom/camcc-sm8650.c
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

