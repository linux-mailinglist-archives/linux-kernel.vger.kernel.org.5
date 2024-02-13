Return-Path: <linux-kernel+bounces-62653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B9852404
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FEA282156
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544760DC5;
	Tue, 13 Feb 2024 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk1UKPAx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639DE14275;
	Tue, 13 Feb 2024 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783679; cv=none; b=BqpXpww2myf6CAuMT0DwVu61zLy2SswB3d4IGLyQg90ADUaV9JSivzY87hdIq4LY7Z6+Vof2MBfice+hriTRBmJeiBxTiWacpt+D/mdK3PTP00WLvl8YMJSTf33AC5/zP5J1nGYvQ71bgGfERn5htSRRcOBOTze2er9YyELt3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783679; c=relaxed/simple;
	bh=ah+nzZDiru87RE9jCReCZvYCNwcsqB7efglrotv/6Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXKzAm1b4y5sxQnxwuN4PldByF64BHvd5jhMbkenvd5qfXKUH7cGT77Mg2/oT6cZYbspghTd2/6oNbPlKQ92sGk8261rqv3oqWLhuEuYgVuwDtubD/OJZG8agaW8GTiSuhu8bAC743tW8n6Guzef3nZtLETeiztmZmqIfhbR3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk1UKPAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF1DC43399;
	Tue, 13 Feb 2024 00:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783679;
	bh=ah+nzZDiru87RE9jCReCZvYCNwcsqB7efglrotv/6Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lk1UKPAx8O17by8E0aNDbJubLRtH59mT1mN2ayU4m/EheP6sQ6ksbtrNAcaPxp+Bs
	 z1KNE7O6e/flW/a947aIhBZTU7jY3Tsidy+qDcrMFedg1yvlsdajV50aI7mGhCdcJi
	 O8G9AiOpNZZmsnPHxu0uRQQsShNu7qbD+HCE1NvHENXPC+7suaUtAAeX4GSwUhOQ5d
	 kUuHTa+MUKbxRuhencHxpDs6vN4dUPfqOqhAJjlUji9LaLw9qIbyYmfxtQTj2PT2gW
	 lQ40kWlzQ26StiI1DSX/0coSIOIsj5FmLNVggiFEHA3cr27O8F9RSORZxbDTviI0jB
	 2PNcYKMxi8VXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 22/51] fs/ntfs3: Fix oob in ntfs_listxattr
Date: Mon, 12 Feb 2024 19:19:59 -0500
Message-ID: <20240213002052.670571-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 731ab1f9828800df871c5a7ab9ffe965317d3f15 ]

The length of name cannot exceed the space occupied by ea.

Reported-and-tested-by: syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 838a79157fb9..b50010494e6d 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -219,6 +219,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
+		if (ea->name_len > ea_size)
+			break;
+
 		if (buffer) {
 			/* Check if we can use field ea->name */
 			if (off + ea_size > size)
-- 
2.43.0


