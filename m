Return-Path: <linux-kernel+bounces-30858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA483252E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA44B1C234BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578D28E38;
	Fri, 19 Jan 2024 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="mchJL3cP"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DB28694;
	Fri, 19 Jan 2024 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650231; cv=fail; b=rUzMTLyfCAYvWLzw/ordjmCPHafdGNdjzE1NBB69EcngykxgaTCFnlbhAsTcPG6p2Danl1o5VogbF2UpaFv4mwjU9jIK3apIhg7V6wedw47357zVf3gnYVKrgL4De+aC9bTs/gr3gb4Zbo7b7/ZBKIEXlXr8ckOVn3UbuibM/Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650231; c=relaxed/simple;
	bh=hvL4n2Dl3P/KD4PHi9ARJLtGktaktbtYa5lDp3HXvas=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eLed+GxO/z1pT6bfQwVvnoaBuDfgYBCEU1e2iwKTufKeDx/WR81E9Nyd4pb9Oj+zIA3oaVut5Sa7uad+KA7qDw3BCH0Yi0qtZp0v12pBx5m7Thm63x+jn8EF98bKBvPLpur/xV23w9Wh6T2bdjvOm5eRxD3U9c745lWv94xH7ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=mchJL3cP; arc=fail smtp.client-ip=40.107.14.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3hML/iHL8HhDqGXBzJ8rt8pXK4wCLUuBFzNM3N2oRRbNAaLTLlZAsjPzvFh1sELedX185UHh7seWHWJE5881fdhNMnAErfzybaGYsnonS5H0zWvw8aVrVkwCQQFHXpOcrQLIKxgLZWu94rUuXFBf8t98SvayFggxP7vgU/lJKbr1xX8xPlM1PcQYJfcdW63m9bfavR3Ut/lrUh0pcCkIw5TlM6Eex04Ts6Z0v/w7tOqrnb2tT0FxdC7daDgvIz+8p/tuZ8Ft0SNSCKgX7DMBtMkLAdOleZpwazIKn3K06pDbeYw0yFzGZwMmQr39hC4SRuTMvkGnSl8xVD+SP81xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwcSUkDHIxrh1gIuZO6QMX0u+NT+wLScv/Yxfan2SxQ=;
 b=ShqSUXlMs8X2AAWRIG7ySk/w5sU5jqZZtAK9Xj4eerhvz09o9HuPIIAATbyF/gpMnvrKe8gWF3qymw7DhAtlZUAVCM2HIlGyRvAFzRaEad1Jyi7U7bdYrXR5ZQfjNddmiE0O2I/NKr7Zzep7ZEPslz9L5sntHc7JQfUtfZF2+atV6oe7HadLi5ZFxVzvvbCPwcHvyBCzLM+MEYk3HFO8Mna19uqx+YuZuVx0yhEtmjkfmYZyZC1SiumMwa75xzskyyPPrf5vjEIhbcRN0K8/yeEufrl9os6KIxDtMCpfP36L0H9UxQrOuQSkSiYVYCnawTtPHV3lKznBUfcmcme5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwcSUkDHIxrh1gIuZO6QMX0u+NT+wLScv/Yxfan2SxQ=;
 b=mchJL3cPFdnVE9UNhKOkKJnaDXkICr8MqVWbPczJX8ysmUC7lSbBiSbY9Ldn9StMx6tCKORHLV0ULWkQvAID7WNfFyqNwmbh281HL968k/yEWa/++TXUP1w8aafKkw6MbosaVZOSTTVQ7Q3bYpG0yC62uqH6sjegLIJFc1kAcY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM8PR08MB6578.eurprd08.prod.outlook.com (2603:10a6:20b:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:43:42 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:43:42 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Fri, 19 Jan 2024 08:43:35 +0100
Subject: [PATCH v7 3/4] dt-bindings: input: touchscreen: st1232: add
 touch-overlay example
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-feature-ts_virtobj_patch-v7-3-eda70985808f@wolfvision.net>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
In-Reply-To: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705650218; l=2517;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=hvL4n2Dl3P/KD4PHi9ARJLtGktaktbtYa5lDp3HXvas=;
 b=2w0TanuP3rYwVb2fuex4PjUEbrKwJAy4TOXPr7yB2KvAPBgnAeCyPOO/PRf7lgjq6c6wVfXft
 d6cX4T8dpQJAgrssLsm4U3LS8O+bZJsYKRcUBAkzMI156sPIJmVC6HB
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM8PR08MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 06261025-8dfb-4479-745d-08dc18c25b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lEqpyRrSsawqF+hcka1AKLqUSdfDiXkPMVXZlm/hLBtnKhTazgzgUI/e6G1cKXbx8NFcmYujTvwiiU0M1vIli9BegVPA7SzzqqPai+3d4fT0AU560aq7x4017K4Lm2efyxyTFyaOCdyyJhirIWAh44RAxkwV+fygK3hXxsh97Bhsr467QR4DlyPiRCg09qq/HAKbJ7YJVR12oxJYSEfKfOHUwHIePBDaVsAEIu+hjEPNDOvqUSH8IOMp1B1cknNSmEVBXE3vLy2mFc/WXdP4lFpU6NvnRFHHgiJ0hYbLRV6ob2N9o5ZwaUAj4h7XVQUGnO+cF925aK8i6wnsVAKHVIw6YiOhaPd9R9J8S/CMQa3KSUGA0NXkWTH1HKvv4FfnfvH6F/EFSkumRq1YDb8OkxrDrFYVYN21Vprr+TyLG1rQJ8lZ6/eKJ4lHidl8F9Mb7di2P7Jm0ubjK+ZolKD31b/awS7WZ3Ywsyvg9CSrHi2LwlKVooqT7iZWP6bXWa/dburVKQWatEIYViHaKuPeRRi/SUKqE4ytGJRunaCPy6qYCsLKBy1sFBLU7zAAj0kM+bPwvYhG6TfZlMCQsBUREneim9fawVjJshGatVwFE/SvautmsglB7DimFb2r1keq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(54906003)(2906002)(7416002)(4326008)(5660300002)(41300700001)(86362001)(38100700002)(478600001)(6486002)(36756003)(2616005)(6666004)(6506007)(6512007)(26005)(52116002)(316002)(8936002)(8676002)(44832011)(38350700005)(110136005)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1Jya2VJVmN4bGY3QkZDc2dQZ25GYnZKNWpYc1VJNWREY2U0aUxsMUdIektG?=
 =?utf-8?B?YlBFZlEySEkxTzltV3gyK1NMV1NVUUZTQ1pWT2dkYlZ1dHdyT29ZdTlTenM5?=
 =?utf-8?B?QUxwZG9DejAyQmhuMzlCdEVYYWVsbE9Lbk53UHQ1VWl0NGpBeGZVSy9EaERN?=
 =?utf-8?B?Q3p4Vkw4SVZCa1ZGZjh3OHpWNTdoS3VYMHY1cVBEUm1qeE50aUY5MkVBT3ZS?=
 =?utf-8?B?YW9EclhDRVdiRkNBNzYrSkRHVjE5TWVKRlRNUDcrVTczcmJuV1JTaWw0WFZ0?=
 =?utf-8?B?U3A4a0JrSG5qemtEWnFyUC93M3dTdW52ZFhLVldqZ09NdW5pMURId1VzZ042?=
 =?utf-8?B?L3AyRVdtWjhpRTFJOS8yRTkwY05sbGFuTVdiWFMrbkVYV21nd25ZU3cvLzhn?=
 =?utf-8?B?dDRuUUU1dDE5RzJ3OTI0T1NiTU9DR2dQcTdUTjVtU0NZb0htclRlZVdJWTM5?=
 =?utf-8?B?WTRqaGdFNkxJN2RldHhJQXJTTlZjdFNtKzBtdmlIOVRvOHlrUFRGMVRETFJn?=
 =?utf-8?B?MGdrSGVYbERGS0RseG1VdVhJd0IwRGtESm04Umd1Wkw1cFliVkk4S2wvMGNO?=
 =?utf-8?B?YmxObXoyV3NidDcyZFI4MFVMSXFMTWY2NGFvLzRjTFFmWHNiSFFtUks5emxQ?=
 =?utf-8?B?SGJoenJTc3hzeHJRei9LUnBheWl6ekxMV0ZIclh5UG1BRXVLV3dGSlpTZ0lO?=
 =?utf-8?B?VU9xdnJMRE9qSlJKYUIwemhDa0lWNU5rcEt1cGJsc2RzOHlUbDNiYU5tMkNk?=
 =?utf-8?B?N3pnTmpORWFhTW41VmdrWXhpa0pZSHNJY3o4WlAyWExKWUJraUxtMEFaYUVO?=
 =?utf-8?B?dEF0U0t1NytkUkpiL3lXdk5tUmljdXRGWmhOK1kwUGFoMk1Fdk81NzJCYmow?=
 =?utf-8?B?aTVnSTNXRjdYTVpUekppWVkxRnVUUWU3SldBWjdFaFRjRmNMeUlxQTZTV1RL?=
 =?utf-8?B?U095WDlsMTdjZTI3U2RqcSt6VFB2eVE5R0NwZkxubVNyam92Y2RiZDZQem1n?=
 =?utf-8?B?cUZGMFA1akd5TnA2UDl6K1lPZHBtYmtaU256U0JYOXZKSTdLRGwzaHpSUThk?=
 =?utf-8?B?TXMwS3AyUVlkaVBuUlVWcEpLOWNqWWJMRFZyYmxFdVhja2NkTk1qY3lzRTFE?=
 =?utf-8?B?aHNLb2xyV3lRSS9kUS9BNExrM3hxT0U2NkE3Qjk0SUZRbURKbGoyMFlyaVl4?=
 =?utf-8?B?M2wrdktyNWZOM2krV1FDNU9xeUxpWmN2QlBwT3lSNnUxSXE5QTluTWdQaTZv?=
 =?utf-8?B?bU1qMURFdVN5WnFnQ3h4cFliOEd6ZjVNa1dYN2Z1dHZSeDFrS2hpdFl5am1q?=
 =?utf-8?B?dXRuZXozOGJkVG10SWRDakZRRGFLQi9qMWt3ZlZIT3BVUUJlc3dXcHg3SU9l?=
 =?utf-8?B?NXdPK0d6VVFabzNaMFV0alQ2UVJ5ZTErWkVvZ0dQclN0bkRyVFU4S0tUajB2?=
 =?utf-8?B?VHgwL3BBY1FsYVhsSUNicEV1aUhOemoxZXN4UG1zUUxXZ0lGSnh6eSt2dWlT?=
 =?utf-8?B?OVJZdGlCRUdxLzA2NjViZVo3ajNaRHlCT2xYaExhRml4Nktaa1R1MXpWejNx?=
 =?utf-8?B?MnFQalZxZyt1cUFlQ2xlRFN0bnYyWnptTlNrQnErOGxydUh4cGdQWEdXNE5C?=
 =?utf-8?B?cHlsZVZJTXVlNFJUWjdTdzMwcG5yYmNpS2pab1ovNWVFTWREZThiMDR1bGph?=
 =?utf-8?B?RExrcTZRZDY0cThJREpzc2w3WkExT2psZmh0c3h6UnkxS3IvU2hsNXNiVm9k?=
 =?utf-8?B?Z1NTcE90Y1hZc0xWRE5ycXhTd1VtS2k4MjI1MnorOXcrczczNlVWVEVVSkNM?=
 =?utf-8?B?UkZjeUlNQzViTithcVU4WEpObStQSjlsS29YUGNLbFgyRWxoL3hPVFZ4Z0Ez?=
 =?utf-8?B?Q1dEblFRYmZLWDhOT21lUzRKMjhSeVNMWnF1aHQxWlIyZHFyMDJwUi9sUGgr?=
 =?utf-8?B?TXN6ZGdrU2ltZ0R5bGo2TWNpZ0JyLzM0RURqMnFXN2x3QVZVMSsraTVxaGJ2?=
 =?utf-8?B?SEZBKzJJVHVlck9ZS0VhMDhqVVJMMnYyMzJpWDBhUEJlZ1hnTmtLQXoxQndi?=
 =?utf-8?B?alBva1MrUXpLRXVkZm5UWHpJWUhYMFpPNys5Z3BhMktyQkdrZ1RTc1FaVFpV?=
 =?utf-8?B?VmkzYkoyRWNubnpUTGgyV0JJMW0rcmY5dlljMkVleUpmS3M1UEZGQUJXZjNa?=
 =?utf-8?Q?8TEgwxIuHCnN5cOmfAywOxc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 06261025-8dfb-4479-745d-08dc18c25b8d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:43:41.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODHvnXwe3NbhSBlIs6uQ7SKj5PhSjGut2v0kiB/80dwjGG5A+rbt5Q2W2FYWqg13OAgT+HfRqNOKOdddk5NnyqXtuZLdCD+OtnuYaiIQs+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6578

The touch-overaly feature adds support for segments (touch areas) on the
touchscreen surface that represent overlays with clipped touchscreen
areas and printed buttons.

Add nodes for a clipped touchscreen and overlay buttons to the existing
example.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..e7ee7a0d74c4 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -37,6 +37,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/input/linux-event-codes.h>
     i2c {
             #address-cells = <1>;
             #size-cells = <0>;
@@ -46,5 +47,33 @@ examples:
                     reg = <0x55>;
                     interrupts = <2 0>;
                     gpios = <&gpio1 166 0>;
+
+                    touch-overlay {
+                            segment-0 {
+                                    label = "Touchscreen";
+                                    x-origin = <0>;
+                                    x-size = <240>;
+                                    y-origin = <40>;
+                                    y-size = <280>;
+                            };
+
+                            segment-1a {
+                                    label = "Camera light";
+                                    linux,code = <KEY_LIGHTS_TOGGLE>;
+                                    x-origin = <40>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+
+                            segment-2a {
+                                    label = "Power";
+                                    linux,code = <KEY_POWER>;
+                                    x-origin = <160>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+                    };
             };
     };

-- 
2.39.2


