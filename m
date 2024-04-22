Return-Path: <linux-kernel+bounces-153746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419D8AD2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BB81F2214C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CF15358B;
	Mon, 22 Apr 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="fMDSJ5rl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56C15382C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804369; cv=fail; b=NRBqp9QPD/xw3CSjrJkznGk9/f4qSmrHhVfrhpY+YyBGi1oDwGQPC6auLoBID3N2EGQCnSPWC+tYObVPAj38M5SN8zPiLxmZ4cfHRdHssmKUgXdleS7BpKWJv80MfDEtSFxzy/ImZIBvgrbicmLRqvZz1KlzAr/sjV70G1xdhvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804369; c=relaxed/simple;
	bh=YaA35XsTyZ0UZO3Q1nzi5/mi+V2eh2BtWlJ4uiA2FX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TNOtJVN7w2TEcU2l8+0S2q2mSfaKV+5t/i2xQanqXnaTPDl3aqIxLzlby76r47NsFgM/GISA7weibO7bCcB61CZcu0Z40bSuLpbAeYquvH+KsOxo6wylYbDK2fB29di4w0FgSQhS9GsGw7awVu7zjhjwn1x0xKEhsPFvX3xcS5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=fMDSJ5rl; arc=fail smtp.client-ip=40.107.22.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBUoGIeZd8FK1KNpvs1s1KD++/WV1EKIQtJAZDJq6hhea8IVmMI5WfFtNAOgfOnhzacY7fPjC14BeqGhgF4Y3KGuGgM8BHp8hZAzjGvtYeDNRQJG4zjY9L1YrIUC5DG+ncyBvRJVLfkWB7wriLkYigHaYWIBE+ma5xdh+5wIBiLyZ5PEuzQfJZor2zbigbJjIjJVlXY+r18kH0oQBdl2PpXgiheRvsSrxl6NcJJ4LzE9pTUhlI+agv7+K5fQajrUHdz6e0TWHwZKQuhF3pXtzUfImlZ2WL02+oihZ5bkUSAPnmZdeJwR7Oifs4h5XXVghmgnHTj4zu/n9z6a9ou3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krRI5+Mu90wdFfA88HHzpPtWXB8COsoPZZBc5ulTkpM=;
 b=MG74PxC1bD6W3sKoMpa8ZoL7z3JiVVM50ZuDYBJInhcn7r7npFPl0+ktHSm/BqNngmFHBGii+qX3msoX72Ekd6buwaoSYELWFtl8jNvEk0AHBMnZ01DM3Vds4NnngpDoVok5TEZFVGwdm8FHIdlGrHy8FjPg7tFiJ2DzbjDfDd73sXL3l2s7FBmRtAJ07cuivmoV+Xk3hXChIKuCv2i6Gh+4MOSJKnxnH6aJzF35MMosPI96Dg8JnZGHFo9NdRfAu2Ohn7fbdyTIPTPwc4a88dN5/GhmUQuVelX4eEOXfqhIHqWUE0nHm0mJN28mqEzsNfDme1+seI20fO8JXNqSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krRI5+Mu90wdFfA88HHzpPtWXB8COsoPZZBc5ulTkpM=;
 b=fMDSJ5rlem5mi4fzkQNU5uprMngWDP7lj96O/mvfLen1CFuh/n3LSI16rzUlKbaqK3y3LW5PV4aSyNzPbyFXl/cCI9yM0Hzg39LXFIQrPXe/dW2xEsHJKgWGitDyBHrwPLEtadOoYczHiKpT9u3GPpsjJZJWULqQeHIYuRdluTps/w2MCjyZ79kP/rCt/+uiHyLttqWz6xkAzjISqlpNCXij4//++CFNAG4pSHe6c9Q13MqdmbxYfKZefcLf8bzzOr03pDWdlsn9inj/34u2T5Z8Jdp0AOcp45v/RTzQYO09djDinoJPgNu0CbO+GydXrSU7f3aOfx+drxvXtK5X7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 16:46:01 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 16:46:01 +0000
