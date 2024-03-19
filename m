Return-Path: <linux-kernel+bounces-107178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7664787F883
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1EA1F215BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32382537F2;
	Tue, 19 Mar 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XYmddN3v"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2020.outbound.protection.outlook.com [40.92.103.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7852030A;
	Tue, 19 Mar 2024 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834064; cv=fail; b=Bfv5PDMsLc8hE/3aVP4ks78B+tkZ3suypGNVcknRaj2a+DTatpygbvQWpbUkPHQUx/LWOI1OZQ+B/GDN3mTM3zwN0WqFG3yaZxKywVJkT0beSXMv3r71RUrdB1A/kT81KsHgsqn7zUgi/2kXNBsOA+59HeXb347B+Y+Surmlrcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834064; c=relaxed/simple;
	bh=tSQUtTX8fh38Go3RUODerRSlpoPFUFwcCJZSuhrWiGk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dAgZinpfok90Mzt0qkftC/jN6t47L/WOXN8ZHHcqqmQBvc8dE1oWmpsBlMvQggZnxKgalAlF6sOqZdYcS2uTOGRLvZ7GFdLXgHRp5Yth37f2WNstdpcvKyxQpTf29+ifBzFOtIyXS9SIo/jM/eg31dGOM8qRXJCbtpUsPPI+PpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XYmddN3v; arc=fail smtp.client-ip=40.92.103.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKIrV+94bQOX5HMuKYXkTWS9EkWYaN9Q9hF0NV9StgAxWAb6qJZFWz22WqU2cRATB58Dnmz72+ps6h3zxmxZl0Yk9UhDd7ixOMRZz/uAG5BizIymOqX0qzJwRrnadatRTyLZA8ddkUOG+Sdp69OI1nMqoOIWio8V/PfDWUX9NY3A7lrUW/+8qVUxQHa9D2FAKU9y9zxCZ0urSsjEtKoLYOj4Aexek7riclAyRhz6LOKK8ZlxwaTO8UQaS8xXiEbZZ0kmfWoBfeypZtjXJNG5TEHzoo1sMikIo4Twe3KbH/oi8IYxQocKU8p+wtqkDrbhpDh/HJtx19tQzhmGVF/UQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gONtz0GRW7/gri2iNvD60/GuVLuc01EbZ7qvr5+H8ZA=;
 b=bnoNsst9RGZmF3i/NUt4lTjSHGPQ9TySRz+mT7XrEjPIKMO4mZGxEk0lBoHUu5RSe1+iLUbkVIhFeSvNahzYhF1hxQGHHwIu7h5wiquq9OrjF219VQyW4czMxQcN0UW2oBAVjNdR0QenUct/ZPNt53B5o1Ax96j5GLcmjChWcT2E+V57Q3UCJTtMHLokqxVQExt4dMlR7OU5o/i20vNcuSFHfjGxZtnTGt9i3ft+QE47LVpqPNIV+ou7nEcFLW+p+2EhTZClf68VAvtHmEbwBiQnYHRLxcoIlv0WVQbOCw52irNCrUkh7hmc7KwMG8h0x46f9As5rRUL7jnYfxawvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gONtz0GRW7/gri2iNvD60/GuVLuc01EbZ7qvr5+H8ZA=;
 b=XYmddN3vMPeoPkMSIgvV6JGtkwd6RZHm2GSB6TMIuFocNDDe+LILt03mys9NO/VeDmUyAhjH7RFH2x5iUqBsDghzt43p0fQixX6CBbLy8Tc9Tm3e1RSo8hFlyG4htYaNnBsso+bFtSpxEC8azWRvCfd8cdpVNkYFFocek2MgfHHLO3TF7gBirXvHze5mqo7bf4N2dVws0vy2VlIHVT+yvNSgRat007Y7P0NrzQYVs4y45CjhTy7Pl1imt1irPwCLbe4G8epRzDFiTkQ91Aw7P0+dNe+DRDHxvw/55CCEOhaNugOKlpCYX0Y2e6jp3WtCd+9p/P9l/HPq0cEPqvSPEA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PNXP287MB0031.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Tue, 19 Mar
 2024 07:40:51 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::1bd4:64d4:daf5:ae42]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::1bd4:64d4:daf5:ae42%3]) with mapi id 15.20.7386.023; Tue, 19 Mar 2024
 07:40:51 +0000
Message-ID:
 <MA0P287MB28227C169B0DFB16B1AC762DFE2C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 19 Mar 2024 15:40:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] clk: sophgo: Add SG2042 clock driver
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com,
 xiaoguang.xing@sophgo.com
