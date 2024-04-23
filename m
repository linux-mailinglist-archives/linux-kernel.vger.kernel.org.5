Return-Path: <linux-kernel+bounces-155528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2318AF392
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134F1282149
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5E13D28F;
	Tue, 23 Apr 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LG242+V3"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACF013CA98;
	Tue, 23 Apr 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888666; cv=fail; b=NocTYFIgoLKtElQVTBXDOuFcMNoX8F6OCEJ/cW0JrqUyEpWDjaijQbKU8WO44tda2wBc4naLuAee4jTcooC2h0mwBUaSQvKt9JG229F1W6pcItLJzegP6toBVyqfD75Sg1eaks0D7FQpLb2rxa9MDarTUik9lGpJd7Zmcl06x9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888666; c=relaxed/simple;
	bh=SH8gqL1IshhUdHpUiD+cG10Bmnm65HxGpizVSzdkiZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qpzlbZRr5xxk7dOHTTkMRZv4ej6qIaeVLo87/A5fuzJtj6kUSZGmwoHfll2+0l6nSSYJagiup/xTFZKqT8wmYzbcvog3HHIHdDedyFcBhqiIlYI+1wX4njH1e8Qozz7YABKCJ/5uztBwKFg3UBvTgeTvXyd9ClxaiTHJWnGGPIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LG242+V3; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTjtlFhDMasfvfvd0dTu5ISQCubja4YyAog/i3h8GA8in2JjQ7G/eXfqtJboUHC9uqeEHmV3zlbcFFur0KvkX35+Lzq/28ACFDrW3fe0GkSox1rqu8LVuWa/rbOzDXgyKS4K3/Asf2GGAf5cR0p7vwaABtfIIb4vYjVfs8Rx2/Rq+K6jsD/MzTHeqseF6yVpy0+frhMMJxMAtY4l/OMlgMaWdsp6nYUG5JlOQHvVzSZQ58UBnwhTakvBPqOEPQ7ikgNdh3ehcHQU+ANlZ8I2UHgcQWxbO3uqQCREOWG4eBe21alFVjTjqnqRJ4YOxw7NHudSFIAOcm68L/xu3WxBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVi5oZpBCSG2AXOOum14VLohiEXNmSdizRF0q6cltAY=;
 b=UXq5Hw0B7fUKuvSzHA1HTzUWzoN2jpCsjx1qXU5MUd4vcmHfnogXpRmDa4xL9XjlQiuMYdJiyBJYN6pO7p+fk+KBBhTmOHACJFJpvje+OJY5ozvoOGYcLp51TI2D5VK/BqSBfGeKyC2R7qRCKUxP6ops6Vu38//8Lc0Obnm3tktElENVwkTahuhLLko4wDO+a/BEnAkeI/huto/7FzbT9DTBaluA3ciyoCu6j3xSDpf/I3XhuO3f8Uhpl1EIrdkbdANFVyF1rHD39yU3MLfJg/POQW9CBEyQwcI193hn2it2ZC8m9qBrwZVqdXCX/YxOUUcfFCPpDw95c2gigWGMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVi5oZpBCSG2AXOOum14VLohiEXNmSdizRF0q6cltAY=;
 b=LG242+V3qD0OSBwIKLQR0vgSxw1Q7a43QpoMH5U+8KDsJOo6XUooZJfAsjLKdbMTsN2i3Kym4ZhYpG2klgfWZASm3bQ8v77lQVNbcZR2UlZFAZLOCWDSWg0kgZRDZAmWfgb7XL8G+WAjUgdApUiUucSum6+jRLTRHQZRWh74CmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 16:10:58 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:10:58 +0000
Message-ID: <d36d68dc-a420-43c5-a633-3eb507b6c3dd@amd.com>
Date: Tue, 23 Apr 2024 11:10:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/MAINTAINERS: Update my email address
Content-Language: en-US
To: Akira Yokosawa <akiyks@gmail.com>
Cc: "Naik, Avadhut" <Avadhut.Naik@amd.com>, "bilbao@vt.edu" <bilbao@vt.edu>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>
References: <109e7532-6265-4476-93ea-34fb0b209691@amd.com>
 <b1078bb2-bea1-4b32-9b4b-4c62e02e3ef4@gmail.com>
