Return-Path: <linux-kernel+bounces-109168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67358815A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B4B1F213F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B38954FAD;
	Wed, 20 Mar 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1cfLjjk"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C234F1E5;
	Wed, 20 Mar 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952186; cv=none; b=HJSc4/uVpy1Hvn/jDD8eSyXdWxo6GnOToKjTSqkqJ7Xs5870sSwk+aHHrC8dqcreySkSrACUifGr3MEKKy41XLn3IYhW5T2WR9XoXoJvDpWiQU6yYslgNlHbiLs4xHd6wi/MuO/WM/dBMiQtwyMfSQuuPCQv9HcJ65HbzXXVJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952186; c=relaxed/simple;
	bh=LgFQfIb4fNHaMJQWnKD+SueEOjahJqUpTHftU/pwsbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2q3W1Q+LBqdzblHhS7Ze9+S8WbCeFsb3z8H2JtQsxwg+aLb1aez6GnXFS8HfAFxC9N1Slk0kam9bL1X069Ld7PPCE1fYpUC9A5NjO/8XQeOms9h6/2Bpf2744/UPJpuxxHTZZCSEpimqX+gh3LrsUvnE7ZwKdMxwdUAz8KhSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1cfLjjk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so959201fa.0;
        Wed, 20 Mar 2024 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710952183; x=1711556983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSz7fQzVFVXAFxgeYQXEQZk+nVYjVrCMtbK7Jhjtun0=;
        b=E1cfLjjkeUUv88eP5e0bNOaTnPzhhoPvXkK1VK4jdWpAEhniWoIlfDq1KbApRa048T
         BMW9GG3zZCHk1OEtUQ0g2N07BYuA92rVoANz4ozEjJ5E8RlMQr9ye39Chf5O8pKBwpkf
         5xbdZskPPA3wZifiTZnKZQ0usfPBT7eimK0SQl1iLyRK8u1bjIuPfln+2BF3vSo761dm
         wZeOILG4f3WSgYdbIqWRaDpBYnddewOUlRe2ZfvtgYD1dVNhO/alsln1/BkvBFYFTrYB
         5Xp0N72GEMCbdNgKup7EU2s7JwKyZfFj5k6K3Zi94uGyqooRxH3qIRc/jzFXFoxS87Rb
         sQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952183; x=1711556983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSz7fQzVFVXAFxgeYQXEQZk+nVYjVrCMtbK7Jhjtun0=;
        b=VeRUXZtMvKvFLjZeLXs0odawlnhp4V9Ifh4QT/HX2fiZAF4P78AJVUqh829mdQQ7NF
         aVP+zc6gqnOxKYSWI2pFBU8PBwpkZWsnW+hl0JCPYCbDTmesHh1SQlxhcPQbJShei3rr
         bpSNrlpi9Kvuq+A1ujoT9JVHxkU2WjGs0GpO/ka2V8oNORuztMeOKkjW5JQb+jEk9MeF
         Gg7ZHKZwVG1HGfxUEb87Juup6QMkB8Vk+DpiS6sVQjzYLSCJKzzGwezmR6JIIlq2KUKZ
         0Dxnjm5FoLzob5o7JtTycvGIcz5gQdRf/7g54EterUZ/TQ3hspaxfzMsXcm7IR8LoCsk
         +QaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcUktnMszS2g3ruTYdbM8SIswPYnoTpWaAZoKVTr2rJGGCMKLo1j4+tZmEriJ3JphRsfMteir9sUTgibSzmVjQjX0OUraeO/vUSL8vkNCac7vopxGaLxAw5AivZtwgRYkikH/R
X-Gm-Message-State: AOJu0YwRVbV2I12UTT/vkDW1fWnXLCHh6vQbgsMcCn3S6AjT4r4p9lQS
	1/92JaAASsqleoq3vXuouaqb6Y+qp5R2HwDw7OGDvo/IakUogykV
X-Google-Smtp-Source: AGHT+IGrXcBnTFuQK24EEr9sarEyN5j7+SUWW/AjM5t6F29uCnPCJezOmOuBx2kavAu6gDq7MHe+NA==
X-Received: by 2002:ac2:5f9a:0:b0:513:5fb0:c5ad with SMTP id r26-20020ac25f9a000000b005135fb0c5admr12638319lfe.17.1710952182786;
        Wed, 20 Mar 2024 09:29:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fc18-20020a05600c525200b00414105c4cd9sm2692710wmb.21.2024.03.20.09.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:29:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: limit OTP NVMEM Cell parse to non Nand devices
Date: Wed, 20 Mar 2024 17:29:25 +0100
Message-ID: <20240320162927.5015-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTD OTP logic is very fragile and can be problematic with some specific
kind of devices.

NVMEM across the years had various iteration on how Cells could be
declared in DT and MTD OTP probably was left behind and
add_legacy_fixed_of_cells was enabled without thinking of the consequences.

That option enables NVMEM to scan the provided of_node and treat each
child as a NVMEM Cell, this was to support legacy NVMEM implementation
and don't cause regression.

This is problematic if we have devices like Nand where the OTP is
triggered by setting a special mode in the flash. In this context real
partitions declared in the Nand node are registered as OTP Cells and
this cause probe fail with -EINVAL error.

This was never notice due to the fact that till now, no Nand supported
the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
access for MX30LFxG18AC") this changed and coincidentally this Nand is
used on an FritzBox 7530 supported on OpenWrt.

Alternative and more robust way to declare OTP Cells are already
prossible by using the fixed-layout node or by declaring a child node
with the compatible set to "otp-user" or "otp-factory".

To fix this and limit any regression with other MTD that makes use of
declaring OTP as direct child of the dev node, disable
add_legacy_fixed_of_cells if we have a node called nand since it's the
standard property name to identify Nand devices attached to a Nand
Controller.

With the following logic, the OTP NVMEM entry is correctly created with
no Cells and the MTD Nand is correctly probed and partitions are
correctly exposed.

Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax fixed OF cells")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5887feb347a4..6872477a5129 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 	config.name = compatible;
 	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
-	config.add_legacy_fixed_of_cells = true;
+	config.add_legacy_fixed_of_cells = !of_node_name_eq(mtd->dev.of_node, "nand");
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
 	config.ignore_wp = true;
-- 
2.43.0


