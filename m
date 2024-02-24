Return-Path: <linux-kernel+bounces-79610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5756F8624AF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFF11F22759
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A44653A;
	Sat, 24 Feb 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4g6m9CL"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489563FB28
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775153; cv=none; b=rT1smHJmudssq9v5MIgAoHJJPj3mi7eZdtk49BijzkFGXS23bs7Rl0MEwSOuq7jDWW6W1yQuw/5PqqckO4JJLD+vR6bJO0xU/iu+Dj7vvrXZAsxXPFCyM9s09QesiFqsJr1dCRE6hyIHEYfTxV1s0vfb10DzigSP/XYr5u/SrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775153; c=relaxed/simple;
	bh=AOKLF1lo0DNZST/F5xk/mQGDH9EWrbhFAsirn0KaH6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jd1650sUWslyNOTL7Sf4evbnvkOyTu9AJ1gdrSBf11MqFWEwMUsAON7IeaABQqzVw/zfCloychG/poQUe8kLJjj5La0noP9kh2V8EylbVMU48VEirydEZuM23L5AQh4W06cOllh9MTVyEatIH3aZkYz/RzA8iYrUNGe151gk0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c4g6m9CL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso187156166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775149; x=1709379949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tJ4KEGjzL+YJpDElkQ+pXC7NYnzSGlRxyULw1fk5Yw=;
        b=c4g6m9CL7wAzvl9Do3rpHKwsnYdoNEjjmkvfP51ch37wCwiu9O4zqEcXE5lWY5NmqN
         zrYMUibXT7G8+TCv3ZkfCZPhyUyT2NVGPlj9L8qIJj2/ojXLQ/5yAdpEy03bE1Ll1YS1
         TCl+dbsptLTUs/9628XDtdyZRL47sLOnI/ICtjwsNe/EJcB5lTyowU7bgh9muGI8FDP8
         Txe9aKgkGzhEy88qNOZODVTc0EeulNBxf0P2XFhOcU5hyO3FHM2JjwdzSoblBlQmYWIY
         FZWTvULzuiZJa2G8Y//035B/S6B/MZYVCEHmRHWDJNC1/fNrhFO2ogbmsL7aBcfy6g0K
         PzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775149; x=1709379949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tJ4KEGjzL+YJpDElkQ+pXC7NYnzSGlRxyULw1fk5Yw=;
        b=phOewcJ2yh4cE6kTEfNwZQp5TlrHhKMTLYtFZqtqR7U99ykdaC8ynN6bhl8fBl/UCX
         Y+I8hmjIkyavWiJiYtyKdOcjSvOwr47MVSHYjFnMfp6LwdlNSfbqqCJCRe/Z2/Ge5BV0
         tOXcMUhkKEF8ApkSSyiDJ9PwShHbwie7oyXdKrfimMr2NdrlVaysZ5buUacXyQY+HH4r
         9GbTLegR6a0gTP/gK/0DwslmCNgFDYvO3qPmM+MgQ/RPS/E6RJsWrG1VhwOSjW29+Pr6
         x7ZWtXapvoVEpcxGhXrN0ABwB7e0EwnZ7yjWVUqJTPWQj/DqD0fD9lafgBwxVGiv9i9m
         KD4Q==
X-Gm-Message-State: AOJu0YxJj1fendKYbdk10E8aPSJl4rxov3gtz7xD6EIc0iWSKc3hB4YK
	1tTQZGNNcFpbeWgbgpP1JOewnakqQjR6u6Au+f7hBqYhhvdSu33IWx9zdf5aDww=
X-Google-Smtp-Source: AGHT+IFO7BUxWodd2CaNu3O/ap2lM4P7hTB0pfUIF1+yyj28KG+lxft+onOX10b2y7VfQUs757P57w==
X-Received: by 2002:a17:906:3c05:b0:a3f:db30:8999 with SMTP id h5-20020a1709063c0500b00a3fdb308999mr1577246ejg.4.1708775149714;
        Sat, 24 Feb 2024 03:45:49 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:49 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Kalyani Akula <Kalyani.akula@amd.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/11] nvmem: zynqmp_nvmem: Add support to access efuse
