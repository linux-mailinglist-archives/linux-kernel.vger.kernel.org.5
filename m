Return-Path: <linux-kernel+bounces-88626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A686E45F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C851F234F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5756EF1B;
	Fri,  1 Mar 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3fnAsZM"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE16EB6B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307115; cv=none; b=S0jZ742AR1P8hri5118fhAxAa0JNrQ3AxUy6lXDMNdKZppnuQ5xJiyTmiU/d8IAR/qAOGMbZisk7KjRBy0fZoqKKlb2iW2AxAIl0bha0utPQ+sBw3HO7Q2kXF3iAQqKYu3NYImqVkrIv0PfjMJxBKsTXDXz/dqcdhd0olC8jKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307115; c=relaxed/simple;
	bh=c6VADMQicUPiPOIu9kP0v1RFWmn/JeAemp3LKilZuoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQxLl7+J7KkqBezEuTII52oBgygYCOD74ji/GRzcqq0IvUebIhgct6XIA6E2jyaxQXMGxVSXjAI+K3vOVnYnCHD/PLlqJ40/LZPKDY83ziLSPlgBhGdhYfgkYL5NylQLyrqO/uoruaP+w+WWEDBxOTlV39IZ9PE3Dpypj/Xn4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3fnAsZM; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d29111272eso28722091fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709307111; x=1709911911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQkIsiqJa3PbCfK5y5rQ5fldLZTBWAFO6axVFhfQfUk=;
        b=Y3fnAsZMCX9sIO5obvOgaI1kwY+est16hgK0/9Y/Tj/5TVtw5E3XRykURwWfoUwSHf
         brV+SE9Am2UCedtJWodaQTBI1v7T+8xd0hdqj5WJX5RrDwU7E9BX7HPjbmO1nsyrP8m0
         BO4AG3zgTFBSi/MpGLMtUEJlcKG0TA7QYPrmaEAvBjnIb0Vy1oAcSx52/+TSFu3iE76k
         /sR8uNqtryU0TNeXFR4thVSzDJtDErf4agWvma7rkcyjweCSUfYTSo/Yzt9tarYcHYPW
         VvbqOTw0laKmKoP14Ar5I9pxQ3EkKhx6nd/S+PYQ3SP8Xy6HQus7Ejy7i+Z3DwOZoIrL
         w80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709307111; x=1709911911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQkIsiqJa3PbCfK5y5rQ5fldLZTBWAFO6axVFhfQfUk=;
        b=KLBKYP+xhk8NT1gz/Zi6Wxw9OfvhagIzkSPRgJrZo5DXAoT0QnYEoz202QEzqHBr4t
         E/s3X/wwR7kxyaGEqfCRZrxI3aPb0+Bq0jvlkVT78xwVZflOXzXdYkfJz0b2wS+7Y009
         M4mCTcMot23jRXpt+8q6YXYXghrGJcxpJUNfWswCRzTmtZWzaz5ZqgUR+1TPRxWjiso/
         9FY0OkCfL3UTCofWGmSvMSASUsQYIoR8ZXFa28qCTSBKfCX6xqMABH1pkOqjy3RHiPo4
         o/cIt3x4+42vsvMyrTR5a2vqiXuim399/BXHnbqicPk9mYgrCqqMg0M/kFVCfdzZ2rFB
         biPg==
X-Forwarded-Encrypted: i=1; AJvYcCWn8R/EjlGnauAlodqSRDb97gDKgi9dF+c2G/yq4329ZlcjAUngBcZthQnZ/59aj7MtmTrTfM7MhBXsgNjZxkmBP7DBvZdugYvAr5UK
X-Gm-Message-State: AOJu0YyvCiJv2hYhhpoLBVJ1oF6iASs0yQ1L4BJJFPeAZWACuBRpAvL4
	hdUxaX3Zv6hNAgWODlahAEilNKBqisF0ARzmlA5tZzho5MMmRZfOap7AdDMDxjEtaA==
X-Google-Smtp-Source: AGHT+IFowqv91ocPiEeEPwajlKa4L03f8UHTtqN7Eo4sKzpVD721ZPHRO+ng/AQ0QUYZzwtnFNGy+Q==
X-Received: by 2002:ac2:5186:0:b0:512:d88a:3a8f with SMTP id u6-20020ac25186000000b00512d88a3a8fmr1450384lfi.25.1709307110610;
        Fri, 01 Mar 2024 07:31:50 -0800 (PST)
Received: from ubuntu2004.cynet.local (vpn1382.cynet.com. [84.110.53.106])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c210a00b00410df4bf22esm8739925wml.38.2024.03.01.07.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:31:50 -0800 (PST)
From: Ariel Silver <arielsilver77@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	yogi.kernel@gmail.com,
	dan.carpenter@linaro.org,
	straube.linux@gmail.com,
	garyrookard@fastmail.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ariel Silver <arielsilver77@gmail.com>
Subject: [PATCH] Staging: rtl8192e: Declare variable with static
Date: Fri,  1 Mar 2024 17:31:28 +0200
Message-Id: <20240301153128.13974-1-arielsilver77@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed sparse warning:
"'dm_rx_path_sel_table' was not declared. Should it be static?"
As dm_rx_path_sel_table is used only in rtl_dm.c it should be static.

Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 92143c50c149..850ee6ae1f02 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 /*------------------------Define global variable-----------------------------*/
 struct dig_t dm_digtable;
 
-struct drx_path_sel dm_rx_path_sel_table;
+static struct drx_path_sel dm_rx_path_sel_table;
 /*------------------------Define global variable-----------------------------*/
 
 
-- 
2.25.1


