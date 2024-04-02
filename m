Return-Path: <linux-kernel+bounces-128587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46777895CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AF8282B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAC15CD72;
	Tue,  2 Apr 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUgKvhEC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4D15CD59;
	Tue,  2 Apr 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086556; cv=none; b=UEG8xzN0uSxor/6yJ4OApB2ffN6OSA2x5b7qrFbaAlOuLyiGQ4TMqCKsFaZrITjLPhWMtzfO6FOg9qAqRjWgnwV/IlQpsgqw/VXtuYIJxWQ5OCDJjpjVQSVbAn990K9TJh5CFO8Em1PGEin6Go4cQrPlC/y8D8tQIbuEnJ/wRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086556; c=relaxed/simple;
	bh=0RvejRjIJPduOyyCTlLj3EvG2tcNMQT1bKnp5UWuaPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzaUxJrSKIWE1Ib99yXz2RRf9RXTHDQdvQsFSoNknHTwp7+vlACByQKg/ziS7pvmu8LSFryHGyHjX04FvrpliGQMvuEw/8iWQ3JCyCx5y/nbDoBpPIXoktqXmJzS60Jyos4HPRGZAUzb3t6bwga1F00RADA1FuGNDxpAsPSli5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUgKvhEC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1def89f0cfdso1815465ad.0;
        Tue, 02 Apr 2024 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086555; x=1712691355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHKgofjtLfTWJ/FAwhBqVxJWAROfQE6XjH/ZqxNReeE=;
        b=UUgKvhECi4OqI3kJJXOQCW+7SoIUbCnYgUEUxUwQ/GeUrTp/xG6+Dks3UNHOmQIY/o
         6sBVmxfsdIkRrI1KEH0z6sfbTePGWduWQ4a9Tf1g5yr5ICUTi0VjVDaFjRoSD0Db48Gy
         GExjoTN6k9+9YeWWseOYKjTwILbK+7K9QSk7nRwJnatV70Z85tpBPwq+2hKAui5Otcgw
         D8/tsAAvfapqtyLwp1l+L+QF2TyBCo4ZhRBYHxrRvpM/Q/QSgCg84tf/ZR6nf9VvuhS+
         4+XnFsyqOa1BamBMKdIhSjYIQYOP3cMriNqhzLnw/YfL/3/DcRcaM2iDg5zJTJtpaG6C
         vm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086555; x=1712691355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHKgofjtLfTWJ/FAwhBqVxJWAROfQE6XjH/ZqxNReeE=;
        b=iT6t4rJmf0AXR6HXqV2pQSNgyHZ0i0IrkDS8LU6VB3DrM18xk7ti5uaDCiVIdVtL5R
         GbgyTlNfkU6aJh1d+JIPCeYrWG41T/s+h11li6nxZUkCxIhvoPt8JyvsGEhWLqVhjS9Z
         aokYy/l/TFMtP4JCSh/fEglDbcJq+kktCtWVhVFrpvRtVDTmiLp4cWrJA5ryw1YazZ81
         F9BVt6mlXgG3o/ZDCowe2qpV4r1WXkGnihXD3TxAHIQHj9NZtFbs4F52g6nBVYxXVJ7p
         kBR+hsz9bIqT/dsLS1s2URC8J/Mo2zulqcyyWP7bMguh+joozfUA3UrZA99TJqX7Ygw6
         XlUg==
X-Forwarded-Encrypted: i=1; AJvYcCWEqAnJyKIg9gYrLjmL0aRPOTGewbOVZVBNzOIP7dwFey2EnbHe4GQrzm5E61QOVTq+EOBIWV3M19SjcbNNCfXM9yWEY7G3tfAtGR0lkmfo12CobkvMvl7gTq/Po/zpZ9iQwVYqnbg0Rg==
X-Gm-Message-State: AOJu0YwhuuWsAovIzt1dqz5nO/afFFMbCktJv3uFyAFzAus3tIL4+eZx
	VLTZ/KTz9iK7DRB7EQcF5i0dZ13wqm0vBNPycAFxZf25l4pQFbRO
X-Google-Smtp-Source: AGHT+IFo4t051oCixR4x2puMKN9+F3XA0BHfQTTOfa7GG3oxo+qvOGVEAXWPPM1McWQQCcoNyHTzLQ==
X-Received: by 2002:a17:902:f54c:b0:1e2:76ad:caa with SMTP id h12-20020a170902f54c00b001e276ad0caamr580629plf.22.1712086554826;
        Tue, 02 Apr 2024 12:35:54 -0700 (PDT)
Received: from frhdebian.. ([2804:14d:8084:b86e:ac17:f518:b547:13a8])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dd59b54f9fsm7775841plt.136.2024.04.02.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:35:54 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] arm64: dts: freescale: Add i.MX8DX dtsi
Date: Tue,  2 Apr 2024 16:35:09 -0300
Message-Id: <20240402193512.240417-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402193512.240417-1-hiagofranco@gmail.com>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Add DTSI for i.MX8DX processor. According to 'i.MX 8DualX Industrial
Applications Processors Data Sheet', the GPU and shader use a clock of
372MHz. Therefore, this dtsi includes the imx8dxp.dtsi and changes the
clock accordingly.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8dx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8dx.dtsi b/arch/arm64/boot/dts/freescale/imx8dx.dtsi
new file mode 100644
index 000000000000..ce76efc1a041
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dx.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2020 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8dxp.dtsi"
+
+&gpu_3d0 {
+	assigned-clock-rates = <372000000>, <372000000>;
+};
-- 
2.39.2


