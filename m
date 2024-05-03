Return-Path: <linux-kernel+bounces-168016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267D8BB275
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23A428274D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FE158A32;
	Fri,  3 May 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VV16mmnS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD2158A04
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760109; cv=none; b=JXsUJBdBb5jN0j5bGjOdG7uSaxIYiqV+526hoDIZGQ4Wdka4d/jfBIrRKvg0nggv3ACsVMr6dY+Az0kErB0AogZZsr1qSbHayOMJXo/8uc2hVEaEGjINuuXti8LjhoLjhTR/QWOMTVMLhPjJNAh1JFcSBTUO5lqfluEg5U2dt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760109; c=relaxed/simple;
	bh=Nc9hNE58BK51xhK8ILsD1cIi3UtQvYLTsi34vGY1x6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvJkL2YJyNG/rKnC028+mQaFi3VzcTwXREHvz6LNs9U8U/Oyfm01sJM5cWnn4o/Gt6J7FFE6yYtO2PaqcKe27McTQceJYAG/9BYoTCVPtW8Jn5zMhWj6UmsaTiYsbuTyGWsBosbfR4rqQRA4l3A/Rb7zWphH8uHkDRMOI6/sRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VV16mmnS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e20f2db068so19398791fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714760106; x=1715364906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skHQQr6/l6kfvwJ0x7uA/O7xeOEy9Dekh3cEjjcSscA=;
        b=VV16mmnSGsFoMaxFz7GxDJZpmsdrqFdZblUpXGV84caBijoV9Fr9dmrhwyWzmsQjyw
         celEPUlW14kEe3CAPim3zHMT+yXDSBOU+xzA3IqiwV4AnddegqIrWoLQGyTdqE9KDtV2
         UrfiojxnsO+VlsfcPwL1tDHopHF847albTx5hXfPdx8usbJu0BPUO7fhvguSnovjR1K1
         Uq5w9epgu7d3oDQubQ9rkjlB1jP77NKfrsZxfOkoXc446cY+iNm2QmdPrizV+xtIXN2x
         jfhWNtvmAbnIYKmVQWvbAsrfUEbmLDAOMwCmeWtmM+ST4t0cXHbzO9NpPv0QG5EHf8pJ
         SpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760106; x=1715364906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skHQQr6/l6kfvwJ0x7uA/O7xeOEy9Dekh3cEjjcSscA=;
        b=ko9qbJ+k5TLhe7h2/ncnaXhNiROAoinF0L742PQ1uEVnJ3hJkS+5UiZLwjusYhkKOH
         zD6KuwIlXg2lcShsqrDjDGXmvRG+yhPm8bLEWc2oOtIWn/A/uiFQagDiH2RrJlbJ+Ls0
         B8/iaEgWfyWmZSbN860Hiq2ed2KifeDvHdm2s5t5QjRzs/zZ0z6yhIGNVpJnfGMMJDB2
         /xK9ywicDCR3Tffq8vR3yWz83FZ65oY1BYWYdTEi6Iakrg0oZQtZuorpCrSt8YX6tnFD
         Fs5rE5G1PkLjQTWZvrE2m6Psr0pXaRjlHHtD975sNus+jYcErmuGHTOnE7bjcOL3DZuT
         sJ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUtFKvZW+iJSycKVx2OwOb9FzVGlfgSRTvSlrPp91XcwIgqJjdv8dxVDMjcJQZJAYu6YCjmv1DvhPyO029SgwuWKB+XZ1nLl7CbPZaY
X-Gm-Message-State: AOJu0YxU8fBYPPG1CCrnLblBEvcwC9/2BwRo/Odixf9VXiSS7jUC6nfj
	zm8/EFk7j0SpX/wH4k7tD7khPM1d68vuN2kKhiaJ3gHK39MsHWPMtCBhwZedOg8=
X-Google-Smtp-Source: AGHT+IErLUvCTp3mZM1tRLp0DEFt22pumkf6pfZD/UceDRcKf1yCaB01xmYu/WOUEodg5n3tjuKMxg==
X-Received: by 2002:a2e:9b0e:0:b0:2e2:1bbd:4ffb with SMTP id u14-20020a2e9b0e000000b002e21bbd4ffbmr2103527lji.22.1714760106046;
        Fri, 03 May 2024 11:15:06 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s7-20020a2e9c07000000b002de118decbbsm605548lji.53.2024.05.03.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:15:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 03 May 2024 21:15:03 +0300
