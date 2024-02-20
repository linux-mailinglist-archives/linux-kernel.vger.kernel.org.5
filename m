Return-Path: <linux-kernel+bounces-72687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE485B744
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5351F2394B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B535F84F;
	Tue, 20 Feb 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ebWh/gym"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2062.outbound.protection.outlook.com [40.92.107.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B65D499;
	Tue, 20 Feb 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421112; cv=fail; b=gDFxGkT83aZkqSW2FTxdduLPlBGmYcBPsk55WPsWRnyzvSA7EUxjE+8esaVK5h29UMvmZy9DgUvojys+ONwPC3qCyLmTS2yo5CQDRWTJSlHGyReGTgToNgKrFNwyByO0Qs1bcg10WW19TEJOgxojm0nsZeqh4he/FXDAcqTYPvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421112; c=relaxed/simple;
	bh=5zAR/ASjrjKrs+6Kez6z+UzgKCd5UoQNTTQfPJA1cEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gz/R7QZJiyW87wWlK2T9UlwkDHBqvGSGDxl1TkfZUBupqkpPzdrF5S/m589Nezz+SrQB9QnWLKwdCSGbnMeOr0Yhb8rAx2vOjOWttgZkxuPlEF2Jfk/HWOZHPcDE8onoCdc4ine6GWRhMcyKfcCnvRJ8X+YfHzZye6b8KqG1U6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ebWh/gym; arc=fail smtp.client-ip=40.92.107.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO6YkG76uB1azRvT+2FExTlG8svVNqN5/aJc+CG87jV3sA0fh86FjaK06TXbBiR6E2j0ryAd7dHHclB8hCPgHqElZPt+xfa4X4AX/PYU5B1HCSNb3ezoFR4G0PA+HV+UhbvzBkL0u5Bv2fJYarvdnc9ufr1ogHpcHM9EMt8j1HDlEYcM1n/Ucm8ul0Shg/2BWCn6ic1/CI+DUjT4ZS01DW0iKSgyj3r3jvWod52YWl+hTwm3BIyjR8EtTRFeeN6WiLPcQrhoqfCy3hBhiSBxbZjm/7dnVDUPuaZ+OcM30+kxpUO27cQdkw1EnwI1ZMazWMIuF6F2k6KDfE0+4XVjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMAjvnf5/2THGdBm2IkBS8NVUiNOoadku4YwMbaen8Y=;
 b=ZHGp978TezxYi0DmlsMTwWaa5ccKfbIdTkamBjVbWpuM40YVfWqwyYNFCb9keXE4t0qM5d5NmrCebf3LdR3mebhlr7BwnxYlt7z9UDi7POJrsR/VXiMDgyuxC2v42e600GCbAk5O76Q+6CGKr+EgCLUCsZaVQwpVKOFcypCsJStrmuhDpW0ey/rQ5xf1DD0pd4upHnAMbGz8BEljpM+4k34+QeZR1Qp6scC9pNKnaRgxr8qRMo2iCf2COdVHzCrMNtA4kX3Bn8twHHNpHiAnqjWphjZsI5hR4EpWRpkVLdKZzPLFUjBUS5jtblRG1s5QH6D+7mD/fwohDnt0A0RuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMAjvnf5/2THGdBm2IkBS8NVUiNOoadku4YwMbaen8Y=;
 b=ebWh/gym9s7cuRAWpV4BxVvmMQ2lsdl8F9axvAW9WCIYJI4a1VGaSnM7S1YR9N52yc2WCmZ/wxpgNCS25qRG84ZRtsoUpOlog1b19UO1ZQoVtnI/SAzo/DiNZjBjVdjdUEENuWw+wKNaT7aw4zukIyg+kh8FHrGqzB9Dlyi6fvfzAICELtgKmbxez2LR4Qj0QrMQDRx1clqvLmpJkcOO7W5dHxpJ6IB/NldtVHFDnXYMgOSYz79+uzhMi5P2ZGrE72W5kXiBHcgBE9OYvrks+nSm2MLLsCEpvDC/K7QNz02m8LD92s5Xoo+6iIeI569O+UAvOmfq5jjvaPj68BX14g==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB5791.apcprd06.prod.outlook.com (2603:1096:101:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Tue, 20 Feb
 2024 09:25:05 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 09:25:05 +0000
Message-ID:
 <SEZPR06MB6959EB3E02967ECDB986AE5696502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 17:25:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 5/5] dt-bindings: phy: hisi-inno-usb2: add
 compatible of hisilicon,hi3798mv200-usb2-phy
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-5-893cdf8633b4@outlook.com>
 <d69b3fd0-2799-4cf7-90fd-d22e6c24bdc3@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <d69b3fd0-2799-4cf7-90fd-d22e6c24bdc3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [EI7S5TZzg3qzN3JRCCz+mQ1vG1YuV4PCnHlxPwQBsQyc/rN7HyQHboAoZhiEKn8Q]
