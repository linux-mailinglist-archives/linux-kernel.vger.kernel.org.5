Return-Path: <linux-kernel+bounces-166455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B78B9AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02FD1C214F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C159148;
	Thu,  2 May 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="g5cdXzP5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2124.outbound.protection.outlook.com [40.107.20.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93F83CD5;
	Thu,  2 May 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653146; cv=fail; b=b1HU1b/5yS74xpU1NAHeX4BogD+jvauYcWn9UaFI+HsdzfX2HXyLJgW7FqOMiXzhAbkhamJBlDNOOShV4uu18m0AWTCHSCjNcR1Bo74KStS/abNmTEfI3Z2g7Ktxsb8Qqs/YRYPL13g/2g4Vkq59LFpYyFh60LLGTD6KSTDcMpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653146; c=relaxed/simple;
	bh=a82/iC57K9EWNwj4rzdTbjU2rLR7nW8QmO8pFSGpLfA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nu93e5yfnbL25FpUMPpfrTcKLB+2fvbPzsmzHHkPXkTEtw/4kpOHYHFA2SR6WAB1BY67yqNoRHyTTTkiv6quTMBl7wWZ5Mgm4wyi+EFRXaYl5wyqNMuCRcQVNhwVInBAI/dCjuhrTpMlKoBtcoZhhzcJsPAZz9rC8DUDZ+0BCig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=g5cdXzP5; arc=fail smtp.client-ip=40.107.20.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyC+gv5k8Q/4atg/dP+nxmsUckz1BVXnBxuNeOS+p11dpdA0MIeC2R6Y4C3fErntiUos6gt0WOGxw+moYgkeU3HXamvJKJPkEaeMZcfoRkDL9TOLw3kanTTsG6MS2ENAF+nTBnda4Xz2iY7bfC2GUy1Lt/ryovBVT8NYLyI7RLX1qAnvUs+8PENXh8SfV8VVw6bNgpbGsJlAOw8yHW2SLXpuHgkw64U+MkCpihzhehVR/2QWjMcmhQTjlWKLy0/JE2ZmykwyqGlu10KytbLmje1nDx6fAq6/wXo3TvWnqG6DuhzOWTMFpMmuTMo1edi2CG1qqVVBz+Bnlba2GTOJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A0xqkpUnuOIrzGjyCUyT2ZwleT/YIRIm5XZQYWph6A=;
 b=J9AzY+/tpquzACT/YeGq3Tg9XQAPJXghBzqvq6/cbxFW/kZCKZcV5517kJHGlZdfV5RwS0ZMzhetrdf/NJ4Nf0ZK8EirtQmiywk7vFM0Az+sLKA2BOk40nX2nAWvhK3dp1BUzLkXv2M6bC23AIAZ9jqXGNaPozuHHbasEaNMrPg0D7B4rFtkYDHRuA5hR+Q+pCujZwt2tPQuImyvMEPwPg2/ZlenejOq4IRcp6AW8e+5wFhBrJs36RukqUQS/8DAdMtYml5u1yxYgPWRiOrxXDEBV6Me4LMBdHzZCwSkQSUNZerG1oeGCM7GjCbA9XGjJMTplXGtSlt5Gt6oc7O2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A0xqkpUnuOIrzGjyCUyT2ZwleT/YIRIm5XZQYWph6A=;
 b=g5cdXzP5Hh4sipVPlZCI3qEPn018MeHVWEwpruVAK6gtsRYitY63zJIb2+QwgvuwCChbUyemG43AwugO/Qx/x52rLXD/yOcLmXn9To111wck/PpksEpvoNnzLuSlJawz4JH7fayfGbPpsNUlrn6QsJHqY7p0O4WOjK8237ALm5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 12:32:17 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 12:32:17 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v4 0/4] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Date: Thu, 02 May 2024 14:32:14 +0200
