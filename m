Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1180F5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjLLSqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLLSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:45:58 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93724BD;
        Tue, 12 Dec 2023 10:46:00 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 75F891615D3;
        Tue, 12 Dec 2023 19:45:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1702406758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PH4Nxd16xStWiZuuxjImDPN++M8DPFUAF0/K65x7Kso=;
        b=Fo8vtGA2va5Fn7rKWhr7Are1TPyx47Baf2hG9uZW8V28u15TJzVda0bG5Fy8iesduCNnyl
        0hDUovBt9LbtF5bFG3Y7ISn+iASm50sAIVEwojWSX4E/XVdOQ+EizZquMDoVXdmQLATdf2
        scENFXl8ENDMTXaMsDuQQlyBoDIdaoA=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Heidelberg <david@ixit.cz>,
        Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] powerpc/fsl: fix the schema check errors for fsl,tmu-calibration
Date:   Tue, 12 Dec 2023 19:44:58 +0100
Message-ID: <20231212184515.82886-2-david@ixit.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl,tmu-calibration is in u32-matrix. Use matching property syntax.
No functional changes. Fixes warnings as:
$ make dtbs_check
...
arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml: tmu@30260000: fsl,tmu-calibration:0: Additional items are not allowed (1, 41, 2, 47, 3, 53, 4, 61, 5, 67, 6, 75, 7, 81, 8, 87, 9, 95, 10, 103, 11, 111
, 65536, 27, 65537, 35, 65538, 43, 65539, 51, 65540, 59, 65541, 67, 65542, 75, 65543, 85, 65544, 93, 65545, 103, 65546, 112, 131072, 23, 131073, 35, 131074, 45, 131075, 55, 131076, 65, 131077, 75, 131078, 87, 13
1079, 99, 131080, 111, 196608, 21, 196609, 33, 196610, 45, 196611, 57, 196612, 69, 196613, 83, 196614, 95, 196615, 113 were unexpected)
        From schema: Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
