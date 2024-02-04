Return-Path: <linux-kernel+bounces-51645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3AD848DDA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358E7282C60
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236E1642F;
	Sun,  4 Feb 2024 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J//Tquri"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392B225B2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051280; cv=none; b=VpeWBeP+S94YYyCy2RrIY157TvJ/0KgADQcRNT6X8dmXHnZyJ9+84UIWhIqsGSQPSoZxvVTrU8CQgOlFWqTwPiGvk8F4R/XhTXrJapxQ9ngoX3Zo3K2gInMqdwta9OAoV3BeQmDPQnacP7PSXjX+GJG0YrgnU/zOvS+kGvIJrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051280; c=relaxed/simple;
	bh=yX98yZz9bh6TkXa1p8lJWZAeQ1Ovg4lal3xzOaBMMpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=av38DDzBLDNSFRfqiFwLVTjukOtQdFMiIe3o2WCHMQRy8X6WAVxRewtnC0OMOCIxgMLhydFxqYJafJMtFVGcao+1puW9bHu0SG2iaYzxGmBfKVvq8AN0QkprpmwW+VO6RGn7ckQXUBA2WFnLUpSH3mxcivdwua3DELbmsJ93kJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J//Tquri; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dc11fdddd6so583566a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 04:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707051267; x=1707656067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tAC4bTgcHhyuinc/GPvD04sELvx94YbTxerqzMu8Bg=;
        b=J//Tquri7h+ki/O7hCWKV4zjS+C1GKn3viupyiCuijngZMY3DgCXJstVALSVtwPd2c
         YM9oZfdxCqkfhGXMKCo6f8ajMWSe+F5KheizX4kgUY1dpZbjcSUzQPlT1h2Rbiv1VkEx
         VHlKdALsLmorRZlgC/k/RQ4RYk8gaaFUASFW7xc91NwNjGy/dKD/alIvmo9e4F/B/RV6
         FACDyEKZ+htSX1TQkAC2ZpLKWUtOohhlGkrFJf6Le6Q7xQwftxwBjWKW65LNs4tWotJR
         Jp6QV5bMomVHfcu3aB10ztHKoIcZG4iJdF76fBlnRneYmlnctkWLtI946s0vZGJ4b3Ro
         hntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707051267; x=1707656067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tAC4bTgcHhyuinc/GPvD04sELvx94YbTxerqzMu8Bg=;
        b=vVjxEq06GhFvZNDpzU7GThOI53LqW9C1PdzVUOXF2htSa2NzZbsxGFfDGkCOhKcf2B
         C0TCBxWQGJcHch97Hgn8Umjy6gboKdxXceJj3Q149mQ2AVs+fMOcTh6k0JLL4ro/AxwD
         ad3DAKm64b++ACtDFg298fAqm/rFU2TJOi1W29vphHRTf8WZd+GuMUiYaE9git+asBTU
         AysZEsVr+oy2BFmki4lm6zprm+EcaJ2RhO0KfgF8eqzW6WzJvUJesfoFO0PqKmeLSdaL
         9Dkn+KtaMSu/KZC49HNRL79si/xCDrQC6Yrju+8tujEpyHSF1oMcfUJGZ80R+CdE8GbN
         E8SQ==
X-Gm-Message-State: AOJu0Yw/Na8/RkTUzQkpzlx8doUdD6Z6CpUxl34vIHnhFDjBHBTNBBB3
	L/+MOHcZsSIPvD/LpX0zjkPgOwwmvyNkfjJoT+Kw1sHqFGzBOECd5cwW26ayyNk=
X-Google-Smtp-Source: AGHT+IGlXfGyxxKUEnIlqEAr/CCBYz0TEKQOucz6PHY5Wetp8CrFWgyvvXpwSUAohf1uq2WCNuXvwQ==
X-Received: by 2002:a17:903:2b04:b0:1d9:7ab0:5e20 with SMTP id mc4-20020a1709032b0400b001d97ab05e20mr7448141plb.69.1707051266767;
        Sun, 04 Feb 2024 04:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2P3M441IKo3m94kcEIRyLqmQoSjqPXpbfoHeFX+kaEVe4IRHlE8e+6vNrp+rtriUX5uoFL4D/zFlmli9GWz2GA6Qu0KZAYzDd+wVjQHfqcSdN/dUzNO/esBTcZdhfUbYFVkrjYBMeufya
Received: from n37-034-248.byted.org ([180.184.51.70])
        by smtp.gmail.com with ESMTPSA id pt12-20020a17090b3d0c00b002968824041dsm900193pjb.5.2024.02.04.04.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 04:54:26 -0800 (PST)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] mm/z3fold: remove unneeded spinlock
Date: Sun,  4 Feb 2024 20:54:04 +0800
Message-Id: <20240204125404.2112384-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to use spinlock in this section, so
remove it.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/z3fold.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 7c76b396b74c..7f608c0667f3 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -442,8 +442,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 	WARN_ON(!list_empty(&zhdr->buddy));
 	set_bit(PAGE_STALE, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
-	spin_lock(&pool->lock);
-	spin_unlock(&pool->lock);
 
 	if (locked)
 		z3fold_page_unlock(zhdr);
-- 
2.20.1


