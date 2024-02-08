Return-Path: <linux-kernel+bounces-58609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821884E8D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE451F30900
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE510376E2;
	Thu,  8 Feb 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JLVSJwwq"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C1374CC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419851; cv=none; b=n3ZK1CyOKWMzPXOh+KKtpZmd0HAylhchAjT30X/i/LK/aub15zhL0dl37By9oOgPy5imaLpoA8ErHvM4SLxnUSDSIDUpIr3o85XeTo23IL7upgCtHBqbA4zkWQTsht87O9uC34/WTCEMSyr3EU1zpknWhcjo4tIE+e8BMhD4TuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419851; c=relaxed/simple;
	bh=9yBfu5Otql54/j4Z3vAON4o4DHtlNUxLDTy8kePGRek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7W7dBdCLX3DTFpR2BahJ/ACuKxL8eTUWEReJPTwj46ldzuU8TvJeMnVbnsiRIw159t9nk2bSdtemr09VRCAFBsocWyRDWCyM4zAISncmg3CBQFFjSL14J/BzRVISXpOh5UKKGzXY/xM8mR6A3hEkS50P5+cv1fScu/Xier1SA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JLVSJwwq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dc20645871so149781a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419850; x=1708024650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dI9fDaEJQuGTRnVRo7wgbOa0EVSbvXtSt12dvCgGk9c=;
        b=SAg3+ETt9JhgiB5l3rbsBRUBY2hhlICn0B9xG1AOdzLVyR8fY7LJu/e9/g+3uTCb5p
         /tKQpLkW64BfC27+9EQM0TfqpClyXdTnBJBnAeWTw4LExgMVCfAjmsy8ouePrXo6C3Po
         AbTjUtM8z7bJy8Eu5qW7grdf6ueoL8ORgT23FWzZLasBU3Lyn3tSeDHU9x9eU5KA1DD8
         whxFTXj5OuZAmKrcVWzrTBqBfD6Gcpdav9HgFivp54/hzwSBhewbcVcmpzSPKSboyxlj
         7WizF6NkcS/ajgR/Ls5EGELhgFKaLm8cHn+NIGiptoqdxapEErGS4p3NTcIF+V42+Hr3
         +chQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwuFAI/30dtKeY5rm4vo69yCzcYntdK6XHOI5PT6Hw9tt7/v7DO1Lw3up3WJ2b5g0x1xfZj2uwX4FxgqgPhof1qEXKY9tVQXY49KBU
X-Gm-Message-State: AOJu0YzpmHSDDWhkFgj+YAQ+jt6WZwrLGBtjtLPdMIlOtc9a9u0tPisA
	JV9bJBdEZvZdDDzQPP5EzdMErGqpWkDZWkw1ZEbNvEUleI6G2gtb
X-Google-Smtp-Source: AGHT+IHzviAZhQ8X+oZQOkcGUBchFhr8UNsznZkA2wKNvyWlLgofQNlsU9S2dsX6aNdgwTqqFWsE3g==
X-Received: by 2002:a17:90a:cc12:b0:296:6931:e70c with SMTP id b18-20020a17090acc1200b002966931e70cmr763041pju.19.1707419849742;
        Thu, 08 Feb 2024 11:17:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSlFdvGxf8XE04WQ3GvkbDY9VJSqihza1Cc4u4OTm1Mo8IPdGriirMewbMfdZQ3jXRtQ+c2LFF9hg5bk1MSzw18l+m0xWITsOUyEGauuPE2JrNEYbbPT59zwXz0hRT6MTjSC70Ia2NuoTANr+tAoX1TzRcTwM8Ru+Q3voemzMSHHqQIdempUMAohaAehrdnGd1o2KTDgwUH7m2Api15546A4NwM/H387+VfQFNaQnHmxZS29fIkD3u7dWOE03CuFB9FdrWPyLijxI1Y6N6PEAR1aWJ4w==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090a8d1100b00296cc94faf1sm134185pjo.2.2024.02.08.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:17:29 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707419847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI9fDaEJQuGTRnVRo7wgbOa0EVSbvXtSt12dvCgGk9c=;
	b=JLVSJwwqTkOn8Fk0L+BP50YFTZWs0tyrQAy8UGEHQTKGxZ+LoDhplGVxzLgwhYs/I1wZgJ
	BTyN9U69MuOiGtaQmcPPQqjySmqLbyYm2l1a9s1tcNvRc+KnFELm2LU4UAB59JKsxx5XOh
	u96903nJGYQsmTtwg16Y9TXI2NvEdV43FuVOJQy6rID46tmiYLeI+6p9D393+AE5SpGX3D
	bUEvb4XEu1PyH9lGLI4Z9c9IcdiRBvoEN0uHG0Yoo9oedWglLEkfraiSvJUgUNr3l++T5a
	CE9NEwYur5cvdkn2RPqFUlV9CpHGSQpdVmCv6vZMqSzKdOzEFiVkqlZLTA7XJQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 08 Feb 2024 16:17:51 -0300
