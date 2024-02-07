Return-Path: <linux-kernel+bounces-57251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F374684D5B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA81F21E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A031149DF8;
	Wed,  7 Feb 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yJJleK7r"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE85149DE9;
	Wed,  7 Feb 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344338; cv=fail; b=GV3Mhijd7HL0k1aeJN/d+g/YPeTDTjr9B6UZLPZs8Bd93buQfPuN1r31VX1IPLWIvZnPE+0R80laoBZi3GJh7vZPdZsTnNZmJn9AQw8FSM/kDtLf8+L91GcTqzj1jgIqJ1hG3aRE9qD5CveQapyVJ/wlIyGp6+SIkV+ldPgXWvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344338; c=relaxed/simple;
	bh=6MOIAN3oMUFW8HTkkoof/Ikp37mbGGhGkDD0BCR+pb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AUFkEv2ByYwPbsNyWJi4DB9ipAVk3U8n0SBwhmTmB2cmwLPGOKsVGEl5z+yOKodWAsoOKjbeJnYRO08ZJZwyRw+2CY26TgE5ydAntoGgLvt5AuMZGo+Tzi4xQJmDhJRgAIr02I8TkcrOovV1PYxGoWUiLzHurhb6pLX5bNFwWZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yJJleK7r; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e71bGehbKSn5ZVUxvYveubX1NN1azfYfrS3era/CbYVkjj40Z2Z36NjuSrpXU/ylqa+Ip6cU10Xs19k4s16bLIGg/fegBAVNAbPsTV6Lj5VaRI+tMEGFWARzvXcpRJKgMIuafg4HBnB6H1T7Mzuk6N0CAN/fj0+WE7gA2hDGXMoNXt882Wlz+hQooI1LUwekklGKKkZZY3wejlebe4lf4YDOyTLhOVwYRj5CHSyPd/0BmJdn729KuKyPjU2IgVImPXAkO4dBBHMUgw9N4BYb46qfXJVMf2eZMQwp+qjsDwP8tdJx1rny88lvy4nMTJULsEe2ZHI7ZhHCePfEf4ul+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJt0YT8ZK6kGw5b4M6v20I5LbOV4H3+gx5GPR4t46pw=;
 b=V4QyLPoPlmneHOwjAlN89Nj98icPLGf5dEyTPlot/njyUFSOhYBIriXrxI4tdeS0P5EPIP+8nkWsSUrjho8iFwKDxdcBcz8x42oMGaLSEDp/hKvf84PWG2IbOrtrMI/Yd23mrolNXBdfo+8+1KlYufcyd0ZUoG/AiS9Cjwwz+aO/0LsmQNV3CrwaNaERm8upP1xBRl1JnHcRW+yawJjdM7f0E+sdy7++CjloxCmo2KxKzKgt494HnoTRN1/qMhnHMOGwtuPxDSfES2d8WQ0WDgeMn52w/+kBDQV0elO9QUpQNXnZ03hr0lcYIBzDkq7Hj/reGkh9gDwSVCMl5sPtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJt0YT8ZK6kGw5b4M6v20I5LbOV4H3+gx5GPR4t46pw=;
 b=yJJleK7rnOupQacoa8HGrK0p9oRlvFKVSF4GZHbClAXVGmHIKylqkKw3Fom49KV4GtPbLk/5v0pGCuwigo77Hr+vs+8ii6fycX9bWAexzsfwbJmAFLzRb+iqZGzoIxg6a/Kqng9o/K/LBkYmL1WfdsqEeYChD6v6NsafM3HImyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 22:18:53 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 22:18:53 +0000
Message-ID: <0f4905b4-9972-40ce-85f4-0880f273d7dc@amd.com>
Date: Wed, 7 Feb 2024 16:18:50 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5] remoteproc: Make rproc_get_by_phandle() work for
 clusters
Content-Language: en-US
To: andersson@kernel.org, mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ben Levinsky <ben.levinsky@xilinx.com>, Tarak Reddy <tarak.reddy@amd.com>
References: <20240130154849.1018666-1-tanmay.shah@amd.com>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240130154849.1018666-1-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::26) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 78db755c-bf59-4da7-c367-08dc282ac4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BqlBkKTNqYkYLXB7QYKKEuQnh5WDAu92y9fwCWW1so2gFDPdQ5LxCSp7C0kVHwj+cN1n/gDDfUvioPv6Ik0qSoMjK+afKrf2qeFdbGSJKHs/arHWjDXv59F2bsW2bIZowrmc92L9Ab0sWOVoGH5olOJV+y143iBtsZSWbJWK9GJkHRHV86lQcfESk8sTRaZLWid2VNA25uDxNB9bgOsRLXXb6Wy3MadR+dkjOocFnxNLF8A+NIufdrQDNkhr5eJj/Mi+Sp66Zuw/A539nEPewVnUa7hfp3dgh8/XHc4PBNnGMghIB+zoyHIQIkiuLSNdC7PF1Ja5Nc5j4OKwGT1yEGw45/u+xDSKLUk8p6vAybHF1c+6z4jnqsZhPba58AKNg/+HNSKPSs748GHsV81VCZPPxqZrDkDtdt82FdghmiEPADhlEj93ycKyJG6SL1PmYQoenZEK3OrLNI6vYPs9Uu0/x1ldVKBnNHlJWGE6yoq2ltVaJWrAzA8PGLKJzUEeeQ54l34D7lcGW0JSRshqjyoeQbr4bXjf+IKT0/B9Ub4f6aQ2wV605uzflJ39y3TL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(41300700001)(36756003)(66946007)(4326008)(86362001)(54906003)(44832011)(66556008)(8936002)(2906002)(66476007)(8676002)(31696002)(5660300002)(316002)(6506007)(6486002)(6512007)(478600001)(2616005)(26005)(83380400001)(53546011)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzFYNytzdmRXSDY2UU5DNXlKcUhxd0xuT1phaXdoVG04ZkhTNlpUTzVEdFI5?=
 =?utf-8?B?Q3FuaURDK0NXOTJMZmhueW1uWHUzZEQvQ2duNlhCdVFvbzkrQ2QyZWw5NzFi?=
 =?utf-8?B?bEV4UHkzemVDbEJMOWZyVnRKNjFwM090ZGx5MTh4WnI4THE1MyszY3BwMFlk?=
 =?utf-8?B?WnNPb3hDcjBJTmQybStWNFVxaDczL0NDcjV3ODY3Ykw0azl4QlVpdXhONVpa?=
 =?utf-8?B?cGwzRFIwZDd6SnU2UWx1TktYQlFxUDg1dDFpSHBrUXh6Q0VWOU1UU3V5VGk2?=
 =?utf-8?B?L1BKamVNd3c0UVNMZW85cG4xYmR6SnlVU2p3U2ZSblFrTGpZOWR4dEgvNTV2?=
 =?utf-8?B?Qi9LVExtckhvVkRlOVFZc3U3YUtWRE1QVm1wS2c0U2c0aTBwVTROUmlmZGla?=
 =?utf-8?B?QUpxYVZXR1NVblozOEVCcTFqUUVuZGVsaXQxcW1GL2RiQlZERkZtbVV5cTF4?=
 =?utf-8?B?Y3Jwb2FOVTUzR0lXU2dlNm1JWXZ4a1JUd2RYY1M4RjVqU2pUemN6OEJNL0RY?=
 =?utf-8?B?MDZ6ckV3dGNWWEw2VFoxYjduNnJ4YkZoODc0Sm8zSitXc1dZTEZ2dTdWMVlU?=
 =?utf-8?B?bUE4M01tdklobnRVSWhVblc4WUhhcXpYRG5iSTZvaUNRTXo0Q241bkZySUxI?=
 =?utf-8?B?OS9JUEVqZU9Vem0wUHpKTWdmMHFLY093SzQzVksrelFOTW9jRzg2SWVKREV6?=
 =?utf-8?B?dDQ3SjFoZ1d1bGJQc0F3czlZS2hDbjF5Q0VZY1lnYWJYVm1DanprM2doMnp1?=
 =?utf-8?B?d2ZCL1NzUnozbU93dnI4ZWFEMGZ0eXVVVS92WG9HelRxeXRxT0ZxSjZWWml0?=
 =?utf-8?B?aXVXOWl0KzRoNEhackdIQ1hVVFBERHppeDhkRkhLNy9LaFM0VFJHaXZCekVs?=
 =?utf-8?B?Y0tidzQ1R1BhZEZ2b1FOL0pZNEorUUVOeFNKeFp6UENXM1VoVTdmU0poN3hT?=
 =?utf-8?B?YVBlLytyNUFkZTFCYXdWaS9KaUdnL1N5QVF1YlVpeUlFT1JQaUZReHpzZGRp?=
 =?utf-8?B?SnVGbGRzM2hseUJxL3RTdUdqd1o0dTJsUmNKVXVlUW9ZOXZOb0xEcmhkaFVk?=
 =?utf-8?B?TDByNVVZMVF6dEkya3FPV2ErdGNrUlZwVXU5SnpxM1o1dkpjZXpycHdvbEdR?=
 =?utf-8?B?aDcrU3hIeXdscFpIdlhTL3N6Z2FzZTFvYUkzTjVjU09JZ0M3UVJINUdqSlRl?=
 =?utf-8?B?Z2MyODJOWjNmck5IUGdsd3RNcysrTkhYbnp6TnFDODJYUkFQRlNvUlhCOTRW?=
 =?utf-8?B?M0hmd0JtNzROTE1QWWNveVlJS1JyUnlHMjRZMEptZjZpRXFQVHZVdHphMksr?=
 =?utf-8?B?c0VQTUYyd3BoUFRRNU11aGhJR2E0emdHMjlGT3dFSVVBWTFqTVg3bHZBY3Bw?=
 =?utf-8?B?S2s1aVhad1dKbzJhUzN2YTk0dFFnUm0xV0hOZUlQQmhaWGFTbWhEa1A1RmdE?=
 =?utf-8?B?QzNmaXMzQWh6blExZlM4SkpGbStpL0Z1U0YvZ2hWdmRvWVNVNHZ6b2IwaWlI?=
 =?utf-8?B?T2o5QzZyQUNuS0xqN3pzQmpIazdSZFVxNmFzZjBlcUR1T3hpei9oWlpkZTd1?=
 =?utf-8?B?R0Zwa3ZvTlpYUFZXaENtOU51cksrc295QjRYekxucGxMREVzVVVxNzZPY3hq?=
 =?utf-8?B?bHNMMlJjbnQxQnVKKzhMbXVvUGdVcnVVaFVXNG5NalBPSWhaeFkzSEVSZVZh?=
 =?utf-8?B?dEVRcG9HNVZFWjVpSDRKUnN6ZVFVRWUxYWY4WHB1UzFRczlQenlqMFU3c0p6?=
 =?utf-8?B?OGNmWWZISWV1NUdkaXpTTlFzK1JyK1drWHNGbGlOV281dFZteElDLzczb09M?=
 =?utf-8?B?MTYzMXBKci9VaXNMamtFaGRWSFZxQkNNL3dzN0RScGp4K3JUcGtHdUVTTUNP?=
 =?utf-8?B?amZBTVJtNUwwUmkxcTFTcTNLRTZuMVFPbitzbllQdkFrL1FXY3ErcUtFZlhj?=
 =?utf-8?B?RHN1ODFSOUJQODBxSkgzQ3R5NXAraUMrU3pYZHdGVzhrbk1nL3d1cWlDa0pY?=
 =?utf-8?B?WTZFMWpDdXMzbVRQQnlySWpvZ2hSVEt3QTBUQ05HQmhwTWhrMHI5QnBJNFpE?=
 =?utf-8?B?cWFWbW9Ga25nc25Eb3ZRbFpTalZDYUlWbUJRSWs1VU9nYXpWcHZFbzNjT1lQ?=
 =?utf-8?Q?oA+cJ5GN7rmmKKzg6acSikF8E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78db755c-bf59-4da7-c367-08dc282ac4c5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:18:53.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTjXHuLjeauTGqKTycMQeLzDoDuswx9ewZSHc4Ocmt3u8aobajvlspvrRmVXCsHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

