Return-Path: <linux-kernel+bounces-39777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988F83D5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874B8B289A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DD1272D6;
	Fri, 26 Jan 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3Ru2Jnz"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EE1272B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258315; cv=none; b=C5xz7ie4/+FmTFi8iTU01arjSd3Ha5cGJyD03wsr/51heBYOFGCR7x/2rZOIbezJpn69FVJj/veMQLxGpGpNHVK74Qtbgrz55s/u6G9mVVJIg5Cj7Ny3mVEHFxiyjsXkIIwrccyI1er+63OqPKe7+CGaPK3sZ9GpfCKHYpjq1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258315; c=relaxed/simple;
	bh=x2DbBYkompYyuRsF27/9gUNszXCgrFgFo1XSXuu+RFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTDKCt/4Zo0xc1CVrEWBeuAkwFRz5sUjqXK4QDp5mRqVrAwlZYQOL7tbRScYjKf+yVVTnOcQKYjee8S4OVsDVgb+Zfm8k9xrSyrLMq7jFUCERPKYBhphzjn125WFaPTRrpLrLDBzrOyAIfzboxJyUvT/odnKGeH/S73vmEnY+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J3Ru2Jnz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d720c7fc04so688355ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706258313; x=1706863113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuVCFtuO0yf5CMGsIkM1BwRpROvgF5wfnsTa+xBxY70=;
        b=J3Ru2Jnz+gSJIzgMfTZKj9nE2YTV7ZxfcZ+ds5ngPKzSiS4kb1uZkzfdC4QAjxbR8C
         7CNmqEy6RrvUM5VmYvpBnZAgWngwNBGJVAzGkAVxahxsqyIU9PUAogpaas2zpfkdcr3b
         iMj9rxR1lu4oa4oHkwc1Rm0V9DthoDfDlj6ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258313; x=1706863113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuVCFtuO0yf5CMGsIkM1BwRpROvgF5wfnsTa+xBxY70=;
        b=BC5vpjUXjcgMdymN1mKcwUsNctUHjy5fpwMsJDYLDdxnqgbQB/DQW0R/391WZDSVAg
         YUh7RT22PCyCnZzAcrN+/kNmGZ7QWrkKa+Pc8M0VBQrfDYv4gCcW6vCiliP088wh4Mbo
         DfgRs1sQ5Ilh3aVHFYddIUKobLCKm6bGVFedkFeIuzt2dsDopDM+5ZCWFm0ElQIjqJPc
         jHtFnXtFkkhA0dcSNhun9P+HqnFLZuoD+ob91gqtNQ19IgwoZg5KgalBhTB3yNaTeVjj
         0e02evG1JBfhMjsvTzH+aPAQQhjh14IUJ1twpOX8opscQqK/nfvTX2Tgop5EFxiNYPPD
         z0YA==
X-Gm-Message-State: AOJu0YzcskWRNl2XaK0qN8Ip9eJL2GGSnPYbbs39AxGg62TPmQMItD1E
	4uhwBr0KFra0D4oVD84QurQF+eAZJHj1M+RzodkoKmWq4I6sGQAiEj9qFIsOtw==
X-Google-Smtp-Source: AGHT+IHSrPFiqGFADJBK++rSPTXc06dRJ9o2+Xh7a7ojGdGkkH+Y1KunO8QhaDk4aD58k+tm0JVFMw==
X-Received: by 2002:a17:903:546:b0:1d5:13b0:cf19 with SMTP id jo6-20020a170903054600b001d513b0cf19mr782904plb.63.1706258313640;
        Fri, 26 Jan 2024 00:38:33 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b001d6ff1795aesm589529plr.8.2024.01.26.00.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:38:33 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 8/9] arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
Date: Fri, 26 Jan 2024 16:37:57 +0800
Message-ID: <20240126083802.2728610-9-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126083802.2728610-1-wenst@chromium.org>
References: <20240126083802.2728610-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT8186 Rusty, otherwise known as the Lenovo 100e Chromebook Gen 4, is an
MT8186 based laptop. It is based on the "Steelix" design. Being a laptop
instead of a convertible device, there is no touchscreen or stylus.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes since v4:
none

Changes since v3:
- Collected reviewed-by from Angelo

Changes since v2:
- Picked up Conor's ack

Changes since v1:
- Reorder SKU numbers in descending order.
- Mark missing components as disabled instead of deleting the node
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mt8186-corsola-rusty-sku196608.dts        | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 0daa1ad27c22..48327471de12 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts
new file mode 100644
index 000000000000..731b0d60228d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Rusty board";
+	compatible = "google,steelix-sku196609", "google,steelix-sku196608",
+		     "google,steelix", "mediatek,mt8186";
+	chassis-type = "laptop";
+};
+
+&gpio_keys {
+	status = "disabled";
+};
+
+&i2c1 {
+	status = "disabled";
+};
+
+&touchscreen {
+	status = "disabled";
+};
-- 
2.43.0.429.g432eaa2c6b-goog


