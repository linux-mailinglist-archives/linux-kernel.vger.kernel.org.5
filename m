Return-Path: <linux-kernel+bounces-100800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D73879D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DEBBB23B67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997814373E;
	Tue, 12 Mar 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O0Mmk3Lm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3EF13B2BF;
	Tue, 12 Mar 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278803; cv=fail; b=MO6AYyy8//kkl7q1WAsltXh+J6Yw1feKFg25SugtV4QA+0ZeIVJHYQR+zVr4UVlEEnRBk+X9f38AJKaq0j3YMcWpjPDegA3AVBieSxBaXv4BMVHrEZ4SjHz5h1xVTMuMibXy6n1azCWVfh4HqeqJ9e70rihOEcG5CwCQd8db6cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278803; c=relaxed/simple;
	bh=atTKGZFnCuytnqh37JXKaHxCrXdzCIKwxw7ffiODgm4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dTrvxk0sMWZvJqkhipZkkz6EAtbLtKS7m3gQec1Zp8pA4WGdzyoX8H3ME4kR7ZK6Uk5pJVtXYGJ7w0nq28GHWeVUeWUcWmRgEGwSbqUucBo6SEErk6xbfRHhhnMCTt0nQv32bMFyu8iac724QniCPqnt0X4KOu79wALVTzV+9OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=O0Mmk3Lm; arc=fail smtp.client-ip=40.107.237.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/Gafd3gRVEOvcu4d1Uw8F1ACd3oL6a/yJ9pFnY/7SrmZhnsiVmlJc2AtBcxOc4eWI2Sh2Ze8Z74MzTzCot1N+ShPOc9Lc2L+iLbRt6EMOodT4wV0M0xIUbSJv4+fIMUgioRE8vXABaKgqAy8rQY8FkjQbxqwWx03+MCf+TqSy93Lzfpf/+QEfvliSuDEDguS+b9LvOj0vff06I6YHTZ6MOLpyCzuRL2u3lZ4lCOOqEj91+z8QpNlfB2LIeR2y6l1ZjtuUP5kejpunSuDUa4bkn6H2brAfrpcWdqftAo2ZePsku5xAvAeo8ZajyJrMNulbxsOH63MLphxJ7AfDxlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrKzl69Ix9bn4DiOEmcSJeeLK0/mpL+pGhT0Jldhhbw=;
 b=eXtgF/cdeCHP+5Gj86hvJ+fiFai/Gh6tk1MiTqQtOjjdUZwYrVEi0H6ON649xHta5GA3nM9aVwMO8xDeADzR4wmw1J3xpjB/f8QGa1kWTmxfb8+lc/aLb+nZKHWvDueO74FTo/PPYyiZ52aeD5VHTIqP9NsRcbqR5REk9tdOhdv9dsvvsb2ZJP/AM8EilrF0yJW+36MZ936eZbvxHmDzRTk+AxykFAgBB5l96iS3T+CSKJ27FraHPBftEeA57dSubtcVdVZGjQfXgBFF9oRTgXoqO9/K5hgYInyV6JsshV5l+MiravlF8hztKcke73qQ7JyFgcjZz0xFii0W/kNK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrKzl69Ix9bn4DiOEmcSJeeLK0/mpL+pGhT0Jldhhbw=;
 b=O0Mmk3LmL0ODdtDWBkVGsX9rQsp92Dit4ewGTPw9dHyeMWg3z6WL+H5C3NGlP7rK2rZOC7CHn36Kpz71MCx99EUEdydePp+9vyYiKkgLebn66qUSq0ufPWS0EN5qg2b4BnZYDRFbRlYCIBAcy6sgXmfKo0Eoz7EEQjW696nIMUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8102.prod.exchangelabs.com (2603:10b6:a03:4fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Tue, 12 Mar 2024 21:26:37 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd%6]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 21:26:37 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: zaidal@os.amperecomputing.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Avadhut.Naik@amd.com,
	xueshuai@linux.alibaba.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH 0/5] Enable EINJv2 Support
