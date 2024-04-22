Return-Path: <linux-kernel+bounces-154241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0658AD9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F3028509F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAA713E418;
	Mon, 22 Apr 2024 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVGkr2CQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01DC158DD0;
	Mon, 22 Apr 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830092; cv=none; b=K0psDyYrNEtx9O20RYsS5bKENGmTMEw/fvLMMT9tUhBiCVNAEeMHezMAJNANpM3gB9rwI8TZNhY2cI5Wl2/OsQKAkHKe9KHry0OP7MesQjqkn/bJME3Rxm/p6a5EvQk6tJTmJuZhk0y/6w14FNj16WZX3b3R8KEby99Nfha2jKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830092; c=relaxed/simple;
	bh=kvJOM7xjD44q/yAl8Oz0aNffaTe2DNveM77rzWrMYgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdO0mLvC0H3iYHTii8bF9NAF+ZsJbkz0qSmw/Sjfk5ggkm7o3QpeCJaE+wwkdUD6SlaL6U9J1WPTVceU97CJ5Vlv8iAEkhCTRQVvEBuY7pmxCgkbFg8llMxeapTneq1vmpl8anqpuTZaW8GsdK/QhMDl0JLA4Xblpe0xFnm1dlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVGkr2CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB58BC113CC;
	Mon, 22 Apr 2024 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830091;
	bh=kvJOM7xjD44q/yAl8Oz0aNffaTe2DNveM77rzWrMYgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVGkr2CQMky/ycWoXRX3jnlmtzTIWoRcXvBDSg1nIZeMJ6QgQUjNi+KVYs2agHjgX
	 IOLgrWKY3ieuzrxMgvGorH/UA+H3D3h7tTjskQnGpDP0nLsd1gAjG6pGkLQp+PZDjz
	 Lo0LtGq+fyt3EMlV4fLIGQ3F87eWa28Xg5ZAXnbpqZG7+QW2tDEMMIFaIdZP4ofMj8
	 nswZFFlNOP+jOPlM3AxjpahRpYLKMOYeVsheb5FjYJmIrGUINRO5um1T/LSLq5Nf3l
	 xchhwUoR6zWMbjN/ETtwGzECzRe0GCrsLwuuZiqnbQHYPQ9D3jDfMztUkD1G+zj49k
	 xTFO6bAgivECg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	0x7f454c46@gmail.com,
	davem@davemloft.net,
	noureddine@arista.com,
	dsahern@kernel.org,
	fruggeri@arista.com
Subject: [PATCH AUTOSEL 6.8 24/43] net: add copy_safe_from_sockptr() helper
Date: Mon, 22 Apr 2024 19:14:10 -0400
Message-ID: <20240422231521.1592991-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6309863b31dd80317cd7d6824820b44e254e2a9c ]

copy_from_sockptr() helper is unsafe, unless callers
did the prior check against user provided optlen.

Too many callers get this wrong, lets add a helper to
fix them and avoid future copy/paste bugs.

Instead of :

   if (optlen < sizeof(opt)) {
       err = -EINVAL;
       break;
   }
   if (copy_from_sockptr(&opt, optval, sizeof(opt)) {
       err = -EFAULT;
       break;
   }

Use :

   err = copy_safe_from_sockptr(&opt, sizeof(opt),
                                optval, optlen);
   if (err)
       break;

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240408082845.3957374-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sockptr.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 307961b41541a..317200cd3a603 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -50,11 +50,36 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
 	return 0;
 }
 
+/* Deprecated.
+ * This is unsafe, unless caller checked user provided optlen.
+ * Prefer copy_safe_from_sockptr() instead.
+ */
 static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
 {
 	return copy_from_sockptr_offset(dst, src, 0, size);
 }
 
+/**
+ * copy_safe_from_sockptr: copy a struct from sockptr
+ * @dst:   Destination address, in kernel space. This buffer must be @ksize
+ *         bytes long.
+ * @ksize: Size of @dst struct.
+ * @optval: Source address. (in user or kernel space)
+ * @optlen: Size of @optval data.
+ *
+ * Returns:
+ *  * -EINVAL: @optlen < @ksize
+ *  * -EFAULT: access to userspace failed.
+ *  * 0 : @ksize bytes were copied
+ */
+static inline int copy_safe_from_sockptr(void *dst, size_t ksize,
+					 sockptr_t optval, unsigned int optlen)
+{
+	if (optlen < ksize)
+		return -EINVAL;
+	return copy_from_sockptr(dst, optval, ksize);
+}
+
 static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
 		sockptr_t src, size_t usize)
 {
-- 
2.43.0


