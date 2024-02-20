Return-Path: <linux-kernel+bounces-72177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D285B07B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9DC0B22518
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC417BC6;
	Tue, 20 Feb 2024 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Vw3xoRSN"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2026.outbound.protection.outlook.com [40.92.102.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD02CAB;
	Tue, 20 Feb 2024 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392165; cv=fail; b=YEHE50c88E5qa7rKa7N8MxCpn71Do394JehKZL+gboPDSvTb2m2rnDALLConZdzK2hAmxBj300SurcGnruvN2+jDhgI8A6zecarqqHMyfdjwqKErakh3ObJ65O9pYRiAUkUCEFV/H0PtJB4mDANUgc3xvKhqp+MxXmfKd3tKESY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392165; c=relaxed/simple;
	bh=3YKyDo53vHI+7Tk02IAkFTgarHpfxP3WNU+MPLRLbTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tONJjMUoX4d/wov/akZ55MUrnFN7zIJbeUSxuGgasvtb0mYThtannDuDPtka2pjoLofwFzXn7LZFGQ/R6ilKEKvNJkDrXYGNnRKQCSou3kuwDL+QF6xvUWxbAgMD++BIRRzjF+md4uLS/79hzlLGk/G5CFBli3BsHL9UFe1yHe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Vw3xoRSN; arc=fail smtp.client-ip=40.92.102.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHMqdI8EJnUNKno6z3H3xKFKm0F1/BegYXP5fJxfja030lXcggLs0x5CHOiG01fwK1Bcnz55R2tpBHfKjD0OT+aq/FXZ3wUbhE2Fg6eqAwpsybLp3ECUooE7cPFZ8mRKrU/osBzRaxJTBBIWpw9sHy8puwutlJiOGCQ1Q/bWgqf0FgBLuDlOULPSwF1d5svW49R+sKofnkHqmlVrgo2zIDUIVwrHck7U4IFRZKE08KH7Af0+yrRU+hVHZupHt5KKDdCTkv24bgwu7wjquZVHJw0mChJUzimXBte15jgjbvqc4TV6oInBJVxqMGsvS7EGiipM/sriB6PYbtk6paIBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQBq46gA80BhUPyzmgunlK+x7pDE/RZONsNlUwyMO7U=;
 b=O+Ul9WWSMOvfMCkq+2UCoVq9SkEU7KM5JIXyRv3Vw1DsKH9oQdelIEQpYR59OET5DmHV4ic18JjI9BO6cxlY2pBkSoardnx0DVMR4ssMkyByxlHqwv3xy5aSRxG1CI4tEv/We+MD0zIbnQr1NC9jBPgrMjWGn7lMWGxlgYMl3rET6pYmiWrR7kYg89ZdTt1GGreZZzyNgGsUnjDvWrirMQuBOjRuBJjEzjoAqi1GKhurGzzKjEhgL2YQ7jSEkzyFoPsWAfgnHGvmrA9BoRTkEv0rnOeRamoQbB0DCAUOH7gX6jkke3z7wVreKwqS0dLZM4MRJNrXKdz7up8Pnt/Sfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQBq46gA80BhUPyzmgunlK+x7pDE/RZONsNlUwyMO7U=;
 b=Vw3xoRSN3bw/HCvA/k1NSNt6hww4KNnOEnVcPIgtTLmOyJdscwcUlRB83mR5P9+sKl2N2T7BxXYbmGCbPLM4v01Dmn3uBljaKGpBoVbSC8Xf8CHanL4ZKp//pg4wh1/0rvjApSwJB34a1HutmSRTC0X9Ydl5ESdF1DPnlnfbZqMV6QFtZWslqpJcmlSF1bNP0osbFwcJD2w5BEMih8LhNviF37gBJJ8SusYax+hmP2NY455hkt8KO09fvtMuwzgKCht7ztc3Eu652C3/E0QFKrbQN8bXN4Jp96fbAXvj85RJFWcmtvKIUm7zt1PHxKhco9VM5k1FF9mjWLqF9L/YAw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1805.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 01:22:34 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 01:22:34 +0000
