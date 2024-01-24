Return-Path: <linux-kernel+bounces-37486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFB83B0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24489287808
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC212A163;
	Wed, 24 Jan 2024 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R65PTh7b"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6A86125
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119768; cv=none; b=aMn4YXgQQN6xisjRUTeFClJ592hBGHGmtSrtyhERwu6BiqNB6AzbWCTb2sOpkFZYfgOigk19kVveeb8kpqpEEEoXaKrLV5d+mmPJZkaA1DITNTtPNrrg+WWa1QFRDntoOlTB6XUVwoKF/URvM5kkdD+UzGVCuve206bdXycEYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119768; c=relaxed/simple;
	bh=zRp6RJBo9ni0fMGxg1rRNC47znJI/AG1cmoQVqhj9/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKfzCJoIf7mQ0pz7f5BBU88DcUagZQcOsS9T5iD5LsUC9dOSuswXi01Zq7fDpa9TqhfOO5BnZAqk3iBtoaYvJKEThxjUZpCoNRZKkyCQsqJoBMMNpwFe0/7w1+0qwA2l5HAp2osWtSZZZWb86Ez4PStxvu6p6hiS5+j63d36VhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R65PTh7b; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51008c86ecbso2537880e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706119764; x=1706724564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTk+QOHhuV0ddu1f13MxSI+SyTG7OrguLkgzhrD1Zbc=;
        b=R65PTh7bjVC6VP6AJn4Wc8SK2KPR1/xu9MAtd9JL+gnEVdHZSxCU37aQ5DnQlBgdn1
         IZPontVVY0TnrgRMKE0U8BcVGNRM4K+0Ky/ej1oI5DWlDqcvfub62Q7ThLZlfv0owOmw
         M9zqOphIwksgeJ6+8wEgpLOq0IYyf3PrqeUizdPcoKXWt+RRoj+kcj7V/tzAz1MbwHoJ
         s0rvgaHSqupdstWHUOJ1goOO8yBeWwmmNJrdNSEYN96M2D7lEYN7IjzX51uX9H6yjK6V
         gQICfvf5hajzFJbu9lkv13hTu3/hLjoIAd/Ikw4m4SJHYWCwmp/bI/VfM3udwY8Gs17L
         CrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706119764; x=1706724564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTk+QOHhuV0ddu1f13MxSI+SyTG7OrguLkgzhrD1Zbc=;
        b=i9IMA33q3yTpJ2TQXYfiBBkLBqKN3wo2GItDuLsIXxja8XPiuNHsawWgKZjpPm8NSm
         12Uq2ltuKm+k9PUxoFwYUwENUsXwT/NYXF9TeaUhuMtdgTMtGLP3XLQeshGdTej38HzK
         TOZSArtX3MKrBL23gFMV9nESYPKvoaM0g8wFAPDP53vULq/zNNek2T2fARz0Nd46Oea6
         7LH9wKnw237PTdvMv44HC4wUGVHzTy3UfcBaPAncZ8IbmU7V3Vikh4hu5bYEx1qCnJKc
         85h0hGuUhaVWcE2CDFK2P0DrGIs4Y0n9dMuijhyBKNInwfcYw063emWAL5sUWwEdP2Em
         LipQ==
X-Gm-Message-State: AOJu0YwSRA4Z8n+0IqkC7kfjpbAdp758IgArHCzjLERHTsJkz+2Ag1hh
	KRo+jXv2K7KqoozhwsroQdGWpH4nqMvdy2y5vqajPogNhxvBBu/g
X-Google-Smtp-Source: AGHT+IGHrDb2JJILi44pZF1bRFKMJXwjxb22K3MOoBAwdNnQSWTxUg4T9nOIRqxBVMxOQ1FEBZ0Gag==
X-Received: by 2002:a05:6512:3991:b0:50e:b3bb:1292 with SMTP id j17-20020a056512399100b0050eb3bb1292mr4221934lfu.74.1706119764350;
        Wed, 24 Jan 2024 10:09:24 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0050eaec14596sm2656667lfu.39.2024.01.24.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:09:24 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/2] mm: vmalloc: Refactor vmalloc_dump_obj() function
Date: Wed, 24 Jan 2024 19:09:20 +0100
Message-Id: <20240124180920.50725-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124180920.50725-1-urezki@gmail.com>
References: <20240124180920.50725-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tends to simplify the function in question,
by removing an extra stack "objp" variable, returning
back to an early exit approach if spin_trylock() fails
or VA was not found.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b8be601b056d..449f45b0e474 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4696,34 +4696,35 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
-	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 	const void *caller;
+	struct vm_struct *vm;
 	struct vmap_area *va;
 	struct vmap_node *vn;
 	unsigned long addr;
 	unsigned int nr_pages;
-	bool success = false;
-
-	vn = addr_to_node((unsigned long)objp);
 
-	if (spin_trylock(&vn->busy.lock)) {
-		va = __find_vmap_area((unsigned long)objp, &vn->busy.root);
+	addr = PAGE_ALIGN((unsigned long) object);
+	vn = addr_to_node(addr);
 
-		if (va && va->vm) {
-			addr = (unsigned long)va->vm->addr;
-			caller = va->vm->caller;
-			nr_pages = va->vm->nr_pages;
-			success = true;
-		}
+	if (!spin_trylock(&vn->busy.lock))
+		return false;
 
+	va = __find_vmap_area(addr, &vn->busy.root);
+	if (!va || !va->vm) {
 		spin_unlock(&vn->busy.lock);
+		return false;
 	}
 
-	if (success)
-		pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-			nr_pages, addr, caller);
+	vm = va->vm;
+	addr = (unsigned long) vm->addr;
+	caller = vm->caller;
+	nr_pages = vm->nr_pages;
+	spin_unlock(&vn->busy.lock);
 
-	return success;
+	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
+		nr_pages, addr, caller);
+
+	return true;
 }
 #endif
 
-- 
2.39.2


