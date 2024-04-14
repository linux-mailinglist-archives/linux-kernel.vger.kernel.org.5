Return-Path: <linux-kernel+bounces-143947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273188A3FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF028243F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF1171AA;
	Sun, 14 Apr 2024 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UhDvYiAq"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081617BA0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063581; cv=none; b=iNJ4BIhEx/hHoqXlH6qJUb1XmqJANN8jIyTDJ0p3S9mFxIQoB0QSkzTDghIdHKpR7nTwHBmjyGY8fUSSh3XRfLyrgvXd0zDpj5LxbUaCQUx1LUFsC3gh+FRHH9eY/xQTCld/JOwx5OMG+3lCtYekDHaK9dGW/Six5RNjphx9E5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063581; c=relaxed/simple;
	bh=n36euKbqIUH9mEQGupSkNUxESKc9mvK/u+joVsfYJnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jipBXA1NGNf/fKBhaojOiFj706NJFzl3yJgJ6YOh5NCAJRXGBVS3o1Y8mip6Z7qlfvYJ/VWcZlb1sDOn0xOeHtifp7RdBmWPlIb862yLq6LPe5d0NaO/6OPY8r8D3luv3DCRQ4ua5AM9ASQyFVcIT8B7k9fqJWf3Xsfcm6AJy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UhDvYiAq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5b6e8f662so12876125ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713063578; x=1713668378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQZbXYtBh7IQ8zFAgTStWmYnvk6O15njdv6RlNb8FnM=;
        b=UhDvYiAqdHYP+/0g2Q/zaRuHNN+XPG2ubNofs0VPEoHr5w62078lFkPsSVGIZPkg5/
         pYyr4H7zCuiVQ9Pxu5zp9KmJMS3/HI5BNpVsoZP9GdeNaMw9YuNzEJfLTSR6OFKncVG5
         +xlu5s0IRE9uliVo0jGnFGN08ZDENawluMoEQ/dJylgP5bTTENKzlIhcjX/y+jrLIP+W
         aEdlQsjz8GbyFNmWAempiKPvbDShVus2oUoyn2zI+kfKXrVeo22ofW6kj5zs/9C2ovLn
         k/cSBjWugBNWWjcv4Irx/gcfR4TP6/4u2YsXaxyvyRq0jMrl1Spytl4abRvmvwApCDZM
         a4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713063578; x=1713668378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQZbXYtBh7IQ8zFAgTStWmYnvk6O15njdv6RlNb8FnM=;
        b=QbFUBbThpItgoSz5fIBnlPNAk/CxhfncBy8PjE2j+ueBMZOn+DU2PtgOSndBprSwMB
         CoZHchp2VZHWzwdIe4hPnQPJeTzHWWAumJsp40Av/4X3/d37FjSXft9iGhDO88locfqt
         GLDvQGbAX/iZcYe6s8HYs+XhRE6f2EVF7JkAZb1Bp252pUTXHcS+k9ImPMNDc1N5LrwZ
         rzuEKTqZgpTpV6CjZtMTZHmVWbavl8Czu2fWgZrbxRXFO8iHUemRGollpuVESCgiGt4v
         IXf4OBy8WRNBEQwk14sqe4YX+3mTrQVpReflrYvIMdDSE1E7j4dDkMy4dc4ZCwb40c2o
         RRog==
X-Forwarded-Encrypted: i=1; AJvYcCUERALpyWXf22BgrCgYPc08y1b9XZfn4ur/oy07B0e3FtYnENlGl231ekQp9WNreI0/zta3U8XQKiJx2STZXFainQNFWYwtYOuNtV/W
X-Gm-Message-State: AOJu0YxXgU5WdBWApusIGVFHk9Zcpeu2SlubidoToxh84StR+clkwMe0
	NsLe5EMUsDy2bXyT5hC5uOXmwJv6sNLaf6OtCbx3Qxx5GdGoTbE6tYmpa0exoc8=
X-Google-Smtp-Source: AGHT+IG7b7aVnf3Zx6K5E292MakYH/snzrvJ2cHDzaIo1qp/4oj8mSnNTvgLFCUzjYXaXUBKeIJdDw==
X-Received: by 2002:a05:6a21:7e86:b0:1a8:2cc0:290a with SMTP id th6-20020a056a217e8600b001a82cc0290amr6050259pzc.30.1713063578513;
        Sat, 13 Apr 2024 19:59:38 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cx15-20020a17090afd8f00b002a219f8079fsm4799913pjb.33.2024.04.13.19.59.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Apr 2024 19:59:38 -0700 (PDT)
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
Subject: [PATCH v2 1/3] riscv: cacheinfo: remove the useless parameter (node) of ci_leaf_init()
Date: Sun, 14 Apr 2024 10:58:24 +0800
Message-Id: <20240414025826.64025-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of the ci_leaf_init() function body and the caller
do not use the input parameter (struct device_node *node), so remove it.

Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cacheinfo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 09e9b88110d1..30a6878287ad 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -64,7 +64,6 @@ uintptr_t get_cache_geometry(u32 level, enum cache_type type)
 }
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 struct device_node *node,
 			 enum cache_type type, unsigned int level)
 {
 	this_leaf->level = level;
@@ -80,11 +79,11 @@ int populate_cache_leaves(unsigned int cpu)
 	int levels = 1, level = 1;
 
 	if (of_property_read_bool(np, "cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 	if (of_property_read_bool(np, "d-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
@@ -97,11 +96,11 @@ int populate_cache_leaves(unsigned int cpu)
 		if (level <= levels)
 			break;
 		if (of_property_read_bool(np, "cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 		if (of_property_read_bool(np, "i-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 		if (of_property_read_bool(np, "d-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
 	of_node_put(np);
-- 
2.20.1


