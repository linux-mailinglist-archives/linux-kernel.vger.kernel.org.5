Return-Path: <linux-kernel+bounces-114371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71699888FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AF71C2B8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE326FA63;
	Sun, 24 Mar 2024 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0MljVnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2F217308;
	Sun, 24 Mar 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321768; cv=none; b=GUEETX/5LSdlQc2yKzwc8X01/hIbrrWoQ59SYrvzGkzFVB2/NOgeEGeY9COPA58M2+6V7F3/4f2NyBkx/BgY357FgF6cETJbzdwtQZLZaM1TwsFcXaSlooBozI7wiLPx0PpjFmMZajKkJxZatXmAx5LbN2X4DLQq1X7pWeHdP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321768; c=relaxed/simple;
	bh=kj/dL7YvE+j0vQYw0fIYQJlGNwGBPNnRWNUy8qy+woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7oj/4V0aa9tmLaTYlWFuFuVNZ6w2DWRPWUKupiFcsHyV3ZeUn7oQj+tga3IPMypnXmbCR8BBdTUqPxq8vmgTWAXMwkqb785qCrNkdTKbnirWCZo/GB0x9yLFwg6xLvhv5VoHwm8SF7bP7XwximVo01HDR+kKSs8/buJV1A4hMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0MljVnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B666C43390;
	Sun, 24 Mar 2024 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321767;
	bh=kj/dL7YvE+j0vQYw0fIYQJlGNwGBPNnRWNUy8qy+woc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0MljVnTG0r1lloGYnoOUeFnIwa1ogcsQslcUdJFEBYyD1y869TTC61f0LudoNFbq
	 qQZ9KFp+qHeBUexPb5ak+PMrgNNw8S5Dp50Vd89rNB1tBEW2CpxEQrdLx1C3OwADiB
	 Pu6Be6tPNhGBhprR1elqBBStlp4aUvkP7JAdAQ/E3w67a/nIhXY/IHhe5TKNTMVTx+
	 bUm8nUvnNxzOPRUeamggh0Bxp6bz8RJfRLT9mFiCgVmS/yx6XqjuIQJdpZ5fgkDDAB
	 3rC6pteUXkkgAC4A5TZjTS8bdvde4C1rpdNX2w5SFc9rgiDDFVL/p4onV8VuE9312a
	 jDSNi5Y4cT7pQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 495/638] smb: do not test the return value of folio_start_writeback()
Date: Sun, 24 Mar 2024 18:58:52 -0400
Message-ID: <20240324230116.1348576-496-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


