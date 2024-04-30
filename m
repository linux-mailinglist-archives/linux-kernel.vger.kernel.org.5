Return-Path: <linux-kernel+bounces-164807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34BF8B8324
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0C7281F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1DA1C0DF3;
	Tue, 30 Apr 2024 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O6d2wsxA"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B51BF6FD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521004; cv=none; b=BrjvQTh3U5TfDRMu/93I293QwZfa1gzTabnu4fy1x8bK5uRFAT1LX3KtP2MF0FXFRoLxvjWhezshs0iUCjwEjzYHcSMrKOTpNT7aeJ3HLWJsdPvpzoZPq46ubaJdxymyx40u3DKb5gOLi03/1BGFSgQXecMflOhJVXKdHvktRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521004; c=relaxed/simple;
	bh=v82YBshvco4PyEh5G77y/OsBLZjjwmf7YEJkcuP6z4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MYz2/arrHfsRAKaZmkXGEf4BlCDWJpRQ87JQ2Tbe5Y4SV1aEi8O9MLn+6T7Z91FZHE3TLV8EgHMhP7WT1YW7i6Bje8Ys/HAbWxY7uQjTmnyQrXNME8anLQzqdWOPoqgDdJ+VP82iH0wsKdnqAu3r8YtmtoqMj9tTNAqeuFXWpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O6d2wsxA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ee12766586so284995b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714521002; x=1715125802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6GmYXeTFVcSUp54UKC83JdujiOnqI837P/1obadSzo=;
        b=O6d2wsxArtcRXM1VbU5lL70UkpGOwEgTKRUmTvZGWLr91mqTkiuJlDDLWy04eo+wpl
         yRryhVW0HSfI/9rLkiLo7Egh6gwB6Gh7lqIIQq3axr+Nt0zmrSr8GwiqwUEXHyT9ffsK
         MykE0QyVsZ+XSaOUBHYuy0o36iG+tW7Y5FQ5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521002; x=1715125802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6GmYXeTFVcSUp54UKC83JdujiOnqI837P/1obadSzo=;
        b=qIV4C415WVy1IB5v7pYpeP8dldY11jKUrzc7wKxOzdQZRswLhOazKEs4MxrYn955Mg
         tfUrulT6qB7Dk+0nt6lYfagsgyk1uWFFjbnAD9u32rST7KjkJvQN5ftp0CWTGy3+oa0g
         bJ4qlf3/i49Rrz54r4+C12mJYBwMQutmz2E/RhssbwHxxQZnOrSRnvRJotugq6IDrgI/
         K6MSQhANEt/plENy+gR2xgA0jXkRePwHR/vpSJ3kE7aDSQgs7zbmazykW9knp/8ojtpI
         5QY4FTU+AVuEW9uhTOHqOA38VwFVb9lsu8vzoVmN94HRyMlAcyxQYk4r3uqepGBTmUrH
         t+yA==
X-Forwarded-Encrypted: i=1; AJvYcCXNb1SCOJ0RQk27i9MeqTWSql06SphhEMZrRoW/jzLy4ZnvcXzpcwRjIaCEfeIbOjaPFT97bmK4AZlkLBJhx8wJxVVGIaFOjU7G4k+C
X-Gm-Message-State: AOJu0Yw6vL1Y93VG0G/SHl6Jxx3jGpYOWSL0Yldznlr3fI1yE2tZF8nP
	Fh9JsgumsfZa+ORk6L+7Xm4zQHg/Nd4Fk/rBAubMbg+VRi0MJVKnQCoDExESpQ==
X-Google-Smtp-Source: AGHT+IEmfpxUlFG6jobG9C4IRBlS63mOhqBwC7NHJec2cp7b9T7KiIvj1WwFDwJrXezIdjny2LBpLQ==
X-Received: by 2002:aa7:88cf:0:b0:6e7:48e3:7895 with SMTP id k15-20020aa788cf000000b006e748e37895mr6650151pff.2.1714521001834;
        Tue, 30 Apr 2024 16:50:01 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g25-20020a62e319000000b006ed59172d2fsm21676555pfh.87.2024.04.30.16.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:50:01 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm: Disable CFI checking for perms functions
