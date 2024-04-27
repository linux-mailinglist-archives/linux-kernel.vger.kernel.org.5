Return-Path: <linux-kernel+bounces-161135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6C8B477E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071371C20C62
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836573BB3D;
	Sat, 27 Apr 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iI9sqUeF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4A282ED
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714245094; cv=fail; b=HldWsiwFEbfL7jLC8Ueyf8//P8z/ACPR/cdCU6eb12PvOtmzr+b/mGJV6Ur2oGugDYRGRtrPULD02fFPiif2zSVAkOFSwo+owBmwf5kiO/1FdEkFd5990FzCGfDISrFMdwBpG0HLG61RoxvUjl0T+ik/5KNTX/2OF9hjiXYxrOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714245094; c=relaxed/simple;
	bh=Zu8yWqIlRBcYlQ6BbzkaGoKXhy+dGlaSkS81Cacr8co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7pP4AvyYUsWwo92R70FQovrLkEdGZkjasXXJx/0t1pmk7EXwxwH6lUsqQhoLkC1kZkijcm7SNA2jAo1PVSr6MsL4uL251kPEZDaNeq8YLyxZnMhSyrvQdCBGfRc/dR8Sj2wSjewkagZ7QYr4ifVuTCEy4rC6PeYWLX4ZeaFNPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iI9sqUeF; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX/KTG46DvhrdJdgcAEeB48t4DKXq2qbYLf7nVtqm6Z0lrkAC9wAe/OZSKPH9yGEDpEFpNkRa9ykl3YwRf6w5vvmGg48sBdoH6JqkjtRQvTRXsisMI1O8gYET/eoo+88Q94UqEtAlVSHjK/wQV0BWd+AyX1G2ecQRqdZOwg3aCp1kZholI0/Oo2S0+VgQYZbImpFNuWYSm086cNRbkrlYaZ1a1Uim6xpEN6535qc3L32JHAwmYaTPaZyiXh6i70k90b5u68xhzRI8jPSG0dDQsb99wph2+N7laKMLtbEX6L1cCShXoY06VN+n1CI/1DcCyBJxgdUlUfSVKAlW8BGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zILIzSJ3oYOfqS+zcZOcB+Gt0JhfkUTyUqIJChyfANE=;
 b=LJwCiwbqeZEv4iLTvrsHEpXPZGasZ98gLIAzW/TCWAkOAXqpkkWdJZpBiZXSVzR+0hZ3xxE7PEJtOW/3FaM1tf31vx1r9EfEW5KlDpOJQ1wSO5hCSAl+/h0r1gKSntyUxmsOOjgXSShO9NR8qwRiHlRkIaQr16AyU0qdNZA99B+exoVhla3SY+eAjHHVQBvZ1R7kEfYm9KHw8Z/ThBVug6E9e/msJBj33RiXqsP/Wiek59JRPvTG9gCm5ck0vBNVdtgTL7XeGfaGxU4OBbLoS8K2oXDTNaUOH7EkOrd7xEn9WU2r25Hek+W0yDGVFcqv4LMBY/VM7D07xoUbNYAXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zILIzSJ3oYOfqS+zcZOcB+Gt0JhfkUTyUqIJChyfANE=;
 b=iI9sqUeFQkHceDjBy7Ek0I5mN4z0Xbhn7IBB0o1NhqRQ0TGG+azA+iozdNo0ciJDAwP+zo9qjHfDnWmEIBXperOt7HcrgS6vLK3FwAz1MWP5LR6HooOxh6BT7uWxiwuZ++fnTo3W0G/XXPDzt3Bq822OMVuRcIyindVwgz/+M/HuofJUdcuEzBRiBFMG0aflSdHWqyFm8bwmm1JHoHnLkeHmY+hCLlpOBHMd9ytaCT6DL2zwB7A08QNXnMRc2f5Ad1S6FbYYwToORr8dqXwZnmvWW0WU2ydaehdOTK/vU2bOq3+TEs5ShKEUBXrdWaAsYlolxqGIn7OXaXQQbHw9DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Sat, 27 Apr
 2024 19:11:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%7]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 19:11:27 +0000
