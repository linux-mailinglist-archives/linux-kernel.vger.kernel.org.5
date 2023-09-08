Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99F6798DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344077AbjIHSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343793AbjIHSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:24:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B649EF;
        Fri,  8 Sep 2023 11:21:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA00C433BA;
        Fri,  8 Sep 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197229;
        bh=gTvBjhblGfOCGq6YxqIkoHtJHRP7ZzQuH4eEA0DNYk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDPrj9Pf4kMr6a9/jA4VEDZDm1LXalmAEmEwMrW2vwPe08KD1dtGpGe6nCpblLPmR
         LBHdeQfurkT9Int1eSjNAS40in9EONzmgCQK1UYCJZL8AuYE85W/HvPKuGz4hJ/lqn
         R7EOggVI6eRQ6zpQ2fKHR6kaZcCyaOzj6n9RnL5rqIG7JJG8aWhvjR7QFHCwHMMGTZ
         dchAlISrJ7WNr6Q3yrzXKVUJQA7t1bXR19PbtuXji3wZvYyp1R93kRsCxwhQzh5hqd
         Fi2gb3ed6ZOpbUljImQgnCDsmJ1tNbxdVQU7xJdFWDqFo5aCP0p6yxTFIdyplgjOkC
         Y1p+MrEVmidLg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/14] tpm_tis: Resend command to recover from data transfer errors
Date:   Fri,  8 Sep 2023 14:19:55 -0400
Message-Id: <20230908182003.3460721-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182003.3460721-1-sashal@kernel.org>
References: <20230908182003.3460721-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
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
 drivers/char/tpm/tpm_tis_core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d7c440ac465f3..b3452259d6e0b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -469,10 +469,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	int rc;
 	u32 ordinal;
 	unsigned long dur;
-
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	unsigned int try;
+
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc >= 0)
+			/* Data transfer done successfully */
+			break;
+		else if (rc != -EIO)
+			/* Data transfer failed, not recoverable */
+			return rc;
+	}
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
-- 
2.40.1

