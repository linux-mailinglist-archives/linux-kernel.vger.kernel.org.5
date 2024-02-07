Return-Path: <linux-kernel+bounces-57258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA0784D5D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2F91F24299
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116F149DE3;
	Wed,  7 Feb 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aQoSgviu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81D149DFD;
	Wed,  7 Feb 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345299; cv=fail; b=ZYRnxvgZenR/awD44zuWh0J0HGE11lfmPU8P1AKhRWRJRx6sWBt9Q44nYxQq99SYYS8KyswzkmSGtQ6sgpiF7WAzSHwgQDyDx+eoGFaL1pRfgrJPoGyS4cRoqu/IedSCd0b6WvPLBanphXszluHvvzh73vzfVE1g58GGo5B9UXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345299; c=relaxed/simple;
	bh=VAH6amqRMUp2IPpN5vYipGy2AcC5QJP19vqYJhRqXIQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ViReDkkE6tUJXDCLpiFxY20pij1ns6Nud6HUW5+tkDJmI7bqPCOIL4aHn8ZvJ36cdb1pxKrjwMByg98oWPENH7zBay6i1MCPt2j2q9I5FN0RYe3OzGCrXLHSTxBOsWd7NGabXiudLrj9MJ+n87n1EW5H1tMeMvkvZCmDOXO31bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aQoSgviu; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2xe1XsAM+N97Ch623fOt2IuXGJrEMqU/qblgX9dfhvWXWsfABGFrkUfmis44MYxxqWLZYNMlPY8/6YcSd5+V7tza0POF7fjUfxoukOtCdP0elUPBcpiyJnGX4gma0ScDF6AtxTvOqqxShBQz3liE0AuuG1LjqAIwcWHdZK2Bg7qqqauRgpgK5vn3j0aYfNUFrP8cfJcp5duIgVEmfnilCQGZyDLWWt8X5OFlDU8nWoUg9JNeWqQlysE0LbHHswgaJ9vlNj2Sm4zZCpQJ3tV2eVaRnGtJtKzNIbP/ugTtgh3Qtn+VVgEn4qUgVKfyxS3jYsj9bEtT9hbMVbVB/V9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhYUcoexecEIps//c/lZrruNWXri+mHOyV/u5F6A+AM=;
 b=XX64r+BuYaBbkdqBrtRDegjcuhm5PUxL9UetR18UV8OzU48KzhFeIXijfTKif8dhNvrBpOEHkA8NtzP6moQGTNKCrd2DwS7mDWFnXvVsX29XeUJ0yCKin2ggg+kCQcEo0ewTZwEWTThuVsl518FeRPiVrC58mfZiuoMIdp5miah/LjSFv/r3Irn/T9hR0osveGIm0f8FWw6+hmvj4lTJxVccP9+z6bi8T288Lr8MVgXlI2xdBpw+8F3fwq6WLIDz/oXlhEOmVMa6j26QnGwgVUmoxPN6TVAR/Gus9aoMs+fdZKy+ECy6YSedQMbFlV0MAmDsOTekzWWr1ZymEx7evw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhYUcoexecEIps//c/lZrruNWXri+mHOyV/u5F6A+AM=;
 b=aQoSgviuyLOZKCH4dsKS1/NkPCyCZwEMlUIHT4dY7OyPm3xJlIOUU9Rpvex5DQfsfx3+3HWrbLJrxezJj81AWenU5mZUvQtp7z2Y4nv7hl0AdJjWaZRRZAA1QUFwY/ZvQZ5JdekEGQKExioDk9yqeOwUJ8O34V6AxX+TW4pN8UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 22:34:55 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 22:34:54 +0000
Message-ID: <e86c920a-c328-4fdf-b060-155216dafccb@amd.com>
Date: Wed, 7 Feb 2024 16:34:50 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5] remoteproc: Make rproc_get_by_phandle() work for
 clusters
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ben Levinsky <ben.levinsky@xilinx.com>, Tarak Reddy <tarak.reddy@amd.com>
References: <20240130154849.1018666-1-tanmay.shah@amd.com>
 <0f4905b4-9972-40ce-85f4-0880f273d7dc@amd.com>
