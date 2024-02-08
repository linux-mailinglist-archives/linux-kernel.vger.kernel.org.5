Return-Path: <linux-kernel+bounces-57904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69284DEDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B605B28C94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD87745DE;
	Thu,  8 Feb 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAjQPuSc"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B676C82
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389581; cv=none; b=sZRdJbgrbiY8U46yJnZNkaq5viuwxYUrjOMONVqU32Xogi/2GCFSCBD7Qa4AajHwgEp4ZKMfkfMf0R0TPMieAkxdAXStpf4UpwkK4IBhQgDA5bPr15TJGyLD49jQfVN9jB0LV0xgfLJZIVhpdg8+b7mYQxObDGdgKZAqaK4aWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389581; c=relaxed/simple;
	bh=T9crF1U/3CuH8rMm1LvPJXw7rjGDtv8nusQ5iZVBmgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o27GhvkULYFXhSQDTz35OCOMHfsRrSU+PIgL/4BcIQIc/dHczd78X7xaoNPUfnygFeoT+wnreo6FwwyKjneF4QGTL3WkPddsITHf6AtTvDLO+p9rNQ/h4hGjk6Rtmy9mozOrQACRAj6WGY5fr4wJg28E6eN/S63a0blPuXapOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAjQPuSc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116930e92cso2004892e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389576; x=1707994376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwcF05L+fXBiJV1GpPE6xGgwy1t7z4SIG9mmsA+zggw=;
        b=OAjQPuScX0HHaUU/p/Goo9RIY4Qdbf6WCVuIULj0UrKv/nkfqbWN+nf1pmZm2TMSCy
         ca+v9cWxoBUQ6OGRiocrgYKwy6LyTmq5rRe+NAO0aa+bBMFTdZWFM20lRrSqhDpO/C5+
         kFEPy27MXjm1kZ082BdZMj8EdzylCukTEbCn4TO1LMYXO3zxEhAsMxuEatO4xO4hklA7
         AoSzqlkKJvKMTieaMgUSXE89YexFMqb/9gci2sfTvmcVOg/OEc54Ec5hC5zBmBupm5PI
         9Xs7V5jJrn/3eXEGhPqgMr0/FJDFcA9IeZYUim3d/vYweE2fuI03rzkQIKJDdiDNRv0A
         s8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389576; x=1707994376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwcF05L+fXBiJV1GpPE6xGgwy1t7z4SIG9mmsA+zggw=;
        b=NYgFl3BL0yU1Qi6V4DwfTBY+k915Ofi0p7pEF9wV3ognnV4IZf2Caj/BJdJZbki172
         Kbg4XFAiZMAwzD6EUkylhWnU/AyH7vBxnZAIdda2z68WVFcCFtlJ3jcpI06Y4WUuqJ0x
         E210loAXZJxbLsyJ+DyyB1MdxVkj+xsNlCl5HUeUODRPoWrZfxWpMCgV8po+aGak2Ha6
         pYqvvHdYNCEdVxd/XYNYDRMKFHneYzIZzbQ0Ynvd3wqAQcmsX5mjHYrhh49ILCCkaFqU
         1ruv3mc4UOy74Tm1DyRmaEnbjYwSEyJJw4ZvuXEEk9YlXxox7vNoT8Pwcu+Zy4NcGSRB
         wnwg==
X-Gm-Message-State: AOJu0Yykb+Lb+qAhlkmF2HR9D62r7yLnSe04zUzf4VoYy4mwqzySONh/
	KgRtUwmAKQ/3aLK8mNBaAz2TuV3KRIAGhgvQswJhXsxqAJ/f6HCSf1JKuyjWz/g=
X-Google-Smtp-Source: AGHT+IF7SoBpfJLUAQTlCDbQmMFs3tDOLUeO3epZth2CubWuvqQRNpyFU+S1j57S0lq1m4dhfkdHQw==
X-Received: by 2002:a05:6512:3241:b0:511:5ac2:eea1 with SMTP id c1-20020a056512324100b005115ac2eea1mr5543383lfr.41.1707389575875;
        Thu, 08 Feb 2024 02:52:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYggYozqIHxub/rHyLV7NoI/RNeHx5NrdQkQ5lFEdug9JLFt3K6AdyVejBBLUbHLJ8CEluIIHVwMQLebhRE9VIRfzADdvqiRanQ6QEBlUoLKcfrgWQLd8xNcSWdnRt30DDULqnDfAQzEeLve0VOG2FeTBvujVzN8JypBRN/a6rHKhN7KzhjiYF+vRmzvhyTgiJrn0/FmUeg7KHTSBtNq8XmHe8qf7PTl3/zBYvzPKkgfWo87QM7w7uLeNIPKxhEqN3KqLYUZHerlqUsJlHUBQyUMdlc/KSwZkuUjggT/T8CyRH25wKXTCS72282niDgny/8Q+XBGO6xfbPkEDqvDZS/O8yCSI1CUbAyKRsAmdpzMWvlSEEY7I8ruWkGG2jAGvnjStZqtuq
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c204400b0040fa661ee82sm1214991wmg.44.2024.02.08.02.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:52:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: amlogic: t7: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:52:52 +0100
Message-Id: <20240208105252.128940-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{'
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index a03c7667d2b6..ad1cac42e9d8 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -54,7 +54,7 @@ cpu100: cpu@100 {
 			enable-method = "psci";
 		};
 
-		cpu101: cpu@101{
+		cpu101: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x101>;
-- 
2.34.1


