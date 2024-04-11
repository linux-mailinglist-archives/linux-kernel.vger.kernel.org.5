Return-Path: <linux-kernel+bounces-141586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F4F8A2057
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE67F1F23D74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC741C294;
	Thu, 11 Apr 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SCw8Sxxf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7D29417;
	Thu, 11 Apr 2024 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868191; cv=fail; b=O9XNr8NkUyZ8xDbdzL/usyIcgLaXuKQKykp8sobe5GfXQdrtP4Yi7RfctgVjqhamzwxh+jGWwi4+/JslvAf2Ck4LdZKgPS41LH/sCEpwnMgLUU9GRbES93d5TyOzhVpDc66Ef6bA99F5ir/4dQqu984phrESXeWMFjSKVQWkdmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868191; c=relaxed/simple;
	bh=bq9HpBRDKgCeVjsE8DolkUDAGqHxF2vkw9Jh9Ssgr3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uYx6iTKYJIkvukTpgIwjU/DmiftcBZVYKy5XUO1eQHLRXNz2E5cayaHr3WAvFIGP4HqXcJRpp3BVQDNViz25ipHgo+8roUUQHw0LEqVHA8LvEm91H2oVHXInWf654lrvrtWqlhf6o1tT9SY0pm8xlXdlMJU9Bmr9eHYBkzizCSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SCw8Sxxf; arc=fail smtp.client-ip=40.107.223.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O++laC58LqlWz8dDYT0uZZVmpnckGIzvfhmeXLTyGiOvu4NwpcnoC4YB+TCOU1AknCHtvYjL8b8/nPNWINjuBeB+lxm2dB1Ea9dM5+QMigvMBzIw6ej/KhDxVDeuxLbegP60s6U6/0Dd+RcVFL4PCbnzUdQFUVx96SuR/eQa1JrIOazQn8poj3kjUGPttYcKk3Go0TF1xqMEx+std06ph1ymD0N7jXvqtVUSseb9/JmAdoPScXJ83ybtgl/wn2yqk3DRdODOL1egJTjgm633En0ee1Irdz5AXJ3mEQ68hrOSxBG8rP5u++S8gnlsClmQjxgOj/cg8R5mQ1u5aw/7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu/U8mgHOB1X5ysL7bno5l1IGovpIqwJprPPgbrXaX8=;
 b=RqOki41+FuwjQtcK7XVs7/GEWvEn8EwVU5EGo/9IqwhuPLoleeL+LAgvP6a627ztwMShZmMJ1UkO5Qg+ZLkIh7OA0rN+ciwKeYP7ZEE5/7qOsO3zGO7btudsh+64FqjBc/Oz01AQ1ZlQiI1Komx5mBAq3UcgzZmOdyCGr/q3LkbhhTGef3BWG9t+yRXaRAvThzw8oOhb+dBIqnXdZzWRcjUwI89uZQk+/+eagqJ0ZLaiAfpHEnrePQr/dQVWhWzprgoUzWvKdjACoXSGXkYE/5sje5sMxS3nzanNKaRCeq6s+XJufPxxssJ2bVq0wLj6yVAiJCHodP0S6w2CxmlrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu/U8mgHOB1X5ysL7bno5l1IGovpIqwJprPPgbrXaX8=;
 b=SCw8Sxxf+Tz4Tu3EmzCMuL0mvIfuWBK2oe/n7G5MkMZV1Hq0jrIiWQVX4hS0QVbkf12WiCjbkOBrfKzq2X4rYFFyeDnlbL1DPFS0gAC9szUosualNo4hoH67u6bMZNfW3PH3I3qJjaL3/kG7ACEJajqsg2p5TRkXfHSrcJj2jBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 SJ0PR01MB7447.prod.exchangelabs.com (2603:10b6:a03:3dc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.54; Thu, 11 Apr 2024 20:43:04 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 20:43:04 +0000
Message-ID: <4296a669-ee88-4f6c-aaa2-4416cad5c323@os.amperecomputing.com>
Date: Thu, 11 Apr 2024 13:43:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Adds additional information to ARM RAS errors
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, Shengwei Luo <luoshengwei@huawei.com>,
 Jason Tian <jason@os.amperecomputing.com>
References: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:610:57::29) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|SJ0PR01MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 74dc7824-b9a1-41eb-7dbe-08dc5a67fc6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U285OdvLfZPSvrMcJQrExSxgBB+YzIzs48/dw61ok+AmrYe3Tdf4hybnj39Djyk5+LFNB9C10KPM91DbYwaezuSzkTr3Fkm9PXhwodCKq8iwaTMXNl/fI+WJxgXNaw8PdFt6AqRvJ4mmdw180GWK4mmVqLwmKNl5bgMA0FmBNTTtfil5cWfgNelbNy1wQe/zEAh8lMWaXIOD+VRNrEjbGw3XZsOSV2zrFVte65LH5dB+QdJSrjDqRS8XAZUvC1IEi764V47PwouAhuJfJKYkCtbGt1/5HY+NUEYzmb6/8I3FxP0QaVkNFOxIFj2ckCxKWb2zGWsMqo/mBqtKEJjQVHaUfvtG/8C/6t2uY7I6pOE+KkSpdqMjO5Nc7RzaoTl5+tlY/BOqO+JPOL+YwOgVfCEx7SghM1lTCVsi+i0hAPmzeYHbTnD3YpILu+WViVC4OfqJsdk+pD3WAJMkZ0YEL8cexTA/TmbA95BRJ4KhcVjXbL6CPCMUjskVsUJDtsJUiZxmY4+49KNcrGRDZnZOaHZM+pyqSuHC3x32cxdaj3hA7aAu+9mcwxYMQjC1J0v0BYSCE83BPLRXzUr8EgYSILq3/2huoTUoJi64I2by9yi1j1d9xJC09TGzlxuYsji41zg9W+B5kEIOXdRe3v6ctZRjbtWz+YeVhLBu6Jbm/zkko1jBDB93I8rmqIYm+9pJvKmcqW5XecvPh1xiOrEVc+mwAuXps/XQyeoOVB76JLo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkFrZ2s0OWJaTjIvR0xWdU9OUHhuV3hsclFOTk1SMzc3K2pWUXFDRGxBZW9N?=
 =?utf-8?B?bVdlUWZYOVlXSnB2RndRbDJHcU5ydmViM2RZUmRLR1VnSFJzVlFKYmpwSEhq?=
 =?utf-8?B?MmZiK0twVVp5T3VCTVpFMklMYWx6ZWw3aGRCc0pheFhvcnBzSWxqUWZhTUZl?=
 =?utf-8?B?K1BOaTYxRDlxWnZtdldvMTFHNmhwbXJJS05US2ZuZEtPNGMwT0xYbVdiVEgz?=
 =?utf-8?B?eUJCc3BEeDI4UG5zSHlrSkE5R3pHTEdlZWw0bE5PWUZ3WlZEeEkzK0o4MlZU?=
 =?utf-8?B?UGJCSHJNRDFFdTlaWnJ2eXJvbExIRGhiNEsxOUxWbUkreHJNWHdPRXB6Ujlv?=
 =?utf-8?B?RmVLVm9aUnc1VWFpaE9pUVlyUWZtMENyOEQwV3RhTTY0dFhTSGZaVVZTQ3ZD?=
 =?utf-8?B?dkdnVGJKVXZITWFiVmtwS2wyTHo5RXpkaGV0U0p6RG9OZDV6WWZveFZuUVBw?=
 =?utf-8?B?elZhd01NazQyNm96NWxYdWRLTXJJZ0NvdnVYeFFCWDNINDJlM2J2c2VWRk4y?=
 =?utf-8?B?RHVjZTljZlgxSmlXZVBaVm1PTkdnNkkzaDMyOEkvU0M4d0g3ZUtOc28xUjdM?=
 =?utf-8?B?UFFuWXc3T1dTaTFxNm4rTGUzejhmWFRCVEtCZkg1NklBeTdkKzJLcHZ1MW1F?=
 =?utf-8?B?MGt5TXVEUzVxaHo3azVTSzdLV25Dd2djTlJKUG1HZXl6SHBLL3oxU3N1N25I?=
 =?utf-8?B?VkxPc09wOXVqdVpsYzJ2STg0S0FvQkE4NUQ3eTIwRytBN2p0Unl4Z04rZzJu?=
 =?utf-8?B?bzRkZDNlNFVKNzBxa2VtMHFIWFE0OThpTXZvanNPVWRJeHdGVlk2UGFNZmsx?=
 =?utf-8?B?K0hpeTJtYkYyUXBvdzVRaHdUc3R3aHlPTit1UmVkc1h3YklSS21hNzEwV200?=
 =?utf-8?B?WStoWDMyVTB1RnlVYkpFUCtiNjZaM25tTTl1UlMzeHkwS2VMdDJiSS9HdUxT?=
 =?utf-8?B?RlAvVXZoM1gxYmJjZkdZUTNnQXoxUERtMER5U3RvQjIrV0NoVWpTNEZqVk5s?=
 =?utf-8?B?WUN2Yzl1Yjl2MHFCcE5xbFNzM0dMelBJNEd3K1RaWXI5cW5xeXF0KzhxNlNO?=
 =?utf-8?B?UlR2WUloUkwrUnJxU0czTStOaU1Rb21GMFpPY3gxb05yU08zNTloUDZ2MDkx?=
 =?utf-8?B?c3ZwSFp1Wkp0MlYvYk0zM3ErMURXZUdjaFdCdjBkOFh1S3BBY3pTNElOdTBi?=
 =?utf-8?B?d1FUTkNmSXA3WnV5dTI3QlhKTmMva1pJLytwNDBBZG9Bd0xCVXZGSi9Bd2w4?=
 =?utf-8?B?elVBNkFJNnFqcEQ1akdFdU1IS0xtYis3UTBTblZ3NkJpUmwyN2o0U1NjTkdw?=
 =?utf-8?B?em50SGRCcGtKR21abHRiRXdGK1crbzNuckdveE9tZnNrV01sWk1yUWFMaDgz?=
 =?utf-8?B?ZnBRSGM4djUzV2lNVllWVEdEKzFIRHU1Y1NhNkFycmRZRW5udmxGaVBkVC9V?=
 =?utf-8?B?dXRhM0RjcGp5OUJ0UEJSYm1YWXVrL2oxZk5nS0VCakhXMXRGOGo0OVJ4SlYw?=
 =?utf-8?B?WWRLa1p1ZHBDb2haSkRFdzU1QVhMSHVCNEg3aEhvRCtqeHZYVGtUQmlid0VD?=
 =?utf-8?B?NjJQMEswYmd6enlpOWIxV0JDcjdBdVFXbm9oQjhmeGluNFR4QjA0Zlo0aXNq?=
 =?utf-8?B?QnVKcTIxS3lYQk9oTlZTREpoWEJTenozMGlWRTQybDF3eWJwUEJQY2w4aklB?=
 =?utf-8?B?NGtsejFvbmF0QjRWYVZvaXp1cVlHRmR5dHBVZFlkWk5ZUEwrSW9sUnhPWER2?=
 =?utf-8?B?VHgzVmlVVWxwTWNVUzYvd1Rocm0xYVVlakp5emZ6cTduSGVFKzNUY01SRitO?=
 =?utf-8?B?WGlSaGUzaVdaYW40NWdqUTlvb1d0cHEyWXQ4MHRlU29JTTNrVVBRRVd2WkRC?=
 =?utf-8?B?bml3K2ZhL3NucVlGVlNGZFZjSXV2Q3hYVEFZWm1aejhaODlwNnhUbDU3WjRY?=
 =?utf-8?B?bEN6UFB2azZLdWRXc0xWcjF6M3VNZmNtQ3F1Nmp4ZytxN3FUbjRSTTl1aGhC?=
 =?utf-8?B?SnZ0KzdldWI4bHpvZGJhS3VGREMrR3FRYVFNMFVHbXQ4bFBDNncvdVYzM2kx?=
 =?utf-8?B?MUdmRFNkZEFRR25EN0ZsZXRWcUVDdS92ZmN3OUF5dnNNenJ5MENHTHhzT2ht?=
 =?utf-8?B?OGdydG5HZEdaM3laS3dWVTRreHRmNFNjSys2VWxyRmN4K2t6OFBDRllZUWJ3?=
 =?utf-8?Q?eZ60gtLe0EEP73bBsMt4mMM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dc7824-b9a1-41eb-7dbe-08dc5a67fc6d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 20:43:04.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSCzO5PX+M0tNQL4OedLqFp9WWVMeRWldzhuGPW6aQCx+O5JCuU7oysqPjyxen7pdt4n3pvrmDjx+pBv6F71mYwFhYoAOr0VJkpLjS0iwIK4tBrW+hVmw5PGqRvWBQFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7447


