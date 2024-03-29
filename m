Return-Path: <linux-kernel+bounces-124536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C08891980
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBC4286A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69185148822;
	Fri, 29 Mar 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgG9Vmkp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BA1487F5;
	Fri, 29 Mar 2024 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715327; cv=none; b=ohkzlIOC4ffyd7ww53h093EA+niuZD23wTcJuDCkTGDHDVZKXu0Y8Yuj1KhzNCMva7MpdV8DGv551bji1EO7Rs1KfCcsa38HANGvKSZY0HfKsAASnA88vWjZ9bpNxmywg1cnkd0R76MGhkHaLDrlfnanqjT99JvCmhJTFwoUVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715327; c=relaxed/simple;
	bh=yFrxUrCxr4nCVz5WlYcMp85OB4SzOnEQNJZ80EpWwjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuFMMs1Eglx6kvz3m/ssHQinKmgPHwve8f0fLGKuNXpqT7hT5Hg8XXURSMjuANwMOm3rI5oAkQgZdqznDfFS+lb/iuwwQBCdMxPnQgNFxiANWbdgR6IrLB2PLO938LArgD57QiI/nlWlHjQDiaTvCsnfQYBvXC8SjbkRCM7Tecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgG9Vmkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932FAC43390;
	Fri, 29 Mar 2024 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715327;
	bh=yFrxUrCxr4nCVz5WlYcMp85OB4SzOnEQNJZ80EpWwjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgG9VmkpdXawxfd6wnJsRYs66CesBb/zqDD5pL2XsJyThJL5ArJ6fh0cYb28iMvMo
	 GCo1y54FZ0ggnNhbUerIREwjgHYvL3VI6JgFlHHehteiiPp80rJSy3lVPeYzLslU6h
	 hoVhyOFz7t1fNA6ds1Lkp5A+vBGVwAr/lWVCOQNRbXeS3mmbpL6bAM5OEfXHDqWr+N
	 CON87rGjtSrqG4YFoYcBduZnVCvN6vx9DL0HKSL5xWHcmnXxPc0/tc58jPCjaylorm
	 88sLfOMD3F09wzdB66pUW6Tvj5Gvx5DMRlf3u94mq1LnRbwg+00i8rgZfEiYi6Y3I7
	 D/8+uOdvzKA2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 55/68] overflow: Allow non-type arg to type_max() and type_min()
Date: Fri, 29 Mar 2024 08:25:51 -0400
Message-ID: <20240329122652.3082296-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 7b5cf4a5cd191..51af56522915e 100644
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


