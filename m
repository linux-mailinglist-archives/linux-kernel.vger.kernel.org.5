Return-Path: <linux-kernel+bounces-108370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB48809BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31D0B23001
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F81B274;
	Wed, 20 Mar 2024 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="KLh5EMNq"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6D11717
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902549; cv=none; b=eb0s0mQaJHopy6HPwJfwzIZHOk/MH/LiBE6SzG55s0Hsh9fNaBIOIJsdihom28c1+tljwAnRzuMlAlutPDw7wk6hPanmgVxC3MevtTrhYJ5DzeeNt1Bgh05MugCBeVaZkWgkY1AjxraIfKU01Nc4PFQd/+v/g65XkcXaE2CwomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902549; c=relaxed/simple;
	bh=WFhBYAwLNBbB8uV/HwzsFmNf8vujXFelMMa+4V8Uzr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lw6cKxn1tG0F/g1JVyNxCnneNM2RMM20LnmR0fRJfUDCrxhG7BVsrm1SYnogna1UyySOenIBBy97L7d2FHKP59KUqOd50Efl8MrHKslRoq9s1sDxtz6yNnl4HtNSY8JA3GZHU/+yum7Vxpy0XxhIAHpHWgFgOelTtdgrjrAi/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=KLh5EMNq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69629b4ae2bso15004146d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902545; x=1711507345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DIGL+dvsKsYG7Tx7310j/b/qOHwOOB9JaG0dOT6QmVU=;
        b=KLh5EMNqAhttxh2TlBWT9qn8jbLvEytYduqt77T2iiUTTG+otRGEo1CpM75ZU0kQMS
         1mXlSCJi/zxjmUY7GRVuiJ/ZQTYR7B0WC1ZZe/ysWNKILTsgmy6juKN6v5Sb3mnZ7dcX
         2pQrFKhoX6LYjSZsB/DCzuU7HpOFtpYpB5BXHQ39cK9ffs9utgLOGti+XonRnEIaVI0A
         WS2QygmrLMB0BHQe/LMOE/O5E5dpLOQWGk2THiZQWH8i9bTqnDS6QwvZziRFoQB3BggB
         BGHgLZjjNFKf7BWgl70qKiIh/U3tSvglH5WyFc1bCJiRnoU/5CRejTXqUQ6XwnmokMkP
         Hhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902545; x=1711507345;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIGL+dvsKsYG7Tx7310j/b/qOHwOOB9JaG0dOT6QmVU=;
        b=VNiQvb9HJYiNQvnEEXyR8w2ULlopHA9wg0ekqGFTDDON5dDLQpLvd0Ltg3qwEV3V+P
         aLVgSVHM6G61a8iW5yyeyP21h+4L2l17bmhYD8uTHx1W/NViqn9AyMX4s07+whqy5Ad9
         /HQD9vW+5qDYHPtJJygBw22n4cteiH5441fSdylcJddUkA6NX+SHARKWFcZ2D0PPG4r9
         7/ms4BUwEZrq0FxPEFBbmhPcXViU2qHRjpi5ohQ/UDuwv1vXOlymGNduerhkPW0Mqzkp
         oBPJDUhtCP12ta7ck31df2RfKyQKolLvf/Z+OhQBDhCTAMBzeyXQv59pLbRzxqt3yOIt
         KUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxxcSeZjMAvQqEsYfEXFoZMo6nbRU8zQ+JWu7x5CESRLUtotSBV60BbsdmL8ug51MiinLJXFcckZ6VWcZesaSRmKz1AMcEMyKUolPr
X-Gm-Message-State: AOJu0Yx4rkvlsWyo7K1T3MylkJZszpkh1HWRtwqHttjb1Hm3hJHNcox9
	H8DRHJMkFA9vRj42Rp8tX8NGzw9FFtU+cv2mpbPiyxkz7pHLqWbfXvNpi5n6Pp7X+39kD/DcrG1
	CGw==
X-Google-Smtp-Source: AGHT+IF1l0N2egM3aSC98LzaXNROU1+O+6Y4xqmw+dsS00Fx32Wnx7e/F2IaRaJEP8IIHWZ1DYSFqw==
X-Received: by 2002:a0c:dc14:0:b0:696:22ae:eb67 with SMTP id s20-20020a0cdc14000000b0069622aeeb67mr4027527qvk.33.1710902545749;
        Tue, 19 Mar 2024 19:42:25 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id g15-20020a0562140acf00b0069150ebcc30sm7204402qvi.76.2024.03.19.19.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:25 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 7/7] exports the number of pages scanned on behalf of movable/unmovable allocations
Date: Wed, 20 Mar 2024 02:42:18 +0000
Message-Id: <20240320024218.203491-8-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Reply-To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

exports the number of pages scanned on behalf of movable/unmovable
allocations in vmstat

Signed-off-by: Kaiyang Zhao <zh_kaiyang@hotmail.com>
---
 include/linux/vm_event_item.h |  2 ++
 mm/vmscan.c                   | 11 +++++++++++
 mm/vmstat.c                   |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index c9183117c8f7..dcfff56c6d29 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -50,6 +50,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSCAN_DIRECT_THROTTLE,
 		PGSCAN_ANON,
 		PGSCAN_FILE,
+		PGSCAN_MOVABLE,    /* number of pages scanned on behalf of a movable allocation */
+		PGSCAN_UNMOVABLE,
 		PGSTEAL_ANON,
 		PGSTEAL_FILE,
 #ifdef CONFIG_NUMA
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ed0f47e2e810..4eadf0254918 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -904,6 +904,12 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		cond_resched();
 	}
 
+	/* Arbitrarily consider 16 pages scanned */
+	if (is_migrate_movable(gfp_migratetype(shrinkctl->gfp_mask)))
+		count_vm_events(PGSCAN_MOVABLE, 16);
+	else
+		count_vm_events(PGSCAN_UNMOVABLE, 16);
+
 	/*
 	 * The deferred work is increased by any new work (delta) that wasn't
 	 * done, decreased by old deferred work that was done now.
@@ -2580,6 +2586,11 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
 	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
 
+	if (is_migrate_movable(gfp_migratetype(sc->gfp_mask)))
+		__count_vm_events(PGSCAN_MOVABLE, nr_scanned);
+	else
+		__count_vm_events(PGSCAN_UNMOVABLE, nr_scanned);
+
 	spin_unlock_irq(&lruvec->lru_lock);
 
 	if (nr_taken == 0)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 444740605f2f..56062d53a36c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1281,6 +1281,8 @@ const char * const vmstat_text[] = {
 	"pgscan_direct_throttle",
 	"pgscan_anon",
 	"pgscan_file",
+	"pgscan_by_movable",
+	"pgscan_by_unmovable",
 	"pgsteal_anon",
 	"pgsteal_file",
 
-- 
2.40.1


