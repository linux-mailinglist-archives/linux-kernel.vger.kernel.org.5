Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0370278DF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbjH3Tbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244577AbjH3NYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:24:02 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D4D137
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:23:57 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8E0903F272;
        Wed, 30 Aug 2023 15:23:53 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Wed, 30 Aug 2023 15:23:50 +0200
Subject: [PATCH] firmware: smccc: Export both soc_id functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-smccc_export-v1-1-6ecc7661bc94@somainline.org>
X-B4-Tracking: v=1; b=H4sIAOVC72QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC2MD3eLc5OTk+NSKgvyiEt3ERDOLFItEI1NTY0sloJaCotS0zAqwcdG
 xtbUAodOYyl4AAAA=
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693401833; l=1040;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=jv62ejhR//CO1W8JyTnPBC5mJNMBfMpgPpnjrb0F1bM=;
 b=s6K2nGpp/paQjgFdfS6v5fipmr7ioGdeCcckHHHvFuQUIzS3NiDPrzMa7HLRfxle5oFD8HTpa
 1OF6A13YIGhBlnnbUvm9cEREZkhH/pNetpm0rNZJeRTP/KA08X2VNNi
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm_smccc_get_soc_id_version and arm_smccc_get_soc_id_revision
need to be exported so they can be used by modules.
Currently sun50i cpu freq driver is planning to use these functions.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/firmware/smccc/smccc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index db818f9dcb8e..b4224da46988 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -64,11 +64,13 @@ s32 arm_smccc_get_soc_id_version(void)
 {
 	return smccc_soc_id_version;
 }
+EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_version);
 
 s32 arm_smccc_get_soc_id_revision(void)
 {
 	return smccc_soc_id_revision;
 }
+EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
 
 static int __init smccc_devices_init(void)
 {

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230830-smccc_export-aa68d8a25539

Best regards,
-- 
Martin Botka <martin.botka@somainline.org>

