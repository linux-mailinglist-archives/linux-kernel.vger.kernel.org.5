Return-Path: <linux-kernel+bounces-165122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C936C8B8859
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80304285277
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAD524B8;
	Wed,  1 May 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfqrSO9x"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BA26286
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557895; cv=none; b=IG6MGTD5s+qLka7aBNwfS77URDupAv8ONeRoMBLRkG41PtXJqb6we1fFkmIH+fjVXeEv1kUSIQswaPMA4YbmneFAXjq2WhMWHKDyihACym7UdWeHnRDvlmqIhdkhuQcdnnq9drVhZo5IUCg98ERmIsa/eMylQEirL/i/v230kZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557895; c=relaxed/simple;
	bh=Qm5gCvwmDeMVHwlF5vZrRm8fnFchsDb9N3kBmaYIEFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6HdllIgNscwfdRlbrACJGhfCtsaUz+L/c3bUnlmFEawE7A1scRVHlC8D54F6jDiy31+TgbVlbGFYeq28y3JkOmuYBnR+79y0eHTdBt+UkALw7WNHukPXqeteP2WuHTUZfZxjQI+6E63PSDqXh2GNNobNA7QT1/dew04CFPhfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfqrSO9x; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ded031fa71so134319139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714557893; x=1715162693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIvbfNHhj5TbvnpekKD4EoyOfeqRMhJTxUZik2O2/6Q=;
        b=AfqrSO9xfIpHFdZ/hne7ZV5hZ18ZaY77vhN4AZb8ee8gTxt9uxdX3yKXLgEPlzFJ0f
         Jl2pZiSRnkc/AWLBIr5d8U2sCkuuE/YbkIhl7upBSQ/mG1bpkWfMHjUQN5Y61ntidKpB
         6EpB9Pq++MqH4tGfUBHB9GpjQSOCTyRAOUzMkOlFzRl+D6hm85hKfI3w/KyPHqt8HbW5
         zwrS66v0gL6P80U7YgKGm78e8aS3f8Aa6m8Sr+qDhDN7h3LxK4aSERebT1L9DolntLSg
         faDJpzh9oeCWgj4eleI3FZTVA+Afy8KyJLbqfXgYByP6ZuHaipHtaT4BYJV5JqdFIRdI
         UntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714557893; x=1715162693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIvbfNHhj5TbvnpekKD4EoyOfeqRMhJTxUZik2O2/6Q=;
        b=l+Jb8jTSCY+vr2DHGHYxtnI4/keU+Xz3aZni+8Cmuia3YTjFuhWGvPE6L0lBQlorHU
         56sPVQLaQT40RVGZUt02Hwc0O7pwU8L6KKYTBklbQGaROSuXNzFDo6Yd4MEB+0OSTn5q
         5MtezgYCAmuvjzxq2x7bbSV/Rf4ya7Pkf9rc2Ibe/N9cgMf8dnNEx38+cnh0J3Ba9Y76
         dDGhsRDw5IjgKW0MqRz1qTmyjUos0pfk/4WmEPoJfEle/mZkDYOXQM/5/B+YCzkZparm
         P+JNxUrfEYkg1/ApCEh+vNA4teKA17mWQDfqdfQvUS0bxC7pCHD8fiqvqnsaP++04TwY
         oJUw==
X-Forwarded-Encrypted: i=1; AJvYcCU6y+MPREDikQCMlCHf+fWIo1BeHH6MqOpgfmrZK2M1uMaKALORf6KDBhCzwyhIutcExHACRZ/xGnzDbua6lufkg8ez9jePSgfYLkEc
X-Gm-Message-State: AOJu0Yy8GL0jakcWua7XWW1m+Ww4ZyU3TcaGeos8l1xrGQWT2lkPV+m+
	qlAoKiRlRxz+9h9yrda5BGkw3oKJUXvf6kAwPTVEPnyRzn4Cvf1L
