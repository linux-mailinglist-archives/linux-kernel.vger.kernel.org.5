Return-Path: <linux-kernel+bounces-112972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64088802C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C233FB21E79
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C412AAD5;
	Sun, 24 Mar 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lInKEKmH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4312AAC1;
	Sun, 24 Mar 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319785; cv=none; b=O86Jn7EA5L3PQlxxTxEZDnzekNGD+/It3PXn/P19lZYIjgqrkCLEwulru048MNVUqzXbnOi3aGKu3Kdy5CXeNeUUl5zxM0MTCg8cavlo8tj0xk5mjXGxwXzaAcntnrUpFK+J8tJoiT8Nfxjtk6AZGSLxQNbfmOpLuwCOmaj4jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319785; c=relaxed/simple;
	bh=pX8VyodF2yR/udKJM+Zj5vWSK6HknsYK0yLQhEYqcg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh+sAbm8y1TzI3DHyqmtKA5ln2wkpRD+2nH8BEPbI4WtHf2R8Uu3eT9HSAeDHVwwOnDUObMJCKK0CFVEiTkEzGvCRrFDwLRe2N4udQDSJoHpfX1Cu5OxugOoj/y1WLkIy3f4MSyrNydq2K8dfJwd8Bt1RCHzsL8SPBgRn9yF+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lInKEKmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9022BC433C7;
	Sun, 24 Mar 2024 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319784;
	bh=pX8VyodF2yR/udKJM+Zj5vWSK6HknsYK0yLQhEYqcg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lInKEKmHwKX2XYr9JZ5DgYJYojgRSN9VwWEFN+RzsvGKeMNW+nWn3TKQqoZSzRt4Y
	 KKHpRRvwQTQyqzsM3rL9MV9HbVLIoUmWmOdvCGans7QkGNw9dbep/HoDIkVXO6HVQX
	 3ITKdgD6PR2LPlUl6BL2eT7MCVf49bTueVVPQBGrKG8wznLB4+DxwIuyGlnmMqrhWI
	 t8+72MBDWpsCI9lKfmBDQY52Rj93p0yaVsjDSXpVoKE9ucoWgxyNGVG6Mvyri+A29B
	 7QX+iP4P85JT3uglFOocvMJBeeHKPn1Y4ydqIiVBdMy14JDZBober+1Ctd9E3r91KM
	 rMkJhCDPQkKVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Grafin <conquistador@yandex-team.ru>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 085/715] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Sun, 24 Mar 2024 18:24:24 -0400
Message-ID: <20240324223455.1342824-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index afd09571c482b..b8b00da629071 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -70,6 +70,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
@@ -5172,6 +5173,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
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


