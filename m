Return-Path: <linux-kernel+bounces-74710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7285D811
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A55B2831A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7E969312;
	Wed, 21 Feb 2024 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Imhl/h9x"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5447A7C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519254; cv=fail; b=gh/lU83AM/MCE0tnVg/4VanwHPu/sqRaIVBvojUNvLR4VtODc1xBYhX0lbdVqvhtuU6stR1YRv0m4pw+Fe4IMRpPMK0xUxBvv9MNRjb8XcEGQAAB9h3rhjoBEbOqqWAQQvncU4nMhumSMUp/Pl+6yDShtFo3zIhtQQGyNhZd/zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519254; c=relaxed/simple;
	bh=hNKk4QG0zll8OfqQitawNNBS4+v099f6keoCihsZetI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=konTovbIgysILQLZgAebUDZQWVKheNYDwO0cbb6y8evSWC0h4mDV3zGknAd2DZ7Ilk8QtRT7GVu/WQfAqb0qAuOiZtUrFMy+BkgSOrYryrzJinv7QoNoRMPSaCLTGfygB82Pr1woeoxYHR2o7fwD3BtX2Om9KrJzYGqMlbO73u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Imhl/h9x; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J88kaQ+Ind+8x2NGWZzgcp1Q/muozkxGtSu+74b9ALYN3X6o3JtpX9EDENYJwOzUpUc76z8s/SRCbV5gGptM1W1ZiKyR86dCnq04vzvgmWA4gqDlBFc6klATz7KzT5IZ4SmKwynS/0vvA5bdR3cvUYTw1QOMb2s9Ga2+Ut+U5sZq/B6ED1G4al1uqYkgLWC3KTOx9D8oUhVPI5tfLtEsuePv75b1ZPqBtATsDB7GxfVCtLv84Sbp0zaUC1PGlp00WgywKKJVLHipu1iZWcMm2DB4kkiN5zyTjwEjsZubOjWXWpp0yKbuoYTJVHn4E71ZxA0m60Za8oY9Xf6m7Dsgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW3UZ6YJFhaioJH24uqxlnUoSC9nDlpOLMj5dVRWxao=;
 b=VMHEvo54n2vLPluAT169mBHngmxPiy2Xxpzj9HnaPTWCoB41VDjK2xW7xw/tGAzwKu7BkRXzo8qE9xA/JBnJlmtarC0Nk8/cPTedisF8FDIFUR0z//wXjKwVL+WBGT7+j2orTB6897sRH8HUziPcvAdrBBaM6K5FRR8IyOgvj1Hotvvwnaio/TUGwY2npDYyWpEBdju19rS/sNJNiXyA8knz0f7wbpLheweSPVGGUUdpQr3419D3/qMTtRa+7lw53TXXTalqEgx2+K4F23TG0KH4b1PTc27pjYka0r0BPqoRIZy/EVsaQjTC5PvT/iQr+gflV4fSkGIN1Pf6Wn3stg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW3UZ6YJFhaioJH24uqxlnUoSC9nDlpOLMj5dVRWxao=;
 b=Imhl/h9xP8j/iToCQ1ylJtOm/vNXegK2kRNWDMr2216HNAKrotjBT014tL6vKL36ZiOF4LHBEosIy700yU7u6IxO0SG0ZHkKgZcpxDIT4E8+gsF1J2wdX7AR0cQF6E5r9+4lJJuwEEwk+yJp/vZ/drA5uBKSeKfAWlCHYG8p1VQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 12:40:49 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::4391:1e19:ff00:84d0]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::4391:1e19:ff00:84d0%3]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 12:40:49 +0000
Message-ID: <929bf3bd-fb5a-4d1d-aa46-a5ce43ce574b@amd.com>
Date: Wed, 21 Feb 2024 18:10:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] cdx: add MSI support for CDX bus
To: Thomas Gleixner <tglx@linutronix.de>, gregkh@linuxfoundation.org,
 maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc: git@amd.com, harpreet.anand@amd.com, pieter.jansen-van-vuuren@amd.com,
 nikhil.agarwal@amd.com, michal.simek@amd.com, abhijit.gangurde@amd.com,
 srivatsa@csail.mit.edu
