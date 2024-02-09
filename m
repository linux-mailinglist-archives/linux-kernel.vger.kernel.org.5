Return-Path: <linux-kernel+bounces-59141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D65384F1DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3D71C2265E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31344664BD;
	Fri,  9 Feb 2024 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BThMWH+S"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7021103;
	Fri,  9 Feb 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469385; cv=none; b=D7cd9fXA6ccQtSB6sFb7qYxnaQB/ri5mgGHsDwyHfkDVNDwVLBW5jMqYE/8y6IVKnFN4Wqi6OVQNLBR5Y+spZKbRkXH7mnk3NIZO5GiZcRfrXzOx+Df4n5d1hjWB+9NWtihkJIR6chsTTSvAhNH9e4SGDy70lPAuFJWIJQJsq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469385; c=relaxed/simple;
	bh=wa9bhmzOX6NTL6/0vCdL+vxvuRUW/j5gFq4FNTMI9mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxY0U/nGzsxD6Eo/+Y796Eov/v7wVxH96dQqyWvgVMVnD3UT/QXWilF9XPG1QBAdyYwWtSWg7TwGUHBru+Dij7ev5fmVCfDPlF0n1b/r1kX+e1yaAfXnoVLJHD/gdIjgiYC2qPiPvntnpCd07jyZ0//FuqSHR6aNNYPjXFPkGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BThMWH+S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41047386d18so6076835e9.0;
        Fri, 09 Feb 2024 01:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707469382; x=1708074182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neBOUcNFScKRdgExDbRdoIzZzeQ/kJIcwYZHML2NDYg=;
        b=BThMWH+Sr6MhR/ni/cd8uCA6G5abnoCHuY4AbpJFF2jsA4mqAhdWnppey8NNkhyPz3
         ZhbK1D1pFXlwlTgiD42ERa/ZJIBnTmtUCFLazq0PzXGI9LZCvVauCiOQ0vH8pfmewlw9
         /8vGsCkhndZ2MxqsXwCL8EdoNN+65lNpDeJiBINeZaMF10m5D4iYeO+niivtGWR8FySg
         9CmfheOavWpq6Rt3Zt2lzfdMmq6rXV95Ulpr+rTXioqKdfoCxzeYt0uFRSv1hwJVPOwo
         bL7lIitOb48s5+JBzAObZn7SgIGeHyZyViU2o4eeNfQeEcybErVFJn70WopcfjTqAX7X
         fhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707469382; x=1708074182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neBOUcNFScKRdgExDbRdoIzZzeQ/kJIcwYZHML2NDYg=;
        b=ktgGTMbMTCWIRwPL1r/jUM5CWLcsrAsKpWeFS5GxjphZICew3TBjO4zoKV6ZTdctqJ
         G/7jKDlhzyi+Sbd7xdlO3ToSWu/jwUDl/znURRdFBHGdVp7TMCGxizjkeSIFcL6/8JW6
         sPH678+qCENbkU5Bm8/iG/ngrntycxn69RNB9cTH5Y3Oko66YooeJzeRYhSGY85fcy2O
         gsACLYftKOVW6EilpUuleUK33C9KVKGe6/WKPTpxEmos7HVDoYz71sLvmjGKRDOwB93Q
         ioAR6mMT0QWAAwh9XDt3nphF/e0CMKwDyCHhVxA/9xaXnfVHsnrA/9uHbht1n3/NtGaC
         KBDg==
X-Gm-Message-State: AOJu0YyM/PNtcufyhLANKoDeSylIHabkaURrMOKsO8zbRx83N6UVu32K
	EH6w/8i73QrgXko86GMetUd0J0qkGuTDRQfZykBEMXg=
X-Google-Smtp-Source: AGHT+IHvmTzYBPETpQD6QUBMdFckTeTvjoS28ofCH7P+9tE3kSQXOdg2sp8J+oFWFFNiunRi7qsUDQ==
X-Received: by 2002:a05:600c:510b:b0:40f:ddb8:c854 with SMTP id o11-20020a05600c510b00b0040fddb8c854mr747559wms.28.1707469381781;
        Fri, 09 Feb 2024 01:03:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMNNyGidvL/baPQzyxrn6Opp+D1MlhQ0Ut3yiVV44g3nxb1fg8HSmy/Xg2ph3fJb/12LRgBw0rkCroJnHV2C7vyLo+T0hxgHau/81U+2wEOG+gkAok5sxxRnVr7abVSwTrc8h8X/Ym1Oca8EsAAcUFuE3AhqlVPv3DxEzsBHA0ODVd9t4Y0Hw8ZYU08fTRc9ati81oov3AMTwbvHrzp6wA/v0FHIQP0Gjoq1scRpWBF6x8pOs=
Received: from lightwarsArch.fritz.box (p5b067f78.dip0.t-ipconnect.de. [91.6.127.120])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b004107219c664sm738486wmb.32.2024.02.09.01.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:03:01 -0800 (PST)
From: Sebastian Kranz <tklightforce@googlemail.com>
To: linux@roeck-us.net
Cc: samsagax@gmail.com,
	derekjohn.clark@gmail.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Kranz <tklightforce@googlemail.com>
Subject: [PATCH V2] hwmon: (oxp-sensors) Add support for Ayaneo Air Plus 7320u.
Date: Fri,  9 Feb 2024 10:01:23 +0100
Message-ID: <20240209090157.3232-1-tklightforce@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2a6ab115-9775-447b-adf5-d63043548c74@roeck-us.net>
References: <2a6ab115-9775-447b-adf5-d63043548c74@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for handheld AYANEO AIR Plus with the same EC registers to add proper fan control.

Functionality was tested successfully.

Signed-off-by: Sebastian Kranz <tklightforce@googlemail.com>
---
 Documentation/hwmon/oxp-sensors.rst |  1 +
 drivers/hwmon/oxp-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 3adeb7406243..55b1ef61625e 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -33,6 +33,7 @@ Currently the driver supports the following handhelds:
  - AOK ZOE A1 PRO
  - Aya Neo 2
  - Aya Neo AIR
+ - Aya Neo AIR Plus (Mendocino)
  - Aya Neo AIR Pro
  - Aya Neo Geek
  - OneXPlayer AMD
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index ea9602063eab..8d3b0f86cc57 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -43,6 +43,7 @@ enum oxp_board {
 	aok_zoe_a1 = 1,
 	aya_neo_2,
 	aya_neo_air,
+	aya_neo_air_plus_mendo,
 	aya_neo_air_pro,
 	aya_neo_geek,
 	oxp_mini_amd,
@@ -98,6 +99,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aya_neo_air,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
+		},
+		.driver_data = (void *)aya_neo_air_plus_mendo,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
@@ -332,6 +340,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			switch (board) {
 			case aya_neo_2:
 			case aya_neo_air:
+			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
@@ -374,6 +383,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			switch (board) {
 			case aya_neo_2:
 			case aya_neo_air:
+			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
-- 
2.43.0


