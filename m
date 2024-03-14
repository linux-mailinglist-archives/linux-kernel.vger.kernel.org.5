Return-Path: <linux-kernel+bounces-103830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F987C516
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B2C1F21D05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083E8768FF;
	Thu, 14 Mar 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmCxUNlU"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AC73196;
	Thu, 14 Mar 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710454820; cv=none; b=arRZDIoRyayP916q7qvI/uEtuxqTSiUsvESZF0u8DuXe6GwbyfN50KlJ0iuRHLVXY1wIlN8n0OsI67VpdloYpf+CdKN2figDOOFsi5EgX0URiNlp7+ebCQIj1YuxlCMgQQazZQuf/xm67TsiGuVixMiWWmwbEYONqZdhPSpOCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710454820; c=relaxed/simple;
	bh=ncDx4rsB+pbrxuiP8gaQoYKHQO769X5h2FCKQ5CP22g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWcTGCM8x5MPtVBxJ5mx+Wii3bxaNju+nRz7oUkYs7q6KY/AL331UFkdQxQJJzQg5ru7nQUSPKWWzet5NhwpOCwg7vy//+f3ZOi8Pwa1mU2UR1O3y6ZM6t0RTNvTItSdQFwYk+gb4AXVnagev0K03rN3/BPxGD82Gs1anziqZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmCxUNlU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2219ed4e2d9so893112fac.1;
        Thu, 14 Mar 2024 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710454818; x=1711059618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGh/a0FjaaqhWt72exyFQnoUZiMKDdsCOSQoVbQhpF8=;
        b=bmCxUNlUHmxAJdVXv8L9RsMAn3P8aEugbwGg744ms7oCkugyJKaArcviCPEY0mgnTp
         Ak0IDYlmwDwVWeSFK9vWe4XNedXet3wxtj5eevPDVB2tBjLZXhkTE4gh41GQsQqvGIQZ
         kK0n95Wrn2aj+T9YaB/g8Y+lQhSJrlr9gBsikJ4Wq3KRuPvenUPppyRmhn+sQ6aHQJot
         ZpqOFewAA0BU3ERjcO581NpWHUxucPJKRyIwQIB5Vd6IaL2oqAT3wNXS5Fhr1iDvHrn2
         aTNMSNDLK5TMPQeZyt48XG6RpJhnIC+0Z+69kAOEn2eWti9+msf03kqgtbDalEo1+rhF
         wKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710454818; x=1711059618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGh/a0FjaaqhWt72exyFQnoUZiMKDdsCOSQoVbQhpF8=;
        b=Sssl237UYekLUQrsOSGmHe8LlgwA9DbmejpFFSfaAWIOCbgvQD5tv7q119utkvhTWH
         cvq2Je/XRHWon9DYFE1f0/EduLyUIcEfe07Z0H0IVQpml/5x2HXexlnCYQU0D7AvvHIb
         dRcdQY3cBQ6IT4OuI0BaCA58R4pMz6vKuSmfGrRARb5diBCFq4y92Zkd+l+UxJNNu7oG
         sseBS/grqoo/rGF5Vaz/H1diRMzFlWmYIxKN0r5TPVwkqakKISR5irwLbLnzjblIvvJf
         1DMzXdv+TuW5NBBpioNqAH30R7z0DyzY9XbvfYX/ukQXDFiWZb3fGbfE4m0ouGXI5aAy
         wl9A==
X-Forwarded-Encrypted: i=1; AJvYcCWf9GCD2RQv6hBvlAiaJHmos6HIWfFnv7L6q0yo+eCh6fmGB+5zx94OQBu3Fpn8obDtHsASUxBaof3nbZThtUxoSInG3lRE/WyoK2fg/0wM2h6MJCuv8QdfhlgN6h1VCI6Ky1lGMN1iM3f7InC3tA==
X-Gm-Message-State: AOJu0YyM9UYc1at4FlApM7Dy7lru2M0F3+AV7Mc3cquaAZdXFJu24YOB
	HzaTUUnok5/kM4lwwtMSryHV+7OZ1zyK+2kZtJmUHkVPrbzC/0yK
X-Google-Smtp-Source: AGHT+IExOWj5lAsmVjxruHjura7sadZXu4+15WI0M4zheCidFt5dk5nW42Jn4z4RNizJzdiCGhtmEw==
X-Received: by 2002:a05:6871:289b:b0:221:c8a9:563d with SMTP id bq27-20020a056871289b00b00221c8a9563dmr2614098oac.3.1710454817885;
        Thu, 14 Mar 2024 15:20:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:481:c7c0:d8ee:20e4:a0de:ff0c])
        by smtp.gmail.com with ESMTPSA id py27-20020a056871e41b00b002227a590258sm160181oac.26.2024.03.14.15.20.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Mar 2024 15:20:17 -0700 (PDT)
From: Ethan Adams <j.ethan.adams@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Adams <j.ethan.adams@gmail.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH] perf build: fix out of tree build
Date: Thu, 14 Mar 2024 15:20:12 -0700
Message-ID: <20240314222012.47193-1-j.ethan.adams@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that a previous modification to sysreg-defs, which corrected
emitting the headaer to the specified output directory, exposed missing
subdir, prefix variables. This breaks out of tree builds of perf as the
file is now built into the output directory, but still tries to descend
into output directory as a subdir.

Fixes: a29ee6aea703 ("perf build: Ensure sysreg-defs Makefile respects output dir")
Tested-by: Tycho Andersen <tycho@tycho.pizza>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Ethan Adams <j.ethan.adams@gmail.com>
---
 tools/perf/Makefile.perf | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 058c9aecf608..63a8b4be5075 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -436,18 +436,19 @@ SHELL = $(SHELL_PATH)
 
 arm64_gen_sysreg_dir := $(srctree)/tools/arch/arm64/tools
 ifneq ($(OUTPUT),)
-  arm64_gen_sysreg_outdir := $(OUTPUT)
+  arm64_gen_sysreg_outdir := $(abspath $(OUTPUT))
 else
   arm64_gen_sysreg_outdir := $(CURDIR)
 endif
 
 arm64-sysreg-defs: FORCE
-	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir)
+	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir) \
+		prefix= subdir=
 
 arm64-sysreg-defs-clean:
 	$(call QUIET_CLEAN,arm64-sysreg-defs)
 	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir) \
-		clean > /dev/null
+		prefix= subdir= clean > /dev/null
 
 beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux

base-commit: e365762bb26770b53d2475852453bed76c0d85f9
-- 
2.43.2


