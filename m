Return-Path: <linux-kernel+bounces-146148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B498A6153
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE29F1C21561
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022B4C7E;
	Tue, 16 Apr 2024 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UCOOCnh+"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEC1B5A4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237296; cv=none; b=fEufkFq91TV71oNI3bobmLscCEwlMXcZ7lkzJ1MNOj5jCfjGP77AP4RMjSkf8zvBCK2LOPDv9yeuJuMpGXktuRd4gI3nLnwGLa2WIWcwfz7k6RwbRkyux5CwXDqYhjfpXN3aEEUeBaaQC9NaknagvCblnvl9lCatwSQw8A6UPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237296; c=relaxed/simple;
	bh=73Ooj+OaJJIoBwEkContTKxHyybH+bNX3xJA/ldJcL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upKQjUW7udnfPRYIH3nXuWNduN/UJUG4jxkuMKogycx7gNW8S9z4TbxEG7OroqxE+6dTTyRly+dFLb8H/vBnw8k0mxlkWPKQcV525bkm0fL6X0Ly0AYD1HotS+D5Flixivqd12z6di93YNLx7/dMEiTIbQQ/bzJ+WpW8mh5NVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UCOOCnh+; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb8ea5ac95so262937a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713237294; x=1713842094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yve68TeIN/f8pyzLtfbyGcp16m/kz9ccR5yLCEIe7Y=;
        b=UCOOCnh+dsL7jY9IXyUpbhZA/SsvalP0hXaB/QD8bBU3ooMgftD2ByoAj3Lys4ZXvD
         aEg2RCI2UQCExpRDRcAKCZUe4r3sWWV5aXhksFjefoIPWgHKyZ7rQTiTED48cZL+I3S8
         /tSRS+Aj50yIArYYjrOplBcCPOQwRZ8GxvKyuC74PeVx+64M2R7LcgBbQSxhUuJKyqEd
         NT2/bXyt/50uYWWm6RT5620BCA3T23C0z6+Y4DATdmFq19qK/qpH/wR5yrvjxJcX94cC
         N9yzbMVbw5ICwZjurG88OaEzbvs71ocfheqXGhg3Vl0fWdQ/oQG4oAJvGRcgKedvKc0S
         JfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237294; x=1713842094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yve68TeIN/f8pyzLtfbyGcp16m/kz9ccR5yLCEIe7Y=;
        b=gHLKKIlYfzKBFzfYzSfUJ3BDt+eGlugxeApbMdXeNFluW8+8XltguIb9nSyoAIGJXX
         pE+IK5wMQH14WMMnsPb3f8VDMbDBaq+w10gcSQXj2WtodNBj6mAMF6WL6LBeHKWJDkSY
         zlUBdcuGpB5XmS2vNuh9FnSxyFhtphlSC0j/1l4SehILK4SJchX8JPoIue1wGdkh18ZJ
         J2xq/AfABmYxLcUmDtlzpBmdgMAUl4MVWEvPQPRn2/x0aVVKUylBqC51rMEUN6Oy0BdT
         eCKPJGXY/fvn/M1jxdHGR6549bie0OJR9RjralnhnnHomH+z5bNaX5wSNEBaGhNjQu0r
         2wYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu263l9UnHCXqqgck25YGRG3TgFn6Hltlg0ayYfEswc7cJ2AaIBbRrDqZvhSff8zoQMsAmPkMH4tKYdQ3TytS+EEso58EeT9ud5Gmk
X-Gm-Message-State: AOJu0YwwDiLRyjX+2hgMbZrE114OV5Ew7qHQJea/HerGrLUTv8tuiJL4
	tS/jUyu0HOMrZYw72Qe3rL/fOQ+yghB9s7ZoK4I1oaPsH7zr/mHI1mvo3UIBUT8=
X-Google-Smtp-Source: AGHT+IEeADcSOG5m5cSI0ix14SxkbexoEWR7Z85N/k76lNUya9yj2CgCsg1obRQTztWOVlClkCQkEQ==
X-Received: by 2002:a05:6808:6044:b0:3c5:fb09:aeea with SMTP id dd4-20020a056808604400b003c5fb09aeeamr11353481oib.35.1713237294624;
        Mon, 15 Apr 2024 20:14:54 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78694000000b006e6adfb8897sm7907983pfo.156.2024.04.15.20.14.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 20:14:54 -0700 (PDT)
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
Subject: [PATCH v3 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
Date: Tue, 16 Apr 2024 11:14:37 +0800
Message-Id: <20240416031438.7637-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240416031438.7637-1-cuiyunhui@bytedance.com>
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
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
 arch/riscv/kernel/cacheinfo.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 30a6878287ad..dc5fb70362f1 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <asm/cacheinfo.h>
+#include <linux/acpi.h>
 
 static struct riscv_cacheinfo_ops *rv_cache_ops;
 
@@ -78,6 +79,25 @@ int populate_cache_leaves(unsigned int cpu)
 	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
+	if (!acpi_disabled) {
+		int ret, idx, fw_levels, split_levels;
+
+		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
+		if (ret)
+			return ret;
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


