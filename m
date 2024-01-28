Return-Path: <linux-kernel+bounces-41679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE983F64A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193D31C21B66
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A8288DF;
	Sun, 28 Jan 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BThAZpoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7F2EB1D;
	Sun, 28 Jan 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457976; cv=none; b=jZv8d6tAm1eeznrd/QFU5y2+u8Ha2/5rtOnoXlUCymcjM9VIpFCSB/OENeOtcsFf8F34nC6iPb+dVUCi1x1B/cVqI4s9gKWM3EmBxKNvW7JqIAaqUj4WUoPpETk2YT52B0gC7pipU65ke9T7lyc8cp4rqYOx9rrjWpAAQfSJGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457976; c=relaxed/simple;
	bh=tUG4O+PgRfdAjKLE8Z/uNA5hf36Y7t+Ym1/UMNDsPG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lx9M6dpqQf0KrFZDD01k5/l7qDzA+Xj0ekaDiUCSUyA0VUlSUSLcviG0Aho9vyAGS4qA9JBb7UT0vlZdfaZn/Whs2qptOpHLGqrN0++np5f7eseVI1e8gxQkmLXbaRcbKGvVeM0FkA8UJtgaPglMQdE7uy7VL7yKrW/0tOUplZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BThAZpoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20E4C43390;
	Sun, 28 Jan 2024 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706457976;
	bh=tUG4O+PgRfdAjKLE8Z/uNA5hf36Y7t+Ym1/UMNDsPG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BThAZpojLE/4qW5yzHzRBtAaQ7rhFO+NUqYv44ES20PUvjB5NGz6RUOcWp2AZpJEi
	 qh6gbkaCh1mhTHsXgcs6vFa9oIhl1NsB06Eo1RZMKuqES4qwTMgF4hJiAXNNX17XBG
	 /FwgagQbrKgDiZaSaWoh5tsP+QZrOF+PssTTauB1B3OpK1a46p64iYEx+9Mv5BA0dp
	 G4kV060SGIsaS6iCxRHsIPpPDahgWoLz9ro9uK5yiWO/NT22nOlDSabvhRobvlUrKm
	 op9U9XtMFY79DF6z+ETw+paZ9C435G9B4tLCHCIcUB9HaAEEx4qo4edkoX2GrHqrPV
	 gTQ5BaBELC9Xw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 3/5] of: unittest: Use for_each_child_of_node_scoped()
Date: Sun, 28 Jan 2024 16:05:40 +0000
Message-ID: <20240128160542.178315-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128160542.178315-1-jic23@kernel.org>
References: <20240128160542.178315-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A simple example of the utility of this autocleanup approach to
handling of_node_put()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/of/unittest.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index cfd60e35a899..d353327767b3 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -233,27 +233,22 @@ static void __init of_unittest_dynamic(void)
 
 static int __init of_unittest_check_node_linkage(struct device_node *np)
 {
-	struct device_node *child;
 	int count = 0, rc;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (child->parent != np) {
 			pr_err("Child node %pOFn links to wrong parent %pOFn\n",
 				 child, np);
-			rc = -EINVAL;
-			goto put_child;
+			return -EINVAL;
 		}
 
 		rc = of_unittest_check_node_linkage(child);
 		if (rc < 0)
-			goto put_child;
+			return rc;
 		count += rc;
 	}
 
 	return count + 1;
-put_child:
-	of_node_put(child);
-	return rc;
 }
 
 static void __init of_unittest_check_tree_linkage(void)
-- 
2.43.0


