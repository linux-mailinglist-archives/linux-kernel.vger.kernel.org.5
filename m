Return-Path: <linux-kernel+bounces-135629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F789C8D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AAEB245CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023C1422AD;
	Mon,  8 Apr 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2eiPAPK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1051420A9;
	Mon,  8 Apr 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591592; cv=none; b=KPDASXCBHX3FcTJNn5sqktQtS6r3ULjaccife3Ll9JlGrSCUSRfKCkP+sJC/ZtunsBNZ4geUAydTimCuUZ/YgzlBCUEWI7pHTyfkhqcOlzghy/Tvw1CYUVqzHfVrj6C6bikXFFAN2PLSbeD0Z+imWw7N29S4Z7ly9KiMsSjlm8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591592; c=relaxed/simple;
	bh=paSRMDlNckWuA66r0WKViWnghhZr2E5Sml0Yhn2MVmA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FJ+Sgf0Qdd85zDoCCnBdCN373oCXsmT2b7eYloeaqGH2XIYSLWK9IvIFjG/nZrGgghnoWKIshjSrw0bnRKbydMk7ly7bAaA2rT6cfdMeqd9EucJ9FqzUTGGtv/P/4QYBs1Yu10WWe1l0nvvLSrSHiRVxuaeNmvV6qT55yZQLnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2eiPAPK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d6e23253so3175169e87.1;
        Mon, 08 Apr 2024 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591589; x=1713196389; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVLdz4RCZPpmOoRrLeAZgIbqKfFqmRWvMYiTDdq2jAw=;
        b=J2eiPAPK+hgXMUWxjJn2lh60J7bxKloBuB2Y6XLKm+9HAM+DW3iagAqz/nHbUPdA11
         bvehRGtq06yoQQwAlCizv04fuvzBXhhwkK7fflHMCQXMb/mPVXj0lVrN3sTmSdC0I4Um
         gfud9VfyHYv3WLdU+jk4W9wW5fB/RHwSol91Byxk30x2hFNbAIAJbC/fij+rNNgajz47
         cqFnQR14D9vqz/fFkI2iRgQyq+CP3TN7Jk1U+s4TtYiJTV9r2/E9aPTiM/oRrVJvgQAu
         3Z2j8Y4uwdGf2d50GrVHEAJoC9+tbmnkBhveO186hH06SkMAczfhkfVz/WDhDGDM94uh
         kkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591589; x=1713196389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVLdz4RCZPpmOoRrLeAZgIbqKfFqmRWvMYiTDdq2jAw=;
        b=ASBgrK9NVSG2tmFEDFy7eceW/aRmhaFh0jARiUR58pfhjSqWDwjyZMEBF7xL8/OC50
         puCsjIXvGXg1C49WDdcF4ZCZirVBWWULnwf6AyMhM6tKEX3jjAWe5xZRGPI6sMPC2xsk
         Qup+ecH8x+rNQ/nTGeFgmYcl/0YSFOTcK9S9lLlcYdxRGQ/vvDd4sCtPRBxCGgVG4DEh
         y2mByIqGNiSQKC1Ygg7NxZPelhog02Y485YIxl94qMXdhUrCkAKIEpPK1k+L0N0GTXDT
         C6ZX9LKNCV3Os40N8uAxUN/exML8d70ELXFzOop2heFnpnemKMWvMlrmtln7Xqa1ulCM
         GWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+2f1h56yW+i1D4xtOxegpxazdNz8DIlBitISSc9Z+4Wwa50ORerdmZGo69WezzHxFLKHGuJSl+tc+yJVQAc3Fs19esx0XSYSGxj27rpzvL9HalMwYCx8Jsecn93cTotNVBFWXfUf0A==
X-Gm-Message-State: AOJu0YziImzfKyT4BRiC9qYyHt+d46K7Yinxof0CUktI/1ZVFaqijkCd
	XkEMFJnGq/U7EGlH2p8zzMkFqEPHfgPJfYa2ZF2PKuhZZbRr+fbT+hkLI7RtaQ44tA==
X-Google-Smtp-Source: AGHT+IGzkzf5ZrBVW/uel17iRj5iBd72o+sCS+boDhbrVpfv/k6Y+8z0gJzljcMw4rpZZlrNTvlNDw==
X-Received: by 2002:a05:6512:48d3:b0:516:d4c2:5410 with SMTP id er19-20020a05651248d300b00516d4c25410mr6728199lfb.64.1712591589101;
        Mon, 08 Apr 2024 08:53:09 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:08 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/9] rtc: convert multiple bindings into dtschema
Date: Mon, 08 Apr 2024 17:53:00 +0200
Message-Id: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwSFGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwMz3aKS5PiUkuLkjNTcRF1jAyMLI5MUw9RkIwMloJaCotS0zAqwcdG
 xtbUADZmsIV4AAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=2339;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=paSRMDlNckWuA66r0WKViWnghhZr2E5Sml0Yhn2MVmA=;
 b=GAJVhgkJAZP0MyB/TYi4TIjAYjqRazVZe7IXvjdW4YgRzeNyvEn4Ew/bDpudVVhHq2CSqzfUY
 +sNcF1axU/XCPPo3HkltSviKDTQIXOLzo27aEU2RSX7PEaEuMfS/VOD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following bindings into dtschema, moving them
to trivial-rtc whenever possible:

- orion-rtc: trival-rtc, referenced in arm arch.
- google,goldfish-rtc: trivial-rtc, referenced in mips arch.
- lpc32xx-rtc: trival-rtc, referenced in arm arch.
- maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
- rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
- pxa-rtc: add missing properties and convert. Referenced in arm arch.
- st,spear600-rtc: trivial-rtc, referenced in arm arch.
- stmp3xxx-rtc: convert, referenced in arm arch.
- via,vt8500-rtc: trivial-rtc, referenced in arm arch.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (9):
      dt-bindings: rtc: orion-rtc: move to trivial-rtc
      dt-bindings: rtc: google,goldfish-rtc: move to trivial-rtc
      dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
      dt-bindings: rtc: maxim,ds1742: move to trivial-rtc
      dt-bindings: rtc: rtc-aspeed: move to trivial-rtc
      dt-bindings: rtc: pxa-rtc: convert to dtschema
      dt-bindings: rtc: spear-rtc: move to trivial-rtc
      dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
      dt-bindings: rtc: via,vt8500-rtc: move to trivial-rtc

 .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 45 ++++++++++++++++++++++
 .../bindings/rtc/google,goldfish-rtc.txt           | 17 --------
 .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
 .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 +++++++++++++++++++
 .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 ------
 .../devicetree/bindings/rtc/orion-rtc.txt          | 18 ---------
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 -------
 .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 -----------
 .../devicetree/bindings/rtc/spear-rtc.txt          | 15 --------
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ----------
 .../devicetree/bindings/rtc/trivial-rtc.yaml       | 18 +++++++++
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 --------
 12 files changed, 103 insertions(+), 149 deletions(-)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240406-rtc_dtschema-302824d1ec20

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


