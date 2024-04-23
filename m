Return-Path: <linux-kernel+bounces-154797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767248AE126
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DD2856AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034059151;
	Tue, 23 Apr 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="D4tGC4qu"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2093.outbound.protection.outlook.com [40.107.20.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8FB1E863;
	Tue, 23 Apr 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865175; cv=fail; b=SRaK94/PtDR6OutQCZU7OIB1Q95+MpcYWrWo/zvSqElU0+42TNksK274U/hRTftiCiiDTMc6FCYWH1LHPh4ojW4DTMITW3yG5dUd9e/36H9YOpLCcdQJ/YQ+78Drh8SiaOaMDkx4WliPKptGFC+isHb/7gxAZy4tl/u+hja1j0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865175; c=relaxed/simple;
	bh=nmytv9FKT83uoeZi2O8cvnL2MSWPB/md0I+WFzSvuAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mAbb/buyhh0Ygfdy0dJU7gRiWMjR4toJwT2fisICih7Oy7iGEB/S5u/cJbRhpvwQruKuE0hbUFoAKFBrvQ1TaffVsHmT1T9b3sKinNEQ5hUfXcWgEYwJgK4Ex3m3cgMvKbVez9WEMe2ind7emGewgaP+NLf00frHEl1eArK92IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=D4tGC4qu; arc=fail smtp.client-ip=40.107.20.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwFcMyQD/pqUrt1nwyRR5vIFgMcDmfnKC5T1H2oGRftaOXzXyCCbZf8uOBtXETDDgJjTB138Dfk4Vik6F52c4y7MvMQRSJuMgU2u/16gCnCuxtWJu+HPpt6Sf/YQl4Y0QiJCXWd+v29+xWSM3JNSWqyb34bDYWlJ1rDdSjYlnwjNuGemrGrnAjrIwAH+ySKr3whYsMRvBMnNIe9SuXzRGt2qajsvv7uC919EbmnZfwZr6cEQ4WP1rQjn/PIpCHPaiXEtYXzSrDJZAnp8FAy6JSPtrWFx8JDzVweBblDf5SQNvb9SiSN6jvm354Y6XnQNj/DvhAVz3q9duD/pbTutOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iglarcSymAQ/s+SXFcIUFzuT/Iab7HVwkRoSu3j8u98=;
 b=k0rxM5uHnkauAxO0cDdiCpS36Tm8AfMjpQSWvHvQyEeQsP71WSj28vVoQemdo/o3iuL3TosdS2EtlwmdDXWhtHYsKJOglpJ7qNTocdthm0R0ABfBqRUVClEvW5c0FRgExTYKLvFR2iYrR61K+uPi6Y9Fh5/6JVRHMR8NOoaRfd6sVRNk5wZ/6C8K2I+L8tscO63xKMjaMNdL0UKi7YtiRB1Z06f6ZunXCcw1B2HHBNlsHUsvojF/BKx/uBZoTP09dvoze+YV6E/h7K0hhWuNgkICPlL9Cn0nzXOHYu9rcQHm2ALLekkcGqPu723tBl6T/0HwCxcQc1MvdfsU6bRZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iglarcSymAQ/s+SXFcIUFzuT/Iab7HVwkRoSu3j8u98=;
 b=D4tGC4qukx7BD5ofs7NRNPn823VHqeL9AP+hnhiNEAH3tDuqVStBKwD+ycNjYDtVMCW6xEWIGFLuAy7Ba8J09uJrgdqjhXFXLaJXXoACVlLn23DC516Nxn29tQ5rP/kIstriXiO61Q4OjI2GvlugZoBNgKPF0TlvIT1Vy4U5q8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6730.eurprd08.prod.outlook.com (2603:10a6:10:2a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 09:39:29 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::224e:39b5:5107:43de]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::224e:39b5:5107:43de%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:39:29 +0000
Message-ID: <3f93ecb0-a649-4492-8798-a00de26236c8@wolfvision.net>
Date: Tue, 23 Apr 2024 11:39:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix nodename warning on
 wolfvision-pf5-display
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 devicetree <devicetree@vger.kernel.org>
References: <20240423082941.2626102-1-heiko@sntech.de>
From: Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20240423082941.2626102-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e68c026-1160-4b7e-5ce1-08dc63794598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2JRajg3dFh1eHowNEpaQjVXZkVGbVdXYnRUSkZYYWpMcExTZ2hzSnFvUFBQ?=
 =?utf-8?B?cWJVWTM3S09UdHZiUEJjNWNINHJYeVo3YjQyRlQrZ0VFMXVyeWtnRXY1T05s?=
 =?utf-8?B?eHo2VkZId3JuL0VRaGZsVFJ3a0pWQVNKQzZRbzF6YjAwQVV1bFFCZ3Uvd1pU?=
 =?utf-8?B?SVpzTTNXTms5UGlvZEtZeC9ITjI3N0ZLTHRDNVc1eEgyUGhka1BkOXR5Nkhh?=
 =?utf-8?B?emlCUGZMSGhKOHpHRVR1MW5BRFpsUS80d1NKNDR6R3JmaXNNYUJpMDNEWkdO?=
 =?utf-8?B?TUV6Q2htRTllaFQvNmRDdzdVbU9ITFdRRm8yeUhrR1U1TWxvYy9wNHlzbldw?=
 =?utf-8?B?UHl1QzV3RnRLTEQzd2VzTEE0cGx4R0pYcWFJbUJ6bUhZZzJ0UE8zNjEwY29r?=
 =?utf-8?B?Ly9pM3VuS1F4Yitvdkh3WGI2WCs1anZBRm1zT2djQjEzMEdOQ05oekpsMExY?=
 =?utf-8?B?VzA5U0RqbjdySnVOTDBVcU1lV01JVWdtSEt6c0RVNHdyK2pOclFxelhqMkpa?=
 =?utf-8?B?SkVqM0dWem0wWVI1amxvc3RFdW8wVHV0ZTNpVExSQ21wV2l0bFkzbVZ1dkV0?=
 =?utf-8?B?dmxoOXZadDQ3NHUrWWhjSnIrcWdzL3JZa2VqWUZ3L2RaTXh6LzU1Q0NyTUdn?=
 =?utf-8?B?aVVyUkVLeXNXSVcrc0llMm83Tm54SkFQcStJUG9uNG9JQndUUGpZMXR0Y2Ra?=
 =?utf-8?B?SlZWQ1k1UllIOEVheG1mMFdBbVNTMUZOZ1hncENmaW9aMTRrbnRJcmZkSkpm?=
 =?utf-8?B?b0tGR1d5bzBoMlgyK3gxeVJRZ1FUSmpGY2RCK1pmdEx6NkU3VGpPMFRDM3pz?=
 =?utf-8?B?MExodDFJaFRHTklJT2x5QURjV3ZSNklHNUpib1J5U2IvZGFmWDNaOE5OMW8z?=
 =?utf-8?B?K3lLZkxTNWp6aWZDZEhGbUJGU1NmdklZeE01UUVwWDBpNHE2YkNGTUgyNXdH?=
 =?utf-8?B?Y0NjL1QrbmVWaVFUSXlpVEIxMTVhblFOVWYxdTQvakVmcWMwaHFKNWpDdmFs?=
 =?utf-8?B?Mng1U3FzQUdHS2tFbSt4TStnRjdaQU5XZno2SnZ3U0c2WUdIajhxUFJ1eTE5?=
 =?utf-8?B?eWZZU1BuY3Y2R3VuYlE4WVAzcUc1bHltL0dNYWNTcmZIY25tNnNNelBtMStG?=
 =?utf-8?B?SFF5MGNSdThhYjhtMkZZQkprckxwdkJ3cGhBZkRYLzVON3RXeDNmRXp3ZHg0?=
 =?utf-8?B?cU83cjByQ3hGK3F5UXhpQUd4VWZKZ3RiVHlpTExiT3d5RkcxWHNHMkwrNW9a?=
 =?utf-8?B?ZzdnY09BVGVhaTR0bHBFTUpMMFBUZ0QwMUNtSkk0bmdoNFpiQzg2YjV2Ymhp?=
 =?utf-8?B?U2c3aFpHcXgyY2JpRUZiQ0lEckozSExpNm04ckMrNVhzVzAzRkFGekd6RmRr?=
 =?utf-8?B?ajBEWTBseHlUcVkxUitjbmxEanhZQ2dOcjhvR3Qwb2hEcHcvdXF2RTlsaStk?=
 =?utf-8?B?MWF6NWpjakVyZEloa2ZLb2FPcnNOaDRZcnFaa1dBNmppR3M0R2p1OHhnYmxS?=
 =?utf-8?B?UXBqRWovUFRWQlBBTVFVY1FNdVpoUmk0TFM3VXRaVU9Wc0JHTWpkSlpibWJV?=
 =?utf-8?B?MmtuaUx2MDRqTXQ0UEdXeXdqcm9Majdrd0U2QVJPQWU5K1ZSeHNUWXdvN0l1?=
 =?utf-8?B?QjVNN3JMTExRSkIvWXhtNGhWK0Z6SkhGcURSY3N5ZlF4N1FBNWF0N2lCMjBE?=
 =?utf-8?B?cDV5Tml6SzJTR1Y0SGxjZGI1UFNVSExpNTN1bVhiV2JHQUpMQ3BQT2F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDU0R2UyVS85N2JiV0J0VFVTWVQvN3lMYXdSY3lZUm1sYkt3cXV2aWZVMjE2?=
 =?utf-8?B?VEtTUXVJRVpZdzhYa2t3Y1loTWZaR0lXRlpDWTI5ejdoQnhxOTFMb3hFeG52?=
 =?utf-8?B?NjlielFWKzg5RkVtOWlHZmdwZElFc1RzYkpUVHp5dG5hdUd0bSt5U25oNW93?=
 =?utf-8?B?N05PMTRNd0VTTnNyLzVFV3NiNHBkbmFaNXhiOVUwaytNWmNOM2JkNEJTVk45?=
 =?utf-8?B?THc1ZW1RS09xV1Bnb1lRRFNyN2U4MTlSVHZCWDJhUHBiREIzRnZDdmdYcjkz?=
 =?utf-8?B?Z0VpNjErbFgxNCtSZE15SzZrZEJxU2FRRkxONkJ2STdKNHBiRXNXdW1Wcjgw?=
 =?utf-8?B?SldkYmw5djFDaW9NNUlGZ0xHQysxcnRRc25Na3VRd0RLdFc3WldubkJDeGg2?=
 =?utf-8?B?V1dXZ251bTJmT3JFQi9HSzYyTzZXbEhmUUhvbVhGVUxGbkljT0duYmo2SWJo?=
 =?utf-8?B?ZG9FNFhiSkE2b08vZmhmUmdHUE5veVhUak1lREhlazE4RXVuaXBIQU1OcktT?=
 =?utf-8?B?R0Qrb3UxZkQ2THcwTU84MWVFR2dZc2tieExHaFFvM3JRRHYzbVFrN09zODE3?=
 =?utf-8?B?NkNrUDR3eDRqbXdwZXR2bzFFNEg0YzRralI1eVAxOVRlZjhaYU8zbVNOeXRl?=
 =?utf-8?B?dURrNTYwd3RPQngzeGtYVk5OK3R6ODg4SXdSL1RkTEoweUVXUXllSVFzVCtY?=
 =?utf-8?B?QmREY3RJOEJ5NkoyOWhLSzdzSURYZWZKZTN6WFNCT2x4VHZYYTEvUklaYnlM?=
 =?utf-8?B?QWVTWW5mK1p3N2ZQdldZeG9WQkc4SVc0eFNKSERSZVVvVDJLZDd2bElod24r?=
 =?utf-8?B?TzFXN0xQN0gyeDFaT1ZUaG9lY0NGczV1NU16enplR0p3bzlDeUNIMnFNY1pY?=
 =?utf-8?B?STcyZGZONTlTdUR3SDh5YnBMam40cmt5OFVCOVJDN3N6VXdiNitMM0Z1VUVZ?=
 =?utf-8?B?VzlqTkRNTlExYndtcTFsYVd3OS9qWDBEOGd4d29JTG5SamYxdlM0b3hkYzdQ?=
 =?utf-8?B?bmdiVkpKY29RTFZIa1krUUZueDdGQklySGdDYXlRdjFWUzVSTFdtWDBNbnBT?=
 =?utf-8?B?Z2MxMjdMNDRjUm5WekZqci84NkNpc1M5UGowTExPVTdkZjFCM3hpeVhyendi?=
 =?utf-8?B?RmhFS0ozeEdtV3JUdzc2aWVuRDg5MThqMSswOHJzeExYY09hdTVBakVMSUdN?=
 =?utf-8?B?S0tmdEREQUJYT2l6UktlODI5eDVXTVlrclFaZzlrQU5CNkJmb004VEpvNWVu?=
 =?utf-8?B?aU80SmlneXJhRDRSdDJZR040aUNpVkFWdzhZY2lJd2pvWGxNT29OSEJnM2dk?=
 =?utf-8?B?RlZ1RjBSM2d3b3orTXB2cXVCeUtid3ZNTDV6clJsZFArTEoreGp3cm82M1dE?=
 =?utf-8?B?RmtwKzdFQlNUZysvaXYvMElIbUhTTFFrQWJDR1Z3QUlrbjl3L1JPL3prdzIx?=
 =?utf-8?B?aGRjMDNxMWdVMFRXaS85MHpaZXlpd1JmK3E0R0xNNk91VkU3K251ZEpYZ0M1?=
 =?utf-8?B?dGl1cUNEUGVSUzRmYXJ2Q2l0eUtpNmNZWG9iY1VEK0Jsb0Q3SThOZ0tPUmZR?=
 =?utf-8?B?MEtSUUVTMS9zamJPNGhWU0lsTGhINW9kTU9vMGVMZ05vK21WbnVrWDhyOXVG?=
 =?utf-8?B?M1JENnlnUVhtUzZTalczSC8yR21PODVkRk95L08vOThoOW0vUnFUd3VpcE9Q?=
 =?utf-8?B?ME9LUzVvSzVlR091czZVZ0JNcDBkRE9ORU9XTzF2L3Ric0xvK002TVk5cHg2?=
 =?utf-8?B?aTJhbDJNZmRGdExDbmRjNzNZclhWZkJQMUFCL1VoVjNBMjlXaGZxbjlrY0hv?=
 =?utf-8?B?MVBnQzJaQ0ZQQjNsNTloRU9IdkxJWU9kbkMxRHE1OVQzTW8zc0p3SkJQeERS?=
 =?utf-8?B?M0p4MEtUam5FSm1BVkYvdEZud2Z0NGRBMlRSelBXalRJYWgrT0c1T0RVdXda?=
 =?utf-8?B?eVZkUFVIaFA0VmR1bWVCWWcyVFhrblU3K2Q3Z0FvdHluM3k1eE1KbHVCMjRo?=
 =?utf-8?B?NzBIRFNNTU52VVVkRC9vRUtSK1lpY3Fab3AwQU5CLzlEY0xRUStweUQxRUpV?=
 =?utf-8?B?Y0RtRzRrY0xHZnppYUNWeWh5M2R5N2gvMnBpQjBsekVGa282cUpDMnVhWXh1?=
 =?utf-8?B?citZNGZNTWtRZVpDMDFrMnZOTmRSZzdaT1pZNXgxUjlVMDFseXdLRGlDN1Fm?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e68c026-1160-4b7e-5ce1-08dc63794598
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:39:29.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfXCokUrISGTgHc5C4EueMsWf7mILqyc1RUmOaxjYDwKQRt3CcNDmGVQoA5lxSnzu2hOUjJqvg4kxBqDgaYBOb70+55SpYkDd6n+lOl0CIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6730

Hi Heiko,

First of all, thanks a lot for doing this!

On 4/23/24 10:29, Heiko Stuebner wrote:
> The dtbs check throws a warning about node naming with the recently
> added pf5-display-overlay:
> rockchip/rk3568-wolfvision-pf5-display.dtsi:113.6-121.3: Warning (graph_port): /fragment@4/__overlay__: graph port node name should be 'port'
> 
> This comes from the overlay just referencing the vp2-port-node via
> its phandle and then adding an endpoint beneath it.
> 
> While this is possible something to handle inside the dtbs check,
> carrying around the warning is not pretty, so change the description
> to go around it.

What is the rationale behind that check? Describing a port in a SoC dtsi
or board dts and using the reference in an overlay is quite convenient
and above all concise.

Cc: device tree list
> Starting from the vop_out phandle and then referencing the port
> via its generic port@2 nodename will satisfy the port<->endpoint
> naming dependency while keeping the same structure once the overlay
> is applied.
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../rockchip/rk3568-wolfvision-pf5-display.dtsi    | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
> index b22bb543ecbb..18c807c39e56 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
> @@ -110,12 +110,14 @@ &pwm10 {
>  	status = "okay";
>  };
>  
> -&vp2 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> +&vop_out {
> +	port@2 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
> -	vp2_out_rgb: endpoint@ROCKCHIP_VOP2_EP_RGB0 {
> -		reg = <ROCKCHIP_VOP2_EP_RGB0>;
> -		remote-endpoint = <&panel_in_vp2>;
> +		vp2_out_rgb: endpoint@ROCKCHIP_VOP2_EP_RGB0 {
> +			reg = <ROCKCHIP_VOP2_EP_RGB0>;
> +			remote-endpoint = <&panel_in_vp2>;
> +		};
>  	};
>  };

With this patch applied the DTC warning "Warning (graph_port):
/fragment@4/__overlay__: graph port node name should be 'port'"
vanishes, but a different DTC warning "Warning (unit_address_vs_reg):
/fragment@4/__overlay__/port@2: node has a unit name, but no reg or
ranges property" appears. Can you reproduce this?

I tried to fix that by adding the reg property, but then DTC complained
about "Warning (graph_port): /fragment@9/__overlay__/ports/port@0: graph
node '#size-cells' is -1, must be 0"

Then, I added the #size-cells property to avoid this. However, DTC
complained about this property not being necessary as there is only one
port. I stopped at this point.

I would say the real question is how this hardware should look like in
the device tree (overlay). Then, the compiler and/or build scripts can
be adjusted to tolerate this.

Thanks and best regards,
Michael

