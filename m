Return-Path: <linux-kernel+bounces-41805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8F83F7E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D1F286970
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7521113DB86;
	Sun, 28 Jan 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPN30Vy8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365013D516;
	Sun, 28 Jan 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458574; cv=none; b=o+Jk+SgADo1BwvvmrRjnT4Xw+1QAcEjpYeQyPY/1DoBg0Rnmrmtm+9wF76PxjFauPety/MrKuEs2KB7YA26ouFXKS5ph33MZZWFnwXBAL9urpArzq03J9KyfE8ADU+7ley8JH6omWqiK8pf/eL4vZX5lKaWCH/W1AsaCG9pdJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458574; c=relaxed/simple;
	bh=fcdbbPgvAY8bSDapOWRbFEZJ8W2aev2un9RJ7QJHQM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECKDKB2TC/W0XNLXTwx9gGPag398UZYm10O8vuh/QLt9h1vq/rkPA0TyQm77/Bxf70iGzIgehXpWxKeCYDkUHLcvSmamYCtI/27pXlMui/e4Rj9c6Uls2dHkODm1YEaIzMs6eaHC8qiYQ2Aqgtk2dY3OCgFlcRQF54JvvC2IU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPN30Vy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4316CC43399;
	Sun, 28 Jan 2024 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458574;
	bh=fcdbbPgvAY8bSDapOWRbFEZJ8W2aev2un9RJ7QJHQM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPN30Vy8WxKhSoBT69rDbPEJf3EMCHpN2NEEe+dKWGOvJITA4afADMqo+hXkgpA6E
	 VQGfpnPpY72ZNRurKEPF08lHdDaba9QnczHPtIMpR4L1yBOECCob2LIe2bIx4z+blD
	 itnRCRMXl6XTetBEjg61MTGIUB9iTKmh+5WPgYFg3YVg45tsC3lqFPTFNnOEUHLvAn
	 /3tQe5Xg9wYDGBNjO0oKsuUk+qLni6+Wr6/420mRDW48bE9H/OxDqdPlPBafa8AbZh
	 5c2I85/vpIzFQde1kf4xkAuCG7GK49H5OI4R4XD8wI/jmnoZ1NKJuPyFJF7eXZDE2S
	 Z92DiPzp4pl5Q==
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
Subject: [PATCH AUTOSEL 5.10 04/13] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Date: Sun, 28 Jan 2024 11:15:50 -0500
Message-ID: <20240128161606.205221-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 68b07250dcb6..134f07c2431e 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -763,7 +763,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -780,7 +780,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
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


