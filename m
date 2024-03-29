Return-Path: <linux-kernel+bounces-124985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2689208F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97EC7B329F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D601AF580;
	Fri, 29 Mar 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNKM/4CE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA681AF56A;
	Fri, 29 Mar 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716570; cv=none; b=qGS/hfFGc+iOkxuBSVXW0+2Bsxo2KO2yY397vWsmxc7mgLNIooGdlzFwyMej1Hkv1hr50wy55Ed7XHO/IAyn/jiS6MyV2h0w6OVNNjyu8v2RtkJ6gSr6DCjNJNG+3rFh0UuXjiT9QlB8Mix+v3pe+PEV+xRFvj88doVNORFuyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716570; c=relaxed/simple;
	bh=XkMSNJUMOTJuZGUL+5hhs5kGZDVM5ajOrVYbFeTufcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZylrkuLmAMvSucv4eAx3VA9e7nfnTR0jma4OtFXWzA9cfSEeCdFPm8NLKzUD9Of2fH4A4Jdsi5WSVd812cfAfK0gJ2rZaog8z9XMEyE5rV7H/iAH1jatRkJMNXQ1PSJLgBSeCg4r478BqPdj5LncjSJA9SQxHTHeDXxW3htBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNKM/4CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73855C433A6;
	Fri, 29 Mar 2024 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716570;
	bh=XkMSNJUMOTJuZGUL+5hhs5kGZDVM5ajOrVYbFeTufcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNKM/4CETzdyb4N/wD2qd7NjiO4MTkvhZOhh/UGvfYlOKGU2TnpzaCnkssR8Uqk2p
	 N0/JB4fyrnrDpplhVfoA/9C3WRVLvsU2OCIl81rghh0uVRlixDjD/GoHXvq0JSEAnn
	 ZJsZY7FFrsDMTj86Mj7syoiKdeNUMH2gafWVsMcNAKkq9gD548guK9QCp++p2EXg1j
	 Ki9WCA0VEdJp8vhqTvhjtGnFjO8lh/2iVA6ftEFe4yGNqKcEW5VlYTxK9oiT/G4n2j
	 nJe+/iQcrJw+5kH9bmeFf0K0bctCAaFEUhRBMf1Uw3ZTqkXCiimoETk35OIKYQky2Y
	 ra4zANJ5FiR3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 15/31] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:48:32 -0400
Message-ID: <20240329124903.3093161-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
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


