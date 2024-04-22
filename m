Return-Path: <linux-kernel+bounces-152999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E322B8AC748
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA39B210AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317F51021;
	Mon, 22 Apr 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="FHqMgf0I"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2117.outbound.protection.outlook.com [40.107.104.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A4179AA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775449; cv=fail; b=BM5l24N5y87we2X3vrG7GLiGfjCW1fROUbmGuWt9lFgVrIcxIjfE9IpOD+d74iDQArmNEFXZlkAEbAIkWXjDTpmr5WvaOHyCQkffk4QFs5xlGwNV2zaL4JCgeYEHi9K8t7rVEB3juQpdb9fXJ5UqUy3N1LR+WmqZBQaN5vy4VYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775449; c=relaxed/simple;
	bh=ssgdq2KOkv0cZR30cLDoRyPyTvlojejM9Mjr/+truZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQWS80sQdNcGhu3sz/6StA0KjcucZ22Z1RmJWlH5xrQtUseQATUjD1pYIm/j9ofi6K2/U5JncYggfraBjB6MoQHrRPPYAq9dA7LLWtHFsbG3GhXh2UeEPBzmTYhlMJr3rpk9VIOZCBwwPJRBXz2HtrdFgWbfgkbPcQIlHof9eNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=FHqMgf0I; arc=fail smtp.client-ip=40.107.104.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMYiBILWrYLqgX+1U6BNeyAbJ3Ompzl+4Vbec84+cVvhJGQvCA+Kttw5cJ0voN3lkcNHuV6WRIokDyOeJNJiofW2UljkWuAYv9bKRWSzqr2TCRO+vRCuwpdmK77paNxJBCTXjyS3zlYg96GrJO0eatd1g+Xd5JMriL5GZCg5yP0g7iJcL7GZmOKtyIWxwBnODbajH7tlbQNx+W/75Kf+A4vcjJMkJgc4ztqenIBubvtN3t1/jC6Q8m8y6wtPqn+Dr+Mjx6cIuxsEK9Oi1XaeMc5Mwi4d2rFNXKpHspAwhyQ8D2dvjSxfuRFsE41JYLhudFlkK+qd2djBMAmK8XWxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JJxpLHi6xi5viGHnYZVQgoQVgW1O6yWykSo0i9vutY=;
 b=bGunrq1NoRCRXiMRMO2nadGoSo3aTkA1bpocQoK7r0IdX2qS3bUPy9IIJw3HmLUDWsNPjP91bcB3oREc4rhTNxkwG3EFziBMaaWEHJHTIaNR+lcGeSU+bt4bUg1EVNez0rs8s+TtQm0Q3FfI3Ft23S327/D7TZL++0eTuzUa5VWPX9YS9uGjPqq+UbnWYgGKOB2GQNREBW6mdhys3ziygR5t3BuXh0z+OiYTvgHB+3HwSy+LC1beaztii4W+k1ldvVpFwqEeJb3F5c+llxHS1qxy8odrSHuUta318aycRh6GO9BGwrYu4p0ZDUCiPplIFhzzmQZfhDiyBQDtW2Tblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JJxpLHi6xi5viGHnYZVQgoQVgW1O6yWykSo0i9vutY=;
 b=FHqMgf0IS/THN3FEzP1FLzE+HGNZqitfyJQaAIU15+KcK8xf295aQmBf24T1WYULM/U6qK08fV7L9XeSC4KjJYE5SH5CXrYczBhYBIrZ9mrSVDHvoShFrfRPWwNYowcygORvnHyg+k5NPIEy2lbAd/02acVNZctUYxerpD43OCtiZpF8G3GXWNj63ncw6Hlr0YOf20rJlAvsUA7LJPpvdjAaSiYNFyMDhBkE4o6vwKMVnUG0RkUJK9oF1+zbaqSnsRqwpPX134Ifr+98wVWdMe3+0yP/g3/jk1HhRXTAstOmofBxhwMlE2sXbeQXORx5qfOz//pax7dKC7x6C8bYBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 08:44:04 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 08:44:04 +0000
Message-ID: <97e7c50c-9cfc-4139-8b25-0c1b5b8c9d01@theobroma-systems.com>
Date: Mon, 22 Apr 2024 10:44:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: move uart2 pinmux to dtsi on
 rk3588-tiger
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240419080303.2402184-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240419080303.2402184-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: e19feb4e-2bee-4af6-bfa6-08dc62a85d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnRGUVVxZ3J0a0VwZ2U2YzVuOHFUSTdTaytZOSs1VE1GUnFGZ1ZuUFFWbE5h?=
 =?utf-8?B?dzIzWURkOFhIZWV2WXV3UkZ3a2wza1V1c1k1d04rUU9yWEs2YnlHSi9YNDRh?=
 =?utf-8?B?U2tIVytGcmxXb09xTVZiSzJZSkg1ZXd4Z2kwQjhlRE9zSkxEdW9YS1czR21F?=
 =?utf-8?B?LzdIZmJQZ0hoWEdyM28rRW9oQUc2NFF4V3cwVzdIZHRkTjBEY0hjaWN4Tm5s?=
 =?utf-8?B?aTZFNFJkaTZycERJeWs4VkxpZ1JBclM5N3FCcytITm50YlBLa3JScVk3ZDd6?=
 =?utf-8?B?ZnpQeFZZOU9YTmNabk1pbUpIUlV5TER3Vk9sYzl3QWJuaEk5aHpRNEhNY2tD?=
 =?utf-8?B?Z0w4Z2J4WEd6UXU2ODI2RGZ1NDJmNXcyZGFlbUNwZTk0MmFDUE1iU0tsQ0Rs?=
 =?utf-8?B?Wmd2eis4VkRldTAxMWViWFYzRUpTcDVYeG8vMEM0WGxjMTJoQm4xV2RpL1My?=
 =?utf-8?B?SXo3K1k1Yml0VWt3SzgyZXhOaXkySUNaT1pLY3FXOHhTYWxseGExTDRXbTVT?=
 =?utf-8?B?Y0hNakZodnFQOCtmNGNnejJhaGU3Z29Wb2kyaGdmUHRUMXVKeXA5OVpmQ1pJ?=
 =?utf-8?B?UFJKOWpGVkROU0xxc05XNDUxdm45cXR0cnpGcHpISUlKRDdseUk4TDJUY2wv?=
 =?utf-8?B?eGFzTFJCN1BKeVZ5U2dxV2RNSjhOTzQzeDB5WlJIazVBRSsxb0dwWUkyam1i?=
 =?utf-8?B?ZitzY0FQd1hTdmM4akFLczd0aFNmbUZjM2FMY3NoSExRUlNLdWRtdXBtSTF3?=
 =?utf-8?B?L0ZVWElYRWNkcmNvdXFMKzRwdERXNStFVHBtdGhWNnoxZndYTDJVWE9aNGQw?=
 =?utf-8?B?RUpYalVWYjhOM1JoeWFGM0J2YklwM1pzclc0aWRkcWNFUHVTVWR6YkNVZnNQ?=
 =?utf-8?B?Z1N1S3daQUcrSTQ4OFA0TFkvK0NJSm9teVh1RWx3clFLM0VlaHZFVWp6NGdz?=
 =?utf-8?B?OU5UWUlMU0VEZE8zUWRna2h3TmRTOU5iR3E0SUp5VWhwQ2lMdFVSekhIaVh6?=
 =?utf-8?B?R1lUQmpEL3QzdGVxVjJ0OTdObG1zaFBVNjdhOVlRQW4vQ0ZEUHpVNUsrTDJt?=
 =?utf-8?B?T0hJMHVJRzViV1hVQmhuTkY5VFhtNGhCQlIxQnBOQUNwUkU5a2FGa21Wc0Nk?=
 =?utf-8?B?VWFESkxhYXJmNjZ1d0tQVE41T0lKcmZkcXcwL1R5OG85UEtoMXNzOWJEZWtO?=
 =?utf-8?B?am5raXdreGt0dWc2MjR2aGVRNkNRaVFsN0l4bERsK3lhcCthTHpsU0Q4b2tQ?=
 =?utf-8?B?ZnFJWnNLaEh6U3J3RVUwWFZSTU9ZODdJZ3diZW5PcjErb1p3QVM0Ly9QdWtG?=
 =?utf-8?B?SFEwQnR2Sy92ZFFwekQ0UEY5OW0zQllpSDZna2I0OGE2VXo2NGZtNTdMeXU2?=
 =?utf-8?B?cmVITjNtQ3VFL3pBcnZMK0toa0wvbHZiZnBKSnJJMElNcWNscHBIZzR3VklU?=
 =?utf-8?B?WFR6NkpCajJ2a21DWXQ0T1FyTE1HMGROVHRhcXVCTWVWN2xQclJLaVY2dHRL?=
 =?utf-8?B?eXBlMDZJV3FLUlFZczNDa0lsSGtzdnIwaWk5TmFaazRPRkJ4TGZNdm5BM1B1?=
 =?utf-8?B?cXh3bW9ZM1NLbEFWNmhjNEdBUHoycEhHVEJGeXBWS3FNdStSU3BvZFE5N2xr?=
 =?utf-8?B?UjFMYW9zTFZUemZkeDB1a0ozK04rVHRNRjV5cmxQUXhveS9uQ1RUUlQwbnZH?=
 =?utf-8?B?R2dvV1BwUXM2M2laWXcxa2UwQ1RzM1U1OWV2VEJRblp5dm5kZW9WU25nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW8rZkpZd3gxbHJsS0dCV1hqT3EyT0VHM3FMaWgrTlBxZXMxYjZuRjNub0sx?=
 =?utf-8?B?NjNxNm1nU2dVK1NYdDFwRUhKbk9VQURPb0t0T0F0TDkxT0ozdldoL1krNVRx?=
 =?utf-8?B?c2RjTXpZeSttZXNxNlh3bi9EenhwNTdzYldHZm9rbytpSHFzYmN5NlF0UFp4?=
 =?utf-8?B?M1ZFNm1uaW5nWi9pQlN5RTA2Y3ZmR2o5SHRncXdTRHphdERBUVdSbTEzeWJF?=
 =?utf-8?B?MmFMcE5FV0VLeWxua3dIa2wyTFZUR01Gb21yY1hrcXBKMVZ4aUdWK0ZSanB3?=
 =?utf-8?B?eXZMaU5XUEtGc1NRdk1HdjhPMGdCaUlXMDJxMVVsVkt5VUZoemx6WjRGL3ZN?=
 =?utf-8?B?dUY4QS9rVWlxdGtVZUlsdWwvaVZEMjYyTCs0dDRaZzBoMWFrVzUzSWFhSDhJ?=
 =?utf-8?B?c2wvQjVMSGg4M3JEQSs3Y1BuWDREenBlMk5CMG90R0ErUHd4cTIxc25wc1NC?=
 =?utf-8?B?SVdGLzIzb0JDbTI3dWRWVDUzV2dieUtoeER4Y2JCOGhaK0pIT0NGazRPVEZW?=
 =?utf-8?B?TDF1aC9nZlJIWVQ0aUJEZ1RlRHcvQ2FCc3laTmhxSHA0OXRoME9TVWNuZVY0?=
 =?utf-8?B?SVFTcnhuNEJkRzdDSmVNZzQ4QlZJdlp6c2prRVk4TEJmNktpZFZ3MmpMbW5k?=
 =?utf-8?B?MDhtQzc0T0pYc3lpN1FvdVBDYXh3QWYrT1htZ2R3RFdDeEowQTlscXZsOW53?=
 =?utf-8?B?N2tuZUJFSnNMN3A3ZUxzUXp6ZlZXWXlBczcvR3VTaWJWMkprakZuZEd6TWgz?=
 =?utf-8?B?YWxnZW04dkcxMzZ1MzYwV2ZmRitLcXhHbmpxd1ZjU3c1S0RGRUhGUERuVS9z?=
 =?utf-8?B?ckNhRHl6NlB6a3kzN2doelV1RUFQN3NQTCtZb2k1bU9KVDVSenlwSDVIWmxk?=
 =?utf-8?B?cmdYQkdwWG5rMGdjeFlzbmsvcVZBQlBnMlBmdjZJWGowYmJaYWhKUmViUk84?=
 =?utf-8?B?aGxtRTd0L2tPTEs4cWVEVXZoUjQxRlcyVHFnQzVmNE1nQ0FhbFo4M1FDd0Ru?=
 =?utf-8?B?bVdZTUJqMnZCQWMvS0txS0VWQThGMlcyWlhHdWdQM1dQM2NZNlRyNW1Gbk50?=
 =?utf-8?B?S2tHLzNBQStLVWhSejIxRkxkelFSUTRGNS9lRk9VUWROazE5YVoxNE9PMk5R?=
 =?utf-8?B?LzVicG16UHgvTFYzYkJaSXlleHJrMWs0Z3BYQnhESFRSK1VoZ3RmVVlodFdI?=
 =?utf-8?B?eTIyb1d1ZFlDZjZLYWFUMFBIOXBQSXlXeDRoWnZnaFpCVVgrVU5vU3RQdXd5?=
 =?utf-8?B?TWx5SVp3K1E2UHNESk5PRWRrZTNaNlkrcTA5MkdoOVBQNDVHMlRudTRGd2xG?=
 =?utf-8?B?NHlPeVZ2YU1UWERqRkl1RFpQckltMTN5WEVlZ0VtKy9EVzRLZ0VDVVB0YVVn?=
 =?utf-8?B?ZDZ2ejd5K2dGZTBHTkJpNE1wQnEzSWNGVmpYZ3Zydml5aWczc21nWUw4bFhB?=
 =?utf-8?B?dmRpQVRHMHFpOERINnJlNmJPUVdUcGNFdjVUamFUVmhMTnNSWGkzNk9JM0Jh?=
 =?utf-8?B?T2hoeUNZSi9JZ3oxQTZGR1NGeUxVR0xmVjRaaFRndVlxU1BHbjRBS0t3NHkz?=
 =?utf-8?B?N0VTcUFsazJHdzN6dHU5Qm5XeTU3THJFRHZxVG5vLzkrUUZUTER6RHhzQ3RU?=
 =?utf-8?B?Skpzb09ScUxlYUZiTEhGQXh2bmlRZ1pkbTZ6MEFiY3FzUmNIQnFadUF5UFU2?=
 =?utf-8?B?N2ZDMjlNUnZoOXRZNTRGbEdvK0tPZGtXRENOcTM1VXNWM1huL2Vwa1FQRytR?=
 =?utf-8?B?dHV4TXZ5TUwxOUxnMC81b050S1FCOE4zTTdPSlh4dEc4SVNwVkVBOHZzemxK?=
 =?utf-8?B?cGVnbkZOVlk1aEFDVDlCUjExbkwxQnV0MGQyNk5sY0ZGWks2L2RsQWx0ejdB?=
 =?utf-8?B?dERXMGFTUnU1aktkb1cwb0krVUYydGZWVk5PMDRYTEwvbSszWDlYc0RMTWpC?=
 =?utf-8?B?TjNOQXNlT1ljTTVPR1hNVU1JTmt1M2FLeklPOEZmMHN3WndMOERLcW5wREF6?=
 =?utf-8?B?WUJjODVXQ0tqZ3czNHVVSW9heWxGVXJpNFlRL0tFL2RqRkFOSEkrZnJKcjlR?=
 =?utf-8?B?bk1EaVlNMGIzZ043a0NkZ0dOUXFZRWtoMnNOTHAzcVJkc0Y4a3d3anJveDRW?=
 =?utf-8?B?V041VVhBQ2pnWHMzOXREYUw1MVkyUU1NaGRxb1Zsc2VzZkd5NE9IWXp5VTRU?=
 =?utf-8?Q?rmiLls/kTlHA69F+GC5SDVk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19feb4e-2bee-4af6-bfa6-08dc62a85d7c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 08:44:04.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEw0slN7oIul+yx5gyc5ep43QMwQTPQn2Wc3OUP7cwMMvCsrqK6zLTsSwH/FmQsACvUIyyWd8avtlNYFVgYwfiQm+7+3SzX1/ElZySgF4SZZYwpw07W+KZBJW0HZMeQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

Hi Heiko,

On 4/19/24 10:03, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The association of uart2 to the q7-uart pins is part of the module
> itself and not the baseboard used. Therefore move the pinctrl over
> to the tiger dtsi.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Could have squeezed in a comment to state that this UART is the UART0 
signals on Q7 because I often have to reopen the schematics/carrierboard 
DTS to remember which uart controller of which SoM is used for the debug 
console :)

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin

