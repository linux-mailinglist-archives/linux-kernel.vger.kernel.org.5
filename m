Return-Path: <linux-kernel+bounces-124909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0D891E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE50B2D3E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699AD29D3AA;
	Fri, 29 Mar 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJw5rFhb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EA29D398;
	Fri, 29 Mar 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716412; cv=none; b=WaDrt+UN58z0fa3g4Td6k2+MDN1Ko8dydKYqBoo+KHkicMbHI+9O41HCzBRIdNwWONJJiHoXpbaeoBc+z3M1HyVMbBBqJ9wFaPFwI954fFKXNuZdmabvA8NLbIQuus6S3Zm9GmsxljuL3Pse3yIepG4thRC5uX+SEO1vJeEkf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716412; c=relaxed/simple;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejyOarLIoEzi/h0F/bpfqRo4IJjVo1wRpKqzzzpK0SrdIWI5bRbeNUyn5sxZoI1zt0mqcjM92YY3IGnbLlMV63Wzg44pI8dy9kPLSUtqRmgwGD21S21M6XNKIY+UtaqDGCmojcOxa0spmyL0SL3BEmLS5QmGgpngz7V6aSodu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJw5rFhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631A9C433B1;
	Fri, 29 Mar 2024 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716412;
	bh=tPEViQjo1qr7FojiB4E3SuTTfzc9SXQ7WNdOd9cbvoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJw5rFhbh9Ucm8SMOvpvnc9dN5ggPWhsodYtPbKtahGDKrqYLgV1hAhGaStPljgwK
	 20tzKKu7yiCKtrKxtEtPUhG7pfH7RyICt2jXG+Q1jXfsyfiIPZeap9ms56VVnch3wu
	 /TqhMARIkR8Q0O79tFUc/3b/WpJRSIOue4tJmh6x2RW2voyygV5c5UQNy3Q0tgVpgq
	 GZ2KdNleIOGd6y6s8d49Sl3Uptaw7+YQrrf0Rlk2OSnZs2J2mq6YWbnMo0q9iMrmCc
	 ySuBX6BmVw0xKSN4qBwzAZANRgHRn0ZHYlQPlcsPs2T55imD0Q3rSEVPVEmdwNdWvI
	 E/j1HoHbKPeMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 25/52] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:45:19 -0400
Message-ID: <20240329124605.3091273-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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


