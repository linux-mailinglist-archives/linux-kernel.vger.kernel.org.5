Return-Path: <linux-kernel+bounces-81475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E1867666
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27AD28BF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410E12837F;
	Mon, 26 Feb 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oWIiRWSI"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2048.outbound.protection.outlook.com [40.92.99.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936B8005E;
	Mon, 26 Feb 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953879; cv=fail; b=kW5yDy6cxA7GIVbDT+jmE+vHOAXR4y9R2WI8jf7wkrfuOQJe8tPa53VyRfWT3PwBxpFip5QzP52v4nGU3r3nbbF6MdQG5+3CVlnzzRv2iXSZiuQNeuvc7mA8s1C3WWoWClmDM3/yCUBvZnQa5s0ZVoT9kkTljZWil3hBWjSqy88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953879; c=relaxed/simple;
	bh=nXAwtj7wD0TCMKrFjoN0e3i4JnzJCMOfgeKLk4fK/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VF09hyo/cOn82s4hhIBQM4Yj8weQemyJkZ+RXP/9S/Q042jr14v05XfzN7eES5MJ1+NBOb0Z1St+GdGfQFAE7rVKL7H9Tx6At8eqh6Fi4C0M7j11jHGCtgzHenOBqpTV0f2SCvFyul+KnMs+t4J3hY1fUZTa1jont9tuPw7j3fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oWIiRWSI; arc=fail smtp.client-ip=40.92.99.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX9U2jAt3Du1dpl0782chcpsWKbaRj4QEpkRW+8zM4zMPZO1XMYW7c47yrUFV1zKr+ww/k5Wx9ihXliXNgnswhcInvVgMRCvlVAzNSYwATfl5ePhJcSIiGWrH4qxQpMmiqbXVwNWPJfD2iJxNf32gp3QUI8m/KS8X7Q9npoqF5A0nhI012ivR73XaTy9bMsKva+dG9sLmj4qtyR0OE9RvEWZYGBdqLIQTQY9bZ4iEkg0EySRJmlMBWZaRCK+fQt/WTwMaVKZ67hWDv41GJ04Lzti0NniyZRFb/km/MlTC2mzmB9KJmB7zEwbYQNZ3nnYbcASFBLcMhT0AqL2BvGU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2fr+M/gLOUDqrJoMfFa20GMUP5OeoSrCXW8BTQSIwk=;
 b=k8+qkXyh8gRrfmpBqHc70g162Ll8z7gw8mpdcluIiD738c4ITiygtk5NtYkLRUPIRWybwVQ+D91rmHmn431WL11pRWTGlCU3/p1pngKRnFgBBOtORJio+eA+cZiLntdlI/W91etx1ceJCCTvTFPl/9pkl9um1ddJTBXDFIjd7vKEZcDDE/6JLxorcn3j8JDQhALlI7XhAARW2GHl4r4nRbNwSI7HbgJx3H+MZZaIy+Vj4eyaiSAnDiU11w2vDtMbpS9vEsrvdogJxtqM8dCCb0GDcQIgwRSPLKwDqC/PhBeiIR4Oqq2ss4XTOmaZm0782J/3ICm1Xnld7Tphj38Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2fr+M/gLOUDqrJoMfFa20GMUP5OeoSrCXW8BTQSIwk=;
 b=oWIiRWSIXZ3xVXXBB7vQGfy4V9KQw3J/gfM9AFC6g2R1NbPLJyfgX3Qs2IES5QXn9Rp12Ve+6ELOLYi/hLY9jP2ocoJvjE1RZwxu+R5XCywlQLYi7r4s1J2vQp7ufWviP4x60GbZlQIlStGwaNdZeenCe+J1QkA0HGa1gYr3TPiqddLj/V96TJ9m0/ykVzcM+1CdOTbi+Fo1Yb4/4YQEKiS7whQp+eBAAd0FcmbH9J7L0+SGqAzKu6Sft/YTn65TTR9ilCD9VrKvUSotoWfWTOXkoCy5QT1LsuXE3jSnpKfsMi8SUeEoDlIFiaR3G5vFESev4OEXDHGCVeKNd0irDg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3427.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 13:24:33 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:24:33 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Date: Mon, 26 Feb 2024 21:23:46 +0800
