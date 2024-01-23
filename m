Return-Path: <linux-kernel+bounces-34477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6321837DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DFEB308A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB3B157E71;
	Tue, 23 Jan 2024 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nNO7D+O/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E71157031
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969731; cv=none; b=Du9jSccwQdm5vEDXHZNIEwpsEPJa1H6FvQ7qWIn7Gzyi2BlB7yOw3TzcSWDsXBM7SQVOwlBXskpaA93DnOzsVIDz5845+oTOt+keGNla1cG1sVR8k1cOo0jQUi8/7CWhDhvdiV+5zDrNT61tzG3BY8t9VA8sdabtFLw0b4oy5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969731; c=relaxed/simple;
	bh=wh7+GBhkNO1sVmVaz1rCepK3Q+pc7moaQJ0Rt+76i3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n6zFSK0V5dApMpGHjLFEQDXEphFKGkxXU76xnPW63oLiAjKUdMTMsg9SsLXHuoQ3IoDWLgeZK8ft4GKY/VvrIeOVkkeAFbTfeG7zsVBrptKIyL9UJ/VNUTDdEbapObseQKiBjw7xxhSOxZtyCmG1rEzAmPWmFf8ER8npUEvYwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nNO7D+O/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dbe3fc1421so785229b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969729; x=1706574529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF/i2yiDIRENT0mwh/2n9kzjWsYDnfFtPr14I/rXEpM=;
        b=nNO7D+O/BFrDRrFSaF8132Z3RKBIkV40MmsmE23WuSWbwl+jIUzyIJEhgsSbIHe59G
         SWQl2vWk7lQkgM9yGiweSA7otlcJOyommcAtj5ZgbAMAkLkBlvCrf3F68lA78nzH1A9n
         m227tXr6wn9YTRIOQGmKOHeTeNx+TeXsqTWy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969729; x=1706574529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PF/i2yiDIRENT0mwh/2n9kzjWsYDnfFtPr14I/rXEpM=;
        b=ceL4vZRWTY1xLpXNXpZizZedw8sQUTKXzFI+p+ZCtqxf3i2WbdQn21UNI152nu04Cb
         TbHPEKiQzrcP/TR5lLKOGMqNqZpt3cUKxTcMaAUsdCc4/Lr/2TVchDcfswsixWnAiQA7
         tdVM3DBGZxKuyOWOErz4I7C9azmHRIjPgPQR7C08PDAFY2WgOh1fws7gl/ZreJHtjkbz
         ZmRvYZOH+eq7S/0q2J+gBBprwziTQJ2cZ7frP7KtIwbwu+gDqliA5z16scJLD8vDxw3A
         +d5L1xNxL1KJ4YMnFFEemqeO18iOWhUFKL3g2WAXAbIO4RLFphoQvooQ4e94Hiy5XYoi
         Kd+w==
X-Gm-Message-State: AOJu0YwAtl9OYMe+V4w0olAdOH4bfAA3MMAj0KvlHBUjfyhExSEsDxQC
	6Sdd7DpvN73zM2cN7er4fwoCrQ+CGNJOM71S0LV/tNXqQQEhZWRhk2abl2EzH5TSB5dbIe35XmM
	=
X-Google-Smtp-Source: AGHT+IF0AD2yK5eOlHI73Qf0l24Vr7AY8Z8TEV46LGlNK1HMzni5jVd0N361f+kRLwkxWtRWm/rdOg==
X-Received: by 2002:a05:6a00:244e:b0:6d9:b385:26f9 with SMTP id d14-20020a056a00244e00b006d9b38526f9mr3480265pfj.2.1705969729016;
        Mon, 22 Jan 2024 16:28:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s25-20020a639e19000000b005d3646ae6e4sm66443pgd.24.2024.01.22.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/82] iov_iter: Avoid wrap-around instrumentation in copy_compat_iovec_from_user
Date: Mon, 22 Jan 2024 16:26:43 -0800
Message-Id: <20240123002814.1396804-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=keescook@chromium.org;
 h=from:subject; bh=wh7+GBhkNO1sVmVaz1rCepK3Q+pc7moaQJ0Rt+76i3M=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEV0qAxoV3HSGdN5QKjvrPLDYsC3mVorule
 CjY0wDbzwWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 JqycD/9F1q9lCA/qtcVMnJ/DbvpEtV4bCUN2UDhmCqtFaVSmfFz5GkBooadVTFFRdc0AU81Eaa2
 fDh1T4zdDWUy3eY0HD9GbxBCvyRrzPljX/d2rE9odidCZus4n+8I2N+F/h/FEwwsKZ9EBOTDkcj
 cK32kXDBzm53ZIYIm/4H1LjN8V+y9LaKNXRzKSUWIvHqDOelWrBYY1mSfmsL6TdQL8rfw9a52Yc
 e06Sgl0/CiFLFyVzHwrfnuX8t6gEJWfWIIE6G2UJpuIObJUtAixAUIofBbBQLdfeRRpgq4Blat7
 C/qFo7mUuIeEj/S7hDCAdrqjkeSxDbf4ddevVFlhCMXQfg1YX4Nw+T0tfWPj1yx51nWSvUFScDG
 3Zvgmhrqi0Vdmbz5LtLlq9v1ZhZ3PwPtr+0uY9fBXdYJ2nDEdlXURt1qv5oOvg3IIsg/S8797+V
 bxAXszSNVbDYeOgEeQDgw+ecqzfwF+ntVpS6I4XQ1JOagLyuGTvf+fGNW+ATif0Z1useQk5i9rT
 YMpY4vcRMVQtV4BU79pBMA4gHMs6CQWUXNizjjetcvAtSgGtmJ0x+Td2X5k/z7zha6ny/SyzxSr
 GT+w0Hht9fp/RugdC94ZvrlMjDNgwjN4Od9qWIogtUvKIz55RmiSjjgIshFdIRladAbPAPsBJCM Arv9af5S8HAeKFA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The loop counter "i" in copy_compat_iovec_from_user() is an int, but
because the nr_segs argument is unsigned long, the signed overflow
sanitizer got worried "i" could wrap around. Instead of making "i" an
unsigned long (which may enlarge the type size), switch both nr_segs
and i to u32. There is no truncation with nr_segs since its is never
larger than UIO_MAXIOV anyway. This keeps sanitizer instrumentation[1]
out of a UACCESS path:

vmlinux.o: warning: objtool: copy_compat_iovec_from_user+0xa9: call to __ubsan_handle_add_overflow() with UACCESS enabled

Link: https://github.com/KSPP/linux/issues/26 [1]
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
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


