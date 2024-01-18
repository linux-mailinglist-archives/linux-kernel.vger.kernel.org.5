Return-Path: <linux-kernel+bounces-29789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4450A83138A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F6FB23FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431D014AAF;
	Thu, 18 Jan 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzV9XM2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307C13AF9;
	Thu, 18 Jan 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564687; cv=none; b=olLEPREOyn+nG3nMG7TBU/TPKmLDxkWYRfnBfmU6T9BAM0DjnoG/eZompQZqb6lob3y0BVTW6T/nkAgv8gYC395rX4XxS9K8Lxh7nDAxxgPQ2xcnkqMYnvCk5EqMetAJJZTZzlhrw3m5Fex+Ovr1qchsBlTcanMKYd1Qxz+u2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564687; c=relaxed/simple;
	bh=VF67ScvZaWBLLIl5rAX1Kh4YdbBo6nKFZPHrtIWu1Y8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Ti+lcsgr/huevKPH6Q0nRQRZXxt3dG/phLHD7Ub7oI3at3oZVWhSeMmyak5ntVFpSxpiSPOtqArarEPkfsK2HwG8a7s/1PPs3Pc7gHCGy1wmm3Sng8fVQXV3xP4IRjANnqzc1k9avo7ABXZx3DwzxNNIoxDWoVG/OQMS7SSbZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzV9XM2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A187C433F1;
	Thu, 18 Jan 2024 07:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564687;
	bh=VF67ScvZaWBLLIl5rAX1Kh4YdbBo6nKFZPHrtIWu1Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzV9XM2oma7CXY2prJ5hO4Kbts/86byd0p9nMAE71rQBKPNnKmCaFUuJhksZ6tiWq
	 A4DeNHDswadUILCIUtRzvkMMFjSHKrClNwXM8YlKPhiey55Ge1Geu35zcySFp7xrIh
	 g3zCt4gtKuBSfXYLHfm1F3DNLjkpXXasYfrY1gwsZlY8A+rb5ZRiJ8hYADBevSK/GZ
	 wecsF4s50veThCCoCiLIMPItmjENtSJPPTaH2HzrGfrJLUeZlQxmNwskMoH/eQTHbz
	 LJ6oISId7gI8Gz4YxFtwAYrDidRreY6Ay3kys2ZXctW2eftCVbxdgvPa/XN6HosL4a
	 /5zquQEqoeZSA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 02/45] fbcon: make display_desc a static array in fbcon_startup()
Date: Thu, 18 Jan 2024 08:57:13 +0100
Message-ID: <20240118075756.10541-3-jirislaby@kernel.org>
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


