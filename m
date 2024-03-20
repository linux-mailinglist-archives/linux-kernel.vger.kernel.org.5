Return-Path: <linux-kernel+bounces-108586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB14880CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E171C21676
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2340873;
	Wed, 20 Mar 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="MbJyt/x9"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF53FBB9;
	Wed, 20 Mar 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921507; cv=fail; b=HH0oQe1D94LAk7L5TywmswMqP9M2akvgJiFCDfKSDFFgH8m/SdGnJ32DM1hh5EHoHyK2ROtknNX0XodPjVY+Vl14n7JdhkM1pgYD46RUN6yHVgpzPHdkbOnhhJh9/J9J9CnBcvC3HPt6m9ZCFZPSwiWTlOjE5PI6a1pvv51N7yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921507; c=relaxed/simple;
	bh=3tqHLMst+mhiK4QFgwslIHL8ziDdEQua0JAC67hS/k8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aaI5uFCVwo77qxW0IVLkLj/jCAjLxyyPlYIzuo4MuBEDrltDAnhwAUvFSeJdHvhFBVf8pWp7hmEOz9rhLg5Qijq5+c4VHU84jd12d82Hz6Y2JMhtFHkGgXa4TRT0363vWiCpkxqQQINKHvbXk2Pi6lrqPYQxSi3eyPyIAxaKnC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=MbJyt/x9; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElSeSFsM1n/h3cgPTfGXGStmIZ/Q5U1Z3VntJR2Ho+JEfYZvYsET1iLhC015PEwUXmngs+/Or4ugRVaGQTsrhNwBfJtPdl7LwZyZhFUtb2JMDvIQZn34UNitzcMGTZn823qLkjLQS7S4MOBO2d5Yn/iW1DmWSrl3UjIza6BoGFLLYn7lTFbBu7aKgkks+BBCyvr/PbNvfGYnWpQi0eA+MXqh/Zta1trjLdOXHXnTpvpmRHnJ761z43QeHa9xqoIxOkhK3i5i21OojHBgGsdDj5t4ex5vlURdag2GJEZrgE7pLz269caK1IlWSSOrAjgQ+Avm61WqfxjEkoHvA7ydSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOX3tiBOxZrggRpnLxNwFouyH6dOHwsiI7ZIXmenRY0=;
 b=MHrrHeUzV8Vcfv9oBa0g65v9eXjmTsBkctOOOJq0dt9oZwdaO2Nfi7GFRdpxCxe6Ya0B68zuQRPFYSldH+iCEZLfaK4SvBhQBRq2l7Bc514Y5I8fcE/ws8Q89FMXwKfOh+73GpNqpoAutURzQcVev8IWyEcBrsD3KvYxgtlysne9dzMplv+f+2I8s0/TkAgGLyMY6dKTczrB/P815fbv+YTJO/nX+8CYBdhCXndY9QFzpKqkXJHnzSHWHGiB2GVMgvI8SF2pCoBg7IKApLW02/Zmcau/4GDWNpGvaBBeU5Ibn3xQ5yJlGFV6ykSR7XCzY8AkHVglttQK4h6OctU8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOX3tiBOxZrggRpnLxNwFouyH6dOHwsiI7ZIXmenRY0=;
 b=MbJyt/x9orExaYtAMWIC3xlpKq9nlvTiYPp18Vy/8ljyar60/h8NBKPO01aR0uzJRtwDJPf1IfL5o0CpadYOK7Mufp8wYa9hY3Ub/JO0xns6YL5mbQ5i5AgCDOynf8GiF6u/TU5MwPgBbVv2Q/vNYaaldsX5QPSC09zh5RRw+hQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:58:17 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 07:58:17 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Mar 2024 08:58:08 +0100
