Return-Path: <linux-kernel+bounces-61407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E58511FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A491C2170C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260FA39ACC;
	Mon, 12 Feb 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI3t9Err"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3C39877
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736664; cv=none; b=iBjfEKjHP/Et42baVZR1JtJhmnEZrBpoMCdWuxhM3Fl1YI5tgo5WbZ73iwoQ8MJNlvIsS3QPEaNR+NEaaSRg7AOObx7hjD4dNwm6XjYah/flusqHpz81lw6p9iGPbJEaJXV+sMCSfHi7d56arcsFoQU6eTQMQj+HiA1iaeVE/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736664; c=relaxed/simple;
	bh=YCI5M76ZWV3agMAEsxysptr2SwbMtl3GoSgyNq4kuHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WilFmZqu6qcnSJPweSEY6heB3RguFYEyNYsmJUF4hZdOgCIlm9Sap7Kh/ZvS3UDQA/XviWbtNKlEPty2CRG+7ggS7YszQ46iJkoBcbV27DTHE9j+86be7/6G4DfCDbdtNcjRGIDYOMtn82GyJFzXCwK2hOlGWkew16z+CuQ9F6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI3t9Err; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33642C433C7;
	Mon, 12 Feb 2024 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736664;
	bh=YCI5M76ZWV3agMAEsxysptr2SwbMtl3GoSgyNq4kuHM=;
	h=From:To:Cc:Subject:Date:From;
	b=uI3t9Err5RSXW5W3b0MsjFi/rTEbrQsdY0RZkCxI3OuIZHaoktNEWhszlyUdDfmSG
	 aDryVTPOn9cBxqiUJNl5KopjoaOFBskt+vCtpzF85hlHlRDc45H8rP+DEsSXhT8ATh
	 Ar2dYy++CV/rWqE2HXS3rgwb97LoGCL4aycz1fBRLlNx84BDdBZaccZXg08avAZeIW
	 z/Z600Qbyso+3x1VEngdXtRWxbRcaVRfj5Ny9m2yqtUdeUG0CiYAzXORKYsx87xXVB
	 wwZJZN1oCjBQTmHCK+AKPdpIFZK83ffIipbBza2Sv/1cf4Z8p24yFOqM5nXJ1EO6eI
	 04D8nrJm8Uygw==
From: Arnd Bergmann <arnd@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>,
	Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] samples: user-trap: fix strict-aliasing warning
Date: Mon, 12 Feb 2024 12:17:31 +0100
Message-Id: <20240212111737.917428-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I started getting warnings for this one file, though I can't see what changed
since it was originally introduced in commit fec7b6690541 ("samples: add an
example of seccomp user trap").

samples/seccomp/user-trap.c: In function 'send_fd':
samples/seccomp/user-trap.c:50:11: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
   50 |         *((int *)CMSG_DATA(cmsg)) = fd;
      |          ~^~~~~~~~~~~~~~~~~~~~~~~
samples/seccomp/user-trap.c: In function 'recv_fd':
samples/seccomp/user-trap.c:83:18: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
   83 |         return *((int *)CMSG_DATA(cmsg));
      |                 ~^~~~~~~~~~~~~~~~~~~~~~~

Using a temporary pointer variable avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/seccomp/user-trap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 20291ec6489f..a23fec357b5d 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -33,6 +33,7 @@ static int send_fd(int sock, int fd)
 {
 	struct msghdr msg = {};
 	struct cmsghdr *cmsg;
+	int *fd_ptr;
 	char buf[CMSG_SPACE(sizeof(int))] = {0}, c = 'c';
 	struct iovec io = {
 		.iov_base = &c,
@@ -47,7 +48,8 @@ static int send_fd(int sock, int fd)
 	cmsg->cmsg_level = SOL_SOCKET;
 	cmsg->cmsg_type = SCM_RIGHTS;
 	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
-	*((int *)CMSG_DATA(cmsg)) = fd;
+	fd_ptr = (int *)CMSG_DATA(cmsg);
+	*fd_ptr = fd;
 	msg.msg_controllen = cmsg->cmsg_len;
 
 	if (sendmsg(sock, &msg, 0) < 0) {
@@ -62,6 +64,7 @@ static int recv_fd(int sock)
 {
 	struct msghdr msg = {};
 	struct cmsghdr *cmsg;
+	int *fd_ptr;
 	char buf[CMSG_SPACE(sizeof(int))] = {0}, c = 'c';
 	struct iovec io = {
 		.iov_base = &c,
@@ -79,8 +82,9 @@ static int recv_fd(int sock)
 	}
 
 	cmsg = CMSG_FIRSTHDR(&msg);
+	fd_ptr = (int *)CMSG_DATA(cmsg);
 
-	return *((int *)CMSG_DATA(cmsg));
+	return *fd_ptr;
 }
 
 static int user_trap_syscall(int nr, unsigned int flags)
-- 
2.39.2


