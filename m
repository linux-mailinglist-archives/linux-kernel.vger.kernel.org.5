Return-Path: <linux-kernel+bounces-98238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7B6877728
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E5E281497
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18F2C84F;
	Sun, 10 Mar 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7twodkL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066B3224;
	Sun, 10 Mar 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710078321; cv=none; b=kC48M9rAAIJPVfTEJqCxNXKXoPuX4eLKWGcfaowe6lK6owwY023chaFu2Qd9dXM5x8KfyV+AxukYAk9mlAz49WHfseyVBGl4OSSTTh8azFkGaJ1zByQPbElHUbD07WnT5LsxFk/xCuQYiLKZh+jZt6bb5e2mRc4T/StthXlz2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710078321; c=relaxed/simple;
	bh=mdd74oX/bEef+Zfj3qpeWNkE9WnOB2d2RSfAJiG6Bo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=olHL7r/cUjhyIttQpcoK04ce5UGPNjxY7fumU2y5YbxFF6QgyY0LvE6q1g9UgpoqF3i3/hMY0kVjA68rZuQ16EHKAoi9gtX9OmvTqBPpGvOfF5Pa4jpTfYu6b3KsSSDV+0F18c4VtKp4iTUIXElVFQylp2TTR9aatKsTmCDFvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7twodkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC91C433F1;
	Sun, 10 Mar 2024 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710078321;
	bh=mdd74oX/bEef+Zfj3qpeWNkE9WnOB2d2RSfAJiG6Bo4=;
	h=From:To:Cc:Subject:Date:From;
	b=M7twodkLu98ejWkpJYhxZyauyrK6QMWbFMt/xCJlJrpqJgl++tua3iJjhtXUUgoqN
	 jmfxIiJhabvLnZLqhbOpfc8D8Sv0STwUllLqy4K2yotYEqf8bYNgpn8zB0afQlplzs
	 dzMwa52MiaEUdEf72rtLyDCUx3/3ShKLKLflIyXSPPOfQh5cLwTfLQcNBR6BxeUZw5
	 Hp1ug4FTUz/mqGBmePi7M+lUWz+5LAwW5U2Xzg5tuZRbAO8NqYA/R6cs85Hl2s13VO
	 neMPq0yAwZ0vROoMLPacKeKDmRg53IIuD3HWaUlg2WDLcs0ZqybIJ9BbYWrXTuwnIV
	 X6PQPnYfRdtWw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: check prompt for choice while parsing
Date: Sun, 10 Mar 2024 22:45:15 +0900
Message-Id: <20240310134515.447020-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can be checked on-the-fly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/menu.c   | 3 ---
 scripts/kconfig/parser.y | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 840ce642ec43..8498481e6afe 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -561,9 +561,6 @@ void menu_finalize(struct menu *parent)
 		if (sym->type == S_UNKNOWN)
 			menu_warn(parent, "config symbol defined without type");
 
-		if (sym_is_choice(sym) && !parent->prompt)
-			menu_warn(parent, "choice must have a prompt");
-
 		/* Check properties connected to this symbol */
 		sym_check_prop(sym);
 		sym->flags |= SYMBOL_WARNED;
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 22f616334585..b45bfaf0a02b 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -233,6 +233,12 @@ choice: T_CHOICE T_EOL
 
 choice_entry: choice choice_option_list
 {
+	if (!current_entry->prompt) {
+		fprintf(stderr, "%s:%d: error: choice must have a prompt\n",
+			current_entry->filename, current_entry->lineno);
+		yynerrs++;
+	}
+
 	$$ = menu_add_menu();
 };
 
-- 
2.40.1


