Return-Path: <linux-kernel+bounces-108584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5BE880C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CA0B20A45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB52C697;
	Wed, 20 Mar 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="21Gv6cL4"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AF3D3A2;
	Wed, 20 Mar 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921503; cv=fail; b=VxcV6jn3KmQLtPWIAN1/FX0zKBGLOab4i2dgPniqCOB7XSxtbO/VQybzHDoSI9EWZLDegxpqqM6WdW/loH1OjqArGZpVKboWwF+Kf6PmfMhujaRoNDoz7Dj8x3aSMh/++JlNaVw1Gp+nQRV5hM0CBpzJO86WvMNWEH0+TYOYCwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921503; c=relaxed/simple;
	bh=We4djLZrQmwTewoy3TXvLCuEcuRF2BZn64gf0yEafpU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LBgeUvo3SZ2CEnMEzueHT2+fPyIPllGxmCIOW7YqHzw+oJOUqkhSEzHoeMR0wcv8OA5wfMPkGx5RB5XKx4o4q74IIMc5w4GPHdqKr24g2XE2vkJlEYrEb2SdfwSt1tjzg22NZU0ZEiDCO3uFzY2Nm2aK/X43gjgFAioJp3Tortc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=21Gv6cL4; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdJvp34sTn/Q9Gk/Nvf8nMshRjWB6ygMpRpYHDb0wmpgY+byUPyP65GsRO8HmGBG5WEah6iXwiJuonbeKOO12acr0zjIghEblkVZfGqcRhHHeshL93oHTf2Gifx80iJJvz1Pjh5hHelbYfk7RJDDGiXBKrYyZ/GXs6sOw5pAQzC9Bd3DQ37pLlM3mRIFSMVKobEBY/bxx/aMSTaoKq0DGJDBlrx64L2G1hcNCeUWHxq1ENwhwTmkBNlc05sZ/D2yj/C+ujeklXqy/567ZocLE/D813FMa6QGYWZLGjv2tIsTJTf+kL/epaEwTORqYg3ZW2HSLmFHB1C3slLTDu8ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRUe7KDkC01XwoHUft0RG9xZV2wyedfrobtHpSyaX+g=;
 b=cfCKh8qkRYDppexZq94R3dAz72VQ+zdbfI4I6qb1Ddtb0mX7WqMpau1zKuCaK/TeonemG29heUnaKk05dVe8zHnhbqIpNqCe9CaBqh5Tn3tkxylb6Cpo1LeyeCjEeJbNUIV49WGMHF796M03DP8AXkdADfzZNK8mnaul0+rnU43p8mC6FMKEMN8T2t5AE0dJQx548voFEKJxkvahZnDH2YK5RtIPTufvbzjCo5sws1p7eaMGXx01GDY7Xvin8eBvUMNEbMHRpkcGGzKKLkh4Xp9KM5L74TLzKBE+XRA0SKWUU3y1Ihool+TqcrT999/uAuJplPq1J8eGSN2KJTjrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRUe7KDkC01XwoHUft0RG9xZV2wyedfrobtHpSyaX+g=;
 b=21Gv6cL4ShvdUCH9xl/IE/OQnMK4nFBsCejNn5EabWS5NsGYR9pkZqHqa2IOmP5l/1uVArWe812abOoq943lPc26gzojjVhplAoMTNBPAyDbDya5gbmOL9RT7VPQHtYW6fJLhHGhiB7mTmTjiZ3+MiC1az8vHle5Guwh9lQfqpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:58:12 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 07:58:12 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Mar 2024 08:58:06 +0100
