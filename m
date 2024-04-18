Return-Path: <linux-kernel+bounces-150617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34C8AA1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8323B28790C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574AD1791EB;
	Thu, 18 Apr 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="F9BIczq2"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2100.outbound.protection.outlook.com [40.107.104.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30116191A;
	Thu, 18 Apr 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463880; cv=fail; b=CwrG6USpbg4D5NGCU3+Mk2wtzSsRJM0wjgbypF2o7kegK3mU87BWoIbGMfEXJzOojsdEwcWImK9/ofRLNejZs9AkuIlcGFbjhn+rCZhUOdUZA5SDqf5BBPq7ZS5uiXF2OIC6h5u29lIhWMl8zhnoLrBeg3UbbNCBY927ZfZf4GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463880; c=relaxed/simple;
	bh=gkuQW41xsNaN7XNFZbydJpEsHn3deEp31pGgZUYHtfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kxguVvt7no/b2FiBvlyad9S7CWP3yl5vBJmHlLo/N3cTBOT/qjULl4XtcDcOAuAnPd+yHt7lmXnnQo7c0O6O1M0HxUplPxsmnMWydGC8gvHx3OKq5jBt8sa6hKn1kh42Z40CBT8W6xMOsmQHYv/nJPyWLFFFYfJrOfjZOKiFdvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=F9BIczq2; arc=fail smtp.client-ip=40.107.104.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3nLTKxJlvwP0/RHt6PDhZtvXG14g0m28ZveKpLkQtN/TSuJ7OA2wRvLLKIAowVBlFLrtBNbAkAYOtuIAqFXFfV+vuxYQol0jtohIf3aCbQkBDOD965Ijf+jzySpBke7I0gxli8PaCUPQ1+wqOdOAPTWkE48+PmcHZ87UytszOSSLSrzht9y7aVTMYFdtZ5aoi+W827y/UmJjCzTm5E5zspXk7PWUBYeveVULcHFBkRxUcmmlKZy5IG5fRU7g2+SjqPnYRD1FMPZKjSNbGgF6Rwxp/mcL6PZ4vUDF5UodjPMPfArJXj9ac+GUU8W4ZmJVjy96XsDFJXpU5Bg8r4hrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAxDc/NsRGnFXFbnNVlYWnIuTnwSoV9gV8Z3BqUw8Lg=;
 b=oXBps7d1Dxc/MMw+dPrbu0fTl/G7Ta02OPI/JAkkLSOWyW75mHK+zJhILsVrlGd8Y4Nt6wth1VKTplOkmvSj/qbA2SCKGcY9mPv0SBtyn+VWAMSL2pwVm07gkNBnbV+oHKYjRidS8ax7ppQw+FcMJVm2vTPymcjhHMSsmO9/IpcRZ7IOed7ZknDOBfYaxWYWfkX8s4PPOGvvbZtNUwPjUI/dwJ3OaURwimJtn9O4s57w859TC2eX0nP3H+tRH36aDo/0jKbHfaubZvmQz1JoFGp2rko7NCf4/kktJ5du+1OhpYb+XspHazVcvF0O3eIVcATaKvTlxXBW3KOe20DbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAxDc/NsRGnFXFbnNVlYWnIuTnwSoV9gV8Z3BqUw8Lg=;
 b=F9BIczq2ZYU8HFsXyCUOmU87dlHGXkUC6DGWMEQxfzXpReUiJZvqdjoiLOlDfHDg0aao/1PkkVXOxGnNHSSXakzv212SR5Z4cAtMOcqsgb6T9/EFBCCrO30KKD7813o3a0IOeSAETfpnKCEDWR+BdAZFY72hKDI/MCnW+qVQh78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 18:11:06 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 18:11:06 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v1 0/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Thu, 18 Apr 2024 19:10:56 +0100
Message-ID: <20240418181057.2688-1-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_|VI1PR04MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd3e76f-a136-489a-73e4-08dc5fd2ea6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X+LZlleXEo8HNjFE+ubEj7nJLjSUolkWELyvQETb0Fs11AQwQl2UmzaoFuWZVv7dP+ULfrEg/Wmg6PwWRCNj4GYMDJf/0LeoSfdQ6TmjbKatGesw+VO9t5s2YB0md3Bz8WL5LwJnOqgbAxGfzdRLVfrUKA8M4NyDL/P3QGlV0pRZX4TKd29jujUowcrGtle5n8BgZuKYmGQ1RPPy+apEIXLcIub7FvQT9F3Nuxp9cF7rvHjTFjGL76KSYZwaX1gMRb1YsNQdQOFacJE8g5GIEpEla0+J8lHAHukKaOP8SOadCzq0TFQnjwKBobGjtiRCO4Ond1GlHBITZdvnDaeVftzY6U2NgQtNCyFhOa+eNqA7LEZWLMTVCUzDq+oOjI2cuk95I4Wpid2Al27EIrhL2Veyx4lWBRdzhoPk7bwQOJw/6G35Ue70gkUb93G0VyJhJOj+WsxAlEuNFyyfijOArrla6g5rdcKd4mAPh+X3oRFukYVqTjdlgYuBUnlXT0s9zxQ1y6k/AxCdJvPt4PEV5IWnz6SvA9s/f6Znz32AtA8cxLpVSIW6/IiOJrwHuYq09laKEx8Q+Kivqhb6XaiuvIHn2SQvfkexfiDu9pZgC87O2jAtdBt8m6z3fkZvK7TJnHdkypTiSvGvRq5YB/wvAyzdrT1ZZivYAXDGeHwQGfLZNZfSa+E/cNNiieJCwoGAZdSE+s0kBgkxKr5+aex67/KpycMh7gGxUkG9hKqPTqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(41320700004)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9F2ei6EZMFVHw+ua5H5UE/7/bDnqIf8O5ckR3NAAUGpeF66JPdjJYClxl+Ri?=
 =?us-ascii?Q?LbjrHrmvZGv/e7VRm+28WxnxI/cb+2K+KnndNLh1nJfGGAzLASr2zw/pYZLt?=
 =?us-ascii?Q?ktftbDIbnEalzGBpWQ2p9Iaqpv4PnsGXBVr5IzfPb3dlQ5j2RUcq1KMAyKqW?=
 =?us-ascii?Q?W2AfBc75fOn80F/RuFwQLVFKgDTI7Fx64ODQb5u1m/MAlqP+JgtMKg/4H8ic?=
 =?us-ascii?Q?Jl/sRajSjh5JwOuT5ch4yY3k2FJ+86uGbK7OB7qLZ821YjB1gNvXgswsQSoQ?=
 =?us-ascii?Q?pV8aP7D7IpR4EPhj8qLyGulNOPzrX3A7h7Zcy7OnSfnTxcOffbVInTv/bH7a?=
 =?us-ascii?Q?gnkcNyZSyq8ENET3J1oDl11UA8f/Oz7DAn2y00pJurn0+hS+n6S4Q6HNK35F?=
 =?us-ascii?Q?GxGzlcZeBZObwW5gYe/i8TCEeIDF91nNEpJ5XaP3YVfXMIWGZvgGQuvGIYk0?=
 =?us-ascii?Q?FmEe3soWctiMIoKhg8iUf2CqqHuV7Ty/sflwZa8tfHSv4SqijxrvzuXCvcbB?=
 =?us-ascii?Q?rEqj7BXIxYTkTYsCDmb6pVpvbanIlvgDeNtSk5F02BTBigrytd4domQeJTkK?=
 =?us-ascii?Q?rZqm4Nq4lqX1nPDqabSDmNweezX3VS7Zr4gRqokqheuJrsVmVzRsswn2PcYe?=
 =?us-ascii?Q?T1RkMXfFp91klUEMKg1WwSYW86DYL//SJ8XUcib0juKszL1yQ08r5GJ2WvrI?=
 =?us-ascii?Q?USa+fePMIqkk/xXSUY5up4fhwt6Nc4UT+pPyapxr6yrAgWNu1lhUifUK2QTc?=
 =?us-ascii?Q?ileWAk26xH2oyGdVqyVCfdhvXIx1vNYTcAMwJGjTAf2dWHQVxqmrZu0hNmCG?=
 =?us-ascii?Q?bN8BpAcjYQepuhNf8VTjsZkRSEtXa1u1J5eauSWdPPHoDvhrRCwP2LD1o+Oa?=
 =?us-ascii?Q?GkWW8GizRAUR+VQVlUNHeQ8hDfXkuepzHSEsuEECaXcn/JvUI6vpjQjMCwyZ?=
 =?us-ascii?Q?2q4IDuYCfcXdClyZ/QZ7AVYW7nj6lbjbtS3UeD0rDuWMTxrveAnzjoJs0/ny?=
 =?us-ascii?Q?N/xMHc+N3Rz74zKpDx7ZCNQIrT6o85BwJTdXrVGkIoYLxrHeVxoJ9Ra4pAjC?=
 =?us-ascii?Q?k9RnlmVWiJuwEOk98TRqqfv+gJ7IB9hQPyzWYBv+A1Jdr/doFeN7qloNzHxz?=
 =?us-ascii?Q?YAt0MISUbBOfqbkcjArsz7yJWWFQdY3BbUHZFtSMR03DcvPzpQX5JR3tj8I4?=
 =?us-ascii?Q?TiKmsomR9Ui+FkJpgWNgqBq3NlEtpwvkw5NdUPIrCXTS3eKTbEatx7/l2kN0?=
 =?us-ascii?Q?wYceSCDsqHf5HjQLuoFu0YUCTVnhdWN2Iu27UfZge3DNRHR0FGmPRiSUKSuV?=
 =?us-ascii?Q?/vAohFek3GF8/a2QZ3+ydmflQ/ZFuQyb3PKAgziB0d13SOlkVLgSKqjOLDoP?=
 =?us-ascii?Q?jZEoTU1W1eWUBhBmNC8uM+9bepNksaxFQl30hcPA4fYnL+lAXMar4iAC5ozN?=
 =?us-ascii?Q?h53u21o6gonCQNOI3LKZFgtpPxFGUpY/VTqnIilNzn5EOwTHoldO94fq0LFx?=
 =?us-ascii?Q?s+gP6HrH1+hgQ87Gyz9Je1wknkq95430f2o3FTPd4HHb0x6VDG5EjOR8zP1V?=
 =?us-ascii?Q?9Sf66kZbDUBwHlLSu+rUlWjyrta+lSyD/i0SFlKqAIyxATnzzglzYl0CMu/r?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd3e76f-a136-489a-73e4-08dc5fd2ea6f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3905.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:11:06.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL+aguugjLBDPaUN7PPrOJCkOu9dlV6GBQRi7TzPBL3bJuMrL48lE4t6py7IV5DTO7LNi1acRc4W/G+2pQMn8fHI7Wf5RQzKNLqixdVdTEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes and adds a new
full speed mode available on these laptops.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Changelog:
- V1
  - Fixes grammar in description
  - reorders macros
  - adds throttle_thermal_policy_max_mode() helper function

 drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 51 insertions(+), 42 deletions(-)

-- 
2.44.0


