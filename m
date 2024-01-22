Return-Path: <linux-kernel+bounces-32260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C2835928
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00F71F22BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8CA7FF;
	Mon, 22 Jan 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kgsf4f7M"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345336E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705887356; cv=none; b=OtH7Xtz0MZiJYrbAXiSdoqqqHIqQThjmFXz+phNYYkmx2X08I+6w39P2ExsEY/bJGvPRJOwf/l0A5jyX/lry8dQqBasi/Lhio3mVDRBqJ80AAfB6xLWNlHnj8UpIw7QtmILnjPu3EmQMK6NJWhV4LxCE7bFKT1z+T7ch8Q8fflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705887356; c=relaxed/simple;
	bh=DN1YT8HGHXh19DTvNmtqNmMtIBziBd51UFWCoRR3Ca0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=HfcIHLm/CV03gMZB1mF5VElpwOfw9aGdZibvUbShrbHQHC+StswAFnDJLfTZdcQcSrvzPjjDyt+LP1nZwNWLtt4FcBn+LZEwYBfwqDg3Z9RteS+4osMwrlaFbvwtekdMCAY19d/FD3GKwdd8K85LbGlP7SZExIogK5JuiJdLF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kgsf4f7M; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bda6c92ce7so1723883b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 17:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705887354; x=1706492154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Jsu46i64Gml+WhUl1v04oD5se4ar3Pxfhx1o3Plk4=;
        b=Kgsf4f7M8/+pOZd6W6hUm/AAObcoGcwcbaHH6kOY8RcMZ185P7+ND4yWm1UHPgEdAf
         JnBn0PTIL3kRyujstMcW3iYGVdKm/ycR+adm7zRDdNpSupXfNtdJGEk+A+BJL4xpL5S0
         wjOnzjDkpJirQ/gfmh9tSnxV0ZXgE3yuJyZ1cwy4xAjVZmimM+GyPQcEH53nRHAZPOpl
         RUM8nvoGOhDbpNUwnRt+NHf4brsTjopdiop0pKfixDzMZO0DA4gheYBGeNsKMAVCA9Vc
         JQxJWNqcVWnZQncnt7Uydb5S3qtX11x1omxi9QvesuVCvige+VMVSxv3nOU7gSTvIJAK
         OhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705887354; x=1706492154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Jsu46i64Gml+WhUl1v04oD5se4ar3Pxfhx1o3Plk4=;
        b=Fo7k7G2mL5O4OpK/wqtm11G5WtTvm8eQCFS/Cl9EOLdZJvs8CnrCmJMjZv9Puo1dRz
         mGUS6iUn5aIPb7dhlov5iyqadllQjynzKuZKZvgeh4NL8llTm1t69ALhkPhgfsE+jpIx
         q9cI2aHRXF+zjsRCcBgVymq3NvQ9LM8R2ur3EHoj/UQmlsF63Io+ny9MOnQoGlZJwhHA
         5tlbpvEtFkQi95QuwRgpcjVtcII1iaY3ohdoXntTMxHC+T78V3mySrLNSaEz8l4Iq+gV
         2tHMA7/jMZyiTlsoyhwLOBZ6r1z23QgKeG186MxZd2lmAW8HNHQKOhOHYDvsz6SEHthx
         /Qnw==
X-Gm-Message-State: AOJu0Yz0gkvOz3EhY7dRx+2sMzi7PRXR2TqJWP8B1WMo4q19HESiLRyS
	GUUZcQslrYbyKXhpOjm3K58eT79Bo3UZzfImIRWaHjOB5wIK4vmAepFRISsvpcY=
X-Google-Smtp-Source: AGHT+IEqkScX2PPDIKRxZ/Oliomw2fBUesIuhmWwCy3WZeaHxfa8eoDaXdj/07eLwpCASY536Fl3TQ==
X-Received: by 2002:a05:6808:150c:b0:3bd:bc2f:a9ab with SMTP id u12-20020a056808150c00b003bdbc2fa9abmr338490oiw.104.1705887353962;
        Sun, 21 Jan 2024 17:35:53 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id m7-20020a62f207000000b006dbbc6ab938sm4750692pfh.199.2024.01.21.17.35.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jan 2024 17:35:53 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com,
	conor.dooley@microchip.com,
	robh@kernel.org,
	sudeep.holla@arm.com,
	pierre.gondois@arm.com,
	suagrfillet@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: cacheinfo: add init_cache_level()
Date: Mon, 22 Jan 2024 09:35:10 +0800
Message-Id: <20240122013510.55788-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cacheinfo_sysfs_init() is executed, the general weak function
init_cache_level() returns -ENOENT, causing failure to add the "cache"
node to /sys/devices/system/cpu/cpux/. Implement the init_cache_level()
function on RISC-V to fix it.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cacheinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 09e9b88110d1..be9169a38bac 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -71,6 +71,12 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+int init_cache_level(unsigned int cpu)
+{
+	/* The topology has been parsed by acpi or dt, return true. */
+	return 0;
+}
+
 int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-- 
2.20.1