Subject: [PATCH v8 1/4] dt-bindings: touchscreen: add touch-overlay
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240320-feature-ts_virtobj_patch-v8-1-cab6e7dcb1f6@wolfvision.net>
References: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
In-Reply-To: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710921491; l=7148;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=We4djLZrQmwTewoy3TXvLCuEcuRF2BZn64gf0yEafpU=;
 b=xbHRhMZf3j2RJXqiOH5VwThjrghylI62i7Te0nmyw8Px64oiXiYMacbBViloJUCZ3HqqDv+aM
 Z2sWHhxXg8UBYqqzDHlrxHDujW/M9PxYuxbM+9oMoZ2a7EWMlXHchxj
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
X-MS-Office365-Filtering-Correlation-Id: acaa3bd4-d3d6-4005-8198-08dc48b37d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sbOtxcf5uWKR60WedFeSXS2tSSPlMGRZkP9aC/uXFoNfv70ktWU9Md26zWwtrNu1hNqLJ+cWH3+wt/AsFiZk095RekLUXTt7wWnhr2oc+gV/lTb/rQPaD0HnDhgtybL+xCCtyR1BRDBKHGj1ogQjxaYuJEInbDNG1bUtlXCFwmWBVLCIVcxP+V1larNCh7ZS5Is+E3V4L0z6Reteul3/qdZd5L89H78MGdi+vHlmT+XfnjD2T90kMJV8w8IPhDwK0XETLLFDrPv6fUd4GYKM+j0Vc89x1OdNZWiJ7Gg9LgkWOguDi+tUg+iHHMHNMDYtK/PzkeMvFCKEhzDGEbHlmOh6XPzvQ6FCM7QOnnlAQ/RMF4tNElC5reKZnk48VpAQNL11/tqNkWa5CZmHf6lWeqMh34/m7b+4nn1lTZC+TnWoNxMglGGqnuSahbqUKKOA4s8W1qOLVOYZcYpd2lb8OnIJVUhkRDkRGdgq3CWQcHwO3otMPVpwyo0Ik05nhfa+Ny5uZiHoELwVTktXPb/KWXFdQHLM4kfKD0dv7kddmhL/yJC6A/JnXH18JVqhT+d4b8P6ZBCIFS3TYBZlKn9RXQCUp19z24AVw/leWDrLHWMG+R0QvLB+1DofvbdegZpocWVNrb9lFOXz/qaqgSlEYDJ643NgAUmRydUZbGxvu2aDesBYINOOTU2HYdBcc9GyVcQI43j5m3xWUkRNa3Y3ECt4+b5kKnME95bVxQMyGzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG1vZ1RzSFAwSStPNnA4L3BJYVp0K3RrR3NmdUNUUjdCNkpYN29YWlVINFJk?=
 =?utf-8?B?UkZLRkxYdmh4VkVKQSt3SDlHQkc1Vk1BTXdFTXowemt2dzBjZnJxMU9md0VK?=
 =?utf-8?B?QVZwNzFBcTdTa2NiNWpYRGQzRFFtbHNMZGVBdXJ1K0F6THNIcnRWOHdrSFlr?=
 =?utf-8?B?WktoUTVpV3FidlhhaVk1YlBrM2xROUxTbWZWcjFXN01lTUFVQkhjTjVKWGpz?=
 =?utf-8?B?b3dtUzZ2d1F3LzNZK3Fnb0N1aEYxR2pVMXRNZlFnc0xndWJNOHR6NTQ3Wm5Z?=
 =?utf-8?B?NmdOdlRiTVQ4Y2tBUjJsd2NpQUcxTDhScUNzOGdCaldyWDJGNEhJTnRydllm?=
 =?utf-8?B?TEZMUUIyL3FETjZpbXJyQlhPLzduZUJOeFJFQ1N0WTZvQ0hwSTdGM3NYVkRJ?=
 =?utf-8?B?ekQwempGNHltYkcydWVqK3g5dzdObE5tRmpuS1kvcUFmVUViMERFWVpOalhk?=
 =?utf-8?B?MVVZbUJRVHlud0dCSDlyK1Irdk5oQ01ieTJPK1k5WGlOSDNKYmpuMHhCUFBE?=
 =?utf-8?B?djl2YlkxbG4ydWc0d0dkbFp5Mkh2T3NzOFhUVlp2UzBTdjdwVDl4NmU1NldI?=
 =?utf-8?B?Ym1ZNmhSQVhkK1RXYjJMdW9FMEVIeUJIdWxrUUNVSVMvMzJscHcvRmw3SGpV?=
 =?utf-8?B?WURYVmI1UTV4eFJueEV4RHFZem4rdDAxMGlkUTdweXRiNDV6MjRQaXFDcXNH?=
 =?utf-8?B?U2M4YlJkNGxWRElpQjIzaHNtN2xMOThMTzQyU1FxeTBNNVpkNm02T1BWUER5?=
 =?utf-8?B?SCtiWFRkREtDcDU5cUdJSjJlbm0rSVNhK2V6TmhNQUlvS3dqdXJGYkQxVTJh?=
 =?utf-8?B?U2ljQ09yYUJEckdISUtTV0dkQjRoMWtUMWo1dEJVWWRhY29LckU1T2hMaDkx?=
 =?utf-8?B?UnJtdE50M1NNbGdUc2dIamZCRUhrdVV5dE0zM01RTGMzbEJGNjNoT01WU1ZI?=
 =?utf-8?B?OWV6bFNKUUQ5WjBWQy9lb3JXUUxUbHZBeVpCTEpjdGVYR2FyWUtsY3lHcmx2?=
 =?utf-8?B?Ukx4NXRCcGhZbXdUT1E2VnBycWJySzB3dHFjTXMrUHpsUGhxOWcxZG9QQkxR?=
 =?utf-8?B?cmRaRjBGSnRadTIvdERiMHVGWmlCZG4rZ1RFUElycEhlamVKSXovcjNWeklS?=
 =?utf-8?B?VGYwWFVFREdGNGdtQUNPcHIwWG56N2lPMjdhZzRpVTNQVk1xcUZ1NVQ2OFoz?=
 =?utf-8?B?YUVqajkzNmNiZjB0TlhXWFNkbzRMNkVqaDRyaEFIbmFGTTBZWTMwZWdac2Jm?=
 =?utf-8?B?S3RuSGJBV3NvSmJWNFQvU3IxYmVWUzlVMnhaZG1nMThCcXprUDZSVXlWSVNU?=
 =?utf-8?B?MVZiTWJVR21WMUJTU29JbDBHWkpGdHMxMmg3R3lNc0t4c0dQamF3WVRtVmxz?=
 =?utf-8?B?Q1Q4YndCUnZQeFQveDlqVGpOdkdLSi8rMWNxNGNZbSsyRC9aTmUyZ1ZzMW5q?=
 =?utf-8?B?UWxlejlUaGJVMGtFN1huTW94K3FmaDhISHFXN2lnWUNtTmdCRGZqOU1NS3pF?=
 =?utf-8?B?RFNtM1I2REhicklFZFFETkkyMjk5bHRQTnM0Q044UU5IeUt2d016MURJYmhL?=
 =?utf-8?B?YmZjNFlBdC9oRk1XZWFHSWhCRDRzc0s5WVZRYlZCTzNqS0EwYmpzRlRGYkNx?=
 =?utf-8?B?UTZINzA0eFhPR0FZb2lGdGxIcE5kOHZFSHJpTUZ2cmxTYVQxYkdqMy9vdlhn?=
 =?utf-8?B?L2dYK1BMdVpsVzFiT2JOcGQzSG1zdFMvUzdoNkJFbWZRL29pTFdmN0kvNHV4?=
 =?utf-8?B?WFdXUGRJTkJvM0VVRHJ2TFE1TVk5L1VhRWxyM2lRTHZCMkdRR2VtSEtRL3B6?=
 =?utf-8?B?cHZaemJkTEIyeUpEbnd0bEtmdnNSeEdTaVcrdHRTdGNJOGx2SDk2d0RQSVFX?=
 =?utf-8?B?YW5zWXhOSEFLYTd5RTlMQjNuaDR2ZUhTZUlZNGRGV3ZVNFpGOEFUUVFhb3hz?=
 =?utf-8?B?UGhXU2prSDF2UXBKNGx4U2JjNEYrUUJSd0xHd2RXUHRwQk1CUW9FYlkxbEJo?=
 =?utf-8?B?cVlkN1BoU2I1Y1V4MEJXNkx5OXNaajNXTG1vRk9DUWs4RFhsU0UyVDZKL0pC?=
 =?utf-8?B?VEd1Z1R3b0pLVnlyditmT2t4SzhIM015blQ3WDFpYVlIMlRtWWM4YllZdGFG?=
 =?utf-8?B?TjVRZHg3bnZ1ZHV5RmV6aG4wU09xUEhrNHFYdmc0MmIvNXUydWxieCsvVk5C?=
 =?utf-8?Q?mktAHV+FpyQpDapn0C3HA/Y=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: acaa3bd4-d3d6-4005-8198-08dc48b37d39
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:58:11.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3MmJMPNSRioVrs0+cBcYF5+tsn5XWTJhLhLYV6SV2GpBpmdMrdBM8s/ispNCwfB7EIb/dL4hsa0OElqQPHEXskPZQe94MVO38PTAFCuHKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

