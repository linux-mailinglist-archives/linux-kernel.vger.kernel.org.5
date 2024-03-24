Return-Path: <linux-kernel+bounces-114770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247288911A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3E02931E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86611B24E1;
	Mon, 25 Mar 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh17ZVGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF85175552;
	Sun, 24 Mar 2024 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323369; cv=none; b=Op9z7og8HHlSyrE3USA7R4ZIUkicmjUT/BLL2F+k5MxRwB54i/dp/nHvm0bJ9QOzhYPk2f8vHweCWIjel4w04HrmHSdGQhphFNr2jyz+ui2/h/OZrnmV1PzzBqvXX0HEsyOms0fP350kAxVkms6IlDw7jues4T0lI39C3A+8UEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323369; c=relaxed/simple;
	bh=LJkbQ5Qh4PeIsNFxt7AK6SdngL2bBEqJKWrdeSQHzVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu1NmI+KAJQCIzeuouYicoO4qVD0LqkFJjmaPRGbPu2JLUanL82JyED/IcGGGMMD2rjz5jv105aJ9SGIy3IkVEwJ1ouqhN6HtPM2Bapq7flsd6ys8mfMJ2jc+DVxiWxR0KxZpouZJPKCMi05SnFgW6gMWX2CDvTldGIrD8j87KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh17ZVGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E416EC433F1;
	Sun, 24 Mar 2024 23:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323367;
	bh=LJkbQ5Qh4PeIsNFxt7AK6SdngL2bBEqJKWrdeSQHzVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wh17ZVGNnnLuK/kZwYJRtDMdChPOM37CJwkiu+f7t+hrdTOkpxK1AVerHhbfqkhbL
	 tTOPGmV363pqTr1xqY2wzOPeDqNfvAmRIy9uM1B5ErAJ7CKj7xeBlLePEI0/6+S/yp
	 w/UG9ktRbpJr8MyG+WMKHV+Ht39ubMHvjFm8WEnj+KB4WyLQLrNFVTUZJ5I1JkUIsK
	 v0VHvmwAVdDyZ1pP98JPLXdyO4uaVb6nBviqRTkaRTX0ICnDFXeS7nOo8wSmCYpGys
	 Xy2DBdZOWAzhGS7mNqc9DibakW9+1YqMua7Jfgl/eZrQbybJetS66tsEj6CvqVF0Zo
	 wFKm5sTFn+aCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Grafin <conquistador@yandex-team.ru>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 067/317] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Sun, 24 Mar 2024 19:30:47 -0400
Message-ID: <20240324233458.1352854-68-sashal@kernel.org>
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
index 0c201f07d8aef..e45f831a12c2b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -71,6 +71,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static int __base_pr(enum libbpf_print_level level, const char *format,
 		     va_list args)
@@ -4617,6 +4618,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
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


