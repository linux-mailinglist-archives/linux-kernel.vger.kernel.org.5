Return-Path: <linux-kernel+bounces-123076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7688901D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65279297CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14012FF65;
	Thu, 28 Mar 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz5xPjEt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B412F598;
	Thu, 28 Mar 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636305; cv=none; b=s38mZiZ3tW7fNQiTOYOW4VhvVMHsdmp3vpt/rKHC/kf4FsLknZwlxE+ScBoZ79PippCoGk1I75qO5lE6gv2Op24oIP/r0PJoTJdDRfS0iajH4IizdlWIGBAADRazxpWB5FzIc4cg7iGa5GeIc0un8UxcTXluZ5dfzbJ7ShbF76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636305; c=relaxed/simple;
	bh=P6U94BE6FHCTdl/v1oN+gzg/0SGP34DXAEXihnAEO3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1nUV+MAyRoF+QRv0JZ13Wa4NNOLxWvsYoe9Ll/vrTYcXX08ySADs9fgJFHdtW9hXTMtQ88jNxha7oscssneUTqSm8fca6/F1UH+CYuq0qlBYZjFTeHdoRGkcmtbZW1BS/7fzaxMwyYT1wMEHITctDlt6h6IJ+ReAc27eodp3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz5xPjEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D19FC433F1;
	Thu, 28 Mar 2024 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636305;
	bh=P6U94BE6FHCTdl/v1oN+gzg/0SGP34DXAEXihnAEO3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dz5xPjEt5VyYuoA/EUZ5hzXQNEmdtPQiJEPQIKiRkUOsl3dJ+VLdy8KmQi6j4VNH7
	 UyWLrfIqWtuEBxwj4eNtV0jHUM7jFg8diimwdcslOz2EbT3MRAfgmaEmwRuaY8ABGk
	 6kIR6c1mrdk4Vk2W9PxHF3EN/ZgpnM+JmelIXpvXSdIifuSMDlohPjCQ3NhDZ4/Gpz
	 1OA3c2Fmvv9eJVsH4ZuCZ7aX1gHKDPgc576+A8RORprUymUXmYkaQ8ZGglVC+gVJPC
	 c5eKJCqL3pXda8JK1lqY94e+adEyykt962vJ5gWK/Vnp5Ei50ZuqULlKICze1BQtCk
	 j62QouhM/AjHA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	llvm@lists.linux.dev
Subject: [PATCH 4/9] kcov: avoid clang out-of-range warning
Date: Thu, 28 Mar 2024 15:30:42 +0100
Message-Id: <20240328143051.1069575-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The area_size is never larger than the maximum on 64-bit architectutes:

kernel/kcov.c:634:29: error: result of comparison of constant 1152921504606846975 with expression of type '__u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                if (remote_arg->area_size > LONG_MAX / sizeof(unsigned long))
                    ~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler can correctly optimize the check away and the code appears
correct to me, so just add a cast to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kcov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f9ac2e9e460f..c3124f6d5536 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -627,7 +627,8 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		mode = kcov_get_mode(remote_arg->trace_mode);
 		if (mode < 0)
 			return mode;
-		if (remote_arg->area_size > LONG_MAX / sizeof(unsigned long))
+		if ((unsigned long)remote_arg->area_size >
+		    LONG_MAX / sizeof(unsigned long))
 			return -EINVAL;
 		kcov->mode = mode;
 		t->kcov = kcov;
-- 
2.39.2


