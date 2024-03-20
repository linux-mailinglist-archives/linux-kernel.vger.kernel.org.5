Return-Path: <linux-kernel+bounces-108910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7008811D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2238B23039
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FC3FE36;
	Wed, 20 Mar 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQqnRjO/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3E36AF9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938770; cv=none; b=FB0q9unvQ9cBMNRMMniTxy2B00vKbfK0hCZxqUNVzqhjh8VdM4n01Q1Et2QCGb66Fta9ZOUc+CVMgazl5NlgxcOVz5YLu3UV5/PS4HOgxs27rLhfCk0p6vuBspnA6I3JTymns6B7aHChoc5pU5a2bbHr8lZo7y9cEjuUsWANrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938770; c=relaxed/simple;
	bh=ikYClmhkpcH/do1oMlaDvQ89lEcvUS8Ek8KBHY/2EfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvzEJaBq06FNPcO4Z/FGIelDqykYjTfLPl8bbI/GoWvcgaQi+kbSL6G1Mlcb9e6lMwkFmNppsjdbhWrLEUB5qJn+uQxnP47P/9aeSireZySNH4wepvGtynMHzQ9yLodkIhYqnPP6pFxJN3yOs54afoZC0XuZqSlxW2WhAo57U90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQqnRjO/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso8181910a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710938767; x=1711543567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SDAogGPuygwh29NPxgC639xPo+ijeYfHL0ce3uVTXM=;
        b=nQqnRjO/64mQTxkVZqBxGVp33+HCg0p4VN3Z8WWo0AScHMHv1pH/s/mW38k/2DHAIQ
         ukRN3OwNMml4KyFganjUYflMpbPj2/cdRrI1FMFu2WPSy5qCtupY+ntgn6M3p0BQKmoZ
         DiLFn3FGFpMFEjYqzY7NG6pr95SHF09VSSEN/7pKDDaYiyxGD1eQ6iNi47kL522/Wcx9
         mwzvFaj6ErfIJwXr+7CnBHCBNaCgr9ovxkff27GkQkhzToffYJ7qmA9LLBWoIQNbPKpv
         f0BQ+zqIHNk1eNXECzITqJ8GhTdKIQ/lFN5DXUNFmiInjQKzGZbIPk5dBCXooBW0rLZw
         KYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938767; x=1711543567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SDAogGPuygwh29NPxgC639xPo+ijeYfHL0ce3uVTXM=;
        b=bnmPhYyiffiCq8yRoTELZNFD4kC/lG9ZOZytmFFX7d2PaQq3JX95lGTaPka8Z1TOmW
         JI3hImKAFlQ+mMR1+y4/9xcfcgUV+FuamR17HmpR1NioSliWUiEnyXoZvW7gsbD8fsG2
         B7NBD3ZVthnm9RHo06yZ9lMEI2H43fJdHVbv048URHENs/76tpTAaV8zSaCvn7N0sU4Z
         fAkLSq2OxyZQMLBQqU1aPw2E4AepRUVFTeEZNz7yiVQV3kR29nXYQIEcdhWt2NqLDCeb
         BihNwqKjKu3i/fnJR11AG1Mbfu0Gn70iGG6G+NLu7Mw21IF3xiUOIWfie+ARBpVItjyz
         Elgg==
X-Forwarded-Encrypted: i=1; AJvYcCUoYfLn/oZP42uGvaedfx9nBqy156AzR5Q73E/f54nzZvMrH7cTcq6hmg+iwgPEDxREX+vtS+ErFVhnWO2ne5M4VBwGqDQrC4GLCc+A
X-Gm-Message-State: AOJu0YxXD+fB9UPjxKBsgh6uhQ43+TajOyCwwQNtqmobmHtMugd55EQE
	vvhy6sR0dj+Oee3FHn6CdjfX/oNHXVKbNMyD3Gc62VlhbCfZAogw
X-Google-Smtp-Source: AGHT+IGziFkEH50a6+b0uyCgxj7Ak3Kq5dp5DCRjJnl/FxDx+CFAjRJcOuUP7Wt3pjBL0rIPrgYrLw==
X-Received: by 2002:a05:6402:4348:b0:566:d27a:2ab5 with SMTP id n8-20020a056402434800b00566d27a2ab5mr11995634edc.10.1710938766558;
        Wed, 20 Mar 2024 05:46:06 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7db99000000b00568d67e50c3sm3731936edt.89.2024.03.20.05.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:46:06 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Re-enable named address spaces with KASAN for GCC 13.3+
Date: Wed, 20 Mar 2024 13:45:49 +0100
Message-ID: <20240320124603.566923-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 68fb3ca0e408 ("x86/percpu: Disable named address spaces for
KASAN") disabled support for named address spaces with KASAN due to
the incompatibility issue between named AS and KASAN.

GCC 13.3 has fixed this issue (GCC PR sanitizer/111736) so the
support for named address spaces can be re-enabled with KASAN
for GCC compiler version >= 13.3.

Note that the patch considers GCC 14 to be fixed - if somebody is
using snapshots of the GCC 14 before the fix, they should upgrade.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7aed87cbf386..09455d93b947 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2435,14 +2435,17 @@ endmenu
 config CC_HAS_NAMED_AS
 	def_bool CC_IS_GCC && GCC_VERSION >= 120100
 
+config CC_HAS_NAMED_AS_FIXED_ASAN
+	def_bool CC_IS_GCC && GCC_VERSION >= 130300
+
 config USE_X86_SEG_SUPPORT
 	def_bool y
 	depends on CC_HAS_NAMED_AS
 	#
-	# -fsanitize=kernel-address (KASAN) is at the moment incompatible
-	# with named address spaces - see GCC PR sanitizer/111736.
+	# -fsanitize=kernel-address (KASAN) is incompatible with named
+	# address spaces with GCC < 13.3 - see GCC PR sanitizer/111736.
 	#
-	depends on !KASAN
+	depends on !KASAN || CC_HAS_NAMED_AS_FIXED_ASAN
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
-- 
2.44.0


