Return-Path: <linux-kernel+bounces-105064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF8187D8AC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F9B282FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4475C5FE;
	Sat, 16 Mar 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rStFbe//"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF784FBE1;
	Sat, 16 Mar 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710560163; cv=none; b=dhef+qFzyQlWrxBdDr3GOb6I2Dx0PKW0BZ4z/Q8n6fbUEhvzuf/pHxCL8oi1BLwuLapgb98PjEl+sMaxVc5hI9KiOFDhmHXZCU2zli+XUjlx920Qk7hhB6RRRS02xewjPdoPDdQ2CvvneGImc3qHkjcRKYF5XrntDEG+Q9A4Es8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710560163; c=relaxed/simple;
	bh=CGol9Yg+mvv8j3MuU5adB+S5Zfdm08E6CNdkO4Pw3e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gaRo9B1kVfUfA1q1+etj7unIvQoKKMCAB+kO3ffYCOpJrc7OGnBDdfz15Zc1NHTN00GDmqZURNF4ZzCGzT11hNawhPFlyPfWsfMryXW7R/1Km00ABG/CIz3uTUehcPXd2cbAJk1s/d5RO2Pe9mM74Z0RsUiNcWUtmiRIE7rcRcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rStFbe//; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id EA20C20B74D9; Fri, 15 Mar 2024 20:35:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA20C20B74D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710560153;
	bh=8UZ8yI1Nl9AJ1CZqfQSY4oqd8EWd1HPQnAJhULnqHQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rStFbe//MNm5gFrEZHDxMrnniZaF/nrd+lZGVoPB6SgZNcOwriBy4iZqOSp/eUZMU
	 FUp2lIddC1EVOobiCvX4vdDaCfFwRPXOk6lG0sQQy2pI+9wyTzvA72Y8o4bpzbg3CY
	 oAl0XjZH9oxHgPIAkynddNJOkKsTdBdUrW6CRKyA=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v15 13/21] dm: add finalize hook to target_type
Date: Fri, 15 Mar 2024 20:35:43 -0700
Message-Id: <1710560151-28904-14-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch adds a target finalize hook.

The hook is triggered just before activating an inactive table of a
mapped device. If it returns an error the __bind get cancelled.

The dm-verity target will use this hook to attach the dm-verity's
roothash metadata to the block_device struct of the mapped device.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v10:
  + Not present

v11:
  + Introduced

v12:
  + No changes

v13:
  + No changes

v14:
  + Add documentation

v15:
  + No changes
---
 drivers/md/dm.c               | 12 ++++++++++++
 include/linux/device-mapper.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..16d3fd644176 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2270,6 +2270,18 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		goto out;
 	}
 
+	for (unsigned int i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(t, i);
+
+		if (ti->type->finalize) {
+			ret = ti->type->finalize(ti);
+			if (ret) {
+				old_map = ERR_PTR(ret);
+				goto out;
+			}
+		}
+	}
+
 	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 	rcu_assign_pointer(md->map, (void *)t);
 	md->immutable_target_type = dm_table_get_immutable_target_type(t);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 82b2195efaca..ad368904b1d5 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -160,6 +160,14 @@ typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
  */
 typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
+/*
+ * This hook allows DM targets in an inactive table to complete their setup
+ * before the table is made active.
+ * Returns:
+ *  < 0 : error
+ *  = 0 : success
+ */
+typedef int (*dm_finalize_fn) (struct dm_target *target);
 
 void dm_error(const char *message);
 
@@ -210,6 +218,7 @@ struct target_type {
 	dm_dax_direct_access_fn direct_access;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
 	dm_dax_recovery_write_fn dax_recovery_write;
+	dm_finalize_fn finalize;
 
 	/* For internal device-mapper use. */
 	struct list_head list;
-- 
2.44.0


