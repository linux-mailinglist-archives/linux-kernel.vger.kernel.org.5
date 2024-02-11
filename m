Return-Path: <linux-kernel+bounces-60886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60746850A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B6283651
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC05D499;
	Sun, 11 Feb 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUqMQoWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD102837D;
	Sun, 11 Feb 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673393; cv=none; b=SjVrsHH/2FMap/JwV/aWOrxMuWsq5Xrpaib4kRpudmCFnZ2JD+ooM3Obnf21JfWI3zCHyI2FP7rPxonTjSh6lZSB9jZtHdKsAXS5TmTiLbm4sSyakl5QTlwbD68sMpJUNfrg9xFnVjfGd838I1plck1BKFkoVgaQ3isjVPUQSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673393; c=relaxed/simple;
	bh=FL7OGytfdxTg1+Il2BlWOFoikr/LWTCTYjPks2DpfGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1LDiu8ygANN3U2cDpShQbIlPZAAsL5UydtHChrN8icqC6NdIR1kxB6CRAvCjJMsmah734MhzPY+g56APKZt9fwMV7Y1hr3qgXGwW/ekuyk7G5eZC+teGlhh9ktJek0k4oXDVyb2w1BgtuDgIIubacltHKinz2O87Ad4Br1ECGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUqMQoWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7586BC43390;
	Sun, 11 Feb 2024 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673392;
	bh=FL7OGytfdxTg1+Il2BlWOFoikr/LWTCTYjPks2DpfGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUqMQoWk1tXkagwZnH8JtWCfo+skthBMefbkiM+Vfu4g8PAYIoVqT7XFHAHWFPWuf
	 OXFcvLIbfoxckJ3Bowqs/sx/kC5iM9Sds9nYopT+bQ4o6ueB3YpwsH4oV5aHi5S76h
	 rA/cChOxg6BuRiDe/W0FE+PEcV9k2DpFtMXiRUwliV3jVuYu7g9QVoO07h/HrMDb8C
	 mwPGc1bPXyG3sXjdpqEo3CjzH+15pwe2VDwHtPKOW7Xkqn0G7o2b7RhQCQiKFYRmgp
	 H5F/XrokeFMMrDTzdBorgj280D9v+zZuyBFX0IY1gPMc/PE9r3cgf8DUXSoeMGsoaL
	 66JjV23yVCS+A==
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
Subject: [PATCH 1/8] of: Add cleanup.h based auto release via __free(device_node) markings.
Date: Sun, 11 Feb 2024 17:42:29 +0000
Message-ID: <20240211174237.182947-2-jic23@kernel.org>
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

The recent addition of scope based cleanup support to the kernel
provides a convenient tool to reduce the chances of leaking reference
counts where of_node_put() should have been called in an error path.

This enables
	struct device_node *child __free(device_node) = NULL;

	for_each_child_of_node(np, child) {
		if (test)
			return test;
	}

with no need for a manual call of of_node_put().
A following patch will reduce the scope of the child variable to the
for loop, to avoid an issues with ordering of autocleanup, and make it
obvious when this assigned a non NULL value.

In this simple example the gains are small but there are some very
complex error handling cases buried in these loops that will be
greatly simplified by enabling early returns with out the need
for this manual of_node_put() call.

Note that there are coccinelle checks in
scripts/coccinelle/iterators/for_each_child.cocci to detect a failure
to call of_node_put(). This new approach does not cause false positives.
Longer term we may want to add scripting to check this new approach is
done correctly with no double of_node_put() calls being introduced due
to the auto cleanup. It may also be useful to script finding places
this new approach is useful.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/of.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..50e882ee91da 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -13,6 +13,7 @@
  */
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
@@ -134,6 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
+DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
 
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_root;
-- 
2.43.1


