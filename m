Return-Path: <linux-kernel+bounces-90997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD89870831
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019331F21AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895A3604A0;
	Mon,  4 Mar 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YhT38R9x"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FF1756D;
	Mon,  4 Mar 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572928; cv=fail; b=Cfl7MPfBh69/qgH4l8TSVGUHwu+9iYmTFPOVz1keJ9Ce0R/23sMIiQRP5hQxNdizcalL6MIozTKZRVWHoJlBDy1MvIdM+469Qf0JekL4VIUxeWhTK533aXJ8dtvKCP/WBmWtmdai4oj8sNwJm49/is+ZhjHv3uoDmLmCF6/pG44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572928; c=relaxed/simple;
	bh=1OEUM+i+R1NUN+e4vmVAFjL0rUsOSCJy5ORPtFlX60Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DFOPUoMSpQzdmxH/VAJbpKneSaO8/YfMZh8sm6K4j6Od2EME7442SDYsCwghDpU/75857wSelhUEs+dehW7NtGQYZK6JZsG+0gt56exw/4Ik8tGLIefIvr5JgIHOXeUvNGk3llVFW7N2UU5xGN8NpFqPgcS49YG7ehYGW5Shdnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YhT38R9x; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogm1E8laZbsWRAPt6l5RkLwXkWoeJBF2vD7ZWhT4DbivyTvTuc4CGR2xq4bxexz1FGPjQNgFupbJzl5n9UaimptUxICuKxORrgnIq3arVsYJpHWkX0KbgZaca/kozjScAOeOdAUBUiFIVJSw2LvXtNDa7vvulYm30zyNAugzOaWw0Bx3Xi5/6oxrqoxM2SC3vRw6HDrSJ8kXjHh3pu0vbKSJq8dCxARjaHRDnfpMcLmRPNBgxA7hkpXHMOcxnJ039BPpf88rJ2jaPzl9m4Zeh0XPSw+PHQkEkE+lYjA25DusZJmVUBk6FlHe8ElUJzu2mCag+xfLQeunS2fePUkb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3INIxAPjnhLOmO91H8vh+pph+fu6Z5uClp62BvY5VBE=;
 b=jorTTbEvm/61m6b6XGXXvuQH5RnJaIB0tgwYJgKLOdUgjNc0fDmotU4obs1lKGA9GgcWWq03MHz7fevxXUGOE4QodBPKYT6BNUPNUHLNDoJYzEbYzxTArJLIOFdDwrrcSGseA00G3uerhAWafEkzgx6UN40J04ubhb4SPeDNd5j//sDaoaH8jmZRpK8Fqi7qaeL4XN67/JQTM49e8NdxcA5JX6HtTx5rhBWjZulr9TaGkbKIi83SB84KJxHtVpzsAxTLZNqrrEbcPC3MkZe+a6FMnUb1GfAjZK2xg3m+y7iqlIhhwYPBJdyG5+emA9V8RMrAZZVE4oDbXeQk21/jtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3INIxAPjnhLOmO91H8vh+pph+fu6Z5uClp62BvY5VBE=;
 b=YhT38R9xucBmBJkXbXI85ZnMCMKcX3sFD+1RIGpJSSZpzbgucHPzwd5+gIpwQHlsSIKrfheVpmJUF8O8f8rQfmUOhk+bmOnFMPjL2d+9tDJBxad5+Q/kzwpCy0oEI/r04Hkkdh7HyYH7K8ywp+CaboqMJrm2/m6V94eya2QHnNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 17:21:59 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 17:21:59 +0000
Message-ID: <8ebecb51-3806-49bd-9319-66087fe9336a@amd.com>
Date: Mon, 4 Mar 2024 09:21:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] net: pds_core: Fix possible double free in error
 handling path
To: hyper <hyperlyzcs@gmail.com>, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jitxie@tencent.com,
 huntazhang@tencent.com
