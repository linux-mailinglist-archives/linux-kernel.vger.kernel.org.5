Return-Path: <linux-kernel+bounces-63747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E38533EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0761C27BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB75F568;
	Tue, 13 Feb 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="UDCGNzHv"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D55F546
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836289; cv=none; b=GKAcPsLuCKwGUwa1Oq0AoMLu9CuF3JAicScQj4WXX4mwA9kYxFsgw+wCi3XZ5Gf9IAHTxOlqNhYcCf5D4UDLEVrHimKn9g+zO/2hD+wMyYr8YTJyUQRe2cO0We5as/mV+G1RQZrDdDYHYryDoxXObkmTxnDbgcFEJWxJY72rlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836289; c=relaxed/simple;
	bh=cvM3jbGn2pNGISxHf3FmW8b1rHsifYht4dAojgY2Bt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Unnee36rep3nQh0kG38w6RRzDSoOkeUx4jiNqcKR8SBR2eMQuShRic+QEbLqPpw5+3tYvWc6HL0RwmypBTj9oGI6FyzW+3uuZtc5E0Ef9wNbZ75EcNpmjX5WTieSU6axW87VTOJ+3u8LvM4zqFDZr9+i0rOpYxnyVJqhrxF4Et0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=UDCGNzHv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-411a6ceada8so11601195e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707836285; x=1708441085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3C5SmX5V+6lKninJQlWt8eaA/IGxq3ch1+tply21Ok0=;
        b=UDCGNzHvdRJnSRvIwiLAGk1a/67gDwIYSbyvWmqmHfbRqSZr7AqO8qmtDWAuMuKNge
         bbkitP81NMUoTueN5KZlPqnQoDapGz56VXJR6TVhyTPGPua9wf6tGwmA61ginlSj1i9a
         oA1vJX0Z8STWu73cQqvOUhLwADvMdUz6VwNTCV1WGTnGdxxAoyDdJaFktcvPkuiDOpmn
         uIDlmaGLpD/upE5EbIkmcNLAcHSKfOnvh8MN3LHBxV8Fj2DngbbC3uB88SR48zU63T+w
         7NVNpDRlT+2LGCHzb6UKDqyNEtR9FRe3yJMJ1OKTSGG84nWt9G8ibEcFAVeOW3j40pZf
         r7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836285; x=1708441085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C5SmX5V+6lKninJQlWt8eaA/IGxq3ch1+tply21Ok0=;
        b=JUTwVu3AsQsT5LUXWt2aBUatJX+WKRCmh4qi6zHaFVnu1VYl7RRjQh1y+mE1WNMcl3
         gDmoFsGy/Xd9S/NSYpyeb+xq4S+ihWC/0x0TBoH4IIDXnA+GCY1DVHm+qLSpvKgOo/z0
         qzSjiU8y5CgWWDFRzIFK8qkesRA3ZprpLKjwY/y0l4Apa3YJDGh/INgaw96MdresTCZC
         XskbaHSadM+/CApY98sS+VGLVrOY4YtWPXtXFV0fCNwpgVT/19POEYZ1oHvfhYuDtXDd
         9eJeevHWY02iMRMNZdOkaFhm8rXaKPzPONbev5A/GX17KHB7ZCTmfoSEbfxzwVjS+jpP
         3Z0A==
X-Forwarded-Encrypted: i=1; AJvYcCXZP0KGQ4mvnYcxq1RTV2eGPKMw2VcY1b7XKI1c8bOi6YfpXwRWFDkZS71xQB97oVXk3qGTsxyJ8se4WOvhHevJp2tmNDOnPUb5m3F3
X-Gm-Message-State: AOJu0YwECgmp1IFUqnftPx481gcUpAgkD6RIOWAPeGF4hhhBARwkCzrS
	GwaW3bx/P2CSeFNJL0zw8CSO6Lpx/az0Ed8CfP/zhqSQ9Au4QC43KCo/3lltE1k=
X-Google-Smtp-Source: AGHT+IEMrorDs+DE8fCrD59h8sdhFeBtv676TyQVfbYVRnwLeedfusnUerNCKh81sX6zxI2BCimyQg==
X-Received: by 2002:adf:e992:0:b0:33a:e76e:8b5c with SMTP id h18-20020adfe992000000b0033ae76e8b5cmr7550074wrm.33.1707836284722;
        Tue, 13 Feb 2024 06:58:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfr6aLDw7FycKbAl5QvinBYogvnkZQWpd9P/wdOWNnllIhuGVHQYn3H19NMh6Ml+Bz9e6ku3mh1EwL3t5C846vIEld2LaJyUYQCgupKAihlJKEtwaRA80EF+yurEyX3al9RSjOwwJ2Jl62KYSpRURUuLV01l4LCD+M5pDGpUk=
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0033b46b1b6adsm9900019wrb.21.2024.02.13.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:58:04 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator (max5970): Fix regulator child node name
Date: Tue, 13 Feb 2024 20:28:00 +0530
Message-ID: <20240213145801.2564518-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update regulator child node name to lower case i.e., sw0 & sw1 as
descibed in max5970 dt binding.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/max5970-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index 830a1c4cd705..8bbcd983a74a 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -29,8 +29,8 @@ struct max5970_regulator {
 };
 
 enum max597x_regulator_id {
-	MAX597X_SW0,
-	MAX597X_SW1,
+	MAX597X_sw0,
+	MAX597X_sw1,
 };
 
 static int max5970_read_adc(struct regmap *regmap, int reg, long *val)
@@ -378,8 +378,8 @@ static int max597x_dt_parse(struct device_node *np,
 }
 
 static const struct regulator_desc regulators[] = {
-	MAX597X_SWITCH(SW0, MAX5970_REG_CHXEN, 0, "vss1"),
-	MAX597X_SWITCH(SW1, MAX5970_REG_CHXEN, 1, "vss2"),
+	MAX597X_SWITCH(sw0, MAX5970_REG_CHXEN, 0, "vss1"),
+	MAX597X_SWITCH(sw1, MAX5970_REG_CHXEN, 1, "vss2"),
 };
 
 static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,

base-commit: 3240695334aa17325671e9ef37bba43038fc4181
-- 
2.42.0


