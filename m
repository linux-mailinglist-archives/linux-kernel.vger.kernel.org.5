Return-Path: <linux-kernel+bounces-32710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81B835F33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBE51C219E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40DA3A1AA;
	Mon, 22 Jan 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GMUS63JJ"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2066.outbound.protection.outlook.com [40.92.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BB39FE2;
	Mon, 22 Jan 2024 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918298; cv=fail; b=IlL9wVIEGvLe3WY+jvm6+QctO9Ns+ImYfghx1744ClPMSYmahUhQVJMrGSP+ql614A4V4wYVgZLLLz/o1fJSJZeuFw4Auzk1YbpkbBybxGZqGCrNpQwO4C7Jln92bXNI8+PtHs81QNd+v1W3FErR+2RTz52Oc93PhCTBfh962T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918298; c=relaxed/simple;
	bh=VCBaVCzDV6K55DRCttt2S3ZCHo9ve0utSKJh+SyFjNk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJOJSZm8bWnU91fkKPO2DQ9WhWai5FnTPYIpeYuMANu/r7Jai4A3iacywG0BknkXQ7Eq6NJR1Zh3ZBvpfDIUJ76ayHTRwAb7OKiVv6ZXaj8tN/X4z95qoPl/uaYJS1eZMd9BVFWrgNbnYW0rJtQpZXx5HKX9IiRkIZxgBIPLs8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GMUS63JJ; arc=fail smtp.client-ip=40.92.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSQ8FXApYv5tXkn+mvPY/mM2tcioQXdIXOl7Tdpwr/O7liW4grBw82dTRhKCc/dbG73/DOv56tG8nn0bE5tAN7PiGHIQeO12awHXMSzGWPbVGgGqHCwOe2nwOsunugUnIJXXy21MYjqTwnw33vHq94D34FZ9FteBtXWGH6mPg9Q5Qd5mFWRN1xIwwiBHlUUgonsy8FlSwT9b52Tbgkzh8OYidylrxI9OxYkTLKi9X/OhDb82tau0BQnxG15Jr9vhkgcFFp4GpjVy+uNTgY1dHGOvx2cSTjxRB11WiQonYpqNuc1u7/aX7fZ6AZ08XCVm13LvmAdPGAgKBmUIJSUusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTokLvTji4opG+w33J4WtYo7phhifYrfwZVWc2XLfYQ=;
 b=UvjcUnFOD6q2mww2f3McOw7af/PXHL0v2QRn8uKojPvu4YGNOwNUpQiEwpU5RvVoHMr1AdCOAWBfSpOy0Lb94JMGtIiIOOdxzg5a9N9VTtKge8DcN/N2GuVRRiS4kHb8ceuf0yrWGlOCpz56hilcdpFRUzn4OgwRLJPvyHgHS6Y9qJra4YLmxwLKxW0N2vf58EanzYCQLaZ+bGqMmCu/+3kPts9L/5Tqt1PTEEaS7T0lVd/psLUq8kC6HSHmGrorbw7VgGYsy5ZqHS43RfVAO4A7VmFu5Nk0z3D+nQ8+SBwWDZecoZPGLCGkCOC95Q/4RdISnv0BdcbrqkU+TRP/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTokLvTji4opG+w33J4WtYo7phhifYrfwZVWc2XLfYQ=;
 b=GMUS63JJXhSRGZohAjaJWBqw1mUdHyN+n+ZkoZre4OFAqtwRoiQjza+M/WJKUITs8AzG4DpSpMKHLIgQtTSPN7v1qBKXZmVVM79hdR2Qa6YxNYg0f0pl3VPHpnBQqUriZiNDqJwZTqZ3KRCzjKhigacC6M41LIXfQ/f+zOpGzQTjyCoqkiqDFv8/+tLDmDFuHHGqNsEFwy4kyI3nbrcvGmXubvMP9ENyqOvaUvERRFqYOXI3zAbTPC4ZWKX7iw/q5RMu/hjp2ePt0+beoDSpH+K85Tt/QcE1npilQZ06haleQOo+pzR8u6BIQMYrThxEnTe1b7P29nEGMY4JcsEv9g==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB2152.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 10:11:28 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:11:28 +0000