References: <333dca5e-fae7-4684-afa8-10b8fdd48bf6@amd.com>
 <20240303084954.14498-1-hyperlyzcs@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240303084954.14498-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: fc349b89-46bc-46e4-e5d4-08dc3c6f992a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	reqs2QeuDWtl6tRwFQrHHZ1UWGnNd5/PalB+zodRdgN7j797iXWziAX3OCboHDuJuQxU2KExr/pKbCatTqYSD+Zt34KgaOwe9NDHDPOUcjzxtaQqwraT1SH+E4x9SAjjhHH5LYZ/OaqEP3ndbX9A7eHOiNCWQvp+iy/kGi5Y1WZRZkkWKCprJMZW3UVatJlQ+2sAkTKE1KG2X5L/6/O+STxLxUw6vFjAEGH2/r3sc5Af5rcRY2bf2pAVyXB+v4HzTnr4AVJFJyyfGRN2mB3kwRC3DBPFv2ScGcidVSnw3rG9WePyJdy35nzuakeh4D2YadeXd7aJbjVXUOaw8NlignuUcWAjXsSWV/uIWa4IXQP1j665u8/rpqrodtFvdEjwAUrOdWrIfsfqT1tGCAeaiEKkBNPXg2OFfci4ewqGxE80nV2BW7SbYeZtDNJSMWUmAWflYQvc0F4JNnVus3h3AyojPZlmxOuETd/U8TMacxHULYdZWa/klvgckyEegVc2ItkJoh26n8Zqh8hBt+DHDIvHC3WJsHivLDxOBjWnp+Q1p5nGm75cFMpYjx6N38UN/78XIkFiPtLjuAXOZMjmolwxQlVkyRy4PH/3SBPP3FTcENo0IUX+SJEmFiI7cbETzKGpAjTz/qDqQpaAX6lmme/dxJiM0tF/XbE4vW4dPvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aCtiamVCbmVDVTZ0N05BSzFJOEtOVEVrVTBHRFZnR1RUREJjbm82K0UxNi9Y?=
 =?utf-8?B?TXlNUVhRMHZmbHVIc0RWazJUY054blpZek5DRnEvT3EwQVBqZWM1bDFBNnZK?=
 =?utf-8?B?WTdxSmFkVDc2QVZRRjVIMlJPUzAxeG9RN1EyTU1oWmp0SytqaHRBeU5kb1J2?=
 =?utf-8?B?TEVCb2tnYlRId3dOMzQ3dXkvT2dJUmcxOUowaCtVYk5KcFdZcUg5VWRDSnFF?=
 =?utf-8?B?dFp0TGk4dWVwQlVhMkt3UkJyTGtTT3pad3BzMTZCMTVCY04yeHlSWXFPeTUy?=
 =?utf-8?B?akpJb2gyQWJwM0R1T0RpT0JiQ2pSQXc1ZUJQd25aanlUamt5LzB0VHo3eHFv?=
 =?utf-8?B?VWUxaXJBQXhFWEwwQTBpTDl4MXV4ejk1TTRXOVJhYlA1VWZEbHRYT3dvdTg3?=
 =?utf-8?B?bDhvQWx4REpKWlhXWC9xS3Z4RDNkbWtHSXFMVmo2b2tpU1F6ZEx4TUdwcFFM?=
 =?utf-8?B?YUpXMklHa1RjWHVjTlRSYmY5K3QxWkZHcTBEcFp0cVNLVlk5Qzk2a3FqSlJ0?=
 =?utf-8?B?VG1sVGxuWlpGdFRkcEppcDZOZjFWTEFTenN6emhqZkdIbEQ2M29hdStTd0JG?=
 =?utf-8?B?QUZoZVpQQlRObFY0Sk1xaVNWeGR4ZDBPQ0NuYTVYeW13TFR1VWhRSk1tZTFw?=
 =?utf-8?B?RjRDaVJPWjFvczdqd0ZORjZUTGZQYWtXY2o5RExaV1BLeHNmTDBlZlpCck5r?=
 =?utf-8?B?blB6NVVIaUxVYzM1M2lURnB2ZkovZUFaR3lMVjRBUHh3dDRmTFlwTTJ1TnBO?=
 =?utf-8?B?bXhRTTNxa1lVZVVzYWdqOXlncjd4RWxVK2RhNXdLQWxDeTBYT25hcWNwTEkx?=
 =?utf-8?B?MG8rL0k0R2FhZExGS0VnOGVNYklOOW51QmxjUlFtQUFqU1VtZ1gvckxUR3ZX?=
 =?utf-8?B?TzM2V3N6NjRBNnVGVXhUM1BQMm1SaUlwRExPbjV3T2F6SlNqMmd1VHF3M1Qx?=
 =?utf-8?B?cnlBcTlyMlVjbldtQkJSTmxmNDl5SVVJU1N2TFk0R1VTUHE1YU1kVVVtL1VG?=
 =?utf-8?B?MElsRU9Ka3VZV0VNbDBxUXY4VmpWekphdXRZNG96clRaanQ1ZmduYWJUUU1j?=
 =?utf-8?B?VjJiS2ZsNE5ETEJtVU1WelE5b29wZk5yeG5tdjAzbVhlUmQzZkMwSXllY0p0?=
 =?utf-8?B?NlZTNXU2aHQzY0x3L01lZFNDRXBiaWFNd21LR2VjNmo4TGRjTVA5aHczWHFa?=
 =?utf-8?B?aUJ6MFFQNEp3QnpJL3BUOU1TdHVUUjE1RFE2RU9Yb28yaExwVjdXMzhuOTlD?=
 =?utf-8?B?bDg0S0c2VitaWWdNSmdyZWpIclpyKzE1cFZVUFVSdUo5c0V2Qm5aRGU2SCtV?=
 =?utf-8?B?Z2VqUVAyQUM2eDZCY0VTbU1BVHNGcWFiNnFlMDJBOERPVlBxM0JscmwrNTNr?=
 =?utf-8?B?YzA5TzhyYVNiK1lXK0tuWHZPUUQxeE4rcGVPdDJUMjcrelYzbThCK0JSa1M4?=
 =?utf-8?B?RitabThnMkNmZTVkaThDYmY1WjVCYXM5OTJDQ2dPY3E2QTJOZnJNbXVvTnZQ?=
 =?utf-8?B?SWFjU05DaVZLUG45bmk2M3lJQU8ybEE4SUN3ZVNUMUxIY2R3R3pWRUF3cVRK?=
 =?utf-8?B?RlhvNCs2VTBFMWlFZjcxTW1QY0gwT3UxeU40MDlGYlFmUzNLRnNJYmhzL1la?=
 =?utf-8?B?em9UNTFEakZic0d3L3ptNmNneE96RUtYSzZUYWFrdC9VWWdCcmtCYTBPNGFz?=
 =?utf-8?B?aXdUdmdWMjd0MTJsYU90WmNKNmFWM3hqZjA5SUdOQXFmcnhSN0ROc0NYVC94?=
 =?utf-8?B?amVIQmw3b2E5TVRIN2pDZER6eTN3RjNPc2hNRkNGVWpKM214OE1GNmQxQXNq?=
 =?utf-8?B?SXZzbnd4RmpYTDlPRDlkTkR6NjZJblVzWjdCQ05sbFAvUVVPeWRkRzNFRjlP?=
 =?utf-8?B?TXJrR1M4RHFxWHdVb1psSUZFM1FFYWR5RVg2VTBJWHVjanFvb3hjakE4OXBp?=
 =?utf-8?B?MlRRaXFZZWNwVE5wU1ZhdVUzSVVFS0xpTE9uTjNxSUNkQXR2WHBWZXhYNDVn?=
 =?utf-8?B?bWNYY2xENEVNSGJzRTQrRUk1ZFJyVThQSzFDdU9yOEVacXhkWERNQUQvZmFR?=
 =?utf-8?B?bzhXNk5sV2VyeGl0V1dvcGZhWE85K3Y4aHM4enNISG9RelZIbXdJSExYNlgw?=
 =?utf-8?Q?lIVBpCfwQCrsN3FLhppfinKcY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc349b89-46bc-46e4-e5d4-08dc3c6f992a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 17:21:59.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yMcudy3ewBLuByjakAVdvbJLWx0lvj5yF4xR8Xu6Oub71WcWwfVPnNpG8k6F/lC3y7FswH9h91g2OFqcJOnmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127

