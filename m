Return-Path: <linux-kernel+bounces-41730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E28983F715
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CAF2899BF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80460866;
	Sun, 28 Jan 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3TGJD2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D05604C8;
	Sun, 28 Jan 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458412; cv=none; b=rhgGzStA6bRGamY4/evNeHW9bg+QTwAodKi37JlBdzIQmLOrR8Njn2XcRHhO2hiTihaeW7ysOiV8gTHkUrnQlluWiQ/JOIC1+HyCuR1rNT1T5eG6XM6rHYn0+BfP4pjLUePyqMycfOqmJntcnWkuseGxWsOVjKvnKJ3+GVmL24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458412; c=relaxed/simple;
	bh=aJxCJ2yk008ydqrlmh4d7c6Jytm/930kThFZ10FTI5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0+azVO5DMXx8rqGHY9cm7YGaI/Q/jInrimHXWTlLBncCNrsqaIZr/tR/Hi28WBsVwyrRRV2dVljSqTA63zJV0P2gGmXC+3Sq7FPpQiA7gRCAqdbnqWWO4w5KP4PBQKS2ES8zyU9u7bnXGWVadnlF3Np/ZiMSp+YIecA4m88hDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3TGJD2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5240FC433F1;
	Sun, 28 Jan 2024 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458412;
	bh=aJxCJ2yk008ydqrlmh4d7c6Jytm/930kThFZ10FTI5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3TGJD2un76B5YXzaUSipNEecYmUcMtqKnpWZwfcgo6tB/5ghxAePUxASjuJiXzGW
	 fT5qeLYDvdbD9T1CxfYXp0RAUKZiy1TvMVLjcHMDbkq6j+GVsmt6hrU3sqc9vkoMjX
	 jtRDS1/Z/mYeFq7aGIN5E7l5qpHi4LF0plgaIFsX/4DqWr4iPHT8mcBYKbcqjOGclx
	 UUEwnKZ4M6uQ1jYJJnTzUpO3oWxg0dZRdv/PKND6IghOYccQ3izeAOftbkclODhNVo
	 pDNPlWk15jnegPif0qleMIaXn4TxVOaJADA5xfaqy6wyXXZNn02P+lJpcMxlqeGuoT
	 dBA02YBo0fJgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Reber <areber@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/31] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Date: Sun, 28 Jan 2024 11:12:39 -0500
Message-ID: <20240128161315.201999-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Adrian Reber <areber@redhat.com>

[ Upstream commit e0f25b8992345aa5f113da2815f5add98738c611 ]

The capability CAP_CHECKPOINT_RESTORE was introduced to allow non-root
users to checkpoint and restore processes as non-root with CRIU.

This change extends CAP_CHECKPOINT_RESTORE to enable the CRIU option
'--shell-job' as non-root. CRIU's man-page describes the '--shell-job'
option like this:

  Allow one to dump shell jobs. This implies the restored task will
  inherit session and process group ID from the criu itself. This option
  also allows to migrate a single external tty connection, to migrate
  applications like top.

TIOCSLCKTRMIOS can only be done if the process has CAP_SYS_ADMIN and
this change extends it to CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE.

With this change it is possible to checkpoint and restore processes
which have a tty connection as non-root if CAP_CHECKPOINT_RESTORE is
set.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Adrian Reber <areber@redhat.com>
Acked-by: Andrei Vagin <avagin@gmail.com>
Link: https://lore.kernel.org/r/20231208143656.1019-1-areber@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 7958bf6d27c4..7c6253685545 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -850,7 +850,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -867,7 +867,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios_1(&kterm,
-- 
2.43.0


