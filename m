Return-Path: <linux-kernel+bounces-41763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A383F773
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C3B220DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9D6BB50;
	Sun, 28 Jan 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fayOrCW/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F006D1A7;
	Sun, 28 Jan 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458480; cv=none; b=hXvsuJwNiNDImGgn0ghqeKrHKJWHEkXaxeN0/D6xO02mEGgNy5C560epF6IlX+a9MbmT4AtH2IdIQXN5ucJZVPDiVYZGKxrkBUwot7oOu8TpYqlKYLogPrFoERrEd3tr6RF4yFC3I80Y5F/aHji+UfgWvYdUFx68idT7uHMExEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458480; c=relaxed/simple;
	bh=t/oLxMaAwbqU9K66T9Ia3Kt9Jt0nznQv+B09sf5KI/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO/ekNFwH8oi8b0bSOtVXxkxw9tflAN/ALdg2jV1ZJywzV9ccY8QHJR+AskWqN7BrlGviGjAUTLwQlszojAX1Ex7YR7fpQLHyphs+FAiKwZpvzyvO+ny3hDX8LMaGOIf2sN8k+9P4gcgMw/D8/W/PtaP2WL6fHf5dWIk0Ky/aCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fayOrCW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCD8C433A6;
	Sun, 28 Jan 2024 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458480;
	bh=t/oLxMaAwbqU9K66T9Ia3Kt9Jt0nznQv+B09sf5KI/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fayOrCW/zVfWobUC4MWSLxwMyU9LwWWDOkh2mDDjbs7KLwEM470MK3lyBMxHtmF9q
	 IElLqqmrAUl28EFTiwxTijGL+yOcfqYWirWiAk6vZQArtULaNj9IvurpdazMQLIbMZ
	 uxssi7JZMl7Zy+uQ0JzGYv9WjSEc/aVUu9XnEhlEdxzT28JWFviNkDqxZawHHmpmpi
	 q9Wj0oGFw9cqh9sec2UMm9ZRPEzhwCQEcmoVSIWlr4RzZmwSpIWg7i1ST9fFI1W9ao
	 9o3JzxQrm0IAqE7kmcmRKrjcIEw0irdMpmN3TVjABdEoiY/GQj34DMIAIuwxPnI+pT
	 9KRdgZ5sbm2eA==
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
Subject: [PATCH AUTOSEL 6.1 08/27] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Date: Sun, 28 Jan 2024 11:13:53 -0500
Message-ID: <20240128161424.203600-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index ad1cf51ecd11..41004720d4ae 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -859,7 +859,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -876,7 +876,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
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