On 3/3/2024 12:49 AM, hyper wrote:
> 
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
> calls kfree(padev) to free memory. We shouldn't call kfree(padev)
> again in the error handling path.
> 
> Fix this by cleaning up the redundant kfree() and putting
> the error handling back to where the errors happened.
> 
> Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
> Signed-off-by: hyper <hyperlyzcs@gmail.com>

Thanks.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
>   drivers/net/ethernet/amd/pds_core/auxbus.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 11c23a7f3172..fd1a5149c003 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -160,23 +160,19 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>          if (err < 0) {
>                  dev_warn(cf->dev, "auxiliary_device_init of %s failed: %pe\n",
>                           name, ERR_PTR(err));
> -               goto err_out;
> +               kfree(padev);
> +               return ERR_PTR(err);
>          }
> 
>          err = auxiliary_device_add(aux_dev);
>          if (err) {
>                  dev_warn(cf->dev, "auxiliary_device_add of %s failed: %pe\n",
>                           name, ERR_PTR(err));
> -               goto err_out_uninit;
> +               auxiliary_device_uninit(aux_dev);
> +               return ERR_PTR(err);
>          }
> 
>          return padev;
> -
> -err_out_uninit:
> -       auxiliary_device_uninit(aux_dev);
> -err_out:
> -       kfree(padev);
> -       return ERR_PTR(err);
>   }
> 
>   int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
> --
> 2.36.1
> 