References: <cover.1708397315.git.unicorn_wang@outlook.com>
 <d7c74c2cfa410850c044ff2879720db06c2f8272.1708397315.git.unicorn_wang@outlook.com>
 <47a83f766c85481b73c6e6dd3759d4d9.sboyd@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <47a83f766c85481b73c6e6dd3759d4d9.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [A3Cr4AZvhbYTRJRmg1jpqPysGDLJNTXQ]
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <d00faf47-80b2-4e2c-ad65-00654a95d5ef@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PNXP287MB0031:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0f22a8-1f3e-4c6a-cddc-08dc47e7e4f8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s1PYnEZFe7P1mfvb1a12viYf1xdlNFl/dqoBt4VNO9IQ+QdXgSVvqSiIaSdbM7moeRZlS4RPOPjm1WHLiZ6aIaZIjH0rMIuX0YHM7Bca8ADB824Tvbt9CZfSMny1uQ1G4iU4FWZZ763HDMUjpaDTjOJr9t8Z6w518ziZjAh/00hRU76x4IqWG0RmtJjOfr9zohMZz3teD1mplVIqKu4Jb81oCN6BFqJQB6xy4iZEUKG8axVsdjvI5GgOr73+cpBd6oGmwxxajoLgvlTPwI8x8WpCOwjb6H0wQqX6HEp28BThfAdw+TnJJ1+s08Ueta+5ps9yb7AAroXyM/LrAWPXoY/jzNRM9qHgQYdlWScXD+dGWX6vBXgMBumN2j2pY/XGNrkgEY1RR3tk1ATtVrGiusr7ZZeEUvuzqfD9y0XZ+nnAcLbiT/zRAY6Iiz4qMJA0avSFPZt05qlalhO7wDXRQQArC2juHnkYt1BDIROy+k3zerYv8XRSyYnW7mWQTrpNBuhaA/Bh46xNHFDo7JhW9I/2FKmgIQVqKAi5CFaq5Nmv4g7wax+F+j97bOXueCr2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk1VTW9JOVd3ZUJiMFBobWNvOHZ6T3BaK1BFb1Q1bS9lYUh5WW9iMmc4eXhC?=
 =?utf-8?B?dE1jZUtuTUFCdm9oSStlUzFHbjhZR3c5SWM5dEdUeUMvb0tmdHMxSnNpK1pi?=
 =?utf-8?B?bDJlUmVicGpvQnQwMnQ5VWN4Q1NPU1NZak5zUnBlZGVuZ0hMVDJtcEp3OGYx?=
 =?utf-8?B?YTRaUmpueXZZZFBpSXI1TmJPV2t0dEtLaWY5QmtqNlY3UlJvbWp1NTB3eEJI?=
 =?utf-8?B?TTVSUEY4dWwrdFlicDBvTEhrLzlMKzNZMWNDTHNNY1lVZDQrZ2hQSTUxTi8r?=
 =?utf-8?B?R1JRQUN5S2luT3NoMy9vQ1RzbTl4NGE2SmtHelVQbyt4TDk1bHVEWnNvWmJO?=
 =?utf-8?B?cU1LcG0wTWlwRnNiOS9EMDZhWHJVNnZnNU5IMzAxZjlobnlvN2hHdlVJUzla?=
 =?utf-8?B?OG9yK0RwbEVaRzd4NkdIT1J5UTJCVFZvNnBRYlJzU1h0WFVwQlpHdFRraERo?=
 =?utf-8?B?eHltNzJweFN4dDQyMlVMdnhSd1dBMUJyNEpTNlpTTVVVekJ3WmEzVHV1Qk5E?=
 =?utf-8?B?N3ZpV244UzV5Wm50UytDc2lPajZ1SEQ3Uis2d2hoSGtQYUpBd3FzckNOcDZP?=
 =?utf-8?B?MTJrME5oTjdIODlrMHpCdU1peWx3ejJEL0dSak82K0hvRWg1VFgyZ1BXd1JX?=
 =?utf-8?B?VUo5c2phRnYwbTZubG10Mm9FMi9sbnp3aWhoRXRUQks2Zi9oeHVqUjFFeVRH?=
 =?utf-8?B?UTdoTFVaWHhpc2E2cWRUb2c4UVZjbjBEcGQyc0JqUnNXWnNuL2l5WWxlZ09F?=
 =?utf-8?B?OG5NZGY0dnNJMTNZSUlpUDROVkwzWlpnSkZhTWxod2V4cXhGSDJReVhFSUF6?=
 =?utf-8?B?QXJnT3VDbS9MdEtKaEgxYnNVM1M1Z0JuUnVvbVY2TXMra3g5VW0yYnR0UVVa?=
 =?utf-8?B?S1lJU2wvUTN1dHZHbmpHV05ScmVjRjYxTW5vUThDdTlObGQrNVlxSHAwa0hZ?=
 =?utf-8?B?UndyNFZ1T3VpYXVhakdaY2M1dU5tVXRIMGI4dnZKTFkxdFVYbWllSk9TcVdw?=
 =?utf-8?B?MUQreURLYnB1b0VuR0xtam16RmJiYUU1UlVSOGtMTUdFeFNTNk9pTnQ1cTda?=
 =?utf-8?B?bUxxUThKNGZNNzRHdlgwRkJ6K2k2cmloWWlOLy95ZVdVVTdFMFN5cVNacVNJ?=
 =?utf-8?B?dTRUZld5QnVFNDdPZG5HT2tYdjNQd3JNN3FIaWxTbkhTeWZTQXBuUzYxdW4y?=
 =?utf-8?B?cHk2dUczOEJTYStMVWJSNHY3NWNxOFR1bXdJVTlGRUxERWlSZmlQUndDb2sv?=
 =?utf-8?B?QzdqMnN2VS9DLy9RcjhSSmFIMmdhL2dFYzhSR3lmNmRsbmxsdjZ2UTBaWHFq?=
 =?utf-8?B?Qk5JL1FPQWtOOUoyZHdqVDB6V1IrNW81SmN3cUxPNUlQZnZMVFV6cWs5YnZI?=
 =?utf-8?B?VW04dUVsOHRaZTFEc1V2WVhLZlIzaXZOOWh5RHNKTk03Q2h0MzljQUJ6RmlJ?=
 =?utf-8?B?eERNS0NaajM3UzBwdmNIckhDZTBpZnBocVlYOU5LaWJMTGFmdmdKNU9UdS9G?=
 =?utf-8?B?ZjhvVkVaUE43bnpIbCtod3RFdU9lUzN5bnNPZXVtU3IvbUQyQUtuVm1QRFgx?=
 =?utf-8?B?UmZ0ODZIRGc0L1UxZ2Y5WmFPbDJOTERiZm1JUm5JTUxxRVM2WVNjc3AvNjBC?=
 =?utf-8?B?VEd0NHdLSlZZWWlRZVIwVDRHck0xQkk1N0tncThFUWNDKzJDWk5HVjVmQmtU?=
 =?utf-8?Q?q2MVy0Z3ThqSM7DwgwXO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0f22a8-1f3e-4c6a-cddc-08dc47e7e4f8
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 07:40:50.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXP287MB0031

