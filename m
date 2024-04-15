Return-Path: <linux-kernel+bounces-145057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BBF8A4EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C3B22B22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C196F06A;
	Mon, 15 Apr 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHaHYBEZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D96EB65;
	Mon, 15 Apr 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183652; cv=none; b=ZpqXawLhpNBnP1y6yA0669NQpL2J/WXE34Em0fEqzQHndfIaunP9pHikDoD6FsiZXTszy6dne6BMxINizy4rI7GiyBZerkGpPLppTX7OcF/C10eBzAJ7spimA4N8Qc6ags6QGJyebJU4bWn8ky25v+sEBI1KO5lJI3DAD/KqjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183652; c=relaxed/simple;
	bh=mTgeIYCmciNqI0jeKacsXjlw+DjiDCIlmChxzf0Df80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhRRCIO2lpCkG1VWMQxBkmGg8SeQD+S9EFQgL+Kw7qDqe3ApOoORhEs+Vhj1iRiOSKq/1UeKZNzchnZ9hlWaZg0DBVyYUkxbY+fh6z/yJf2jeWVKlBbuEXv4uCGIRGdaviOVeLDbYcWYSjfB/SHYWpQdMLzSi3v6gw7yMhml30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHaHYBEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF78FC4AF08;
	Mon, 15 Apr 2024 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183652;
	bh=mTgeIYCmciNqI0jeKacsXjlw+DjiDCIlmChxzf0Df80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHaHYBEZ7SwFPB2Y0v2tECQAWnBsG4DlLTyyZQnL0MJNEHRZsBSTk9W0dV5QkLC6U
	 cak7Eq3NKoczjdsX0hYxKg3iegMBZOjhFp6/jcpCe+PxlgHqaRAf4k70LS09vPPjm9
	 okaPj6Wsar6jC0iNTh3GVWeQCnKKvZMjSEh+J+444WkbUhwHPE4HaEBrVSsGwE+hKH
	 n7Q6KbyFhjuKgFLXscf2NPtabfl0RuonGzelISpB4ZQgL99/yy/4vogkC4mSg9zH57
	 ux+0ImSsTfOZH48BJR+CRCyKKaa3rVIbwafFkDvAl5k4qtRv7jVLnahYD0NpEVnoSR
	 EGu5WEwGDkMrA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] [v3] kbuild: turn on -Wrestrict by default
Date: Mon, 15 Apr 2024 14:20:34 +0200
Message-Id: <20240415122037.1983124-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415122037.1983124-1-arnd@kernel.org>
References: <20240415122037.1983124-1-arnd@kernel.org>
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
index 8b3f5b62b837..95466a04d51b 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -98,7 +98,6 @@ else
 # Suppress them by using -Wno... except for W=1.
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
-- 
2.39.2


