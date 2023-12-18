Return-Path: <linux-kernel+bounces-3278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269FE816A50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5932C1C22911
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E217125C8;
	Mon, 18 Dec 2023 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJt0FVa+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iULYsgGL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B907125A3;
	Mon, 18 Dec 2023 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702893460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b9B/dJhmZ1FQU1Ml+AeFKF1QKF+vHETnd8Coz1FtEOs=;
	b=qJt0FVa+T5xF0c23SDHgq6oH8efKsuOHIpvSGOh5PZh7sS18QYv9sYs+rbCl2hUlt3bKmB
	vMKNOYTXB0HhUvBInth1H/Dz4ip7T0Mh7Ta3Wwe6WMM4s7ZXcWm3IJShUMtQ9wX1vReAwD
	8Z5QG2XWpBSiVwGStwFmROYr7j//Lpb6RlSmiXamssiwsr+Ike4vHqKWhbJIVukrL1vkvO
	srdJ1GQEVfHoUUvmpvvPF3r3ohT78Cx69DJ+dR7Exc/R/O5er64Z7Ufh8cw/Ana6aFfZob
	UElghQGblGLF+FUvqxBzbjl7GHC4ACR3fw1xGHR06RcgiZcDh+w9M2g/MRMx+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702893460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b9B/dJhmZ1FQU1Ml+AeFKF1QKF+vHETnd8Coz1FtEOs=;
	b=iULYsgGLAjpNxsywH3DLqbO9R6yfT8uCby5NXhu/LjersaoceyLj+bMy8mKBmPQYycXE37
	onivXZO+3yellrBg==
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
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] fix LCD diplays sporadically not work
Date: Mon, 18 Dec 2023 10:57:29 +0100
Message-Id: <cover.1702890493.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While working with a framebuffer displays, I noticed that the displays
sporadically do not show the image as I expect.

After investigation: this is because my devices use deferred IO, and by
closing the framebuffers, all pending deferred IO get cancelled. This
causes the image I sent to the devices to just vanish. Using fsync() does
not always help, because the driver's implementation of fsync() does not
guarantee that all pending work is flushed on return.

This series solves the problem by flush the workqueue in .release(). Also
flush the workqueue in .fsync(), as it is supposed to do.

Nam Cao (2):
  fb: flush deferred work in fb_deferred_io_fsync()
  fb: flush deferred IO before closing

 drivers/video/fbdev/core/fb_defio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--=20
2.39.2


