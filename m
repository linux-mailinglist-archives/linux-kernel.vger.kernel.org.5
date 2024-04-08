Return-Path: <linux-kernel+bounces-135885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635CA89CC9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C061C21931
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44312146583;
	Mon,  8 Apr 2024 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoYOqUDb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805291DDD6;
	Mon,  8 Apr 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605708; cv=none; b=boCI0uP/AYOGPftGt0kfjVl3bc5FmtVFjFW2YicNwm8T+sOg8KEddR/auj/90LyAuZs/ZTexORI6zEEDYOO9+JShLcP8TEpoSF5jvsmIhtpkiF8t7elPvbNwmfeabDMhZ/lM1+AzisvLwBEEiLTk7JcQnDVL5E424Ta7BkMC7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605708; c=relaxed/simple;
	bh=G1yDRw2cGcmj3SgEMjIktGBqnDyqi9a//n2mgyTtQas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jGMMu/Te6RlFH6DlzKnFp+4jBkuJBE6G8TUpooJ4WTv+w55d6eY7vggwY5M9bsHSR3+ly5aqw/2Cap8VbSdwwV+RJJ3sjiRa+fCofF+14Wnsb/6pNluFPVRFGwQPBDv6PPoJcwVi+n0J2PzR6+tRF1DRAOBfPv31w8Esy74Ht14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoYOqUDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EF7C433F1;
	Mon,  8 Apr 2024 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712605708;
	bh=G1yDRw2cGcmj3SgEMjIktGBqnDyqi9a//n2mgyTtQas=;
	h=From:To:Cc:Subject:Date:From;
	b=LoYOqUDbfx1xNFCsNMnAFyBW96z8s8aBHRpiKE2MwIdZyw6jMXosGQ+fVQEDy6sRj
	 uroHu3rW3pEwcvDWmlJjMCmZIyp4pZVzH2iw4fVwuxmi9nRsBc2MqO6laPdXc4LD1M
	 0cCZpL9XRETSJqbgJn5cNE4JNzboilMYcoAsMal8eIwNIjSqKPzObQRBl3B3peq7HT
	 RRXpwMMCmOZWFYyZamj/ws24MsbmcwGOCHDaNDCMZf4RZOqdRgsnpIFl5CsQD7vfj7
	 H44E3xqbMumPYnARc0enRqbIom3jzT+btTdZNRnlOS6qzG+r8MMS2elFN1yxk6lT/p
	 oripfHjywJsmA==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [v2] staging: rts5208: replace weird strncpy() with memcpy()
Date: Mon,  8 Apr 2024 21:48:09 +0200
Message-Id: <20240408194821.3183462-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The code originally had a memcpy() that would overread the source string,
and commit 88a5b39b69ab ("staging/rts5208: Fix read overflow in memcpy")
fixed this but introduced the warning about truncation in the process.

As Dan points out, the final space in the inquiry_string always gets
cut off, so remove it here for clarity, leaving exactly the 28 non-NUL
characters that can get copied into the output. In the 'pro_formatter_flag'
this is followed by another 20 bytes from the 'formatter_inquiry_str'
array, but there the output never contains a NUL-termination, and the
length is known, so memcpy() is the more logical choice.

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/lkml/695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove unneeded space byte from input string for clarity,
    rework changelog text
---
 drivers/staging/rts5208/rtsx_scsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index 08bd768ad34d..c27cffb9ad8f 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -463,10 +463,10 @@ static unsigned char formatter_inquiry_str[20] = {
 static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 {
 	unsigned int lun = SCSI_LUN(srb);
-	char *inquiry_default = (char *)"Generic-xD/SD/M.S.      1.00 ";
-	char *inquiry_sdms =    (char *)"Generic-SD/MemoryStick  1.00 ";
-	char *inquiry_sd =      (char *)"Generic-SD/MMC          1.00 ";
-	char *inquiry_ms =      (char *)"Generic-MemoryStick     1.00 ";
+	char *inquiry_default = (char *)"Generic-xD/SD/M.S.      1.00";
+	char *inquiry_sdms =    (char *)"Generic-SD/MemoryStick  1.00";
+	char *inquiry_sd =      (char *)"Generic-SD/MMC          1.00";
+	char *inquiry_ms =      (char *)"Generic-MemoryStick     1.00";
 	char *inquiry_string;
 	unsigned char sendbytes;
 	unsigned char *buf;
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