References: <20240202113811.2546311-1-nipun.gupta@amd.com>
 <877cj0a4fj.ffs@tglx>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <877cj0a4fj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: d0567f77-9a2d-4734-54ab-08dc32da5547
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nK994lCeIU8Ac3iOaKdDXE62vrbECBmRaXt3Bw05CBkNrAGIPl/ITmLfB1CieAdstQY4OV0UAueoelUs+1Utb2EKVigMRZooxAZYjOfUgclG3wjliMSC9XmTF9CQGstjazeHvNKGwOj+kFBIkKgi3X+jxZuCD9+ij6ZmA0+OktRUw20U9/OF1HCM2cTGjjnSOq55mgHG3dxu7LWMdOfHDCSv7RkijLqRh1vl7SdScgelJKJesu76VnPmxOfmxWZ3E3/CdH5aKSum4O5YYojqtbRnXB1y721MStT00Lot7OTv1RC8Zkb5wzTZjHGfHnl3aaY3fZjeWCGC2vmtGZFTXoG+Oeav0uWuKNlLnBKCRunoeZKJe+eufUwlD8SOrcSQJPT8WLFmHz4Du3A+V3+DaUWMFWlwyP7fyTcX4n/Z0MoKM1oXrKGHRMAWkiDPxRd4gmxf6KZLJ8vuWXuAuovzRI5it7mqcnUGFV500Dw11rp6upCAoL09KBHu6Rv/LTm8QpPCjsd/Gh8dDpVIzVcQFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUxlU1ZEU2grTTRPYUVZZkIvd08vbFJ1cnNraU1JY0IxaW5QV1ZXV2RYenQ1?=
 =?utf-8?B?SEFudWVCVFVrUTBWaTQ5WnlKZEsyTTNiMzNTYWdZaWFXbE9oc3R0UjN5V2xh?=
 =?utf-8?B?WWlaK2t3YzVZNkQ5cUtyYStxVGZTaG5wV1NNdzFyOTBJUGViVmo3M0xjV1VP?=
 =?utf-8?B?Z2R2cWk2MFkzYmlhNUswanc3NURyc2FzcEJWcFQ0MzQxTXVkallJSUlNajlZ?=
 =?utf-8?B?TnFXQmdqM01NdENsUUo1NGR5RlRUTnR4ZG84cS9hSTJxVzRZcjlCYWpxMXlt?=
 =?utf-8?B?WUZBSXI4emViRzhmalQ3elFCOFRWMzVhbGZDR1NNbWZzcHBNb2E5bVU0SU5L?=
 =?utf-8?B?bXZGTVpQdUt1VDIrQ1RKckp3UmZRam55SWZBRmEyQWZKVFphZ0ZBZzFGdTBV?=
 =?utf-8?B?SzVvUUQ4dFIxMmRseXdXcHpYRnRiQng1d0VGTzVnSndaT2c1QURMYTdtZFBY?=
 =?utf-8?B?V3hZU0VVcnllakdYcnYzQ0lCcUlBNTduZ0lEb25iY2RocE96SHpqTDd3YWE4?=
 =?utf-8?B?dmI1Wkw3VDc2SHpqb1dGWVh0dUVObWowV3BkQmg5a2JTWE9iQXFoM21qV29y?=
 =?utf-8?B?ZGFQaTR0S3NLTUJtNU5hWFNGQWFiWDlubGpQTzFoQnZ2a3pPSnVJbDQ1WjRM?=
 =?utf-8?B?WnBJT3pwUkJHeC9MTS9ndldmOVBOczQ0d095KzF2eFBJYk41d01ob2h5WGI0?=
 =?utf-8?B?bmF4TlFMaDZoa3dLN2hCV3cyZjR0bVlYVXk0YjRvNzlnRjFQVkp4bFBXSWpW?=
 =?utf-8?B?RnNUMm1ZUGNHU2dnUHQ5TVh6QWRqMk1NNVF3OE9tWjRqbGpCcm5xeVNDSjcr?=
 =?utf-8?B?Um4yS3RJRmp0R2Vuc05sNitlNHZBNEhrQTZVQTNvWjI0ZzA4OWFFQnFWMEJY?=
 =?utf-8?B?VVhmVGtkQ0swb3E3V2xJSmlVNWpGWDhpdkVwcG5kMU42MkJhWU0zNGlSM20y?=
 =?utf-8?B?ZlNJRTVDT1pxdXd1M3VhczlySXFDV2FoSWFKVURISWE3dGVyWnRRakxYTlk1?=
 =?utf-8?B?U0UxQWFONHprdmU4RzJNUWRjQWxxRjQrYkJYdXVmaEsrSUZEcnJET0UvblYw?=
 =?utf-8?B?aWtGTWZBU2hPdFJDNURiUldNUEptQWk0cFhlQVU4dUsvL3VxaFFleC9wR0to?=
 =?utf-8?B?ZWgyZ2E3Y3dYN01zZmNyZnQyT00rYzZ3WGdrS1FBdnFBL0JDTURpbHRzMmRI?=
 =?utf-8?B?c2hqLzJ4eWJYNXRqbzdZUzJtaGsrZDhVYzBVYlhETWpUNlZoRFdEWGpwM0o0?=
 =?utf-8?B?U21kcFVJV3FLNWY0cko0aWk3dmp3NTdtZHBqMGZUQWN3ZkZFbUZ5UUlJNVI4?=
 =?utf-8?B?dldTYm1WZTRvMVhRLzFUeElBRUZQb3AxclpnaEhOcTI3Wkw0UFFVWDdES0d0?=
 =?utf-8?B?V3lZSmF0NmI4L0FtZEZrYWdKYTEycU9NcW5mS05seFIyMHJjTVpaUENFZTE5?=
 =?utf-8?B?M3FpRGJRM2RoZU1Pb2pBZlNDU1FTM0hLNkZ3NHFmUzBxZGtvQTlFMzF3d2RN?=
 =?utf-8?B?dEZLYTY1bDdFMVVnT1pyOEZYZmVDNkp0UHo1alhyQis3b2hmY1NndUhaYnVP?=
 =?utf-8?B?aDVhUFhPV3lMbDNIL3lrTHMza1RrQzlkSHpOdkkwSmhpNmdpQWF1V1RRT3la?=
 =?utf-8?B?d3lEWWpzNW8zZHFranZ2TWNNanZVbHB4MWE0Z0lQOXdwU0UwamVKNkN5Titw?=
 =?utf-8?B?SEJNRksyb0Q2YUMzTTR1d2t5Um5WVlpDVUZKamZpN1RwSk1YZk5UUFVhN1pw?=
 =?utf-8?B?WWlaU084dGRweklQVEF5ZGhqT0xCU2NIVDV0OTVTR09PWERkcDcwMTRzUC9M?=
 =?utf-8?B?L1JaNkJDYytWdWFnRndZWUpZeUwvcmZzQ2NvSUgrdGxDU1BMQlFXRWNNbW9H?=
 =?utf-8?B?bW9sTTBBMllLNWxKM2FDRlkzSkNyQTk5VDZyT1FHSTlrNVlVUlQ4dWpmdGZW?=
 =?utf-8?B?ZkdjTnF0bTZ1blZ6NEl0S2dEVnFWeWlGdElHQVlqZlZaY2R0Z1lxQThMRlA2?=
 =?utf-8?B?emt4MHg2QkdteDluMTJBK0FVR24rdzFjdFc2S3krN2hMRFNkN29jSHhBWDR1?=
 =?utf-8?B?UTNKRm1TOHc5YXR3Sks3SkJaTE0wRGtvdjB4eXFLS1pqcG02ZnlmU2NOWU51?=
 =?utf-8?Q?6PqtLcr1hwqKIwuRcXSshYJ7i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0567f77-9a2d-4734-54ab-08dc32da5547
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:40:49.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeoPgbk936mOSpugmq2WzZIjBJyrdzqNNX7zEnjVeKnK0NIye5Chs3cvAXqymaf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018



