Return-Path: <linux-kernel+bounces-111462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F2886CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBA41C21698
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF5D44C89;
	Fri, 22 Mar 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y91k3fo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DF4501C;
	Fri, 22 Mar 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113620; cv=none; b=TyynmqGVdfQz/u865NDFUYfmtBx3Muegc3X1GiMdRRMTBDSlK1WBbKeiypES2NYHS5+Ox/acQg2NkM5MxXDSnR77f7DCrN4yALahnQ5Pel6vJXwxt9fux2XLt+DtjwBB1zotnnAqBSy2IWQiV9n/BjV8TzNz/H4BM4XMumFVq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113620; c=relaxed/simple;
	bh=EEJlkqbFRKdutJiIhqb15BoNHeyy0W43DVSF26lWl08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JpyBpYCGb4S8KTIRFxN+qy+s47wIectoA1NH7K2gvYccNPQtUK2CAf7IYML1PHyCdwyVN5B1CPysiokAhlUxk8JsxZn3IZbtgo1g293gixS6a1Zo1oKNJi00aJfwRFQMOMaycYwXeDBcdrBuZmc6/EAJrQWPdVJbPxUGHyJvYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y91k3fo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6887FC433F1;
	Fri, 22 Mar 2024 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113619;
	bh=EEJlkqbFRKdutJiIhqb15BoNHeyy0W43DVSF26lWl08=;
	h=From:To:Cc:Subject:Date:From;
	b=Y91k3fo+UgGLFpJEMeLTwOztmBVaIzbRbC2bvNmlLzsbTRzUA4innhjnIMM7+kuVQ
	 5AB8mUKTls/OeC1KsWS1U13jpEl4MCg6W5nIt94kpqauIYdKDNTb4NFW9XBbflOPxY
	 N2m7SyG5SA/bjR/cqmL51I2GAbC7uakQL/e9VkiKCGf07kRZQp23pA7wqbcwaNSUtM
	 GFJIp4lqKl639NlPyzesF0xaHRXvdZkDf0TAbOHlHbEJd72+9PuVtEsfh4KSJh93ga
	 A5B/SxAPVviWmANwyl+++nVOO1+shLU0PfLhBw4w0fGl6PGBmWgHewqVt/ChuYPbx7
	 pg8pbgj6b3fIA==
From: Arnd Bergmann <arnd@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: silence warning about unused 'no_warn' variable
Date: Fri, 22 Mar 2024 14:20:05 +0100
Message-Id: <20240322132014.906097-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The sysfs_create_link() return code is marked as __must_check, but the
module_add_driver() function tries hard to not care, by assigning the
return code to a variable. When building with 'make W=1', gcc still
warns because this variable is only assigned but not used:

drivers/base/module.c: In function 'module_add_driver':
drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]

Add an explicit cast to void to prevent this check as well.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
See-also: 4a7fb6363f2d ("add __must_check to device management code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not entirely sure what bug the __must_check on sysfs_create_link()
is trying to prevent, or why the module loader code is allowed to
ignore this. It would be nice to have an Ack from the sysfs maintainers
on this.
---
 drivers/base/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..0180dbcf2240 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -67,6 +67,8 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 					    driver_name);
 		kfree(driver_name);
 	}
+
+	(void)no_warn;
 }
 
 void module_remove_driver(struct device_driver *drv)
-- 
2.39.2


