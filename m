Return-Path: <linux-kernel+bounces-134111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0163C89ADBA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1671F216E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97CEAE7;
	Sun,  7 Apr 2024 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="lYcEeDN5"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2133.outbound.protection.outlook.com [40.107.7.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90308F4A;
	Sun,  7 Apr 2024 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712449656; cv=fail; b=piEaxkN2zKTYApPNQ5kOLS+vUIt3bN3J78jCLrJtIB3yArAjCxaHMsR7j8VTNiT1eKt/Z2GsZFXVEaMl5liU7D2oqOCP58IPBPz8OlVl3mJ43SSI5aGitoFtc79+tPNX5j3fdCzpqUUtgUbbEQRP/BdWE5yPMBIl8aIsANVMkpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712449656; c=relaxed/simple;
	bh=mku60eiZrlwILUYPIhJ1rv/hgxY6mxV8UellxrzSluM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhNknTZ1LCcY5L4Z4cMIfCgrvq6A9JKD9fIoZjzvrAXpbrCTfyzVbTaqIAKMCF+GZ6peDbi5w9Wc1nV6EMyoJ9Vyv7EOB6xeT+1djxRU8qQMSOyqJp0S1AXq4nCjxKF+uALCwia1FSDqi2nLkiHuWwzlD0wB0KwK7qPM8TJE/Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=lYcEeDN5; arc=fail smtp.client-ip=40.107.7.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRMTNb8n2PkYkuk8kCVXlpoYOvwfwNud8HtWRqcA0VJrECUYyX9omT6dalRvjITFS4jZ7PCfsOCiMOgD48yy50+gAeYmenFtw1rMBME+WLVMFNbpD0PiaFXMQf65YIjUihXXPNJkVFJyIJcFXMvWRSocTbaCUNA8sE3EPS1wJU78cemnJIgmYRQID0/GSoBj8UUdeg0AA6xggyQSdzHsexd9Lw5KdhgkZgYnWGJDK10aQr10gijmuAbs9GRrSUF9jDkNLjkl0Cko3x10FBZpSGaUKu45IvP/zxkQ3vJbWwN+H57ZnHYoxdmIfoRiosbh7eegn9oCWBgsAEucVuhQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mku60eiZrlwILUYPIhJ1rv/hgxY6mxV8UellxrzSluM=;
 b=MiFyKrF7UDaB3qc10OYZVRZM22nRJUID1q0m8DcydYu95oQ1fUOfyLaW6ujlQc+YNvQ47B/ahGUIPmZcf/3KI6GnoE12PTeIead7f+UDWSflWbOTY4KLb6H8o+qUoLDVaHEbEhxMoW3xwrO3HCePyJEJRNPqatTxKWeEcBXGynKQIU6zkykMjqmQ+wajnuvWxwr1SYbXsaAfPy5EYIR8cI1ZYmbxXs4gb+cw/4axGEXGB7588ew81bJgJiPKsjyYTUEf31LRaBfK1r9xEft1v7Z2NVEH9Hnneyf/ehzFWXUPv3sPq1PVwIUPazz1Ns/TmMaQT5Raj5avAdCk7QzxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mku60eiZrlwILUYPIhJ1rv/hgxY6mxV8UellxrzSluM=;
 b=lYcEeDN5EnAT5GRrcAY5nCxGICGwG3sb3IvZSseFwuXUPgPUonWosdqp8t0fM9UYWv4+jb7RhjqLnLeHOD0WQ+Wd2l0V7IpDrUNF74iFZ705xZDLx4O7F5NeZVLvEKzeLMllVTSLJaMwseJcoK/AufKp+rnnUWZlTO4RbkCYuoQ=
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1339.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 00:27:24 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8%4]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 00:27:24 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 4/4] serial: ar933x: Remove unneeded static structure
Date: Sun,  7 Apr 2024 02:27:09 +0200
Message-ID: <20240407002709.16224-5-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
References: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1339:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WmteaX2mFqNP2xyP0Nu+KRg8JLZ5jmqe/fGLLwCHJ4b3QvTyG8XpqD9KAD/3H/0rYpJ6nHk3ZLrqS6R/7idieIYy1w28AGZVGp1Y8SWZX4sdtkqe18D6ztM593UUhd/l9A/L9I+jhd6bDNi4SdaOfKzyNRQVTLBT8g8RgYlm4U+mhVC/fPi3fRv7qHV/+gZgOekn5z6rR6BFoA5Cxsy+nUoKlGcAuXvRiDrLqCvQRsN2Ggn4DHCMYqrzU/XlIgiBw1qvkUECHY7eWnWuNptZD5Jl3fsFWb2e1uwpMawELqtqlGhUUmTQA6vXF8uqjIOCLT799rOw0jWbLNcwPg245zwciOfgrjtdKOugJzAVCoBa4+tJyUl0IApAdP4Qp9HMR149fVJboqbl+yjdPGuiBm7E3fXgCNoNhiCs7ZZBuI4lDYqlRciN8bR8N4BCW4RMGaqHXfmAFknH0Fgtsi+W3oVnOj/RI7pZJHlbjq48VrgSLgXIoPvP94YR824bGEoHGpU4NmfLyMgaIzx7pop7rfnJazsUyZd7omIsb5PMJvdzKeV3dVQGgDjUuOSwSPefaabgpC+ch3vVoubKzVLTrbLBbOV7f4BKmc5gmWdVMvZw1ABK/f/RPU8XS2YQDBC6+QVjVdxpHUzZmDyj+p0NHD3ukY6eaDPgqfE9Wqw5scA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqEu48MgsWLKrpRrKEagMYqsxRTT2Qi9PA+678Bgrk2gdj/Hx6bGBWMeDYEp?=
 =?us-ascii?Q?j5Z5ig4xoj7xk2+u2ylzsnXcGaTyySiLhPPNnOu+7DDoeeu+35QOfDM7J6lV?=
 =?us-ascii?Q?+9VqGm/Y1sEPa6yXVc9k+sRhTfdOSZyvBWx3asZUUtSkn9jpjmg3ODRKRiRc?=
 =?us-ascii?Q?dL3esx7tA2oMqV205zj789eJdYwRX/uVq4ylrt3ByDt0zkQhgA90ab1KSRj1?=
 =?us-ascii?Q?IWFUwIHBhFE6JnBIbVn5c5co9VZr6pKB7aeGMeLB1rXFhFi2+J0+WdFCUce0?=
 =?us-ascii?Q?cJtSHIOgp3oaebf7gChg/8PlJPeQ19KJGspztFEdyj+T7/wJdANYxwgTY/X7?=
 =?us-ascii?Q?Au3jZEwa3uj0RLhkNVK/lntDsrrfRaUmUYq9XnboJRmYExZEKVDXIojDdepM?=
 =?us-ascii?Q?IMLEHriR0iYAtOryLeCBB+X+kfssuK2l+8grPNPykG7mFcLryxCgQENVpTvP?=
 =?us-ascii?Q?7fPGVpA2sbQVSm9vTx2R4/RWZWc4n0R3KMf9v2UoBMq5uWdtJslZ5V38q8UV?=
 =?us-ascii?Q?9bjbCEp9hBMLynS72iwqFg01NJweCy/wM1+CQJ3CjX2IkDulFITTgcpRxk+T?=
 =?us-ascii?Q?xVdWXBkPl/7phc7Oh/OcgQFJQ5Zj7S3WP4+oPUg1I+Aw/Bk7M+kbC4ifjJ3L?=
 =?us-ascii?Q?5N0d3YeXYq8CCJOIle9bkZB7szTR6caZWDJ2pTHy8lCyAP7ajEeY2ssaRnGQ?=
 =?us-ascii?Q?oiXQpz1+oYqvypoiWlfpB5JTksVnaBU4xHnv7NWHuD60GRTvkhib4mkkDuZB?=
 =?us-ascii?Q?iJs7gPRIHUvKYC+xCnhSPWcD+o3sdKZv9/C4Xwm/zkJO6jzXbQUX/7KKdBwL?=
 =?us-ascii?Q?sLnjvgJu0k7alBmfrio71L6NoIgmt/+kZFiLiswGOzI7hv3ZqHpbmApn89Zp?=
 =?us-ascii?Q?19mNM+GCBtnO0UFjzobKe3h7KAlCI7WBMrPr4abLl9LxrNnmUX96Nf1TATfK?=
 =?us-ascii?Q?i3AMXbCanpd8aA+EVBv2VYY2iWJeBBxzNmmedIjaH5z76mAE2VG34fWMTGmy?=
 =?us-ascii?Q?UqiX4kgTbNOT1MycKF5YaXQmH2WJCkipscSUc+rHKqe1a05kjRojCBNFaOnM?=
 =?us-ascii?Q?vN626X7THcgFDVUmrmIu0seE+bSCgthbLGRxkVyMA5KtS+KfCY/J0QJvnhf4?=
 =?us-ascii?Q?OXt1egQcS/oQczUoE/Rzj5OVFG1TJZxTJR4Sd2B5x5vHUoVX0RWT3jaLkQOA?=
 =?us-ascii?Q?AIoCn82uQ/7m27aroRP7CjSbTwViAHUmDaydXvR+NIPPmOl9eW17pB0srvGS?=
 =?us-ascii?Q?0sezKSj5FyNAyvXAMbe/GuPbHstfAlPFDlbiNgDjQ04neVPKwdIcEZpjhRse?=
 =?us-ascii?Q?6dP59/dbIKv9eZYwJi71Yzc+nk7GfSX9PXC/S/J57iyxmAK872kdcBLFYTQn?=
 =?us-ascii?Q?7ZXYLjPU874i5807y6Mfmd+WhRQEVi8r2gIwRZS8qaZslYx4tMBa4DdzG0Y6?=
 =?us-ascii?Q?zdIFgfEi0sKTPCgBVYFYD4OOq1rF+NiAZGtSvQbceWPNmnCWF4cVgXhF+cW2?=
 =?us-ascii?Q?az0T84dM5hUR5m+MgOAFEXNrK5Cbu8ciLQpAF0lEKFoiaYfGFQJDFAG7GlTp?=
 =?us-ascii?Q?Ikb0mgM7x4O0JpznNdyyJ+TbcBbztaPJMtCsSGrDEu/wfv/SGCTS9KC0Z0XT?=
 =?us-ascii?Q?b5+K5Fa5N+UwZ3DN4zXHz/tdjI/vntL3wJ2xLPx9ED/b?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dff2e3-7bb6-49b5-22bc-08dc56997ed4
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 00:27:23.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz9noLmjXEAJ4Vamt9ERBseMcntCl/KZUUengqyovaoD+i3sgazoZ6gj8Pw91M6KwfEKXX2+DRzeYCKK/C2imw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1339

