Return-Path: <linux-kernel+bounces-131960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD5898DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757D5B26E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91633130E27;
	Thu,  4 Apr 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dl6MlKag"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2137.outbound.protection.outlook.com [40.107.212.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98A1CA82;
	Thu,  4 Apr 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255598; cv=fail; b=hpyHE5InAAtY44h4KPcDAZiiEu1Fvph16Q+gO+PnFBFrg0VVtuqYCgwI7A2vkiZd2WUOqJDdZ/CsKGkrG7tfP0qPN9CH/W7E5C8w/3gRmET5pXu/vVWN0MoYZD/5jZ8fpHBKoqZ0NN/PIK0wilN5FVpU5R6hMOYJkFHeeGZAImU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255598; c=relaxed/simple;
	bh=b47ajAoofn12jK98r2eD4s52F7FUCDRlsmtvKxdUtPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1UeMdV/AW9meosSGCoBFl/0tutbKW960auWRr0iVDiLqrHGEekUTMrKufMIPIQ000VgiJ7DHDzlctZvc6Iobzwl+zNUgIUU/GifbyNqpGeVzTeeso88LyZNuvDqsppteRVXIpWw/YZDgoLIyu3CSqFBVG8uXakAegpYBt10+Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dl6MlKag; arc=fail smtp.client-ip=40.107.212.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3sCvsyqpKlSgNhKkFI2IkN6mKgMlgkVx3RRC/kH8c8x5otcsxgedD10tjyBMo2KyDCouDRq3HC+JaoN2oOGS4CMhR2IClkO0c7GU59m4dK5ThfdEa1KvZlBSwJMYnQOSuWNra5CaUl9GrLaBk8npj4l5jFRy/q30gKOu+v4uzvBDNYxQF0yRUNH8CsK7NBdgH6TeeHCVI2h5xdtPXsXk0CTPf1xTCsNui7dyCDxWjgLtKFSuto3uV1DWKJM5nNNLvPMwZ2BvuzBW4ozp69noh18JXsN0jH2vIu25XNMsTKvw9NppezOgn5JRXHdh3Y+zi07UGJZUzZl24UCMUjx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEJCFw0ZLARzppUUYaf9rVhCorwAR2UdkOr2T8kVmX4=;
 b=nJfsrgfYj5L4+S69MfxCzu2uVE7vGniW+zhR/tu5f4hLV1R+wmMjuuLMNjWUAakPnjA0AtKj94HVeUqeUed2Hpj4UpeBcUZIA4jhNbbd+CduU6atAsO7yWzWFXTemFMyEQiP7b36AMXYkw/YBBfnZ/80S/dgygzhQceko9jTIy3nQyH4MPMN8XHGsI4afZBTpkKtYDeEKKA9Ragb6FDgCmDyomVr5jaTmjLPmJFKmlCc7JtHbtcOQJN9m+bIkTNAAKhlhjoBnQoGEEgNFTqNUa8YSn/Z9xvR1CwcWghg5+1AABXwjgUJKWjL6Uzf46L+XPMlJ0SxIYfaxm81nF4M8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEJCFw0ZLARzppUUYaf9rVhCorwAR2UdkOr2T8kVmX4=;
 b=Dl6MlKag7TrStFowUn3xIKU3rXEyjtQBecW6eBXBVRkRrhrfue7+D0NQowFElzmjkg7XBHalgfdl4lITqmF9JlEqYyI71T8iIPxDGxfeTLst6hTrIXCNRzu1Hvcuef1AeXbQ/nZvvNamY6Rp0a/+Ty56+FASMr3ELg/bHfMtopCroBOSHWtqRMU9ZtncAlYGPd6illoNJfqPPVrrYButZz7Gq08GSziq6RM8Sv8AEmVP/+eT0uub8u/utm944jj5fE10q+f7W3m46kV3AcqjKkwel9BwTc6kzXjxymxvxi8N+YqK71lShihiIGRS8paAMqTzbqKDrPYyeo0tckkl7w==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 18:33:10 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 18:33:07 +0000
