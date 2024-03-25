Return-Path: <linux-kernel+bounces-116947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8249388B1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F713BA6F18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCBA16ABE3;
	Mon, 25 Mar 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c/cQZre1"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AD1C5AB6;
	Mon, 25 Mar 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366313; cv=none; b=eTonxTBwtpJafamVBR6tPLLbMQ63QPLrsS3H2iN64x6c+KoajhXC6RronJsDspmqAg5yGWCssMMNxNLX3j15cSfoXdiOQrefQHcV6AO/R6yhV4NMpftFPHNY+3eDj/7yHTUgV4J/SfKinTjshxBS7K2HZyqBZYkUZpR+P7aYgLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366313; c=relaxed/simple;
	bh=8wIa6nW1ERiw4t1Ybn1tnOi5l/VyBjBAJ/xBmZH1cd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCzzjwlwlueN5ARxAYSPX8yoffMVKmxeoz7K0SyBEMueofQm/W+6JFWfj5zn1c3zbxNhhdkaxTxNziQmBO2ykdl/IMc27ZsAkcNTcftmQVy0/MUIhDXMrHvlFndrx3rKzA3bbNo/4TRmFr55S6/4GbMdRM3QMTBRCbqJSCDiZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c/cQZre1; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P4qkf4007553;
	Mon, 25 Mar 2024 06:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Ve6q53KNEyaHYsEeYneEssGZ6Wrn16sSu1b7bPPggrU=; b=
	c/cQZre1an3oq7WNRPOSd+tbcrU3woSndVth5uiXREO/unhZ67BkwsC7nUkoWDVn
	FkjLlg6HYnSw6CHI9AGZtBO4e8PUfV9Q6kWBG+CUnWpLrePIw9dGN5IP0NHXbLIh
	oL0RGNzh+KbWLzo4/smOX5PsJr/4J7Rb3ms5vrPVFfpdLgMbHdo06uP8qpv0A5ui
	OlBRjSdJxEozbRq0RRWpzSyvTAhhwgeancq0I0klLrWlCWHgdtWZOvNv1OqpoSUd
	u0Bki4VCnetoHTqhaSoe8PeXc3k9M8xISLS7m6GjTo4vrKerGvHZgtOcsFyRaf+K
	DyPXoNwywMD35K2eigiX/Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyb6v0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:31:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 25 Mar 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3C764820246;
	Mon, 25 Mar 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 1/5] firmware: cs_dsp: Add locked wrappers for coeff read and write
Date: Mon, 25 Mar 2024 11:31:23 +0000
Message-ID: <20240325113127.112783-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325113127.112783-1-rf@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: W_mGFw0jCLpfl27Iq92J29FYCUk_XLhO
X-Proofpoint-GUID: W_mGFw0jCLpfl27Iq92J29FYCUk_XLhO
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

It is a common pattern for functions to take and release the DSP
pwr_lock over the cs_dsp calls to read and write firmware controls.
Add wrapper functions to do this sequence so that the calling code can
be simplified to a single function call..

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 54 ++++++++++++++++++++++++++
 include/linux/firmware/cirrus/cs_dsp.h |  4 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 9f3d665cfdcf..0d139e4de37c 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -819,6 +819,33 @@ int cs_dsp_coeff_write_ctrl(struct cs_dsp_coeff_ctl *ctl,
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_coeff_write_ctrl, FW_CS_DSP);
 
+/**
+ * cs_dsp_coeff_lock_and_write_ctrl() - Writes the given buffer to the given coefficient control
+ * @ctl: pointer to coefficient control
+ * @off: word offset at which data should be written
+ * @buf: the buffer to write to the given control
+ * @len: the length of the buffer in bytes
+ *
+ * Same as cs_dsp_coeff_write_ctrl() but takes pwr_lock.
+ *
+ * Return: A negative number on error, 1 when the control value changed and 0 when it has not.
+ */
+int cs_dsp_coeff_lock_and_write_ctrl(struct cs_dsp_coeff_ctl *ctl,
+				     unsigned int off, const void *buf, size_t len)
+{
+	struct cs_dsp *dsp = ctl->dsp;
+	int ret;
+
+	lockdep_assert_not_held(&dsp->pwr_lock);
+
+	mutex_lock(&dsp->pwr_lock);
+	ret = cs_dsp_coeff_write_ctrl(ctl, off, buf, len);
+	mutex_unlock(&dsp->pwr_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs_dsp_coeff_lock_and_write_ctrl);
+
 static int cs_dsp_coeff_read_ctrl_raw(struct cs_dsp_coeff_ctl *ctl,
 				      unsigned int off, void *buf, size_t len)
 {
@@ -891,6 +918,33 @@ int cs_dsp_coeff_read_ctrl(struct cs_dsp_coeff_ctl *ctl,
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_coeff_read_ctrl, FW_CS_DSP);
 
+/**
+ * cs_dsp_coeff_lock_and_read_ctrl() - Reads the given coefficient control into the given buffer
+ * @ctl: pointer to coefficient control
+ * @off: word offset at which data should be read
+ * @buf: the buffer to store to the given control
+ * @len: the length of the buffer in bytes
+ *
+ * Same as cs_dsp_coeff_read_ctrl() but takes pwr_lock.
+ *
+ * Return: Zero for success, a negative number on error.
+ */
+int cs_dsp_coeff_lock_and_read_ctrl(struct cs_dsp_coeff_ctl *ctl,
+				    unsigned int off, void *buf, size_t len)
+{
+	struct cs_dsp *dsp = ctl->dsp;
+	int ret;
+
+	lockdep_assert_not_held(&dsp->pwr_lock);
+
+	mutex_lock(&dsp->pwr_lock);
+	ret = cs_dsp_coeff_read_ctrl(ctl, off, buf, len);
+	mutex_unlock(&dsp->pwr_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs_dsp_coeff_lock_and_read_ctrl);
+
 static int cs_dsp_coeff_init_control_caches(struct cs_dsp *dsp)
 {
 	struct cs_dsp_coeff_ctl *ctl;
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 23384a54d575..82687e07a7c2 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -238,8 +238,12 @@ void cs_dsp_cleanup_debugfs(struct cs_dsp *dsp);
 int cs_dsp_coeff_write_acked_control(struct cs_dsp_coeff_ctl *ctl, unsigned int event_id);
 int cs_dsp_coeff_write_ctrl(struct cs_dsp_coeff_ctl *ctl, unsigned int off,
 			    const void *buf, size_t len);
+int cs_dsp_coeff_lock_and_write_ctrl(struct cs_dsp_coeff_ctl *ctl, unsigned int off,
+				     const void *buf, size_t len);
 int cs_dsp_coeff_read_ctrl(struct cs_dsp_coeff_ctl *ctl, unsigned int off,
 			   void *buf, size_t len);
+int cs_dsp_coeff_lock_and_read_ctrl(struct cs_dsp_coeff_ctl *ctl, unsigned int off,
+				    void *buf, size_t len);
 struct cs_dsp_coeff_ctl *cs_dsp_get_ctl(struct cs_dsp *dsp, const char *name, int type,
 					unsigned int alg);
 
-- 
2.39.2


