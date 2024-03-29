Return-Path: <linux-kernel+bounces-124863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3509891D37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203171C26FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9A1C8FD6;
	Fri, 29 Mar 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsABKrKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA31C8FC8;
	Fri, 29 Mar 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716311; cv=none; b=o3Vg003OikW3ExxqcNSA2zGqvENUvigZYghqU/OAinmqNCJY7UVO8PqXgJe01OvXkOCav61RbOhPSorRajfUZqjX7UXhpAfN6dx43jylM1YFRhLTrxxdygaNYVdLUX2dG3Mys0xYO4IFrYMPcYSnX2e2UmkZkwINQOj2hCeUgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716311; c=relaxed/simple;
	bh=2XkywHGTNla9wNUnN56Y6gr1IeKydyjwYr37lT38rYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoJgBMtpt0J4y/khxrMIJarGgV9wpRCQY56VAR8f5Uole0TPuR8MWDWTeRCBJ/cBPnp2TfWmyezeTXSZxxxoyQtm3+KoaC0+w9TEhXFbDkkxr8pgq6J0YMMqgpW6fiPn2cp9Bh7Zpla8NydtUar9zoRI4f3amWUqMVTKz+tJZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsABKrKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A293C43390;
	Fri, 29 Mar 2024 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716310;
	bh=2XkywHGTNla9wNUnN56Y6gr1IeKydyjwYr37lT38rYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsABKrKwIL69/48G7dR+/H8tXygP/livDxOAUkBYS1ELEP3KkFxi67QozZyEYmyu7
	 RJ85gigVq7ag/UF2o0qzzVHr73lCLx9PF8/tLpltm0eGTiw3jqwfgX3Zeeeng9rCm/
	 n23+CdahUueiZzGY7RzMaaXgp5qT0o81XMBSmezgRnxwbBE6Bae1PmzX90kj5AY3rr
	 Ea9PQ0DL5sUqjsxvljON15tiM8G7hIzSl/VNvl3PSeGcEJaEA9uhmdWm9FM5l8A1SW
	 51gTI2OhA0+GCFVK5ywhFdLX/fdRXhXE1I61wXYkyDcIoDKGFa6g/rXmODI1T7Nand
	 VNIPACSCbTpEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 54/75] overflow: Allow non-type arg to type_max() and type_min()
Date: Fri, 29 Mar 2024 08:42:35 -0400
Message-ID: <20240329124330.3089520-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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


