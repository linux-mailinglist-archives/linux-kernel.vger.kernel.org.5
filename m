Return-Path: <linux-kernel+bounces-59552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B792584F8D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDBC284F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41C76024;
	Fri,  9 Feb 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oI8dnA1/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6381E504
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493744; cv=fail; b=aqa2TBlkG3ZkxJQkVWbvTUaXquRgeXc4lVtZr92IeKl2zimawwtaWJcM8AU/GDHoGg3TciDVe0gzQ4PE4kSB/HMCSAf31Rij+ITnNSIpbRdFno+FY0M2Oj2DykB08hSmCQf1krIEBbZBGk03uKOhtL8T4iIHcWlBMJ47DVVMCBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493744; c=relaxed/simple;
	bh=7NicLsVsm8xSv6fKDNFHed7NhxQQhm615/nZnfLh020=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PEnEMhIzCdneLoawjretXWTo2zNOnRkdzd2gCADFM/IcMpDgVbVN8CJy8v2Jq90ETUCJkFrqSExGt2mAcj7Yxk/6NyfOROWFPnAPHueOd88VfDmBJW6JQY0mlZP+H/aRUSAJsOFBVkZG808ICSJ3zakK1LYkoy/ilBvIv/gaEYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oI8dnA1/; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lxbd8CNYUBn+82NDR4z+/KxQzR/4UIn0pkgkSIwn1iiDRzkr+ZaYwSfIz+3nW7H6JU5ueHkcYFCwjPPh/twLQS6+3DbIWDRcpclv2R897X+8gtnvX/oKxcIcLtCBPTK/GMxpjOSzH1wJ8fikO6v3A6n6RAePnnl7d7KsI+bqqgEtyCmBkvv1cgVYvdXwRsrhCH20/MNplGlFu6HOq2RglbfAL75s6OY0BhedOBfEK0rWd7yuFGbtwFXzca3mCvFc76Mx2PB9q1W/2nZcr4utxYk8t6uus5ikIkFVMCNCQ96yez99dOKsWENdyMoSeUZqXTznBzUVvR8kjwDKbRw8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPRC/ESfdxaHsRv0j0taGaqwiU5+qHHJGf6ZurO09wg=;
 b=ESRo+5uhW4hXNPIo+qZ4PLknvufEYyd65borabQNEOkGF1yVa7VzF6FxPpBz8tPTk5aYyoqrb54T7D5oIluaw408FNpNJiU1GDFlEDOJZoguE28z215IEOdD32UG4WniJzYh58Ws/zfdKpgEE09zxEhyQLRNGFUXwIrDYXinAwIEdHUq2J7BRH/+JO4uzcT5e0hstzRP47EttvIskigIiUPjuAvu2xZnRB4IgJ3/aqmYEdMQUEzwK/wvYyNE4dzw6wjhjXlrpRGDjLtw8bsoyj3dOIllCIc8pH6RZs6/PTBkRWSWDDVCUI+leDTjztcdXUyQcSlQDkJrwIE+HwyMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPRC/ESfdxaHsRv0j0taGaqwiU5+qHHJGf6ZurO09wg=;
 b=oI8dnA1/XX9S57pvC5C+01QohneGTS8pQTfqWfIvh85de2EsjvE3jl/m0vzEPInrVxtOGD/fdrBTsaDxqOWmprafLJOBVO/TFRU81kRt4d0gAu+0FwsuNGojtP0QP9FmXhzlVy/Ig6Sd3bJQY9WP030UFTkxCSwtm6nPCjtUGuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Fri, 9 Feb 2024 15:49:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 15:48:59 +0000