X-Google-Smtp-Source: AGHT+IEvG+BcSl6mnlsCumJF6Aok/QMB9i3YxeuOAZtciS2FbJ0A7xIM8mpR0R+q6Rbs38MWydF0cw==
X-Received: by 2002:a05:6602:2554:b0:7de:d55f:c1d3 with SMTP id cg20-20020a056602255400b007ded55fc1d3mr2206254iob.17.1714557893424;
        Wed, 01 May 2024 03:04:53 -0700 (PDT)
Received: from localhost (fwdproxy-nao-119.fbsv.net. [2a03:2880:23ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id ft3-20020a05660260c300b007dee6a8b524sm369559iob.21.2024.05.01.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 03:04:53 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] selftests: cgroup: add tests to verify the zswap writeback path
Date: Wed,  1 May 2024 11:04:46 +0100
Message-ID: <20240501100446.1454264-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The condition for writeback can be triggered by allocating random
memory more than memory.high to push memory into zswap, more than
zswap.max to trigger writeback if enabled, but less than memory.max
so that OOM is not triggered. Both values of memory.zswap.writeback
are tested.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index f0e488ed90d8..fe0e7221525c 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void *arg)
 	return 0;
 }
 
+static int allocate_random_bytes(const char *cgroup, void *arg)
+{
+	size_t size = (size_t)arg;
+	char *mem = (char *)malloc(size);
+
+	if (!mem)
+		return -1;
+	for (int i = 0; i < size; i++)
+		mem[i] = rand() % 128;
+	free(mem);
+	return 0;
+}
+
 static char *setup_test_group_1M(const char *root, const char *name)
 {
 	char *group_name = cg_name(root, name);
@@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
 	return ret;
 }
 
+/* Test to verify the zswap writeback path */
+static int test_zswap_writeback(const char *root, bool wb)
+{
+	int ret = KSFT_FAIL;
+	char *test_group;
+	long zswpwb_before, zswpwb_after;
+
+	test_group = cg_name(root,
+		wb ? "zswap_writeback_enabled_test" : "zswap_writeback_disabled_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.max", "8M"))
+		goto out;
+	if (cg_write(test_group, "memory.high", "2M"))
+		goto out;
+	if (cg_write(test_group, "memory.zswap.max", "2M"))
+		goto out;
+	if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
+		goto out;
+
+	zswpwb_before = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
+	if (zswpwb_before < 0) {
+		ksft_print_msg("failed to get zswpwb_before\n");
+		goto out;
+	}
+
+	/*
+	 * Allocate more than memory.high to push memory into zswap,
+	 * more than zswap.max to trigger writeback if enabled,
+	 * but less than memory.max so that OOM is not triggered
+	 */
+	if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
+		goto out;
+
+	/* Verify that zswap writeback occurred only if writeback was enabled */
+	zswpwb_after = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
+	if (wb) {
+		if (zswpwb_after <= zswpwb_before) {
+			ksft_print_msg("writeback enabled and zswpwb_after <= zswpwb_before\n");
+			goto out;
+		}
+	} else {
+		if (zswpwb_after != zswpwb_before) {
+			ksft_print_msg("writeback disabled and zswpwb_after != zswpwb_before\n");
+			goto out;
+		}
+	}
+
+	ret = KSFT_PASS;
+
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
+static int test_zswap_writeback_enabled(const char *root)
+{
+	return test_zswap_writeback(root, true);
+}
+
+static int test_zswap_writeback_disabled(const char *root)
+{
+	return test_zswap_writeback(root, false);
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should affect only the zswapped pages of that
@@ -425,6 +506,8 @@ struct zswap_test {
 	T(test_zswap_usage),
 	T(test_swapin_nozswap),
 	T(test_zswapin),
+	T(test_zswap_writeback_enabled),
+	T(test_zswap_writeback_disabled),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 };
-- 
2.43.0


