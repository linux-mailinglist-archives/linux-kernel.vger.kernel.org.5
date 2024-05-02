Return-Path: <linux-kernel+bounces-166435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004C8B9AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011E91F237EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA779DC7;
	Thu,  2 May 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR0k/KVJ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7A152788
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652497; cv=none; b=Od/4ss6u/MlXpUuXwYAhgbQ74omP+tgetVnPHUZoDPYtIXfPwAp4HiXhl3I+cWMYk6I5YVezhSkbkjsTJGu1H59lAF6trR6Z5LLQwY4OC0jWHpoFtzYfc784tl1TbfnrbXgofFutpHMzzYNAHzY4xuFzDgos83HL5qlwkrw0KKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652497; c=relaxed/simple;
	bh=Bia1DWsELNBuu5T705S8/7Z5sPbSoa+JIPKeKG1d360=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+knipiN7wCwxqAIcpwnC9zsoiwx2fpkV2wafuK/VBHwLsOSuVy1268URzWJl1QODY16Xm/QdoBGdpadn3kmPddB4R4EReLD4pYiAxZfh9rmaIRB9OlNGt/qsY7itbhgkiCuM796z7CWpz4QzxPlxIgnOD/BNiM0td6KzfQ6/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR0k/KVJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e0a2870bceso54410591fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714652494; x=1715257294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/kgNxqzXCsv3u98tcBIcgQ8RrZvP4N8zse1QQob0I0=;
        b=gR0k/KVJSeF6xGAL+yEiL4nUnT3ssvU2U0Wcd3ZOV0LCQWd1Ykx+ezzhGgVEp/xbCY
         VRSfuaFvEoOm5roqULvYxE9Q4ife7tXwfQvaSDeeuuCZU1SE3XKMkNw5KQcTY2XCd+e5
         ZfrHBYhw7hsYE2e6jLoF04k+RbbgAQGckQqLl2RknJ27292fOtg+uYDa+l2YnxzBJPkq
         YlfErlxlATv/P0kUPl8KWGm/mnKy8xmV1LSoXA90ONagA1tvAUEiX103zwrxMgxp3pP+
         8+N7QV9T1g1uI2MUksmqLB/+tmBsB0CnhxYG8nXURSP8MYCAgTxfIUq2SLF7LAWvaKn1
         DA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714652494; x=1715257294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/kgNxqzXCsv3u98tcBIcgQ8RrZvP4N8zse1QQob0I0=;
        b=pF0uYJyZshI0AdctSUZ5VfBEzoQO4CJr4lJHRoaoDdY03MwkaEyzNsxGPBOqzJkAdy
         Kwa75OUD4jFGK0zhw8//xYkY/9NyqF8S8OZs5fgxd7KWo0mCHNbcLnAITilcGiL55Amn
         OG9ZxZOIkf/YtjZkF9GA+NPdFFbdSVvH9swz2zqnZk4aVgfW2Jm1AFp4owGU0gYuxRMo
         YOJ6FvSUWklwRnTyvpPKGwjqxvcjUWpJEmt6ZCyyDKposiW6KXt6gjDIwW0Twy9DLWDF
         cM2zly4nIJmSZ5C81cxQY2fi9+AZy6e3+4L8eIxvFa3khfgUnQEMFHp81VDf8nWH0ica
         3VZg==
X-Gm-Message-State: AOJu0YyiYGAgpa5siaIhpm7jUiWnS4hsKNMqHMrsU2s6XH5XpwKbQxEz
	VTf0nRPbw/9dHUZ2I/a2se0d9KLl/T5qTfzepnPkDYqh23itWGnCl3a39w==
X-Google-Smtp-Source: AGHT+IGyJBUQgPZon1LWFNFnTUf5lj6gJbhePesSjN0xz9L5QPpU1CnOQag7wbFlVdmy1/8D/70epA==
X-Received: by 2002:a2e:94c4:0:b0:2de:c6b5:2888 with SMTP id r4-20020a2e94c4000000b002dec6b52888mr3445204ljh.3.1714652494062;
        Thu, 02 May 2024 05:21:34 -0700 (PDT)
Received: from octofox.metropolis (77-46-212-180.dynamic.isp.telekom.rs. [77.46.212.180])
        by smtp.gmail.com with ESMTPSA id d13-20020adff84d000000b003436a3cae6dsm1121731wrq.98.2024.05.02.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 05:21:33 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] xtensa fixes for v6.9
Date: Thu,  2 May 2024 05:21:30 -0700
Message-Id: <20240502122130.2863322-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20240502

for you to fetch changes up to b7cf2a1d9881823133acc48427815a48b35b49f4:

  xtensa: remove redundant flush_dcache_page and ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros (2024-04-28 21:18:18 -0700)

----------------------------------------------------------------
Xtensa fixes for v6.9:

- fix unused variable warning caused by empty flush_dcache_page()
  definition
- fix stack unwinding on windowed noMMU XIP configurations
- fix Coccinelle warning 'opportunity for min()' in xtensa ISS platform
  code

----------------------------------------------------------------
Barry Song (1):
      xtensa: remove redundant flush_dcache_page and ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros

Max Filippov (1):
      xtensa: fix MAKE_PC_FROM_RA second argument

Thorsten Blum (1):
      tty: xtensa/iss: Use min() to fix Coccinelle warning

 arch/xtensa/include/asm/cacheflush.h | 24 ++++++++----------------
 arch/xtensa/include/asm/processor.h  |  8 ++++----
 arch/xtensa/include/asm/ptrace.h     |  2 +-
 arch/xtensa/kernel/process.c         |  5 +++--
 arch/xtensa/kernel/stacktrace.c      |  3 ++-
 arch/xtensa/platforms/iss/console.c  |  6 ++----
 6 files changed, 20 insertions(+), 28 deletions(-)

-- 
Thanks.
-- Max

