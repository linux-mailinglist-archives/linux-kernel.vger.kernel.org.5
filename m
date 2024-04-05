Return-Path: <linux-kernel+bounces-133181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E884C89A00A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53736283B33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AC16F296;
	Fri,  5 Apr 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcr5P9Z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6116C85B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328190; cv=none; b=qpdBH76CD8notEDpU3ttVyoyLmz7pQ2AxxN7uOrR2LSO9mufpruJSNOzV9bE9jAII6ubrRlSSJO2v32RROFVQrFr/s5iO32FgPVhp3KONiaZ5oaOj5c66jUT7aXQ5gtHUSRa8fsPWJW/nxXmGMUAKcvcH+xOWTOg1QW723ZEzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328190; c=relaxed/simple;
	bh=dtABkso0LSZG2RGcX8jHgM1Ekot+NTaq1ZsNzn+1SL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lzrozM0yQU+Ip/fMCPp1WO+ktYakF3xUiQj/dDH9VsQRIM3NfrW0fvLrUxx8tYCYupFDLQgI1v8x3tP3mPUpFowzaThsPpjjANFCdYalXoLRylQ1C5/Bn8SEAfsVvkh2Akzi+duvPQiJ+L/+M1e2AabweBGZX/4tdqHQTsKUDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcr5P9Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B1EC433C7;
	Fri,  5 Apr 2024 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712328189;
	bh=dtABkso0LSZG2RGcX8jHgM1Ekot+NTaq1ZsNzn+1SL4=;
	h=From:To:Cc:Subject:Date:From;
	b=Lcr5P9Z+BP47g3ZrRyRJuqQxNdyFrQB6OkNYSyeYxsLXikRS6nG7Jp9pg9ZxD77c1
	 aEo+Yw2M9jyvix1ZB67Foi51FOPT3cPwp4drXJbvWucrQjyNBZ4FI+tSD2V3UcOYim
	 rZBF959m/b5PDnQaLQAjXAPeYQz5z6q2857Uvg8SvfETw10ABBwsbYF3qd55t826nI
	 6NWOx2///6T3hQPgYpcfPWH0ds+9QdiX6jh5Ttc0dGdxL08JUVb2ZOjxAlT4Bdf5vI
	 1corVP5yvBSA271ppQU0N3SBjxcRRspcwEZPaBwgHQ2+JKjAN/xVsGzVmx4TBTO/+j
	 b0StK6PIW9vwA==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] parport: mfc3: avoid empty-body warning
Date: Fri,  5 Apr 2024 16:42:57 +0200
Message-Id: <20240405144304.1223160-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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
This one was still missing from my series to enable more warnings by default
in Makefile.extrawarn.

Greg, can you take this through the char-misc tree for 6.10?
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