Date: Sat, 24 Feb 2024 11:45:12 +0000
Message-Id: <20240224114516.86365-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6929; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=uNEk6qD/B90EI4wNpkm2x5253pB8VJ0Bolh0DlxUGyE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLU7b2cRWRzjWafKxtCAEIq0J4cAk9/9q60 OpiWbSYZJ2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N/V/CACkS9VKEFiUnxyyH0Z/lFzStLT39pZSkjpB3Lls1GoJ1L58GM+05k2MkahhA/vzUfbx5jr YrfNUoP2G+ydwJrCvPfe1heXcTXs513JGb/sBdrgrgRnnVY6iPep5xuVEwFUWDyrFy/NvkTa3NT 0nx21WyuPkICyue58Fgc/n3H+YaaE3M6PWH0gJm5FXztmQ1ozuS/QSJyF8wKenrBfw2mV4ZVOzQ 1KPtCCt+lvkKe5rOAdPbKpQYRjxR8F5VsE/QlQ7VFl2U5WX1f66IvQ5ik5RQeR3aSalWfgp1cG1 ictARCYKxw5DlTYtTUyEBSz4UamPYzSQ8nTeC9CBKXdI3bPM
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>

Add support to read/write efuse memory map of ZynqMP.
Below are the offsets of ZynqMP efuse memory map
	0 - SOC version(read only)
	0xC - 0xFC -ZynqMP specific purpose efuses
	0x100 - 0x17F - Physical Unclonable Function(PUF)
                efuses repurposed as user efuses

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Acked-by: Kalyani Akula <Kalyani.akula@amd.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/zynqmp_nvmem.c | 186 +++++++++++++++++++++++++++++++++--
 1 file changed, 176 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 391d8e88b270..8682adaacd69 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -11,24 +12,189 @@
 #include <linux/firmware/xlnx-zynqmp.h>
 
 #define SILICON_REVISION_MASK 0xF
+#define P_USER_0_64_UPPER_MASK	GENMASK(31, 16)
+#define P_USER_127_LOWER_4_BIT_MASK GENMASK(3, 0)
+#define WORD_INBYTES		4
+#define SOC_VER_SIZE		0x4
+#define EFUSE_MEMORY_SIZE	0x177
+#define UNUSED_SPACE		0x8
+#define ZYNQMP_NVMEM_SIZE	(SOC_VER_SIZE + UNUSED_SPACE + \
+				 EFUSE_MEMORY_SIZE)
+#define SOC_VERSION_OFFSET	0x0
+#define EFUSE_START_OFFSET	0xC
+#define EFUSE_END_OFFSET	0xFC
+#define EFUSE_PUF_START_OFFSET	0x100
+#define EFUSE_PUF_MID_OFFSET	0x140
+#define EFUSE_PUF_END_OFFSET	0x17F
+#define EFUSE_NOT_ENABLED	29
 
