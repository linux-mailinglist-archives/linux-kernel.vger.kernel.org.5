Return-Path: <linux-kernel+bounces-166495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3A8B9B75
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BA5B2273D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406FD85285;
	Thu,  2 May 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ORIxpvwD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8D83CD5;
	Thu,  2 May 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655824; cv=fail; b=IK0XrW/UarrpuUn5aeK/eRrRNnRweDDuT4DxKtGPIgv1GeiMMw26LJfUkaVi4CU+GQBlMFcKP75qPpQTfEWzq+Ay2xRbKS8GgT9KS6Yksue+Ddr7TuTJx/UHMnRVlXkLQOEMRh7HTXDORYi2C/2zI5EwqBn1tFZxdqxpJlEzB4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655824; c=relaxed/simple;
	bh=CHD33ffj5azY+V0rWU+5s0+kDQ3qD2oUdfHrPySYCCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScodAyM1GviH1Qz3HPD6JRQNrXDrv66et7OX1KcDQftP7hjnGbLewSi6kiTi/p3Zi3Th/rTUNDZzr3p2XQy6ffyrfo4/oSYKzi5LVkE8HJNx3HxQRscp+JO6WepHy+PTT9p0oeGWXQSc27gFt26r2+Xtym4gjfFW9sAdkUQepy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ORIxpvwD; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7NMvuoA79SHufnPn6V+/JeHJIABbbxCbcMiH8FvMomgh7qxxaUdNVHjr3KLpt/4q92AbhP8dnHwYPbPngCyQpMj4knGGySAUu/4NwkaUXmPOZ2Iv42PakOOICs13SFlXYQI0a8sPq2vAdZHoZA+0iSM94A1gmmsShGwGdlkgVzWKXJEsVGP/syXY6MPoC9Fu3ODwDr6RtZ3Ad2ioLlSSbhMsnVMsJuAmQSiQZkQ0Y4IWaCzBiOGD7wkChK8xQNaA1M3OR2/Z/GdiLiENgI6OF3BS5uvbofxifSeseEbdfGctFZK0lSS6Z7GNl499jH6zx7vjWdulwpYqHU0Xxq85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ6qchn+J6rknL7xt7vz8yYYXd/dYbFmd2U9InCDF2A=;
 b=bKdW2XYyLbhBnJV3fFz+PLHWjEij5C4W6vD1OZoOam2QtOpi1eC1mJdjbBrPhK/xhBDLMuU9svFpR+a1Mqn/mgJ85hniPjjDQID+O8GVBfj7VxlrcVVmZs86+UwRiQdKFs3Bfg1AJ3eenp+EG5PztatFKjJPRbJkMOZ3UpVK8uFwhT1B6PBG5d7SpV9l9vNGsxh3fQDErbIoyZSxzZ1wu9KjQPaL6+WH/hPi2ilL81GC7ZigqLtIuqhkmEaD7t5EJoeFAwL5E2ZeHMTW9FoPUfD50rITh4hlNmYR7+TYzo6ZuCnbT+MVurRPPQx+6AFmKWwYKdSZliDwBqalAdGamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ6qchn+J6rknL7xt7vz8yYYXd/dYbFmd2U9InCDF2A=;
 b=ORIxpvwD1RgP8hijV9bCIMPNHxUOzd9BDBhOMBIbxg8qmV50g9CPDqjQNXvX3/H7ABzZxqa83z9xH9yPQR9keTQJQFwdLYTr3wbfLZkbx3nboh/l1WREg+lJBrVRlvMpDfWrvZgfQ12i33CTN0YNwynskwTTYonwH/8R66GKVs1i+k5YQWYT5Hd+Hu33kyEdJnBPE2VF8OthPhECf02H/iB1WUJVNBWojnzUJA/LzGqQixFubfppzw1DQ553rpiozZ1tQ7YxG7zZtD4VG+43DP7/cispZIsEL5+x/y+/kWwYb9wlMuII5uWAmZinSqj8AkUcJngIrk8wSyDdPIgUGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.29; Thu, 2 May 2024 13:16:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 13:16:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Thu, 02 May 2024 09:16:55 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <EC1125D5-EED9-4D03-BCC1-77BB06262A1A@nvidia.com>
