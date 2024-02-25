Return-Path: <linux-kernel+bounces-80100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFB862ABF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB451C20B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB238171C8;
	Sun, 25 Feb 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DihQqm1c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923317579;
	Sun, 25 Feb 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871267; cv=none; b=i/FW5lnaTLVaea9twjxeIvTOFFHpz9d2ZRc6PPewC+pAG5hp3Ps4TNoJf5z8H9CU+c8m/a9tgzwjmXUnINCI5ejPscxKSLgI/cqDTa2fcMDwk4vWrA1wAIKDoFI5WbN/0L60mLumH+U88W1JuFf/zt6ZTIOFP++HeqH2OxLZTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871267; c=relaxed/simple;
	bh=cy3xgv+zOTeCfTawrekO50j/BQnaTUqEu6LMlwDPXkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sthZvdpeyNhFLDh8vQdyv/tuAg31UxW2A+ZMDg7qBiOvxX9KtjHG8Zr48viSz9lKbcgjzPBuK2CT1gO9Lr1RPQZzr6gC8rZNTFZ5JcNn9gXmscFzlpvWTalOyThqwhxdewIJAmhNBxA1nkBl3lo99I0S4EfcVh4mbPkx6w9mbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DihQqm1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E28C433F1;
	Sun, 25 Feb 2024 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708871266;
	bh=cy3xgv+zOTeCfTawrekO50j/BQnaTUqEu6LMlwDPXkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DihQqm1cO4S4hEX3mO7srDwzf8AMPmNm9EXTEwCUb5Ft61bHiQ/1Ti6VC3WR4TSt0
	 C2VD+yTN7u2+bDQISJ+ctCCUE/NkwCiU0/44ISX3U/OQjEK9Oy0LczGoor0eHlMCf+
	 lU8DVnp61JzDLpAIiUV6x51vVmXtjtRVKMxci84kwkJ4f9vYDLyiuiPzMeRjaXH/9O
	 BGmTIx5qtzD9+05iKnUJKA/fCGOcYlo3JMAc5hjfITNSRzZnZGz3dr649kKpmSKkeB
	 kwSNQp00qkqbm8g+kaVgvvk5KInutdjD7x67aAoUKdFq/qY1pz9FYHXqOyCNH7A2im
	 907Ychz4iLJIw==
From: Jonathan Cameron <jic23@kernel.org>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	marek.vasut@gmail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH v2 3/4] of: unittest: Use for_each_child_of_node_scoped()
Date: Sun, 25 Feb 2024 14:27:13 +0000
Message-ID: <20240225142714.286440-4-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225142714.286440-1-jic23@kernel.org>
References: <20240225142714.286440-1-jic23@kernel.org>
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
2.44.0


