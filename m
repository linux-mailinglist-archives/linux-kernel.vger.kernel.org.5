Return-Path: <linux-kernel+bounces-68745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB290857F61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FEF1C24FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A524412DD86;
	Fri, 16 Feb 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iPG3CI5y"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2027.outbound.protection.outlook.com [40.92.107.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DD12D74E;
	Fri, 16 Feb 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093808; cv=fail; b=DeyB4tZt9qTyvAN0ZWJJKqcs5Wg5MpOO2qDUa69vt49BGwz0QvMUut/W6E/t7XAo42M635GmUJPe9aabuzxSOE52F6e3+Mz+AQ4GjyDpbOFGmh3LcRSDTB08NAds7egDe7JGUyh/afdBDPm4V3fiHse5VwX9SBqNAqxNBQDDIZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093808; c=relaxed/simple;
	bh=o8Xv5jlEioGy5Iq8Ai9s5kaXTItwTdKhFgOWoPmOKuc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nszk2fMVx9zPy/US5F8F5h6x5pzxmJbhoxFYaV50ERZtsmwvpJ4kAvKoq9YVHNgpTCOthXWK/jTPiqZZ92ABIu+7+l3C46ywfOcK8DCP5hWMAM7UyNe0eFlzcys2feKjPQyuNtPWezEs8XznJA4Y1DS++ElvyKpGzD4sp1BwTJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iPG3CI5y; arc=fail smtp.client-ip=40.92.107.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXCYHgmp3YPzReTOO6FUHhoYSRdYVDI8IjC6lrs6mH3cxR6VA5fFXiMFOx31B2R295HqGaZpsn0ecRt38UUppO1q32BtNl+WnNDgxwHqwhcKnWnP9TvUTv8E33E2WcWNby+I0RXvn30IoGb6+hpGk1V51C4p6uC0k+El5V8nB7bB8JpFZXu1+KP/dN/RuFY0DaK9Bol1F/Eq2kFwh6pRYERUXM5CkLS79CEqMVxqRhXPJ0X7bVwtvPwkANz5FmC6wfSv67oTQwRtRU5Cnr98ijdjfk8+iArO/dFwV+trbmimpNn+jlp5Esb+dQEmF9TeMraOMv+aFodyr6n28OLsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW5vTaXT7/hNteW7efOye9EO2H7Vfq2EVlgOO+RRsEI=;
 b=RlRuo3nLb3awTi3ApQvxwNplWuzvS1WxIQkK7k63UIwgtByMZo65pU8nLisk2jp9bYuAAAa3ZGC9iSyn+x0euh8ePsb42fjm6/QG9PiIHzBr63lhZ8XanSHaay851rhSoBut2CrWYc3m/miJj90cCDCipyk3Ze+yIld0KiX5UEXnoJZXewGrDFYVYowshyd+R5A9WME6+OTUiqZblwVYXegWOFqud/JVLMVMCaKPVz0oOV+5MIavmia17qa+RwjTCxirsGGMrURtmPaR8QIO5+jeZs5ovnbxNOls07i6ufezGV9kZ2BAMnjU09ASxfLJBEU/Qnpm9KyIsJg2tKKMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW5vTaXT7/hNteW7efOye9EO2H7Vfq2EVlgOO+RRsEI=;
 b=iPG3CI5ycATn33SBT8jkPpCPlOtQbMiylc0irxyfYepkzZvBLx2siASDux5u+Q6/6zrJdjwqq/FPzqx0J/1f8bLuZilx3kktq6nVeJf2TTb3Su2t4y7Mx3ldATxdYX4AN26LQ8tVxKvjgBikj+ivkR0D8vDRcMP4amC8ToX/u0Cvk0Z9i7mHP97LPczqfgLXQnk/h3+Jvk38zqh5j7KxoVFpc+PMMd9Jc8gxXv+CrwfoJRmZjJijXp+nTsl0E2JahLzTtMXp0QA4n3qu9MRAD4oKynKUMKap0qsbsumuJN6azoMKBDlRKj6qw8/vlzXT5JUtcxBhL/ZDzQROppJB8g==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SI6PR06MB7536.apcprd06.prod.outlook.com (2603:1096:4:231::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Fri, 16 Feb
 2024 14:29:59 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 14:29:59 +0000
Message-ID:
 <SEZPR06MB6959D1466670252F024425EB964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 22:29:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
 <6dbd998c-269d-44eb-bf00-1eb79ee66f0e@lunn.ch>
 <SEZPR06MB69599F74D3C7D2B7705C9DA7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <3deb4ac9-558b-4ce5-912c-aa07797d2eda@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <3deb4ac9-558b-4ce5-912c-aa07797d2eda@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [6odokYPP5SpUXxdoKdqVrCsrijF+Nf/SC/SX/K4K5oRKpUqh//DH/t5UCkQkpf9nI+z11ePes34=]
X-ClientProxiedBy: TY2PR06CA0044.apcprd06.prod.outlook.com
 (2603:1096:404:2e::32) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <c4671030-5e7a-4581-88c5-ae948e848776@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SI6PR06MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: ea47f0a1-6c6e-4531-fc88-08dc2efbc0e4
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6c1cOtx239ZsJJkcpVeF72bEnYBfKbULeB3FEflVUIu97fWZq7V0WanPClax9prXs73cq4Qt5+2XcY1BReL7DGk3rEN5SnDiO9sqqQeguRMH+PZ+44YkpYm+NKKQA+yt8Y/z01Yw5HVokNmoVtTjXq/eOdUyScu95fO0DArKOPX0Ga05F1SRFve5NdojERdAYtJiZcwfEBZ29++QC48dK8vMzzO6QxJXJ5lV2W1BDadirAYyyMvsU7W9I9vz0SLMYWcIPFtrPvSZqyy/u1j0u/9Be/qJfj+XVFzJe7wowjqvDqS0WvFiV0ehvBpAqGpNTYf8gU9TvdW0EtBYRi0z+Vq3s0H3Bi+Ad0nq40LBwzrUNBgz/luiruY4zBvU6fZZ10JCxHDc58nFs6tlJER+aAjL7wdleQKcFJAja8Mxj9RQMpFpv3LBerv5BCq2TAGbrBlYVxVpR+8oQShthNIs4L1cTKpUcp9L4uNehDqdpbDw+QkG6fR/i909eeInl8JySj+pGxwnUTxmEctlB9iF5bccmljt15E+VF6iPdoYa3pCrBbe30TDy+rZnSZFfkZYhXbw5YG4oPnmZFPCWrFjMTUVp+AvTjVEprTUdHEiaYNrKWEGcTafa2O4cM1h5WicSXvCpbWw7TATnloLKVBV/ikVC24/EIwiuvwEx7HrzClZnFLae/evY6U79krlMNs0DESgxFUwKBAc4LUdfYpZh94CNu87cZaA2YWh4Fr0ESYoktrMTXlIMdioqlOy/1ED4g=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wnRhk7OT2PXfF2klt9YbFHx2dXnrvfpNC9U2VroYhKJWYRtdFMBN4O6+6vLmXA2H7CMkRXfRbmEifOL66y7A8+JrsnReAuJkkuX8/dkH4kG2+dYIk4GZAyF+MzwkUVq9to/P3AIyz+slQp3ZfVmLAnhGv7o9/tvGMdc1AXAbvWjPmcmJPdfQSto1ilI69QSIg5LSj5JFes8gFV0eHtCtLwcsMFAMJa7gQTfwjuttfw3GmaeSjRkR/Qx72CbG1KWL2WnqtP5YSmHNOERvLFzKNSzGv5DQVzItPvcE7ITDGA9gnrpZwNM6TMEiRUA0+vQggXA+OVH0CBnEN+k3Ih/M9lfG+o6r50aZmKATezagcYWvKcNzFiDZMBELWOCv8t6/+7DGGLw3EGN418/kdoQo5rDICE7oS+B7+ahyIT7UNNUgIiTQN0mtrE3+xJCEjEea00Z00o8FCs3es4xfNyYOSwKZUvqEKfQ/t/wsm4gOLxMkBpRAkxcJqwSRLpZeNNT8rjfRUBJY3aco1Ut+rLUPFslYbsPeKkjIRZsrN5/2IjgS6Cak5S5arr8WXONITcgJRHFl3cPjOlq4u1xX8owBajEUEshBetWJVqpSf/OWpHFIpXqv5owPJJvrO7fb+7sIgwmtIAiimndsMUgKmiKJ8g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1l2RUEzVUlLZ1VWWUN1VkxqY2FwMkkza1E5QXE4R0JzUmx5cUphazYxdzhF?=
 =?utf-8?B?eDR6ejBtZW1lTEpaR2tjeno5VUJtc1VOSXFvdjUwZnIzUXBpOGIrbC9zYkhi?=
 =?utf-8?B?Uk1iWUlyMGJydjhvQWdnaDZVTzJIclp1OEIvc1l5SjNIMmhvRXFxamxSTWtX?=
 =?utf-8?B?NnV2TUNjZEt2eStKQ0U3NnNsMHNGc2t2TG5wYlFVWTM3Lzh0b1dzcXltMnR5?=
 =?utf-8?B?aVBQTVhoWjBtRXBuNGt6b1JaZXVvbmJXMUFFeHlxK0U0aUp1YUk4L1ZSN3JI?=
 =?utf-8?B?b1NCSUMyMHJtRTBhWGIreDR2QklLbFV1RnlmcnMyYW52eWdTY2Jkc0pZdERG?=
 =?utf-8?B?bTR5dnk0Y0tsc3R4RkxLeC9TZkxQZzBkVm9NSkVGMzFRTVQrSmpQMEVBaHpE?=
 =?utf-8?B?bjlPdFYvcXB4anhLSldTTm9jc2g1K05GVUdGZUlHMm8yNkpZeFl5eFA3Rk5x?=
 =?utf-8?B?QWt1alpHbURwODlJdzEzVGs4aXVHWWJTRkg4SG0vdTZvWnhiQnlhSVIyWUZm?=
 =?utf-8?B?dkhkVUtENGhTTE1xU0Z3V0hKaDk3OVcxUWx5eDV2K3J5bzZQRkRteFFRMHBk?=
 =?utf-8?B?dGp4aTkrd0FwNS9DU3p4ZHBBRVVONTVYRWl4V041ZU1tRDRsbkxiclJ5OC96?=
 =?utf-8?B?TlJpalZ4bHhXelNvb1ZRTHdJS2JZRHQxcFpOdC9lSjdiZ1EwY3RNb01paTc1?=
 =?utf-8?B?VnI0NFd4dGlNRjhoSXBlTWxOYWlSOVZPTlE4NnFCTURVUDc2a2FqUkh5VmF0?=
 =?utf-8?B?Tnc3T0F3R1dNQVQybno3WGFXRzBVdzVkTTdNTC9MNXVINitnWkFzOE1kNlhr?=
 =?utf-8?B?bVdHeEovZlV1SzhZQWNTVFlkSkNDMXB0QnNnNm1lbncrYTJZdDE3QjFuRnB4?=
 =?utf-8?B?THpFOTVjRm1aSjFFdzJ6YXNjMXMwbmk4WVdpRjU3STlSR1hiUVV2ZDhnNHBp?=
 =?utf-8?B?LzhUVkRPeEZ6K1pXQ2cyVXhnNFFuRWhUaFJaS1B1S051dVh4ZVBua2xhNDFZ?=
 =?utf-8?B?ZEE3K3BZQXdHVzJ6TXVhd3cwN3k0RXdRSnQzd0ZWOG9XZm54WmlNY0hEU2Zn?=
 =?utf-8?B?WnR2MUh3bU5nZy9OR0EyZGZxV3JqYnhjdXZmTUxJZ042eloxSWJqWU5HbmRV?=
 =?utf-8?B?UG56aGxDVjNlbDNjckdiWEZjUy9mMDdrWmFlazFMT0s4YllPa010V1ljVnZO?=
 =?utf-8?B?OHF2VytEZ1pUM3cwcjNFdG94UkcweXBya3MyZnM2Vk1hMFVSRER3anJkczgw?=
 =?utf-8?B?cnovY0tiMDJqSDJCa3VSbTNuRmMwaVo5Rm1jSFpMajc2U0xhZWtlb0pwRVlo?=
 =?utf-8?B?NzBuTFZsYm1XLzZUcFNVemNoSW1WYk0zTzRocWdYRFF3QTRvQm1VS0paUmo3?=
 =?utf-8?B?QTJPSXhCVGhWRVphblRWVDl3YnFwQjRSdHE5RVBlL0pMSTdqa3J3aUZPdm9Y?=
 =?utf-8?B?Y0tBU25QQjJ0VUZJeDNMRE1ReFVUWkNGZVN6akpJVGlLTVlYbUNkZ2lWQ2Nu?=
 =?utf-8?B?MHgzRUVBVGZlemNUVmx4U1NZcmlZYnpBSGg3azVENlkvUUorQXNaRkxCKzI2?=
 =?utf-8?B?Z21YNU8weEJZL25xMkZrTGhaVWtleERiN3pydnRZb0RucW9Ld3JWeVJXOGNU?=
 =?utf-8?B?V05NNEx1bEpGK1pGMUljZ01vZzlpU1Y2dDRIQmd1WG5hTVpOWHNDWGV2QnNU?=
 =?utf-8?B?K2pLZWdaYjNsTXFUUTZVMmtnU0kvVDQ3S0ZCeWZrV3JaR2U5VXZ4QTdKaXNC?=
 =?utf-8?Q?hWOU7FxlHCBuACwvxqC1qh+P55l+CUfgLqtHlpB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea47f0a1-6c6e-4531-fc88-08dc2efbc0e4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 14:29:59.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7536

On 2/16/2024 10:10 PM, Andrew Lunn wrote:
>> I've tried accessing MDIO address space and MAC controller address space in
>> u-boot with `md` and `mw` [1]. From the result, i guess the CLK_BUS is the
>> System Bus clock (AHB Bus clock), and the CLK_MAC is the clock shared by
>> both MDIO bus and MAC. The MAC has a internal clock divider to divide the
>> input clock(54MHz in common) to a configurable variable rate.
> In general, sharing a clock is not a problem. The clock API does
> reference counting. So if two consumers enable the clock, it will not
> be disabled until two consumes disable the clock. So it should not be
> an issue for both the MAC and the MDIO driver to consume the clock.
>
> However, the funny PHY reset code is going to be key here. We need to
> understand that in more detail.

I don't know about details too much, either. All the resources i have is 
a brief TRM and the downstream linux kernel code[1], U-Boot code[2]. The 
idea of managing all clocks and resets in MAC driver is taken from 
hix5hd2_gmac.c(in the same directory).

>
> Talking about details, you commit messages need improving. The commit
> message is your chance to answer all the reviewers questions before
> they even ask them. Removing a binding was always going to need
> justification, so you needed to have that in the commit message.  In
> order to review a DT bindings, having an overview of what the hardware
> actually looks like is needed. So that is something which you can add
> to the commit messages.
Thanks for your comment. Also sorry for the inconvenience I brought.
>
> Please take a look at your patches from the perspective of a reviewer,
> somebody how knows nothing about this device. What information is
> needed to understand the patches?
Will rewrite commit logs in next version.
>
>         Andrew

[1]: 
https://github.com/JasonFreeLab/HiSTBLinuxV100R005C00SPC050/blob/fd20f78ab02934e71474dbb1d933c6ec911b01c9/source/kernel/linux-4.4.y/drivers/net/ethernet/hieth/hieth.c#L1281

[2]: 
https://github.com/JasonFreeLab/HiSTBLinuxV100R005C00SPC050/blob/fd20f78ab02934e71474dbb1d933c6ec911b01c9/source/boot/fastboot/drivers/net/hisfv300/sys.c#L50

-- 
Regards,
Yang Xiwen


