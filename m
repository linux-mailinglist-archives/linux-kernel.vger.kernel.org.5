Return-Path: <linux-kernel+bounces-112529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC4887B36
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911371F219D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8819381E;
	Sun, 24 Mar 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verified.se.com header.i=@verified.se.com header.b="uPHcS8vq"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FF625
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711240937; cv=fail; b=S+Q5KTM7YB3/CSJx6xQspXCSva1utFlwJhwFaHIGetFHvfREWM/AEr2ijhThp1xId86S0/EO2oxQTWD6cuiFdgC07Ukg4w95FtR/8PsgbIX1KC01ZMLMataHnSvkT3q8DCFMiSu9yqR2zfak6RNilCmQ6b71EkCcVfHSZFrFYqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711240937; c=relaxed/simple;
	bh=ETrjVxV96qhqVY/iRrVNWQ84gBYvUndujJ9Ndu33EbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B6Aw2RVU2/iFKS36T870r5IB5P5h3T8Wy/etKDWDImAv3wdFf9rauwV/uaAgS/BfmfMTQGck9HhKvOnUxALPyU4githE4UfIva+AzrqAPTQkdpxGCFqAEEWpitlq0Hm8aehb4MFIMac9khrJFY7oEjdJkhjQyF36BNlagESninc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verified.se.com; spf=fail smtp.mailfrom=verified.se.com; dkim=pass (2048-bit key) header.d=verified.se.com header.i=@verified.se.com header.b=uPHcS8vq; arc=fail smtp.client-ip=40.107.7.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verified.se.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=verified.se.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA1vPmZL22CooR7iLfwuNK+B4OhYgv4EkNrZK6gg01fZSMcFSdg+VF1NUEKzjFH1jI5lRa8y8T91vdK1FtP9e+yMk5O0+oVHP2YkVxg/0vBKLc2Zksnll0tx7beWZd7FwtmqeWllFAsFuhxAChkcMOraUqcK71K0SmQu2wgKU7cKj8CwAKolZykTtTT/SnOpLtyUn3imLXeuRpUovzbaHNZYeqR19Plkj+ZSWU12UXzBfMZDgZ71DI+ULDcLpFXg7oWDGu0XmSt6fyhDQdmVoSUn0Rn2M1IF3+rLEZkhXufK16tj68Y+irkyjrmrV5kiVhFsey8PrCBitn0nu2leqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4Ow8PAPp+wISMrhuxQrct+QbHboR2RfFW288wi8nRs=;
 b=oXKYX2v6V092iv0ijsuH1nOd+GMlap/N5imvsY+DTQNUSlRKtdkQ0wglpS5wMbg4dLIh11rY0fQQshwjSN1KDDRWCYuHxK6Qlw85fmfBnCRQIRM5PNkYnpV4eJcbJ8KmNK6malavgkCCicVj1CtPHaKdpd0zu6tOweI7ot0+gacqbTcsx1DqcAubE59v+JmRVXOEDiJaH9U1ftAIH5s4kM5+09KD6z5zYGEgND/mDBNnlKsDuc6ovM9lSNi/thY/aMrveFo+ATLx8FiKDfUMz6cGXJWscGG2Esxck8zemHziQHXxvK/ghx0Tf6gnbI+xkPNnA59/XAtZG3mjypF8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 159.215.248.142) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=verified.se.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=verified.se.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verified.se.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4Ow8PAPp+wISMrhuxQrct+QbHboR2RfFW288wi8nRs=;
 b=uPHcS8vqvCQRaPsIjbUtC7KHsSQhCzpa+tVAWpDmx7okg1apWtsgZBykjnMIxyNmOcgB6D6/wUObTOljzH7+dmP9+WNy5jI3uNb9aZmuWKgkAlmowSSPhZAiYnULiu5ET71SOA6L5Kuh/tiy21uSHaLIPsHoeATb+rNTyA8EzjTXrvswloAY7eb/aqSsqB0J8Bt+hmmNKM21+qfX6Tznsl579nJVl/NZFNO9GI81chbELnEEJAA9Go7sttlw75Zl+hi9rMPMaf9udmKI+ZdF8l1rOKUsnCjcn8yrPxhkDY8hENZT8sZB4KTjvN1Gp9e//vXS1etsex7CqaSibls9QQ==
Received: from AS9PR05CA0162.eurprd05.prod.outlook.com (2603:10a6:20b:496::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Sun, 24 Mar
 2024 00:42:12 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:496:cafe::ad) by AS9PR05CA0162.outlook.office365.com
 (2603:10a6:20b:496::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Sun, 24 Mar 2024 00:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 159.215.248.142)
 smtp.mailfrom=verified.se.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=verified.se.com;
