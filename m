Return-Path: <linux-kernel+bounces-85164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81386B158
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627FB1F24B77
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ACA1586C6;
	Wed, 28 Feb 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NoSrCYgo"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB636132;
	Wed, 28 Feb 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129517; cv=none; b=uw6sqq3P/v2Esfns3sIFATcMHSRtfXJizCtfG0FoAnn2ARB1of7wNIa+CdhYdMQtYq/qiLrnQY5nD2EvtHoeHpawDmD4Q3on5tZ+AjvTnJNgt1bvSEjbJ3g0PMrikB2m30V5Hg4mzqyjkFJx/Hysof6YFzc4D0L0aQmAwFyKZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129517; c=relaxed/simple;
	bh=HCzUjH7sa9BNvz6UHleN9vbonQTqd2eG6/fTQEgkjLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LruBhTUCpq3CoeFKdHDXaPQ1oYnexzSJgWii7J8X80Kp/8Nx/A7I4boiFvftWGA5JAqW4LElA7kq/1Q61R5UAd9B0kb6X4/WiJkvx5cOu/BbcREQUH7L5UzSjrP29UBbAc632oM5Xd5cjrfnM1uZWg7nwn2MF/Qj1hliGHxl7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NoSrCYgo; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SEBj9t046116;
	Wed, 28 Feb 2024 08:11:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709129505;
	bh=tZLXJ83gMr8eBL3rhWDV0D/+umP0/0+AkPugCLBIiWM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NoSrCYgo8GPhnXqiO57D6kFOszEDefsXRbWJW6JCJfIvnaMOi/lTpelI0XI4gFC0m
	 xQ28CrU5Zv3cuF22//lJ3MkWJs7dxwtoV8pbuqiCTT/1Ki8ms0Y9SFDfy/UCcvXpY+
	 QRO53M/rveZVbO+SqgG4teL7LC1lYl4XLHHgnNzo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SEBjoQ129702
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 08:11:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 08:11:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 08:11:44 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SEBiq1123242;
	Wed, 28 Feb 2024 08:11:44 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <mchehab@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@collabora.com>, <sebastian.fricke@collabora.com>
CC: <laurent.pinchart@ideasonboard.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>, <andrzej.p@collabora.com>,
        <nicolas@ndufresne.ca>, <afd@ti.com>, <milkfafa@gmail.com>
Subject: [PATCH v6 2/3] media: jpeg: Add reference quantization and huffman tables
Date: Wed, 28 Feb 2024 19:41:39 +0530
Message-ID: <20240228141140.3530612-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240228141140.3530612-1-devarsht@ti.com>
References: <20240228141140.3530612-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add reference quantization and huffman tables to a global header file so
that they can be re-used by other JPEG drivers.

These are example tables provided in ITU-T.81 as reference. The JPEG
encoders are free to use either these or their own proprietary tables.

These tables are being used already by verisilicon driver [1].

Also add necessary prefixes to be used for huffman tables in global header
file.

[1] :
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/platform/verisilicon/hantro_jpeg.c?h=v6.7#n30

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V1->V4 : No change (Introduced in v4)
V5 : Rename from jpeg_enc_reftables to jpeg-enc-reftables.h
V6 : No change

 include/media/jpeg-enc-reftables.h | 112 +++++++++++++++++++++++++++++
 include/media/jpeg.h               |   4 ++
 2 files changed, 116 insertions(+)
 create mode 100644 include/media/jpeg-enc-reftables.h

