Return-Path: <linux-kernel+bounces-158798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD518B250B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D721F24351
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BAD14AD3F;
	Thu, 25 Apr 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="blM82wgY"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2093.outbound.protection.outlook.com [40.107.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93114A4F7;
	Thu, 25 Apr 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058776; cv=fail; b=guiSZtHKojybcaqspO5MiGzlIjZwYsJaeyQm6mMIYBSAcK0yMZvxRMcQx20+4XfIa5BZWXSYbNDD4Hpmbh0mc/4pxrEDyd7GRK5vr7Llnprz+rIA122h4fXT9BWe2RBap7bgfE7Q5miHhV5ONJH8epwpuhqkNouXTIsDtg9ebvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058776; c=relaxed/simple;
	bh=pkjtqfLKZ/M1HzJllzbtu27Ea2w2/Qsqp98pM5e5+bU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qn4E8sptp4L97gEeqtJVXLlLgYdeOsbf4240xilPWzCGo/CZItdCmJAOD4zQMsB8OSJHB41+CF+w04D+WUvlGvN/zyeddANDVGadT5d6k3ufvdi6bAZbX4Ai6rV5Y62H+Vw5yizW+7qnjJYLOjuAlQyvK40hK4182/LItQDg+bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=blM82wgY; arc=fail smtp.client-ip=40.107.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnKq8F1AAHayFb0M4XWTFSMQwY0a3utQKNuW5z9KxRAjUxNTBXmcCr2XX0+gXOFkz9+lY8QLQTbe/gdTs5L7C2KO76MFr+Xe17V95rrh/yJgy6iaJLLTD0nIJZPHFIIhfoh4/KZhNkUicmdMSveSUDYNw1+rXKYHkCCE5M0/d48sWe52Vo22KerxXPD5RysRbEX0UqpKVAFo+er6MHP67A8s6Y8c9ptOd29/0fsTFrnR8j/yOTyev7fbNqfcQN6jCksS6gcV55pC3prmsc3E049L5Xfnm61Wlu6TwFdS54fz0bk2rgicaXeOc+MLmNH7vX8+b0L2k6S9yGumQB3gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzpgJguvS9t5ftKKgsfIiqm73J4+MH2QQVJWbMfNMHM=;
 b=XQuAVm08s6MvdFGglP29hJtxdt2QBSQRglmw9zJDPT4CEyaCIiS2cke876kMOEUj+LRsSf+U4xVqfNCrxn+0908c68opaQB1kiRJzEkuN+uHSHnGMBw1klemgEAkGCyPsQz4R/tC0zoxNqPqgoenvX5kAF6YO8wGoNEAEYdXcvTCb74dE/yWxlUFFY+eJBjnAMnzk4/gooQk8FQqhfPV8RGpAhNsNUNjxcmew9tKc5Opzxtyg8tpBXb9BKQDDMbT0dqFzVNAOYio5maA5kRYnuOymA1v5Yn0YqiLdThmEqZxcwKou1VTeC2TWcvs/WinrrY02GPBZ9LnpqIezJBPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzpgJguvS9t5ftKKgsfIiqm73J4+MH2QQVJWbMfNMHM=;
 b=blM82wgYAMCfc3Ab0fbkzlRw0JXfxT3wlXDcEmGwO+L3AJ4f0KIVbbjzhNnm6f2H4ODLIvczm5YhYdbQkp3qbiap5GGAWMyOlhdxFdYO5OmA43gWNTNB7cYijXzygo5Iff4SfvS8OATfi7HlXX+RQq/SBjQNMlgAG9Kr+HaJ2XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by CYYPR22MB4364.namprd22.prod.outlook.com (2603:10b6:930:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 15:26:10 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 15:26:10 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add USB-C
Date: Thu, 25 Apr 2024 08:25:58 -0700
Message-Id: <20240425152558.485763-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0420.namprd03.prod.outlook.com
 (2603:10b6:610:11b::25) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|CYYPR22MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c909165-4683-4f5e-8473-08dc653c08a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5YqUV46hJqliNZfm/97yqvnb+sqHMI4+p7NYLNMI1xI2Pw4mJbI7A9l5YdW?=
 =?us-ascii?Q?mNoilJu7EtWfUDnC99DsWAsIETvr8mHQ2Q8gBkvMoVWmYEYpMWBxvhzVycXz?=
 =?us-ascii?Q?XCjNIze+VzEG/JEttjrDYOwBZUFTLXmPMoQAhRPr1/mi3Sxkr6v06qDDk7kh?=
 =?us-ascii?Q?QCHYlkUuWuPxvjRnbFRu0SGYgGtn6gi89LOG1GvWbh4umHg5qL+8mcJUTgOv?=
 =?us-ascii?Q?/jJGTlLdu5L0ZRhc7DztruwLcWCzoTFGFQ3cjq0B4GNGXX+n3P1t/2t0WWXD?=
 =?us-ascii?Q?yxGGx9h0HmCQC44JMkqgFcCy6Li9oDAxdtmtYVVIA7Zxh5cBIwI6VqA0SOsV?=
 =?us-ascii?Q?amG2/E0nXHii2fFR6Bb1dR5iqMgKz0u5exu6uXc8cz/ukYQz9PnWH75QUxdp?=
 =?us-ascii?Q?hWjQLDqoO3IrvaSMmbGqBTuSb2ahfWLRyPUUYSThPWmETsPIVDot0eKTF2CJ?=
 =?us-ascii?Q?IVun1FF4noHAVThnajBQfBodTgDbQzvOUg9KHyIDjfTzkpE4XAySry86Z6Dk?=
 =?us-ascii?Q?97CFbTNvpsUK+oylQG5Obs6Mr0zJmZgSUxbWdZr8IGF7cHJKmnr0YDO3efqC?=
 =?us-ascii?Q?q9xOiJFPzDFBYSw2cZJWvnIyws+uCzruUbf9kTlXC7U/dSPiKgfOgHYIxsRj?=
 =?us-ascii?Q?ntsalFCbHfGhF0GVXJt92D7VifWUgCBb0P6LywiESpmkT9+GnVSk1i8EYvcG?=
 =?us-ascii?Q?gLjOfF7jWJ+w7Kkj4hZjsCs69mUOVEUkdtaQXIyCqos0df8aB0iRzTlu+vSs?=
 =?us-ascii?Q?TRw3b5I305oe5fc3T+4sreDv3//oeJBFoPH7OaFnqNVzebDUvnRY3hia1dSC?=
 =?us-ascii?Q?wTAZ06e87kxPFtzmxz64uVrFmkdCvqMbK7krAXr0UlKnV7itPML0iyQaBeXW?=
 =?us-ascii?Q?oPxW1RJ5NJ7OPDQaz+9Ny/dRaTq4eeOjsaXJ/XIm2L3x1IeL+uUZnqcW/WYC?=
 =?us-ascii?Q?br8uK8hUXY1lp87j2QUhotqdk9ocYh+xS6RVt2YV6DFIcUkiBVjRbnnlbl7o?=
 =?us-ascii?Q?wDIUMkwD3e+T+sQ6CAJaHGEkPeU5Ei0sFt9F1ZtXdr+UwlNvjd+SM/dbHxOI?=
 =?us-ascii?Q?qL+/6cHjYiSdXM3hHVS3Se9B5krmYohSmJx9fwIM2NNMTiE35YRym45RtBRP?=
 =?us-ascii?Q?qZhT/XWz/HL+a+zmMEXUOQtbFvuYyZLw+j/4lRYdQbt2/iw3rbC4v01xPcVS?=
 =?us-ascii?Q?1oOlnDriMTazPdNTvbPNc/GQcu5giTSZjE4AhlD2uSXiTQX75t54ypGcEQbq?=
 =?us-ascii?Q?NyAMLRAcqP539mZw84Wy4xQtdsQkl0Dw0lmfThemZur6GwuuMTNBP3nO5Qlq?=
 =?us-ascii?Q?CiRrgqSa4e3h23aiKdRLpKmFLOdDDQf+MfL4b6YYj2rZeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iw1FTnyqRM2V1xYUePyty2dVRLfR8qEVjlCbAbwUf4Cyg34IkWpa4YHdHQbR?=
 =?us-ascii?Q?iSFF4s0wNJJNPiuKdTJLUInmUu5eTz4wEG6Z0LVt9qqgLPVnGZO6cimkqcyH?=
 =?us-ascii?Q?oeBDiJc7T+Z4IFa0Ee4TCJ91LKKrumhtNmvUTLVRPbFkxKBWnpt6DIGzKTBD?=
 =?us-ascii?Q?K0Qf64oaXrg9545q9c4ZUfGzq9o5q4CgVJ3Gxk3Ost9ZR1myze9g+zqBPj0z?=
 =?us-ascii?Q?k/knXEaaQdao1FvUL6ludY3gHRm+u9TayvPlyl1zfuqE+LMxgu7ji439h5EX?=
 =?us-ascii?Q?ba8V6NdsLWKf6y2+/2SPwlV9ueDJfu4lfjxER+8SKza/yQOfqcUG9+ZbuLpJ?=
 =?us-ascii?Q?vL+2Q0IVHlgGqtrQw/de6nr14EVuA++LTEORofIoLP4dpVanKOMWIQXGXGu6?=
 =?us-ascii?Q?vpUepj0uSJPXBMT8g/wU+XBzA8lEmlmnBAbf6svqVwtyZubu7SjMwLMO7Nq0?=
 =?us-ascii?Q?99mpi8gSkZOdCFzLBCLYBooU62wrhkmMrqodRBGaV361QDOuC8Hm2ys+shRX?=
 =?us-ascii?Q?xLZxovRnVoWf1G8hTJIZ/feNVPqaPVI8qWTuSRYS5q4PPIE0B/+5NOTpac+z?=
 =?us-ascii?Q?JtId9ZIKcQGi/NJ8jElaQGOVv3X0GxWtnZOWoCiRxZ7aD89FtoCzj9QZ6JZn?=
 =?us-ascii?Q?RnUarXCgnsW64O7w4wpICc0/Qt+NNA139NVcxi5FzxiFiUyut5F5/U98BzKF?=
 =?us-ascii?Q?VbU3zu9plKCu20wJ6Jbkpfiw7t65UShOkf0SW95HZzvVxt9ALRe4irxGBJ6X?=
 =?us-ascii?Q?L4chxxQ99WNgQ/eZl+uedt6h5VZzcWrh1/BBPvPXPokNXe2cIuNO/u3V0iMf?=
 =?us-ascii?Q?MmkrznL1KLNooaSjYNhywjGdyryng9xkHf0/1jMw6/jz9dpqp43mNTBa0YeR?=
 =?us-ascii?Q?GKctei+TsY8nN1WTdHgQftdbUjU3d1MvtTI5K6H4j3E5CA+cmayxSs/om/hs?=
 =?us-ascii?Q?07CAxSRzZaaBEGvopeKl8pyfNFW4eOryULJ7nQNmnX9M0Q/yAKh/7jYk8LaI?=
 =?us-ascii?Q?5Qmt0e3V32cDxElh+f+mAjGCovSYPOKIDlXZLV2j0mGYlWHzJEdsWwObDcME?=
 =?us-ascii?Q?DsVEF4mjM3flsHSiuH9HAQODXKzplAaRAD+Hs9FP/4oyTvdr7RjRTA/RIM/l?=
 =?us-ascii?Q?hJvwXrBYLS5IKPQl/roo+dyeZU8+V0PvU6xpvD4NBYYZiaTqukI62JujJ2Ml?=
 =?us-ascii?Q?wwxIk70YD7jTpVnYvkON9B4O0Z4lsPrFVvOmXg67xuRHOmSC1WtdN1o7zaGR?=
 =?us-ascii?Q?Ln33ZcAZinxs9bMshB0K98vcaJoYHxtsdo7htLObVLk9+O+VIEU+00peMxMs?=
 =?us-ascii?Q?PmjOKd9nWPx1j11EQ1ZZAbmJZnWlfpmNXePi1+hSeqDBsR4iSofQdgB8uCOZ?=
 =?us-ascii?Q?mEiAso1jhw2zSYl7uu5aoSsXWXrea985q9ntJ9GfGh3QGn2PvTRAPbmjid28?=
 =?us-ascii?Q?srI6lcBdVsEQqajtIjMxdkG7pCo88C/XXamm6UK8tQVPp3dTpYaNdWYeijPM?=
 =?us-ascii?Q?QXOnwKGo9BsPmWXuobYXeOiqoxs4NlS2vPVAIHWop9NcIcpUHy984GIjaQQM?=
 =?us-ascii?Q?GCbWsdpdCkYxipbtHyADT2Md8Zkc7DPCMsbipjHt?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c909165-4683-4f5e-8473-08dc653c08a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:26:09.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+9XC0yGwO0HHwrT8OSo9tVpS1Kblmqmrxvm99budV+V8IDGRlAh9dLcB0k9zH+cYtKBUMawkpSQkftTUp9cxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR22MB4364

The USB-C PD manages plug orientation, power delivery, and our endpoint
for the USB interface. Add this node and include its endpoint.

Configure USB0 for role-switching and wire it to our USB-C PD endpoint.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index dfc78995d30a..fb3bc914a018 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -348,6 +348,24 @@ gpio_exp: gpio-expander@21 {
 				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
 	};
 
+	usb-pd@22 {
+		compatible = "ti,tps6598x";
+		reg = <0x22>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			port {
+				usb_con_hs: endpoint {
+					remote-endpoint = <&typec_hs>;
+				};
+			};
+		};
+	};
+
 	sii9022: bridge-hdmi@39 {
 		compatible = "sil,sii9022";
 		reg = <0x39>;
@@ -449,7 +467,13 @@ &usbss1 {
 };
 
 &usb0 {
-	dr_mode = "peripheral";
+	usb-role-switch;
+
+	port {
+		typec_hs: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
 };
 
 &usb1 {
-- 
2.25.1


