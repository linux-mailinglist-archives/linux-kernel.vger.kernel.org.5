Return-Path: <linux-kernel+bounces-98245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2AF877750
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981BF282292
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F13717B;
	Sun, 10 Mar 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHblSTb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179F364A8;
	Sun, 10 Mar 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080187; cv=none; b=OHum3kSXRsN88Sm4ZHIps0A2zDZNXb9BnmqrKaNiqLXSazNlFEkDI0ZWHlYKZ5q5bXqQ822V4Dg93ylW/hDHTQYzzgk9yxMAw98mQ2n9XbfKvF9q3L6NK+4AeE3HeDAaGNTrB0L58BxOGVEMa0rgw2mUFGaaCsGiZTGlLfA8/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080187; c=relaxed/simple;
	bh=/Dth7Oao/M9/4eesqTDyXiBgGgbrahl+e7eHqlVqpEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmjfoRaZUUEoGWh+JUXJEeeim9Qvz6bGNzpwwcHvsqc8w4aukFJAMLqMnluvHUc2f10BLd/h6wF1+UOveraE28WT+Q+h8iu6nW2THMT6Y6sg28xw+Gh/exbrh2aaqkbvo+blHoPxYvnVwVi1VR5ebgaGeiM2v4PmIK2in3hN1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHblSTb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B7BC433C7;
	Sun, 10 Mar 2024 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710080186;
	bh=/Dth7Oao/M9/4eesqTDyXiBgGgbrahl+e7eHqlVqpEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHblSTb5sPHqVe6cc8nRjcfYpUktPB7R5/xxVKcAN94TDS192tucsuoVxPDs92kIt
	 UB2Ml7YgjhrmCYIqgFNfvL7IED6QjHmbJ7KTs9SeYJgotzc71ALGbJ/4+7nljVA0Qt
	 Qe+23JlpKJufD+kXe59OF4ZsNSXXdZ2iKJlAz3ez77BinpR6I1Pjs8sux5X8YI2b1/
	 QDjonVHKX5JlmZ5py4HVLx54OgdWLVvN7XAVmNsmW3fR0vxyuekqi5S1y9oulyuKsH
	 VCXpbBgzO3zzb/rY7AVqlYoAumUtqNaWpJsRSErwaEDU/mve/IPcaSedxQuxrL9XIG
	 XYYF9povPAfQw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] kconfig: add menu_next() function and menu_for_each(_sub)_entry macros
Date: Sun, 10 Mar 2024 23:16:18 +0900
Message-Id: <20240310141619.606415-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240310141619.606415-1-masahiroy@kernel.org>
References: <20240310141619.606415-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions require traversing menu entries sequentially. This
commit introduces some helpers to simplify such operations.

The menu_next() function facilitates depth-first traversal:

 1. Descend to the child level if the current menu has one
 2. Move to the next sibling at the same level if available
 3. Ascend to the parent level if there is no more child or sibling

The menu_for_each_sub_entry() macro iterates over all submenu entries
using depth-first traverse.

The menu_for_each_entry() macro is the same, but over all menu entries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lkc.h  |  5 +++++
 scripts/kconfig/menu.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index e69d7c59d930..5241dccd559e 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -79,6 +79,11 @@ void str_printf(struct gstr *gs, const char *fmt, ...);
 char *str_get(struct gstr *gs);
 
 /* menu.c */
+struct menu *menu_next(struct menu *menu);
+#define menu_for_each_sub_entry(menu, root) \
+	for (struct menu *menu = (root)->list; menu != (root)->next && menu != (root)->parent; menu = menu_next(menu))
+#define menu_for_each_entry(menu) \
+	menu_for_each_sub_entry(menu, &rootmenu)
 void _menu_init(void);
 void menu_warn(struct menu *menu, const char *fmt, ...);
 struct menu *menu_add_menu(void);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 8498481e6afe..417dc01ac412 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -17,6 +17,21 @@ static const char nohelp_text[] = "There is no help available for this option.";
 struct menu rootmenu;
 static struct menu **last_entry_ptr;
 
+/**
+ * menu_next - return the next menu entry with depth-first traversal
+ * @menu: the pointer to the current menu
+ */
+struct menu *menu_next(struct menu *menu)
+{
+	if (menu->list)
+		return menu->list;
+
+	while (!menu->next && menu->parent)
+		menu = menu->parent;
+
+	return menu->next;
+}
+
 void menu_warn(struct menu *menu, const char *fmt, ...)
 {
 	va_list ap;
-- 
2.40.1


