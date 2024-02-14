Return-Path: <linux-kernel+bounces-65316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD9854B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673DF1F21EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759154F89;
	Wed, 14 Feb 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecn8bSnV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A95467A;
	Wed, 14 Feb 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919510; cv=none; b=XnbX7f/GxhVqPKBEZz+kPCa7DoXFnWKC4oV8bkvThyDwCKGMwxapugANfKOv5d4RNEYeD5f+jiwCsIhC3V3ACXhGqjSlUw5E628yFRKlEq68jncYI8sCoGXoRWFjzGq74aMYclAO0BYa9aPMjyEVPxGW8E0oC9MsKwxOHW1Idn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919510; c=relaxed/simple;
	bh=0ioxeDR3K/K4HUN13S6t6/wJA9enDqmUGbqLb80CXiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcYF1RW6xAM2m+vFkF7YeiEuq530479SbPNwBfHOjIpbg0uSHRVTj5Mh+ZS17TX6VcqOZXejhAKtfcSghbQdftdDu0uzG8TxUkYS6xWzrW9/otkrlpDw3t4Svt5C5OEcjphH9dlh64Hbuykl9Ya9MGG6baF/0YUSQ5FTvYpGlB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ecn8bSnV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so8906112a12.3;
        Wed, 14 Feb 2024 06:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707919506; x=1708524306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp9yTCv8Nkx/po83XyeQipiHIFHlL3sjSTw5FvYRdgw=;
        b=Ecn8bSnVIURbtUCVnT4/29QbxAEAvJZElWNzXKZZQ6qEceKzZQK6XRyCC3kgU8f8lY
         XF0hL5clx9UKdYhUuA+ps7o/nsLWei2oOEMO4saVHhYVDHdRy+RixJGKKlZA1i6q3325
         7d4qZM627eOIA9ncD6PIeKU8sNqxDeMJg5wAoB/uDUiRQ1aW9mw5c0FW52O3yu3Q7HsB
         V8BDQFH8mVXjGttNVMSg0e72ShqWlmWKTQZSO5gOYtvFPDUQ/CVAku9EZWiJ2bLs2ZBG
         ckqxiNgbzxOCtp42qc/8GoegpsoKf2/Bl24a81UVXJ3YiodEhx5ug9bzpCz2grLO31Va
         2r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919506; x=1708524306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp9yTCv8Nkx/po83XyeQipiHIFHlL3sjSTw5FvYRdgw=;
        b=nqqJGQoGpVyBFkqwoV1+YJ8Ro8YOLD5UCoUZY9akiyzaPguival+AAf7S4xUcMcuI/
         NG/dFjf4RlI/bpZjwfRn01hqlYIvAc25Sad/47BXIMjBsieFF9I5wCJ6axSVHaR8Sm7B
         S5lYMh/0i1SKW55sIg7Vx0ST0BPzVTNKCqiM0KUnyv+0CSEA4YYtLkFNxLbN2aQBuX1o
         q5RoWp43j9gzGjHAMn14pe/qWEr7Z2awMOKhbJwTfPOWHtiVDZNS9jHpx5lqxCHFl5eZ
         UuGYxfvGN3eMpergnYA/brrr1I1sGlGWnbKAN28XRWWDIEYiF+S/1UPa0IQxTTH46BpI
         68mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX322n3RCqGjynkrArhRzM11Bq0JT5o4qGLbou9ldlcD14dcXqbZNIocyIclj8Bv1MGko2Ho0ZptC8QcsM7SCpN/Wm9sadDXh42O5BcL8Zgflz/rTG6GQ6kOJPWjgiMM7jr0K7QajpyuyhQoTYcYMEzTrehf/7ic0DKsD2KhwwTO+Tt+g==
X-Gm-Message-State: AOJu0Yx32+TQjI7o7F0ZitD6rYyNgfcNvAB6gCw4MGv//Y/c/6AeJxdt
	njfvjdzBUi2p0ZN9VIkVbST74+EZEsjP0m4q0VhKIEvU1oYkadOI
X-Google-Smtp-Source: AGHT+IGd8MaMO4iogIBuFJz8TmdoIxMvob4CDHybYmI+oXS2kWaWWHs6MOISz80HK5iFOoRO2UzsnQ==
X-Received: by 2002:aa7:c441:0:b0:55f:c5b7:5855 with SMTP id n1-20020aa7c441000000b0055fc5b75855mr1908358edr.6.1707919506394;
        Wed, 14 Feb 2024 06:05:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuZaHwkIiWbn2mb38Z67j0i1WOdtMavF2LwMIhs+ISKRDeoL3SPtJfhfpXrqP8xyBJtN2liwmPWeZgHqVpXUzaMtOzfHSMc+Ta6bhQIuoLGhbTHAIXsianp6EX9ql0tt704xppvax/L+ji3m7NcTqOPHEtWUgdZsIhFsv+t/Dtq654PuFL05UAwO/+hpwpbAGWbSTz0vAADuias4zMTxv67C5f8UF9lmRhoCC3kxjuJLRV159K+opxXWaxIrTsc8R5vCP4HCYFGT21x9FRO871Fzt51mYZiO+QULaS6Y12ccanNuE+dP0e2FDcmLqBxFzkTE1fQM3AcwA4eE8idTAfOhg6Vefx5KsuX9MHqgHOWYCS1JhRjO1m6uGiBfAwZQPRSdQMCrtcS5UGvFEeRfkghzPWhbfuKbn3pYM/hzOeDX6Z+sE6WsODL699ZGbX9NuHP5QkKqCiPJ5UjzneSvILjjPIHEQ1eK56akkER0ZnYKxxg/59WSqNEfPgX5UG9A==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id p23-20020a056402501700b005614409022esm4700646eda.63.2024.02.14.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:05:05 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] pwm: mediatek: add support for MT7988
Date: Wed, 14 Feb 2024 15:04:54 +0100
Message-Id: <20240214140454.6438-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240214140454.6438-1-zajec5@gmail.com>
References: <20240214140454.6438-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7988 uses new registers layout just like MT7981 but it supports 8 PWM
interfaces.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: New patch in the series

 drivers/pwm/pwm-mediatek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 562102a47ac0..292c8bd5b343 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -339,6 +339,13 @@ static const struct pwm_mediatek_of_data mt7986_pwm_data = {
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
+static const struct pwm_mediatek_of_data mt7988_pwm_data = {
+	.num_pwms = 8,
+	.pwm45_fixup = false,
+	.has_ck_26m_sel = false,
+	.reg_offset = mtk_pwm_reg_offset_v2,
+};
+
 static const struct pwm_mediatek_of_data mt8183_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = false,
@@ -369,6 +376,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ .compatible = "mediatek,mt7981-pwm", .data = &mt7981_pwm_data },
 	{ .compatible = "mediatek,mt7986-pwm", .data = &mt7986_pwm_data },
+	{ .compatible = "mediatek,mt7988-pwm", .data = &mt7988_pwm_data },
 	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
 	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data },
 	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
-- 
2.35.3


