Return-Path: <linux-kernel+bounces-154769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854E8AE0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD3D1C21C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F257333;
	Tue, 23 Apr 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="HrQBWb41"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2128.outbound.protection.outlook.com [40.107.8.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA2482FA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863444; cv=fail; b=SBzoAkNh6AwCB/H2BleyyLz+octrdYJqo2ChfylBRehQSrNz5Ntu5CT9bGy4gjRZleO/SueWobrqNyg+NKh8CGZsyIFy2D017s4tGpwGjOfbw2uOlB3fJUTfy23Erg2KvTxhqpmbEkaOOupkTO8YXms1+nqBmI+0jn55J5K0COg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863444; c=relaxed/simple;
	bh=I75lxduvF2GQG83xzIOEeDsTjIi6nmdtxAt2UNQduhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGpyX+/iJAYF29752a44Si4rZ5TI+H5asqiPh4+miE2WIoUMtjUz8Av6C/6ZOELqnXblJkSLkMjLHV4Ocz7/6UQJ+LEPOaI4hGd/D3SxT/A/hreaqsAphDcT1YtRENVoYhdqjuDumhVfuePZLO8i2n9UnpXRyprYx803amW58vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=HrQBWb41; arc=fail smtp.client-ip=40.107.8.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb7O82VY5RF1uyFreby1MXBFVvW6R8QwH6rvuJYwJ4g5W3dlUBRSYMnNSOQLIkc61GIu1PbxexbzSlE+bvLTFU+P1IdIUG3MfttL5/8zT0GpWc5kcT8sC5k5HCih8lHnVz2HDxlm2YqIqr0vla4xlQaOUhQ8sSA1QgzHsHILtWEdDddbGyZEOqRzwqg/wTABTn1gWyutghS7/vd483M6yXO/YGcztJwjuQJ8tBklxgsgH1bEro9lkheJaED92lnL/EH+BFye//Im4/MIZEWWjq1kbGBNEkRamqlRz/8a1L/Ac1FJvcVNtBVGJRep/oZZZCN0da4Epm2AQptDB7MYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1yfQdmu9hDfL269w9xcDmxv2UlhfrFEHS7JVq4oxM8=;
 b=JRKyHmU5r54QMhMbovpc19zcvjFUIb1BqU1Cvcqt/UtcBFhiJpF0cyjO+Demfo6ArAetTQBCQIWfSmu4DKI5kKY51bZPMdeJQCQREuAZgL9s8lWBYAPjWs/ZPek3p8sKYNJtdWj42G8gRepiCg95jzXNc5zk2B/3BOYcipFalorQUBE/gYD8AmOz2aabXR/FkQxCWrohj+/Vd/sPWVyIHakbltmthEOFvar7TKdiuPPR3UDVEocxf/AhjDDQLrhfqpfv94kSi9IVAaBKTh6JfP7gYPJ5DoC2oLbcLdrLAzjkdStJ6KdOVD4eZuh8nZTQ+YIJ3o8IqSsEuCQUOVQlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1yfQdmu9hDfL269w9xcDmxv2UlhfrFEHS7JVq4oxM8=;
 b=HrQBWb41xgWxujoVim/J3+zv2kKEYXWxi64wC3A+UAslWl0qnQR27pXgPm7/uWw6ghgxz+NIWX9yh/caUGXRRoljUO36DAAbz7i3FWcKB5pvHwO0tzadrEvssGCOO0+Hwciasd4EAuGda6hhqZPgg1+4X0tOJtEufgy4YXcL063ACyD8cNro+2dxBAt1ORx+feOYMDbCeTKhNCDwvnCtaO5ZtBnTiwS5Ztl76/IuAFulQcFknadJ7JckDsMjlW+8SZ3LQq9GT//CjLjstzw+nXVfQKl9CgJBrxxi0hPekCyClvE9berGTnpSgN5c+PHUmwka65eg04OZwdn+vSCVkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by AM9PR04MB8082.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:10:38 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:10:38 +0000
Message-ID: <9baa0835-9cac-4bb8-b172-9e1351ffa6c9@theobroma-systems.com>
Date: Tue, 23 Apr 2024 11:10:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: rockchip: add PCIe3 support on
 rk3588-jaguar
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240422133502.2592975-1-heiko@sntech.de>
 <f33c0c0b-979b-4f50-89f7-976832968494@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <f33c0c0b-979b-4f50-89f7-976832968494@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|AM9PR04MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af0c88d-2208-4393-2589-08dc63753e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWovVFUwb0wwd2M1bUhyaXQ2TkE0Y1lZSU9pN0F2ak9CQm9hWUw5aTJDbXNx?=
 =?utf-8?B?Y0NJSFVnenFpSDRNRWdjREEvcVAvZkZ4UjNZS1puQko1aGdVQ0xYL0tZR09N?=
 =?utf-8?B?ZmFHL240RS9NY3dVK1F3dUUwSkx6L095Vnk3UWRERGJIRzVZbXhXOXE2UXFI?=
 =?utf-8?B?MW10ank4UDV6WlhHRVVzaWE5eGVST2QxUnpGdzh6NW04ODN4RUdYMWUyR0Nu?=
 =?utf-8?B?K0RzeVgrT1F4aFAzbVV2Q3EzSFBYaGRnSWkvRHFmcmpRUEhRNzNZL3BnTXds?=
 =?utf-8?B?WW8xRDhLTTFBTitJVVdwQThtN1JZbzZEZlRDdG1Vd1JNV1dJSElBYnU0SFpF?=
 =?utf-8?B?VmJtRDdBRzRrdjFkNUtkWnh5Zm45TXZUM2g0NEUrQnZHcGhaWEZ2aFY1M08z?=
 =?utf-8?B?T0Y2bXRjZTRTaGViV1g5STlteUdpZHkyTC9FQ2IxSk1jSDI4ZVluVFNDeFd1?=
 =?utf-8?B?ZkhkVE5LWmZKYVNoNDA1U3V6eFBnOEpGbWRXZzQyTVNiYTMvcy9YYTJRODF2?=
 =?utf-8?B?cjcwb2NUZG40K2FCU0x3T3Bod3E5bkc4OTJpZTBIRXkvQ0FyUkRRd0F6RGNz?=
 =?utf-8?B?RXBxdE4rbGlhdm9iU2dWNTRNci90bmFiVW9qYXM1ZUtlcjNoRy9tQjhVRFd3?=
 =?utf-8?B?UjlscXYyZXdrQnZZSGlpSVFiSlc5MS9qWkJYWUpxV2x6am83Y3M1WjQzUkI1?=
 =?utf-8?B?K3c5cVZqVzNYSDFNVDZiZCtmNlU2VFZURFFCMXBUSFVEWTRGeXJ5NzJvRGN1?=
 =?utf-8?B?dEh1MUszU2M5VEVuOG51MUdyY1htQnFFN3JGOXR4OC9VbTFhSTVBRHJzYlRQ?=
 =?utf-8?B?L2pzZVIyejdPeHlTY29mdkFuaVRVMTV2ZC8rcHBjTWJFMkxRb2phc1ZXTFNh?=
 =?utf-8?B?VG5IbmtqcFFXTk8ydGtqVU9hVlUyYzlrYmxKamUvT3R3UnBZNVoxUkdDdEd5?=
 =?utf-8?B?cWlrMzhDTzBlUlBkTVVabWR1T0FmSHVyeUZ4RGE4TnBYaUFxZ0MwTFdqNlVn?=
 =?utf-8?B?Rzlvd1F3QnEreSsxL2R1REljWVVOYnJIUnZ0VG1EbmtRUlI3MnpBY0ZGa1Yw?=
 =?utf-8?B?c3JZbjY0UWx1YVpLbCt5L0dtWkh5MVdqTkJJaFgzSkVJbmhnb1krTWxtSitS?=
 =?utf-8?B?WVRYL0taV0I1MytWTkJndGU1SlZIV1FCRzNGb3J3eFY0ZlQ2VmV4cmRyQlpU?=
 =?utf-8?B?SkNHK0UyQmgwTkpuZVo1YU1ocnJIeHFQVUdtQzVoZnl5U09FNDNCcUhRTXZM?=
 =?utf-8?B?NmoxUHR4U2NETGZvRVpORDZuMXUzSTJVZkU2TU10OHZKRmt0cDFPck1tRG9z?=
 =?utf-8?B?TW9CNUJycVJSSm5oMnUvMGdONnMwUXVtektSL2lWY1VMLy9aOXlYM0txbGhW?=
 =?utf-8?B?WUh4bklvUmFHQ3ZnRmhJWWJlbDQzOVo2TWZxOEpKMmtIam5VUEdIMEV4R3VU?=
 =?utf-8?B?eVRoTkFHdGg1SlFwdzNNMnRFUDJLNnpSeHNjK2tVTURyc3B0WUl0MTNPbU5l?=
 =?utf-8?B?aUpSWHdDQmtGT3lCMEhrMXRSR1Z6ekFLMm0wdFB3cHorUndEY0p1bEN2Wlgv?=
 =?utf-8?B?NmN3Rms1RTgyaCtwTzVPMG1SNFpxZmlGakljMk4zWHRkMnNEN0tIZWd1R0pD?=
 =?utf-8?B?eVo1M2J3YUFFeDVENGdGcFN0ZlBvbEdvOFhJL2p2UWJBVGd1VXRsNEZYLzNm?=
 =?utf-8?B?WUpRZTZxRU1qSnR2Y3BMUDVlMGFiK3laUXNsbU0yL0VWU1MySTVaT05RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDI3V3Q1VkVPUGRlVWdhVGp3V1hYbkptTkg2WUUwd3E2NEVLZEd5VmhuV3dj?=
 =?utf-8?B?Q0QwNUxSTmlJRmpIbTQ0MmM3Qk5ReEgxNFdhMGRMVGMrYkVNWXFhOFFUN1hM?=
 =?utf-8?B?QW91UERvaVljQXJKQlhWckJ4Wm56Sll3eWIrSDczYmhDTzVyek5kWFk3SFl1?=
 =?utf-8?B?VFZqTmpPLy80YkgwKzJYZk1UM2xDbXJHZnc3clI4VjdpcGordFVsRlZXMk0y?=
 =?utf-8?B?YVRzT2h2ckhyeld1MUxGKzQrTDU2OTFhVTFrTEZnQit0NFFxUGNzWmEzVWgy?=
 =?utf-8?B?RzRBbWFkV0xvWXZDSE1OSU11L1RTNW4zVkRwSStVQTZTcjVadURFNFBocXlv?=
 =?utf-8?B?T2tpaGhGTTlrdlFvSDc2ZzY4NXR3ZE5Fek9DdE56QXJwMDczWWNHK0E2N1ly?=
 =?utf-8?B?eEU0VllLdkVwbmlYcEVnRlFidmJ5bjdHa2RRd09IY3EwbHpGUCt4Z3MrVVU2?=
 =?utf-8?B?NXA4M2gvMzRGdEhWMm4wUnFLVDI0S3prSDA2dEUwNlpMMWlQODFtaFhqVENl?=
 =?utf-8?B?YnlLRjB1SlR6Ym1pMHFLdnB2L0IyQmFkZkowTjkwSW5qLzRvdXgvejN5R1NK?=
 =?utf-8?B?RWlkMDJDNjB6TjN0UVIrU1oxaXlwQno3aW81aTN1VS8vQmFlTVRGUUhoM09n?=
 =?utf-8?B?Y3ViOUpOcml1ZTUrYVpmM3FYYjllejhvaXZWSmFwcWdtUWdEdTdxQldRUGJ2?=
 =?utf-8?B?YThtOWc5L281bmxZV3dzeGtZUFN5UWZjdmF4T1c5Q29kYk1vakF2VnBzQnZZ?=
 =?utf-8?B?T3UxdDZmQ0ZrZ0twYzlZYUZGTTE0T1JPd3hydjZadEZacm1TNWlSSHlvdzlG?=
 =?utf-8?B?TDRVc0pIc2dWSVg2eW1tTWxhYU5qcDVPTjd3cHJUenpvS2hCNjRFVjhmNVdZ?=
 =?utf-8?B?cnlnb3YxVlAzdUpuQmRQem03RGhVMFQwckRUejZnazQxTUwzRU1jaG9YRU03?=
 =?utf-8?B?elFLaktZWnZvV2pUeEp0SFdmSW91WVQvUEFTclBDeWM3dEhpMEExWGZhblAz?=
 =?utf-8?B?cmdxS0czcldJMEhKZXJweWJWdlU2NFJhQ0xuY2xGUXpMYUlVUk9rUHdhRG9k?=
 =?utf-8?B?QUo2Z3N4RDFoTnVqcitrclBwRWk4TWdiRWRlM0hiYVZkSHhxZ0h4Q0srTCs5?=
 =?utf-8?B?SmhtdnJGNitBdHNtOGtxMFBnYXVFRG5iVzVTUXBtTFBaQkVlRDR4UllNeU5j?=
 =?utf-8?B?K2xPNzFaZXBmYUhMWmZvOE4rRXR3WFNRY0JLMnN2WmJscjlDaW9VdFNOWW5R?=
 =?utf-8?B?dFp5QlpFTjQwVUZQMm1pd1VWSzJJdUNFT0lEQnE0ZXplRVo2aFlhcFRueElm?=
 =?utf-8?B?aWNSQy93WlVJczJuMVdITnNGQWMrME9rQ05LMmVtcEtId1FXL2NZSkx0cTVB?=
 =?utf-8?B?bDNzQTIxTzRqbUo5SUdpa29HbGZ4czhDVzQ3R0FYSXQzVlFWeDlOUkprTFkr?=
 =?utf-8?B?bnBKMENIbDRoWXBIczkzOTdmTjJQSTNsVGFac3J5bjJWYVNBU2dWamZkcTI3?=
 =?utf-8?B?ckt5Snl2MjFaTG01enpueUVURjV4azdUZDFWditNT2dVbEhVNEVKUExQcGIx?=
 =?utf-8?B?eC9yazB6bjhYcUJWRzNjcmt6ckFRSjdaQkk3M1hycEt1RFVFS2VIVFYrWEVG?=
 =?utf-8?B?V1VMb3BzQWM2RklwOWladTRUY1hsVTlycUxtcHYxaU1kekFxU2t4emE0RTBH?=
 =?utf-8?B?RWtwbWcwdmJyU2JYWkJPdlZ2RE42WW9raWlVbGdyZ1dGaHVLZXREb1VqTG9r?=
 =?utf-8?B?QUZyVVpoTWVDZ2ZKb3lFa2JTeXZHK0hFWVBUVU5YZ0ZER1J1M2VwT1E0K3Qy?=
 =?utf-8?B?dnVGd0JmY2pPdVpnMmFFRXJQTEdJS1pFUGRjTDBpaWJhVDFIdHBnNmJpdzkr?=
 =?utf-8?B?cUV0OUljL21KcHZxdjUyaTg0ZE1jdW1Wc2tTZUkyWEQwbS9qdG0za09meERB?=
 =?utf-8?B?ZGRsMzB3UnJpSnNhUCtiNmdiNmNFM05NN3dSbHdOSklNbjMvRkpRdVVrK0hT?=
 =?utf-8?B?QzErRUh4M0xuWFJFQ2lYRDFwRGJ6UktDNkdjME0rdkc1eGpGZmdQcjN1VnV4?=
 =?utf-8?B?bEhmNFJKZVhxZDRaSGh5QmI3OXlKb3E1Q25WelNkaUVwb2p1aTJLbW5GTmQx?=
 =?utf-8?B?TjU4WnNOVjIvZDZ1aTF1UU94WUJtY1RhMkhQT0VEVVFLZlM4TzRNaTVUaEJ4?=
 =?utf-8?Q?ZGjrh4+nqNDTYCmnmDrgYfk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af0c88d-2208-4393-2589-08dc63753e12
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:10:38.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt4AnHtprl3lhnEX5WJAP5Kn6t9Y25+b/bDBPD/qXiJtgPB5c6kXpjmVhKysOclPwvhM+j/Az2CWihs/OOYXUNkv06XQA9nRiLz/zKpXXlbkxXgxcWQs0Bvi7oD7kGf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8082

Hi Jonas, Heiko,

On 4/22/24 20:36, Jonas Karlman wrote:
> Hi Heiko,
> 
> On 2024-04-22 15:35, Heiko Stuebner wrote:
>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>
>> The Jaguar SBC provides an M.2 slot connected to the pcie3 controller.
>> In contrast to a number of other boards the pcie-refclk is gpio-controlled,
>> so the necessary clock and is added to the list of pcie3 clocks.
>>
>> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
>> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>> changes in v3:
>> - drop unnecessary pinctrl comment (Quentin)
>> - add Quentin's review
>>
>> changes in v2:
>> - "an" M.2 slot (Dragan)
>> - pinctrl for refclk-en and reset pin (Quentin)
>> - don't repurpose the pcie30x4_pins pinctrl entry for only wake (Quentin)
>>
>>   .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
>> index 4076c92668ba..0ad53d7768a3 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
>> @@ -72,6 +72,27 @@ led-1 {
>>   		};
>>   	};
>>   
>> +	/*
>> +	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
>> +	 * clock generator.
>> +	 * The clock output is gated via the OE pin on the clock generator.
>> +	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
>> +	 */
>> +	pcie_refclk_gen: pcie-refclk-gen-clock {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <1000000000>;
> 
> This should probably be 100000000 (100 MHz) and not 1 GHz?
> 

Good catch, we also need to fix this for Tiger where the same mistake 
was made it seems :/

Wondering if we couldn't have some kind of constant to make it more 
readable in DTSes? E.g.

#define 1K	1000
#define 1Ki	1024
#define 1M	1000000
#define 1Mi	1048576


And in the DT we could simply have <(100 * 1M)> wherever appropriate?

Thanks,
Quentin

