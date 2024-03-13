Return-Path: <linux-kernel+bounces-101348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60E87A5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B951C1C21A63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F50038DDD;
	Wed, 13 Mar 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiZG6Iki"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BD374F6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325661; cv=none; b=QTc5pioqtbbhr/0FYySlzDW9OQqaSG38DI9bHCbQ+dZrdKggXY4lI3ja+itYfruk7MFpCsR4ke0+j2mbrPLQE7f/Z3IXkybHAQsWLWOSDBF2MHRWy13pDhgbO4jpvoxbIIO6TbBo6Pgr+GADlSEBZp/Q+riirLQ7LkqqMn44e5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325661; c=relaxed/simple;
	bh=ROVSMg/7I+MfL/McSwpCE4XfcVD3+xeG1cb0IU6CST0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bg5nIg0oixVi8O2ivoFnWs+ae0QfLba+4ZVxDUUUxDm7X8z0OTZfnJYJgil/kWNa34GEfcVLl+u7tfQ64QgktGXZ4kw9EFBrpciK48+7KjSPNqVnrMvZmD0E3QbpY9d3cc/+otax/cIn4M+eKg2/qAIvaAaxYC0uP9YXKKTH2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiZG6Iki; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso48329531fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710325658; x=1710930458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrWU5S3r8n7ABKmHosAcw1tFmQwtwioDP9kb+kgmgPc=;
        b=aiZG6Iki7tR7+7isOsWkBMlYtHZ3DpyLJ1DL+eAQ603Twexox0Wff+74PG8wR2/1zv
         aZVZEnmeI6MiZuyOvxUgFP6PxLd0KAzQ+OUm8qPsB1Vkg561cDa6omcvH0fz7ELHcl7A
         UJy2C7rsagVI30t+bdbXAcnmnYv0RQ1zVp2G8TLRXF4mKvUu5VFisJ9GN+BQlkgG2KRw
         8QbJq6nDlm1ffESYJED6n++K7KPHWyV5de8t6rlBfPTlIv922+xmlBWbrsvKL/thgEX3
         BXn6XLjTjxKC7A3ov2VUFpFIUiO7S8XfmN2APVQR1B4zaeaLXshu+EuUx3edRu/i4gja
         pYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325658; x=1710930458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrWU5S3r8n7ABKmHosAcw1tFmQwtwioDP9kb+kgmgPc=;
        b=sqm9GZfpscRin0n3zWMSKRfnFUPfKBzDszf9IhGjrH81ObDtErxqfwFTYnM0Whx7YV
         0SWRnwsCrH3OXbPh9CWNurzZqKubAwgLdidAR+JbuA3m+7NhI7adb9fr17DssFFUTziB
         tAR4Umr5nAe2R8Vv+yXg7A45X4EOEAl4NVFxIqdB+Grz/Bzc4z0AtwdCvqWpUFOUw9Dw
         PPgygeir2ydY46u5EftnOmyblUKzHylPE/2gvgOMLtMltX/vOPsfgoFf0VSYPEIJjh4v
         6zQly31Odf9Phs3kjXJUlTqobkpB+gOK4C28OnpHWZGRfhYTZ2j8bfur0tHh/7l9vR0L
         Jb6A==
X-Forwarded-Encrypted: i=1; AJvYcCXTu/M7aIj3T+FYUfxq2K6Fi4sJZTFthLUxe8BKh95pxsYGpGwItT1hm34H/gfspGXTxs3BFD/ufvMy0/8VuwuwOvOb98z88O37QZnk
X-Gm-Message-State: AOJu0YwEKwckrGHpBE02Ar5Nm9XWmrpswrw8eosAw2O9H/YqeAFevF43
	Xv6VvGEXNFiuDIAspXjUJNLcRB2+sV7n/WB6qUGQyastwTQVYNr/
X-Google-Smtp-Source: AGHT+IE0wvyNlJYld1l2UG/SCUa6eIml3WWIv72zVSS2Ajod8IiYL+3saVFji46D+bE9CMBu5yfMxA==
X-Received: by 2002:a2e:7d14:0:b0:2d4:693d:ff10 with SMTP id y20-20020a2e7d14000000b002d4693dff10mr1341497ljc.20.1710325658052;
        Wed, 13 Mar 2024 03:27:38 -0700 (PDT)
Received: from localhost.localdomain ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id w20-20020a2e9bd4000000b002d0f0f5e395sm2082845ljj.47.2024.03.13.03.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:27:37 -0700 (PDT)
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Cc: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Hector Palacios <hector.palacios@digi.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] mtd: rawnand: hynix: fixed typo
Date: Wed, 13 Mar 2024 13:27:20 +0300
Message-Id: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function hynix_nand_rr_init() should probably return an error code.
Judging by the usage, it seems that the return code is passed up 
the call stack.
Right now, it always returns 0 and the function hynix_nand_cleanup()
in hynix_nand_init() has never been called.

Found by RASU JSC and Linux Verification Center (linuxtesting.org)

Fixes: 626994e07480 ("mtd: nand: hynix: Add read-retry support for 1x nm MLC NANDs")

Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/mtd/nand/raw/nand_hynix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 39076735a3fb..9695f07b5eb2 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -402,7 +402,7 @@ static int hynix_nand_rr_init(struct nand_chip *chip)
 	if (ret)
 		pr_warn("failed to initialize read-retry infrastructure");
 
-	return 0;
+	return ret;
 }
 
 static void hynix_nand_extract_oobsize(struct nand_chip *chip,
-- 
2.34.1


