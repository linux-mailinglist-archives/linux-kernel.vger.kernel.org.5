Return-Path: <linux-kernel+bounces-40131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE683DAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1591F249C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244341B81E;
	Fri, 26 Jan 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaZc+ud7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B91B959;
	Fri, 26 Jan 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275816; cv=none; b=io6ZMDVE6vMclXxJ47h7HOfjk1HRv8T2um9cV1u4tv/QZ5E5lux/PErfBDgqXd4HtZMLChyKfoFuQJ2efYXTY2WjtVce8uJlgTainZBF3LNH54ahgHxv0jy0yjEPaJTvl4lTPgWZC5aVVtVsIINxLTRmLmczcqwTXfk+IlXZywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275816; c=relaxed/simple;
	bh=Nue8KygHkKeII+jOSXsS8scQGO5eZ5Pxo/5p3G7mjZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4oU59s1I/Pe07wZ2774UA0iCLwt9DOAZZz4II/ApfrY/lqVpmL9pVvUKWqYlzqOrEFn8hNvdKM0U3idWpud0cox9murJB85k7kRetN9W8ooJVorBJzialZYkTnnMMMpZl+gTDNt3L/gRnLnqZ0akeYfrVY3MbRE5nWgc5KMVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaZc+ud7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2630C43142;
	Fri, 26 Jan 2024 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706275815;
	bh=Nue8KygHkKeII+jOSXsS8scQGO5eZ5Pxo/5p3G7mjZc=;
	h=From:To:Cc:Subject:Date:From;
	b=IaZc+ud7tFfYGt9iESCGtTbgHjNvW0STOVJzOw2Wfcmdo3Viaipm6Yz8VCwWKOUuN
	 HNWBP9OHnlweqoct2SEK8VDPm6U3xs8Wpj2/LFHrldxPAL61/GTMpWuWf4b0t4zEQL
	 Yx2iqVT+tzZ3fFfMsLlkshffQJCbqKfgRVORQMZpLTucSWcckgJ5ej14uJNT3Ci7+2
	 2QS1DheAIeVXRbJGUsCfXpuRAW+NVN5hs6g5switdlvDt3JTeHR7YzkMj6p6WWkQcU
	 jlulZYAgNrH1fpO0FwpYY+hwdh4ebeGuWYZN4i04zmKly/plLvl9eOMUqI6KQkVA/k
	 hZF6AUXg0sggQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoann Congal <yoann.congal@smile.fr>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: initialize sym->curr.tri to no for all symbol types again
Date: Fri, 26 Jan 2024 22:30:10 +0900
Message-Id: <20240126133010.78999-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C programming, a non-zero value is interpreted as true, and a zero
value as false.

Kconfig has never worked like that; only 'bool' and 'tristate' symbols
are properly handled in conditionals. The other types ('int', 'hex',
'string') are always interpreted as false if used in boolean contexts.

Until commit 4e244c10eab3 ("kconfig: remove unneeded symbol_empty
variable") accidentally changed the behavior, the default of
CONFIG_LOG_CPU_MAX_BUF_SHIFT was unconditionally 12, because the 'int'
symbol 'BASE_SMALL' was evaluated as false, hence 'if !BASE_SMALL' was
always true.

You can confirm it as follows:

  $ git checkout 4e244c10eab3^

  $ make -s ARCH=x86_64 defconfig
  $ grep -e LOG_CPU_MAX_BUF_SHIFT -e BASE_SMALL -e BASE_FULL .config
  CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
  CONFIG_BASE_FULL=y
  CONFIG_BASE_SMALL=0

  $ make -s ARCH=arm keystone_defconfig
  $ grep -e LOG_CPU_MAX_BUF_SHIFT -e BASE_SMALL -e BASE_FULL .config
  CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
  # CONFIG_BASE_FULL is not set
  CONFIG_BASE_SMALL=1

CONFIG_LOG_CPU_MAX_BUF_SHIFT defaults to 12 irrespective of the value
of CONFIG_BASE_SMALL.

Since commit 4e244c10eab3, this is an undefined behavior because
sym_calc_value() stopped setting the sym->curr.tri field for 'int',
'hex', and 'string' symbols.

Commit 23b2899f7f19 ("printk: allow increasing the ring buffer depending
on the number of CPUs") presumably intended the following:

  config LOG_CPU_MAX_BUF_SHIFT
          int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
            [snip]
          default 12 if BASE_SMALL == 0
          default 0

But, the correct fixes would potentially impact multiple defconfigs,
hence they should be reviewed in each dedicated subsystem.

Restore the original behavior for now.

Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/symbol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index f615e2c1e85d..1290c6d2f8c2 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -346,6 +346,8 @@ void sym_calc_value(struct symbol *sym)
 
 	oldval = sym->curr;
 
+	newval.tri = no;
+
 	switch (sym->type) {
 	case S_INT:
 		newval.val = "0";
@@ -358,7 +360,7 @@ void sym_calc_value(struct symbol *sym)
 		break;
 	case S_BOOLEAN:
 	case S_TRISTATE:
-		newval = symbol_no.curr;
+		newval.val = "n";
 		break;
 	default:
 		sym->curr.val = sym->name;
-- 
2.40.1