Rejected-by: Tanmay Shah <tanmay.shah@amd.com>

I will send new v5 with change long included.

On 1/30/24 9:48 AM, Tanmay Shah wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Multi-cluster remoteproc designs typically have the following DT
> declaration:
>
>         remoteproc-cluster {
>                 compatible = "soc,remoteproc-cluster";
>
>                 core0: core0 {
>                         compatible = "soc,remoteproc-core"
>                         memory-region;
>                         sram;
>                 };
>
>                 core1: core1 {
>                         compatible = "soc,remoteproc-core"
>                         memory-region;
>                         sram;
>                 }
>         };
>
> A driver exists for the cluster rather than the individual cores
> themselves so that operation mode and HW specific configurations
> applicable to the cluster can be made.
>
> Because the driver exists at the cluster level and not the individual
> core level, function rproc_get_by_phandle() fails to return the
> remoteproc associated with the phandled it is called for.
>
> This patch enhances rproc_get_by_phandle() by looking for the cluster's
> driver when the driver for the immediate remoteproc's parent is not
> found.
>
> Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Co-developed-by: Tarak Reddy <tarak.reddy@amd.com>
> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 29 ++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 695cce218e8c..f276956f2c5c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -33,6 +33,7 @@
>  #include <linux/idr.h>
>  #include <linux/elf.h>
>  #include <linux/crc32.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_ring.h>
> @@ -2112,6 +2113,7 @@ EXPORT_SYMBOL(rproc_detach);
>  struct rproc *rproc_get_by_phandle(phandle phandle)
>  {
>  	struct rproc *rproc = NULL, *r;
> +	struct device_driver *driver;
>  	struct device_node *np;
>  
>  	np = of_find_node_by_phandle(phandle);
> @@ -2122,7 +2124,26 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  	list_for_each_entry_rcu(r, &rproc_list, node) {
>  		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
>  			/* prevent underlying implementation from being removed */
> -			if (!try_module_get(r->dev.parent->driver->owner)) {
> +
> +			/*
> +			 * If the remoteproc's parent has a driver, the
> +			 * remoteproc is not part of a cluster and we can use
> +			 * that driver.
> +			 */
> +			driver = r->dev.parent->driver;
> +
> +			/*
> +			 * If the remoteproc's parent does not have a driver,
> +			 * look for the driver associated with the cluster.
> +			 */
> +			if (!driver) {
> +				if (r->dev.parent->parent)
> +					driver = r->dev.parent->parent->driver;
> +				if (!driver)
> +					break;
> +			}
> +
> +			if (!try_module_get(driver->owner)) {
>  				dev_err(&r->dev, "can't get owner\n");
>  				break;
>  			}
> @@ -2533,7 +2554,11 @@ EXPORT_SYMBOL(rproc_free);
>   */
>  void rproc_put(struct rproc *rproc)
>  {
> -	module_put(rproc->dev.parent->driver->owner);
> +	if (rproc->dev.parent->driver)
> +		module_put(rproc->dev.parent->driver->owner);
> +	else
> +		module_put(rproc->dev.parent->parent->driver->owner);
> +
>  	put_device(&rproc->dev);
>  }
>  EXPORT_SYMBOL(rproc_put);
>
> base-commit: 99f59b148871dadb9104366e3d25b120a97f897b

