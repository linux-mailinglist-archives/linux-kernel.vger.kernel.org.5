Return-Path: <linux-kernel+bounces-100802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E4C879D71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14677280F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFC6143C69;
	Tue, 12 Mar 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Zptw8E2M"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5B143753;
	Tue, 12 Mar 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278807; cv=fail; b=egDLgQbT017cbFDkKIiTYBHJtsyR5q6IaknCXFNkgC1umXfJjrb+sfpzi/Lmi5GExAfroUe03Ch8R4xNA8dRbkZLR1+2xQfghhHwuiYrLak9e/rXD04mmMoNuZ+l2xypYzxz6Ds8khzGxftGAT+gQlUMNaKRqLpLyA1daSbtyoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278807; c=relaxed/simple;
	bh=cUnYl5HsEIlXDXg+vIkOKJNE1eKXK/JVFJsV8tqfUYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WXCXxbdU9TSZ8ETy3wnfkyz93FvsALrBljrBupYzac2iBzr0QmO5Yxed6BgDgUb7ERsHtC2TYS0yiy5bMvcO1N9RtvAZj5L07o0mRnOtNd6oEmBIg12NjH9bZ45aM3m9BrKPNzDWl6TH23AQWwipDXmD7YMB5y1Qst5HsYx969o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Zptw8E2M; arc=fail smtp.client-ip=40.107.237.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6UcvlyUmjV1Dyp9DrmXv8yp/TPcybBNiAJGAe4AgRHif7bAicS4NKOrQ4QLbGh/UAdLos+As8qIxA4Iz2rATMv7nL2jJPRdzCIgr8X9orrhlaIEvQbbRJcM1AoQhelokeN5+MCnoJHEpHiPY72b+ZfbanC1AkaofDyvzVqH2k03Pid8JGNYaFYOZpBQQhaeBuQEFiiCz13fRkq8TtoTKH/0VSpcT47TkV7+l1Cp/BT0Cn8i0lIKrtA3vhPYB/VJmynG26Gu9BIa8t54CV2xklZbzWfxO2p051G9CefMLpcizLJclsOENkyx1W20vPJu/mijTAB0FnPG9maSE9R8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgD+GvbHXc2pCRWJ/AHxDNTqAAK29oc8HnBBdYvGaeU=;
 b=cBo90QZvOWEuhxydYxuq0Euo5SxWbMbsV/kHoNozuz1ICHYNAXKv/iyneyvFZiNMPxdYeWlOILGY8DpdLNq4j+kzMM8eZet4/wILD3QHngieOZSJOXEQS2EtvU9taxmat0glrYNQPwMdoSLJ9ULZQglrZx1NqGqVSsi6LHRAG5uio0ngBFvNCgEPpA6tBniWjWJq1yNpYn4L3yByFeASVAZktEcIX/dzyXrVQtn2t1ez9EQkY64mSj0+IgoA+pGm3Y7CHB2/h0Jcuh10cC+cZiQnQXvr14jzy356NHwiXqwhJ0dmyUSRcIr8Yd6ZJdr0/CbxSVeqo2ldASWkyhtXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgD+GvbHXc2pCRWJ/AHxDNTqAAK29oc8HnBBdYvGaeU=;
 b=Zptw8E2MKIDxCeCL9GeEeXAdtu5WWqto/EmD5E0ZawnZYw32bQ5shME41qaWpUw2cS60szt6e/Re9og/5u+34XgfdUC1XobuFblZO1p7HAXRgvy1cJ5y1pbvF4uhnWjG0qKXp1CWWSTrbtThrmA9PDcDIfDPPX8qGSp4aii95+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ2PR01MB8102.prod.exchangelabs.com (2603:10b6:a03:4fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Tue, 12 Mar 2024 21:26:39 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::32c0:d77c:f00b:bacd%6]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 21:26:39 +0000
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
Subject: [RFC PATCH 2/5] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Tue, 12 Mar 2024 14:26:23 -0700
Message-Id: <20240312212626.29007-3-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
References: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cb16d6e-5fe8-46cb-cb36-08dc42db1aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jd26rZsjQEn09HW0XVLpaIvY29gCdmBBjJsxW7FATtQRqJTkBRrblwKUnXDM0HP8zCu7WBzszBJO+tKMO1GXCvCJf7SXcYxTECSjKKSbhIIGK9uS+q4ojlxE2bZaJCbQUoNNuUE4XxLe1xvpUBvF+P21Lz3TuaaJTEmPB3sKyCp6vLWW5QD4XOw0WrqHBU3BsNmfZCYPt2D8MQbII6mO4PR+03HgzJdVeIYFC8QfExOrSwhjVnNnpZT+6JJ6ivrSVpOUeo8iNWlbpE672YX5h3a7t5qaEAEiHDB8N7egD+mAbX/Lu9YfYuf06o0clbtL8xWT6f0E8f4Ft6rW2gmmWddtYqP9kaBP6pvQiqpZ/zc296WBliIQxfkbmYfQHden9WSc3WecBFB7XSLK5cwIdb3pYJavMt4LV7zM3iwrwmYHAphsnicCGF7V5DohcbUy7UzgrHezRyS2Lz2Hjb2DxDADQ/+7veWo/Q16OViOji+j3oTVD/j0kvAOvyfhqwgE6O3jZcuMyRugE8lD5tbhZ/PtNi91I4dSaedOERn1daYpuOLDGbkNGrRTJKpzG4h+1GSEp+Vv30vglKAICDksW9AqzCuiYqtpj61hBvpNkppiF6aFQjMxgZBybX4PcXf6qzUsRihfWD5bKuCu0K/DEwOjqInG9byybpuxhqaqWic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKZbqkuinnkVAGzaRB5j278lPNBkVKXAWDdDBkNe8g2ZSn/DGVhSF4qsZYgq?=
 =?us-ascii?Q?I/esl8Bf9XsRGfG/XhgpAE9Up5r9zObHuYj9Y3IBFhH9YuYU4X+N6vOnPbaP?=
 =?us-ascii?Q?5mJaNbC7ELj+iPYDxCloh1jWcfoLrfvfsmrWJS0qpsR9Tdk950LgFnmCa13p?=
 =?us-ascii?Q?vW/m6TwQXToYRxY+KdLCNJoAxHiOvkjhrE5u29OEdF1WpdPIqQGBJI+nSoPV?=
 =?us-ascii?Q?Cfqi8gAhKN3urpoRHDVM6xTjdZJPzHUG37OEktI+xkmaSLgHLhKhAQfZVnvV?=
 =?us-ascii?Q?LEM/lL6jbsavtji+R37gYmXeX8m1CpZkDGx0KUiNBM7u/NtVQ2j2ZSEeoxxo?=
 =?us-ascii?Q?yijBkA07XDmHBZvGV3fpoRAqnwhGaewlKcU6IML9Dap5htDm5YQXL+8R34Tm?=
 =?us-ascii?Q?keDoMbo5ifd1X57fBwSXHD1h7va6JCKxQZbFaqjobrXpr3PbBzU6+ruY403W?=
 =?us-ascii?Q?zCecjk2V8fHvDuXFnZIcpHWegXc8VS+batoKcM01i2KHkJ3VPtmwh34xiawA?=
 =?us-ascii?Q?o59M2aKFH1dx+xWXcmHkHHgLd7JK5lKJ7iK1SELSwP2NREeWaNb8bpcV4AEj?=
 =?us-ascii?Q?CErjDjsYrXqlX57algC/J91YYWay6KFyW3LV6y/2FMYjkUjGzUA8uTeUbmXa?=
 =?us-ascii?Q?BmBKsH2pIgnBz9JDGobRPFSbgIaP8mFCjSA899wOe0NrZfYEG4PsOzJvQobj?=
 =?us-ascii?Q?NTHhVrRa5WtKcfTPCM3IvKl8aiOE+MvJbY38KqQMQr3agnJwuOQ/3HzrwS4I?=
 =?us-ascii?Q?qAhpDPK3dkQWqnGNMdD8imw63wmUAm+alxG8iz+7XNc+9CwYFNS2Zll0jleA?=
 =?us-ascii?Q?PQRLctYrM2J5JxzTgAqFG/azTuNnZB5LrAcDn4blU52wBdzCV6ZUaUMKXTPt?=
 =?us-ascii?Q?6YMCRWun/4Pdksafp1EvfurySd7edbViZo6mTua6KCslgsduWqM6780dZA5J?=
 =?us-ascii?Q?1hn2mZcDUFi6r/74hz23hg/uy6aWXonvGgjrmtT+MH8Epg7P4NVCsqDSiLmN?=
 =?us-ascii?Q?B1R6yFJhhUI+2Ry6bmo8m/pnXurVicRsoP2slx7jqDUP3jYHXCbvdj8Tldxd?=
 =?us-ascii?Q?usKiW0WrHWX3IjRdOzFA/uzElCwqxygPNnMCNWDhzruvdLaVENCrwZaaWx+k?=
 =?us-ascii?Q?Y/GokTiZ35HKfT5Kj/RBeM6HLI204+Qeq1N8cO2g9VhSBh9Ns31KpewtqbC7?=
 =?us-ascii?Q?jJEhicf1rS5HsuqZFkqtAqPd30kjGWW2E2rzKeGMrOkO8Zkgm7FFSlKDy3ic?=
 =?us-ascii?Q?q570zNix5Ofq//Xqk3e3rxNfcRadr/IYqpi+BbNS9M4e/cYApZ7deEoeUPqc?=
 =?us-ascii?Q?uVNZK1DBHLRLRKSf2GuVD/fquFr7bAIhH1S79AqgK1VgnPIr7hQMPoLCj66N?=
 =?us-ascii?Q?Q7U9lH+zDFnkE6CpOpQAiW4/2YzQ03LWbpje3kM4EvXdMnk82w62phZB3rzD?=
 =?us-ascii?Q?vGjwrkKqdPQJBzxPf3zUX+VrY1l3LLIThHQm1cp/cnTeasW2Lp64WYudxnZT?=
 =?us-ascii?Q?TlKdDx9/sZprP4c/7nN9L2EuAOJPPh7kQ5H3n2AaHSbDrhrfEgiF4Y4DQG9P?=
 =?us-ascii?Q?e2TjweHbVAC80luM4QzAeKsVlRTO/zMzlNr1aWSGzrc1BCQ4/OM0peTpH9d3?=
 =?us-ascii?Q?WBXxe0jfw7plCFJ6W5n/zoE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb16d6e-5fe8-46cb-cb36-08dc42db1aaa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:26:39.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbXGPERLYqtQ7QMGu4toSCcvu/NIu//VdjyMl0bAKK2Kx5zMrwSceNJhCq/nW0cOflEtp+f6F7yKLkShasDJ8yaDyzjdk3NFO0/YT9li/nxnoxTX4t7OPFa442z/vbNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8102

Proposed ACPI specifications(1) enables EINJv2 by extending
set_error_type_with_address strcut. This commit adds einjv2
extension struct and EINJv2 error types to prepare the driver
for EINJv2 support.

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 90efbcbf6b54..119f7accd1c9 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -43,6 +43,28 @@
  */
 static int acpi5;
 
+struct syndrome_array {
+	union {
+		u32	acpi_id;
+		u32	device_id;
+		u32	pcie_sbdf;
+		u8	fru_id[16];
+	} comp_id;
+	union {
+		u32	proc_synd;
+		u32	mem_synd;
+		u32	pcie_synd;
+		u8	vendor_synd[16];
+	} comp_synd;
+};
+
+struct einjv2_extension_struct {
+	u32 length;
+	u16 revision;
+	u16 component_arr_count;
+	struct syndrome_array component_arr[];
+} __packed;
+
 struct set_error_type_with_address {
 	u32	type;
 	u32	vendor_extension;
@@ -51,7 +73,9 @@ struct set_error_type_with_address {
 	u64	memory_address;
 	u64	memory_address_range;
 	u32	pcie_sbdf;
-};
+	struct einjv2_extension_struct einjv2_struct;
+} __packed;
+
 enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
-- 
2.34.1


