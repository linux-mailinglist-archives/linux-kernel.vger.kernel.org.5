Return-Path: <linux-kernel+bounces-119220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D588C5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB32EB21F60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6513C68E;
	Tue, 26 Mar 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK+MeDxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347013C67A;
	Tue, 26 Mar 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464711; cv=none; b=oWkRkzTInpQvZOVxz8eeYTEOpLgOyFKGxJQxzw58rtRyxStTrOLHCq84dlGNfFy+aINFpicFPTxDuKPfqIR3EVJdxQCyvaNNZscfxfFDEApGM7VIoWETcKIHX6w+wrSlv5AreP/YOewapzORJ7tDAOpLA0fnvfjkwxdX66RFfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464711; c=relaxed/simple;
	bh=sLOSA2H/JQY11OMFy/vZi8SPun9a9NZx8PpmPt3viRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWPQ6s4FuKis5Iw1H7gO8llPBCvJUFquK0fb2wg9/5/98PG0lDlfuncwhvPEab5l0VHYldhUJaKWGaBUuL9laAOLmTOVTuBm0+YcE2q1dDbBfQjT2AMWkjULnIg0Gn35xCn7Jqic2MGh1JHOX0UB1ZPTOwBKbAXvNRe25/Rnq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK+MeDxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940B0C433C7;
	Tue, 26 Mar 2024 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464711;
	bh=sLOSA2H/JQY11OMFy/vZi8SPun9a9NZx8PpmPt3viRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XK+MeDxFWZSbU6Ztv/eTdl1O/MnMn2rltqtau5hHB0cLkDe7/0lgQsYebdu+ZMaWj
	 gYfcd/V3fwWCe40+c2Dd/WXqk0Uks4jufr4q4NIftomOghORvFssfU9cEyW+4sam0K
	 fehwCZcCyAVYlqX9wkIjY1swNhL8xblyq1JFo2tHESrKu1L3Eub1YWn6hmkGIfyoNK
	 K6SBdMvai+sEru3XlLS9YUn26FOLy5hihlrzfR6Wq/jaE2RqUK35YdYdGQuoQdRnwI
	 iSMGE/C9kpCESavZGDZLmDtWJNiNcE16ix6ckFvld3zeM9xdIgirEDvF7UyQFVBYUo
	 hgUpqwR97s+Cw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] [v3] parport: mfc3: avoid empty-body warning
Date: Tue, 26 Mar 2024 15:51:27 +0100
Message-Id: <20240326145140.3257163-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

on m68k builds, the mfc3 driver causes a warning about an empty if() block:

drivers/parport/parport_mfc3.c: In function 'control_pc_to_mfc3':
drivers/parport/parport_mfc3.c:106:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]

Remove it in favor of a simpler comment.

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://lore.kernel.org/lkml/20230727122448.2479942-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: no changes, resending
v2: fix typo
---
 drivers/parport/parport_mfc3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index f4d0da741e85..bb1817218d7b 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -102,8 +102,7 @@ static unsigned char control_pc_to_mfc3(unsigned char control)
 		ret |= 128;
 	if (control & PARPORT_CONTROL_AUTOFD) /* AUTOLF */
 		ret &= ~64;
-	if (control & PARPORT_CONTROL_STROBE) /* Strobe */
-		/* Handled directly by hardware */;
+	/* PARPORT_CONTROL_STROBE handled directly by hardware */
 	return ret;
 }
 
-- 
2.39.2


