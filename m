Return-Path: <linux-kernel+bounces-40234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383183DCF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B06B2813BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562151D55F;
	Fri, 26 Jan 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="AUoVsn2e"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658081CF98;
	Fri, 26 Jan 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281114; cv=fail; b=ZukU3YOLWcw7ZQz+OiAZGVtaOU63jm+3iUSadOxqGQBeZ6I1PqS3blaOjpMTw2dkJgVG54gJmaqhS4dHuvPb1QPC9fUbyzU9DP83cBq/vTp4wE5Z2OYE7hOd/LLkTY4yNRdwE8c4cmTEaHzq/rpAG6l6yCdaHntaD3Uks05Zlzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281114; c=relaxed/simple;
	bh=bU8QzIIAEmLwIHySXLaVymY4yS06nq9pd0KTDM18h3M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VkjMxfiGBJCNAJA2FoASJclWcRaKbooobRwRVyFOPLiYQqHv2E23pfLUuK6UJ5NQHH6fekE97/snKv28HUbRN5tvWZ0fl23z24yh4AzIF6CG+Xc8rlFhhFbVN+Nwtw8k+Yb0NEuJLOBErRfs4U+pR7qHeu9JEoHqv4+D7kDZGUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=AUoVsn2e; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPupAlI8bKDW7Q0jLQ0HQ62YxGPEHdUngDJ+O7sq7dImxH5P9K03ZxV+IeeOC1sUe55g+JB40/Bx8u5rT9Icdzm2mdbDo9xhR/BdvLNGjLbREGHzioYcL8CXbGx0QRQSD7lGDqfBh/o7QdkKvYVKpuHegV4Spe5L5RJzq1oqBgPrCuXewdi3zewNERYQAFOZ5gZcUNEoRV2CTvG+Owt4HJYY1z1O8ybVvQqmOlvnTBOhDNJaoAdADcus6Rd9qqL/ywlj+Jt9DAPvHLmxMdrEO6TgSOU0xJfCa/SB5iZkk4V92+f7O3QqRI1wpMylb6Y6FUUm1agFtCpJBHZ3RIyLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb46A5LLYS4lPodtjzqkEpywdweV2Ij7mTZrNtpcHr8=;
 b=Xy/r1gUoHpv27k4MqUOVbbe66ZnP/SWSdtQ6xFIr+4cwEbwl38jPhzrI0BuV/DxWrYkfBvAhNTFPnjmeagJpbimMdXI0wzTysvRK1km5nQ1jU3uOVP5u+EZ566YG80wtEvAsct/8f+iefB59h9L1cyFZ3tpFolic8+a+jPm/BK79/VKlCCjfuxDts5oEux9pNTwX2s06Q9ypxrJ5BSAdyublzVcsdYn2H+leAaiuOl6ZQdu9/yB2HQsdgCqoBIMn4BUl6h+hufF0TVKUncJPpW9J3dWZP1Ukk3FSQtwn210B7nYo5wVF1mUfmNM6uMwh/pfH96y8Y8Thok/z3nFUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb46A5LLYS4lPodtjzqkEpywdweV2Ij7mTZrNtpcHr8=;
 b=AUoVsn2ewuC/M4TLJ2Avjn3aW6VD/BUWuLP0hiGorBQVqQIwRLb4pswJ1M+j0kfO05sbNyUkP1u6e7XDgmLKk1/9tvOxGZB+M9P3HTAO9zZIKWp6MN6qkagCTehV+lYd09yAmQGTaGXYK1r13+654Hvxlkf/J2rnTYLsfelr0nA0zm/NBEpXrxC56AoF6n6rJh5LB39h+qBS+7QhH6cXR16/Hs80d0GpxvDJODQRXd+fW/aJToUGqOX5rxH18VmA8lPCaRqwjTCK3iMwApPovrG/tup09QfFAol/3SHvYkErI3JddrQiG3aNBLu8bkERIAQv0289/3cy+fx0iyc7/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:58:25 +0000
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f]) by AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f%5]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:58:25 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 15:55:12 +0100
Subject: [PATCH v4 3/6] dt-bindings: serial: add binding for rs485
 rx-enable state when rs485 is disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v4-3-45aaf4d96328@theobroma-systems.com>