In-Reply-To: <2f95dac3-51cc-474d-8ef0-7af9dd09784b@arm.com>
References: <20240501143310.1381675-1-ryan.roberts@arm.com>
 <4992C22D-D7B7-4B6F-8A50-E084163BEF42@nvidia.com>
 <2f95dac3-51cc-474d-8ef0-7af9dd09784b@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_38CF2DC2-489D-4DC1-96F8-0F3A23297376_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: fc32d2c4-9c45-445f-ef87-08dc6aaa251c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6aZcdPuMJgaNCzh7eqdhZSm+50pX5XA8XGrGLSt89gvlCiVESrhClMePAMxH?=
 =?us-ascii?Q?pdxk4hdkhOxf+yvkTYDk0vSQoHW6X5A70yXlb6726tv6dInUBXsc6bfqfBYO?=
 =?us-ascii?Q?JP7d1U7sxjta+EWtZ3ZnyXNDvH/4lWm2DV7pdYyHFhiemXRg7h7JYKHgqy2+?=
 =?us-ascii?Q?CluVA8iGpSgaZz8otz5y+cfhG3TS0qR+gawN27pmoP4tZdjO0a/mUkgaxY+i?=
 =?us-ascii?Q?X80jw6M7EFQVwt+3lPT2KBTl1CSRerZUcnfksG+bmok3f+n/Gb+ufpztdCOY?=
 =?us-ascii?Q?xBBXLPPzmCA3/aUwQn6Ptw3/oss+ZlWvZW83YLfZ+bnBnig5rOD8dX920azY?=
 =?us-ascii?Q?8weiJ+kfiP6lBbhyyKMr92XiIIW1oudZrHu+mDMOypwagbaM1o/OfeTPYXfv?=
 =?us-ascii?Q?RCTbqDrQ8Rkh6Dt/cveNepiS44sy58P+CjTzRz6U1BHHvygBL4oJhyvGUH/c?=
 =?us-ascii?Q?dTeyp2fy61l7MVfVlSQiTigxlzmjVW2mySGWI+CUsHFg3scAkDHdAZvhKqPr?=
 =?us-ascii?Q?g+JJ6sEuEXp2ZoM9V8n4iM04BjrdY8/LI1o8JslCYBmSU8J8/kUU6wwht2G/?=
 =?us-ascii?Q?/izXU7SbRBHbqxQNKME5bG6LirVSXOVJXMDBy/os2nFgRmH71iPVbiVO4dFw?=
 =?us-ascii?Q?gQpCf189qyYc+l4T2cS/UcUmDpipIKSUPyKHERafpbkx0xbDEFvV7pqWvOSI?=
 =?us-ascii?Q?s0Pp/0II2jfHVwk+gJxMZW80Auk6C98K9XpreTecojryBrRyU6N1ZO54mXPr?=
 =?us-ascii?Q?IJHsCipLy8ggaGyAbNoGLszmSjbzfR7k6rf0uRFQVGLjThWQcLWe+42qiTJH?=
 =?us-ascii?Q?Gt03I3vJLq/9gWyyZcp37mwQGrhbq5OUT1LFoakB417cjbwQtlxwIsFB6amp?=
 =?us-ascii?Q?spiVKTVBVoRKcIqRSec9QEhCiJfEO2dV7ApLlsIsyTO/D/DZ2egtQ4VtjRAO?=
 =?us-ascii?Q?pMBjrGQfUiutkXGJDYBQchRoAXJlnuj/LUwkDsYjiHj3wESzsYkrRb/fAlyD?=
 =?us-ascii?Q?mVKBSl/cg6ABGvd3KpOjRbChGbRjhzaaSdGhW/gTbLMavhnLt3PbMsmYqTTE?=
 =?us-ascii?Q?MXS7/CJlVXpW6+HpcgBCNvntT1Yw7EaI+MPa7uZFJliGDkuDlaCKa8xDmipk?=
 =?us-ascii?Q?2PmXzwCrvAyMjmmgfnlawCFMnmNVGBvetep9TcCfZWD/509GFr6gj7RYGVbE?=
 =?us-ascii?Q?jDSfF06Vaz9BpvT77vnzZb9ZrM/VQ26UKlFadoOnYaQ5yNS3lMRDxpt/zEYj?=
 =?us-ascii?Q?up3OhFWYwnqJMPxU09rge2n/h/infG+h6kekB0xTuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNqdaaEsAZPsYyLTfU2AmmVv7skW+WAU6BMz9LKCxrQtHXT6QfAIlXOZrS1S?=
 =?us-ascii?Q?5LjNDl58G3IwgFmZOJR9uAEP3yWv9lnGpCfDuAASsjah0ZpRnm22Z0kbf8U+?=
 =?us-ascii?Q?GCqT7j7DyaENdmjM0mVaco84lc4S33gpDDaHBlDJ8Gi2MRRc+lBHxllcU+Je?=
 =?us-ascii?Q?RW4iDobn4CrG3PVpz0nzKOpQVnt+JFETZo2aQ+AGpMUmVuHqTg77Zml2NxAw?=
 =?us-ascii?Q?vhf6QnSiGX4bwZqgrkKdrsuVSVbkJ4knC3C1/b/a7fERIVo4Zxtl0wfN5nug?=
 =?us-ascii?Q?cI0e7bEyKeQsqvlXtxfXCAaQ1ChshYjSxqa+yrWBa54EuWIO7eJifmj21+GE?=
 =?us-ascii?Q?WFwoTYeH1rjP3cZR5XePRJNK5ALBKk67+cfcLcodB9x9URJOLBshbKl9Xgjp?=
 =?us-ascii?Q?iITGDBDDmDei6xnRDvGoR4isPnAg0pcenIcpq/qLBx/tn+hZVB58l7tvOLYO?=
 =?us-ascii?Q?EuHbQOn3Ru2f8yF2mISJMN5d9e0Ea6wRXvTW1qmMM3hVNAnLKkKmMRRj7gkr?=
 =?us-ascii?Q?CCIlzxBRNnk6VOsw2PcO3ZFg0sw+m5Lg/1xefJHsvm+/dBfMYgkE6ysWQcJO?=
 =?us-ascii?Q?frskiw5c1fFcZEnYQSVkJyBF2ZEy8gSEWrBAyNZlDN+2qbFDCqbzPD3nnUUE?=
 =?us-ascii?Q?N2OJdor0CXcoT0bnl3ZXOBtORQ+c4H2RzeOreCrWGHTFfQD/trTaN2F/vUCd?=
 =?us-ascii?Q?lWpqZpRl8Hnf3OjZTEZIXbMLGvPT7TzPa0atR4+Oo+CWidhNKdlE8ufq3IPs?=
 =?us-ascii?Q?Ft1ILflN/JcX8YpBCcNW7iXrLUUcvQlOLnjJBYOHWLsIspRK6/gAq0krvhe+?=
 =?us-ascii?Q?4awrsoXAu9OO52gt/iGLQuxIvlQe7q8/e8xZj36yUWnlUzNEzgiy5Vjyv7bB?=
 =?us-ascii?Q?yut67j7gebrw108U3iGxH3X6U3LZlF1erPqG+kQWOEeHBpnYixkLoVdPBlJh?=
 =?us-ascii?Q?xynvVrd/uHiulhglbbM+k1ai2Nn3LtxAfE9LXC5NHIfKev8YRdP0L8Y8uBZI?=
 =?us-ascii?Q?1v6BsHZ7TBv746wb9uizz9zVNe810GULjy+ehLpoS2LR3IfEztKpnNu/bR3m?=
 =?us-ascii?Q?CXYBF+z954rMwg6lEzW59G1hCvBUoGYk680+FTArtf2PtzfkqHPUBWCpPJ96?=
 =?us-ascii?Q?ilzB3U2tkgl3+s6Rzuot44847zXfyC1jXzq0EvHNc1AVOTTClDBCwS/9Honn?=
 =?us-ascii?Q?wDr3lnl+6+4ITYz8J38Ig0wi5DLxupt6KEOagRJWJ6R4CI4w3433r4JBuhD2?=
 =?us-ascii?Q?KAY1Smoj3kzrRhB85LXZO/ZsAdVX4rc8LQGWkkJ3QY5TIuBZgZHeXkptRkBm?=
 =?us-ascii?Q?jAagQH201kjCzUmM4SyoYCihDVHYSZvaVZn4pFDQiZwVnwNy/WWC7trf5TO4?=
 =?us-ascii?Q?6jUfHZAe9hmoGu5YxOpnGcqz28BsqGf6WZQSMp0j3t5euUm9FELXfwgILYIN?=
 =?us-ascii?Q?4AjUHdLvY/Gphab3mcvo/KoVuPUwZXMHG01fBEqii4kvYkh7E8zGPLufTt6D?=
 =?us-ascii?Q?8LJx0pvpORQePTh1e7XNLzUG/JKE3hGc6M40KxzBHp25x7rnzUvavqEe5KB8?=
 =?us-ascii?Q?QLUly56VynVXPfMsFgyf8Do4RkQ3Thyvp4otPK5l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc32d2c4-9c45-445f-ef87-08dc6aaa251c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:16:58.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOAuerlTg1nMdRtdj2rSuUVPWtWYhkqEm9DuuuN3ZdcZFd1vF1523/D9CSETmIvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

