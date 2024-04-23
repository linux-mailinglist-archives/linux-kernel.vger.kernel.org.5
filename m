Return-Path: <linux-kernel+bounces-155074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF08AE501
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B896B215C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445531494A5;
	Tue, 23 Apr 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaw5oGqh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1F149011;
	Tue, 23 Apr 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872509; cv=none; b=O3nwm/LVsI/4m4mtQjxscRVqXKPigM5Be0dfl54z4DGznSFmAsxGSVdc4KvELty3jc+RnR8xFt7IjFVqF7+VADqm2Mi9KrjomGthJ70e51B0NfHijOQhEre+z61PN/lX92bFlZIBR3hVuRaxqflYHWqgCZOyceLWSXv5ixPGTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872509; c=relaxed/simple;
	bh=YV2KABLMsMm6kEiuT9Ol3h9HjtRdqo5DDz/idqcYbVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU6GUZEs8xM7y2OE051f9ihhqX8jf3zlxbNAEKgi9hLLOWjliKBwmUKHwtvZHXupcTJYhDvp73QuItUhP1Lt0TDUPTYwPf1rBfoz5zCQ7QyOvvxAP9xLAJ2+5QQkG/S6AOZS/jA+dH+uBPCFdzOlvgQHW8wIg4u9ROhi3ke2iQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaw5oGqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FD6C2BD11;
	Tue, 23 Apr 2024 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872509;
	bh=YV2KABLMsMm6kEiuT9Ol3h9HjtRdqo5DDz/idqcYbVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaw5oGqhp2u+8sBCaU88GICDf02Q3hEiCpipehCySMKodb/7fAdf2AZlP+cogvymq
	 TePS108Em/TJ5CRdYHJv8LPxjUN7F/aoTuQhZB0q4etmmy2jjNet4p9Y0tL+iAt3KP
	 4QaTRIdanlVy4FcaX4f3fcydJsb7bicSZ3lCjHL+TXKiOFjIT6KkuJdiXW2mG6C8f9
	 5/ccdQBNDEG2iyLhlHy0ddPZ19jkjb7SLKhHzj5DkNCbI+0+lM1zI5XWbGpTc0SI7L
	 OQcKm83b6VKfqVS3aWZL8wlGUCvK1lWraJ2rKs/4ZtJq5dN+7BxcSD4n3SbzWk/k35
	 57LQvRsKyIOAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 2/8] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 23 Apr 2024 07:02:57 -0400
Message-ID: <20240423110304.1659456-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110304.1659456-1-sashal@kernel.org>
References: <20240423110304.1659456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
Content-Transfer-Encoding: 8bit

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit 87de39e70503e04ddb58965520b15eb9efa7eef3 ]

This one hits both 9P2000 and .u as it appears v9fs has never translated
the O_TRUNC flag.

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b1107b424bf64..ffce168296bd3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -177,6 +177,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
 
+	if (uflags & O_TRUNC)
+		ret |= P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |= P9_OEXCL;
-- 
2.43.0


