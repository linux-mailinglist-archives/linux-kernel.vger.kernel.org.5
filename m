Return-Path: <linux-kernel+bounces-113497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E78893C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B798E1F30B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540313D527;
	Sun, 24 Mar 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+CbfoXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42013D50C;
	Sun, 24 Mar 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320299; cv=none; b=borPn10bTzXhaGEcRStmuv/X4xtNs0TD/tDzlMgRPb3EUGgUdpdeM/c0xUV72nZ4dwecqNyxHkXLPqX9qTQQHFkox66bnM8d3Oie3TRfIsdq9g3vGzD0hcwuTbJkC/Y/Owy9stMtcvWl8jszOPp9XK1XZHgXv2SuUNLgFgNQaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320299; c=relaxed/simple;
	bh=BFLrM6VzIQ/SvkmNCVyRKM9OQn5i2ec6bYhmnanVnZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgEBZ55rMvHBV/Fc04wWnh5fPD628YYqolOkWCBFPLeBzJ3sUVKWVGVhb3HWKoxXrwY7YhNvw5nUxsS2e6kOHre6DjpaQjI9ZW3MIrWQofnBqIMm+KbCAvs9Mp2nYlgjSe5WNzkJOOJwj+4JJQVFiPaBiNtkjacOGzPQ9LzC3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+CbfoXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED94C433F1;
	Sun, 24 Mar 2024 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320298;
	bh=BFLrM6VzIQ/SvkmNCVyRKM9OQn5i2ec6bYhmnanVnZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+CbfoXIGFwySHmAsdjdoWHukm7+7lUlanrRB5HQz9FzJsrEnNuISokt+w8aj2o2U
	 WoKbEMsseRxHCH3pTlgSVI55DMQqWR1SlwiZEZrJCpR64Mu06SQiXsd+q0bAN2lKK/
	 wnrgJpADI4XZOf9hOKzFU+WDS9uZypZPrPINkWtNs0F3cUuCEIr9d5qmkT/1VXDkS0
	 +gBBz1tmnzaDntrIbw0CRDWSiGW+1dglsgbOgCzPdbZuMnSJ41d1HE6fEawshgRomO
	 PDFu6joZR3hOsuXyLimVWcgdIfKsUILFMP7gMs0vTIW+aQMZEUzPiggUob+QOFcogJ
	 HQiydz/k+EBwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 606/715] ovl: relax WARN_ON in ovl_verify_area()
Date: Sun, 24 Mar 2024 18:33:05 -0400
Message-ID: <20240324223455.1342824-607-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 77a28aa476873048024ad56daf8f4f17d58ee48e ]

syzbot hit an assertion in copy up data loop which looks like it is
the result of a lower file whose size is being changed underneath
overlayfs.

This type of use case is documented to cause undefined behavior, so
returning EIO error for the copy up makes sense, but it should not be
causing a WARN_ON assertion.

Reported-and-tested-by: syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com
Fixes: ca7ab482401c ("ovl: add permission hooks outside of do_splice_direct()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 8586e2f5d2439..0762575a1e708 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -234,11 +234,11 @@ static int ovl_verify_area(loff_t pos, loff_t pos2, loff_t len, loff_t totlen)
 {
 	loff_t tmp;
 
-	if (WARN_ON_ONCE(pos != pos2))
+	if (pos != pos2)
 		return -EIO;
-	if (WARN_ON_ONCE(pos < 0 || len < 0 || totlen < 0))
+	if (pos < 0 || len < 0 || totlen < 0)
 		return -EIO;
-	if (WARN_ON_ONCE(check_add_overflow(pos, len, &tmp)))
+	if (check_add_overflow(pos, len, &tmp))
 		return -EIO;
 	return 0;
 }
-- 
2.43.0