--=_MailMate_38CF2DC2-489D-4DC1-96F8-0F3A23297376_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 May 2024, at 3:33, Ryan Roberts wrote:

> On 02/05/2024 02:27, Zi Yan wrote:
>> On 1 May 2024, at 10:33, Ryan Roberts wrote:
>>
>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>> (non-present) migration entry. It calls pmdp_invalidate()
>>> unconditionally on the pmdp and only determines if it is present or n=
ot
>>> based on the returned old pmd. This is a problem for the migration en=
try
>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only b=
e
>>> called for a present pmd.
>>>
>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>> future call to pmd_present() will return true. And therefore any
>>> lockless pgtable walker could see the migration entry pmd in this sta=
te
>>> and start interpretting the fields as if it were present, leading to
>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walk=
er.
>>>
>>> x86 does not suffer the above problem, but instead pmd_mkinvalid() wi=
ll
>>> corrupt the offset field of the swap entry within the swap pte. See l=
ink
>>> below for discussion of that problem.
>>>
>>> Fix all of this by only calling pmdp_invalidate() for a present pmd. =
And
>>> for good measure let's add a warning to all implementations of
>>> pmdp_invalidate[_ad](). I've manually reviewed all other
>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>> conformant.
>>>
>>> This is a theoretical bug found during code review. I don't have any
>>> test case to trigger it in practice.
>>>
>>> Cc: stable@vger.kernel.org
>>> Link: https://lore.kernel.org/all/0dd7827a-6334-439a-8fd0-43c98e6af22=
b@arm.com/
>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common pa=
th")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> Right v3; this goes back to the original approach in v1 to fix core-m=
m rather
>>> than push the fix into arm64, since we discovered that x86 can't hand=
le
>>> pmd_mkinvalid() being called for non-present pmds either.
>>>
>>> I'm pulling in more arch maintainers because this version adds some w=
arnings in
>>> arch code to help spot incorrect usage.
>>>
>>> Although Catalin had already accepted v2 (fixing arm64) [2] into for-=
next/fixes,
>>> he's agreed to either remove or revert it.
>>>
>>>
>>> Changes since v1 [1]
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>   - Improve pmdp_mkinvalid() docs to make it clear it can only be cal=
led for
>>>     present pmd (per JohnH, Zi Yan)
>>>   - Added warnings to arch overrides of pmdp_invalidate[_ad]() (per Z=
i Yan)
>>>   - Moved comment next to new location of pmpd_invalidate() (per Zi Y=
an)
>>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.ro=
berts@arm.com/
>>> [2] https://lore.kernel.org/all/20240430133138.732088-1-ryan.roberts@=
arm.com/
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>  Documentation/mm/arch_pgtable_helpers.rst |  6 ++-
>>>  arch/powerpc/mm/book3s64/pgtable.c        |  1 +
>>>  arch/s390/include/asm/pgtable.h           |  4 +-
>>>  arch/sparc/mm/tlb.c                       |  1 +
>>>  arch/x86/mm/pgtable.c                     |  2 +
>>>  mm/huge_memory.c                          | 49 ++++++++++++---------=
--
>>>  mm/pgtable-generic.c                      |  2 +
>>>  7 files changed, 39 insertions(+), 26 deletions(-)
>>
>> The changes in Documentation/mm and mm/* look good to me. Thanks.
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Thanks!
>
>>
>> I wonder if making Documentation/mm and mm/* changes in a separate pat=
ch
>> would be better, since you will not need acks from arch maintainers an=
d
>> get the patch in quicker.
>
> Yeah maybe - I considered that, but then decided I'm literally just add=
ing a
> debug warning to the arch code so it shouldn't be too controversial. Pe=
rhaps
> wait a few days for acks and if nothing turns up then I'll re-post with=
 it split?
Sure, sounds good to me. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_38CF2DC2-489D-4DC1-96F8-0F3A23297376_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYzkkcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUvMcQAKJrLAR7F//CCGv8JJrUq4GMdZKP2ksQMqzc
/sjrwG53foQQubulasS04PHXGLoZWJt671SyLKUw7bvtmRalOxM6PuA84KY0Y8IS
FPwATA598nak9S/+WaDSybomtPIVZDTWgNYigTi8Wq9NR3x/Z1nBLJ2WPXNm/LiN
Q4ZQh0DjBrGKTrq7KDTGRdXgkFkAoc7XLBBQSb9VtKU1+2DisZsJw95SO5osTM3S
V9uVtlpYJdTbMuX96ZrQZNNVd7RvwWfOljGf7iTFXdQUMlZg9aX2B8/BLWxIji96
98hGBA1Tk9BnBHwYkJd4Et/O1D0gsfLuT+f1eoQvwuPEfGaEgXpT4LeqP3twmm+3
/jXjP+idt4cfvrKoM87D09iMTFTZrH7H2HCRcjhWbImyoa68F3OiA7vyI2wox0MX
Gpm58KmVUqgbFe5pe/HvN9aldqjhzGGOjnxrBzeDJZ+OmtMG8KSaFC8s5vDM3a6Z
QGkacX0dxt5Yg5VWvb5Ab+htkI1WXEVo+GavjZYFjHowi6p++Ka1jmhSWk4rxYBm
jCZ+3s1WJgKhBET3UrZE3aFXTqkpNodTjPcZh02dyDdOi0PoTRb1shfau+eLKcdT
3bOqy7U68zJHYY+PuDgq0fS5ZwEEkvXpo/0/Cn5eMZ2v1r1eatGdFnTiyzyaOC9R
+ae2bhll
=egvu
-----END PGP SIGNATURE-----

--=_MailMate_38CF2DC2-489D-4DC1-96F8-0F3A23297376_=--

