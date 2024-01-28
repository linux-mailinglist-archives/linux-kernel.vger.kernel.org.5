Return-Path: <linux-kernel+bounces-41967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E06A83FA1F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6252820E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9593C470;
	Sun, 28 Jan 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="neVF0c65"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1C25772
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477245; cv=none; b=AD0pS5HfZBhnrMoHYH6Cop4KWF+gTBG+KKnTAR6Na0gHAFnNNpHa2GKj/JCSpJRFF4KUkLUPQCve2MUY8EbPMcp4oqhhZlNZWpUI2zCBaAox4KJ8SwAWmfeFNMHSnq3uvH9HuYnus8nQYB+03LnJNKFtsjyx2FLoctAuJZiBitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477245; c=relaxed/simple;
	bh=5BDRz7/kXrA/SKMGZUudnZHtf0X1AaM/GMriOO/cC7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gapXP5+CwlCgHwNPUGCO5Mmdx94DMQISDOctwSiFge8/q9YBeNl0UjqeN2nORPHncoX5WVNe+Y1CDFYlNnkyvdMyp5d873yYrd2pGRFO8Rzt1RaZZrW3Xrr9tKt2targ+3lJI51eyXNHt/DWx0xB8cg9ZpqOjyCQRmt9z7sNKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=neVF0c65; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ef6da20feso1410985e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706477241; x=1707082041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2SAo9LdnR8uwhVnCuLDyqIe/++QGHcrtzG7xwQ0BCc=;
        b=neVF0c65R4jKbWs4kZX7/29HFelgX27F3iEMFyhjxSNH4qaxYdnpFP3/IQwnKC4OnL
         +gOigw9+rCf5Q/TX/QXuc1rQe9KU4CGSv2xOgkmxtD23YcscCDW1sz1HO+N50gHB/H3f
         AsACgi+PGQPb2G5En5J4lJcGjuNe/roqEN+M/2YGxFX7jvjZ6hG/FaxvrK5LxiKbLNs8
         OYJ8kihxeRJN7Mtz/jNxpnmmjNYJoqBkz+JGziW75FUM2tT/KzSAAjjYFri331rRoifq
         6n/7aZ7wc1TJwyr44bjD2OTaViavLakGRe7qyR3RFfBY316wj7T8aKLQdZn02599ASUo
         FYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706477241; x=1707082041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2SAo9LdnR8uwhVnCuLDyqIe/++QGHcrtzG7xwQ0BCc=;
        b=XvE4/SbuT/GDNPwrJnfsf3LHxLSzRwCHxS6KKxL9Fted6trbswQzMUDcqzTIeev7nU
         uelDGuF8m5bs5+h2155xMbVm4dtb0fguxlcjSLpMJyskIuke+3KsfSnz9Y2P02NjkqUl
         huc/5vTOXQo7HuDe+UQQZApWEWb1+hBAtPfUM75gShDT/MCZoZUpcqYUob119bFXfnF0
         GtjVvKlm7WxqVXLc1eoC21nmNZeJDGIv3wBOomLk4t63nPjcPubnTQm6709c4+tVW84j
         uKHrFQrKdzZPfl61pZCZ74r9Xk22Oj+kv4LZKn1EOiAoPwx+jSTsABcPtjgeKAn5Y3Vj
         5G8Q==
X-Gm-Message-State: AOJu0YxPM9IPONvLEtNe2Rboaksbx8bH9wX8aXxtgU6eGm0PpNXnIMZR
	2pXH3YAnmIQI/vxGvw2Mz5VC8ypzmwcyRZ2yzEM15XSBzovlBrvV9NzDZnWRc/s=
X-Google-Smtp-Source: AGHT+IH7I/Y0oeuRogEAXZZ4W+1eugSgt+2idcW2aYyaWuUEipfC6kDbb4se7qMFvg/EplAlKYj8Nw==
X-Received: by 2002:a05:600c:1d1b:b0:40e:9fd3:6b75 with SMTP id l27-20020a05600c1d1b00b0040e9fd36b75mr2971518wms.2.1706477241698;
        Sun, 28 Jan 2024 13:27:21 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d62f89381sm8218208wmo.35.2024.01.28.13.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 13:27:21 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	biao.lu@intel.com,
	linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/4] tsm: Add RTMRs to the configfs-tsm hierarchy
Date: Sun, 28 Jan 2024 22:25:21 +0100
Message-ID: <20240128212532.2754325-3-sameo@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240128212532.2754325-1-sameo@rivosinc.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTMRs are defined and managed by their corresponding TSM provider. As
such, they can be configured through the TSM configfs root.

An additional `rtmrs` directory is added by default under the `tsm` one,
where each supported RTMR can be configured:

mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index

An RTMR can not be extended nor read before its configured by assigning
it an index. It is the TSM backend responsibility and choice to map that
index to a hardware RTMR.

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 Documentation/ABI/testing/configfs-tsm |  11 ++
 drivers/virt/coco/tsm.c                | 164 +++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index dd24202b5ba5..590e103a9bcd 100644
--- a/Documentation/ABI/testing/configfs-tsm
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -80,3 +80,14 @@ Contact:	linux-coco@lists.linux.dev
 Description:
 		(RO) Indicates the minimum permissible value that can be written
 		to @privlevel.
+
+What:		/sys/kernel/config/tsm/rtmrs/$name/index
+Date:		January, 2024
+KernelVersion:	v6.8
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) A Runtime Measurement Register (RTMR) hardware index.
+                Once created under /sys/kernel/config/tsm/rtmrs/, an RTMR entry
+                can be mapped to a hardware RTMR by writing into its index
+                attribute. The TSM provider will then map the configfs entry to
+                its corresponding hardware register.
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 1a8c3c096120..bb9ed2d2accc 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -419,6 +419,108 @@ static const struct config_item_type tsm_reports_type = {
 	.ct_group_ops = &tsm_report_group_ops,
 };
 
