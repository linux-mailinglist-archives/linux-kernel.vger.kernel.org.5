Return-Path: <linux-kernel+bounces-32810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BC8360A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897C1B2ACFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C1C3B18F;
	Mon, 22 Jan 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM/HDbBn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FA3AC19;
	Mon, 22 Jan 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921452; cv=none; b=CPYsF5NZWDw03OU/wh+RxvlDKlZdIJrQ3t0TX0zD74Tb/mGYtP66HTLc6V5b5DtefMduGQ6ae4LgVHeHMkneXXW+2Sin4eG8IiE9ty9vlOWUgpEIfkXirTcqZTxYJN44bNg3JrP/SAzc08JqTe2Ca4fi4qL/akqCXNb/w87BERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921452; c=relaxed/simple;
	bh=VF67ScvZaWBLLIl5rAX1Kh4YdbBo6nKFZPHrtIWu1Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fViZ5yfBmfy1qd/Hb4CNcKKObnCjKm+TkDrUjiPGvTuIp88sRguY7Z3/dcQr02soQybrxyqFxtuhimxPoYp6Y5rWJ/Zu1UbERmDWqM5PwLYj6GV5lMkIgDp6OsRSyJOpnEsPuNlig0nzkHntDcKh/aM8oNiU5/Zlx//l38EnzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM/HDbBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0025AC43390;
	Mon, 22 Jan 2024 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921451;
	bh=VF67ScvZaWBLLIl5rAX1Kh4YdbBo6nKFZPHrtIWu1Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uM/HDbBn28ozw8+m7zBAf4iUG1ywiPVlR8oK74pQvtUEL9V43tD0ZD3K5myV8i8Ru
	 qBXm1NbMTMoFrmfWHbwH5FJr2B3Rpju4y9SYpJH9uMFbEfAPpXrGQ3H3xglEvjmO6s
	 8CaHFB7e95X4jVgDZga1cLZJi/2kJx3SUs8a5yx+RPbficQy2hzgTZppJeNnOvPhvo
	 VqQZv9bqjc6vszod5BCWLtEGKg7AWC3ZQrdBk1JSxFTOHdDJIAVVvZRPYDgmMGxMbQ
	 IQuVblg76l6cj0umvemrD3tOsammT6mwMvKBqCZsCc/Qr2K1/1kbIbOTWw2PZI+UBV
	 ULDUfIVSte/LA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 02/47] fbcon: make display_desc a static array in fbcon_startup()
Date: Mon, 22 Jan 2024 12:03:16 +0100
Message-ID: <20240122110401.7289-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

display_desc is a pointer to a RO string. Instead, switch display_desc
to a static array as we are used to. It BTW saves unnecessary 8B on the
stack.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 63af6ab034b5..a8c32cb4c878 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -921,7 +921,7 @@ static void display_to_var(struct fb_var_screeninfo *var,
 
 static const char *fbcon_startup(void)
 {
-	const char *display_desc = "frame buffer device";
+	static const char display_desc[] = "frame buffer device";
 	struct fbcon_display *p = &fb_display[fg_console];
 	struct vc_data *vc = vc_cons[fg_console].d;
 	const struct font_desc *font = NULL;
-- 
2.43.0


