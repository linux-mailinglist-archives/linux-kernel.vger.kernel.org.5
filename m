Return-Path: <linux-kernel+bounces-63419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B5852F06
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B161F243CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4C374F6;
	Tue, 13 Feb 2024 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1nKU+9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DE3838B;
	Tue, 13 Feb 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823265; cv=none; b=tNZzLFEU80tsxfkJj6+pMx7LA3SqLpLZsrwQI3ayiIOSjmpGWmgpVFcTsu/T7cHLin5f3QkdEGZjRt4bZD7qXNBmlB143lmdzFyrwvxV8FZMz+7wdVKgGw/JxCkzjC+bwpqPCv4QhgR+QNg1d/1AOpbj14lJci1UzVSJkpJr9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823265; c=relaxed/simple;
	bh=iSGTy1weM6BB1E4whQVWIFf+UuG8A2NUShVr01qyUoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW3p8/4P1XhjZCSNICBv7E2L+Yi4ZiGDexWLWh3GYkYyyzvBtD2tqDSo7BiyVaLQDf7rCOL3/FE4MZLZeZM/PTUZNRTf7236mjOlPFhvZtV2MzC/gzd0r5A3i2J681uK72Y2pqUw6lwC4wco8N28PG/vaU0Tfjlf70FvlxLfRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1nKU+9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA149C433B1;
	Tue, 13 Feb 2024 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823263;
	bh=iSGTy1weM6BB1E4whQVWIFf+UuG8A2NUShVr01qyUoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1nKU+9sfquXXqkd6qyBkxjqnS0AFPguGvx53BQw02NAU5I1tvz2rW3d556C6cgFw
	 AU508gCgj2+AtwMbOOCE0vH/JA2enqcK8wKQvxQKnRA0NmW4/H6s+K/3XYV8kCt4X4
	 QnyLN+P0JeTN9aIcPLIVMylj7lBJj5ErR1b7ESy10sB7sABhoAnEscJ81FKfBUnSY8
	 Jf/nzgAuJFteIOVjviatJdFz1sFnO5Hsu6wqvRtPveopFwOm606da6k2qSbbYvanYx
	 snqKquOrmW58aMT6H9jXkjO/Zf3lv7fY09AVSh5Tbpg0DRuwtjv6jmpJ1V/zNg16/g
	 hBbq7yqgs2yvg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Douglas Thompson <dougthompson@xmission.com>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH 2/7] EDAC/device: Remove edac_dev_sysfs_block_attribute::{block,value}
Date: Tue, 13 Feb 2024 12:20:46 +0100
Message-ID: <20240213112051.27715-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>
References: <20240213112051.27715-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's unused. And it never was since its addition in fd309a9d8e63e
(drivers/edac: fix leaf sysfs attribute). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Douglas Thompson <dougthompson@xmission.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/edac_device.c | 2 --
 drivers/edac/edac_device.h | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 0689e1510721..0e18729111d4 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -162,8 +162,6 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 				attrib->show = attrib_spec[attr].show;
 				attrib->store = attrib_spec[attr].store;
 
-				attrib->block = blk;	/* up link */
-
 				edac_dbg(4, "alloc-attrib=%p attrib_name='%s' attrib-spec=%p spec-name=%s\n",
 					 attrib, attrib->attr.name,
 					 &attrib_spec[attr],
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 7db22a4c83ef..c4704b5b1e9f 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -99,18 +99,12 @@ struct edac_dev_sysfs_attribute {
  *	can have an array of the following. The show and store functions
  *	will be filled in with the show/store function in the
  *	low level driver.
- *
- *	The 'value' field will be the actual value field used for
- *	counting
  */
 struct edac_dev_sysfs_block_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *, struct attribute *, char *);
 	ssize_t (*store)(struct kobject *, struct attribute *,
 			const char *, size_t);
-	struct edac_device_block *block;
-
-	unsigned int value;
 };
 
 /* device block control structure */
-- 
2.43.1