Received-SPF: Pass (protection.outlook.com: domain of verified.se.com
 designates 159.215.248.142 as permitted sender)
 receiver=protection.outlook.com; client-ip=159.215.248.142;
 helo=smtpdmz-eur1.se.com; pr=C
Received: from smtpdmz-eur1.se.com (159.215.248.142) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Sun, 24 Mar 2024 00:42:11 +0000
X-CSE-ConnectionGUID: s+0/cXHkQiSPtZwfdU+x9Q==
X-CSE-MsgGUID: 3RumJbGsSB6v/+u4pUQKmg==
X-IPAS-Result: =?us-ascii?q?A0CiAQAqdf9l//7ZywpaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF+AwEBAQsBgzKBYYsqqxoPAQEBAQEBAQEBCUQEAQGFBogHJzcGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQYBAQEEAQEBAgEHBAGBHYV5hlw2AUYRH4ENE4MAg?=
 =?us-ascii?q?mC1URoCZYRhrmeBVIFIAYx5gy+EfoFKgzOLBgSCE4M3n3EHBzwnfgOBBWsbE?=
 =?us-ascii?q?B43ERATDQMIbh0CESI6AwUDBDIKEgwLHwVUA0AGSAsDAhoFAwMEgS4FCxoCE?=
 =?us-ascii?q?CwmAwMSSQIQFAM4AwMGAwoxLk9BDFADZx8ZGAk8DwwaAhsUDSQjAiw+AwkKE?=
 =?us-ascii?q?AIWAx0WBDARCQsmAyoGNgISDAYGBlwgFgkEJQMIBANQAyBwEQMEGgQLB3aDP?=
 =?us-ascii?q?AEDARIBRxCBMQGKGoM/KQGBdoQ9PAMJAwcFGy43CQMLGA1IESw1CAwbKB8HQ?=
 =?us-ascii?q?x0IBwOmNIEOgikvHJMLslgHpT9NlzYqA5JLAZhipCCEY4F6gX9wghyBG1IZD?=
 =?us-ascii?q?6IUdzsCBwsBAQMJimgBAQ?=
IronPort-Data: A9a23:uUaQfa/lQR2JEDgCS30CDrUDOnyTJUtcMsCJ2f8bNWPcYEJGY0x3m
 2QXDWCAb6qOM2H1fYxwadm/8U8PupKDm9RlGQo9rHsxFiIbosfsO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG86yE6jefRHuaU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uqyyHkEAHjg2Ec3l48sfrZ9Es05q+q41v0g3RnDRx1lA6G/5UqJM9HTU2BByOQapVZGOe8W
 9HCwNmRlo8O105wYj8Nuu+TnnwiGtY+DyDX4pZlc/HKbix5m8AH+v1T2Mzwy6tgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEFL0OevHJSxjSCc51aFKzzn89VtNUANBZEq5eh7PCJep
 MVNfVjhbjjb7w636Km+VvEpi9k5dY/wMcUUvXQIITPxVK5gG8iYBf+TupkCgWtYasNmRZ4yY
 +IBYCFkZRCGbhdCIFceEp4Wguqyh3f+fjEes1/Trq0yi4TW5FUsgOi3bIuPKrRmQ+0OpFudh
 Gjp5F/TXA9dd8HD0Qe80Xej07qncSTTHdh6+KeD3vprhkCDg28eEhsbUXOlrvSjzE2zQdRSL
 woT4CVGkEQp3FeuUsG4UgCi+TiBuQZaQNcWGOo/gO2Q9pfpD8+iLjBsZlZ8hBYO7qfamRRCO
 oe1ou7U
IronPort-HdrOrdr: A9a23:P+4XU6gzTFQASy7hJa64tyZZI3BQXjQji2hC6mlwRA09TyVXrb
 HLoB19726ItN9/YgBHpTntAtjjfZrQz/NICOoqTM2ftXfdyRKVxehZhOOSoAEIfReOjdK1+p
 0AE5SWY+eAamSS4/yKhTWQIpIL+vXC2qauguvV0ndqSi9XS4wI1WxEIzfeOHdbAC1dC7QENL
 f03KB6TkKbCAwqR/X+PFVAcNPkg7Tw+67OUFo9K1oCwCmqogiPzNfBfSSw71Mldw536Yse0A
 H+/zDE2g==
X-Talos-CUID: =?us-ascii?q?9a23=3ALCYwhWh+pl5/GQhCACEKTkjTfjJuaT6Fi3zgA0y?=
 =?us-ascii?q?BCF1RVI+KR1Otu7M1qp87?=
