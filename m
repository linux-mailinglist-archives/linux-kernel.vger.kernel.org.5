Return-Path: <linux-kernel+bounces-153202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F438ACADF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF37F28143B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBD145FF9;
	Mon, 22 Apr 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqlE7/HB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D681465B5;
	Mon, 22 Apr 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782290; cv=none; b=AVAabIUDhJJP8e4WsVmtA/LlfLgH6xvdRaci6P8WYcCTR5BCcHnFZxzmRhuG9NPpjSzSkBRYwXiVrGKVV//Sdx3SnYoworyz2cXTV6tlhNkgT6wuaOwUyCWuJ0R0iFxWgtf6UqMRGsOmznk6QWFULbhXOoXKeiDQn0rg7wO4wqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782290; c=relaxed/simple;
	bh=Lt1nFZ8VwQDqcdcvZHEXzl3FPeDt6SmnxVVK6tvED9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeInldqserytyQnfFKtWXbzrm8/Eo+2S6TOiZI9s2FU/22mjSup8YYagsOzpVZGhfnSnSTqeJ1TW+0wuvaRJJpZUO3N4aXYQnF1oBFvhKJ6LRhTiYgamAfmiU8GME3k/fLjnleBKI/M8pdQEcHzjBCW9aZAP/KkYUhJWJOZkbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqlE7/HB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso2607406b3a.0;
        Mon, 22 Apr 2024 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782289; x=1714387089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0O7T2yJ5pHgmNgm6vNSvjG0SyzCguoIApl75+ur4PI=;
        b=eqlE7/HBYE5LyXkIemCBDpKs+tci6KsNIPMMb0iQ0auExPHy2SIc9va2cLsykwTyB2
         rGLSQxvcGqXGFUyc3OuesUegQWW6zoKtXFUG5YmXNhjK5n2mMreizfu2bdZTwJN/Nl7V
         iTKL1LkrmTJ/h4Yq9u+PISPWBQHXgzIwSsbAduSvdiiTk9FCRO3DG1N6ch47tqznFWV1
         C9TCMjGEKaVMZfwz5IPymYl/iguRYQIyO/iMNaBzyBNSgissapSL8fkhFcBwogZmRHlR
         T68ZFlMEH/oNiOq8awF+Tp/uy9KmO0QXoBbn8ATQufUH7QAWFjXkB1sqpOnkT48Ma5KU
         Y3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782289; x=1714387089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0O7T2yJ5pHgmNgm6vNSvjG0SyzCguoIApl75+ur4PI=;
        b=ZZrjqi2WGMPnS4ZG9CbOzF4Ok9vT6a6VL2AN91NrXrjUr2kgm+2IegPiqLNx9Mfk/+
         p5wJaVMgn096QWIof11cFk6C90ikG7WOluP0SLrC+ysIHDxrS20eg4iV45jZ/DLpYYXm
         iksMy1zQXwYgBYLgqlmWWfNgtx9wc3a5hXV18waj6ZDEfjR6p75hkTzOaOS8XdJJWwyE
         R9YRlHwogyL7nDaiybsCe7HWedE5OaZDWt3p9IRgpP0JW2waL+9nIhsLwKJMVhPVSNDe
         IA9RVQ+ACqcIvbvRT+wJRuRdCRo/jr8etp8ryqaI4I3oCEn7Ciih5lYr1uHwWmilHTs6
         WuUw==
X-Forwarded-Encrypted: i=1; AJvYcCWuIrfgsD4qXhotW06PMFIRrQTastAFNfPBcoE01Tsme7uIi/oDH/YxI9C0o1trjQbSkb9/NeO4R4Yf27fc7yWOtMpDHNgd2XNo2DGB
X-Gm-Message-State: AOJu0YzwJYp2lvI/CSJoj0cXiuACjxqticCAoJw2caqjSYtufk0ynrPp
	vSRQlGjcTjhqMRylmvihhuQZR4d5UJ9N93Eg3WAoBZmXeC5PLzv3a12v/cDb
X-Google-Smtp-Source: AGHT+IFLzOEGM3Y6KshSjNA9oDlSdeo2YiHgu3YZWNDXH2+HRTIK0aUEWq96LTgSJPU5+iAbPvUXBg==
X-Received: by 2002:a05:6a20:43a4:b0:1a7:63ce:84ce with SMTP id i36-20020a056a2043a400b001a763ce84cemr12754835pzl.49.1713782288808;
        Mon, 22 Apr 2024 03:38:08 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:08 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V15 04/22] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Mon, 22 Apr 2024 18:37:27 +0800
Message-Id: <20240422103745.14725-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

To allow an additional external regulator to be controlled by an mmc host
driver, let's add support for a vqmmc2 regulator to the mmc core.

For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
this too.

Note that, to allow for flexibility mmc host drivers need to manage the
enable/disable of the vqmmc2 regulator themselves, while the regulator is
looked up through the common mmc_regulator_get_supply().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V10:
 - Modify the commit message.

Updates in V4:
 - Moved the voltage defines into this patch.

---

 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 005247a49e51..208c27cfa505 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -226,6 +226,33 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
 
+/**
+ * mmc_regulator_set_vqmmc2 - Set vqmmc2 as per the ios->vqmmc2_voltage
+ * @mmc: The mmc host to regulate
+ * @ios: The io bus settings
+ *
+ * Sets a new voltage level for the vqmmc2 regulator, which may correspond to
+ * the vdd2 regulator for an SD UHS-II interface. This function is expected to
+ * be called by mmc host drivers.
+ *
+ * Returns a negative error code on failure, zero if the voltage level was
+ * changed successfully or a positive value if the level didn't need to change.
+ */
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	if (IS_ERR(mmc->supply.vqmmc2))
+		return -EINVAL;
+
+	switch (ios->vqmmc2_voltage) {
+	case MMC_VQMMC2_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(
+			mmc->supply.vqmmc2, 1700000, 1800000, 1950000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc2);
+
 #else
 
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
@@ -252,6 +279,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -271,6 +299,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vqmmc2)) {
+		if (PTR_ERR(mmc->supply.vqmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vqmmc2 regulator found\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3e823ef5f672..f60cce75af57 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -74,6 +74,9 @@ struct mmc_ios {
 #define MMC_SIGNAL_VOLTAGE_180	1
 #define MMC_SIGNAL_VOLTAGE_120	2
 
+	unsigned char	vqmmc2_voltage;
+#define MMC_VQMMC2_VOLTAGE_180	0
+
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
 #define MMC_SET_DRIVER_TYPE_B	0
@@ -331,6 +334,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -613,6 +617,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -626,6 +631,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 {
 	return -EINVAL;
 }
+
+static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
+					   struct mmc_ios *ios)
+{
+	return -EINVAL;
+}
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
-- 
2.25.1


