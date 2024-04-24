Return-Path: <linux-kernel+bounces-156501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03918B036A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011F01C23364
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0F158853;
	Wed, 24 Apr 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdhNUXs3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B71586C1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944579; cv=none; b=G09PWppm0Pj/4Vl35+Zb+iCYcYljp2IN0+3ohj3GzD6usPtKBJedg0MktzXUpMNuEPzZtdQskqWjDfDv8WswKeeDLSWkmF69y2vO4fjMsCrpgHTaHyg/qNZiep/7mFo8eiZ++vWfrl7KPWOsMga8SzlVOYjGqHN1WoJ8pwihYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944579; c=relaxed/simple;
	bh=n+ycT1yaD+HA004B8O0G4wFDtyUmGknyRTVEjZID7TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SauNGqI6KmnJ6lJt0f44dSMt8QFQb2jg8Bm9KCyGH2xRxSE+I3x2Zn2rgsv+OlVPfIIRZaesVbzwnJT21W25mAAKWolX3qzD/yNXawUUwUay4i/KbrphU1ON6ulmmMMJq1YBPMYfH1hPR/en6y4agu89zGS7q7gxRWli230SAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdhNUXs3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de4645bee83so11729892276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713944576; x=1714549376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnX9oGxrs0TnUfelI2d5iVd7k4fE//vtfjvjvt3oSPU=;
        b=YdhNUXs36iy1oeuIYMP5f5hEMbMjpDrv6N3qlVXGDf/4LIw/l2m8LyM2pnvBgPm0QJ
         vstcl3CcSuNeGQa50mFs/SYjKPLF+b/aBTZq4/WpV60U9qhJTOLKe8bHhRLkueqw20T4
         iB2xgjA22/GGSO8guG3cRyet8l9436UQe3Ft3dmfvnti6jj9KDoQus/bXaf0VATTHIuj
         z1nwydah/k32fEAr7IrKWFl8qbxOR8TZKGGqoaOSj7wrw3jTCPc80FoYr44tKHATPaYk
         DkfgwP+Z9KU+3t2Qu4i+iglafVu3Jh3d0C+qUO91dSW45ukbsZvA8qhqQkLLpIbrra5T
         x7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713944576; x=1714549376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnX9oGxrs0TnUfelI2d5iVd7k4fE//vtfjvjvt3oSPU=;
        b=CekTeGCKuKzX8SYVdWXCWs71ccAU9cNWsMJ3KfA3s8hNV+toGVsurfkNdIGx4xKl0L
         GIRgElT9ZRmMmC3ep60+Pqs1R4jhO8uZJROgssLeWb79BprZc4XaNKPsLN3gZivWtW27
         yvEhkf8YK+1u6rzx1JHHdxQqGBhlaVqK+d5UEh5qaIYdKRa97s2oVo6deSOzrEfjCMGy
         Sj0NIeT4Bz6foDFAjJb3JEO8VVOi/yucFJGiVLA6Ye4oo6KrScGpVTnmPEpejOJhGN+d
         Babc3Z189XsYWYbdQ7+C2NXM+7YD3EomMy8qscmCLmPPNsm5+apnyi31Fcqae5IVxWI+
         BA5w==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZE93Q6qrbAnCXBWl2uo6DiqOFuWVCvfVdpcb2/eJNj20zxR+M2Q1ME/u6lnrixMwjxAsBvSz1A1NfwRK8NQqhizNZjy9oKaJgjOe
X-Gm-Message-State: AOJu0YyKORhgBHY8ngqxvXCuliWtlDziOTZpn7iBiF85thULlnq+CLAz
	ujSrEp830KtG3eh02jqiiZHUMDM4BKeOgz5wz8VuD2DTklo8lxHVzVZGbnJSBkGv+hSoO5LKkv9
	DBdS7q2fPuw==
X-Google-Smtp-Source: AGHT+IGG9SHHBlYVZw9h0aZecRewHnIYI/R7Ng5mN7X4a5ZHHJUZByaO93pbP0qE7tlfomx0JRKjuQEkFZBsiw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:100a:b0:dcd:3a37:65 with SMTP id
 w10-20020a056902100a00b00dcd3a370065mr134595ybt.7.1713944575720; Wed, 24 Apr
 2024 00:42:55 -0700 (PDT)
Date: Wed, 24 Apr 2024 07:42:42 +0000
In-Reply-To: <20240424074242.519895-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424074242.519895-1-joychakr@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424074242.519895-2-joychakr@google.com>
Subject: [PATCH v2 1/1] nvmem: Change return type of reg read/write to ssize_t
From: Joy Chakraborty <joychakr@google.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vincent Shih <vincent.sunplus@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Rafal Milecki <rafal@milecki.pl>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	manugautam@google.com, Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Change return type of reg_read() and reg_write() callback to ssize_t for
nvmem suppliers to return number of bytes read/written to the nvmem core.

Currently nvmem core assumes the amount of data read/written is equal
to what it has requested from the supplier, this return code facilitates
better error handling in the nvmem core.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/nvmem/apple-efuses.c        |  7 +--
 drivers/nvmem/bcm-ocotp.c           | 12 ++---
 drivers/nvmem/brcm_nvram.c          | 10 ++--
 drivers/nvmem/core.c                | 83 +++++++++++++----------------
 drivers/nvmem/imx-iim.c             |  6 +--
 drivers/nvmem/imx-ocotp-ele.c       |  4 +-
 drivers/nvmem/imx-ocotp-scu.c       | 12 ++---
 drivers/nvmem/imx-ocotp.c           | 10 ++--
 drivers/nvmem/jz4780-efuse.c        |  7 +--
 drivers/nvmem/lan9662-otpc.c        | 12 ++---
 drivers/nvmem/layerscape-sfp.c      | 11 ++--
 drivers/nvmem/lpc18xx_eeprom.c      | 14 ++---
 drivers/nvmem/lpc18xx_otp.c         |  6 +--
 drivers/nvmem/meson-efuse.c         | 22 +++++---
 drivers/nvmem/meson-mx-efuse.c      |  6 +--
 drivers/nvmem/microchip-otpc.c      |  6 +--
 drivers/nvmem/mtk-efuse.c           |  6 +--
 drivers/nvmem/mxs-ocotp.c           |  7 +--
 drivers/nvmem/nintendo-otp.c        |  6 +--
 drivers/nvmem/qcom-spmi-sdam.c      | 12 ++---
 drivers/nvmem/qfprom.c              | 14 ++---
 drivers/nvmem/qoriq-efuse.c         |  6 +--
 drivers/nvmem/rave-sp-eeprom.c      | 18 +++----
 drivers/nvmem/rmem.c                |  4 +-
 drivers/nvmem/rockchip-efuse.c      | 19 +++----
 drivers/nvmem/rockchip-otp.c        | 19 +++----
 drivers/nvmem/sc27xx-efuse.c        |  3 +-
 drivers/nvmem/sec-qfprom.c          |  4 +-
 drivers/nvmem/snvs_lpgpr.c          | 17 +++---
 drivers/nvmem/sprd-efuse.c          |  8 +--
 drivers/nvmem/stm32-bsec-optee-ta.c | 12 ++---
 drivers/nvmem/stm32-bsec-optee-ta.h | 20 +++----
 drivers/nvmem/stm32-romem.c         | 26 ++++-----
 drivers/nvmem/sunplus-ocotp.c       |  4 +-
 drivers/nvmem/sunxi_sid.c           | 15 +++---
 drivers/nvmem/u-boot-env.c          |  6 +--
 drivers/nvmem/uniphier-efuse.c      |  6 +--
 drivers/nvmem/vf610-ocotp.c         |  7 +--
 drivers/nvmem/zynqmp_nvmem.c        | 13 ++---
 include/linux/nvmem-provider.h      |  4 +-
 40 files changed, 253 insertions(+), 231 deletions(-)

diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
index d3d49d22338b..c97328ee220a 100644
--- a/drivers/nvmem/apple-efuses.c
+++ b/drivers/nvmem/apple-efuses.c
@@ -15,10 +15,11 @@ struct apple_efuses_priv {
 	void __iomem *fuses;
 };
 
-static int apple_efuses_read(void *context, unsigned int offset, void *val,
-			     size_t bytes)
+static ssize_t apple_efuses_read(void *context, unsigned int offset, void *val,
+				 size_t bytes)
 {
 	struct apple_efuses_priv *priv = context;
+	size_t bytes_read = bytes;
 	u32 *dst = val;
 
 	while (bytes >= sizeof(u32)) {
@@ -27,7 +28,7 @@ static int apple_efuses_read(void *context, unsigned int offset, void *val,
 		offset += sizeof(u32);
 	}
 
-	return 0;
+	return bytes_read;
 }
 
 static int apple_efuses_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 2490f44caa40..9435002787bd 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -148,8 +148,8 @@ static int disable_ocotp_program(void __iomem *base)
 	return ret;
 }
 
-static int bcm_otpc_read(void *context, unsigned int offset, void *val,
-	size_t bytes)
+static ssize_t bcm_otpc_read(void *context, unsigned int offset, void *val,
+			     size_t bytes)
 {
 	struct otpc_priv *priv = context;
 	u32 *buf = val;
@@ -176,11 +176,11 @@ static int bcm_otpc_read(void *context, unsigned int offset, void *val,
 		reset_start_bit(priv->base);
 	}
 
-	return 0;
+	return bytes_read;
 }
 
