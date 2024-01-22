Return-Path: <linux-kernel+bounces-33046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F978363A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E1D28C8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360CD3D966;
	Mon, 22 Jan 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Zz2OMR5V"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792093D576;
	Mon, 22 Jan 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927402; cv=fail; b=NUY17BOFJUkps0uWMDIlgvzjjpGcmfHpJYlBfud8kSJ/IfgdP3YJ94OY5eVdzoqKTmc9J/JfokoziHPwexIBZ8xXyY8tiqtEwRpdPfo6wTGtQX0+f9pWK24kLdNDg/i07KtXpTyPTu+pGHNJBdXktNyx7wd52dcfbvhEuRJegV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927402; c=relaxed/simple;
	bh=XTxNK4WsSjjL0QZpplfgVBS90moeRvsfz3QSwRi248o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C2d3qUO1Rn/7EPY5TBCsraX/7wly5kzG0yNe76bv+slH6kR+NnhTbvNIedTE9e/Ct6n9oLjDynnwVXUhdlj3ddVtsNpM+pT33oy3AZyq79QFhgvcm7c2aJZAVAoUkn6qp6+kktixTFCTuHvMf9Dhl5QYT3BOMOZJHjRySPKYn+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Zz2OMR5V; arc=fail smtp.client-ip=40.107.14.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/Z99rL9AqpjXmV4p7d9NeO078W0dK9vcxydWm6CKm7k9ujVzUsXUHP9C44mntF2Vj034TYYVtdW+8YMOy+w6rEe2bGkUVsChibNgbyRVU/NgyAakkutPWjxyBqWW4hV6UXUJtLUvV3NnFJR3ciThNZlKhq2VaaNTl8j+ZXFK4LO11PStBwvGyk7FyZ0j6ns47I5fsbz6fVs8ttr8GE1OjbcfqOTR3BMBSedc29ral3W7XmB69Dsr+j3Wb+U8F/WxiFQ99uCoQyGgImb+ubJ2ZTH8h6fmd7nSumMukUCxiLdCN2+08jygwGeIae+nFxxQMGvmDTitZLUhItKaWrBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI8n4/6dI+DVCF6+wXoA5tIjqn3MBN0lKQhXfs1I6yg=;
 b=Ez2xlfVtnCEjWrGrQOoSg9tgFUcHg0OussO6C2Py4hk+P2GLSgt59nSEptlDjsALxi7+Yy0fBXLEWso27u9h9PBSIwRrGIR/JqoYdr1oTKDn8zOUF8iZOPuI43e7ItkHsNCHavDEJT9+ORHXT5iqCh/pyfEk1JpyuRIsq1v0JZcMKIOze8Yk+oibFOlSPGAPb+/ncrU/hOVS0ZGKp5zhW6Nui7LP2lKwUirvBK10EVpoiZFD2zrYhen7tJ1qatJLcGEaXEZg4hSy0iKSdkN08wRT/XtHyBdOkrrpqoGXkFjpNe2sTRQIYa4lQ/Rxt0KB+W3uB2LzEzlIRj637+xRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI8n4/6dI+DVCF6+wXoA5tIjqn3MBN0lKQhXfs1I6yg=;
 b=Zz2OMR5Vubf7xxnvYlZXr9slrwf3czB5Hg0fcjijMTYnRWvwVAEFGiUNVVb0oU0JWCT2ax6XSeO82sepkOqRCkBVI8acIXPYG5F8DZq7wN2RWXeliXwcvsftj06Uvl676bzhg5pBZBItrKb+gqLZ+wL7lEs2lG1cv9+4CFE2k9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI0PR08MB10428.eurprd08.prod.outlook.com (2603:10a6:800:1b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 12:43:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:43:16 +0000
Message-ID: <1c74a991-ccf9-4074-8111-0160ba4e05b4@wolfvision.net>
Date: Mon, 22 Jan 2024 13:43:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for
 XMOS XVF3500
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
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
 <34a421e3-b11f-4e61-b894-0b42a1330d8f@linaro.org>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <34a421e3-b11f-4e61-b894-0b42a1330d8f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0055.eurprd09.prod.outlook.com
 (2603:10a6:802:1::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI0PR08MB10428:EE_
X-MS-Office365-Filtering-Correlation-Id: b71adfd6-12fc-464d-7b82-08dc1b47b42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VucsPJLYKXQIKEATIWHT1HKO7FHTkYUJ96maiG//lQBralL7A+V1oBmUQ7vNQP2wrQQh6RYQTk5OFUzpNpU58EAZgm0ZBeYnyxQ9O+LMmQVmv7dtacuj1Ng1ke/K0qRvRIxDtjWCCzL9tuxbuotaLlj5sC0mnxDodLm1z8AW5HIOgV6Uz+Nk0Zs003byiZAf0QomMjlZ3DXaZt8TAQ3eE5kRf0xuMp2g5vsETVj9WEJ/vPpqVccX88BXmNNNDN/kg7AAPK/uD/CPR/aO6nTnhC4ftc85pSNGYoVwKBln2bUXhQ/m/EiifLGcgz0KMRAo+CAPR/AhFULews3oItcuEAJBEH8SUv+bUGTUhvOOdRcVGCHbX8Q+G5QuVwl50GNu6qcpD+O8LDQ6gtNw3B91EUjfOatZWnkMeorBYUc0ii7abCpVByiYMWiD5PVo+EFpJQVkt6CurUGhI56satO4/3eNU/DbBjEJ7cpcyPUzfJmtToCjJY2YhKcOWxrG4WwLnXMZJs4a1yBPHj9ryGcXawOwaAC+kxINM0mdDPMFBH4sN37f3pZ3paHIWOtFCiK1RnbISA1Meahs3Owp0O/LfqEGfKTRyYHHd7rXzCJcksliPpYjC7+r79NGFBUpJ17lQUdSz4v0Wnc8w1Iw2SFHog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39850400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(5660300002)(66946007)(38100700002)(4326008)(2616005)(53546011)(8936002)(8676002)(44832011)(478600001)(41300700001)(2906002)(7416002)(66476007)(6666004)(6486002)(6506007)(66556008)(316002)(6512007)(110136005)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFA0b1IvTjRQd0U2TlMxU2srcUJFaG5GaEM1TmdGYzloZlhoNGdpOVpGby9t?=
 =?utf-8?B?bXRXalA0d2YzMWJueFoza2V1SHRLQWZGUW5SekV5cGRpSHdvNkR2NXBaT3c1?=
 =?utf-8?B?RUh2WDBYejZKQVNGTWJNV0kvYTBwZS9od1J3bWVJYXhXcWh6QnZjS2UrQjBy?=
 =?utf-8?B?ZDZGZlQ4VS8rZ2ZpSGU5Rmhsck1ZdFpjL1FTMnBSbGNJUnFZNWhvMXNkcEEy?=
 =?utf-8?B?SzdYWVhBeVU1dmlENk1RbW9yOXFTVTVjb2t1eDBwTjhPdEVXampDMXZMVEF3?=
 =?utf-8?B?Z2pTUHVySlc0U29NZ05abEtjZnZoMU55ZXRmcTBiQVljbVZPWnJsZExvbUVW?=
 =?utf-8?B?bmFmcStzb1MrRkM1T0FQMlp2WjQ3eU9qcUx1SkJxUTc1ZFoxQkduRDh3R1Ir?=
 =?utf-8?B?c0hQTTlUb1UrUUtYYU9EQjJBOEthcWRteVQ4VTN5NGtEOFVzSGhVb09TRVFV?=
 =?utf-8?B?cnVCelB6R2lWS1ZMekFmKzhDRUhxREtlSjI3OExPVzVCVmduUHpCZ2l1VDV6?=
 =?utf-8?B?ME5VY2FHQkd1Z0lxblpxNTFobnorZFAyWjVrWmlrNk5DeEh1M2JoeWM3U1pE?=
 =?utf-8?B?Tyt5aGpOSUI0amZ1aHFtcWRCcTA3M1NQVE1ZQnYySnVHNkRaZ01NNUFEaTBM?=
 =?utf-8?B?R3lDdWp0bnR0Mm9qNWI5Ync5NUZ3bHc2bG11NVE5aXp0SGdUOG1HUVJRRDNY?=
 =?utf-8?B?S2lsRVpCRDdBZDBPcW9ZV3N3MkdJQW5JNW0wM2I1TWhiYjBHSFBBUkZzV3ZW?=
 =?utf-8?B?SUg5ckRnWWdtbngzMFNrTlUxVjBHS292SCtES1dHRmZIeXBrdlVCUDdqOUti?=
 =?utf-8?B?QVQwV1IwR0YwMVYxZWVVSTZNdkZ5cHYzWVF6Umo0RHZqa2VOZ0N0MDlIWWNy?=
 =?utf-8?B?YkR4ZU5kYmJKR1BDWkY4SDdxYkFBcDhQRFNSSEdpMFFvMHRldmFqS2VFVVYr?=
 =?utf-8?B?MFN2SWhJTVl2RTFLT0NRUTQ5RjVtaHI2UnBGQjREbzJhUFExVU1VK2hLS0RD?=
 =?utf-8?B?Z2J1U3lDM21KMkFyRnpOMkZOaHAzWFdhUEhsdlpaYjk5TUZqbDhZNHVmbTFr?=
 =?utf-8?B?U3BhZ3NoZ2dkOFVXT0l2Vm5kNXBRWi9GNTBub3NNeTNJYnlpUlIvQlFrRGxS?=
 =?utf-8?B?ejBiMUFzbDBNUzFXS2Nyc3ZRUCtOMHB0TmJVVWVYZUt5eTU5dlI4VjJEZDl6?=
 =?utf-8?B?WHhDaUM2REJLdmZFajQ5SCtyZFQ3eHF2cnUvVmtiREtCTmpnemlJb0h6WUlY?=
 =?utf-8?B?U1VmWnZnQndYMnRBNldTaXZmUXlIZk4wRW1QUFkrNVBjcGp3ZTh4Y1FCd3RM?=
 =?utf-8?B?NXUwTUMxYlQ1WUswZWhyemZiY3UrU1pKY2M2RnBJRFNaQWRGUzhDNWlhaGxr?=
 =?utf-8?B?cWpOSXRBVmtjZnljNXFZR25XWkNPUVRJK2ZGeERBR0w4R0pHZ1RPYmNQSm9D?=
 =?utf-8?B?OUZ5cm90dmtHbDBVa1ZpbXZhMnJrL281VGVNQ2VXdEFDd3J1OU01V0FqUkxP?=
 =?utf-8?B?OVM5MHFVdDFVN2VselFabUhlWWczL3BzUS9QZmREOTVYY0x5WnBBZEV5YktI?=
 =?utf-8?B?aUJrNHdHRUFwck9Nbk5ZcytxczVEUVZ1bm9WTXF1TEcxZnJoejNVemZENnRl?=
 =?utf-8?B?ZDgxcmRMUjlTRnJLL3VkZ3V5azZMeGxpTUZ6R3JUMDlCWVI3UXlyRm92dEZp?=
 =?utf-8?B?azZybzhXN1lrd1JGcDBNcEdaQ2wxY3Brb0MyTDBacVMvT1pXNUorQkwvNHQ4?=
 =?utf-8?B?dUZzR1NtTi85VHJ5dkdWMTEwWUUxVjk0dXRLeEdDMlZMZVV5TEk0Z0NoUFR5?=
 =?utf-8?B?bjl3dzJXYUIwUC9sazhnaTFUd2pnRmxnaHlGWTNJQ2pWK0ZYUjlrOFdwSENq?=
 =?utf-8?B?M0hYWkZHVTFsYmFuNHp0QkxTemZzK20ySktMMEIzTFo5QWo1bTBHemFLa0Zt?=
 =?utf-8?B?anpjTmhOZFE4MmppaTFCR082dUZUUERKSnRzY0gveDhxOElwSkl4THlmeHFE?=
 =?utf-8?B?YkhySThaSVRYRVJSbFlwYlc0NWdhM3ZKOFhnbk8vR0EwQlFYYlN6YnlENFdk?=
 =?utf-8?B?QU5MR0hsUWNrV0hjd29jSWh4T05OYWFYQ2VpdUhseGZZbWpGUERqaXhGQU1x?=
 =?utf-8?B?alBmWDlwTkdPcTdhaG9SdTY2dWNxY1dUNDUrd01OaFVud1pKQ3UwTEpWclJv?=
 =?utf-8?B?MlhpYzlnNjZiMi9DSzgrWGdoNThJZUlDU2ZDYnFueWY4M2dlUkNFVWtKZ0VH?=
 =?utf-8?Q?e9gaXmZV1gnG0hAj0tQUKU8FudRQ3xafuXUEnD8OPM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b71adfd6-12fc-464d-7b82-08dc1b47b42f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:43:16.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLMABFmnhs9Opzw8xDsu1IIfm0xlk+C3IHAAf48V37jjG+DqzEfCt4lukUPoUacaK3ACRSkqe+6skc2fOppWbmNYO3PDFnk1bETnhgZ+BKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10428

On 22.01.24 13:29, Krzysztof Kozlowski wrote:
> On 16/01/2024 08:29, Javier Carrasco wrote:
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
> You have two Linux devices: USB device and platform device. The platform
> device controls power of USB device. If platform device goes to some
> variant of sleep (PRM, system PM) before the USB device, how will USB
> device react? Will it work? I doubt.
> 
> You have no ordering / dependencies / device links between these devices
> thus possible problems.
> 
Thank you for clarifying this point. I only covered the platform device
and such device links are missing. I will opt for the inclusion in
onboard_usb_hub, which already covers both devices.
>>>> non-HUB devices in the onboard_usb_hub driver even though it supports
>>>> more operations?
>>>>
>>>> I am adding linux-usb to this thread in case someone has other suggestions.
>>>
>>> I don't see any difference between this device and onboard hub. The
>>> concept and the problem is the same. Therefore either treat it as as
>>> onboard hub or come with USB-version of PCI power sequencing.
>>>
>> I have nothing against adding this device to onboard_usb_hub as long as
>> it is valid upstream, so no conflicts arise with new additions to the
>> list (which was the trigger for all of this with v6.7). That is
> 
> I am sorry, but we talk here only about upstream. I don't know therefore
> what "valid upstream" means. You cannot send a patch which is "not valid
> upstream". I mean, technically you can, but this would be waste of our
> time and receive rather annoyed responses.
> 
I meant valid upstream, so sending such patch makes sense to the
community (and not only to us). So far you are the source of feedback
upstream, so I will follow your advice.
>> obviously the most trivial solution and as you said, it is justs a
>> naming issue because the power sequence is not HUB-specific.
> 
> I would ack it. Others? No clue, I also do not remember full story
> behind onboard USB hub and why it was called "hub" instead of "onboard
> USB device".
> 
> Best regards,
> Krzysztof
> 

Thank you and best regards,
Javier Carrasco


