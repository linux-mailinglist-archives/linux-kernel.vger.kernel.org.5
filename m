Return-Path: <linux-kernel+bounces-65009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286FA854687
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17641F23658
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1943714F8C;
	Wed, 14 Feb 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="kSReAH1K"
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C614A93
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.111.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904396; cv=none; b=QV/LnJeLW0BrwyDi2AhFx3EK0JXCpUb/Q8kPgPFaKbRmARg0d/sN8pYunZ3ehtQdsMsqzStTstRWE7PUEqEzEf2qoEH9zkc+GLdt5GwmR3YVCQhaQeR55IdoXzWr+zeQWMXyRjiwFKtfzV184ZmcqeMW1o9o3dwjITumySKiOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904396; c=relaxed/simple;
	bh=t3lriJm+URY8fHWjXJj+9+qWOC1dAoV21v0HsBAo0HM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=D6pD9uGEmNE3UetkGxc+KEE0sdlcGynPKlmVhjf0PmNBcFpG65pQqMyt+Yz8p9nOcNS57S9jys+ZP7kLHZXvtt6HWNlhyGXqyovqbKwzhHb6B1W3/pG7wr42AJNe536+J0W3GUUxyd96HhnIsFZJxMdFULCdeFJjSsuSn1aXwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com; spf=pass smtp.mailfrom=toradex.com; dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b=kSReAH1K; arc=none smtp.client-ip=194.104.111.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1707904392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zX9LGuKvWN76JQhjsb1UwhedLGIt/TXJsjFP7Zr+GtQ=;
	b=kSReAH1KGGTXxcwftfCi+RqOxszu1xuxa1AbxMtskhvTzUN6EaxZi7+puKJ3V0kA1V04xF
	MAKjbhfvqsLNgfk6WzkLgIQUkJvPdYxGwIiIwV5xIM3C8YoQtgplfurQfxJ0pHkvjWQejH
	Fp5EIRXncQzq4hq47pYi/g41QJ3/Y6Y=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-73-ieKBLegXPKig36j6_xpTUA-1; Wed, 14 Feb 2024 10:46:05 +0100
X-MC-Unique: ieKBLegXPKig36j6_xpTUA-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 09:46:03 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d357:325d:28a:dba7]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d357:325d:28a:dba7%6]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 09:46:03 +0000
Message-ID: <b27e4519-a9fc-43bb-be6b-35d69d65755d@toradex.com>
Date: Wed, 14 Feb 2024 10:46:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
To: Roger Quadros <rogerq@kernel.org>,
 Andrejs Cainikovs <andrejs.cainikovs@gmail.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Bin Liu [EP]" <b-liu@ti.com>,
 "Gunasekaran, Ravi" <r-gunasekaran@ti.com>
