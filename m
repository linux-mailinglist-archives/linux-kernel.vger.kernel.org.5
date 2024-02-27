Return-Path: <linux-kernel+bounces-82472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382F86850A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3492852F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E1E555;
	Tue, 27 Feb 2024 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LYBBrYFC"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D25223
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994200; cv=none; b=Qw/XCOUjm+AngDUtA0GU+lVuRH/AnIuDKAI+kUp0GCJcWxtnNaI+enuLoqAn2oaV5QupfHE3JH4O2vKWFGZnsrDx9awLSzzKN71FPTcj2FMAalG0k8KsL0O3iDWHJjbwQY8Y964NlRE+8XE1+YYkgdZCsWLPWAbT5P4fFnRCcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994200; c=relaxed/simple;
	bh=pjl4fEaMJkh7DZc3EiKaxaa2HCJZf6Iu0TXjya2kYwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxUWu7FeYP6vDW6sy6mhPRI49Lw/t8yARwrTpdQXB5iVr4jyECTMLIc0Lg7Eb7Eciz6w8xeCYFpqlvtobBbTv7cFdIFiNrTYivVL1tD3xSf5l7w8D4h7TQNQcWR1QoND2JGV0KQnd7Ghy/O4WgA+IRwbhpW16Sq+xq5HvcdX5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LYBBrYFC; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-204235d0913so2574305fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708994198; x=1709598998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IhytZLl3RHTt2r80xPYLkB9iZxHThEoH75QMIzrbQ8=;
        b=LYBBrYFCBqmHYY4jYJk04eL9VVtk9pCYpc/tRIs4YN+e6YuCQL3ON6on7+aPNyd0qG
         ZNyL/a7ZuMgzrGZv8qjI97BOCl5/TygDsOCkWlC3p7iE6dWGn8e8dVQGxdza2SH9/0rG
         sS0nW7M8+SnBglAyMopliXeBZLewRoLzd2KebRVcOADKKh8c/2NbmC9452l+i5HN0gyz
         T/AstmFQdAZ3IdGwu+Xh7/5VogMqB/3cCJBj6HLP8/QFc65O/lymtuW8nwj2LNa0ISGV
         gGWPV6tCSFSIZhzr1kPODoeFkus9cgN+qK5cxN1xhqm4P9Q9L2ugI9Rief3ZtsvfDwHm
         sEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994198; x=1709598998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IhytZLl3RHTt2r80xPYLkB9iZxHThEoH75QMIzrbQ8=;
        b=C9U/DdeBG4DobvcwKbjF1nCYFfARfb4W5ABdLmxcC8dv+qKintIXG9CypJIYhjCfum
         vA8sSXNR3IaqEt8sT0269heKU6Mg3QRaZp21hlhUOrHPJ5a0sFcfiIOPTlHboG+1m1w5
         3i3lU7FL1uJUiFgUbGBtF4YqEB+bQ612m+1C3CmNvYjOdK5acKasdNTP9Q0i5zwC+ecN
         HtBK7q4JGU03fInWDAGbdGsIdhNcqmMhQOZWCOuLfElbmkDCULb8VzK6DPAi7+3n6lbB
         3QSerI9R40TPWkN2fjtE+Xt3QfVEJCOUYCFcDgwJbz3bZt6AcRAqXqBVTSU1ng5RXJXF
         OmzA==
X-Gm-Message-State: AOJu0YwcqACjzKyFFa6ZgI424cnuQXERSsjlpqYbTaBIxGUCKLh1ecr5
	C3+yPtvrEs/QJHyHK+V3Xmf34/obh0g7ij7JEwrlZ4VKBIhQbCKwLY8plSyXdRI=
X-Google-Smtp-Source: AGHT+IHuBZg/S/3Di/VYl17m/qNJYD118ohwXH+f7ieMrzQ9VNxL/lys1ubJ/2vm2l8Q2yXGwE0xZw==
X-Received: by 2002:a05:6871:230f:b0:21f:a4ce:d532 with SMTP id sf15-20020a056871230f00b0021fa4ced532mr9485542oab.31.1708994197885;
        Mon, 26 Feb 2024 16:36:37 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020a631919000000b005dc85821c80sm4504117pgl.12.2024.02.26.16.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:36:37 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 4/4] riscv: Allow NOMMU kernels to run in S-mode
Date: Mon, 26 Feb 2024 16:34:49 -0800
Message-ID: <20240227003630.3634533-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227003630.3634533-1-samuel.holland@sifive.com>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ease of testing, it is convenient to run NOMMU kernels in supervisor
mode. The only required change is to offset the kernel load address,
since the beginning of RAM is usually reserved for M-mode firmware.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ef53c00470d6..0dc09b2ac2f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -64,7 +64,7 @@ config RISCV
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
-	select CLINT_TIMER if !MMU
+	select CLINT_TIMER if RISCV_M_MODE
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
@@ -220,8 +220,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
 
 # set if we run in machine mode, cleared if we run in supervisor mode
 config RISCV_M_MODE
-	bool
-	default !MMU
+	bool "Build a kernel that runs in machine mode"
+	depends on !MMU
+	default y
+	help
+	  Select this option if you want to run the kernel in M-mode,
+	  without the assistance of any other firmware.
 
 # set if we are running in S-mode and can use SBI calls
 config RISCV_SBI
@@ -238,8 +242,9 @@ config MMU
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT && MMU
-	default 0x80000000 if !MMU
+	default 0x80000000 if !MMU && RISCV_M_MODE
+	default 0x80200000 if !MMU
+	default 0xc0000000 if 32BIT
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
-- 
2.43.0


