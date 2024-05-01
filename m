Return-Path: <linux-kernel+bounces-165314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0F8B8B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAFD283641
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3012E1D5;
	Wed,  1 May 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUi7x/ey"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517B12AAE9;
	Wed,  1 May 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569853; cv=none; b=S2QTi/pE049BKNjXUMa0ZKPblMHht39OGZaDnR4OU/Uu1//TyIvPGTHNCEMLn/o9KA9kFyecbPbg1oavYDvZIlVPNUPcVr98M5m8rEN/cDplGj0nGOMN0TWq/m+8vjwtiz7m3gCKXIj1HakXn4Gwnzj2/1mo2sGgEe9N7Ekm0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569853; c=relaxed/simple;
	bh=lMYzmV9//9INyU1Duoqy4uVKWMnnmekE58fSm7AFEL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZ8Ga8ueHTgYHS4y3hSy9dOOESLa4J1VVVzD0ZLlsou0CfTzx8/I2ujaMEcBz/kLqhPVwIL+0BTcbbeH+SUp8RBzBalDoU4csjcGMQoZo7t9bBTPPVeD1p3pYfMa0DQIcXIXSJ5KScposYheP9wp8JD1Sexe757T5xz2HBRmPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUi7x/ey; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f3f6aa1437so3247738b3a.3;
        Wed, 01 May 2024 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714569851; x=1715174651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMBFEPpX0chiN/ZQJQtqfNtd+/I0a6HtphalfcoEIRs=;
        b=YUi7x/eybSpa4uwJowB73jIbW5xmuspKSI2/Oyyi0Iq4iI0pjElrJEoPTEuo0AZjLe
         lIt9T13CKyZ7voAizNU6FLkf2jzx8yvVyWCLO7xH8ZMLRDrIL3Psxf727MXyStZOXwuS
         g5buXlAqN+6/ttziZm6MZ9OiVlT26vQdvWnizKC78lz519erYCZbCG1R/+ZK0yYMNa+F
         FJ3IhB0xKb0WJSANB/ZzsyJud32j6I09RmpaeuIvDBTPqCZfYX1/AVwJ/njijztlAuAo
         rGbszpNuc0YrqLRKPo+JVShy1grqwkU4zCl/usNzSVzEHE2RHkZv7Q9+Rr5rC5eC3nMg
         lbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714569851; x=1715174651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMBFEPpX0chiN/ZQJQtqfNtd+/I0a6HtphalfcoEIRs=;
        b=iZIUEMOEeyIVQ3Y/e41YgLYQaMznjBYl35/Fn8hshNsFahNxOmdyqSEyILTK9j3q3/
         N+OnGezILMD7Ln4m5pvWTNM3WxhPVNR4/nbMeU4212fCjyC31JgoJq8VbL50c7GvHziw
         /l6i/I07TJKN6Nt99H6ZDU/7RvbQV4NHLE7MPtFa3LKaoVwGcKDrg+ZaDC87vduh23cj
         jXhMN6jiGLwjFqCmt8KUyW64KCefIOjez9qGswCbgPIq+blW3Dk11dCXNeAkbF+XEdhY
         QEjuBfxzsofkI5+Eub7sVjqZZ0l0CZ8RfU+ECNa0QO2ViSpKpdillxGEMjuYwG/l2Euf
         tjYA==
X-Forwarded-Encrypted: i=1; AJvYcCWy63nWqOLOdG2seyezoa70IgRC3BMGJqKhMIf9rN2W+3QDxRPdDpmcO3UzyBq68TOCNG98uZoHibjNJEHlYJ5aC7rPRTAd41/+nbdHJz81I2/jeM9J46bDH/HgejT21bo0V5oTL4KIJQ==
X-Gm-Message-State: AOJu0YxwNqlFwoTDqRq8u6SMBqyTR+9gXnMKS8jqujKbUnwXkSUfuFyG
	1fpZP4SZKGy4v8xF9UT7hATxkwhZ4GXcDJzdGjtATT1JEbR4ua0x
X-Google-Smtp-Source: AGHT+IGWQGHARDT9zOyTneCFcfF0M9DcNNCQix+mRZM8KZme0cTKD+4AVFAz6FeVhl6PzTx0E67ZUg==
X-Received: by 2002:a05:6a21:3996:b0:1ac:4fca:23c2 with SMTP id ad22-20020a056a21399600b001ac4fca23c2mr2514825pzc.8.1714569850990;
        Wed, 01 May 2024 06:24:10 -0700 (PDT)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id g3-20020aa79dc3000000b006f2909ab504sm17809894pfq.53.2024.05.01.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:24:10 -0700 (PDT)
From: skseofh@gmail.com
To: lkp@intel.com
Cc: daero_le.lee@samsung.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	robh@kernel.org,
	rppt@kernel.org,
	saravanak@google.com,
	skseofh@gmail.com
Subject: [PATCH v2] of: of_reserved_mem: clean-up reserved memory with no-map
Date: Wed,  1 May 2024 22:23:59 +0900
Message-Id: <20240501132359.488616-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202405011208.qsZQwChO-lkp@intel.com>
References: <202405011208.qsZQwChO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <daero_le.lee@samsung.com>

In early_init_dt_reserve_memory we only add memory w/o no-map flag to
memblock.reserved. But we need to add memory w/ no-map flag to
memblock.reserved, because NOMAP and memblock.reserved are semantically
different.

Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
---
 drivers/of/of_reserved_mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8236ecae2953..d00a17a9cebc 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -81,6 +81,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 static int __init early_init_dt_reserve_memory(phys_addr_t base,
 					       phys_addr_t size, bool nomap)
 {
+	int err = 0;
 	if (nomap) {
 		/*
 		 * If the memory is already reserved (by another region), we
@@ -91,7 +92,10 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 		    memblock_is_region_reserved(base, size))
 			return -EBUSY;
 
-		return memblock_mark_nomap(base, size);
+
+		err = memblock_mark_nomap(base, size);
+		if (err)
+			return err;
 	}
 	return memblock_reserve(base, size);
 }
-- 
2.25.1


