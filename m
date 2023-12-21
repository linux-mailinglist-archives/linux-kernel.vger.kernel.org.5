Return-Path: <linux-kernel+bounces-8856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955281BD52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1B71C2606E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51630634FC;
	Thu, 21 Dec 2023 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu0UUoTW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCD634F0;
	Thu, 21 Dec 2023 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2340c803c6so129382066b.0;
        Thu, 21 Dec 2023 09:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703180074; x=1703784874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
        b=Eu0UUoTWpKyE3YCGUdSsqVezppxNYEp9/2/S74PEgflbINlV+iD6vnfbrY48bwVRma
         /VLUT8X2y7aMVwleN4WeUJtYBKSshIxKAe50wyNCuQu774t4ti4obsBuTE7I2yt+EWqQ
         fhaRHNq7eO9luv6dVpP3u40Oa78fEf0G5hegiF4y+4pY0cXoOVEe19KKewT3NK4Zcd7z
         jXs5wpVn8m9OXebZ0t9fEfEIpqqCmogv1JQXDmLWo4EYXPozyeX/YVd4wr79mtKSjez2
         xGWeRPoAV8D44uTjyBWYhE6hjOrM5OxxN5lREzYSMe6f6U35rt/yfcG89hlKjB3wQnCO
         ExUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180074; x=1703784874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
        b=xQcWSgkKmizNCS6hqM45+6M1W7uqfEqiwt5OizhHsDOwhL+db2usTpIM/SAkGhjQgX
         pQosyIOE1ChN4Q696cFs3Q+4jJP7TqXTLrNkEcMEnneCz6a2Oo15gPPm13MkHqIdFq7y
         DeSYiZQWuQKPk85Dj5c2+xRZKFrGSE46dOI61Xsb7HkOdPTG8ljAEDga57V5MpRZmKLy
         tL24IHZadXN7ZbWYPLdE7cW4wIeVBR5EyVsmtDzpaIfaGHmQJo/jEB0ZDymUvR1hhNIC
         s9D6bCHBcWNKAT7KHOd/ft7AdPqtTPQzxQ7n3sZmsAMPcjnuwnfe6I8xUxB13gdTfE8S
         8D6Q==
X-Gm-Message-State: AOJu0YxhLVUKcMDcO1jjtzavhiwacanX+x5Pa22qwZS4pGjcC71E60dg
	4EoBMqbF3b2qybn6cmX3vWs=
X-Google-Smtp-Source: AGHT+IGgwY5w6AQTHQ1MgBWS25JJJBhWhKSdij/Jvg0xGBl8Vj+fXysVr5sbWXq5EX6J52TSERKREQ==
X-Received: by 2002:a17:906:4749:b0:a23:65de:419c with SMTP id j9-20020a170906474900b00a2365de419cmr75233ejs.144.1703180074094;
        Thu, 21 Dec 2023 09:34:34 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:34:33 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 2/6] nvmem: core: add nvmem_dev_size() helper
Date: Thu, 21 Dec 2023 18:34:17 +0100
Message-Id: <20231221173421.13737-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221173421.13737-1-zajec5@gmail.com>
References: <20231221173421.13737-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This is required by layouts that need to read whole NVMEM content. It's
especially useful for NVMEM devices without hardcoded layout (like
U-Boot environment data block).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4ed54076346d..980123fb4dde 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2163,6 +2163,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+/**
+ * nvmem_dev_size() - Get the size of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: size of the nvmem device.
+ */
+size_t nvmem_dev_size(struct nvmem_device *nvmem)
+{
+	return nvmem->size;
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_size);
+
 static int __init nvmem_init(void)
 {
 	int ret;
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 2d306fa13b1a..34c0e58dfa26 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -81,6 +81,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
+size_t nvmem_dev_size(struct nvmem_device *nvmem);
 
 void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
 			    size_t nentries);
-- 
2.35.3


