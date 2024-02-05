Return-Path: <linux-kernel+bounces-52004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385E58492A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98385B227F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B88F40;
	Mon,  5 Feb 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n3SBa6YX"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310EB642;
	Mon,  5 Feb 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102197; cv=fail; b=oPTe7kL79PfFg56mX2/4vXQxoPgaLE7jL+fmDZ7tuP2fKGJx0/QjlEQ71ACLwV8RupfHjX+slPGH7C19THsOHgmBHG3go9Upz7f4d2jbywaQU6MYitPNGEdHblw7OlC9a8WZvBPaKBAay3DYdexTQavEP9IPmIdJC4XXCQBDvjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102197; c=relaxed/simple;
	bh=04+N2J7h0QpEUNx5ql8+58ZUQ3gZrSO9KiMgvEwekak=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NCc9dpuEhQkxOgBauPPTzV1vFWogmJd2AXeQE5qa3n2Z7nq6JgnP6e9bedMWkjRNhaWYN2psIuZ3KIYaPbUte+SOYJFbHg7N3SeHiuMlWFYMbaGVT9YQywyLZ399wC5qPy+srz1DOyLnsTueVwwp8qGgafpVBzz+OryS0ghRgNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=n3SBa6YX; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKvo7k5aGRTLsxKwKT5QeLeShIqsbhAxl3wV4sa2UENQOuvhfBGCkHZBsh0hNlndUs7pJhVMQZ7ZMMtNRhVo4c5CGxAPm9ik9UJhmj9PeDRYcfNmYo/DzZvLGvM1ZwTkcxv8jhPbYb5YpsbWgJ00RB75xHdVldTYGyoOiAGGmub2Yscq7/uisfGz2PoMtlt4YpbrJfjEprr6dbbMWwwO3/mytZdm3NA8c0fZr0kvkngGSQPFCX66ZKMLeQbvAa1K17w7gmRkOIIf4R8qNZdHp+jitCbLp72b9RDcme+jDTS1UNIR3M4NsYwQiiuyGQd05yQjuKL2qcyCFOVsbftZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pms2M3dtDRmLboEFI2NobDfl+l2d9SdMHXt6gMaUlyA=;
 b=XVfwIteaFjxjXAh8e03NNONP739JXCKM3GTXoN4AUNInLhYh9gooNPhSnEAwrHoKdv9aUtHE6bdXIFSeUxmUI7vo1c05gcAQE5jaTiB7NHXqOl/JIp++mGxk53u2yEcN+xRMNObYGdKCDZ9iHp9oadF5TGNVR2OmbLoufOE+9xKtWNv/5XoqXd6VFOt5LhMWlzabbkzLF+48hMWDaPApfHbDIJR5GycdYZTfqoWlbv52nfo06AUiDXEDaJtljYB6vipIyC10Q2xFCPKq6rLCvijfiznxu1bIV35GIXz3xW9KlWFfVM72F9vidr6pZpItS+NHkyTGHY0fzVr2nmfchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pms2M3dtDRmLboEFI2NobDfl+l2d9SdMHXt6gMaUlyA=;
 b=n3SBa6YXYHoh2eEqe1h1s5t2niGott69oqLzfBU2kqd3rsuxC88E/1vGWH/vNS1KIoEZc3SF3EwES0gY7RomSSSNa8ZLiUg8zsOB/RprG1UqDJbky4w9g+uW4E8yseYZy+4/88R2IyIigRhJtI3KoSCc9iZs12PakPtiNj8lwc0/8X/Iva4eRgICdDQa0TfQKyzrLoTgk+N7Ggx54jtENwy+2F/Ra0I1ZhO7ky/mMyAU+mdVKbZ/sPk01MtdD4oXuns1P8HDrEb1GVew7ME0If1X+QZ3xG8SHT95ObJbSHqXsRk0kQ+omsdl0RxapQMwWFHCKuC16asNgAJUf1dhJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TYZPR06MB4159.apcprd06.prod.outlook.com (2603:1096:400:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 03:03:11 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::256c:56b4:d404:efd4]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::256c:56b4:d404:efd4%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 03:03:10 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "f2fs: stop allocating pinned sections if EAGAIN happens"
