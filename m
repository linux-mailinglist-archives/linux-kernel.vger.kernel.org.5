Return-Path: <linux-kernel+bounces-98502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C1877B03
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838B01F2101C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2AF9FD;
	Mon, 11 Mar 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="BfV0LQAk"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2054.outbound.protection.outlook.com [40.107.215.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16DD516;
	Mon, 11 Mar 2024 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139418; cv=fail; b=UnGiK9z/laiROkJGjwhK7Sy8oZV6TEDozYnNcup92ook3udqnuatPAW9pJvZk0DEILrhfM4PDIHBqJ4sMjniX95mx9xvns7SmtPvJW/x6iYykADfVKFjItBGUaaiuoafpkGaZIX3PS0bQpmUvKLX2SHQw0FHcDZIeEuuEiYM7UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139418; c=relaxed/simple;
	bh=D4H031LZKQGHpWHQoJ7BzBFN4n7qq/iv2MA/rmHUtAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDndnDKM+qRV0qRoLM8M1cjSnXer1VfgI+vp3acDW/2Q6LFJJgmkJDWLyhvaPTmYZ/XIi/7a0D5AlIxv7RmG4oOb3pA3y75pUAYifs1UHGucTLgSg7yOYdwfTuX7MVYE9OJnsaRapSJaRMQqi85o6YVgODyyy2vmvqbtA+S6yAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=BfV0LQAk; arc=fail smtp.client-ip=40.107.215.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo346L9LJ5R8aS99WIrxs3rHVUVlDwU+6ENQ5DkaXbolaJeqb/Gj5vA0UW+B06NOhj/5kTK2bdjdpHhco9GLe8ADumQm5XrmjZlV/xGdAxJ/m5gqmTlUz/nvLKSJDNpRm8cyVI3j1zuqF1fWO31W9XpDUBweYloNN7okCvR4t4UNiUeNEhYUwS3wPDFg2xqRUBQKaxJBhuHoikXhU9kSvpg/ia/62fCi9ZyE3uacxRZftmVEv80Q6KexyZDANtB+R9xfYiWeIRlzU6Z+CgoIkUt6nKBNHDKJGMC9J4A34GTQVx5P115noCZN7YnkdZIMJyNBaDsAjUMfBTbRz/gMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxYCnF1J/j6rr2oRDR7vsfgEmBwoUr+sk/4c7MxLth8=;
 b=hFiz+qNmdvOGapV6EpOJdknkg9/5WKr2fUpYg2YQS0gjIaVWlxZBDHEz5n4Vqr+YGQ64SjKUzp6ZKUhuCxSe/psO9e4DWSpjJy/mBXWAq7X8DcunLEYuYhssEMrhvW6I5qZqUlohNSyw+4OV9uAbdLGmD8GcXJqjEFj3/UtuYrPZrM8WMKQEuDs0LyvNWymHh6dCYS6F5qkwsos2kyOZySvJUmn4KeN6+1Px5azT4a4O0U+Z5+0/D/WXKqlqCb/ZtnT1D8hb3TlDVoK4vuHF/r5gO/Ri9zxQfGLdAhF1KGlwVPQIOslSKh7JHV7OdOIWYfUrbwgZxQRJdxJ+FDJWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxYCnF1J/j6rr2oRDR7vsfgEmBwoUr+sk/4c7MxLth8=;
 b=BfV0LQAktzyHTjpe04dkFUh5lr/bbQgI/vGTl8l8NahKBaYn/SQKCCKCabnmaVgTn8KqHjy67gQyonv5ffzoeKwkvEwQm58TIZCYh5X6W/CjeGdDn0m8zCscPia4B9sGXTjPzIjiVeJD4kJPOc7KthCBCGjLG/xgn3kEepGyvV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from SEYPR03MB8378.apcprd03.prod.outlook.com (2603:1096:101:1fd::9)
 by TY0PR03MB6773.apcprd03.prod.outlook.com (2603:1096:400:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Mon, 11 Mar
 2024 06:43:26 +0000
Received: from SEYPR03MB8378.apcprd03.prod.outlook.com
 ([fe80::56e1:5482:dfef:a8a9]) by SEYPR03MB8378.apcprd03.prod.outlook.com
 ([fe80::56e1:5482:dfef:a8a9%4]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 06:43:26 +0000
Message-ID: <0c78b07d-a50e-485b-91eb-6dd167869268@nuvoton.com>
Date: Mon, 11 Mar 2024 14:43:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
 CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
 supercraig0719@gmail.com, dardar923@gmail.com
References: <20240304101523.538989-1-wtli@nuvoton.com>
 <20240304101523.538989-2-wtli@nuvoton.com>
 <20240304133731.GA105655-robh@kernel.org>
From: WTLI <wtli@nuvoton.com>
In-Reply-To: <20240304133731.GA105655-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To SEYPR03MB8378.apcprd03.prod.outlook.com
 (2603:1096:101:1fd::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB8378:EE_|TY0PR03MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a8d598-1a87-4bb8-cb26-08dc41968dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+JgeC4AvDNv+GYyVVo0Qn1jHvJz312q8T/29GZIGlsQ0lYUL7O6+i+J977khHlJkwZq5BCBMIBmN3yJp6zW+5BqRiSP7s9bNfWX/PCeZxUYFTe2DWJdTBKt3gGjUFERcdJxyVBJpFEI02hmxLgmX7hZkM4zxraZGE4i69hI/eZyTp/0HbSpizN0r53ju9OxoBleH+E1YjCxJoOI3OQ9vGxlZJ7gJwXcWPOwgWfrNTNSPOL9KzvtJwqd6dnqT5hdgmKmsjGXGUgfJ2gnRuzi6yf9SX3jUjuiZ/tdBuVYKqzJh9V8fo+8q8jRmgbn9k759PLecnVMPXnXoRSCTNnkJG263OQJzkd1ivbLv1cZHl4uHs/jsGShh/sZ6uacoCobTriajcPEHtjeV3snOLcxeIYThCZw2YxYqK/W5Gd5yTdOjM/QrvZub2Dfy/FACZ82/LQxQ02nq4YouArY/7XIEDshlTfAHPLBrvF7wJJqbxdP1oykEqMlXttDL5R9/v6nVGSkQ9rMJcjjylVp48W+1zbRMsNrJ70xLX3DXuOUnjSsiMM6pJfzjReB0HocevcGo7NynPcZeKMSsX1JrR+eRTPNt6LTMbS8w9TsdIST0ZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB8378.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0JjWHhqRDRxWlVGNXVGcytCcHFVaUQ4OGU5TFNDNXBnUUtsekZ0U2xoNGhm?=
 =?utf-8?B?a3htY3UrdzRuTHlIb0VQUlpwenBuZWxTQzVraHVaa1dnc3BZazFoVmU5a2Fq?=
 =?utf-8?B?b2FPOThVNjh3VXQ5UXQ4a201SlVlcGo0MmdBSXc5R3hDK3dYS2RDalU2VklX?=
 =?utf-8?B?NGpVZjF0ZllCMU5MSTlNejFTU2xpQTFPVHNCTDNIYWpaUVFselJIK2IvbWcz?=
 =?utf-8?B?Tm9QRXp6TllwaFVVSEdVaXdPdURxN3l1Qno1Uy9ON2Uvai9HYUh0eTQyMFl1?=
 =?utf-8?B?NTlrZ2FFbFBVUEsyZm1DS0UvYm9OS0lCTng3dUp2aVlyaGdzY3B3bUU1d25L?=
 =?utf-8?B?N2NRdE5DZ3BjTWZUQVNKb2xPWktOZGNYMVp5YktsMThzVVcraVR5c21lVnE0?=
 =?utf-8?B?VExSbUVsaExUOGpsS2FpeG1ONE5FMC80YXdtajc3RkdaMi92VmN3NDNHOUlt?=
 =?utf-8?B?WDJ3dWxxTTVhM3BuQlRvNFJ2d3RyeGdCYU9xVHo1K2dZaHcwUGxsdzZyNThw?=
 =?utf-8?B?UXdNZDhVNnVTdHZXVktvSW9BeTlad2RSK0dJbU5NRFgzN2QxVkhhaXZjeisr?=
 =?utf-8?B?RDBBbVJLd2JGSVZkaWExSUljL0NqYXZLTTFaa2dqUGJSRzZDamlzUklzbFAz?=
 =?utf-8?B?cTVqSk5EL29QOWE4K2ZVU2lLemFkaDhtSEdUc3hna0FXRWJZcG1WMjVxZUND?=
 =?utf-8?B?MEN5ZmF1RnlMbUlLMXREY1dPdG1ocUxxOTBNdXRLT1liT2p6RUlJYldMZzFQ?=
 =?utf-8?B?QlBaSUREN0RmZ0ZvcW5LZUVJQmV0ZE9SRWZzWW84a1pnT1ZsWTJVTGFYSE5Y?=
 =?utf-8?B?R1ZhK1MvckU1SHUzT01idFkvNXV3a05obFRuUDdHd2FSSW9lWlFabDJUYlBn?=
 =?utf-8?B?a3J3ZVNxdFZMeE4rVnBDZzUzVC9ZcVNURmZZMmJqOVdHNEE0RGUzbFJFRWho?=
 =?utf-8?B?VjhWVHUwZ21zR05VWEZRSHJlV2wzSXlPQzdSYS85aE5Kb3NCUlBXS256eEFP?=
 =?utf-8?B?Z3hQbGVjMDlvaHR6SGN4NGpHTlJnT0hhMnZ2K0hJdFA5T0ExTWVmNmlnZ0Fk?=
 =?utf-8?B?K0U0ZjRPeDkzWVdpb3lMRVAyMWVKQVVoTjluZDdicXNYSUVvRm5QekZ2Q1ZR?=
 =?utf-8?B?ZFV1TVBTZmJTSWlkNjRRQi9iWCtQcXdmbHFMazhSUkZKR2hEbkVhMUZGcHVm?=
 =?utf-8?B?S3pGcGtTOHpvbDV1eVBic202UCt4RHdNdzNkdHJGU0w4dytleTZQc0hadTIz?=
 =?utf-8?B?SjhlWUhOdG1sQmZFOEwzeE4vMmg3OEpPbzgrSk5JTmdrODA5eTU5MXc4REp6?=
 =?utf-8?B?amV4NHdYSis4bkFUODNrSFBTNmNhaGxYRHhGellBYWJpN1hrOUVZcE4zcTYv?=
 =?utf-8?B?emJZQzFtSm41SHF6dWQ0RWxDNm4yMFhEQi9sTkI1SmRWU3ZBblpxWmc2NFZH?=
 =?utf-8?B?V045aUpaT1pydkd4Mi9vVytsSFpNczJ1cVdmeFZXRFlwVENRVHEweUJqRENt?=
 =?utf-8?B?OUM5SDJrL09LcEloZTh6Ykx0eXpSWG00U2FwZzRaaWxRYzhqOFgxVGFuSUgy?=
 =?utf-8?B?WEM4ZTErRCtIRk9aRVlLY3FWcURaZjJna05xZ3BwOFQ4TTdWYXBCYWhDR2Nl?=
 =?utf-8?B?T0U4dnJHeFZPQ0Mxc29oNnBLWXFHWE1tSHRlUUNwS0MxSlVITGZTdURMZjd1?=
 =?utf-8?B?d2NtZTJURGU5K2tzd3ZMeUY3b0lsWlFITGpiclUzelJaUFJDVU9QM0o5WVJ5?=
 =?utf-8?B?VmVTOExQSVhaNDk3MW5LL1VYMDZkM2YyOUx4UEJPZjcvUVVEOG9wN2hmbUM3?=
 =?utf-8?B?L0F3ckJ1MEs4N0dyUUFQaUJ6a09VSWtHYzNLK2FmWGxpVEV4ZFFSc2RURksv?=
 =?utf-8?B?WWFNSHR1N0ZEY0Zob1NEOXJMMUVyTHRNQ0RvMVRldVpkOVBPUlFiVTZSb01V?=
 =?utf-8?B?dmVoQlR4TXc3dDNvbXRGeTI4SHRhRCt2NnFOZ08yc2E4emRFT0d1YkJNSklR?=
 =?utf-8?B?c29mTEJKNGdDREN0K25DT1AwbUFPR05OUjVIQktMTkl0NUNPdzFLNnFESm1P?=
 =?utf-8?B?ZTZjWWx3YS9SLzJYVTI3eDBIck5PN3ZpQ0ZYZ2hheGpJZ3hYRFllSFJzMytS?=
 =?utf-8?Q?EdiRt8LCbRZQiDoqZyU8pAxhi?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a8d598-1a87-4bb8-cb26-08dc41968dae
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB8378.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 06:43:25.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8pAL3EUc2lTPi21BbsGlLS+a9URj1RU8+R+zcbZjRS7iv+ZLgVqCcYS3BHaaHk4kfL6lqqXuy2ZBTz6XK2wZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6773


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

okay. I will.

>
>> Signed-off-by: Seven Lee <wtli@nuvoton.com>
>> ---
>>   .../bindings/sound/nuvoton,nau8325.yaml       | 74 +++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100755 Documentation/devicetree/bindings/sound/nuvoton,nau=
8325.yaml
> Schemas aren't executable. checkpatch.pl will tell you this.

okay, I will use the checkpatch.pl.

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

okay, I will.

>
>> +
>> +
>> +  nuvoton,dac-vref:
>> +    description: DAC Reference Voltage Setting.
>> +    enum: ["External VDDA", "1.5V", "1.6V", "1.7V"]
> Use standard units.

okay, I will use standard units.

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

