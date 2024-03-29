Return-Path: <linux-kernel+bounces-124591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E2891A50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3012868FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668613DDD8;
	Fri, 29 Mar 2024 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0Rmn3lh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603E13CFAE;
	Fri, 29 Mar 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715480; cv=none; b=OJG4xk/lK6S670VjJJby0URxDWJYhgNyOdOD/tZ+HgH/q30UbZPR6ZUMemmniP+8M63es4O0k/VzxzaGHTitf3QUyWujowxMMpSSJWgq18tsUE8t3AKR11WGadkOpmO6I6G3PT8H9i+0xWxLdJo1wPZP1Lu0dgybo3wB+qc2W/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715480; c=relaxed/simple;
	bh=2XkywHGTNla9wNUnN56Y6gr1IeKydyjwYr37lT38rYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLO965hDQz4udQuBrvTn7ZKl1oBP/vvPyf6VUWCq8oLH/tjhYIyGHo7S0vBaLEdEP8e6xOiJyHZxQhv7Yi9lAimEV5OYVqN65mZHNeu1skoYcD5ZsPHDhNryrmBq1Sz0XlHCuwp2nv8dVT3jCVs6GhFxItBu6C6dLfUwGvXfvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0Rmn3lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D7DC433F1;
	Fri, 29 Mar 2024 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715479;
	bh=2XkywHGTNla9wNUnN56Y6gr1IeKydyjwYr37lT38rYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0Rmn3lhIwez5d+VgogTtaf6bXlSXctrsj3vhKUDAU7BIPWaoNgtxradqtN8vUwzu
	 xq8lXg0iMXttZ2e6nIfkGwkO28A3lVFYy7zSt/SUYK6rg/75A+HJSIiZZkxneZWSZo
	 f+k4pEFxkeePYNDArDXz1n9YzMvEIdQEYrfBS4Y6ieshR+aBeSAe+uJgPGBgZ8MEfG
	 z697BBz0MGONBm33r/JPDEkaClXKrShE446hHVV3a1Yw2iyWGkt9MxrvKnukF1bac6
	 mu7XN08xyFPzsE5uI8Jpe6pPGQkUZg7ZsL4tOL+9J2rQda4cl11VaSCXae+zAFRCzk
	 d85IG5NRRUwwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 40/52] overflow: Allow non-type arg to type_max() and type_min()
Date: Fri, 29 Mar 2024 08:29:10 -0400
Message-ID: <20240329122956.3083859-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit bd1ebf2467f9c5d157bec7b025e83f8ffdae1318 ]

A common use of type_max() is to find the max for the type of a
variable. Using the pattern type_max(typeof(var)) is needlessly
verbose. Instead, since typeof(type) == type we can just explicitly
call typeof() on the argument to type_max() and type_min(). Add
wrappers for readability.

We can do some replacements right away:

$ git grep '\btype_\(min\|max\)(typeof' | wc -l
11

Link: https://lore.kernel.org/r/20240301062221.work.840-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/overflow.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f9b60313eaea2..e04f679476473 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -31,8 +31,10 @@
  * credit to Christian Biere.
  */
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
-#define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
-#define type_min(T) ((T)((T)-type_max(T)-(T)1))
+#define __type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
+#define type_max(t)	__type_max(typeof(t))
+#define __type_min(T) ((T)((T)-type_max(T)-(T)1))
+#define type_min(t)	__type_min(typeof(t))
 
 /*
  * Avoids triggering -Wtype-limits compilation warning,
@@ -130,10 +132,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 
 #define __overflows_type_constexpr(x, T) (			\
 	is_unsigned_type(typeof(x)) ?				\
-		(x) > type_max(typeof(T)) :			\
+		(x) > type_max(T) :				\
 	is_unsigned_type(typeof(T)) ?				\
-		(x) < 0 || (x) > type_max(typeof(T)) :		\
-	(x) < type_min(typeof(T)) || (x) > type_max(typeof(T)))
+		(x) < 0 || (x) > type_max(T) :			\
+	(x) < type_min(T) || (x) > type_max(T))
 
 #define __overflows_type(x, T)		({	\
 	typeof(T) v = 0;			\
-- 
2.43.0


