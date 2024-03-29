Return-Path: <linux-kernel+bounces-124784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62062891C77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D671F222FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DA187E8E;
	Fri, 29 Mar 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL2ppa1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0D187E76;
	Fri, 29 Mar 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716136; cv=none; b=ex5vmLhJXujY+TxWUwaGeUnoDyJj0CyCiS94epfCBQhFgrXtBgixQuDXFFp1iYp0J0z8kIf+bc/YsOkn5yt/45twTsrSy/A06EvLIPVt19vC3sB4rcAeJ71IoS/sf9MncWoLKkyy47cJfod36ErIBCrSADu+BsRlEd55c9QRcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716136; c=relaxed/simple;
	bh=yFrxUrCxr4nCVz5WlYcMp85OB4SzOnEQNJZ80EpWwjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7Ji0/xx+T5Z3eiEHa5J2TqYAe1SSBcQtQqKZVRuKcXVPE2B1CPOgxNwVHZNeAV0r0jFosixKH/CX5XpaHRaLPNT49eOQsmVbsb3QxGr/nCMVBlR66tnHvniT8t263Y9jNftOW7CGHQBHiOuSaOufb6Wu+9Zxbj7I4+y1UNBGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL2ppa1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89165C433C7;
	Fri, 29 Mar 2024 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716136;
	bh=yFrxUrCxr4nCVz5WlYcMp85OB4SzOnEQNJZ80EpWwjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NL2ppa1MANHS7QW6IJ8ZhaStVnXIKMEe+0M5QYCpi1ZN0vcAmnPIk4kiQSHVzFsAi
	 iYmZFRjQmnfQRvoQqhnoMo+Al4prpcJ1yberzl5uXELKT1lhbMl3lUeYvrsL2m8Gak
	 2ByO9H13u/Q7/hfyjs9wb4Kep5ZplAO/5x8RpuI6MUw4dP7lli8+4Lgw3E2cwiEobo
	 umZZ/BkyXN+w+I7sDYKSN/58GAwjwXJ/Zv7w03QrROtwq9Ji5hn0jqXq2tLpK98W9w
	 u4HhSHAuNCAOyBt3BXKpGlsKPJ4SQtVZb8axRgaiO4oXjuv7w3UfpLFB6eVcMdBl7K
	 uw1+kyK4Jna6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 74/98] overflow: Allow non-type arg to type_max() and type_min()
Date: Fri, 29 Mar 2024 08:37:45 -0400
Message-ID: <20240329123919.3087149-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
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