References: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
 <2629cd30-23aa-4f03-8452-ae13297fd6b6@kernel.org>
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
In-Reply-To: <2629cd30-23aa-4f03-8452-ae13297fd6b6@kernel.org>
X-ClientProxiedBy: ZR0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::7) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR0P278MB1123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7256265b-02ae-4925-acf8-08dc2d41c1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: gXL0XxBVOVamm9JultX05rs7+sN9QUjkAlqkzu+vn4CQCEgX8uYjH8dNAewYwCAyVJukvyACK7Xe5TC5aGi+Td+8st7xm/9kgETeld9NlVk89sBDsUqktU2cFNI7F3mzXanzCQKW6PVoYvq9HV/83cNQc/Pn3aOjiovG7pK+s6vwFgT7TfAO3hEZaD1idJYzy3CjZrY//NL9y/im/koGAAmZwArU5Sm3KGgAth/t6sOaWxp7l47mbqQzCoGD9qfFfVSz3sxK85WI+q5q2fKfPKYxcjxT+1gYfctVsGsgiNNo0AWsWgL+PnVQ8ZWhvPU2IYNBCe/7x9yzUDTDaLLo2ynUm706biK0B8GrKWpiW+HZ78NXIAL022Q4dUGMAimZnoEI9AkcACtczfL8PlQhjsyeJ99uHjPrplPvUDu6qVRRk5WF1JeP58UjnkedeA9dJtgPeBMqiwGgjrrTs1+BNudKEcsWub1ILlCxYxMrpZm6Kp2/KbcMRBmxbWrtRQKvBM9ObiYjtnlHfzDd/q9boJd00z9uCXCAV70KMvi+h86UnudRwzrsck41vc2tu8CTONl0XUnUwfbA2Zy68yMa7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39840400004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(31686004)(4326008)(8936002)(38100700002)(26005)(921011)(41300700001)(36756003)(31696002)(83380400001)(7416002)(44832011)(5660300002)(2906002)(86362001)(478600001)(2616005)(66556008)(316002)(66476007)(66946007)(54906003)(110136005)(6486002)(966005)(6512007)(6506007)(53546011);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZQeCtZNkVrUTduS3BSWmxxVnRuWnFqRVF5R3d1QW9GQTh4bXJ5T1l6c0JN?=
 =?utf-8?B?MVZBUE01alFWenFqUFppY3o0YWZQaG8wR3RJWUd4U3UwL3FpTFhDYk04V0Q4?=
 =?utf-8?B?WHZzOU0yZEZiaStPbjFsTmpjRFVaMjdnNms2ZFBidG4yYXFJbnlKUGYwaE5L?=
 =?utf-8?B?clRDbWljNngwMmg1Nk1TUWVSK29IdWlDV3BkNnNSL2NhdnRGUkd2SWFQeDRi?=
 =?utf-8?B?T1BObnhBdEppR01hUCtOL05JTFAzU0s1a3lubVhPR29sUlpwOXZIYzJGY2d4?=
 =?utf-8?B?NEI5MnRBTWdFRVU4Ym5CaWlqQThaWENTZE43QVlzRmxLNGtrRlAvQ3pzZVlM?=
 =?utf-8?B?VWE2Qk5yd3VXMlN0ZHUzM1NoSlFraS9TMythb0h0YkQrTEtWQWJ5UEtITTFU?=
 =?utf-8?B?Z2s4V3pYZEEwUDlLeUcvZVhqV2F6R2hXR1dObnAva0wydjYxaWRmWms0Nzlv?=
 =?utf-8?B?TEFQVytTQmFtTUNENGpvcXMyeit3QnNHeEpod0g3Y2NPTVRnZk9IRmt5Slhs?=
 =?utf-8?B?ZWVJY0FRSEFZS0x5dHlhTUlLNXNwOGFmMEplMEpxT1lxSnhZUldvN0QySGc1?=
 =?utf-8?B?OHRPK0JiQndzN0sxMnhFblVCN0ZpOUY0bExVL1UvcVNWZ2JaNlpXVHpZUjVi?=
 =?utf-8?B?WXM2UjBkZDBHK1JDcTRLelAxcjAvRHpzN09jTmZPOE41NUN1eW5XWnprdms4?=
 =?utf-8?B?L245SjdiYUxkVWs5WHlSTzVUdDFtV3lrR0cwQWhNYW9XRHlwRUxmeTNqeUYz?=
 =?utf-8?B?dFgvMVJOZEJEL1NHbzhzUUg5cElPMUVnNzVCVHZ5TU50YlRmalN6Y0gzbjdp?=
 =?utf-8?B?THZ1SGlpR2VwSngyUTdVZ2c5TGdvU3RDbXUybW93VWNXZUhjdVROVERLMmJj?=
 =?utf-8?B?cERHdlJKYmZ3UjcyeGszWlZEdGtuTndRaFNnYXBVdTF4UnA2dGtTc0dFcnFF?=
 =?utf-8?B?aWdwejArSHU5WE9CY1pQQWJHVW5ycUl5aWFYVGlkV0h2V3JzU3lRZGZmcEVQ?=
 =?utf-8?B?dFliZWlhZlZyZmhvUUc3YXZUNm5jZ1FYclU2TDlYd1pVeHB1VnhMN0FPMDFi?=
 =?utf-8?B?NzBZL3NHTUtsTmN5OTE0azZtZjVHaFdKcXl4bDI5OUNFcjFweWpidXdDZEQ5?=
 =?utf-8?B?c2NGc1Y1SENrR09pKzdhQngyYmkrS0plSzUrREQ4NHdzbEw2WGlnN1MwbXE1?=
 =?utf-8?B?ZVdQSTNjVnhiMEpyU2YwZ1dickhacjNpMkhsajVxdGNnNnJoNEtEQnJBbUhj?=
 =?utf-8?B?bnZSeE9rTHNudzJUWi9MNUV2T21XYzMwNW9wK0NjOVJCMk4zR2luV0U3TzVG?=
 =?utf-8?B?d3ZBaEx2L3l4ZHU1cmtRbVJWdk5WRE1oYytuZlAxS0RlaHRsR0lteGRPRzZu?=
 =?utf-8?B?bzA3bjNNaVFMT1Z3NGQrWlcyNGR4MkpLLzM1aDZueVFlWVJ6NDVycFBGZjNr?=
 =?utf-8?B?czN3d3FZUTNvNC9LMXR2UVBmU3hTWkxIdDB3MGR4ckhUb2V3djdxTnFzZ0VV?=
 =?utf-8?B?MFhlSGttL1EzSG94anRYVVJReHRJNktRNmpYbUVlVkx1TlUydXZSck9paGpi?=
 =?utf-8?B?SUFKdDFldG1VY0xGSWllVGhoN1ZiRzJXT3h6blVwcDlsVTlvYjJGcHZWTmw2?=
 =?utf-8?B?eHZQQjZPUTdZbXZmQ2tRNHcwWnFYblh4NVFPTTljNUI2aUw5cHN2Ym03UkpL?=
 =?utf-8?B?SHNRVmJXV094LzdzbmZUWi9wcUNieDhFQWUzek5Ub09aM3V6V1U1ay9sRFFj?=
 =?utf-8?B?TjhXM1hPaUlvSDVsaGxjeENoaGZqa2lEdGNqUGJwTThDZlI3Mi81L0JHcnRG?=
 =?utf-8?B?ZThLTUt4bE5uODIvckIxNWZmZ3N3cm5tY3paVENGeWxjTlNnSFE1UFNpOXlB?=
 =?utf-8?B?cnpoWHBDNFBaSHQybzFyMVJVOVVqbkF0cWFBMGpneVZVenJrMUNhMklOZHNP?=
 =?utf-8?B?ZVlyYXFRc2hQZDFhbE1SWVNyN1R5VWVTMmRxZmhTckN6S3hJWVRld0JkVkcv?=
 =?utf-8?B?V1JLeXZLeGRBSXJJS2hjRjRNRUFpeU5IMzBYWTU4NzBRMHJ0V0dsZ1ZDUVZF?=
 =?utf-8?B?R0VCYldnTG9pTUhFZklMVDNiblhZSlJIYlhUTGNWaXZnQlFxZ29pM1dUa093?=
 =?utf-8?B?M0tEMnpzYXpRMDllZjZXOWMwdUtvdmVHaGJFK0J3SHhOMTEva3d1RG9uS25H?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7256265b-02ae-4925-acf8-08dc2d41c1f4
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:46:03.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkJIlU/+K9cbal1zn7Wb9sh6oOmwWeJkDJhe5haNFxuwuJodQupxumwzB6vfv8mFUj5WYow2+oCweBSZuY4NwI06jp7FqzTqHkIxTES41xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1123
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2024 13:13, Roger Quadros wrote:
> Hi Andrejs,
>=20
> On 09/02/2024 15:02, Andrejs Cainikovs wrote:
>> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>>
>> AM62 USB works with some devices, while failing to operate with others.
>=20
> Could you please share which devices failed to work for you?

