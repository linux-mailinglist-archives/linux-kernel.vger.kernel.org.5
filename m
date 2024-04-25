Return-Path: <linux-kernel+bounces-159137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC09F8B29CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA8E1C2096D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076D3155357;
	Thu, 25 Apr 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TsVNigJ3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259C1534E6;
	Thu, 25 Apr 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076907; cv=fail; b=oKQuCDizLcs4rqn9rsiOBFkJxbzpVfTvtwjHatKpf5j8k/LqdmN+4B1X+V/ILJgD4zhTxG6p4Itorj++3BuCoH2277TqCq+5nIAi+tdU9CuoGFjx5kuBB3Qth4A3WIQ/WXNDPNJ8Sycx5qGuobxtwNPT6/tMgCpJCFL4784OlMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076907; c=relaxed/simple;
	bh=jNTRHXjJnEdGhufXuLerJaeVUsI8kaOHecTkfzG2kmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cRtU01y7OICjZYKGtyCjRh+Wb3Jk+XhPEDt+vzr2CJeZuJPA5VriELzdare+hh1qyuJBaPX4Cnudx96M/oVfBFsuu0/2cg+EZescPb26wGShPkBst0eAkmnd0iajllswR3kqFm31y03VgkkANmfQfqGpYPn2c8hmYStd1f7Wj7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TsVNigJ3; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxG0eenKn3czvAP3X6YqAUIeQZNKk1OHQypOvHkGEHtZONyJOK87H17YLrsJIy2tYMsxtHtfjrfQfD0oPFDjFP2TmbAC7wIFRQ+uUvJRE+oDxzIGNQFYl0xWzhWr1FnFcrwsvlD8sPAXZiXsXkUfHQQGMsjQNAq70KV+4nwdReHD8U3psr+p1++VhG+WTu5YNAM2KSEOrLBnix9qa94u4MiV0oA4f2Pn5aMSzu1dJrstVu2K1U68NK3NDMeZdKZDKmwbdTMKAVNXNrJBkfSnxHm0SEgFFTemqnl/Mk6xCMNmmR8lx4+4n+cMy35aIq8wB5AgRM+AE3fTuLSjGn/vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4fj2Z/K5VheLW4IZXo9BmGVRDcAofXR1+mVHCK8PX4=;
 b=DNsWzL+WUbE/k8FZvNxVxSaj7ZpAT88ENC5vrz3PZtC7BRmwCInVXGiTigv3ONvsEcag/6UkbmrnVwu7rrwvU9Lb+4LWcQEtLXwguI91QfYViIOetaho0306u8OnA1LRUkDPRsYRDpC2QWtwZVaNP7LH0fmzksSAaoq9ILoFmDsmGqF9EGW3a6aX9BDh/mAf/wAoBXpPNced+VSVdjq+jbkjOrNV0fagBYGn3V0FjvBpQvetMwlpvkXms06Jou48Hsk9aTV+XY/PCPfJLt2myqqoXaz0y2nYdCmHfZ6REB2qgvQAURb+MEepBB92zSV1NOxzHbZK1bqmtebwExdV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4fj2Z/K5VheLW4IZXo9BmGVRDcAofXR1+mVHCK8PX4=;
 b=TsVNigJ34Q78tqzgJs/vprdOA5wqdtnizU1/muGHvAeO6pND5tDJUdRalGVpeqkBiXveXKN/myeQQ4DTXRmt4xTFjzS7SC4XSMZM3NQrpNgJgRvYA0lMZ4Lc9iBfS+JT+NJzQvrKbUi4PjhpBkUIA7dNi6sBkf8nYj+uxbeArXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:28:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 20:28:21 +0000