X-Talos-MUID: 9a23:xePVswklxTvfC1WgOl7ldno5Dtptwa6BE3snz4tB+NTYLRFJGDKS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,150,1708405200"; 
   d="scan'208";a="158824928"
Received: from smtp-eur1.mop.se.com (HELO smtp-eur1.se.com) ([10.203.217.254])
  by smtpdmz-eur1.se.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 20:48:34 -0400
X-CSE-ConnectionGUID: BhL8pu9xQaKsA0OFODwtrg==
X-CSE-MsgGUID: tCL1LWM1Q+W3rSK6bjHjXQ==
IronPort-SDR: 65ff76e3_QQ01sQDdHPJahW7rJmcs5k5HJziBLioB7wg0mwa/uJuj1Qt
 nRIlST6ja0Y++QGNS8xOMivDZTLQMuZTfJPo8yQ==
Received: from unknown (HELO ironfarm-zone4-worker.eur.gad.schneider-electric.com) ([10.203.247.95])
  by smtp-eur1.se.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 20:42:11 -0400
From: pascal.eberhard@verified.se.com
To: Richard Weinberger <richard@nod.at>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>
Subject: [PATCH] ubifs: xattr: remove unused anonymous enum
Date: Sun, 24 Mar 2024 01:41:34 +0100
Message-Id: <20240324004134.161755-1-pascal.eberhard@verified.se.com>
X-Mailer: git-send-email 2.40.1
Reply-To: pascal.eberhard@se.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|PA4PR04MB9461:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 484a55ab-f068-4229-8bb6-08dc4b9b3e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	82wZlM5RDf3yiVGiBC0Ug7eLgrwguLrpMGQuyRRqvkoABCu4+GP9ayGIb1Nl1hB+C+My9OXyeV5kHNTyTSwRYzkPW/ANt1jHst/wF/WngWXkmrgyLPTaTYFDpFJdmIGbF7B2vUygKQxyYxcC/qFP6y2UIdCR/SY5o4dayf0tX7Fc3s+palAWxVoeqR9bTl3crudAW+rsl7TV1JJo8Y5c8vOdFS5wMABk3pmatye2qWB7d3dHeEMXvHf5oO+65FFY53Q57869/qB39ZwqiGvS5TT4UbI0dMV3HQCU94qeTzwjqOTXK+8hEkZwltPano8cTrEleaOJhplOABFmZfKo8jOiTpIs0WJBPkROFCw/kr9gusNj9u9ZWLTD4vLKrJasFfXJwXAc3kGzOKvDOTNXGA1qS1d6hqgNQTdxkAUB8B3PsnNmX7ROKe+dnHzNhokNEEFo0qUfVGG+a7yEFK4AH3467RLgzgWOPbv0ty/71LcDUZEH6Mu2of+RMaoIoniwUdrUwxG7rMaCcUYo8kX09I+fTFFZLm+DiM/qlegpSUBc2FbvPbCMwI+a/FpfDxSDw1juDBpdbmIiwvBjv9j5SljOr2hpjdZiPfVAbw07u4d3pGGs7o4fcarhjtwCJvGZ+Cz/ZmWVCGoXKc/oNLn/8k3aVgOmWUq9koBTKK9enXdK0jK/sKO6j3Mo21XS1HnKs4QcRvW5g7xwlMd37vySHP57ox7iDjXyfAAP+qBNK/J9kcxzQTVRnhnqtzvGgLaf
X-Forefront-Antispam-Report:
	CIP:159.215.248.142;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpdmz-eur1.se.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(61400799018);DIR:OUT;SFP:1101;
X-OriginatorOrg: verified.se.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 00:42:11.7802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484a55ab-f068-4229-8bb6-08dc4b9b3e62
X-MS-Exchange-CrossTenant-Id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6e51e1ad-c54b-4b39-b598-0ffe9ae68fef;Ip=[159.215.248.142];Helo=[smtpdmz-eur1.se.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461

From: Pascal Eberhard <pascal.eberhard@se.com>

commit 2b88fc21cae9 ("ubifs: Switch to generic xattr handlers") removes
usage of this anonymous enum. Delete the enum as well.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 fs/ubifs/xattr.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 0847db521984..f0969519ad05 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -48,19 +48,6 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 
-/*
- * Extended attribute type constants.
- *
- * USER_XATTR: user extended attribute ("user.*")
- * TRUSTED_XATTR: trusted extended attribute ("trusted.*)
- * SECURITY_XATTR: security extended attribute ("security.*")
- */
-enum {
-	USER_XATTR,
-	TRUSTED_XATTR,
-	SECURITY_XATTR,
-};
-
 static const struct inode_operations empty_iops;
 static const struct file_operations empty_fops;
 
-- 
2.40.1


