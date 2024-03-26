Return-Path: <linux-kernel+bounces-119235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA788C5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BB5B258AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3F013C69D;
	Tue, 26 Mar 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Oj9Y1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BC13C680;
	Tue, 26 Mar 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464915; cv=none; b=A8G+A8vVl3CVNdfpuX/mSL6RLryHUR/AZGJN6K+PzYRHAXY2S6oSLw8l3Et6tB9If4ot83Cx7LLwYOzrJ+pu9RlZ4LM1sbmcs39D3oO3aHcos2AUAmQg1CsiEYcMEc0fauDb4ADFQebGRR2MTjvrgDFNWaINW+M38AjipQolU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464915; c=relaxed/simple;
	bh=VJ9rGUlw+RSatuE+PgmaM3OFygViCBRY76yapwirB44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AetTJllu52oUw24wDBjcfJ92A2shcqmMf6T0WcVb8UFeAxKL/fZo8XZ5600AnIU3XJziT+DZJ1OKpjghGPeR8C0a1XQYWGU0n853xb312Ux2nrl2K15v4EUwshCy2SCfe61/ObTFVkEYKv+UVqrgD2a1sM+63ptqxE0l3gyTI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Oj9Y1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C98C433F1;
	Tue, 26 Mar 2024 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464914;
	bh=VJ9rGUlw+RSatuE+PgmaM3OFygViCBRY76yapwirB44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4Oj9Y1bCPd/7/gJyu6AYomZjL3Yh9r3yrLZsUaazLkkmej815mdnhGumZDHgu4vs
	 ic3a9GFnsDiQ3wbIRPi3aHN0lrVpt/0p4PcQpraOwtiDOTwLxEBx5lK5fPBaup1raq
	 jMUEPjqX9ILwuJltK4omR1LYwBLt484Qwo+2pv9/XthyiMnQsRN0V+2YzV2o6nk8D8
	 JPR4WjM3L1xUgvFUnCYfeZSeX42nT9+JaCYv9E55ERC6FNMB0uabdRSXgK14lD/Yd3
	 hQ3pZtk0jjvFw1GmyhX/z9LaeS5lr3m+D5j+C6EcSmXJ4e+uHN1Sp4uhHXmM/klIzJ
	 VjdINIgm7/Gqg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] kbuild: turn on -Wrestrict by default
Date: Tue, 26 Mar 2024 15:53:39 +0100
Message-Id: <20240326145348.3318887-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All known -Wrestrict warnings are addressed now, so don't disable the warning
any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 889c0593a0c3..bff6c686df7c 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -97,7 +97,6 @@ else
 # Suppress them by using -Wno... except for W=1.
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
-- 
2.39.2