+static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
+				    const char *buf, size_t len)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+	const struct tsm_ops *ops;
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+
+	/* Index can only be configured once */
+	if (is_rtmr_configured(rtmr_state))
+		return -EBUSY;
+
+	/* Check that index stays within the TSM provided capabilities */
+	ops = provider.ops;
+	if (!ops)
+		return -ENOTTY;
+
+	if (val > ops->capabilities.num_rtmrs - 1)
+		return -EINVAL;
+
+	/* Check that this index is available */
+	if (tsm_rtmrs->rtmrs[val])
+		return -EINVAL;
+
+	rtmr_state->index = val;
+	rtmr_state->alg = ops->capabilities.rtmrs[val].hash_alg;
+
+	tsm_rtmrs->rtmrs[val] = rtmr_state;
+
+	return len;
+}
+
+static ssize_t tsm_rtmr_index_show(struct config_item *cfg,
+				   char *buf)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+
+	guard(rwsem_read)(&tsm_rwsem);
+
+	/* An RTMR is not available if it has not been configured */
+	if (!is_rtmr_configured(rtmr_state))
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%u\n", rtmr_state->index);
+}
+CONFIGFS_ATTR(tsm_rtmr_, index);
+
+static struct configfs_attribute *tsm_rtmr_attrs[] = {
+	&tsm_rtmr_attr_index,
+	NULL,
+};
+
+static void tsm_rtmr_item_release(struct config_item *cfg)
+{
+	struct tsm_rtmr_state *state = to_tsm_rtmr_state(cfg);
+
+	kfree(state);
+}
+
+static struct configfs_item_operations tsm_rtmr_item_ops = {
+	.release = tsm_rtmr_item_release,
+};
+
+const struct config_item_type tsm_rtmr_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = tsm_rtmr_attrs,
+	.ct_item_ops = &tsm_rtmr_item_ops,
+};
+
+static struct config_item *tsm_rtmrs_make_item(struct config_group *group,
+					       const char *name)
+{
+	struct tsm_rtmr_state *state;
+
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!(provider.ops && (provider.ops->capabilities.num_rtmrs > 0)))
+		return ERR_PTR(-ENXIO);
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+	state->index = U32_MAX;
+
+	config_item_init_type_name(&state->cfg, name, &tsm_rtmr_type);
+	return &state->cfg;
+}
+
+static struct configfs_group_operations tsm_rtmrs_group_ops = {
+	.make_item = tsm_rtmrs_make_item,
+};
+
+static const struct config_item_type tsm_rtmrs_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_group_ops = &tsm_rtmrs_group_ops,
+};
+
 static const struct config_item_type tsm_root_group_type = {
 	.ct_owner = THIS_MODULE,
 };
@@ -433,10 +535,48 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
+static int tsm_rtmr_register(const struct tsm_ops *ops)
+{
+	struct config_group *rtmrs_group;
+
+	lockdep_assert_held_write(&tsm_rwsem);
+
+	if (!ops || !ops->capabilities.num_rtmrs)
+		return 0;
+
+	if (ops->capabilities.num_rtmrs > TSM_MAX_RTMR)
+		return -EINVAL;
+
+	tsm_rtmrs = kzalloc(sizeof(struct tsm_rtmrs_state), GFP_KERNEL);
+	if (!tsm_rtmrs)
+		return -ENOMEM;
+
+	tsm_rtmrs->rtmrs = kcalloc(ops->capabilities.num_rtmrs,
+				   sizeof(struct tsm_rtmr_state *),
+				   GFP_KERNEL);
+	if (!tsm_rtmrs->rtmrs) {
+		kfree(tsm_rtmrs);
+		return -ENOMEM;
+	}
+
+	rtmrs_group = configfs_register_default_group(&tsm_configfs.su_group, "rtmrs",
+						      &tsm_rtmrs_type);
+	if (IS_ERR(rtmrs_group)) {
+		kfree(tsm_rtmrs->rtmrs);
+		kfree(tsm_rtmrs);
+		return PTR_ERR(rtmrs_group);
+	}
+
+	tsm_rtmrs->group = rtmrs_group;
+
+	return 0;
+}
+
 int tsm_register(const struct tsm_ops *ops, void *priv,
 		 const struct config_item_type *type)
 {
 	const struct tsm_ops *conflict;
+	int rc;
 
 	if (!type)
 		type = &tsm_report_default_type;
@@ -450,6 +590,10 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 		return -EBUSY;
 	}
 
+	rc = tsm_rtmr_register(ops);
+	if (rc < 0)
+		return rc;
+
 	provider.ops = ops;
 	provider.data = priv;
 	provider.type = type;
@@ -457,11 +601,31 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 }
 EXPORT_SYMBOL_GPL(tsm_register);
 
+static int tsm_rtmr_unregister(const struct tsm_ops *ops)
+{
+	lockdep_assert_held_write(&tsm_rwsem);
+
+	if ((ops) && (ops->capabilities.num_rtmrs > 0)) {
+		configfs_unregister_default_group(tsm_rtmrs->group);
+		kfree(tsm_rtmrs->rtmrs);
+		kfree(tsm_rtmrs);
+	}
+
+	return 0;
+}
+
 int tsm_unregister(const struct tsm_ops *ops)
 {
+	int rc;
+
 	guard(rwsem_write)(&tsm_rwsem);
 	if (ops != provider.ops)
 		return -EBUSY;
+
+	rc = tsm_rtmr_unregister(ops);
+	if (rc < 0)
+		return rc;
+
 	provider.ops = NULL;
 	provider.data = NULL;
 	provider.type = NULL;
-- 
2.42.0


