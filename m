Return-Path: <linux-kernel+bounces-152478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAFC8ABF0D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935DDB20A83
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11DD1119A;
	Sun, 21 Apr 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZjfMy0G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD86AD7;
	Sun, 21 Apr 2024 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713697990; cv=none; b=MoGzItVwvzBumnT9iG5pRGq+sNd3jnSdfj7rMThqWucA5VMMEhLhfGK7ge9E3hkc2AIC/tXmDR/MghunUP7IsdaA96M2IW3nIiXstUi6ZeqLr9BmI6oPNxHjklb/+MwG9rh+yL7dUFhsiRnGQ9lSqKJyD9bH6w6KdSNSVQBDlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713697990; c=relaxed/simple;
	bh=T8R3zSpNO6LtvSfdpaSEY3m6wVK/7bVFcSFRC8miPRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VbFS//gIywGBGHAxoaupaZdv/uSaC6VvKr/GcIBu9dkk0W7yShkhoDlVO5G/bussvsC1Lm06ez1sqg6ScAM/GytkAMCcSThmGBR1Wu3C4Ymp+V4dg37SSWOnlQJItWh5PgDSr09/fy06Chq9Cv/zaFipYGHjJ0ME/jBBj+WWRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZjfMy0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E8AC113CE;
	Sun, 21 Apr 2024 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713697989;
	bh=T8R3zSpNO6LtvSfdpaSEY3m6wVK/7bVFcSFRC8miPRY=;
	h=From:To:Cc:Subject:Date:From;
	b=hZjfMy0GSSO+b6ajLntEc9d0sWwU3mLGx+AUaQtrbs4Pon83+0//CAxHGvsHmSL8c
	 XMxo/9nA0w0niBUHtxt7VYKG9P9Yt8EsGdtV4zIOxo1am0evJVVJKH+ka6LUd/nSmN
	 Rvi4rGcfz8yMqsXsAJbZeVvv4dZyUZIJDmLIBZAWlrwBOEn266Ak5z5vz/stBIkQ6p
	 5i2NCtTn1ro0vfFKnVaZ7fTRP6RJKl9T2cDqi6fZ3DTUcrYfyOzifGgS0M/uHbI0Op
	 2yWAw2T+WpA4lqH9J+KbcZ12JEkEHe4Lc9My6ZU837gVnSMprR/cZ4Ja0rw2blkSvu
	 e58gwU6SDCrDA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: remove unneeded if-conditional in conf_choice()
Date: Sun, 21 Apr 2024 20:13:02 +0900
Message-Id: <20240421111302.2712135-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All symbols except choices have a name.

child->sym->name never becomes NULL inside choice blocks.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/conf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 965bb40c50e5..0156ca13f949 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -497,9 +497,8 @@ static int conf_choice(struct menu *menu)
 				printf("%*c", indent, '>');
 			} else
 				printf("%*c", indent, ' ');
-			printf(" %d. %s", cnt, menu_get_prompt(child));
-			if (child->sym->name)
-				printf(" (%s)", child->sym->name);
+			printf(" %d. %s (%s)", cnt, menu_get_prompt(child),
+			       child->sym->name);
 			if (!sym_has_value(child->sym))
 				printf(" (NEW)");
 			printf("\n");
-- 
2.40.1