Message-ID: <23361410-3b56-42fb-aea8-3be53bfe5ae1@amd.com>
Date: Fri, 9 Feb 2024 09:48:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Mark interrupt as managed
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240122233400.1802-1-mario.limonciello@amd.com>
 <de66890b-a42c-4d8b-8079-fcfff0007aeb@amd.com> <ZcXhMNZDOHstOP5k@8bytes.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZcXhMNZDOHstOP5k@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 11be86e5-0d8d-49f8-63dc-08dc2986a1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hb/avop78sjt9n9T1WefmjzPJpcpM5pHh3NWJOPMpp0xQoHuzJ6aOeVN9UOWZy04K18MYSzoKiUJJ1bSM4ENZisfuyCk3ls5ZUNIS2GMKZvfKcLdbqTi/JR2y0A1o/DA8hqb7pXl0L2Eoe25W7Adgm9dYSbmeBmsoW3zv3PZMmpEp07crb/r6gYFcKw1H6OaROiaT3HwLu0O9NU4X5PPy5hwzL9h9Dr39qkod8Ywz9e5oeJI0uFkASGy0cWkymROhrP8aUox+OCvBeDNZWdgJUtmpEYAbz5cUM8uYR4EZvGcDlhLP+iAg0hJLGkWWA5Y20A0iyE2E5RQrK3hy2TxqA/X5HDW6ZNZnZX6U48zSHoV3SqceXjDK88mlHeq09/w0zwf6ZuixI0TKgtlGEmZYuao6y+aKZo2ViprfJrxga+ak7LiZrYNXw/tq0V8DHMcyiIxAn+fpvuwnqaGil+gwn7/WZSNtJ6U4mAf6ZxgiaWZUQcfcfrmtWfHpVVjiMkG4jVMbQTFFvEWdJQa0vyBdEOtKQR9Hl5t5WvDpsGNBWNrghOAqLgVVpnYpdR94PGQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6916009)(316002)(83380400001)(38100700002)(478600001)(4326008)(31696002)(26005)(6506007)(86362001)(6512007)(2616005)(53546011)(6486002)(5660300002)(66946007)(44832011)(8676002)(4744005)(8936002)(31686004)(36756003)(66476007)(66556008)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFJxNllKYS9GNVo2Yjk3OXBrZXI5YlRpSG85WU5MQjJNR212azRPZURjRExG?=
 =?utf-8?B?K0YyVGhoZDF1MmN4NVdTU2hNaU55QUR0OEVSMGdHUkxNZlI4MjB1MkZ2UFV3?=
 =?utf-8?B?WXRQTVRwNEpIQ01Vc0EvdHVJMEh4SDRWWURaRERRK3ZJYWQ4RTBBUTIvdlZh?=
 =?utf-8?B?MndOU0duMWovMjkxRUY5LzNBdnIxNllJR0xDWnhQZFFUaFZadTFJNXhOY2Vn?=
 =?utf-8?B?V3VCVWlzcEFlRHF4ZXdlOUZCTWU5VVJXcC8rTi9yQmhoekczZFJDdGN1SlpE?=
 =?utf-8?B?ZGhYZ1F6MnZwNGZzZlZzYVB0TDEya2hvTmhnN0YzUGlZSk45UE1kcXg0dFJO?=
 =?utf-8?B?U3c3TEJydXI5VEk1UFluNXlRSk1ucnZHSW13NmJBbEx2bEVyZEVUSXdkMVh4?=
 =?utf-8?B?OWZXZFFrYU5reEd4TEtKS2ZCeUo3V2pUUHJER1VLL1R5SHlVbWdCYlYzZ3VE?=
 =?utf-8?B?cFJiWjV0Yy9XaFJ2TjMwM3ZjNkl1UFVZNFl5eXFRYXRuYVlaZ29QRFhkRTdI?=
 =?utf-8?B?UEcyZG1OdDRERStzcDYrZkdGV1NaTzgrOTNSVEpPdTBIVzRaVit1QlIrcG9h?=
 =?utf-8?B?cXM4eEhWVnYzTzFoVVQ0ZWprckZqU0FmYm9iRml0UFZXN1JIaENQamdXQWdC?=
 =?utf-8?B?b0xqVEhJdTB6YTRXd1B3WXdpNFI5Y3E1eXE1a1NJcitEb21jWDdhTTFYNlJX?=
 =?utf-8?B?QWtYNDNsdHdtbFptWWJ3MEU1L09qUDh5L3RRSTBuNVNUWGpMdUI3U2YwNEpP?=
 =?utf-8?B?SjJ0d3RjZjM5bGZtR090UzVQZWhNN3BKRUVCQnlTYkpqa0g2ZFVRdC9qRlNx?=
 =?utf-8?B?aWlxZzhBU0p3V2hERTk3UG5tc2NUT3VwRkhtalpUbHh2T0F5R1hDQVlHNnpx?=
 =?utf-8?B?R01QcVgvMHk3d3FoSDZlbzlIbks0TkpTN1pWbnFxZFFxVXdkcGJaNnUyQ0F5?=
 =?utf-8?B?WlU4OG5yc3ZubXMraEhYS241YzRUby9sT1BYMTI4TjltV1ZQUEJFUENCbE94?=
 =?utf-8?B?bjd5TXhzdE9iTktwdVpBbkRsaEd3aEt5TU9jVVFnb0VHdk1xeXdQRzgvWFg3?=
 =?utf-8?B?aHE3bmJLTFRIWHdPQlozT3orOHoxVExPdFE2cHI4V0JIRG0vU3Vqdi92d0ht?=
 =?utf-8?B?WVB6OFJlQlA0YXJkR1dMNFVGYWM5K1hQZ0h2UndSdGZhWWpiYWFqY2xZQnU3?=
 =?utf-8?B?ZWhhL1NjZTZSVHI5VllTRzRzeWRYSmtaMXlHd2ZmOUF5OGJNam54bi9VZGlX?=
 =?utf-8?B?cmxPZWZscS9ET1ZtOThaT3JJYUEwdVRpZXNtRUY1dExFZlg2dUYwL29zZHQz?=
 =?utf-8?B?NE5PWkNraThxUXgvREliVm10aHY3MnUyNlQwakh6MGxLd0FOL2RuZW4rSmNK?=
 =?utf-8?B?VVVkWWhPOTZMaW5UOWpjSXJnZkdBM292NDNaUktCYzI0NTEwMXhYSEpqcm4z?=
 =?utf-8?B?NGE2STZ1cjNlUGVubVlGb3BFSU84Nk9ueXh1WVZvQiswS2pnK0Jua2NmcFdv?=
 =?utf-8?B?ejlIZ0hJVVdjL28rQjEvOWpuYzIyMXEyUlNNS20rYzR0cGpsbjlKVE1iOE1D?=
 =?utf-8?B?TytOS3I4cmlMcVVoNXUzOW90dTBZOTBvN1ArYWtPOXBKdHdOTFFzQUFuc2Nz?=
 =?utf-8?B?REdzMXZjWU5KRGttbWcvUTUzeGl6RFo0OWdFTUhoSUIrTk83MldoM0E3WmZn?=
 =?utf-8?B?SjNzTGNiNm5rU3ZabXIyZmRVK0JCMmhuRnphNktaK0JnUkE1MldoejByNjI4?=
 =?utf-8?B?NGd1SzhIc2t2R0RUNUd1Qkg3eSsvajZIV21YZ1JjSWVMb00vdzc3d1htdWZW?=
 =?utf-8?B?WjRvYyt2MlgvdkdNOVg5cnU5S0UvVXYyTEE1cW1HUmR5OFdtM2xEY3o3dkJW?=
 =?utf-8?B?dGtpQ0E4RXEvYkZOR3lDK0t4QTBrNXFFNzJwY3JXL0VZeFBNa3htYnA5eVI4?=
 =?utf-8?B?VHhkajRQYTFpanl4L3JvZDhyRmgvQ1lMNnI2L1QxZldhYnNkMk1lemJLclRN?=
 =?utf-8?B?OGJ6emtPd09jbDVHMmFKWU9BVVBYMEtBckVvcm1NVE1GR1VVaUtVRW5yaHd3?=
 =?utf-8?B?cDRyTU1DbkJHZ0MybzhYTTZacUtLWlhPRkZ3Tk1DYjJxNEhXRFB1Y3lNVlYw?=
 =?utf-8?Q?aqEf11n3RyK3ZRKDgMTYyIRR2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11be86e5-0d8d-49f8-63dc-08dc2986a1d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:48:59.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT/C4LBuayd+AwfSbVESap5hqIY/aE8vi3YLCVtT7KUwpe/1dER5OkLPqck9Bum1pmLZNtXqRJYVmoQpMaq1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837

On 2/9/2024 02:24, Joerg Roedel wrote:
> Hi Mario,
> 
> On Mon, Feb 05, 2024 at 10:31:47AM -0600, Mario Limonciello wrote:
>> Friendly ping on reviewing this patch.
> 
> Thanks for the patch. Since this is a fix the patch should contain a
> Fixes: tag. Also a review from Suravee and/or Vasant would be great.
> 
> Thanks,
> 
> 	Joerg
> 

Thanks!  This problem should go all the way to when MSI support was 
introduced (2.6.28):

a80dc3e0e0dc ("AMD IOMMU: add MSI interrupt support")

But I don't think that's a correct fixes tag because
irq_managed wasn't introduced until 3.19:

cffe0a2b5a34 ("x86, irq: Keep balance of IOAPIC pin reference count")

But then I tried to go off the original introduction of the error 
message, but that's quite ancient.

1da177e4c3f4 ("Linux-2.6.12-rc2")

So which tag do you think is appropriate to use?  I'm tempted to say 
this should just be without a fixes tag just a:

Cc: stable@vger.kernel.org # 3.19+


