Return-Path: <linux-kernel+bounces-160365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704308B3C91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5D1286286
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E315358A;
	Fri, 26 Apr 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="h3+Ia5vB"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2137.outbound.protection.outlook.com [40.107.101.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12177145358;
	Fri, 26 Apr 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148090; cv=fail; b=QkbunrirekAjPgKeBD+E9LerpTu8ZL8Zl8uTs3UToX6vt73DgnjHtf5/KvdHfZxVvsDOTHpUrA9Z3VimtJhdueRK0vBUfRPMFHa539xEX+/az8P4uFA+nTy/3bpW54H6L7EtTsj7LnfP/aVYv/T071pbjhaN78l/52kWqMgEAM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148090; c=relaxed/simple;
	bh=fqF+ekf66S9kT2wSdfasWgDbpYNNgWyfSwY7ymY05Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DMzVXJ6ZKVssbtaskZG4344eptXYoIkzMn5Fabof83XK8h8TnBPrX9OlSIi4VGl/XgQExlMWq7F/ZOZx9huaGmOJfHd7uNvrn5gsdCNkQ3qpHNGlTPVKvS9NE4bbCx2rdcKBjR2SOLaozAWhcWE9wf8gUIMNj1NaMdpKhGrgSvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=h3+Ia5vB; arc=fail smtp.client-ip=40.107.101.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM3jL3QHx7EcnEDDHMMtp7W2qSREJqSZ72UbthZ5QJ0bIofeDsHw5ShZGB50IhPcEG2M4ayviNVC7/r4TeV/hUs7ZoqupgNH1kWOffUSDL0N7O2zsMZV2fj7MKn/2HEK/FnY/yUWW/bxWWp8Ysh/h2FvcukI20Ohj6zLeLvV0D4LfAvPYMtXjxxTIWL+wU6aqHkSsYz/6Buu9SExlcqtlEkPmK4GaCctaYygX3f/j95/ZehjqWpUzB8dEYNW6dJ180X56o4+9V2Vkecqpsf1zKz4kPb4V9wUAkKCeYBzUfeGHTtvK43SiT5JSO2Vfdg2TNDMgiHBqmwE8i8s5BiVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khrC5PDuMZrhIuPNX8ijenDKE7eqeYTZlr0jH6LFcyI=;
 b=dAPizjWeOmMvJcm6rsWRniIFPWkTljzO9KN2GJCk0BszdRGH9iXBGFEO8HnlDEWJyJ7lm4fscsvO3cQ0ms+cTIV6ptnxGqYEoun/AkjCaVQ060HAVBYnLn/i7ehZTW6x+W6uzxyfeG4YyJ6evdqEAtn7iWuN9/cHQ1GXYt6LKML3H21RhXvNbpdTNN6auxGS7fx+vtrXZAu1ecC6Nnwjw93JjsQ01/lO+OWeIGbwmC1s/H5JHuDowLsAVCs194RJqwFHDDopbL4j8Ktu9IoLmZeUI//0YsfjB4dGJxYKKpjK1F8h3YhASHSzv21pU1B81UHrec0fcfqB7TgNq370nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khrC5PDuMZrhIuPNX8ijenDKE7eqeYTZlr0jH6LFcyI=;
 b=h3+Ia5vBVMz9yWDLzZV/YF1KLZQ+O2QSaxJ6pcy/JBubd8nfIQ60fGZJlaCXu93euYYQyt6tlBkQjgWmWeWkYq6+nSKkB8H7UDiDHscuxM87oUsK3ywEL/l7qKEvJjE2Ns02KJpx8HzehY1c5Iv0AS0jZjEwFCoHhiWXX9o9U5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW5PR17MB6009.namprd17.prod.outlook.com (2603:10b6:303:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 16:14:47 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 16:14:47 +0000
Date: Fri, 26 Apr 2024 12:14:43 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: Dan Williams <dan.j.williams@intel.com>, axboe@kernel.dk,
	John Groves <John@groves.net>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <ZivS86BrfPHopkru@memverge.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
 <ZikhwAAIGFG0UU23@memverge.com>
 <bbf692ec-2109-baf2-aaae-7859a8315025@easystack.cn>
 <ZiuwyIVaKJq8aC6g@memverge.com>
 <98ae27ff-b01a-761d-c1c6-39911a000268@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98ae27ff-b01a-761d-c1c6-39911a000268@easystack.cn>
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW5PR17MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: dff0d860-f073-4b58-18a9-08dc660bfde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmtDaitQbEJpYmpMRG1yY25sb2EwTlFJSGw1Y0Nac2FSK2RVWjNHRmRTb2VM?=
 =?utf-8?B?dHdvMFBFOEUwNkhPRHNjZzFQOUU3eDBtNzhUNFdMYnJKQ2hYN0d5THIwUUNx?=
 =?utf-8?B?VmNveTFNaEwvMGwyN3hIVERvSS9WOUJMRGFrT1hnNGJFS3JLM0dxN0xLWEJj?=
 =?utf-8?B?SEE3QUdqQ2ZKeDVyYTJINkVmb05xb296aGp6N09KYWZVSm9LNjBqN2o0U2ZU?=
 =?utf-8?B?cFk5UGtsRFd4Rkhhc2luejNheWJOdVBqdjh5Q2dadUdhMFBxTEtDRlVpR0ky?=
 =?utf-8?B?cktyMzduQU9rUHovZFowQjlXRTFvOERqWHh6dnVDVDYzSmFJaktkRHlGUC9E?=
 =?utf-8?B?SVU5VTVDVmNEb1NsSHh4T0Viam42SEZzOU5uYzM3S3NnY3hxa000YTNwQ1or?=
 =?utf-8?B?aGdKamU4THcwVnpMYXJTY2p5Ym9GUndXU0U4ZDNXSXo3d3FVUHRVdlFzd3JV?=
 =?utf-8?B?SFpFSE80dG1YVXpJbmlzSy96SllLMVZQUDZiUWtVTjV4WGxDZSs1T0RQUktN?=
 =?utf-8?B?RUZrdE9NQm1WQ056anNtL2xjSTAwbnpVTEo0K3pyMk1JdUZDb1RBbzZYeHNL?=
 =?utf-8?B?bW5JZkJRWGdYK2pDc2djYUZLcmp5TGVUeXY1enE4WnFaeHBVektwd29RZS85?=
 =?utf-8?B?NEdBa01za21EbU9JYWEvSWZ2cWFkYlRMMXBHemFVRGgzWklIT1A0L0Y5QzY3?=
 =?utf-8?B?Wm11czJCZU5oWEh1a3dQVDBNYlVOSU9wcXR0aGUzK0grak5Vbnd2cEYzUlBC?=
 =?utf-8?B?aDRnSVJieW1Qd0VWNFRZRTJXT1RGWDlUVEhWUVhZbThBZlZuT0kwWHpIYnJj?=
 =?utf-8?B?ditYZUJGVzBMb2VwOEVKYWFPWjZQK1FkS3laWXlSUUh4OWVLTm5mbFk4Undp?=
 =?utf-8?B?S0l1UmdkUC93a2tUdlhNKzV1cDdjNmRlOXptWmx5OERkenNGQUJ1L2hMQVhu?=
 =?utf-8?B?V2doenhlMmxSSVhqMXhreEI1Vmp1dmYrTmNGUHg5czlwYTlLRmN1SC8xRWZN?=
 =?utf-8?B?TnlFUmhvWlkrbTF4VXdOZmhVZ0l4bm9yTG9RbFV2d3lFYzVLdDFMdGhQc09W?=
 =?utf-8?B?dXF0bjZITHUwYzNrTmx3MjFKL3RIajVUKzJwb3cvZEF0VkJVSmdaTFVGUzlN?=
 =?utf-8?B?a2NDL1kxNkZwR0tkSlF2ckZhWjhuSXNQNWx5NlloUFZLdFI5TWpNdHJGdjBD?=
 =?utf-8?B?S21mcUl4cTE4bGsydHN0d0VYemZZU1Q1cFBNVkpEQmlXVVhacE9ySTByekJm?=
 =?utf-8?B?eGpkOCtOSVNQOGQrMVdLUDZHeHk1WkY1T0NMc0pyTFpTNE1nQ043OHpVR215?=
 =?utf-8?B?VTZzbzJtVnpvVFVQWGhmUWZsbzVKMk0vNnU3bFlaQnMwOUorZW8xVk5hbnND?=
 =?utf-8?B?cWV2SU1MaTJYWk5VdTRNUlBPQ1VIYmhySVhkZVZxamhGeVBKbFExNHFvNDNq?=
 =?utf-8?B?RGd1NEV4Vk85SVBDbThiL3pJVklsc1V0N1U4b0k4OXFEeGZyMGltYjR5SjND?=
 =?utf-8?B?c3pZWm5lRUdoYzNCWndJUXp5N1k3TVZMOHZ2eXJHWXFIb3Fzb0xaREZQbGlp?=
 =?utf-8?B?anhtSktESkdGV2J1bTdrQlBXWW04MFJkYWpXOHhCd2hsb2lTN3NMd1NObnNO?=
 =?utf-8?B?VW9EbGdNQVRoejhwUXllU1NxSTh4NnlqaUFhMTUvOUVFUWhMVGxzN2dwamd4?=
 =?utf-8?B?Qy9mUDk3bWVDTmhhQVpCZHF5b0tuZ1ZyaWQxUlRSaGgxSkpSWVZNVi9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZwTzRlNnNHQWt0WnpmRkNGQ3oyMmQ4YmJnWFlzVFFhV1EyQm85dEVmMWdy?=
 =?utf-8?B?cm5MVENXa0dHcHFmSm9lV2s5YzFDTmI2VjUrd2xzNU5NVzB2ZENsME53WW9x?=
 =?utf-8?B?VUNRZDE2QTFEZENHSFZpUkt2ZDA4ZnlBZGNvUGQyWGsyM0RtaTVWV1dsbGUw?=
 =?utf-8?B?SXFBWU5vUFlzVldqYlYzdWlsd2IyWUdUU1M3Sk1nNFJMUWRzRFJBWUo1b2NG?=
 =?utf-8?B?T2h2bFpTYVpQd29ZbXpCR0M3SHp3RFdzNXJFdmt6SjhnSGw5c1c5YSttajUr?=
 =?utf-8?B?RnYwQmJVZHBWQitGNUY0bW0vdGhMd2lZRmwrL016MGZQVldUMlQ1c2hOUEkx?=
 =?utf-8?B?L2E3b2R4elB5QnlXYjNlK2R4MHVQSndQWk1OUVY1djNhK0RHOUkxMWI4V0tq?=
 =?utf-8?B?U1JzS1FHZENzdVhLV0NJYlZZZFNPQzJKaWkxcXVKSmhVTXNSY1lFVFFjK1Vn?=
 =?utf-8?B?VmtBSmhYQTUxSkplejh4MFZJZEVNM3piYU9nVzRkSy9MdWt3T3g4SnBZaWsy?=
 =?utf-8?B?VWh6RWQ0a2VURkMyT2xYNjFFdkVTc3RaakpHVWlIeWtvWkNwenRYOEdSemtR?=
 =?utf-8?B?ZCs2aHhFTXRWZ25uOG9vci9IWE90MFRDYys3a1BSQlhhdzN3ellicFhsSmRS?=
 =?utf-8?B?OVg2VkNLNXlJY0xFMlhKYnJEM2MrZlc0WTBUMGJGTE9obE5FcXA4UDB4eHpm?=
 =?utf-8?B?OU1ocWU0UDhuVGtxRWs0dFhMdjJROWRib1FrWk8wM1Avc0N2WmJUbDVNRzAr?=
 =?utf-8?B?aFMraVU2d1RxalpNRGNIb2c3Y3IzRnlPU2F6WEZsN3lrQWJFMWtSTW5YYWZn?=
 =?utf-8?B?UlY5SkZjcVdza0dYVGt1TTZVZ0dnV003MUlyNVhLd3I3RzhSTVZFako0cnlY?=
 =?utf-8?B?bjhPeVJLak1WclMzaUdmR1FaTGRocTFsWkw5NW92bHFJNDZrSU4wOFBCNTRl?=
 =?utf-8?B?R2V6UUlyZU5yajNBUzFkckxMelppS0tnNjdzYWhJU0xPNzNsUHY1SjBlOXkw?=
 =?utf-8?B?SFErZWRleUV1TkgxV3Y4ejh3Wk45WGErSlo1anVTem13OUczbktBc3pmdkFo?=
 =?utf-8?B?Yjk2Z0xMdTFOSVo2c3pYdGFlTWtOQkRacXZHbkl4NWpRMlJMZVlaOTI5N1Fv?=
 =?utf-8?B?dnYwRWc0VGZJZVFWcjBwd25FMC82U0hvQmZJQlQraXZrQm5Jems4VlUyNDdz?=
 =?utf-8?B?aXhPc3IremVrOUlsaThxcG9ZUFpUSTZCdnFsbklnYnpaSW5JemRmeW9DMkR5?=
 =?utf-8?B?bDdJa2hCeTA0NkVNSjJxdDlWVUFKTG45M0czRnJ5R2ZDeDRXdDJBYjY5c2th?=
 =?utf-8?B?algya1B1VGxNbWZJaEp4d0k3VTNqb1psV20xcEgwczVQRGVCS1pBZVpQSlNT?=
 =?utf-8?B?dFJOUjVwbjJ1aVhINXhPUy9TUDFtcmFXeGxkZ0dQeWsvekpINTFKMHc0Vzhs?=
 =?utf-8?B?c2REWVVLeDM1T3lUdHlic1pyVTFVd2h3NDVSSDlSdzVBTkxyYzdVdnd0OEtj?=
 =?utf-8?B?Tm1LL2ZtcFd1bms3eUQ3NmdWWnJFSHhmbXV2WGJuUVNPTjN4eU43Yk9qcFE5?=
 =?utf-8?B?d1h3THdMaE42RVFVMFlmbU1MbmFvK2hWMUlPTVYzZFJjQ1FhNUh6dDhiaGZD?=
 =?utf-8?B?WG1CL3o0LzcySVZnRGRTNE1hQ3ptOTBBK1BxRkhZWjRpQ0tvQi9DQ1BiZ0tM?=
 =?utf-8?B?ZW5jVk9rZ2MzU1ZpSlVTWGJGWXptalQvTkQzQUpNL3o4S0xzdGhKUCtGU2xj?=
 =?utf-8?B?d2NvSk9ieTlaQ3RmMDlSM05XYVR5d1k3Y3FrMWVjZkMrdWdRR2NzN240SVpy?=
 =?utf-8?B?RiszVU92Z1cwajIzUTQxWCtKcWlDMUxQUHluZkVVQzdGc0l0bFRNbi9rbzI5?=
 =?utf-8?B?ZFVJWmtLTzBvSjNwd0c5eFN2OXFHVmE5a3huVWxjY1laWE4xSFpHV2FRNytB?=
 =?utf-8?B?WlppMTRZMEZERnhNMjYzQllneFdBNVZQT0dHbFZTcFIxcUpBK2hXT1l5UUxq?=
 =?utf-8?B?WGJmcWpBelhHSVdLb2ordWZtOEVpbUJINDFicWFuWDdzSUVqSzIyY2UxNmcr?=
 =?utf-8?B?VTFpdndlQzZrN3ZiNWxMMG1FSlE1ampMOG5Rb1g5VFFkc0JKUWRscUxBcnIr?=
 =?utf-8?B?Zm1WaUdHMk9RRVJ5YXVSa2hvZkdzbDN3Z09EVXFSUWt0T3kvTEVZMlZWbWVH?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff0d860-f073-4b58-18a9-08dc660bfde5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:14:47.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5pxphtB5vs5yo1TPRZyWCBtIEndtLPBnKaEtcWTwSsSqR7wazqbbjmSg+PfujttWy1GLvn6EZ4MrkK0azKHm9wvFoS8sf7CJzoiSa223Mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR17MB6009

On Fri, Apr 26, 2024 at 10:53:43PM +0800, Dongsheng Yang wrote:
> 
> 
> 在 2024/4/26 星期五 下午 9:48, Gregory Price 写道:
> > 
> > Also, on a tangential note, you're using pmem/qemu to emulate the
> > behavior of shared CXL memory.  You should probably explain the
> > coherence implications of the system more explicitly.
> > 
> > The emulated system implements what amounts to hardware-coherent
> > memory (i.e. the two QEMU machines run on the same physical machine,
> > so coherency is managed within the same coherence domain).
> > 
> > If there is no explicit coherence control in software, then it is
> > important to state that this system relies on hardware that implements
> > snoop back-invalidate (which is not a requirement of a CXL 3.x device,
> > just a feature described by the spec that may be implemented).
> 
> In (5) of the cover letter, I mentioned that cbd addresses cache coherence
> at the software level:
> 
> (5) How do blkdev and backend interact through the channel?
> 	a) For reader side, before reading the data, if the data in this channel
> may be modified by the other party, then I need to flush the cache before
> reading to ensure that I get the latest data. For example, the blkdev needs
> to flush the cache before obtaining compr_head because compr_head will be
> updated by the backend handler.
> 	b) For writter side, if the written information will be read by others,
> then after writing, I need to flush the cache to let the other party see it
> immediately. For example, after blkdev submits cbd_se, it needs to update
> cmd_head to let the handler have a new cbd_se. Therefore, after updating
> cmd_head, I need to flush the cache to let the backend see it.
> 

Flushing the cache is insufficient.  All that cache flushing guarantees
is that the memory has left the writer's CPU cache.  There are potentially
many write buffers between the CPU and the actual backing media that the
CPU has no visibility of and cannot pierce through to force a full
guaranteed flush back to the media.

for example:

memcpy(some_cacheline, data, 64);
mfence();

Will not guarantee that after mfence() completes that the remote host
will have visibility of the data.  mfence() does not guarantee a full
flush back down to the device, it only guarantees it has been pushed out
of the CPU's cache.

similarly:

memcpy(some_cacheline, data, 64);
mfence();
memcpy(some_other_cacheline, data, 64);
mfence()

Will not guarantee that some_cacheline reaches the backing media prior
to some_other_cacheline, as there is no guarantee of write-ordering in
CXL controllers (with the exception of writes to the same cacheline).

So this statement:

> I need to flush the cache to let the other party see it immediately.

Is misleading.  They will not see is "immediately", they will see it
"eventually at some completely unknowable time in the future".

~Gregory