-static int bcm_otpc_write(void *context, unsigned int offset, void *val,
-	size_t bytes)
+static ssize_t bcm_otpc_write(void *context, unsigned int offset, void *val,
+			      size_t bytes)
 {
 	struct otpc_priv *priv = context;
 	u32 *buf = val;
@@ -214,7 +214,7 @@ static int bcm_otpc_write(void *context, unsigned int offset, void *val,
 
 	disable_ocotp_program(priv->base);
 
-	return 0;
+	return bytes_written;
 }
 
 static struct nvmem_config bcm_otpc_nvmem_config = {
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 5cdf339cfbec..dd0e52eb12bd 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -46,8 +46,8 @@ struct brcm_nvram_header {
 	__le32 config_ncdl;	/* ncdl values for memc */
 };
 
-static int brcm_nvram_read(void *context, unsigned int offset, void *val,
-			   size_t bytes)
+static ssize_t brcm_nvram_read(void *context, unsigned int offset, void *val,
+			       size_t bytes)
 {
 	struct brcm_nvram *priv = context;
 	size_t to_copy;
@@ -61,7 +61,11 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 
 	memset((uint8_t *)val + to_copy, priv->padding_byte, bytes - to_copy);
 
-	return 0;
+	/*
+	 * Returning bytes requested as the whole buffer is padded even if the
+	 * requested bytes to be read is out of bounds of resource size.
+	 */
+	return bytes;
 }
 
 static int brcm_nvram_copy_data(struct brcm_nvram *priv, struct platform_device *pdev)
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e1ec3b7200d7..a41b29e60e58 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -55,8 +55,8 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
-static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
-			    void *val, size_t bytes)
+static ssize_t __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+				void *val, size_t bytes)
 {
 	if (nvmem->reg_read)
 		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
@@ -64,10 +64,10 @@ static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
-static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
-			     void *val, size_t bytes)
+static ssize_t __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+				 void *val, size_t bytes)
 {
-	int ret;
+	ssize_t ret;
 
 	if (nvmem->reg_write) {
 		gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
@@ -79,8 +79,8 @@ static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
-static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
-				      unsigned int offset, void *val,
+static ssize_t nvmem_access_with_keepouts(struct nvmem_device *nvmem,
+					  unsigned int offset, void *val,
 				      size_t bytes, int write)
 {
 
@@ -88,7 +88,7 @@ static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
 	unsigned int kend, ksize;
 	const struct nvmem_keepout *keepout = nvmem->keepout;
 	const struct nvmem_keepout *keepoutend = keepout + nvmem->nkeepout;
-	int rc;
+	ssize_t rc, count = 0;
 
 	/*
 	 * Skip all keepouts before the range being accessed.
@@ -107,11 +107,12 @@ static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
 			else
 				rc = __nvmem_reg_read(nvmem, offset, val, ksize);
 
-			if (rc)
+			if (rc < 0)
 				return rc;
 
 			offset += ksize;
 			val += ksize;
+			count += rc;
 		}
 
 		/*
@@ -135,16 +136,21 @@ static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
 	if (offset < end) {
 		ksize = end - offset;
 		if (write)
-			return __nvmem_reg_write(nvmem, offset, val, ksize);
+			rc = __nvmem_reg_write(nvmem, offset, val, ksize);
 		else
-			return __nvmem_reg_read(nvmem, offset, val, ksize);
+			rc = __nvmem_reg_read(nvmem, offset, val, ksize);
+
+		if (rc < 0)
+			return rc;
+
+		count += rc;
 	}
 
-	return 0;
+	return count;
 }
 
-static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
-			  void *val, size_t bytes)
+static ssize_t nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+			      void *val, size_t bytes)
 {
 	if (!nvmem->nkeepout)
 		return __nvmem_reg_read(nvmem, offset, val, bytes);
@@ -152,8 +158,8 @@ static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 	return nvmem_access_with_keepouts(nvmem, offset, val, bytes, false);
 }
 
-static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
-			   void *val, size_t bytes)
+static ssize_t nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+			       void *val, size_t bytes)
 {
 	if (!nvmem->nkeepout)
 		return __nvmem_reg_write(nvmem, offset, val, bytes);
@@ -195,7 +201,6 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev;
 	struct nvmem_device *nvmem;
-	int rc;
 
 	if (attr->private)
 		dev = attr->private;
@@ -221,12 +226,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (!nvmem->reg_read)
 		return -EPERM;
 
-	rc = nvmem_reg_read(nvmem, pos, buf, count);
-
-	if (rc)
-		return rc;
-
-	return count;
+	return nvmem_reg_read(nvmem, pos, buf, count);
 }
 
 static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
@@ -235,7 +235,6 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev;
 	struct nvmem_device *nvmem;
-	int rc;
 
 	if (attr->private)
 		dev = attr->private;
@@ -261,12 +260,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (!nvmem->reg_write)
 		return -EPERM;
 
-	rc = nvmem_reg_write(nvmem, pos, buf, count);
-
-	if (rc)
-		return rc;
-
-	return count;
+	return nvmem_reg_write(nvmem, pos, buf, count);
 }
 
 static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
@@ -1638,9 +1632,12 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 
 	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->raw_len);
 
-	if (rc)
+	if (rc < 0)
 		return rc;
 
+	if (rc != cell->raw_len)
+		return -EIO;
+
 	/* shift bits in-place */
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
@@ -1713,8 +1710,11 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell_entry *cell,
 
 		/* setup the first byte with lsb bits from nvmem */
 		rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
-		if (rc)
+		if (rc < 1) {
+			if (rc == 0)
+				rc = -EIO;
 			goto err;
+		}
 		*b++ |= GENMASK(bit_offset - 1, 0) & v;
 
 		/* setup rest of the byte if any */
@@ -1733,8 +1733,11 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell_entry *cell,
 		/* setup the last byte with msb bits from nvmem */
 		rc = nvmem_reg_read(nvmem,
 				    cell->offset + cell->bytes - 1, &v, 1);
-		if (rc)
+		if (rc < 1) {
+			if (rc == 0)
+				rc = -EIO;
 			goto err;
+		}
 		*p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
 
 	}
@@ -1774,10 +1777,7 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 	if (cell->bit_offset || cell->nbits)
 		kfree(buf);
 
-	if (rc)
-		return rc;
-
-	return len;
+	return rc;
 }
 
 /**
@@ -2052,17 +2052,10 @@ int nvmem_device_read(struct nvmem_device *nvmem,
 		      unsigned int offset,
 		      size_t bytes, void *buf)
 {
-	int rc;
-
 	if (!nvmem)
 		return -EINVAL;
 
-	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
-
-	if (rc)
-		return rc;
-
-	return bytes;
+	return nvmem_reg_read(nvmem, offset, buf, bytes);
 }
 EXPORT_SYMBOL_GPL(nvmem_device_read);
 
diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index f13bbd164086..f9f912bd4e41 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -29,8 +29,8 @@ struct iim_priv {
 	struct clk *clk;
 };
 
-static int imx_iim_read(void *context, unsigned int offset,
-			  void *buf, size_t bytes)
+static ssize_t imx_iim_read(void *context, unsigned int offset,
+			    void *buf, size_t bytes)
 {
 	struct iim_priv *iim = context;
 	int i, ret;
@@ -49,7 +49,7 @@ static int imx_iim_read(void *context, unsigned int offset,
 
 	clk_disable_unprepare(iim->clk);
 
-	return 0;
+	return bytes;
 }
 
 static struct imx_iim_drvdata imx27_drvdata = {
diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index cf920542f939..3025fe8aa991 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -61,7 +61,7 @@ static enum fuse_type imx_ocotp_fuse_type(void *context, u32 index)
 	return FUSE_INVALID;
 }
 
-static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, size_t bytes)
+static ssize_t imx_ocotp_reg_read(void *context, unsigned int offset, void *val, size_t bytes)
 {
 	struct imx_ocotp_priv *priv = context;
 	void __iomem *reg = priv->base + priv->data->reg_off;
@@ -102,7 +102,7 @@ static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, siz
 
 	kfree(p);
 
-	return 0;
+	return bytes;
 };
 
 static int imx_ele_ocotp_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 517d83e11af2..033261827141 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -129,8 +129,8 @@ static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
 	return 0;
 }
 
-static int imx_scu_ocotp_read(void *context, unsigned int offset,
-			      void *val, size_t bytes)
+static ssize_t imx_scu_ocotp_read(void *context, unsigned int offset,
+				  void *val, size_t bytes)
 {
 	struct ocotp_priv *priv = context;
 	u32 count, index, num_bytes;
@@ -174,11 +174,11 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 
 	kfree(p);
 
-	return 0;
+	return bytes;
 }
 
-static int imx_scu_ocotp_write(void *context, unsigned int offset,
-			       void *val, size_t bytes)
+static ssize_t imx_scu_ocotp_write(void *context, unsigned int offset,
+				   void *val, size_t bytes)
 {
 	struct ocotp_priv *priv = context;
 	struct arm_smccc_res res;
@@ -215,7 +215,7 @@ static int imx_scu_ocotp_write(void *context, unsigned int offset,
 
 	mutex_unlock(&scu_ocotp_mutex);
 
-	return res.a0;
+	return res.a0 < 0 ? res.a0 : bytes;
 }
 
 static struct nvmem_config imx_scu_ocotp_nvmem_config = {
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 79dd4fda0329..4338bc83665a 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -154,8 +154,8 @@ static void imx_ocotp_clr_err_if_set(struct ocotp_priv *priv)
 	writel(bm_ctrl_error, base + IMX_OCOTP_ADDR_CTRL_CLR);
 }
 
-static int imx_ocotp_read(void *context, unsigned int offset,
-			  void *val, size_t bytes)
+static ssize_t imx_ocotp_read(void *context, unsigned int offset,
+			      void *val, size_t bytes)
 {
 	struct ocotp_priv *priv = context;
 	unsigned int count;
@@ -217,7 +217,7 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 
 	kfree(p);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
 static int imx_ocotp_cell_pp(void *context, const char *id, int index,
@@ -307,8 +307,8 @@ static void imx_ocotp_set_imx7_timing(struct ocotp_priv *priv)
 	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
 }
 
-static int imx_ocotp_write(void *context, unsigned int offset, void *val,
-			   size_t bytes)
+static ssize_t imx_ocotp_write(void *context, unsigned int offset, void *val,
+			       size_t bytes)
 {
 	struct ocotp_priv *priv = context;
 	u32 *buf = val;
diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 0b01b840edd9..606a63232c3d 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -66,10 +66,11 @@ struct jz4780_efuse {
 };
 
 /* main entry point */
-static int jz4780_efuse_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+static ssize_t jz4780_efuse_read(void *context, unsigned int offset,
+				 void *val, size_t bytes)
 {
 	struct jz4780_efuse *efuse = context;
+	size_t bytes_read = bytes;
 
 	while (bytes > 0) {
 		size_t start = offset & ~(JZ_EFU_READ_SIZE - 1);
@@ -112,7 +113,7 @@ static int jz4780_efuse_read(void *context, unsigned int offset,
 		bytes -= chunk;
 	}
 
-	return 0;
+	return bytes_read;
 }
 
 static struct nvmem_config jz4780_efuse_nvmem_config = {
diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
index 56fc19f092a7..4a2aa3324b2d 100644
--- a/drivers/nvmem/lan9662-otpc.c
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -119,8 +119,8 @@ static int lan9662_otp_write_byte(struct lan9662_otp *otp, u32 offset, u8 data)
 	return rc;
 }
 
-static int lan9662_otp_read(void *context, unsigned int offset,
-			    void *_val, size_t bytes)
+static ssize_t lan9662_otp_read(void *context, unsigned int offset,
+				void *_val, size_t bytes)
 {
 	struct lan9662_otp *otp = context;
 	u8 *val = _val;
@@ -136,11 +136,11 @@ static int lan9662_otp_read(void *context, unsigned int offset,
 	}
 	lan9662_otp_power(otp, false);
 
-	return rc;
+	return rc < 0 ? rc : bytes;
 }
 
-static int lan9662_otp_write(void *context, unsigned int offset,
-			     void *_val, size_t bytes)
+static ssize_t lan9662_otp_write(void *context, unsigned int offset,
+				 void *_val, size_t bytes)
 {
 	struct lan9662_otp *otp = context;
 	u8 *val = _val;
@@ -167,7 +167,7 @@ static int lan9662_otp_write(void *context, unsigned int offset,
 	}
 	lan9662_otp_power(otp, false);
 
-	return rc;
+	return rc < 0 ? rc : bytes;
 }
 
 static struct nvmem_config otp_config = {
diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index e2b424561949..fdff3374b5a4 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -26,14 +26,17 @@ struct layerscape_sfp_data {
 	enum regmap_endian endian;
 };
 
-static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
-			       size_t bytes)
+static ssize_t layerscape_sfp_read(void *context, unsigned int offset, void *val,
+				   size_t bytes)
 {
 	struct layerscape_sfp_priv *priv = context;
+	int ret;
 
-	return regmap_bulk_read(priv->regmap,
-				LAYERSCAPE_SFP_OTP_OFFSET + offset, val,
+	ret = regmap_bulk_read(priv->regmap,
+			       LAYERSCAPE_SFP_OTP_OFFSET + offset, val,
 				bytes / 4);
+
+	return ret < 0 ? ret : bytes;
 }
 
 static struct nvmem_config layerscape_sfp_nvmem_config = {
diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index a73acc7377d2..1f68731ff865 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -87,10 +87,11 @@ static int lpc18xx_eeprom_busywait_until_prog(struct lpc18xx_eeprom_dev *eeprom)
 	return -ETIMEDOUT;
 }
 
-static int lpc18xx_eeprom_gather_write(void *context, unsigned int reg,
-				       void *val, size_t bytes)
+static ssize_t lpc18xx_eeprom_gather_write(void *context, unsigned int reg,
+					   void *val, size_t bytes)
 {
 	struct lpc18xx_eeprom_dev *eeprom = context;
+	size_t bytes_written = bytes;
 	unsigned int offset = reg;
 	int ret;
 
@@ -123,13 +124,14 @@ static int lpc18xx_eeprom_gather_write(void *context, unsigned int reg,
 	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
 			      LPC18XX_EEPROM_PWRDWN_YES);
 
-	return 0;
+	return bytes_written;
 }
 
-static int lpc18xx_eeprom_read(void *context, unsigned int offset,
-			       void *val, size_t bytes)
+static ssize_t lpc18xx_eeprom_read(void *context, unsigned int offset,
+				   void *val, size_t bytes)
 {
 	struct lpc18xx_eeprom_dev *eeprom = context;
+	size_t bytes_read = bytes;
 
 	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
 			      LPC18XX_EEPROM_PWRDWN_NO);
@@ -147,7 +149,7 @@ static int lpc18xx_eeprom_read(void *context, unsigned int offset,
 	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
 			      LPC18XX_EEPROM_PWRDWN_YES);
 
-	return 0;
+	return bytes_read;
 }
 
 
diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index adc9948e7b2e..c60a565b6b97 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -37,8 +37,8 @@ struct lpc18xx_otp {
 	void __iomem *base;
 };
 
-static int lpc18xx_otp_read(void *context, unsigned int offset,
-			    void *val, size_t bytes)
+static ssize_t lpc18xx_otp_read(void *context, unsigned int offset,
+				void *val, size_t bytes)
 {
 	struct lpc18xx_otp *otp = context;
 	unsigned int count = bytes >> 2;
@@ -52,7 +52,7 @@ static int lpc18xx_otp_read(void *context, unsigned int offset,
 	for (i = index; i < (index + count); i++)
 		*buf++ = readl(otp->base + i * LPC18XX_OTP_WORD_SIZE);
 
-	return 0;
+	return bytes;
 }
 
 static struct nvmem_config lpc18xx_otp_nvmem_config = {
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 33678d0af2c2..ed2124d916fc 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -14,22 +14,28 @@
 
 #include <linux/firmware/meson/meson_sm.h>
 
-static int meson_efuse_read(void *context, unsigned int offset,
-			    void *val, size_t bytes)
+static ssize_t meson_efuse_read(void *context, unsigned int offset,
+				void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
-				  bytes, 0, 0, 0);
+	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : bytes;
 }
 
-static int meson_efuse_write(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+static ssize_t meson_efuse_write(void *context, unsigned int offset,
+				 void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
+
+	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
 
-	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
-				   bytes, 0, 0, 0);
+	return ret < 0 ? ret : bytes;
 }
 
 static const struct of_device_id meson_efuse_match[] = {
diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 8a16f5f02657..de51841216c1 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -131,8 +131,8 @@ static int meson_mx_efuse_read_addr(struct meson_mx_efuse *efuse,
 	return 0;
 }
 
-static int meson_mx_efuse_read(void *context, unsigned int offset,
-			       void *buf, size_t bytes)
+static ssize_t meson_mx_efuse_read(void *context, unsigned int offset,
+				   void *buf, size_t bytes)
 {
 	struct meson_mx_efuse *efuse = context;
 	u32 tmp;
@@ -162,7 +162,7 @@ static int meson_mx_efuse_read(void *context, unsigned int offset,
 
 	meson_mx_efuse_hw_disable(efuse);
 
-	return err;
+	return err < 0 ? err : bytes;
 }
 
 static const struct meson_mx_efuse_platform_data meson6_efuse_data = {
diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 7cf81738a3e0..c47fdb169734 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -143,8 +143,8 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
  * packet. The user will have to be aware of the memory footprint before doing
  * the read request.
  */
-static int mchp_otpc_read(void *priv, unsigned int off, void *val,
-			  size_t bytes)
+static ssize_t mchp_otpc_read(void *priv, unsigned int off, void *val,
+			      size_t bytes)
 {
 	struct mchp_otpc *otpc = priv;
 	struct mchp_otpc_packet *packet;
@@ -187,7 +187,7 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 		} while (payload_size >= 0 && len < bytes);
 	}
 
-	return 0;
+	return len;
 }
 
 static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 9caf04667341..d9db85933ed6 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -20,8 +20,8 @@ struct mtk_efuse_priv {
 	void __iomem *base;
 };
 
-static int mtk_reg_read(void *context,
-			unsigned int reg, void *_val, size_t bytes)
+static ssize_t mtk_reg_read(void *context,
+			    unsigned int reg, void *_val, size_t bytes)
 {
 	struct mtk_efuse_priv *priv = context;
 	void __iomem *addr = priv->base + reg;
@@ -31,7 +31,7 @@ static int mtk_reg_read(void *context,
 	for (i = 0; i < bytes; i++, val++)
 		*val = readb(addr + i);
 
-	return 0;
+	return bytes;
 }
 
 static int mtk_efuse_gpu_speedbin_pp(void *context, const char *id, int index,
diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 7b78f18f9545..50734489fb3a 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -56,10 +56,11 @@ static int mxs_ocotp_wait(struct mxs_ocotp *otp)
 	return 0;
 }
 
-static int mxs_ocotp_read(void *context, unsigned int offset,
-			  void *val, size_t bytes)
+static ssize_t mxs_ocotp_read(void *context, unsigned int offset,
+			      void *val, size_t bytes)
 {
 	struct mxs_ocotp *otp = context;
+	size_t bytes_read = bytes;
 	u32 *buf = val;
 	int ret;
 
@@ -102,7 +103,7 @@ static int mxs_ocotp_read(void *context, unsigned int offset,
 disable_clk:
 	clk_disable(otp->clk);
 
-	return ret;
+	return ret < 0 ? ret : bytes_read;
 }
 
 static struct nvmem_config ocotp_config = {
diff --git a/drivers/nvmem/nintendo-otp.c b/drivers/nvmem/nintendo-otp.c
index 355e7f1fc6d5..bcc5246517ae 100644
--- a/drivers/nvmem/nintendo-otp.c
+++ b/drivers/nvmem/nintendo-otp.c
@@ -45,8 +45,8 @@ static const struct nintendo_otp_devtype_data latte_otp_data = {
 	.num_banks = 8,
 };
 
-static int nintendo_otp_reg_read(void *context,
-				 unsigned int reg, void *_val, size_t bytes)
+static ssize_t nintendo_otp_reg_read(void *context,
+				     unsigned int reg, void *_val, size_t bytes)
 {
 	struct nintendo_otp_priv *priv = context;
 	u32 *val = _val;
@@ -61,7 +61,7 @@ static int nintendo_otp_reg_read(void *context,
 		reg += WORD_SIZE;
 	}
 
-	return 0;
+	return bytes;
 }
 
 static const struct of_device_id nintendo_otp_of_table[] = {
diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 9aa8f42faa4c..ac7e3b84b2ac 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -60,8 +60,8 @@ static bool sdam_is_ro(unsigned int offset, size_t len)
 	return false;
 }
 
-static int sdam_read(void *priv, unsigned int offset, void *val,
-				size_t bytes)
+static ssize_t sdam_read(void *priv, unsigned int offset, void *val,
+			 size_t bytes)
 {
 	struct sdam_chip *sdam = priv;
 	struct device *dev = sdam->sdam_config.dev;
@@ -78,11 +78,11 @@ static int sdam_read(void *priv, unsigned int offset, void *val,
 		dev_err(dev, "Failed to read SDAM offset %#x len=%zd, rc=%d\n",
 						offset, bytes, rc);
 
-	return rc;
+	return rc < 0 ? rc : bytes;
 }
 
-static int sdam_write(void *priv, unsigned int offset, void *val,
-				size_t bytes)
+static ssize_t sdam_write(void *priv, unsigned int offset, void *val,
+			  size_t bytes)
 {
 	struct sdam_chip *sdam = priv;
 	struct device *dev = sdam->sdam_config.dev;
@@ -105,7 +105,7 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
 		dev_err(dev, "Failed to write SDAM offset %#x len=%zd, rc=%d\n",
 						offset, bytes, rc);
 
-	return rc;
+	return rc < 0 ? rc : bytes;
 }
 
 static int sdam_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 116a39e804c7..4c40c23a92e7 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -251,10 +251,10 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
  *
  * Writes to fuses.  WARNING: THIS IS PERMANENT.
  *
- * Return: 0 or -err.
+ * Return: bytes written or -err.
  */
-static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
-			    size_t bytes)
+static ssize_t qfprom_reg_write(void *context, unsigned int reg, void *_val,
+				size_t bytes)
 {
 	struct qfprom_priv *priv = context;
 	struct qfprom_touched_values old;
@@ -314,11 +314,11 @@ static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
 exit_enabled_fuse_blowing:
 	qfprom_disable_fuse_blowing(priv, &old);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
-static int qfprom_reg_read(void *context,
-			unsigned int reg, void *_val, size_t bytes)
+static ssize_t qfprom_reg_read(void *context,
+			       unsigned int reg, void *_val, size_t bytes)
 {
 	struct qfprom_priv *priv = context;
 	u8 *val = _val;
@@ -331,7 +331,7 @@ static int qfprom_reg_read(void *context,
 	while (words--)
 		*val++ = readb(base + reg + i++);
 
-	return 0;
+	return bytes;
 }
 
 static void qfprom_runtime_disable(void *data)
diff --git a/drivers/nvmem/qoriq-efuse.c b/drivers/nvmem/qoriq-efuse.c
index e7fd04d6dd94..12a1e9d20e67 100644
--- a/drivers/nvmem/qoriq-efuse.c
+++ b/drivers/nvmem/qoriq-efuse.c
@@ -14,8 +14,8 @@ struct qoriq_efuse_priv {
 	void __iomem *base;
 };
 
-static int qoriq_efuse_read(void *context, unsigned int offset, void *val,
-			    size_t bytes)
+static ssize_t qoriq_efuse_read(void *context, unsigned int offset, void *val,
+				size_t bytes)
 {
 	struct qoriq_efuse_priv *priv = context;
 
@@ -24,7 +24,7 @@ static int qoriq_efuse_read(void *context, unsigned int offset, void *val,
 
 	/* Ignore trailing bytes (there shouldn't be any) */
 
-	return 0;
+	return bytes;
 }
 
 static int qoriq_efuse_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index 9ecf3873cbb7..7011b247a96b 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -214,11 +214,11 @@ rave_sp_eeprom_page_access(struct rave_sp_eeprom *eeprom,
  * arbitrary offset (not necessary page aligned) of arbitrary length
  * (is not constrained by EEPROM page size).
  *
- * Returns zero in case of success or negative error code in case of
- * failure.
+ * Returns number of bytes in case of success or negative error code
+ * in case of failure.
  */
-static int rave_sp_eeprom_access(struct rave_sp_eeprom *eeprom,
-				 enum rave_sp_eeprom_access_type type,
+static ssize_t rave_sp_eeprom_access(struct rave_sp_eeprom *eeprom,
+				     enum rave_sp_eeprom_access_type type,
 				 unsigned int offset, u8 *data,
 				 unsigned int data_len)
 {
@@ -267,18 +267,18 @@ static int rave_sp_eeprom_access(struct rave_sp_eeprom *eeprom,
 	} while (residue);
 out:
 	mutex_unlock(&eeprom->mutex);
-	return ret;
+	return ret < 0 ? ret : data_len;
 }
 
-static int rave_sp_eeprom_reg_read(void *eeprom, unsigned int offset,
-				   void *val, size_t bytes)
+static ssize_t rave_sp_eeprom_reg_read(void *eeprom, unsigned int offset,
+				       void *val, size_t bytes)
 {
 	return rave_sp_eeprom_access(eeprom, RAVE_SP_EEPROM_READ,
 				     offset, val, bytes);
 }
 
-static int rave_sp_eeprom_reg_write(void *eeprom, unsigned int offset,
-				    void *val, size_t bytes)
+static ssize_t rave_sp_eeprom_reg_write(void *eeprom, unsigned int offset,
+					void *val, size_t bytes)
 {
 	return rave_sp_eeprom_access(eeprom, RAVE_SP_EEPROM_WRITE,
 				     offset, val, bytes);
diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 752d0bf4445e..e8526438ce4a 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -17,8 +17,8 @@ struct rmem {
 	phys_addr_t size;
 };
 
-static int rmem_read(void *context, unsigned int offset,
-		     void *val, size_t bytes)
+static ssize_t rmem_read(void *context, unsigned int offset,
+			 void *val, size_t bytes)
 {
 	struct rmem *priv = context;
 	size_t available = priv->mem->size;
diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 2b40978ddb18..36cf62f534df 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -52,8 +52,8 @@ struct rockchip_efuse_chip {
 	struct clk *clk;
 };
 
-static int rockchip_rk3288_efuse_read(void *context, unsigned int offset,
-				      void *val, size_t bytes)
+static ssize_t rockchip_rk3288_efuse_read(void *context, unsigned int offset,
+					  void *val, size_t bytes)
 {
 	struct rockchip_efuse_chip *efuse = context;
 	u8 *buf = val;
@@ -65,6 +65,7 @@ static int rockchip_rk3288_efuse_read(void *context, unsigned int offset,
 		return ret;
 	}
 
+	ret = bytes;
 	writel(RK3288_LOAD | RK3288_PGENB, efuse->base + REG_EFUSE_CTRL);
 	udelay(1);
 	while (bytes--) {
@@ -89,11 +90,11 @@ static int rockchip_rk3288_efuse_read(void *context, unsigned int offset,
 
 	clk_disable_unprepare(efuse->clk);
 
-	return 0;
+	return ret;
 }
 
-static int rockchip_rk3328_efuse_read(void *context, unsigned int offset,
-				      void *val, size_t bytes)
+static ssize_t rockchip_rk3328_efuse_read(void *context, unsigned int offset,
+					  void *val, size_t bytes)
 {
 	struct rockchip_efuse_chip *efuse = context;
 	unsigned int addr_start, addr_end, addr_offset, addr_len;
@@ -144,11 +145,11 @@ static int rockchip_rk3328_efuse_read(void *context, unsigned int offset,
 nomem:
 	clk_disable_unprepare(efuse->clk);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
-static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
-				      void *val, size_t bytes)
+static ssize_t rockchip_rk3399_efuse_read(void *context, unsigned int offset,
+					  void *val, size_t bytes)
 {
 	struct rockchip_efuse_chip *efuse = context;
 	unsigned int addr_start, addr_end, addr_offset, addr_len;
@@ -200,7 +201,7 @@ static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
 
 	clk_disable_unprepare(efuse->clk);
 
-	return 0;
+	return bytes;
 }
 
 static struct nvmem_config econfig = {
diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index cb9aa5428350..54c4dbb2e57e 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -144,10 +144,11 @@ static int rockchip_otp_ecc_enable(struct rockchip_otp *otp, bool enable)
 	return ret;
 }
 
-static int px30_otp_read(void *context, unsigned int offset,
-			 void *val, size_t bytes)
+static ssize_t px30_otp_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
 {
 	struct rockchip_otp *otp = context;
+	size_t bytes_read = bytes;
 	u8 *buf = val;
 	int ret;
 
@@ -181,11 +182,11 @@ static int px30_otp_read(void *context, unsigned int offset,
 read_end:
 	writel(0x0 | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
 
-	return ret;
+	return ret < 0 ? ret : bytes_read;
 }
 
-static int rk3588_otp_read(void *context, unsigned int offset,
-			   void *val, size_t bytes)
+static ssize_t rk3588_otp_read(void *context, unsigned int offset,
+			       void *val, size_t bytes)
 {
 	struct rockchip_otp *otp = context;
 	unsigned int addr_start, addr_end, addr_len;
@@ -227,11 +228,11 @@ static int rk3588_otp_read(void *context, unsigned int offset,
 read_end:
 	kfree(buf);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
-static int rockchip_otp_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+static ssize_t rockchip_otp_read(void *context, unsigned int offset,
+				 void *val, size_t bytes)
 {
 	struct rockchip_otp *otp = context;
 	int ret;
@@ -249,7 +250,7 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 
 	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
 static struct nvmem_config otp_config = {
diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index 4e2ffefac96c..45a2da241271 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -121,7 +121,7 @@ static int sc27xx_efuse_poll_status(struct sc27xx_efuse *efuse, u32 bits)
 	return 0;
 }
 
-static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
+static ssize_t sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sc27xx_efuse *efuse = context;
 	u32 buf, blk_index = offset / SC27XX_EFUSE_BLOCK_WIDTH;
@@ -194,6 +194,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 	if (!ret) {
 		buf >>= blk_offset;
 		memcpy(val, &buf, bytes);
+		ret = bytes;
 	}
 
 	return ret;
diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
index 19799b3fe00a..dbacaab519e7 100644
--- a/drivers/nvmem/sec-qfprom.c
+++ b/drivers/nvmem/sec-qfprom.c
@@ -20,7 +20,7 @@ struct sec_qfprom {
 	struct device *dev;
 };
 
-static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
+static ssize_t sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
 {
 	struct sec_qfprom *priv = context;
 	unsigned int i;
@@ -40,7 +40,7 @@ static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size
 		val[i] = tmp[reg & 3];
 	}
 
-	return 0;
+	return bytes;
 }
 
 static int sec_qfprom_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 89c27112320f..6b02d69f7158 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -50,8 +50,8 @@ static const struct snvs_lpgpr_cfg snvs_lpgpr_cfg_imx7d = {
 	.size		= 16,
 };
 
-static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
-			    size_t bytes)
+static ssize_t snvs_lpgpr_write(void *context, unsigned int offset, void *val,
+				size_t bytes)
 {
 	struct snvs_lpgpr_priv *priv = context;
 	const struct snvs_lpgpr_cfg *dcfg = priv->dcfg;
@@ -72,18 +72,23 @@ static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
 	if (lock_reg & IMX_GPR_HL)
 		return -EPERM;
 
-	return regmap_bulk_write(priv->regmap, dcfg->offset + offset, val,
+	ret = regmap_bulk_write(priv->regmap, dcfg->offset + offset, val,
 				bytes / 4);
+
+	return ret < 0 ? ret : bytes;
 }
 
-static int snvs_lpgpr_read(void *context, unsigned int offset, void *val,
-			   size_t bytes)
+static ssize_t snvs_lpgpr_read(void *context, unsigned int offset, void *val,
+			       size_t bytes)
 {
 	struct snvs_lpgpr_priv *priv = context;
 	const struct snvs_lpgpr_cfg *dcfg = priv->dcfg;
+	int ret;
 
-	return regmap_bulk_read(priv->regmap, dcfg->offset + offset,
+	ret = regmap_bulk_read(priv->regmap, dcfg->offset + offset,
 			       val, bytes / 4);
+
+	return ret < 0 ? ret : bytes;
 }
 
 static int snvs_lpgpr_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 1a7e4e5d8b86..54f1e210d3d4 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -291,7 +291,7 @@ static int sprd_efuse_raw_read(struct sprd_efuse *efuse, int blk, u32 *val,
 	return 0;
 }
 
-static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
+static ssize_t sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sprd_efuse *efuse = context;
 	bool blk_double = efuse->data->blk_double;
@@ -318,10 +318,10 @@ static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 
 unlock:
 	sprd_efuse_unlock(efuse);
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
-static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
+static ssize_t sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sprd_efuse *efuse = context;
 	bool blk_double = efuse->data->blk_double;
@@ -355,7 +355,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 
 unlock:
 	sprd_efuse_unlock(efuse);
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
 static int sprd_efuse_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/stm32-bsec-optee-ta.c b/drivers/nvmem/stm32-bsec-optee-ta.c
index f89ce791dd12..d2a93bfe80e5 100644
--- a/drivers/nvmem/stm32-bsec-optee-ta.c
+++ b/drivers/nvmem/stm32-bsec-optee-ta.c
@@ -136,8 +136,8 @@ void stm32_bsec_optee_ta_close(void *ctx)
 }
 
 /* stm32_bsec_optee_ta_read() - nvmem read access using PTA client driver */
-int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
-			     void *buf, size_t bytes)
+ssize_t stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
+				 void *buf, size_t bytes)
 {
 	struct tee_shm *shm;
 	struct tee_ioctl_invoke_arg arg;
@@ -198,12 +198,12 @@ int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
 out_tee_session:
 	stm32_bsec_ta_close_session(ctx, session_id);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
 /* stm32_bsec_optee_ta_write() - nvmem write access using PTA client driver */
-int stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
-			      unsigned int offset, void *buf, size_t bytes)
+ssize_t stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
+				  unsigned int offset, void *buf, size_t bytes)
 {	struct tee_shm *shm;
 	struct tee_ioctl_invoke_arg arg;
 	struct tee_param param[2];
@@ -294,5 +294,5 @@ int stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
 out_tee_session:
 	stm32_bsec_ta_close_session(ctx, session_id);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
diff --git a/drivers/nvmem/stm32-bsec-optee-ta.h b/drivers/nvmem/stm32-bsec-optee-ta.h
index 3966a0535179..c96cfde9b0f0 100644
--- a/drivers/nvmem/stm32-bsec-optee-ta.h
+++ b/drivers/nvmem/stm32-bsec-optee-ta.h
@@ -33,10 +33,10 @@ void stm32_bsec_optee_ta_close(void *ctx);
  * @bytes: number of bytes to read
  *
  * Return:
- *	On success, 0. On failure, -errno.
+ *	On success, bytes read. On failure, -errno.
  */
-int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
-			     void *buf, size_t bytes);
+ssize_t stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
+				 void *buf, size_t bytes);
 
 /**
  * stm32_bsec_optee_ta_write() - nvmem write access using TA client driver
@@ -47,10 +47,10 @@ int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
  * @bytes: number of bytes to write
  *
  * Return:
- *	On success, 0. On failure, -errno.
+ *	On success, bytes written. On failure, -errno.
  */
-int stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
-			      unsigned int offset, void *buf, size_t bytes);
+ssize_t stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
+				  unsigned int offset, void *buf, size_t bytes);
 
 #else
 
@@ -63,15 +63,15 @@ static inline void stm32_bsec_optee_ta_close(void *ctx)
 {
 }
 
-static inline int stm32_bsec_optee_ta_read(struct tee_context *ctx,
-					   unsigned int offset, void *buf,
+static inline ssize_t stm32_bsec_optee_ta_read(struct tee_context *ctx,
+					       unsigned int offset, void *buf,
 					   size_t bytes)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int stm32_bsec_optee_ta_write(struct tee_context *ctx,
-					    unsigned int lower,
+static inline ssize_t stm32_bsec_optee_ta_write(struct tee_context *ctx,
+						unsigned int lower,
 					    unsigned int offset, void *buf,
 					    size_t bytes)
 {
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 82879b1c9eb9..aed620af788c 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -40,8 +40,8 @@ struct stm32_romem_priv {
 	struct tee_context *ctx;
 };
 
-static int stm32_romem_read(void *context, unsigned int offset, void *buf,
-			    size_t bytes)
+static ssize_t stm32_romem_read(void *context, unsigned int offset, void *buf,
+				size_t bytes)
 {
 	struct stm32_romem_priv *priv = context;
 	u8 *buf8 = buf;
@@ -50,7 +50,7 @@ static int stm32_romem_read(void *context, unsigned int offset, void *buf,
 	for (i = offset; i < offset + bytes; i++)
 		*buf8++ = readb_relaxed(priv->base + i);
 
-	return 0;
+	return bytes;
 }
 
 static int stm32_bsec_smc(u8 op, u32 otp, u32 data, u32 *result)
@@ -71,8 +71,8 @@ static int stm32_bsec_smc(u8 op, u32 otp, u32 data, u32 *result)
 #endif
 }
 
-static int stm32_bsec_read(void *context, unsigned int offset, void *buf,
-			   size_t bytes)
+static ssize_t stm32_bsec_read(void *context, unsigned int offset, void *buf,
+			       size_t bytes)
 {
 	struct stm32_romem_priv *priv = context;
 	struct device *dev = priv->cfg.dev;
@@ -115,11 +115,11 @@ static int stm32_bsec_read(void *context, unsigned int offset, void *buf,
 		skip_bytes = 0;
 	}
 
-	return 0;
+	return j;
 }
 
-static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
-			    size_t bytes)
+static ssize_t stm32_bsec_write(void *context, unsigned int offset, void *buf,
+				size_t bytes)
 {
 	struct stm32_romem_priv *priv = context;
 	struct device *dev = priv->cfg.dev;
@@ -142,19 +142,19 @@ static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
 	if (offset + bytes >= priv->lower * 4)
 		dev_warn(dev, "Update of upper OTPs with ECC protection (word programming, only once)\n");
 
-	return 0;
+	return bytes;
 }
 
-static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
-			       size_t bytes)
+static ssize_t stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
+				   size_t bytes)
 {
 	struct stm32_romem_priv *priv = context;
 
 	return stm32_bsec_optee_ta_read(priv->ctx, offset, buf, bytes);
 }
 
-static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
-				size_t bytes)
+static ssize_t stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
+				    size_t bytes)
 {
 	struct stm32_romem_priv *priv = context;
 
diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 38f5d9df39cd..7bda128bb93e 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -114,7 +114,7 @@ static int sp_otp_read_real(struct sp_ocotp_priv *otp, int addr, char *value)
 	return ret;
 }
 
-static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t bytes)
+static ssize_t sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t bytes)
 {
 	struct sp_ocotp_priv *otp = priv;
 	unsigned int addr;
@@ -140,7 +140,7 @@ static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t by
 disable_clk:
 	clk_disable(otp->clk);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
 static struct nvmem_config sp_ocotp_nvmem_config = {
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index ba14a76208ab..0133263d2adb 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -36,8 +36,8 @@ struct sunxi_sid {
 	u32			value_offset;
 };
 
-static int sunxi_sid_read(void *context, unsigned int offset,
-			  void *val, size_t bytes)
+static ssize_t sunxi_sid_read(void *context, unsigned int offset,
+			      void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
 	u32 word;
@@ -56,7 +56,7 @@ static int sunxi_sid_read(void *context, unsigned int offset,
 	word = readl_relaxed(sid->base + sid->value_offset + offset);
 	memcpy(val, &word, bytes);
 
-	return 0;
+	return bytes;
 }
 
 static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
@@ -90,10 +90,11 @@ static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
  * to be not reliable at all.
  * Read by the registers instead.
  */
-static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
-				 void *val, size_t bytes)
+static ssize_t sun8i_sid_read_by_reg(void *context, unsigned int offset,
+				     void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
+	size_t bytes_read = bytes;
 	u32 word;
 	int ret;
 
@@ -109,7 +110,7 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 	}
 
 	if (!bytes)
-		return 0;
+		return bytes_read;
 
 	/* Handle any trailing bytes */
 	ret = sun8i_sid_register_readout(sid, offset, &word);
@@ -118,7 +119,7 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 
 	memcpy(val, &word, bytes);
 
-	return 0;
+	return bytes_read;
 }
 
 static int sunxi_sid_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index befbab156cda..2288a2891bb2 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -47,8 +47,8 @@ struct u_boot_env_image_broadcom {
 	DECLARE_FLEX_ARRAY(uint8_t, data);
 } __packed;
 
-static int u_boot_env_read(void *context, unsigned int offset, void *val,
-			   size_t bytes)
+static ssize_t u_boot_env_read(void *context, unsigned int offset, void *val,
+			       size_t bytes)
 {
 	struct u_boot_env *priv = context;
 	struct device *dev = priv->dev;
@@ -66,7 +66,7 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 		return -EIO;
 	}
 
-	return 0;
+	return bytes_read;
 }
 
 static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
index 6ad3295d3195..a6c28e03adc2 100644
--- a/drivers/nvmem/uniphier-efuse.c
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -16,8 +16,8 @@ struct uniphier_efuse_priv {
 	void __iomem *base;
 };
 
-static int uniphier_reg_read(void *context,
-			     unsigned int reg, void *_val, size_t bytes)
+static ssize_t uniphier_reg_read(void *context,
+				 unsigned int reg, void *_val, size_t bytes)
 {
 	struct uniphier_efuse_priv *priv = context;
 	u8 *val = _val;
@@ -26,7 +26,7 @@ static int uniphier_reg_read(void *context,
 	for (offs = 0; offs < bytes; offs += sizeof(u8))
 		*val++ = readb(priv->base + reg + offs);
 
-	return 0;
+	return bytes;
 }
 
 static int uniphier_efuse_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index ee9c61ae727d..4e2bdb38305d 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -143,11 +143,12 @@ static int vf610_get_fuse_address(int base_addr_offset)
 	return -EINVAL;
 }
 
-static int vf610_ocotp_read(void *context, unsigned int offset,
-			void *val, size_t bytes)
+static ssize_t vf610_ocotp_read(void *context, unsigned int offset,
+				void *val, size_t bytes)
 {
 	struct vf610_ocotp *ocotp = context;
 	void __iomem *base = ocotp->base;
+	size_t bytes_read = bytes;
 	u32 reg, *buf = val;
 	int fuse_addr;
 	int ret;
@@ -193,7 +194,7 @@ static int vf610_ocotp_read(void *context, unsigned int offset,
 		offset += 4;
 	}
 
-	return 0;
+	return bytes_read;
 }
 
 static struct nvmem_config ocotp_config = {
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 8682adaacd69..1502d4998159 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -56,8 +56,8 @@ struct xilinx_efuse {
 	u32 pufuserfuse;
 };
 
-static int zynqmp_efuse_access(void *context, unsigned int offset,
-			       void *val, size_t bytes, enum efuse_access flag,
+static ssize_t zynqmp_efuse_access(void *context, unsigned int offset,
+				   void *val, size_t bytes, enum efuse_access flag,
 			       unsigned int pufflag)
 {
 	struct device *dev = context;
@@ -140,10 +140,10 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
 	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
 			  efuse, dma_addr);
 
-	return ret;
+	return ret < 0 ? ret : bytes;
 }
 
-static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
+static ssize_t zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
 {
 	struct device *dev = context;
 	int ret;
@@ -166,6 +166,7 @@ static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size
 
 		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
 		*(int *)val = version & SILICON_REVISION_MASK;
+		ret = SOC_VER_SIZE;
 		break;
 	/* Efuse offset starts from 0xc */
 	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
@@ -182,8 +183,8 @@ static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size
 	return ret;
 }
 
-static int zynqmp_nvmem_write(void *context,
-			      unsigned int offset, void *val, size_t bytes)
+static ssize_t zynqmp_nvmem_write(void *context,
+				  unsigned int offset, void *val, size_t bytes)
 {
 	int pufflag = 0;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3ebeaa0ded00..f7e83a59aa2f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -16,9 +16,9 @@
 #include <linux/gpio/consumer.h>
 
 struct nvmem_device;
-typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
+typedef ssize_t (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
-typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
+typedef ssize_t (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
 typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
-- 
2.44.0.769.g3c40516874-goog


