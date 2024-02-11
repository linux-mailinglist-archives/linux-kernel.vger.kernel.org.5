Return-Path: <linux-kernel+bounces-60888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01461850AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3CD1F228C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B175D8FD;
	Sun, 11 Feb 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD5NkYJL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39EB5D758;
	Sun, 11 Feb 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673400; cv=none; b=hurKDcSI22D0231wS5HSK+5kDAjoZ40TRigMr8+KtsODHP+dDaSTpprQuhGA/jpCC1+jk9cVHaovW48BEZrbBTTuA4ooCWh+ih1HOZwWW0GsziZzwDs1RjpcbxsYAt4ThTBLxuDH5dcRslGgDdBNsjRP2bKhZTHBf50BORH7wdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673400; c=relaxed/simple;
	bh=ipeQZ+LZe5XilwqeMPmR4IQ68fkOcifsuM6YVshivis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2cRYyCxZsyZmfqXCOWPoJdBk78cIFaZ5jxnqELW+s94utl2j2RmacSYzqS5mVRvmZ2fziNOTzfYvLS6gAVp2uuNRUKbyfb5ExJ5rDIQa/VarkENwcH0CGR18Vz5kek0J2ggfR6ZzgDzZv0//VTQK4qKJtXEc6LuVO1bTt11Rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD5NkYJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8237C43390;
	Sun, 11 Feb 2024 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673400;
	bh=ipeQZ+LZe5XilwqeMPmR4IQ68fkOcifsuM6YVshivis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FD5NkYJLGeomQEeIp1Xv63ealhPiBYhblKKG2irQbuUnY5MqOtb+XQ6EDfMV+QoCq
	 +5gMoE+NXCpbH3s4hJZIS05gGzXh4KNxFjbEKvNzU/dk1RAvTzB4bNipOSwarkKuxx
	 1qrTBV2mtkcwzPKWjp/6TwLzWQbYYlreZ9905gHqcwvAPkDZj/+RDzDHOrvG42MS2Y
	 qrzSrIuBCuKFpjiVl7r9PJWHRo/+fnDGjXih+y18F0cBu1MIqAlUwgqKpwwrqRgs5O
	 DajTQzngXbAS4u8OT93WT67f7bx0IVK7ki8ixn3md3KFKsaxmwgR9FToBZce1bj+7d
	 aiRH7jjfLlPPw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/8] of: unittest: Use for_each_child_of_node_scoped()
Date: Sun, 11 Feb 2024 17:42:31 +0000
Message-ID: <20240211174237.182947-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211174237.182947-1-jic23@kernel.org>
References: <20240211174237.182947-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A simple example of the utility of this autocleanup approach to
handling of_node_put().

In this particular case some of the nodes needed for the test are
not available and the _available_ version would cause them to be
skipped resulting in a test failure.

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
2.43.1


