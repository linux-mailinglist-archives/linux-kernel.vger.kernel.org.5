Return-Path: <linux-kernel+bounces-43722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD623841863
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834EF1F245C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0948336AEC;
	Tue, 30 Jan 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKZfRcZj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980D364AA;
	Tue, 30 Jan 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578559; cv=none; b=cIQEkS1JsCVTNYdse3AM4ihbBnIHZdv5RCEFJK/FEWSzUo7p6+JL+tLaFiQpDdmVCAUnbxokQLy22gRSBqdg0aB3Zk3SqgM8PERzv/U4v+00oRezKx0bOI/YpIbooZD7u4TaO8ouuAxI2jOzFRITQnX8ZMSOu0xUrkrI5DOuZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578559; c=relaxed/simple;
	bh=GSL7nuFSaQ43gT72aNum7HC23/clv4WedM2oZBR/GrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3WjOyooAf96DVrTsyG/+DUYLb6CAY90vyI0zu8Kmr2pFxai/4Kc9VvkM4x2otOWwEzWAyr9jc6NFNg4USoXOsZS7/VyfYCWNFrZ9VeDPEYB0JRFFiL5Zecwl7EMqexJ5WbwkKgcmqWkEHl2bgvIsmp/0N5EWzpIyOvEZ3CYzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKZfRcZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67DBC43394;
	Tue, 30 Jan 2024 01:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578558;
	bh=GSL7nuFSaQ43gT72aNum7HC23/clv4WedM2oZBR/GrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKZfRcZjeMJaoFjnzl1T3ocvC/Uhe1cyzn0Rc/XlnkaJj+m8bW46azfzCAuxbWIjn
	 ewYrYf+SX915gV51UI+fD+Juf+moFNFV8MT15MTOIC1sS5Sf2YrvbufrC6MDxeidSc
	 JdIqXBP51Er2vjIiDvxotFCBi4JC0GwO0yHvVrrigMXoRUfYpq8mniDcee5NfVkdqM
	 te+wzvlVzvP8MoNEKUoCLL70JAR0WKcmZD4ugSL6B1yRmpLXJfm9RvKlB0l0OnmYTm
	 04Sb7RUNXerZ/8174TpYCB+CbhmjLKtX915YANCjPBkRq+5saAwP9Fj6G04a0cgKun
	 hPWm6PJgR8KEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mm/damon: rename CONFIG_DAMON_DBGFS to DAMON_DBGFS_DEPRECATED
Date: Mon, 29 Jan 2024 17:35:41 -0800
Message-Id: <20240130013549.89538-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON debugfs interface is deprecated.  The fact has documented by
commit 5445fcbc4cda ("Docs/admin-guide/mm/damon/usage: add DAMON debugfs
interface deprecation notice").  Commit 620932cd2852 ("mm/damon/dbgfs:
print DAMON debugfs interface deprecation message") further started
printing a warning message when users still use it.  Many people don't
read documentation or kernel log, though.

Make the deprecation harder to be ignored using the approach of commit
eb07c4f39c3e ("mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED").
'make oldconfig' with 'CONFIG_DAMON_DBGFS=y' will get a new prompt with
the explicit deprecation notice on the name.  'make olddefconfig' with
'CONFIG_DAMON_DBGFS=y' will result in not building DAMON debugfs
interface.  If there is a real user of DAMON debugfs interface, they
will complain the change to the builder.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 29f43fbc2eff..fecb8172410c 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -71,7 +71,7 @@ config DAMON_SYSFS_KUNIT_TEST
 
 	  If unsure, say N.
 
-config DAMON_DBGFS
+config DAMON_DBGFS_DEPRECATED
 	bool "DAMON debugfs interface (DEPRECATED!)"
 	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
 	help
@@ -84,6 +84,11 @@ config DAMON_DBGFS
 	  (DAMON_SYSFS).  If you depend on this and cannot move, please report
 	  your usecase to damon@lists.linux.dev and linux-mm@kvack.org.
 
+config DAMON_DBGFS
+	bool
+	default y
+	depends on DAMON_DBGFS_DEPRECATED
+
 config DAMON_DBGFS_KUNIT_TEST
 	bool "Test for damon debugfs interface" if !KUNIT_ALL_TESTS
 	depends on DAMON_DBGFS && KUNIT=y
-- 
2.39.2


