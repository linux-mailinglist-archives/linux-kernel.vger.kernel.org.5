Return-Path: <linux-kernel+bounces-112974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77152888030
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3223228163B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35312B144;
	Sun, 24 Mar 2024 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV+wVb20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4112AAEC;
	Sun, 24 Mar 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319787; cv=none; b=pnenMjdJ6dJQSA579XlvnLTl5TuYbCzSFRko6/0kriwurC8YTaqoy4LRIm5623yT7f79YmAysM6OIqAFBXxyezWGi9DyK89W/AoF8E40Arv40FnT/bAVkXgScrMvX58MJE+acpxYshSu+hyj8BslZEn1X4BqPSqeggiailzss30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319787; c=relaxed/simple;
	bh=PCOZYknRcewXzsIhOF0XD8bL6rrqEfRfHwALBDHzhnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Esgp3egYLRfZGOSOUK3YYc71dPC2wHzTTTT0VUXAOrBlvaNp235bKd+dgSWT2xXlpszka583SUVTEDJtbkzgkQcMokM9+QRjolXoftiWFZtTeP9zOzKMQbhGOGhka7GGNS7P1BqDcqk82N41SO4ZFq1YoaxUGUotdr9WtiW8mPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV+wVb20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB22C433C7;
	Sun, 24 Mar 2024 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319786;
	bh=PCOZYknRcewXzsIhOF0XD8bL6rrqEfRfHwALBDHzhnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VV+wVb20TPm9k7eW4yNETVN8/EVXnwkrJT90sL9Ugis0ahvYQ1Y1qlh0JgdgZm6N8
	 5SfljofD0UursDmS/5YLT5hm9A4lN2diKRrTDXVRS7kKbIlJBBaQAMg3sT+Twww8vT
	 tTDXRE305GxCXKlNDuY3t+vAqfxIMdX0TnKf9MTU42IBW5D+dcH2U/3yp00sGwjgpd
	 oNtBPxRllmOnr19TTYTi+L3ekGDtopXX0frZBK1AZdizYs3UKota0FB7oKawo/oPx8
	 +JpWwdkdN4C9GoB+366oO39Gglt+RVJLAEN5l465Zo3ZVLODw9cwHKV9i14gYoSw/J
	 6r2z72+BfF4mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 087/715] bpftool: Fix wrong free call in do_show_link
Date: Sun, 24 Mar 2024 18:24:26 -0400
Message-ID: <20240324223455.1342824-88-sashal@kernel.org>
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

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 2adb2e0fcdf3c6d8e28a5a9c33e458e1037ae5ad ]

The error path frees wrong array, it should be ref_ctr_offsets.

Acked-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Fixes: a7795698f8b6 ("bpftool: Add support to display uprobe_multi links")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240119110505.400573-4-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index cb46667a6b2e7..35b6859dd7c3d 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -977,7 +977,7 @@ static int do_show_link(int fd)
 			cookies = calloc(count, sizeof(__u64));
 			if (!cookies) {
 				p_err("mem alloc failed");
-				free(cookies);
+				free(ref_ctr_offsets);
 				free(offsets);
 				close(fd);
 				return -ENOMEM;
-- 
2.43.0


