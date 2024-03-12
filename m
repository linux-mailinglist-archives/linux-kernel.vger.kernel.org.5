Return-Path: <linux-kernel+bounces-100844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A37C879DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60023B22E15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B7143748;
	Tue, 12 Mar 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAPlN9g6"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DD4AEEB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280740; cv=none; b=T3zK0TAfZj4V3bF+iFjZlT/N96XCTAo9sOJ6BwlTZVNR+xk4Dn/wS2XgRebH9CEU+it1eCnGpshCThwBApJLpWrQJM9cbONFwhJUD5Mia6FQC+axpGz3MbRYZ1jlru7CyVMFrdjOIV9otSuazXJ1mV4rPVHGfrokjBWuNdBpCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280740; c=relaxed/simple;
	bh=UkP2oqitBaKlKxu5Lo0O/T2Ghg0lIRzJZ/hY0NyU2/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6zk84FWiBBxHGlMIlSHoNcDddiY9e6Al83ln6ZA/VaULGdkCzy7fHseIPBz+yiF6DFoJ1Rjvp5LkSIPsNPEhf5+XZ7nCGDfk3SLPuZ2YXw89Q2mfQTlg/lrZKqCxmdDVy+JgE83MY4G1/2vA7UG2Scl4/M2yKVRufp4SNY2dH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAPlN9g6; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed179f0faso244320276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710280738; x=1710885538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydXkZwv9V3NwRoIP3DyKezxKOPgcLP5qOzwyD4YOZIs=;
        b=DAPlN9g66xvsnr6lVUlrLaL+3m91GvFgltPN96rtrZwfqz5XwX21Iaz6h0x2x6WndQ
         T8atfM2v6ijeu3PwB9DjAXRVQtag0p9osoXTJtHy7/DanRRakuuS+O2+Imk0I4jJE6gh
         4J6p6aVjNsuO7wOQucBoEKvrFXc9gosaMOovfd0C6fzusFGjtVkKkSFeLaghKG7ho11L
         8Ubi+h/NaeIsTYEfUcPDBZYiLAeZHTV/x1ATJy5YQQz1JRFV26ZoYHiqHQlEXjTYH4TM
         kbwOmfhK1156NgUuWRCUsGYlaMFRgVcmWqUXNqpPpaQc59kLxngKHZHRJ4+0ksTx0tZL
         fc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280738; x=1710885538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydXkZwv9V3NwRoIP3DyKezxKOPgcLP5qOzwyD4YOZIs=;
        b=G1M1RyA1apCsyyLYh8ha8FjOQQPcMv2ja+w0O11Z8Qd6OvJr7JghGK2HpoZXJiR8Bf
         uK9hW+a2okBnAYZ52myXAls2triEjBWtQIpvVkqlfk7sTwsaPrGB+cyKtW5RLABUVBh+
         ffF9cIJA1giZkLpJhUqJRG5FLHKqMTgc4pXX2OBvQUzgD+xIkSbilxnjXr6S6kCToxct
         8yMQHYYdHNc1rnDm2hzq6NSTZ4VcYiulAizBrrUhtLOMEimDHkOmUD5UkSOCcoDX9A4F
         XpTKhMUPXexJzoD3qzTxDV4OWrnmgadoq4j+aZOhI+qBZu5saXRKclDW/jx3cZH9KhT6
         xVeQ==
X-Gm-Message-State: AOJu0YxIXHe5sN0vqyoSFhRc9kEI2SP9NBtyKvjMqIP9UeeN3a6i5eaO
	hcxj6Z5B4utg9ZvP5B0hPL8iGOpWAIxbSUCv1KsV5JrlmKtdxjX1nKcZPHgo
X-Google-Smtp-Source: AGHT+IEmelupohGUzF0WByBT2S0ceILYWye+1RyABOQe2XEddNBiSSt3ceGebyKOF9JNSzAajwpmKg==
X-Received: by 2002:a81:e709:0:b0:60a:f3e:9474 with SMTP id x9-20020a81e709000000b0060a0f3e9474mr650350ywl.17.1710280737751;
        Tue, 12 Mar 2024 14:58:57 -0700 (PDT)
Received: from localhost.localdomain ([64.234.79.138])
        by smtp.gmail.com with ESMTPSA id t78-20020a0dea51000000b0060784b3bba8sm2121986ywe.35.2024.03.12.14.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:58:57 -0700 (PDT)
From: Kendra Moore <kendra.j.moore3443@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kendra Moore <kendra.j.moore3443@gmail.com>
Subject: [PATCH] doc: Fix typo in drivers/media/rc/keymaps/rc-khamsin.c
Date: Tue, 12 Mar 2024 17:58:54 -0400
Message-Id: <20240312215854.27861-1-kendra.j.moore3443@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects a typo. Specifically in a comment
"supports" is misspelled "suppors".

No functional changes are made by this patch; it only
improves the accuracy and readability of the file.

Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>
---
 drivers/media/rc/keymaps/rc-khamsin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/keymaps/rc-khamsin.c b/drivers/media/rc/keymaps/rc-khamsin.c
index 2121cad8d3df..88074b23125b 100644
--- a/drivers/media/rc/keymaps/rc-khamsin.c
+++ b/drivers/media/rc/keymaps/rc-khamsin.c
@@ -7,7 +7,7 @@
 /*
  * KHAMSIN is an IR/Bluetooth RCU supplied with the SmartLabs
  * SML-5442TW DVB-S/VOD box. The RCU has separate IR (TV) and
- * BT (STB) modes. This keymap suppors the IR controls.
+ * BT (STB) modes. This keymap supports the IR controls.
  */
 
 static struct rc_map_table khamsin[] = {
-- 
2.34.1


