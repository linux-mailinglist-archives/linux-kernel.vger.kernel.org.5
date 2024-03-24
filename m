Return-Path: <linux-kernel+bounces-115620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FD8896F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2FC1F35E36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4280254076;
	Mon, 25 Mar 2024 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePp24iTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C601E7DF7;
	Sun, 24 Mar 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321414; cv=none; b=Pn8fEqIOOHLjeiBkTa3y2sdaJRMXsVL3pn2PVuvv5K/iWM8KhgMkcJoDCN0wbRGh0CRtSSUwVCfcCP7VB0wp1g9ypZOwtPLDybn6OkusbVw1nowE//xz0YI/XFSaoHVi2Uh1PXdFKyme6rnU2GwcI+z0HO3T2VvTXCHnw1Yb1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321414; c=relaxed/simple;
	bh=PlfCxDYpw0F+l+BRPeezDpLk0I8AsZhrEJWzjT0IJjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmsiJP5+5b7wSMSMnxsXrqzTASmGESLFR6fG14iPKffbhnEUmRFUTNFPYIIVm9yln4A2OewR4F84AbUN5WzLpRkzzKGDEagNhkUiXc9s18lnZF0uXvYhNyxU48I1QYnmvn801imEw8kY1YVSf6v5jEJFHfvJuNoC+wEnu7f10mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePp24iTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D523C433C7;
	Sun, 24 Mar 2024 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321414;
	bh=PlfCxDYpw0F+l+BRPeezDpLk0I8AsZhrEJWzjT0IJjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePp24iTwAn1lu2nyxvyqc3NK+NgqNYmGmwtnMeRDINeF7Rkv3M6peqc5lyt8orakd
	 8uXdaMFIKE2AS5bDybydsHmpvWJ18/vIafxE3tBdMsjP/y71WmpdsyIPPztm1mKOUK
	 dP5ypE/MM2PVv3/bWFvkqX8gfLJt7d57oE9L4jIb/R713GnbWkvb0YNjMftDCdaRpK
	 FUFxDfFD1UuSFeS952pZle5IEMVsrmFCekwyE8/c/cEuN9B+XXcXDyM8vsl39yfO5u
	 W8DEgdvyBxle4k98dwIoln7PuuC3J+DZba1L2oTHosuo1UFNKxA/g+Dbw0N/8MWFn1
	 I6xJOkywbIpcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Grafin <conquistador@yandex-team.ru>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 138/638] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Sun, 24 Mar 2024 18:52:55 -0400
Message-ID: <20240324230116.1348576-139-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index de08b920a149d..e238e6b824393 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -70,6 +70,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
@@ -5121,6 +5122,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
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


