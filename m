Return-Path: <linux-kernel+bounces-139702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD58A06AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36CF1C20962
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872A13B7BC;
	Thu, 11 Apr 2024 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE8y4XgB"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5E13B58D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805932; cv=none; b=bFHFqN3xDGLiESg/EFKEnrtGRG1V6n/g3sBUufNW2N8F3HLAwUU6O1CN8jdbhO08OvcZCPaMAx6kjlf8VRHA2CKqD0P6cC+n9e5PsgVgWeNiahrDaXSAKRDiHXnB/bJBJgy/UOK+wz83fVY38rhHtrfz2+gn8MYPNoSUNxH4IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805932; c=relaxed/simple;
	bh=KeJpTltWvp34aLVwOhgfYkJ5qkUafemwD40qWwAeh3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8RY+sd3TjAqfVGSi/+0Zsjy8cx2H66SSflQnilQ42hUlipyEtZMOQvSHaY1djqv6seyY8AO4q8RLMCfGTEbrIDLb0415lcpQn35gmmuULIOLoWD2Y0mOCz27b90oz6m6zkmSWDOA0kfbyv68Bk5KXRrul4yWoJHk8EMEXHpZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE8y4XgB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so5411505b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712805930; x=1713410730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZCVQwQdR/DxF6xfmiAlaAl/0HcO8Z3D8nID8IjezKs=;
        b=gE8y4XgBc95HY0UikWCKZ+TZ/GdyGxC886oMCzSpzIUTM5L0cD1JaFrxXNvqNOP4nI
         jsjbb5dG60YsIsaYC+SVSB5NQquyHBmgGei8Cqxexx99f/pzOeZz8xTYKjbt2Zlan0/h
         0L710SzEEw05MBE9YZl1LuKgkrev1m3HEOfS1iKfLWjY2wcEYytyyhniESm7J9xfMHpy
         +GxjiaM1RJN/k1bNge3yfsaWU0dMR28WZ4h7kv1ysxowgpjlptcJeY+nMgjBhOvNt9eL
         RTLv9d9oMYv5/Gu43hBqlc5PxQxDz1YGE9+7pBe787kXK4xexobAo8xtOZh8RmWFoWps
         pPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712805930; x=1713410730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZCVQwQdR/DxF6xfmiAlaAl/0HcO8Z3D8nID8IjezKs=;
        b=kMNAO51qG0dG93UN/fCeMi5Y/DdPHxTGmc72Yn3UDZGcCGpSK2gqxnC5O3G95jykpC
         sK//I/PQHxnPZfUbB19Z751cLEqlUFEJHcnnZP7gUj/NjS15N4ZxKvBmLLiOV/RAgJz2
         1d6Fci43Ze9CYVtF9C4ECx590NokHKeaHx78bofD6efnkc2NjQqictohRMqgOSKnb1xx
         dqEZTkx7R1umIWmdBl9rz5+c49UrE1fNZRJ/36ec9URSeBCR5J+0NYWJQa2igq0PY5yb
         rx4grHgzBgSUHlgyrJqS0g3cqhp646sRf8BUF0s9nZeelXggn+b/vBbZezUAHUSxcLal
         Qxuw==
X-Gm-Message-State: AOJu0YwseB2nnwSI1g0a9FMnmrUUA5FauwHmSDi0259ysSufNsj9YBUd
	FGrk6brcyCX1UO3+AfP4RQOiPtBRDuRQ56MLaCQWIdTS9Gajtd5/YOk4FrYM
X-Google-Smtp-Source: AGHT+IEatWGVQe7Ck21EmGAwH0HjtX/BkRCYMl2wwqQvwBZih3ySnsqeQLvG6b52v0LEawM+IEOvfw==
X-Received: by 2002:a05:6a21:3396:b0:1a7:23ae:92c3 with SMTP id yy22-20020a056a21339600b001a723ae92c3mr5428278pzb.12.1712805929823;
        Wed, 10 Apr 2024 20:25:29 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id je14-20020a170903264e00b001e22e8a859asm297139plb.108.2024.04.10.20.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 20:25:29 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mike Rapoport <rppt@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] init/main.c: Fix potential static_command_line memory overflow
Date: Thu, 11 Apr 2024 11:21:55 +0800
Message-ID: <20240411032155.208042-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
static_command_line, but the strings copied into static_command_line are
extra_command_line and command_line, rather than extra_command_line and
boot_command_line.

When strlen(command_line) > strlen(boot_command_line), static_command_line
will overflow.

Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 init/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2ca52474d0c3..a7b1f5f3e3b6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -625,11 +625,13 @@ static void __init setup_command_line(char *command_line)
 	if (extra_init_args)
 		ilen = strlen(extra_init_args) + 4; /* for " -- " */
 
-	len = xlen + strlen(boot_command_line) + 1;
+	len = xlen + strlen(boot_command_line) + ilen + 1;
 
-	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
+	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!saved_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	len = xlen + strlen(command_line) + 1;
 
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
-- 
2.44.0


