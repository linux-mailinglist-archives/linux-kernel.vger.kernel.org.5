Return-Path: <linux-kernel+bounces-162752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B6C8B6019
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82D01C21A20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A44127B77;
	Mon, 29 Apr 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qU0w7UQI"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E591272A7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411810; cv=none; b=k4tyz+vgOPgW+n2D8aV7uXNiUSoy9ZkI1CRUUNgCD90t+tLjtAsTWfpByjiMfKxGKMe3M91y/sgyedKqlI7WQhP1hUmbDIs0CFAubVrjUCJibayWX45QF5qFrvjKJJhQa+C2PN2iyt/OzhkdvywDPaooVYd8Y+3oFAG/Kb1geMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411810; c=relaxed/simple;
	bh=NAYUwQk3+viNKWYj0Ci8K+1OFeyRtiPWNJCpAFbxutE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q9VHgZRUzznv4XiZPh7wxDYZGZpaNaQW3ZhOPFNi5dOnpFGTzdRadpG26DHd0DGEfbw8d75KUnLqae7veBJ9A6C1KzzNgpGNDRFG7YEyD4Ia/i4/yFEemHhtMf1wCJYdnyr3iVzXC0N6fCaUwRuRwlfmBlclNBuZly4PaWkpnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qU0w7UQI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a58a36008ceso561893566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714411807; x=1715016607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApsAmNtF7WojJxJovU3iPiwCDNKhiq4dAAzkVUAsKYM=;
        b=qU0w7UQIvkuDG6eBbYmcmPjuRY7wXyXLMbO0RsF9XzsK17Bb4EqTCV5bTVLfXWnX6s
         sPnNlZuKHP9rn3eF5FU0kiI7j5FDlvI8MnDllgl6SwqaVbRdwSLlxBLplOp0QBmK6wNN
         jTfEm/afsMabJP1NG14sfjFCu6b6v8r0m2gYBa29WyvjbFKmMq9+GUN+jECFTH2C8muR
         6gUr5fSgXdIIupNI/iXpThcYOJ5zUa2GMp4AWiJIQuXUA1/9j5gJlm+d+KAT4Odlyq4H
         4czTYlsWGDZ69TaBse6NkTuJGh0iw68kPGWvMG1K0xd9bX9VQWPIByjg92u2R5oDa/xv
         DIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411807; x=1715016607;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApsAmNtF7WojJxJovU3iPiwCDNKhiq4dAAzkVUAsKYM=;
        b=AjF4JoBZ8ghNuF8JBQr6N3fZZc0DKBDsGCEgIgpurpkrF29pqi/HnZvLN7E3X4zHsZ
         Gm0OYvvmQGR7HHfxDOdbNhGPud7VtALJNkX2SASVVmq17V3mNkmiPxNpObIUUSRjYuUn
         uPz8rCTQAM76CMyTB7XZ3OQ48ZGHCslKiwt64ykFtjnQY9ZvC1EWn7TntYMmPaZMrWl/
         Nr26JBqHzlHLxGfkZM3x5OQTAbEp9UWpEFuQvlyI3vL7iYxSPOnewfEsi+lVgwLluGPC
         S6uDkEomNSxqgEmQGjPWfLesfTJBi3VQfXMypgQh56w/A/zEtgtMG+aztgosk4qqRm/7
         LbLA==
X-Forwarded-Encrypted: i=1; AJvYcCWs/2576BE48wetJhQHieX1EjWFYtcMliT+JjdXN/9Ojo3t2tcwwVq33/2lhUlstrnJFOf2D9saVa6Mtytl1BEqjVJA4MAQkwcWX6YN
X-Gm-Message-State: AOJu0YzY5a9gNlwPD//IHurEcyKlHt8XOVrq3qZE+Nb3Z6JbArp7+BYf
	dAPd0pp+Vq4bZJ24PSk3EdoaXsZHqRHHirkAU4DHReXAk65em18HcYT5L7VEUwU+4YOwDD9OsfR
	2Yx0=
X-Google-Smtp-Source: AGHT+IF6Jf+FDVXZFYTzzEsiJyYjXEo46zQqXDIGe//XlnoIxz3tHXt5cCHfbrryZRIviq2Dbj2hgA==
X-Received: by 2002:a17:906:f18d:b0:a58:7298:fdfe with SMTP id gs13-20020a170906f18d00b00a587298fdfemr9105221ejb.53.1714411807391;
        Mon, 29 Apr 2024 10:30:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906298a00b00a58ed644d6dsm2770173eje.127.2024.04.29.10.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:30:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240429-usb-dts-gs101-v2-0-7c1797c9db80@linaro.org>
References: <20240429-usb-dts-gs101-v2-0-7c1797c9db80@linaro.org>
Subject: Re: [PATCH v2 0/2] enable USB on Pixel 6 (Oriole)
Message-Id: <171441180540.306855.2701742264944278377.b4-ty@linaro.org>
Date: Mon, 29 Apr 2024 19:30:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Mon, 29 Apr 2024 11:35:48 +0100, André Draszik wrote:
> These patches enable USB in peripheral mode on Pixel 6.
> 
> We can only support peripheral mode at this stage, as the MAX77759 TCPCI
> controller used on Pixel 6 to do the role selection doesn't have a(n
> upstream) Linux driver. Therefore the role is defaulted to peripheral
> without any endpoints / ports.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: exynos: gs101: add USB & USB-phy nodes
      https://git.kernel.org/krzk/linux/c/14d15fcbe0f1fac5979a0b01160f3651340e38b4
[2/2] arm64: dts: exynos: gs101-oriole: enable USB on this board
      https://git.kernel.org/krzk/linux/c/b93b3140e82a0e48442087c38346eabfb92c63af

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


