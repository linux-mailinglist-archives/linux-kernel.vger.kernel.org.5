Return-Path: <linux-kernel+bounces-106679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F5687F1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5506DB213C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE65822C;
	Mon, 18 Mar 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="txLW4s/W"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2111.outbound.protection.outlook.com [40.107.243.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0C5811A;
	Mon, 18 Mar 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796460; cv=fail; b=EpLu/Qew5S9K4cpLshRXnkOlfphpdIiJg7Rm2bryHj5Y7TwXTzC3RmnO8ZOYzjlxJ0hKVlkstcrboyter57GqjFa+PehYilhv19V3DtOOwl7kvsMi1fVJqGg/uwBjJ/kaq/RdfHADmkmJ//ms/kaQQGPnryf5hWBcH3tgiBKg8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796460; c=relaxed/simple;
	bh=bQYReBqQ29yTsMo7OPxEFNor7sai8b+ogXnO5JzTf2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRHIqKHOi7FoA1yd+oyij0mkEIWHNTV//RSQhDPrCf6hKB9sbIUY2QDX/eWp1K3FcXao82ZU1Qx6vjqCwD9eYMNWl6+TGeRDpLlkd+JTpKGIsanmfQpVvq6Q5/bvucySmaGcv+5hk1ksZ/1Qmy0NVSekTJZcfTv2eHF1cNCmwws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=txLW4s/W; arc=fail smtp.client-ip=40.107.243.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6DnF57ofNQ10P2Tg40BLulHB0lZ53g7G7DegcfUoDZwAppLw45UjcgAWtMrYTB71nxA3TlgtQGk2xd9+TPmXfgMp8PKvYhVw9xEyThIcpFtUzgoZ47H5PXIv6Os1NO/0Cs2SEiswDiowQRHjg++dxdtfT6LjhRkKSuTrmCyKli3ETR9JaDz5NkhxkFN20e3hrfgJFUQWAf/DOQiNFjpMTmq07q1VPRVBUbCqqsX9Lnz374g2uPJtNPa5OsMWfnxHbKYiwPre+p3bjq7jV3JeQpjEwsGOVO370waEODRIfS3uISxP1GUXP3OmjXG79KgnFI/HHHcoC943uWNAvRuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqyztqco/pBsSkglJl5a2XLgD1qp42hIcTUOHCHHCfE=;
 b=Mz+DkQiTvyorrHqaeGyVz2if2lOO4VMyer187adg/TLw6RZ2vXhsDjejOS3bKTzo0g0eaBF6BUxSR6qn9RRh00D0sA2A90IOM3NyZfasnAUlCCRvZSolH6emwqPxPhlt+/Vbae2GZXCrK9O2Hl63BXyXqvC4yI+aX/0/pCe/BDNly/mWvDQ+hkR87v2K/TgTkhr5AlZsw9gVNENqtWJQIcZ5DI9qlfg/9qQofcTEPW8NB98BqWGphCIWPciJS+k+CpnDFQoKobYctLOnCUKKo3OtuLnez6oQp0iFIWvGq9/5hn7HUyhiZrzWKwDisiAaAOOuyKfDZesxmwxFxZOjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqyztqco/pBsSkglJl5a2XLgD1qp42hIcTUOHCHHCfE=;
 b=txLW4s/WbZcqF8g5tZC1Ydwgjn7yUMrUAvpBmfLe0xb7U1hEXraKzl+TVRcWdIyzFRVOi1hX9E42YuNL7Ztev3FlCB43XZncM9pfR4xyPscxukb6+ZRzucbPet30T6oApVy0mQUR5uLQJQEpN3vhfzqcs9KPyJrynBcIH7CxSXQ=
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 21:14:17 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 21:14:16 +0000
Date: Mon, 18 Mar 2024 22:14:11 +0100
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] x86/numa: Fix SRAT lookup for CFMWS ranges with
 numa_fill_memblks()
