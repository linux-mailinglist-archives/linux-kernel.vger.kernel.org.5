Return-Path: <linux-kernel+bounces-113905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC3888746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F40D1F25BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD021086F;
	Sun, 24 Mar 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO8b136d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA81ED71F;
	Sun, 24 Mar 2024 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320990; cv=none; b=n9IgSimRA/YfeqVQmPOmjssDbaFKt+2u7gzg/KuQMFPzN4kbSA+F10mqZXWHQMGqL3OKrn6w8j+4CPeMtx78kndPVsmL3D6pq692uvIEs7fYZ1gq2JfvIEvok74xb0SJElAnoSQcgQwVcWl7U0VcXgYtJm2v9EMxH1m/eoOjw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320990; c=relaxed/simple;
	bh=kj/dL7YvE+j0vQYw0fIYQJlGNwGBPNnRWNUy8qy+woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRn7ZEvbsctIOrxCqujmY/cHC7G84vyaHTwGimPmxcSep5+0TrfX2lLHCPMPc6e791ZgGSz+0pS4gwfK8B0t2dx0pQYhq67ycBm/mcq2ABrMZqHl1tvn2H3CWcWJImV/5LbM6SY54T9pYr6G5tIMUwQ2itGVp1j2MHk/i/lmKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO8b136d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606AEC433F1;
	Sun, 24 Mar 2024 22:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320989;
	bh=kj/dL7YvE+j0vQYw0fIYQJlGNwGBPNnRWNUy8qy+woc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hO8b136dWmYY/ZLJsvH1sY/YFez37nIBvk6Ksf7PQEUiGf1aQ8yyQ/wx+MBA4fKsw
	 HyIMA+1Hvr2sYFQhV3EkWruvsIGLUmSorxToUx50FGmpRyU4jocgPJNddbxVBBNTlk
	 nro1dq/TKmdcNZ1fBLgA/OIQnB6JtvETFlOnCbw7xzrgJQ9T68Uo5MrP8e6zUZxmZI
	 vR0qHA40ch/+owFG1mDSZfAwnPQKKUbmRootC3dK5PUbRaLzMAn4EKOxwPja49ivtS
	 DoO+tc2quBOMJ5R+Tgiu9xdS/o+0zpIFSV/A4VCMqEeB6cT3ZCBPt+1v/HuCdHQrZW
	 XATBsAX+GmcTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 552/713] smb: do not test the return value of folio_start_writeback()
Date: Sun, 24 Mar 2024 18:44:38 -0400
Message-ID: <20240324224720.1345309-553-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit a9540e35624d1475f47dbf6353eed8b99936d36e ]

In preparation for removing the return value entirely, stop testing it
in smb.

Link: https://lkml.kernel.org/r/20231108204605.745109-4-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f3dc1bdb6b0b ("cifs: Fix writeback data corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4cbb5487bd8d0..043bee4020a91 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2709,8 +2709,7 @@ static void cifs_extend_writeback(struct address_space *mapping,
 			 */
 			if (!folio_clear_dirty_for_io(folio))
 				WARN_ON(1);
-			if (folio_start_writeback(folio))
-				WARN_ON(1);
+			folio_start_writeback(folio);
 
 			*_count -= folio_nr_pages(folio);
 			folio_unlock(folio);
@@ -2745,8 +2744,7 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	int rc;
 
 	/* The folio should be locked, dirty and not undergoing writeback. */
-	if (folio_start_writeback(folio))
-		WARN_ON(1);
+	folio_start_writeback(folio);
 
 	count -= folio_nr_pages(folio);
 	len = folio_size(folio);
-- 
2.43.0


