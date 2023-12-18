Return-Path: <linux-kernel+bounces-3279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E603F816A52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D754281971
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F412B72;
	Mon, 18 Dec 2023 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYB7/wZC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2c6pIzvC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B925125A7;
	Mon, 18 Dec 2023 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702893460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8g1705acTr/tgoPBJPCxDzSYFLliwXwTit5yL2vhLY=;
	b=QYB7/wZCAy3GKkvWhPXPJbjtv5jqKhrH0IhYndaJGvRnNE5S1hUB61ByPMusRDvNNvXgM2
	Q42MtKtQcxIyvDOHEYF2bCyRS3fRHM1KxPYBheyoHag0Q60sHOgHrQe4WBs4L4E4anC+yZ
	XqiLqjsIHSNwrd5uf/LED1uVcwDCIqsepv6Tq0iX/+/+w5S6Ew9QTde2vjoYJDeY+j6Tjs
	9VL/bFO4UEd87V4BsklZqXav85aVZRZpD1ecWcON3F/ygKc/m7ezm5g0C7R0qmcFXlFlK/
	RYNSGG5Ff4hjhg06dbm+Df+XIta8gHP6ifJnPlez0yxhdqzWqMKtqAyhV/b1qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702893460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8g1705acTr/tgoPBJPCxDzSYFLliwXwTit5yL2vhLY=;
	b=2c6pIzvCC2pWWiknD+IJ9Ed+Cd9zmCRkfZrO1U/2cAVRfSf59hAhENuaciIIH6Edz/mnb5
	Z7ATSmsGmX1ghRCA==
To: Jaya Kumar <jayalk@intworks.biz>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Antonino Daplas <adaplas@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: bigeasy@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fb: flush deferred work in fb_deferred_io_fsync()
Date: Mon, 18 Dec 2023 10:57:30 +0100
Message-Id: <d15187348e7d7f76b7a1adf95aa5e3e3ecfc10b4.1702890493.git.namcao@linutronix.de>
In-Reply-To: <cover.1702890493.git.namcao@linutronix.de>
References: <cover.1702890493.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The driver's fsync() is supposed to flush any pending operation to
hardware. It is implemented in this driver by cancelling the queued
deferred IO first, then schedule it for "immediate execution" by calling
schedule_delayed_work() again with delay=3D0. However, setting delay=3D0
only means the work is scheduled immediately, it does not mean the work
is executed immediately. There is no guarantee that the work is finished
after schedule_delayed_work() returns. After this driver's fsync()
returns, there can still be pending work. Furthermore, if close() is
called by users immediately after fsync(), the pending work gets
cancelled and fsync() may do nothing.

To ensure that the deferred IO completes, use flush_delayed_work()
instead. Write operations to this driver either write to the device
directly, or invoke schedule_delayed_work(); so by flushing the
workqueue, it can be guaranteed that all previous writes make it to the
device.

Fixes: 5e841b88d23d ("fb: fsync() method for deferred I/O flush.")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/video/fbdev/core/fb_defio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core=
/fb_defio.c
index 274f5d0fa247..6c8b81c452f0 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -132,11 +132,7 @@ int fb_deferred_io_fsync(struct file *file, loff_t sta=
rt, loff_t end, int datasy
 		return 0;
=20
 	inode_lock(inode);
-	/* Kill off the delayed work */
-	cancel_delayed_work_sync(&info->deferred_work);
-
-	/* Run it immediately */
-	schedule_delayed_work(&info->deferred_work, 0);
+	flush_delayed_work(&info->deferred_work);
 	inode_unlock(inode);
=20
 	return 0;
--=20
2.39.2


