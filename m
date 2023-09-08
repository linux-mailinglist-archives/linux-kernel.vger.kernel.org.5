Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE97798D90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbjIHSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjIHSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:21:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C430C3;
        Fri,  8 Sep 2023 11:19:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A40FC116B1;
        Fri,  8 Sep 2023 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197136;
        bh=x07t9AquVDDZ8wPm1iLFiM9WCtFjjsw/1WSYNoDNons=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+e7ZZ1i33VdeGOFJdxK9YiNpQ6Ft8gSqOdWEEai5tMjx3NsdYDiZ/BcRsTbEdwld
         uEpJgOsrmCI8x2mja+Ee0UrHkzo3ueknZN0iYr6akAuy8Oa41ZqNxJ4yZ36wauXAlc
         d7sw/yIsFvXiOxO9zNDspccXYMi1qKNrJoc7toTRc9b7zJO9LaWkRTWROeUPLKpLdu
         yJBYWLWcVKdm0igk955urb5fkUO0aDgFGl+cn0kxG1y5vV2KZl8ZHR1XPapKr5dh+K
         dJn0EUqLfQ0/L4XIZ9U34wBrwKH7+GflbFZpx8Asb30HdPyiIc3ePQlWHTSOiRC6vK
         PtFJSEmoUxStg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/26] tpm_tis: Resend command to recover from data transfer errors
Date:   Fri,  8 Sep 2023 14:17:54 -0400
Message-Id: <20230908181806.3460164-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Steffen <Alexander.Steffen@infineon.com>

[ Upstream commit 280db21e153d8810ce3b93640c63ae922bcb9e8e ]

Similar to the transmission of TPM responses, also the transmission of TPM
commands may become corrupted. Instead of aborting when detecting such
issues, try resending the command again.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 44f71f2c8cfa0..5889d9edaf940 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -498,10 +498,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	int rc;
 	u32 ordinal;
 	unsigned long dur;
+	unsigned int try;
 
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc >= 0)
+			/* Data transfer done successfully */
+			break;
+		else if (rc != -EIO)
+			/* Data transfer failed, not recoverable */
+			return rc;
+	}
 
 	rc = tpm_tis_verify_crc(priv, len, buf);
 	if (rc < 0) {
-- 
2.40.1

