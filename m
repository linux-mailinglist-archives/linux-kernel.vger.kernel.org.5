Return-Path: <linux-kernel+bounces-29808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD518313E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE74B25263
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBC2C6AA;
	Thu, 18 Jan 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXWNLegc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317D2C688;
	Thu, 18 Jan 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564725; cv=none; b=gZT4AcYwPokQdX8GnwL/1JRRrf/TCGkfprD0Tf93M5S02JTdKGCyl3aN5nRlrSMFEtJeUzNJLiaeTK5p5WIEmLF4s3u5fXEU1liEIYrIbguM+aWKyrKq2xJ16S6kfdbo83Fjo961vjZPbWy4q0TH7slggpbhxy0LO4Is1K8wbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564725; c=relaxed/simple;
	bh=/HUcPJ1BjPv5GMtQ1xgKekTdrhD9fVd1hk++uDzgCqs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=YHP1gr7+LENbaATnnsS4TlyWbO2OLQvwTdBzLLbB+6huH4xSvb1xPrw5XzNt9j2nDZspAL7wW58sMb5RRLexEnugHUJItI5AjavBydA+DjtAjycGrbbrw4SkjwgNbK6QwcbTEY2O99DVDeQoLAYYSUWMFdzLet+VYqj7Vuw87vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXWNLegc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945FDC43399;
	Thu, 18 Jan 2024 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564724;
	bh=/HUcPJ1BjPv5GMtQ1xgKekTdrhD9fVd1hk++uDzgCqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXWNLegctp3Fhf2lVHyLbqQ/aJ29ru/jxnBhXLxcUeG3r4JMtYk9j4xfNlYHd+92T
	 TGuL3YICbbpazTOXJvANDqXxsOoEmi2aoiU4SeRjhQA9T3QW9Zru/VJUiaU12dXqmW
	 z9zZ/WP7i90YwaMFF/BL0ZPQVCtnXINr25NtGyN9l3wbL6wH/uazpxBY3ZftDPLN7z
	 rnwRkY/dAv36z5XYeHWV3ZGq2MCmc9upg7uRifd4yOQMFAM0KK4PoPSnDE5LxQh7Rm
	 LH4vI/qbrQliMRS59B2Ex0fQMih+DocftSPCivm8a/hwbWEKElqBbZUcnFZk1ZqY05
	 CSonq6VCBsl6w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH 21/45] tty: vt: remove checks for count in consw::con_clear() implementations
Date: Thu, 18 Jan 2024 08:57:32 +0100
Message-ID: <20240118075756.10541-22-jirislaby@kernel.org>
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

'count' in consw::con_clear() is guaranteed to be positive. csi_X() (the
only caller) takes the minimum of the vc parameter (which is at least 1)
and count of characters till the end of the line. The latter is computed
as a subtraction of vc->vc_cols (count) and vc->state.x (offset). So for
the worst case, full line, it is 1.

Therefore, there is no point in checking zero or negative values (width
is now unsigned anyway).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/video/console/mdacon.c | 3 ---
 drivers/video/console/sticon.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 1ddbb6cd5b0c..2ff2c9394d40 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -448,9 +448,6 @@ static void mdacon_clear(struct vc_data *c, unsigned int y, unsigned int x,
 	u16 *dest = mda_addr(x, y);
 	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
 
-	if (width <= 0)
-		return;
-
 	scr_memsetw(dest, eattr, width * 2);
 }
 
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index d99c2a659bfd..b1d972d9a31c 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -303,9 +303,6 @@ static void sticon_deinit(struct vc_data *c)
 static void sticon_clear(struct vc_data *conp, unsigned int sy, unsigned int sx,
 			 unsigned int width)
 {
-    if (!width)
-	return;
-
     sti_clear(sticon_sti, sy, sx, 1, width,
 	      conp->vc_video_erase_char, font_data[conp->vc_num]);
 }
-- 
2.43.0