Message-ID:
 <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ffUVxoTrwJkx9AQFUnET/LjLusg4OZUy]
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240226132346.12019-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3427:EE_
X-MS-Office365-Filtering-Correlation-Id: abaf2053-4451-41c0-07ab-08dc36ce4516
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	argETSp414OuhWZlX3vO+0K+z2CSvSsT1isTTSf0IW5et13XvPAHSu6sbxehUh2aIU3w5VrF3zF5fE2GcpSVnG4Rtm0TSjb3Rj5YQPtsi8xIqw23fdLn5SWmJ6hSkQeV4y36MilMY7Z0PYDj1EqaIFZ91G/7YvaK1OGu+gER+nHitV7z6x8hHS3Irp7UBQ9y4kMr6JHML7iBgtLAODQh6MPCun1+fhO2NN7v0gI1DIK18ctgZCrZ7urdAMRhveTDdE+YuPZPGnNKx11yyLIRyLpAypf/aykPNuQfT9xRj3Cog+qrKwxd03wxnyGhbN3LHBgNK1xwaCbW9RoFY/4QV/3GGG7Y/k2rxVvqibr7BWrG1pOQR/5Gd7kyhxOJ09bwAn65/RfFlS6+C7139xXIGIBFFlJW18LqL2I7d5fAfUUUtevnkpZ6LRjI9/s+4s5NNU2BLMV2KOyrpeJYVQ/J3LTsNvmxcfpVQXz3TsDaiA2h4kz6S2nbTBqmpIEc47bkauYZ+h1u+AglEyERPvqEhoPwjBx4gwT8Vfg2wB2IU3A2CF2jMhoT7NjcuKUURjSDhAxYtAqy6JDedC8foYQ17XEK5dIr3sJjEoKvVFmDVZhKE51pEOmRrRurhet03Mnb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sXhQA6qf3k4zGvNZGs4KZjRaMD3PGLGwqwGCzhLIxwNPo3DUYcUvwcfZZ6Va?=
 =?us-ascii?Q?4lTK9fYzw3XonXc5pUIKbJsT4+tK/lFVymFGfI7AiVkoFIyKblwt/VKJNhcG?=
 =?us-ascii?Q?Mf/0YUUMU8RRaU5XVv6T0Ja4uz5Uczv4b8+6Vmd+bhm9VvH+pnJ6yMT0svoZ?=
 =?us-ascii?Q?uMVEdKNoMAYMOMxhtuxX+mS0XJqc5c3j4urTKoEDqFCtk2D97BjoV8IBgdW3?=
 =?us-ascii?Q?y49gYqgk6LFjOPZ1efMkj3eOYx9TggWQX6eYhE0jdV7Cf/UVcuRhPyFqbYkB?=
 =?us-ascii?Q?Vezhj5w2O7jfKwG3yTlYoeSnCLVZOKKc1UlgrPIjAynIpf8HZaU1x0QlCBsi?=
 =?us-ascii?Q?5r+iWl71hVUURq2HfLofv2uK5fDD/IhaKGQFDoi+OS64lQgOmVPYGU3jp1Zy?=
 =?us-ascii?Q?2C9boxugbgTnl3TC14vERhUlLyZeDRwjIG1Uk5t69/FlHCbAwBgPrxSIOs3S?=
 =?us-ascii?Q?0BFax1cHMdcVbmb/92kaOGTmmmb3yRSRkD4lU30V/heQA0cLnQdCVXlk9a5r?=
 =?us-ascii?Q?g82jKakryPv3twy6LgVlS9Okeaxs0Pck9XEcfRp8jvUCcEPSnS0uWxeuWITB?=
 =?us-ascii?Q?ajf2WrZUgpEP5+VenUkjPLJO4b1L//zC/SPPe3tZEbRmt6Qdla8xDZZCCMbi?=
 =?us-ascii?Q?OgV3JOi83fnXAvUkWs+Kv/Yg+wd2yjtEBudhjmYKCzXPEWJyzjwuZ5xhzb7Y?=
 =?us-ascii?Q?MVSu8lu1lNeYQR0RIYHXgmTcO1TJddX0YbGInoKb+OjOJDOwIxEw1G4dwYiv?=
 =?us-ascii?Q?RIFAf+GN+YVEnesQHx66eX70Npmd+a8Z3D+p6xKT2MwoeRHtqZS5MTKZzPIy?=
 =?us-ascii?Q?/HBRL1RMV4TgiMwMN/4HkOpsb0540M6R1vxz+Kyg5WeZ8Bb61EU+0TRmSI/G?=
 =?us-ascii?Q?6/bTVBIH2DT6MR8/M+PHf0skDVkVXJsUf3I9xB6uMo2WqXxXIpALLLCZGxlQ?=
 =?us-ascii?Q?KSmNLBC0++DPkpXBT3H+LEkgmk3L3rLZKQCrnKaeQvodb7OuZyr0bRhQ6hdY?=
 =?us-ascii?Q?/stvgq74laQxBzPdzBIztQXf8X2qzJPMmwhqccOtL1EPKVBA4d+RyDOAXjCD?=
 =?us-ascii?Q?yNhXWWeqvqqifPabiqb3znmEZfBi1CpOp7C2n9QZ91aHCqea8RwO5mAxunWB?=
 =?us-ascii?Q?gYO6Birfj9Pr2gveBKDLaFKbHiKx0aWBhMfda5Vz74POZUkd2VL5pelS0aWR?=
 =?us-ascii?Q?QpoQGrTULcirwqdDZXo7LfvQGWo/M2lELt73Sm4oATvdeR0nKyaKA6HMWhY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abaf2053-4451-41c0-07ab-08dc36ce4516
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 13:24:33.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3427

ODI DFP-34X-2C2 is capable of 2500base-X, but incorrectly report its
capabilities in the EEPROM.
So use sfp_quirk_2500basex for this module to allow 2500Base-X mode.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/net/phy/sfp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..2021cb4ff2f6 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -495,6 +495,13 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// 2500MBd NRZ in their EEPROM
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
 
+	// ODI DFP-34X-2C2 can operate at 2500base-X, but incorrectly report 1300MBd
+	// NRZ in the EEPROM.
+	// Besides, In early batches, vendor id is set to OEM, but that is fixed in
+	// newer batches.
+	SFP_QUIRK_M("ODI", "DFP-34X-2C2", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),
+
 	SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
 
 	// Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
-- 
2.39.2


