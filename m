Return-Path: <linux-kernel+bounces-124953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA3891E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8E28763D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE118646;
	Fri, 29 Mar 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/K8zeYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1D16C87A;
	Fri, 29 Mar 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716501; cv=none; b=n9L7SelBlDyUoAY2q2vfoebr7SNyzExW3bc2WR/kX2ZEZBnPdWy4eSQOOVzHdgkbBAPY1q5nULPLdCqKYNrB3toCMrNifAxP8sJFcEHWGFH6nFjaBvvqRtxhCMZHllHbl+Cpb/YyWpHohg18+GMiTHSUR4lOEKd8CDAV39DPTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716501; c=relaxed/simple;
	bh=atLbCrAFF/AvlcWQ0EJKEUSz3x7UDvnUlEl5LvVKMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odiGr9WowVavccBWXpj8+W1Ta/Lu66VWwjjOX3/fp9XsxyLnuZaOKDLfaZTl520bZTI3JoRSJTO+cJt2/r5uA9aDfduQRxGvyZiU3LLqkF3Rw7YwOD/7ZXaL9hyT7cyO7cE8U0LNC0NKFEE44X+LSVBKF9kw5NP4voh2brR1PAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/K8zeYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FF0C433A6;
	Fri, 29 Mar 2024 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716501;
	bh=atLbCrAFF/AvlcWQ0EJKEUSz3x7UDvnUlEl5LvVKMzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/K8zeYF8/87DWCtPI7vLQElY0LhGeHfQkHlnr/4A5PBFqc+7g0Oe1OyQgEFDzqHu
	 hoxUq28SU0nDcgqpBzCRwNgD2PS7esZnmQZKFGitPug566oGjiCbNIfJXQc22lu3uL
	 9GjXxhpbRXRMyZBhmPwQ/TX/rkkzRtLYl5eLWYUQvHDVLCagK2amYaNp6zDrnuZ5Oe
	 gCGbiTsSEBUBAL2P0d7m7mCRSq9c2zfA7mszcqJOJFTy+t14SyPHNEqLkdhX8MR5GV
	 0is2za82/h8LtgWnon0EPmG3b3cJwdfkE2OhZOIbcLh4E9Eg7TxsgVzBIo3n7/L9nX
	 Pyc1O2Wv/KXJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/34] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:47:18 -0400
Message-ID: <20240329124750.3092394-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 5d3f944f60185..295040c249d91 100644
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