On 2/19/2024 8:26 PM, Thomas Gleixner wrote:
> On Fri, Feb 02 2024 at 17:08, Nipun Gupta wrote:
>> Add CDX-MSI domain per CDX controller with gic-its domain as
>> a parent, to support MSI for CDX devices. CDX devices allocate
>> MSIs from the CDX domain. Also, introduce APIs to alloc and free
>> IRQs for CDX domain.
>>
>> In CDX subsystem firmware is a controller for all devices and
>> their configuration. CDX bus controller sends all the write_msi_msg
>> commands to firmware running on RPU and the firmware interfaces with
>> actual devices to pass this information to devices
>>
>> Since, CDX controller is the only way to communicate with the Firmware
>> for MSI write info, CDX domain per controller required in contrast to
>> having a CDX domain per device.
>>
>> Changes v6->v7:
>> - Rebased on Linux 6.8-rc2
>>   ...
>> Changes v1->v2:
>> - fixed scenario where msi write was called asynchronously in
>>    an atomic context, by using irq_chip_(un)lock, and using sync
>>    MCDI API for write MSI message.
>> - fixed broken Signed-off-by chain.
> 
> Please put the Changes documentation after the --- separator. That's not
> part of the change log and just creates work for the maintainer to remove.

Thanks for the review. Sure, will fix in the next spin.