Subject: [PATCH v8 3/4] dt-bindings: input: touchscreen: st1232: add
 touch-overlay example
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-feature-ts_virtobj_patch-v8-3-cab6e7dcb1f6@wolfvision.net>
References: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
In-Reply-To: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710921491; l=2517;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=3tqHLMst+mhiK4QFgwslIHL8ziDdEQua0JAC67hS/k8=;
 b=atdLQXyA66hccpIs9ihGdq22LNGwXJKOzAYMmjPiGS0iriBn+D3uwc8kZJR2eDAlpcuI42nZ3
 F1ObXtmuhTzBfYlNJ9xP4veiVVYlwT009TgAtfDECMbZQl9mYy27jq1
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0662cc7f-a688-4cfc-faf9-08dc48b37d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mh98VB17WH2gxah7vQsz7rQa3RjjRXWFSVss9QkHUJS5JV6mHfgDtPXCKjx4u4HiIZygan+8dfgI4Hf1BoOHm3+UIcLve1OvxmYEodhFH0O7s57avOUQqJawrHoMQ6/mucjbqFbC3QKEkyLPCIhg0XR4y9q+Y06vN0cvhJyuVmckpusAlAQqVUPDw+fD+d3thZX7C1jQClaQUnRhxzb+RwOzAuxorxZePxJfUBkYo6EQNJ3+PrfuxkC1xQhHkzsGSGyZ69wXH8CpEqOKlyGY5211jWsqKux24fvjmW6pu0d9Ae/hBa/Es/PiMOaMxVO+tEF3/E/IgaYaSe20n/1dEjLzhUqCd8ZdFw5tzTRKZLix4vO5NrawuHLTKaew9Vo0LBacb8NLBeVwJwvNpjp5XHS8YQqMUGteUIKS1oFiOd1eiltjNBzrF4gVTowlN2o0OxinZ0GQwtFqE1sd28DMgzZECISDto0241PVQ6V5WbUQAkReeBj0jZUSePFvPutV/DGJM9ekcyQtq/R5IX1zpwZcZSRG1Hu82JY74te/WBdkyLmTYHkZ1G8oSLZ1dyEyAKBJ/lr64uWbOTfTYp+h+q3i/VlwRXgL4wYRyZqKuh5qypIVH6iJLkjBEMJMRe16ZKfhAUuUUUwHYP1DEmASqdTNpWQ+FX7GbM8VVjdIbtTU8uRPl8SHcd8AmGGrwFFzKsBhniszrpqYE4+a815bVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHRrbTFMRGxsRXYwell3dDNYWlA2UWRzOVVlSWxmK3I1UmV4a0dGRVVJYkND?=
 =?utf-8?B?Y3owdnY5YUxrWTVNM3V4Q1JHNVhtUzlhTlNkWjBvcmNGU2VLK1NiL2VFS2RN?=
 =?utf-8?B?cm1NV1FQbHBFdFRqY0hMYUxMdkJnQ28yTnZ3K3hoU0liaHNvRHJuK0J2ZFph?=
 =?utf-8?B?VHVxNU1PRUs3cUUwWU5YUWRNdi9Xd2hlVTZQRXRpTkNveDBDSk52cGlncmQz?=
 =?utf-8?B?em9zSTdvNzlJUTJXaTNEOXR1U2lBYUFWMGpmSmJiYnBrcjQ5bGZ0cGdHNUVy?=
 =?utf-8?B?RmJHVVRuLzcwMEovVlFBc24rNWg2LzhKdERHRU5memdxR2hQQU9Uem9JLzM5?=
 =?utf-8?B?MkI2OUZZUkU4RlRuQWNtMXM2c2NMMUpYVGZzZVNua1BPT2kwdDdhSlBWODZC?=
 =?utf-8?B?d0lKZUVlbkU5Ulk4aHZlQnJKUUZ0SHVPTmZ5R2ZrSXU5VEdlcnRLSEw4czZQ?=
 =?utf-8?B?K1JLRThlMGhPb1JkV3J1WGxxQVlCUkxEa0NWYWNvK0RwWTlXMlRXTjQrbzNk?=
 =?utf-8?B?bG9Bb1RreklFdEoxeHVsSmF6bFBPdW5aS21lMHl1VEhVZVZlMUpLQmhEU2F5?=
 =?utf-8?B?czQ4THVST1dYSW5nL3I1dTk0di9POWNqcEI1dWYzc2JyaEtnYkZTOS92dXdZ?=
 =?utf-8?B?dVZ3U3dTdEVCMnYydkJlT2JGR0xRV0hkN0JCZHRGb1FqSkM1ampiM2NSNDhZ?=
 =?utf-8?B?UGdKbE9ZL09qMWZhMnNBWFowRnBZY2wwbUx1R1c1K3h1a1gzNzhWUVBDM1FQ?=
 =?utf-8?B?WThROWZReFBIeWtJNTFqdmRjTS9oamF1Q0R3ZEFVd0UzRjR4R2M2YXA3dXFi?=
 =?utf-8?B?OFY0ZUp5QVZsbktOeGltbmZWRnRNd0tYNDRvejZycDZrUVZMeUNhRUx4QmM0?=
 =?utf-8?B?a3NDUGZ4OGIrc1pZclFKWE1xbDBOWWtOVktITFhFbmlKODNGVlhOY09Ha1Z6?=
 =?utf-8?B?WGM4a3ZZMUFTS0RMMitMdEcrWjM1MWEycTJiZ2ZNeW9FUGRPaE1UTkFHa0xt?=
 =?utf-8?B?YnZFaTJKSUp4OGJPN0xvYmNrbVRGUCtma1pTa3BoVDlTamlScE51QldNalBX?=
 =?utf-8?B?dUt0RkFYbmlISEk0cmV4ckN0S1dLbGtJYTZjSzJkR1RTV2FDVythdkNEQXMz?=
 =?utf-8?B?RDZUc1haRWJLNTVnYTA2Z1NzcHFBSjR4ZGNSTVA4K0xZSlhzaWRWTzhub0hW?=
 =?utf-8?B?eGM0U2tSUXJia2FZMHp6U2tOWEZSNW1icVh4NDNTdlFpNWY3blRsWHA2MlFo?=
 =?utf-8?B?ZldWY0tqbGtkclN2ZDRZSmE5emtjZE5UOHFPT0ZsaTNRbXB6TUJvWUpkUVpx?=
 =?utf-8?B?N0daMTdpeDdjQ0RvUmJkSzlFak1DMVNsbkc1N21rY1VsZDBGNS9WZU1maUpa?=
 =?utf-8?B?NGtoVUFUZFZCeElEc1pDazZQeDIxVlprMnVoYVVLOGt5T1BDNSt6UFpsZGdJ?=
 =?utf-8?B?d1dsRTdxb1FGVUk1cXQrN3ZFNjlCNENKVFNONXhpQlBKeWFMT0RnaFR0QmJv?=
 =?utf-8?B?OTkvOFM4RDFKR3hNSjN2azdUaDkzOFN2N05leUNYRVJZdWRveWE1VUdJY1FO?=
 =?utf-8?B?N2NqWlM5QXBoWFBxZ3g3OWZvVlJhTFZEbEREc0FXb2tDL3VjVHBBSjZnSEVw?=
 =?utf-8?B?V0xGZFVRWE5vNXY4MU5wYVBBcUltU2IxS1BjcmxhNUtCZlA2YjZzVDV2RUJz?=
 =?utf-8?B?Mk5pTjJVQUkzc0NveUlRMXk0L3U3dkpVWDIxaXBhaHJUeHJIZlJCQmZRSlBx?=
 =?utf-8?B?YmN6R3ZYWFVtVU5mVjFEUUY4K0syUHhVWUUwbHlzM2h5VWdzdFVuUEkvbnFG?=
 =?utf-8?B?S3E5VnZ1aHFlZkJ2aE9JeS8xTkxXYnA1Z2lZb2JBTUJxemtnZXdBVWlkT2lH?=
 =?utf-8?B?S2NxTVZnWmV6VjN5SDZ0RFVocFFndU9CbGg5K1dwMURMTUNheWhsSnoyUm13?=
 =?utf-8?B?elA0VG9lSkxBenBzeVlWd0R1akM2WXZ5RzNlcEFBdE5DTWxRWVV1OTE1SDlE?=
 =?utf-8?B?c2d5YWJ4bXhDbWNPVTd4Yjc3cFh0QytrUHRJN1RkNnNZdXJoaDhXV3EySGFi?=
 =?utf-8?B?ZjhVTnhaMFlCS1F3cVFSclJyeEFVOUtFUURDOTlYSU9qWTZYSzRRdDlRUmZw?=
 =?utf-8?B?MTRRZWdZa0lwTlJUbXJwL0Z4T25EVjhoU216b3ZWS0h0N0RMRUNkSG80bWVk?=
 =?utf-8?Q?zE0MkOjEjrKk1J8A6wMEq4s=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0662cc7f-a688-4cfc-faf9-08dc48b37d9b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:58:12.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 274i+ZyUP+DU5f1Alv9O6iFneBcqqfO87CdRDjJTINcTVpeVG005TEpLyMBhPPSAIHA8lhYd6MVIOrzWtBWUln/Pw3dukRHD7+QE5OhFV8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

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
2.40.1


