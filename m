Return-Path: <linux-kernel+bounces-156449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A486D8B02E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90C81C22156
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C11581EC;
	Wed, 24 Apr 2024 07:12:59 +0000 (UTC)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2131.outbound.protection.outlook.com [40.107.122.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD61426F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942779; cv=fail; b=Us7SBjH3MewkXgFjiJEDgb9dtUY32ggPjxhjvHKJ7OU+jZU/pLkHlqT1Ve4kBnAlgyLtwOY8kVv1t3GaeBS2MkmOm1fdh7JP3UhiCoEbDoJm4Il6uKor9vI1w3r2Qjd5hnh5vPxmxIZJ+Jzobxdw/vwmhZ70V6+7c5wnXS+cv5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942779; c=relaxed/simple;
	bh=wZfij+mdSbLQEq564Emz9/SRUgAMK1e6OItXT8d9MEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XaRu+UgPqxOzAhny2TqjeNcRW7HaEZYYz+8MFrqqpf3HADMLyWH2alyj+9IRDQE28ZrSS4zWFIQ69/MdrKE47VUDDPaoXeYgij5iEj2q9qRSz2fORSJxEq1ptcEiw+8Ubj+eafbS4oWFL20qFxJvd5AYyQ4iXuijvaQAmKvfFXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.122.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPWOWdsE05IubPivSh1i4HwAEWkJYCsCuNo+YMz5R7oTMZfXVY7c8VkFYjADVpMBuWSbSfsFVYgSrP6ZLWXIM32nNiMB4Md7IkBngX36UtOvjoFvqba+PdVwvlhtVW8UgrBaFNI8YZVewinUnKBEqRhS3BVBB9g2bG3BVqSutWe2Q1ZJ/K1hxJLDEzIqi4S41ncM+sQmFbA/GHXcuMQR8MRV/8L0XRfpdDM6GlFjeKab6lmwO9ZiyjOrhGxg+msoJj8ZmYbRhRKWZHCpC4y+slMKy7v95YAfKvLSEKw8h37d+2ZA8faEWEmIJU71+X0SldoVPS3KbEm5OMDpIyhLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WloM/fuVaXDvtOv2uZpx7usHRDE6jb/841dVlySl1Ds=;
 b=XCFv6EnDEC/Skdz3arBLO79cZ5OPUgPcrlvTh8V+edXPhUKRIUCyiuNGm4XfTTiIa7lAXQGzpRZ+YUgCFDy9ROUZqHABkhkhPY7i1TswGVgQIgPlWnnkXOX1t31qXiwgandJDQ3r62UWa7V85wxn8f6Z6Ar1ywHAsRjgRf74ZdzpPO2zVX31t6wVxFtj1gLM/xTkRqGVBv6kOBs/II4zcEJbm/iIG11NxGWBH47ZrIYytLnA55HwCKyrHfQfcWhUq0wDrPfVTzsWNS3nFscnELkdNHyZKRzBvLohVgBUikCXDegBc35i+fuqPuOKOh6RuyAYuCrckpNjGhfommOUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7831.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:12:45 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e8c0:ec4c:4694:dfd6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e8c0:ec4c:4694:dfd6%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:12:45 +0000
Date: Wed, 24 Apr 2024 08:12:40 +0100
From: Aaron Tomlin <atomlin@atomlin.com>
To: Wenchao Hao <haowenchao2@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao22@gmail.com>, neelx@redhat.com
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
Message-ID: <5s3id43tqtwywggry7zmefl3jsaim3oxgofuhkeq3kmadtxpoz@srrrlrf5si5n>
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
 <00b43845-c990-481f-be0a-4bf15ada8b3c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00b43845-c990-481f-be0a-4bf15ada8b3c@huawei.com>
X-ClientProxiedBy: LO2P265CA0418.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a842716-6103-47dd-1a9e-08dc642df0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWZJZ1VpdFVSSXNCaytCcTlVTklYeU9TUm9GRkRqdDVoNVhoeVkyQ0ZRTkpO?=
 =?utf-8?B?L1V3MXRSaXBkZG1xeHBHK2UyV00wU3o0bldQOVdRR3ZuLzlPQkRab21IeVJH?=
 =?utf-8?B?VnJRc1JlK29OSk1YaDgrRFROcU1SblNoU01vY1VUTWF5ZnZXUkJHSmxPbkRW?=
 =?utf-8?B?eG51WHlFRkV2SUlqUFF5WXNERHl1bHBXS2F0ak9ZeUdDNzVJd2FqZld3d2o5?=
 =?utf-8?B?Ym11V3R0SjJKSlRWUitFcVNQYWFnQVgrSHY5ZmlSWUJNMnYzYmthemJLb3Bx?=
 =?utf-8?B?blhVYTd4NXI1Y1BjS3Fnc1Y4M1l3cTkvMjJrS2N2eHUyd2F2TmhRdmZqS21B?=
 =?utf-8?B?U005TDdnTkNOWWd2eXpFelpQdzIrWDJScTVodytDY2VGcHd0QXhzV1JyeXlt?=
 =?utf-8?B?MnQxRmNiMEhlUjhBNjRxL3lTbW9hNWs3enMwU1JXa1lyZ2NwOFJDcWlqVkdn?=
 =?utf-8?B?WjNPTkt0NUZ2UzA2aEQ4YWhBYUlFbUtTcDlxd0VOQzlhZFpqSzg4aXB4N3Ri?=
 =?utf-8?B?bTVVMm0vbHlXbXFJMnltVUxCMjhDQVY0YTd6MVEyZktKTkRqNVF2SEg0N3Zt?=
 =?utf-8?B?ZWxFK05KZTB5RTJaWTR3V0hQUHhsV3lFM1hZRS9tbDhmcTZXcG0yUUxZcTNK?=
 =?utf-8?B?ZmdqQjBpUk1yVGlsQ0NPYXd1bjRWazVLSFhhUFc5czBGR1R1UEovYWhKemVV?=
 =?utf-8?B?RG44STNRaUQ1L01taGVubFBGbmVnSkZncXU2U0Myb0hUeGRwK0dzUmQ0bWdL?=
 =?utf-8?B?VE9mZW9Dc25IUTJiOE9tbDZ0OWdvbGw2ZG9xWHRPcGllbzFyRjJDQWtGaGkz?=
 =?utf-8?B?QnhxK29FaC9GRkpOa01BWVRCaUg5MGZWUTE1UkUvVkkzcDVOa2VhdHRPZ2JB?=
 =?utf-8?B?MkRVT1kxQnAwWnNZcUw2dWtVQ1pHSHBJRjc0RWJuSG9nLzlYK1kwWG9aajBK?=
 =?utf-8?B?L0NVYzlDZ1JZcWtCQjVYeWNqSVBLckxCTTgrOTNySUFMM3BpNVhKUU9HQWp3?=
 =?utf-8?B?L01ZQkJoSW03SGtDVDZyTEhKeVErU3h2dlVrZ3p6bmVERGFvVzVPMUxYaHlG?=
 =?utf-8?B?SmJnVXJYVFhwZjA3YWR4RWVmZVZibGNRSTZYQ0ZoTnlhWkJOSVZySFVILy8v?=
 =?utf-8?B?UTdFbE1YVnhjY2xKS0kwMi8wZWs1azlqbjl0c0EyTnBxVFlmbnE2c3dNZWJH?=
 =?utf-8?B?ZW1nQ1ArbGVld0RQbCtyWWpoWDNpdk1KTmpCaWE3NWE3S29ocE9uaC9FRU10?=
 =?utf-8?B?SGhYK2R0SmtQYzdBbzRobXc3RVg1Yy9YK0JybFNRcWRocmpndDNXTWZyTGRE?=
 =?utf-8?B?QkQxQVArUi9MZzg3K1dkeDFYd3NzM1VCcHZtbE1yZFVFTDlhSm5mNGVrb0xX?=
 =?utf-8?B?NWZTRUdpbHJjQ2pCMGpmY0QxMFZjaHUvcWRPYlp3dGdWd1FHSk5GMmdmRC9k?=
 =?utf-8?B?cVk2YzVPMS84cjJjSlZmWE8zNEdaUkZpbDNiVXpVc3hvVGNCQWJRUHlOMDMr?=
 =?utf-8?B?U3E1UzFHL2NzaURNUzdsWHM4MitNZ29MT05mR2dkN3c2cXFvcXlJRm9BTWRM?=
 =?utf-8?B?dE8zTkRmU1ZPM2Q0VmlWK2Y2eUpOSDNnMzl1dkYwL21aYnBDYUFtQUJTT3Iv?=
 =?utf-8?B?dUF4cmx4WG4rQVk0VXZ5S1pQZjBFMEpjc2JDSGJFdkVxN1hnclZGOGxtSXd6?=
 =?utf-8?B?WjJjWTNSaHNLTEI4UHRLSzJIVWMrUHVjd0p3UzlmRzYxMy9KazRoZ0ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1k0bG1JZWZXWW9nR2VJNlhFNVVZYytOWGFJTXl3SUZLVEdOZFVZRjNzR2lq?=
 =?utf-8?B?S2daMGVYRnIyMmJabk5zTFByQ1ZWVXRkTlpycENlbHovWGdKRkdsTFV3dHhQ?=
 =?utf-8?B?UXdjVjNyUis5Qmt0RkdjMlJadUZKK3ZrRUliU0ZaeFNzMXY3QnVNOENIT09n?=
 =?utf-8?B?V1RJMU1BOExGbVUwWmZNaTV1R0FHd0JjV0piQVpQUEd4SnltNEx3aTd1dHZR?=
 =?utf-8?B?YWttNktlUEtDQUlyNFpLRzZCbDcxOFR1VXlNa1lMS0pxOGlhSjIzNklxYVRr?=
 =?utf-8?B?MzUyZlh2emZ1MTUvQ1BXbG9TZklmRzhSN1A4Ny9PT2JQM0NzNE9hMGNOR2Ni?=
 =?utf-8?B?MWk2ZHlEeThGRmRIanpNOUJ6Q0ZkenhzZ3FXdWlQTkg4b3NjZ1RhVkhPbGY2?=
 =?utf-8?B?ZEEwM2dlb2ZNR2pVL3Fha09vdGVrNU92TjZkSjM0ZlFGNzNXdzFXTUN0RHhV?=
 =?utf-8?B?N0V6RkE1MTM3QW4rdVpDbC9uTnI0QytJbXIwd1pJZmpUclRWNVVDTE9GdGhV?=
 =?utf-8?B?NE5BSFNBRnhsdXZ4bzBFU1l4ZVV3bXJGZVE2MVJqdnZzaXVWUUIzRGQ0YjVq?=
 =?utf-8?B?a0k3emhPVFdmS0JtZ2J0eXozMTlKVFY1K2wzaTFkVHlyZUdHMlBFQ1lzaHJI?=
 =?utf-8?B?TkJkR0x3dFNOOVhMNmQ1Y09BaGE0Y25RWGJOYXFabU1Qa3ROWGVoVUJCbVFN?=
 =?utf-8?B?bkxaeEMvZ0tsOFdZSGhGQlNiRmVRMlVaSDFPeTRxK214RTdvcGJ0NmhuaURS?=
 =?utf-8?B?R3pJZlh1QXF1VGNmOUpXdldCemg3TUt2SXd1VHlCUnFCVnhSV0lBK05hTEJj?=
 =?utf-8?B?TTkweEdTVmVDSEpkMEMvUlVLcU9OUW5tSzRVWlh5VGovYk1KOUI0SlRUTmhO?=
 =?utf-8?B?VDFhM0pMbWtsbGI5M2JxTnYyaUp2Y2x5QTViSUJlVjAwOGhJWUlqRWlmbkM5?=
 =?utf-8?B?QmlFYVl5MWZuWnRBamZEUVJHTEk5TnQzcHZzWElNeGFjK3NlWmhSb0V5WDRl?=
 =?utf-8?B?QVZHSVQ3dURsRDlHR1lWSyt3S004UlJ0YmVBL2FuZkY1aktxT2l4TjlaV2ZT?=
 =?utf-8?B?STJMNXN3MmhxaGwxTjU2SWg3L0R6a01ZelVnSmpDV0wzMU56Z2NsTGx0OFhr?=
 =?utf-8?B?QUtyU256eW5lVUhvcGdMUWpXSnE5S3UrSFBpdXdFZ1BkVFA0S1BRMzFJNzFQ?=
 =?utf-8?B?Qm1qRU9ReEwwQWJacDBGWndGUGhMbGNhKy9hUVR4RXhNZmpHVnNuditvT1JK?=
 =?utf-8?B?dEJGR2FxMUE1MndjVXlXL0NKbmpKc2p1R0IxMlZZa25TRWNPdndPMFRCT1Jt?=
 =?utf-8?B?RTFEeEdNdVpYbi81K09hSDhSczYxN3JJNGtySkFVWGc1bHRjR0lRL1Q2K0Zw?=
 =?utf-8?B?cVc1QVNkdWU1Sy93bmtZWGZFYTQxckVqRXd3NnpsUncxOVBud0xGVTQrNXFX?=
 =?utf-8?B?R05ja2o0L1EwOWM4RUFXQmdza3pIVHFrOGFCOXJBUElwQmNkLzhqemZnOE5B?=
 =?utf-8?B?WXV6OUZ2c1FZRkxMSk5mQjEvNzJwU3JINnd5dmdxYlFPWGNsdHFoVmVya3dM?=
 =?utf-8?B?cmx6NmNxbWRyY25lWTdlYlNYYytZalE2ZnI0UGtSVmVkb3NPQURsY1lxUVcv?=
 =?utf-8?B?Z2JkaFE5YnFpbG5UTitmT0hFNkFodU1pZTFzU2hzSTlCMWxIRTVFOUZZRDhD?=
 =?utf-8?B?YmVZdVI3dE8zdHlyRythYU4zMkt2OSt0SXFJajBzSkZOSkNCTGJOVFY0T2NP?=
 =?utf-8?B?UkRIaVFoUEN4ZEdHeWVabGRJZXNpT0VkcVF1ZjFqM2g3QTcrSFUzQlFoQTZB?=
 =?utf-8?B?SGEwdXN3OXdTRElRQWJQbWdibTNCd1NaY3ZqZUZ5NTZ2OHdGUmFqd2N4eStG?=
 =?utf-8?B?UmNUMWczb2diZ09KdWorazIzbmdtOU52Yjd5d2ZUZnRwRUtIRlFaKzlPVy9o?=
 =?utf-8?B?OXAwdm95MStVK2JiTkVCeGJ2VGk5VytNZmxCQU5PRmo4a2FzNXZ3cEJsMnJM?=
 =?utf-8?B?MGpvYzltNzJEcEVmUWNsei9hVUVxdUhFZVlnNHdSS0JaNWFaSFFHa1hVR0lS?=
 =?utf-8?B?VUZ6c292QUJLZ01OWjhWMTNycTBGbWVzbG9PeG9uakg4RUU5SHpDb2F1NlpX?=
 =?utf-8?Q?ZbyZktX/QiyCC0fnEN3Ng35Xl?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a842716-6103-47dd-1a9e-08dc642df0a5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:12:45.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euRTosXiUTndtw8Il1f0ZWWDuZVYX2OEQYOJWa3VUPRDThKjKeLMVdxGFQt6rwemrr5FS4l7M4d4PhutU5IjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7831

On Tue, Apr 23, 2024 at 12:55:22PM +0800, Wenchao Hao wrote:
> Hi Tejun and all:
> 
> I added another logic in wq_worker_comm() to append worker's desc when
> worker is not attached to a work pool. I don't know why the origin
> logic only append worker's desc when worker is attached to a work pool,
> so I am not sure if it's safe to using worker here directly.

Hi Wenchao,

A worker description is always updated under the per-pool workqueue lock.
You can indeed use the rescuer's own description to store its associated
workqueue name - good idea. We know the caller of set_worker_desc() will
never touch a rescuer. For this unique rescuer case, if I understand
correctly, you can read a rescuer's description outside the per-pool
workqueue lock; albeit, you need to prevent a race with destroy_workqueue()
to avoid a use-after-free.


Kind regards,

-- 
Aaron Tomlin

