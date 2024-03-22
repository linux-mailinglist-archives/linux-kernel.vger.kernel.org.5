Return-Path: <linux-kernel+bounces-111656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80023886F21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3257A281F69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4A4AEEA;
	Fri, 22 Mar 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="si7V9sGH"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320C4D134;
	Fri, 22 Mar 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119288; cv=fail; b=dEAOyYbwHDiQem6s75GpLx1LqbU6+YlnIDZuenOlAqRJ9MNvcO//TbwtPogwqls7a+GmL3Pi5JWxgg4nfNhduKOS0FGa0t9F/P4QRtWfuqujRHtqF2iob4J7mw/sCxmiu5hBazXzoRiIzbnyb1vhE0Gh7CMSKukJZEuvd8Nx/9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119288; c=relaxed/simple;
	bh=TeteK8cJBrCIYtjxDfAsLmYamC39DEuU5IbajGIOh/8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OVjypVHJmg3/3cHmAtM7MFATwxVwnSvaLr+v96SyBV4+g5Kq5qH15nwLuUydpAvJ86T87aCA2u6IH+98LsyPhuiyfX8eCu1zwqijhfsElMqsn3JSloppwF8sBoGzhlOSk69exQ+FbOhQrUuvT8+82+jHdbkVS6Sg+D6woMbiknU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=si7V9sGH; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmup1HcDvUmnFnjE8oI+vSCSklGgON5989fLXZQvNQFlblBFp9GrhlLLmRFw9nKrH8Y+NbcEN4ewicD0FjTqApsj8olbHk4jZv5bGz6BZpDKK0deAzVYSsIaL/h3TXFhSc+W8qZpYXuAR71muXC1qEhPfu9FMgP0Q7jj0wOp4ei/p3IFHpVBrrxlrOHyjbNMyFQAy43u2uvNXcNlFimDyQHuKrDY+wawe2F7MkOwlZh5uyBtjRUsDMbmBlKrwWw8e5j93MU8E06jZoSWQK7duOwALlfsTTRXAiGxDQupTEPji+DglZpwBCsU66JApiybL7yplK5ZiDT/WqF9qQAAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SOiV6oiYz8yuAUYVvq69PyZ3PZMVA2Nmb3g0834yas=;
 b=ogJJAIQkEHoo71Yw9Hr/pzxzROj9R9S22XE9RzdUFNo0KH6tJkQhhIN0xfk9EACOKDSM4uhTtD8I30ApMDvZrJzGCSsma9IxfKd+XJNa6Rpm7xHgbx1FACJ5hI4tsPJJYIrTXB98hjQYaefYed0/zc/qvwbby7f3T6xWN8sGffdbS9rmxUGQOkDAf+BxlAJ8V68POyNwa4clIjPhe2jqzppTpihi9059oxQdIPD1GzDeZzKCJ30uRQlz1viQOc0x4tMkw6+GaM+EGxhgDHrap8hHcucwF8TDVPe6Z1ag45J1fDxkGX5YcJ4iX+GRNg84JIs3y9BU4XlrsJ0nNho+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SOiV6oiYz8yuAUYVvq69PyZ3PZMVA2Nmb3g0834yas=;
 b=si7V9sGH3m8nXchNEUA8FNVFDK5jpGznowRA/lx5nRyqxUqPGO1D7PkhEhJwYRZsRQDaxaCop7tsekj8NQ8bkDmdy2L0BC9rCpUz6BOfXQQpCRA2JTOOqEA5L4vF7nwavIQpCJlsjE9FwWneBq1P6TgX7/QnFtponv22ClvO7xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7206.eurprd04.prod.outlook.com (2603:10a6:10:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 22 Mar
 2024 14:54:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 14:54:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to yaml
Date: Fri, 22 Mar 2024 10:54:05 -0400
Message-Id: <20240322145406.2613256-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 240709be-4dc1-4177-4c82-08dc4a8001b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JhpKqMVVzqqVxHGYngmkp3Msg8Cb7Pas1NKlKtuu1pXJY2hEnESbcJgyy9GWzpL2xF1a0dOAncJTqW2UU6xfcIix9VNwAke3NF0p+FEYWgLPx7jG7iARsndBE0AAoiir16+NF+6IpuYJsrzk+54KFUc4D0o3TFqIjqBZyMZ0JrYi+uvH6W4WhgL3qZzACOF8z6QWur7taofBQHHfT7c8dLoR3mQC2y9KYoroDPskhhzZ/qFI767jJFYzx50mvRK7/gZDGCycH5P/JAHLNGjH0HpD3+eqe92olHqWbRAH0NZFHYd/t3OD+Roz0Fz8EhAV+Aq0OPVDXqRTj8IXD/+vagTfCz+Ae4X+UPE7Az/nG0Trin5FEArcfkwSqHoOFX4J/NUL7qHv+4dFQBd/kbjfxOY5SOJj0mEHt7SlOTrOkKMU+RzI/4KSUbWeDQfpQzjht2laAU+6PS5r7qyxS8EoKx8f/JlaeNaClcuI08m2XVKJXcOCH7MCGvqeW2SSGypYQ7+oGgGq3nMQCqhjSWyi1Ka94h+jsicojK5JOoEVscAMLmp8GmUO6D0AMTvurRMIoW/YldxQq7O3gBigqF1mH63iSpYrDITkZr1jXCvdFocW4N37bA9e0EZEagqI0bzTYMzi1xKgaucRD82wv9T2Kn6k96NRfUh2ddS9uUL1TVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdSu6UgqtvEWIIt86VOrpSQZ8Jz0Tkvqf8f7WPFz+haJ7JdyEFwQVmr0vVPr?=
 =?us-ascii?Q?3N6olWD6jEUWOGvoM7USlyjFEt9P0OkOXYdHg1K8wkqIMNbQNMNNPYKF7SsO?=
 =?us-ascii?Q?UY4ITyYn+8UklxvlhYkCfVzyvaW3f+gjJk181m4qw2Tbs50hkC6BnrccW7wa?=
 =?us-ascii?Q?lPD3WFDvg4xIS5eZFYG8PD1ANz71916sdunQDiFxcUlv7lPWEwkdEwc/9uij?=
 =?us-ascii?Q?G9AGRtA0dr8o8dOijMwlSFjqrILKiMre0lWaAhK7IpwPm+aalw6S3JRXSi8D?=
 =?us-ascii?Q?RWFraIRnGNfIJInH9sAuNmnxKAbaQzewzycOAHbttkE5qVUtOSUGEtM1AT0r?=
 =?us-ascii?Q?Fc0FbD4sWQpDeemDZ4QX+UlcSdpreIQzshjGrC8vx4CZh2Rzq1Xo3W8sdLUF?=
 =?us-ascii?Q?wKUfzPMWPq6bZux67CInVtM5hTAmPBn0YiuPQ8IDWt3MRc74uCkonWs2OUmR?=
 =?us-ascii?Q?K+PgYVa9H/sEF12lzenY7ZzLysPbwG1vX7mEd4T6JNH4CGRgvdQKaziEdNar?=
 =?us-ascii?Q?MqEDNXw14afUR1P6XgsN1ApoC6dF6URNEFpfpl3NLF/sGyX/XaOQ/e/cnzoH?=
 =?us-ascii?Q?VDStQsUAFMFwglvnNmtlpXRTWiAbQAgX34UlWA1+7YwNGJXcN+4RtHebEOK/?=
 =?us-ascii?Q?Uymbn56N/dyoia2GVdkYdQErdVorm7HCUgnU8pOek5V1vZs4cJP6VTMaK7lH?=
 =?us-ascii?Q?dnghgi4NPFPbsO55GE52JDnse45NuWcKSyj64dK+QCS/JgupSK3KO5vvINKL?=
 =?us-ascii?Q?GbP6L8DF9Z3+uofn2c0rjtTMDaxKJgQiMwnSsKdYabdF4d+GL6KL+9g4gOJ3?=
 =?us-ascii?Q?C6dFJwlPyvp780V5HPQdy7cD3F0wu1BTcy23dqCJX6yFWR7FbPKXkfRtyW8p?=
 =?us-ascii?Q?NYQlHrgu1QxXqb6iDJc/5KAZQ+WiRt3Sh3uOwBcpD4Y5xKxEVfBKCwCxux56?=
 =?us-ascii?Q?2TbYRvRdeBfY6aT37F/YPalqxcV3dpHYb5anQaP5KL6MD4Uznqttem6dHTuk?=
 =?us-ascii?Q?DaWRJr7QjNwnuy1y8xtoOtDWTBdeVw/U2+/gpXkzYYSAYOzKMbEepxYgqLTV?=
 =?us-ascii?Q?QEo3ULAodLQ29fFFY2uVk9p2tDAe9bUQXj9zS6+92VODUfBlkh927CHXnDvU?=
 =?us-ascii?Q?8BfNbpaqjz3KuH9mbXVFrifrl0nIvjgSwl+7KG+JVYm9hGwtcp9B1XqSjFQb?=
 =?us-ascii?Q?phw0ifX3BtBtpxUrMTOtdoYjFLP1UEoxR6iEX6rQZgQjDXamHPlPLYME8t0y?=
 =?us-ascii?Q?wTwKmeGojs+RRhCwCQbV3ckoBMp7t0h7DrrimEtIDcQWvnVXcS5LmXj0vxx5?=
 =?us-ascii?Q?l6I+tRmzFWT0Feu1Rx/F9T37Kk0E+lMGHxiByM2Z65z/Gw6CoBi+tmyiIoWG?=
 =?us-ascii?Q?MMxRFTryfec/K1uUGUcADsF1KudnikGxEGBtjVCAlHulAGpxA5I3RsWjUzGi?=
 =?us-ascii?Q?Yt1JY18/JWFJN604miKek0ofghJ2OBMOMtCUjGmBqXqaBaIdmVYVb/uaYRsA?=
 =?us-ascii?Q?2tglk4hNxs5m973FzMwifBU6s9Wn6AhQa6yXl3oXoLIn+zpmk5QU/ELKsHwR?=
 =?us-ascii?Q?JIv3J4W3EYRkAH/XQkl5KdW+3pOu7IFobNg5HtMB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240709be-4dc1-4177-4c82-08dc4a8001b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:54:42.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVaNkMDi2BUwAjjv9mek32CFIpEY9J8/5ZzOPOMGkuCptt80SgxJGDTxEYRVjBVFZxFosrcorClHVRi0f2LcQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7206

Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file about
esai part.

clock-names 'spba' is optional according to description. So minItems of
clocks and clock-names is 3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - alphabetical order compatible string according to rob's suggestion
    - clock description move under 'clock' according to kryszof's suggestion
    - fix descritpion indent according to rob's suggestion
    
    Pass dt_binding check
     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
      DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
      LINT    Documentation/devicetree/bindings
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb

 .../devicetree/bindings/sound/fsl,esai.txt    |  68 ----------
 .../devicetree/bindings/sound/fsl,esai.yaml   | 116 ++++++++++++++++++
 2 files changed, 116 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
deleted file mode 100644
index 90112ca1ff423..0000000000000
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-Freescale Enhanced Serial Audio Interface (ESAI) Controller
-
-The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
-for serial communication with a variety of serial devices, including industry
-standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
-other DSPs. It has up to six transmitters and four receivers.
-
-Required properties:
-
-  - compatible		: Compatible list, should contain one of the following
-			  compatibles:
-			  "fsl,imx35-esai",
-			  "fsl,vf610-esai",
-			  "fsl,imx6ull-esai",
-			  "fsl,imx8qm-esai",
-
-  - reg			: Offset and length of the register set for the device.
-
-  - interrupts		: Contains the spdif interrupt.
-
-  - dmas		: Generic dma devicetree binding as described in
-			  Documentation/devicetree/bindings/dma/dma.txt.
-
-  - dma-names		: Two dmas have to be defined, "tx" and "rx".
-
-  - clocks		: Contains an entry for each entry in clock-names.
-
-  - clock-names		: Includes the following entries:
-	"core"		  The core clock used to access registers
-	"extal"		  The esai baud clock for esai controller used to
-			  derive HCK, SCK and FS.
-	"fsys"		  The system clock derived from ahb clock used to
-			  derive HCK, SCK and FS.
-	"spba"		  The spba clock is required when ESAI is placed as a
-			  bus slave of the Shared Peripheral Bus and when two
-			  or more bus masters (CPU, DMA or DSP) try to access
-			  it. This property is optional depending on the SoC
-			  design.
-
-  - fsl,fifo-depth	: The number of elements in the transmit and receive
-			  FIFOs. This number is the maximum allowed value for
-			  TFCR[TFWM] or RFCR[RFWM].
-
-  - fsl,esai-synchronous: This is a boolean property. If present, indicating
-			  that ESAI would work in the synchronous mode, which
-			  means all the settings for Receiving would be
-			  duplicated from Transmission related registers.
-
-Optional properties:
-
-  - big-endian		: If this property is absent, the native endian mode
-			  will be in use as default, or the big endian mode
-			  will be in use for all the device registers.
-
-Example:
-
-esai: esai@2024000 {
-	compatible = "fsl,imx35-esai";
-	reg = <0x02024000 0x4000>;
-	interrupts = <0 51 0x04>;
-	clocks = <&clks 208>, <&clks 118>, <&clks 208>;
-	clock-names = "core", "extal", "fsys";
-	dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
-	dma-names = "rx", "tx";
-	fsl,fifo-depth = <128>;
-	fsl,esai-synchronous;
-	big-endian;
-};
diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
new file mode 100644
index 0000000000000..f167f1634d7e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Serial Audio Interface (ESAI) Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
+  for serial communication with a variety of serial devices, including industry
+  standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
+  other DSPs. It has up to six transmitters and four receivers.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx35-esai
+      - fsl,imx6ull-esai
+      - fsl,imx8qm-esai
+      - fsl,vf610-esai
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    items:
+      - description:
+          The core clock used to access registers.
+      - description:
+          The esai baud clock for esai controller used to
+          derive HCK, SCK and FS.
+      - description:
+          The system clock derived from ahb clock used to
+          derive HCK, SCK and FS.
+      - description:
+          The spba clock is required when ESAI is placed as a
+          bus slave of the Shared Peripheral Bus and when two
+          or more bus masters (CPU, DMA or DSP) try to access
+          it. This property is optional depending on the SoC
+          design.
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: core
+      - const: extal
+      - const: fsys
+      - const: spba
+
+  dmas:
+    minItems: 2
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  fsl,fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The number of elements in the transmit and receive
+      FIFOs. This number is the maximum allowed value for
+      TFCR[TFWM] or RFCR[RFWM].
+
+  fsl,esai-synchronous:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      This is a boolean property. If present, indicating
+      that ESAI would work in the synchronous mode, which
+      means all the settings for Receiving would be
+      duplicated from Transmission related registers.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If this property is absent, the native endian mode
+      will be in use as default, or the big endian mode
+      will be in use for all the device registers.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - fsl,fifo-depth
+  - fsl,esai-synchronous
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    esai@2024000 {
+      compatible = "fsl,imx35-esai";
+      reg = <0x02024000 0x4000>;
+      interrupts = <0 51 0x04>;
+      clocks = <&clks 208>, <&clks 118>, <&clks 208>;
+      clock-names = "core", "extal", "fsys";
+      dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
+      dma-names = "rx", "tx";
+      fsl,fifo-depth = <128>;
+      fsl,esai-synchronous;
+      big-endian;
+    };
-- 
2.34.1


