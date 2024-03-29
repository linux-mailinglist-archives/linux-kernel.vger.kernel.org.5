Return-Path: <linux-kernel+bounces-124584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B005C891A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB292857C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F81156F35;
	Fri, 29 Mar 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVEZsVTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A1156C7F;
	Fri, 29 Mar 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715469; cv=none; b=uVOqcVQkbs8cFzMSD3sKJAPdojsDfNuHkp6/BMF8WoOrshYyrzH75OkSDQh/CdpscrP1vUNu2mAOxw9ye0GyzBunn5s6lHZz0FY6x5ATXaGRSu3g7ivBiWn5Pq7HD3TODJt+E7PbKw5by/YFY5s8wvMS9xBDfN1BvyY3nD8RYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715469; c=relaxed/simple;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqdEHEr/lPNHJCfN+g2jeY740L8qf3TMAiBv8ao4TYkSHpEYI0yrM5eF06/wedEmiYBA+0AW8xgjC4f04OBelQ4O+m+B24Y/lT9TyvPcenaDUuD3QMXXYaiVPyz8W+f42BmIPHXA8dW95r4nPev7BQvzgWgLQcX1Q8O+LjkzCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVEZsVTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D778DC43399;
	Fri, 29 Mar 2024 12:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715468;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVEZsVTUP/RPIkAR5NE+qQUHbnJTNECn69qJbe6dFxitCyvpt/cjNJ5dCIlyuqmHf
	 nWknBUO/+kMuTXgBi4OG5G6aPLbSw0IchikK2aO7p33FVmmTz49b214jzPF0MXoR7C
	 6TxzQUTmD2DsarqIkWSg/I+ikiniWBlho3kqRe9e+Wl3Mhc1cKlbBJmZ3PQ6qb+CHk
	 hBNg/LkNMT0ckRl2+oHBgfE26YSPVBxUDH7Yj1gmiRvRCAIbNpL975dDfeuNgGrvy4
	 +Fa5rP2dq6QH6gKb3Qd38bxDqsnhSasovVEMj/6R3NUWcK+0nMLksqq8UEI6zEgCm6
	 I20xOzWaVR//Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/52] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:29:03 -0400
Message-ID: <20240329122956.3083859-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 98bc7e26e14fbb26a6abf97603d59532475e97f8 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118100206.213928-1-chentao@kylinos.cn
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 2770746bb7aa1..abca117725c81 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -973,6 +973,8 @@ static ssize_t psz_kmsg_read(struct pstore_zone *zone,
 		char *buf = kasprintf(GFP_KERNEL, "%s: Total %d times\n",
 				      kmsg_dump_reason_str(record->reason),
 				      record->count);
+		if (!buf)
+			return -ENOMEM;
 		hlen = strlen(buf);
 		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
 		if (!record->buf) {
-- 
2.43.0


