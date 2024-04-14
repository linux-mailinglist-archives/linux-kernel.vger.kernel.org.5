Return-Path: <linux-kernel+bounces-143978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF78A404C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170741F216F1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1841B813;
	Sun, 14 Apr 2024 04:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JPPquOoG"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2138.outbound.protection.outlook.com [40.107.101.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E22032D;
	Sun, 14 Apr 2024 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713068620; cv=fail; b=PJPB2T07opu6Frnolh/ue2dNVrKu7cNaMvRuiAQ6AMnu/Tf/+YK8caZfNrXV2U4nKJEjkCws0EONp1GY7rkhaDvGs7fz4IYvMb622g2sQIRvRWGtqIPSuSnbcHoWRZ3DKbmBgDY/aBzc8/EbN+GZhwzIj1b3w6nUlJLrjqvh2UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713068620; c=relaxed/simple;
	bh=TRxN67RiKa9T53ID2U5qz1HXJM61gN/p43Z3ktK6e0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/uCuWpuVKLVk1zkPdZ8wPfa/8Re/peUc1ZGZCoVUuO2n7OOzmCHB/TnZQPfpC0M9c1rvCuXmeN/Gg4UOY5ntrB0h9yWUkWEUF6ht2ZyrR343SieGd2RjvWiMEVYajdKZW/R/VMlY9jpx76Dvp9QTk2GqwxBlQAC9waYxkHVgVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JPPquOoG; arc=fail smtp.client-ip=40.107.101.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnLgEaUHhxngTKUtYaOv44GYSq0642lvAsXQ85JQ4PIsz8YPy9QRo9g4FX6zxsug74AnF1wvfebigddYuuECenBwhguvApzNsmnQbbuEVEFEW58qb3YRTJMXIkszcdTldEFfgrfeKMMNKM8wLHHLKGJwq5wYqYFc5hgzzeTBLJsB8WiQFfDfb1qYmqTF1FmP3AQWmhx6nkQNnSeMu0S6dUhyEKnzUI2IYofd5c5hd0CXgjrFeSuxaW/KZ7e/zlAjPaP365tG2qCD9nypQ5SALe8lRj/RnC+EAcWEx/69ICnqiez5Al1iC+JL4OucEIPmqJ1kJfbcr+EDESI/J6latA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVkvhwnZGvJmLK+2wwrGq5HUcv7rahFdqvZIjQMvlE0=;
 b=kc06e9LAVuuojHm+Jtablfn/ZDIx1t+0HK3ojtKXDNK6o+V06dNEDVaOvUzPug/R7cQ+WPk3n7WVis4zZfzKgTxJFBxNAjCtvRSWoLZ9hqw0NmEXw+Z91cfALN6yD9ievDHSbG3mY4qBVDKVCpDqznE5DI5lLwOs6CteHkFxIuwVcQQZW450QDT452bgetxCavOfo9G6LD//KlPdsokNX8WH9VoyFDneimV6+fcR1fz9+9eP1wxKlSS1E9vqYDhBNxqKfxmhHxkuNwumI0kgRHHTeas/BzNG4dDTIDbGjgPkATEmfkPQFY5jCpeKYVCUYc3S0h/k34sVb9pQGnq7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVkvhwnZGvJmLK+2wwrGq5HUcv7rahFdqvZIjQMvlE0=;
 b=JPPquOoG4XpHTNF9aqsHo3aNPaPubJUEoMB4xVJt/90ydBBUAFr5afd7GrsspUiPHyzlyBdzlzKQZf06GL8dDhG0FmOMkJX4vc/DXKB5e+4j3HnO+FeFKPq7IGebM3jKXA52oBTUYy8z5MKAyLUdPCV8ZYmWejcaxmvoVRP8uBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 PH0PR01MB6715.prod.exchangelabs.com (2603:10b6:510:97::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Sun, 14 Apr 2024 04:23:37 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 04:23:37 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add maxim,pwmout-pin-as-tach-input property
Date: Sun, 14 Apr 2024 11:22:46 +0700
Message-Id: <20240414042246.8681-4-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240414042246.8681-1-chanh@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|PH0PR01MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ffb86e-5ae2-41f2-bb49-08dc5c3aa75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JC19MrJH2UP05b9AdcaJJPFfuX22MTV4AfoNIzAYvoc+6KzPUtfwaDNRE6w?=
 =?us-ascii?Q?+nZVIFA/y7kPeLCbiMDEVylQnsfeLdGkf/QssMNqXzbaqbzep0+caj3RLctg?=
 =?us-ascii?Q?gwgFg1GghY+rBt3hIN6miLDjjqb7wofxN8Q2zWsAVcx46RhEpsS6LxW7gGK7?=
 =?us-ascii?Q?XOs2z5V+BxCPO/M2Wyik1DxzZnosyRHU8bvl19JLS9S8cDG5EZTDSnZCRgef?=
 =?us-ascii?Q?YViELu3Z2pFDHjxIBFM11/nUbzJetFpHkJDpNNVF+hmsTehJ/GarOagy/tSP?=
 =?us-ascii?Q?N7Z1syfsN8VjWRU5b/WHcurrBLB9Bx5y1ndS8Gc3BFRiBbGBsUxaLTljLElv?=
 =?us-ascii?Q?qbpoNoDP1palqNU0GSzY59kzU5IwAwMzPxGCyZrbeqoDs7mNbn5U0FSGz6dk?=
 =?us-ascii?Q?BqfLqbTFsTEAniLeQgH174MAEwC7cFtLNyQu9tXcaSyPlocxhB3DL8S44ZPU?=
 =?us-ascii?Q?LqkHqwJmmEKvQBU4swRux5nc2fJID4RKVAgUQ+gBAEjHugljwYGJbQz8Kuvo?=
 =?us-ascii?Q?LsJk5eyNvJVtDYmIaBayq/YhvpRXL9DaKf/PC8ZsGQcQWuU/OHRGAToWETIo?=
 =?us-ascii?Q?dth84DSBPFBJEZiH7EX5i8/rbFAG6QXEnP4abjrajurL/6qTUFjwrv527rX1?=
 =?us-ascii?Q?DbWUbAOBT5dkDDD5dPHBKu8oqcdR2kvGGxLXWlQECunmIzfjVROmy4hu5eqS?=
 =?us-ascii?Q?n7jQcsqLuaQ7s1q3SBBnfoKVwgiezT+OJwQCux8k7iCb2pHvdMON/Ljiqa19?=
 =?us-ascii?Q?aUEKMg+cCopCApEigvVvUIC9tbrTv02peWSys+4VbOoG9wVLZHIuk4vaTxJ3?=
 =?us-ascii?Q?QAq8lv1p5LCqpEx7nKfu8mxl4DOftD54az+p+v0NpLkloFQ1H+TZR5/ZJ/IK?=
 =?us-ascii?Q?NOecSjzEkXygBKrOcL0UTW7c+PrWhiyFoKq8FB2faS8csau9HdBC0TOjr4Ks?=
 =?us-ascii?Q?DI7AqT9dxrDsE4Keg0VprEm3vu8X4Vj8xhz0ldDt/f6WJom4JxwRroW1Xzs0?=
 =?us-ascii?Q?awgbnYpMdp3ObaK26eR2AAPcBWD2tidFmBmFIt97PQ3TNl8RJIEva6VF+N3P?=
 =?us-ascii?Q?fRDNbAKeEV+W2ke+4nNrXevK3cIj+XyNYhu6veOS/fAjHmY5t1mfCBWAuMEC?=
 =?us-ascii?Q?+otKCx4CidqbwBSHVOyKIGZlFFV1KI+2dOJqiad2EkjnixRHY7cT6kPKTvh5?=
 =?us-ascii?Q?m5RrKjaond25J3J/ACKcsW8lgfsA8yY9b2JSemklGC15jpByQqPKj1Ka6kGA?=
 =?us-ascii?Q?CcAKr7JTAZcivTBl3ArMycMv2dwZ0MsAWKqThJU5xrxJ5iFZ5vakUKapdpAz?=
 =?us-ascii?Q?26LIvrBQdVKOQPixHFFCRnwbqabXMhpsVNjd9lCdjhzPUswGksuTgjU0O02S?=
 =?us-ascii?Q?XTIB2rw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1c74AE2iZ4DTFXSyX+oguEPp/qUfPBmxfWqyYtN+Tp/O4zvz2ThE/Eex9TfK?=
 =?us-ascii?Q?bjhU1R2TTxH98VKnygjsexZGtEcuudfBGHS0ZG/xDaC5nqda/GKZxPwChLyj?=
 =?us-ascii?Q?2WFApWL3aPq+LHOfxcubiTlbeRtW1iic3qbCWlYP28keZH6PUrqcM8UWU1aA?=
 =?us-ascii?Q?HuKAyLCvOgVBu6U/vbZzk3n/cBmKMjLBwG81hxHAg75tBsM/Ckqz8yMEJ6J5?=
 =?us-ascii?Q?+lG952hUPFnIYRPAK2AMjQ7IRznNTRyfzt6nt5e3EILsqqTimOldZ/UJdqBR?=
 =?us-ascii?Q?gngGm2MqZxB4cWwbCsR3FoevFk5K1r8jAMKpMSWTNte0krihMgAqHv7CVDn0?=
 =?us-ascii?Q?omPFBOHj0pfxWSzXZ+lqPu2GKqTWWFnW3E/i0vhLxlK496+rkMUVpV8XrlH5?=
 =?us-ascii?Q?FnDBtohwVIp7njPpdJlLhfjSbVGzEFvxiqt8R0auHjHorIEIUvquxSSE3/NB?=
 =?us-ascii?Q?x7siE3dS+jqdBSfmTAQjeZ1MJWoXELLET6r1eBmrBJFpY/HIgmCPFmmjJDRq?=
 =?us-ascii?Q?TggzaFiQWrq2Y/OXSBI42Jg+oB5X2UOY8xKXyz4qM9sP1MIEvk59sIwidaQB?=
 =?us-ascii?Q?duvm5P7EIRQh4J/T5yzLCuNP2dhKXEN6U7tadFkjHQpsB3xS0VBev5/QkWF2?=
 =?us-ascii?Q?hJoOqPtE17VT942yy2475AXon/vyczSopkweHro4FjCQ+tHBS9pEmhdLWLVF?=
 =?us-ascii?Q?cF29qIPE1O30hHDXOqgS3VseSjEhTbanMH6fhJKk21HKg4TnXrQ13Yfe1Yo8?=
 =?us-ascii?Q?85E9/7/uExSZajDMt70AjvpLHTok+HL44+7GF95vNKculGyp2got6qY87v/9?=
 =?us-ascii?Q?XIW6kPH0x6p9aIYlfr399NJLZWg+Z5HuoQZ72xRg+KB8HWryXRKliaGoJ1TO?=
 =?us-ascii?Q?FeqGs+OB4JYVPOS0sUG/Ey6bvK5nXhimKVcHT4h//dwPKJcp4qPSvTDCMcuZ?=
 =?us-ascii?Q?ENEquA/XvVuVSRPQ2WwqqWwYRKTqB538CrbuPc6UX5AUGqWA80jaYoHwIDdG?=
 =?us-ascii?Q?NXoGATgbN+luw2xNjNs3faeRAtWseORSvCJLsyC66tgHPPr64BB4s6yVUiO4?=
 =?us-ascii?Q?iFDyxp/dSM0ldswiVCknP+tn5BEOgWpajyFE0dVTICoKc7dWKSA92g+SCHy5?=
 =?us-ascii?Q?IgAECmFxcAT3MOG7CXjzpuLv1+NiIds7F0FfGzDzZvQDg7u1ZqMjJPKSiyja?=
 =?us-ascii?Q?Kz9UB4C8fNu5Ambg0AdcjqcVve8hPhFnrnOZP6ek8iuPKABKWr8QJIa9vnzC?=
 =?us-ascii?Q?EdKziCMeuqglE0GL+ByNcZtBzTsABFMSEJ3lmdumrU6fhZQJjCW7zIokPqk+?=
 =?us-ascii?Q?7N5Tve/lVxcqZRRJ1jGkMPimlm5LbpqGOR837jCLVF3rHHszlFsaV4Pz8MY5?=
 =?us-ascii?Q?1ptVYfbMgJEuAILqbNhP0ivGg2p5/PjiL50jNOgHg13SC0MlfQQ75OzfuVeA?=
 =?us-ascii?Q?w11d0aSueemcPG3mYBLmCLotOtH6ZX1RihQfQ08hUdlQcz1PD21ogDuZH78h?=
 =?us-ascii?Q?bE+gQxe4tPfKx+3csNrnWGFh91Iz65wlh662D1PT3jLfca25qSrf+eYyqPPd?=
 =?us-ascii?Q?YmUxaxIjnpGd9IbaM586VXAQBEqlz8f/3rZXHYDjo4aHHeiM0xSPbxhXW4zE?=
 =?us-ascii?Q?oMWzWcChGNB7ww8zqWLv0TY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffb86e-5ae2-41f2-bb49-08dc5c3aa75e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 04:23:36.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZKlJutpeUddnd9bPywT3KumJ5yMce60rOl96RUfOQVLrYkL4ievYMT5f/7bU/B1dFDvxKJF2qN8AeG1VZd1LY4o9vSPY6zoUuxjceRVoruL5CGpbv4HyjaRc1PCuFo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6715

The max31790 supports six pins, which are dedicated PWM outputs. Any of the
six PWM outputs can also be configured to serve as tachometer inputs,
allowing for up to 12 tachometer fans to be monitored.

Add a new vendor-specific property, 'maxim,pwmout-pin-as-tach-input',
to allow PWMOUT to become a TACH input.

An array of six integers responds to six PWM channels for configuring
the PWM to TACH mode. When set to 0, the associated PWMOUT produces
a PWM waveform for control of fan speed. When set to 1, PWMOUT becomes
a TACH input.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
 - Update the vendor property name to "maxim,pwmout-pin-as-tach-input"   [Rob]
 - Update commit message                                                 [Krzysztof]
---
 .../devicetree/bindings/hwmon/maxim,max31790.yaml     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index a561e5a3e9e4..2d4f50bc7c41 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -30,6 +30,16 @@ properties:
   resets:
     maxItems: 1
 
+  maxim,pwmout-pin-as-tach-input:
+    description: |
+      An array of six integers responds to six PWM channels for
+      configuring the pwm to tach mode.
+      When set to 0, the associated PWMOUT produces a PWM waveform for
+      control of fan speed. When set to 1, PWMOUT becomes a TACH input
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    maxItems: 6
+    minItems: 6
+
 required:
   - compatible
   - reg
@@ -48,5 +58,6 @@ examples:
       fan-controller@20 {
         compatible = "maxim,max31790";
         reg = <0x20>;
+        maxim,pwmout-pin-as-tach-input = /bits/ 8 <0 0 0 0 1 1>;
       };
     };
-- 
2.17.1


