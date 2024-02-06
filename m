Return-Path: <linux-kernel+bounces-55170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E217C84B8C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7281F26741
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82011332B6;
	Tue,  6 Feb 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="viI+jqxa"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2126.outbound.protection.outlook.com [40.107.247.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705B1E866;
	Tue,  6 Feb 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231922; cv=fail; b=r4dS7vrAl4iEstm3vj8E6NRc+GAuMgV2Vy9BcpEby3mpoBhFgT1uQKEzyzApJ2pAeazDecm2dL23dVsKLzbzMbGQKPhLPEAUzLStzm6BvrWsVpPJ+sL2vusLiZQJJzye7zOpOO8m0Gp20Og1dj7Egn/aZzWZJa4Oa2NMD7YZb2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231922; c=relaxed/simple;
	bh=MjOcOqjJtXJNTK/OFnHYxslAQhtd4J23yj7J7cHcYh0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rkk7DvkXn+u/UReo9Qts05YPz+qrsH00u3QueN46/j7bggLDTT8nO01GMqquJX5oClWWC6wRQf3GLrAQLEuV7e0KXPPXK5szVJo7JFVFUvXopXiTIDgofIaZtOtcUKEdFOfVdzEU/OzUB2+62f3m2oqYfr+A7JcKNDeM5U7mFCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=viI+jqxa; arc=fail smtp.client-ip=40.107.247.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhFxCRrfLhnKKMgXeSB35kZNLbM7nzqLA/4NgHtkY97Qv9p9lDGNxAciB+3WA7WiR2yE9ftctwf5cMHoqNUWhlDuhWyNCHwfPezd7Ak+8pe0A+KrXHYrVvOzlBIdkOzfkjy0dVDuDYUHadVRca8uhQirysmiQ7gNONKBJ/uB0eV4ft0I4zD2+ajxWY+9TN0U34mkiaLiji2rimE5DVRnK2C3QoI0dDuFtCTaaOnqq7tWcdtmYnQzsEcOom2Cuz9penjmiONR1QgrJ86KAmuWEzqniOB8sI6A8BYzbYClu4hSj2WXQP73HreCnFYEa0VyR6QrxteL/YA1FGYT57Dhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq3gYyZWWMSoTsck3ZUhPidu2DAsOs8HPVZnwvMBSsU=;
 b=T3q21Okw1kQBDRdQ8NvFyynum4hrpgZUHoiqcv1ojMifRC5rtGAd51KXRyVe0a0139iskVHD2TG9DznXAf1o/jR9jvjl01XoFPkzd8iW27fbdUjgNJRu8wDGBxkUP9A9KnOv6PidXkzZSrYtX9xw1lqCWeHjeJytSpwIP5kcgEmF9dn/Lx0CA2CfnYwKgkO8ZkDsMTwg5wwb6xhXxO4IL0aS0NY1YVQZo3rq1APEFD+WE/E4uSOCVhPu00WGzqYa2edbFAqbVUxWsNPkOcBePY9ajyBEr0moYn7o+TG5ct6QmRJEg47BugHNM3dyJs8u75XBpGksOllknF4F6Gzb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq3gYyZWWMSoTsck3ZUhPidu2DAsOs8HPVZnwvMBSsU=;
 b=viI+jqxaWc6vSj1lDi+scQKkl9ImbTyA+dY4lGJ6c+0EZmXGUsrqf9CZlN6PrOPr8e5F/hBg1cMpd3ZiTuC+4hl+OuYr8dbEZzR+JsAYafBDusIc+TZXYhCcqPdIpa0zcIFsD140nqr6nvE3LCOE06GO0O6c8xERSGGgvMFOMXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA6PR08MB10443.eurprd08.prod.outlook.com (2603:10a6:102:3cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 15:05:17 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 15:05:17 +0000
Message-ID: <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
Date: Tue, 6 Feb 2024 16:05:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0192.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::49) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA6PR08MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8216a4c3-a3a1-431d-93fa-08dc27250780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	07sIu1XxU1Mhi8LlGDsA+ryMeo+Ik10mh8d00DcAMvat7rQv/rEMdwIUD7+5QwNdHQiMLDUuiHHXaqmAbR80MoVyEQXbSfQzh9EGBIOxoq+OQhSDGC8zZtTDIpH5LoleOW2OvsMXMgB/8vdFfxHKxZZVGMvGBB7plWwranaIXEqqUXk/HedO7tbeEvHAfyCb0nOq7tJOvLUFdUfovbt+4VXhlv2SvUt9MizwM3OhcZW4dLI8dDcBOE3vp4JAa2/b58TevRAkcpVALbmohZkV7/gOtUzCvsczzGvJbAbBk4xlhN6NCrjQW3l0vEusD7uKMuwLS41oOVZcOkjrTPKeI/Y5I4Om0Z7O79pIV5ZSD1YmxYcLviYCt2sPKh/WhlmsoflJ0RFUcQwmewoEvYdh8kxsU6HJfzyFMCfC+FA1wvwOcyNwW9Ru+Dh2cyZIYp7syM3NsaVTeQ9SMOk7Ucg2v4pMin5XjC7w/JBzNkExj9YHeNx5vezG6kH+U6Dqpi62DXgfJgov+5tWRRbUziHZbxugMqiX00NGDsKyddn5IR8jOthNNrR+IveiTBNB1MM7bfRckS9XJxoUxgoeqqFlW2bzJjvJughVvHx7iwmt+v20wgS8ox5M6ejswp57+e8lfsXy07ukDC4a+XDr6742LQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(136003)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(66476007)(66946007)(54906003)(66556008)(4326008)(8676002)(44832011)(8936002)(316002)(6916009)(31686004)(26005)(86362001)(5660300002)(38100700002)(7416002)(2906002)(36756003)(6506007)(478600001)(6486002)(2616005)(53546011)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VERoWUpzcUp6SStBcjRCQmRFL0MvdXRxcWxhcC82VFM3V2FMUVBDZTNLQnZ6?=
 =?utf-8?B?VDNlMEFlbWhzc0tac0ppVUtCdGhRbkNyZEZoN2U1MGhYRVBmZVhydmhGQ0Jn?=
 =?utf-8?B?aGxFWUJyQjhVOWp6T1FZdXZrZmFsRnVTUUVrQWNnRGU4WE9lc0U3eW1RcjVz?=
 =?utf-8?B?UGR4UjJzcGN4eGw4Z1J1UEFDTFh5UFJROFpGRmlScVU3WDF1V0REQS9DM0RI?=
 =?utf-8?B?QnlzaXJrMTVQUlh1T2x2ZXBMRHk3dmFnMXRFdllPQ2xhTkFOZlNtMnFuS29F?=
 =?utf-8?B?VEdoSHhnVkUrdmpvRDZoSyt1VzBCVEV1bGx6WjZyd2VwRXBoNmFSZVFHYUhO?=
 =?utf-8?B?WXNwNDFPdm5NZ2R3Q3BUM08rRFFHSFNqMXhDbkVQeUM1dWRka052am92UVJV?=
 =?utf-8?B?c1E3UVhNTytKeTlydlArYldRTTlyMmdMVXNKN2hHU0gwYWlDekJJUUI2S1Yr?=
 =?utf-8?B?YTJaNVU1elY1TEQ2OHdOYmNhNUd0b1k2YW9pWWtQMFVQY1dUZSt3eGluSFRn?=
 =?utf-8?B?RkFHVnIwYzBXRy9YMTBxVU9nRC96RHFiQWg3cEdmWHNRL3FnREhjMkRFRC81?=
 =?utf-8?B?UFJFVVlCZGw4S21nVmswZllHVWpLR1pFNW1XVzJ3TFFVR1paTXpBc092RkxY?=
 =?utf-8?B?dG9BQitEbzhIMkRnVzI3dzUrREdDT3Z0cnZzajNOY3R6ZHkyOENpdUI4Z0ZZ?=
 =?utf-8?B?YVlnRzVFaEt5cElYMHZwWGpOdk1SODZpT0FSakQ2U3Q5Vi9Sd3UrbEJOUVg2?=
 =?utf-8?B?dllXYjlXM1Y0ejQ4Y1M5U1czU1FMNGZncHRBdEZweEw4bnFoVHZZeTBpMm1J?=
 =?utf-8?B?UzIzSTZDejJObUpaRDkzR3BMbkNrdVJWZlVQNUM2eFFoc0ErWjlOWGNVZGti?=
 =?utf-8?B?YkZnSUo0aVR4VVRzSFVpSFo5c1NxeVFXb09vRlJFa1lNVThkOE1HQVR3MHZC?=
 =?utf-8?B?UjU0NnVGM0lkK3VWbERDa0tRL2ROL1ZJYmcyOVRyQkdXTDZRU1V2Z0xRZ3Jh?=
 =?utf-8?B?Z29hblhHcjN6TFlRS3JzNjJwUFppV29wVzdQUVIzYmoydm9hNE9CUFRYVGJB?=
 =?utf-8?B?MXhoOFI3SHZyNmZPT21JMGtvcEhFTVVYOVJXNDN1dTI5S3FRbDFSSmd6ckRB?=
 =?utf-8?B?Rnl5Y3h1UytnQ2FrcmtzQmtiU3F5WFduT1hHenQvcGwyS1FwZnVUR25XUTdT?=
 =?utf-8?B?N0czM0tNTVJuSDZlMTFURndtdHVmcVowVXBtMURoS1UrUm5telo2Y1lxZGx2?=
 =?utf-8?B?eDNqUDh4YU9JOXFacEJ0QTZFdEZuVWxndXg1YTVlc3JXWUFxdUZZenlKYnhV?=
 =?utf-8?B?RklKMmRvU3pTVnlIRHE0UDhvaXpDYUozaWJZbVNZUGNGazNPSmZKOEg0Nzdy?=
 =?utf-8?B?cE5PYjNKdjlRc1VjL3d0UFViQ0JQbi80VG5BYjZkd1VXZHVYK2QvaGZtd2NQ?=
 =?utf-8?B?dWo3UTVPUWJoTkVLYWVoV0dxTlZkbVBFSWcyL295ejlQUE1lZ0wzSFdKMjha?=
 =?utf-8?B?NFNEeVZkU3grVW9NcWNyNjNDWHh4dU90OC9kYWN2Ri9FcXU5NFB2YWFjTWxT?=
 =?utf-8?B?dGFIY1BicCt1QTZOL0ZubjNUTzMvQ012K1JPOXRTVVIwTi80UXlRVGNYZUZW?=
 =?utf-8?B?aHRCSC9VbHpDK3I3VjRWc2JkVWZSNHNSQ3hMVXJBK0hiL3dtRmlyMmJDM3I4?=
 =?utf-8?B?MlVySVkydDYzbXJCemlkbVN1T3F4WGZjZTlMRE5IL3ZEVDVTYkYwWjZGanV1?=
 =?utf-8?B?Z1d4Y2VhQm1xU1VHdVpaWVQ5OGNlK1F3ZXNsMnZGU3Z1ZkhLbTBDb3IweURq?=
 =?utf-8?B?MnJBQTlKQnI2Z2RDV1ZNa1RTbjA5TnRiN0R6K1pvN0R3bTJGQ2dLaDM2MWE1?=
 =?utf-8?B?WEREN3VnNklreFFCNS8xQmEvVGN5TU1GSzlmN3FjblJRTHo5bnFsTGhXOWtp?=
 =?utf-8?B?eU1qa082c3ZJTlVhQVUxaE1Fc3JKZFFNcFRqWUZOZDNLQ0pDekxCWWZtU1Np?=
 =?utf-8?B?N1dTYW1QWkY2SmJQWk5JQTQ2VG83RHFYWm84R3lML0thd3gyOVdNS1JYcVY0?=
 =?utf-8?B?U2NsV0tEUTJFbkkrZi8xT0I2aVkwYzQ5ZStiOVB5RVhOY0RRQnF6VEFZZGVQ?=
 =?utf-8?B?QzNpZFJ2VkpxR0piS0NxcDAzMzJqSVlSd20wN0tOd1JQUDcvQ2dZK29vYmRD?=
 =?utf-8?Q?RlHANYBQNmXo+i/kkwYTI10=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8216a4c3-a3a1-431d-93fa-08dc27250780
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:05:17.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tW7Gy416mRZWfTQiNTqkU9lyeGS7JchMzpIsxsH8Al0tV1bu0vRnYV1ZO3JXkOqrfQ3e8C4Y68JHHSee+wCjQKqlG3v1pzDU7JkYwkvQCsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10443

On 06.02.24 15:32, Mark Brown wrote:
> On Tue, Feb 06, 2024 at 02:59:34PM +0100, Javier Carrasco wrote:
> 
>> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
>> multicore controller for voice processing.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> though...
> 
>> +  vdd-supply:
>> +    description:
>> +      Regulator for the 1V0 supply.
>> +
>> +  vdd2-supply:
>> +    description:
>> +      Regulator for the 3V3 supply.
> 
> ...it's a bit weird that the supplies are named like this, usually
> there'd be some sort of meaningful name (even if it's just VDD_1V0 and
> VDD_3V3 or something).  Are you sure these are the actual names?

The names in the datasheet are vdd for the 1V0 supply and vddio for the
3V3 supply. I named the latter vdd2 instead because this device does not
have its own driver and instead it uses the onboard_usb_hub generic
driver, where the supplies are named vdd and vdd2.

Those are the names used for devm_regulator_bulk_get(). Is that not the
right way to match them?

Thank you and best regards,
Javier Carrasco


