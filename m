Return-Path: <linux-kernel+bounces-3280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B46816A55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2641C229EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650112E44;
	Mon, 18 Dec 2023 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kkxi3zSo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faqY/3zT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96F125AD;
	Mon, 18 Dec 2023 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702893461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQgbUD/9nx5mi5GS7bnC72VqZMbKoUb8rPJa0pNUbQg=;
	b=Kkxi3zSonUFc6y94k8nGCK8agXTv2WfFgXRqzSp3Kk+EiUi7x+4dK3FUjlcRqGkqKnqrdG
	kb8BZYzCINHtS1fVRyZf7x+513wa1htBnuxQmfHW+ipRyBldeMol/tQQjK6WMkAxuB3x6K
	x8B+X5gwp697Y88VxGi60b4L/rUbzzD+8ILa8C+86UpcVy922Z+CjbUOPVqhCRDMcCDu0I
	6H4/oeqWUo/2lr6tyNgT+jEndcAWIYt4FDNOfX3cSQKyo5trqc6JMZGTffcRRBnajXkN4r
	estX+xLS1zqN2YQaL4H1thIpODq6P2R9DzFsGaaBWsuXXA+2hNhFi/W0S98fWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702893461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQgbUD/9nx5mi5GS7bnC72VqZMbKoUb8rPJa0pNUbQg=;
	b=faqY/3zT2f1RnxKjUVyMNBjYHnbagbsIJ2OtxRfsf+0e6/fXqcPT1MzTJJJRoZZvDJzJid
	B41FU8hSdvRtjnAA==
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
Subject: [PATCH 2/2] fb: flush deferred IO before closing
Date: Mon, 18 Dec 2023 10:57:31 +0100
Message-Id: <bd017f29c0c3d0a91e7be35520d3994218465562.1702890493.git.namcao@linutronix.de>
In-Reply-To: <cover.1702890493.git.namcao@linutronix.de>
References: <cover.1702890493.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When framebuffer gets closed, the queued deferred IO gets cancelled. This
can cause some last display data to vanish. This is problematic for users
who send a still image to the framebuffer, then close the file: the image
may never appear.

To ensure none of display data get lost, flush the queued deferred IO
first before closing.

Another possible solution is to delete the cancel_delayed_work_sync()
instead. The difference is that the display may appear some time after
closing. However, the clearing of page mapping after this needs to be
removed too, because the page mapping is used by the deferred work. It is
not completely obvious whether it is okay to not clear the page mapping.
For a patch intended for stable trees, go with the simple and obvious
solution.

Fixes: 60b59beafba8 ("fbdev: mm: Deferred IO support")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/video/fbdev/core/fb_defio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core=
/fb_defio.c
index 6c8b81c452f0..1ae1d35a5942 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -313,7 +313,7 @@ static void fb_deferred_io_lastclose(struct fb_info *in=
fo)
 	struct page *page;
 	int i;
=20
-	cancel_delayed_work_sync(&info->deferred_work);
+	flush_delayed_work(&info->deferred_work);
=20
 	/* clear out the mapping that we setup */
 	for (i =3D 0 ; i < info->fix.smem_len; i +=3D PAGE_SIZE) {
--=20
2.39.2


