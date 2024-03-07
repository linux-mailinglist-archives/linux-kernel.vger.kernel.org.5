Return-Path: <linux-kernel+bounces-95525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352D874EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71571C23C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3D12AAE3;
	Thu,  7 Mar 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PsIjtumt"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19012004.outbound.protection.outlook.com [52.103.64.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA312A168;
	Thu,  7 Mar 2024 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814182; cv=fail; b=L7/EK3xzBABsjdINLQEjQgES4Y2ViON3hdtSMZZX/dZ9Pq+BMZcU8H89hSCAqPCH6JbrlS+s7+aflBdp5j+0ZJsTujhadLDNXxJKjP0l9KGn4l/jxSrp56zzYk55/LzKy7MFzqu9V/fpgEf/U4vSO/nbEqIWJMFtK4eigMGs7qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814182; c=relaxed/simple;
	bh=2tnAwjoykv+ZQxBw0Pacvaghd129yMDtZ0eelW9ruS4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YCbHV4GDTLyYnHkdtcTrCzWQ2H4MbkYsOvI3MAAylBj8t6cOdWHSpsAifSj6dJ7ZssV4OJNfXWG1uf3zVePF+aCJ5ZdLhpVK08eMyD3hxuEgwkjZ6xmx8DI/XL54CN6WbwEQ89kjeRfnnQJiyoi7cRzLRYw3lts99o6z1Gv55ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PsIjtumt; arc=fail smtp.client-ip=52.103.64.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjZOJD9JIFmGQm7yB5e7OR5R9NWVyuLk7/p5BRkYfmrx1WbNBEx/NVoWDdb+R0mlNHdvuu2BvgIBRVVhv9dYcI/A5k1fvflbl8WUURw+oCRRXDPijmyb4dLug17RZ9WVQzJFemDZA6AMgTU11GuCubShrv9G5hySb/41lE5O9MKgqr7yxHYzaj9PD0J/+RsfwVrJLkb7Zznf62ZY66sYluxMBw6PvqRWfUVBzU0hishr3lGhtmUK7K41mJARYYmF3o54b9KXIm+qmqTxSiyv3TgqL1ZBgtQalRmSaHPuXx4qfDcWNfFZigZxkbF6/AZyIV2sk0nIRgD8Iqod4iRYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP6UKB3jwzPKSMtsl0yPbhLWzuEn7vxyMVv36fcee/U=;
 b=JmNTH0zUEibfVVIIPutDEBkK2KiC1lXqicS6/kR5a7hzq5YIxQSnb11GRX5SFYgo3fHxjQWwur/8bJiKHrXj2Lcs68ZnKbTCeUUypfzauF3kPlIWvofLyYo6kE8HN1TTeZvDt5HDQx12lc+qz6TGLPCcTB8QFvbqCNQ2BVQeHbUdaTJLRNbglOPilh1KENoHuf4HIONToStFnxZF61nq6vBr2xrHlf98nbs+0tgZdqaFWNwzjPMM5F/wi7EE12xtsWzMlFYHBVypM7gLRWdgfLEhZvJOxIhpTQ3ySBncvQYuOAYF1pkdkpAYYfRODvyvtA8Ekoj5XKlIVuj/znDJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP6UKB3jwzPKSMtsl0yPbhLWzuEn7vxyMVv36fcee/U=;
 b=PsIjtumt7aAbQofgOw6r/Lw8HaDEKfsR2nP88nTuHHxTJfNDisi0JL4UamEK+ezZFAl3c0fPcZR8V1wwc4K0Pefjf+a12otZutzaAqWyaqp2lG+c2ylZD/o4Jp9QIzsVh7xE6ULMlbWxuiZ7oIwDz2KSCFnjAHPQDqrU/b1cL6qtO1pppnf8tRZpJEnBxOU1uyFbAAcCDtInmC/GaKnTGVlkOGCI4MLkqyOThs5QyMRA+kN8fw2TEAzY2QqwPT1hRsj/w45Tt+0zRclkmGp8urduEalZtfCq4Bz8ARVDfNbtiLrAt2WYqeQB58cI54TIgchcAn5AdlEpjnleurU9Rg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TY0PR06MB5801.apcprd06.prod.outlook.com (2603:1096:400:27d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 12:22:56 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 12:22:56 +0000
Message-ID:
 <SEZPR06MB69597EEFAB2F77049E9B257296202@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 7 Mar 2024 20:22:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307122129.2359553-1-usama.anjum@collabora.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240307122129.2359553-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Gobuhs/uZpQLhbmsm/wEEeAq0TOUQJaY1r6kuYnsgEVWj7g4zzingRacBk73jM9m]
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <f7468a38-a8e5-499a-b57f-b1d00275cfbd@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TY0PR06MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa7c7bd-8086-41f2-bb02-08dc3ea151b7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7sQXAS/e2snwpD6/MYf9pQM/idrJMTkDIblH32nLoJU0Cza+FZRerl9iOW6rIccs34g2HPblvs9MPrcOgDQDjG3qcz1FYlViIdlh6TLkA3ULUnnvLHQm4M7xta06izwcEe+PZQnngISe4o7V14t7nF/PXw4CN2xEkoMy9sf3qbGQreeutX110HfGd1mfocaZu+KPut6fGs4ihPxFmRQGUXDhjsSRFXw3c1sHo2E3dGDjIsm+ICF9EzOJFOHYdn5C9u85iltUhpKgKeEbhKuGOoT/+rn+ehZTbMCcmZRR3/QzIFNbn+6qynokXO9tWUTUJzSClldb+gW7chL73Lv86alngprwhvQPX24099OscPIcAhl+N0Jk6U8vnhpIxoDQjTbngq5hw7cCE9KQTortN+YTOR3NZ8ZG0ZWzHdVycO3jwh8Ibfj1zDRL8NVVNfxkI1/pYx/JNBro/0NCk0zyy/nrmqX/fCZbWh+WhQj1bBv/PUUgPDJ5Cxrjhafm46TngW447/Y0pYbGIk1mggj3rUpXf/jIIzaWlYPe+sU+aQ48B5gjzKHgiexanp8YG3T3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHZjZUxJeXdpUHdZNVhldGJUY2dlRURSNG9iYU0yeFkwUXNXcy9TYzZSS0t2?=
 =?utf-8?B?NGFKRzhRZDd1NGJLTmtEdFJVTnZXNEc3SFh2d2czSGdxbTU0NWJEN1ZWUVZi?=
 =?utf-8?B?amJsbFpOamJjbThqNnVTSGdtajY4c1JybDNKSnVGczZUZnpXdU92UnI2RGs3?=
 =?utf-8?B?c3N0TDhQTGcwWExTZ1oyOFR3WHA3NUJiU1FDY2RQcHBTM054SWJLYnFKTzRS?=
 =?utf-8?B?Q0x0SnBOc3FNOWNWTWxvR3ZaZFYzbzU5V3lEeUQ0VnF6SlJZaUV3S092Q3Zn?=
 =?utf-8?B?V1lnVHpLQTNrZjVpNVJnaEVLNXJvUVlTSmlPRUVIUkJoenBUR3VTaE1EUER1?=
 =?utf-8?B?RnVtSGpwcG50TnpPNzZBdHBrNGtUc1Uya2VsRW5MekJ2bWlvaHZzNFE4dTFK?=
 =?utf-8?B?NThBQ2NWQS85a0JwVkNzQnZ3V1ZSN2dQdlNCSUVFenJ1YUppeVhSajl0TXFo?=
 =?utf-8?B?QnFmUWZIbTRqeG5GNHhwT2ZyUmFEMldXSUJsTzVURnVZTGR0WjFUeksyT1FV?=
 =?utf-8?B?UHBGdlZYVmp1RXJBRGlSTlZiREExTE1qM2xhTG9lNldIK3M0M3BiS1g5R2dy?=
 =?utf-8?B?TzMxa1VsV2VSYjBWZmlucDVQRHdmSGZLKzBxNkdJS3BmRE0vVHR2ZS9pSDVj?=
 =?utf-8?B?Z0luQVNDK21iSWVScTF1U0wwSnJTSlNITnZBMytDTlpYOEl2Qm1YN2RUUVZ6?=
 =?utf-8?B?NmZid09WeXMwQlJMN3IrS3NVeDhlNXRLQ3pTWlp6aUVJUGxZdlpiNXR2Wmxa?=
 =?utf-8?B?a010REV4VVRhVU9MRFdGVEFWc0YxS3pkMnpWNW9kY29PQ1ZyR1BQYTFhL2J4?=
 =?utf-8?B?ZHJYZk8yTUZ4WnBZQ0ZSNmVMWWdJVWo1ZHBZRUJYeTNrb2svdnJlVWdUc3dj?=
 =?utf-8?B?M1hTTzlCSTRwZXhxMFV3dlFsejdGNi9yNlNmOWFqcUJTUjNYUkdvRENEeUh0?=
 =?utf-8?B?aHk3SXJxYTdXMm5lR3pSK3Y1WU9iaGx4Vk5peUxLbWlZRms1bWRFSmRtcWt2?=
 =?utf-8?B?U3pFZXkxUzRCazVBMHZ1dzd0NVI0bUM5NlJGWkIrb1dTWkhqSlZDSm1wUVVD?=
 =?utf-8?B?WmJRSXRUQ1B3TlU2TGhsa25IVHo0NC94Y3U5eGkrYW5qYk12ZDlZV3NVVmow?=
 =?utf-8?B?SkZyQzNXZlY1cE0wbTYxNkhRV2IycnpGVmZSTXhhdmMrT2RQVDluT0ozVnZm?=
 =?utf-8?B?NXVaRzllRzR2ZytPS0FXYzFMNEo2ajN3ZTF6Q1JZM3V2N1VpZW1iRVZMbGZT?=
 =?utf-8?B?VFhCcmpoNVlRbDVqaFc3NFlrYW0wMjhUWWQ1dzROdzJSRXRHclRZalJLbHJL?=
 =?utf-8?B?eGdxQWMzZnVwNVRuMjlJK3IxYVBWYUhDeHRYb2pZNWVZcEtyWVhvcmdNQVFr?=
 =?utf-8?B?cTgyaTZKdmtLMlhxKytKYVAweHpESjZIeDl1ak5oU3pjRVJONGRUc21pd2t5?=
 =?utf-8?B?OWlzem1tS096WG4xNDRySm1Qb3BjaEVqOFo0dmVTQVIwa2UzZTJqcXNQbTc3?=
 =?utf-8?B?SU52NFdvOUZMd3cvUGZzOGU2RkMyVE9VZFBsSkJGcC8ydThDSEgwU0wwR2g4?=
 =?utf-8?B?TVpCM1ZVd21Vb1RGQ2FGdHc4OGhOQk0rcG5kbHVzWlFxUU9BeG03dHFHbDZJ?=
 =?utf-8?B?dzZBM0dVY0NSbG5tUXN6WHhJKzVhZzFWczB5VUE5amRZY2ozeXBtTlMveVJ5?=
 =?utf-8?B?VFArN21WWTBsaFFHaXRTVTRwdUlyRHJ2QXhWUG1wSlJaeUx3VWZlNFN2VFJ1?=
 =?utf-8?Q?NTyVZMTpDu4yubq8UyWymOn1eOXDvuHigr/wVxv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa7c7bd-8086-41f2-bb02-08dc3ea151b7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:22:56.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5801

On 3/7/2024 8:21 PM, Muhammad Usama Anjum wrote:
> The err is being set to 0 and replaced every time after this
> assignment. Remove this assignment as it is extraneous.
>
> Fixes: 25d043841db1 ("mmc: dw_mmc: add support for hi3798mv200")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/mmc/host/dw_mmc-hi3798mv200.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> index 989ae8dda7228..96af693e3e37c 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> @@ -133,7 +133,6 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
>   			goto tuning_out;
>   
>   		prev_err = err;
> -		err = 0;


Same for dw_mmc-hi3798cv200.c, maybe fix it as well?


>   	}
>   
>   tuning_out:


-- 
Regards,
Yang Xiwen


