Return-Path: <linux-kernel+bounces-161611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BAA8B4EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007001F21975
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D17111A5;
	Sun, 28 Apr 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Vn1lT1dD"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFA2263E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345275; cv=none; b=WWJVOjMQoDoKvj/uk9ZQSzYc+S84F/tnzBuUwFa0sl8z74SVyYs4FuEosD70mSjGIYjSofZaitZw1KjOlTyqKTuUFlaGbI3GRvHbku+nuYNEw5OzLtCADuizf/wCU6KcQfWsK1ChHNNs7GiWi7idUJ27+jSjJ9HuRCL+N+UaeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345275; c=relaxed/simple;
	bh=YfrGStHbweVnCvMwn8UTPUZKQBrHkwiqrt1nr0sCsZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRLaX7u4Qf0+4RRwMqDawbX8NFRi7rLwQ/TC8l9rJ6sMe5xbZ4xmRioWcw827PLW6hRrNXPfw8kJLNa17nUB5/o6p2NTlF2w9BVz55b6r4UKh9o+bxKiDld7LuwxlKBb+S3W7Q11MghmxzUcMH7hfWJtsFSRgeRGc5e4SBlJcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Vn1lT1dD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so3451170a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345273; x=1714950073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJeJ+1XziadzZSEMqMnXKNKhDjbxY+G/WMn03aFRDbU=;
        b=Vn1lT1dDqWoAaUS5vNvNyXM0/dDqvi88At+wk+wRyWQLRP983R5m9Zyagsw5gPemUC
         fmdkihuHQ3Wpx26YwXps0GrqSidBGhEzKL6V0wZNhJJuc3Dq6pABMJpOjclq2fAXHhxG
         25/d/Zzo0YQbIhm9b3pwew7SQ/nhsQ/IDWakxOzOhyHySizgk29oq5R/NM1Y95ZywFDr
         i/Ga66opsaWu1ka1r4pFE/73FahqKW6uICwAV6mcIKgroRK7dhPegk84I9L1YGX+pBAS
         PzKWSSrFv9VtVQfxEF0OexGfO7v7P7YNqVvAaPV5Zmu3A9sG/2o8tx1sj+7ztwMBMKRJ
         6wBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345273; x=1714950073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJeJ+1XziadzZSEMqMnXKNKhDjbxY+G/WMn03aFRDbU=;
        b=oXgYK76mv4v/5EFswTsPQqhB18khlsCB2IjoidjJLHQ/3znTahZ3is+DFlKqOZ/k5F
         DFpqZQqhHbNSkk2Cl16qAoo3rvibAnPAoKyz/Cd9e6/5CXmW+m6Vc+iQ2G6dA6FKd/TN
         yyrbfsySHttLFmknlE2Biy0m3zupRHkK/4jEGbYw3qMxSiZtYVs64QAZwKIVvx5GKqon
         QbZYVOkjBk99wreREre1kmvhjjzVudg/EunjOrOaoMiaeYCDnT2Qp3a90wx3rbPi78Yg
         VKOO6ecjJYljqI5TrLUXzqcf0/iL2zWcDHv4OYunKKmDu4wZnFjN3V3XGnG7zaRbOXl+
         g2GA==
X-Forwarded-Encrypted: i=1; AJvYcCWY9N2Jt8MuJjgijsaVQDazc7UjFDbshSH+Wt7wACF0Tcy+OR5AM/Yhl36cHrcY64xdf3pxyamsqNPmFroSon8FWp3nyjzZmbWh2KNI
X-Gm-Message-State: AOJu0YwaPlsBpTjLiMtc/q8vK305Zp/N2gvKU4W5yzWCldbSokUjpBuQ
	vMd80k9pgqhTxV649ioAhke3g9kSEjjLtHEgbNuLqLvvOK+AbHNvbN4ugICZYVo=
X-Google-Smtp-Source: AGHT+IGzPKnCf7hYz9wQBgtMqODuyuk28Mz5LJu+AKr4QFas/DZKtfxcDciH5KdVfrMJAS5KGLyrOQ==
X-Received: by 2002:a17:90a:eb03:b0:2a2:ba9:ba61 with SMTP id j3-20020a17090aeb0300b002a20ba9ba61mr9252623pjz.34.1714345273454;
        Sun, 28 Apr 2024 16:01:13 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:13 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/18] Staging: rtl8192e: Rename variable AdvCoding
Date: Sun, 28 Apr 2024 16:00:54 -0700
Message-Id: <20240428230106.6548-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable AdvCoding to adv_coding
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 938be9c27e0b..fb3c0dba9d16 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -24,7 +24,7 @@ enum ht_extchnl_offset {
 };
 
 struct ht_capab_ele {
-	u8	AdvCoding:1;
+	u8	adv_coding:1;
 	u8	chl_width:1;
 	u8	MimoPwrSave:2;
 	u8	GreenField:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b79ea0b42e44..6eb708ba80ae 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -251,7 +251,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		*len = 26 + 2;
 	}
 
-	cap_ele->AdvCoding		= 0;
+	cap_ele->adv_coding		= 0;
 	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
 		cap_ele->chl_width = 0;
 	else
-- 
2.30.2