In-Reply-To: <0f4905b4-9972-40ce-85f4-0880f273d7dc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::9) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 931fbd1d-be1f-4c03-73a1-08dc282d0140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rcxNtq4VOQvt6K8TERtXPvn3ThTO+iARNgWNtA45JdAyQNKDEBp/cSbYKToMDrWwNNnSsxMf8/7LaeoJtQnVAgfXyWCqBcRMZO2z33SymvYAHAoZxeDfsnR+cJ3s6D8AqnZoE6d4pfJS0vLUE9S6aedef3Y4y0guntoc08raucqgTAUuObuVNSCvYAngP6M4igfyIhT/V1kaLy06Cev12ZcYCj9IjpbltNrmOWa5+9Zv8Poy8ZoxAVdoazT/tqtO/UljWL2ziKnKM99UZagz51XfLPljjR5cuCMJJZP5UMO6LVP5F1NGGZx9T0H0Gws/yjCtg01UBydR3xcX6juWz4GGuiJ3kIW1XAh+ESzAA+AEIqfh7huqxtaRpsfRbhiP9b6ZEahAVzkyHeXHFoPAGo2+/sdwNjEe3+pXaguLY8U0UOFwfTZPoXcCZ02OELu8OQDKaIbfBHBxbC8B8/xhthps7//XSWfVRokd+0fRD39LwzuG1OWSShoXJ9Rr1pFMdpOswyZFuZZJO9YIa5komerfkSz0EVg2UPuOHryK5nK5RRxuCM8ta80wPleaPTgu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(66946007)(8936002)(8676002)(6486002)(4326008)(36756003)(66556008)(66476007)(54906003)(6506007)(86362001)(5660300002)(6512007)(2616005)(31696002)(2906002)(38100700002)(478600001)(6666004)(53546011)(41300700001)(26005)(316002)(31686004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0QrelIrM09qMFFaTEpKeUJxV1VzZWFMNW1DUjJUQnpJWEg5dCtBcnluQVZG?=
 =?utf-8?B?MFQ5K2xjZ0w4MG5SbUl3b3EzbWhOcUdEYW5Ob1VzNG9qbnFQNys2eGtwYzk2?=
 =?utf-8?B?ZTZTOWxwQlRmQk5TUSsyR0JxRmhPN1BtUmlic21KY0pOOWlOQ2c4a1U1N3Bu?=
 =?utf-8?B?OWp6ajBJbk90dklqbUtTTDdWcDlKeTl2YUxiQ05teU56OVdaaFY5dXZzb3Jp?=
 =?utf-8?B?KzJXWHBTQ0NYTFlnbUVQYmE0Nm9zVy9WZFpqOVBORDZBbll2anlkVDE2NzlY?=
 =?utf-8?B?QkhTdTRTaW5HK3RxSWVQUHp2SCtTTWl3SURBbCtLN0xuRkRjWDlIcE54cFlF?=
 =?utf-8?B?L2MyZHRvVUZqR25rNlMyeWFEZGl1aWg2aUl0UTJESDJtTThQNWdMQzdob3Fk?=
 =?utf-8?B?dTRpUGRDNUxCNHR4MDd0eGlEL0pjOS9Qc0RiaXpGWEUvS2o4WlcweHFNdW5N?=
 =?utf-8?B?Z0d1ejF2bkJWM202aDRMbnpEcGtUb3gxc0Z6ZUV0SmFHb0VNbFZrM05udVoy?=
 =?utf-8?B?WTZnMXNoT3BHSXd3dXdJWlh1NGFmRnBxdXBIc1k1WnJnU0VuZHdoS3l6U2VY?=
 =?utf-8?B?ODZuT1crcEdRVmJXZjFycjhERHppM2UzZ1NmN2E4MHNrZWZMWWdZQ1N3bTBs?=
 =?utf-8?B?dDFSQVZ0Q1pFaTRBdlFsL0xYeS83dm5zWUtJQWdNNHNOUGVELzE2K1ExalMz?=
 =?utf-8?B?V1Y5RU0xTVZTZEZ2U01DZVhXUEM0QmJYb1dZTWVNcTl0c2NaTzZZRFppMTBj?=
 =?utf-8?B?aUNwKzUvbVcwekVySGE4WUJSaEFsUE5wRkVLSXozSjk5bG9SOFFYdVRtZU42?=
 =?utf-8?B?eGVQbWFvRGo5M3hQaVFhRHRlSy9HMTZyVGppWFEybk9XM1hyVElsb1d4U3JN?=
 =?utf-8?B?TGdZcU1VbDRMejQzMEpacTlPU0lueGp1bVcydENJcy9reHp1dmxvak56QVhU?=
 =?utf-8?B?YmJLN2hrekcreWpPc3hDdDJZZVMrN2VKOTVvamllcDNUUzNDYkhYeG5lTFNr?=
 =?utf-8?B?bmpQRkE0RkpCdDlMVUNkZm43Z0U4N3RjanlJMmR2UERKME9xSVFsQkFYVktE?=
 =?utf-8?B?Q0NDS2EyVHNtQ21oUTBnUG1UYjVmRzNIUFY3OUE2Q0JVcm9YVlI5M0p1QnAx?=
 =?utf-8?B?U0YvMk1iTmhBUXZGODlvOVpObDhINzZLeTRyZ1BxNlhTUGdEa096UE8zYzBX?=
 =?utf-8?B?eVdsTDJDNGZCWVhFOHNvZmdoa29tbEJ3U1UwQThPL3RGZ25qRFZoVHdxMmRv?=
 =?utf-8?B?d3VXTURvd21pSkxVMExnKzVhUjQ4bFpNNnVaVVVYeGJzVTM4VzdLb1dmR1pY?=
 =?utf-8?B?U3YyL2FzK3JTS2F1ZHVyOE5oSU1yYVpnQnVLNElyT2dVamYyWFpwZEJtZ2dE?=
 =?utf-8?B?T2FNSWVRVTdLQTZ6SUI1Rzh0RGwzaU5SMXVmaFlHUFp0Zkl6aS9udU9kYnBz?=
 =?utf-8?B?SWhFakpmQzRuMllsay92YWR6aTFDanhkZU10MEEyb0lVSllZVHVRclp0RnpE?=
 =?utf-8?B?YXlrOTRlbTFDMjVGMFJncW5CZ05FSEhVekRGWnZVMjU1eFlZVWMvNWJzM2Fp?=
 =?utf-8?B?Um1UVGZjOVR5dlVnb0JwaXJTWlc5aDhYMVJGRG5pMi9jTzgvZGtoL3laNXQx?=
 =?utf-8?B?VndXMzdrREZJU2U3bjZvdFhRUjZTUHltVUJhdGVrQ2FCdWtEZkhyclUybFpE?=
 =?utf-8?B?QlR0SjNpMDRNbndhSkdsU1VKRXM4WUFvaUM5SkQrUHhCYWZTNTRyL3A3WHNS?=
 =?utf-8?B?aVpOWW9YV08xMFEyVHVyRHA1NUFURXJOdTNYT3RHTnVXRFBDaDNuR0doNkwx?=
 =?utf-8?B?YTNzMnhWWG5CMmV0RmtPOEI4NjBlNWczYnlGQW5NRi9rQklUZmJJWFBUZG1Z?=
 =?utf-8?B?bGxLVVVRTVp2ZUl1dGh3OTdvYWw2OEN1V3Q3NktiUnBzN2pNNEUzcUlrWVBz?=
 =?utf-8?B?eXVxREMycUNjakhpZEErVWJzekM4czYvZ0w0ZVVzU2RreTRJaVNTUmMvdHQw?=
 =?utf-8?B?Rml2MUdleDltSXY1V3JYWExtaVpTZys5WnRiZWptU0xzSWZVRWxqZlhIdzFY?=
 =?utf-8?B?djExOVQ2eENZY0xCMER1ZVpFY1R4UEJmMFRweW5SdlJ5Y2RjNXU4WmxwOVd4?=
 =?utf-8?Q?rDYiP3d+VzXltTUWSJS7hMBXI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931fbd1d-be1f-4c03-73a1-08dc282d0140
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:34:54.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbZRAZEbuEfUnjJbE+F8TUZ7WO+R8JELEM8yok2jJc0tJ8wrZ7qlvJF+g3GOTvO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

