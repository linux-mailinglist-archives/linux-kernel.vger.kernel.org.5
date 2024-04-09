Return-Path: <linux-kernel+bounces-137051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D11E89DBA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1AA1C225D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DD1350D6;
	Tue,  9 Apr 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI+tE9nq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DD12FF72;
	Tue,  9 Apr 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671293; cv=none; b=qAfGlXafydH+9QFUKmeB6V/VJ2E9YJnOxjbuEqeyM6LZtgJcM7OhpDeaq+1Fpr4C67+mbefUA3KSkobN0Xx4flVl1ypGwkUTrykKismsrLCo9IFMLeGj4G7GHGHftGdx8Z1skysr2OZZ/SXJDLGhb3cLggibIYnN/TCYmPIejR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671293; c=relaxed/simple;
	bh=KBapuCoet5kfjziaVWML59WbPosua5uheV6EN7HL7cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/G94JFVwccTPueFjzUZp8PSydKD5IGEKTnAC1OIDaIqqYIPW5JQXWt5EXFX/i+SI9fixpv9VMuoKMZnXnmfIyFafDfwvBjEpTR8A/j/NndDQ53fMM87KLB/h8vpsasSqEDYVpGGBlWfaqmUA5nKKKvEN0tGfSx8JDydRXvbNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI+tE9nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5330C43390;
	Tue,  9 Apr 2024 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671293;
	bh=KBapuCoet5kfjziaVWML59WbPosua5uheV6EN7HL7cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CI+tE9nqa8mKqJOIqe+CfUonGLG1fsbzMR/Wd7a5I1Vi2laBO5bxr2CoMJV9PXJmW
	 l3B5LTh7o9wALv4UUWeYM/t6wiBxQSugqqL1qMaxru2tX3syz5zQ1dsosUQsa29l8T
	 p7IjRvBsv+ejS31ytc4jFbGqhglSJWpDfeCARtT2DuJQwR0l7vlr6MAVUGv1hn/+RL
	 LYOEYFvgKimhfwTM29K1/o3+OR9G+feE3zRGY+tAuvl6i500jl0QwnR+iS9P/aFQXM
	 zLfT5yP+z3QnvGF/tWNTahJ46H894mg0QFW7RX22FGXq0UqZrFoQ1e9EbWlVu3+fcI
	 vfZrusQ178Ykg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Richard Russon" <ldm@flatcap.org>,
	Jens Axboe <axboe@kernel.dk>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Lin Ming <ming.m.lin@intel.com>,
	Alexey Starikovskiy <astarikovskiy@suse.de>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/5] [v2] kbuild: enable -Wstringop-truncation globally
Date: Tue,  9 Apr 2024 16:00:58 +0200
Message-Id: <20240409140059.3806717-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409140059.3806717-1-arnd@kernel.org>
References: <20240409140059.3806717-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The remaining warnings of this type have been addressed, so it can
now be enabled by default, rather than only for W=1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: no changes
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 57edc80661fd..f4d69092698b 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -107,7 +107,6 @@ else
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow-non-kprintf)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation-non-kprintf)
 endif
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 KBUILD_CFLAGS += -Wno-override-init # alias for -Wno-initializer-overrides in clang
 
-- 
2.39.2