Message-ID: <ae6a5b66-86e9-44cd-8484-1d218e7bc72c@amd.com>
Date: Thu, 25 Apr 2024 15:28:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com,
 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
 <24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:8:2b::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0edb27-f8b1-40ad-6dad-08dc65663fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU8vVHlDUTk1dDJXWUZVSDhkelB5czBDaVVTVUxpS1o3R0VHVVk4eFdpSmZ6?=
 =?utf-8?B?TU5ZeXJuS2J3ejhabUZhbUJFeEtUUEM2Y0FqZm1ManovWjAvNHJZUlhUMlVr?=
 =?utf-8?B?OGFRZGpSS203YXBuVGh2emEraG1OZHRNYldrWHIvOFdGbHoxY29TcjRnNVNK?=
 =?utf-8?B?REk2TXNzYlhPTE5VcnhteDNRTGJORzhYV21PU0ovK09EaWEvMlBPTUFwb3Uy?=
 =?utf-8?B?S0p0SlhibkU0ejZja0NabHVtS2pQZW5yRUhNQ2pIZDlYZ0xITHN6KzgzcWZ1?=
 =?utf-8?B?TkhsWDYwcnA0SjVxaHFSTzFNM0xlR2JJKzBsMUZnblZMOGhKL0tGdkM4TTRS?=
 =?utf-8?B?eGN6S1A3MnNMRElhYXNDUFM3QjZKdEU5RTZxL0VQd09DczJXQzJLMnREVDR3?=
 =?utf-8?B?S0NLWTNKL1NKV3B3U0UyWGRCVE1idS9HZkV6STFLVjBvVm44bUJCVTU0Lzcx?=
 =?utf-8?B?ZDUraUpVTTBDY3NuNDhKWUxsN3ZkOXZ6U2xsTWZNc2E4RlJGelpnQkN0SlFD?=
 =?utf-8?B?SkpvazlvS3ozWkMvQWxzVy9PVFNsTTZ5K3hkd3BRYmhpMTFIaDBWeGtESEZk?=
 =?utf-8?B?bTgrVnV4Vkx2SHBrQjZiekRhU2pSNmF5OWgxTnpaZTdXY2hXRlAwODAyQ2NJ?=
 =?utf-8?B?akJBenJRNEpkaS82amJpdDZZTW95WllDWWd3TUFPZXhRcE9RaWtWSkFsZVVQ?=
 =?utf-8?B?WWVFZzgwYm5DZXdoSFJGWDFQYTJQTnBTVGJaTkJVU05PZHdFQS8rbEVlRDly?=
 =?utf-8?B?ZzNyMU01OW5Zai9CSk5xdDBWTU9GK0dHdy9MbCsycVAzNEc0NlN3NytuVi9Z?=
 =?utf-8?B?ZEdSQjFKKzJzaDZja2ovdlVVQWxWMktKZ09mZ3drOERlN2poZ1lkaWhvQ1BO?=
 =?utf-8?B?ZXpxZm80djhvZTVmRjhsYXdZRzZTbm5nUWtndDllSGNkRklpZS9FZWpNY3Fl?=
 =?utf-8?B?WjMvUDlteGMvdVNLVWVpWlJ5K1l1M0tnb1c1WU1RQjQ1a3BiVy9PeVkzWjk2?=
 =?utf-8?B?MStNNytiSElIVmVhUEJoalZidzg0QVJPOHlENUVldzRYZUtQTEI0VWFON2xa?=
 =?utf-8?B?aThzQjAyWXdOOVpuNVMxM0MvMlM5NGRDZ2J1K3RaK1NKRzlrTUN6cXhENksv?=
 =?utf-8?B?T2VacDh5MzA1b1FvdE5HWXR4ckJzb04yRENpSVFoSTAweS9lMHZyT3ZKdkEw?=
 =?utf-8?B?eUY4aVJjMDNqdkRIQzdNK0NETGJqYUZNTVJOMEZXWUo4M0pzdmxRbGptQXpI?=
 =?utf-8?B?M3U3UXd0bjJMUnhwd2JycHhkWWZlNUFBalY3RnJXZk85eGhlMnc0UnRRRWh6?=
 =?utf-8?B?RG43YXdkbjNkekZmZVY5VDJwbVZ5bWNHaHR0QzZCM2g2SnQrR1Z3OGhhYkhS?=
 =?utf-8?B?WnhLSnRXUnJ0T3VoYzZ1aHNnWncxYmg4cEloUnY1Q2FQd0loYzRUWnU4VGov?=
 =?utf-8?B?YWNmMHlvTERPNjZVdWFuL1NLODJ4ZGVoM1BleEh2UHVaQXNRZUFMR1FneThI?=
 =?utf-8?B?ZWZNU3RlbG53WlFSMkhBQkpmNDFEOFRBUmxwOVFZQlVETDFOMVNST05KTUtR?=
 =?utf-8?B?R0wvOFNzNjk3bnBFSjhvL1BvQUNRa0IrdXdLMkFteDNiY1Q4YU1RdHFKQVFh?=
 =?utf-8?B?RkdnZ2FsL1VSWHhaSU1nY1ZJVnE1Y0FRZkpwMXVDN2RmTm81NG5wYWdaRHlU?=
 =?utf-8?B?eFdoMDZ3eTJKRDUzM0dLWHJrU2NwVXgxN1B5QmFGUDladXRrcURRYnV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGE5U0hhSGFTTXFZS0I5Sk1DSkJhaEVhM2oydzNEb21tVnZKUFdRNE9KeE5q?=
 =?utf-8?B?ZXhNZmNObnUwZXByM216NExuN2M2S1pIcGdCUi9RU3VRSnFxYlBzSEZ5aXR0?=
 =?utf-8?B?QlJFcjN3aWcxZVF2dDJBRkM1MnZmb2phRnFCSXV5dEdXQW0yTFZrcW8waE5J?=
 =?utf-8?B?dDJYekVXL21NcUtLdmhKVGFaV1VHWXpwZGxlaUhrdTZlN3JseWhsTHNGMzZK?=
 =?utf-8?B?bUVoUi9kYTZCV0t2VGJvTXlpOExlZE9SSFVqZUhMc2x5Ti85N3JNZU5qRjls?=
 =?utf-8?B?T1A2cks3QjJYN1Q2OE11UWVKUnc2UkJRcDFhNXhteExIVVY2ckUwWStEcmc0?=
 =?utf-8?B?UEhCTkJlN3NLOUtyOXBjUXhncCtTek1oQ2hkNEZOVCsrTm8ycXBrNkJVbEg5?=
 =?utf-8?B?WXA4cHF6VUlRZ1Vka01qeFVibm0yRnVGUitHKzlOZnFRMklVTXhKbTQ2NGZP?=
 =?utf-8?B?Z2loOHE1eEN6YjJWUXE4VklzQnF2SUhDU2Q2Y280UXkrVG4vVk9RYkZvNXBX?=
 =?utf-8?B?MzV3TU5vSUV3QmY2WTdSZWNlM2VkRk1iUU40aXU4Y2J3UmJ6N2VIUFFZTVRR?=
 =?utf-8?B?M1NyZi94L3RONFhCWHMyRzhvL3hJblRhak5rZnpEV3p2cjN6Q2xRZnh4VEs1?=
 =?utf-8?B?d1JYY3FWN3ZXcks3bGVPL3ViV3BoMXFPQ21VQm1udFVPSjVDZmFxWDB0bnIz?=
 =?utf-8?B?QVpNZ0FIa1VIUEVVRmwzRUpSbldMUDNCTS80dWV5a2NHdWZUMytiMVBSbHFj?=
 =?utf-8?B?V1lkcDdGUVJ5ajE2VjZFZ0JWZmVYWWhubHdOdE9KNTRHZU83S3pxNnBkWTZh?=
 =?utf-8?B?YlhXaGo0d0ljV3FTaVlVY3E5aURsY1kwZC9vVkRja0RWVjNPOGdZQXJUZnJ1?=
 =?utf-8?B?TTkzTnRGWVA3M1JFS21mWnI0eUpjNGppWXMzMDBxQU11NWVmelZPYjBTLzVM?=
 =?utf-8?B?b3NyUHZGV3NKNWhwRUF3bGZvU3N0OHBZRG9TUHE5d0tEazNYeXpZa1R3UmJ3?=
 =?utf-8?B?NTdYYmFlOVpVeDMxUEhqSjRjMHBuUEp4WEh4NkZCaGE4YUFZWFNKa1lnVkRi?=
 =?utf-8?B?UVUrYTd4bUl6VC9OeFQ2c3JDeFhhOER6MlNxOVd5aC9MeVNMRzBSRVhPelpH?=
 =?utf-8?B?aXVZaklNdHVWS2VjV3RVSnZrMnNaa0JHZ2JobHVrZURUczFBNGNoaVpTQkpm?=
 =?utf-8?B?RXVVRHQ0VzVjS3J1VjNOc2RhU3hDbEVhM215TlRTdDBUYkNPeFlqVlRpWHVG?=
 =?utf-8?B?bkpPL1ZNeWhKZjBMY29GYTc5MWh1ZTcrZ2s1L1M5ZkJFQ0pUM3pDVkZHZC8y?=
 =?utf-8?B?TC9CRHl4NW9iTnV2T1pEZlNTZGJWZzA3K3F1Vk5XWS9tSnRCZkxmb1ZWbUdn?=
 =?utf-8?B?WFJ3RWlka0tEZldVSzNyT0ZWcUhCK3RXUG1YZHhORzlWbUhtdDJPS0ZIUG9H?=
 =?utf-8?B?UzgvY3l4UVVDZ3pGNENqMDdzWkxCK0VtcnVITnVyVVdQRmdLOUhnUk9oV21z?=
 =?utf-8?B?YjYxTlpXV2xSaUU3cFYvYzdwNzdmNlg1LzBudHRHKzh5OUZGRitWaGhIZmR1?=
 =?utf-8?B?VE1BZjEzUWxhTkNnV3FFUUFYWHNheXJPYVhwWS9MU1crSlNKckF4a3I5ZS9O?=
 =?utf-8?B?Unovck03bnJOYllZRVlpS0E0QUpoYkJGNzRBMHV0cEpOTzEvN0VMdjRnY0hC?=
 =?utf-8?B?YUhFTzM4VW1XQm9MMHZwcXhBZEY2Tks3V0NJMlhKYnhoMEFpNzdkYWUzZS8v?=
 =?utf-8?B?VEZKQkg5Uy9ZSlBMQUNCZ09BU1JZY1pGYy9IKytqWERMbVhteS9jZkc4S0JT?=
 =?utf-8?B?MnRmS05aWjNtZ1cvSjhwWWxmQjB5NXFSa0ordmgzQ291U0ROY0J1YVNsV1h0?=
 =?utf-8?B?c0NuSE5kWTJSZ0VlcmJNa3ZzMlBIR0xMNG1IVUFta3ErNzBGRldrNUlUUFQ1?=
 =?utf-8?B?aUlkcjBEcXkxSk5UQWRiQ2pvTUlnRTZ1WkY0WHpEVUExZDJuV0N6bG1OeUc2?=
 =?utf-8?B?YktweUVrMU9EMktVNGVFWXFJUzUwUWtXaFBIOFI1cG05MVFNOGx0WDJHTEU4?=
 =?utf-8?B?OWplRzZRUC9tT0MrYVpQcjZBQXdUYThncThMeWNuaVFnY2Fab1FIdVhhSTN4?=
 =?utf-8?Q?P16/3XagIZM/1kQeP8UijyzWC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0edb27-f8b1-40ad-6dad-08dc65663fd1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:28:21.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg0XsWMYrMIWdNPiP/Bzp10CDei1l4VUseq34XeFVY3DX3PaC3KU2/jsHsWe5JkdXQ+T8FuL8+4PzdNGg+dGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

