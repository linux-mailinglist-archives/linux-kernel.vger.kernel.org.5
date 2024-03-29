Return-Path: <linux-kernel+bounces-124669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49AA891B33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CE51C26407
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62E16F853;
	Fri, 29 Mar 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbpqi4I4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373B16F831;
	Fri, 29 Mar 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715663; cv=none; b=kNKmYBAWZq5iGtySsAehOZPTkQF8byXhMB0QP1GAZOQBuEKh7OVki7ubSqrhdRUdD0JWZUkTp6OJjaB5574eLrMogeZdVUNI/vrAnZ/5UX8Kgd8SXFGkej5KY0CvK0njSGrVdXKaaGC3wNi3HbMI/oDVRxNVCgTa3Dcg1YcYsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715663; c=relaxed/simple;
	bh=XkMSNJUMOTJuZGUL+5hhs5kGZDVM5ajOrVYbFeTufcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBStQCbUFhFUE30VEDJVfQPJTB0cfT/8lHYuK71vNKnhijpeUtsnS9BUXfNyT8oj8PFv8tHOTQcMg2itKKpyCrt7AggU+pLoSNCF6PnufC70+JuLAv5uTHAwLYjsZdBZh9UnWqZ0DUbo6y0bRdgsIk0tnOrYyq/7NDJ9d9Cxzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbpqi4I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7CFC43390;
	Fri, 29 Mar 2024 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715663;
	bh=XkMSNJUMOTJuZGUL+5hhs5kGZDVM5ajOrVYbFeTufcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbpqi4I4IJZ0aCm+LD33d3QA8id/PZprlL1PBuwx4VWIeX4AVjZ1xgh2RuiKQOTx6
	 YTzWOoSGBklIKjpv+XW2Zx+4yt52duLMGwtKxhxMlzbA1cYfC1FvuHOi4ZNH9ueSFw
	 iQpnzIBHLtFTGCfKUp/wmeeh1ZxLemqgTrSsehyQ2Lg0F623paPPh7je5KG4Z57Zn5
	 OArjdzpADBT8rfhVays9y9Gm3rT3XuX28AbTTe1HgLkHiBk/3oETp14Sc6CymiLKxM
	 NuUcmBVwodHUQdtRT90NGrsUidCJCtMXRwfqQTLTrKQ96f64EThzUp5gEt8lyceO1m
	 TvWB1iZAkFDmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/17] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:33:48 -0400
Message-ID: <20240329123405.3086155-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index b50fc33f2ab29..2426fb6794fd3 100644
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