Date: Tue, 12 Mar 2024 14:26:21 -0700
Message-Id: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18)
 To SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ2PR01MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f89ba97-2bf8-4a7f-fb7d-08dc42db1971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aZ+X1QIFV/6Sa3LWqjP2bro6MoSXlH46VGLQcZ0UVAaQO41SmK4uPAQSmRbOkSJi4wkRr+aDkJ0eL/ZgI1Y7pmDSkNLb76vEgjJMq+Qofu6LDCz44YXx1qFbjWMOmhdHdNa06+7t6gU07VTHRZCFlc17Y+7EG7l7EGMg88NujCh6+R1jEmUxb5HJOC/Up4GtQ7f9/byZWdQpU+hBSxCy2uh9+OOpsc8q6gFiMMwVEvUgyl5/wzI7Sbyeoz7K4raTOXbvx5+uvTnAUHEKXZTGa2twfmusYFcqMkhM3bgAfj3b8aH8AemWwoX9lRTommTL6ep1iMtAM77oT7EgQcu7920V6oNO+yT4aRkxE03mJ51fmYdKAP/xmg2ehpC/OAuj3DcNJ7AZWUQvssDmfcxuTCBWMklq2TuGuH95y4m2yp20T/C5BbVmiKlhPU03jFrjwE0bKZh0XfPAj/G+sAXTwn1vFblrSdTU/VcyhfTgKDoSgCG3r2s72yYxEvyRWb6s/JkHfaCn7n9tdzZcnaBiTFPMO748X6OlxC2UPg5bYOP+2KE6ATMbyyaoZICfTXak89snv5V6T+BhNZbh0ulqHHV1K74kGnNSPA4kQMlYQ4hM7/3qSXDVKcC0dcr5Kv28qRbeJ0dRwWWBSuSSzK3LPTB76aCUUgm0V2wh8XU2LmI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9njomy+p0ihMW1KgaqVXJpte/SeOHw8lyda9S/GjyClzqwuy/CePVgsNd96f?=
 =?us-ascii?Q?LdIKMAyOwIqq321tSuQo0Dhce0Qo5Kkd3U4LwZ/Jp2JoJLg1JnKAGG/CSKBC?=
 =?us-ascii?Q?KPb5GuuBqlARPUJEgojuvILP6eUGQBv6rhpuhwpw//LQ/6DJOTge1eJ5Z5mt?=
 =?us-ascii?Q?x+vL54L410KoC/HbE8Nkc3mI5I/+822BJSYhgvYSxfsEPDCh6s8H9HpGch2P?=
 =?us-ascii?Q?i66m+Mn95myTHsNUTVPcXzqAO4+reDZMfrOVQ0QICItfac55l0GF4EnZ6d3Q?=
 =?us-ascii?Q?jz7AfC6ddvxJKyjHbCYrvnFBhJTdrN+PQozRwHLoAy6Pj1y8UmzrGa7zIzG+?=
 =?us-ascii?Q?TA+cEAG+ZeM01GhGA7dmwF4xAheugt7KLLO+jR1kdURuCkCz5Xub6XiK2rcg?=
 =?us-ascii?Q?u/vG5Q8QyvDz1XWlM2sVHV8bYng9Dm+6q94Rwhexd+vUOzhjSh4TOlRcH9/N?=
 =?us-ascii?Q?VoV7Jopl42NC0RUvClvAe+e6so1wfu0cfe0rvTbW4y8ST14ScChRtfypbfxq?=
 =?us-ascii?Q?OON72SJxkMHicgNKpYCN4FTwpOQKy43UEew7pKDzYvhUcMFk9O6a3qOlmW63?=
 =?us-ascii?Q?lhsXOY4Nq5Bxk36WIErcMW5sEBy7TQorP3sbsBCh7a4ju12SZ9tGxoINVqYV?=
 =?us-ascii?Q?jLSS8B5CV3uCKUY8YuIjvWrezRYh49mx1kaYJPS4+HWxkot3TrPHHxCq1ypK?=
 =?us-ascii?Q?dnaZGGScHshrnRnZNUuJMbqNkxV+rcuEbJfBC00QfYLFML0B28oTJAyhB1ox?=
 =?us-ascii?Q?ottYLy66+adOPsvhnerPyrDGMp0yTXUVVOyFjrJFYxBISrTz5k/pshpben2m?=
 =?us-ascii?Q?hVb3h10Wka9+giJHZLjCu1LkFiGl7EcfXm5PGAZ4PDUqGyRA6IZ7yATgPQqQ?=
 =?us-ascii?Q?54heQ4mN17ONee4yfleAYdNga9VwWo/M09aKrVZykU3sRQM9eB8/xsj5RxwH?=
 =?us-ascii?Q?x6+vM9QmeGoLJm9j+yTgYGmPFS2vfg6C/1hOtCh9ngR7AK5PIL1jvYhkYm//?=
 =?us-ascii?Q?6LTPLQMAAvSpMP80zshNucltMI14PC7a7LfjpzIQ3597cPfVKPzCqoeeW0U/?=
 =?us-ascii?Q?VsCEk0gQpfVcNRnpJGRPhflD/g4WDHiBeZr2h4ENB67V7IQFzHpubJbo6Jnc?=
 =?us-ascii?Q?+ErkO7EX4cKRCfuMarzMc6H36jz9PAc3in+2Mg1eQif1aHqeK6XSGL4b0N70?=
 =?us-ascii?Q?0F8hsO1p9PUdC6dHAhRIBsffYU9iylgh21/y2GRgHW1thgkGyPHhQ87MumfV?=
 =?us-ascii?Q?YhqOGMgApg1JoMrgsT6Cw2IBhTCnT5j19F1+qPTqrCfxq0cGQMWANzVEYnT7?=
 =?us-ascii?Q?bTu1/VfDhnV9kgdx4Fgtx3Dxyupb7aeON7E2phb4uh2UPs0RVX3yy/4YeRoc?=
 =?us-ascii?Q?+yjhDA14PAwPk9cPW7FCIR92mfsE68be3Gs16KfqI6uRSBulu2J8jf0sA/L9?=
 =?us-ascii?Q?ts0usxGnyH7IPiVF/qqaz5E1JTTZvs1Ygr4ynaZ/KkZ9EP/MsG4vFTXR7Cyn?=
 =?us-ascii?Q?3w3cqMLGLxb/wIwgxQUc77EVar7QCVu+R3H65dAjTzrDLUZfgbVSMAin8UBN?=
 =?us-ascii?Q?c9C3t8dX+PKOa1dkxxxa9BCr4dni2WQJl12qCQjzPUzyNuJdInwZ+xu7bEJj?=
 =?us-ascii?Q?kz62fLo3mft8EJ3PQMhuht8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89ba97-2bf8-4a7f-fb7d-08dc42db1971
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:26:37.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOXfka6d0wb1xrCf0Z1XreyACC4DN2bmRRWDyZHxZDxCnqCe4HwE5PA0B1/irjGXzM+hJo0xxuISb2DbqzM/DsI4wrDEIMitVHreXa2eJjSv6iqjeFjQxBRGBITA7AHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8102

This patch set intends to enable EINJv2 support. The goal of this
update is to allow the driver to simultaneously support EINJ and EINJv2.
The implementation follows a proposed ACPI specs(1)(2) that enables the
driver to discover system capabilities through GET_ERROR_TYPE.

Proposed ACPI spces:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1446

Zaid Alali (5):
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  44 ++++-
 drivers/acpi/apei/einj.c                      | 178 ++++++++++++++++--
 include/acpi/actbl1.h                         |   1 +
 3 files changed, 204 insertions(+), 19 deletions(-)

-- 
2.34.1


