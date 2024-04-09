Return-Path: <linux-kernel+bounces-136599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6A89D601
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311371F20FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A17FBC7;
	Tue,  9 Apr 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JBIyS//V"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411A80038
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656367; cv=none; b=sqZUgoLllUdDgGhe7fvam+Dki9b9W/r/VACyBdCy4jKvwjla1/kqld5MYDneQLpPse0K40cRl7X2zU0U8wQoONSY89lWg+m4n2SNIEZwAWn18mVxte6KOlf3uBqeWa8XuoYqqpljpA+CVNSuS/NlM6dN5CnyPOeENhtZ5wdzSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656367; c=relaxed/simple;
	bh=o46lc9Q8YdggmxxMFiuacXpzbP0DIwh3ZSk+bba9AeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMWosavzlAn133j6V6MJaWVdUCpBJ9FpDr5+5hqhD4yaV59wh10fUIlgxrdd8ZwcMdMsUjM0T4u98zkwx18SUeLol7Cpw0rpBFtsFch0zssCbYrC+GX0pLSYjpcNPbj/31Zlk/MwQuCImgm5NafcDFfD5vLGSdIY3T0Oiygpdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JBIyS//V; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so4413268b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712656365; x=1713261165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq9SUUh2shlwi+HSCpikmSF5BpTnfRa+mJbDP7CI3P4=;
        b=JBIyS//VD0l0wyGGKVDlAUpdO7bCC2fNHYqIp3BSRi/XmMQ7I0T8yADQgJkTFNd3G/
         GA+l176dzm/Hy8o9D1C9UovJBJUL58aU1HFOdR+Nvm04oG839xC2TF/g4meTkhVn0WIu
         kaxceuzlJmsfghpDEfHbNYxnE3w3ZEEpH9/n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656365; x=1713261165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq9SUUh2shlwi+HSCpikmSF5BpTnfRa+mJbDP7CI3P4=;
        b=SsHJTdQR/lDP/NHdv47B9PSL8IobhRKCtjsWRLLHhcljpsnuvmOyy0AZuAUdyv6M89
         Glmct0U8H9nn/S/U5m7YBCmorqz2MKq3+iX5CyjOtqKBXB5mEDM4HmvROX1u+5L19tNP
         17ZCPVY8OYtJKn2W8JLnnx7KcwLJhc4u+KVcM8WQhcfzkf7WAhGdsZU+kLvHsGQ/x8ga
         Vlj5TZUmRPG/bCwNEW95lzCpJIbA3eGpO2rifbXfu1oOu64vsZsBZcPudOYG2GJJ2XuN
         OKcmowkYobYIx6iV2YG8R7xEdGXya13gN9d/dWRxKvDiABY4j0Z2EDAQXQmW4Jg36xz3
         exjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw5njVPgHqPnH3i6pJzJMpDB9X2bzs6pOosHZbvyJ3qg44zy7o/xs9FGK9HHyoqyWiij8BaKau7YLj3723CXxqWkfAegHpxkCFT0RH
X-Gm-Message-State: AOJu0YzGoEQbgKKSIkMhVnhiWz/IKhWYprVqeu1Ll41HWAC4TIIKWQnQ
	K4ZE3pTChr05V70yYWf+NAY+H8IAEcX2a40i53+Urm8x0myrv002ovgNAPB78rzlRnpKs0Pi1BQ
	=
X-Google-Smtp-Source: AGHT+IHTIYMFgIsIpfetDHfBOIWNBd2HP00jBw0bY4nV4zUEdvlm/8j6ySitJ5LHkNkBYsJJiw13jw==
X-Received: by 2002:a05:6a00:1782:b0:6ed:6b11:4076 with SMTP id s2-20020a056a00178200b006ed6b114076mr3371667pfg.12.1712656365506;
        Tue, 09 Apr 2024 02:52:45 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:cf76:4647:8bd3:d341])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b006ead792b6f2sm7931509pfo.1.2024.04.09.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:52:45 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dianders@chromium.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC] arm64: dts: mediatek: mt8183-kodama: Split into base and overlays
Date: Tue,  9 Apr 2024 17:52:38 +0800
Message-ID: <20240409095239.627000-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the SKUs of Kodama share much of their .dts, as evident of the
inclusion of a common .dtsi file. However this scheme builds each
dtb file as a complete device tree.

To deduplicate this, make the common .dtsi file a .dts file, and the
SKU specific .dts files into .dtso overlay source files. Have the build
system assemble the SKU specific .dtb files from these components.

The final composite .dtb files increase in size by around 54 kB, or 22.5%,
due to the inclusion of symbols and fixup tables, and extra phandle
properties. This could be slightly reduced by dropping the symbol and
fixup tables after the overlays are fully applied if desired.

However if the bootloader can assemble the end .dtb using the base .dtb
and overlays, and only those are counted, then the combined size
decreases by around 165 kB, or 68.7%.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Hi,

This is part of the work I'm looking into and will present at EOSS 2024
in Seattle [1].

The idea is to reorganize device trees so that devices within a common
family, instead of having a common .dtsi file, will share a base DTB
and apply one or more overlays on top. This allows an upstream [2] or
downstream [3] bundling script to be able to deduplicate the base DTB
and get some space savings, however minor they are compared to the
kernel binary executable.

