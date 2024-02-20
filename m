Return-Path: <linux-kernel+bounces-72489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C985B423
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B94A1C22832
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9CB5A787;
	Tue, 20 Feb 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="Dr1/KEpu"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AE5A782
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414996; cv=none; b=V/lgqoCdTkQSgnKUFVvudY479ccPZOdQd0BC1hOBYG8W7Brh/ac1riIubKlb3gEuBP9OYcUn4pfZMOyVNXbw4/e0/PusfHG+OkL33kMZho4RG8QXIiS0nl1L5ut7Q9gA06Zw2pq37easTUyGaRxb6kJ0O+Ybw3AF2cfKUHD8ZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414996; c=relaxed/simple;
	bh=rv5wc++x90d6SuMHSDmSnfkE40CpmmCdSITZKOMxFeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5DORHNvQoLv6MQ5SwtBW1rBgW8H3sMewOwhTGXcTsWT8lCG9iGRnxAEGIV41l2UZzkaTe3dWgyh0ryn04VIqAokjil+OVVrRlFKG6aGC2ur2DRvxGYnAyllNFvA+FAyu+WoyEwOcriAdncC/mSDdHedzvYkTb4SAV2ED+Nu3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=Dr1/KEpu; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso4801222276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1708414993; x=1709019793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzt93vSNIrGDzyg1PIPtvFGU0T9v/8rtMnoi2x6SDHA=;
        b=Dr1/KEpu+xeWthawGJ086i63x4PcgCnNQXLgRMW35w4jHUa+vV9x/60ckV1cqBVX+U
         qTqRu9jh+ElPYI7JgBZnffENBcIC5HztJiiwT59RdRmAB2qbcuoiLIPQOx3ztHmbqtYD
         YRKa2ECXLp70yvZx/ySAtTh/SyZptdp2P5FH+yYfzsm7s5zwTwMEyDJ6G64NydIKSLgB
         Ahi5hV55pd1wkuuCIehG1wmSlCCCAPDe4pjII8Y8jghnJXOQ4zq9LLRHoO0M5qGHA55z
         He1VtMecCLx9D/9xQ/+qjMBmVBbEiF3Fo+GMsZ8PlZJGNtRXP82CjKqjZrFEwpMDJcHg
         Jy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414993; x=1709019793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzt93vSNIrGDzyg1PIPtvFGU0T9v/8rtMnoi2x6SDHA=;
        b=dq1s+rVhWMWP5HhWtJvfFeOO6ADIiW0yJgMX4NANKqZjOcX2Sy6MUht1oGp8LZTGpB
         41PQeYoMfNl7cxLmNfGwHmIEawAm4xaaYMdyBaZEoN4wHkM6tadqFPO0fM82zOkUvgpo
         +blKYQAcDtWQG+HvNH56/5ePBEHXTnYmH5YIVj39VmFD4JA9yI2OMAiz8aF4CNYGlZ2Y
         NjAz66LPNjLfz/+qDEofCUVo9qdls2/BBEDYY99oSGdzP05SEUUi2IVrcoQSF9s0/uF+
         oH7tGCqY/+lo7hiwl06ifB9T02AfQdvglL2bM7M9Y7HUf8V9qd341XwNBjTIzL9EclAj
         y72g==
X-Forwarded-Encrypted: i=1; AJvYcCWRJZ1kZSxaQGZWbEvcGHtx49R9j7FrAXl2mevUNNV6JSPvmoSP4R6OHzVvHjmtdr5UAR+fbLeetFNX9iq4P0zJICpbQJ2legXFFk3A
X-Gm-Message-State: AOJu0YxAsm/ou7Fw+1iFCW454HbCrDcgE2tJcISPTqLNstcGc6NpRash
	bW1PDBURwf8PAcqvQZ56rSXT2fg/sO0kiw896am3a2OESsV6ypkcskGF9fvfkw8=
X-Google-Smtp-Source: AGHT+IHEI4eWS8vyoRA1SVegw4028sjC2JWNJGV+rbCloBe8jQQA4Rz32K2MCOW+qaNR5deWLFwKog==
X-Received: by 2002:a25:268b:0:b0:dcc:1dc4:15e4 with SMTP id m133-20020a25268b000000b00dcc1dc415e4mr13015975ybm.47.1708414993731;
        Mon, 19 Feb 2024 23:43:13 -0800 (PST)
Received: from xuyingfeng-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2a:187f])
        by smtp.gmail.com with ESMTPSA id x18-20020a25ac92000000b00dc6e1cc7f9bsm1809085ybi.53.2024.02.19.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:43:13 -0800 (PST)
From: Rumeng Wang <wangrumeng@xiaomi.corp-partner.google.com>
To: djakov@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fengqi@xiaomi.com,
	xuyingfeng@xiaomi.com,
	wangrumeng <wangrumeng@xiaomi.corp-partner.google.com>
Subject: [PATCH] interconnect:Replace mutex with rt_mutex for icc_bw_lock
Date: Tue, 20 Feb 2024 15:43:00 +0800
Message-ID: <20240220074300.10805-1-wangrumeng@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: wangrumeng <wangrumeng@xiaomi.corp-partner.google.com>

Replace existing mutex with rt_mutex to prevent priority inversion
between clients, which can cause unacceptable delays in some cases.

Signed-off-by: wangrumeng <wangrumeng@xiaomi.corp-partner.google.com>
---
 drivers/interconnect/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 50bac2d79d9b..467d42cc7e49 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -14,6 +14,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/rtmutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
@@ -28,7 +29,7 @@ static LIST_HEAD(icc_providers);
 static int providers_count;
 static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
-static DEFINE_MUTEX(icc_bw_lock);
+static DEFINE_RT_MUTEX(icc_bw_lock);
 static struct dentry *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
@@ -698,7 +699,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 
 	old_avg = path->reqs[0].avg_bw;
 	old_peak = path->reqs[0].peak_bw;
@@ -730,7 +731,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		apply_constraints(path);
 	}
 
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 
 	trace_icc_set_bw_end(path, ret);
 
@@ -939,7 +940,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 		return;
 
 	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
@@ -968,7 +969,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1094,7 +1095,7 @@ void icc_sync_state(struct device *dev)
 		return;
 
 	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 	synced_state = true;
 	list_for_each_entry(p, &icc_providers, provider_list) {
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
@@ -1107,7 +1108,7 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
-- 
2.43.2


