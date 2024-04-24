Return-Path: <linux-kernel+bounces-156427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E318B02AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B95CB21E25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17039158DC7;
	Wed, 24 Apr 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQWkiIz+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A215920D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941678; cv=none; b=nkVZHa5kGLvpRuKrgubwlahOa3XHw8GsDNEjYlRMctgcD6/QXH28R0zqtQkJZxc24GBW+VKo4GE5sMR15cPRYCfhF8wSuu1k5E1C18Exmt960N3LnlEWHu6SDF3UificdSVmB2PTyZ4iVYF5mZmybBrIlpE+MX5Q8c09Sa0D3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941678; c=relaxed/simple;
	bh=kY2xucFKXDqqzr8S/qyR/W0doPVyCIPfsW6Hz83rCoM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3e9RiNuLV6xTfeO0CMmjSmUZqGZWj6a3AxXwL/OLp0u4cuXXHf0gdRdilv+lpVxJiUMBUaMx+iiLGqWFa6Wql/yZuLCX9hMqfb7va/10eEx4buD3HrxeS12kxWmdXvqcbTdqR+HMV5N78PThGQB9P17KR320AZUms0DwZaqvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WQWkiIz+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346359c8785so5394971f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941675; x=1714546475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZlI2I66i4SsS04f2xb9wEuEKYSB3a9TLQrXJM4K3mE=;
        b=WQWkiIz+QGXPz2Eg8x0BwMazyR0QTPrQc8T5GtsZ7RxMotYkom8yWgjABF90wYjjTI
         /jZ0iZeFyIncJwWY4nIH2ve8PLR68juXZEECHpKeYq7qTQMbP3af8tcrW5GDGmf+2Jq1
         FEs9+NTEaQdNsEMGlcqOlSwMbNxol3R2LPsZxQVTCKv2tk7aXu0YFLSFUe325qBfMq5p
         qSyX9gFR9ngY/+lxIZJAJJkjBSZTBi0qZw0SjEAGKZ7zKdeVfBoKtZFDpUGq8BCyfIvu
         U+YGEDw/Yg+OmhtH4OUaHEFpRlKDZQi5Q29GSj7VfnsBe+jVyPaFDrcgjbuNZbXkxzjq
         wAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941675; x=1714546475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZlI2I66i4SsS04f2xb9wEuEKYSB3a9TLQrXJM4K3mE=;
        b=fkjQ/eujviYwguiUooggg0BXHlxsVoz+cqyH9EjylmHQtGDI1d5eQUdHNybId4ZlMP
         s3OxTIzt/uznEqssO3aub3ZgpTnKP5Q/sZ/fBDQHxIhBUdecJU1sZurBmD8kmn6XXNk/
         +4MydRvoSO1418BwSYKTq+Ll6dB0EXxNyaGFhVY1DSo9e+MMuIfip+W2oHhkh/MIQY1r
         c88dZAW6R/ol87odhB8cuSV7OC0ynnu+RmTjsayDGlEjmFCmS8d8a3C+I/T/0TP9tZte
         N/41aeXMAuOwptGkryyk9habeK/n6ALBW4f87Q6mzwmRWfTC7CD7cAky+7RU1ho3mrA+
         8sxg==
X-Forwarded-Encrypted: i=1; AJvYcCXjfuGHED1tmrkVGc2FkIQ7upAQgiLlfksHCx72/7OIUYjL7W4XwBA4BOlIiz0P+QxWiTct6W0MuKbrwBZQ3xQB6BAnoMNRsx/fG2JS
X-Gm-Message-State: AOJu0Yx1J4qdQ7twRxteJefKK8uVO1OQyoz2DoNnMAYFG0bCW98dvZBN
	yc+6j+9Dpsn81PMgVIrAhJwuNe1WODiGxGxsoRT1/i/woRfwdZPiBRSwwK8WHb8=
X-Google-Smtp-Source: AGHT+IFZ+BTOKCS/fwmhCS7yyEZE+FWRqPHV7tu3vrn5Sle/H3rksFobZHYU3JN8cj+AiY4uqR/Rng==
X-Received: by 2002:adf:a491:0:b0:34a:e1c4:8e38 with SMTP id g17-20020adfa491000000b0034ae1c48e38mr857302wrb.60.1713941675161;
        Tue, 23 Apr 2024 23:54:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0034997769ae4sm16338534wru.15.2024.04.23.23.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:54:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Robert Richter <rric@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: cavium: thunder2-99xx:: drop redundant reg-names
Date: Wed, 24 Apr 2024 08:54:19 +0200
Message-ID: <171394159881.43787.9165226045500607522.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407102841.38617-1-krzysztof.kozlowski@linaro.org>
References: <20240407102841.38617-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 07 Apr 2024 12:28:41 +0200, Krzysztof Kozlowski wrote:
> There is no "reg-names" property in the PCI bindings and the value does
> not conform to Devicetree coding style (upper-case letters, space), so
> assume this was copied from downstream.
> 
> This fixes dtbs_check warning:
> 
>   thunder2-99xx.dtb: pcie@30000000: Unevaluated properties are not allowed ('reg-names' was unexpected)
> 
> [...]

Almost a month passed, no replies from maintainers about picking it up. Dunno,
looks abandoned, so let me grab this. If anyone else wants to pick it up, let
me know.

Applied, thanks!

[1/1] arm64: dts: cavium: thunder2-99xx:: drop redundant reg-names
      https://git.kernel.org/krzk/linux-dt/c/aa79fdba3d42dfbcb10d1bfeb3db9fbc73c4f793

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

