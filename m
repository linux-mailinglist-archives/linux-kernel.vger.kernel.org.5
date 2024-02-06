Return-Path: <linux-kernel+bounces-55253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73D84B9C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08A51F250D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422713474D;
	Tue,  6 Feb 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="tlxcj2tl"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7713341D;
	Tue,  6 Feb 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233768; cv=fail; b=EHiwj9CQbPYoJ2/4KJAYxsJX6Nxe7GTzq+hW0rnyD/A85Q+RUZ5MIPbaykLgvtMng8kx24QUEY87C9vIhieAUaVQtlBL5VSg3zfsDX0B/63iHb5WpL+l8XumEmRRmHLV9/G541BfCKO1ijVo52j0mHqzMx3NoeVPzL5fvHtA7xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233768; c=relaxed/simple;
	bh=razHpoM8EA6j+RRogW6ZoXkQolftswpPe9nhFPvwGY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AE9BfI4+RsD/UVdDmyDvnKfDx8IeQQPoexYd113Snt1SwQZL7hOX4/2R8u/Gmmf3WC0kbkFTQPM0QW8fYJY5rUvrGVubWys07i9YtvqYpG1y4rVfvDpF4fjXxyfLR+U7CvJJ1h/pZ5cTH9eNwYWecVGK8Dyb3M3g6bt59VBPa3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=tlxcj2tl; arc=fail smtp.client-ip=40.107.20.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K17CnkPAXobshCD9yfNmJaKsm1qR6hR1uOX0edYYzsQJ7lvPr1QVAW86VtQvSZnleXm6cwCphoG7civK/R7QB8omC7fflskRave7eKYEoe6x9U9pVL1YTxVbV40noP8Yrwa/r+/ai13qKtNI5PF5Osv1ylgl5mfv5x5D1ze54XWHt3vYPnu0bmHQ3Lx57jSUSuqjfg8jCSadKZBcE1TH+WmwSAfAQR6aoT7QpWV2vPZ4HPnzQ8P6GydvEIgGtebMKC5nXFx3G5Qp99h3gSeMbCrCFBH3sbAdlccK7SfqA8Qb2SXA7zsGbyktbBcZX0HPZNkoORHiJI/DQuBLXTwgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEyv/L7O1dOB3ziSSx5rTm6O7MtYq+d7NH38AAKt4aA=;
 b=HfMJaRwlhx0VxtCcVb7oGKp+Xnbpls7jFt62d3jfUyKJx7J0zMk/kf6AAVoP57I+rX2s77BnGUQfa4doM94iUMAqTDwOIb9xHlT6Nm9W6e9Jo3IMBNn1G7uKp0SDjQ7zt4Ux4gRLMkPrseulp9XLNj2WsQzgiKUq/kiIb+6p1vN2XK1tpQGGETUjErwniJBW9ioo+VUZUvIWWgrXoE+4YNqeaFe0YPBHawTi0d5VKneX/BNgEet7snuT5fOR2KB50kEIfVBGxGe2KLv7yBnhNyZqjciSvfSqyOs2/CS7S2UBwA4X54+C05a71ezpPQc6lNpm5TFNHYINiN8KbBsTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEyv/L7O1dOB3ziSSx5rTm6O7MtYq+d7NH38AAKt4aA=;
 b=tlxcj2tltB5dmZCiP+x+6x8lnvPQjqGRq7EOGVzKyoUEPD2o8mCEycrt6VUQPNvg47A8bwpkKrLUBvr8BZ4AYkOn0DNiTb8OR23eixUH8tX6fGwt3ae+BGwdr4XJr7g+8B2Ji3KS+TjVttAgn2BKR8ylDc8TiLeMXpVbEo8DSvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GVXPR08MB10763.eurprd08.prod.outlook.com (2603:10a6:150:15c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 15:35:56 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 15:35:56 +0000
Message-ID: <42106e0c-109c-4ba2-a703-f95df92db5e3@wolfvision.net>
Date: Tue, 6 Feb 2024 16:35:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Content-Language: en-US
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
 <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
 <ZcJOrvmbukDubcuM@google.com>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZcJOrvmbukDubcuM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::18) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GVXPR08MB10763:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b22ff2-526f-4dc2-0ddd-08dc27294f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0q8t/phokchCMK0zzBFS/mtMjeCiHGtga41YMR5GxBWZl4J8pOjefUNKE/qJqS/GgHvDJpDbEQG8w656uhRhjgJFEXXvAKjnjoT6UuX00LtVtCyKlBqwQZ1aD+hUNG4Ob5eIhamlA5O4bsGHnP/dLAzpyD+oWfbME7+8hAgWmDzNgzqTbvT6lADRA0mkaYCN8RB/5i/ifh7PbFKdkzSRXi/Xj8iOrOegqrm4meT3cGfgwkmKNOzRtaPczIlPN7z8QekscgDOG7l/xDG5K+9GDkhhRMEPkMIzTSpeclUZqKMY2L8ezYjjj3Giby/kLV9ra4KcOda0mGnbbMKpimlOfKBDcxsAhQY3fg1vKOTCZq4RJ18u7lStObUgukOh/2gV+7mQSzGexv9+Kt40v/pGSwqQWljAoNvaSolthXj41fEWlolG4rSvuG7Xi5Z5FiljZSsVVjGY71AvYjtmmX1ADQBMRZXozRfkh3lwn3x0GmvLVFcGvpBeTULSsRoxcDfkQNjJjBHpNJrnzBzdRWruc1iHKxuk3oSgVQPlEwPWK/3MYHYIHxmyiRTPdF1CVtreBhK/VjPOeo+Rs5TP+qL+c6/VX90aTgvXAZyfahh2iZsfGHt8j/czqL0WlO86R2jhhLMwaCDXzsKhjSYNpIWhhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(86362001)(8936002)(8676002)(4326008)(44832011)(31696002)(7416002)(5660300002)(6486002)(478600001)(36756003)(2616005)(6506007)(53546011)(6512007)(26005)(316002)(66946007)(66476007)(54906003)(6916009)(66556008)(2906002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1RiTUttTWNYbUJCLzVybWJYQVhoaU53dXJjd0ZCNkwvS2QvSkJ3TWJhK0w0?=
 =?utf-8?B?cWtxL2s3SFdrQldTUDljY29uN3M0SENvay9zSm9UbG9oMnZwYjAxRXBRdjlx?=
 =?utf-8?B?NUdXZ3ZkZ2NMeGEvTEwzZ2NnZUVnd3E2LzkzWWhEaUd4Z21JWS8wZGgvU2Jh?=
 =?utf-8?B?a3ZzTHJlbmIvUitXa0lGSlhhYmtSOWNBeHIvYXpsYmVsWFV4bUNZbEpDYUlL?=
 =?utf-8?B?bDFVbU9aMko4MkNQaU9oaGVJSlBUTi9Pci9od2ZKbTZmSGs4MTFCajNxUVZo?=
 =?utf-8?B?R2tXVmIvL3F0UzdmSUdteFEzcFlXcFBaU09PMGFHRlpTZ21kVktSQzVOS2FB?=
 =?utf-8?B?djhwWHRQZklhaGlLOGFlZmF1Sm9nLzJtc2VMMWEwWit0Rko5YzhrSktwOTQy?=
 =?utf-8?B?VS9hMytWNHZrZllTMWZGZTNNa1RxbCtIQ2gzNGNmUXFmaHEvU1YvNjJWSXph?=
 =?utf-8?B?dWtnTTZVMmZuTXQva095SWxrUm5PNU1uR1d5U2JuUWJOTmx4aFBlcDZhWUtl?=
 =?utf-8?B?SmRkQm0rRnN3ak82SW8yT2lSUUczTy9UeHE4UjN5ZEdTQnRYYVZydnE3TUJt?=
 =?utf-8?B?akU4NzQwSnlGZnV5dERpZ3o1c2tFSTdzTDZUb3dDU0hSWmRSb1QzeEdadWxi?=
 =?utf-8?B?ZkFRaVBHeXJxdVQ1RGY5NFU5WXBvRVlXM2tSdzF5MXJsUllFN2t3ZGJ5bTVo?=
 =?utf-8?B?UmlyRVNLa1FYL1JsSEpxU1JSd29CRE5wUVdnVlV6TTJWcFVKaUF3b3JJQ2Rt?=
 =?utf-8?B?NWNvRVZsRCtUT0ZxUEV2Y1VqOUZMWFdhUXM3UzJncjNRT3d0V05IZUNmK3FF?=
 =?utf-8?B?Mnk5MHVXdU5VMGxVZnlFS2ZQdEl2MnRBTk5CWW5TNnZmRnkzZ2s5Zzg4Q2pR?=
 =?utf-8?B?NEVaQ3JFWEYyWVZQaUpTaXV3Mjd0Qi9SVlRVTmVsLzl0V2ZqNFFFZ0Y5ZkIv?=
 =?utf-8?B?THJsUFZpWGhXaWh4OWxNL3NBajRrVWhCTDlyTWxHTkVsRGVvNWRNRXVmNTgz?=
 =?utf-8?B?VHFURVpnNnpnZStUcml1VmlNTlYyT2JuY2trTStPWDAwbExtU0xmbnh3aXhI?=
 =?utf-8?B?LzlkZGlzdmJQRS9ZY3MxTW45Q2ZuSVdWVkg1YXRkeHUyYjhzUE5OeDcxbkJV?=
 =?utf-8?B?am9QdSs1UC8xSlZmZEd2SGtJSTgxNmRIbEl6R1J0Q1FUM3l3UTAzMHZ3a292?=
 =?utf-8?B?ZEJ3K29DSzNhU3NKV2JtdzF1Mmh6WmpaenRIa0k2d0VnVWxnKyttQnlBRmIw?=
 =?utf-8?B?MVhWVUQ5Mjd2dEh6VS80R2ZYNHJteVBweDlUS04vVVVpV0pkWWFBdHdleVNm?=
 =?utf-8?B?aTVRK3NKTzlzeWxFL1BHT09xUC9FcGFZb1dFS0pvcXIyWDQwUVc3L2pua2dZ?=
 =?utf-8?B?QTQ0amxwT0xFUnN3eks5ZVJNMTdOb3dScmZuc0Z5aHVLN2laZUdRZG9TWDZ2?=
 =?utf-8?B?clMwajJYRTFPREtDUHJDYzlkSEpYYjFsZzFxelFhSllrTUZ5bTdMVU5Tc21p?=
 =?utf-8?B?S0htcUxUM2tOTXI5QWZHUm0rTGhsVmlGb0Zvb25zUFA1VzJoWUYvYXVaTVBq?=
 =?utf-8?B?bmEvY2VxME83Zk9NSmtxeWNZOXM3ZXJKdi8rUE10TWEzMVlpY2FqdnJqbUcw?=
 =?utf-8?B?bkhjTGRjaVBFMGpIVnZtVzczdXhnVkZMWlR1bVQxVFUrVHF6WDlZRmkyRERU?=
 =?utf-8?B?NEpYUWRqZXI4djV3Q3dOdmt2WTVqY0FNTnZ2NVk0d1A4THI4YnlaS0JoSEVW?=
 =?utf-8?B?WURYaS9yZDdCMkY1cnVwVTNCNCs0ZmVvTVg3U3laOVRXNGVXTGE0TVRNYiti?=
 =?utf-8?B?N1loTDBkWEhxeGJ5VlExdnozUVpRaVpHZ0VHQU1qMnRiclVkMDZ4Y0xHMkh2?=
 =?utf-8?B?UThiV1ZyMWRERWR6YzBralRYUUVMc3VEM1ExTFZFeDBidDZDU1hvMGE4YTlm?=
 =?utf-8?B?a0wxL2hrcVVkazJTeC9tZUJIOVhmamh6RG1rY0xrVlRlMXBnTk1ENHNuWFJV?=
 =?utf-8?B?VzRaRS9pSlpQY3EyWkhRNlRTR3RsbElpeUR1VzFWYnE1dkVpbWtDWnQrb3JC?=
 =?utf-8?B?TW5jOG12VEx3OU12K0RhRUd1ZWxjeU1lVjFNd0MrcytOZ09MZ3hrQnl2SVZP?=
 =?utf-8?B?elZELytQY0ZNYmkzaVE1aEphN0ZpbEhRaUZqQ2wyL2crS3VhY1pUNVJ4V3Yy?=
 =?utf-8?Q?cJlpgkd6KcKg5u2t+tJ8uXU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b22ff2-526f-4dc2-0ddd-08dc27294f83
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:35:56.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/zKdW8cfX4AVq7E21+qUA3PeOUfv4sb466ImvBId3f022wDIhXuJxVa1C+ir8tWfkcdrLjWq5HVIg3v+DO4pSx7XFuUnGngt3FGAWAYfdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10763

On 06.02.24 16:22, Matthias Kaehlcke wrote:
> On Tue, Feb 06, 2024 at 04:05:15PM +0100, Javier Carrasco wrote:
>> On 06.02.24 15:32, Mark Brown wrote:
>>> On Tue, Feb 06, 2024 at 02:59:34PM +0100, Javier Carrasco wrote:
>>>
>>>> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
>>>> multicore controller for voice processing.
>>>
>>> Acked-by: Mark Brown <broonie@kernel.org>
>>>
>>> though...
>>>
>>>> +  vdd-supply:
>>>> +    description:
>>>> +      Regulator for the 1V0 supply.
>>>> +
>>>> +  vdd2-supply:
>>>> +    description:
>>>> +      Regulator for the 3V3 supply.
>>>
>>> ...it's a bit weird that the supplies are named like this, usually
>>> there'd be some sort of meaningful name (even if it's just VDD_1V0 and
>>> VDD_3V3 or something).  Are you sure these are the actual names?
>>
>> The names in the datasheet are vdd for the 1V0 supply and vddio for the
>> 3V3 supply. I named the latter vdd2 instead because this device does not
>> have its own driver and instead it uses the onboard_usb_hub generic
>> driver, where the supplies are named vdd and vdd2.
>>
>> Those are the names used for devm_regulator_bulk_get(). Is that not the
>> right way to match them?
> 
> If desired the driver could be extended to support device specific regulator
> names through struct onboard_hub/dev_pdata.

the onboard_usb_hub driver as well and their supplies are named vdd and
vdd2:
Documentation/devicetree/bindings/usb/cypress,hx3.yaml

I took a look at its datasheet and there is no vdd2 as such, so I think
we are in a similar situation here. Actually that device requires five
supplies and they have been grouped into vdd and vdd2 according to their
voltage level.

Best regards,
Javier Carrasco


