Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615F3798D37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbjIHSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbjIHSTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEAE1FFA;
        Fri,  8 Sep 2023 11:18:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38509C116D6;
        Fri,  8 Sep 2023 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197021;
        bh=kLeY+TwhtPWyUHBrbEncXkdzjNGPZwO+tjpTfzz4t2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4rn3a9qr8ROYmHLAd6rhZPs7bwE1hgGg6mswBGCahsEPy6iXMFz3uoCKJKbinwfC
         /LOi53+nzi0QMtfcHf8rfjAfuQnMXo5lHACsdvV+xSFPPqre8143Td7q1Dwe8Jyf/H
         lUb8Na+lCmQk+cwTESpqwSBZ6w+C0fIAdYBVs65Ph7z93qO6ZRbLBnMjNbKPbIoPml
         9ALl+7cO1Aongu8PK8ERonoaHWFdwFaqlfydfiEQZNyS+VlTHIGOTOUDEv3fTeM8ec
         GAlTqrSkPQrsbL0GTtPkdZcfYikiX6yEm7DgBgXvgPcXF16G2JKp1Gr0bS1d/jLden
         m0B1f+JHLKFeg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 25/41] tpm_tis: Resend command to recover from data transfer errors
Date:   Fri,  8 Sep 2023 14:15:39 -0400
Message-Id: <20230908181555.3459640-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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
index b95963095729a..f4c4c027b062d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -512,10 +512,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
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

