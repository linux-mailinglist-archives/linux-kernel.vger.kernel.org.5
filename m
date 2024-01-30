Return-Path: <linux-kernel+bounces-43742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02914841887
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4261F281FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D3936AF3;
	Tue, 30 Jan 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="1v/W6LFA"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0E2E40E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578940; cv=none; b=E7aZpF/XxsU6BEFXpSgVW7L9wzs/DCoVQ40KtXFJd5FEy0hcg1M2LbosCpbgR0vLZHA2bcjrRlKnkUyrZFrQCaRtClfC0OkgaXOI7tG58tWdOKAeqrjVA/4dYNWgnpUGv8cqFc5xL0rmCcAdzIHlMlFNXnO3oa35PJGvAJGwfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578940; c=relaxed/simple;
	bh=afmGsTSHwwdohMS3QuarqOP8HJNNtAFIbuu/jsQLzdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjR7Lnpi9MyMrNi3dqhJaeuq2N/vad8INtpYRJIe2dkKVHYy+TKOROweNlDAFRgYf85ZIWHe9BO9mh6LL7Y89vy5Uus2Frn1Iwxbe/cO+dwvwSWPIQA/WehzQMpNRId33/K/aIC2cnHhue6X6XUEjrtB6LEZCtaSkWPAbPbbE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=1v/W6LFA; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68c495ba558so13027686d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578937; x=1707183737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V/6lwbRMGjS57LQdA40055rq8F7L2NGNcAA5/p/KKk=;
        b=1v/W6LFAo2HF9vrO2b7+cNDfYX51YQGsbS7IRT0rpoOf/NVcusSA/fQcbQxGlsCFLs
         FMDY+x/Kehmjn3akRLktAqny/oQuNdIzhU2vLNmZmaYmAUbM9xPOgyFFYO3cSQvmDJ++
         r/lQ8X2uikRQeCFJ3eZLrQwQ69950oyq87m+5sKHKV4veTRX0wg0t+JPXaxFKMr82kAC
         4RNA1/iHFvMw/h5clPmMvBCDw0C/T3b/11/71RyUsztQH5XR4WCUd4XQTcDV9OzpVz1U
         AkQa3NLsPSnhghYcA+SiaYaUKbldR8kRMhykstIo1LWvdIZHlwr67QZkRVO+D7UqXIEe
         m5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578937; x=1707183737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V/6lwbRMGjS57LQdA40055rq8F7L2NGNcAA5/p/KKk=;
        b=W1zPyxCNluIOEcTFMqGY4qbCx3p18+rCwEu6CtSWedDr/Vu0a2elHgcsbqT6cEfVHv
         xQEBK1xASfHF/YcE/07WFe88EPA2wm6RTMpbYAxkWYQHqymkiPIuzvtdcEQxEI78GWRH
         cEvuhH4rOb5+4L/1MT1fVv0jDlX25WIFXhP4vNNB/D4XuCVmnMp38gnFANODM3qUTI4p
         Ep/bcydZhQ0O+XSvSRBbb7grWjiNG4pZA6CYGdHWstKens7AqgC4JpeRjeYNsyofFk7f
         m70Qhy43/RX8npK9vOiRePJLnFUs0yJkroroA/I5yttaze44ml4afHeH/UjvaxAn0HBg
         6+Wg==
X-Gm-Message-State: AOJu0Yw4MFD71iuEBGok29+pcrdf8dIC4BXkgKXxUlipjovbJBwCkywp
	uprSsoGQk/IbMNIXXZaQ0a0jNnYYZiv5IOnKpiA5vZha2GWX2DTIIruCkHEofTkR6xpZ2phRNUO
	V
X-Google-Smtp-Source: AGHT+IFtbmXej4OpvwtpOTmn5+j0+Crv33a0WDVXCIw0rfc+AKtf6Z9PD/0SvdYRbq+4bF63apG45Q==
X-Received: by 2002:ad4:4ea7:0:b0:680:815a:44d8 with SMTP id ed7-20020ad44ea7000000b00680815a44d8mr7696476qvb.130.1706578937523;
        Mon, 29 Jan 2024 17:42:17 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 11-20020a0562140dcb00b0068c5116af11sm1223091qvt.142.2024.01.29.17.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:17 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] mm: zswap: move zswap_invalidate_entry() to related functions
Date: Mon, 29 Jan 2024 20:36:39 -0500
Message-ID: <20240130014208.565554-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move it up to the other tree and refcounting functions.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cf864aaa214d..9f05282efe3c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -559,6 +559,18 @@ static void zswap_entry_put(struct zswap_entry *entry)
 	}
 }
 
+/*
+ * If the entry is still valid in the tree, drop the initial ref and remove it
+ * from the tree. This function must be called with an additional ref held,
+ * otherwise it may race with another invalidation freeing the entry.
+ */
+static void zswap_invalidate_entry(struct zswap_tree *tree,
+				   struct zswap_entry *entry)
+{
+	if (zswap_rb_erase(&tree->rbroot, entry))
+		zswap_entry_put(entry);
+}
+
 /*********************************
 * shrinker functions
 **********************************/
@@ -809,18 +821,6 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
-/*
- * If the entry is still valid in the tree, drop the initial ref and remove it
- * from the tree. This function must be called with an additional ref held,
- * otherwise it may race with another invalidation freeing the entry.
- */
-static void zswap_invalidate_entry(struct zswap_tree *tree,
-				   struct zswap_entry *entry)
-{
-	if (zswap_rb_erase(&tree->rbroot, entry))
-		zswap_entry_put(entry);
-}
-
 static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
 				       spinlock_t *lock, void *arg)
 {
-- 
2.43.0