Message-ID:
 <MA0P287MB2822BCB4E43BCB495FCF9069FE752@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 22 Jan 2024 18:11:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system
 control module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1705388518.git.unicorn_wang@outlook.com>
 <598b1026fdf9989bc48e5e10d1034b37947d3b80.1705388518.git.unicorn_wang@outlook.com>
 <f4a46311-2e12-458b-98a8-d3caa2c95517@linaro.org>
 <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB2822FBA18674540BA85035BDFE712@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <c9feb32f-1efb-4613-94c9-9d6bb0f45366@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <c9feb32f-1efb-4613-94c9-9d6bb0f45366@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [n3fkDQygIzdUiN28vMEsfXKhKBijUAwV]
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <06dac627-f144-4ae0-a8df-fbb494aec2d2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB2152:EE_
X-MS-Office365-Filtering-Correlation-Id: a3195ace-9d73-462d-5c6e-08dc1b327e57
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Toi/Y6h3G7mQdQiMSEBZy8diE/K/CAs5CpGBXepi0GDTG/ZVhsN6tuhT2lStXx+9XE/C1ExnHc7RuSnM+nBZHgH+8Bho4Sd5UnYGXLoyHPyZ5dj1LEUTc9NBGaeGNS7hWNwMocc707O7zncMDr2vWJkB5fO/C1pE9A21OoiIglPg6dqs0HcrEe1O17wtBjTY6UwFBS5L297bkAtT+3iPVidOhzjQj7cRQoQ4KBsMysCkvCJOoi9pNoG/B6xCflCaQbMgIfjO3OC22aWCHJRsccGXp28IphX8Bh+/8dmpOpSzufbSS0Nu6qx9NSkcJHRNZgYzlEFAIFW88jPDZ6SBELhb7xmOiyTkM3os6xdn80XQWqfEX9zF4O/HNQukEXHXtIvDVk/EmkttyiPRHyu4cxXDknY6eFUwkngyxIhxjeQzvihb6CX6kI0lKGehhAZ3bXaWnnjI6DoKUEzh1JIq9rmrAx1/ZId/NysujmiL5Ie37DlSkDnHS/76BCozpLYqkQvvrEvk5+P2C6ib0qouR3HpRjHPZ/pQqXM0rLkrciD3B8KcKWfckhCb2LaAwUNs6QPYLUgruEo0NvioWi3mYJ/lKIrQLK+CoP2rrtzOye64U6WbVwNiEi7TVwzLYRmfe912QP3OKsn/iBX7VLjnbQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxkM0R4bkNxUnB6N1hEMjBvMy9rcEovd1NCZ0xtNERHalZ4dmhtc09IZ2lW?=
 =?utf-8?B?OHZHQTM1THJMMXd5cjJaeW1iYlVTbzZIa1h0MzJWN0w0WEVSVCtFd0FzK0kw?=
 =?utf-8?B?clZicE56ZHExV1hvbnBLblhCL2ZGZnlxc1dZNW1XQ2Vwc1dIeGhyK3AvMjdO?=
 =?utf-8?B?UVF4WHBnb3pBaUdlS3RZM2pXRmVpdjJqZmRNQjJpdzBVbFZEZzBHT1Y3OUw2?=
 =?utf-8?B?cVpWM244T3dhNGpJVXJGaDhteXg4ZXJrNm5UQ2xZZTBRMkU0UnFUY0hoWXQw?=
 =?utf-8?B?RDF2bFBpMzkram1remRDM0djbGxJMXNFQUs3NGVxLzlCa05kWVNVNHd6Rk00?=
 =?utf-8?B?WC9PbktKYVF1bTUxcjZ3V0Y2RzYyWWp4OUFyRXNmL2lzdGVxdGFmcjhQNlNq?=
 =?utf-8?B?MEpvQ2Q3U29xY0h3bEl3Q21GWFBObnJ4WjdkYU5ja0h3ZjVjWEFpaFFDamFN?=
 =?utf-8?B?TndEZ2c1RUxHR0ZlVUZuWVFUV05ZSm9ORVlmM1UzZ0U3OGx5TlBSSkt6dWE2?=
 =?utf-8?B?NFVVYVMzOGR6enpvS3ZCUzNteFArWFR0ZjdBUmY0MTQ1QzhyY2tWOXVFaUZM?=
 =?utf-8?B?bi84QUJRbGV0V21NbkljbksyUEplTW9wZ3JLUHJUUlpVaE91SWVFaGV6dkNh?=
 =?utf-8?B?U1dialVrL1dSUjdpZ1RNL3pEc2xXNS96bzR0NW5LQ0VLMk9GRHJZbERJT04x?=
 =?utf-8?B?ZTBnbnZTaWhHaVVxdVMxSXZVakhwWFBLdzdUdWdpLzQxQ0FlYlFZRkJkZ2Vu?=
 =?utf-8?B?OTNXcXBxVXgyUUZnN1VqN2FtcC9zSTZoODJMYjBmU0c5K2JSZ1BGd2k5eDVk?=
 =?utf-8?B?TEprOUdvRGdQWTJBMVdJWGhHMW4vdWNyekk5Q3BpQ3JzRFVMdkJHOStya1BY?=
 =?utf-8?B?VW1BWTVVRWhUOVpyNXA1SEkvSE9wanVtcnludm04RHBHMUV0MFpVaWZqQTFI?=
 =?utf-8?B?eGFrTVpRUjV5NEUvU0o3bFNJbSs1RFdaZXg0dEQ5TjZmRHRHMUlQYTg0aWFI?=
 =?utf-8?B?WVZhV2p1d21yVkx2dEVGZkhCWXBWdTl1dlZTbldWVHVkNWdFVUQ2TkFwQ0oz?=
 =?utf-8?B?WkZ6SEcwNjF5YjNoekZQS3Q5QWV5ZUwvbTdDV2Fwc2xsV0lQcTdvNlJhTzBo?=
 =?utf-8?B?YkRsZkIwUVRWdVZXUlZRUFI0a2w2cVc0eFR1NUtjT1cwbFJTOHdKZGpWcmxJ?=
 =?utf-8?B?UTBtMXc1ems5b00vN2ZjMWdyNG96aGZMOU1OU1F1K1ZTazNXcW9teVJQOWts?=
 =?utf-8?B?RnZXdlJzSS9OUnlQWEplRE0vZUlIYnowb3pjNndrVGtRT1lRYWRuNFJoMndm?=
 =?utf-8?B?VG4vWWZieVpzVlFVLzJML2wrZllCdS9pYWozdEQ2YkhYcmtWU1lPb3hiYitE?=
 =?utf-8?B?bk9tR3hNdHB0cXpMUzZnNjVmODZzVTNtUjM1ci82SmpsQko4SDhVaHcyUmJZ?=
 =?utf-8?B?OVhTWkFKRWdDQW9vMys2VzF5TlpWRkpWSmhWYUJhblJTYURJWjcvTlN1NWRi?=
 =?utf-8?B?SUZBWjdUbnRaZm9TSnNsdmEySy9tT3VBekYzNVhkYi9Fd3BKRGpXSGRHZXNy?=
 =?utf-8?B?ZzVhUmhTLzVuZjJMcUs3bEkrcHoyUW5KckVlYWZxd2FEVmFWaTZOMWcxMU15?=
 =?utf-8?Q?VorCjY4D7XFoVn5R0e+HZCNWswde5f07NZ+OWGbOOvHU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3195ace-9d73-462d-5c6e-08dc1b327e57
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 10:11:28.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2152