On 3/21/2024 3:55 PM, Daniel Ferguson wrote:
> The patch by Shengwei includes most of the justification for this series
> in the commit message. The only thing i've done is add a few conditional compilation
> directives based on feedback from a previous submission attempt. This series adds:
> 
> 	1) Conditional compilation directives around ARM specific RAS error
>          handling routines, so non-ARM platforms are not unnecessarily bloated.
>       2) ARM Processor error section (As defined by UEFI 2.9 N2.4) to tracepoints for userspace
>          consumption. This particular patch is a RESEND.
> 
> Originally:
> 	I did a RESEND of Shengwei's V3. I didn't make
>       changes, and I didn't rev.
> 	The original patch: https://lore.kernel.org/lkml/20220214030813.135766-1-lostway@zju.edu.cn/
> Changes since v3:
>       Added conditional compilation directives
> 	previous submission(RESEND): https://lore.kernel.org/lkml/20231214232330.306526-1-danielf@os.amperecomputing.com/
> Changes since v4:
>       Rebased on latest linux master.
> 	No functional changes.
> 	previous submission: https://lore.kernel.org/linux-kernel/20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-0-08e0f168fec1@os.amperecomputing.com/
> 

Hi Tony,
Thank you for your original comments several months ago for my v3
resend. I'm hoping I can get you to take another peek at this.

Daniel