Hi Roger,

This USB memory stick is the one that is failing most of the time:
ID 058f:6387 Alcor Micro Corp. Flash Drive (DigiKey 1GB)

I used following test to reproduce the issue: boot without any devices
connected, once booted - connect to PC for gadget mode (RNDIS), and then
unplug cable and connect USB drive.

I did not had any failures with this USB memory stick, btw:
ID 0951:1643 Kingston Technology DataTraveler G3

/Andrejs
>>
>> [  560.189822] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
>> [  560.195631] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigne=
d bus number 2
>> [  574.388509] xhci-hcd xhci-hcd.4.auto: can't setup: -110
>> [  574.393814] xhci-hcd xhci-hcd.4.auto: USB bus 2 deregistered
>> [  574.399544] xhci-hcd: probe of xhci-hcd.4.auto failed with error -110
>>
>> This seems to be related to LPM (Link Power Management), and disabling i=
t
>> turns USB into reliable working state.
>>
>> As per AM62 reference manual:
>>
>>> 4.8.2.1 USB2SS Unsupported Features
>>>
>>> The following features are not supported on this family of devices:
>>> ...
>>> - USB 2.0 ECN: Link Power Management (LPM)
>>> ...
>>
>> Fixes: 2240f96cf3cd ("arm64: dts: ti: k3-am62-main: Add support for USB"=
)
>> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-am62-main.dtsi
>> index 464b7565d085..c49fbce5cb70 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -640,6 +640,8 @@ usb0: usb@31000000 {
>>  =09=09=09interrupt-names =3D "host", "peripheral";
>>  =09=09=09maximum-speed =3D "high-speed";
>>  =09=09=09dr_mode =3D "otg";
>> +=09=09=09snps,usb2-gadget-lpm-disable;
>> +=09=09=09snps,usb2-lpm-disable;
>>  =09=09};
>>  =09};
>> =20
>> @@ -663,6 +665,8 @@ usb1: usb@31100000 {
>>  =09=09=09interrupt-names =3D "host", "peripheral";
>>  =09=09=09maximum-speed =3D "high-speed";
>>  =09=09=09dr_mode =3D "otg";
>> +=09=09=09snps,usb2-gadget-lpm-disable;
>> +=09=09=09snps,usb2-lpm-disable;
>>  =09=09};
>>  =09};
>> =20
>=20
> Instead of this could you please check if this series fixes the issue for=
 you?
> https://lore.kernel.org/all/20240205141221.56076-1-rogerq@kernel.org/
>