SW4gY2FzZSB0aGF0IG5vIFJUUyBHUElPIGlzIGF2YWlsYWJsZSBkbyBub3QgdXNlIGEgZGVkaWNh
dGVkIG51bGxpZmllZApzZXJpYWxfcnM0ODUgc3RydWN0IHRvIGRpc2FibGUgUlM0ODUgc3VwcG9y
dCwgYnV0IHNpbXBseSBkZWxldGUgdGhlClNFUl9SUzQ4NV9FTkFCTEVEIGZsYWcgaW4gdGhlIHBv
cnRzIHJzNDg1X3N1cHBvcnRlZCBzdHJ1Y3QuClRoaXMgbWFrZSB0aGUgc3RydWN0dXJlIHN1cGVy
Zmx1b3VzIGFuZCBpdCBjYW4gYmUgcmVtb3ZlZC4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmls
aXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL2Fy
OTMzeF91YXJ0LmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hcjkzM3hfdWFydC5j
IGIvZHJpdmVycy90dHkvc2VyaWFsL2FyOTMzeF91YXJ0LmMKaW5kZXggOGQwOWFjZTA2MmU1Li5i
ZTllYTk4OGQxMzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hcjkzM3hfdWFydC5j
CisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hcjkzM3hfdWFydC5jCkBAIC02OTksNyArNjk5LDYg
QEAgc3RhdGljIHN0cnVjdCB1YXJ0X2RyaXZlciBhcjkzM3hfdWFydF9kcml2ZXIgPSB7CiAJLmNv
bnMJCT0gTlVMTCwgLyogZmlsbGVkIGluIHJ1bnRpbWUgKi8KIH07CiAKLXN0YXRpYyBjb25zdCBz
dHJ1Y3Qgc2VyaWFsX3JzNDg1IGFyOTMzeF9ub19yczQ4NSA9IHt9Owogc3RhdGljIGNvbnN0IHN0
cnVjdCBzZXJpYWxfcnM0ODUgYXI5MzN4X3JzNDg1X3N1cHBvcnRlZCA9IHsKIAkuZmxhZ3MgPSBT
RVJfUlM0ODVfRU5BQkxFRCB8IFNFUl9SUzQ4NV9SVFNfT05fU0VORCB8IFNFUl9SUzQ4NV9SVFNf
QUZURVJfU0VORCwKIH07CkBAIC03OTUsNyArNzk0LDcgQEAgc3RhdGljIGludCBhcjkzM3hfdWFy
dF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCXVwLT5ydHNfZ3Bpb2QgPSBt
Y3RybF9ncGlvX3RvX2dwaW9kKHVwLT5ncGlvcywgVUFSVF9HUElPX1JUUyk7CiAKIAlpZiAoIXVw
LT5ydHNfZ3Bpb2QpIHsKLQkJcG9ydC0+cnM0ODVfc3VwcG9ydGVkID0gYXI5MzN4X25vX3JzNDg1
OworCQlwb3J0LT5yczQ4NV9zdXBwb3J0ZWQuZmxhZ3MgJj0gflNFUl9SUzQ4NV9FTkFCTEVEOwog
CQlpZiAocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgewogCQkJZGV2X2Vy
cigmcGRldi0+ZGV2LCAibGFja2luZyBydHMtZ3BpbywgZGlzYWJsaW5nIFJTNDg1XG4iKTsKIAkJ
CXBvcnQtPnJzNDg1LmZsYWdzICY9IH5TRVJfUlM0ODVfRU5BQkxFRDsKLS0gCjIuNDMuMgoK

