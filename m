Return-Path: <linux-kernel+bounces-108252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4A88086A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A04D1C22293
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB857EC;
	Wed, 20 Mar 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBmv1DkD"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37B29A9;
	Wed, 20 Mar 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893518; cv=none; b=bAOVpxbgkRJX5NAsmbaw0cMqkHcXg8JErDJn58H+0W7u0VPyHOmnjkHNpMSXY0umTIbQariXINE3LLfv/h1SmKtNdEaFYceAxxsI8wkTb9qsowY37lqXEtV2BZb9Tv0M+i3aVhSejaYnKgN+JNZRanUpb9ifnQQkTmAyJ2/za48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893518; c=relaxed/simple;
	bh=tT/cnq29qDS361LtzVLG3+TjD7UVyvgFr5D6DtgnviA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEjI12F1DaaBJfWdbdF7eiriolBfXd2BQrkXnLS348yNaEyjN0XNTW3cKsJuo+Jhg66NU47nJOuIDoy9nWP8mZbDgpYVg9SUAA6heb80uWi1GKTrFWd43TR+znhutgYePb6jrswEIQZ21YOtzi+qOGJR+e6xfIRGpESswWrftv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBmv1DkD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41462295004so12199095e9.0;
        Tue, 19 Mar 2024 17:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710893515; x=1711498315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5UeCuP+rHqrtuTgJs0v1PQXUHTqmsrEuVFHCUle14o=;
        b=FBmv1DkDhrVDBdi9RyurOfG+9db0yxQQ4e4Ir0e+h4lQl0wcbANLE/7W4VW94yUtMU
         37HhmZvDx2mgAQkvDo4V2MDdylidsbrxTgW8JBugdKLY5m6Resb6pEh7n1xed24V7lpq
         OvXIZdJT2D9TcsfWeRWejyTmlhi8JgOvLEkL2eoYxfI7m0tPK6qy0COsdRjFOiSLHHQ9
         tENer/uf4De+SNsZb/1/BkTXcNyjRIaH9fV1FLscvjYqS/HtkQMkeFuYXjbr+UdyasS5
         aQQNf+iv3urA5dYeHT9Rs1aAO+x0dsJnVWeHRV+xcAlsfSuhQ9VKOH7QKcCOy3Y/6HRR
         KLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710893515; x=1711498315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5UeCuP+rHqrtuTgJs0v1PQXUHTqmsrEuVFHCUle14o=;
        b=kGnbOoRZwzVxWPsdw2QvfR6z9/8Gds5Q5hxRZyMi8A7LpvPN9N42gjm5M4WXSWm9bQ
         crd/u399iSOG54lS2TouACsYoB+narTE6SdYHjuFaQY11wROwzxZ+wbz2gvQDMnAAFoe
         hn1N9VUENloqjOVL99p4ClIZaIhcWPqGjEIovA5KJ5aTr1fkliCJpHtl5dn5d5ed2uG1
         se9ayI80FmCy/AVsYvo9XJlmwiuLmZbeHppGa/mJd85WmUxq/f+g3ulkSNLr+FhYL4ZR
         NcRxi93wBWfE2JS/xALNjeyDHwgj5Sal9TYml9Du4o8zfkBqx+i2o9LyCcJBDViLUquK
         Or/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxSszq1F9tjY3N0UGWwVdDMhULL1wqwy/bq9kmUNqDV4UDcKJFQyzVMIPjnLxtJZoNHNc/hcXy+8ZH+PSwrQz83COJ+AUqcb0CqZVBfA2n64hu+L7rGOUDImQfH6OYrcyLrR8wAqliJiYENkqyDtLZ25TsgzZZ1vSNy5nE3ds6P5ydMw==
X-Gm-Message-State: AOJu0YwDwi5l7aNkGLA2dNDJUXkeJktKHR1JMe4Sd8gEaeQ+KawBtvBX
	GdZtNIUoYgFqfZs2VYn3+mX7+FMOZGrRGtkQsn/n06XjLRgpOvWs
X-Google-Smtp-Source: AGHT+IH3ETbAdh9odNtGmgi5+pc37TVausHqIdd+KaNxNGb33DnpvHbi2eNlp3wRouIqKjFQ5anQpA==
X-Received: by 2002:a05:600c:3b0a:b0:414:cc0:e4d6 with SMTP id m10-20020a05600c3b0a00b004140cc0e4d6mr5937225wms.26.1710893515176;
        Tue, 19 Mar 2024 17:11:55 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id f20-20020a05600c155400b00413eedd36a4sm371478wmg.39.2024.03.19.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 17:11:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: qcom: Fix broken misc_cmd_type in exec_op
Date: Wed, 20 Mar 2024 01:11:39 +0100
Message-ID: <20240320001141.16560-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
reworked and generalized but actually dropped the handling of the
RESET_DEVICE command.

The rework itself was correct with supporting case where a single misc
command is handled, but became problematic by the addition of exiting
early if we didn't had an ERASE or an OP_PROGRAM_PAGE operation.

Also additional logic was added without clear explaination causing the
erase command to be broken on testing it on a ipq806x nandc.

Add some additional logic to restore RESET_DEVICE command handling and
fix erase command.

Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b079605c84d3..b8cff9240b28 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
 		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
 		instrs = 3;
-	} else {
+	} else if (q_op.cmd_reg != OP_RESET_DEVICE) {
 		return 0;
 	}
 
@@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
-	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
-	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
-	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	if (q_op.cmd_reg == OP_BLOCK_ERASE)
+		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
 
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
-- 
2.43.0