+/*
+ * efuse access type
+ */
+enum efuse_access {
+	EFUSE_READ = 0,
+	EFUSE_WRITE
+};
+
+/**
+ * struct xilinx_efuse - the basic structure
+ * @src:	address of the buffer to store the data to be write/read
+ * @size:	read/write word count
+ * @offset:	read/write offset
+ * @flag:	0 - represents efuse read and 1- represents efuse write
+ * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
+ *		1 - represents puf user fuse row number.
+ *
+ * this structure stores all the required details to
+ * read/write efuse memory.
+ */
+struct xilinx_efuse {
+	u64 src;
+	u32 size;
+	u32 offset;
+	enum efuse_access flag;
+	u32 pufuserfuse;
+};
+
+static int zynqmp_efuse_access(void *context, unsigned int offset,
+			       void *val, size_t bytes, enum efuse_access flag,
+			       unsigned int pufflag)
+{
+	struct device *dev = context;
+	struct xilinx_efuse *efuse;
+	dma_addr_t dma_addr;
+	dma_addr_t dma_buf;
+	size_t words = bytes / WORD_INBYTES;
+	int ret;
+	int value;
+	char *data;
+
+	if (bytes % WORD_INBYTES != 0) {
+		dev_err(dev, "Bytes requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 0 && offset % WORD_INBYTES) {
+		dev_err(dev, "Offset requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 1 && flag == EFUSE_WRITE) {
+		memcpy(&value, val, bytes);
+		if ((offset == EFUSE_PUF_START_OFFSET ||
+		     offset == EFUSE_PUF_MID_OFFSET) &&
+		    value & P_USER_0_64_UPPER_MASK) {
+			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (offset == EFUSE_PUF_END_OFFSET &&
+		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
+			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	efuse = dma_alloc_coherent(dev, sizeof(struct xilinx_efuse),
+				   &dma_addr, GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
 
-static int zynqmp_nvmem_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+	data = dma_alloc_coherent(dev, sizeof(bytes),
+				  &dma_buf, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto efuse_data_fail;
+	}
+
+	if (flag == EFUSE_WRITE) {
+		memcpy(data, val, bytes);
+		efuse->flag = EFUSE_WRITE;
+	} else {
+		efuse->flag = EFUSE_READ;
+	}
+
+	efuse->src = dma_buf;
+	efuse->size = words;
+	efuse->offset = offset;
+	efuse->pufuserfuse = pufflag;
+
+	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
+	if (ret != 0) {
+		if (ret == EFUSE_NOT_ENABLED) {
+			dev_err(dev, "efuse access is not enabled\n");
+			ret = -EOPNOTSUPP;
+		} else {
+			dev_err(dev, "Error in efuse read %x\n", ret);
+			ret = -EPERM;
+		}
+		goto efuse_access_err;
+	}
+
+	if (flag == EFUSE_READ)
+		memcpy(val, data, bytes);
+efuse_access_err:
+	dma_free_coherent(dev, sizeof(bytes),
+			  data, dma_buf);
+efuse_data_fail:
+	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
+			  efuse, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
 {
 	struct device *dev = context;
 	int ret;
+	int pufflag = 0;
 	int idcode;
 	int version;
 
-	ret = zynqmp_pm_get_chipid(&idcode, &version);
-	if (ret < 0)
-		return ret;
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	switch (offset) {
+	/* Soc version offset is zero */
+	case SOC_VERSION_OFFSET:
+		if (bytes != SOC_VER_SIZE)
+			return -EOPNOTSUPP;
+
+		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
+		*(int *)val = version & SILICON_REVISION_MASK;
+		break;
+	/* Efuse offset starts from 0xc */
+	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
+	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
+		ret = zynqmp_efuse_access(context, offset, val,
+					  bytes, EFUSE_READ, pufflag);
+		break;
+	default:
+		*(u32 *)val = 0xDEADBEEF;
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int zynqmp_nvmem_write(void *context,
+			      unsigned int offset, void *val, size_t bytes)
+{
+	int pufflag = 0;
+
+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
+		return -EOPNOTSUPP;
 
-	dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
-	*(int *)val = version & SILICON_REVISION_MASK;
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
 
-	return 0;
+	return zynqmp_efuse_access(context, offset,
+				   val, bytes, EFUSE_WRITE, pufflag);
 }
 
 static const struct of_device_id zynqmp_nvmem_match[] = {
@@ -45,11 +211,11 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 	econfig.name = "zynqmp-nvmem";
 	econfig.owner = THIS_MODULE;
 	econfig.word_size = 1;
-	econfig.size = 1;
+	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
 	econfig.add_legacy_fixed_of_cells = true;
-	econfig.read_only = true;
 	econfig.reg_read = zynqmp_nvmem_read;
+	econfig.reg_write = zynqmp_nvmem_write;
 
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));
 }
-- 
2.25.1


