Return-Path: <linux-kernel+bounces-107486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF6887FD34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9384E1C21D36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C47F485;
	Tue, 19 Mar 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zRR/2ndT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B697CF03;
	Tue, 19 Mar 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849307; cv=fail; b=g/nvwnO7pjKPZPigD9Nl0UlDUViJANqvuHRlS0i84sZ8bc01bOzfaYCKr9dPLuAJ8BTkbYaYsTIe7iH8nh59EdATtZ1RGlrz43+JbswbBTyafS2ReBLdxVRzgQs3CXBcGEXBgZV/VUw3kXR0PT1Mb1tgPghxBzD2xGtvCO3POWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849307; c=relaxed/simple;
	bh=IBuYpeWynMmVX8z74aKrwWdQQFWVjmbPOz+9gDGuoyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=arV60V8G5xXbsdA1uDrazy6sOU8RThMea4VW4QYk2YlLVtRgKjjlxFw8y95bUq7FE8x2qRyp2El4tp1ljT+xO8GHDI++gLO7tbJqp5lsJq3UIyvQ7gRugqVXuzTr6Xs4+r7kexPSVD04Tn1qtRtTcEmUF9QQ7/85EMwVmKNQIrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zRR/2ndT; arc=fail smtp.client-ip=40.107.223.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftiEakrI3Ipko6jTiOLF8pn7BC5VSgzhu+c+uEIPQL6VlWTNdzNRytQ5LW5GIdz14ayHr7IDV6POWS3cI0sD1F+criuEfK6HJrrkFok0V1rxc7UdbNYOz7bBQlIWiFFVdtrYocONQbQ7NoKojlCHIEWSA+FzxFue8/EMY/pHmjToZIbptCVbFWTg/B98cA/Cl61QW5pp0Vgk4+6Zwi701KLBT2HbzDWp81pG3+UbQOiowQQx7dtpK6Hhp3fu9zpx5GNHeShnU3Q+oDjC8aebPds0iv9PTb+e510GO052l+Dgyei7J/sUe1e/C6sbpcHSHZmodrLSALgBP5b+MCnchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7tnLJncZ9SHFvZ+besmeb1H4wO8vJFhsuV51mb2O28=;
 b=I5Xz+3I9Fbws0I6Ix3zXRE9ZSTcNRTt18qQlEwd/fBq83/JYHvKEox+FptpMVRcsOzpi54Ww0qRfXxZEfbZzcrcuZtkteMJI3CmCFblJYnhDoj/oYVitQExU6GBoxfVha4op1T4SCRxEUE7QyV/11aI+8Ld4j8CRMCnCH8ryEDqCfkVqemyQc4xxJsKjqlEcLQABZBeaVZAhd0k3r8F+a/NIoyzUk+GawRrlTpC/1vsDUZg06DtXese9saUxoB5G3P0Wceqi9K4qIkCl9B2N+jALDdV3yqXaE2NLGQrHzuCw/PFZC/coa2IqXGWhB7G0q8gzK4hDF2CFBsCcBgoXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7tnLJncZ9SHFvZ+besmeb1H4wO8vJFhsuV51mb2O28=;
 b=zRR/2ndTCVJpLuXMdrF2AUIcmWrBNOv/jFnE5vxyvTeqlvVZ7cwXa/wfXynrQoZY/sYZOWUZ+aPluIkijjeNC/fF3aJRnpoepsozEoUjiFa2Hv0vsmkyeAaSssDCA69UswVjvjZiPjh73MbOxOkhbBPzz0ABJvcQmIotUdLs7Gs=
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 11:55:03 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 11:55:03 +0000
Date: Tue, 19 Mar 2024 12:54:57 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH] cxl: Fix use of phys_to_target_node() outside of init section
Message-ID: <Zfl9Efxe7DwuU_i3@rric.localdomain>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-2-rrichter@amd.com>
 <65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB6852:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rimx/2kfC8Mcf6vZnP/v6birkS2F4gyqC7s0ja0jaOSCU1lY+4EmRE4KJI+F+G2M5Yw0VXcJ/HDOyAWAKh7oMlIAlLafsoBZHaazfn7QaI8h34Bp4DUaQb35773OC8eE9MbZjruy212cQsAOsJQX+p2LMfOJCErhDaDtdkJ7xaynk71ZfN40Jrz/lh9lCHr5pwPIo82+VreLkdIVQ6wb40/9czYGeDdRVpmkMb1kfOK5azyPy4eB7awx6gLMbDNiKxX/uMD1ySgwcWiT/92Q0BcnjYth72z1Tg1SvPZbCfAhRpzNvUuBdbYI5j/8ZMhUX7G6J9PJPzCm6v37S1TY0ipAdx8c4CtNKnFn46gDlAhF04Fb3Fl5obkfwxPufczg8r8LNoA7hDzIecDSgxoc1H9Ps9P0c2WGKSaIwwatJEjHyvl3mV7XLpN0q36zyFVmwlfz35zAKvHW+9Evi834ACA9yuNGCpO2Ub1Liqlh/LSnn4JNKRgnQNFWSo0uMxKWKVzQA6IPuD3UGgr6es5nk0CKsH1YDIyEAHmVp8kGJzY3vclxyQZpuc/65jcpQ1/BM0iHJowKcJUvn01/4fy4nOrCtS69jcjGs9AXZDguwGc55opcomRpuag+5T7EvE8zX2l7JKbRjpBrNjbhUlHMJvR4c+bEzKr/GJUSlR4LF4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QICQKAySqibtC6UTqgPaaebHtjoJWz9KKUwSEzNnQ9mnotr9Y+3h7PtlhSzG?=
 =?us-ascii?Q?mIhck9wTqQ4rZqqfOmCGb7Fi0gTaqmf1v3U54aS27Yeyxgv7l3pBFOKxbSJW?=
 =?us-ascii?Q?nRQ3c7oFgBonKSf/oSc57W6Xs4jpcEaTgJJguNEKzJTb9nsbnTzcBegMKkjf?=
 =?us-ascii?Q?H55GwnFeHUJ/kf06c3zlCykyjaO1wNA6sjOr/fWBl2HbMPjyfDxepPUez22m?=
 =?us-ascii?Q?YphPKZqS/2LC/5OchI4uyzvd+wZ08K10lXtVxPjBWMAg7gMbxKFdaif2fBjQ?=
 =?us-ascii?Q?YG4c7yTL/PEM9xOzrDAATIczuP0ki/1HbaOU0hYb5tC90vqw3h64gy4vsH+H?=
 =?us-ascii?Q?C3scJz+cpwNzmQIQ1wGhg2QPP6lD1Y5ak0tRewGTiHJVnIkYo2Yt54d3Z2V9?=
 =?us-ascii?Q?YTkE6Lw6Uj7Bf5Xn974WyJFOb7e2yVb54wd6ScBdawVUN7sAL6ShazXdy85e?=
 =?us-ascii?Q?8RXkqGLpJBvLlJkyYuwKa4Qq/jpn8NoL5S+LKMh4GjiSfb+ba7fEoTXoBc69?=
 =?us-ascii?Q?fUUW3PzalCCj9Tw8u8Ql3+h9y+S6tbs/3hgi7VmKnwqNyN4r1kjAC7b5R2lO?=
 =?us-ascii?Q?aYDpU/p0Hhs+zHqenAFzrceh1MTI3TM249EbVbVOQhnRWmJBthbl4xf9Id2t?=
 =?us-ascii?Q?wovSaHbOL1OJ0V6SRd8P2haQhfe8O/4mePBwleyaBraRa8Ap8AmsYDKpi2zO?=
 =?us-ascii?Q?LO8m/5PDnGSaETpXZG5USrptze2whS56d+fA6UA6lGqwPEI6iR4qVjntBbu/?=
 =?us-ascii?Q?N51gCVOmZRIBzEvE4cV2TBEVsXGEKQvmm68NzC1HIaM0QlYFo0liUmndRWvN?=
 =?us-ascii?Q?XbCH0k2Q6GRrpj4n3XljlqUY+BV3+z/pPLtgHT+1Hm/sgCreabb6xWEpog+L?=
 =?us-ascii?Q?jydogFLZkGtFLJ4NWq0BA1VRvJaXLmNKU3bmiBh2oQo4x5jkNsm77QnAN88U?=
 =?us-ascii?Q?OPTO4vhFxaVO06xaN9WAYKXJa/oIk/E/IpfiWefryxX8jnsBIPmep4UFVg2i?=
 =?us-ascii?Q?ZNXaobeRggjCuKKWWxa+LLFGV4ev6yV1JPPAzvtabcCVM1gjt5hxfnSTidbb?=
 =?us-ascii?Q?JXDX3SIwjBJ9y2nWb6y3ECHszXJQWV7h80LtNB93oNa+s4fJNPLhcKwaJJAl?=
 =?us-ascii?Q?0xAsf4l92eBm7+Vy5WmBYHeOKGAok+FGdEkfyXm4NeNX11LvxxM32+kp4wrF?=
 =?us-ascii?Q?LpAowfK9sdptbiRMFFFgnZKkWiVKTlUxSG/J0/U9rVCyraiQuDWNkxbioLP/?=
 =?us-ascii?Q?lE8VXz9PAzZj510+KA8hT3TqA1Vc/Tr8GdNweuIBFNw4hAA9N2HD60SFNFUH?=
 =?us-ascii?Q?D70C5/1v2BFbvWeo1LmdSLXULjOspXjY/4LO87IUa6RWTGAJurnH+8yPwwNA?=
 =?us-ascii?Q?jQRk61jED0FlPTgXl2lNBMHvaXZq8fvRbeEe43qQ7/8k6DlG4lx0FkDW9VMi?=
 =?us-ascii?Q?Y8v3TeJDwtQrJmD4A40OYfRAqVxWUdI4Yz2McKzsghRK1PVyn1d3i1tk4Yr4?=
 =?us-ascii?Q?T1aLXEmhO0EI0DAD1tWjwjLRNxC6tC4GsB4MkEee5PAbDJX1pok00KBLrC4I?=
 =?us-ascii?Q?8RM05tR14MHPf2EpEM8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0277663b-b900-43b7-64f8-08dc480b6989
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 11:55:03.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIy8SU6lrpNzG7Bohlp+85ybXqj6UGGR7ksTbMyqszNL1AqpReGUKqVx5PBvNQQzUBY2lSlkjBFK4K3I3NLidg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852

Hi Dan,

patch below. I have not included it into v2 of the SRAT/CEDT changes
as it is cxl specific and can be applied separately.

Thanks,

-Robert


On 18.03.24 14:26:41, Dan Williams wrote:
> It should also be the case that cxl_acpi needs this:
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..1bf25185c35b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>         select FW_UPLOAD
>         select PCI_DOE
>         select FIRMWARE_TABLE
> +       select NUMA_KEEP_MEMINFO if NUMA
>         help
>           CXL is a bus that is electrically compatible with PCI Express, but
>           layers three protocols on that signalling (CXL.io, CXL.cache, and

From be5b495980bae41d879909212db02dac0fba978e Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@amd.com>
Date: Tue, 19 Mar 2024 09:28:33 +0100
Subject: [PATCH] cxl: Fix use of phys_to_target_node() outside of init section

The CXL driver uses both functions phys_to_target_node() and
memory_add_physaddr_to_nid(). The x86 architecture relies on the
NUMA_KEEP_MEMINFO kernel option to be set. Enable the option for the
driver accordingly.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67998dbd1d46..6140b3529a29 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select NUMA_KEEP_MEMINFO if (NUMA && X86)
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
-- 
2.39.2


