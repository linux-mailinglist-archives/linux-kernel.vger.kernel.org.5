Return-Path: <linux-kernel+bounces-123018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94CF89011D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE4B1C2B293
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2AC81AD0;
	Thu, 28 Mar 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvgGl0TD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C364CF2;
	Thu, 28 Mar 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634777; cv=none; b=N6LDImQxgNaMV0+lwvlDJwc452zGUvT/bMu5Uxglid2AgKjLOxvKJ/hegRMG+hEpslCCPQ3pYomMaSTwn8zKChDRmyEQ+0xjdxrNWUnqmC5oLwj+8Im16vbWREGRW6o67FrwRwHPi6iyJS/DFlofMvUboLvSrJ5ysmg/vwjLBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634777; c=relaxed/simple;
	bh=gMylBYrmATWxZ5d+8c6bGwHQWzKICTyrQtHLw9Ti9DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mY01wL1joDaulSCGlZUM0WzKJdp+1LUfvS5sNeMBR5vadawt92wxcpdTi4cuOQ47z5HyueAk6PWNQRFX3a7j89TwzpNvEmpYAUMUg2WDyW98rv976D33ijTCF9WGrAwBcm1fOE9X1kaRfQkAitUm6dBt5Yoh1mgVbge5Kwwe/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvgGl0TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03422C433F1;
	Thu, 28 Mar 2024 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634776;
	bh=gMylBYrmATWxZ5d+8c6bGwHQWzKICTyrQtHLw9Ti9DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvgGl0TDBH4Ei13F0xA5j1Dfi29LBEHXzAToRTsK1pdtLFjbATzWe3pQeWq+zBVor
	 UngHRavlLa7Kx+dH+Url/3wWbJBbf+ONDpKI6iD4QryPFLU/QRK0CIL+GskjFmnmAj
	 NDobSqFxZdaTwUiu2SPQs0Uv0cBon2FlTQHVpdyrYy/A+xkKcZRSXQFM8hFRTrZP/B
	 aSUEvlkgaI6UFqLUO4qJY8U3YaA/+mAFTEyrbookmYAnyvXBQ6NK8QHF6ScRnRKfFY
	 xaCnYXF4xKEEEGuLweImK3fUKVGSnFVu/QnifeXWS8U2U21eNv4cOLmP9p3qYTMlMV
	 HDe91isEP5b3Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Micay <danielmicay@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev
Subject: [PATCH 03/11] staging: replace weird strncpy() with memcpy()
Date: Thu, 28 Mar 2024 15:04:47 +0100
Message-Id: <20240328140512.4148825-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When -Wstringop-truncation is enabled, gcc finds a function that
always does a short copy:

In function 'inquiry',
    inlined from 'rtsx_scsi_handler' at drivers/staging/rts5208/rtsx_scsi.c:3210:12:
drivers/staging/rts5208/rtsx_scsi.c:526:17: error: 'strncpy' output truncated copying between 1 and 28 bytes from a string of length 28 [-Werror=stringop-truncation]
  526 |                 strncpy(buf + 8, inquiry_string, sendbytes - 8);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since the actual size of the copy is already known at this point, just
copy the bytes directly and skip the length check and zero-padding.

This partially reverts an earlier bugfix that replaced the original
incorrect memcpy() with a less bad strncpy(), but it now also avoids
the original overflow.

Fixes: 88a5b39b69ab ("staging/rts5208: Fix read overflow in memcpy")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rts5208/rtsx_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index 08bd768ad34d..a73b0959f5a9 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (sendbytes > 8) {
 		memcpy(buf, inquiry_buf, 8);
-		strncpy(buf + 8, inquiry_string, sendbytes - 8);
+		memcpy(buf + 8, inquiry_string, min(sendbytes, 36) - 8);
 		if (pro_formatter_flag) {
 			/* Additional Length */
 			buf[4] = 0x33;
-- 
2.39.2


