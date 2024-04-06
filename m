Return-Path: <linux-kernel+bounces-133955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA489AB65
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612FBB21C9B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F0364A5;
	Sat,  6 Apr 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krTATqmP"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370801EB3F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712414416; cv=none; b=umzqXFY7gFeeBrmY057e8ibZdGGvX3hvppXd3AiP4AkH+Ifho5U26VgZLi4EPy1OQlk2QqwG5qYDdFxu29EV2jLPRl10QXKO9zJwllemq5bPMQb2FCOo4CU8QOYbc7guz5wzirF/Z4kXYJeTzo+xwMMk/k+ebVfMQh+zrAFNjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712414416; c=relaxed/simple;
	bh=CcxHNkjEoTPBe+t4JyilkjceY1L6THn0B6VroagQ48A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMO1DYbCgdI0uwqvRp0Fa1awW1D/7KwT7CLwIMzVT48TTBQaQhKSxNKieGyNa3wmS+T7pFUiPFKvKZrwZ4IPRNpA/veQy/Yv4+1sv1Pgkyi25hIjmg0Av4gSqEuVg7CWIZ+Wr5OScZecM4BLwaApGbJAFlMnwBMUovLJT5/n1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=krTATqmP; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3205938276.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712414414; x=1713019214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJZ+wW1F0Udf2WYtlYShrGEiUXEZlJBVlEyGRMWnHC8=;
        b=krTATqmPVcekRjdTdJBVv/EosiLP/Ep1qM/+uYACGWZyADEDQL6OeywNgbCMy0t41l
         J3Pr54s9mE55eTg6M3rzFaYuW9CWToXar4E8nnq3WMGjAYR/609QbndQa8xR6p3tTpj+
         XR7mFnz6aDQQWae+7XRWiXkcqgktnzfRRuy5tr+weyZrX+uMQuZsA5Wyfm5Gw11Aulp5
         hwytowRGy92j3F3FU/YN2RpDFQko3TQlcWvG+43/27GdZneArlayLFSHNLAE2wfqv+wb
         YK9FpIC/zq960qxGg9YJHyJhvifjB9O5n42NtxlXmL617kw1k8Ew2i2Ku+scgedVVhLn
         zgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712414414; x=1713019214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJZ+wW1F0Udf2WYtlYShrGEiUXEZlJBVlEyGRMWnHC8=;
        b=SCmK4Ib7IjxYqG7wmhFfNmFrqBxDdZ/z4lXgXw694w5rlvuC2jDQatAPuzBf1211yD
         s9cqAOk5F04nQv8HzjYBwd9wcPOZ5pIvmu3xlrjGgVrD8KEQFR8TaOvRFn8l42tzSnj2
         ODe8zTayVHNCHDxiXZVB1Rxll1MhNfjme4uZkoiDlR9k1HsXSiXovRm+UcZAKxf1UWJn
         yQrgtdG4i+C3SQy6XqBiFXDNkC6iG4L45wIq3tbVkEszWCJDJmJhS2wQXqOqJJbNTWFL
         Hwi4wspwQpE6+I9ICMWoJ2CDMMlpixvAhGpRou6hixcsOLrdauoWoItdjUUNL3HmkaeD
         Z9uw==
X-Forwarded-Encrypted: i=1; AJvYcCU1AYYxpuyXuqrQtGRKjm9UO/DxWaM1aRb7XKXYZlwYnqV/ucizHNXI79WzDK8Ek54rJ1tGoZGbvQUR/Hq1SsKntqxYspztA2r0mLj8
X-Gm-Message-State: AOJu0YyI1lK93yMxrhN+o4eDW54ls+YdoKiqvWVtUzUDOrQZrp4F3o2B
	kpyQbBNKS5YqQdcp0f3PdaXQthdCnqidcfeppXg6grRQW4Flf4O3atHGXgy6qYwzGyW8h7e3FWM
	diXskHUjZigVIIePCxPuVmoQlaM/GoAmoVAxvtw==
X-Google-Smtp-Source: AGHT+IHHKJBvpms8GyKJP3zvG/nih1HHOJPLUjfhe7C8wwi+ufj1fM/ahAT8qyaXumJtQ9xSI13siiwrE40dsyyY+ww=
X-Received: by 2002:a25:ae5d:0:b0:dd9:2a6a:3bcc with SMTP id
 g29-20020a25ae5d000000b00dd92a6a3bccmr3754646ybe.28.1712414414202; Sat, 06
 Apr 2024 07:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406-phy-qcom-m31-regulator-fix-v2-1-c8e9795bc071@gmail.com>
In-Reply-To: <20240406-phy-qcom-m31-regulator-fix-v2-1-c8e9795bc071@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 6 Apr 2024 17:40:03 +0300
Message-ID: <CAA8EJpoENH_4Rp38R8igf72fc3j=qAfVNOh5Qjr0y7_tmsyrAQ@mail.gmail.com>
Subject: Re: [PATCH v2] phy: qcom: m31: match requested regulator name with dt schema
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Apr 2024 at 16:37, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
> supply regulator must be defined via the 'vdd-supply' property.
> The driver however requests for the 'vdda-phy' regulator which
> results in the following message when the driver is probed on
> a IPQ5018 based board with a device tree matching to the schema:
>
>   qcom-m31usb-phy 5b000.phy: supply vdda-phy not found, using dummy regulator
>   qcom-m31usb-phy 5b000.phy: Registered M31 USB phy
>
> This means that the regulator specified in the device tree never
> gets enabled.
>
> Change the driver to use the 'vdd' name for the regulator as per
> defined in the schema in order to ensure that the corresponding
> regulator gets enabled.
>
> Fixes: 08e49af50701 ("phy: qcom: Introduce M31 USB PHY driver")
> Reviewed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

