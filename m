Return-Path: <linux-kernel+bounces-98244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837C87774E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B5B1C21328
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3702E62E;
	Sun, 10 Mar 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFMJZqo8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610CF219E9;
	Sun, 10 Mar 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080185; cv=none; b=oASdNh9XV7e2r2l3yH6A4iYrUi4S+5dbRO6rHKv5o3jRIDqqV7a8+8MKpznAfrDn3dCye3I31qXEut4cqRMD+DeSmQs5NUZPY9JdAdUS5+VnpDw1HtOWobXImuJh32nXlfT/wfQOEW//zgNumK31RRia7x9JdejZeQI/ySZNcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080185; c=relaxed/simple;
	bh=vyUsoJZwUXiUt3No7I9+cObd7fy28lhRp41UtwCxqJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mhUsgSrRztzOVgpRdhlkpfOLEowNCRQOwG4YRh9yA9sSndtHaLwC0mS9y2dJklHU669hVY3g8iMh/Mb+p3xrMIqKz35Rl/ExGTkKPWayLrELdHBMCo03847gzyXJF3XohWdNMlStHizqkDmcIYXu+S+Zn39W9UzagPJEhaRWrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFMJZqo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2384BC433C7;
	Sun, 10 Mar 2024 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710080185;
	bh=vyUsoJZwUXiUt3No7I9+cObd7fy28lhRp41UtwCxqJY=;
	h=From:To:Cc:Subject:Date:From;
	b=HFMJZqo8NovSBYUW6KVuJ+kabC2HJ4ZThfGIVrzziubNHLkwweLsH6dp4l/XO39/p
	 Ft1QNkhJI4iyEeDHX3l8QWYKDj/NptDCPeXlC4TfGenUElikfYy/wfc5m/+mbZsJU/
	 c7pSzvb+KVi5guKRd79sO7LrwRC04NOSQAwOpiLYt08Qlz7fcgWMMXWPXGvrrnzJls
	 buMgDHPWvOqVYpltUEf8zCmG2joJKTQL5FyoUKrLWrk3XWU0TLif1xTiQYKYKWGh1I
	 YAXJZ7vfOQeqjVkaObK+enw6wTLZbhg9wCBXopQaI9RB/zCQ4EeMp0eyDbqhv3S+7n
	 sp77D5P+/NwiA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] kconfig: remove unneeded menu_is_visible() call in conf_write_defconfig()
Date: Sun, 10 Mar 2024 23:16:17 +0900
Message-Id: <20240310141619.606415-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the condition 'sym == NULL' is met, the code will reach the
'next_menu' label regardless of the return value from menu_is_visible().

menu_is_visible() calculates some symbol values as a side-effect, for
instance by calling expr_calc_value(menu->visibility), but all the
symbol values will be calculated eventually.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index c5b6487d68ac..0e35c4819cf1 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -799,10 +799,7 @@ int conf_write_defconfig(const char *filename)
 	while (menu != NULL)
 	{
 		sym = menu->sym;
-		if (sym == NULL) {
-			if (!menu_is_visible(menu))
-				goto next_menu;
-		} else if (!sym_is_choice(sym)) {
+		if (sym && !sym_is_choice(sym)) {
 			sym_calc_value(sym);
 			if (!(sym->flags & SYMBOL_WRITE))
 				goto next_menu;
-- 
2.40.1


