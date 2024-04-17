Return-Path: <linux-kernel+bounces-149001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98B18A8A50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8869128200F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D57172BA7;
	Wed, 17 Apr 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SadbNP3Z"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2090.outbound.protection.outlook.com [40.107.243.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBA3AC01;
	Wed, 17 Apr 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375429; cv=fail; b=eAUZFUT1obN5x1eZdpUPefOeRINP2y3xHiAkdWYYKkx0jmNUQrLdNf1dohqa6dEu2Y7u31fCJ1RDtjbtgQXRZuamDeDsWZEdfvPAhqh60eiohWTO1fE9WRhNnSJuUgoElyK4tnikntijnAS+6LeqD3UCcuuUUJVUjamgTR8ks2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375429; c=relaxed/simple;
	bh=jJZsbB5mtLVOS0Wif63lsk2lZteoVZ8s//SaPQ4KsCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WhIvf2Lp5SmRST5Idz/diEyq+qDjHhCiYPnF8VqHFACM657vUHxomZy6rOayynEyNOFTUZ9taaTNOxDgnzI7smXI9ETtOkrJA1xn31QG8lr1hQaX6F/Eq+c1FUalBScV8iGVtHU6e5jQvdQ/Wc4tD7SOIE1w+mJGgL2h88Zgox4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SadbNP3Z; arc=fail smtp.client-ip=40.107.243.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6Wup1Q5rSpi3DtepPB5DUnPKsewVSAV0yNApj75jKo94Yqu7NNXqDiL9S0EaLHTB/Kbjz/HM6nx4nmFn1/M/fKW4XyI/zRMWjDW1JFgE23QVXWw+BzYd8Rp42u8vGRuvdPkzmHE6njFuy2498N3c7OMoMZ9/SKuP7/gxWQEx4FSG2Dm39rEHlTfD57pU/ATd0DT/PZjkRt+O2i8GZ8hLgOITDsS0Cqvi4z8gEq+CgEEUm8ybY7yRw9xrE7DSpS+/7Ts6BsnoD8h0tfmJpl1Cl/wyqvC4VacWIb4EEvGAhcvjIKvxRAhMpOag0g+lxErMMHsT5AsGTnrZtKcXi+L7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jus1LAOuwUSWoFsr+xHKJFaIgyEoWXMfUCu+TJNh9tE=;
 b=jC6zFVbXd0M7bDyagqyDewKpbPJgqi18eG40L7cMNYM+VNSQOUzjoRO23xU0kxeaojBQ2x3mK9J8n1UkzYtJLDdsKtuIJqateiY/o9OCjrYRDnGrk1Fdk1mLph3LLnwV2dPQ0gxJPphdKP1hcBv45TIxAZm08OBhm7DFNdKSfYnw4iiJd3bc8816gu10zkA14GNPyKcU6rExCUmJNqsZth67OFngBiT8717tuQCdZ2+htk+lxcJ/bhxv8aaYaqQVscX9YjjWaJtp+zQ6TMjPjezloqYAOQxMC83QjnfDT8O6+a7d4KHXDPZvPHz7NG60LLffMiv/FPcP83UFJXld3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jus1LAOuwUSWoFsr+xHKJFaIgyEoWXMfUCu+TJNh9tE=;
 b=SadbNP3ZecFheFBPS+ZcYMFrO+OwBOtXHuvXvBSiRgN6FB9w9/PBhRAPT46sQg0yVIhWJsXswNBgwhiZ1inWnuigJO/lMufK9U+3mL57mNAkWejNTkUkITSDDoFsY80L8AYJzMGk29ev5rVpYqGMTPZfU1KTgyYOih2v30NWomg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 SA1PR01MB8672.prod.exchangelabs.com (2603:10b6:806:3a3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.37; Wed, 17 Apr 2024 17:37:04 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:37:04 +0000
Date: Wed, 17 Apr 2024 10:36:59 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: CPPC: Fix bit_offset shift in MASK_VAL macro
Message-ID: <soawdod6cpcc73wrc35bvnah5toubf2cv4x7c3e6p53xtvllrs@6dtpn2v5t3di>
References: <20240409052310.3162495-1-jarredwhite@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240409052310.3162495-1-jarredwhite@linux.microsoft.com>
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|SA1PR01MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 759274e5-3049-495c-9752-08dc5f04ff14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wCUhW07Dw6Bgbq0HB+sSTzBn2mhpa2fH2/CU5D3ujyqpj8L36BAku8zJw9Nj6JXcDT9hgbGQ5+NngsBLblg2G98F0HY2NTvzkH0v/Pm76x3Bvg8PksZLq/LnXPgHTS4LzzyqfH/Okf0PhkK/QwtjVn3sgBrSrOIDWr6YLyF+p4iZr0fKLWOM/DdsdWH6y+HFBIyc5xrgc4IAZ700SMPSnI0pxrobb3+Jv47jtpOaGw1NWeq+nVmSlEEyZWNoeyRWTWEoE5RdXKSsk/FGypJcZCGst0SqFxMjUmNi+RWuKEeMgOrPZXKm8QYY22uTv06jF7ciyETrpVqeyImvLBtzmkYFy0fm0PTpRP1OC4dNuyAjkgEl2qLTdrzMjfmbPjI/o80gdo1MGD9vkLhVIGnSdiSSs6yePG48NJBMoWry8lMooieA84r57TKd7ePCXOpJNnmwmbtFCqxZfqTaZyvVoX74GLs8nyrWhZKeKo+ubigZEFtZderOj+aoKt7xD4xtCNfR5fDU0ZCGDOyEHWb7sLqD1Ko7wPodsFNXNbVR/9adIOFsIMFL85EMZ558d+35A4cVIs38i1P9C35m2JqwpnBX7Ts+i4l8Hy5Z7M8KNBUvwOGFsWuLI4JcHgXcafInpBfD8CpBFhyYJVwmnODqcfpGaLvwJMaY3fOvm+0GjJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sknGvFRqWMNWVgZSPIL6ryZ9l8mk4IR765YvXeF2pBMPasUQ/Um0G/U2kt2X?=
 =?us-ascii?Q?wLk6xWEwwL2Rug1yYJwfOxU/8AzJQfyUiCgACXPm6zqQWjuyVnuRjWAYWgLH?=
 =?us-ascii?Q?UwrKADkuWLg/x0jZA+711r2emGJjDq7O0nwkhdMEN+HE44+v1JLsrmvqYF8O?=
 =?us-ascii?Q?1fXS4cbCWsWDAIAE8XgjC693yl9IbtghirAZqwldtwjDwEnJRKOOID/umn7i?=
 =?us-ascii?Q?zqPk7k6gOYHaOuLksJFdmZPdaJvnA9CGmFc5fhKgC823fz40lBZRlzLU1zmu?=
 =?us-ascii?Q?rcMpIl3LiBJpciey8SDFYrhEfuyEYbKrS4206l7FzZvdvYe1s2MCmRFiLWl9?=
 =?us-ascii?Q?FzX/iyZH57gDEKXhZzGXrV8/DIlkpdE469S298oGwv0ijhHg9I4eTzXALrBu?=
 =?us-ascii?Q?VhwJmPI5XS7+mFkf21Lu1/hGJK9pwuSPesFS4AjJB9YpsOQhzJtB9CyzNJ/H?=
 =?us-ascii?Q?QPWqNdt/fbS7L64tI7/4Uxhl4kV5CZnCyrGAHLnmT7ygevHXewNgo5luT765?=
 =?us-ascii?Q?nmDPdWt4ypzMiBzY4DrEdnP3VGBreyAEVn16GisXw7Kp1+Abb7yCoCr85nID?=
 =?us-ascii?Q?YrWzM7XGxrqL8l3IqGcZYEi5dXrkYOnGFSToRpMGbsr1Pa+rtpbRV6FY8Rws?=
 =?us-ascii?Q?gZgKmp3Kh2BfPrRGrfn5mvC/jlRNiNDn8wvtLVQpDj4ZFLLDeB9erIKT5mDX?=
 =?us-ascii?Q?9/InRpjDra+lU+0NiTx0IK/CInpuwoYI+EuBpEfhU6vjipSmMvS2xEm//dAc?=
 =?us-ascii?Q?kVApaWHWgAZmen/JjYTa8WauHNETYjmw5m/5Yly7TjTOU9Aczadfo4hoExS+?=
 =?us-ascii?Q?YYxhziv1uTxJFA36GGSD05Lz9FHRUvjuZpuSlNsULJfJxZdMwJNJSsi3qcCa?=
 =?us-ascii?Q?8EO73vNx1NmgGezwBGGumKvEidxkOz/02GMWBbcIJoGRmTYZEbX7PaJJJEx4?=
 =?us-ascii?Q?KQYJjN2SYKxsUT72MSACFDPsodDr4NLP50niZgFkaXBeg+pG4/Wq8omNDh7v?=
 =?us-ascii?Q?ubcjazibiV7zwooH173U4lxow0SqpZO8sl7/xBGAdE6Kw638SbU5N5asTkZS?=
 =?us-ascii?Q?1v44GjKoVWOE9wbjogWxHW2m57nOIltSEv9EfWSIZfoA7OoFu3FQTr/EMpFX?=
 =?us-ascii?Q?OCvugl0RZqGkMPbKtEGX+6TFnhYFPhe8O60WEhAAZ95paCYQAzBfFvjenr4u?=
 =?us-ascii?Q?cUSWReIF81hbACgzQF8aC+3z/hrH8FL+RzaBmFXnkpxQ4iprUnpxUs0bSIgO?=
 =?us-ascii?Q?dJvLhrZr9ahQUeUXRvEVBsZZs/cbQvNeR8bt2ME3KWJCiiv+8nFgU6Xuw8bM?=
 =?us-ascii?Q?k4f/e/hCTO8E6gPA4rO23d1YajP5twlBBpQY6W3LkLAZ6Iy7ouX06xWUL9xI?=
 =?us-ascii?Q?x7noS1gxsJMs1l5u207zUuARlvpcSHDpBJ8WGCgI2nY4yZ4WsHl+qvfOTGGd?=
 =?us-ascii?Q?EWemukfMW/Tn4n0K77iQnNk7N2RRnsQsaqOHjsNMj5iIwbdLFHtHvaHLL6ie?=
 =?us-ascii?Q?WneDiKadh7vgDJs8heLkl8y8Yr+Rx7e5Ql9o2JgAKQch78QYfIerrZIOkPsA?=
 =?us-ascii?Q?+lpoftziWbBjllWX/Jaautt0UiyvHSsXRB18gCZoUeWl+sj9jWqjuxn7PdeQ?=
 =?us-ascii?Q?PESTfIIQLOknV7kszM14rpI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759274e5-3049-495c-9752-08dc5f04ff14
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:37:04.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPFCSdnouax2LiXzW/0IsebW04FpR2YB0eouN3jg3amO+PMENHTeWV2/QYHdpDJJAb84Tli51pd6v6kCYZP4od6s8w0BhsU6WtD1aQl2ljLQDB0tcKIIJruU78eoIfoJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8672

Looks good to me.

Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>

On Mon, Apr 08, 2024 at 10:23:09PM -0700, Jarred White wrote:
>Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
>system memory accesses") neglected to properly wrap the bit_offset shift
>when it comes to applying the mask. This may cause incorrect values to be
>read and may cause the cpufreq module not be loaded.
>
>[   11.059751] cpu_capacity: CPU0 missing/invalid highest performance.
>[   11.066005] cpu_capacity: partial information: fallback to 1024 for all CPUs
>
>Also, corrected the bitmask generation in GENMASK (extra bit being added).
>
>Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
>Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
>CC: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>CC: stable@vger.kernel.org #5.15+
>---
> drivers/acpi/cppc_acpi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>index 4bfbe55553f4..00a30ca35e78 100644
>--- a/drivers/acpi/cppc_acpi.c
>+++ b/drivers/acpi/cppc_acpi.c
>@@ -170,8 +170,8 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
> #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
>
> /* Shift and apply the mask for CPC reads/writes */
>-#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset & 			\
>-					GENMASK(((reg)->bit_width), 0)))
>+#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
>+					GENMASK(((reg)->bit_width) - 1, 0))
>
> static ssize_t show_feedback_ctrs(struct kobject *kobj,
> 		struct kobj_attribute *attr, char *buf)
>-- 
>2.33.8
>

