Return-Path: <linux-kernel+bounces-114411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9A888A54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1E928CD6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DB176552;
	Sun, 24 Mar 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV0suB0L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2D13F44C;
	Sun, 24 Mar 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321825; cv=none; b=fJlV7+EhnDeB/mjnUZE3czPtg6uFRlsBqACY1ZaL/qrLnBYMW560ykHYcIuGD9EGrGOKDUK2AjmqiROCXkP8MmB98/PaYeN3+IIuc18geLp86wC4xwBQGwZwfdMp91I6YbR3qklpbF3L8bDDMWsmmFBpYKeddyH5xxnEMyowMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321825; c=relaxed/simple;
	bh=fRJ1NF/0Po2lrONLXrVy0VfghTonH8e7OtvZdiYNLv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0XvZtVlJZZUddQq90pQXCYLDLUm33WHlMc2uNmkWZ466EPTTvD25gAnyrdir5WngXMTyxyhEXcTkvwgloaBJstxuZ8PRUm6EEvBSfEuwHthuEzKvq0Nvgq1rhQhA+Bze7BkTN6/t9GMRvwlMEe5gRAjpb0yROg63PakPiRpjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV0suB0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA1FC433F1;
	Sun, 24 Mar 2024 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321824;
	bh=fRJ1NF/0Po2lrONLXrVy0VfghTonH8e7OtvZdiYNLv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KV0suB0LwJAs9/JIUQviPMjWAVSmDFsNgHcBA7pjJ9+UC7E6DpUOLfyzQl5kbn94D
	 8peR5FbZQKuQ7CVwmkw8JCNEPnRNTr8pdUqESENG9uO5QAlFhqhwaQuXVBOBsBt0GF
	 67qgHI525E3GX8WCRghuovDetQ3n9I8stegVxl90p7jmQ+Tb66gXnvbknB2Uke7ft+
	 z85SdNIvRpfaqzmmYSokKrFBVXfESwl7NNG5wLglimV8tRYuQUa2ACqW6KoEhH7Oby
	 r4M+C/xtoMShH9HbyL2hlNRFmC0zq7RIJIPJXF8c6cDBy/ANzimM5ThkyIORyOehUL
	 1MsO7E9R2m/Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 552/638] io_uring/net: correct the type of variable
Date: Sun, 24 Mar 2024 18:59:49 -0400
Message-ID: <20240324230116.1348576-553-sashal@kernel.org>
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

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit 86bcacc957fc2d0403aa0e652757eec59a5fd7ca ]

The namelen is of type int. It shouldn't be made size_t which is
unsigned. The signed number is needed for error checking before use.

Fixes: c55978024d12 ("io_uring/net: move receive multishot out of the generic msghdr path")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240301144349.2807544-1-usama.anjum@collabora.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 058e04ea68c04..4aaeada03f1e7 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -536,7 +536,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 
 static int io_recvmsg_mshot_prep(struct io_kiocb *req,
 				 struct io_async_msghdr *iomsg,
-				 size_t namelen, size_t controllen)
+				 int namelen, size_t controllen)
 {
 	if ((req->flags & (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) ==
 			  (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) {
-- 
2.43.0