Subject: [PATCH v2 1/2] drm/msm/gen_header: allow skipping the validation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-fd-fix-lxml-v2-1-f80a60ce21a1@linaro.org>
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
In-Reply-To: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Helen Koike <helen.koike@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4120;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Nc9hNE58BK51xhK8ILsD1cIi3UtQvYLTsi34vGY1x6w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmNSmozOG/joa4cqDUWD1VjN9wTEAvsB5eq+xk7
 QAdsumPRPmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZjUpqAAKCRCLPIo+Aiko
 1Q9xB/4iDrSSvTmfXNCsFiLTo2477qXgJzXMHzCiAUJ9v03lU5+MFosDd5wVJErlvq797qkByIr
 Nv7ifu0ag+lYSh86wjxBD5xwxH2ZSgBEwVMsnQFj+1e9MZq8/peQGsVndUnWKI61SSmVvp9Z5A1
 ywoG0u0V3fMcnx79xqJo2VgZGzHgQPusIQDG0E48uVgh8e2MBAFj/9DGrkFIoHy/ai5xXNKFz5X
 0yQq0Jt/7ZrNf4Yq4WBM0FiwlxnSjr9N7Ikl4USl2QeNe8UGBSEF5hB6Ycz84We1Py7A89I5grd
 BARXj1ORVR0Ce0H4u3/ZLZXonu5IvO/scRi5LnPu8VhwP1N2
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

We don't need to run the validation of the XML files if we are just
compiling the kernel. Skip the validation unless the user enables
corresponding Kconfig option. This removes a warning from gen_header.py
about lxml being not installed.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240409120108.2303d0bd@canb.auug.org.au/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/Kconfig                 |  8 ++++++++
 drivers/gpu/drm/msm/Makefile                |  9 ++++++++-
 drivers/gpu/drm/msm/registers/gen_header.py | 14 +++++++++++---
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index f202f26adab2..4c9bf237d4a2 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -54,6 +54,14 @@ config DRM_MSM_GPU_SUDO
 	  Only use this if you are a driver developer.  This should *not*
 	  be enabled for production kernels.  If unsure, say N.
 
+config DRM_MSM_VALIDATE_XML
+	bool "Validate XML register files against schema"
+	depends on DRM_MSM && EXPERT
+	depends on $(success,$(PYTHON3) -c "import lxml")
+	help
+	  Validate XML files with register definitions against rules-fd schema.
+	  This option is mostly targeting DRM MSM developers. If unsure, say N.
+
 config DRM_MSM_MDSS
 	bool
 	depends on DRM_MSM
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index c861de58286c..718968717ad5 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -156,8 +156,15 @@ msm-y += $(adreno-y) $(msm-display-y)
 
 obj-$(CONFIG_DRM_MSM)	+= msm.o
 
+ifeq (y,$(CONFIG_DRM_MSM_VALIDATE_XML))
+	headergen-opts += --validate
+else
+	headergen-opts += --no-validate
+endif
+
 quiet_cmd_headergen = GENHDR  $@
-      cmd_headergen = mkdir -p $(obj)/generated && $(PYTHON3) $(srctree)/$(src)/registers/gen_header.py --rnn $(srctree)/$(src)/registers --xml $< c-defines > $@
+      cmd_headergen = mkdir -p $(obj)/generated && $(PYTHON3) $(srctree)/$(src)/registers/gen_header.py \
+		      $(headergen-opts) --rnn $(srctree)/$(src)/registers --xml $< c-defines > $@
 
 $(obj)/generated/%.xml.h: $(src)/registers/adreno/%.xml \
 		$(src)/registers/adreno/adreno_common.xml \
diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/gpu/drm/msm/registers/gen_header.py
index 90d5c2991d05..fc3bfdc991d2 100644
--- a/drivers/gpu/drm/msm/registers/gen_header.py
+++ b/drivers/gpu/drm/msm/registers/gen_header.py
@@ -538,6 +538,9 @@ class Parser(object):
 		self.variants.add(reg.domain)
 
 	def do_validate(self, schemafile):
+		if self.validate == False:
+			return
+
 		try:
 			from lxml import etree
 
@@ -567,7 +570,10 @@ class Parser(object):
 			if not xmlschema.validate(xml_doc):
 				error_str = str(xmlschema.error_log.filter_from_errors()[0])
 				raise self.error("Schema validation failed for: " + filename + "\n" + error_str)
-		except ImportError:
+		except ImportError as e:
+			if self.validate:
+				raise e
+
 			print("lxml not found, skipping validation", file=sys.stderr)
 
 	def do_parse(self, filename):
@@ -586,9 +592,10 @@ class Parser(object):
 		self.stack.pop()
 		file.close()
 
-	def parse(self, rnn_path, filename):
+	def parse(self, rnn_path, filename, validate):
 		self.path = rnn_path
 		self.stack = []
+		self.validate = validate
 		self.do_parse(filename)
 
 	def parse_reg(self, attrs, bit_size):
@@ -853,7 +860,7 @@ def dump_c(args, guard, func):
 	p = Parser()
 
 	try:
-		p.parse(args.rnn, args.xml)
+		p.parse(args.rnn, args.xml, args.validate)
 	except Error as e:
 		print(e, file=sys.stderr)
 		exit(1)
@@ -941,6 +948,7 @@ def main():
 	parser = argparse.ArgumentParser()
 	parser.add_argument('--rnn', type=str, required=True)
 	parser.add_argument('--xml', type=str, required=True)
+	parser.add_argument('--validate', action=argparse.BooleanOptionalAction)
 
 	subparsers = parser.add_subparsers()
 	subparsers.required = True

-- 
2.39.2