X-ClientProxiedBy: TYCP286CA0203.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <c91c82b0-c4b2-4a6c-9f1e-911b4abc67b2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 15565e33-4092-47c7-605b-08dc31f5d27d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mK5b7BA+AUy8ae1UO3kRk/gP624kQ81uBQN2SnGTNXYfBH7uskRNy2MwTyRf3gv7i5qz/bz9jeS5II2inuaLOZD7eCt2t1ieDeOwkAvcsF46HGkFrkjJNQ/SnpqsSpsqZscGnYF5eEIcbo4mYUDleyQcHs0moVG8RQz7ZwoXN9Wl6MEvfW5x5H0T7GjZ4DMsi4U4z190m6OFiHy/Q8sqf8fqe1u4k5VWPVJaDhqngrcd0nu7m7LY5uUxDTBvSdiQdpauRUY3KS89cznc/oSVuzwjfcPrdsNVSgpAaQ5cSPfcegBD4aexsNCH/QITHM6pz0deI8ued0rnLsFGPt0+el/ylbjfe6ok83e4woIY9EbhERRdjaXFnjMe5TZBhkfMlmU5URsYNr1UPBFc8t70LkOYTROYwLfdn+har1NhpMQxxeKG1hy4JdWsM8zUa074Hek89eU3jr6eOoa+ACtHWBWRap/BU16YIMhuWSsVUbazIkakW97/9CoHcCfhWHFLUlachO2Rf15gmi3tLkRvzm+cL5rFClGB1/gJj4iwQ7p9nv8lf+OyyUB6z+684Fhz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek92aEcvcEQ4bjA1eHRDY3kydjFUQ1ZTbythL1ZQU0pZL3VPVnB5YzJKN0t6?=
 =?utf-8?B?c3hlN2psekQrTHFxbTF1VkI3WnRPV3BGTGtFWTY0UEpZMWdTM0liZUkxTldt?=
 =?utf-8?B?NmpMSHFoL2JmTjJDZGNVb2ViNk1ESGhMN1d5SmJ5ekt3T3RrWE5uLzNYUWR2?=
 =?utf-8?B?YmVEVGhFRkFjUUdZeUlGa3dvZkFJd0hHT29nZlJMaE1xYmFSMVVlZm85WExq?=
 =?utf-8?B?ZDR5cEVlL2NSSWh1WHlCaExuQjBhTDhReHdRbkFIQ25xVVVLcHhqOG44cDFF?=
 =?utf-8?B?OFo4ZG9jUTN2NHhaekR6c3Y2RnZ0eDVjTVE1cWJBWVpFejV5QmtKN2hRTVVT?=
 =?utf-8?B?Mm9nQ3c4aXBRWVVWQjh5Zis5SGRsZkphT1JxdHBtdURndng5blFvcHE5VjFz?=
 =?utf-8?B?QUhtQ1hFai9ZUzdHZXphcU8xNEF3dm5PUFdXUTA3Y0RYTWpaSmZkQzF2c0FD?=
 =?utf-8?B?cWx3Rm5MTnRWOFJXNjlRbWZid25pQXNHSnBueXNDeGxHWEJhV29VK013RjI3?=
 =?utf-8?B?NjhZUVpQVVNmbEhaWFFYMGxOWFcyQVFKQmNsamRCcEdZSG1zanZoZkkvOGNk?=
 =?utf-8?B?eUdTUEhIMldoZ2l5S1BncGVZbGZMdDlWSEJzY0liM3ljbXdyY0JMVEY4d2JK?=
 =?utf-8?B?WjU4ZzVwU1dJR0FOR0pNQnJxUU9WZVZUMkMzeUdocm1IeDV3b1p1YzdDSy9Y?=
 =?utf-8?B?OXlBZmRLSEx1NTQ0SDJiUFF3MXNIbW1UakN2d2FSbGU0ZjBNcE5UTkh4cDQr?=
 =?utf-8?B?Q1NLWmMxa1RjN2dlSU5rM0JTajgraEdRVWU5bXpuNHl5YUl4WUpKYWovQWhy?=
 =?utf-8?B?ajBYLytpbHU0eFFaTllDdmhBQ3Boa0g2dThGTElTTDM1emUvcFNsaUR5c1dn?=
 =?utf-8?B?S1FHZDk5UEJjcG0zdzZyTmFLanh3bGExUjZoTlYvWklLZ1UzekJNeTM2R3Zk?=
 =?utf-8?B?T1dTVXhhU3QwdnZDcExVWVhNQnYxRHRqQ1YxdmpYWERyeG1Jbm1abWJ0SXRa?=
 =?utf-8?B?WDI2UVZEb2ZXb2pqcjVHS1lJRWIvakpkNkpYQTMzckFpTUEzKzdRaXE1ZHZq?=
 =?utf-8?B?UGI0cEJiQUN4Nmo5NHI3TGlFZDNnMXpIQksxdE1hdGhpL2pXVUwxeHNrcytL?=
 =?utf-8?B?QzNtWEJJaC9Da2hwYUwxbyt3UTg4V2M4T2krdnpBNkxqY3hjSnVCNEdicW43?=
 =?utf-8?B?dlg2VCtBaWM1NFAyeGVDZXZLWElid1RhUXlVa3RMRHZibU1rV3VRMGxGMU9s?=
 =?utf-8?B?ME9WeVoxdGE5QVlvNEtQZWhOQXNwa0owZTEwYmE0d0lQY0l1UFlEaWVZdkcr?=
 =?utf-8?B?bHZBU1YrdHNSNzFpellYNFhPWDUxVHFDQjJ2cjZ1QjBEdjFLWHFyWkppZEQw?=
 =?utf-8?B?TVh6ZDEvNFRDREFmSjRDNnZ5Wkx3UnFaZEFmMDBVQktSMEswL29TTnhLU2tC?=
 =?utf-8?B?SmF5UEVscFhwbG5rMkRZelRJUkVzT3d2dHd2TysvSGR3V0NtQW9MNDB6Qm5j?=
 =?utf-8?B?ckNiS1Q1eFE0UmJkVkxIVUt1dDZuSUpvTmRpN29VZTVoSjMrVkZaNlk0NTR5?=
 =?utf-8?B?SGx3T1puVzVMWjBDYVNtb2crTTlNYWx6RnJUYVIyVXJFQzVDVmZhaHNzdXV0?=
 =?utf-8?B?Q1dqZ25aSEcrQVB4YTRMQ2h6OXd2cUw1VEY0NnBmbTFmQnFzMHNaRmY2VllQ?=
 =?utf-8?B?cWtkSStoNEg1UzZUMFowMWhWSzdNaVMveDl5ZWorQk9BTm1NZ3BhbWxPejg1?=
 =?utf-8?Q?PzxnN6WpF+kzMmf8Dlc2sLgcUntPXY1Y5OLutmy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15565e33-4092-47c7-605b-08dc31f5d27d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:25:05.0120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5791

On 2/20/2024 4:18 PM, Krzysztof Kozlowski wrote:
> On 19/02/2024 22:28, Yang Xiwen via B4 Relay wrote:
>>   
>>     resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: port
>> +      - const: test
> Why old device now gets two resets? You need to constrain it per variant.
I only make reset-names mandatory for mv200. For other models, this 
property is not allowed. I'll add constraint for resets too in next version.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


