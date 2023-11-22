Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C57F3E74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjKVG5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjKVG5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:57:34 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EDC1AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:57:29 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AAF2A2C0240;
        Wed, 22 Nov 2023 19:57:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1700636246;
        bh=UUf0sol4MXR6E29PQDMqjrVE54IEFrYzEFPblgiH5pk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRT9wru4qojBDGFtQ6OJYF4V6fOwr3mXK2BvNqzAs3NuL+vLdPVsf1aQ7WT9pSJ1B
         qRnqeJmCBDWmx9vrxiBS0gTElbbvJsSxExzRHyU9AUudarO/07ngML9UzvvNcCWSQh
         YrBNaxgcMdT1sQTNa17YnsTn5i6davGXCIAL2WxLnK5ekk/qWZJbdJHZAwU4Rtsa/C
         fy22V1T3NgMaDaY44mR0fDVsB/qZ6XaU1IZnBkcYwzSK4dLT6iVHgj43b5f5CFeK7f
         tyw5CmkC134DRSNOMaL32RHGJpEs48zsgVX2jXt0h2xxZ6ldrbF++C8YGrloGgY3K2
         RjvIrkIGmEmzQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B655da6560000>; Wed, 22 Nov 2023 19:57:26 +1300
Received: from angga-dl.ws.atlnz.lc (angga-dl.ws.atlnz.lc [10.33.22.36])
        by pat.atlnz.lc (Postfix) with ESMTP id 74B5313EDD7;
        Wed, 22 Nov 2023 19:57:26 +1300 (NZDT)
Received: by angga-dl.ws.atlnz.lc (Postfix, from userid 1025)
        id 6F0DD5639F4; Wed, 22 Nov 2023 19:57:26 +1300 (NZDT)
From:   Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
Subject: [PATCH] tpm: Start the tpm2 before running a self test.
Date:   Wed, 22 Nov 2023 19:55:28 +1300
Message-ID: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=AZXP4EfG c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=BNY50KLci1gA:10 a=rJFBBZ_W6pJUP7hz3OAA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before sending a command to attempt the self test, the TPM
may need to be started, otherwise the self test returns
TPM2_RC_INITIALIZE value causing a log as follows:
"tpm tpm0: A TPM error (256) occurred attempting the self test".

Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz=
>
---
 drivers/char/tpm/tpm2-cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 93545be190a5..0530f3b5f86a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -737,15 +737,15 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	if (rc)
 		goto out;
=20
+	rc =3D tpm2_startup(chip);
+	if (rc && rc !=3D TPM2_RC_INITIALIZE)
+		goto out;
+
 	rc =3D tpm2_do_selftest(chip);
 	if (rc && rc !=3D TPM2_RC_INITIALIZE)
 		goto out;
=20
 	if (rc =3D=3D TPM2_RC_INITIALIZE) {
-		rc =3D tpm2_startup(chip);
-		if (rc)
-			goto out;
-
 		rc =3D tpm2_do_selftest(chip);
 		if (rc)
 			goto out;
--=20
2.43.0