Message-ID: <Zfiuow9LiOIl3C7X@rric.localdomain>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-2-rrichter@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318210904.2188120-2-rrichter@amd.com>
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM4PR12MB5747:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n2LYQAG0C+R2ctD1k2f0I5gvy9dTc+cRIIt2moSzsGArzQHrSMyWR0pVXJmYrC5a6tfpcv5CTJDduO5tJt6Tw2RA2KA3A9+AlBbWoy+JvS7NZ8Xg6AZgzh7jbur4TRVWE96QOKUwtqbkJ7rzP072mNuMGC/HsmQQbNh9p4a//mcDtY4tQMN95QhKYAMYfXPH1LCAYRVTLw9Ym5NLCKgMrH7koHVeeLkENZxlA0842eBQnZcZ4Jyik7ZGaDADdu2YDjjVS3Zmi4fw2usgf8CkZM1Wrdz6ejfW+QPPNE2590aef9niVHW1R10tLVUemslmnk917m6EWJSfsN2wYcXn43706pThk3mAm4vXlpb5KPBd2ELTgU2CkxO86PecUqmYjbGcktdrhXfheUqNE+QHlyDVpGGSJi1xL2zMYPAgLfZwDyh8seN7J5WPmkm8GHQXxP4ChbuGu+AEf4+fLvomjUhtA2qJmX46LYsIV87URDC4+e0UXGOfEfeYj9EGNNeow2Eq12UROTeanhaN9xPC2jFrnlFnJcq3T9wmnzqv7QmSm0UmhmlhKccNN6tWA/1rnvsiFf1huzV0YAKNDkQOERSu1Ypzg6f46L6385+GGcIU6av0QeFrmnG2zFQvwOWLfNTRkXc0k4eOhQH2or8hK8NFal/UPz8XSREFQmjMYXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSFoOhp2u1Mc4bort+dxXWcgeJ5UdDY7UFU7+3sOh4EyPhrUXGEEn5hk+Bia?=
 =?us-ascii?Q?6GP6edKmbKpQf6twQ2LFvvMZBC/KDWtxIaald54Nbfvp9oMwbgD9tJXdC20c?=
 =?us-ascii?Q?QmMhPKulUiNnNgSRRu1dtTh9X2HBcGfH/VL+47f/z+jGk/XkwJcm930RGD8/?=
 =?us-ascii?Q?h8oGmkSO8xla6cxVr+4uHu1GtovbkUZ+OR14ltTyLAOkGeOQTVjmr3o3GrzS?=
 =?us-ascii?Q?Fc5xeQVLmv0SY4gEOQDbpemiUQ9Uny5aKCPyn8lwfFp2Wo3Egc1UeClsefpe?=
 =?us-ascii?Q?h3EA4z9O0iVLIxf+Cg5knQzpKyDpR7E+J9bvSdqutOubmpdHtWVtVOV3JHe3?=
 =?us-ascii?Q?4ueYSLG3Sag8FybVi5YUyY2Y5MOkFa1lqPZoD9qbdfhgFC/nd4WF2y9FtpWN?=
 =?us-ascii?Q?vXRF/t60J+OSM+FPO3Nu0qKQGF1iUmMuiqNLhdi9SAPqaRX8wrFDOGVL9twM?=
 =?us-ascii?Q?KypMhW1oU/i+CaD3HxVF2xnI431kTRBO4x/0bd7ZS74RYkaq2RtENwtirZ0t?=
 =?us-ascii?Q?ShQmB3ravBhL/9fU1zOHnnRuwez1n+JVN8AiLQU2dmMfaeZowZH1y3/RsYNi?=
 =?us-ascii?Q?YEZQ4UWqLZ54vD9NArJR+AX3loTk6zjE0BX0QGj9oDCTERbL//tGLBGluG0V?=
 =?us-ascii?Q?fBfSCTuJLtIBB/shvtNPKzGdSX7btTGmkm6RMkzbQANn3TCC6+Ev1+1ce7i0?=
 =?us-ascii?Q?Y6jwK73nIuOuJtlJnWIh5rlco7wnqyBe0yYSJqcw2v3TNuzQqiAfT46+O1DZ?=
 =?us-ascii?Q?HWI0v1Wgui/PbbVwRNuXIBPddLKXQ8uodKwPd0xH+FNuSceBJij1LGnVnar+?=
 =?us-ascii?Q?kPVMRbIO0IEqYvuZuYBbxVYTN3kB/VcxSPx/F3dLrxdvcdLwqxnEA7KnKsSc?=
 =?us-ascii?Q?HvbX30MRFQnzfbPw5WmQJa8Eaw+J2aq8upmgXFKfXhcFyBTY/oC80NRS0853?=
 =?us-ascii?Q?dosAPJtRCzn/XZeaFEPJYkl/8G4zCBONRhKUt8B0BDDRZTgBzT2BrcSBkNlE?=
 =?us-ascii?Q?y3bALedboq23f2IrjYLfg4N3vrQ0T31C4PfMnMJ/pEPfeSEhabauH3miQFYZ?=
 =?us-ascii?Q?HuemZlXVQwT0chHMByW22OYwGj5OBj074Eo+CqmyyCQERIHyNge9vCuWxmcb?=
 =?us-ascii?Q?x3HI+8VR62q1KoNfj/siYBjTr+/RGNn43fMnnfNI17oesU/jB9eukcg18e/T?=
 =?us-ascii?Q?KOJe9wgQdPAjASWTu2M87e1jc0pSuDUGi7anW1QUA8ySxXNn4IpLL8l+Zslt?=
 =?us-ascii?Q?ME5cIqIsqh8pijIuvqqvCFZ8UBCL7DjgwCt8XyCbJnVFYXGOTh52kOBt03OY?=
 =?us-ascii?Q?FMznReM3yRsgJ86m5mp9iYExLNDQRW/8uw2gZWwIQq1zYW53jicTeyBMy7j/?=
 =?us-ascii?Q?QttjugJa/n7zbECXGsS2z4ihdA53aCU4OzhUFmIVXZLu9Py/3537SPZO26EQ?=
 =?us-ascii?Q?V4FmSh/l0PsbpO13JuZonH3+eARS5aU1Pe0ikTXH5ur8ctYY6pQZzpe+rnHX?=
 =?us-ascii?Q?kq261gvyJxduWholhFUZgn2pWQ/7iYnY0b8JMXYhOpZb0IEChbLf/4WbzF8W?=
 =?us-ascii?Q?iKZbddtC+3zKDGoKr1H9kLXb1JjFT4jJsvXZE7MD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d329b2-b21d-48ef-c4e2-08dc47905e9e
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:14:16.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwQCQBH5j601LdQhj+Mmo5Udk5/2L3XF16imWZXxj0RZu/yQRlGF4gP0NcoBuGu3OLGsqaypfDFmeaLUVG+3TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747

On 18.03.24 22:09:00, Robert Richter wrote:
> With kconfig option NUMA_KEEP_MEMINFO disabled the SRAT lookup done
> with numa_fill_memblks() fails returning NUMA_NO_MEMBLK (-1). An
> existing SRAT memory range cannot be found for a CFMWS address range.
> This causes the addition of a duplicate numa_memblk with a different
> node id and a subsequent page fault and kernel crash during boot.
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too.
> 
> Fix this by enabling NUMA_KEEP_MEMINFO for x86 with ACPI and NUMA
> enabled.
> 
> [1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

This patch should be dropped in favor of the other 1/3 patch, it is a
leftover.

Thanks,

-Robert

