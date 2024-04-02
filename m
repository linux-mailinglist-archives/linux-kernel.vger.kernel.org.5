Return-Path: <linux-kernel+bounces-128749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E6895EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D473A1F22E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9615E804;
	Tue,  2 Apr 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er0R8I9P"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8315E5DE;
	Tue,  2 Apr 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094455; cv=none; b=u7pJvVLlCOJBB/RLYQrwCOCy+c2JthcDEjEUDvGvZoEVN/c+xz0XcA1MS+0snTSOdXpV7b0kvuDxJEgjeClPfVJ4p8cWA7t/ZTC4c2g+6FSbChemsfT/z7QpjZZt3Dlm6ej3Txv1/xTxGZvsqeg86Qsv7cMmwgghge6eHJJN0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094455; c=relaxed/simple;
	bh=ThzxJ0+1nzXQr5OOSAlfmCAsA1NCAF05FUR+WWzEho0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOzHUGQ81owmwrb7YSQuZmRG6XLk1UCxQli+WL7HEzOrA8CihipoZwDmJfVLO2I+wilb7R21Q6Ele1xiesSD0qXJffupfVVEKihCIm0jedwGxOIJFNkPwrOsQgUkVAHMohTXXAH4VxxJBwglviteIxwAHP04ApLkiHgikU4mAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er0R8I9P; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-416200b3caaso3121575e9.1;
        Tue, 02 Apr 2024 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712094452; x=1712699252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDdWgOjBMl1tMJjRaoCRravRU0WRe5hMbvpkOwO9lZs=;
        b=Er0R8I9PW4MBn0Ec0nRoVXOqK/Trpoxs9lcz1cRkrFcmGTmy+z/YKxDKoLIX8P4a5D
         sMzB4vQ1iPFfLAR/BdTn8N45b8NbjdR8q43+/WXlkG2CsMVfrmPQsw2uXWVp5FftGuF2
         TqIwYB9JQSoMdz6uyaSf8A9vp9N0rQFUARKiRYVan+amgS3Y8xkeeV7VJZ6MGi0anqFI
         9KXoJjfzywJLa+AAgfYkGR2ug5YXAvNXZHt8HiA7sgQb56fgSiHS8d+8g+GqnIJSHmB1
         cdN2+Amd+k13qitD+HX8y7I5a6IqdfQ4Ae/WmBGmA6lCj1YzVZX9GYKwAvyR+YTetGlg
         b0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712094452; x=1712699252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDdWgOjBMl1tMJjRaoCRravRU0WRe5hMbvpkOwO9lZs=;
        b=BVzJcbirnWF/ICSnJin8mf8cgmcAyXWmxSRpkEYKrGRsEjsbAbq4uZ3RLEwJzQTjhA
         JJf8M+bVIi1oWGR4HVgBRSWXqtEJq2GE+8CLAeB1E3yq2i4FX8J4Lc9xANRTczGk83oM
         08lepOUQ8xaFpwrDMj2AgemLOt0WZrL3Aj/62zDAAhqgNfsURav9jHWe4EXHV5wJE0JM
         zbzsDSY3KX3bqSYzGLXn8RFe0tetP0l42WFVzAUDZ+sEGHah5Gxsf3u5vafvje+4z6Wb
         +a+YRHVH8Jscb/mmxfdyk6cHLHqR85mMosBCjZ4NYa1MlhyrLTfMEYkuUleGk4R72bak
         FamA==
X-Forwarded-Encrypted: i=1; AJvYcCVAEL0GwrXZI/h1vaX6DeCThwxeOTiX3/+8+Jle1sMvHiHGz+cToro8R+cwLg8LKuAlf0dXu0rzl4Ojg8AUym1F3ymMxCmbJmgjuhDWpX5EX2KYY2cyMvy9FXlHOe0lPq9a1BcBVLORwMhsAjtSGrxkkscoNxjeyTPIFkiD2By4ZErRTQ==
X-Gm-Message-State: AOJu0YwuK3Do8NGmb6Wt5AygiM/MXELPyxdFGSnx9I4tkRdNyTgBgXM5
	11jVe0+j00xF63szy9mB5lxRQ+i5YC20xV5nNt0GTse6Hfv0EnfN
X-Google-Smtp-Source: AGHT+IH8HHuydEJoGrgEKUlbvYjlnQraEID5+on1377b8OsiGIjc1yd6tOz6uo4tcmYGXArYVCuLJg==
X-Received: by 2002:a05:600c:1ca2:b0:416:1d2e:62f1 with SMTP id k34-20020a05600c1ca200b004161d2e62f1mr1600676wms.5.1712094451446;
        Tue, 02 Apr 2024 14:47:31 -0700 (PDT)
Received: from localhost.localdomain (host-79-35-252-101.retail.telecomitalia.it. [79.35.252.101])
        by smtp.googlemail.com with ESMTPSA id c2-20020a05600c0a4200b0041563096e15sm8812630wmq.5.2024.04.02.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:47:31 -0700 (PDT)
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
Subject: [PATCH v3] mtd: rawnand: qcom: Fix broken misc_cmd_type in exec_op
Date: Tue,  2 Apr 2024 23:41:34 +0200
Message-ID: <20240402214136.29237-1-ansuelsmth@gmail.com>
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
OP_RESET_DEVICE command.

The rework itself was correct with supporting case where a single misc
command is handled, but became problematic by the addition of exiting
early if we didn't had an OP_BLOCK_ERASE or an OP_PROGRAM_PAGE operation.

Also additional logic was added without clear explaination causing the
OP_RESET_DEVICE command to be broken on testing it on a ipq806x nandc.

Add some additional logic to restore OP_RESET_DEVICE command handling
restoring original functionality.

Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Merge patches
- Rework commit description
Changes v2:
- Split patches

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


