Return-Path: <linux-kernel+bounces-143948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9528A3FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66772B21454
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2EA17BA0;
	Sun, 14 Apr 2024 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IK2OiGAN"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ACC18E01
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063586; cv=none; b=NmJPPH7rFLbh5UXOEDz7mLAxeqCbEfmB69dTnNlyAXHoz6tbUHqb01xa65HV1ODeZD+eLZ7FMtgANq3A4sUa+WCHzfq0G3VqYSZdb6lMqUxWyZqJhyUW0giiRcyT5i3p49yTn8pzlPdjvTkeCR2UcCur76R+bAMefkMIf8G+WPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063586; c=relaxed/simple;
	bh=GNxwO8FiM91HhPodNEqh1grX1c2NbQXpFfur+digntU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yfwl/mmam5CpTlyc/4GlL8jW9+ltH3gsykmjnM6e6Qlhvw5m6Y5NTQS9Av5teKxcHB0h8v5bYyW9d+V6uAiG93fnW4H3tb2JOokKcGyCjcniEvCQ5KhhabBjzsVTHmjocg7YZLmjF7L5y+NrFJequ+KgP8EQT+GY7DOo/452GME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IK2OiGAN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1734252a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713063584; x=1713668384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+iJ/bWcbs5TbNYkdodB+bg4kp9o+X2TePK5VotNZ5U=;
        b=IK2OiGAN6NQbyDG1JvzjtEYJ79zVP7XjJeqSP4Xko8J++mC73Vivgs2R8QkUJ+BITx
         LGNqPcl85iDceypbrSZ7XaFn7m1RzhkFEbZDHEzt4/1/dF3IbCtrN+Vx4g5z9AiuPvU2
         M1+OFXpee1cYSVEoQqU2E0c909ylfOMGS9nfNsXTkOBjTOAE5mauGFup1tahk88rSIji
         TGqqImmeRIjrOpHtSq5TXofa8mWaJqZV/+zJ1vUTIfbfGn6YVQWTgsI8FCBBmpoFkNgH
         XlrRDEAbOHlLDdf3EqDICDoj93UAC7dYq//CyqP5aIvmCPeGd7aSUSQp8lubCZ7ODnrg
         JgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713063584; x=1713668384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+iJ/bWcbs5TbNYkdodB+bg4kp9o+X2TePK5VotNZ5U=;
        b=wJXkJawUjfIyqoU1LhhPphPPiw03kET6WjjDcYm2Mg8JsfpNqVbDfryuom+RpeLNOo
         Fhplwoa5IUbBCWTuKW1uYtVx8iHvRDJRXT7FFy600Fws82X63FXaFfsYWOkLa7CoEk7x
         ZAUz8f8RFyiCIA9oeJ6y/U5WxLuDPWxrK259zzb1RYcWvehG5179WekGAdCgBLMz59VX
         pc7CP6RT84aKkx8hWAQ7N3vL4H5onUqkrlja2EO1KMOVW/vol53IZO/g+lbHygEubpwq
         qacowMULJ6KPg1hdrSir2K7OPnswHOZvcDhbyz/HDuj1HReIwKUJ2+gYOENS8j2i02/i
         doDw==
X-Forwarded-Encrypted: i=1; AJvYcCUyzl+6QjqdJrvtXRZZG13VRuA5VKhL8DDha67CjiosKa7Qj9BvS0SYM8gEj2zSgAZ05w4q4KH/bCc080npUAMQAhtsBpBJgfPjCtOS
X-Gm-Message-State: AOJu0YwETTh7ZlbRn5uaW262wN9zOs32MEYeT3UX43XIJ8CumQJr28Sh
	3kmROVhWkGl1yUYOSlqqhTpMHvkzYqDm/Oe04PknMk9e1mdHK65xu1zoarq8Kcg=
X-Google-Smtp-Source: AGHT+IFC7Ostz4NVqRl+TdyivWIDYqcK3ZnTae/PQDs3xYi5nfAgFK24gkFZANSYBnnATXXDHJF4Cw==
X-Received: by 2002:a17:90b:80a:b0:2a5:513:921e with SMTP id bk10-20020a17090b080a00b002a50513921emr5443131pjb.31.1713063584355;
        Sat, 13 Apr 2024 19:59:44 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cx15-20020a17090afd8f00b002a219f8079fsm4799913pjb.33.2024.04.13.19.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Apr 2024 19:59:43 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Sun, 14 Apr 2024 10:58:25 +0800
Message-Id: <20240414025826.64025-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240414025826.64025-1-cuiyunhui@bytedance.com>
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before cacheinfo can be built correctly, we need to initialize level
and type. Since RSIC-V currently does not have a register group that
describes cache-related attributes like ARM64, we cannot obtain them
directly, so now we obtain cache leaves from the ACPI PPTT table
(acpi_get_cache_info()) and set the cache type through split_levels.

Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cacheinfo.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 30a6878287ad..ece92aa404e3 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <asm/cacheinfo.h>
+#include <linux/acpi.h>
 
 static struct riscv_cacheinfo_ops *rv_cache_ops;
 
@@ -78,6 +79,28 @@ int populate_cache_leaves(unsigned int cpu)
 	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
+	if (!acpi_disabled) {
+		int ret, idx, fw_levels, split_levels;
+
+		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
+		if (ret)
+			return ret;
+
+		/* must be set, so we can drop num_leaves assignment below */
+		this_cpu_ci->num_leaves = fw_levels + split_levels;
+
+		for (idx = 0; level <= this_cpu_ci->num_levels &&
+		     idx < this_cpu_ci->num_leaves; idx++, level++) {
+			if (level <= split_levels) {
+				ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
+				ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			} else {
+				ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
+			}
+		}
+		return 0;
+	}
+
 	if (of_property_read_bool(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-- 
2.20.1


