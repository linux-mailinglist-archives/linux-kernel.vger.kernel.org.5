Return-Path: <linux-kernel+bounces-119231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34088C5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF341F63FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78F13C914;
	Tue, 26 Mar 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB9p/fQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5413C838;
	Tue, 26 Mar 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464813; cv=none; b=KeHlEmhx1GM6sIwUB4ephoTIpaecFDEMf3t+Os/uSMrT3SryULbv9/18aoe7wayA8c11renlkej2xzdIYUqZqeZYhua5IMAfgrez1jLTr9o0f7xgdEx1rofvYK9uvEbYT8PHV91Sv5KjxSIdDV+43PtgydJuq+5iHs5mU2XTC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464813; c=relaxed/simple;
	bh=AX24N6tngsyhhImQGkFDPYqJJEewhb6t+11+7XBmXQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDShPjoslL1Be6Zpp/AKE2JXlJr4KPHNzGIyBcF0MOAb+xgmS5kHzhGf9zUZTLSEFyw/Q6YXhLcPvVmn5yMCWqFjBSRSdAI91WTQxnYo1n1FZJKstsSIxtNoc7DEk7KRLpsTY/Uj+4BBi2Jvh6hTetZd2E8O5CbGk7EUm+OGBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB9p/fQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29B7C433F1;
	Tue, 26 Mar 2024 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464813;
	bh=AX24N6tngsyhhImQGkFDPYqJJEewhb6t+11+7XBmXQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JB9p/fQVoKswYRxtH6BN5aHtw2Iy7ztz67Xr1DuNLWdDsWXwqzfFHnxqI5h+EbuqX
	 fx+1ETTUqXh3l51tKZHbnWdvOYIPegOJHfrb5tS5MkZcia3xCcGR1eVZdPoXRX7XrI
	 D74Zuuo2o/z74JaXnqkkMVy5JWfpwa2yjlXWijdqOxNCFnRr8vsQXoYY8/AAUihDKX
	 zgGDCBI7tzDjZkPGJnVGlLe9r39Xxyx3WgOroJtVHWU7mpfILTQ/eWZA7c0AvukaAb
	 1DdNSXLgFrU1oPLXfUIJWuGj3Tl4kMM1+SDM1OlxFWZn2Rzzxt55yCz8f3pZkec6+N
	 mzweStTnO9Dbg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] kbuild: enable -Wcast-function-type-strict unconditionally
Date: Tue, 26 Mar 2024 15:51:34 +0100
Message-Id: <20240326145140.3257163-8-arnd@kernel.org>
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

All known function cast warnings are now addressed, so the warning can
be enabled globally to catch new ones more quickly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 17b00d85f6aa..889c0593a0c3 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -122,7 +122,6 @@ endif
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
-KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
 KBUILD_CFLAGS += -Wno-enum-compare-conditional
 KBUILD_CFLAGS += -Wno-enum-enum-conversion
 endif
-- 
2.39.2


