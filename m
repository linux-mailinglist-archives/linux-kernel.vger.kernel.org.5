Return-Path: <linux-kernel+bounces-155065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBC28AE4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78D22869FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B0145B37;
	Tue, 23 Apr 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od9sNDn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EAF145B24;
	Tue, 23 Apr 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872494; cv=none; b=jRHcMzHDRY9GOEERn2inJ9PL4rumHlV6qCUZgDcTIk0nTO6O42XRa3vxlKdOGNRpozoZFSFSTIOwMKBDnStgfFhkkaH1XnTOntBkzNuEsSiw1FNocRwnU8liDMnuQTn2yqdYW4kxvLG8+9CRIeZnx0LIl++4au94dKdSpR7rXBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872494; c=relaxed/simple;
	bh=ufTzEUAEaajkF1jHWBZch7zxR9570wEoG2eWInPd2tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwa241+oT9mjGwsmzKXFJQaqpFLdp6cYXMOFqRmoc2dvDL8BXuC9vtCKk8gBe7Qjm1rm90TZPJzAL+PjtU+tStchT2Is6aJbdLKqEEZk//DIcm79YyQNxqnMFMr4skX4PshUzdJhwgM/qWnUCON+so4CzPizafA0rhYI3/jt970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od9sNDn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F02C2BD11;
	Tue, 23 Apr 2024 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872493;
	bh=ufTzEUAEaajkF1jHWBZch7zxR9570wEoG2eWInPd2tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=od9sNDn1QDoeO73UBV09VYurdTQcUJ5ua9qCepe90Sk4lY8KO6Ylc2YAdshjbZQzD
	 k19WK+85z3SO/W8h1xoSOHx6GTwoNxy7J/+Kp9cOI+kkYS8t5648udvB/34JhIDYnn
	 PN3uYYEYGJx5AfZvn4dPCoueyGWvecdNlJnRri90juFwQBna/2Xiiu+ldZkVPMy2SR
	 p5ldyXFtpw5OeilK1RQ3KqIXXgMS9lHRDP5XNwqcfVuUGDfIHb9Hl+tTsE7/mhIUb2
	 WEf8ZjpBEi5KG0M85d1dY5KyCNNbBKZdmngIpiQeAnM0sqHVH0JGj53ah5FKA8Un1i
	 AUqFtFUsJ5ilw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 2/9] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 23 Apr 2024 07:02:40 -0400
Message-ID: <20240423110249.1659263-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110249.1659263-1-sashal@kernel.org>
References: <20240423110249.1659263-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
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
index 88ca5015f987e..4ffb0750c79b9 100644
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


