Return-Path: <linux-kernel+bounces-30855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78C832527
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE1128664D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E602376A;
	Fri, 19 Jan 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="xvenX6cK"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B33D51E;
	Fri, 19 Jan 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650227; cv=fail; b=D/AJwwcprknYPg5dvipH5xufqVa7q+pjvHmAOjxwX0b/3ca8n1G3QsvyiBf4pUyLmfVrSFlY+eh1pNEcA8lE7gScCuaTItZ5kiR94TrPaGMFxkva+fPBWcEtWMCA+NBL0fu86ihMlSvFaj5kJy5mLn92TEHuC5qgVVixLjVKJxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650227; c=relaxed/simple;
	bh=ZNiTABoFYWaEKt28zFdQtWrro1OPl0Jcasv4659bNPQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DMWk63tr63tTUD9RG8ZNbbKY1aYiwRnEuOrKHoQDojBe5qLQANf+Of4MNYeJzuW+qic508NIAxXX7J+0GbokNeM50F46TG6N2varfMFv17pMF7Ll9W58F+KRkpsrDul+nsytlfIKS3FlDmmmgPfupqlL8tUNc9qUQ+zvflpZCsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=xvenX6cK; arc=fail smtp.client-ip=40.107.14.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0m2qf8+dAY1f1c/yq7/+MI/QViNX/2Y7+vYFJGv66WYS1HmSzwiVwGuLULYF+lWkmMbfK7oxoUTUkUrfXydP6ZkAGU5TMvMCOl2JC3JAsTnqsPiveWg6DVwz0WMFIPDUHtUKT1YZjIMRuZD4MP1qnb1PVzPhh2abOsfrH9KxrR1CzCg4gDOyeUlL44Y8BYC0jBysogUgYovuHWm1h5E1E4v5I2xJ5BJLBkZeKoSKnwSeCOVbrcNIy/ThcriC0m64oTANFridG35i6KjHtEsFxMm7C6A0tZXhHo+IkBCdRRvUuxGhJMsqAuNxob1JmmQwOkfWaSXjbdhzIcz2qpIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfyo3V+MkSiy+1nqFG9sFBwgBkZCJ+lW/9nFNEcd/Lw=;
 b=OZhYxY4YqbhPhlB3O5m2VAZUXS1Xz3l35QWDGAU2Jv8gQSzLC+AWe4901j6J8lcT7lXWCvi63WUlwuaf7LI0r29/GOl0wV7ILoMC/UBKUuigMqq97F1NpSHK4x0MsbwsVOkIG1+3gj+rtqAvt81HRpaIp6BngEO44GQtUCTcn7VyNHYevs6KGQAyUMl+M/7jDVqm3knLZ0WUQ5TgQUWRab+CRMe9YyKHVKtrzbZkw6SbWBd5v5KDmV99M8yN2Hh6VzieL15kb9Tx9rTVHE7WhWm6ODCGevdhgTBL+vk4egq1qdo8xM1sQiQR3i8zZX3snYFUzxBfhyOq7ZNtnNLbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfyo3V+MkSiy+1nqFG9sFBwgBkZCJ+lW/9nFNEcd/Lw=;
 b=xvenX6cK1mypf+JIZry11joY7D4FpW4LyK5oNrKxJTti3b60r+hYPNZkVd5ZdqyHE35N8Pf4TUKNdfsQiHPQnaxl0sxqF6iCeAm3XTm6d/Knfjv1i80oaOyLP79ZNqqI7jhPA9UEn386a429db8E3B2N9om3CbUT+lJQKG2kuUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM8PR08MB6578.eurprd08.prod.outlook.com (2603:10a6:20b:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:43:40 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:43:40 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Fri, 19 Jan 2024 08:43:33 +0100
Subject: [PATCH v7 1/4] dt-bindings: touchscreen: add touch-overlay
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240119-feature-ts_virtobj_patch-v7-1-eda70985808f@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705650218; l=7143;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=ZNiTABoFYWaEKt28zFdQtWrro1OPl0Jcasv4659bNPQ=;
 b=wijrqGc7/fG1CEWL1EoYb9UyG8jBaYyfB9lbTHaMxMId7dfXpdyAfzZNJVRA3erENay+nxDiW
 61d5pwmITlUDHdppN6RtxDPQOtPRqoLaxwF7RbaX0Rn2I2vvoVg8aks
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
X-MS-Office365-Filtering-Correlation-Id: 458c6b6d-b3e6-44f9-cea0-08dc18c25aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s2XYyhqwotNc8ckbEd1XtPZnv/aAO3j9i5Fscd+adJiEeZIJcvqU+afERnGUSBsmoeP6bjW2EC/0DX3RJemwG84Fig9RkxgUA4ujprF1xCyY7N4KWdeerrh0P0QWay7fz6nWrOsrspq0r8Y4l/AOMXk3HZl4oPFUXey1ZKfiRL9B/qTO0Yvts+wk5KPH+RMiiojvlP0UYPmft2DZ4rnwNvVW6kRjUygcPgMfHV5ZBE6Zte1AUtNG+EdZGkuMhk3HTZd87xB0JMt5MwMnFp17er8jNt2N7FTZFyCCUFobO+CATAAtcDpRIu0iyiy2T9FhtH1BMCQgfXEIh8UHKCRc9Zr426aX3AY/gilWZug49TqNI5rzMPkG2Jz99h8zOoUeDcqVWDA7ndxqBnUrdkHr6kRR5rI+MtSw8TlppijFsUuN3rGFtBlZlUCk9epZnE4fvkWajbmuWbPk4qUlC5Q/9EHgHW5M4ABlFE9oDhVZe/TZy0Qpg8JpMXT5uIqwokAr7Y4KHgGBh68cJexscX4UU7wr4xINcPdTzsgnlG9Vwgk3n4pXFVNq0VEkjQLvxlusw4en4IZFysQm/7uxMl5vBFolgnVr6NPRtuAUnDbffxsxEZVn01yL433Bdz8TCK8z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(54906003)(2906002)(7416002)(4326008)(5660300002)(41300700001)(86362001)(38100700002)(478600001)(6486002)(36756003)(2616005)(6666004)(6506007)(6512007)(26005)(52116002)(316002)(8936002)(8676002)(44832011)(38350700005)(110136005)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkl6SENkNHg5cW96VkQ1TllWRmZmd2VxOXczajFNLzU3Zmh0THhxQTBVWG1J?=
 =?utf-8?B?aThCNWF4c3c3MDdOSTdTemY3cnlHOEpoZjRiOTNpSStYcm1LSVUvRGFtOEZk?=
 =?utf-8?B?NEp1WjY5MG0waU1UN0RmVnk4TlVicGRlclAxRXNwSDN3WFhVc3c0Tk5RbjVp?=
 =?utf-8?B?eDV5dU84Wjltak02TXhVUEJzS2FXTUozblhCS0RuVWNlTktjQlNzbU10blp3?=
 =?utf-8?B?MDJSc2VMTFhNdFoweFhzZEFFSGxQMmJHYktMa3dxTE1WNW5vaTJrTSt5WWs2?=
 =?utf-8?B?S3F0NXBTZklmaWM2NFRkR1FvQXAyd2toNU9aSWlhWit5cU9MSEdkdTBkWm5X?=
 =?utf-8?B?V1lDeUV6RnlEU1ZGb09rcXJYUGlSeTIvVFFDUUk2cTFjRzZRcUVUcm1xU2VZ?=
 =?utf-8?B?QVZVMi9XdnhFYmRzaVd1TWlKOXo0ZFJLV2ovK04zY09tL0RiQXd0eGdYckZz?=
 =?utf-8?B?M2tWSFd6SXh1M1VLMnhtN3BFTStwOUJhcjNHeXFEZVNQSSt6eVhFV3pBL1dW?=
 =?utf-8?B?SHE4dUdGNnB3VVhzRit1VXdldC9BMG5FQ2NyckFsZ0NFN3Vta1U2Qm9CRytq?=
 =?utf-8?B?MkFyeTNDQU03U0FSbzRKZS9SbE1vclMyazhQRnRUZXlvTlVXQVhDR0lyWmM4?=
 =?utf-8?B?NEZzaDNNcjEvWjlxLzJpcHRzdmYrc090Y3lJNmdhNU9FVlR3Z2Jxck1udEVF?=
 =?utf-8?B?OHZ4YXozVU0vU1hMTWFxUnNFM0ZWeHc0QXBSdWV3dmtoWkZMeXBPUkVNa3Ur?=
 =?utf-8?B?WnJCeU9tZ25oV1VJQ0VQUjFubzU1RUs0dTVHWVFFckcxbUtodjZTeU5HUVFu?=
 =?utf-8?B?ZXRCM2NsekZLcEY4ZkpVZGFtN09zdTgxd042UDJhdnE5S3VjbjNwc1VyejBS?=
 =?utf-8?B?aGw4NGgzYi8rcG1RbzJ1bGRsNUEvdFh1RVVyY2E0RktUQnhDcGxyYlBaYVpG?=
 =?utf-8?B?cDZYanN1VEVGZDJ5RDBYY0lwR3FWVnYzUEg5K2twOFBNOVdTd0duS0xNZjJF?=
 =?utf-8?B?UzJIZWFLaGlveDFoc2FuKy82SU5qbjd6M0pPQVlIWmQ2MEFRZ1FOTWFmYlh2?=
 =?utf-8?B?L0NpU05lUW1ITytGRUJOTDZrZExDS1lGSGZJc3pPWXg2SlhXR0dOQmFDUWVR?=
 =?utf-8?B?RUdsaDIvZ2syei9ZOEt3OTIzQzA5dHVsSy9MUjNxdWd6VUVBVFlpaG1SenJj?=
 =?utf-8?B?QmJnaTkzcEdrbmoxOWJoVnA5aFRxM2xlRUJ4cUQvR2c0Mm11UjluNExOOEFE?=
 =?utf-8?B?a1FXczRYd2JKeHVDcG5HalRob1E4TlFFQ2R5SWQ2eGErTlNjZldicEM2eDY0?=
 =?utf-8?B?L2lqSXBRRytnVy9vUVhsMjZMTHVkdnBGOUFSWVJDTTVMQVc5cTk2RWwzaU9O?=
 =?utf-8?B?SmNTQzlDNDdsSGk2WEFoQ0dLN1RTcEEzbDhtSUNBeGJPczQxaU80bHhCbE15?=
 =?utf-8?B?MVJQbjhSUFQyWjQ5Ymx5czZkV1hvdEZpVDI0TFpqUUpHZXg1RlZIR3JCdW44?=
 =?utf-8?B?dEx5eUtiR09pSHZsRjlmMS9oRHM2U1Z0UUxEMW14VXJWcEpSREdrRnBtNy8v?=
 =?utf-8?B?NVpQVXlnUUJWMjdjNlZlUXZrVDY4Sitrb3F5SkhMTjRLVmwxSGhwSTFyVmIw?=
 =?utf-8?B?Z3pRRU9mVVlWNHdLSldNUmk4Y3dzQlNyeGh0bU5JTUdxcnNnYVZyblVUQlZN?=
 =?utf-8?B?RSswZDJCZWNIMDRUa0Zjd3B3UndKSDVhVTlkMzg1TEZ5QTFWS2ZJQXFsUUQv?=
 =?utf-8?B?MEdVVTBKNzBLMk9Gd21ZUVNFeks0aDVVYmpobTFudXpNNnBsejYwYzJKZmRO?=
 =?utf-8?B?MnFkWDRFd1l6QlZQWXVKYXBBQ3RLQUpRdlZlR1NOVzNZQjV1SHJndERrQlZx?=
 =?utf-8?B?RFlSZGErWkRYNVVVSHppQ1hjdndYL2J3SEpOckVaQkVxWExmald3eTFYSVB3?=
 =?utf-8?B?b1h0LzhTbGErT0VnaVc1SVBnZ0FTVFNZK0NoZnpVUU96SHhheTBWUEU2SHRX?=
 =?utf-8?B?akNGSnJhSTBrK1NjNUFGUGxBNGltL1lwM3VSZlF0N2xVZGsvc0JZblpTOGJl?=
 =?utf-8?B?T1pFbnJFZjdUVlRzck9EN0wxSitnUGdkZTcxSjF1OWJXbDRLMFNHZjVpVUx2?=
 =?utf-8?B?V1czNHJLQzN2NEg5M3hITzJBVnBDMkhndU1hdmVwMFE3OVRqb2FxR0ZVengr?=
 =?utf-8?Q?JNbJc2CR6ciWGYAY2lDXfs8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 458c6b6d-b3e6-44f9-cea0-08dc18c25aa3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:43:40.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RGnNXKicHJF/jU9pzoBIQ7hFaDTuxfqXJ/epol6vtqqQ7rReGmIlhOm3GXz66UXtW7Y++bIThFwhrA09J3pjZX9ZluxDvPs8Lju6JiBJm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6578

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
index 431c13335c40..eb1e86fa86c6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -87,6 +87,125 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  touch-overlay:
+    description: list of nodes defining segments (touch areas) on the
+      touchscreen.
+
+      This object can be used to describe a series of segments to
+      restrict the region within touch events are reported or buttons
+      with a specific functionality.
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
+     where (0',0') = (0+x-origin,0+y-origin)
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
+     (0,0)
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
+     (0,0)
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
2.39.2