This patch gives a simple conversion, but we could even look into
converting the entire MT8183 Kukui family, which are all based on the
"Kukui" hardware reference design.

There are some issues, hence the RFC:

1. The base .dtb doesn't have a valid board compatible string sequence
   yet. Suppose we used the sequence

     "google,kodama", "mediatek,mt8183"

   for the base .dtb in this conversion, would that be acceptable? The
   base .dtb would act like a fallback.

2. The composite .dtb files grow in size substantially, due to the base
   .dtb file being built with overlay support. The symbols and fixup
   tables could be trimmed out with `fdtput`, but there will still be
   extra phandles, and also nodes with /omit-if-no-ref/ that would
   have been removed.
   For this I could maybe come up with a program to minify the DTB. That
   would also work for existing composite .dtb files in-tree.

3. Such a scheme would require more awareness on the maintainer's part,
   and of the .dtbo authors. The maintainer needs to be aware of how
   the composite .dtb files are assembled. The authors need to know that
   certain constructs, such as /delete-property/ or /delete-node/, won't
   work.

[1] https://eoss24.sched.com/event/1aBGe/second-source-component-probing-on-device-tree-platforms-chen-yu-tsai-google-llc
[2] https://lore.kernel.org/linux-arm-kernel/20240329032836.141899-1-sjg@chromium.org/
[3] https://crrev.com/c/5412876

 arch/arm64/boot/dts/mediatek/Makefile                       | 6 ++++++
 ...ukui-kodama-sku16.dts => mt8183-kukui-kodama-sku16.dtso} | 4 ++--
 ...ui-kodama-sku272.dts => mt8183-kukui-kodama-sku272.dtso} | 4 ++--
 ...ui-kodama-sku288.dts => mt8183-kukui-kodama-sku288.dtso} | 4 ++--
 ...ukui-kodama-sku32.dts => mt8183-kukui-kodama-sku32.dtso} | 4 ++--
 .../{mt8183-kukui-kodama.dtsi => mt8183-kukui-kodama.dts}   | 0
 6 files changed, 14 insertions(+), 8 deletions(-)
 rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku16.dts => mt8183-kukui-kodama-sku16.dtso} (90%)
 rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku272.dts => mt8183-kukui-kodama-sku272.dtso} (90%)
 rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku288.dts => mt8183-kukui-kodama-sku288.dtso} (90%)
 rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama-sku32.dts => mt8183-kukui-kodama-sku32.dtso} (90%)
 rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-kodama.dtsi => mt8183-kukui-kodama.dts} (100%)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 9234dadfe1ad..6986d7a2efaa 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -46,6 +46,12 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu-sku22.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku38.dtb
+
+mt8183-kukui-kodama-sku16-dtbs := mt8183-kukui-kodama.dtb mt8183-kukui-kodama-sku16.dtbo
+mt8183-kukui-kodama-sku272-dtbs := mt8183-kukui-kodama.dtb mt8183-kukui-kodama-sku272.dtbo
+mt8183-kukui-kodama-sku288-dtbs := mt8183-kukui-kodama.dtb mt8183-kukui-kodama-sku288.dtbo
+mt8183-kukui-kodama-sku32-dtbs := mt8183-kukui-kodama.dtb mt8183-kukui-kodama-sku32.dtbo
+
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtso
similarity index 90%
rename from arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts
rename to arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtso
index 7213cdcca612..20675de68823 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtso
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-#include "mt8183-kukui-kodama.dtsi"
+/plugin/;
 
-/ {
+&{/} {
 	model = "MediaTek kodama sku16 board";
 	chassis-type = "tablet";
 	compatible = "google,kodama-sku16", "google,kodama", "mediatek,mt8183";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtso
similarity index 90%
rename from arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts
rename to arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtso
index bbf0cd1aa66d..46ab97a18003 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtso
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-#include "mt8183-kukui-kodama.dtsi"
+/plugin/;
 
-/ {
+&{/} {
 	model = "MediaTek kodama sku272 board";
 	chassis-type = "tablet";
 	compatible = "google,kodama-sku272", "google,kodama", "mediatek,mt8183";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtso
similarity index 90%
rename from arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts
rename to arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtso
index a429ffeac3bd..e27b56f1826d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtso
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-#include "mt8183-kukui-kodama.dtsi"
+/plugin/;
 
-/ {
+&{/} {
 	model = "MediaTek kodama sku288 board";
 	chassis-type = "tablet";
 	compatible = "google,kodama-sku288", "google,kodama", "mediatek,mt8183";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtso
similarity index 90%
rename from arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts
rename to arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtso
index 5a416143b4a0..d9a13ff7abf2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtso
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-#include "mt8183-kukui-kodama.dtsi"
+/plugin/;
 
-/ {
+&{/} {
 	model = "MediaTek kodama sku32 board";
 	chassis-type = "tablet";
 	compatible = "google,kodama-sku32", "google,kodama", "mediatek,mt8183";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dts
similarity index 100%
rename from arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
rename to arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dts
-- 
2.44.0.478.gd926399ef9-goog