Date: Sun,  4 Feb 2024 20:14:15 -0700
Message-Id: <20240205031415.557879-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TYZPR06MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa687d8-885e-43e6-2ce6-08dc25f6fc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pg51Kh0AcHytjpTVsomvDtUiEpYdtlEVc6YYEE8fauKb4uKwvrbSohA1hIc3qOTZg2TlvIlylbJwg2Onu/EQb47bTBrmEz7pJLLVu6ZDzTrM4Y5FW9L2qE3LLMXOdlX6PN3sQqVmEgJs203EZVNv7YbsLaL5WiTI8rpVJKfFsi7ZO3FpDWASmCxhnca0cvZd1vRNRP8Hx0oZFI/Rg3m+qIAD9+7+fDpUEqtPdfLN5uuNp/oxGczVioQ9mO/+HW7wkHT2bZyGwFhKvi3l13TbBcfkEvCjpaP+GB5b049AsByiobUi41DYeH1wBKEzRWW1/eFlV5JJJ8MQhvuZareYdQCqKa5VMKXtA6Xc5ht+VR9F4QpAO/L5FV301kh8P+VyHcBcHBF+eLQWOzDYYrCMmowgp/NRDShtFc7eHunimkXYGkwIF5sCxzcpuYJYoArGqkxPz/jR/JfQbEDP6OMj+wiQT7mzfZfffigr/wQ1qpJWNgMVtl2JSB3Ml6nJSMYE1JQKs2m5N9H8WY3sCHpelCtY2inaeKL5KQoLnMTbJlDbbZR4Qp+rAR5LdN/ACi2rNtrZn8o62FLZmMXd367WLEBmi6ZKuZ8Y4P47QmvHYEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(38350700005)(110136005)(54906003)(66556008)(66476007)(66946007)(36756003)(316002)(2906002)(5660300002)(4326008)(8676002)(8936002)(83380400001)(38100700002)(6506007)(6512007)(52116002)(478600001)(6486002)(966005)(2616005)(26005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Qrd2WrLOGLBvPqKZ7oml2+fSDCK3zuvQzgUaj7pRcHeUOAOCyFuCJq+rkAo?=
 =?us-ascii?Q?t6uaOujlNegjw2FDcoCHlnnLyVLcec7ErbzzO0RDOVB9EZ7lGYqiAbtvQryC?=
 =?us-ascii?Q?Wz88JJ+eLe94XJx8kLbIKld0yxar141ksZ2Sg4jlt6grC/2MTafdRJR5zDAL?=
 =?us-ascii?Q?7I6fWHfY1qwypYZcQTUUM6XQuyGtKtmvJurdK0xkpG9aohHyhhNyu7ARWCA7?=
 =?us-ascii?Q?DWpgJ2HVDxwsE4a8Q56ombeF4pZiTPR5TZz3TL2poGI1KXmkkKJAKq2d9rKj?=
 =?us-ascii?Q?VWJUhCPB1DXdkVUo2eNP4Wkq4BMk7bjS46x3RFtr4WmcEvn+tm3NEDF7F9zL?=
 =?us-ascii?Q?blvsOoTgwphfvmDKzOCNxijF87yNlKytEzkwgdb6OSInOVDNIemsB4OWJJWy?=
 =?us-ascii?Q?C/hzr28qxnXRNvN7RhA5J8pRI1PMQl+hB/yinbp8Pqbw9YhDgmMHxz0CwEz0?=
 =?us-ascii?Q?U3QvNRbeiDWsfLEyKSLKAOF9H6GTx/fuA1UFLAyKIXM/b7X08fWnahqM3V7+?=
 =?us-ascii?Q?03WAAh9ZcVsBL95B1VQg4uPoXxB/L7vbKdfJevaplJkiEbeOhjIU02/bsstw?=
 =?us-ascii?Q?McR7OZBaz3Xt7LsOJvtHsmtBR2OLRMElKxfxxamgKDUmtfHhTiKFxB1HXStI?=
 =?us-ascii?Q?UBS0syW2+aDzS7NG0pfXr5zmg4FctRFIgIQwyiFt2WMFnkOODeJz5cE7jqu6?=
 =?us-ascii?Q?pc0pNHZU+OlnNo8MYnkIRrdKvGGuR4SZJI8eBaK3+mnu0BeUoIwQlRTnvK/C?=
 =?us-ascii?Q?hmLNnvkzDYTews98dxx8ldNdSVx+Vdw8nHX65LgzC6CFWJis06z/W2wYH4yx?=
 =?us-ascii?Q?WzZZPcOxji5xbizaja4Hr2uMVXlmttbMZRXqpYmDBJqmnFYT6jZ51lGclt1D?=
 =?us-ascii?Q?GETXWKMO0M1kt/gihgfWlcEFDqe6VNcTPm38zT8kQMflpY2FbT52qxkC079W?=
 =?us-ascii?Q?1c0QyI4QY4Lot4HDOTsxmtIZZQkauOYC4t3YCvkHrnQLEM3LuX8UWPMoKtus?=
 =?us-ascii?Q?3KBjfeU5S1iWwdVlv/rOAeJin7If0Y9vGfWU+naaZAA8OR4tcaTD6fiYi/Ey?=
 =?us-ascii?Q?rKUTcROPsJ5/PYYCoTGXcv/6vmvXw1eY0QXWr9uBxVrtuVIJgm4EF0lGrJeq?=
 =?us-ascii?Q?BL5dU7n0mfJJSJucsvL5zj7T1qwz9+Y4V6PMswmRe8aBHWVzo0kaliGHMluT?=
 =?us-ascii?Q?CvURLa+0fDNFLTbeK8bzJ4jsdFj52WE922Sun1aL9uAINV2TLQLnkHv7Jmc0?=
 =?us-ascii?Q?CgvoMd/nUkRkmg4wJGcfZWnR+V5j+xJQiBNkQFWzrSSl/8Tl3W1aCVBffSGQ?=
 =?us-ascii?Q?xBzqvEJcq15Nf2HKoTzEpWdim8IFAccl1MDtooeEUzXwJmvFa19Df4aBv6lF?=
 =?us-ascii?Q?Qf1sOgGptNq1IaKYHQTtNWRpzzUDamzKUcz3W9J8hTsXkfnfhd5iF74UwSVg?=
 =?us-ascii?Q?hVy5pr6U4Cfhn7DKA+HLxrwgAtBYaWtHCjg57lTV5nKuMhFbKPReQS4bcKP0?=
 =?us-ascii?Q?chFSbQY9JG4HV2dBgfKhmuPQYroYrV3kkocjv+UWbOkLGbexoSwEsIFIY/KK?=
 =?us-ascii?Q?b8N6jzvRbupomvnrNKjgOmR5lAs39AejLW3d7nB1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa687d8-885e-43e6-2ce6-08dc25f6fc32
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 03:03:10.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHtb/8Qcbz822mZjZybMOZmHeA9khcG8wSJU/H/Kl2+aMfyzh/vot/NatHYSs2xx/1f4aKWNfE9CtcYo7tcH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4159

This reverts commit 2e42b7f817acd6e8d78226445eb6fe44fe79c12a.

If the GC victim section has a pinned block when fallocate() trigger
FG_GC, the section is not able to be recycled. And this will return
-EAGAIN cause fallocate() failed, even though there are much spare space
as user see. As the GC policy prone to chose the same victim,
fallocate() may not successed at a long period.

This scenario has been found during Android OTA.

Link: https://lore.kernel.org/linux-f2fs-devel/20231030094024.263707-1-bo.wu@vivo.com/t/#u

CC: stable@vger.kernel.org
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b58ab1157b7e..19915faccee9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1725,7 +1725,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 			f2fs_down_write(&sbi->gc_lock);
 			stat_inc_gc_call_count(sbi, FOREGROUND);
 			err = f2fs_gc(sbi, &gc_control);
-			if (err && err != -ENODATA)
+			if (err && err != -ENODATA && err != -EAGAIN)
 				goto out_err;
 		}
 
-- 
2.25.1


