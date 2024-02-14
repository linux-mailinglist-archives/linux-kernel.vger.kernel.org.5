Return-Path: <linux-kernel+bounces-65795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF898551F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F050F1F22673
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02C712836B;
	Wed, 14 Feb 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWzMdHtv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5248604AB;
	Wed, 14 Feb 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934788; cv=none; b=G9CKREgIrLv8JmP9RHoi3mP+8elr8BWMNEarE4dyP4Oddhk+d8yQSaykHPWdBqbg0bMjgE0FdY62Z5q3ZQ31VTab796xK2nOTA+hPBkN55473mmFQ9XHC9W8KqE6GNMbWNLm4gz9nQBtBgQ8MA5toFPCXg1Z/j1zez+MCJ0yRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934788; c=relaxed/simple;
	bh=ireiJEzPK4O+z7JRHkRgdN7IMbrEYY6WQWzsHi+UMqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TUEC1KNBNOpDqjGoEUHl+jXLdB9/rWUsRPGamblTy/Dagqw9VTek3TurczLS/blFJeV2ORhHpMiKP3QnM7nWLpKBaGpW+UJtD1XQsfR//0mssONsFwS9Mtp4rUsNdi28bnsXb1rWBx9U/GMStBvaJAwjz0k5q/loIdW46jU/PaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWzMdHtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE92C433F1;
	Wed, 14 Feb 2024 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934787;
	bh=ireiJEzPK4O+z7JRHkRgdN7IMbrEYY6WQWzsHi+UMqE=;
	h=From:To:Cc:Subject:Date:From;
	b=WWzMdHtvzjCGafRLG46fOvXOyI/md3LQwpvLSwT9ZTOMprFd7wbFK/1ws6j7vMk1j
	 G/79vryqwTXIrfo8HTSQ0fYMUkeaMpQYMvQs9GhkHepL0+moIxZIMgiByClWOj6jl3
	 kgVyuBjwnNkK5GWGnkESsowW9fRALGyilz/6q5wtdwdmFXmTPc0EcGM5BA3EMKpKkp
	 46j9TFjUnsz7Fr+4WgDZfjYFvFaJ5fJy04g/MIH4JCtyIkk5tr1dsty4sW2BsOK0MK
	 ZHIwnINIc1ZIogQqYi4nKHW3p3qMstSHooC6cPqwPL+vOB1TaHoMsfMVEgdhZw6CUM
	 Yp5oYM96KVYCg==
From: Arnd Bergmann <arnd@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms: ignore ARMv4 thunks along with others
Date: Wed, 14 Feb 2024 19:19:25 +0100
Message-Id: <20240214181942.3562473-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

lld is now able to build ARMv4 and ARMv4T kernels, which means it can generate
thunks for those that can interfere with kallsyms table generation since
they do not get ignore like the corresponding ARMv5+ ones are:

Inconsistent kallsyms data
Try "make KALLSYMS_EXTRA_PASS=1" as a workaround

Add the missing symbols to the list of ignored symbol prefixes.

Fixes: 5eb6e280432d ("ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer")
Fixes: efe6e3068067 ("kallsyms: fix nonconverging kallsyms table with lld")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/mksysmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 9ba1c9da0a40..c809bf592790 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -52,6 +52,8 @@ ${NM} -n ${1} | sed >${2} -e "
 / __AArch64ADRPThunk_/d
 
 # arm lld
+/ __ARMv4PILongThunk_/d
+/ __ARMv4PILongBXThunk_/d
 / __ARMV5PILongThunk_/d
 / __ARMV7PILongThunk_/d
 / __ThumbV7PILongThunk_/d
-- 
2.39.2