From: "Bilbao, Carlos" <carlos.bilbao@amd.com>
In-Reply-To: <b1078bb2-bea1-4b32-9b4b-4c62e02e3ef4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:806:20::20) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0b9337-8f02-4456-37fe-08dc63aff684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWVlbjlzY1daWTk0OFVKbzRpUnE2d1UwVlI5R2xKeWQwcWFLbUtWbGwyNCt6?=
 =?utf-8?B?THZWVWM0Z1BzakZNWHNGQUhmZUxLaGNSb0QvbHZvcVZ2SnNiWlRLZW9qQ095?=
 =?utf-8?B?dWxONjNON3FXZVRzYkF3dWNwZnczZDB0aHZOemU3VkUvTTRBQlV4NGxSMmds?=
 =?utf-8?B?MnlpdUNqelFJWFpndzFiRXUrSDZ0MlFKY2p1WnI2UU5FMVNjK1c3TGRKeGd6?=
 =?utf-8?B?azRKM2JTMEd4MjBLa3NObWhzVGg3MVRURVFPbUkyeE5XYnhocHduNm9hOW4w?=
 =?utf-8?B?NXNDTzRKcDhWWnkxYWJ5U3h4Rmd6M0FoTXZYRTVkRmxncHo4UjN2d3Nkencx?=
 =?utf-8?B?R2dTNU02YzI0czZGU2VpU2xPR1FVWjRZdm1vV1pYMm9XT2RYSnBZZUJuRHdp?=
 =?utf-8?B?dzdJYmdxTTREaVRST2NRQzUxR0pvVG9tUmJrQ2E3VGNPb0dqTGtwM3l1bDht?=
 =?utf-8?B?cysvV3daS3ZPQ0VDZG9OMWhIcEtCSHdEUmxVTzRpZk9hYlVjZmg1NHgzcVZP?=
 =?utf-8?B?ayt2OWdjc1N2MFdQZWVuQzY5TGtSYzVGNHNZcldFTk1pRHZrcHVKWklVUEtn?=
 =?utf-8?B?WHBuQllCRStadEdzcG9QeU9SbHpKS1VlS2F4L3dDWmgzQlZ4aVNiWS93emtk?=
 =?utf-8?B?SjFxM1h4MDB1VUlYUXhESmtpSHhjOWM0enJSS1hRYUM0MlhkREw4Ulc3NlBC?=
 =?utf-8?B?WWxDVFl2WTJBYm9VRGwwSjg3bDF3YnJxRjlXci83bUQrSEpvRzZRL0NDKzFL?=
 =?utf-8?B?T0RKSHpWM3cwenlXczlVdDZvNng4OHorOUlORE9rVDU1dmlpbXdSNmVnN0pv?=
 =?utf-8?B?bDd4YXZqQ0g1WllBNEl2TU5MUVJxZnZQMEszUXVsZWVCbFF0cXlMS1pRd3hE?=
 =?utf-8?B?NjJxWG9ESGg3MGVxVVRudlBzWDFWQUhDcFNmVDgrWVhRUVlwMG5Qc3dwSzY1?=
 =?utf-8?B?TVVyeDZxWUpJVytOL3ZSQ0dRY05VU0IvWDJEU0ZZclFERFh1YVhTMmNUQ3pC?=
 =?utf-8?B?N1dIYUhxSTYzeVRWeW5kK0ZCcHU0d0ovT3g5eW13b2FiLzdlSUwxcnRCMlVt?=
 =?utf-8?B?RGpQb0d0dFQrbFpZdFJBL2Zud2N6bFpUOCt3aHdTQ2IxYjlzQ2dXWUhidUIy?=
 =?utf-8?B?bXBvbksxT0RaeVplK2lMU2d5WGlPU1lpbjlRZEtEMXorOHZFT1l6S2RxQ3Na?=
 =?utf-8?B?UXRpaVNRbzZraU8yZVB2YjU2a2JQenVRNGpBL1ZhMzVHdjNibmNrMHZqYWlm?=
 =?utf-8?B?ell3T1JaZGdCTTRrRmVVSU4vOG55VnNXejZETk9ZODlMUFZidUFoOVUrUzJl?=
 =?utf-8?B?RjFZcjlHaTFvMHRpUUp2ajdIY2dtUm1rWXc2NFQxR2RJL0NEZmw1RDVvYi9o?=
 =?utf-8?B?SVBENSsvZXdkMHlsdUdHdUFGNkhYWWhnV3plQ2MrWWxSVW0xSHcxM0NQNnpq?=
 =?utf-8?B?QkVoVUZkL1VVMWlheld5VXFGTVAxK0xyZDgwWlE1VTVYaFpPRlVKV0tUelpC?=
 =?utf-8?B?UE52eERqTTIvT3lWL2NpNFFGY3FjTjcxbVhCb3JTTFZEQnJWWmV4SFdvVXVo?=
 =?utf-8?B?NlYwOXFXZVBOeDJJcHJndzZ0RmNmS1huWGdURWNhdWtpenBXWmpVYlgwSkVL?=
 =?utf-8?Q?Fpsqgvm4pb6uXxGEm8hklepa7+j2aPhduay/pnljVtG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpuZ2tITkw4YlltUFNCYkZQZmdnM3E3WmplV040dndDQ2lQNC90MU1tVEZU?=
 =?utf-8?B?cVpqQVNvVFQ2R1FtWkhDS0pIOS9Ecng4TjhIV01lMkN2V3A4aHVoY3Uva0Ny?=
 =?utf-8?B?ZVdtTVdmcmpoSk14NzllNWlYbndvMGZBemhKNDNjZWFvSjhqVm1oc0w3YUVn?=
 =?utf-8?B?WHpWOGcvMGhxaXhTQWxsQUR3ZFdZbFd6NFJzY29na1JYVE9NNzFZQXlOeDRP?=
 =?utf-8?B?VUgycHR0QVFMZlR0OUNrTG0vYmk4MThZSTViS2RZVkxvQWJxYlN1QlNGT25l?=
 =?utf-8?B?RDhsaHAzZGtKTWg3UkI0MHF5d0RjK2phKzF6aCtraVROME16d1dwcEZIcVFq?=
 =?utf-8?B?djRUQXdNVUJaekhYZXFNU2F3WU00NldUR3lkZW4yckthUkZhRGEvNnZIcExQ?=
 =?utf-8?B?SWtUVkVUVFVQS3E5dkhoWTBrczhTNVlTbEZjalNlYzA1NkFhclR0YVBMMEVV?=
 =?utf-8?B?M0l4RXlnbHVUWEhVeWJsUVZMMUUxTkVqRThQYloxc016YXdZK3lMRitXS2sr?=
 =?utf-8?B?NlpJdjU4TitTRXhIbldSTXFHOTl1b0JqZ1V3MXpaVnpuSW1uS0VMSjYxYzNT?=
 =?utf-8?B?SUg5WGZ5OG1NcUZLcnpEejAwY3NoRnVDbTJLbHJ4QjFVNmg1QUhvU254NGhH?=
 =?utf-8?B?dWJLQjEzWVJlNVhER29qbDU5UWttSlB4ZG5oMVZNVzR3RDZMZFVFK052bWJh?=
 =?utf-8?B?NytsbllWdEdvUzJPeDk4MEhaeFVPbmErU000VitUbTJHQUIwL3k1VHlPR25P?=
 =?utf-8?B?WXIrN095YTZ2OXdrZzYrcUlWVjJoQy9GZE5POEZBZ2dYZUhvakk2QjFxMEJO?=
 =?utf-8?B?Q1VPZThkQWErVzdEcGdXQTlvdkxGb05Qc1JrNmZuV1lSakg1VnorM1JKNytp?=
 =?utf-8?B?bzVYdWFxREwrSzhXd3h1bjR3YUlqeVpkK0hVSFpKTklJM3NyZTBWSGdoT1Yy?=
 =?utf-8?B?NDA0ZW9TeTlFaks0U0NnVHFzbVY0UzBXclJRRUl4T093ZVIrbjUyby80SWpt?=
 =?utf-8?B?WlhYeGNQK2hhMWwrQ1haWmhLZWFDNHA1NHJ4dGtnQURsTkZaZVVUamt3aFpY?=
 =?utf-8?B?VnBtc3RGTlNNZG1xdVBsM2FrVGFhWkpGbFlJK3k3N29XMk12emxOWHB3bnBF?=
 =?utf-8?B?amh5OFArYnFoVTFpVE5kNUdtQ0dhYms4U0ZJSlpEV0VRTURGZU1nZUZHSVIr?=
 =?utf-8?B?cW1FSFJDVXlaU1ZtSjMwSlVIbXVYQ3JTb2ZGL2lKSU1tZjM4dEkzaTJEMUxX?=
 =?utf-8?B?dG9mc3oyTjVSTE50OHRTb29DQnROQlhyalhaQWtoMzVMTXViQW1ONkxRT1NW?=
 =?utf-8?B?VHE5ZG1uY0RNeFM1Yjd6ZytWWW1sK3VlSjdRQ0Z3MEdDSXVDMTdVZ3JIUmU0?=
 =?utf-8?B?S1BhSFkxdjRqREVGRXhlQngvWmpSRk93Y0dTYkMzcldNN3hPak04NVdDUDJk?=
 =?utf-8?B?SVlZTHRVTEwrRllXTnZIaFJBQ3dSRkd2WGRKMW1ZZVNIMDdGN3BvaTBIbWhl?=
 =?utf-8?B?dnRiUk5TNWg0ZGF4c0g4dkszbExjb2huQ25FSnBIeG9QTzVQVmhnN0J3dTQw?=
 =?utf-8?B?YlM5aks1dnNmR3VyVFJieU5ZSFNZSkRVWE53aDd4Sytjc1NZUFhoNHk3TlJO?=
 =?utf-8?B?ZHdvaTVvMkM1MTZLV05MejUyUG15dU1CbzE2SUpnUHhvUytqU3RYVHZJQ2hB?=
 =?utf-8?B?c0ROaXpvTEd0ejhxY2hhenkyODFKOG5TdVVXTVYwUkRvWkxxTHhHTCtrN2tF?=
 =?utf-8?B?NG1WbitJRlcveWlUc0VyVGVwZ3VucVVuUmRVRWtNeENCN0dod29SK2xRQlVS?=
 =?utf-8?B?TExmODJ6YjJIdjFud2RUMVBweUtPOXJrSE9RRkxSb09GclFDRDFOdnV0TEh4?=
 =?utf-8?B?N0s3c2R6dURVM0pCTWJoUHNsd3NUZFRtRnlsV3Rod3dYVFhwUnM1ZlJWT1V4?=
 =?utf-8?B?ekNiL1pFVnVEdEE5VmFydWhVanNRQUNhOFo1VnU4b3cvWFNhR0Y0cnhBRllw?=
 =?utf-8?B?NGdoMndXakUxa3RHdElLd0R0eTdhY3FYYWkyME1Hc3FsS1lMV2NyZHJSd1hL?=
 =?utf-8?B?SFg1Vjg3aUJUcU01bXB5dTJUblNiVFFEN1h5c3pVeE12M0w5cjhvRjFlUTNU?=
 =?utf-8?Q?R1KCZRibykSk2wlBW5+Y7+Zkm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0b9337-8f02-4456-37fe-08dc63aff684
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:10:58.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUre7ZcpLPHr9zv+nK2ZcksSS76B+OWmgvK4GGgXYbJUgFUcGIvDKq4fbEwLeWPsU4S9MQRF4W9iWBAZxKDDlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

