Return-Path: <linux-kernel+bounces-56545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA884CB76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAC31C24CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2079DB8;
	Wed,  7 Feb 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYl/gimL"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA47E571;
	Wed,  7 Feb 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312158; cv=none; b=nmRmOGEDwLFZC/WIYZ0h7baGIjqyIl9/90XyGFuygb3q+a6EQQxU/XP0FCeUi54aUM2cDJBn5INV7xdr8jo6Nu6WrMuFnAU0ADYDTQglEt5vgAfpcmzm7/F4KL0OLlqUbyjzciMFzWT9MS+Q2fB4UG/g0NF1rOTeDlG2cI68MC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312158; c=relaxed/simple;
	bh=lp2EuxvbdjktSjgXoQYRe6g36+FmIO4Tk9k172WgeII=;
	h=From:To:Cc:Subject:Date:Message-Id; b=b8NIjON8CEtHGZTJFDPRrrFy07Ui62jsquawWlJgCkDXXlbRDeHnQ4QE7DSMK5kqrTadQbv848eFaI++0mthhSROuvKJND7j+kK+1oNWf+wfNmgPYnibFJlNEoFpErPOFuAUKYmppokkpaozGaNpXOrygmMLrlRFxFDCO3cRs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYl/gimL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3864258438so125394066b.0;
        Wed, 07 Feb 2024 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707312154; x=1707916954; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btAz24IgCKzwrdNvEUaIqqAv+WGdf0h9y7BxoNQKWVc=;
        b=eYl/gimLL06NmTIZ2LtVX3BCBKh+qD9EM2cK15WeYvB2vK9eEFhuS+eV6cvnWHvyIz
         +uL+IuP+JmDttXk1qnVphJ+TWa5Z3chCia4x07KFF+j2XkaVjCnoApDlZ/MxX5flX0SJ
         pE3GyspJN1h7oDtRnU8bQu7b25xGbiF6D7i3ylAgV2k5F648kMSQSi074QsdgajQjPFQ
         e/v5KCwYT/3au7OGQq3k5fa5dEU8tu+mXRH23knTku9c7R64snYWx8KWJPVWAf5L3roJ
         eb2R0/R1k3PxFlNrOAnlwcabU8l1+LLxVL+BkqMJHbSo+yj85cseIwyAo44LiledpROQ
         27Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312154; x=1707916954;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btAz24IgCKzwrdNvEUaIqqAv+WGdf0h9y7BxoNQKWVc=;
        b=o+O+F4770SplQTI4GHDwkQifpIKkeCw6Xvfwj0NruZ1avoxxXiuMkkKxsokT7/hkvS
         IC2n4Yeic1zqdFyVzub4I/oEFF7kB+VnCu/5/o8Tpuyd64hLJceND160zZGuGYbtBbd6
         MyR1Cg9NngZx1nTVmNn08WoOMEOz6m9BH2Zbf6Eunw3IXBATAazR53qEh71gepDMBBZg
         ZPL822lgwvdcgeMthz6PSPG4Rp61CwljsCNyxCWOw85XKKrqDhgFPjxi61kqoIPvOqvZ
         fVQZYplhS9zfwYtvxpHvZR9s8q4t5cprYizfTSuHdyGLa09TGIBCdKJ+54kNy8I+62Mk
         S3Xg==
X-Gm-Message-State: AOJu0YzKu/LlUOscE8tDXDH55V/01qpSjfIzhB3UQWWemcYaaOFbOsCA
	ufSTDnl9DoELG91c7lXKTWMZEN0/32mpBDYD7kgCXvudoPBvfKwqm1sIHe1C
X-Google-Smtp-Source: AGHT+IE9bPVZK04UV+tm9WxRbdfPetniu/nC04eKXIaiiybNhHN9HXBwQ0KgpUds9btFyHEoFTfDSA==
X-Received: by 2002:a17:906:185:b0:a38:757:fee with SMTP id 5-20020a170906018500b00a3807570feemr6011595ejb.8.1707312154395;
        Wed, 07 Feb 2024 05:22:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEA2ocgoqDIFCWEXQDSQX8pgVyYCYjVsTdCMkVU7XfRMtcWNQhFE75VvhLIaT3uwsk5lHOpItKRF7PxRvr9C0tesHs0Qr6WkiTUoQvsabEpSQK5pypqWEskE1CpmRxvYMe6MUgCG5fm66ufb5zoYL7fylhVRn7ryQJvh8vk0hwwml3VWw6fboHrVjuiX/1USsOW83GekxpM6wpi0gLoqqcqKPdTu1wiTFo3KE1RS3+kLSI6zgbWJ42xJxyBQBGB1hmEf2DsTC/fpaCfGbAqvMT3trPDgeXbNqnl3IrZuIq6HTIsMDQYmrcwvgwdXsg
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81be:a476:88e2:db23])
        by smtp.gmail.com with ESMTPSA id gq13-20020a170906e24d00b00a37116e2885sm758649ejb.84.2024.02.07.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:22:33 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Andrei Simion <andrei.simion@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair entry for MICROCHIP MCP16502 PMIC DRIVER
Date: Wed,  7 Feb 2024 14:22:31 +0100
Message-Id: <20240207132231.16392-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 64db3e8d7be0 ("regulator: dt-bindings: microchip,mcp16502: convert
to YAML") converts mcp16502-regulator.txt to microchip,mcp16502.yaml, but
misses to adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in MICROCHIP MCP16502 PMIC DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mark, please pick this minor clean-up patch on top of the commit above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb234d11f21e..e5087e4659f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14415,7 +14415,7 @@ MICROCHIP MCP16502 PMIC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
+F:	Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
 F:	drivers/regulator/mcp16502.c
 
 MICROCHIP MCP3564 ADC DRIVER
-- 
2.17.1


