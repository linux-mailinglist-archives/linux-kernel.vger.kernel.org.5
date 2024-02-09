Return-Path: <linux-kernel+bounces-59319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE984F550
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8331F24C9D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2EC374E9;
	Fri,  9 Feb 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="MJvNIvvP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58DA3717B;
	Fri,  9 Feb 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482352; cv=fail; b=rCo7Rdm9PUIGya0YBJS7hiAwT94g4x74shHsYWAXrfNsfQ7f3+6sFzx6C3IhscoPX3k/7CLTouEfFwqThZ2Z5zBBdMidNSZyZyfRPFTG/79H8Z3CyDRd7lcmzUcE0Doqcbq8+eoSw7N3UrIxyFnjDUjMFFFVd/cUpkVFMUzIfPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482352; c=relaxed/simple;
	bh=I7Nu0xgDYhA6HBtYyIGiuxjVZYX7nBSWvnGQsuosQ6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uDuWlSUfg6kBLJ4VaZL1no3hbAbDGvJ0A8hM40jlxIPoouiWQcr2g05lRt7D7sWS6NUkFkojEhoVWYnjlpp/jQg9QXrkAJMlGd1ck/ns2T99ZAHDuWxHJ0CVwFwivpKW0KtM9wpelWTxhApqhiJ5wKQKpvetj3k9DKlQrq4qLME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=MJvNIvvP; arc=fail smtp.client-ip=40.107.22.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NruOs0e6W4y30r69zg0pBfszYo+8xLZ/CtapryI3aSXgaiOrwY/Zx0ob3aLAK4rLgTfoaDZ9POfhJhVLaXty+daACl37xJnee9Cd3zR2jW53bbW0HXvTmiIOeob41N+0sOYjsxVFO0aEDjihMM3VRGKa1os/Nc6Ujc2qfMxqgWz8P3JyetAnBTL12lwgaL64pGWn3LcVSw1hC++8cc0M1cw/sPKT+vv4cdYK7sNuz7JlikWuw9kjI3hXuGFNa+5J3noVV2vOgrC+hXV40yLHntz9RXoawNJ4HhJdCO7oLefbwOx6j578O2idQX16O1R7X2OFQqc/4tN/HsC5FSz6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3rqYNzWyLJQCI4Retmd37rxmcJwvm1pVWgL+BlRrOg=;
 b=ON+bCaZhjTByjKjkhdLKJbje+5C39+NuxOLGlolpDzjoewjOwv+kJkQ8dMS8xyeRZG6Ao788+zlEhby76AE2r6VDpDdDWooypDGlmOUHSwripq6gcfskA0TGjfHBM+Yl10fGDTaVD+Yf044vBcrCgDTx8r3PLxdbeuyvG7ryWQak1JY2xumYCbNRBZxq5L9Prm1nmcHrGN2S6vPPMiEEyAlI6jvFebrOX5y/CUZJI2KOQFMuLpJwjFTWXEQscD7E6pkRFao0NEC9Wnq78AiV12fGQPmV4ikVVMDJGeMpBZMEpk8BMmqdeYQQWSNJdy9C5NS6u4ZWM9u+gJaFXaWCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3rqYNzWyLJQCI4Retmd37rxmcJwvm1pVWgL+BlRrOg=;
 b=MJvNIvvPzSe2ueUdckEfLP3hdxOrLCndO+w6+JmwCxcahqMIaPUfHTY2vBBPLsvK5FycBnIXItQiQPfmStFU1h22+SttI2iaYUDpTI20LGVOM2xQgHI3HF1S+LXCzgB/88dFFIfpOfVQOxETUKd2ltBx7V/5oNIY54cwMdHgcbnIJTaK9flqq4v5ib7iRzKBeAFzlJvET3SaH7zdKAQGumY5cfM1KluF4B/Azw6kpKpSAQ1tmxEYSy76QESatowPwfVbZsKZhX9P5rHk/swe1jIz7zX13NmSA3BzCUM3x65p7Z+3B8RrA97ONhQtGDg/sA8gbZ7b+R+akF9cQ+tRrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by GVXPR06MB8634.eurprd06.prod.outlook.com (2603:10a6:150:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 12:39:03 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 12:39:03 +0000
Message-ID: <65582610-72ba-4644-9032-91c09f50a6bf@vaisala.com>
Date: Fri, 9 Feb 2024 14:39:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] usb: core: Amend initial authorized_default value
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 vesa.jaaskelainen@vaisala.com, geert@linux-m68k.org
References: <20240209094651.5379-1-niko.mauno@vaisala.com>
 <2024020903-october-placidly-20cc@gregkh>