References: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
In-Reply-To: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AM0PR04MB6371.eurprd04.prod.outlook.com
 (2603:10a6:208:178::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6371:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: df1b6018-3cd0-45d5-c165-08dc1e7f3f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uL4WJea0dEcD3BP2fksuub1KNtbWiqkkZaTmvz9viKCrjouBtzhLGYEGwqqAitcn3OFXFvnw/z1lwxUsQEjtE5i2gFqIQewe9KImiur9I4XzedtiaMZdAhnGRJqao+z+hoXHZaC3RpQezDzNrajdVQHILyVo+RiGHkBHUk94o4i2QmhmHoM7yisHWsWBIwtPM5VXDwba2j6UCbpteBD7tgam0umZov0MmmTRl2T8Rvr+NbGdARyPfnEwuFsMDgvUNLOHprZhMUfFaWejseZSnArfDt4NJS3EP5kBj31Ayq494Q3FMpWabNd2fxecFJwLI2Q6SQinmu04YUDf4DLNVPhYmgf/Bvu4YXJQn7PWa0oChVSIY1ENgt0w1tiYw6MYuCZh9MkgAzaHGeVzlDHeXPT1loyJO+ykUqJLc2krv72I7Gy6ODer5PZEbtmLTG0KhyT3dLBRZS0Qsrqpaa8esDRA42F/hnEwXIvoDt2xHD1SkLPOOtAkUdxoPOr6zYnU7l6Pc4YdYNnfeNRnJ+/1SQfhKEf+L3Z1pzY+LDxH/WrTdctTFU1N9HNM4GFJHj855JWo9MEcZkNpo31eaXJMfeKpfh0c0WD4Yh9y7hVtJZnetngg2/Gp5xaonb+qsMyL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39850400004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(54906003)(66556008)(86362001)(478600001)(38100700002)(6486002)(6506007)(36756003)(38350700005)(41300700001)(52116002)(4326008)(8676002)(8936002)(26005)(2616005)(316002)(5660300002)(66946007)(6512007)(6666004)(7416002)(2906002)(44832011)(83380400001)(107886003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGNQa2lKM1FmVXlraUJvSzd1VHF6TEFLWVovbmxaeksrZlRHQ2NCMW5HMTV0?=
 =?utf-8?B?d1F5NzgweE44Z3E4MkRLdFArQWU0ZGplY0VwWG12NExOUWh4bnl4RndaZGg3?=
 =?utf-8?B?YUdTWFhVY2FIcUYxTmVYa29oNFVYTkIzdFV4RUFRTjZISXRTRkxheldYeVVR?=
 =?utf-8?B?RXd3YWtEVlFwUHFMT1RpU0hnV0cvWSs5a2N0UUJKeWxTY0FaeThoNlNEcStN?=
 =?utf-8?B?cDlZbFV1YVVXTk9jMExldytyUXZLVExXeG1EZThyZ0lDZm9Qejd0TXovQUky?=
 =?utf-8?B?YkNnOU40OGx1L3lqSTVFTVA3UVRESnBZZ1JPUjV1bXBQSnJ3RklVcHVSSEZi?=
 =?utf-8?B?KytFdkJ6clNralFUVGpUMHRYMHZ1VEVWa0oxVTBPMkgyR3hMWjdmQ1dvUDhj?=
 =?utf-8?B?VVovbCtOUmFrZTBISUducjVQZVdGdExWcGVYOC9ldHpUVnJpaGoyT3pBczIr?=
 =?utf-8?B?NllwVzdZZDhCVFFoTHl1SWdUK3JvNFVYZnJsOCtuVXJBZjR0czNJMTRHT05z?=
 =?utf-8?B?Nkd3bEYxYlRWcitLSDkyTGR0d0h5dndOYjB5NDIxOG40OUdFVStYY2c4T3ln?=
 =?utf-8?B?S1owNktnb3JEbW9xbStwLzEzbHpPdmprNm9UeHdjcVZjSWJYMDZJWWpzVUZ1?=
 =?utf-8?B?dUtpU2FTaDdGRWEwWTByV0tWeVBGM2hUSlp3OHUwK1M1a01HODNyWmNEVnU1?=
 =?utf-8?B?Tk5kOERzdjE1MWlYM2YxNk05ck1qTVBFL1RDN25Db2d6TzNUVG5EcDdYaHRD?=
 =?utf-8?B?MUJVdU9hVE5rbVdQKzNjaWFpN0lzMHhHMFIzUmdmVStqamJlL2dVbmxnZE5j?=
 =?utf-8?B?RGlaaU1pdHpKR1hpN3l6UC80MmRLMm9kWmVTUjNYWFpiZWxwRWV4NlNON1JW?=
 =?utf-8?B?MWlDWGd5ZmY5NElpS2l4NkRxMWhxbUEzRVNPMFpjOTRUZVU3NzF3Q2xZcW9R?=
 =?utf-8?B?b29Wb0JLZHNvaE9Ub0hBbHJVQTRGUVR2b0dJWTB1cnNQNFE3WTZkS0tJa2c3?=
 =?utf-8?B?NnhxcDIzdTl3Y2FuSENjbTBvTzNOSXh3VkdKV2IyNXFTUHVOaTFZZ2ZWVnQy?=
 =?utf-8?B?NTRucmNhcmNESTVLbWNjM0JmQWVoVzU2QjhsSnRTKzVtNTBHZFJrOUJ6dC9j?=
 =?utf-8?B?alRzeGl2NHJDMHJoUzhwd2VyZlBpdkdxemFhU1A2RXRLZlF3VmlEOTFCRGd5?=
 =?utf-8?B?eDF1UG9mUnFwOVhMNDBnUVhCTjVVVExITW1KVWptMzFFS2ZoZWRGWmFMcjJT?=
 =?utf-8?B?WTNyWTN0THgrWURWN3NCeHZJL1lqRm1qM3d0U1VtYXBTejNLRU1saCtBbGRB?=
 =?utf-8?B?Mm9VM3k1Y1hXMXVzNGZTeDVaZzVrdHIvYklQNVFRUW8wVnNpd1d1QUdjbTBD?=
 =?utf-8?B?L095Q2NaOEw5QlhFK0haZWdvVWRQODFMWHlWUkxLZXZqazljVmlGdkdlanJH?=
 =?utf-8?B?bTRtMEM4N2tvTkFpRDJ3ZjdydjROdXU2MW01QkdZRUlGL2NlVGtIOXl2cHJY?=
 =?utf-8?B?em9OcWZCM0x5QkZlWU54MVlyQ01pVmt1NThyVERkbElLRThVK1R5bUxwV2ZM?=
 =?utf-8?B?MUMvazNwekplZ0RIM3NpNzJaVU9RcDE4NlFSWkxldTQyYnBkdnk2NE5KV0t3?=
 =?utf-8?B?TnltL0tqSGIyNjhSNmY0a0tmVjZDY1FOS3JNWVNrZ3FDU3BQbVVYMzJzeVB6?=
 =?utf-8?B?a2t3QTBhdHU5NnIrdElVTXhaMW5YWm1kWllEVE1vL1FSYUJNaDE3VzBpNm8v?=
 =?utf-8?B?ckpPa2Q2S0d6RDZmNDFhanIwM25IUWo1L01qRlUrckRSK1R1Z2U5RUhmK2x4?=
 =?utf-8?B?WjB5aUdIcXQ2eTMxMzdQZDZ2Z1NPUkpBeFFuMHdnclVjeVM1eXNnNjFxWUJ1?=
 =?utf-8?B?SE1GSDJVeFVNUEpzRmdYeWVNSTgzVFJjMmdiMnk5MFlMcFc2TmdVYzlSRk1O?=
 =?utf-8?B?R0RERmI4OVQrNFlDWEwzQ1VJMUFlWlV3aTU1QTFGeVRJOWJBaE04bU1oM2FD?=
 =?utf-8?B?ZHNZR1pPb0VWeHltTWxGWUhoR0NadnhEVzBTRWJRZ3UwNXF1eDNFVktXTTR3?=
 =?utf-8?B?NkM2KzFROVErNXBKbFovd1NRaE9zRHAvbThOazNIcXJaMnliMGhHeHhKTGFI?=
 =?utf-8?B?SzdPWVl4ekpzSXFMWTR3T2MxeWhjaHB4OG9BWCtqQ2hKNzQ1MFcycndmS2RQ?=
 =?utf-8?Q?N/IZpXr8JxCgqBPcOr0Z2Vc=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1b6018-3cd0-45d5-c165-08dc1e7f3f68
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:58:25.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZj1cWrQOCZ4I6/7k/hdG9QO6+5QHOcATmlcFutOexe5gT9XmRucMRRbBAWYhtpREHegI4WdRna072iQCtXBZWfPr0ja4hARFgxNScK8G+P0wbHHLEShliWOt/KF14QF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

RS485 can have a receiver-enable gpio (rx-enable-gpios). When rs485 is
enabled, this gpio, if provided, must be driven active while receiving.
However when RS485 is disabled this gpio should not have an undefined
state. In that case, as DE and RE pins can be connected both to this gpio,
if its state is not properly defined, can cause unexpected transceiver
behavior.
This binding depend on rx-enable-gpios to be implemented.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index b64577036b5c..4c79dfaaf460 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -55,6 +55,11 @@ properties:
     description: GPIO to handle a separate RS485 receive enable signal
     maxItems: 1
 
+  rs485-rx-enable-inactive-when-rs485-disabled:
+    description: rx-enable GPIO is not active when RS485 is disabled. If missing, active-state
+      is assumed.
+    $ref: /schemas/types.yaml#/definitions/flag
+
   rs485-term-gpios:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1

-- 
2.34.1


