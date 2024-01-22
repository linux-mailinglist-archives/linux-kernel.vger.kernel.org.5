Return-Path: <linux-kernel+bounces-33122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7028364F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A741F262F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E3B3D965;
	Mon, 22 Jan 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmTO/tUZ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01333D3B7;
	Mon, 22 Jan 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932139; cv=none; b=tGjWibXLqWzXqn/o8GiUyC+pma/E8eGo8Q1hKNo0qZuj/On8acy9lYWP98Iqq2/Qm26uPN4lw+czr/RqRF08pMoaMq2wUt1DjsuYmwbwR7vEECu48fjRqjjVCFGMUO7CwMF1uSKBQwKB47pNBspvWR2klT4ef8Rs10LpbKCGZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932139; c=relaxed/simple;
	bh=ERbftZ3Vd+XCk1UE8noci/tViuxyTk7z6UOt+ZHs2Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLhxRKHs9BzvJxLHeZvLjgYTLovlbcm1edEGJGul/BlRooz47/OTDANA3wSYadBlzEUwetGEUVcYVH67BiABqUjFk1GHCteMnpYn0xLuV0LSzHgEi3GdpY/eEx3EYf/AXuzlzvL4izRaE/rMmpMAA0pD3TjAOhMhjeLjcdrWneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmTO/tUZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dbd7f1a300so1523259b3a.1;
        Mon, 22 Jan 2024 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932138; x=1706536938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la+vRQhSHTIGLMc3mcFeHM8AWwBAMUAN3NmM93QvSNo=;
        b=HmTO/tUZfZnGamOKh+7vE8eZjCdP6/9GG8dCth0ufrmF81EQ43xXJXuyvE+4XPkUbf
         ADK0fcCISS69A/lFukyWolPBckDAj+Xj9L556QVZl/alk0r9Vg0k1ghsNPUshFLGBZ52
         ohhehxfGVVbBReAvkXMUcTKVTsShfm1Vm43S2cHf0pPwe+CGQJzB+tcwhh1kjnGMJfC2
         MNYP8fXnu4HdIQPbQCn7LgElVaT3dxmAE1fLJ8bgoLvEvLkUZCG79+3kFkybI+4S1XLm
         PzYbujbKzd4JCCdXcZbM8Aq1lzoBLsHErE/H3N/MIjLeuzal47Ya8UeQdetyMJHxW6KJ
         T4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932138; x=1706536938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la+vRQhSHTIGLMc3mcFeHM8AWwBAMUAN3NmM93QvSNo=;
        b=f9C8G4PgsYIzSkJ8COIdK7PKqAhBgFiyZTeMrmVMK6ahXWRekLXaQNT1GvL15ZDSLD
         hp8SvLbUUb72dSc1WnD1XnGn3WZ4CIqhlm+cwIHwATVvayxjabwPi8kVt41lyLbiGng2
         MWdY6MoFtkeEnd+zGn1t2FJIFS0WZPke55QGayo1iX2PZxieS33lgnc4rX80pMGQUecq
         4BgMm963wfKHP8nSuZBmKO8eY+jV+bXUyZPUYfvgh19uXB0+orRESAhamvZPgwSysbU5
         dGFUrLAJqGSMEj3lbUaGTbLm2ptJt91J8+f2H9NYZ1usy5BnlS9QaH2nAVdIrKM6ULQl
         agWw==
X-Gm-Message-State: AOJu0YzSBabZquII3/Wk+4aNWRuFWz4EynDMz/Lw1r7LGbv7eyDBy+2X
	dtVcQAK6AgVJweGRpZeIHqZ+/czeC0nl/wfEh+vusTxtq7cw1JIIH4xdtibx
X-Google-Smtp-Source: AGHT+IFlXVgxNNHnv4gj6Aw8Z8TH+81SJh+E6YLgOwRxh8uEMRp/HM4YCuvNOpXpCv3mXTzq3MGOqg==
X-Received: by 2002:a62:d44b:0:b0:6db:3103:a1e3 with SMTP id u11-20020a62d44b000000b006db3103a1e3mr5131122pfl.27.1705932137894;
        Mon, 22 Jan 2024 06:02:17 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:16 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] nilfs2: convert nilfs_copy_buffer() to use kmap_local
Date: Mon, 22 Jan 2024 23:01:50 +0900
Message-Id: <20240122140202.6950-4-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
References: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine nilfs_copy_buffer() that copies a block buffer still uses
the deprecated kmap_atomic(), so convert it to use kmap_local.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 5c2eba1987bd..14e470fb8870 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -103,11 +103,11 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 	struct page *spage = sbh->b_page, *dpage = dbh->b_page;
 	struct buffer_head *bh;
 
-	kaddr0 = kmap_atomic(spage);
-	kaddr1 = kmap_atomic(dpage);
+	kaddr0 = kmap_local_page(spage);
+	kaddr1 = kmap_local_page(dpage);
 	memcpy(kaddr1 + bh_offset(dbh), kaddr0 + bh_offset(sbh), sbh->b_size);
-	kunmap_atomic(kaddr1);
-	kunmap_atomic(kaddr0);
+	kunmap_local(kaddr1);
+	kunmap_local(kaddr0);
 
 	dbh->b_state = sbh->b_state & NILFS_BUFFER_INHERENT_BITS;
 	dbh->b_blocknr = sbh->b_blocknr;
-- 
2.34.1


