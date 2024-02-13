Return-Path: <linux-kernel+bounces-62594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3960852368
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91541F226A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9872BD1C;
	Tue, 13 Feb 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBGEVQ2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4212BB0D;
	Tue, 13 Feb 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783548; cv=none; b=Hfx/fMrqPtnl+BOayWNbVOopc7xPGq7QYXNoLQVVxFHZ93SJMUBwI7o4823Uw45roTPKzBx+aS1u0mnQC2N/epj1WrutJnzSPX7EH4KNy7TxL+ENHPJ8RKisW0RmdAXgK3hhxwpG+y3Md/6pql+DjT3arlT71tx5w3xErjDq6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783548; c=relaxed/simple;
	bh=P5Sj9YFNejQfZGvQFffjrjTklDvu0mwcU2lHnSacnwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmynVbKpNA4+GCI4LVM4oN4PkKyAdDT3DhfZprVBKE1mm5WJ9D0IRUW/mtxkftdpc/wXqJd1vkNmN27GZXQZZNWgv//RiJmhLEJwInX7Nu+Q/OIbYGuStoGZ9cSzId9dgbb40WjNZcx0aT/fUYCsc7vPEfWSuzbd/+PmfWJHhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBGEVQ2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A7FC433B1;
	Tue, 13 Feb 2024 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783548;
	bh=P5Sj9YFNejQfZGvQFffjrjTklDvu0mwcU2lHnSacnwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBGEVQ2FE9EZ8fQyhSnECfId4B3E7thLG/+n3lYblSRG8ZSIhTCD09jg1NIcYinpU
	 EFo0mgUC0UTPAwH6zUSng/q9k4Ki7AttTWiYgKIg+47QODVpwBgMWFClcNwA9tK7nk
	 8cWTrD383Wlu0e/uz7/U4PHuNX7MhIS2MzHlQ0MddxFyB+0e/1sAPturiTcazHXlRs
	 n2+p6M0X7V2IqszjNOq8MVFWePryL1TdibN7fQVBrzhraSbvKuK12HoimnPMNYG8XA
	 hG7UXjV0Ggw0BThd3R9bbvUV1QBaZntBAnAF1zku9k7LA95lySwZ8D4Q1XBlVOKKDa
	 13IDkoibFn1RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 25/58] fs/ntfs3: Fix oob in ntfs_listxattr
Date: Mon, 12 Feb 2024 19:17:31 -0500
Message-ID: <20240213001837.668862-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 071356d096d8..53e7d1fa036a 100644
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