Message-ID: <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
Date: Sat, 27 Apr 2024 12:11:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
To: Zi Yan <ziy@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dee060-1dbe-4794-a841-08dc66edd655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlF5QXJPb25zK2FzUHQxRnRROWZ3VkxySXlIM01STGo1N0txZXBWdjl4czVB?=
 =?utf-8?B?RnpuaERMb2lXbGhpbUU3ajBPYzdVcXJUazlOWFNmSyt6ZHQrSHFhYVY1UEsw?=
 =?utf-8?B?S3EvVEVqeG1jSXhWOUwrc1ZyeTRWWWNMOGVWbFNHbjZBTGxsbXRwbXRQQUZi?=
 =?utf-8?B?T294czJ6dHR1blU4aGxSaC9lOThVdkE5b3ZoSVFFYUZMcVVnaUZ3ZnZwQ0Vn?=
 =?utf-8?B?ZzQ1SHYxRFIxajRuNDRtUTZmVW9CaTdUS05aUm1JWnBibDY4WU9qc003OU5m?=
 =?utf-8?B?L1dWZEE1UmxscGlabGhycWV3engzOSt3OXhHK2ZpSVcxYmppVGJDQUxuZlBM?=
 =?utf-8?B?WmVSZkQxZXZhbnVNRzBMTzI3c0Z0SFVobDZENXRsZGJiNDFjSjFBWTV3Und1?=
 =?utf-8?B?VnV4KzZIV29pWFFlR0hHUFI2NG8zcmt2TGhML1NBR2FDN1kzeUFIZWZ5eHlN?=
 =?utf-8?B?cXRoYjBvNUs2TndVNm53ZnZFT1p1M0R0WEFyQUo4ZGFDWjZVU3puWXlEZFVu?=
 =?utf-8?B?KzRUQmpCMk9FOXVKVldUSVlvNjFDK3dlQnVDVXZGZ0t3OWZZaG1DL1k3Tzhk?=
 =?utf-8?B?NXVxdVo3OHZsV2o2MGd0U3dmenF4K01qMWFWVGpsZDl6amhCUTFFR3hLeGcv?=
 =?utf-8?B?VlVuRTFsR0dSK3AvNmY4T3pPb1JTV3RTOHNPYTFMKzhQL2hiZGhJTHFoUXFz?=
 =?utf-8?B?UmZyK0FKNkd2aFJSa3QrcmR1bHpwMDdjWUgzempKdHlCZXRoS0NzcndWcW1G?=
 =?utf-8?B?TUVjREcvMjl5VkR2VzZvUE5QYTdPWW5rZi9JK0xOd24zNWI2c2p4TGNpM28z?=
 =?utf-8?B?R2U1SGlnTXNpOWU4YzVjRGVZUENMQ0ZHdVQ2V0Q3dmp5Q3p2STlWQWxndkNG?=
 =?utf-8?B?ayt0TjFKZXYwSzYzaU8vczVNcVdDMDRNd2FsMDdlbW1PdElLTzZaWHBxWXgr?=
 =?utf-8?B?SEd6QWJ4b00xRWVXd3NPQlJhUXFzdCtiMWx1K1A4c1ZiZzFJR2JJZTM1cmpS?=
 =?utf-8?B?VlBnMnVUVy9PNHp0QjU4aURhdmxXZ201VitueU1PTkppNEZkcnpvYnRVN3NK?=
 =?utf-8?B?Rmdkc3NKUXh2RkJaSWZoVHhKU05nSkVDenU5clFuLytuUzFOMmZtVTA1UVZQ?=
 =?utf-8?B?RmV5WEhXNGFmUGVJK2wxR1BxbHpSb3RjY0xkdWsyU3dibHpUNlZkNWR5WW45?=
 =?utf-8?B?U1ltZEt1Qm1SMndqa1JRSXhvVTg0UktLUitmUnlyQXdjcUdzQk5ham9oYUVD?=
 =?utf-8?B?WC8rek1XeXBtRnRVclE2Z25jT0FEVXBCZ0hmVWNBOXArUmtUN0tKdXgvdHpF?=
 =?utf-8?B?ejYwb0luR2J6UmRLamQzV1MwRVRnSjRMZTFIeXNsRlFjOWVpOEhvVnl0MS96?=
 =?utf-8?B?ZEg4TFMzWkMxZjR2ekR1SFNwcGw3WGFQclVQdko3VGxZQlRUK0hRUGhnMVY0?=
 =?utf-8?B?dEhPZFMxOXJpOExyQXhnTjlXQmpWZW1LdzRTaGlqTEdEdmxvWmVhRjBHakdl?=
 =?utf-8?B?V3lKd2JFUkhDbnExSFlDK2FlY2JFTHAwQjZnMHZSeDVML0tJa01KWndJSFlC?=
 =?utf-8?B?bUpxQjBMUmdYWWhabHJIdFhKWlZwaVVZMGN4ZlNNck1HRStnLzArMVR1QW1j?=
 =?utf-8?B?V3lKZVdzRm9KcHdYNlk5KzhwVWtoRjlKMVVZbmZxYkhDMVRzUjNjSEltZ0Z5?=
 =?utf-8?B?eUl5dmlEemgvalZtRk45STRhL2VoelUyWE83b1YzSEl4aUNBR09DRzF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZllOc0hlMnJqTTRLV0p0WkJVWVB2ZzE3YXhpMXVJYU9FVEZTQk5EdlB6bVlI?=
 =?utf-8?B?STAwWVU2QU40bmRrTGYwWGh2TjB6Q25KVVJhRzBqL2Z5S1ROUUhzM0ZFMlRW?=
 =?utf-8?B?R25peFlSSkl0NEFwZnEvSk4zUzl1aEdCSE02UjFOK1VYa1FYZ09mT1pXUHRJ?=
 =?utf-8?B?R3hPdUFOamUxMTBkVURnT0V6TVU1Zm1DNzVOWnJjOEVoUnpxYzdtSmZmQU50?=
 =?utf-8?B?N2l4THlrYTE3eWl4WHRLOXcxc29wSElBSFB0N1RWOHdqSlBxcFAvVGJ2VTht?=
 =?utf-8?B?YVB4VmpqVnk0dmM4Y3BZejIrdnJNenVIZDJoK2RvOVNNTlFaUTBsZjMyY3d5?=
 =?utf-8?B?eCtmMVQ3Mm5lVTYrekowb1dZS1lIOVpETWxmY0gwOUFmSWdTS2d1VjMzSEkv?=
 =?utf-8?B?SUJLT20zRkRHck52dkF6TTBXNFc0L1FtUFI3VVhNRXcvSHd0OVdUS0VqcGF1?=
 =?utf-8?B?Nm5vTzdoMTE5UFkzRkRrNzNHYUlrbEM2MnpISEd5WFZCUXNjUFByeVVIcGxz?=
 =?utf-8?B?YUg3bUgzaFR1OWlxWksvODh1NVFCUkM1bzkzK1VtcXpmV0pGbkdWZ2NYUkd6?=
 =?utf-8?B?clc1b3dpZk5PWHRleEwvVTAwKzNxbVZWTDc1SXdLWnV5WDhpTmNubEdvZEZB?=
 =?utf-8?B?THZTV0VGOEI0ME1xQ3AvY2VrdzJBcmFpbGIvZFlxaWQ4ZFZaZmZ6S095L1N2?=
 =?utf-8?B?MWFXWHBTRjZhWTNlOEZqUW9ZQTBHY2ZOcXpuWlM3Z1RuK1d2SHB1cy9vS0Fr?=
 =?utf-8?B?QTJvN01Xbm0vc2xUVm1sT2cxdVBMeTdVUm1rMVc0L1RRbW9YaFkyYnIyVC9D?=
 =?utf-8?B?OWNwcy9OV1diVkROakFOWDZ0N0NROWNKUFgxWTdvY1Myc1liMzc2RTd0T0gw?=
 =?utf-8?B?S29WVnFOUUM0by8zeXdHWnFMV1E4eFc1dFkyTmZ3dGV0ODc5Qjc3QU8vaFMr?=
 =?utf-8?B?aENDNE95SldSWVo1N1NSazhxcTJqNDNzcGJRc2dZYUMxVXJxSlhvelJ1ektS?=
 =?utf-8?B?SVRFckZIcVZEdm5hSkRWaFhSYkRTV1FOT010eWpheVJmNEdRcExNelF5ZEVx?=
 =?utf-8?B?emxqaStEZEVFdmVvZmhOZGhOOVlrZUloeStHdnlDVTN4NDkvK1FmTzJpU1ZY?=
 =?utf-8?B?aUJlUXpQSWxXU3BxN3poWmhOM1AxcDVUUU9NUGJydy82blVyakFzM3c2VXNx?=
 =?utf-8?B?RVNwZkVNUnhLWFhJb2RLRktvQ1N5bTVHcTlSTU95aW1FRzNBS2xmYnNKZzZO?=
 =?utf-8?B?bVptSlllcXRhQ3dNcUsrcE16RlIwYnkvOVAvK25ibzJ1YzFOZHFpSUxNRktm?=
 =?utf-8?B?bUJrekwzaFFUcXozQWxyanNYOFcwNm54Q1dQa3R6ejdLWDZQTktMaks0dkJ5?=
 =?utf-8?B?ellEU3FvZVUyZWZ5Ui82bHIyQ2lHOVRwVXFCcG40WmFIZHdVSG1tZEhOYkx6?=
 =?utf-8?B?cWJSUFE3cDYwZzBKcHI3eWkxUURvQVNaWDZHUWRJR25oRi8yQVJibWRENDdV?=
 =?utf-8?B?UzRQNHc3a091aHgvMVF4azgwRkduYUZGWjFHMGFoWVNBMmFXVkY2VWFSQ0hU?=
 =?utf-8?B?MElLcFp2QngvbFBycHJHZDhxMEpvWmRuSnAxaFVad29wUUpvYnMrUFU1SEUy?=
 =?utf-8?B?VU4yZUQzYnE3bWVNZlRITzZoZXViY3Ftcy8zNm12N2t4RlRZTkFKaVJXckQy?=
 =?utf-8?B?bE9HNGVZWTYrOG13c0FjaHExLzN5VFpLOFJ5VnJRWjMvZXk0Vk5WQVkyNTlJ?=
 =?utf-8?B?N1RuaFdqMXQ1RkpaSWZubXE3eTM5Y1NCTWhEUkN2TlhmYzdNTW5PMW5ZSzR0?=
 =?utf-8?B?VlpRcFFvUUlNdWwzNnNwL1ZtR3RhRTJRQ3NnaFRyMmxCdEY2TDFtc25PVXhI?=
 =?utf-8?B?cVRHZmNKdVBNNkZQTmZyMVRLbXQ3WXowcUNoekhCWDBoVllMaUMyS04zV1dz?=
 =?utf-8?B?Mm5TK3lFSWg0VmZsRWd5NDBMNUhSWXlrWUdkYWRYTXBRNVZBNG9vNkNNRUM0?=
 =?utf-8?B?V3VxZ2xZM2RCWDJ3Z1R4RUVnT1VLREpNZkF2Q3hXQXlsakI1OFhKajVya2hR?=
 =?utf-8?B?UnVtaDdVck9XQXpWb1RLcGtjR2JQVmFCYUhhVmw5S2dSZ2ZHRDlIL2gvYzJn?=
 =?utf-8?B?RDdaTlE1Wm9zajFqWDBYMUJveWcrd1dnZHIwNUJTZGxJMG00RCtBWk43MW9U?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dee060-1dbe-4794-a841-08dc66edd655
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 19:11:27.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CuIE9lcqtbo5Z+jrUzn4tTrfr0+vJjcZh60NNWlLsQidnvv915Ypos2lkCnRkjTZIucLCLerM21dhoPZWXCSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

