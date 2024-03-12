Return-Path: <linux-kernel+bounces-99851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A126878E46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90211F22A70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E81EF12;
	Tue, 12 Mar 2024 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="kcbqX0Kk"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2081.outbound.protection.outlook.com [40.107.117.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631310A12;
	Tue, 12 Mar 2024 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710222444; cv=fail; b=KlgEyIYlvkU29BOXPOxkW53abWCJUNER5Ol3r/HqPA5N5NSk5z3XafZ70eF3Ncvho/ioB75LVVVApS0HVMF8tKS3C+N0Qh2dhZT4AVl+qmnRVZI7jw7Bd4VML9wWgzMkXuJGls3vkabhu/Uo8Q8gYl0X5p9HDYngCcfZJiCbKys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710222444; c=relaxed/simple;
	bh=Ow2ZWUYgvFMELb8UseOUtUy/lQov5QRhj7aXXL/T42s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B3e0/2rafb9C8Dmuxc78MRdNXZNuJ3OWFamyanFvqKIfyyys+oDnkWX9rBJ5NNRUWmgn8bzCS/5e+X7TSBqjgqludwhGWHD/2MPsaUO39q82rDtAzAQJKy5GFQU4bthocoG41p5VUCC61kNCvkVqyfB+zGPk9RDGjOogfYVcE9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=kcbqX0Kk; arc=fail smtp.client-ip=40.107.117.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA/i1jv1nI0QuObgOX2hYNEYH5Hx+DBIn9zPNYWWGh/kCCfe6IlHtWRF4Kev4kaHvXbehksEqtJkghwuh64lw6rWsaCXKzs2O+ptz8t/EcbJTj3f7psCkx27S3kmHq0QoZMmo54iFhbnWXAIrzt70FXrQ6LulJnbmpua2SQdMQrupaDOSkYMLkymfGJuoLcrM4q95xiLZeMSAu1P13c7ZHuN2hnlUDDNmEJ6W4rHMQQYGXL+iTM8rTBSpU+GLbNjLniy35SMF/dNyIOHaB/lEOYTYKn8A5yzoUY/wNvZWOdWgq31LcrvZrU7sTgKuQkAYZsgqQIuAUHMYw2fE/F9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fha6Q0bMHzghyKG7R+TGJu3ftJT4ZRjwt5cmplO9tUs=;
 b=NCsPFpTVfCCMZ3DT8dpdx8tgLZH0HMmr+zX1zevZs7EgPgk2UySjMTkcHETRtzOozg7NOK1qFjsZfqmjPG1G5LC6/fL4Q1O5XxZTGk6oPaqhsJtXtKjFjJp1egqDy9tcIJ0uONJanu9uE17FCgeWQZb6CksJWRdiFTAYfvhYj0s+sYPHusjXO4BPMlLMGICw4/MzY11YR/+etyPlw9eM0qk1vk4GYnYhvY8t4H40axJ9L3OgYpTla5KulIc1MPyIVXOKy8EX1NSyMEOojd2j33GwCQlL4Zvy3BwJEGHb/IlceK9T20eqtk7KFSI8Wx72Qyq/+K8rjlTI6HGGbq3ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fha6Q0bMHzghyKG7R+TGJu3ftJT4ZRjwt5cmplO9tUs=;
 b=kcbqX0KkRmZTc8ykO9r/ZdBZpPLuxkSlgdGMVQ9D/xfHA8ZfMFsTDAIR9qBURXlrKokidfipNblA2R1RWJjNf5p7I+T0ej8dQBGPYgg7afHg8MTz/G9IuAYryrBEcft3spA1fN66KgK9WNEc2Sl+/ZXzZ5sqjM4CPe8Xwx0QGXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from SEYPR03MB8378.apcprd03.prod.outlook.com (2603:1096:101:1fd::9)
 by SEZPR03MB7898.apcprd03.prod.outlook.com (2603:1096:101:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 05:47:16 +0000
Received: from SEYPR03MB8378.apcprd03.prod.outlook.com
 ([fe80::56e1:5482:dfef:a8a9]) by SEYPR03MB8378.apcprd03.prod.outlook.com
 ([fe80::56e1:5482:dfef:a8a9%4]) with mapi id 15.20.7362.024; Tue, 12 Mar 2024
 05:47:15 +0000
Message-ID: <bc70cb4e-1b98-41c2-8656-929b2e931800@nuvoton.com>
Date: Tue, 12 Mar 2024 13:47:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
 CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
 supercraig0719@gmail.com, dardar923@gmail.com, wtli@nuvoton.com
References: <20240304101523.538989-1-wtli@nuvoton.com>
 <20240304101523.538989-2-wtli@nuvoton.com>
 <20240304133731.GA105655-robh@kernel.org>
Content-Language: en-US
From: WTLI <wtli@nuvoton.com>
In-Reply-To: <20240304133731.GA105655-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To SEYPR03MB8378.apcprd03.prod.outlook.com
 (2603:1096:101:1fd::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB8378:EE_|SEZPR03MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: e522f95c-d752-4f72-c1de-08dc4257df1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PD0pbSM4/7CaGmaNnGRfkJNbw7Iq+EPbxBcDC6LnQ55C2fNJXDwsUh+qaG7XL/ymElOIVMRVZKGFjk9WNe9wVWwbnjLNakMfySBSOIw9vPJcRIrbB88jTINqVMuRF2xXOfw6ng9uYgUvn2y64ShZBZKz+fQ6mG7T4sfomN6FiBpi4d/s8A1T5/YyuQatpS/iwLQSJU5g7eH4Bw15xAxHO+qBfEaglCY1R5WwpPEe4AP8pQuhJgaLJ3PSURMBtsmKSC1xVTK6LTuyosRpBA5reNLGO8X1T39OQgK+o9j0gXvcrmRWgmemWGWj6NMlFiv97DMTUy8VZGhPLUTp3eUrfAFUkKiTUD8Xj7cAeVLbtDmfisUP2Gp6GXVlE5aE0baLH65dLRwq4QJIfqp4tI/GsVhrS/hxoTgKSpwLYMZ8U/HEywnLwwckZstcTrrcevmS7QCx4ANI4l6HpnprSYJ2du107D4s1oZXacPjpkiCDVp+UpOZIcHugKsK0Qtzbkf5hmuzo2UM88lQX2RidwXCFZX24Q1smCdw246nPMpNCAIQDs5IJdJPw8E0N7+xXNv1Jfj/M92Uzew2CmxVHRe0kg4kF7CIuA1p3xts96hTWBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB8378.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STMrRXhOWFNmdlRUM1Z4UFRSZkVMc2JvUnFpSUM2eUJRVDc1dGx6VFhoZnpw?=
 =?utf-8?B?WS9iaXJodTZaN2lYWlplRXhhaWhTdHJDR1Z3TDhKNzRFNkV4bEJ2OG1lUmVx?=
 =?utf-8?B?NFVtek1OaTg5ZHRFNE1wOTU2bFlOR09IMllhWnhmT053a2xNejJlcHlPY3ZZ?=
 =?utf-8?B?L0duSFdvTVJHUnlKRnBxb2QvUUl1aG5FbFBIdjRKaHBxNU1hQjNjNUdnSmE1?=
 =?utf-8?B?V3hFWWJoendPNC9ZY3BmajB3V25OSXdHTjNpaTMzZGlPZnNaVXFtMnhxckJF?=
 =?utf-8?B?N1pSUElaR1E1NkdsWGJ1S3JIbVNsNkVBWGZLYndFZXRUT0I5UEFMRnIwR2dK?=
 =?utf-8?B?OTgxdlArZ3hpYjVza0Uzc2lVVGN5OWtZRTNRc1F1YzZxZStKSHBxY1BUUHN1?=
 =?utf-8?B?TVpMQWk5bG8wU0NXeDFvL1Fyb0tYa3Z3dlE2REpCSzA5UzVwVmFOQW1kdXVR?=
 =?utf-8?B?dE12U0JIdHFIZnA5VUI0bitRZVpFTmx5Y0gvb2czR0RFSURZUVFpMmlmaU5I?=
 =?utf-8?B?YWJqWDBUd3Z5N2Q5TWRsSnY2YW4zdEg1ZTdZVWgyOGpmSUVFaTRVMGFGeGww?=
 =?utf-8?B?YmxieFRhbTNTN0dxZXpwNkxpa1g4YWU2UWVTSlRqT2pLQm91T1V2VmYwQ0Fz?=
 =?utf-8?B?Y2pBVkNCbHFCOEpGazA3TThjdWZnVXU1RkpWbTZSbk9TQXNpZHhHMGhJRlFK?=
 =?utf-8?B?UGo2SUNlNms3ZEMzVWVnWjhVYWZLMUdNRWtpUzhna1VocnAyRmoxdXdmL0FW?=
 =?utf-8?B?V1Z0T0Y4Y1prTUtjL3FldVFVNlpKYjErdUw1MkUrdjhiRlVMOTZUT2txTndw?=
 =?utf-8?B?NjdFbGNmcGRnQUFsd3VoNjNKN0VnY0NZQUVTd0VaOFZTM2gwejdpc0xDQ1dt?=
 =?utf-8?B?WXY2YlR1N3VVU2tlWXJDSzlWT0dJcGJQclJBY3RyRXFUT3poZTJXT2hFdWVm?=
 =?utf-8?B?MHVzcDJpaXlEK3Qrb1NFWk1KUERLSXFzbTFFNmxkSGhhYVJ5MDRySTZaU3V0?=
 =?utf-8?B?ZGZRTmVNRndWSjRLcW9VaTZibHJIUnpaM3k3VER3cjBRYVhyNzNxS1hEZk5u?=
 =?utf-8?B?WlQyeFhzVkhmOVkxVWVDQjcvYmRVeEZxWmZSa1NyWmY0YkJJTmVzb2JmUHNq?=
 =?utf-8?B?Q0FMOHlPM3RnUklyS1l5OWlKU0p1ZHJLZ1lhc1k1MThDYTBSYm0wcjAyd2l3?=
 =?utf-8?B?ZTdIU1Zoc0pqaEpycGNDeWNXVzRHWTVEWW9RUGs0YzdxekwzWlBNWjloT1JW?=
 =?utf-8?B?RzNnZElsYnVvWHVPU2tLWE9rZi9vbW93VnR5bm4raXlpa0tPekZRMmdrKzUv?=
 =?utf-8?B?KzJBdERiYXNIcmpuSDN3UzAyRlBUZTdWQ0IxdXF5QkhjeTlvS0JQUU53VlVH?=
 =?utf-8?B?YllaRXdZQmxsaGRKdDFEc01zaG5zV3cxb2hudjlTTzJ4cE5xZ2dHMUxFRVpB?=
 =?utf-8?B?SjRnTld6ZTRXTlQ5OVRJSHVZVi9VZ1lmTllHYnd4Y0wxSlkvWDNacEhzS3Z2?=
 =?utf-8?B?RllHdGk4SjdXUDRkd0lFc1JkWE13RmxpOFppdnoxQ3hUdmNFQjNpWnFDaFRs?=
 =?utf-8?B?SFdyK3BnSndXTk1qekhTVEJUbUdpWjlHQ3RiQmJwZEJzKysyRWMra2lpQm84?=
 =?utf-8?B?V3VNZzZqWE95b3QwbnNIb1ZhMXlyZlpiTzl1MXhDeHdESWxsdUpFVEZDQllp?=
 =?utf-8?B?RFVqQzZVVXRvdndqM1dLSXcwWmFmajBnOUpYbStsU1MxU2xCZnpvVnRjRVBO?=
 =?utf-8?B?R3Rscytoakw0a011cUIzOHEvZm53emZlL2tGVURKdGwzT3J6S2xSOXc1MGZU?=
 =?utf-8?B?YVp0MHlhZnl3aVVQRXF2dzZsVWg0anIvVlJlZ0tVZUpoa25ndmxhWEU1bXhl?=
 =?utf-8?B?czlVVFRCTHIzcGZTSzNCMlF5WHJ1OFQvZXkyakt6bSt4OHkvQjhhREZFVVdJ?=
 =?utf-8?B?VTNGOFUxdWtXclJjZHY2dno1WDgxREtHUk9KTjd3bWV5b0tSZkpxVHBOdlNi?=
 =?utf-8?B?NTBrd3c0TDVnZlB5RlIrYlBVS3dsMWg4Nk95TjRrdGxnU2FueDBUQWZSOEVG?=
 =?utf-8?B?UWtBQUpuNUNmRkJaS3hNZXErZldkem54MzZXcTFlL0ZPYk5MaDhUdVNrZ1NH?=
 =?utf-8?Q?kYZ8yTtHuMuYVAyrCMWO+O4Hw?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e522f95c-d752-4f72-c1de-08dc4257df1e
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB8378.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 05:47:15.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJr+4jCDg+jPJiFvOLH3/oozCi8SUX91p4Aebnm4ktB+tnkFn4CjAII5f4nGkwP+wiOFJCv72l/xFpZXcIvIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7898


Rob Herring =E6=96=BC 3/4/2024 9:37 PM =E5=AF=AB=E9=81=93:
> CAUTION - External Email: Do not click links or open attachments unless y=
ou acknowledge the sender and content.
>
>
> On Mon, Mar 04, 2024 at 06:15:22PM +0800, Seven Lee wrote:
>> Added a DT schema for describing nau8325 audio amplifiers.
> Present tense: Add a ...
>
> Please say more about this device. Features, link to datasheet, etc.

Are the following revisions correct?
Add a DT schema for describing nau8325 audio amplifiers. The key
features are as follows:
  - Low SPK_VDD Quiescent Current
  - Gain Setting with 2-wire interface
  - Powerful Stereo Class-D Amplifier
  - Low Output Noise
  - Low Current Shutdown Mode
  - Click-and Pop Suppression

More resources :
https://www.nuvoton.com/products/smart-home-audio/audio-amplifiers/class-d-=
series/nau8325yg/

>
>> Signed-off-by: Seven Lee <wtli@nuvoton.com>
>> ---
>>   .../bindings/sound/nuvoton,nau8325.yaml       | 74 +++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100755 Documentation/devicetree/bindings/sound/nuvoton,nau=
8325.yaml
> Schemas aren't executable. checkpatch.pl will tell you this.

yes, I will.

>
>> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yam=
l b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
>> new file mode 100755
>> index 000000000000..297d29462812
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NAU8325 audio Amplifier
>> +
>> +maintainers:
>> +  - Seven Lee <WTLI@nuvoton.com>
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,nau8325
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  nuvoton,vref-impedance:
>> +    description:
>> +      VREF impedance selection.
>> +    enum: ["Open", "25kOhm", "125kOhm", "2.5kOhm"]
> Use standard units (-ohms), not strings. For "open", just omit the
> property.

Is the description of the following modification correct?
nuvoton,vref-impedance:
   $ref: /schemas/types.yaml#/definitions/uint32
   description:
       The vref impedance to be used in KOhms. Voltage Reference impedance
       selection. VREF impedance selection.
   enum:
       - 0 # Disable tie off resistance
       - 1 # 25KOhms
       - 2 # 125KOhms
       - 3 # 2.5kOhms
     default: 2

>
>> +
>> +
>> +  nuvoton,dac-vref:
>> +    description: DAC Reference Voltage Setting.
>> +    enum: ["External VDDA", "1.5V", "1.6V", "1.7V"]
> Use standard units.

Is the description of the following modification correct?
   nuvoton,dac-vref:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
         The dac vref to be used in voltage. DAC reference voltage setting.
     enum:
         - 0 # VDDA
         - 1 # VDDA*1.5
         - 2 # VDDA*1.6
         - 3 # VDDA*1.7
     default: 2

>
>> +
>> +
>> +  nuvoton,alc-enable:
>> +    description:
>> +      Enable digital automatic level control (ALC) function.
>> +    type: boolean
>> +
>> +  nuvoton,clock-detection-disable:
>> +    description:
>> +      When clock detection is enabled, it will detect whether MCLK
>> +      and FS are within the range. MCLK range is from 2.048MHz to 24.57=
6MHz.
>> +      FS range is from 8kHz to 96kHz. And also needs to detect the rati=
o
>> +      MCLK_SRC/LRCK of 256, 400 or 500, and needs to detect the BCLK
>> +      to make sure data is present. There needs to be at least 8 BCLK
>> +      cycles per Frame Sync.
>> +    type: boolean
>> +
>> +  nuvoton,clock-det-data:
>> +    description:
>> +      Request clock detection to require 2048 non-zero samples before e=
nabling
>> +      the audio paths. If set then non-zero samples is required, otherw=
ise it
>> +      doesn't matter.
>> +    type: boolean
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells =3D <1>;
>> +        #size-cells =3D <0>;
>> +        codec@21 {
>> +            compatible =3D "nuvoton,nau8325";
>> +            reg =3D <0x21>;
>> +            nuvoton,vref-impedance =3D "125kOhm";
>> +            nuvoton,dac-vref =3D "1.6V";
>> +            nuvoton,alc-enable;
>> +            nuvoton,clock-det-data;
>> +        };
>> +    };
>> --
>> 2.25.1
>>
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.

