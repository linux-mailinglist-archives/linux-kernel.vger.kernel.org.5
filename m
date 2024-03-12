Return-Path: <linux-kernel+bounces-99925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93048878F43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75181C2118E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA169973;
	Tue, 12 Mar 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="diDTqarM"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B469969
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230046; cv=fail; b=tIGR2C2OFbN7fDWnqfBC5F8O/+aJGV7IUNZHaV3LYNiELfNHBpRxLaiDBm/mV6dYyg6N0Zk7y7eIKAhFd+9qTZSlfFa4vimADkJ2oyeX3qsDFVvs7ezSvjrHsARwpMjCAUfh0rcyAZEzPiVP+aU6tlRtmh9TvYkBpeO8tHkc2hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230046; c=relaxed/simple;
	bh=IaL3BrcwObFnWycQ4tH3yIaUoIx9jbFqDW3+VmYxy4k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PkJUL9cWhlOKSH/vWaZ59HzT0QVT/gKzwbU+JeVO43DdN7HpgiUdTy7F719S0vGbppl1zbJZvFLSAwQJDKu9f6qQrocqKLQeLtiYZ70XqgLCVlSosOrc4QK0TITBqCKdh72RMkWAYkcotYhUOMaoJaVrYgSTH0McGzqZ/LLoyKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=diDTqarM; arc=fail smtp.client-ip=40.107.215.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTyKL+s55JrCUVoIfXdFiXgYn2ZqU1x0ejVptxEOXIAtza7he5X3a879OTdFwBE5rrzoCCfdMsNgAcu1vPmw0ba+RrH6My8DVP5Evzkbq7XEcRmRakmIEYUe4yxvd+eMiEVIQZ2A3PGO0rjgMELGwYLA3TVVZQotWWN36Fq94Cdqwa9RJvjbTOhwULFuZjDX0lGx/k9ETB6SP5nDH40kQB9ZGo1OhsP8AdFSayMTswUTJrn3esSdeTwDPD3EdX0I+MUoLMprp/3vD5mRPxPgswef+mQTKRlB/5ivGbKZ3eyC3fbgTO2pRUjmubHzW4y8j+2x3pnFVA4sHj1qKltBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPY+m1H8evBrdj61K74ptXmE8HCUFqT75R5ziaZeWBU=;
 b=mhJSgRx4gz0AtdEphLyX6i2p4+cdrpMQA4HXbacLNWkzDIDLcIDsFGMrxCgYgDPI5vTRjJgF4a5S6E9qF+G409w0kgg25HHxBSi9mcT7lk3c0jaEcjdoTsYsZ4rOEeMbXZ/zlKPW2pkFAF9TYOw9LExV4QyLr00cVDcc91fY8veQ3GNnoz8GZyI2l2lQmWis3YlLzAchYSsfYqXsNMeR+KGvoGN6JxFgcm7iszFsEzwwo5+GhaIHnvc9p2jDOW7ZYgFU+WIfKb1dAi3Z/BFoexat1htISbSOWEZVtn+MxGh3A4gGLpe+fSS338ZQGRI2cxP9gSU4oz1TmqGM4B7W9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPY+m1H8evBrdj61K74ptXmE8HCUFqT75R5ziaZeWBU=;
 b=diDTqarMhW44r6eix79/FND4gMBtWJjoxMXfxqGEXHr3rv+NIuXAg37bsV7yl3AgSJEFhMycJrLUIrAcsx25ZkvypPdc5Zv5f8gYQtSnTsZaMkuQG7HkMFQfmfIRyyo0BNViICtaT9vHrVW+PTT2yUG5tfW+ID/xzLeFhMiuimTiBVyFPpMVZm6p8iB139KxJrhBdJ4MEjEP1DgUhjSGLw3Y5TJlGgNTceUbJNo5DnWANxDdTqUG+4IhF8tag8YT1XmLfwPkogRt1bwe7DS4ZwxDtJ9fhHDnQJy4/1Pc6KypCYlkob7WHlJHLr06m+ED6WctCmWruppsdpXim6vXrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TYZPR06MB5250.apcprd06.prod.outlook.com
 (2603:1096:400:1fc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Tue, 12 Mar
 2024 07:53:56 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 07:53:53 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: james.morse@arm.com
Cc: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2] fs/resctrl: fix domid loss precision issue
Date: Tue, 12 Mar 2024 15:53:49 +0800
Message-Id: <20240312075349.977-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|TYZPR06MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b509c5-8925-4496-f8cb-08dc42698fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LQp3+xKCNSK2igTEqpiU3VhTckpTb7cwgW40iEdlXjiPTz4y8PcjgHZnFLE+AtxUCfJijXS2ULDtWKrkyusatfZsZZmFj5Yg9xZG0PtvMSBOW4bbtDAHEaBEStqtzbfOCwZxmuo0XTb93FINxtxiqPqR6Fnr0M9MtmZN7fvd4k0cWhtftbhpOUGlw1RF6PTFb21zrcgIQSBI87IA9cjuNv5PcRGTR54xCMgXYHnIeNIiPCL4/+7EnwvqjqIVRt59BC9QQYbwhnonUIk1DNcXOsgvI8ioeHEchki+Dniwxa6Wez5TUwawuj5QICxfph4H0Ir78rsDu2H6Wv4PSFmewF28gFc+vyePv+K5DP2oVdjRCMVrVjesBxu//R8P1HGiboTdf6ZXx+nuGO4PTpfjVi5XLPtA9zRKELbEYj2f1E7C7dYkuIQBcL8jaiF3QYGJg1Zr7xy0Dg1WSJ3Vu9axHaGaBJTmC20MmK4CHgaq4015ywp9ODAN+S74JYjaH2XmLU2/UK9aUUmVk0/UEYxzQ+SHS5T7Vd6W0GlRnfcHFpQOo0W6jo7OLdtDxSINNnN1gKX4z5BxmNdqQ7YW4Ml8VsDJDX2k7mM8W/ThI3ZlRyaVHr06d8pmbyEU8veHDE1WLp8ss2QPCRvWcVjjmxutn5+U1TQaGx2X2tUi3im6+iKJQS420uhVvBrM6/KHBtiB0rUTQGZRUsY5YKe1nP7bZl84jvGZrsDLefqKMB/XAMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaMAGe4NFOaCfSoxrEuEeT8T853kctmr8Zw0bJCeP5c5+m+u27/+ngrKTKdN?=
 =?us-ascii?Q?BUI1l2JvGHTP4RGNbwDyCtnVkzOHKYW4LO7XcgTZWtHPK1SvEg5HML5M9zAj?=
 =?us-ascii?Q?Dg4AiXzfxNpIguSx1mX2zNTWDakKIHSilyMNcdJn4Mf+OpcXBwawFoFaFZj4?=
 =?us-ascii?Q?OgcSiJZHFqyymiQ4Co2734VbgUeYXL51P6OmNuJ+UHMwtLotaRZijGbbB+Q6?=
 =?us-ascii?Q?2//pVjO16ZoZ/7giPogCxtu21HPVGxo9G1yP5TWNKcPuQiOQgdFx6iP36tpE?=
 =?us-ascii?Q?Qz1SdXJ8nyLxjvVrZlfAT3l3kt5r9X0nGSREAY49llz6/DG6tRIOwf07+nfE?=
 =?us-ascii?Q?2+1RvalZ2HU4eMnKe6RFyYT56RTy4k2PkMYdttljlsvInbfiQ3bbqO+LNcIP?=
 =?us-ascii?Q?opxeOr4AN9N19k6lHZlmnmZb2T5fiGL6et941Mk5haQfzUuQYmamGhFZJEXi?=
 =?us-ascii?Q?wnqmFXGu3V10IJVyPguyp7kqSY1cU6/G4A0yTtvZhTme4NlryUXNAg93md2G?=
 =?us-ascii?Q?rKjhzxMLCaRgh6R1pw8LvFDh1Ti+l8MfSdYYLB5kls7BwBcnIcnDXT59KLVv?=
 =?us-ascii?Q?c2+FA5SJo21XdhoIR41SWkxY/A8UUfPBoUNyvINNMJwrNbFZx079hXs+zPW5?=
 =?us-ascii?Q?D39PnJdxo8ifPMsvHj06HrZjru4w8HorJkHWFV7frS6oBzMaHG7on+eJdfeb?=
 =?us-ascii?Q?g3tDfc6a0DRuSIHpTmYbRSdVKpQ+EJT6IErQb/vXQw7kIrP3NQPWzDCWfV6a?=
 =?us-ascii?Q?j8nTWZ88J6xJ74iTPI36bwTQgLrktF9i0MIsRurLv6OdYXEffylz5hK9bmgw?=
 =?us-ascii?Q?NN1lDsJRR+c3CnTqjIWcmw52W3xh/XcZUk8q29Lb9tW6SI5+PYR7Sd2IFfHL?=
 =?us-ascii?Q?S4p9nolP7EReaCVuQ6sFpoA5/xGjlz763RxbIIJfSjtkwDa9EVyFOmhoCGfw?=
 =?us-ascii?Q?gRaJiLhi7djq3/W595gOZDTDXPcb22DTsHNZtz3OIC2pTrFt3GIZqtcQSvWL?=
 =?us-ascii?Q?ISq3bYm1z/UGe498o9mTj3nvmfz/vYdDIwjB4LRRD4B5foY63w1fHJAknlh2?=
 =?us-ascii?Q?VYW7E4mSwXVoj6CJoFqSxaDEFqzt8nqdzdAbWPW0nNo20Tp5DHmVmHLg0rY+?=
 =?us-ascii?Q?gOq13e3mO0vV5MdgHs7hlEd2+6YciZSkWW5bA1hsZn5hEGZwgCvzam9JKJuj?=
 =?us-ascii?Q?URZhDrCzDYtv3rcS5RqVutiXX6RshlUQRWFPKwHYbWkbrmBEatAmq8pECD9V?=
 =?us-ascii?Q?PQKpNUvMe8o/TqcV6IAnKhCBfdqECKZek97IgtTs0lcN8OMMdiHMSvqibFA/?=
 =?us-ascii?Q?kYMa5mBuZ+PUjExawoOr/ofglhs1M/tGzuqm4xscfhVnYYLQDSh+8oKUcor9?=
 =?us-ascii?Q?MSVQc7CUP4LCxYSlC2SXiq9abXadkGAc/6FLpfT4qWVNOl3uNcicWRzLLxY8?=
 =?us-ascii?Q?nqXczBiEInzO71XZpz1SOJ/M1GdK+63T5gJf9GOzyq7NXOc/FA9Gj6cu0YGZ?=
 =?us-ascii?Q?wqgp989HTCyBSViYXbnNN3r+x8oHD2liRGpc+txT8NKr2vstrj6zamYwOcuQ?=
 =?us-ascii?Q?eUQtAVjPRyp48c74GeO6MEV/X5OHp5ID45G35+b9?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b509c5-8925-4496-f8cb-08dc42698fc9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 07:53:53.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7KeTaF+PSrHFsecuGEm/RpGG8l1w7bmshQFYY+hviJstNvaMi2A4OPXDMWpk+LCy0/zTc0BCSV77r6V60rkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5250

Below statement from mkdir_mondata_subdir function will loss precision,
because it assigns int to 14 bits bitfield.
	priv.u.domid = d->id;

On some platforms(e.g.,x86), the max cache_id is the amount of L3 caches,
so it is not in the range of 0x3fff. But some platforms use higher
cache_id, e.g., arm uses cache_id as locator for cache MSC. This will
cause below issue if cache_id > 0x3fff likes:
/sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy
cat: read error: No such file or directory

This is the call trace when cat llc_occupancy:
rdtgroup_mondata_show()
	domid = md.u.domid
	d = resctrl_arch_find_domain(r, domid)

d is null here because of lossing precision

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
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


