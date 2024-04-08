Return-Path: <linux-kernel+bounces-135611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6F89C880
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30A02877A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3A1420D1;
	Mon,  8 Apr 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="OHIckg9b"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0E1411D0;
	Mon,  8 Apr 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590598; cv=fail; b=Kw/jpyDBzsZlstcct13zKB9B6nBsELQzFLIlpIy8jq0KOaOBn5fJPMdyFdnf1nzhbuvp1oTVJsd0GivJgFKuujxwoAk1YL6ZTxcGxXf/yoKbHqU50TD9YooQBndVNTKLeTBiJi7GT6gBKMAhynOUAgytNMU5YwKvPXQHcj3e/Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590598; c=relaxed/simple;
	bh=R54AM+qRmC+5QdgyaszCZR3P4DyV6FKa4DCYlrSG3fI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MGGJaylAvXpYXQeV+fTrj1BxqHUXOUDqqo+mpaYVfUuTfJYFbB8r/buXdFtv3A2cJ0nT9F6GCe2x66Sl9VRnres8f4YLpI5M3llfzVdDawY4nMxwRfyuXSDMLibYhEgXstzx4FiQiXRkYR4qDcJsJJqLOiE4zGsi++RLX0Vw9A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=OHIckg9b; arc=fail smtp.client-ip=40.107.22.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czll8XyH0uZCuA6U0zv+n/sVYI+siSPEvYLyylXVvWZQVgcyS4Xdk49b3NDi/eAB1HaKkqDXRqWTq/g938FdmARrML7xezKKdcfNlhajcYVOhrBNnvkZQpo5t9m/7V0nstJMAPnW8MY68a9VG/NTabEvDyqemPa93BxyMqx+K5hquKQWu2Nk4PwjOndIoCmKzyiN+lAs0W6KWiGUKpour/ObOOAoYppq0TAi/9ueYE13opbgVqUVYoNwxcSXW4sjR6OF4wGXdNDlsDl5fBE90w8ZTGPMv//WaFXbndKuo2a0mXk0YwvLcw2N4lw6X34q/ZH7mnkrt7Cb2nYCTLMIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kk1MqPhnyphyGpGYInQVYRc8UwX2j/CqyYqeb4hp+4=;
 b=Kh69oIqxKRj25MfXTmQElP42umingeM1AGixZGSujX7b/mJXWpGBBt3yHfT5d4ao5KZvoRXWysBONfk0IlHE6YEDhSXZ53k+pe8Yqy1QVgB7uwsUpO45iKPWXAXgQh6vQHQvf/wp6ru/4aByo8XClJW/bCPrNl0TZ4nuNNLDUtmlh9eUGAEZ71FSgy/9z3FmqvGXVh5tOboE/4eTVXyHFboLlzznmUulpVyK+ZBLDZPVfjfSTTA9urkFIqC+v4JtPlkpIIuNeNWPg0Ha1r0Zj28JE03YFd9hPhqkPpNygwmEUdMLVRQbVmEOuK2kUqeULTlh5Zx0MV2+lPhXf+kZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kk1MqPhnyphyGpGYInQVYRc8UwX2j/CqyYqeb4hp+4=;
 b=OHIckg9bpte8w7qcNtXGmeqWxU3/QZyu+d4E+y1Fff4Q4mCmy57HxvU3uyDZCjA0VCEUWEXivzJ7+3+CEN06YOEcxEVP14HVxWCO4hi0itdTVYPaauZa1Kjouff3hZPOO/xWRTq34TQSTlrQO1vivW3IX/bALygamLfje1sIQ2k=
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB6436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 15:36:32 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 15:36:31 +0000
Message-ID: <9183d3b1-4f12-4c5a-8210-71388935f08c@kontron.de>
Date: Mon, 8 Apr 2024 17:36:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Disable the USB hub clock on
 failure
