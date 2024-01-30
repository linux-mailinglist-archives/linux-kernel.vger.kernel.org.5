Return-Path: <linux-kernel+bounces-43744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A125684188B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578A628378A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF64376E9;
	Tue, 30 Jan 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hvd1WYna"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C836AFE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578942; cv=none; b=kYE5fTdh5Fihh5nZX1kZaQ5aMO5YH6mwOvouqO1aplbnDw5x22BzNy5wSfAqeLfeNf+/+oKG1wkUw1AkahlArfuFRHOHQr1DheSehGcEQiB0LRLrKawYymH6H2Lu1dKuxfuXaRrvtE17iz2fPiU94WtLL7/D+7460B4RczHDdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578942; c=relaxed/simple;
	bh=GyovliTv6mCdRtvV87ncUhqOka1TJA4wbPaRsBeIVbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0m5tFpJX5wci18KSbWHbdxj6yB8lKp7W72FNuqz3H3FPDAEP9RSANDi1IeZwpx/rFEsesjjTDaL6a7QF6cAKSwqjcbf9nvp/7sC+Cln9aSzVDn6HeIYZi5A5Q6Uucee69wQGq6Jlib7BkLUaj11aNxIfcWwhrqFnK0JRZebVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hvd1WYna; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783ced0216aso251321285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578940; x=1707183740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3noBpEoNcYkgCi0cr1quPQy/gMKhnK1FE9Og99etBLE=;
        b=hvd1WYnaT5BNguVj30FAaYd7ZgH0IAOpDrabH5bOi0DCgK5QnS7tEcgdqB7mPGGs9G
         YaR9cEb7S35B5OKpSImWU9BD9aByxPo1/VcSKzbswgyJG4Esr9xCQgE718NlURNMbYum
         s0Lbg67mv3AHmw/nehdQ1wUb8A+5vjcgjomXxzcqd2jWAc0cS8u4v6eJTqN7utQvfZdW
         65BS2FYDOQQSDtn2bhX2spCuv87NdnIA1Y4Dm7o31hMwsiViQr+GUTqI3Nty4Aqbd5Rj
         H+zEbvKk5idmNDW7rtF1qc9OA7pdaHRJZcRLGEXLbbuRG+W/nMDHsyKLzjHrMGp1HYfw
         gLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578940; x=1707183740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3noBpEoNcYkgCi0cr1quPQy/gMKhnK1FE9Og99etBLE=;
        b=p8dyk7aV83RJxnxaI6gsR+oBN2w9gRhxOyPD3HEjolv+l5wxzgcJE5pT6/FkHe3IWO
         g+2mz5946MmaIxzhQNi4Uvvh++ICQ/Qon6u/RAD1lxkwKtYLL2DofBkr/SMQM+Q4xpW2
         XsOKI0FBRC5+UN+faMN+my3E05Bg5jjxikKpsnN7rDCmIsxnKO5w8kDxDajSFaLKy+op
         lP6cM5AzbgazKvjkVYD2iAObBCzF4fNPmJh6BEsAWj3C+ba39qDb2DW7NyRiZuyu3oaF
         wGhdk6hxEI/2zBn1sbHbp2uoMBuCIF4GZSJrNkyM87VqHlLf4vFj57Jb/+m5phW9Eh7R
         W2+A==
X-Gm-Message-State: AOJu0YyCqpMOKd8/Dpyb3t4ll2xUw/norbetf/HzV8KhPpLIr9tvqNOD
	Yw5KAvOXrM2iy0bmPkARw4uodd91TjFLOM/LNNiolxiIu9YsvsKnim/6u29b5WRriiJ3loF9MM0
	B
X-Google-Smtp-Source: AGHT+IFva24g3oCWu71j33LtFcxZP97ALn5FVyB0OWjRs+hYHzvHicsl+CzPH8nqY1WBmS0gQvju2A==
X-Received: by 2002:a05:620a:28d4:b0:784:79a:ce59 with SMTP id l20-20020a05620a28d400b00784079ace59mr1212077qkp.26.1706578939943;
        Mon, 29 Jan 2024 17:42:19 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a205700b00783f77b968fsm1879593qka.109.2024.01.29.17.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:19 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] mm: zswap: clean up zswap_entry_put()
Date: Mon, 29 Jan 2024 20:36:41 -0500
Message-ID: <20240130014208.565554-6-hannes@cmpxchg.org>
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

Remove stale comment and unnecessary local variable.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0c6adaf2fdb6..7a7e8da2b4f8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -546,15 +546,11 @@ static void zswap_entry_get(struct zswap_entry *entry)
 	entry->refcount++;
 }
 
-/* caller must hold the tree lock
-* remove from the tree and free it, if nobody reference the entry
-*/
+/* caller must hold the tree lock */
 static void zswap_entry_put(struct zswap_entry *entry)
 {
-	int refcount = --entry->refcount;
-
-	WARN_ON_ONCE(refcount < 0);
-	if (refcount == 0) {
+	WARN_ON_ONCE(!entry->refcount);
+	if (--entry->refcount == 0) {
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
 		zswap_entry_free(entry);
 	}
-- 
2.43.0


