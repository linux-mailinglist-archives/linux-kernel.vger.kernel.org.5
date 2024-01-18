Return-Path: <linux-kernel+bounces-29825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD583141C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AB4B2656B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D217321A9;
	Thu, 18 Jan 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO+yOELZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436931A9A;
	Thu, 18 Jan 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564767; cv=none; b=sxC058dPq+nRNAcoJFecN9cz3Oht1Qmrl/CIisYjk1I6X68qnTJkRFSFgf5WuPvv5qk2d0lSb8Ya9fzk1PkVETLeaIi9x/rt6e//vBYWJ3cTgejQp1kjZVJO1AE8mI5FitPF0dqbTp06fI2Knh4PDZJ/cNdo7jLyfcm+emTg+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564767; c=relaxed/simple;
	bh=ySZcU9jF42JuV+7z6emCEUbJtD0/5xrFJi0CmG4Ho7Y=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Kb32kyjbrRZIUh7lB3U4MQAxRUBNpZA1OZFMFHU0tjmTG85VpjWYiViAsVAxd1P640H+7hgaZ4Oygph6GJj0vXdlRsqq2vqkSg9M+CtRCzoM/pdmXcjA5fTgohxxMXsntMBN4MosWpw5FcNzWoIEv34e0btvec+TIt0asw47+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO+yOELZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB092C43390;
	Thu, 18 Jan 2024 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564767;
	bh=ySZcU9jF42JuV+7z6emCEUbJtD0/5xrFJi0CmG4Ho7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EO+yOELZvBiaXuPeIQ9rss9TXpxzH4LELNUO3Np+v3e7EUGgOKCuB2lrBJcUpsW8x
	 hNclnoABAbqcFqGlXTsavzxPWVnmVaFbUlB35ov7q6E0NNbJhbLFRTE1A2iR0e2jD6
	 qG9yS77hcXvr8TAZlZWn4m6J4KmKEpWsKS2gWrOEGVHWZtuJ91z95BvuZInQ44935A
	 Uu7KiTl4Hx81EsUip2XTR7j9zeEzlIS2ihqshlB6PN8fsmKsC9QLC3DsupNbVX5X4E
	 J8RCadSx1IzB1Trhax9PZSE2MrufdHM31/YaBCV55QvTTHTrzycTu8DHNF9VkK2xLb
	 Gm5kpri/1r8xw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 38/45] tty: vt: remove consw::con_screen_pos()
Date: Thu, 18 Jan 2024 08:57:49 +0100
Message-ID: <20240118075756.10541-39-jirislaby@kernel.org>
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

After the previous patch, nobody sets that hook. So drop it completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c     | 12 +++---------
 include/linux/console.h |  1 -
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 196c849ca492..b41ecf3a5fc7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -289,15 +289,9 @@ static inline bool con_should_update(const struct vc_data *vc)
 static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
 		bool viewed)
 {
-	unsigned short *p;
-	
-	if (!viewed)
-		p = (unsigned short *)(vc->vc_origin + offset);
-	else if (!vc->vc_sw->con_screen_pos)
-		p = (unsigned short *)(vc->vc_visible_origin + offset);
-	else
-		p = vc->vc_sw->con_screen_pos(vc, offset);
-	return p;
+	unsigned long origin = viewed ? vc->vc_visible_origin : vc->vc_origin;
+
+	return (unsigned short *)(origin + offset);
 }
 
 static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigned int x)
diff --git a/include/linux/console.h b/include/linux/console.h
index c07e1ce6bd14..2c8a77865437 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -104,7 +104,6 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	u16    *(*con_screen_pos)(const struct vc_data *vc, int offset);
 	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
 			int *px, int *py);
 	/*
-- 
2.43.0