Thank you Stephen for your carefully check and comments, I will improve 
the code according to your inputs.

I have some additional explanations for two of these points.

On 2024/3/9 10:11, Stephen Boyd wrote:

[......]

>> +
>> +/*
>> + * Below array is the total combination lists of POSTDIV1 and POSTDIV2
>> + * for example:
>> + * postdiv1_2[0] = {2, 4, 8}
>> + *           ==> div1 = 2, div2 = 4 , div1 * div2 = 8
>> + * And POSTDIV_RESULT_INDEX point to 3rd element in the array
>> + */
>> +#define        POSTDIV_RESULT_INDEX    2
>> +static int postdiv1_2[][3] = {
> const? And move it to the function scope.
>
>> +       {2, 4,  8}, {3, 3,  9}, {2, 5, 10}, {2, 6, 12},
>> +       {2, 7, 14}, {3, 5, 15}, {4, 4, 16}, {3, 6, 18},
>> +       {4, 5, 20}, {3, 7, 21}, {4, 6, 24}, {5, 5, 25},
>> +       {4, 7, 28}, {5, 6, 30}, {5, 7, 35}, {6, 6, 36},
>> +       {6, 7, 42}, {7, 7, 49}
> It may be better to make it a struct with named members because I have
> no idea what each element means.
I plan to add some comments to explain the meaning of this array member. 
This array is only used in this function, and I think it is somewhat 
unnecessary to define a structure specifically for it. Adding some 
comments will help everyone understand better.

[......]

>> +
>> +/*
>> + * Common data of clock-controller
>> + * Note: this structure will be used both by clkgen & sysclk.
>> + * @iobase: base address of clock-controller
>> + * @regmap: base address of clock-controller for pll, just due to PLL uses
>> + *  regmap while others use iomem.
>> + * @lock: clock register access lock
>> + * @onecell_data: used for adding providers.
>> + */
>> +struct sg2042_clk_data {
>> +       void __iomem *iobase;
> Why not use a regmap for the iobase as well?
I plan to unify it as iomem. Anyway, just use one method should be fine.

[......]


