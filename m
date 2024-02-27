Return-Path: <linux-kernel+bounces-82922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E6868BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FD92821DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049F1384B1;
	Tue, 27 Feb 2024 09:10:15 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36062136673;
	Tue, 27 Feb 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025014; cv=none; b=Pfpw8tcZ+Xy0zRc1UMdpZ3CujRzJ/LgtiJSMwI+HYdubzwFuRlywqgHbFB1Y3bOPLqJ7QrHxpjTQoHMzB9z4TFi7qTbfRa19OrWEeJS750aRDIOjvqRxdugaJr6mbgOMZGxeFw+1Np2fBo0pCizEVxFbZvYXTs0lpDj8OSAxibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025014; c=relaxed/simple;
	bh=15SL5H9Vr3d25QL8lsHu2Dxz6rwn+VRLaCIq0cwiSrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iiew4jZLRMVHZwks8Tig55fKrPwZ/GBTa/Eq/ok9rB3ZyBjnxvGIzSG2y/MJao38gs3cUFX4DtxpH+aEf1NxAM179atjnjLUv2VI9zgJL27Tz+IADCIX8Yhttpq6vRyWlKjHH6RCHQ8yYiZVZ1HU14XtFB2SJBOhFEMX5Ia7Xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TkWqs0T9kz1xpNr;
	Tue, 27 Feb 2024 17:08:41 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 1589A1A016B;
	Tue, 27 Feb 2024 17:10:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:10:09 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 6/9] ext4: add positive int attr pointer to avoid sysfs variables overflow
Date: Tue, 27 Feb 2024 17:11:45 +0800
Message-ID: <20240227091148.178435-7-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240227091148.178435-1-libaokun1@huawei.com>
References: <20240227091148.178435-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)

The following variables controlled by the sysfs interface are of type
int and are normally used in the range [0, INT_MAX], but are declared as
attr_pointer_ui, and thus may be set to values that exceed INT_MAX and
result in overflows to get negative values.

  err_ratelimit_burst
  msg_ratelimit_burst
  warning_ratelimit_burst
  err_ratelimit_interval_ms
  msg_ratelimit_interval_ms
  warning_ratelimit_interval_ms

Therefore, we add attr_pointer_pi (aka positive int attr pointer) with a
value range of 0-INT_MAX to avoid overflow.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/sysfs.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 8e0473169458..ddb54608ca2e 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -32,6 +32,7 @@ typedef enum {
 	attr_clusters_in_group,
 	attr_mb_order,
 	attr_feature,
+	attr_pointer_pi,
 	attr_pointer_ui,
 	attr_pointer_ul,
 	attr_pointer_u64,
@@ -180,6 +181,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
 #define EXT4_RO_ATTR_ES_STRING(_name,_elname,_size)			\
 	EXT4_ATTR_STRING(_name, 0444, _size, ext4_super_block, _elname)
 
+#define EXT4_RW_ATTR_SBI_PI(_name,_elname)      \
+	EXT4_ATTR_OFFSET(_name, 0644, pointer_pi, ext4_sb_info, _elname)
+
 #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
 	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
 
@@ -222,12 +226,12 @@ EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
-EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
-EXT4_RW_ATTR_SBI_UI(err_ratelimit_burst, s_err_ratelimit_state.burst);
-EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
-EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
-EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
-EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
+EXT4_RW_ATTR_SBI_PI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
+EXT4_RW_ATTR_SBI_PI(err_ratelimit_burst, s_err_ratelimit_state.burst);
+EXT4_RW_ATTR_SBI_PI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
+EXT4_RW_ATTR_SBI_PI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
+EXT4_RW_ATTR_SBI_PI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
+EXT4_RW_ATTR_SBI_PI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
 #ifdef CONFIG_EXT4_DEBUG
 EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
 #endif
@@ -382,6 +386,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
 	case attr_inode_readahead:
 	case attr_clusters_in_group:
 	case attr_mb_order:
+	case attr_pointer_pi:
 	case attr_pointer_ui:
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
 			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
@@ -452,6 +457,14 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
 		return 0;
 
 	switch (a->attr_id) {
+	case attr_pointer_pi:
+		ret = kstrtouint(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if ((int)t < 0)
+			return -EINVAL;
+		*((unsigned int *) ptr) = t;
+		return len;
 	case attr_pointer_ui:
 		ret = kstrtouint(skip_spaces(buf), 0, &t);
 		if (ret)
-- 
2.31.1