Message-Id: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM6HM2YC/23M0QrCIBTG8VcZXmd4jra5rnqP6MLUNaFpaI1i7
 N1zI2iLOFffgd9/IMlGZxPZFwOJtnfJBZ+H2BREt8pfLHUmb4IMBeMgqfY1cEZT6KgU0spS6TN
 TmmRwi7Zxzzl2POXdunQP8TW3e5i+nwzCMtMDZbQCAKyUYLWyhxSuztD48FsdOjKlevzyfCuOm
 XPVIGKtK4PmH+cLDmvOJ75jqqyMEJapXz6O4xvMC+8jJgEAAA==
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f84299f-fa5a-4060-b4e4-08dc6aa3e731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amVLd1d3MlZTZ2Fjbi9XRkdvQ1doOHhnd2daZnBiRUdzbTZZQi9uNDRLeFRa?=
 =?utf-8?B?TEZEN0JiMTVqZ2dKNndXS1c1NkNoTElldi9XUHY3ZUNoSG93R3VQeG4xWnd1?=
 =?utf-8?B?aVpMZUs4YW1vdW9MY0JGUHNEV3JJa2hHcDQrNmJpWGNrVm5rU3NYK2VBSXVX?=
 =?utf-8?B?SCszUlZDeGxRbmhwcmd1OHFyKzFFbmVaR0F3Q0FvMjV0d2M0NXhDRUtybkhl?=
 =?utf-8?B?cDNLRWpwdXplZjhhREhKc01CczVTSWlsbjFuUU5uSXpXOE9DUXNWNnpDYXgx?=
 =?utf-8?B?bGxmMVRyZm9wck4vUDExMnZQT1I0MWVoRWhyNGM3eU5xYU5MUGZnMEJIV1Yv?=
 =?utf-8?B?YzBxUjVKditQeExXMVUwV0FLcXY1N2ZqZ2xxS0pqZ0dSNFBxOWQ0b2p2aVpR?=
 =?utf-8?B?NHU4cE10WjBFQW4xb1dMd0VRcEdiV0VpY3BSOVdRQlFPYU9QNjlmSlFBS1Nq?=
 =?utf-8?B?YUk5cU5LSDhHR2xqb0NCbFFFWDJqUGxOZmR1Q0JpVlI4ejZCaU01dVNHWnhS?=
 =?utf-8?B?WlR6cGpIb2ZzOENVemV4Szl2MTNIWU5zTGZhYk5Ic2hWejF6aVVVcUtYam5Z?=
 =?utf-8?B?L1JqNWQ3MnI5NVl1SXVjZ1J3ajJxdEczK2FZMC84N1lyUUg0NlVycVh5bFg5?=
 =?utf-8?B?aWI0ajRoK2NUYWxXb1ZPK2YxeWFPTzJrYVd4SXdKc0FpUnAvUEdoT3h1bWVQ?=
 =?utf-8?B?RFVUU3FPYkw4aG84UVRqakRaVWNFazlvYUJ5VFlISDBFYWp4dVZYQTZIRG1V?=
 =?utf-8?B?Ump4UytHVUUyWUsrZUk3eW85VzdwWm11SnZsRzlyQ1BBNVo5RXQ1Z09GeHBh?=
 =?utf-8?B?amtURnc3WUdKTWl4SzZOWk1BdUFvOUJwWk10d21GTFdLVzk5TzY1NE1qMHpY?=
 =?utf-8?B?WGhLVVBmdzY3RHp6TjVxdGhjY3QyblBhMXFpUXVtNWhZSmxjWmdRdkI2TDQ0?=
 =?utf-8?B?WGlxYXdvcWFNYXArK0VyaE8rdW1LNHFlYXFRVWtEY1VvTy9yNTZaRXNIY3lV?=
 =?utf-8?B?ZXhaeFIvUitSb1hEWGx1MFUvMFR0UDAwaUlkUVo5SGdJZFAwbHVWeHVqd1Ny?=
 =?utf-8?B?RE5hOCtuNE1lMytaUVY0azhNanMzVlhiTnZMdEtaTjFsRnZCSlNVWmE2dzE4?=
 =?utf-8?B?Ry9FM2pGa1NSeDVHM3JNR0V0TE9QSmdNOXdIWW1renpFM3RrMG4wNEFvMnRU?=
 =?utf-8?B?akhJVThMVFdNTFZUdS9yTXo5eDRkL0RBMmtjTE94Vm8yL2UzWVZ0bzFrQ1B0?=
 =?utf-8?B?NTdwTldUVnlDQVc0bmZWbHlFY1ZZVFUwZng3SWYrdVVTSTN4NXpxRU1WbklQ?=
 =?utf-8?B?QU5JVlJVNTJNZTlUQTBubUVKaXdJQ3h3ZUJpMG8ydWh3RjNIMHdSeS9HSlZY?=
 =?utf-8?B?cW12K3RZeXN4dHZ2bzVBLzhka0FOTFV1YmFrdlZSSmdSakxBbGN3RkdJQzFs?=
 =?utf-8?B?L2VkSDJyNlN2MUd1amoyK2d5UU5Zazk5VU5rQ3RQc3cvV3RyOUJpZk9rZFZE?=
 =?utf-8?B?ZmpxNThpZlVFY1M5aWdqZ3RFNGh2ZitPL1VwTFRLSVVsYWs0aXQyTFg3SFpx?=
 =?utf-8?B?TGFDMnN5VThzL0EwNlJROG1JVFJSOGdtYnUrdVlKYWd6dDRXOXRDbEVjNVZC?=
 =?utf-8?B?UjdkUGpQcHpueUJuVERFOTljZll4UkE1SlJKZkJiK240WG5pMHFTY0FQMlox?=
 =?utf-8?B?MUpvaXJJbkdlOXpDbEw2UXNMRmFacWptTmpyb3hNZDN1eWRUYkRJbll3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajV5YklDVlptN0luVm40ak8zQTVSVjV2d3VjaW40NDFBVVRYQU00bGloV2g5?=
 =?utf-8?B?QXNBYWdzczlCdk4yM3JJNDduRm1udjNremRGR1VyM1B4d0Ixam9nNlk4T0JS?=
 =?utf-8?B?eWFmd3NyNjY2QThySjRaNkxrWGE1Wmk2bkwySno1bHUrdTIyaDQ5V25xQmdF?=
 =?utf-8?B?SVhxVzI0aWpUeXpEZS9YOEpWV0ZrTGRZdGJCbk9PK0VLVC9RSmFkUlcyUndh?=
 =?utf-8?B?TGlYc3gzTHpUdDV3eENTZGVGWGNEOU4zdlBib2Y3MFp1cURTL3hlWTA2ODdR?=
 =?utf-8?B?d1U4bG9kT1BSbjY2RGZONHFCcENGbU0xeU1hQ2FDbnNwSnBUOS9RUHhicHVU?=
 =?utf-8?B?Tmt6enRYOVYwekVjeFoyYTc3S2x5MWVGM3czOE9VZlJUUTJBSC9CQVNmejNC?=
 =?utf-8?B?b1ZMRE56U0tMVFdDYXNtYWgyU1p6NzEwK1JtU1ozZllEc2dZdzdHTGx1VDVp?=
 =?utf-8?B?eHY2alF0RjVZNGtJdHRXdWVtbll6dDNqY0J5dmRUZzk3VXJXc2ZMSlpZajJ3?=
 =?utf-8?B?RWlxQkI1a2c1ZjlNaERlNlYzRkhxby84TDRXdU1XSXh3WWFFdkpsOHl3QnNS?=
 =?utf-8?B?RlNBYlMyR3Z2UzlDYzRRWjJtY3poVGdlbWs3bFo4bzlFMVlvQWFKU004eVVh?=
 =?utf-8?B?QjYxdm8wZHk2cUhrNkpCMzlNb0JHM0RmaGVhTG1wYjFjQlRhcUZxYmxoaUtH?=
 =?utf-8?B?dlJxZDRrbzRVSE0zaXd1WTk0cEYwTkgzT2FnQWpwYld4bXJQOE1janQzeGl3?=
 =?utf-8?B?NTRQOThEUkdSYW1QNW5sK3o4TTQ1eEExcDRYTkF0Z0JJSlZUZ2drVTBkVG5p?=
 =?utf-8?B?YklqNUgvRmpXR0Nma0tsRWFRUlc5NjJrSVI4SWtJbU5RUlNOZy9rekhSU3Bk?=
 =?utf-8?B?RVFIOEFTbFY4eVY1Rks3dE13Y0FGc3hnV0Z2Z0pjWTY4cDhYSFNiUytONGM2?=
 =?utf-8?B?SEdSYXgyay9OYlEvYXR5NFgvSElUcDJvbDBaNU5jbkNBditFeXBnZ3MzakxU?=
 =?utf-8?B?SWsvMlJhY2RmYUMzSmRTd1ppNHdjdmlEVkNkbE5PSytBTXg3OHpBeENxVlVN?=
 =?utf-8?B?R0NvOUJkazk5RUlReXVSLzhDdTR4cFBpNUFuM2Z6RitDcktZNlRUa2s3MDJu?=
 =?utf-8?B?bnhUUWVzSU5ocHoyTTNEelVCcDZRVHJmd0huWW5uNXREVDYwMzN3RmVpRmUy?=
 =?utf-8?B?QVhxOTNPK0dzS3BuYkxYV3UwWkxNdkVHUkdNalZqa0tBMEZvcWtNNFI2M0Vy?=
 =?utf-8?B?QkhTMS9hNEtjdWRoRlY2MERFc3IycXNnZWdlQjhFb2hhMGQ1QStJaUlZTjBt?=
 =?utf-8?B?N0h2MHZWNEI3ZFV1TkVLWTJOMEUrUDIwWDR3WFBNNkRGZnVndzVrSnR2aG83?=
 =?utf-8?B?dnc2Zy93ckhTd0FWcjZuTHlYZ0U4eVVTYW1xQ2NQRGlwSy9kUGMrTnBQSjB1?=
 =?utf-8?B?QjRYUVNVVnVsanA0ZHhMVTFjMW03OUY5Y0Nwd2xsQUpQZmFUWU80dXBKa056?=
 =?utf-8?B?a3UyM3FyeUt4R2EzN1ltUUxhNmduNi8rTEZXaHk1MmpvbEZ1Mnd2d0tDTFpL?=
 =?utf-8?B?V1VkRzc4ZVgxdzZZYmZvNkdCdlNhRFJBNTIzR3IyRDZGZS9UUThvL1FiUXMr?=
 =?utf-8?B?SGMxdXJ4aERvbVNkVkI1aGFzY09WU2YyNmcwL1hmS1h2Yko0bWhMUVBwc29L?=
 =?utf-8?B?NUppQlFiaVhGOEprNHlyNmhsWk1nTnhaM1MySDFOQ3ZYUExJcWp4cFVtTXZm?=
 =?utf-8?B?QUtWUnhSYkZHVTJZblpnSFZCekpCZDdjY05aZHN4T1Q5T25hY2tJd2dUbVpP?=
 =?utf-8?B?QmpIS3I3TTJKYWZSLytEUkxVYzVXQzlsMG84NC9kK1pjOHRPY3hrelg2Ynd2?=
 =?utf-8?B?dW9GcFdDTGFXZncyVlVuVC9tallvV3h5dEwzZXRGSjU5QnlPbkhTZUVHOGIx?=
 =?utf-8?B?MTkzL1ZiZHV2MW5OUzcvSndZMkhFNW1OL1BaRjhDNkZyY3RLVU5RdXlURWNl?=
 =?utf-8?B?YS9qRHdBd2ovcmh6OVhkQ1FpMWp6dUdma0ZmRW9nR3FkYWozMHVIbnhwNE1M?=
 =?utf-8?B?cVd6SlE4Zlhlb3hxcWxVaEtqS0N5ZjJmL3lSN0tBeUR6RmloVzRYOWNyUGU4?=
 =?utf-8?Q?S2efN4FHHhvzwHKrk69p00K5a?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f84299f-fa5a-4060-b4e4-08dc6aa3e731
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:32:17.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntGJKkVzzAYoP08B6xc/1ftL2tKWc6fsy/iJGtOxOWJENKO9Lbc5XB1t43IjORCvs2vy5b6BVXkhWYOZu4lfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900

SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
SoM used in Clearfog and Clearfog Pro boards.

1. Add new binding for compatible strings closely matching the original.

2. Add device-tree includes for SoM and carrier shared design.

3. Add device-tree for both Clearfog Base and Pro.

While dtbs_check is happy with LED descriptions behind dsa switch,
functionally they require supporting code by Andrew Lunn:
https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v4:
- Picked up reviewed-by tags by Andrew Lunn.
- fixed a typo and changed 3-line comment into single-line comment
  for clearfog-base/-pro dts, but kept review tags since change was
  minor.
- Updated SFP led labels to use "sfp?:colour" without "color" property,
  to avoid duplicate labels while reflecting they are each dual-colour.
- Link to v3: https://lore.kernel.org/r/20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com

Changes in v3:
- picked up acked-by for dt-bindings
- skipped acked-by for dts because additional changes were made:
  - moved legacy netdev aliases to carrier dts
  - fix status property style errors
  - add pinctrl for secondary spi chip-select on mikrobus header (& som)
  - specify spi bus frequency limits for som
- Added CN9131 SolidWAN board
- Link to v2: https://lore.kernel.org/r/20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com

Changes in v2:
- rewrote dt bindings dropping unnecessary compatibles
  (Reported-By: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- added bindings for two additional boards (cn9131/9132)
  support planned for the coming weeks, mostly serves
  illustrational purposes, to understand cn913x variants
- cf-pro: add description for LEDs behind DSA switch
- cf-base: add description for LEDs behind PHYs
  (Reported-By: Andrew Lunn <andrew@lunn.ch>)
- Link to v1: https://lore.kernel.org/r/20240321-cn9130-som-v1-0-711127a409ae@solid-run.com

---
Josua Mayer (4):
      dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
      dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
      arm64: dts: add description for solidrun cn9130 som and clearfog boards
      arm64: dts: add description for solidrun cn9131 solidwan board

 .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
 arch/arm64/boot/dts/marvell/Makefile               |   3 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 375 ++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 197 +++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 643 +++++++++++++++++++++
 7 files changed, 1574 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240318-cn9130-som-848e86acb0ac

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


