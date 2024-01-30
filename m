Return-Path: <linux-kernel+bounces-45482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A9D843149
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C6B288BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955527994C;
	Tue, 30 Jan 2024 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SfZjkkMG"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AA7EEFD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657504; cv=none; b=QOBIfASgD2PXHKL1eOv+0cw8XuX257FCRLvL0l8cMHYG0BBV1F+KJ3TJuZz7EmewsYhPGxav6g9A3B9SlnjOJNf5GNY/bP34SFYZ64XkLkyzInylkAXXfmTHbqj7PtHzitLQEe2s5n4oHk3PKcEM2xYzxpCg/0b5nOBd3lb5vug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657504; c=relaxed/simple;
	bh=tjgkJWJHJ1m0/YqTb/xcrpYoub6gZSwUTnxfXo0y8mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YRPGbdX01zdnm65ntY1lSptCw9d3LgFvqfmrHlEB1vwCsxkfSMkVA4TebYCj0XjWesM2NRUu6mqopsrc/P9KVTPe349PafmSbG4FiAuwZ/MGFqNEP0eEOQV6JOM9nCT/R20JePm0X/y4SxY5ZxVk5gDoNIDKnYYnJlxjKtPUOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SfZjkkMG; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e13cfc0b2fso756684a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706657502; x=1707262302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PiOXMkAilXSlADbFG8aS86y0I95Of2JWiczoVplHqlw=;
        b=SfZjkkMG9tP/l3XQiSN5vSGU8PfTGIUC2iFrsS1/9HT444LCCYAZdj1yhc9KdiRyk8
         hv7LIw2hwe2ZcTbNZKxa28/lCtf5LeZUGUDBM8MfclY85w3dIXb8SwN9uUrrdHd5wVzQ
         yqvwCLU/4JdtD3cUcZYVbqUfJgBFVmk0w2KSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657502; x=1707262302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiOXMkAilXSlADbFG8aS86y0I95Of2JWiczoVplHqlw=;
        b=d5U2a6G7rvIZbQpn68PkiMDJUO7/770JsdNxHIvwlFYsqAbNYc/B5HWMP4FgVReI2U
         sF3cm5BZwOal7W1Xz0+zUQFz1YblbEiDlERq88RdUj0+nf9RZ/FKbfuv6XHi36UrPxmu
         tJgjqWinI/tZ0jsWvbQBc6Vpv56dXkaworICvMIC+dB2E5qGKVzaR2giafvkXsl84rj8
         9FJGMAVqVvVTdBklBFq1rgrr8Vt6K6LVuX+jyuNJxgnlsaXga0x9iw1ko1aiwyBkbXag
         MBEBIvdwRoQieVVCojCgnNBTC0/cwfVmappCrup0x4Osp/xDbO+vhY9zydehFLDSFfG5
         CWow==
X-Gm-Message-State: AOJu0Yy8HjTKPQuUANjcoUG/4K9F5jIDBaUpzmZC9XsSrIfj5jFd7U9D
	A8SwJLavvaPKqN8jGujek9k/fMCNiV44F5amfiIMEHYzyc9m1Coq00FtQkn2Qw==
X-Google-Smtp-Source: AGHT+IGGp57sIuxTKTDCF6nyyO91maNOKuzeOvSumXmlWoy42j5hwEgcNPzAvuL4+x+S4cRxfQM9KQ==
X-Received: by 2002:a05:6358:ee4b:b0:176:503b:937c with SMTP id ik11-20020a056358ee4b00b00176503b937cmr11351112rwb.21.1706657502506;
        Tue, 30 Jan 2024 15:31:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e17-20020a656491000000b005d67862799asm4122554pgv.44.2024.01.30.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:31:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Fangrui Song <maskray@google.com>,
	loongarch@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Qing Zhang <zhangqing@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] LoongArch: vDSO: Disable UBSAN instrumentation
Date: Tue, 30 Jan 2024 15:31:40 -0800
Message-Id: <20240130233140.work.887-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tjgkJWJHJ1m0/YqTb/xcrpYoub6gZSwUTnxfXo0y8mM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluYbcRNRE8eUz6tYFQAladg8P+XLUdL7e+q6Ay
 HNwzQiW6pGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbmG3AAKCRCJcvTf3G3A
 JqrGD/9KqwEPh/D8NLTeQy/ro72FzTNk6eJ4UoWbJyVz54451QNtyI8Oc+aW7x5mwjheN6IuiBH
 NQWBKFcgrqimUJYO3XbnPOZ9OHF6ipf8Fx5/YGLbDOW/LvRGhQlfhhM/BrARH1xALcZOIemiMq+
 NuU7tiZ/mCDZ/F642nIKE0HNndm4/hc5n2O6qywD9fGxto65WqauLwprzk8bha2cGSgza57ugq0
 skX/qRMKo3j1tE/w2RqvkSBY3+GQpzZagNc3svK67YbiehX9F/OmhGV4MwHgq14GA+cdGeq7RqE
 yDvPvSSAzv53zimYkjmzf1J1SJu0JGr1Z1oN1hp+9nCi0ERF7nII2Iuqrwg80fVRF1XcH1NbC4e
 nNwMv8Y+SxYvohvqCUv7PPh7jG9px5qJckUoUTf4WfuvKS7YU2vOMXpjjfENAh8x25CZV8hgM7w
 9GsO/XTLRiPR1AHlUG8WmqX9X8WYkLGiJrQDYNfJfzURwyRzrE6DYCVqHFnF7biS08v15rdi/kK
 uGO36RfIGaYGeB9X43uygcIWgMx8nAEyT7HAs65yjqtAQPXCwSN7dsKqUZ8MbVbqmfpULI8mwwN
 cigKOOdVwkeauhMdkb25S1LXaQl0LOqZcCgvjDThmUbYmdv9piaEe9qYh7seS8iF/mJGyg/+e2Q
 1zZB3C8 wXNNI0+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The vDSO executes in userspace, so the kernel's UBSAN should not
instrument it. Solves these kind of build errors:

  loongarch64-linux-ld: arch/loongarch/vdso/vgettimeofday.o: in function `vdso_shift_ns':
  lib/vdso/gettimeofday.c:23:(.text+0x3f8): undefined reference to `__ubsan_handle_shift_out_of_bounds'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310530.lZHCj1Zl-lkp@intel.com/
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Fangrui Song <maskray@google.com>
Cc: loongarch@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/loongarch/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index c74c9921304f..f597cd08a96b 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -2,6 +2,7 @@
 # Objects to go into the VDSO.
 
 KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 # Include the generic Makefile to check the built vdso.
-- 
2.34.1


