Return-Path: <linux-kernel+bounces-43358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A26841294
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA7A2843AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9C1E53A;
	Mon, 29 Jan 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jUcKDXDR"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD3125CC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553455; cv=none; b=Kbb1KFD6uQDD3Ut6gqlA/1Ot14AgQDE5YCNf8HwzTsccgxOnetSeRCCYKncZhoz1lY0tEmHPRmvgmBkT08+ULzDlzTEJwCB7ahLCVcMgROa5dLxRCrV+5aEYJgLojFJGuMPciypJHdYIWnqQaz7IOQI/hCUX2UwQ4/ouLOV2qQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553455; c=relaxed/simple;
	bh=90HpXRkuAYjZRHJFMyOU2HX/eq/5yDzcx8txY4NB+uA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZhSuk43VmxRAF4PnIKqfzdiv3kklDE3KHVdGEg7NXN81xIw3p6idghs0WUFh/hr30BkurjtQ1sVkDzJTnoWRKA4hCH/xmtvDS7XZ1lQZSHkWE21pfgIOp4h/JMaIM7Ieh4D7N0GJMDuo3s88Fpl8Mx38Kv+XzkHVQK5XlsnLLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jUcKDXDR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d74045c463so15772415ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553452; x=1707158252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fla7JsNhKo492vdE3w3Tg2/OHYB++/QCBkeo0Lo52hM=;
        b=jUcKDXDRvQWvDoFvr09kRTHfQcmQM+VkpXBXmJxptHzfNmgPY6VarzRp6JtZmWuQ7u
         rt1fNUyS1vms+6XdY+m9kcN93jWVU2zfq3mLkIRnoCAbjIFTim+tpxwOdFucrDJ5qzsd
         bqAIScw8lDy1MQrczuoc5lEeNOrmOog/fTgwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553452; x=1707158252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fla7JsNhKo492vdE3w3Tg2/OHYB++/QCBkeo0Lo52hM=;
        b=P7YJCnSr5PqnwjNF8oR+iybsb6AvfNhRe+axqB7hvHI1UydWWOi1oqqSRIyffov9Fd
         WB38Z5R7AGP6zkLsEAafjwLQzW2z08vsao40DkFiOxf6oxR3e9a3T/e3KFphAEFhuzNx
         XubujhnuTEuTeJJCE5HQ3Doi4FOEb6f06xoHI6MLohM13/2o0VW9u6tRhD5oUdGMqft2
         PH0apBRxsRQU5scadg8pCYnKEJ2aZPnwO3DlFeHzzE2y4rO7lrQuzU0iefaLK/8McIL8
         zyMH3V/iiIBtAHWbQpWVYk93A09fY3tzBKqrl9kC4jbcGQ4trOfAt505pq9vOH6jHYU1
         ArEg==
X-Gm-Message-State: AOJu0YweyH3Ny0tLkhNBPWDlZX1Gi3fg07hyXcuoyXOWzrcfwfyD1ZEQ
	8We+wTEVxgApKpPWdrJ1tYTv6oNxOyDDyZ7dSYQwldbyJu0mqAeb5lYy/eRS7w==
X-Google-Smtp-Source: AGHT+IFdSaR5vk/z/in9yVOswwyJHDAI7aDS5JDJDlfLvz6Tr/EaV2A7KUXoI1jRQ/PbokdQDWowhQ==
X-Received: by 2002:a17:902:8349:b0:1d7:4353:aba5 with SMTP id z9-20020a170902834900b001d74353aba5mr2989671pln.58.1706553452033;
        Mon, 29 Jan 2024 10:37:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d8fb2591b0sm634433plb.301.2024.01.29.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:37:31 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iov_iter: Avoid wrap-around instrumentation in copy_compat_iovec_from_user()
Date: Mon, 29 Jan 2024 10:37:29 -0800
Message-Id: <20240129183729.work.991-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=keescook@chromium.org;
 h=from:subject:message-id; bh=90HpXRkuAYjZRHJFMyOU2HX/eq/5yDzcx8txY4NB+uA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt/BpxNgSkSBKSux6ybMpFyLH/AlD9KaCDrzvt
 zEDkh9HEfiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfwaQAKCRCJcvTf3G3A
 JnjjD/sHeWCKm3lg/E+QFrgqXUNgcIvHzer7ewmsf+ihKlwoeIwPQ5RQmISAu0wDhSGkszJbr4S
 LR1R/yqBxSOCQqAdDKM7jN68oBOd9qFo4IMXeFaqJZJu8nR/tuWBrZNlG+VOHaKwyoKrHDeRQw9
 BLswyT3fks3NI+ggmDNeBWT042vySVCGveZ1swPQQZTjgw04BOTfM0gRE2mPv8Bv/KCw5njgZi8
 /f7NZ2XKc3CIrHLcfQXahsWyB0AORAjz3N6KIpi8xHlFdicAVy+rdEFG+TZts5a4BiLopEeFc13
 orkQ1h2moHoetfbDh14khgoG0FfeCWIyNkXrATK6C99djej9ROR6oXDjz1NBu8DMVhI9M1htMHg
 txYpfwgrlqc3UZeDYtUsmlVg8OXlT4GAIhjTMKHBw2GzsUpgWAdTxzcLnwxLqQM4ag6EBWOt51n
 m+uJKNbNlchD4Uq61PnxncNkPT9BVjZ0HaAkUmi7+wzcWxRYIbHl/Qyick3ed/nA3nQzki6a5Iv
 gi7i6i0yuQAcBxj7mbbsFyVDZy34vRaLrA/FW9qxvdhOrlSaZIhexwDQSIXtr+1aygAfBEZlsZA
 fSpJohpZU1/66FVLY1fztGTlNFnCANiBVVm7H0ltwYYysXzsogYKl7jxsp5gYUiWpvQ3esmJ0FJ
 dR/pBKO pa+wo1RA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The loop counter "i" in copy_compat_iovec_from_user() is an int, but
because the nr_segs argument is unsigned long, the signed overflow
sanitizer got worried "i" could wrap around. Instead of making "i" an
unsigned long (which may enlarge the type size), switch both nr_segs
and i to u32. There is no truncation with nr_segs since it is never
larger than UIO_MAXIOV anyway. This keeps sanitizer instrumentation[1]
out of a UACCESS path:

vmlinux.o: warning: objtool: copy_compat_iovec_from_user+0xa9: call to __ubsan_handle_add_overflow() with UACCESS enabled

Link: https://github.com/KSPP/linux/issues/26 [1]
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/iov_iter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..d797a43dca91 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1166,11 +1166,12 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 EXPORT_SYMBOL(dup_iter);
 
 static __noclone int copy_compat_iovec_from_user(struct iovec *iov,
-		const struct iovec __user *uvec, unsigned long nr_segs)
+		const struct iovec __user *uvec, u32 nr_segs)
 {
 	const struct compat_iovec __user *uiov =
 		(const struct compat_iovec __user *)uvec;
-	int ret = -EFAULT, i;
+	int ret = -EFAULT;
+	u32 i;
 
 	if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
 		return -EFAULT;
-- 
2.34.1