On 4/27/24 8:14 AM, Zi Yan wrote:
> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>> (non-present) migration entry. It calls pmdp_invalidate()
>>> unconditionally on the pmdp and only determines if it is present or not
>>> based on the returned old pmd. This is a problem for the migration entry
>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>>> called for a present pmd.
>>>
>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>> future call to pmd_present() will return true. And therefore any
>>> lockless pgtable walker could see the migration entry pmd in this state
>>> and start interpretting the fields as if it were present, leading to
>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>> I suspect the same is possible on other architectures.
>>>
>>> Fix this by only calling pmdp_invalidate() for a present pmd. And for
>>
>> Yes, this seems like a good design decision (after reading through the
>> discussion that you all had in the other threads).
> 
> This will only be good for arm64 and does not prevent other arch developers
> to write code breaking arm64, since only arm64's pmd_mkinvalid() can turn
> a swap entry to a pmd_present() entry.

Well, let's characterize it in a bit more detail, then:

1) This patch will make things better for arm64. That's important!

2) Equally important, this patch does not make anything worse for
    other CPU arches.

3) This patch represents a new design constraint on the CPU arch
    layer, and thus requires documentation and whatever enforcement
    we can provide, in order to keep future code out of trouble.

3.a) See the VM_WARN_ON() hunks below.