diff --git a/include/media/jpeg-enc-reftables.h b/include/media/jpeg-enc-reftables.h
new file mode 100644
index 000000000000..91959907113f
--- /dev/null
+++ b/include/media/jpeg-enc-reftables.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Reference quantization, zig-zag scan and huffman tables as shared in ITU-T.81 */
+
+#ifndef _MEDIA_JPEG_ENC_REF_H_
+#define _MEDIA_JPEG_ENC_REF_H_
+
+/* Luma and chroma qp table to acheive 50% compression quality
+ * This is as per example in Annex K.1 of ITU-T.81
+ */
+static const u8 luma_q_table[64] = {
+	16, 11, 10, 16, 24, 40, 51, 61,
+	12, 12, 14, 19, 26, 58, 60, 55,
+	14, 13, 16, 24, 40, 57, 69, 56,
+	14, 17, 22, 29, 51, 87, 80, 62,
+	18, 22, 37, 56, 68, 109, 103, 77,
+	24, 35, 55, 64, 81, 104, 113, 92,
+	49, 64, 78, 87, 103, 121, 120, 101,
+	72, 92, 95, 98, 112, 100, 103, 99
+};
+
+static const u8 chroma_q_table[64] = {
+	17, 18, 24, 47, 99, 99, 99, 99,
+	18, 21, 26, 66, 99, 99, 99, 99,
+	24, 26, 56, 99, 99, 99, 99, 99,
+	47, 66, 99, 99, 99, 99, 99, 99,
+	99, 99, 99, 99, 99, 99, 99, 99,
+	99, 99, 99, 99, 99, 99, 99, 99,
+	99, 99, 99, 99, 99, 99, 99, 99,
+	99, 99, 99, 99, 99, 99, 99, 99
+};
+
+/* Zigzag scan pattern */
+static const u8 zigzag[64] = {
+	0,   1,  8, 16,  9,  2,  3, 10,
+	17, 24, 32, 25, 18, 11,  4,  5,
+	12, 19, 26, 33, 40, 48, 41, 34,
+	27, 20, 13,  6,  7, 14, 21, 28,
+	35, 42, 49, 56, 57, 50, 43, 36,
+	29, 22, 15, 23, 30, 37, 44, 51,
+	58, 59, 52, 45, 38, 31, 39, 46,
+	53, 60, 61, 54, 47, 55, 62, 63
+};
+
+/*
+ * Contains the data that needs to be sent in the marker segment of an interchange format JPEG
+ * stream or an abbreviated format table specification data stream.
+ * Specifies the huffman table used for encoding the luminance DC coefficient differences.
+ * The table represents Table K.3 of ITU-T.81
+ */
+static const u8 luma_dc_table[] = {
+	0x00, 0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B
+};
+
+/*
+ * Contains the data that needs to be sent in the marker segment of an interchange format JPEG
+ * stream or an abbreviated format table specification data stream.
+ * Specifies the huffman table used for encoding the luminance AC coefficients.
+ * The table represents Table K.5 of ITU-T.81
+ */
+static const u8 luma_ac_table[] = {
+	0x00, 0x02, 0x01, 0x03, 0x03, 0x02, 0x04, 0x03,
+	0x05, 0x05, 0x04, 0x04, 0x00, 0x00, 0x01, 0x7D,
+	0x01, 0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12, 0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61,
+	0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xA1, 0x08, 0x23, 0x42, 0xB1, 0xC1, 0x15, 0x52,
+	0xD1, 0xF0, 0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0A, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x25,
+	0x26, 0x27, 0x28, 0x29, 0x2A, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44, 0x45,
+	0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x63, 0x64,
+	0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x83,
+	0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99,
+	0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6,
+	0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2, 0xD3,
+	0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8,
+	0xE9, 0xEA, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA
+};
+
+/*
+ * Contains the data that needs to be sent in the marker segment of an interchange format JPEG
+ * stream or an abbreviated format table specification data stream.
+ * Specifies the huffman table used for encoding the chrominance DC coefficient differences.
+ * The table represents Table K.4 of ITU-T.81
+ */
+static const u8 chroma_dc_table[] = {
+	0x00, 0x03, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B
+};
+
+/*
+ * Contains the data that needs to be sent in the marker segment of an interchange format JPEG
+ * stream or an abbreviated format table specification data stream.
+ * Specifies the huffman table used for encoding the chrominance AC coefficients.
+ * The table represents Table K.6 of ITU-T.81
+ */
+static const u8 chroma_ac_table[] = {
+	0x00, 0x02, 0x01, 0x02, 0x04, 0x04, 0x03, 0x04,
+	0x07, 0x05, 0x04, 0x04, 0x00, 0x01, 0x02, 0x77,
+	0x00, 0x01, 0x02, 0x03, 0x11, 0x04, 0x05, 0x21, 0x31, 0x06, 0x12, 0x41, 0x51, 0x07, 0x61,
+	0x71, 0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91, 0xA1, 0xB1, 0xC1, 0x09, 0x23, 0x33,
+	0x52, 0xF0, 0x15, 0x62, 0x72, 0xD1, 0x0A, 0x16, 0x24, 0x34, 0xE1, 0x25, 0xF1, 0x17, 0x18,
+	0x19, 0x1A, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44,
+	0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x63,
+	0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A,
+	0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
+	0x98, 0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4,
+	0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA,
+	0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7,
+	0xE8, 0xE9, 0xEA, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA
+};
+
+#endif /* _MEDIA_JPEG_ENC_REF_H_ */
diff --git a/include/media/jpeg.h b/include/media/jpeg.h
index a01e142e99a7..e07b20ef8665 100644
--- a/include/media/jpeg.h
+++ b/include/media/jpeg.h
@@ -16,5 +16,9 @@
 #define JPEG_MARKER_DHP		0xde
 #define JPEG_MARKER_APP0	0xe0
 #define JPEG_MARKER_COM		0xfe
+#define JPEG_LUM_HT		0x00
+#define JPEG_CHR_HT		0x01
+#define JPEG_DC_HT		0x00
+#define JPEG_AC_HT		0x10
 
 #endif /* _MEDIA_JPEG_H_ */
-- 
2.39.1


