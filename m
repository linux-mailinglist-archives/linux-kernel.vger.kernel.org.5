Return-Path: <linux-kernel+bounces-115832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEF5889830
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACB429CD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EB16E88B;
	Mon, 25 Mar 2024 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/p5tFJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA2145B2D;
	Sun, 24 Mar 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322032; cv=none; b=E3bpMJWatDF9wcVvBLYR9F3QpeYtdyCCSBRyxzmRqGju6K2tu2lG5RTSAnh8Y8gZoXoyWbWjZSvtt7T+vxvVnwfvdDs+RMXtyNfjPtMohUpohC9T6foMiRcFlUF/UtFnczrebQyHs9I+eaD5GNyGPq8CjnXXALXr8cgs2HU+gMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322032; c=relaxed/simple;
	bh=WWgtDIV9J28S4Sbj8l/mMebPZPCkN9iMzwE5lhXBPpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRI+D3MVBHW6LRvZNSQK4Jcn3wB8LTLRJxrHZtJC/JYWVFrXpMQaSzu4PO4OLqIu1LqEp20jc6TsNaCH/TLnRIMjTDOXoK/zn0TJepIdESsWRka/ewSomh8JpD+0+hb2uNpQcla2I/Rs6dFxQyQu9zT655hJNcubXbbW4tFVViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/p5tFJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC771C433A6;
	Sun, 24 Mar 2024 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322030;
	bh=WWgtDIV9J28S4Sbj8l/mMebPZPCkN9iMzwE5lhXBPpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/p5tFJ4hUsg5T+suIIvlOIJMzIXhd7HpUo2aeKPzLsNX8t7Bazs13glEhEZiIQnn
	 MVGL19IrV3byaXZ0q+3VExUkcrrFoUPEe9VHFQKoWJRrsFN5ysvBIs/LnsnOk4izM8
	 G1nkhoeCCg6dh/5eK+B8S/yrtxCz55byhdKuKjvXZSFoe404hPDuCZ6WHsQ8Dza0Oz
	 ZhJ2GQw8zKOOc8gS74GJEJOyKoeP7NDho8OTwTr2nr7wJCeQKinLmEjDieLtCwB7W5
	 gcJzSUvQGq3Ykb4MEdSpgdFk81M7v15JVRa3p5AgtZMFM+NJrDO/1swEVDeW3rTj0Y
	 oxFI/X9i7WhRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Grafin <conquistador@yandex-team.ru>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 102/451] selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY values
Date: Sun, 24 Mar 2024 19:06:18 -0400
Message-ID: <20240324231207.1351418-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrey Grafin <conquistador@yandex-team.ru>

[ Upstream commit 40628f9fff73adecac77a9aa390f8016724cad99 ]

Check that bpf_object__load() successfully creates map_in_maps
with BPF_MAP_TYPE_PERF_EVENT_ARRAY values.
These changes cover fix in the previous patch
"libbpf: Apply map_set_def_max_entries() for inner_maps on creation".

A command line output is:
- w/o fix
$ sudo ./test_maps
libbpf: map 'mim_array_pe': failed to create inner map: -22
libbpf: map 'mim_array_pe': failed to create: Invalid argument(-22)
libbpf: failed to load object './test_map_in_map.bpf.o'
Failed to load test prog

- with fix
$ sudo ./test_maps
..
test_maps: OK, 0 SKIPPED

Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20240117130619.9403-2-conquistador@yandex-team.ru
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/progs/test_map_in_map.c     | 26 +++++++++++++++++++
 tools/testing/selftests/bpf/test_maps.c       |  6 ++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
index f416032ba858b..b295f9b721bf8 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -21,6 +21,32 @@ struct {
 	__type(value, __u32);
 } mim_hash SEC(".maps");
 
+/* The following three maps are used to test
+ * perf_event_array map can be an inner
+ * map of hash/array_of_maps.
+ */
+struct perf_event_array {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+} inner_map0 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_array_pe SEC(".maps") = {
+	.values = {&inner_map0}};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_hash_pe SEC(".maps") = {
+	.values = {&inner_map0}};
+
 SEC("xdp")
 int xdp_mimtest0(struct xdp_md *ctx)
 {
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index b73152822aa28..81cd48cc80c23 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1190,7 +1190,11 @@ static void test_map_in_map(void)
 		goto out_map_in_map;
 	}
 
-	bpf_object__load(obj);
+	err = bpf_object__load(obj);
+	if (err) {
+		printf("Failed to load test prog\n");
+		goto out_map_in_map;
+	}
 
 	map = bpf_object__find_map_by_name(obj, "mim_array");
 	if (!map) {
-- 
2.43.0


