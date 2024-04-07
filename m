Return-Path: <linux-kernel+bounces-134504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FB89B24B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC21F21602
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F339FDD;
	Sun,  7 Apr 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkmRJo8v"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863AC3838A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712496823; cv=none; b=INdfUN3ppSqdgZvInsApu3v9NME6FJyDxCTg7Aldl7v5ck5lufkOqklag9NCF4k/bSnW0LSqkCQevAMzJ+zJSbDNymybu8k9Qsb+L2e8xPQuDriKmOhWfye+i/7JYhFOwoCkDW/R7NeZIMFCC1xltw8bWzE3BZzhGBAbiDlamww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712496823; c=relaxed/simple;
	bh=vEdFZ3XH5UC/kGPwZlxG2ZU35jbh7nfLdrwNQKRK3Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cm0BBHUYDhasXqBxQwJmatVrz233GOasvggC/pny/mpEdsiy4QI9TelICiokWVWYGTvuFFbuXH25RXfmljcWgHk9LI2Y+ijZARrnV8QV5PDiYsUDZJQ7f7C21pxsm+VOu2+y+3pHPJxt0xLTHf+m7LaSUSy/oUZPP7VLbwG7geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkmRJo8v; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34005b5927eso2343864f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712496820; x=1713101620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XpyPx7qA2rxEu7q8/rxvJ2qD4iyIGQSw8yw977aFHsQ=;
        b=jkmRJo8vTUvFTiAwyxQrrfNqC7Z0Qh7bLaH2NaOYUhxduNR/K6ChLXf2oKVmU/Kesz
         YaEFLK7UtxCWA5GJgezDGjToSYeCRaAXZWZT521ootTDp5BhlNYd5rl64+HGU6PWToAm
         lIesoXo3YkDmeq0uZfvBHrNN1cPvlMdZveHNGSXMv6LbOUNLrVlUVTtubhPFIu06BQXB
         9n4F8IFAZsQWhmZX2puKODlLu4aKl9+DGp3V1TkrOUbH6/VZOfyC5QpYcB1qDCQDrTcv
         i7kbVi7ys+lGzBir5gWZCXEXHo4r8JoO11Ba23xwU2Ni3ymp8FKWTMZLA1iw/8nC/Yf2
         OULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712496820; x=1713101620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpyPx7qA2rxEu7q8/rxvJ2qD4iyIGQSw8yw977aFHsQ=;
        b=gc003wUpdIE9gG8C8eAYEz3nJISR++HlQTBd04zQpLhQTI0W6qNLlecreqPN3IoF3M
         qfr5whX8CjjFpY3EDTWuswPKa+NQPR2UGfW6y4HLBOi0BNpoPui8BJWoGeN/kkt/SWtE
         CgxzBj0kRimhxUJvfjrC1g+8cttf8ka92Ne3iof0BpfQmkEaUx0sdLuGNB3hgBYi3DdX
         32ifZ0d3hL8H3w1b9qu+pb7VcepPYOrHHseSC5dEjhWmmoZGWhOGEkwrWcjbATWFjYIE
         Le1+JvPwrboQjzJg2EnggbryRFUmkpK00YmhVGC5vrIVDHmIQu9D+sjeNI0CMNAAuFa/
         uH2A==
X-Forwarded-Encrypted: i=1; AJvYcCWG35YjksB6O+LGfrrMd/6rVY7TLxQUUY+YuxFgz28K7e4gt5+DmNd67jurq6K3B0bV46R2KkjEthCYlBSJnndK/B2wolkvDTpsw8bD
X-Gm-Message-State: AOJu0YzuAc+6g7jEXv47SUzJEjjCVCR2unOyQ1yyYM+9xeboU9wcVcdJ
	D1c1y6i5lptlnysf96vGxdbeQcYrj8jFhPs0eIcAOnbBaS6D5gix
X-Google-Smtp-Source: AGHT+IEyktO4eMlUeyMlxWcQWWQOCz5MfphZsNb32oiOfcaTeRamgm+qDAa+UynH1INQTT7j+S9YbA==
X-Received: by 2002:adf:f9cc:0:b0:343:668b:be04 with SMTP id w12-20020adff9cc000000b00343668bbe04mr4191121wrr.3.1712496819659;
        Sun, 07 Apr 2024 06:33:39 -0700 (PDT)
Received: from localhost.localdomain (soda.int.kasm.eu. [2001:678:a5c:1204:59b2:75a3:6a31:61d8])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm2406208wrx.93.2024.04.07.06.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 06:33:39 -0700 (PDT)
From: Klara Modin <klarasmodin@gmail.com>
To: akpm@linux-foundation.org
Cc: surenb@google.com,
	kent.overstreet@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] mm/memprofiling: explicitly include irqflags.h in alloc_tag.h
Date: Sun,  7 Apr 2024 15:32:52 +0200
Message-ID: <20240407133252.173636-1-klarasmodin@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/alloc_tag.h uses the macro this_cpu_inc which eventually expands to:

 #define this_cpu_generic_to_op(pcp, val, op)				\
 do {									\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
 	raw_cpu_generic_to_op(pcp, val, op);				\
 	raw_local_irq_restore(__flags);					\
 } while (0)

The macros raw_local_irq_save and raw_local_irq_restore are defined in
linux/irqflags.h which is not included implicitly on all configs.
Therefore, include it explicitly.

Fixes: ac906a377c67 ("lib: add allocation tagging support for memory allocation profiling")
Link: https://lore.kernel.org/lkml/6b8149f3-80e6-413c-abcb-1925ecda9d8c@gmail.com/
Signed-off-by: Klara Modin <klarasmodin@gmail.com>
---
 include/linux/alloc_tag.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index e867461585ff..afc9e259a2d3 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -12,6 +12,7 @@
 #include <asm/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/static_key.h>
+#include <linux/irqflags.h>
 
 struct alloc_tag_counters {
 	u64 bytes;

base-commit: f43b3aae94511d62174c3b29239da0dd22d0eeb3
-- 
2.44.0