Message-ID: <41925799-563a-4aed-a2b8-e1fb67a948c0@theobroma-systems.com>
Date: Mon, 22 Apr 2024 18:45:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add dual-role usb3 hosts to
 rk3588 Tiger-Haikou
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240422163951.2604273-1-heiko@sntech.de>
 <20240422163951.2604273-4-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240422163951.2604273-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0032.eurprd08.prod.outlook.com
 (2603:10a6:803:104::45) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PAXPR04MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff62a5a-5480-43d9-f071-08dc62ebb124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkkySm03SHVKV005YWpITktMTWFwQnJ1RDJCQ1IyRlltYStZbWd2L1hVMWdZ?=
 =?utf-8?B?NnFQZ3g5YVR2clJ5Q0pUK2lKU0NpNVA0OXdUcGo2ZVhLWmJuL0lySzJRcm1P?=
 =?utf-8?B?RGM0Szd0MmhhMEZWWnZuMWcySVdoU25VS2hZajJXaGFBWlN3eHpCMTVvZEpy?=
 =?utf-8?B?WmFKZzBJdUppc0NZNkpCampHVUo5WFVxamxMWlMxVmpEVHNic1V4SjBicGtQ?=
 =?utf-8?B?aDRscGJYL0VrYk1Sei9SR0U0RloxRjBUSDJQcWlDYXErMStKb0UwNER2cHJP?=
 =?utf-8?B?eVJKWkJTSDFmLzJ0K2hpZERKQzZFUjlWRUpaQkprS2ExdW1uQkNodkFKUllk?=
 =?utf-8?B?MnRoTlE2UEZOM3RaQlBLem5MY1VUWWc1ckN0alVQTEJzSDF6VGlWVWk3RzY0?=
 =?utf-8?B?bE9YdjM1eFRzUzRpYmR1MzBLcEN3T3BIckYySXhNZnFzR21nRGZmOUt6TXNQ?=
 =?utf-8?B?VUVDNzJBaXM5bzhhZ3hld3VZNlhoaG43NEFRZHRJRTdxeE1mU1RVd3AwcXBo?=
 =?utf-8?B?R3RGK1FLeWNiRVB3RUgzOVpDSHBodHV4RittSHgyWVZoL1ZNWlVXR2VnQ2Mw?=
 =?utf-8?B?V1dEYkd5ZzRuK2pWTitSaHZ1ZW5YQU9OOVo1YUNHd1RraTBiQmFZOEw0dzR2?=
 =?utf-8?B?VVVPZ1F0ejVhU2xwS2FhcWhnNHJDamgwckNsS3JjWnRtWmtsT1lYcTl6a2ZJ?=
 =?utf-8?B?T08xdTBJTWtWcE5ldmhnOVp1bGkzSTU4SlRWNmZoTUcvd09uR0FFZExyMHlh?=
 =?utf-8?B?ZFFtVUJ6blcwdWpGZEVLUHkzVVdNWUQ3OEt0SDlHeWtLOVZkUy9GOEJmZTF1?=
 =?utf-8?B?MndpYjQwS1BuK0ZMeDdoc0sxRW5CMnVGVUROdlV3RS90Vm5LQWZ4Slc2MTNU?=
 =?utf-8?B?TGplMzhSN0lwUitydnRwZHZVaklZeW5qcWRBRDJHNWNNQjRDZDF6Ym9sSjRD?=
 =?utf-8?B?U1ptaFRzVFlhbFV3ZkQ4M2cvQW1WWUQxcFBKeFFSS1VtRWpUdVRUVVVSUGx2?=
 =?utf-8?B?c0EwS3BiWWk5MmlqL25mT3VjZjF6ak4xS1dCOXQzZG05WklOVlVVaW1jbE52?=
 =?utf-8?B?QWFLMmlUZGRDSUZ4YlgyRTlVMzRDMlMyQk04VmU1eElvVUNsY1hRV1BHZFBF?=
 =?utf-8?B?RHJuQnIvMWRzYnV0Y1lKR3VSNXFLVW5uK1FLbGQ1L0hUNDM3RmpqQzlXRUhx?=
 =?utf-8?B?dVRjeThwYWpsSmFvUWxoa2FCalJJdmpLVkpOcUE4ZnpJbmkydzAwdmVyTGxJ?=
 =?utf-8?B?ak5nZFl1Yjg5K0ZCUUJSczRsbzNMYUNvVEFPRjl6SjdkbjlvdE03K3JheXVS?=
 =?utf-8?B?MWhHR1VnZDFRdHJZR3hvQlpUUzkyazRYKy83c21TQzNJbDlEYzBaY2Y1bGNT?=
 =?utf-8?B?YUVzVSt5UmprSzJjMGtERHNoNm1kRzFFUUZjU1VEZm1yZzVib0U2dU9RNGJG?=
 =?utf-8?B?TGtZZTM4SUg0a2FMSGFYaXZpenI3ZjdEekZSejFSSXJXWmFXVjh1ZkJ6S1ps?=
 =?utf-8?B?K1YvOUlDaVQvVnJQcVJQbGt0OTNnanNqNGV0YytBcXhVL25OdEl0MFZpN0Np?=
 =?utf-8?B?WWVqeDBuc3JNa0srYWRjaUQ3cXFxZzVtL1F4d1ByUDRTN0s0QXM5TFZHU2RO?=
 =?utf-8?B?VjJIUE1yMGt3NjhMRzZkb0hmdzdvb3paaUMzRG5kR0lnOVNNTXovdjNkSXpx?=
 =?utf-8?B?Ynl2bVh5d2pSaXFTODJoRkRIeURydkE4RlBoaktUd05wb3AreDdONTh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckg4RVhlUFgwMytNcVFRbm5abGQ0VWphQ2prVDhMOFFQa1IxcFF2OVhTT3Jp?=
 =?utf-8?B?aWo5U25YWHU2clhoblJuMjcwRXNCNmRNalEzejFXaTNOVEdyM2JBNnRubnBI?=
 =?utf-8?B?YzF6SUhab3IwYWRVcWtKS3grL0YydjlraXlhaHFwRkhpK3EwMHIvb3dBaGEw?=
 =?utf-8?B?UzFwM29Ybk9WLzdUOVRwQmhTVG5OM2dqenhmQlpTeTBMTGdNbFhCNlB3RUl5?=
 =?utf-8?B?bE5TaFJCWVY2RDNYeTNseXRER2ZHOWR0K1RhVENqK0RsMllGRHRDdGl0enpa?=
 =?utf-8?B?enBGVXUwZjA3ZWlKRjRDM21VaGhvR050UWVjZk9nZnZKbVhWL21GRG1YN1hJ?=
 =?utf-8?B?NEhmM2Zwam55NklmQndFYlZNd3o2ZnhFVHpoWGtNOEltY25ObDNTeDNlQXZ3?=
 =?utf-8?B?RisybWUvK1BDTm9QUGF6Qk83eEdYM3VSNDdhUDZCUHYzSGhIY2lreVBjcHdq?=
 =?utf-8?B?c2RveDBkZnlCT2V0UFQzUFBoQWFCeTFheU8zYVlpSnhWSGZHTEpYbzBjMGJU?=
 =?utf-8?B?cE5oa2NudlMrbmVHWjhsOTBwNE5reGxFcjRFTHAxY3ROOXlnSFRiL0RMY0RO?=
 =?utf-8?B?L014ek5yUGZUVjZwZmd0NWJaZU0zNE1iRDc5QytZUXRqdlhiVVAxekFZS3J5?=
 =?utf-8?B?V3QvNFh2ckxnYTBHejc2OERkUWphczBsSVhMRk1zOVJrK0I5NFFZdkEvb2tO?=
 =?utf-8?B?enVXWDJ5SnRyczVNUjlibHF0cU5saFhTaWdjMW80cVRtNXZFWTFaMXg0SzV1?=
 =?utf-8?B?SzJLNERlSXlWcVgwZGV4SjJ5cjUvM0FqUGY5NGpVb3FVWlNFclV5RnFUeVp2?=
 =?utf-8?B?RHZ3dTFXdVhtSEhhdkJqTmh2ZU1QL09KUzJ2ODAvdU14Wk16S2J5NXJ6cEto?=
 =?utf-8?B?eUE0bEk4RVhXNXEyRGYrRHJuUTNOend4NUczT2ZZR3BwSjNUN3FsNkNrcHFO?=
 =?utf-8?B?ZE5nSmhlWTRPTm5aWng5YlkrS1lXS0k3MHNPU0kyUnl4UWI5cXk5VjhrTmx6?=
 =?utf-8?B?SlNXVUF2Q0FqT0YzZWZZR1ZlUUViT0RpWUNibGVsd0lSeG9adGtuTjduNk5q?=
 =?utf-8?B?Y3RFdXMxWmtmOXVPNk95RXMvbG1kWGtEdFZuRVJlM1pROWpETHg4ZEljcThu?=
 =?utf-8?B?OWRMR3VSY0wzcVdiMmNncDNYSkRucU1XN2dYWXJNQTJsSjhqb1ZGcDFPZHN5?=
 =?utf-8?B?OFVKL09zZjBVRGFaK2VpMDFRbDBXQ1Q2RW9YUVdQaCtSNXc1c1gra0c5RVNj?=
 =?utf-8?B?N2FLaFU2UEdsMlo5NTBqZ3BoRE84UFVFaG11bVJKc3VHL0RQeFd6Ly9UcnUv?=
 =?utf-8?B?LzlzRnZwejYwUEl0VkR4SjFiMVdUUE9ldXE0MHlhdzBYdFh0TFBzcmhnY0J2?=
 =?utf-8?B?dWEyeUl0S0NzYVNoY0ZOV0ZEQ2hnb1cySXpOR0xva090Uys0OVBlUU05cWV5?=
 =?utf-8?B?cGphL2RFY3FYaU9yd1pnTlRhQk0xczFIQkxrK0Z6aTNwM0pvYnpCcXlMaUM0?=
 =?utf-8?B?TndBc2Ntbjh6QmhVQ28wdTBMRDFIcXlMWXc5Z0V5em13cDZXRmpLU0plWHhi?=
 =?utf-8?B?MVp3UkxzR0RXaHNzRWFTbUswc0g3eU1VQmlSYUhReDVSc0h0YXpUUmlPa0ZN?=
 =?utf-8?B?REVwbFhEMnJTMmZWRm9HM0xKcm9CVmNvUm1BL25vM3gxNXhrMTVlbk8zTk5q?=
 =?utf-8?B?SGxJdk9abks1eXhlN2JwQU10dzBVdkJXOHR5dVVjbEE1K2NFcXRRc3FsT1lS?=
 =?utf-8?B?ODRlV2Q2Vk1HUEFtTisxQVl3b1liQ2g5UExUdUpnWDduV0grS1paelpzVUtO?=
 =?utf-8?B?Q1FtVmRsUkFISnJQNVVyUFgzWUdUTmlyQUhHUVJkVXhnNlU2azRpSk51NzNX?=
 =?utf-8?B?anNUenlJV3dXUHFxN0ZORmlheVgxL3JCWVVlbUpYVk9pKy9EZmxWM0ZhZ2k0?=
 =?utf-8?B?aVR1SkNmbzVOWUYzWnF0UFFISnRTTkp1Yk5mbStybXl5d29NK3krZ1AwODli?=
 =?utf-8?B?R09SZkdLZmpSMU1OcitxVWEzdXVsV0JlaXl4QS83dmI4TFlHM1IvZzl4ampH?=
 =?utf-8?B?d0lTbEVseE1KYUg4UjNkazlkdlZ5ZWwzYnR4SjNTT1kzMHdWQ0w2bWY2cjM1?=
 =?utf-8?B?SmozMEJ1NXlpTDVhY09mRmlFNXhJaFhlWXR6WGZxNE43OEtZVnY4SEZUZmlK?=
 =?utf-8?Q?jwE50wyUEswa9Wn8ZJLZlrM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff62a5a-5480-43d9-f071-08dc62ebb124
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 16:46:01.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3A9ksZIMryJXcVh+Dmn2RjmfS3tqByYsek0N6tq51FaFPeUUAriiMBhCxZ/M6sjJkhG01er1dRHw0cWG/pGlkSxnIW45TBCP42ckjVye3wLq2GDYaqCoMlIjYo4xjWBI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704

