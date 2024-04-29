Return-Path: <linux-kernel+bounces-162753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A28B601C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257211F21D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A8127E38;
	Mon, 29 Apr 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyfmSKZr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D2127B58
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411812; cv=none; b=YRgZCTbqaayTPRjXO7pz+wgzaYaE636byAHG1fRWZBwEOUDdeV7FKy4y4PdvwQO41phncCbS71XxnZdkinbJnvQdOV190x6oQhR88/IpWhUccYpivhU/40kEN6C7RBS41hpTa8MxiCII+ar5qFfjB7y/eNY+sqP57JkB07EhyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411812; c=relaxed/simple;
	bh=cRkiJUAPzdyGSuRp9yfhNiMROQ+tPMAI9gPTeFbgk3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eDpPG5N7GLW2ROGEt4q2Tew/CEoWn9GMh75ebAViaS8U9ODUvml+KskNcSotZxuSOS2m3lI8csUeEDTi8+hUrLhwv7T68pgVF1t/IaS4ONd9TTSUSdMDTHRHG50WbB58mL8/WvOiZr5Z3pfMC9hSuiaOVLxivcleHubNOkEv9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LyfmSKZr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55b3d57277so574186466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714411809; x=1715016609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKhKqy5/7Ei/RZU9HCv/MdOytLVhH+m1/UF0NQoH4no=;
        b=LyfmSKZrguyPWiMWiEJeS7vRhuXQCRkaOUH/ixA8lUONKjsQOlApj/nZ0VFEa3UwkP
         hDqPqT/ykZRACgQFUr4K1xvePKew/dDCkRzIaVnYoSzSjXPnYszXvUQK6w15pmHMc9jz
         UTpSbBFld4Ux0XPR4MBkJiK/9AyV+JZKtib7+LWaLV+LQTdCGJuzTzMrXm2VSRfyBDdJ
         c1OtYOy1isY9t9Et7WM+pY82uX0FXVMMl9sAMlrXvrLHe0Jx8v7XubFojSG6LdOqj4ZU
         LZb7+Px3a+Mo+qplSk56c2g+iXhNmJS+3Al5rNMPcF/1ssE+H8iDJrqqM/Mngy0XH3l8
         0LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411809; x=1715016609;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKhKqy5/7Ei/RZU9HCv/MdOytLVhH+m1/UF0NQoH4no=;
        b=nbydo5qUqNHr4PzocRfTmTktPh9AOa5H+V1zQ7d8IOft4W7s3t8A9ZTy75Z2g+s05r
         9yR8H4d7Egi8Y/YxHD4Q5Kvr+MqDYjgQJ/c8tkLqr/mkQ4RLnK4qTU2T9FZKUazrupaG
         1E7QWnrZkxJxa/7JlEIdxYeRzl+uJhGO5Y9L9ZkVBVFBH1nAMnqVpxVtfhP8TNRWH+Xi
         tM78h/JovZA4Vcs0re9CyKv7rHMuq9X8YScJ10G2DEKERejctV278ganMKLyhJncTn7h
         oZ396sR9nzUFh8zJqcQlhtB1ag++BiAVITqSWhieoHBjdOx1NZ0kKgay0vOOAQue9b3W
         +yAw==
X-Forwarded-Encrypted: i=1; AJvYcCVW7/dqbLUbHWMude3r19tyaXGSv/M04a3Ro1KBf/8fJcjZJvyu0EPZTxHcWEYeQqNoStEMD2QSulYXmPmfRNSwy57+BoTLh8MwoQAQ
X-Gm-Message-State: AOJu0YxKho/Dio3KS4B0+vt8hXbSj4inpX6lXJRgEqxuBJjBbQ48/GX2
	Ui/9P/1Y81dyc2Vz6BvoG6RFFF23Uo/IiozaS1USGb97rkLx7UrMDa6Fxw35Jt8=
X-Google-Smtp-Source: AGHT+IFMCwYKqThp3mwiSf+4+XCuztnSTcv7W1qMoW81GVcGEYxjbTiZBj/6VWTRdTIMLOWAQTjavg==
X-Received: by 2002:a17:907:1b16:b0:a58:725b:a021 with SMTP id mp22-20020a1709071b1600b00a58725ba021mr9532292ejc.15.1714411808790;
        Mon, 29 Apr 2024 10:30:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906298a00b00a58ed644d6dsm2770173eje.127.2024.04.29.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:30:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 alim.akhtar@samsung.com, Peter Griffin <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20240429111537.2369227-2-peter.griffin@linaro.org>
References: <20240429111537.2369227-1-peter.griffin@linaro.org>
 <20240429111537.2369227-2-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v4 1/4] dt-bindings: soc: google:
 exynos-sysreg: add dedicated hsi2 sysreg compatible
Message-Id: <171441180684.306855.6625584588248689841.b4-ty@linaro.org>
Date: Mon, 29 Apr 2024 19:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 29 Apr 2024 12:15:34 +0100, Peter Griffin wrote:
> Update dt schema to include the gs101 hsi2 sysreg compatible.
> 
> 

Applied, thanks!

[1/4] dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg compatible
      https://git.kernel.org/krzk/linux/c/6d1434a7d95939d21cf300f73040e3e6a02e84f8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


