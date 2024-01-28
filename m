Return-Path: <linux-kernel+bounces-41789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D30583F7B9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AC6B21CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08B12C539;
	Sun, 28 Jan 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOn56Mal"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D212C558;
	Sun, 28 Jan 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458537; cv=none; b=d8vaFxwNtBuKL/CkedtNFg30hvGVfVhR3Kf1cKYfw6MF/fNBp5fjYClrZUTspdoL9o41wESyp2FI+IRMJuBliqzkY8d5z/NtuxnFK2YJgECaKzLAqqDpNKxqRQjt62pIVpAn2aOkV+NXlTPLlax+AxShtB7B+i4UABg+sqE9inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458537; c=relaxed/simple;
	bh=OGli1iqfWIparKcCK3HzdR9pfjfzODT0novBM1V+ryw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHaeI+Wyn/XDQjnSioOKv5W2DGsctDSuyxqaf3BnV6CbtRQJUjaEsZlcmEAV5ODzY7q+vgFf9L6fwDD8zQCPAbX7dxeUGITZLjw5Fpn+mp1MLtUkKbehkMRbCqghHB1Jtj+Y70K5kWEiTgmMfbcMDyokO6sUjR51V952BzAuoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOn56Mal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0856AC43399;
	Sun, 28 Jan 2024 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458537;
	bh=OGli1iqfWIparKcCK3HzdR9pfjfzODT0novBM1V+ryw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOn56Mal+C0lzcMr5hRF3x4/3BTRdxY0IPY0BEeSaCfWUKZioUUN4bViNTkBExwBR
	 JhQOmP1r4ZpFhwcSY9mVJXKOfmMfW5UiHd6No+fL1dfZHyivqplUjE+5MTLlPFLq2l
	 0MwhZLRk7n/m58loTY2YWV297Dn52e9FHhx4ZuWkjO3Ml7jn/o8XfwjTewPSmoAkFb
	 72/G7itPa51I1JHVR2JZUZZVdx2gk2qE6NI0hrqS/wefXWMNtdlXAjxs4Z04WxgZB9
	 uYabEkqlfNTnxu2Rvapswhp+bq8mR21oVtrIWF+YWqkAUzk5HkDdKHfPkvhGFUmY6+
	 5WTepYM6kunSg==
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
Subject: [PATCH AUTOSEL 5.15 07/19] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Date: Sun, 28 Jan 2024 11:15:04 -0500
Message-ID: <20240128161524.204182-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 1736130f9c39..1c7c3a37099d 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -786,7 +786,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -803,7 +803,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
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