Hi Heiko,

On 4/22/24 18:39, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Apart from the host-only usb3 controller (host2) the rk3588 also provides
> two dual-role controllers. On the Tiger-Haikou combination these are
> connected to the lower usb3-host port in host-only mode and the micro-usb3
> port for dual-role operation.
> 
> Add the necessary controllers, phys to the Tiger-Haikou board and enable
> the usb-id extcon.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 58 +++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> index 2aa43e7430e5..52695b6c113a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> @@ -113,6 +113,16 @@ vcc5v0_baseboard: vcc5v0-baseboard-regulator {
>   		vin-supply = <&dc_12v>;
>   	};
>   
> +	vcc5v0_otg: vcc5v0-otg-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&otg_vbus_drv>;
> +		regulator-name = "vcc5v0_otg";
> +		regulator-always-on;
> +	};
> +
>   	vcc5v0_usb: vcc5v0-usb-regulator {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc5v0_usb";
> @@ -137,6 +147,10 @@ &combphy2_psu {
>   	status = "okay";
>   };
>   
> +&extcon_usb3 {
> +	status = "okay";
> +};
> +
>   &gmac0 {
>   	status = "okay";
>   };
> @@ -199,6 +213,13 @@ haikou_keys_pin: haikou-keys-pin {
>   				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
>   	};
> +
> +	usb2 {
> +		otg_vbus_drv: otg-vbus-drv {
> +			rockchip,pins =
> +			  <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>   };
>   
>   &sdmmc {
> @@ -214,6 +235,23 @@ &sdmmc {
>   	status = "okay";
>   };
>   
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	phy-supply = <&vcc5v0_otg>;
> +	status = "okay";
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	status = "okay";
> +};
> +
>   &u2phy2 {
>   	status = "okay";
>   };
> @@ -236,6 +274,13 @@ &uart2 {
>   
>   &uart5 {
>   	rts-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};
> +
> +&usbdp_phy1 {
>   	status = "okay";
>   };
>   
> @@ -249,6 +294,19 @@ &usb_host0_ohci {
>   	status = "okay";
>   };
>   
> +/* host0_xhci on Q7_USB_P1, usb3-otg port */
> +&usb_host0_xhci {
> +	dr_mode = "otg";
> +	extcon = <&extcon_usb3>;
> +	status = "okay";
> +};
> +
> +/* host1_xhci on Q7_USB_P0, lower usb3 port */
> +&usb_host1_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +

Sorry I didn't catch this earlier but the alphabetical order is not 
respected here, it should be after &usb_host1_ohci.

Cheers,
Quentin

