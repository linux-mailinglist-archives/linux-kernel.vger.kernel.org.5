Return-Path: <linux-kernel+bounces-38055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7FB83BA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956811C23323
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676810A29;
	Thu, 25 Jan 2024 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="m3FKd5PF"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9711183;
	Thu, 25 Jan 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165639; cv=fail; b=Io5Hu7fWbPr5COiIBn2ghROtRVXE+zbVqUzkoVQkYAweK0hi52MBVwAq9vYKaDbfGro0ir71ah2DBBcHHU5ofOoJgZawepr9ahXJ2+6sogQzM1w+H0CdahQPjfZsZDWEDh9D/pWKXo1V3MW/T9MLztj9rCCcc02mghEucubSx+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165639; c=relaxed/simple;
	bh=U9QHKCX2LE/sc+h+sngfMzirOGUCF2J7SqQCWHssA5I=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOlF7jyiCx/qWceeygAuVCPdX4czB3fvh7Lw+xQS8toB+sj08gKzmG98ZgzETlPSzbSH7QM07hn6Ks4oiYYN+YEeY5VMzs0otVZ6haPxngCXLw7dOdScch6+RCpUgOCxWS1QYicoeDlO/XDH/eJifRGJLahwh0obAi8ktx5nfhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=m3FKd5PF; arc=fail smtp.client-ip=40.107.255.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BK1RQYkZaeqbIjBnKnoWeTzDYAWPjjwho+nB/gn1GvunvyvZM143H0jEHXX1TteuA9gVo7/3EP2x6GHjcpjSmgg7srB2Av6WrtuVRRldxicji1veq1/xqmmn2Phksu/V16PQIRH6MOUiIdTeaL1r9jQeHX6b1mztkvu8CJJfRfr6e4veDBZkAoyNiPfzgLcbf1v3HeVw0pMmV/Dk1uimSRxUHyTanIdzOdgZCrvNMpQUH8OWNIu4rcvsqrsu38xV70A+4sk+V6gc0NGzTNzMWrF3OYeJOJKGVtmKS79quttfUSR85jDRu8bKsH/1+BwnqiUryqTxwrDpsS1v+4vscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHXGpeSObhmcSLNQnnT/spDPJj19r6OYUOIBEUEkAlw=;
 b=S5kK2OXE70q3yhxyxq5s0HFf16/lVwNa7Z6HRatOY3Wi6E/emE0SGfsbVqw+VqzFsudaFP2mG7/Q1PwZVhbgfuYTbRNQ/cUjJQw16aUnbA/8SiIuhrr6h9m9PorDY7FxXaw8jJgiwCqRaz2XJ0FkPzgLmJhl0obhN7NXCym5IXaskiavpM79RX87c4IOt1VSQJRVWiAQo3+mEdxpTsIMrRiatT7l5D9zi5bjQHDVf6E3Qcwcyb8fOeB5wa1JhqGrfDvLs0LNrsb0g7PIc2sLbXIXAuJyjzPeSWySOdTvzvYZ9HeqwBFK41ympmlWgN4w/qH8BWh8OvORivYcWPnRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHXGpeSObhmcSLNQnnT/spDPJj19r6OYUOIBEUEkAlw=;
 b=m3FKd5PFD1Um3DlReielKGPgw7BUVHXgHqz2uiCOKpXyQhoqjlDg5nWHAOk6E/HG5eTAr7jVapyutoJQjeXmzJWJseu9oC6Obz5TqS8kbT1aQyn+0lSFKs812/H/bM+9wzpZhf04ykSvdZeZrc3Q1ygTff7r/Fn77uC5BMvoGhQitvnfjLRLw18FmGaaJbUoNsL9yh1ADm06kqzMWFulgD1ezVG2Kv26uLnhe0WBTqeP5CAE0k+qCcSOa6Gm8Ohp7KFseSFAA4Lkkd8qWRV2D/KoN+Hbb3gMV4FfuBhH9CLi9gDdTSrHqEBg7xcpFTzIGuPXYhvaVDL8e0Uf1kt99w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5732.apcprd03.prod.outlook.com (2603:1096:820:70::7)
 by SEYPR03MB7780.apcprd03.prod.outlook.com (2603:1096:101:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 06:53:52 +0000
Received: from KL1PR03MB5732.apcprd03.prod.outlook.com
 ([fe80::d8bc:1799:661e:dc86]) by KL1PR03MB5732.apcprd03.prod.outlook.com
 ([fe80::d8bc:1799:661e:dc86%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 06:53:52 +0000
Message-ID: <6ee50584-38f8-4c34-8b54-4ee6af4c3906@amlogic.com>
Date: Thu, 25 Jan 2024 14:53:46 +0800
User-Agent: Mozilla Thunderbird
From: Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 5/6] pwm: meson: don't carry internal clock elements
 around
To: Jerome Brunet <jbrunet@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-6-jbrunet@baylibre.com>
 <gyhea42rtydw3g45lfkfbxfm6xcbwibz67vw7xke2sm7powz2a@i33g4pyanu4l>
 <1jttn3w0ja.fsf@starbuckisacylon.baylibre.com>
 <jlrptw2norojxgpfmsybv6b5aq3epkdkqvri2l2rkvtx5qofjd@q4ggezt47a42>
 <1jplxrvyin.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-GB
In-Reply-To: <1jplxrvyin.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY1PR01CA0186.jpnprd01.prod.outlook.com (2603:1096:403::16)
 To KL1PR03MB5732.apcprd03.prod.outlook.com (2603:1096:820:70::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5732:EE_|SEYPR03MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a3964-44dd-4c0c-a99b-08dc1d726426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tZC56CGuT1Ty5SPcSfcAdg4BGbwIuABh2mra9WvniEEhRSnggtURvqO/wpwRdkDzmY7u7d5x4JY4xTs7W1sZGzwkjCzQMYhtZWWJ+1krMn2eVZ+h8ZV+bf9MFyKa8eEeelbrK7CtDy0/9fSbf0qQK6PTDAt4zvjYkTRbR65vCzhLvnwL434gJC9JEhuAMoEIYJwaLJEqh56nY+R9JcW/Zo23xLPDJ/Mc12a3Ldr6WepEVhZQYytbX6svXsHn2c4ttNdowDNrzZ9Bxm0ZgWThXd7cDcAWfkO6Arz3D8pM/f60UMykFbX2IN1Eh6v4XA4Dlygg8V8fxXJkuesluQ1t85NCCF452qAkfWaEzEwPkecqBtTagwhLliU2tu4W0IlaMJnwSbJX0TOfw8fgF436hn6r4Qzj34gWlrpuSe7xKZRl/b5HNQcsyMaI6SM6oKGJp/TZ0SNz/bVTJErV+MU6f96y5KSIGXYK0zIV4BSqAk9FBWjTqDfJEKfW/n+L3/i2KtmxHAdbg0CRG98qDeGs0HQdo5a6guu0thtwQHm/n4v8o9xFFcQ9/FMOi7q2AH3xQA8xjbWRJlclxTtksTwkPPs9eB0T7QWtaC3sw3YiREfekZOXnvewgzUCZpho2Fc5bQjlex1u+ajI7eyStrnAr1AJ/e+jwu2wvOQjRvUc1Pa/m/bhhpYGrcTg07uNtaV/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5732.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39850400004)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(316002)(8676002)(4326008)(44832011)(8936002)(41300700001)(31686004)(2616005)(54906003)(66476007)(66556008)(66946007)(26005)(36756003)(110136005)(86362001)(31696002)(6506007)(6512007)(6666004)(2906002)(7416002)(6486002)(38100700002)(478600001)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnh4VkJra2tDb24xYjlDNk1wb3p3TERSRGxuaFFZVHorc0d0ZUUreU5STVUy?=
 =?utf-8?B?QlhhaThZTWY3RHREblRiWjRPbFppbCtVcnIxQ3Z0TFB1czkzbCtDZ2N4Z3pp?=
 =?utf-8?B?MjNoaitZakhjeUZnQ3QyVjlLRVEwUTR5aHpwUDBxdmRHRU9JRjY1enRBT1VW?=
 =?utf-8?B?M1ZBcmtTNDNyQ215cWFCcFA0OVR2TFdweDFxbE04NzUvSzUwWVFWRWxCOWdB?=
 =?utf-8?B?MXNIVmx0ZzJsNzJFS3EvejBwOGZOZ1J6L1hDYmR4K3hRcENqTmMyZThXdTBs?=
 =?utf-8?B?VGNXY3lDd1Z4Y082blNkOGhDc3h1MFV1b2ZpM2MwanA0aFlCbVpRZ2M2eXo1?=
 =?utf-8?B?YjJhZ1B5a0V0MlBETU5EOVptUHdVeHorSnlhdWZ1aHhUS1hQd3ZwOGRHcTln?=
 =?utf-8?B?R2h4cXVRay9tNGpkUjRGalFxVWovUW44ZDg4bWZxVTNGV0t5OVZ2VE1IeStr?=
 =?utf-8?B?Wi9QZlZXbHRUYjJsUEs3QWlkeVVjVGgyazFkUUtaQjZXeDc5S0hzOUNUdG5t?=
 =?utf-8?B?TTVWWS9lak9sMXFDamVkYXZKdHdmQ0RRQmNSUENKbEpxeE12bW1BcnNWL3BX?=
 =?utf-8?B?QW1VSkpaT1FEMnJ1M09oUDBzd0lpb2RGVVBMTGpuby9tdElIOXFXWUFJd0x0?=
 =?utf-8?B?dzFoV3JqOE4yZmpwcUVSQXlFNG9rTjdYVjhLVkNtbGlOZTdLU1pNMnpMckI3?=
 =?utf-8?B?KzlxVEducjV3aUl4ZmRRbWNSZWpGTE5WSXZRcUc0dHZMUHNXNFBKS2xML0pj?=
 =?utf-8?B?YnVaWDNqQTFaci9laFVoT3UxRk15OVJpOHZMUUd1aUFpTmtyMlIzaG56OFlF?=
 =?utf-8?B?cU9xMVJreWZwZnRBUzl6cm0rUTJBZ0R6RDZIUkoxdnNqUC9OenlRbmhnMlpt?=
 =?utf-8?B?VldndkFVR1FHaXZsQldDTE11RnQxTkpWSzlJbEFIUmY2NzVrTUlOMS9CRm5L?=
 =?utf-8?B?N2V6TU1Ra1VWMDZZWGUwU0pTaGlpQmw1L3JQN21PWVo2SWh2TUxqVlZueXhv?=
 =?utf-8?B?RHYyUEtJZTVBWC8zQ0QwYnYwVUxiNDVNd3JHWldHTVVqME5iT1NRMlEwSlhU?=
 =?utf-8?B?OUpGSFZSaDZqUFJrclRlSCtWVFc2RkVPcExWTjBMbXRuSDVWTGRBbzJKeS80?=
 =?utf-8?B?MUJ5VVdpbm1TUTU0UWg3ZTJYUlQ3S2tNWDhkcXM2U2VVQjlqakgxb09rMU1m?=
 =?utf-8?B?WDFRMWpSNzdGOW9YZkRLOTZucmN2R2RoMVhzK1ltZ2N0UlMyRCszSlZCenJ3?=
 =?utf-8?B?bEpGa21IN1RTSXJFdHNYQXdXN0ZOb3lBQVJrSkc5QnRNa055ODZPYUlFZkNk?=
 =?utf-8?B?Zy9XejI2aVRESGNhSkw2MnFsM0ExdHEyUFVpSWxRNWo1TmVFdm1sQnJGT3VH?=
 =?utf-8?B?dWRZYVVQbTZSV2dkc25NdTlabjRlTnZYMEZsNnNqcG5oMFNnRnRud1R4N2hN?=
 =?utf-8?B?THJyVUZzZEZKNkNUN216OW1YNmlwRHltQkIxa3AyK0JKQlArUTdReXVWUzlh?=
 =?utf-8?B?NUlhRDAvY3ZlT2swb2YxdXVna0l5UHorSUZDclM4OUZEUXcxblpQL1psa1Jl?=
 =?utf-8?B?aVlHMTFkci9xanVWbzg4NWhGTm5Yc1hSaytPQVJVYkRwTnVRTVpCbEM0b1lI?=
 =?utf-8?B?TWxjNHZZK3NOUnF5KzJmZUJoVXplRGlNUWdqOVFVYVBSanpsV1B5ZFdqcEhR?=
 =?utf-8?B?REZ2QjR0b2UrT1VXSHRJQk1xMkFWMFFmRk01bDlqMTl2bXZNNno3MzRtOG1x?=
 =?utf-8?B?TFVaMGJJWEpNYXMyaElHLzlESU5URTNmbnJEdWRrbHRoOW15YSsxbGpRRDlh?=
 =?utf-8?B?VGF5V1JQb3grNFNhMlRZakY0Z1Q1STYvVWhzZ3FhcHB3L0J3SXkwS0lhN2kw?=
 =?utf-8?B?enVrNFJYYmQ2WG56ckZBQVViSHo0NnREU1NxS3I5cnVReFVuOVJSL3g0K1hl?=
 =?utf-8?B?L3RKNVh6enQxVFd3bGFtL3VjNWF5VW5aeFJxdjAzdEFhSEN1N0E4TVBjcXFL?=
 =?utf-8?B?MThEMlBsVU1FQWJaOUVmREZ2MGJRbTJFa2owUVluL0FKUnVSZFNZWG12VkhG?=
 =?utf-8?B?Z2pwYVJ5ckl6dHpSOXBqbmNWbDVaaVM2ZkFwZFp4djJoWjFlc05lTEkyWlA1?=
 =?utf-8?Q?hVJosRjUd8SLsZDjvAGVd7wnZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a3964-44dd-4c0c-a99b-08dc1d726426
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5732.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 06:53:52.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/2cW1mGaOrray2ftp+wYFBg8JORagDBj4SyEEen5HotY57C6lYzvYNik/VHAn2EWHCV0U+2M2Sm0aaxxVFf5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7780



On 2024/1/24 17:59, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 24 Jan 2024 at 10:48, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
>> [[PGP Signed Part:Undecided]]
>> Hello Jerome,
>>
>> On Wed, Jan 24, 2024 at 10:16:17AM +0100, Jerome Brunet wrote:
>>> On Wed 24 Jan 2024 at 10:02, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>>> On Fri, Dec 22, 2023 at 12:16:53PM +0100, Jerome Brunet wrote:
>>>>> @@ -442,6 +439,13 @@ static int meson_pwm_init_channels(struct device *dev)
>>>>>            struct meson_pwm_channel *channel = &meson->channels[i];
>>>>>            struct clk_parent_data div_parent = {}, gate_parent = {};
>>>>>            struct clk_init_data init = {};
>>>>> +         struct clk_divider *div;
>>>>> +         struct clk_gate *gate;
>>>>> +         struct clk_mux *mux;
>>>>> +
>>>>> +         mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
>>>>> +         if (!mux)
>>>>> +                 return -ENOMEM;
>>>>
>>>> I don't like this change. While it doesn't increase the memory used, it
>>>> fragments the used memory and increases the overhead of memory
>>>> management and the number of devm allocations.
>>>>
>>>> Are these members of meson_pwm_channel in the way for anything later?
>>>
>>> Not really. It is just not useful on the SoCs which do use it and not
>>> used at all starting from s4/a1.
>>
>> This remembers me about the old pwm-imx driver. This was essentially a
>> single file containing two drivers just because both types appeared on
>> imx machines. Later it was split into imx1 and imx27.
>>
>> I didn't look at the relevant differences between the existing driver
>> and the changes needed for s4, but please don't repeat this issue for
>> meson. Not sure this fear is justified, just saying ...
> 
> Noted. Don't worry. s4 is indeed the same PWM block as before, just
> mux/div/gate migrated from the pwm IP to the main clk controller.
> That's all ... I know ;)
> 
> Only the clock registration should change and simplify.
> 
>>
>> Best regards
>> Uwe
> 
> 
> --
> Jerome
Hi ,Uwe and Jerom.
Compared with m8b g12a and sm1, s4 and A1 are new pwm ip that moved 
MUX/DIV/GATE from pwm chip to clock tree module and the pwm block are same.
About new s7，compared with s4，one pwmchip corresponds one pwm channel. 
Like，we separate PWMAB into PWMA and PWMB.
Here is a version from Amlogic. We will start the following work of pwm 
driver. Welcom to give comments.

Best regards
--
Junyi

