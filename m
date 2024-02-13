Return-Path: <linux-kernel+bounces-63536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238928530D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8901F21422
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290442075;
	Tue, 13 Feb 2024 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fbp79580"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2104.outbound.protection.outlook.com [40.107.21.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022EF8832;
	Tue, 13 Feb 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828407; cv=fail; b=kHtvsCIJXZlomPSLmGGM20VnTuHfZdCLxr70HklZHAx9ng5p0521BT+CB/uwvcTM3FBzGWCdEeIB8jkLBCzUMEhfJ1551FyH5AVd0RtqJmM1uhDZ7opqfiWiy2kAJMc6BtgnTSKAJJKVmw/9XhCy5JgdQJ/i0M54fkKUrTgURZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828407; c=relaxed/simple;
	bh=o6PZS2YwKzSnhXSlzRcaU4SmLdKu3+TS+Xx31lfLSzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eShJ0/4rfT8kkutDev0P640fP5enh2YFCjgNOol3SYIHvEdbCk7rvGWGRYgdNpJV8y/w0Mu+xIOJZlb4rO2XiytX2XAm9m/5lq2/kVgSuBOu6woyNmp7G7tGIp5sq/gDOGYaChTO6eq4391Qd0t6uFpC63cBSzbE5z1LtX6Iuvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fbp79580; arc=fail smtp.client-ip=40.107.21.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCy06SZq8jpRO2nZDqTy+MWxWwYAOfvyiZ3ooxkPa8qIjEnCPzGiolke+9FbOAwulzGKC2zxAROUP4p4PaRzLb9yoeZEqPtYARDgnlOPwkU5aop5CbuIW6A+u8GTNM6sTxb6kv6F23PBeryJRgkQ08XCL6xqp6chzAm2IFpJBdDfueEf4YKJj4llTkbeMTl7tQe6t3RgaV5h5U68SG2LGLPGF5CmuxhqzLg1xDRUDS0p8mCRx+K/Z0dnwba6XBkbwqck49BfEX6qLR0OwRSEwjTOTsvv0KDHq0cQmdq4d8rIGrgtNUcQrOyVqk2nws6lRlporkmakTyoqZqnM6k9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mds3PAtUJxk/u67ibBP24B4EKjxgjNkGlGLSJoBkYxI=;
 b=KGgDOA+XTVHf+D3JEBJe3bjKQYB7flpvavDRBFVb64nC/uxf12IQwcxZRd954jtXreAAdrZ5Zl/HF1fmO9x+pVmW9DtMR1MHNwQPOX0lZZ8BWPXBIIWvBhCFqqm26QHKZ8XznPvBeEusOBCSYEbrNBMjJZ+rwUgc4HL6i8sOFxfQOwbORBZpNKSqJ9+lzofSHVmWLPBj9nk9TiOmFlZ5VcKDiWvSdAsqgjua+Ruh3TkwTwgJATuPP93ccMBT0B/0AIbkMNFq/Rbu/FiFFlTzTczqCSwSt0bXWEJn/BJySfD7+DLZRRzAgnLODrXunCx0zSkNNCh8Fm/BakFDcwxIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mds3PAtUJxk/u67ibBP24B4EKjxgjNkGlGLSJoBkYxI=;
 b=fbp79580z3t1QV8RUmXUf5ZrBmAEabqaCRojT7mYtHVXdkjxtmSI8gMrFDVukEKIK9EcCb8R90B5cW1epV7n9Are2CmkcdRSj/2sHSgF0JFC5JXf4p4DNb63LT08ToAVdpVoC09zObrzhH1pedqeRJ623TZoZjewKbbGhKm4bts73B83g/bfoe4GVIn6R7PJ991u66QU0BzcqN+/IMZJwC/g73kANf+BtF5+4nkaqJlE11yacg/VRK58qwrFEpQZfU9oda0wLmZ+JUPVALOrPmZ5egD09H73wK8T/tJ2d7XCO9QDBT585n5vLZhwKnfPVRaKSV8Cbb+mNA6ootHVWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AS8PR06MB8330.eurprd06.prod.outlook.com (2603:10a6:20b:441::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 12:46:41 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 12:46:41 +0000
Message-ID: <263d486c-655b-4179-841b-de3ad04de38d@vaisala.com>
Date: Tue, 13 Feb 2024 14:46:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: core: Kconfig: Improve USB authorization mode help
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 vesa.jaaskelainen@vaisala.com, geert@linux-m68k.org
References: <20240209142951.27195-1-niko.mauno@vaisala.com>
 <2024021043-nursing-unbridle-cea4@gregkh>
From: Niko Mauno <niko.mauno@vaisala.com>
In-Reply-To: <2024021043-nursing-unbridle-cea4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0000ED90.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:3:0:8) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AS8PR06MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: da035a80-6d81-41b7-cb16-08dc2c91d386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DgR0HoeKz1FMfvoGg+uxBEhQJlAOZP3bHAmx+71k7ClhmGhqsRDfgnKKLHfmjnORLbbxewgU/RLCZ5mZTkj9CVxJQSyfLs/Ae/lhb2AS3JnHIWJJO0AdN8P3ELeDD8PJUqa1H7zdh6Z06Y4Ln56ABuhy+deQ33RxPwrKjr1X6mLd8I2dQHXdRRWVElzKITFuTqX3M4gJA3TzgT0aMGIA5Xnl79xhE5nd8Uj8ZccM7vuO3FWrO/JTNgtL4EniqUGdB90UB2WFyyJCIdi2FgQ04SdBz1BfZJQDPbwqJkTuxkz33MQYyEM2XtQpaKrtVNMCngVBuCFq83/GK2JTwRlDpKY+kLNKF6hKaBqN/4elx3t11dYQWS8oghI0P1WnlJ3pk4HFIcJA9Y4AiakwGhVU7a6I1gXD2oLgnp9ZfN++kwQNZZNbboaygcQBPd37Q3ajphM40LwMQZmiO8G8+l+eUOEwuxd9xnezEuI7uqoUJjkZlXCzZwirHT2pvoDX98VQqOqSuHmzPrZHo4iWgH6H5j3r0QTd4PriqsSCNiSA5ctR1Kn+C3NFQkbMydVyH4Rk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(396003)(136003)(346002)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(2906002)(5660300002)(26005)(6512007)(6506007)(2616005)(36756003)(478600001)(38100700002)(86362001)(66476007)(31686004)(6916009)(66556008)(4326008)(8936002)(316002)(31696002)(83380400001)(8676002)(66946007)(6486002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2RlWlNneXNSckh1YytZRTZLL2JIb05vRFFpSmdOYVMxR3hhWjRvTFFUODlI?=
 =?utf-8?B?MDdLanY4NThNcmZrd3cwZ3lmNmR4ZDQwQm41eVRORDAvZjV2Wnplci95REdj?=
 =?utf-8?B?V3RYOTNlWk9ERnkxUXJyT2RKbS9ITmw0TitVOTkvYndKbGp1NnhnOVYxUC84?=
 =?utf-8?B?QVhkYXBOeFl2VGJWb3lSeGhBOWdZQ0ZrYWlNSjdwWjFkMlprc21BeG00NEY4?=
 =?utf-8?B?dWg3QW1SUE00aW8zQ1gzQnk4V2N3cDZOYzNrTitwMEQ2NXZOblFGcXRsSGV0?=
 =?utf-8?B?dkhrTkFIZHpnY3N6bUJndXQrSWcvVWlxckJKNkEzVUFqaGRDb29tWW1nL2F0?=
 =?utf-8?B?cUpJS29tcnF3MVZhYy9hVHhSSWVoQ3JDajRld25rSDdoSU9XQXJrQjNOS0o1?=
 =?utf-8?B?bGJHaUd3ditSd1hNVHZncXVncUNKeGRmWXQ5Y1VFY002TUxDUDlKZmNYd1lT?=
 =?utf-8?B?L1VJaFNteTQyVmVSNUR1VDEyMXIySXNLT2pFSTJ1NElHY0ZmRElvQ2Q3a3Rs?=
 =?utf-8?B?b25LSEgrblI2K0pvdThidytoeHdRblR1TExzSVF2Rk5PcEpMVWlkUzE3R2Zj?=
 =?utf-8?B?WUtBRlZJcWZmN0lkTHlWVG1zYVlaRTd6OS9oYnJGN0lqdUdvQTJDbEZuODE1?=
 =?utf-8?B?Ym8zb2dCeSs3c01pL2lldGxpT09mRUNjckJoMTVlU2hVNEJ3Y05TMzB0aVM4?=
 =?utf-8?B?VmJmT0s4SXRsNHBrK1JOTk1CakVkNGIyMnpBYVpqekt1clZQdDhyaUNydHd6?=
 =?utf-8?B?Qkp5N0J0cmcyeVZLU0IvWmZqSlB4cjk0MkpCN3ZPMXZkbE51SEtyQ2VTYjdB?=
 =?utf-8?B?OFMrTEwwaWw2ZTJ6RHFlSUlHbU92d1ZUckNnbHMyWHk5b1FreXE0cGduTnpB?=
 =?utf-8?B?MmhOcmRlYXZEKzNxSXRHaWFVSysxUFFQY2tGVmlRbGR4Rnd3aUZvL2VTMGZ0?=
 =?utf-8?B?REtTclF2TmtBVUlNRWhGdmFvdVg2M3o0Tk9GbytkbmE2RmtJNUV3UUFKQ2NZ?=
 =?utf-8?B?QTNFZHB4VDZNUHozdTVTQXNFL2pQMXQ5RjZYb2V1UkFuTnI2MzBlNmZ4RjBr?=
 =?utf-8?B?ZVhsS3R3NUZHUGJ6Vlk4SWh4dFo4cXFBT0hXTXQrdVVSb3p1T2U4UVZraFpY?=
 =?utf-8?B?eXhoZ1hkRmIxTWdTUmd3THdpcFVEV2o1Q0gzRnlyZGpmelZWRnBaN3NPUWRV?=
 =?utf-8?B?b0R6cUtkZVFkTzFOZlF0TitUa2VrdGtsWVVncjNnUmQ0S3ZRWFNFSEl0TEdE?=
 =?utf-8?B?RFEySWZ6V1Iyc24zK3BNSUVlOElGVFNpaUZDbjZmaVBhOTR1cXh4SGx6UTJu?=
 =?utf-8?B?SjlsckpSQ1lyNXh6WlJkRURJTGxtNE9QbEgxamRxL2NhVHc1Y0oxRGNVYXRx?=
 =?utf-8?B?Y0pXRG9QVGNiSjNRSDFnSWcxQ1B2OEh2Tk4xOTlCcXoxSG53b1h3WjVvNzVq?=
 =?utf-8?B?R3ZhUEpkcWpyQnAwRkphTDI3c1UyRHg0L29uN0U5Qk16OFZZdDJwM2hRSnU3?=
 =?utf-8?B?THhZczA1QnZiWCtaYldlcS9xQU91Y3pkRVNGWnpIZ1hkb2oxckNhYkMwUTF5?=
 =?utf-8?B?b0kxYVlmTXdtVlRiTVRuQzlRUHl3d29OWEdNUytvajhTWUlURnFvRE0wZ2d4?=
 =?utf-8?B?M2xEcHZMNjBQV09udXVFcEVMUWlTNUsyTnorOFppaFc4Zld2bjFDbXF6UUp6?=
 =?utf-8?B?dk5sQVpEUFpDR3hzQVBCcU9BWlo0QXFieWZvczllRUxBejNBMGJ0a2hUYm40?=
 =?utf-8?B?ek5kWkpoVXJWYTgxR1VjeUE5WjYxR0VDQ0ZVVzdOSVVFbkdCWTZobHlIMkFV?=
 =?utf-8?B?VW1PNkp5bktwcEhUdmREVzR0REk1eFZuMDl5ODBkNlNRSlNNR0xQVUV6T3ZH?=
 =?utf-8?B?NUE2ZlE5VlQ2bnhrWmhhNGlTNW1zSStkdlh1b2REMnMzSjFSdnhmVGc3VEhF?=
 =?utf-8?B?QXpmVzk1dFFZZlk3NG9HS2pCUVhwdlpMSis0c0hjd0MwZXFXOEdRWWJoOWd2?=
 =?utf-8?B?Znp3d3g4YW9QVEVNeDdhQVBlR2R4WHpzUno1ZHpzN25kRjBZODBsN1ZaU0Ew?=
 =?utf-8?B?VUErTmZFV3F2SWhMVktHRXlHVVZpT21PWHIyKzRXYnFoOFN0MXVUZDFqUEsr?=
 =?utf-8?B?b2kzMW4yYU1uOXQrZVhsQzc3VnZEQ0NoSTNvOFpFTnBtNHE4L2tTRlBMRDFW?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da035a80-6d81-41b7-cb16-08dc2c91d386
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:46:41.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRJ5Bsbg1SwQxnHhxmzEiBFxZx2vbqzmku6w8ydchnFuMdj7gijaSzJVmbqNw7kAQUja61wVYQzP4Mei2Vbf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8330

On 10.2.2024 12.27, Greg KH wrote:
> On Fri, Feb 09, 2024 at 04:29:51PM +0200, niko.mauno@vaisala.com wrote:
>> From: Niko Mauno <niko.mauno@vaisala.com>
>>
>> Update the default USB device authorization mode help text so that the
>> meaning of the option and it's available values are described more
>> accurately.
>>
>> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
>> ---
> 
> Shouldn't there be a "Reported-by:" line here to give proper credit for
> the developer who asked for this?
> 
> 
> 
>>   drivers/usb/core/Kconfig | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
>> index f337aaea7604..4665df550d36 100644
>> --- a/drivers/usb/core/Kconfig
>> +++ b/drivers/usb/core/Kconfig
>> @@ -126,10 +126,21 @@ config USB_DEFAULT_AUTHORIZATION_MODE
>>   	  Select the default USB device authorization mode. Can be overridden
>>   	  with usbcore.authorized_default command line or module parameter.
>>   
>> -	  The available values have the following meanings:
>> -		0 is unauthorized for all devices
>> -		1 is authorized for all devices (default)
>> -		2 is authorized for internal devices
>> +	  This option allows you to choose whether USB devices that are
>> +	  connected to the system can be used by default, or if they are
>> +	  locked down.
>> +
>> +	  With value 0 all connected USB devices with the exception of root
>> +	  hub require user space authorization before they can be used.
>> +
>> +	  With value 1 (default) no user space authorization is required to
>> +	  use connected USB devices.
>> +
>> +	  With value 2 all connected USB devices with exception of internal
>> +	  USB devices require user space authorization before they can be
>> +	  used. Note that in this mode the differentiation between internal
>> +	  and external USB devices relies on ACPI, and on systems without
>> +	  ACPI selecting value 2 is analogous to selecting value 0.
>>   
>>   	  If the default value is too permissive but you are unsure which mode
>>   	  to use, say 2.
> 
> In looking this over, this last sentance really isn't a good suggestion,
> as it will turn people's machine into one that by default, doesn't
> accept external USB devices, which is probably NOT what they want at
> all, and is NOT how Linux has worked for the past 20+ years.
> 
> So maybe a bit better clarification as what the normal default should be
> here?
> 
> thanks,
> 
> greg k-h

Thank you for the pointers, submitted v2 to address aforementioned issues.
-Niko

