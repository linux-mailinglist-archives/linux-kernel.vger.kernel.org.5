Return-Path: <linux-kernel+bounces-145053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222C8A4ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA7E1F23BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E366BFB3;
	Mon, 15 Apr 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvVnKv4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B8679F3;
	Mon, 15 Apr 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183646; cv=none; b=IsT6SNhZdGEaCbjx+rH1pVzKiUPwIgzgy3Igo/LYXjLFq9f6cJKUELaBGvTQvl1sgV/B+o65kyLX5CNG5W7cX1KWbSbYguBQa8lNtcpvqXidothEoFih6xtofLvKbFj0vtVdC6Dkp3vTnxZ0PtKTsQSektlkclGyIjMFjZvea5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183646; c=relaxed/simple;
	bh=IW1/5zKnRf0vw8lfNR7D2qM5w54xu3yNJIPDeRFonXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KPDvdPyIpvRuZY+D/rU6LujgfHBYtZ2I5aQmQp/lDC/czmnyqVqUl4Fe7+b/EnIzkkn7UZ0fQMXIUEKSlsfC9EPVOsQ68o8MouqWZ7VZ6yXjSrX4RWlBYPptehE/VrERXXHz6IYyo9YTL0qty4wCpgeIa9/ToG+usWxYC+A6Pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvVnKv4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B97C2BD11;
	Mon, 15 Apr 2024 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183645;
	bh=IW1/5zKnRf0vw8lfNR7D2qM5w54xu3yNJIPDeRFonXI=;
	h=From:To:Cc:Subject:Date:From;
	b=JvVnKv4AsPCeRMiEg6D4oYpvvDe2nSTFgYOiHNrlrifk56E7NMCpMsX4UZmoLtQDL
	 j/QBUMPyJLDS32sKkOTrl/BaPpq2HQvqkeBiddUjEyKw2lhz86S/N4QvJfiEFwxRTd
	 ljrITaHn2FIm8du8d6QJKQCwvlbYFTWBRJJOKgsve0shOShydllGXvNmiZU3cUaZCY
	 PFWjcIwP166IZvxjlRvVyy2i0oJoN1zQJvbmX/OfAr+egklRCgBXknOuZxbBdzl5G9
	 rZZr7EP3uZ/ktq8b5/AuOAVy/GjXvaAMJFDJMxjY5yWnKVoPgqZlnFH2jdSCvrfoll
	 Cc0ANhX7thanw==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] [v3] kbuild: enable more warnings by default
Date: Mon, 15 Apr 2024 14:20:31 +0200
Message-Id: <20240415122037.1983124-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Hi Andrew,

All the warning fixes I sent for these warnings have been merged into
mainline or linux-next, so let's turn them on by default.

Since some of the bugfixes are still in flight in maintainer trees,
I have rebased this on top of the mm/mm-nonmm-unstable branch
for the purpose of merging these during the second half of the
6.10 merge window.

I did thorough testing of the changes on x86, arm64 and arm, as
well as allmodconfig testing across all architectures and compilers.
It is still likely that this will catch more warnings that show
up in configurations I did not test, or in newly merged code,
and I plan to send fixes for those as well.

I also sent patches to enable -Wunused-const-variable and
-Wtautological-constant-out-of-range-compare, but those still
need additional bugfixes to get merged first.

Arnd Bergmann (6):
  [v3] kbuild: turn on -Wextra by default
  [v3] kbuild: remove redundant extra warning flags
  [v3] kbuild: turn on -Wrestrict by default
  [v3] kbuild: enable -Wformat-truncation on clang
  [v3] kbuild: enable -Wcast-function-type-strict unconditionally
  [v3] kbuild: enable -Wstringop-truncation globally

 scripts/Makefile.extrawarn | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.39.2

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