Date: Thu, 4 Apr 2024 15:33:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240404183305.GM1723999@nvidia.com>
References: <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB5906:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z9h8SosH2Hfu1HbqBqs/9iUx8aOnhnjTykzp89J+gY6MTb3iQbGTdFRag0K2Z8twipHlVNIonTOWXDyC4cB8VHGv/hY5ITLHG7+fknxsZG1Plk/C2Lu68qrJhxD2/7mUcRFImaUXMh1Qjb2b8Q1dckh12NADDtsnlyOC5KjJeckM6gw3mpXOqauDNTul4NS5+3w8Hj7Z01tYRUUechzOG0L/whe9nA3pXYtAS4TMPny2tHfGVBAqgqO7B5Fx05JZsBl0pAdIWASRAIxifQ9lDbs7iZa921BmetMyZNJsja0F+0HcIyY10E5sHKxZBnCVpRVgborHN6juWYO2nLKm6Kn7qwOy8lAa8l93x+hseTXqv3WOs4omoFd34jk+0wxaatJ0Q+FsQG8DAEUPL0uwRVchE68sgL2MZ3t6rNXa0yuq7K72Kzyi5L9go7dqcOu2O9/98eMVdsrf7vXUgk7tIcmYNVGI78Q9Gs7uFc20VXa0iyknEd/VivYuPiMTnBMp2DlhDrSi0SMH7/vj9xQAohAY1rthivi/p8tdavTeH3g0iSJL3duztmt5LmDT0YMkrJ9Rv4lLV+s9ZIF11rNwZCvfS7RE4wOLIr9Jlt8tpJo2BLWV3v9HfVd/kIHCit6cszlFGsbHYEJGPGQK+qniqULVG4wjIpmIVeMwyNvBBLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG1LRVYwaTJOZ1hkYnhlZVFQUC9waFhUMGpNTUJiNVpDQkR0Y0R6OE16dFMy?=
 =?utf-8?B?Wk16a1prTFlmTW9PMnZZMjBVeEhOTjRQbE1OT3AwYUZINGdDMEtBejQyYTd6?=
 =?utf-8?B?ODZkUkhEQnhRdzM5RGxjd3VwQnZKcU5ZaVpQY2JqME5YbEY4Smx4VFM4TStJ?=
 =?utf-8?B?THlQTDI0ajlMdDJCRmVhVHVIekhCMFQxUlh3MEQxMjJhNCt5OFZRUnhoK0RM?=
 =?utf-8?B?OFRIaTcrckk5SlY4cUJxQWVVUkd5OVVvUWpnZFRWV2hzak5pZ2ppc0EvdHRQ?=
 =?utf-8?B?RkFkRHVOQVpBMXk1blJ4enBsZXR5eEtUYktPWUNTTXpyUklLZDBVbElKZXpi?=
 =?utf-8?B?WlJLVnhTUEhmTm0vMzNJZElBWVAraE5vTVdXdHhscHV1c0lqR0RVODBER0Q0?=
 =?utf-8?B?elMzb0RrVWtWQjVrb0k3OEpOK0wzdXY2K3g2RWZOczVMdXpueGcwK0tvNS9N?=
 =?utf-8?B?SGZYN0NmcmxDb3ZaSnhPenBKVnN5eGlhYktISWVVT1BlOEF5bzlDc0tWaG9N?=
 =?utf-8?B?VE9xRXBkVXBBeFpaanRkMkM0VElVaEltM3Uwd2daOGd2T0VFWTV4blpieS9L?=
 =?utf-8?B?MXF6YmJXZk1CV21UVmRsUVJvT3hldVVCMnNYSDBMVElmNXlON3dZS3YxVHNP?=
 =?utf-8?B?RjJ6MkViQXZHRTFIWW1zSGJVUFNxWnBSL2dpODlEWFh0c054RnpOT3NTWDk4?=
 =?utf-8?B?ZmF0MWFwWmlqbnQ2UkM3Nk00MXkrRm9QU0VtVEc2bkNMUE9FL3dtdzBIR2M1?=
 =?utf-8?B?YzNyc0NyQ1FsaHdrMjBrRDRkMzd0dEFITERXcVBRcXd6UjNaVFdGeW9IN3ps?=
 =?utf-8?B?NDNzTUZGZ2FWeThxcDhvam5GTXNvSHh6bC9uT2NFZUU3OWtlcG8rMGxUZGRG?=
 =?utf-8?B?ZFZSTkxLTHFMczdvMGdNdml6NTNsWjh2QVNoWElVQ21xdytYNUFMamlNcGl6?=
 =?utf-8?B?WExZT01pT3hxWk9ya2V5ZmpMMEF4UVJxT3RVcGdLQVZPZWViZXhISHFxOWJi?=
 =?utf-8?B?Q1VhbFhaRkcxc2FEUnFKS0hEcVVMb1ZOVWxUZXpuYktnMmF0MW13aFpqcTQw?=
 =?utf-8?B?d2Y5cG8yaXQrbU1VeFNsVUh4UzU1ZmR3dmtSUzg2L0tKSnpCdVhsMjE4dStl?=
 =?utf-8?B?aW1MQTEvLzkvSXFrb3QvUTJKNUlJeEFCWmJ5cFVsZmthME9qcWpqTDZuRjRT?=
 =?utf-8?B?TlZZUjY0WmRNVnhPV013ZWhCNFIyOFBBbmZWd0lrTVVnV2NPOS82U2lJb1lW?=
 =?utf-8?B?Z2NiOVIwWGhLdjZDc0RvM05FSmV3N1BDTUV6czhVTHhaQWF1MGpyc3NYMDRa?=
 =?utf-8?B?Wm5XeExGUkJzc0NodEhIWDhQZjdZRHFNYzFVY2tYanFFVmJ4R3lHQUVnbER5?=
 =?utf-8?B?aG9Lb3BGaHdJaG1nZDIybCtaNjlYSnBzUHFXRnlHb1QyUHhaekxpT0JERzZR?=
 =?utf-8?B?azhMNncxQ2dwUXVZU0tSb0J5N04rOFB5S1E0Y0tFd0hDY0VxZG5zOUFreEJM?=
 =?utf-8?B?OGVhTHpjRUdkMkpyUkVaNHYxYVpyNjE4QnB2M1QzeHh5RG1OakwyTy8zV2o0?=
 =?utf-8?B?aGgwVi85cHQ5TlFmZmZFeEFxWTF5Rnp3VDUzdEtIbUJmdVJsNERraFF6UThQ?=
 =?utf-8?B?dVhtZUhrQUEvUWlOMGhGb1RjZnlybSs3bFNwMytnd3V1S3p3TkFSOFRtcW1D?=
 =?utf-8?B?Vng4UmpLVW1vVUVoR3pIcmJuOW51WWlWdktrRGI3dDFGdUNEMjVmNnVJbXRZ?=
 =?utf-8?B?VmU2eFlQWE1CVlFUYmlwc2RwYzdrUnpRR0xDRTJXZEpLY3lGaTVVRjNqZUlL?=
 =?utf-8?B?ZWQwNnJHQ282K0xzT09yZ1BJUTBHOUdlOXluMU1KNDZROUlOeGJsYWx5cnVI?=
 =?utf-8?B?Sm40ODY4MTkvV1lGOURwa25QeDRTcFZndVdyVkpINmVGWklUcnV1VnhUVS9C?=
 =?utf-8?B?RXFiMGlReTh1RURndCtnakV6TFpNQlIreVMyMmNCS256Vmp0bFNsWE0vSlBS?=
 =?utf-8?B?ZFdWd3BhMDN2Y1ZUT3lhVFVqMVliZ2tVUmh1aCtOQnAyZXZ6Q3Q4MzhaWWpW?=
 =?utf-8?B?Zm9UazA2aWd3Z29sYkNWK0l5T0kwTk94QWt3M0sybWZRaHR3YjhJcVVVM3Jj?=
 =?utf-8?Q?waAX6BO19edWjoT3JClECxPLx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bcbd45-0ca5-4b41-8185-08dc54d5abe0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 18:33:06.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjYWqRA3gbk7Adhcfc1Qjur+H/ut1aBA/tC4JHLxX/YgkI2C3bZpIHEPxdl/UVJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On Thu, Apr 04, 2024 at 06:35:04PM +0100, Edward Cree wrote:
> [ Again, I had better disassociate my employer from the vitriol below,
>   for which I alone am responsible. ]
> 
> On 02/04/2024 19:40, Jason Gunthorpe wrote:
> > Uh no. Alot of this configuration stuff is to serve niche customer
> > interests where the customers have no interest in publishing and
> > commonizing their method of operating because it would give away their
> > own operator secrets. The vendor's created it because their big
> > customers demanded it.
> > 
> > eg there are configurables in mlx5 that exist *soley* to accomodate
> > certain customer's pre-existing SW.
> 
> So it's a single-user hack, why do you want support for it in upstream?
> Oh right, because you want to be able to ship single-user hacks to all
>  your customers while still getting the _cachet_ of being An Intree
>  Driver with the implied engineering benefits of open source — despite
>  the actual feature implementations being obscured in firmware that's
>  not subject to the review process and thus doesn't actually carry
>  those benefits.

Uh no, mlx5 already has an excellent in-tree driver, thank you very
much. The configuration is not changing the driver, it is changing the
device.

Consider, I can ship unique devices pre-configured for each site's
special needs. They still work with the same inbox driver.

In fact that happens already for certain large customers. It is why
Jakub recently pointed out that Meta doesn't need any
provisioning/mlx5ctl/misc driver. They just buy different devices than
everyone else.

So, it is really some kind of extremism to say that allowing users to
configure the device in their own system in a booted Linux OS instead
of in the factory looses the "implied engineering benefits of open
source".

Further it is really rude and inappropriate to say that some customers
should not be able to enjoy intree drivers because of your aesthetic
opinion of hacks in a device's design.

> > There are something like 600-800 configurables in mlx5
> 
> So because your engineers can't design clean, orthogonal APIs for
>  toffee, you should be allowed to bypass review?  Sorry, but no.

Overreach. The job of the kernel maintainer is to review the driver
software, not the device design.

> > Where is the screaming?  Where has keeping blessed support out of
> > the kernel got us?
> 
> Well, clearly *someone* wants you to supply them an in-tree driver,
>  else you wouldn't be trying to upstream this.  

We already have an intree driver for this access, it is built into
sysfs. Tooling exists everything is deployed, people are happy.

If you had read the thread to understand the issue, you'd know this is
because the distros have turned on module signing, secure boot and
kernel lock down.

This disables the ability to have an OOT driver, it disables the
existing sysfs scheme and it forces everything to be in Linus's tree
or it does not exist. It effectively breaks the long existing
ecosystem in this space.

Arguing that keeping things working as they have been working for the
last 10 years is somehow going to wreck opensource or whatever is
absurd.

Jason