On 4/25/2024 15:24, Lyndon Sanche wrote:
> On Thu, Apr 25, 2024, at 2:07 PM, Mario Limonciello wrote:
>> + Srinivas
>>
>> On 4/25/2024 12:27, Lyndon Sanche wrote:
>>> Some Dell laptops support configuration of preset
>>> fan modes through smbios tables.
>>>
>>> If the platform supports these fan modes, set up
>>> platform_profile to change these modes. If not
>>> supported, skip enabling platform_profile.
>>>
>>> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
>>> ---
>>
>> When you developed this was it using a Dell Intel or Dell AMD system?
>>
>> If it was an Intel system, did you test it with thermald installed and
>> active?
>>
>> I'm wondering how all this stuff jives with the stuff that thermald
>> does.  I don't know if they fight for any of the same "resources".
> 
> Thank you for your response.
> 
> I did my development and testing on a Dell Intel system. Specifically the XPS 15 9560 with i7-7700HQ.
> 
> I do have thermald running, though I admit I am not really aware of what exactly it does, besides being related to thermals in some way.
> 
> I normally set the thermal mode with Dell's smbios-thermal-ctl program. I am not too sure all the values that the bios configures on it's own depending on the provided mode, so I am not sure if thermald conflicts. But my understanding is that would be out of scope of this driver, since we are only telling the bios what we want at a high level.
> 
> Lyndon

Yeah it's not say it's a "new" conflict, it would just become a lot more 
prevalent since software like GNOME and KDE use power-profiles-daemon to 
manipulate the new power profile you're exporting from the driver.

If there really is no conflict, then great!
If there is a conflict then I was just wondering if there needs to be an 
easy way to turn on/off the profile support when thermald is in use.

