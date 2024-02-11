Return-Path: <linux-kernel+bounces-60887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032C850A9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B8F1C215B9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7275D743;
	Sun, 11 Feb 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCrmHKDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E85CDF6;
	Sun, 11 Feb 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673396; cv=none; b=cBZYPVcdwsKN1cWj/c1hwXzZ5ttWWZDUB5jKYaAi+OP8Nca++JkgXRfWRP19rWhLAmmBMcLTqQd0uOrXqMt33YRQEGdE8ggPmFbGDTEXVtXWHidjBu+hdsMktXoJw8D5yVwpPce+fJ2Y7rWmAPMQPbB3AKQArvHYkBMzE8C2bfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673396; c=relaxed/simple;
	bh=VgEK2vscmpylabGiM7nvGoX57oIPPeaNwTit8d+h46A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBTU9x9L97uaExtanH5teun+7Lk2o1M6fzsoL1kR2TT0DMCBkTZY7FFClZUFsqH8kRmvsPhL5CRjY3Du6t/tXu/zM0u+JrnEOPO6Mi7/shBC/nBaqa2G5Y67XKd3MuQ6mUSAmzkWPVt1zCJljKTD/088B8JGoVz2CVT/V+JHH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCrmHKDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4724CC433C7;
	Sun, 11 Feb 2024 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673396;
	bh=VgEK2vscmpylabGiM7nvGoX57oIPPeaNwTit8d+h46A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCrmHKDPCdySn0pPYItTL2t7zwZYjXsrjzzICJ5bIPlVfBxcXz3I4mQx9Rm8+05IG
	 4zhQ5X9GNutZxC1biiXulib7hYq7Nf9Pkc+p8yBs7GT2qSG+CWT06pgc4K15BVQ/Pt
	 xJIvH/rpk2l+k8WlsV5XbVworWbScq2wnTXn6sh9G4n1qq322KDmhvEqFftqyOQTsF
	 jO52rL3gkVRzJMXltO1tCzCRdeY33DAJeUZXabutSKhgmJRten5clFb7JlKG02UOgL
	 1DrJWdfMVK3jobfLMxbYhWwFvjIGhSWiXkuryeMBJYkELTHBHier4/Bq62iK/5yJp7
	 mbpWd75FVNViQ==
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
Subject: [PATCH 2/8] of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
Date: Sun, 11 Feb 2024 17:42:30 +0000
Message-ID: <20240211174237.182947-3-jic23@kernel.org>
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

To avoid issues with out of order cleanup, or ambiguity about when the
auto freed data is first instantiated, do it within the for loop definition.

The disadvantage is that the struct device_node *child variable creation
is not immediately obvious where this is used.
However, in many cases, if there is another definition of
struct device_node *child; the compiler / static analysers will notify us
that it is unused, or uninitialized.

Note that, in the vast majority of cases, the _available_ form should be
used and as code is converted to these scoped handers, we should confirm
that any cases that do not check for available have a good reason not
to.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/of.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 50e882ee91da..024dda54b9c7 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1430,10 +1430,23 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_child_of_node(parent, child) \
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
+
+#define for_each_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child(parent, NULL);				\
+	     child != NULL;						\
+	     child = of_get_next_child(parent, child))
+
 #define for_each_available_child_of_node(parent, child) \
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))
 
+#define for_each_available_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_available_child(parent, NULL);			\
+	     child != NULL;						\
+	     child = of_get_next_available_child(parent, child))
+
 #define for_each_of_cpu_node(cpu) \
 	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
 	     cpu = of_get_next_cpu_node(cpu))
-- 
2.43.1


