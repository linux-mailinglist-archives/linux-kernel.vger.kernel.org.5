Return-Path: <linux-kernel+bounces-128730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512ED895EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE5FB22C97
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1D15E5D5;
	Tue,  2 Apr 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="r2yDchdH"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2114.outbound.protection.outlook.com [40.107.92.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212415E5C0;
	Tue,  2 Apr 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093580; cv=fail; b=fovtywBRoc/FFbqw8nUnvYlo0D54mjvyQs1DFcsEmwVf0GOcm57cYapAZ2NyxT4ajUBOCH4cgKb2jaSExE09odP20ZvwxXmdiiFAAovvHQ/fNn+Mytajet2/pS9X6Bnl9p62I/R74tO0aXKIA0D1l9fdArih6JkpaBI+QDVKooo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093580; c=relaxed/simple;
	bh=g5LKBpRyJ9I0cbEvbTpB6XAfkhUeHtG+pxznTeZ1kfo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Gt4QKqCJCMeEyvQi+Smo0admW9w9wmbOy2ihHwQCR/sLOZE8JgJDh9LFw6+eKSL6/U/EZuXKRXQU12UPBO+31D0Z4ffkrpxxpNb8uACVZObCf9ii0P+Hd851sYU2554RY5qGN5gB8f//sqdGOg7oV4tU/f7aQL9pBngWcSYJgZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=r2yDchdH; arc=fail smtp.client-ip=40.107.92.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAsV8FWeTmSUXjcl3SmzxTO/8hXXKG6q7rOnzktXAiWpVjBRZiyg9lmMmuONfv3n4t51nmBTsstXlQSlsKIcOvkgl1q3vzsGyPIJZs6wyqG/zydNrlyCnWs/15GNZWwUT4NgyX0hoDyX9vfU/atqG1fsJHoF11k+l8fdP3mD7Wpzfaj2p9r8lcjhnhHzyz4bIQsG+8dnpaLNNRtYEJKRU8xBbVAo/x8S/lFpQpTv3DI5GOsZyXUR3RjsBIu12heC2thIUeIFb261pEEHSu9MslF2O2WNkjLr8hYxO2RwNFZ8Sa8ZJESbK00SQswLNMHQd0if6TQ9PypKlGENWpYHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgkPns2djioblnK2Ecb5ZdVSvS3t9myz0RfExe0FaDA=;
 b=Lp7Ry1tw8Th5pXtlG9a/68BjBlu+qFZWgcLKaPIUNVfSr0wzR67h9//8x7xdLs/gIG7DxlitmYLiIKMBmE4DvpC2jxdsdqlObJvCofW36vT7pGA4B+0ce3ZFHgGl4xJf+yxeRq/nR7SQqTGwk08q4E1kB78FlDrZiS+lv9gyuFBfC5aa7WtxnrjhvR5lTUUqDvrhuFd3wP5XYJ5Q4MZPBiY+MPzuFNHEjkq7Yy9g+r+cNXtseCGwChrw1QlY101y9e8kRkZoCNV9K4VpeX9DCLrpo0lWb9LwucYvJTtPRsjb3wvuJQolsTZf0c0QfaJkrV7LbwVzmtD+2DgQFeB3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgkPns2djioblnK2Ecb5ZdVSvS3t9myz0RfExe0FaDA=;
 b=r2yDchdH7g29wMUoUW+5faB/aggVDBLLYlKd6SoWXBlVCUvj6T8bXADSIEdbrAXP+YWY1m0L2F+xiLo3IYPqTxC9AjHf+CFkNWvV3tPAwhuh7EUSw6SzFWQ0xuu+YjiVvoKrXn018sszS7329kYNT+pUI1VK09S0d7WhI8Mgz4I=
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Tue, 2 Apr
 2024 21:32:54 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:32:53 +0000
Date: Tue, 2 Apr 2024 16:32:50 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: 6.8 SPI Chip Select Regression
Message-ID: <Zgx5glZznSCheksj@euler>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|CO1PR10MB4644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jaD5y1S/OopnXk59UC0NsNm8mn1hNJkhRK97PaBgi8FLKHBHXhQ6iNWpe9FowBdkBb6eyY+kGTMxsMu6ohSYe2UG7S8HGD3rAUOnzLyo38uukPyJNhIfUlA7B8mIh6OUPCAmBIH+W2yNry2FjJPLtRaSh9y+tRvug2jMIEVTH7NU9KwGEelBWvwd3rSKUe2+Wrs3fDDIX5ZVDXJmKki9pWPDub108T5SbVKSY2yj6F6HBGJBI6hXCd4R+GHWCEuMqPlxPLzIfidHsdn4usYLEzev7kQiDUtNfPb0lvhL81RW36Lm62MNkqIuaKFr/WWs6T+fiITf3RahwyhQZsL00gCE4z+97aYu8ltbRRy23OX8qco9SJ1l6WC3MtaRGSE9/TN91TJ3gH78DCpMPvOpCETde01gMkzY1hJtkF3Vk/xsU2LDiYKMHZdTrmBZ9Px+C82sSzdQxpudkozMYur978YNtzwxFXAOZvZyn6D6RTzBWyQzq1sJeiwdN5dfehFQBpuzaQqPXQ3+JLWlujZB+6AYtxJinnSKQ8tr4mFHKxOKLiloB6qYNE4bgipY/+eYID+MOfvWUb5eUBSOZcn37jEUaQwuXeWF8z+W8pbKzPQdQwZtKJ6NP+HMrFSf+6s2sFJ2EYPVEVNOnVAMZcsb0T/b4VOr5811Jf3AI6743lg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N8bKgxdbfCFEJXKVekai28CC8VRapp3HS/hp5fHxemJDf8Cr/xfLuxmUtrv/?=
 =?us-ascii?Q?amuWcTyUQ1g7CsmcBmfh2i8hZmw50ipA+BpyDn1dGNqFYaOWtgj/gvJyPo9T?=
 =?us-ascii?Q?SyCYvDq32X8VEIVBL922/1rPUajPxFwkckOMocte2PQZif++UIsDTNu/b23R?=
 =?us-ascii?Q?37hPKrIkqy0Jmy4w8CL23lWXy6iT9WG0YBJo5pp2T+QVKSA++FqO63Q25EyS?=
 =?us-ascii?Q?kk/QhkcU9DOboeJSraiyivj4hlWjkyPAsJUvJGQmruwDsIG60Kd1H2G4Jgu4?=
 =?us-ascii?Q?74g6SivTy4IgH8SqZrUGSWgWPlOto80uQdioSg9X43uD2qAoLvLfgh50xHXl?=
 =?us-ascii?Q?iYsFIZwV5n4VGgmepMlGvbFWGCnhuEbTMiwnH5/wFAWES4999BHCRsXcJ4ds?=
 =?us-ascii?Q?IzR9OvFk0IVIhjBKvBM/TW9IjQEriVU5dGY0cLqhRBwK7W7rhe0tJp9HDQz+?=
 =?us-ascii?Q?UMCSGYes75+X/QTbvPtt4Zav52TRvnrMO0B/RscnpWmMRITWrpGDnsD9Zlfa?=
 =?us-ascii?Q?AZwiB6qrwzHohoIJfqWHEQilkUJ+ZO/L6OyhuIJOs/5HJAYVvtCczKoBNqCj?=
 =?us-ascii?Q?AAKWKmFmcPwKp2GgRs2CNFlYI2OS8WZjZP0jqrJ/SIMj7lgpFb0Nm3wgwt59?=
 =?us-ascii?Q?UIBhTioyosiamD/bp1ma7ilSavQ/3s9fDhDQBTi97FKoiExlGOeQWT2LJnN6?=
 =?us-ascii?Q?a3c+582H2BG0IXwAGag5y8pKDbfrXo2rkP0IYf1Uf4jWm2oRwh9QNM85c6oq?=
 =?us-ascii?Q?3mZYG83IWsx8XXef2qhOXimz2u2u+UWSv05jNB5fVfKfDFDJmr89Ihy+befU?=
 =?us-ascii?Q?iwmDIVj6yZItpx9BhTdUduDnsrJwYSZ8ChvcGvH7rq4POXEVjjVzBudYf0q9?=
 =?us-ascii?Q?NBiMkwA9GhuRK2uTKsetjIWqtpXMxoWMRSf8ioT4n/xHnhdvefYy8BJAhaDD?=
 =?us-ascii?Q?NL8h1emVubVrl6YSoX79V9m5FETAmYiztjrg0ZOKdtVjxRjG//TE4mWtsaFr?=
 =?us-ascii?Q?s//I7jCNRm5BY/gOtD8uiKrl0bQLBO3YzMflwdUWEhzEt5JvKjGhvuD7IAfH?=
 =?us-ascii?Q?/NwLzVSV6OF7Bf035ev3zSUFZE5MTv3YfyM3gP/CUD3CN82uDwdPXsVrgZce?=
 =?us-ascii?Q?yxD1Bn+nqjB8nhg/keROt4bl4DMBVSB+tDaC/b6Tzz9ddqxLW8S8Op4l2hT2?=
 =?us-ascii?Q?CmcECsfqziXrFlSdGO+aDemay0uXuD75FRcyotXK4Z/91iVbsOkB5O7mM9qL?=
 =?us-ascii?Q?OhmJuByEaEkzUVl9z7oWUfLz2e6NGAUShe0YLbUW2ZngbvuJSrqa+uHowJYk?=
 =?us-ascii?Q?fI/sYJxqSTKJoRVGN/wIk6vUTTucjn1sBFNfocIhhtgevcD82hvJK+HLTQsr?=
 =?us-ascii?Q?MS9+Xxw+QoS7BPGfi1BwGFCiqrVn6r7S8VSMf1AGL2R8c4lE8b9EH01OkR/A?=
 =?us-ascii?Q?JQc/Bb+cipw0i9syXkSI6bi8EKtvRLnZ9Bli2y8I1gHjzwVeIh3pipA93yPH?=
 =?us-ascii?Q?TlhDZVxM6awnTnvJ6VAlpPD14AiMmcJNDq+oWBchl4fc6vbn4eZ7r0EpWaFi?=
 =?us-ascii?Q?JongSHcadcVN468gA9+TrnUEKwRcrled8Pl28Or8JsATd13+KqEghlmg4LQr?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df73682-e7b5-4fba-d692-08dc535c748c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:32:53.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RP9gjLM+8IIqbcFEXyNl/X970v/Up1+zFM4pOSUiklC8RpMbyYeX8mmOUPdBC/wMsZdH544vD3z0rrMFTRbsTBAnAKMo0+UD5xOZrW+aN/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644

Hi Amit,

I finally got around to testing 6.9-rc2. I must've missed testing
6.8, however, because it seems there are issues - at least in my device
tree - with commit: 4d8ff6b0991d "spi: Add multi-cs memories support in SPI core"

I'm running on a BeagleBone Black, and have a single MFD attached to CS
0. At boot, I see the following:

[    3.459990] omap2_mcspi 48030000.spi: chipselect 0 already in use
[    3.466135] spi_master spi0: spi_device register error /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
[    3.477495] spi_master spi0: Failed to create SPI device for /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0

Is this a known issue? Is there anything I either might need to do to a
device tree, or something you might suggest to help troubleshoot this?

Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __spi_add_device+0x190/0x224
 __spi_add_device from spi_add_device+0x50/0x64
 spi_add_device from of_register_spi_device+0x3d4/0x594
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8


 Thank you.

 Colin Foster

