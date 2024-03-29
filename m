Return-Path: <linux-kernel+bounces-124764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7EE891C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335F41F22C73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8068181323;
	Fri, 29 Mar 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbJdQhVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D464181338;
	Fri, 29 Mar 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716103; cv=none; b=fu60G3LB/dgCDwggaL+pn7wgk4j9oOSoccpYmleWcUjSiQKuSsXyETPg7Hk6CSTyfsbE4JaTM0ycIYcQMMOeXGYoBAcCxXSbgnjqQiYzfcK73J3JlkKkpt6NA/jCLkLdKZWxqjLZaJLEcjB0tqGDpmTrfN7wt5E8sXe+rzPxRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716103; c=relaxed/simple;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTqxU3T53mW+J8SnNRxgHWJwpEVkFFCTvNnT3rRV8RYsZUI7Vk9eyLX5JgRKFewkvN+EvdKFGT8DJ1HJG6YhR5vS4EMrP46WkKQvoc+BDkXj17dejRJSIifCQnaglxzGxOpKSZEfQ+gny3dtf7unkF15vckJ70B9wuDiAWdaYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbJdQhVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397B5C43399;
	Fri, 29 Mar 2024 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716102;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbJdQhVKoCwSoDC2GrvNs2ukVT1NQ6SkXgVnY5RGzE/yMmyLlordTj9oWiKiyZS1G
	 PKQ6bUeICyzINAhG7dUvWgPN2bhTCaKqarDxUuBRixhIA/ubMAeWtHuojZLUXra9fk
	 dnGYXUk3pEtjUxVrgUu3GMDHGljYy6bBtq/StKuaC5GHgTwW4DfBS5P/uRSM4LJtPG
	 Y92FlGUrudb195X6oAVDL64CA4Z/wans0AYbfNtPRq9SKJ2HJmAjuV0YzmqBQtuqtQ
	 B1azTWoWqtDDe1NoR8w0lubyeKro/tJxcGqdf3+3WOKDlEOCpHCy1tRCCTRXYnzcuT
	 DtXMR7DbZBjvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 55/98] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:37:26 -0400
Message-ID: <20240329123919.3087149-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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