From: Niko Mauno <niko.mauno@vaisala.com>
In-Reply-To: <2024020903-october-placidly-20cc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003856.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:16) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|GVXPR06MB8634:EE_
X-MS-Office365-Filtering-Correlation-Id: a393e82b-6350-4031-9a3b-08dc296c1921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1QkbHVo++hCz/QQ8g1noBWAuqGbMhvBDTQbMparvxSU/YcYSSiHfDwuaZe54gdXIgnAxQsNqecrY7RUUaKkDkNKyko0DozklZJlyTSUYTihIt7Ld6XkmTgucU3Pg7kjr7HlkuAhy1NbcXLMdpyS7Wc8MTOaBIHAn4Tc9spg/mFRI6ho0PO9UI97j/csBlnShxd4dDaiEnPZMqMESjU8d05vklu79AnZjh8DhRlJlryOO5caGIqVWePjpN9x9UbNMeNSKbA6/8KHXdtPJIRYDj68tN8FBk2JycgqLoiY0qXiGhHX5WhYos7MJjvwxDlYKeYioH9q57nwhRlM1g49n/qmtQSqAdGApxvBfxA5zewhGnxmUmb7KaqqCDrN1ydj4TENUrELr9HfYHzHD5C8vBZWOSFqY1IfPobkEc6HYQvEACf/hvbYkBFMtvclq78npwAWMFlsFgiRFBqO6AC6hKGTMQbkgcsXTUjkbQod4e3jh2fjST6kaSTCemAFH5VsI0tu6NHqN0S7aqYPRQPgojQ7lRhXnaRjZKbaqVXXxZGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(44832011)(31686004)(2906002)(41300700001)(4744005)(8676002)(8936002)(4326008)(5660300002)(86362001)(31696002)(83380400001)(36756003)(66556008)(38100700002)(6506007)(66476007)(66946007)(478600001)(6916009)(26005)(316002)(6486002)(966005)(2616005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBnaDhqUWFkd3RsNjU5YVJlRjM0OW9GRUdlWXZCV3h0bnRuRWk0TTNpWlVV?=
 =?utf-8?B?dVp4ZEtyNThuNU0vTmwrVGxvR3crY0FESHNXTGNlek0vZ0t5b3pSdjZXNjQx?=
 =?utf-8?B?bXV2aG1wSlFYWjh4aXZlZ2lGdU1NTmF3a210dzNIV3JDOHk4SHh6b3V5ZEds?=
 =?utf-8?B?T0kxdEczSXlUNkh2dEJXWElMMWNoTVk1cGhHalR4eTFZMjJ6VHRESktXeGtY?=
 =?utf-8?B?YUkrWUVaRHN6eW1SWGR4RFlnZzVVUERjOVVqazJuYUQ3QkRYc04wbjBucVdI?=
 =?utf-8?B?RzBDK0NRWHdTYlMrdjV6SXk0eW96OVo2N25Pd3dobWFlMEFtcUc3ZDVwUGVi?=
 =?utf-8?B?TUhsSzZ4SUFYeGZNcTNUZloyaUJQaHdNMFg1Vk4yOGJtVjBkbE1oY1ZBaktV?=
 =?utf-8?B?aDV2Y0NmZE05VFVQQ2xJQ0FoNlMxYm9UMXlpMklCZ2plOTlwTVZTTnZMWGxU?=
 =?utf-8?B?M1ltYWpuY0laUWF3Q2NMWDc2RXFycGxiT1ZnZ0Vta21oMVYvYWxCeXRlRGRm?=
 =?utf-8?B?bFFyK0FzYU9HSGFLcUdlSW5XOXptbVVneHRqREh3QlBQSHl2TWVPU2V5eDBG?=
 =?utf-8?B?emtnKzN2QkNIVmRTZUU5cDROZ1lnYmhEQ2pKcEc0TlZxNFhKcHppRWJIMGVC?=
 =?utf-8?B?d0dYSVdhTnRLOEZ2TzRKK1VYSEdEZWFid00yaXQ3ZWk1Q2s1K0NQcEpLRWtv?=
 =?utf-8?B?L2N4L0x5NVdRQ3N0Y09Xc3pMRFdIZFhMcTk1VkhWbDRkVEVScjNNQXdyMC96?=
 =?utf-8?B?RUZ2WXk5WFhEOEtaMnEwMkVJWVJRYWZtTXBLQkNaYlFheHhPNjRPd2l5VVlm?=
 =?utf-8?B?NUg3MXU5R0h1anA1RVhXTFR2L3J2SGZnSlpjczBKM0QwUzZ4WDRqY0FlYXg0?=
 =?utf-8?B?eThhalB4dmJSbXVqUllCSWd0WkxLbHdwVkhPcy9idjBMeUtud1JiZ3V1dDJx?=
 =?utf-8?B?RDdLdG05aDF6VG8yd2xQTzBsZHB3RTU3SDRXRHhwUEZzQ00zNnMyNFhkblFR?=
 =?utf-8?B?SFM4UVVpTTg2UGR5MVQ3dThWeElXUHpQNzZNcFQ0dCtad0ZSd05MNEN3UEdS?=
 =?utf-8?B?dXkyVURvc3ZER0JWUlZsRnExTlhSbnVzS3lDR1ZnMm5CMGszN1JxMmxaQzYz?=
 =?utf-8?B?cTJvMVBpN3JkVGpxaFRwaEMvck9KU3l0RHFJZEJGT0ZBaXRzKzNBMytrRDdC?=
 =?utf-8?B?ZlhGN3hhR2FyRkNFdzFDdUhVOTc5VjNCTnc2NlNlaFhyTEw1UUthVmhsM3Fz?=
 =?utf-8?B?YW9rV09FdCtxRjBuUHM2STRjRUNVQkxUejRMSFVpMW05a2FWRHJwd2VRL0Jp?=
 =?utf-8?B?S0k4SWJLMzlXelI2R04xaVFpeWhzcFdPR2txNFhZN1AxSmtqOWRHUHljSHJK?=
 =?utf-8?B?MVlXQVRERjVpRFIxdGk1M3ZEdjBGREZiZFp0eFZ4bmVRejB1RVJ6RjlNYitl?=
 =?utf-8?B?RlVuYzNYemUvSVBsVDdxTGRydzR6ZkJhK3BXK1YyMWh4M3JVc2dXWGJYYkJK?=
 =?utf-8?B?R2lwY2ZIT1p2NTU4Wk1rTkFCaFh6ZzhlZHRsUGE2anVyOFpEWlJaVUtWTFoy?=
 =?utf-8?B?dW1jZnZKZm0xanloclhYeG84bDhRN2ZnRC9Lck04K2IrRHA0MFBtZGY1NGtk?=
 =?utf-8?B?MXNqWFBkcm1UVFF6bVJiTDBIV2FlM1BZK3FoUFhLWlFRa1BSWWZDWDBucEJj?=
 =?utf-8?B?TWdzc3VSaVpFT0JUSzFacUhFNExyWVVEbi9RQStRcmt3cnNTanA4ZG83TVdx?=
 =?utf-8?B?c3FCcGt5V01VOTNNVXExVGR4RzlPYzNTOG9nR2RiQ2w5eFUxanpCN1JsNkI4?=
 =?utf-8?B?RGg4YnhzSGhKSkJvREF0THFtakJhZlFIS2tDZWVlZXNaZ3U5ZGdGMUhUL1F4?=
 =?utf-8?B?QmpOWC9LMWorZUZEbi8wTXpvL0U3MzJWblhFRTFBT1ZIWUxuMFZDNlk0bWFz?=
 =?utf-8?B?VG5TTzVtU0x3NW5COTk3SUZXQmJZN0lUakRDZ2hTWC9CWi9EeXRaRmo4VktE?=
 =?utf-8?B?dEsvcC9pMTZic2w1OGYrTVRwTUtjZEIvSm1PTWZWVE1Nc2FsK2tTdk5SU3NB?=
 =?utf-8?B?MnJXRDJxVW8yRjRaaTlzUFVsWlJabjBPYWUzZGs1SkY2K3NESWdROThENG5M?=
 =?utf-8?B?QjFmdHRweSs2bE5saUdIRkpCeGhPZnFFcFdzNmNXYWdoQ3Zya0JjTTUyb2pP?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a393e82b-6350-4031-9a3b-08dc296c1921
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 12:39:03.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAIcsOh/Wh32PbsWNbpM3G1EYkf33mx4J1VvbFivOJm0Crv4rFpJWOrzv4fTKxOzvUZ6e7uBaw8fqY1GOySMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB8634

On 9.2.2024 12.47, Greg KH wrote:
> On Fri, Feb 09, 2024 at 11:46:50AM +0200, niko.mauno@vaisala.com wrote:
>> From: Niko Mauno <niko.mauno@vaisala.com>
>>
>> Since the wireless USB implementation has been removed and since the
>> behavior with authorized_default values -1 and 1 is now effectively
>> same, change the initial value to latter in order to stop using the
>> leftover value. The former value can still be passed as a module
>> parameter to retain backwards compatibility.
>>
>> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
>> ---
>>   drivers/usb/core/hcd.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Isn't this series already in my tree?
> 
> confused,
> 
> greg k-h

Hi Greg, apologies for any confusion I may have caused,

Geert requested some further clarification in the new Kconfig help 
section, please see:
https://marc.info/?l=linux-usb&m=170747246528305&w=2

(There shouldn't be any functional change introduced between v2 and v3)

Kind regards,
-Niko