Message-ID:
 <MA0P287MB2822D28F96F1A0E76943FA15FE502@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 20 Feb 2024 09:22:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/5] riscv: dts: add clock generator for Sophgo SG2042
 SoC
To: Guo Ren <guoren@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, jszhang@kernel.org, inochiama@outlook.com,
 samuel.holland@sifive.com
References: <cover.1708223519.git.unicorn_wang@outlook.com>
 <dc899c89e5c30e2267965f185b52d6dded4eb1ac.1708223519.git.unicorn_wang@outlook.com>
 <CAJF2gTRPU6-8Wwds=PRREjU3W0cmCpBcc=w7=J9p_y+XSd3o6w@mail.gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <CAJF2gTRPU6-8Wwds=PRREjU3W0cmCpBcc=w7=J9p_y+XSd3o6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [T694EED5EStVhQFksPAETG6khaqgINra]
X-ClientProxiedBy: SL2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:100:2d::15) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <d77c95a0-3f5d-41cc-9303-06090019796a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6965ed44-dff8-4a3a-3424-08dc31b268f8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tto+YNw8J8/t/hSdv481wJfsIrti2RG0H3+/z70eiBnzANUapu2BPURFqBFOcineauFm1Oqx8v4rXbGuyXwSUGks5o4LEURB3r73T2yv6qNcWUM9skiuQcMUYdHmymeHZ184Tk/ytminWVy+opQBH6omfUdVEmOFP/g94ZUeqIQnDsw+2S6mcVeNa2YAUVjbz9r23XZ2LHNWg4ep0x7QXb7TsR+uXohNNdYmgn8I48sNQ00RZxLpb8zGYGGd7unfJlkbuELe1dyDQ1tH3otmymnAtziaYjP+40jy6K7rFrQn+eQg2nS9qd7/HDFF9oeRkxsyPhggVjkq4MX2hW0JI+qRh1OOsiVQNibiC0NMA3mQFDuU3VGxSgPcoDdVErlHade4gl72KhTVYeirdl8q5NibVSsJhvv4Oh/BcZATitLoARGjFrjFQKptXaA9z6o25X/b/FEETwL0bWENEEaZtn41E6Jgr0eYKBiQ3TqqI+xDfvPHIqz36EGnUwp7g4SNjX5u8A6Ii+wAi5tpeCPprGabf/836EsiYnLUO1+g6aaV7dD0eubZW59d1tat9/31
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDVlbUVrRG9GTjVTcVRYSERvVytVemhKUmI4UHh5aHI5NGdaZnhqdWQ5TzY5?=
 =?utf-8?B?M3FSZG1QSjgyK24xR0hPNWJtM2duREhIVlJYNWVSL29ERlcxOHZTNWkxK0I5?=
 =?utf-8?B?SE93b25qZnFuNDZTTGRtVzBLY25SZFpnb3dQZFJRb1BkSVY5VWJVVW1JaU1i?=
 =?utf-8?B?MDU3UjJld2lhZEM5UEo4aURXVTJPYkNqZEVBZm13UEo0b0lBN0ZneTQ3Vk9H?=
 =?utf-8?B?bEJHVmszdGQ3K0o1TDlvQ1NQRXZrUGdiYWZtRzN4Y0k5bEI1aDlpWHRyajNE?=
 =?utf-8?B?K3N4WEFSYWFEQjd4c2VEcTkzSkpSME1ZZ3JYbVFCaUxieS9YT1FIZGpkR0h1?=
 =?utf-8?B?OGNWRVVoT3N1MjBnb2pydkJCcGdVME9IdlhMOTZiSUxvL2RNZFFZdVJIdGJp?=
 =?utf-8?B?b3dmU1JUamVUV2F6UTZHYk1IMmtEYUI2bkxVNC9uSXBxSGpiZ2VaQWlFSU82?=
 =?utf-8?B?MkhOUE9FT3EyMlh0TVVyeXkxZFBDTzgvMjJzU29seCt0YVVHVWRuT3ZrTk9M?=
 =?utf-8?B?d2lIUVRpaWZjT0xERHZMYTE5UThjZURLQWVHTzBSZk5YSGErWHFnSThOKzZi?=
 =?utf-8?B?cW1PVFlycHkzWGxnWEhtUTdRQkVCVEJBNE5JZUZLK2tlRXhHUzBZVTkzQ0J4?=
 =?utf-8?B?VlFWQjJlSGQrS2tUUTFXRXRUdFE2Y1FHSnNQcEhaV0hHT3JlL2FRM2d2b3lo?=
 =?utf-8?B?d2ZKWU5GNVJIZ050WVZMWFA5ZWc2VWhoU0s3SzlYS01ZaWZvSzNTZlNXUkx2?=
 =?utf-8?B?RGJ5UXlwcTh5SmY1b3N1ME5PS094dVJoWXJRdlFYRFNMSmxJUkNBVmRiZGNn?=
 =?utf-8?B?c0xXY2lCSUVxS1c2L29VOXFYNjVwbVBuZjA4cEpRYlRxWlFFbjVlSEpPTk1p?=
 =?utf-8?B?VzF4bnIvZXh1KzJnOHVOTVBNOE5wS2VnUklxYnVTbVFHaXd5MGRTNzBpSVFV?=
 =?utf-8?B?TExhdjRtL1ZreFhubTRTbFczZFFuL2g0QnNRTTY5QXJQZWFCckU2L2l2OGEw?=
 =?utf-8?B?S3hIaDAxWVZ4V1FRRDZlZm9DNTcybjByZ1ptc1VrWU5XSWlMYk9QVFJaOS9Q?=
 =?utf-8?B?VzM1MDFROXJ4YTJ5YmNHbkhvYy9PMGFCWm1mVU9ScHZXQ1ZLVUJ0bVVxNGlv?=
 =?utf-8?B?MzZ6N3BJUFBuRTVJVU5qL21ydVl4OTRGaU9CRnQzaVppUmJ6Z1d5cjVQQkNv?=
 =?utf-8?B?Wjd5dHZRcEcycHBzWVh5ekpqRnhNeS9QOVo1TmZ5cW5WSzJtRGFUQW5zQjQ0?=
 =?utf-8?B?Y0swTWYxUlZGMmNUYjArb0kvNmxMSklNdm51dHRFd3VwS0o2WWFSR040Wmg1?=
 =?utf-8?B?OThHN0lpTW1yS0JQR0lUSk5MT0ZtRjY4MVkxT1p2N2YvN2d0S3pObzBleE4z?=
 =?utf-8?B?ckNWdmJ1b2xISFo5RzkvMTJzNXhjY3ltRkwxMnZwUzdRT1JPSnFVSGZWOWg3?=
 =?utf-8?B?S0F4Z2g1cmZjVENtL1J2dktLeVp0R1U0Y0ViTEdvdWdPOXFLMGhkcW9aWUZ1?=
 =?utf-8?B?bzJRWUlTTnVIdWp5UWdxTlFMSkF4ZUYyaCtacFFMTlNxOVVSSVNLSjYzcHdN?=
 =?utf-8?B?VWRTeE54TmtkNDR5Z3liclNiYm02SkYwSm9XYmMvSHo5SkM1U3QzcmVpWHho?=
 =?utf-8?B?TmpTOHlpVVpaMUlFOXd2R3hvVHVRNlVVRFNpbnZKZVRHbjN3czdrR2xPSStk?=
 =?utf-8?Q?yxK+rSOY2I6NrwYtcbtD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6965ed44-dff8-4a3a-3424-08dc31b268f8
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:22:33.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1805


