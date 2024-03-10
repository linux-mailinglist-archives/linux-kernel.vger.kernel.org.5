Return-Path: <linux-kernel+bounces-98236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B8877722
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF2D28138B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448442C6B2;
	Sun, 10 Mar 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJQ/6/2Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4A2C84F;
	Sun, 10 Mar 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710077607; cv=none; b=qMnz43HpaHG+GnhqOgkTHQiE2ak4hrw8FK253KP4tu1B807mFruIAXFTBurepkUV2w/0q0YbKepP+/T7PnXO/RpWTOgdT6gU05vBiq4oOnTmMyCsrDl0/O6TrUWk7km6VLCbngckcWkKf/jLxsixWLclBamN0oUw16KfyYNTpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710077607; c=relaxed/simple;
	bh=tgwEiueuYpMxSCeORO8yfeV2fLM5R+vKqlL01popFYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZlM1leSi0Xg3CL02IOlaN67hRkqMKIOzPL+OISZIH3aAGlihicsJ+b6oSDDzvyHfN5qN3pa+r+Pqf2gLBIL8D5QjPrCrgzHE81cip4usVJmFJegbwCz4OcMtExf5YPUIoEBxnuhvu9Tv9NbKtvmVq5GYdSzxqthPXoQae7beBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJQ/6/2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647C4C433F1;
	Sun, 10 Mar 2024 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710077607;
	bh=tgwEiueuYpMxSCeORO8yfeV2fLM5R+vKqlL01popFYE=;
	h=From:To:Cc:Subject:Date:From;
	b=IJQ/6/2YiPqLS3cVEX/FnjssB2BodDRAwwAhy67bsiMIsATFCje2PGvaKj/6WZdVN
	 zkU/UKdonCQrVCpajbMW5DhdVSXa++tNdb/Z2fsMWaEyfjr6xgwFQcxM+OaeX7RTMg
	 fvMwIwCvg+UlZ+GolQVmWXopYhjFJfUzN+Ar0mkVie67Xk1VNf0/NVtvRAEiXYvzjE
	 TboqRL733UY60eURUYhwmDRPVYOZ7sKLQPwSeqTZ24CAHp3+AEGCz87QbjDsnNjJ+1
	 ac2FX/UzKIqsphMdN3TlW5v6UKL315lJccCaE967CkGhGeLIEUGlvnWNnWwlNMwMyw
	 sVxt22SAEZrzw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] kconfig: lxdialog: fix button color for blackbg theme
Date: Sun, 10 Mar 2024 22:32:57 +0900
Message-Id: <20240310133258.443787-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For MENUCONFIG_COLOR=blackbg, the text in inactive buttons is invisible
because both the foreground and background are black.

Change the foreground color to white and remove the highlighting.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lxdialog/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 3f78fb265136..d5315315b066 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -101,7 +101,7 @@ static void set_blackbg_theme(void)
 	DLG_COLOR(button_key_active,     COLOR_YELLOW, COLOR_RED,   true);
 	DLG_COLOR(button_key_inactive,   COLOR_RED,    COLOR_BLACK, false);
 	DLG_COLOR(button_label_active,   COLOR_WHITE,  COLOR_RED,   false);
-	DLG_COLOR(button_label_inactive, COLOR_BLACK,  COLOR_BLACK, true);
+	DLG_COLOR(button_label_inactive, COLOR_WHITE,  COLOR_BLACK, false);
 
 	DLG_COLOR(inputbox,         COLOR_YELLOW, COLOR_BLACK, false);
 	DLG_COLOR(inputbox_border,  COLOR_YELLOW, COLOR_BLACK, false);
-- 
2.40.1


