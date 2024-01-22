Return-Path: <linux-kernel+bounces-33023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3526836354
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EEB1C223E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B798A3BB29;
	Mon, 22 Jan 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="2IzTbMT9"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7D26AC5;
	Mon, 22 Jan 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926938; cv=fail; b=RmEOEtL5FjBjsMSuWF+FypF3DR3RFwOs4tCxB4mm3BP4BgXyVmlyx3hFs8l/y0cmuoH46TB9/HBH80DPE8L+EzQOlz4cQ4KypGnGQrUQisq/gCA+X+meZELfecmaCBYUb8Ihsx/dFP6URwEq25e4vd7E/2Qh146lXCeLSWy+hRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926938; c=relaxed/simple;
	bh=VtE3ouGbiiKr+jvh7FVUvYKPahrdbr2s7FRZvHptwJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuOL6q+0s5t1FGxTyaJLvWgzdWAeqDSU2ax60/MRS6Cf//7DBp0fHfAml12hVL1vFZrzNsTn73mFHvP3nTv530zmXlwb0KLYgFsC6SFdOOuGBQhmC6mAqAXpS+5cdVmbaosl4Er2/VhOcnd83xIWBIatQxf1mUAZNmSvywOFAwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=2IzTbMT9; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnaGmOi+qwXcnXaIkwioPADjLoKWYdoh2CGgpbNZk4nZPegEaFmC+Ht9cLk/+/o5SSLlCF3rSbrWmja/9TA+R/Z76OZZgRw2lLq4fnIocYRwHTXlU56XxZsYlD++gTCcrBq/vgGXGqOthBWWsU8ztj50Irk1dCYntJMZYolzHnoETuWTePER4tM0gKbPbYF/dKOclWufcngKcAKlYCSgMkyRmjMg2taD/UacmWbKAVGmfTPywOSfhvBO6c0LZ/DdGlcoGa20JeQs30twv7BjKAPtGLFXvwJn1emXxtRV6q2KhS1EvC8q06B2psNSIK3WucDAH0KwKOOCqJYUuzzBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3chs/qp+SZKLQyDAiZP1eZh8EHNNAKnbTbXnIEN6xw=;
 b=Xk+mZr1isF8hxJIBDe62TaaEHCdgP4St3Sx2X2xP2Cnx1ybTCmWPPDMVEdajCLyVpF1Ywmz05mqUxIGsi51GSNsrWGm+LVllzV2ZUbqOmrL1ndv4p+gNRY4PR7EXyVM3MGgyVUS8auKxKI5Yve4AGH8W6zqwBiTlhJu6xKTVxErMjN2kWUhTyLftbjqvMD1IomgmDGZHprI7nCyvxCe/SmJxEzxdvAP/QpdPSjZEgKgImbn4ht+Rqj/jzZ4ByT2OObc5LYx8Gf/2HGK1rGj6LAjWyCz5NlcS+8gcriKln53X14uwIT959LAaUWkGuwk6iKtKZ51dK1ulTJ7zXWGCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3chs/qp+SZKLQyDAiZP1eZh8EHNNAKnbTbXnIEN6xw=;
 b=2IzTbMT9Tm3bQLETOPaeAt50P3a/4iybSc2WFuU6W1E2LJbBdcBQ9jgD18uGhIE9FVWe4BKrWKk6PGCEqDKcW+pwyB6XrpC4302EaoHVBoeq9/PE/e1OQBLq1xITTIaToYuvy/jgdDNoJVgpxhFPcWEAedFfZEnaALYsWHjHoYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS4PR08MB8094.eurprd08.prod.outlook.com (2603:10a6:20b:589::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 12:35:33 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:35:33 +0000
Message-ID: <1426b1e4-f42b-44e4-8d21-e675132866b3@wolfvision.net>
Date: Mon, 22 Jan 2024 13:35:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for
 XMOS XVF3500
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
 <20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
 <333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
 <96abddcc-fa65-4f27-84fe-2281fe0fcf1c@wolfvision.net>
 <644f7f02-405d-47fb-bc72-4d54e897255f@linaro.org>
 <5db4b898-93d5-446f-bfed-b57847f9967a@wolfvision.net>
 <435f502c-1e1b-4d40-8dcc-34487905d69c@linaro.org>
 <b7f76546-9998-43e0-abff-a4e73817dbae@wolfvision.net>
 <47bdc31c-50d2-4d33-9339-5132b6364539@linaro.org>
 <16027339-0a82-4dd1-86aa-19fda6e23f88@wolfvision.net>
 <aeeb0dfb-87e2-4024-9d4a-0b9529477315@linaro.org>
 <b888d958-4eb0-4c1f-ace6-b2b85faa5113@wolfvision.net>
 <87ede9y3ue.wl-tiwai@suse.de>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <87ede9y3ue.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:803:14::28) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS4PR08MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9882db-d512-41d5-8b6a-08dc1b46a015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rzkkokFx1BeKDKL6MkWP0zy3Qz7sUzVt5YO+tHtwShMtAhssz298RzgHlinoZEwBYhTkxrKIxIzQ+LrA+gSJiUspgGvJQcDBMepvbQf8G6/HCAwAvYgMEy6Cy8JuLlxc0ZvC8XHVKYURBvosDXcxrFtTJm8UCz2k8be6IHtA+4NnsBKXMBp/0fiOVUM/WZxiwwNwPFjNklXpX5uscLjZZ/knAwgtQoNI4QlMiXvLs1aph05CsoF05vcTMVwmK0qdxFaebI3oPh1GTbPHQ7CEkF+vF2LWznED7XUzQ1qcBWXVOYl5v4eWNZdeY00pF0qeYnh8r2gvG/z2HLBD8nqU24qhtTI4HjReWjrECqys8q6VeWyh8Dhk5Ag1y7ejzdXM3TDs8vr3tm+rPcG1Z8zzLWc3RCNQuqmhTlODME84obdkXgAdcIcFpo8DmvGOs2zaRBvgxbqR7osENsUcvHDVcj8jRWKNPt9Sb1FtPp25EO4ga73fyyQ2RZF0rzZqrSnddoIjJMq3uotWTZ7vQAV8R+zJma3lHfix5u77NS6+WyRfa/e/GHq2UN4XKvEPv8enauGmova8+NIy13bzHn3naysB62I4oZ7cYubPFw98VNQRGczykkHLi/MuVs9xMX8LzI+XpJaun+yqiLCE+E2D6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(6506007)(2616005)(53546011)(5660300002)(83380400001)(8936002)(7416002)(2906002)(66556008)(6486002)(6916009)(66476007)(8676002)(4326008)(66946007)(31696002)(54906003)(316002)(478600001)(44832011)(86362001)(36756003)(38100700002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWdaUG0rQm0rOFY4cERkbWR5T1ZrOS9Lb3lUUlNaM3pOeGdCTktISFlrSG0z?=
 =?utf-8?B?Zmo5QVgraC8ybml6a2ZpSWZXM1M4c0ZlaFA0cXdVbTVDVFc3Q05LNzVFdTVN?=
 =?utf-8?B?T0lhMVM2emFzQW8wUmlFQlJtL1l0WTlxOU5UWjltL1dHYURKVUNNZVlxcjNE?=
 =?utf-8?B?SVdkTXo1Qnh4N1ZRSVByQnFzTUF6aFFEbHVoZGJrczhHMXNwSWgzVEFMTU9s?=
 =?utf-8?B?ZDhkdUFGQlJsbm94TWdTeGFZY3MwYklsWFhnVUZOUFR3Y1RUaGJjcldtUFR2?=
 =?utf-8?B?Y1lPVnAweHdBTTg2VHM4aWhBQnVCVEtHdGkxNDloZUNWL1dTRldGd1RKK2hX?=
 =?utf-8?B?cXZZSkhEWnR1dXFMV0V1NlRtYmVndWRFaXFxUzhGVUVMUnJJMStsVFUrWW9n?=
 =?utf-8?B?dFIyNGxoQVVadWR1VlI3QkgwWU9lRjdZcGs1N2Y4VEQ1bTVxdUo0RVdRNmF1?=
 =?utf-8?B?TzZpamh4Vnd5SU5TVTgzWGtycEJpRDMzOFBxZ0pDQVdMaXYwMm44S0ZacTg4?=
 =?utf-8?B?UTVWWkR5NDNxTFRqYlhPMzcvREtFZW10dkRNMWJ3S2gvTm9wZkxwWUYzNDkv?=
 =?utf-8?B?VFV0S0MxYXVyakM4QzNLVVllSlNFbno2MTFYWXpWY3V0czhUZTZjL3JGdVd4?=
 =?utf-8?B?bmZFSC9PdFFudlBpUWF4WW1Db3lyTFo5QkR1Wlg2alJSVko3Z0NTUlJJcEEr?=
 =?utf-8?B?SnN1MXZGQzRjb2NSdGwyUGRHeThkVURnT2NPaC9ZNC9JWWcxK2ZkQWZKM1pE?=
 =?utf-8?B?aFVmdnVXdTZUR2pKUGhxZDFybVlYUERlbDVUUmZFbDhGcXVhaTRUb0N5T0lu?=
 =?utf-8?B?di9rWG85aFZYQXN5UVkxWGRlMm5vb3dTYVU3b0lQb0duT2o0MWZHQ3lFM09M?=
 =?utf-8?B?djhSai9udlVTOEVSZjhCeDlnTmhyRSsrRlZSS2hwT0FRbSt2a1ZqNFVTazdB?=
 =?utf-8?B?YTQrT2N4ZG5RaE4vOUI4OXJPTE1SZUFJdU94T0VLendmbXV1UnNjdkNSdjgv?=
 =?utf-8?B?b1c5SmpWRmtuSlNxUCt6Z0t2YTF5YW1SZlZteTMxZ0RWWUFxekRBYnZxdDI1?=
 =?utf-8?B?dlBaMW9yajNpSlZFSTZsMGtPOTFJRVJHNGdoUlRiSDk1NVZoNWxreUNKZ2VL?=
 =?utf-8?B?WVN6RmFQdlMwbG03VUdodEhaUHNFajBuMU13QUlBWmRNSlViY3lVUlZKckc4?=
 =?utf-8?B?aTQzYklRUjNzV1dIa2d2MVFJRnMxa0Q1RmYyMkNpSlBQYmJjakZXbk14RHZm?=
 =?utf-8?B?YjRBdzk1N1ova3RqOW5wWGhnRWtDbnFlaElWcmhZTXlnVi9vL0lYQUpOKzRB?=
 =?utf-8?B?K0VpdCszbXNYVDJJd0xqeHZOeTNFTWZ6WENQVUQzbDdDR3JWNEs3NktERWZx?=
 =?utf-8?B?K1UrNzR5TFBMK2dEOUwzMjk5cXF0dmRHdWVTN3JwQUg4NjFORzdwU1pVS3Y4?=
 =?utf-8?B?V01Ta3JyRXg0YlFUK1ZxWTJKakpqS0F2Vnc1VTBJd2RxaVhzS0oyUzBHUVpG?=
 =?utf-8?B?TjNWczlPK1RtTE5WMlgzTWxhMFRZRkZoUlZ0RmJ3SlZrcXFEcnYxU1pvMzVw?=
 =?utf-8?B?VGZvNitDa3NDQnpJTzZLUGphdE5NV2JYbzd3eTdUeDlFQWdGaDZUSDdEcFZr?=
 =?utf-8?B?bVBoVDBhR1dNQWwyRVhMaXNsbDhrSzZsOHI2dkoxQ0VDNTNoSGRsN0p5WGov?=
 =?utf-8?B?OWp4U2RtZCtBeXU0dzM1akNNWVBnUk00ZGt4TEltTUNJZXpFTEowODdLbXNS?=
 =?utf-8?B?OCtqbVVJUkRLWk9BR2lsZnpmRzlEeUN2aWxuMHgzZXU5OFJoL1dDUTd1M0w5?=
 =?utf-8?B?NUprQ1IvREN5anhSNW8xdDBZYUJJWU0ySEZLOWs0R1JlS05nNndxTkF3UHFo?=
 =?utf-8?B?clFrOVRZUWxMckhsNnRhejZGaEJva3ZWTGg1djVpWnY3Q25kcjhQTlhWaHBW?=
 =?utf-8?B?clhKOXVQeW5IRmZBUFlPc3NYVXB0RGxUdlRDSWJPbWVJTEFDUlVvTWxrQ3NX?=
 =?utf-8?B?NTJCYk1jT2RQV0VyaGhBd3BLZU1TY0x0VXlzeGxYR1M1dDhGZWd1UG1hNHQr?=
 =?utf-8?B?WmVQU1U0MTVHbFNiU3FNTUNIeGtqQ2VJL29icHhVYnhNMDhEY1l3RWluV21q?=
 =?utf-8?B?RFVWRHVkUnBSa2tLdE1KTFphUGtuWFdsV28xT1ZYdG5wREJrVTV4Rm93NXh6?=
 =?utf-8?B?Y1NzYXVMY1NoUXpJYVJvTUtLY0laTlM3eHVDVGhZcDRvNU9ybWJxbU1EOVdz?=
 =?utf-8?Q?vwzn5Z7rd6O2zzy7pVvTEcyOB39oE+X/f2puFD4nqI=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9882db-d512-41d5-8b6a-08dc1b46a015
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:35:32.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNeF04Dn2ivHqu+uNjhDP7HwViMO1lHrxAw6zVoQlerHrNoVfScoXao3C6kGYMMkEH+izbdbq7uB5PLqRtT5ptZ+L8TPgxjLhqqFFBJ0Y1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8094

On 22.01.24 13:01, Takashi Iwai wrote:
> On Tue, 16 Jan 2024 08:29:04 +0100,
> Javier Carrasco wrote:
>>
>> On 15.01.24 21:43, Krzysztof Kozlowski wrote:
>>> On 15/01/2024 20:43, Javier Carrasco wrote:
>>>> On 15.01.24 19:11, Krzysztof Kozlowski wrote:
>>>>> On 15/01/2024 17:24, Javier Carrasco wrote:
>>>>>> Do you mean that the XVF3500 should not be represented as a platform
>>>>>> device and instead it should turn into an USB device represented as a
>>>>>> node of an USB controller? Something like this (Rockchip SoC):
>>>>>>
>>>>>> &usb_host1_xhci {
>>>>>> 	...
>>>>>>
>>>>>> 	xvf3500 {
>>>>>> 		...
>>>>>> 	};
>>>>>> };
>>>>>>
>>>>>> Did I get you right or is that not the correct representation? Thank you
>>>>>> again.
>>>>>
>>>>> I believe it should be just like onboard hub. I don't understand why
>>>>> onboard hub was limited to hub, because other USB devices also could be
>>>>> designed similarly by hardware folks :/
>>>>>
>>>>> And if we talk about Linux drivers, then your current solution does not
>>>>> support suspend/resume and device unbind.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Actually this series is an attempt to get rid of a misuse of the
>>>> onboard_usb_hub driver by a device that is not a HUB, but requires the
>>>> platform-part of that driver for the initialization.
>>>
>>> That's just naming issue, isn't it?
>>>
>>>>
>>>> What would be the best approach to provide support upstream? Should I
>>>> turn this driver into a generic USB driver that does what the
>>>> platform-part of the onboard HUB does? Or are we willing to accept
>>>
>>> No, because you did not solve the problems I mentioned. This is neither
>>> accurate hardware description nor proper Linux driver model handling PM
>>> and unbind.
>>>
>> You mentioned the PM handling twice, but I am not sure what you mean.
>> The driver provides callbacks for SIMPLE_DEV_PM_OPS, which I tested in
>> freeze and memory power states with positive results. On the other hand,
>> I suppose that you insisted for a good reason, so I would be grateful if
>> you could show me what I am doing wrong. The macro pattern was taken
>> from other devices under sound/, which also check CONFIG_PM_SLEEP,
>> but maybe I took a bad example or missed something.
> 
> FWIW, the patterns in sound/ are somewhat outdated and need to be
> refreshed.  Nowadays one should use DEFINE_SIMPLE_DEV_PM_OPS() instead
> (that should work without ifdef).
> 
> 
> thanks,
> 
> Takashi

Thank you for your feedback. I noticed that the pattern looks different,
but given that many devices in sound/ still use that pattern, I just
followed suit. In that case I will only use DEFINE_SIMPLE_DEV_PM_OPS.

Thanks again and best regards,
Javier Carrasco


