Return-Path: <linux-kernel+bounces-111015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DD38866F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACAF1C2371C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171FA1B5BB;
	Fri, 22 Mar 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3H7ZnqK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC0199AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089751; cv=none; b=jTjUWMxc62fy5aXwSOrIpaa5dYcg2DC81mfm460N83/SDLrrNM04IuH6vlHjtm9FzfATi27C7DWI1F9IB2WOokJxAN1rEcUbVbjJPgrQjHD/Aa/9QuaIe7KOGn54G/hI/J2MpNHt0zdhYf5O47us4emgskiIlQ4cHYgRW1YKq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089751; c=relaxed/simple;
	bh=9bdjqCAyvS7k1BS7Lhjz19NNuYfcjp2pCZWc4hg6CHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3WqpWEbwRcxqNfHCAizQVjv4OJTqWJnfRQDZ/pXpyeGdiXOa3EwtxWd/xd+cJCiTIOCz54lU1RCQS0fPufI2ahepDx9uzsHIc4UlSK5uZ9lsRACYjEFc8HB0hTPIpnzxE5R73zkAxDfXyZTm5BO5q7ZoDslAQM76tGe3TTKK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n3H7ZnqK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso2110793a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711089748; x=1711694548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BmaPEfXpnyUWO4tk/lYu9wRilg7S6pQ6tbGno3QPjdk=;
        b=n3H7ZnqKKHlBSYPu7tTeNj2R3K7tdVZRPhdMA1+H1J+2f+e7QsLbbQZLgJRhIaqDva
         ZSvORsxZfDBoDTk985oitAkBzRHet+ZU9Afqssft8uwEOeg+QhjaSlmGd2q4aRgfUjdX
         5JLIImnVX8SQt6VktVR1DSpjeJDMoiD4H/reFsufUCG2efKN8rCMKhQtEqfS+Oa8II8n
         aM67M5RAjxlB7rXDZodXReKUGHATxarpSiK7WuByfmgx+ShHDVWVSfNB/OovY0NwGP4A
         RG3jsvVV8FAXdj0sQ2X6VVaZ546RpA/E3AQ05WBsZjd4J8ZsiWiOqHwEo0PFwx4XjfQG
         wgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089748; x=1711694548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmaPEfXpnyUWO4tk/lYu9wRilg7S6pQ6tbGno3QPjdk=;
        b=GBTPq65BG4YVuOkQbJR68CfpVauxcogKB8oUrX3wRHtCaEIvrxPsqRdIhCtl+gUC/X
         F/b4aK3D9ywz9TInpnkw77eryocla2Qkk1akRgf1bcCXjz5MLKbFUlj89F1NB46yIVwb
         9IRjheXGqLXz8kDJ1W/VXSYfIl80Fpf+Vq20GIWmypAU4PlBxREwjiLLN3V9yKCNX+1y
         ZyEW/y4wEKc2137DiuZ15uNBCru/opP+/i8JMLzAQrzlXFaGMfz2gkq3NUcOcV75x5aZ
         qSOQEteim+NBKEpFUn2xfM/WJH2zcp3seHIna2m3vIwgvYkBkFfiZwFNM0BKqnub7NLn
         IleA==
X-Forwarded-Encrypted: i=1; AJvYcCV9n0OgndugtX6Q9sLbJbO47283vkiAkUwlhIOhR6InrR8OjPcdjilH77Ptm+TyJa6qEOt/zidbOCwBreMo0yiJGeSoMlSaWoTe1mYk
X-Gm-Message-State: AOJu0YwtUN+2aHuPVPdm/8cJQcrqHiNnIb0IDjcrc2Oaf8I0E5maWgow
	fqtaoZjY35ShhAA3kFa1qQdBRxxlDTxRV92XBnOxRz3XbctaurojF5T/r+Dit6E=
X-Google-Smtp-Source: AGHT+IFjCUgRktXwrv+Lvi6UwcbsFwpnpkk/JBK3O3IuUm86QVwXhrso59zXtrI/2Z72EZMRI6ku9A==
X-Received: by 2002:a50:d559:0:b0:567:a318:ac0b with SMTP id f25-20020a50d559000000b00567a318ac0bmr916782edj.16.1711089747857;
        Thu, 21 Mar 2024 23:42:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id p8-20020a05640243c800b0056bdc4a5cd6sm645506edc.62.2024.03.21.23.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:42:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] sh: j2: drop incorrect SPI controller max frequency property
Date: Fri, 22 Mar 2024 07:42:21 +0100
Message-Id: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The J2 SPI controller bindings never allowed spi-max-frequency property
in the controller node.  Neither old spi-bus.txt bindings, nor new DT
schema allows it.  Linux driver does not parse that property from
controller node, thus drop it from DTS as incorrect hardware
description.  The SPI child device has already the same property with
the same value, so functionality should not be affected.

Cc: Kousik Sanagavarapu <five231003@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/sh/boot/dts/j2_mimas_v2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
index fa9562f78d53..faf884f53804 100644
--- a/arch/sh/boot/dts/j2_mimas_v2.dts
+++ b/arch/sh/boot/dts/j2_mimas_v2.dts
@@ -71,8 +71,6 @@ spi0: spi@40 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			spi-max-frequency = <25000000>;
-
 			reg = <0x40 0x8>;
 
 			sdcard@0 {
-- 
2.34.1


