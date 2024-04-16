Return-Path: <linux-kernel+bounces-147685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B388A77B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0901F23E47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAE13A24D;
	Tue, 16 Apr 2024 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="s3rOz04a"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2060.outbound.protection.outlook.com [40.92.64.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2884DED;
	Tue, 16 Apr 2024 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305922; cv=fail; b=DtXLfpsw/BzDEyTmTKpevRKkO60CfMZ47SOPpLmTYg2pX39i9LmZ9ZiENSG+llGi/nlR/b0QCK/ihok0DVqHvyNNSi7fLsb51rtGBL5NaYH+79GWBvsDs+F9UCUmjvDWSL6eZlYmokMbWLawYYOp8p/u1N75iQ72EvLgZa13YU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305922; c=relaxed/simple;
	bh=t0xYnJcdrcQS/j6B2jl17gEkTHRnrcPfbUjN17E+ZoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qS3NCVVmEzKVABE6tvz6m6NiFpb3sgenkgpVyQxs0e8NywkJJQrLTBrX6TZGMPvJDF+fBap8a9IOOw18rIPN1h6FU2Zch291vJRVz8vTjQYqir8rTOQOcF5XVn3BiX+0sTc5UiRbpyz4nJGdd94B8NqQCN2blUxRnKvGtf8RtlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=s3rOz04a; arc=fail smtp.client-ip=40.92.64.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6GwgwAG8jhDDX3XfjTuj6MVWRQod75N6/sSgYGNTKdgBbt3IEXq6J3XlmzbzVdnOD6hvju02QG6s//gqT5f8GL/E2caZNm5eE9ncBIiayZ4gN46n4wAV/DH6+VLb7B6s7SUiTwxLGCk3bfzdtAZPYput/5TyRGoqQd7CM8GQqiUvLhgiJNdb6j4o9Jx2FE+hzR8vkTx5ZGuZA2+Z6ll9VJlh5X0z8bKhU151yiWMOQygZWam8Sj8gZRgM/yDwJkq+yDCb/pNlVHGz9yTPaUD5yavWOkENsS+9VxDGc9v4wTrvine6n44OMBCYZy3mHRa/R3jB7VXDZogZboGJXW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9wK63hsNnLDHV3UlerEtuvkGUw4te9yNuEsJmOarEo=;
 b=Nftz95PYFf+QXMlR3j5MHdjxuH2olEC2KlB+CcX0FWh0x9wAvkByKVfCvM0RNEQfr3/Re15JpCJuEEP33UQX1gBKDT56RKM5BSNbJ+7kqs0G+LWsBGtEXC0/UsfpJiCRen91lqqtq/qkjyj+r4o5oQITArqDz/WHy0bBlQzD71vAHYm59id/IBvMIthIMas7Y87BBhT6XP2/Oob/l9al0qe7XVzvpeJ1E2QzRjVafVv9T3Pd+korcUQlfXHCzeE0JASBXcJiq5rDPxYAW3J+EaUxB35f6pnTWmiEAVUaXTvzuBEBEL45uLjZDShHCmSyr67tC1km3T9QuLqrGmh/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9wK63hsNnLDHV3UlerEtuvkGUw4te9yNuEsJmOarEo=;
 b=s3rOz04aQtokYlkMo5k+TfbWQhupXno8lKu5KPZFlTCKogYA6ea04lsmRprN8Srec0QuytQ27Cv6dkEA8vncMBzy0KXZnYeG3QewGjiLnrBjGvsrWQqtLTuJ1PAyKrBsiwGvtCRsmeKu7Fs0fGcBpWgaCnMP2nHMU7ELn8cF404xuR0hS/1ZbCVzYQc0RuI/7bu5QI6pjsFjxyffBFoagL8qIhaRQyHVKUFdSTOCmRAurJCJkMGN5o/dKM7EqxrvN42HI0EVSRFqTqK6rZ7Vn3poRr58Hd1obeRDchSwwnVsAWZWaGc2/WnNL5LFvN4DlxXEYtVOfTLZhPMoEwjxKg==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by DU2PR09MB5357.eurprd09.prod.outlook.com (2603:10a6:10:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 22:18:37 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 22:18:37 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: mgreer@animalcreek.com,
	krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH 1/2] dt-bindings: net/nfc: ti,trf7970a: Add rx-gain-reduction option
Date: Wed, 17 Apr 2024 00:18:15 +0200
Message-ID:
 <AM0PR09MB267553535F7A85EA639D739C95082@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1713305374.git.paul_geurts@live.nl>
References: <cover.1713305374.git.paul_geurts@live.nl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ggxY9ltyv+sILJH1vuaZ3hcE7+EvDSKNqZyvyedAYQzqiWftGNnEZTC1Z1qdEgZF]
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID:
 <2bcf524807880aee5c9aeaf079b2b04de695db5d.1713305374.git.paul_geurts@live.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|DU2PR09MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: e8021eba-9f6f-4f06-641f-08dc5e632976
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RGqUkIaGd7EaM+owMLVNPIP8nWbKMaxhTTOLSwb76e0isIGj5VEZcsw4lIO8Zazp8f4aPov4S7EM6EvXnxstc3C0sLdkvYe9RcgIhCcleCbyRgmH0ckhZsgF4AIGuX0mamvMY/cMKeneyKPxPDyFGUYIHr8mJVYzUmHP3H/ZdWMKzV8s9Dv3SJmtPGedGAStgmtEKcaf2sYMBrsQWhNyyDSMFQcIl87tZcJCn0uFLIJyYe8YKP/Ua6SoU7KNDyUtk5SYc+WGUMTmWvXR0BBmPSpRfe/s/PuER5PP1UtpWaP0LRQHjLoazrqGcPqXoonWz8gfkwuR3GM/ZMVZB+KPfmLEcz5JAPP9pjzd3zQjPxeTRCwoJDqhyeLvFYEFLI3/S3L7tejuvFk0jpc9UY8UJ0/K9dsU1jgONXmb9VoA+GrEbx3FUh9h4jW2PLUNjW1RcW5u55/WKB8qOsomh20dFvtifWEN95c/il9K6e4LXQxjGY+2JrdY7jZQxqwTME8KEYpWKi9yKwzXP3sSG/EjARdqoO5odBJ3U4QB6/72kD7gwk76r7dH4aqUI/A7qRFBlRdOHLEu0s958vwQJjWEP7Ic1oLUjiTIlXwkFuFEKtNM/92sI4CHoOJ9Axd61eHb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qn15LyvDsFBE5X17M9WL5e/6fhgXQpWGHDbabL0NtjQurbU8FlWgu9o3O4vQ?=
 =?us-ascii?Q?ttKuwusEzgQ5MHqU9YJBuP7xAmckYxTmYRW90OXCHgEFwy37HTFGvv2rIEaO?=
 =?us-ascii?Q?giPeoj8SwC/hG80vQw6V65hIuH4SE5gwhe0x2cSgzIPyZ0n3trzbqifwdFZt?=
 =?us-ascii?Q?4HZl2pPEoHP3H6vBYHJ0k2LjJ0GjTcQEsz1wXF4bXf9V+o2bM9nhngxbbEOA?=
 =?us-ascii?Q?L31GEKhvCsUxCvBxH05/AmRm5rGl+u9Vj0uzScbfiwLMUQEZpC7LEdKRMWQz?=
 =?us-ascii?Q?lB6bz1ULQIWy9GWD8KEEw+VulGiMQxUmmY470uMYL0L4U3/sfhNGF5qKWyv6?=
 =?us-ascii?Q?W7PN4og0hFX6YzxLtpITWNZ3f5GTA5+h7Mn0bKvdBwEQ9BcPPdbdKVTbhivT?=
 =?us-ascii?Q?XTRWOtbRxwhMtrBGIkytuYl/fCf/XJUV5nw4LtWQjj8X1g7creD9fStn8m6B?=
 =?us-ascii?Q?PNvznRjAJTzY4bc4TtANdCDpcUwxJ50aySt36uzo2/4R7b0S12lJHDln3zEm?=
 =?us-ascii?Q?qM3kxPfs73q5s9oMjV/NYR+MZU5OM0BlbxAFWcL+AeMognIRZ5nNoGx6/ilt?=
 =?us-ascii?Q?lTvhqKajXcrFi9ca9XP2qvMWQ6SUy+QchTsPPCdNGVHumM5/X4CGMsaGml7S?=
 =?us-ascii?Q?2iCwZkAd1dntMDqg1iTZofQskEfhoOE3HNFoXMaJk00w9sdRtaoQ8CKrISKf?=
 =?us-ascii?Q?QRWGscYCb/lJpjCCz6wG3T6+oK631zewy3X9elieyDHitmwHLc7vThje22oe?=
 =?us-ascii?Q?nmEJKYQvtSOlr6kkFxPdfAwuavxNQd9ISvIUsRwcE2aUfTrLn0SyjEVEMsS1?=
 =?us-ascii?Q?iA1/hFWeQiRBp4dSkCFUrnxukzUGU6YKRZ8TKgni2tnT3hALCAcYdRLyILWe?=
 =?us-ascii?Q?wkIveaoWl299UL15SX5YTcDS32Fx5fMXXulnWFprnqKQj2Bl0OtXcQGN6s25?=
 =?us-ascii?Q?lOztH7d2O6Jpgt6v3jFT5IBe/xdE4Q/cPbC7JzNZKhfVBkt6JOSw8tW56jyt?=
 =?us-ascii?Q?mu0YOVzRW1+SZ5Qj39HhglAOCHK5FAG+mKgydznBwPZf2P52VGHHGvfXoWXo?=
 =?us-ascii?Q?rJ/fQA2CzEgZ0mlSn1CAzdn+W7SR3kDxh4VMhFFyT0FYQtB33DRDK7GUxKvh?=
 =?us-ascii?Q?Xwo4WVxrvLTnRu9yErSKYUNNiKSuK0PQUOPg4jme3Y7wdjWgCOF075XhQFOf?=
 =?us-ascii?Q?mQ8BpZ7+tM4vJ3LGsVYpNNnWTuRtRxfBNuttkZXF5vkw05lAxJihmkMwb9O/?=
 =?us-ascii?Q?x3cgmhCCDBQkVohZ+uXRt4cWmyegMwMn6mZhIJysopsJ029EQ1AtNVZJiO5m?=
 =?us-ascii?Q?yZc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e8021eba-9f6f-4f06-641f-08dc5e632976
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 22:18:37.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR09MB5357

Add option to reduce the RX antenna gain to be able to reduce the
sensitivity.

Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index d0332eb76ad2..bbd045f6cf04 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -55,6 +55,11 @@ properties:
     description: |
       Regulator for supply voltage to VIN pin
 
+  rx-gain-reduction:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify a RX gain reduction to reduce antenna sensitivity.
+
 required:
   - compatible
   - interrupts
@@ -95,5 +100,6 @@ examples:
             irq-status-read-quirk;
             en2-rf-quirk;
             clock-frequency = <27120000>;
+            rx-gain-reduction = <3>;
         };
     };
-- 
2.20.1