Hello Akira,

On 4/23/2024 10:59 AM, Akira Yokosawa wrote:
> Hi Carlos,
> 
> On Tue, 23 Apr 2024 10:19:14 -0500, Carlos Bilbao wrote:
>> In the near future, I will not have access to the email address I used as
>> maintainer of a number of things, mostly in the documentation. Update that
>> address to my personal email address (see Link) so I can continue
>> contributing and update .mailmap.
>>
>> Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>
>> Changes since v1:
>> - Update .mailmap
>>
>> ---
>>  .mailmap                                                  | 1 +
> [...]
> 
>>
>> diff --git a/.mailmap b/.mailmap
>> index 1eb607efcc6e..4bac5578426a 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -113,6 +113,7 @@ Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
>>  Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
>>  Can Guo <quic_cang@quicinc.com> <cang@codeaurora.org>
>>  Carl Huang <quic_cjhuang@quicinc.com> <cjhuang@codeaurora.org>
>> +Carlos Bilbao <carlos.bilbao@amd.com> <carlos.bilbao.osdev@gmail.com>
> 
> I'm afraid this won't do what you'd expect.
> Entries in .mailmap should look like:
> 
>   Full Name <new address> <old address>
> 
> See gitmailmap(5) and git-check-mailmap(1) for further info.

I find it interesting that <new-email> <old-email> (as opposed to
<old-email> <new-email>) feels counterintuitive to me. Thanks for catching
this, Akira. I'm sending v3 right away.

> 
> HTH, Akira
> 
> 

Best,
Carlos

