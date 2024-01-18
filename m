Return-Path: <linux-kernel+bounces-29800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2118313C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7BCB25542
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB925779;
	Thu, 18 Jan 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHJi7AO1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8025767;
	Thu, 18 Jan 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564707; cv=none; b=nQhP00zaVE/32Nkz0H3wZM3ki7cfCBQNbKpkSz92w1mlhcfXEqXM1IdIsUchYlVxad6xbASh8eo/KB0Y/UuBlcsO3OBXmInc++YYi6ZW26TzSqMQCh6RV7sN66iGqJtHEdx/FqJI/Qgrp8iSLoKIbeLUgVAJpPJ05AX7gYSgUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564707; c=relaxed/simple;
	bh=xmX1GzocGEugxu/cnlcvvwjE5Bbm+09jL2ht7Rb2p+g=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=kCbPm6ukr/ZFj4ZVMf4FC4ijfAr5aE1f+Vnf1oNbHTnlM4TkvGL0ffCf2iAtcPgFyX+DWRcjX0wL7H5Ufn71OUhYNCoEUYtGiAHaiSs1ppcW+W7rg2NWgSd6N8Lchik6TcFTCgPoMQVA577g82aDKt1kGzv/bodg104fUvAi/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHJi7AO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C00C43390;
	Thu, 18 Jan 2024 07:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564707;
	bh=xmX1GzocGEugxu/cnlcvvwjE5Bbm+09jL2ht7Rb2p+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHJi7AO1PNdvAsN7hDS1juOpdy9ki5ylj3fmAxuqH+AYBbTbF1FsFXF/9gdbMaSwT
	 1U1PjhFNjAx7ZTgbwRmrs7u8lR263THO5/wK2K7NSrqomwLoE0Q/1UU3DN76FAEqMp
	 hkn3FyJY9I5EPye8XJ0z2C1EdGFMIYpna0B7kYZnbYNi2zfOLKvfpgtJrpvlDkBLlW
	 4smxs9ZspcFIOKluQwaIcYRXM4lCf53SejjCr7sjm+LGzhK9c3E/I/IwHuVbsWlNM8
	 QL3UH9MLnS7P938tg942WbkgoVh0cgfFTGFdy1VAqkkBCCoSps32QBYIYOlBGn55Rs
	 /txVwh+wAeZbQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 13/45] tty: vt: define an enum for CSI+K codes
Date: Thu, 18 Jan 2024 08:57:24 +0100
Message-ID: <20240118075756.10541-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decrypt the constant values by proper enum names. This time in csi_K().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 22ef7366c155..3e3ec9c28f26 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1542,6 +1542,12 @@ static void csi_J(struct vc_data *vc, int vpar)
 	vc->vc_need_wrap = 0;
 }
 
+enum {
+	CSI_K_CURSOR_TO_LINEEND		= 0,
+	CSI_K_LINESTART_TO_CURSOR	= 1,
+	CSI_K_LINE			= 2,
+};
+
 static void csi_K(struct vc_data *vc, int vpar)
 {
 	unsigned int count;
@@ -1549,15 +1555,15 @@ static void csi_K(struct vc_data *vc, int vpar)
 	int offset;
 
 	switch (vpar) {
-		case 0:	/* erase from cursor to end of line */
+		case CSI_K_CURSOR_TO_LINEEND:
 			offset = 0;
 			count = vc->vc_cols - vc->state.x;
 			break;
-		case 1:	/* erase from start of line to cursor */
+		case CSI_K_LINESTART_TO_CURSOR:
 			offset = -vc->state.x;
 			count = vc->state.x + 1;
 			break;
-		case 2: /* erase whole line */
+		case CSI_K_LINE:
 			offset = -vc->state.x;
 			count = vc->vc_cols;
 			break;
-- 
2.43.0


