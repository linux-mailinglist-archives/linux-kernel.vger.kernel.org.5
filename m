Return-Path: <linux-kernel+bounces-17730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE698251AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2934B23D17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC02CCBB;
	Fri,  5 Jan 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qB194l4N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0082CCB8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE13C433C7;
	Fri,  5 Jan 2024 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704449785;
	bh=wVz/wYYysRMvYjHcfqRSF/XdEwbeiY/IQOOSisoeE6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=qB194l4NAu6JMrdnRQKjdZsb5/G+864DaGMBZOUAjETqng9gWgFFrbM796frZEKGE
	 R3A05PU4zEgapTdDDqnaTJxR6MnFOnRi4uTt7M8DOeFikIBTQZ05fT8D5ZyYNkw4TS
	 eq0NVna+Mr44wzibv8v9MuM3Gjo4In/uukDKLjg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: greybus-dev@lists.linaro.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>
Subject: [PATCH] greybus: make greybus_bus_type const
Date: Fri,  5 Jan 2024 11:16:17 +0100
Message-ID: <2024010517-handgun-scoreless-05e7@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 41
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=wVz/wYYysRMvYjHcfqRSF/XdEwbeiY/IQOOSisoeE6Q=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnTr33Mnmz5Oehhg8V9+UNzi1R/L5Bp+Hpa8uGTgtNP5 nI5JH1a0RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT4dvOMD/KwWfe32dXs7S/ LGE9zvSP3/2LZRjDgpN+NwSPmyeuCD/YweS7OrZHW0tWFAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the greybus_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/greybus/core.c  | 2 +-
 include/linux/greybus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index 5714be740470..b0aadc1e7bbe 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -155,7 +155,7 @@ static void greybus_shutdown(struct device *dev)
 	}
 }
 
-struct bus_type greybus_bus_type = {
+const struct bus_type greybus_bus_type = {
 	.name =		"greybus",
 	.match =	greybus_match_device,
 	.uevent =	greybus_uevent,
diff --git a/include/linux/greybus.h b/include/linux/greybus.h
index 18c0fb958b74..92da9ec4f5f0 100644
--- a/include/linux/greybus.h
+++ b/include/linux/greybus.h
@@ -104,7 +104,7 @@ void gb_debugfs_init(void);
 void gb_debugfs_cleanup(void);
 struct dentry *gb_debugfs_get(void);
 
-extern struct bus_type greybus_bus_type;
+extern const struct bus_type greybus_bus_type;
 
 extern struct device_type greybus_hd_type;
 extern struct device_type greybus_module_type;
-- 
2.43.0


