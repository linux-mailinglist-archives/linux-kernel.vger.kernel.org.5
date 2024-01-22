Return-Path: <linux-kernel+bounces-32897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F9836195
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4861F27A99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6644D117;
	Mon, 22 Jan 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bbrnlqj5"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CE4D10A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922126; cv=none; b=vEn56sOsu6mz/k+cjjWnWrN1GukbBrEzb8XXWjHrQ6UG/B0Se11mV0XICc29u3nd+aZHCpv7KRokJFBzHxAI4g5TVCpSkPRdfEscbfzkIlC1UGumQf1cJRPADIXqSyBGkpMVK7NBRD2u8tQpjigvFXOcVSOEmNMReeaW1MZMh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922126; c=relaxed/simple;
	bh=jz5+fq15v8P2y1IAjuMP+zZSU56HsumzIfdjgfbshWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EFI4r7TAzQJgac9FpkyxMJy/8IQhrWrScjaxiwwfJu1u9/pkHM6J3CSXNRIdxJd8zltFTa+1UNdpfX83erkbBjTweaS1FALauJtuxOi+o0z8k+VKe4ke8tiAdkQihln6HatGst5lCj7JuegiR76+Mx1Ps6RXc+/U5DZ8uespgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bbrnlqj5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccbc328744so35669191fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705922122; x=1706526922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcuxO13l9rVY0t17bgZ5rUtyhA0tzJvdYRk5OWx3zok=;
        b=Bbrnlqj58dUry9GOIU1x058bMXzTRNGlmh1uOq8GxRW/f2lmU9vUog9CivUU6F277k
         JHr8gNQ+rwzV4DTpqeFHVI40Si+BPJ+FNNWcOmnWdDOfscPlf1X7ZYEYCsLPTLb6yU3p
         lLnHr1EoLqKPkQn8YtDmMw6cvXvg9niscgwufeZR3vSgB/d9NdzvIAs6Nx5JncSX4oQj
         /iGQ1VMB+82yKReDwsNolULXAxA6kBEHqTmS4kQCYbTtIrkSgHOLETtLP+3uUsK94pIT
         MDj6hDGBfGQgMSwTvCcJNIG4Z4vhg7nmn//wdH4gGYKjQjI0JWChbW3CtzYwacn84R+z
         eAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922122; x=1706526922;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcuxO13l9rVY0t17bgZ5rUtyhA0tzJvdYRk5OWx3zok=;
        b=adNTE3oLDRxhw7V2hWzEunfUJkaeiIm1vznrEfHGLgrjbuQGfwY3v8NOonmnl1D4us
         sbnQSBNIb1V1UE2qYTLsBW0CStP09MBvBPB7ntVbAbBfCNcQKEnUHBKQdWeuNK4fSLf4
         i5CWXQqO8G4K/XPS8gqRsbQNo6gmr94xhWTIFzpjCe55ptHcOQpZjDocoGlMyJ0NtYkv
         +nUkk/kV6AJhmXTdLVIf/2bYSmv9J7ir6LGo2O5tPRiNVBCw8YRShhskb2SxPA5y/u88
         zZ2qPX27hwPD5JWaItVTuLnMWYFyQDFiYt/DOkToIYgHojPhR97pZBWZlfMgqzMR2oPR
         OxZg==
X-Gm-Message-State: AOJu0YwhKtE1u4jyrvI9GVh7bdJOy1+BFRMEcw7CVxL/uxs5UOSuwZ7r
	EHIlFjcgjJ+fGpaqqmBXZX6d10oKTSlVfQfb+SwW3MH/chj+xLqqipz/sboSHDtvQ2N+77SEn9I
	qehU=
X-Google-Smtp-Source: AGHT+IH9GCOtDWvqqem7I6JtqINBeY4M8rLVsz/vddPraRdlqQUuPr0C1iB6ZvQxovWcHQFQ8xuEQQ==
X-Received: by 2002:a2e:8895:0:b0:2cd:8ee5:2d8c with SMTP id k21-20020a2e8895000000b002cd8ee52d8cmr1592791lji.33.1705922122727;
        Mon, 22 Jan 2024 03:15:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h27-20020a056402095b00b0055c643f4f8asm179422edz.32.2024.01.22.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:15:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: andi.shyti@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
 tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 andre.draszik@linaro.org, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20240119111132.1290455-6-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
 <20240119111132.1290455-6-tudor.ambarus@linaro.org>
Subject: Re: (subset) [PATCH v4 5/8] arm64: dts: exynos: gs101: enable
 cmu-peric0 clock controller
Message-Id: <170592212128.45273.4024019835261321108.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 12:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 19 Jan 2024 11:11:29 +0000, Tudor Ambarus wrote:
> Enable the cmu-peric0 clock controller. It feeds USI and I3c.
> 
> 

Applied, thanks!

[5/8] arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
      https://git.kernel.org/krzk/linux/c/8a670bb84cdcf1397fc4a3bc295c0008f49bed91

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


