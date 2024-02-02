Return-Path: <linux-kernel+bounces-50087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE084740D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B9D1C25607
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4844153BEC;
	Fri,  2 Feb 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn3YZR80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D915350E;
	Fri,  2 Feb 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889541; cv=none; b=VsuSThnnYomgWjk6JFcsg7/9mga9UFVFcAPqe4BagROxq+VptKycGF93SAN0C6PeDfOvmEGsIevuyE5uG04dRRb4B0Oj7AYPfz7owQwuxYTQr0gW5PxwBlh5BsuwgvGM2oitRCXWf4lnUaY7WSbnLdA1N9CFhWVByW/maD/G09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889541; c=relaxed/simple;
	bh=z4Cms56kmTfXRHkY+P++VOmPThXzhuLEMnCh+5t5LTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpBfO3kKOzjLLhS0sOJaEb1M3U4UQafTpl/PxSdxhs7Q+GBZ9hV95VtwRwXlXq5KPg4S+ACEw9TX5DO9tKQcPfrSF7VDR3RnW3ZPYG7woFyGzGNCKEayiG8tllvGvxSsMhENVpjhlHhOcWTyObbOkSeWwscp0JfCuo0Zi2y4SPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn3YZR80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF86C43390;
	Fri,  2 Feb 2024 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889540;
	bh=z4Cms56kmTfXRHkY+P++VOmPThXzhuLEMnCh+5t5LTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nn3YZR80OfoXt/sLgprXuYM20Lq3vti3Bsrk0CaUs8c7oU5QF7MwxAzEWpoAp9dGH
	 7rM06W06R0+Uc+bAhvFj+HuwDNJUXxXM12eCARlJH9by5rQqTStGZPzBilgeI/p5MJ
	 zUr2e3hI5gBKtgGLvo9zFFSWMuLsr7zqWMjsTaS9/tncjCAYGRzRoJIwbQZVWRpYF2
	 lXgiuhMH+k5Kq7rgx3lRGc4eBztnQjo6zIwlPiwFSdQNnJ1XEPeLr792PFoXTrmEo2
	 ZOAn5mBQ+DSbMPqRfKYqqNjxjzNKH8fE+0IEAhaVFyPXRnJOxdwu19DP2OUWxbVUNg
	 MmBYRI1Hd6Afg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 27/27] kconfig: do not imply the type of choice value
Date: Sat,  3 Feb 2024 00:58:25 +0900
Message-Id: <20240202155825.314567-28-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not feed back the choice type to choice values.

Each choice value should explicitly specify 'bool' or 'tristate',
as all the Kconfig files already do. If the type were missing,
"config symbol defined without type" would be shown.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/menu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 696803d944e0..44465945d6b1 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -305,12 +305,6 @@ void menu_finalize(struct menu *parent)
 					}
 				}
 			}
-			/* set the type of the remaining choice values */
-			for (menu = parent->list; menu; menu = menu->next) {
-				current_entry = menu;
-				if (menu->sym && menu->sym->type == S_UNKNOWN)
-					menu_set_type(sym->type);
-			}
 
 			/*
 			 * Use the choice itself as the parent dependency of
-- 
2.40.1


