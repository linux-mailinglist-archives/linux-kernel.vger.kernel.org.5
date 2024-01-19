Return-Path: <linux-kernel+bounces-31034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5E8327DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D12B2228C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8924D113;
	Fri, 19 Jan 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyCBprv5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFD4CB2F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661136; cv=none; b=C2a45UX0R9PGfjfVY5Vv/telDy/czpGp9ShJSU+A6o6K57/gnuJI5iTjRacSTDUOkmdermJRKVb0k55z6w5POmgmsPUY8yqSYFP/YcWeTx4LpqGHHEQ8mUFU1qsUKDEpAzwoZLXeHf4FMmk2zFgXyGfepvgnfuEUuJhX17LnnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661136; c=relaxed/simple;
	bh=kuYDD5uxgaAqiPArwaEVu4dV87lteqd14/0vwTxY710=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr9VzupTTz2feoRGZdxIyLemjbjJjCIk1a4w+aCrDhHyDd2hY0lkCiv9vDnfji2Xkaibs0BZR5EmQt+Ez04r7TW2LB2d67A6yNTEjmSHCJstjnKLGNHXapDrXoY+OmF4bM54UxcLPynsIkGCeoPkiLB45sVadAT+nRPolbg6L/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HyCBprv5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e8f710d44so7713245e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661133; x=1706265933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2al3iBNQhWlEPx3zO71H97w87oPbBhC1wsAJyE/YV+Q=;
        b=HyCBprv5hj1T3vMbgBjHtlb2CTbcrtZMsEXtSdPFtLEEx4ZZFqkGHMbYkOa1mQNG7Z
         EBALnaaspBl7HA1bvpn1qN6szerWEIYciGc8zqScRvq3+GGQYUFmE3WMyK55xKm0oRu6
         cad1IDrU081KHxtalNev3KIXopfkWyA2tze8Z2lfD73e+MQ6jSujtXVL8sjcyfzhHuNY
         GoQBbUu4LuC14bsCtp4RRdDCTIiyKI4yFWg0m1N+P4rT32db4hExV7I0mBwZKe7Z+dbb
         bi3g7r+KPzInc8vCmSmVfk/+AfeHQTBv9+jxtDUamuWnNpjw90O+1Q4wN/TAJDSx1wKx
         GUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661133; x=1706265933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2al3iBNQhWlEPx3zO71H97w87oPbBhC1wsAJyE/YV+Q=;
        b=GCMmOMfKpCb3gikC/8IL33lAtIiYVu/bcYzTDfEq/8g+OLm/iPgKe8wX+40+gHLzlh
         /VxrDEoOjC0d7URxrRsNriGW4XEF8ZtCrrWJpB23/3vu2z7ZF8y90dg6Vg6eo//9hpDx
         91ovuK/XU9TxYmXP9M/dnGOgEcYiuAK7j/+a3bnPSsg/tJD7qiUlybCgZga7/Tb+rjte
         b5JDuo/oAKAZ21vFEt+r1f752BplQV2TBx68zmMEe1ZEs0llowWbhyrRRPOXOaKFiVhI
         T1Qjj85Go9otBeOu9A6aU5dOcgIUxTW3HS2Lq55IXHH4xp2uauJpzcNmTyllJp2t/Lwo
         RZUQ==
X-Gm-Message-State: AOJu0Yygmf+/cOGTokCwLt6WUWcYGrz+m4CrtcZJQl76LlYfM7A0g1oQ
	zvvNibQAWzUrq4hySqtiw02vQZJ4l+Jj4nLuv4i+LXN8iPDlCMZkFNOYyIPp0Hs=
X-Google-Smtp-Source: AGHT+IHXRVDj6Z2rHedmVBuRLxryu4//t1M2OscXjxE5zCpuJxJ49smSeqRP5ESmOv4g6vvM9Ij/5Q==
X-Received: by 2002:a7b:c412:0:b0:40d:7d62:80ab with SMTP id k18-20020a7bc412000000b0040d7d6280abmr1306238wmi.117.1705661133590;
        Fri, 19 Jan 2024 02:45:33 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:32 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 05/19] tty: serial: samsung: add gs101 earlycon support
Date: Fri, 19 Jan 2024 10:45:12 +0000
Message-ID: <20240119104526.1221243-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The entire bus (PERIC) on which the GS101 serial resides only allows
32-bit register accesses. The reg-io-width dt property is disallowed
for the "google,gs101-uart" compatible and instead the iotype is
inferred from the compatible. Always set UPIO_MEM32 iotype for the
gs101 earlycon.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7a1b1ca82511..80b8fcf9e025 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2809,6 +2809,17 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
 			s5pv210_early_console_setup);
 
+static int __init gs101_early_console_setup(struct earlycon_device *device,
+					    const char *opt)
+{
+	/* gs101 always expects MMIO32 register accesses. */
+	device->port.iotype = UPIO_MEM32;
+
+	return s5pv210_early_console_setup(device, opt);
+}
+
+OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);
+
 /* Apple S5L */
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 						const char *opt)
-- 
2.43.0.429.g432eaa2c6b-goog


