Return-Path: <linux-kernel+bounces-75498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6B85E992
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E78FB2398A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01B126F0B;
	Wed, 21 Feb 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebTIqFOX"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D54126F2A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549769; cv=none; b=OtnYIyJsLKJWtG8YXEf+Gkctg8LCme/2nzGcITsUaV1r+76cJtKk0w49aZBzekc6hlorMkJtyzIpnvZBOyNzgMn3pxDkHkJsti6NiXuCmeyDgXJ+K4A4oCIdVdsWJzeYEsIPXXyi1OnnYvIJILZLkDwxClt5Ct6MY8ta3BCcg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549769; c=relaxed/simple;
	bh=A7MgpSAgPwbO17hLGoDnvZLFVp7RaXADSRnNJuIsHV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLzHfTwRmmRS6+BCeh2D5dMTRDRgB2IBP8qVVxNOd2BnihbJ1o2wk+yzUW70IWgOEuqtmwOgStk4ZQegNWSYNcL76CX0W9+UUD/OEKoV0Xrwv9jKah0uRYJQZPd8s8Ph8jysjYyQbOvt5grTB6R4mhji9E0Zu+ZGqX+X/TJqhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebTIqFOX; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso5582728a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708549752; x=1709154552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgEgI0pyQ0ahFABUGJN4FTJZ0fWcQT3ObrmUIWNiMM0=;
        b=ebTIqFOXrwBWr5W/r/GgvnJLa1a23HmujQkU/C9MmMblPSV/Ee5dJPQoKKH8zEnPym
         t4QDJSx7rVtdOXxi3G/XN/DnpDpYWH/IvUJNwqcv3/AOq4mwNfLtS/C2xIoB99/cuVgw
         xmmnSDItBE+J7AfJtBAYQ2KCXtS2MLA6E8v2fA2pGol9/GHd2QnSKseyfZCuWPKE8Ijw
         jh1EyAgLbkLg///luBd4nOfSE2KAwy2mSyx3TDaoUbMcJ1hWmwbH1hRoo8Ri2Jxni0SZ
         4f8Gdk/Vawd6CRIqbZg4zGGfQo8bVtjtKv5hCDR4mRUY8spvI0RRnkaIka0Bzv7vqlaf
         SWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549752; x=1709154552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgEgI0pyQ0ahFABUGJN4FTJZ0fWcQT3ObrmUIWNiMM0=;
        b=XgBvTA3W7MSAnRSJVm5MM7Yc7xgzDuBC2BfMfMYz8wCxVQRmIY2mCjSTIbpHg4Z+po
         yf68ewqBGkZ4zTg29dZV3d+HuxX3ElLiWylJyBJghwWx/g6MBxVhNTARRAfdOrCoMHHC
         e/YOmcqgKlL8lxKSFhB5OovLIpvOz5yFoqWAOqP0kphxJlaUzDV2CYV0b6dXeL01CeDG
         Y4rVQLsgVshS0VXMr9FYB1TKhoad9LcF8gP8nY+ZE3Fie5lXkhCm4Sgv6/hTbUu5mYNt
         pGVdCY8S1PR6wKL6uT7EgH5N+Ogv8poED4gocTLnz9v47Vx97qmSUNySsE/gugOnBl/8
         CdBg==
X-Gm-Message-State: AOJu0YxGEAQoK5XvOsCNkrJpdDx3nD+9ULQPy6NDqrM5GXVQaGYuUvWD
	CwSQFRGRDIOfEJQrSvjXSPwS6qfDD5wCzZvJqAIU7ZLYp5hbrbq/
X-Google-Smtp-Source: AGHT+IGx4Ckh9+rgDzCEHIwqC+BEIR8tWS3MN+9/iDSLEeA1aJK0bU29MEZzWU3iKIn72xFWfbRGzQ==
X-Received: by 2002:a17:90a:bf0f:b0:299:6479:4678 with SMTP id c15-20020a17090abf0f00b0029964794678mr8599563pjs.19.1708549751681;
        Wed, 21 Feb 2024 13:09:11 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:366d:9fa0:e78b:3075])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090aaa9500b00298c9790610sm10004596pjq.6.2024.02.21.13.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:09:11 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2] mm/swapfile:__swap_duplicate: drop redundant WRITE_ONCE on swap_map for err cases
Date: Thu, 22 Feb 2024 10:08:45 +1300
Message-Id: <20240221210845.13488-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The code is quite hard to read, we are still writing swap_map after
errors happen. Though the written value is as before,

 has_cache = count & SWAP_HAS_CACHE;
 count &= ~SWAP_HAS_CACHE;
 [snipped]
 WRITE_ONCE(p->swap_map[offset], count | has_cache);

It would be better to entirely drop the WRITE_ONCE for both
performance and readability.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2: drop goto according to Andrew, Thanks!

 mm/swapfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..7cb6d9a2d51d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3320,7 +3320,8 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	} else
 		err = -ENOENT;			/* unused swap entry */
 
-	WRITE_ONCE(p->swap_map[offset], count | has_cache);
+	if (!err)
+		WRITE_ONCE(p->swap_map[offset], count | has_cache);
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
-- 
2.34.1


