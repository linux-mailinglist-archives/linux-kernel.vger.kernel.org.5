Return-Path: <linux-kernel+bounces-114771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BF889120
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874E529458C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A131B2506;
	Mon, 25 Mar 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiq+nQpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9E175558;
	Sun, 24 Mar 2024 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323369; cv=none; b=QOILzMI8mW/m2aP2svkkChgYLNhpSsKUNDUe/on7llGbb8SGnmWUhpLALw5DlEEIXC3mRgdovOVtm5tdCjkvXp3xWF8W2D1Ns5+T3JgvIKMu0w7C3iTJ3J1XEv57jC88UhR/rd2ql1gmvyXKCgglQuEdsEpL1HVm4JVbEKoWPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323369; c=relaxed/simple;
	bh=PyzAdGm1hzptCH7EM8IRzrHYBDnoj+9zKSyU1/zY8GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdWnfY/RKoMzKkkuY4raakRivw3q4S2pq+6ljozhj5KjmqTw6W5MBAFFEB1kXU4L47UmnhYbLcDlxgPDWboPNrFRLtqZ8vSAry5H1NN+tVZALUinoauqkYi8p3XkRWs9lV0UO4IWDT+gzTJ9No36OMnNxgXSkmD+GGvXheWfq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiq+nQpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B256C433A6;
	Sun, 24 Mar 2024 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323369;
	bh=PyzAdGm1hzptCH7EM8IRzrHYBDnoj+9zKSyU1/zY8GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiq+nQpI84FafKxd73o+e8DQ7QHF1W4y0FPGhnaq+FBGYAC3i4fpSxdW0HR6R37iC
	 xNeXP70atnOyLiRQscn6+LRGwdm7R5IJzAfkeOS0pduDoc1WI1+oaLDFD2DpC/xjrv
	 xg0s5oTLi9ZTAlfSP0xqUaAkFkVj07As42R0FirgtvI2gY+iawo9hirFLaauObkaAj
	 q4BbSSaRyiuE2GFYVzwRUstb8Xb+9p/hvK7RQroGAB3Dqphb2wpalM4ULotYnaK28v
	 hzyewbpKsHB5ghkppC+txkeTOoZTyQQg8+FIT3Y9K8pB6MFjOC2WNGfwiReSJJYfZK
	 t9A3tom55H7Zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Grafin <conquistador@yandex-team.ru>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 068/317] selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY values
Date: Sun, 24 Mar 2024 19:30:48 -0400
Message-ID: <20240324233458.1352854-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 5f0e0bfc151e5..8a52bc56568d6 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -23,6 +23,32 @@ struct {
 	__uint(value_size, sizeof(__u32));
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
index c7a36a9378f8c..a72cc78706eaf 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1196,7 +1196,11 @@ static void test_map_in_map(void)
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


