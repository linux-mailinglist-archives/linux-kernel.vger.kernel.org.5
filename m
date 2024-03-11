Return-Path: <linux-kernel+bounces-98505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15B877B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A12CB20ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9046DF9F5;
	Mon, 11 Mar 2024 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="pFDzSEnA"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1277847B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139727; cv=fail; b=mv77T/QKjz6R/2+T4VYsg/MMRJOabRwM82C8cA+dgr4Z9D0Vo95yvsFIbxMdPUwaLeOCyHEuPmg1+Q/4U3gJQFjDuawQDxe9jt/cIQF8bUUZzPCTVcnx+wYsf1ACyu75G8ZtvACVwmI1ltwntA2nGgUvCMsd5NzRUlgAkVhRVr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139727; c=relaxed/simple;
	bh=5m7VrCAVUoOhHcsEaQKjfEShqT/BI3iFDJBVUSXPK8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cCke6eTGacm5kcwnAEUDqKL/EL8TpUnigL7hWcgu7rTcOaKszrGKveXZnyPngfDe8GblVxGgEhG93UI9Q2Xh8mWBWlFHJMAnepAeNUgK19ja2BvwXfKPslHnkzFSOiRk7sxQB/dUXCG4+LSQUTJwUvKxxd0DqpRgvERYwYqE+Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=pFDzSEnA; arc=fail smtp.client-ip=40.107.215.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqhZf0QXiDYzxpeAqQgfcr+HiDMUMKZ+ELcDjJBEd2c58vKem7bQYI7wvmgIoHIeXfqmUdSLMa59LXE8qGKpalvbMPdd8h5wLoNIBoJFMoC122prmIcLMpe3MbUNAMSHdlQIXpnY63B6ZlSNiT/XcljYOT7KI7P7J2WPEdmwKdvTepCYEONld6WWnfVNVKJhM542CTVkKKMlXcrPbk8+OOCRfSKJPm1OjmfAmcHJHXVTjL9W9O8QuSlECqvY8wWpdmUwjApl7Q/mJZ7Gf1ZvZ74BC71gUdUgoRugh1AMLWhvDYe02QdcGHVz79R7vRI3Ocky814UBZsn6rnnY5TUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFbp36kjvKlVZbEyMPo/KDtwpgQ6I/chtVB7czwkh+M=;
 b=GEPKzoFCKWRHhqCq8PMndbD1pl6svzjNS4N2B3oCOJJvuyLS2w+XiUOh4iI9z784UPxpFU2sHif856AdntRvd4lXhtbprVIp6oyuoO9+8tStvoUmeTKnnESZN8qNyy1DQLRMNFyGbV9EydDHC19CaB8kOwhNC1EBYnfd6wA3cgdXUhrTmBSR//tmj7ImJIDRN9OGiUj/ZskipGUdqUgE4vsgQRc7y6in4I3GlxY/8l2Nu2ONUw/GJEUNz6FQrVgop4L53wSum8sW42zET4G6miPhP3zifFVTmJHOtR7aeityPcY6ISCoC+RNSDfxFoSCjfuq6hQkvutmumDG3FWFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFbp36kjvKlVZbEyMPo/KDtwpgQ6I/chtVB7czwkh+M=;
 b=pFDzSEnA6medVQS3ynS/abiHGowRhD3WOslO3m/1FkAAtqEFMyhR148B/TUNrV/1VHR5NOj+sADxqXrYYIG1cVfOq/0LjNCo/OV4hO3kyk642V+DW12M1u/6wTgj4ebvZ03xKp95jrpYoarwJGTx6FXa14aPJGBnfm0HX+1CdD34wVYL6TQoodKq5W2/4jLmmbAkATb6RdtrIQ/Ze4VK1xLHpaTotZEmKC+v+Wnn2TSWofauGhf0Z13eD4ywbY+aSt2ZJJiTNjCcCtwuGmk6dklXcP6jlzrSO0Y8Y/v3MIel2JQtyWOPB1XUB+m5fm+ySeqaIvmlKgxfDTSnuYnQtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SEYPR06MB7042.apcprd06.prod.outlook.com
 (2603:1096:101:1dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 06:48:36 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 06:48:36 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: james.morse@arm.com
Cc: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	linux-kernel@vger.kernel.org,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Liming Wu <liming.wu@jaguar.com>
Subject: [PATCH] fs/resctrl: fix domid loss precision issue
Date: Mon, 11 Mar 2024 14:48:22 +0800
Message-Id: <20240311064822.891-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|SEYPR06MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5133715e-4896-440b-3c17-08dc41974696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	41ZIKgMjJcb74NDKIeJRdxbgFS7zwpFx05I4Jxb3GR2ASfZO0ylK8g9OAzO1SwHal7d4AJhb6HaMMA4H07CTTh+8jlq3L1eORPoN7UDYV0GrEEQTyyQZd1DPkDk3rHXH22ldDOsdBR1tYwfGu9PQ1oZyzPYpPzgU2Rw8yQTJuaicZ4oGLvtxfsXrgupJo6VHIXcoRux8dgOkz6Omszz72FGV5eONuUR/fa66tQoURgKhkUEyazKFqbqOd01GoR9tgAnBjsBu+8OuGCqW5kpxzrIhRvAUBaYBQWAOc5QujWt965UMsjF7ueaRU3U65yOZ9X52JkylfQilBZ+Svi9thyJ/dmmtqP9jCD/rjewvbnRovFWxdSH6Odk5toW2JqBS6X19CzEwOOabTtVazmhCgQUc2B6n9+ils+EZAnRbmNYstlQ5NUWk9+GtVwrgi91Lhk9VFmZS/kssdH9ckAUZYDe69vu3EFtQ8/U/OiBgJDYwUHelbBlUqQS35nW9q+fJp90S+++Xf3Ju7/oRivNi7+mubT9HpbJWOX5OnjJWGBbjr2RfknLQlU7LN4dUqF2uqOcI07iwebUjpXqkH50oIToVCcGz/c+xqY8QXhdzjfMU5mEXxCRxRbzbKwBJVz4fvenn3v5nMvAChlwJcCe7/vh1GQEexPmcuTLR4nOmpouDk4p1UH9lvFrL36W3NLdSDackpRZU3IvyqwU1CgoSjOPGtlKFiqK+i3I/nxAQX5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIH/nHDz2AHeRQpYP0QGui8/J0gGt54NNdf1MD+ThokcHTpAmsKtyBQQV5rJ?=
 =?us-ascii?Q?wXHchInIJBVQmA+AKZq6uZ1DADDm2iXVepMz/XMwKSF64JQc3gbHHac6NO+M?=
 =?us-ascii?Q?9gHOJy6pr4Ljl6CFH060qLSWshc6EvMSnBBxiJkiOpnBHsuC9uohk6Qxqc1v?=
 =?us-ascii?Q?O9I3S1gt4y317hyTq3oNOVZYJuD2SFlrvqNebpX9o+lCfIDEY1vJ9T1ZPfvN?=
 =?us-ascii?Q?LI5XKk87aGZbKlV8SB3KL4C0klQroNEMKqtDzIZlmcd9VzKJwwwZ3nIRU3zd?=
 =?us-ascii?Q?BCxVhlGnja0C86bZ1zYtQ9Yvzu2zNJ7yAhkTpyGSOxOBnoLk5lQwJVvRjrum?=
 =?us-ascii?Q?0xFsDOQRtA5q6Q7S5r1YZ7Pq1HapU02L9VGEOMWqc08eVBh0/5eU4Qjxnst2?=
 =?us-ascii?Q?ZFYDDYEzCY9X98h70Q9XdXQv6DMaGXm3cVcm+l3A01zWEMVO9eB+aKu7N/+a?=
 =?us-ascii?Q?oSA7GeT7X2nh2urWDHVZHs7RD2rgfFiP/7mlw+oBFkyWiu4rgtoROF4yl0YH?=
 =?us-ascii?Q?lYnBa89DmrxCkGJmkkOh5VGR88PwfbjmITr7B7jJAs24ORmrBSLzKXs22vWK?=
 =?us-ascii?Q?JMzXAGL3XrKs5ydp8JpC21SVEuPNb7TgRKrR4dnfD+tDZdQt7UaoQxvB3E69?=
 =?us-ascii?Q?R27Q6qO1Cj4iWdUH5KOY54jjWMD20QEXASd9eFC9aPtndDSc7g27j0mbeGqi?=
 =?us-ascii?Q?4N98RZ6HU0abXOaKQEkMiGGrf1k9/E3UUasTs75H0Ek0mhCRg+ynnVYNUkMh?=
 =?us-ascii?Q?GOALC16z9ejYfcMYPoWF0h9ZgYuzI8wlPuDtwSZevX5ngc0bOqAOMA4aFV4i?=
 =?us-ascii?Q?WFLjZy79fDbwRjt/RGG+Y+8soPFPScoR1kVeViQkw4SOOyH+kp53MjOiD38G?=
 =?us-ascii?Q?JIHr4KGVKi6Rj42pInEL7Rtj48M18MQfiXQbaeY7zC6DKId8qUXV9m+EoRNx?=
 =?us-ascii?Q?EGvXm2I2d8JcN/xWg6nnh//27Qozzg/ZQSi42J9f5uMkcBhkYOe1wqas/ZX/?=
 =?us-ascii?Q?t4XrryVl+kKKbJFuQM3xAoFkMxBq54ckG8D+63ho13vm/smQaD8d1w/tN5gm?=
 =?us-ascii?Q?XEFoUIcAAg+kOIZTcXiZS4vJadaAtZYYa+C01axGJefmOnPuZMUUJyRMn2Vq?=
 =?us-ascii?Q?MD/FOA/1Wx6ew29MGE0DduRm4A5bxqHWQ8SQjyXcb71a4sf9ZVPJE+qdwdOk?=
 =?us-ascii?Q?Mhiv76UwXy1/wKiX+zGsQSCbqZTIvUSvssUBGxN/+V4IlBxtylQiL3CKHlIV?=
 =?us-ascii?Q?/xtaDY6gzaUQ+/eGvB9Ui1qRkgcrpuCQ75OOOnTZDoSXpDEP2rNTY0dZwjG5?=
 =?us-ascii?Q?iUMny+ZS9x5i88hDuMYPVdSucwbXHgWuQg5tN/28ZP3xJ0IsaYRw5izmqU3A?=
 =?us-ascii?Q?dB0E8X0b2xWEol+YIbynZuODzT/flBGChgz9nkp1GcpQOqzq+rW/eILom1wW?=
 =?us-ascii?Q?93QjluWyFt+q38V+bmQgZO2T8k1xBgYHq5ASX9ekuPrxRQgxYhCHzF9WuMef?=
 =?us-ascii?Q?knRzUctlYcoplROsDRwUZasZPIjy1m9slXPssxfNO/HVzGNr4mm0/0lGA4wK?=
 =?us-ascii?Q?z5MM8WiY/8flmkC6vyX9gDqDtw0B725CgzeDr7Yc?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5133715e-4896-440b-3c17-08dc41974696
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 06:48:36.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biOVJnQUGaB2ONvbnyHYPHCZvTjbOCY/LrsVtwUtDm6NYvdrObU/s8mMdrq7ioPVgRsHBKZCwYLp/2ghFHQfaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7042

Below statement from mkdir_mondata_subdir function will loss precision,
because it assigns int to 14 bits bitfield.
	priv.u.domid = d->id;

This will cause below issue if cache_id > 0x3fff likes:
/sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy
cat: read error: No such file or directory

This is the call trace when cat llc_occupancy:
rdtgroup_mondata_show()
	domid = md.u.domid
	d = resctrl_arch_find_domain(r, domid)

d is null here because of lossing precision

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
Signed-off-by: Liming Wu <liming.wu@jaguar.com>
---
 fs/resctrl/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 7a6f46b4edd0..096317610949 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -94,7 +94,7 @@ union mon_data_bits {
 	struct {
 		unsigned int rid		: 10;
 		enum resctrl_event_id evtid	: 8;
-		unsigned int domid		: 14;
+		u32				domid;
 	} u;
 };
 
-- 
2.34.1