...

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi | 79 +++++++++++----------
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 71 +++++++++---------
 2 files changed, 76 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index d552044c5afc..aa5152ca8120 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -367,45 +367,46 @@ tmu: tmu@f0000 {
 		reg = <0xf0000 0x1000>;
 		interrupts = <18 2 0 0>;
 		fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x30061>;
-		fsl,tmu-calibration = <0x00000000 0x0000000f
-				       0x00000001 0x00000017
-				       0x00000002 0x0000001e
-				       0x00000003 0x00000026
-				       0x00000004 0x0000002e
-				       0x00000005 0x00000035
-				       0x00000006 0x0000003d
-				       0x00000007 0x00000044
-				       0x00000008 0x0000004c
-				       0x00000009 0x00000053
-				       0x0000000a 0x0000005b
-				       0x0000000b 0x00000064
-
-				       0x00010000 0x00000011
-				       0x00010001 0x0000001c
-				       0x00010002 0x00000024
-				       0x00010003 0x0000002b
-				       0x00010004 0x00000034
-				       0x00010005 0x00000039
-				       0x00010006 0x00000042
-				       0x00010007 0x0000004c
-				       0x00010008 0x00000051
-				       0x00010009 0x0000005a
-				       0x0001000a 0x00000063
-
-				       0x00020000 0x00000013
-				       0x00020001 0x00000019
-				       0x00020002 0x00000024
-				       0x00020003 0x0000002c
-				       0x00020004 0x00000035
-				       0x00020005 0x0000003d
-				       0x00020006 0x00000046
-				       0x00020007 0x00000050
-				       0x00020008 0x00000059
-
-				       0x00030000 0x00000002
-				       0x00030001 0x0000000d
-				       0x00030002 0x00000019
-				       0x00030003 0x00000024>;
+		fsl,tmu-calibration =
+				<0x00000000 0x0000000f>,
+				<0x00000001 0x00000017>,
+				<0x00000002 0x0000001e>,
+				<0x00000003 0x00000026>,
+				<0x00000004 0x0000002e>,
+				<0x00000005 0x00000035>,
+				<0x00000006 0x0000003d>,
+				<0x00000007 0x00000044>,
+				<0x00000008 0x0000004c>,
+				<0x00000009 0x00000053>,
+				<0x0000000a 0x0000005b>,
+				<0x0000000b 0x00000064>,
+
+				<0x00010000 0x00000011>,
+				<0x00010001 0x0000001c>,
+				<0x00010002 0x00000024>,
+				<0x00010003 0x0000002b>,
+				<0x00010004 0x00000034>,
+				<0x00010005 0x00000039>,
+				<0x00010006 0x00000042>,
+				<0x00010007 0x0000004c>,
+				<0x00010008 0x00000051>,
+				<0x00010009 0x0000005a>,
+				<0x0001000a 0x00000063>,
+
+				<0x00020000 0x00000013>,
+				<0x00020001 0x00000019>,
+				<0x00020002 0x00000024>,
+				<0x00020003 0x0000002c>,
+				<0x00020004 0x00000035>,
+				<0x00020005 0x0000003d>,
+				<0x00020006 0x00000046>,
+				<0x00020007 0x00000050>,
+				<0x00020008 0x00000059>,
+
+				<0x00030000 0x00000002>,
+				<0x00030001 0x0000000d>,
+				<0x00030002 0x00000019>,
+				<0x00030003 0x00000024>;
 		#thermal-sensor-cells = <1>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index ad0ab33336b8..776788623204 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -447,41 +447,42 @@ tmu: tmu@f0000 {
 		reg = <0xf0000 0x1000>;
 		interrupts = <18 2 0 0>;
 		fsl,tmu-range = <0xa0000 0x90026 0x8004a 0x1006a>;
-		fsl,tmu-calibration = <0x00000000 0x00000025
-				       0x00000001 0x00000028
-				       0x00000002 0x0000002d
-				       0x00000003 0x00000031
-				       0x00000004 0x00000036
-				       0x00000005 0x0000003a
-				       0x00000006 0x00000040
-				       0x00000007 0x00000044
-				       0x00000008 0x0000004a
-				       0x00000009 0x0000004f
-				       0x0000000a 0x00000054
-
-				       0x00010000 0x0000000d
-				       0x00010001 0x00000013
-				       0x00010002 0x00000019
-				       0x00010003 0x0000001f
-				       0x00010004 0x00000025
-				       0x00010005 0x0000002d
-				       0x00010006 0x00000033
-				       0x00010007 0x00000043
-				       0x00010008 0x0000004b
-				       0x00010009 0x00000053
-
-				       0x00020000 0x00000010
-				       0x00020001 0x00000017
-				       0x00020002 0x0000001f
-				       0x00020003 0x00000029
-				       0x00020004 0x00000031
-				       0x00020005 0x0000003c
-				       0x00020006 0x00000042
-				       0x00020007 0x0000004d
-				       0x00020008 0x00000056
-
-				       0x00030000 0x00000012
-				       0x00030001 0x0000001d>;
+		fsl,tmu-calibration =
+				<0x00000000 0x00000025>,
+				<0x00000001 0x00000028>,
+				<0x00000002 0x0000002d>,
+				<0x00000003 0x00000031>,
+				<0x00000004 0x00000036>,
+				<0x00000005 0x0000003a>,
+				<0x00000006 0x00000040>,
+				<0x00000007 0x00000044>,
+				<0x00000008 0x0000004a>,
+				<0x00000009 0x0000004f>,
+				<0x0000000a 0x00000054>,
+
+				<0x00010000 0x0000000d>,
+				<0x00010001 0x00000013>,
+				<0x00010002 0x00000019>,
+				<0x00010003 0x0000001f>,
+				<0x00010004 0x00000025>,
+				<0x00010005 0x0000002d>,
+				<0x00010006 0x00000033>,
+				<0x00010007 0x00000043>,
+				<0x00010008 0x0000004b>,
+				<0x00010009 0x00000053>,
+
+				<0x00020000 0x00000010>,
+				<0x00020001 0x00000017>,
+				<0x00020002 0x0000001f>,
+				<0x00020003 0x00000029>,
+				<0x00020004 0x00000031>,
+				<0x00020005 0x0000003c>,
+				<0x00020006 0x00000042>,
+				<0x00020007 0x0000004d>,
+				<0x00020008 0x00000056>,
+
+				<0x00030000 0x00000012>,
+				<0x00030001 0x0000001d>;
 		#thermal-sensor-cells = <1>;
 	};
 
-- 
2.43.0