Subject: [PATCH 1/2] staging: vc04_services: vchiq_arm: make vchiq_bus_type
 const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-bus_cleanup-staging2-v1-1-cfe906133a2c@marliere.net>
References: <20240208-bus_cleanup-staging2-v1-0-cfe906133a2c@marliere.net>
In-Reply-To: <20240208-bus_cleanup-staging2-v1-0-cfe906133a2c@marliere.net>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=9yBfu5Otql54/j4Z3vAON4o4DHtlNUxLDTy8kePGRek=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxSjkTa7KtR2tQ3MbgN5W9IC5VndQZkPXGWUbV
 qes6xBk5aWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcUo5AAKCRDJC4p8Y4ZY
 prhUD/wIqzg9iNUTQIsmx124h4XXKBkjC5HrDUDR3CzxwOLmkVrePgaT6oe9JDn40F6wy3jEg5T
 lw3kAMETmM2OWingznK7Ul5Y6zea2lFD4kmJKpWQwdiQul8x4AlAyFStWLQVipJyO3VUEQ+8W37
 Rt30sb1Lp/KBqVQdE+JbgpmQS4sfWYceZSnrwUVBlLCso0JNLuk6Rkq/WaNrlW0gpapR38QpSGa
 OkJ891QRN8bonZnBm3kfxoX4tcYZvim/svfRBc/sqaoThwLOaTv2170AkF7aINe8thZPEpfwmnr
 CNxx1cnnk95WSqVLZZPS36c0igx4n7iwes1GI3snb+5uxZAFlWwgBJSXymy0o0gyqhxd6iSwPb4
 usznoiYobmZvLwaDsg/PBhgbWNAxi7MqrXnOm+HixVwBikQhJ4fO5UfNgw67LfQJwCGa3IlL9mm
 REFeV8wMhi4nl6zA6nuGdY6IJVnec83dnbiRRhLHWu1biEuk7u9mUqtIpzR+ZkRpSVwC2F1iSdc
 4kKFQV/D5zzJhCJ9DT/1JrzSdqrte/i7AdRjevtcaks74aBQwQQKzUDutbJ0IGKhCwfXHnRPlKn
 YZ76c5iJRpfsIKx0m9OOlAVv6BskEjti+Zrl7gzeeIZPn0PNHqYwYHuWYh9XgX+6RNs0iZoBbAg
 I5iyegEUNHU+Csg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the vchiq_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
index 933027e0011e..68f830d75531 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
@@ -37,7 +37,7 @@ static int vchiq_bus_probe(struct device *dev)
 	return driver->probe(device);
 }
 
-struct bus_type vchiq_bus_type = {
+const struct bus_type vchiq_bus_type = {
 	.name   = "vchiq-bus",
 	.match  = vchiq_bus_type_match,
 	.uevent = vchiq_bus_uevent,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
index caa6fdf25bb1..4db86e76edbd 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
@@ -34,7 +34,7 @@ static inline struct vchiq_driver *to_vchiq_driver(struct device_driver *d)
 	return container_of(d, struct vchiq_driver, driver);
 }
 
-extern struct bus_type vchiq_bus_type;
+extern const struct bus_type vchiq_bus_type;
 
 struct vchiq_device *
 vchiq_device_register(struct device *parent, const char *name);

-- 
2.43.0


