Return-Path: <linux-kernel+bounces-98427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1848779F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6044B20F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9C138C;
	Mon, 11 Mar 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBf25Hhf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0610E9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710126481; cv=none; b=WCpiHN71YQxQoiMshdt0MVXctPmYmUMNLSaICGP4CDOIEwk03jZxn1rhjcQkFTpKtf0gqE6uziJFWk8XzzoFWo2SkVRkv27tzeMjizyL05IjsNVTqY4EQi5Feuza2Rq/lDesv36lunIviAVzM2KAdx4b0OIM6PXoImylwyewLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710126481; c=relaxed/simple;
	bh=JbdzwpkpfFS2iVyC+TBl5OYTX5A6aFX9CDpXRqHxk58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qyNeFpuBampylkOpLc7AEsjrWA9QPJ2KOiLmTzQHJh2So9flf10wK7I1XqQVVIqQ7z08cL2u0EBOKGgALmb10syaaDG2Ccba5O88c3A+u98SUKm3gDDWd/ILyAysGWy0DWi+SPAv2xrLOE21F5CAmyqYnszHYM12EXK8ydEEO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBf25Hhf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd63a84f16so3674585ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710126479; x=1710731279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcGqr5CIuEqHVlI4/PROdr6v9f2SLyEhz6wyKlzGBoQ=;
        b=cBf25HhfmOtcuNZ82BGOcs3QIDknEocwnfIjKshfWlehXxo865vepAc7j0oY85dVAF
         18/7HqPDr/HfbB6AYJZjZTMg2HNcPenHYS4JPKyWRnZu3FLTiOM5NYGiEYzqJScU7YHd
         KXj+XTIzNzIot7MMnpnAyYz6iDBDwd7qOv+w9kLptFgUSrXZUtoRxQmX2+XguEgoZjJe
         nNsg5+nyQe78Rl/0cHQfxeNiXNhEfjADcBG5yRQ0nFJVAF1T+FbFmKWV8/JOtldXWAqk
         Uuk8Cdi1kwxW82hNMOx8lnf9ywasw1tY9qgIGxbAgMICaxxLP1Wl10KvR9WoFrKechkq
         zpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710126479; x=1710731279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcGqr5CIuEqHVlI4/PROdr6v9f2SLyEhz6wyKlzGBoQ=;
        b=g7X4hUzxTEDihnxj/gXfHj0yt16FPa5EckYCDHPpiMRv+yDaLEQtQLqYNgbdsF+wE4
         z9/h7rcDM8lwqL/M+pn/L5tTxHONlk9iSB8fP7zMYl8r9Ha/sqnK3Ku7i/L64oqkH7rn
         NQIF9IPp5X5vf1hsO0dN3CGLY6oZL69mWaLccjrtt6IuylCYQxuJQoZD47gLLY3fxKBV
         7tjKgAqQyZNzbrvNdiQhZEmnGJhHVNVhh3C6iEM0JXdWV8NYxwLcB5mgoO2PxrZddH4o
         uxOrYB+g9Jnoc42u3JntJHD0THDNchBsNItCeR62P8CdUtfYAZBi26maBxpYLJwIqu9V
         wE/g==
X-Forwarded-Encrypted: i=1; AJvYcCVwpKS9JRoHivZuW6u6MXv3niqOubYlU8NW3pIhRUUrrmgcIi4p4qL9Rd9LkVa0pTKgXG9CSbNWDKvdGlz/xySYrf+q/nNPOj3xBydk
X-Gm-Message-State: AOJu0YxYTo0mzZbqUz5AHYkUFgoLoTPdLL2ftYr8AMkfNHbYJ0DzHWRd
	BIvVBS2RGm7c5bIxJ8LTgt+lcAn3ArN0OkrzyWPwhO98elLvlN3q
X-Google-Smtp-Source: AGHT+IFPLoe8prsZnH/IcoheBux0DDIfZMnWJLPR2QtXvxdPGYwSYwOHsyS4BA4UTnwXv3vSOk45Yg==
X-Received: by 2002:a17:902:7b91:b0:1db:94a9:f9f0 with SMTP id w17-20020a1709027b9100b001db94a9f9f0mr6247911pll.2.1710126479574;
        Sun, 10 Mar 2024 20:07:59 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:b289:6f57:682e:c7f1])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001dd8cf4170bsm1879641plg.230.2024.03.10.20.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 20:07:58 -0700 (PDT)
From: I-HSIN CHENG <richard120310@gmail.com>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	I-HSIN CHENG <richard120310@gmail.com>
Subject: [PATCH] lru_cache: Initialize hlist_head in lc_create
Date: Mon, 11 Mar 2024 11:07:35 +0800
Message-Id: <20240311030735.233470-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use INIT_HLIST_HEAD to perform the initialization for each pointer to
struct list_head in the variable "slot" to provide more safety and
prevent possible bugs from uninitialized behavior.

Signed-off-by: I-HSIN CHENG <richard120310@gmail.com>
---
 lib/lru_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b3d918761..f2197aae1 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -105,6 +105,9 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	if (!lc)
 		goto out_fail;
 
+	for (int i = 0; i < e_count; i++)
+		INIT_HLIST_HEAD(slot + (i * sizeof(struct hlist_head)));
+
 	INIT_LIST_HEAD(&lc->in_use);
 	INIT_LIST_HEAD(&lc->lru);
 	INIT_LIST_HEAD(&lc->free);
-- 
2.34.1