Date: Tue, 30 Apr 2024 16:49:57 -0700
Message-Id: <20240430234953.work.760-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=keescook@chromium.org;
 h=from:subject:message-id; bh=v82YBshvco4PyEh5G77y/OsBLZjjwmf7YEJkcuP6z4I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmMYOkTglh9tMl/QrCP6s553CKMV982fN7MSxdL
 MST3mjqQlCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjGDpAAKCRCJcvTf3G3A
 Jm3fD/0dRn5r9RWBuix2ZT86TX/uV70Bz9Qmi4QT+F7Cblh+0Q+ojjcy924KPfDG4FsEGUz3i0m
 Dzybef/dbiGeJIU2sFp9XLVlVr/xQSPOLV0bk0UgeeOBse6j9hMJ5aQwJ1yjCGDGdLoQ8frZp4l
 TYQYoLogqlxkBh/iKY4AmXCz1QvRxE3Rr/I0fEvk+Tnu7wgLL0BxmINUoTJjH9yV0l7o617scvM
 yhRAwqCg4G2BlLqJRhvFh6MqtNu0dT5iBKGV0OMzR//GN4aK6xQHKGUO8lp8dmbwjwA9BLfhpjb
 a0Was2bvKjd7fK785CezXnDSNUZNwixgx78Y2icicw/ZCmxiKW6lX/+KzWCeJpOk+EfxfrPpwhV
 cMMtL2pgqmBz2Jh0L0Phnh/VW+S/fjPaf8KEHt26T+w7wNIYVPOpURyhJ4sTYcTslcPQbmSW+3Q
 AEocfXffJu7Jtt5rXoWeDgGTtkwtlRsrczjZ8lqGVGasOCK48mw/a8LBEUIkTG5vUQfxARC261S
 m9CL2ElrS23JpSysIua7LPB6eMgHSIPh+gEj2e0C8xzSkfStQ757wPO/713MWwOpiYN75X+d3Pc
 4N6WhkUc38UCypHgTYgTj/Aj0d/kUSJvFFxzzw1pJAllCCeOLkaaufcKdXv8v7h1mFocCcTwsjo
 Mzqe5bx BzeMYBKQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The EXEC_RODATA test plays a lot of tricks to live in the .rodata section,
and once again ran into objtool's (completely reasonable) assumptions
that executable code should live in an executable section. However, this
manifested only under CONFIG_CFI_CLANG=y, as one of the .cfi_sites was
pointing into the .rodata section.

Since we're testing non-CFI execution properties in perms.c (and
rodata.c), we can disable CFI for the involved functions, and remove the
CFI arguments from rodata.c entirely.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308301532.d7acf63e-oliver.sang@intel.com
Fixes: 6342a20efbd8 ("objtool: Add elf_create_section_pair()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 drivers/misc/lkdtm/Makefile | 2 +-
 drivers/misc/lkdtm/perms.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 95ef971b5e1c..b28701138b4b 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -19,7 +19,7 @@ KASAN_SANITIZE_rodata.o			:= n
 KCSAN_SANITIZE_rodata.o			:= n
 KCOV_INSTRUMENT_rodata.o		:= n
 OBJECT_FILES_NON_STANDARD_rodata.o	:= y
-CFLAGS_REMOVE_rodata.o			+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
+CFLAGS_REMOVE_rodata.o			+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS) $(CC_FLAGS_CFI)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index b93404d65650..5b861dbff27e 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -61,7 +61,7 @@ static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
 	return fdesc;
 }
 
-static noinline void execute_location(void *dst, bool write)
+static noinline __nocfi void execute_location(void *dst, bool write)
 {
 	void (*func)(void);
 	func_desc_t fdesc;
-- 
2.34.1