On 2024/2/20 9:18, Guo Ren wrote:
> On Sun, Feb 18, 2024 at 10:52 AM Chen Wang <unicornxw@gmail.com> wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add clock generator node to device tree for SG2042, and enable clock for
>> uart.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 +++++
>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 48 +++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>> index 49b4b9c2c101..80cb017974d8 100644
>> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>> @@ -14,6 +14,18 @@ chosen {
>>          };
>>   };
>>
>> +&cgi_main {
>> +       clock-frequency = <25000000>;
>> +};
>> +
>> +&cgi_dpll0 {
>> +       clock-frequency = <25000000>;
>> +};
>> +
>> +&cgi_dpll1 {
>> +       clock-frequency = <25000000>;
>> +};
>> +
> If all are fixed, why do we separate them into three pieces? To show
> real internal hardware?
Yes, according to TRM, there are three input cgi(Clock Generator IC) on 
board.
>
>>   &uart0 {
>>          status = "okay";
>>   };
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> index ead1cc35d88b..e70c43e2ccbe 100644
>> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> @@ -5,6 +5,9 @@
>>
>>   /dts-v1/;
>>   #include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/clock/sophgo,sg2042-pll.h>
>> +#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
>> +#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
>>
>>   #include "sg2042-cpus.dtsi"
>>
>> @@ -18,12 +21,54 @@ aliases {
>>                  serial0 = &uart0;
>>          };
>>
>> +       cgi_main: oscillator0 {
>> +               compatible = "fixed-clock";
>> +               clock-output-names = "cgi_main";
>> +               #clock-cells = <0>;
>> +       };
>> +
>> +       cgi_dpll0: oscillator1 {
>> +               compatible = "fixed-clock";
>> +               clock-output-names = "cgi_dpll0";
>> +               #clock-cells = <0>;
>> +       };
>> +
>> +       cgi_dpll1: oscillator2 {
>> +               compatible = "fixed-clock";
>> +               clock-output-names = "cgi_dpll1";
>> +               #clock-cells = <0>;
>> +       };
>> +
>>          soc: soc {
>>                  compatible = "simple-bus";
>>                  #address-cells = <2>;
>>                  #size-cells = <2>;
>>                  ranges;
>>
>> +               pllclk: clock-controller@70300100c0 {
>> +                       compatible = "sophgo,sg2042-pll";
>> +                       reg = <0x70 0x300100c0 0x0 0x40>;
>> +                       clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
>> +                       #clock-cells = <1>;
>> +               };
>> +
>> +               rpgate: clock-controller@7030010368 {
>> +                       compatible = "sophgo,sg2042-rpgate";
>> +                       reg = <0x70 0x30010368 0x0 0x98>;
>> +                       clocks = <&clkgen GATE_CLK_RP_CPU_NORMAL>;
>> +                       #clock-cells = <1>;
>> +               };
>> +
>> +               clkgen: clock-controller@7030012000 {
>> +                       compatible = "sophgo,sg2042-clkgen";
>> +                       reg = <0x70 0x30012000 0x0 0x1000>;
>> +                       clocks = <&pllclk MPLL_CLK>,
>> +                                <&pllclk FPLL_CLK>,
>> +                                <&pllclk DPLL0_CLK>,
>> +                                <&pllclk DPLL1_CLK>;
>> +                       #clock-cells = <1>;
>> +               };
>> +
>>                  clint_mswi: interrupt-controller@7094000000 {
>>                          compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
>>                          reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
>> @@ -333,6 +378,9 @@ uart0: serial@7040000000 {
>>                          interrupt-parent = <&intc>;
>>                          interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
>>                          clock-frequency = <500000000>;
>> +                       clocks = <&clkgen GATE_CLK_UART_500M>,
>> +                                <&clkgen GATE_CLK_APB_UART>;
>> +                       clock-names = "baudclk", "apb_pclk";
>>                          reg-shift = <2>;
>>                          reg-io-width = <4>;
>>                          status = "disabled";
>> --
>> 2.25.1
>>
> Others LGTM.
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
>

