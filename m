Return-Path: <linux-kernel+bounces-71980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D655E85AD5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DC6B2519E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8853E16;
	Mon, 19 Feb 2024 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="agU6ywax"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2079.outbound.protection.outlook.com [40.92.52.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56614524BC;
	Mon, 19 Feb 2024 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375358; cv=fail; b=mz7KhUcWvOh/aMlf14eQFh7TXBoRXhovthlaXz77vJ0W/FzoU/A7aHZBupCXpYQxojQubqAsUYBhCd+0wvjmtq7lb5YPPPRJ/fA4IKjExRaz4oa7Y5xFiZ6A7hs++UpS03oQ8VhEncG1UFwSxNY/di7H5vtF8Q8JVMws9B1DAV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375358; c=relaxed/simple;
	bh=QRGvz/cXo0XmA7/7kV02L3rsYSblxW0EaoivY0lJrvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UIAwMUfDzjot35VEORTWR3qDGgb+DganJw78PWNUMtNcNrVGNRBlkhpgjmiTADLqQLNCbfGrAqP/BBvSIyEJ+R7IuvYnla9iRJiIiJhh9QclPa1SuxkSBWcgYg9030i0PTD13Cn8MixKmnwmkbO3a6KbCWQKZQmFLIBUZH8EAL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=agU6ywax; arc=fail smtp.client-ip=40.92.52.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCDKRk73wOef4/s7i893gpsEObcDmrjni4vz30iG4+7ECmvBj010w7VLKIdWA90oZ69QOerqyu6xHB+s9XQgO2o+wJGJjQ8xZhlzGeuMIpW+p+fjllU77TBgdg+3rH+ejMuOGMIXYh4iUWjs1CMo+9NK/kz06JnAJp+01gSUVmdaBw5VEOGxw+EhTG8ek4CGioIJmn8KiSGlqV4mo8xD4YGkgakln4d3lnWBvvpo+oqqbQYd5bWLqS6e9+/09GZQKQvXzZitOTCEW//lWIFwgSDMS0JB1kXMBhRDVt3wyBypc0GR1BByEcIenog9olN1h1jlD1lpBHgM1uiYaOqx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKI/lq6HcbQTibY62z0ddURsuQm91MilDUZy5uAg7Bo=;
 b=FCP4EZXMqYYwi3ueCfetuA86vYx0cwEQ8nUo+9WfXuI5kXMmIdn2/STvJ8HrKq74mb3i6ohSz530rwl2FsBw4OUScGD9ZPfzl7QNoukuBEBIZ2qz+J0TgZaJBdLvVmo2Z4xnztc6Mk9RPpvDyBYtVMC1R6pLo7nWdNJC1koz2wQfXMepPmsA8YBmWPBZnfCILs61SrDawtXgB/5oLg6btwt9b8iIy3DCLZN8XfCjOSPqhL1o8HQ5OtppGg07m0YbIxs726HyPNT+rd1Y/RkZqpTSWaror4hjDHpNe3bIfxpyJtSdBR+R+DH4YSbgT/iHTBPufAcyxU5k89M/86D1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKI/lq6HcbQTibY62z0ddURsuQm91MilDUZy5uAg7Bo=;
 b=agU6ywax9781xiJWH/Rpa5SXqlFS+ahaH2kOWrCJKnif2vqxoTbVY+x+KbcQRGc09K33sTMI2dw8zMyIjy16iLGhVJy3YXD/dQCSSlUvQnGR3S9ZdL1vTbkfujVnrW6iSU5nTmciyz2hzIflJpseRlO3Pw7wGWhN25fkv1FF2itHdTujpCc5Nx6W0jnLw2wyBj8SifBU4TaRKFm5Ob8Nx7YN70UuvHTGFfJFLstETob6APQsNF1m7UhDmYrOcsIwe3C2MseX/jHlEsc03Cby282XzwqEAiNzbySrE2lNjClxjfIz8mq0ebMnzFfHDs+t9FtCDXB3Ug2ZuIMOULmwRA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB5074.apcprd06.prod.outlook.com (2603:1096:400:1c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 20:42:29 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 20:42:29 +0000
Message-ID:
 <SEZPR06MB695964E1A34936F70470A21996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 04:42:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
 <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [rK4t02bc62SCI1SFFuqOomgyXigST8cOim3lSQyqiK1uafoeIAZS83oYHd7ew9iZ9xjlygoqVSQ=]
X-ClientProxiedBy: TYCP286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <fb38349f-3075-4b77-b4f4-28198fa52409@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c877b7f-7af2-4628-4c26-08dc318b4a55
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U5oEKABdRu3idMlkEkP5FE3tlgyY+NgChJyMp9cke9CRdK5cLUT5jr+Gik4ptm0s5mEwVb7vr/CgR6CyKSwe8gznKQJRAKKdGmAA5EHOAHcMCUQeQgOmBygySdE25pwKMCydYtIewXc1mxd/grY3uqrvmn9UDEMnS7diriKWjbcUAUElye6zvJYRzIbVs0e3BScGcEG02/Iq5qIR3h0qveaD/5v2Kny7qq1Aws6KHow2PXXBaqcYyC5/iDXu2w5FqvSaZiKtFEdCUmks6sunQ/6gE6nepqtBSXY9+fstws8jZlzbeqRmZ03zfopUBozfHOpHkOonEfHojBaU/eSGXTBg4sLSuX+r2Lw+CY+yM+K12y4Adsu0qeGR3dUKrsmEMBCOroup2lsK79H0r8+N+BAa8zE+nt6/Oy7aoVYXyNLN+MXlNkxXEyQf4DZZpToF1QzKG7+iqPPHKmTIdsr5JXhxCpdJV8prSfI5mm+riOe74C4NVCiWn5znNlrNI37d66p4h7kV45OJKLAZXkXVDFMwbExLDdD+3D8TIAlfMHBDql/fo5JX5xuzFPRLVInK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWFEL1R0MXByVzU1VkJrZDJUYmkyNm1aUUc0bkZxeDdaS3c1ZElueS9UZm1t?=
 =?utf-8?B?SjIrT0k4aWh1U1RjWFd5bkF2ZEFuUDlCNnlDYnlOQ2piTzg5QlgycWsrLzFQ?=
 =?utf-8?B?bTFEV0xPOEp0MDA3SUkzWGlmR0RMSkhBcUdOTC9rYjlJUmg1aFpVUG1VSURp?=
 =?utf-8?B?bnJQbUNkbXJyb3AzNEJBN3VwdmhFNEVYRXJSNW5SMFZFNFRodVYwSDY4ZUpj?=
 =?utf-8?B?cGlsWUpqeFlNZmVoQ2lCQXl2T2p3TVdxaFhvRFlZQXJ6M1lYWjRtY1FITGl3?=
 =?utf-8?B?MnZUTHpwWGo1enJ2U1EyRU92cWdHNXBBSmFMSmhkbmxUUStJVUdmaFp3Nzlr?=
 =?utf-8?B?WDFWc0pkbG44YngyczlOclJKZEtTQ3ZrWnpubVZBODRuWHBUU1hCK25ITmZQ?=
 =?utf-8?B?aFk0OG1UalpaYUNjWVlmV1RZY2p2cUxQNW9pdFVBN1NLZlVma0RkdTJKVzFr?=
 =?utf-8?B?SkdsT2cybUxhOU56d1ZFODcwNkxpQTNlK1NGSFpvLzVpYzgwTjlBd3AyVmgv?=
 =?utf-8?B?VVpjVEtIa21CamMyZFRVd3FtRTladXcxemIzVlRSZ2xPMWw5MzhFcHIrSW10?=
 =?utf-8?B?dlpBRGh0T1ZHbXVlRmFJd1pQSCtvV1o5TFZ3RlZCWEFXMkdxYzRFYUNCZ2g4?=
 =?utf-8?B?NDVyY2dZYnQ2VE1IUkJRSWQrTHdIdmV2M1hhaHVlWG5Cb0ZZVmlpOUYrWEVm?=
 =?utf-8?B?V0dYQTFkdHBHb1orWkNIMTlwdmlTMzFrWXFXdEgxYjl5bjBRVU4yV09hTEhQ?=
 =?utf-8?B?NWNid2lUeHc4U0F6OUd4cGJ3RnNCSC93NVUxQlJrL250VGk1Qm5XWDFna3FJ?=
 =?utf-8?B?bEE5RHFXS2tuQ3lXcHR4MFdnbmhGd1hVM2JRU1ZsK3ExY1dReWtRcmM5cE15?=
 =?utf-8?B?MEZETUhGd25nbGFwVWpqYXkzR2lTc05sN2xHcU1NMW4vTXRKbnI5dEFzTFV2?=
 =?utf-8?B?dm9jSVUrWkNSMitqWXNOL09IZ1JPZGlXWUVDVEpUZ1N1OXgrVXhjZ3VsU3ZF?=
 =?utf-8?B?elZYTnl1eVF2WGRENHVmd0xqZXJ4ZzdGUUdsZTAxYnprYWZlY3U1V1JkdWg3?=
 =?utf-8?B?cVdReXNDR0JKWS9mMnF2aGRDeFFyQXpJM3gvZWRIQjVtUkZXZ3M1d281cGZP?=
 =?utf-8?B?Ty9SSHBYZjBZNjJEK3dnQ2NpZnNkOWdZa2FGTTh5bC9paTB6Z2J6RmZ1NFRi?=
 =?utf-8?B?K2xBeXFYSkZ6TFMxRkpkZ1VKMnRhUlhKeDZpYm9hbjcyaEIwNmpseXBzUXFX?=
 =?utf-8?B?Rm15WUhnSTV1MUt6aXJqcVN5L09sQ3hGWk92YU50WnU5YUpvRW1IUlJ0bnNh?=
 =?utf-8?B?c3JOM3NjUEVrSFdRZllrZG0zaHBuMGdvTGlwZC8yb1lIWldRMStHeFFmYzNs?=
 =?utf-8?B?ZG52SGpRYWZHRWlQcVJoVExVWktQSUY0clhNdENyZFBRVko2MUtaU0Fxekxj?=
 =?utf-8?B?aDRESllMZC93T05xT3RvbGNNaU0zVy8rQ1FwNk1iTWxkUS9IMzBYSWJ2anJG?=
 =?utf-8?B?aEh3ZDZEL25lcnJ0MjN6c3RSNlJJelRYNXpkdTAxS3BtZmdVNUlyM1N6d3B4?=
 =?utf-8?B?N2Qwa2hHMEExKzh1UzVUVEpiODhIdTZDWlFBZTBpMUcweTJFeUNsVkRpdWZp?=
 =?utf-8?B?NGFOWjV2bTBvTktETWZ3T2FadmtVbFY5V2syM2tnWWlpU2JsRDZhcWZ1TFlj?=
 =?utf-8?B?RzF3Y1V6L1hwcTZVSTczTUV0L3FUSTZ6LzBxZmdZM3A1Rit4QkxnRDlHOHdF?=
 =?utf-8?Q?z14cSjDMXcMnQ5F+VU0j1MZsiHjmfA48bgo5+M1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c877b7f-7af2-4628-4c26-08dc318b4a55
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 20:42:29.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5074

On 2/20/2024 4:03 AM, Andrew Lunn wrote:
>> Note it's unable to put the MDIO bus node outside of MAC controller
>> (i.e. at the same level in the parent bus node). Because we need to
>> control all clocks and resets in FEMAC driver due to the phy reset
>> procedure. So the clocks can't be assigned to MDIO bus device, which is
>> an essential resource for the MDIO bus to work.
> What PHY driver is being used? If there a specific PHY driver for this
> hardware? Does it implement soft reset?
>
> I'm wondering if you can skip hardware reset of the PHY and only do a
> software reset.

Can we ask ethernet PHY framework to notify us (the MAC driver) when it 
is going to do the hardware reset? In that way we can add clock 
disabling/enabling code to the callback and let the PHY framework do the 
reset procedure. In this way, we can benefit a lot from PHY framework. 
E.g. make use of dt props like `reset-(de)assert-us`, rather than 
encoding these value in the MAC driver with a custom vendor property.

>
> 	Andrew


-- 
Regards,
Yang Xiwen