3.b) I like the new design constraint, because it is reasonable and
      clearly understandable: don't invalidate a non-present page
      table entry.

I do wonder if there is somewhere else that this should be documented?


thanks,
-- 
John Hubbard
NVIDIA


>>
>>> good measure let's add a warning to the generic implementation of
>>> pmdp_invalidate(). I've manually reviewed all other
>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>> conformant.
>>>
>>> This is a theoretical bug found during code review. I don't have any
>>> test case to trigger it in practice.
>>>
>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>    mm/huge_memory.c     | 5 +++--
>>>    mm/pgtable-generic.c | 2 ++
>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 89f58c7603b2..80939ad00718 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>    	 * for this pmd), then we flush the SMP TLB and finally we write the
>>>    	 * non-huge version of the pmd entry with pmd_populate.
>>>    	 */
>>> -	old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>>
>>> -	pmd_migration = is_pmd_migration_entry(old_pmd);
>>> +	pmd_migration = is_pmd_migration_entry(*pmd);
>>>    	if (unlikely(pmd_migration)) {
>>>    		swp_entry_t entry;
>>>
>>> +		old_pmd = *pmd;
>>>    		entry = pmd_to_swp_entry(old_pmd);
>>>    		page = pfn_swap_entry_to_page(entry);
>>>    		write = is_writable_migration_entry(entry);
>>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>    		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>>>    		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>>>    	} else {
>>> +		old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>
>> This looks good, except that now I am deeply confused about the pre-existing
>> logic. I thought that migration entries were a subset of swap entries,
>> but this code seems to be treating is_pmd_migration_entry() as a
>> synonym for "is a swap entry". Can you shed any light on this for me?
> 
> It is likely because kernel only split present pmd and migration pmd, but I
> could be wrong since the code is changed a lot since splitting migration
> pmd was added. We either need to check all call sites or check pmd_present()
> instead of is_pmd_migration_entry() and handle all possible situations.
> 
>>
>>
>>>    		page = pmd_page(old_pmd);
>>>    		folio = page_folio(page);
>>>    		if (pmd_dirty(old_pmd)) {
>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>> index 4fcd959dcc4d..74e34ea90656 100644
>>> --- a/mm/pgtable-generic.c
>>> +++ b/mm/pgtable-generic.c
>>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>>>    pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>>    		     pmd_t *pmdp)
>>>    {
>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>    	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
>>>    	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>    	return old;
>>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>>    pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>>>    			 pmd_t *pmdp)
>>>    {
>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>
>> Should these be VM_WARN_ON_ONCE(), instead?
>>
>> Also, this seems like a good place to put a little comment in, to mark the
>> new design constraint. Something like "Only present entries are allowed
>> to be invalidated", perhaps.
>>
>>
>>>    	return pmdp_invalidate(vma, address, pmdp);
>>>    }
>>>    #endif
>>> --
>>> 2.25.1
>>>
>>>
>>
>> thanks,
>> -- 
>> John Hubbard
>> NVIDIA
> 
> 
> --
> Best Regards,
> Yan, Zi



