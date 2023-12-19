Return-Path: <linux-kernel+bounces-5316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD8818957
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992881C22FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926F208C6;
	Tue, 19 Dec 2023 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XuIuJ1wa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CCB208B0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43075C433C7;
	Tue, 19 Dec 2023 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702994846;
	bh=DdgZ7Kj0TE/uoTM/tInTqUYEDMsw/FAT8pdjD0Yw3VU=;
	h=From:To:Cc:Subject:Date:From;
	b=XuIuJ1watMO1Iilr9I23gN9hAnUhTahYaAa+pHdbdFfL6ixcu9WEM1wd48IkRLXrY
	 lYoBl5vfNOSsKFuDuNUTMhXves8M7cR4+cJfruimlsz3P/0kJ9x1B0iC6bz61PWwDQ
	 hWzizolhvxKjuQZHoE4MxXdpjoGICYVo4ujDpr/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] PM: clk: make pm_clk_add_notifier() take a const pointer
Date: Tue, 19 Dec 2023 15:07:23 +0100
Message-ID: <2023121922-triumph-exploit-f545@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 44
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=DdgZ7Kj0TE/uoTM/tInTqUYEDMsw/FAT8pdjD0Yw3VU=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNi2cvO/nGKHzbzxtLJfVW8rTsmVpguv+bf47Tqe+xk /MOLlxt1RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT6U9iWNBZvbrY99/LzN13 e097TKmzC2MsX86wYMGec4tq5HosHy47r67BqXss/mKbNQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The driver core wants to work with const struct bus_type, so there's no
reason that pm_clk_add_notifier() should not also do the same thing,
considering that it just passes the pointer off to the driver core which
is expecting a const *.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/clock_ops.c | 2 +-
 include/linux/pm_clock.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 4110c19c08dc..e18ba676cdf6 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -793,7 +793,7 @@ static int pm_clk_notify(struct notifier_block *nb,
  * the remaining members of @clknb should be populated prior to calling this
  * routine.
  */
-void pm_clk_add_notifier(struct bus_type *bus,
+void pm_clk_add_notifier(const struct bus_type *bus,
 				 struct pm_clk_notifier_block *clknb)
 {
 	if (!bus || !clknb)
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index ada3a0ab10bf..68669ce18720 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -91,10 +91,10 @@ static inline int devm_pm_clk_create(struct device *dev)
 #endif
 
 #ifdef CONFIG_HAVE_CLK
-extern void pm_clk_add_notifier(struct bus_type *bus,
+extern void pm_clk_add_notifier(const struct bus_type *bus,
 					struct pm_clk_notifier_block *clknb);
 #else
-static inline void pm_clk_add_notifier(struct bus_type *bus,
+static inline void pm_clk_add_notifier(const struct bus_type *bus,
 					struct pm_clk_notifier_block *clknb)
 {
 }
-- 
2.43.0


