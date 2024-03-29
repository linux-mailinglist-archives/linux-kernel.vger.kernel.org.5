Return-Path: <linux-kernel+bounces-124528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEA9891962
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2951F2160B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625DF139578;
	Fri, 29 Mar 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZl23VhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C7146D74;
	Fri, 29 Mar 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715313; cv=none; b=n3UPaiF7fsb9b+i6fnSpp7QjoDjnL/kpwGJPNVLf4piVzKFTssDnaEI84xP9gTJvEWk8W4gQeL+E5usW0rlwxXdRYrR+R3JCxlFH1ictpX4igyhTzYF+WiE4Z6g2tXv+pAeiBzk7utQ0RwFf3WV0gH+W0BlYf2P+6N/ajJfoeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715313; c=relaxed/simple;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEJtRoC48SXf+eFMsa2PElKx6iXXRcnA8JbXvqps0gMHJLV9FvHyVY5ScYkG07moAz/5wFvrDBv7zBcn3WbgjnskU9dS1Q+cztiAUJsn3PsngF1CWTTqhwYnZP7kf3r2GpQdJqpqwfkepU6gIZnInVkw/Ciu6pmhckDKEW1dkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZl23VhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BDFC433C7;
	Fri, 29 Mar 2024 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715313;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZl23VhPQEpFnzjuEmHL4PBju5IYlfeIcexHU77ZvHY9Vquz/Emv6mxsMn/tg0TRA
	 FKtwCejpI46dORWI9s6Zmj3cXW1XXV1mRHd5axIFzUm0aOkj8g0aciadoR+02wLmsl
	 DCOMGQZeEnUWfgT16RFiYfLO3QcR19SaigWYyiOgJKuVcI4bDzILKxjZEKAGbw61l/
	 mXxk4OT7nontkkQizLmPRTF+BmeR9lAp/WR4KhQnUdrSbqLrbPQKq/p9yhn3g612Pu
	 5w/azMzxHeGXwGjfCufbb29xtspJNEUGXMS1ysF7LmVQrPUQf+W547VGljZw5xu4qN
	 FAdxK4nRuTS3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 47/68] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:25:43 -0400
Message-ID: <20240329122652.3082296-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


