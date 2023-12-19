Return-Path: <linux-kernel+bounces-5288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0D818902
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF1E289B43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703A1BDCB;
	Tue, 19 Dec 2023 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qpq1X/xb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AF1BDCD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2E9C433C8;
	Tue, 19 Dec 2023 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702993965;
	bh=y9kMvV4sEkVZ0E0BC98vY+U0QoLkarw+sUxXP25mRp0=;
	h=From:To:Cc:Subject:Date:From;
	b=Qpq1X/xbSEQ0zPPckZ1YvQIzAdJRGxTCdMR2TPHWfDM+kqTGUE+lbDUHOlj9k52lM
	 cpFyYni+2WtXWTGeztZm54iqEx3Xn9TD1QWyObZA6gGluQWYzidqsjOBr6X8CaDgg2
	 7NBz75sEHCfEtr5NmypMKyHpiDE2ETpZF++djxlQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: bus: make bus_sort_breadthfirst() take a const pointer
Date: Tue, 19 Dec 2023 14:52:36 +0100
Message-ID: <2023121935-stinking-ditzy-fd5d@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 39
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=y9kMvV4sEkVZ0E0BC98vY+U0QoLkarw+sUxXP25mRp0=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNC1SEsm7nGutv7o3INZ7OYTSrT2dmx9d7/il7j5ov6 lbWErndEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOpOcQwP3mW0qLUlZxy9Ywl P80K8v+dfh+2nmHB5I8sTCunBHK8v33ynWH8Hq/Tx44cAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

For some reason, during the big "clean up the driver core for a const
struct bus_type" work, the bus_sort_breadthfirst() call was missed.  Fix
this up by changing the type to be a const * as it should be.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 2 +-
 include/linux/device/bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index dddbaa024583..daee55c9b2d9 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1030,7 +1030,7 @@ static void device_insertion_sort_klist(struct device *a, struct list_head *list
 	list_move_tail(&a->p->knode_bus.n_node, list);
 }
 
-void bus_sort_breadthfirst(struct bus_type *bus,
+void bus_sort_breadthfirst(const struct bus_type *bus,
 			   int (*compare)(const struct device *a,
 					  const struct device *b))
 {
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index ae10c4322754..25127f750349 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -232,7 +232,7 @@ bus_find_device_by_acpi_dev(const struct bus_type *bus, const void *adev)
 
 int bus_for_each_drv(const struct bus_type *bus, struct device_driver *start,
 		     void *data, int (*fn)(struct device_driver *, void *));
-void bus_sort_breadthfirst(struct bus_type *bus,
+void bus_sort_breadthfirst(const struct bus_type *bus,
 			   int (*compare)(const struct device *a,
 					  const struct device *b));
 /*
-- 
2.43.0


