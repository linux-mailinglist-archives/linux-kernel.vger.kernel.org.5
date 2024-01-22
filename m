Return-Path: <linux-kernel+bounces-33665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FF836CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D5528B740
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235534F8A0;
	Mon, 22 Jan 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM1dKqXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BC3F8E1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939960; cv=none; b=uRkHaSqR1QrcZU3Pb48CUkqqU0V/1K3PoQeKKSoufH3Qa44M5iay+iKgzPA8N+YidE14KieidRukeh/+P8a86H1Z2v/AN2IBSUMkmTUAYZVoduTp4u8CjYiCwA1P1WDXHDXvvMu/u8t1T8+Wvc1EbfNGF56nP4uCmSpdELAapzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939960; c=relaxed/simple;
	bh=u40yPI1eo5OCBcJ6otQkqT3GuoiQ5GJ9+8tgn1ubg/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5/DSOkeU2SjPLX2GGH48qs9gHP+WIJBe1uF+DODX72wzgjVNZ0X2ZReCJcMZjEfylhGCF+8Aop63n+jIFAhtbjvUOPweDPzgtzo9K4sJSSs8N2VAtVPn98BkcqvL0zR9/Sk5XgXXp9aigYrGGbtqUh62ZYLqoT+2nnVsSmxVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM1dKqXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049F9C43390;
	Mon, 22 Jan 2024 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705939959;
	bh=u40yPI1eo5OCBcJ6otQkqT3GuoiQ5GJ9+8tgn1ubg/s=;
	h=From:To:Cc:Subject:Date:From;
	b=pM1dKqXL0D39T4s644c17DUpE9aVRYMCKqL2DY9cAHmf7KA70sKxHCbT6ZZhifHk7
	 yzdaiA8XHCVk8NfFE8lNI+/bw4f5Kt9VmTjhBII3SDeGPyxI35pctal+49+XjHn0g6
	 8G2/p9p3a+MinQq6vII2pli08Lf7iwTQ12+ilub5Rhu6xvMCtvk8fExWs0XhPZ+lxO
	 j8Fuj0gl2aUeDCe34MpT+uxbmnszi6/1g40H8Y95deHzg3Yoj5u0JBT6503P133d/w
	 Q6F74z+6A8zlqEcwa1ceG4Z9xG/cjQ61zdpKsyCsz2thqSzEepUn4i2BB31Ke9KGkf
	 lWCPhFqKQZ2Ow==
From: Arnd Bergmann <arnd@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Janne Grunau <j@jannau.net>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: apple: use strscpy() in place of strlcpy()
Date: Mon, 22 Jan 2024 17:11:55 +0100
Message-Id: <20240122161233.125192-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Since commit d26270061ae6 ("string: Remove strlcpy()"), the strlcpy()
function causes a build failure.

Since the return value is ignored, changing it to the strscpy()
causes no change in behavior but fixes the build failure.

Fixes: f237c83e4302 ("drm: apple: DCP AFK/EPIC support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The apple drm driver is not in mainline linux yet, this patch
is against https://github.com/AsahiLinux/linux/tree/bits/200-dcp
---
 drivers/gpu/drm/apple/afk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/apple/afk.c b/drivers/gpu/drm/apple/afk.c
index 99d579d5ce47..9fbcd18878e8 100644
--- a/drivers/gpu/drm/apple/afk.c
+++ b/drivers/gpu/drm/apple/afk.c
@@ -236,7 +236,7 @@ static void afk_recv_handle_init(struct apple_dcp_afkep *ep, u32 channel,
 		return;
 	}
 
-	strlcpy(name, payload, sizeof(name));
+	strscpy(name, payload, sizeof(name));
 
 	/*
 	 * in DCP firmware 13.2 DCP reports interface-name as name which starts
-- 
2.39.2