On 2024/1/22 16:10, Krzysztof Kozlowski wrote:
> On 18/01/2024 06:29, Chen Wang wrote:
>> On 2024/1/16 19:37, Chen Wang wrote:
>>> On 2024/1/16 18:06, Krzysztof Kozlowski wrote:
>>>> On 16/01/2024 08:21, Chen Wang wrote:
>>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>>
>>>>> Add documentation to describe Sophgo System Control for SG2042.
>>>>>
>>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>>> ---
>>>>>    .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 46
>>>>> +++++++++++++++++++
>>>>>    1 file changed, 46 insertions(+)
>>>>>    create mode 100644
>>>>> Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>> b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>>
>>>>> new file mode 100644
>>>>> index 000000000000..7b50bb56b4cf
>>>>> --- /dev/null
>>>>> +++
>>>>> b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>> @@ -0,0 +1,46 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id:
>>>>> http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Sophgo SG2042 SoC system control
>>>>> +
>>>>> +maintainers:
>>>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>>>> +
>>>>> +description:
>>>>> +  The Sophgo system control is a registers block (SYS_CTRL),
>>>>> providing multiple
>>>>> +  low level platform functions like chip configuration, clock
>>>>> control, etc.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: sophgo,sg2042-sysctrl
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clock-controller:
>>>>> +    # Child node
>>>> Drop the comment, it is obvious. It cannot be anything else.
>>>>
>>>>> +    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
>>>>> +    type: object
>>>> Why isn't this merged here? You do not need the child node really...
>>>> unless the clock inputs are specific to that clock controller and you
>>>> will have here more devices? But where are they in such case?
>>> I don't see more devices will be included later. It should be ok to
>>> merge them into one.
>> hi, Krzysztof,
>>
>> After some double check, I find we will have more devices in
>> system-control. For example, in the SYS_CTRL area, there is also a
>> section of registers used to control the "General Purpose Interrupt".
>> The pcie controller of sg2042 will use this interrupt controller which
>> is defined in SYS_CTRL, we will add it in later work.
>>
> I expect then all devices to be documented.

hi, Krzysztof.

First, I'm very sorry for having double-checked with you for this system 
controller and child node issue, but this time I'm sure there should be 
no more child nodes except the clock and interrupt controllers, though 
there are some other registers in SYS_CTRL section, but we will not use 
them till now.

One question, when you say "to be documented", do you mean I need write 
binding/yaml files for other child node? But they exceed the scope of 
this patchset (this patchset is for clock support only). That's why I 
suggest just add clock-controller in this patchset and to add the 
interrupt controller in another patchset for pcie support. This 
mechanism should be suitable for our expansion.

Thanks,

Chen

>
> Best regards,
> Krzysztof
>

