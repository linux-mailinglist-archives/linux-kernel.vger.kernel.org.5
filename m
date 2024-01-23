Return-Path: <linux-kernel+bounces-34483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C0837CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D341C26C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2117159590;
	Tue, 23 Jan 2024 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gbjQENA/"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FA159569
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969744; cv=none; b=QelEBXC3+6Z4FvGncuAF/KOAWHMMQlnpuIlq3VPh9GhY0mGZfhDMmxrltTH0xRldDW15/b3v0WIRViQn6J1JPAapntdprlAxZBf0GV4PgDMLO7jOYKJUEmtnSbcmsjSE23YGj97HlVLTBF2KuZry65guoOypYu/R6YFF6Lg6CYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969744; c=relaxed/simple;
	bh=wdQCpDFkq2XNuS6vp7VN0jrvsBX8D7+SnBrIJMJ3N+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hs5KR8/H9NiODKumsA/v6CWZ1BNrOT4YbIiyJyoBmEj/TiDyyAMt4OG4BA4YtVxdn+orjK4eiZFjq6hiS9uzGKWgfndxJS/TtbbFBWepRqTR0xozoBh7Fq+6ITO5vgepePPTzOmcDYhUVR2YyF6LXYm3Semv1zg8zjMdnh/tugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gbjQENA/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d72f71f222so9661345ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969742; x=1706574542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVxLR6f7iEMo7TAEPfaWn9vwjcL8lBg/KdBkMw33Rxo=;
        b=gbjQENA/8g5meX6QjWQL1VbfGuh0/U5pkhiX9v6A0uBKibyG7MkLhMXLsJXz89Jj3+
         8VPauqfi6YbErj6VO/sc8GwmGZj0Xi7nP9/QxKC9ZGJZ6JOY6TqQeAjJE+GE7zV2G9b9
         5UAv7JlyxKoFunZIQ77vQG0GtOxRKfYNjLFJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969742; x=1706574542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVxLR6f7iEMo7TAEPfaWn9vwjcL8lBg/KdBkMw33Rxo=;
        b=T2BwbbJqlwT/trD1NLy3gM4R1FLsPqVY9ZSrzbgQwvsjmSWuCgHInZO5ti6xWIbReo
         MH67m7VN3I6TeXLZNVC+SIKYjKtZ1AmXuDKS9rV9hRB20EKCMR7bULAN1cbp9iRhvxgx
         rzdPtHmiZsKavMbckjpDXvzcjH12u4p5Wr4LDgdhURBQsEjEbRvRrI9x9kVS+8v4Vy2b
         MqeIaTT9oqWKmikkzsNIDFNmAoNbTscqdVcyVyL7dlSQXw+pDUsiQ/2rTFob5Zvamh/2
         Xg4k45/VuDA353rClIv8QzU8HU5dkcd6vWrrHEILBOVSVxaWOs0QP6eYkh7X6UKiR8Ht
         Yc1g==
X-Gm-Message-State: AOJu0YztxcudnGbZ0z3q3hIx05vip/wNMt3D9BXjoHJH4tqZOVKrYOq+
	crMUQRW/Boizo88zKiV1cm0dGEZyUIALs1rPuAlYuZuIxj8h+464RHd9d5r1BFncz14gYN9rOl0
	=
X-Google-Smtp-Source: AGHT+IEn/houl8Yw8FvYMNWC3B8MV8/fbDL4xsjwCWUCzj3v1wRhUvEgEWe5QKZnRXFlO7vX6H4DSA==
X-Received: by 2002:a17:902:f54e:b0:1d7:1e0c:f994 with SMTP id h14-20020a170902f54e00b001d71e0cf994mr3335214plf.45.1705969742100;
        Mon, 22 Jan 2024 16:29:02 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mp11-20020a170902fd0b00b001d75ea44323sm1403673plb.21.2024.01.22.16.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:52 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 52/82] f2fs: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:27 -0800
Message-Id: <20240123002814.1396804-52-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415; i=keescook@chromium.org;
 h=from:subject; bh=wdQCpDFkq2XNuS6vp7VN0jrvsBX8D7+SnBrIJMJ3N+Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJyxtpoS8kJtZtyqL6hKLCRushNAde9dDbx
 HeAgwOgglaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JqIBEAChZM9m9U2HlElYvUdy9F0F0UgsceQedYYNLYx0L54ESBSelfc98YP9tUZ1jkRspBdT1nC
 kijkb49E/qqF4YrjskPndLLLfvxjkzUksvg4xoaV5zyEKUTWNlk+oQ/70241cKc8IGAhpPwQl3j
 IP8LyEb8hrqYd1Gwv05+R/n7XJtH322XuuaSm+VUm++KmFC8YDRf3YRRQE65fPEC2kqrYnLank5
 +wDA7XxfBHYZ5VFHofOMUuKsBwQfmE9o8FtseQm0z4Bo1FQS3oSxQvE673WVKQhVmEwmbOR9ivC
 R5t6LF2QsZrbGDhITRyjy42nBPee5QFqI09uFA+RqI1xhZr+sXi7cXkvN9jzsy4GbJhquMIvoaG
 3y4wcyaqW0M1xPODI0RUOvqlK8vgezTN7sWCM6fcp3eFDI10YvIpiRlsN806ofvtT9OS4OdKak+
 ANIM9E3Ui3D5E/mxLwKbgarX5fgYxrdlwUSwgNaF75JxNETK7fusGPTtlmfq8XYfUeQu9bRajgR
 +XeU5K2axNZCgiE9Kza8K/h1REqqfniSyTWXH5qJS4mqpQk9QgxZgIowNKo/wodiPFN53Bo4WJB
 U5AlyxuOYHJ5rJtrcYirdcrjdv8FILsJ1P8owWZ3SVw0FjZ+qasWTxpHjLsDEI64mmy7fuXj1wv UMcFg1tT7pui2bw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/f2fs/file.c   | 2 +-
 fs/f2fs/verity.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b58ab1157b7e..6360efb98f64 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2819,7 +2819,7 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	ret = -EINVAL;
-	if (pos_in + len > src->i_size || pos_in + len < pos_in)
+	if (pos_in + len > src->i_size || add_would_overflow(pos_in, len))
 		goto out_unlock;
 	if (len == 0)
 		olen = len = src->i_size - pos_in;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 4fc95f353a7a..b641cb8d75e8 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -237,7 +237,7 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 	pos = le64_to_cpu(dloc.pos);
 
 	/* Get the descriptor */
-	if (pos + size < pos || pos + size > inode->i_sb->s_maxbytes ||
+	if (add_would_overflow(pos, size) || pos + size > inode->i_sb->s_maxbytes ||
 	    pos < f2fs_verity_metadata_pos(inode) || size > INT_MAX) {
 		f2fs_warn(F2FS_I_SB(inode), "invalid verity xattr");
 		f2fs_handle_error(F2FS_I_SB(inode),
-- 
2.34.1