To: Fabio Estevam <festevam@gmail.com>, gregkh@linuxfoundation.org
Cc: mka@chromium.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20240408151700.1761009-1-festevam@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240408151700.1761009-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB6436:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bfq9JBpJwtuDabyfl18haUKyI7FYcsktUgVoOBucee4AvxhsnkeR4qNl87R3UoWqRdaXeLHXNf4008bvw+N0mbclGJZdxoh6x71KsuFkMu4QUj5bFcbF4kB43QUbbqBcNnvDEtXInszKj7KNyqi3GinIbfD9MtWgXRIOeeTC5CwjOil6b1f5XdEdOSPC/W5P9qXPOaqLYrYa6Tjy3nWqhPU/8rHODlTi36C4/11pwiG3PhFb89Gw40++jMoI7QEtg/FD1aV53hil+ylXM2et1+XKvY7jCgcqS2wvbu04UTC7647bKy0I4sS140cDG8GpWMPEBwLyjrkNgtm3s8awVfP2QuR2Z+vkDJbYBDh+G3VLWaphhe7bzQ2SZ5mjZ0Yv6khGu5E8wnbpZl4TWkjcJhewvSnJzgcof+lqq0FDZpuYtN+qaPgttqi6eLbehpGOu7wPtBrBhMDh6cih80vIITkFwoAbn54dJmx5TI3l7pxF8xucen56pD4HkvztJL4T/FiENPFjvFAiD0acdAMG5LoGcu0RRVkkCrPRQn9El2C822dWQTEQR373Zj/yWF4I82eucSB0Xn1jSdvKVKOg5nsXdVWMf+zMVaUCr5KQd73wBUOd5LHPl04wHWKT9GpeZDoD8E45EjWt4Q2SwTlKnSHznt9yhNzRWkglT7lUO+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVFZlNLRmEzR0lzYmc3c0hkVmlyY2Q3amkzZWNGejRxRTBWVHZhWnVIZVZx?=
 =?utf-8?B?M045dFNTR3g2cFlkWFc3Y0ZvbnphSkNLcEZoeDVJanBCM0dPSnZ0cWg3blZ0?=
 =?utf-8?B?K2ZHYVlwcXAyVDRnN3Zja0FqTTN6dlZFbDcxM3l2ZUt5R21lUVNtVGkyRzZl?=
 =?utf-8?B?QzQwa1NEUFRyanFLMk1pdXNpWHJhbFBaaUpYVk1TaS91Y3dQS1BVZy9pTHBv?=
 =?utf-8?B?RzBBeTFzYXdQa053RnVSVkxXdllXQjg4TlIreXQ0NkJYTWVzcEVZemZ0c3RZ?=
 =?utf-8?B?dUlQRlNGRVdqNXNJWEd6OWoxblFDb2J1bGdpRWJDYld4ajMxYit6a25CZU9y?=
 =?utf-8?B?R3JoVVFyNTUvNzJBQjkvQWZjdUdGRnN6aEk1TjZuTlJRN1hLTWdnZFVyTW1t?=
 =?utf-8?B?MWRIQVA0ZW13Z2o4L3paNnVpUzZ3Vk1UaXdIVEZHbUNjckd5ZzMxbk1USWdC?=
 =?utf-8?B?eG1iaVVJOC9qM1hvbHNJSnMxNUxodG56c3QySk1OVnc1UjltTS8zVjhobEZZ?=
 =?utf-8?B?RHJ1SFBBRERTRll5Qlk3NUtqTlBHS3I3STQwcTN5S2N4b3N0cHJJUDRxalFn?=
 =?utf-8?B?MHd3RmhCeEhMcE1jWGQ2WWNFSlNQV2FKZUppREhpM3BTTXNsVFN1NEhWZVFZ?=
 =?utf-8?B?MlY3RDVMTk9xakRrakROR3dXS2RYZjQ2N09ieDZWMFFGSGpSeEZwUDVjSVY3?=
 =?utf-8?B?Ui9ObmdoYWMyS1Yvd0hNWHVuQWI2RWhkOFhrdklvR2R0WVpISldRcWRzeHdZ?=
 =?utf-8?B?b096UzdpWVFjU3RFRHFsNEJlVTBpakhHOVFpaENrbWJzVUQ3ZVBhSFZyNmpL?=
 =?utf-8?B?b3RkdXFGYW9aUG5Idm5PU1RDbnY4RmpRYndpdDU3ZTZCd01mUm1SUEZPWVBW?=
 =?utf-8?B?U1dOL3hmdVI0alVKRUUzR3JjWHZrL1BVMWl2b1dBVlg2Q2dYWkJKZDU2TndG?=
 =?utf-8?B?SUY0ZUZNOHRkMWk2YUV4Z2VJYWZnRkppZEdlb1hwdUUwUTk1ZzdlVG1DamIw?=
 =?utf-8?B?RDBFMXhuM1NzbmVFVlN5bWlIU21OaWtQeUx3ODllZjNCajREY1VtZGtHRGgx?=
 =?utf-8?B?YVVBWFJqaVVIKzg5blIrb1h4T1hWWWRROWJ4b0hSdXRYelk2OGhNYkk1OFlL?=
 =?utf-8?B?azFEK3RjVXJMdHBtK0hJSEliWDNEZTlpOVZ6VzBzQWUzSzcwVkVQajJkeUdn?=
 =?utf-8?B?VFh0MXd6SU5CUDVkODRHL3BKSmpTd1FSSnNPRUtWRVQvOFJURTZkOVBzMURl?=
 =?utf-8?B?YnpmcFdIcWg3ZG5vR21Ybm85aW1zeS9QeXJ2aFMzOThGK2dxUkJKYnErbmZj?=
 =?utf-8?B?UFhDMks4b1pic3d4MDZ1dHgxRkN0b081NkIrdHJtNGZMZVV2MWVFRmhWUVFy?=
 =?utf-8?B?NlVnSlNkVTNTanZlTUZITys5ZmdLcU9NdVBwQVJPVmh5bXhkRFBrOU80MnZp?=
 =?utf-8?B?bzFxVjVFcVZjeTRoLzZOWkpyOGtyQ2dZVmVkSWF5d054SmZMcW5PVC83bktI?=
 =?utf-8?B?MjQxbERMa0kySUZ0RGtQY09kNStvZzU4amltNFF6Znc4cytmL2hkNDAzSHBJ?=
 =?utf-8?B?ZjBWMWo2cFdkZWxnQW9TKzRHci9yTTVDazVqS1QwblJiazc2YjZMbWR3SXRz?=
 =?utf-8?B?SVBNbnN0dStkSitjdE9ubVlNZVlNdVZmR0ViaE9RTVNsMWdLZHI1NTB2QkxS?=
 =?utf-8?B?SGFxNDhJUnUvbFRIZkp1aG1VVWVNRlE3WWhZRU56SVNJWUV1SGZsS3N2cmpy?=
 =?utf-8?B?NHVqNjVtRHJDbnQvL01JeWl6dWczNDVva3pnc0tsbk1FM0FScDg1b3JTMmpm?=
 =?utf-8?B?OHpjR2FHVkRSYWZOZWdwN3IwT0JRTlBTM0VUc0dVU0VhL3NQd05iRnFmNnpE?=
 =?utf-8?B?NTZHWEN6R1pSQllXOXVFYW54dms2K0ExYUpsSzdvYmpMT29KbTE2SXhVQUNY?=
 =?utf-8?B?UzcySjVuSXp1d1Q5SDdkMUE5ejJxOWtrTzFwNC9ydXkveDkrbk82cVhQN24w?=
 =?utf-8?B?bktCcTN4S3hUT0xqdjBod3BIa1Yvemt6MEdIemI4QlJYZVg0WENoSVBKUWs2?=
 =?utf-8?B?UWlaOXR5aGFJN21TRWtxYmdzeWF2TnNNMnlpNEZGYk1taWlqamhqOUs3WnJT?=
 =?utf-8?B?blZvZ0FrMnBrTjdkZW9vd0lTU0pxMXNKbXpMV25VUkl5RFZieHNPRWFSYWxG?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 356aefb4-7031-4271-84b3-08dc57e1aa36
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 15:36:31.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EoI6YuYTh2Dppa1uGKSuklHMl9EribNQF8meQG2oTy1lA0b2pIVvudahZib3wNVXhHFAQ2UzcPg+TAWh7s+/cxiEsxobdMpXi9RmnA1OX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6436

On 08.04.24 17:17, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> In case regulator_bulk_enable() fails, the previously enabled USB hub
> clock should be disabled.
> 
> Fix it accordingly.
> 
> Fixes: 65e62b8a955a ("usb: misc: onboard_usb_hub: Add support for clock input")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Oops, sorry. I totally missed that when I was porting the patch from a
downstream tree that didn't have the regulator code path.

Thanks for fixing!

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/usb/misc/onboard_usb_dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index 648ea933bdad..f2bcc1a8b95f 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -93,7 +93,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
>  	if (err) {
>  		dev_err(onboard_dev->dev, "failed to enable supplies: %pe\n",
>  			ERR_PTR(err));
> -		return err;
> +		goto disable_clk;
>  	}
>  
>  	fsleep(onboard_dev->pdata->reset_us);
> @@ -102,6 +102,10 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
>  	onboard_dev->is_powered_on = true;
>  
>  	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(onboard_dev->clk);
> +	return err;
>  }
>  
>  static int onboard_dev_power_off(struct onboard_dev *onboard_dev)

