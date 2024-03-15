Return-Path: <linux-kernel+bounces-104319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB987CC23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA0A1C21165
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5E1BC37;
	Fri, 15 Mar 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M/U4GsmF"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65751B809
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501393; cv=none; b=ZC0HpSanxMOo1Ez3K0WUT6IFCBqvzpZiwzxFsVk8R0T/0Q9HpBZUTwNLRKFMNTEgT8gXMLpCHT9jXri5+PXiiqj9AlA2cITl47KYSj0aBr0prIr5BzlRMlkqAx4TRiybFrwnLFRFmLexXqQnkm5ifowtMhDbP98ZFlD2FfQm4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501393; c=relaxed/simple;
	bh=gWbyXJV1WU2fllqx2n7uBZgIHfZzTQJ1nDc/naFaxpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LojbaAsv+6PqdBcmPofSBi70tgz0kXBugmVZX9MTQ6bcU3jRLKeXzRZ+WBFvCVgK9/xRipVVcf2lQ/8QjtcQWM13qVi7ZlEXya4Zm7ObTpd/N4a2QRbEqmggbxRucMbEpSGtsVzgBDZD4jtzQ6sJbNncCHMCFGmq+QT7xdf738Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M/U4GsmF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b5831bc8so1964694b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710501391; x=1711106191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEdbatcTx+BMxUcwyJodaDR0wXY8zMTqnjTsuA4PhA8=;
        b=M/U4GsmF9y2oYkkVCC3tk2D9iT7DqzkK0gQ/Bubm8JNXxIBOZRYrZhrVNUGrAI1/cb
         09AOrCAaYUZtWg8Jg4N0j+YrhXbE13dnaieOJLO9kPZT6JvDLinKpKbTm+7IvKWDB7Kp
         x0yqxXTPpeAhB51NKhB7jP1JklA1BbBERRyH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501391; x=1711106191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEdbatcTx+BMxUcwyJodaDR0wXY8zMTqnjTsuA4PhA8=;
        b=dxonyZSjNmcrMPToG3QhpEKfg7pejgT+xj2b0VkLlR+dTV7UxOXipdYgneZW8tliiR
         4kE292uwzr3yj1DvyiukZciYetuvjr1u75UOpau+1vi8JxAAW95y/BBJfoO8dZsr3bHU
         1tdvI1rfOvurH0qzYFW518I+CXIpclF3+YE00anGpiNoEGipjTPhZRw92iif/tIRN6f3
         4lVGAQt7+e2dS3XdiwbgTcMWfttN8RmuHuuzcWAUvCCMqR1/E7b4sK+pMqmGVfSwjERF
         g+nyXjmunazStJInM+I3tH0agygrCXGmhxPg2pqS5Lu0rdxp8nv3744f/LRTvNEkyrGN
         2kuw==
X-Forwarded-Encrypted: i=1; AJvYcCXIlXNMGyI8krG17sqaGLuWZfhMpOtx8sv+wdxnt5yuspiEgZfWHrUMK1Nrx2Rpo359wmwngeJJPXwpQp0RUIRkNDB/orXyw4hn04IT
X-Gm-Message-State: AOJu0YyiaeFmP67FTRrQg2SFJ1eIsT+GrsHSjHY9gwD5cG0kwAPVM86M
	pcLCoElhNjPnPc9yDBBLLxu7SPHTv4ZQkkcu31WYzaLwGT17sO/lhQuB7zJrhV6S6POhlBjTpJw
	=
X-Google-Smtp-Source: AGHT+IHuQe/cYmMUFny33NXapxQXc5X930DvksjS95oNx3L58qkOtWxPwKplUrudaUT4vxUuMbsZMw==
X-Received: by 2002:a05:6a20:8f24:b0:1a3:502d:bea with SMTP id b36-20020a056a208f2400b001a3502d0beamr975715pzk.14.1710501391194;
        Fri, 15 Mar 2024 04:16:31 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:2f9c:c00a:bf1f:e53c])
        by smtp.gmail.com with ESMTPSA id c11-20020a62e80b000000b006e6aee6807dsm3122683pfi.22.2024.03.15.04.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:16:31 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 2/4] arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for MT6315
Date: Fri, 15 Mar 2024 19:16:03 +0800
Message-ID: <20240315111621.2263159-3-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240315111621.2263159-1-treapking@chromium.org>
References: <20240315111621.2263159-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the minimum voltage from 300000 uV to 400000 uV so it matches
the MT6315 datasheet.

Also update the minimum voltage for Vgpu regulator from 625000 uV to
400000 uV because the requested voltage could be lower than the minimum
voltage on the GPU OPP table when the MTK Smart Voltage Scaling (SVS)
driver is enabled.

Fixes: 260c04d425eb ("arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v2:
- New in v2

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index f94c07f8b933..c0223f84b45b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1214,7 +1214,7 @@ regulators {
 			mt6315_6_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
-				regulator-min-microvolt = <300000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-ramp-delay = <6250>;
@@ -1232,7 +1232,7 @@ regulators {
 			mt6315_7_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
-				regulator-min-microvolt = <625000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-ramp-delay = <6250>;
-- 
2.44.0.291.gc1ea87d7ee-goog