I am sorry, I missed the fact that this patch was picked up and available on for-next branch.

Won't be sending new one now.

Thanks,

Tanmay

On 2/7/24 4:18 PM, Tanmay Shah wrote:
> Rejected-by: Tanmay Shah <tanmay.shah@amd.com>
>
> I will send new v5 with change long included.
>
> On 1/30/24 9:48 AM, Tanmay Shah wrote:
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> > Multi-cluster remoteproc designs typically have the following DT
> > declaration:
> >
> >         remoteproc-cluster {
> >                 compatible = "soc,remoteproc-cluster";
> >
> >                 core0: core0 {
> >                         compatible = "soc,remoteproc-core"
> >                         memory-region;
> >                         sram;
> >                 };
> >
> >                 core1: core1 {
> >                         compatible = "soc,remoteproc-core"
> >                         memory-region;
> >                         sram;
> >                 }
> >         };
> >
> > A driver exists for the cluster rather than the individual cores
> > themselves so that operation mode and HW specific configurations
> > applicable to the cluster can be made.
> >
> > Because the driver exists at the cluster level and not the individual
> > core level, function rproc_get_by_phandle() fails to return the
> > remoteproc associated with the phandled it is called for.
> >
> > This patch enhances rproc_get_by_phandle() by looking for the cluster's
> > driver when the driver for the immediate remoteproc's parent is not
> > found.
> >
> > Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Co-developed-by: Tarak Reddy <tarak.reddy@amd.com>
> > Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> > Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 29 ++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 695cce218e8c..f276956f2c5c 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/elf.h>
> >  #include <linux/crc32.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_ring.h>
> > @@ -2112,6 +2113,7 @@ EXPORT_SYMBOL(rproc_detach);
> >  struct rproc *rproc_get_by_phandle(phandle phandle)
> >  {
> >  	struct rproc *rproc = NULL, *r;
> > +	struct device_driver *driver;
> >  	struct device_node *np;
> >  
> >  	np = of_find_node_by_phandle(phandle);
> > @@ -2122,7 +2124,26 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> >  	list_for_each_entry_rcu(r, &rproc_list, node) {
> >  		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
> >  			/* prevent underlying implementation from being removed */
> > -			if (!try_module_get(r->dev.parent->driver->owner)) {
> > +
> > +			/*
> > +			 * If the remoteproc's parent has a driver, the
> > +			 * remoteproc is not part of a cluster and we can use
> > +			 * that driver.
> > +			 */
> > +			driver = r->dev.parent->driver;
> > +
> > +			/*
> > +			 * If the remoteproc's parent does not have a driver,
> > +			 * look for the driver associated with the cluster.
> > +			 */
> > +			if (!driver) {
> > +				if (r->dev.parent->parent)
> > +					driver = r->dev.parent->parent->driver;
> > +				if (!driver)
> > +					break;
> > +			}
> > +
> > +			if (!try_module_get(driver->owner)) {
> >  				dev_err(&r->dev, "can't get owner\n");
> >  				break;
> >  			}
> > @@ -2533,7 +2554,11 @@ EXPORT_SYMBOL(rproc_free);
> >   */
> >  void rproc_put(struct rproc *rproc)
> >  {
> > -	module_put(rproc->dev.parent->driver->owner);
> > +	if (rproc->dev.parent->driver)
> > +		module_put(rproc->dev.parent->driver->owner);
> > +	else
> > +		module_put(rproc->dev.parent->parent->driver->owner);
> > +
> >  	put_device(&rproc->dev);
> >  }
> >  EXPORT_SYMBOL(rproc_put);
> >
> > base-commit: 99f59b148871dadb9104366e3d25b120a97f897b

