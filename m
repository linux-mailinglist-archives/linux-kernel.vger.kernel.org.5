Return-Path: <linux-kernel+bounces-115416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E1889B79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5778C2A1FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A585C206C94;
	Mon, 25 Mar 2024 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7q/mr5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FF82D82;
	Sun, 24 Mar 2024 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320595; cv=none; b=MJ9uwvQXqb622/JvR676ZPQ8gG/6flSFfjh5DaSjnBjdDLHb0O8j8aHBly5gCAzXMWyHoxiPDpNZoY/lzggPydtsgoWQ32FxoHxhe4FHNRz1QnMk4BoE2JIkU0aogqqPnzaTDBpFfCqWnHqRSwlz/PNpCijcRvTV88lZ/c08z+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320595; c=relaxed/simple;
	bh=IGAPQ3cc2+PmQMYuwOXJr7pg+IhtAnoe76s99Qn4AZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFBZFW0Ut5yG8tb0nwm3XRRqbg8//3kHhJzCfaBWLoTlW1/c5+Q40Q/HBKZNSrpa9K1dg+T+5CobTlIlxVN9UwTfpIf1BAsQnIDofIPIpcJvkAUenAUQRLuhJWsoHnVUvp1zWA5YvDfxJmioNBtOrwGHTJsSAVg75OEyqh9na/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7q/mr5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5430AC43601;
	Sun, 24 Mar 2024 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320595;
	bh=IGAPQ3cc2+PmQMYuwOXJr7pg+IhtAnoe76s99Qn4AZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7q/mr5mz+DquukSdEC4r4Yrdj9UUr0Z2/zTW+8wYj75QSJRjVh6JfPKt32r/nTPv
	 na2qg/uENWGIjfmmNzL0743od9XeVFlf1Jo+PvWeOUEiX3x/fesYFmp9O93eNANIzW
	 UzZ8wJ8RKpnsnBa4EUQeplQ3+xslg/Cwa52XKp/RTo8G1hpBe02RWmNcYXRQ6RtS9M
	 SEgvZe636vhlFncHvmunIizaAfvgTmire9fqZ7kkomEn1hVWc562rLEGhFBWRFccou
	 X7UIvxvX58xeAPVXrRteH3H7FdS+Ouu/9ba8aUBM7Iateqltt9Jwjj9QrZrSHUxz2R
	 /4yZ4e2RwVHnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Grafin <conquistador@yandex-team.ru>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 156/713] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Sun, 24 Mar 2024 18:38:02 -0400
Message-ID: <20240324224720.1345309-157-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit f04deb90e516e8e48bf8693397529bc942a9e80b ]

This patch allows to auto create BPF_MAP_TYPE_ARRAY_OF_MAPS and
BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY
by bpf_object__load().

Previous behaviour created a zero filled btf_map_def for inner maps and
tried to use it for a map creation but the linux kernel forbids to create
a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.

Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20240117130619.9403-1-conquistador@yandex-team.ru
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index df1b550f7460a..ca83af916ccb0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -70,6 +70,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
@@ -5214,6 +5215,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
 	if (bpf_map_type__is_map_in_map(def->type)) {
 		if (map->inner_map) {
+			err = map_set_def_max_entries(map->inner_map);
+			if (err)
+				return err;
 			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
 				pr_warn("map '%s': failed to create inner map: %d\n",
-- 
2.43.0