The touch-overlay encompasses a number of touch areas that define a
clipped touchscreen area and/or buttons with a specific functionality.

A clipped touchscreen area avoids getting events from regions that are
physically hidden by overlay frames.

For touchscreens with printed overlay buttons, sub-nodes with a suitable
key code can be defined to report key events instead of the original
touch events.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../bindings/input/touchscreen/touchscreen.yaml    | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 431c13335c40..3e3572aa483a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -87,6 +87,125 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  touch-overlay:
+    description: |
+      List of nodes defining segments (touch areas) on the touchscreen.
+
+      This object can be used to describe a series of segments to restrict
+      the region within touch events are reported or buttons with a specific
+      functionality.
+
+      This is of special interest if the touchscreen is shipped with a physical
+      overlay on top of it with a frame that hides some part of the original
+      touchscreen area. Printed buttons on that overlay are also a typical
+      use case.
+
+      A new touchscreen area is defined as a sub-node without a key code. If a
+      key code is defined in the sub-node, it will be interpreted as a button.
+
+      The x-origin and y-origin properties of a touchscreen area define the
+      offset of a new origin from where the touchscreen events are referenced.
+      This offset is applied to the events accordingly. The x-size and y-size
+      properties define the size of the touchscreen effective area.
+
+      The following example shows a new touchscreen area with the new origin
+      (0',0') for the touch events generated by the device.
+
+                   Touchscreen (full area)
+         ┌────────────────────────────────────────┐
+         │    ┌───────────────────────────────┐   │
+         │    │                               │   │
+         │    ├ y-size                        │   │
+         │    │                               │   │
+         │    │       touchscreen area        │   │
+         │    │         (no key code)         │   │
+         │    │                               │   │
+         │    │            x-size             │   │
+         │   ┌└──────────────┴────────────────┘   │
+         │(0',0')                                 │
+        ┌└────────────────────────────────────────┘
+      (0,0)
+
+      where (0',0') = (0+x-origin,0+y-origin)
+
+      Sub-nodes with key codes report the touch events on their surface as key
+      events instead.
+
+      The following example shows a touchscreen with a single button on it.
+
+              Touchscreen (full area)
+        ┌───────────────────────────────────┐
+        │                                   │
+        │                                   │
+        │   ┌─────────┐                     │
+        │   │button 0 │                     │
+        │   │KEY_POWER│                     │
+        │   └─────────┘                     │
+        │                                   │
+        │                                   │
+       ┌└───────────────────────────────────┘
+      (0,0)
+
+      Segments defining buttons and clipped toushcreen areas can be combined
+      as shown in the following example.
+      In that case only the events within the touchscreen area are reported
+      as touch events. Events within the button areas report their associated
+      key code. Any events outside the defined areas are ignored.
+
+                  Touchscreen (full area)
+        ┌─────────┬──────────────────────────────┐
+        │         │                              │
+        │         │    ┌───────────────────────┐ │
+        │ button 0│    │                       │ │
+        │KEY_POWER│    │                       │ │
+        │         │    │                       │ │
+        ├─────────┤    │   touchscreen area    │ │
+        │         │    │     (no key code)     │ │
+        │         │    │                       │ │
+        │ button 1│    │                       │ │
+        │ KEY_INFO│   ┌└───────────────────────┘ │
+        │         │(0',0')                       │
+       ┌└─────────┴──────────────────────────────┘
+      (0,0)
+
+    type: object
+
+    patternProperties:
+      '^segment-':
+        type: object
+        description:
+          Each segment is represented as a sub-node.
+        properties:
+          x-origin:
+            description: horizontal origin of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          label:
+            description: descriptive name of the segment
+            $ref: /schemas/types.yaml#/definitions/string
+
+          linux,code: true
+
+        required:
+          - x-origin
+          - y-origin
+          - x-size
+          - y-size
+
+        unevaluatedProperties: false
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]

-- 
2.40.1


