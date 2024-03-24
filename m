Return-Path: <linux-kernel+bounces-115830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FB388982B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED67B1F22B35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27879378C4C;
	Mon, 25 Mar 2024 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLnqT+wi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D16145B2C;
	Sun, 24 Mar 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322030; cv=none; b=CAGJUhx1lW9seO8ElDdy9jYyXE+AbEi0KoHQm5pFHuje0ULSKCdtCVnwWOZnrSRhE7/IGHdOQ7PZJmeqq0wQTjmeNUkROc24MjXZAtnpCbPXnYatEgxTRjMQc55E7taNRQ8OKh6WG0m3BxYabO59AlpvZJvYzfbfWxay3TejhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322030; c=relaxed/simple;
	bh=NyPwPnV3tRxSLBf5Rdd6hqsddZMu5hwDMK4gpLucHkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzwSNcq+mcimaE/cqQ+ypzegLrm46fYiT4dSdFP74U+naeqzzOjwP4u6O7l+U5Y1416tfi0G2BT8R/tiuHKp/FP7T8aB07hk4WDDig88OVyu4j3z1qkauy548B2jR274HhbN+PFVwIGtATWprjZ46JtIcToRFE4+ZPy8Rn9nGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLnqT+wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5CEC43399;
	Sun, 24 Mar 2024 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322029;
	bh=NyPwPnV3tRxSLBf5Rdd6hqsddZMu5hwDMK4gpLucHkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLnqT+wiakqp20JWwBgP2sUi+4fUAWkx/LY0Uj/XZRc8tL21+q49VdyAhuxwknoGc
	 efFjKsQr3LVYe6L19xcvlzX25q/T97Z66/4NDpTU0Skoqbux/vkhX1iDqLnbF9drmk
	 Hk0ALvWIpmgURBPVYQZ1sQ8W9/RK0epE/mlyVwVozBoGzMqRzumc5Ma57TzBFQOcpu
	 eruUgC8rSzwthbd0vDBHr3No0IE5lMBPOVjVrT41BN2DepH9I2S6IXIdqsLRHZdhjI
	 eunVZzksOuaUw1cYJjVJ+E8Kx06MyQd87u+g839HnzdhG5OR3YsE+kmbaWw1SHuk2U
	 0oemXCs2VhO0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Grafin <conquistador@yandex-team.ru>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 101/451] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Sun, 24 Mar 2024 19:06:17 -0400
Message-ID: <20240324231207.1351418-102-sashal@kernel.org>
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
index e2014b1250ea2..c71d4d0f5c6f3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -70,6 +70,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
@@ -4992,6 +4993,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
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