> 
>> +#ifdef CONFIG_GENERIC_MSI_IRQ
> 
> Why do you need this #ifdef? AFAICT it's completely pointless

Agree, will remove.

> 
>> +/**
>> + * cdx_msi_domain_init - Init the CDX bus MSI domain.
>> + * @dev: Device of the CDX bus controller
>> + *
>> + * Return: CDX MSI domain, NULL on failure
>> + */
>> +struct irq_domain *cdx_msi_domain_init(struct device *dev);
>> +#endif
>>   #endif /* _CDX_H_ */
> 
>> +	/*
>> +	 * dev_configure is a controller callback which can interact with
> 
> s/dev_configure/dev_configure()/ which makes it clear that this is about
> a function

makes sense. will update this.

> 
>> +	 * Firmware or other entities, and can sleep, so invoke this function
>> +	 * outside of the mutex lock.
> 
> s/lock/held region/

Will update this.

> 
>> +	 */
>> +	dev_config.type = CDX_DEV_MSI_CONF;
>> +	if (cdx->ops->dev_configure)
>> +		cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
>> +					&dev_config);
> 
> Please use either a single line, which is within the 100 character limit
> or place brackets around the condition:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules
> 
> All over the place.

Sure will update.

> 
>> +int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
>> +{
>> +	int ret;
>> +
>> +	ret = msi_setup_device_data(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
>> +					  0, irq_count - 1);
>> +	if (ret)
>> +		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);
> 
> Why does this need a special allocation function instead of setting the
> irq domain of the device and using the generic allocation function
> directly?

Do you suggest we call msi_setup_device_data() during the 
cdx_device_add() in the CDX bus where we also assign the IRQ domain to 
the device; so CDX device driver can directly call 
msi_domain_alloc_irqs_range() API to allocate the IRQs?

> 
>> +static int cdx_msi_prepare(struct irq_domain *msi_domain,
>> +			   struct device *dev,
>> +			   int nvec, msi_alloc_info_t *info)
>> +{
>> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
>> +	struct device *parent = cdx_dev->cdx->dev;
>> +	struct msi_domain_info *msi_info;
>> +	u32 dev_id;
>> +	int ret;
>> +
>> +	/* Retrieve device ID from requestor ID using parent device */
>> +	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map",
>> +			"msi-map-mask", NULL, &dev_id);
>> +	if (ret) {
>> +		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +#ifdef GENERIC_MSI_DOMAIN_OPS
>> +	/* Set the device Id to be passed to the GIC-ITS */
>> +	info->scratchpad[0].ul = dev_id;
>> +#endif
> 
> Is this ever used on a platform which does not have
> GENERIC_MSI_DOMAIN_OPS ?

This was added to enable the COMPILE_TEST.

> 
>> @@ -120,9 +135,13 @@ struct cdx_controller {
>>    * @req_id: Requestor ID associated with CDX device
>>    * @is_bus: Is this bus device
>>    * @enabled: is this bus enabled
>> + * @msi_dev_id: MSI Device ID associated with CDX device
>> + * @num_msi: Number of MSI's supported by the device
>>    * @driver_override: driver name to force a match; do not set directly,
>>    *                   because core frees it; use driver_set_override() to
>>    *                   set or clear it.
>> + * @irqchip_lock: lock to synchronize irq/msi configuration
>> + * @msi_write_pending: MSI write pending for this device
>>    */
>>   struct cdx_device {
>>   	struct device dev;
>> @@ -144,7 +163,11 @@ struct cdx_device {
>>   	u32 req_id;
>>   	bool is_bus;
>>   	bool enabled;
>> +	u32 msi_dev_id;
>> +	u32 num_msi;
>>   	const char *driver_override;
>> +	struct mutex irqchip_lock; /* Serialize write msi configuration */
> 
> This tail comment is pointless. It's already documented above, no?

Yes, will remove.

Thanks,
Nipun

> 
> Other than those nitpicks this looks reasonable.
> 
> Thanks,
> 
>          tglx

