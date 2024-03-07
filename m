Return-Path: <linux-kernel+bounces-96352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17537875AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FE8B21C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A853D988;
	Thu,  7 Mar 2024 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gFd9Jw4k"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC072E648
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853003; cv=fail; b=f3OIcXjjAldUIRsbRgCK8vfeFvuimtXQ28gRLfRU+dnLTq22yVI2/PS8iD1IMW0z5lqNlIEY1B7xed6+XXr6AKv+RSOLlI1HuuCvDUU+Cq8CMEuCb3nPqoxFh8t37127kcQMt7VnR3i7bGiHA2cxp6WT+23YW5A0L9d0TMLan3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853003; c=relaxed/simple;
	bh=ieYXY+TGhzEzsQX+1bjY+ZLJP1XISB+f+CTgmdPuaNI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nlwXeN5n1A5b/V1gSWm6XlfGoSdrL5tsP94Ws0zfR6lN2YPAPcPADzMY72oNO4AAj7jCUIfy1XIYub5m5B/L24yiPiSEgOhDVS0Epho6ttILU4EPcPdRRiGNha7sdjphMx9vmKShiIypBrZ7WU7cYy72mfIoQYNuSb3PkWRkUEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gFd9Jw4k; arc=fail smtp.client-ip=40.107.237.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbiBmQV0s3LCUI7/+KvCzD9ZYcrSPeokfPqyM19r2mSXbpvHSczxMzeBeUEomQ3t/Z3x4EEQjmGXdW9mwn/OzB9ZLVCjOUsUMy3XQo3aYruD7Jkok1m2hFHIGwnRJCNmjeKn+scu4nQ4TVhJs9fHf9oJevGjXzj3bM7uOnfA0nMqN8GwcO8ytj9Bb/GdqnGXMZ1WU8jlszwF3+ERFROS9otC+SthD39Erp22l6Azw5owgWCr2zXOkmk9c9OwZKNMD+Mimm4dG9IT4cL4tZyTAgtVz+1CvtpRO8Ffdzc25QjhwsUEr9nkMPAUeOe1gUIaNnkcBYZ6CAZv2LoqF8FzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbz+HiIlURZHqfMEpg8muGUqfqsT4WiG+NUmQxmv570=;
 b=knF4+/T6Au13UXgVgHdx4CIgTjrjypcTRRrG+xO/AYIdJ7wBPyz7AwtdkN1v0iH3q3RYfi/5ntaUZ44S7uq7NTpMaGRAqocMEyP7vtmAwrklBTCTxTUpP3kqJw+wmLd7SEx56N7dvpbq2SEYCUVTYcaiApCCYoQHNP0OStSjydCVGUUouU16gyPU95a6dp+SqO8r3/zkP+Z8Kyv6bvDHSvHw2oSCq+7Hr9orK1rZ+0cmX7HmPUqOoL4Sf/h9TVh0LV4A6w9ZJ0wlnoZuaHR/utsvUUHIpnMzp5GOQcbyZzQcP7yVHgqataesg4wa7eM5WzXR8pnVlXI8OS5U2RqKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbz+HiIlURZHqfMEpg8muGUqfqsT4WiG+NUmQxmv570=;
 b=gFd9Jw4kROggXITPEn/PoHzKLprwou5NN2SonPjSmhGlsrgsZ1WJtouziXnFiHL7K1gXK2Q8h9GuwJ3SJaddadRBNgzCE7Pw4qFxoq18VITP4F6JEBClYhyrJImWfgXATCr6XTPcrOAnfFU5oDiqgZI++cVEngp0x0EiAi5m/Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 BL3PR01MB7116.prod.exchangelabs.com (2603:10b6:208:33b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Thu, 7 Mar 2024 23:09:57 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 23:09:57 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf/arm-cmn: Add support for tertiary match group
Date: Thu,  7 Mar 2024 15:09:27 -0800
Message-ID: <20240307230929.6233-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|BL3PR01MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a05b1a9-4fd2-48ec-d367-08dc3efbb4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vb/z6uXgmxoNLmA5mJlx4kYhtreF6DVGn8xYMnspH9um+Gqqi/iNMC0Hp3zdQNwTzECRpz1kvA45Aldz/jNfbYSzMUI7h4fc30E8ojWG7Bui6JwFly/75R5R53x6d2DjdMF5BAEHfYnhZqp5cKPSzwnKfOw6LQmaBxpumU02JIeJEx7lYRQXtqktr9Cn69aCBlC0o20LKsGFBsZSVDt5cL2wYnORWwvLyFozuAcj5joVEmgBKreN2r8hlBQVMXoYSYXKkYwdQLhxHvfebxrQzaMWHb6FCxft6qsBqe2EbuNVpo8SzQGNAU7dnUL79O91WDjSvgHh4GYzJdzTejDxnk714KAlPYqhyKy0YYBeqhJtfhMiNiZ0Ihap2EQyBZZvYhfkiRGRrJ8fv/ISoY/mR2T5d2armEXChuxehAiWfyhilFt381qXAW5se/uZouTBt8OCrJRQ1f+GmkFP0xqz0EFlXIkcNfkGu47BPbG6EIlQwZ0ozqsYLr7SYoxkQxNIzsJrywlxUAac/RBe7rt1BD0w8yJv/BdEV5dWv5eCoHV3gDld6SW1HC+YeLXdoWi5su5cSOfHHV2JrwKaIrG3yqgyoNSEy2lV+1wg7hr0BldJ+hDLek5x2I4cOZdTPwGZiRsdqkwo73KeH+lqoVR73+scQW2uBO7gmB1p1+GtKYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W13BYvJbbq6zmZWn0mHp0RDIoo+l4vF627ZJXolOgIfkw03z/3vQcAObx5V9?=
 =?us-ascii?Q?ATvYRv8bALqxm4f3yt1bmyTysObkgMhXOrpTFiuekfeC+KPCJaO8TwxkehjM?=
 =?us-ascii?Q?Rm1ggL2VPKKdxGWQPhuFqBJHLabuZspquBdxbZHTXkH8lLI1IP1ps6LOQBuR?=
 =?us-ascii?Q?wqpqPBU4GqA6v+g7mY3ItHrgPuI6UklsdYRvn9coM+DhHH4uxBgE8q6TooRe?=
 =?us-ascii?Q?nG3vc9QdxdVAuPxnxd5fvnCBBgI5b8KLbocIGEE2hGMg8X1AzH96Yz0C6mFJ?=
 =?us-ascii?Q?K7A3uTbDToJjaa1KP+4nnaztSCeYfuleq/pNsnZ6xRx8xI7IUHsqRjMP3zkU?=
 =?us-ascii?Q?IAHTNqXUNXZH4kiQvMTq1qQn2Ls9ocnxjzVyyb5jH3/e64yWcw0VOocLBhIc?=
 =?us-ascii?Q?XWSqcWn/CA8r+KCypIVeJHsUkwPQqMIEYnj5s1JxcJ4Win4NrAX6P31LgxGA?=
 =?us-ascii?Q?sQN+copnYC+nVhhqrpx+c6SFBNgkxmBvDkAIt+ve3hUA58mlvWupr7YZdFw3?=
 =?us-ascii?Q?omnDZ6bXxTEYJbRj7AxbRDT3mmVbxJEs9AZz253BAn+eGq6VbaiUEADywAKl?=
 =?us-ascii?Q?68RQRoR021N8VzhYNy3QTpsrsuxmQOsWUQltC8nQARi7KmbL8it+J3yyknaF?=
 =?us-ascii?Q?AuNQRHYtxFAiV98Ujpa51KUnvtKrfBYXmEtAxGSVjw2EnkLGRA7CY55JGECS?=
 =?us-ascii?Q?vMJRwHMerZ60xaPXrc3i1R2frso2BbskSjbNDOoSs/gZzZVoUJTOhlESvi5S?=
 =?us-ascii?Q?rPGCnt+DOqLdgGTTP+TadWYp0TztkBxLCPN6B7YW/LbcmfrXqoCHBUJ4/U54?=
 =?us-ascii?Q?YRVyKTfhrDvnkjSQQzHlbtK2IL+em5VvcUfMswDhNf5JuSivEjL5NFe/XrtP?=
 =?us-ascii?Q?dYAUtQXWSB7vY1AP/6M0UeDJreJca73w3qIvPOzrVAj1lOoMlQ2MdvTEfm/l?=
 =?us-ascii?Q?s+4KmuSieu+fvuTrY2A9q7Al/ulSKV/TkPAxPn2ZNQJVgtEM1kvmDm6EjfbA?=
 =?us-ascii?Q?6qgsNlrxwfrtKHX0ur/STGuG2FrEDSAb0TDAAMGFtyFcvR7ftSHDSl9oXlNH?=
 =?us-ascii?Q?ifcI1caWIVYnxFIERKc3uXTd0OqCUk2RSgwyjHzaH5nsYkJmx71xQtCc6Gw2?=
 =?us-ascii?Q?0spwgqM8RZYDxx1sgyZAuxDpI5uVhYBNu3GcSCt7oI3BBhIzyKApBRg5JAvH?=
 =?us-ascii?Q?gywWyd1rdMPtVjXrpujQY2LvIAZPdp9Qe2zHQhDj876vF1XZnXzwVsiEydE/?=
 =?us-ascii?Q?Bmri8OpdOWPGKGgA2S9QWWOsmFZdQNlXnRmNYoqyAdc2lDfNwDqefzYtC/6C?=
 =?us-ascii?Q?Pv2YB9Jar1jkGgJSOX/ZEyMJujBz0JPRVjW3LsHcUHujdqXQxeBNFMKZN6y1?=
 =?us-ascii?Q?61PpuWLYxlL+FqDBQQrK08wvmYed7zaw18gFAC2Y9ka0/zuv2/GX7YGaIw4c?=
 =?us-ascii?Q?kZI5C4RsgheSjKwe3/KJA582R/ZzJeQkxO7UER30+PKR/4jdIFuNDTXaTdVL?=
 =?us-ascii?Q?rLY/H9dQgjx3DycC05JMTap4Qc01gClyXrWA7f08DALU5llmysS6QEpXezQp?=
 =?us-ascii?Q?/Rgrk28UeK3Nl5XnKD+F84NpOm5/ukluJ6rKoSJ2jR4nz6OKrb3OUExc5AaV?=
 =?us-ascii?Q?f28KaahUAA6ZqrcqB809diQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a05b1a9-4fd2-48ec-d367-08dc3efbb4e5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 23:09:57.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT8e/loHEfMFRpcI+VBs3p9k7KBjKtWsfwbY4B0xA/xOiqa7rr85LaTDrchA1UwJ/bHNDGxvwO0kSp9T+6tR3irmHiYp3rM+kyjRRtnd4Zy/CtZPYAO5URZmCUP7ud5O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7116

Tertiary match group was added to CMN-650 and newer implementations.
This patchset makes the parameters model specific to support properly
various models. Also, wp_config registers and filter groups numbers are
decoupled to enable the new match group.

v2:
	* Use bitmap to track which WPs/DTMs are used by the event
	* Dropped model specific parameters
	* Addressed other Robin's comments regarding to sysfs, sanity-check
	  of wp arguments, and wp_combine check

v1:
	https://lore.kernel.org/all/20240126221215.1537377-1-ilkka@os.amperecomputing.com/

Ilkka Koskinen (2):
  perf/arm-cmn: Decouple wp_config registers from filter group number
  perf/arm-cmn: Enable support for tertiary match group

 drivers/perf/arm-cmn.c | 144 +++++++++++++++++++++++++++++++++--------
 1 file changed, 118 insertions(+), 26 deletions(-)

-- 
2.43.2


