Return-Path: <linux-kernel+bounces-161503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624958B4CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA581F21039
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36E71B50;
	Sun, 28 Apr 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="buw+nbXj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AE71B20;
	Sun, 28 Apr 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322658; cv=fail; b=kgr1QzSzqjmv8hlEGpMciP3SK9Rxg90YI/CyZuyfIWvp4I+brROTdWIhmkecuYEsDdd0b27GJVDGiKq2WnMhc5pax2w03bJZjbw2TgQsZDCEQ4/y16ouaK7YbTNp50++MLaAC2aw6H1fLLkKwBAv6F/+lRJxHiodwZ35zF2nAEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322658; c=relaxed/simple;
	bh=VAmuUlIrBdi8G7K2UeBcfPEWZxfD4CVzsywEYubqRQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aE0Iz363Rou/+rHM1xH8tti6OG46kl/FIyZVrxwc+txZqxyilojBBeABgqm2RJfO3OgfWM2mWnRw01IPO6xOee5htkoQmJJliVJJGGz90QDGfoFY6+0m5lfKLIplbJPd9o7vfsdyMOXtlUVCJtR2pfUIbxMCrrOE+oH7PncykXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=buw+nbXj; arc=fail smtp.client-ip=40.107.220.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwDlcFBH7LWMuid1mfyCCuNgxudaP2jHIvaKt8TJork3sxJz/5GlLyhxRRD+OtO/X/AMGHiKCeamsKvDFYSRWT/Rz9gTkUviSRbIcaNpDqXvL0zNTeieubbYd5xOZt6kn86JM7aLJuGe1MuiZsusTeMWt+PyAksh64XAIlq5rNkR7B/HlAyp0SGHxmBAEbBO1L5Cg2t73A1dKH9qcgut2pKiQgAsZiO2bA7ezm4lf1OwSOtlekErQ2tm3wtLHMm5UP7xo4qP+n4TRRZ66gYmqoig1qzeyJRPrC67/V0/Z4YuGIoopXf9v4yhLyh56Q5/Z61mzpcA43z7Bb3Ka2CoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpk8Sa54oYq+3APMMD2K9xPQrHgMvHfXQTWa6LfBsEs=;
 b=UqM6fPjKT9Nzfbsdad0mKdjo5fG8YNuZBcvg2po/+xpiZ78EYGP2CJ4JNqY3zUoBr7HvIFaF5Xadklp1gzBm/KqdbtIaGWcGj7NdIyFGubX3WZBHZ5HqFgU/eo3QdN9RTWp5MsXC3dZpcxbbN1QucqgB+t0mWD93deUXQsu8DUBqEzdDzNcHYZ7eX6zCYjIWzTLJHKPUk7gyq+q1e0Yk6CcmVRaCcb97xhMxr1vNhWezkdVDk36MtEZA/RGckDkqeLhzraCazPcUOosX+2CsHs9htxkOvh4FIWuZuwbGodVaC4iyhWNm2y3+WQVMhAP0NiCInIOEsrDXvDQfqDv/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpk8Sa54oYq+3APMMD2K9xPQrHgMvHfXQTWa6LfBsEs=;
 b=buw+nbXjb4Y+Fmh9YW3CckooyId/3Mg7Wb9ZXsXYCZ4/DfyswJg5JjGqCzbgdwrPQX8lHwAhHikmffBnEwgr2MMI+QtbCHWMYzegF1zZuTkv4XP6r535w6rtlULUh7wVCClsgLlA0ez1d12iR+65zsaDxvnU0LCNOI6ldwJZ+B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 16:44:11 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 16:44:11 +0000
Date: Sun, 28 Apr 2024 12:44:07 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: Dan Williams <dan.j.williams@intel.com>, John Groves <John@groves.net>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <Zi5819GyW7lGFqtM@memverge.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
 <ZikhwAAIGFG0UU23@memverge.com>
 <bbf692ec-2109-baf2-aaae-7859a8315025@easystack.cn>
 <ZiuwyIVaKJq8aC6g@memverge.com>
 <98ae27ff-b01a-761d-c1c6-39911a000268@easystack.cn>
 <ZivS86BrfPHopkru@memverge.com>
 <8f373165-dd2b-906f-96da-41be9f27c208@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f373165-dd2b-906f-96da-41be9f27c208@easystack.cn>
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3d63a2-fcb5-42de-831a-08dc67a26e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enpoTXc4NmsrZmJvclNlekxadXBzNWZpTE1laEY1M2RsZ2ZVMmlXZjRhcENT?=
 =?utf-8?B?eTZUQTVWRG44N0p5eFZaMkllTGtGNE1FTDVvNi9YYUFXN01LbVV1QzA1OU9Y?=
 =?utf-8?B?TnpBcW9Kb2ZHb2VZNEcyOUhxK096V3ZhcHlxaGozbS9WSmdhdWxucmM3dytY?=
 =?utf-8?B?cE1jZ3NtSzBsWXZUSi9DZjdHTHh1VE5VZmlXb2VqQk1iWGRTZUJ2aVVhVE5r?=
 =?utf-8?B?cEZrckNYQ3VhOGg2ZDc5U1ROQ2h0ZUl0YUJBR2ZjNGMrVHdGUHlrUzd3cWNu?=
 =?utf-8?B?Y0VvVmJKMkNGdkhmVEZReHRkbDE5bjNEVTJqemRKNHBaVkd4SVVlOFZVTVpy?=
 =?utf-8?B?UXY3dzNQTFVyOVB4VHlSenNwTlhUakRIZldFMUhlQ0s1akkvZkdhOGExek1L?=
 =?utf-8?B?TnFHaVdvbVZJZ1U0ajhGcWNsREJwRWJqcVVCTlA3VC9pbkV5cEtNckExMGtT?=
 =?utf-8?B?NVVQU2pXTzEwUmI2eGxVMFdNYUNnMmc1RFQxQU5PWjNkZXN5OWVBeUE5dm80?=
 =?utf-8?B?OUFRTitKazNzYVdXZEI1dU0yMFdXNzNjWnp1R2hxM1F0bjB6R014L0J2bHZN?=
 =?utf-8?B?ZC9rbjZ1cWIrbHl3KzlXemVKY29LZktNMWVoQzhVeVplN2wwdVQxWW5oVG10?=
 =?utf-8?B?TVFqNVo2R3NRTXdaSm0wZmRMOGlVVGdQdlJkRU1ETWpOazRTUmV0Nkc5b3Z0?=
 =?utf-8?B?S2tuU2VzczBtU3VMMmN5RmF5Z0hNVk95TmlhaW5iMm9ISEFBQ0tiWHM1VHdU?=
 =?utf-8?B?b3lEOTZHK0lWc0FNKzRIUlFBYkxYY2U3NVpDbW94R0JiREk2cG1UckVJRnRB?=
 =?utf-8?B?VDNxR1dNS3VQVWtLR0Q1VVZLZ25EUStBSWxuL3Q1WVNleFpDZDlJcTlmQ1lp?=
 =?utf-8?B?SFJMTjdremt0blV4T0o4U3d1cUxXMEZiMSs3eUFITytTakdLa25NRzJBclNU?=
 =?utf-8?B?c0EwUjFhUjFHKzJVUTlEb0xxMFBZWGRDMlcvenk3aTUxbUpOL2YrNmovM2t2?=
 =?utf-8?B?TFB5US83aTRCWDdYazEyT2ZmODFGZUhLdUF6N29vQldWZE9pcHk0T1k1NFN1?=
 =?utf-8?B?MmF5R3dVUDJ5a2xEOEhkZ0tCQmxUME16TzJGMlZsMHhpcXF0eU9zK21ZY2ZH?=
 =?utf-8?B?S1F0NStqaGtGbkRhM2xwem5IT0hMNHowZFFUa2ZzSXNicFlkaHZ2RHdxMkhY?=
 =?utf-8?B?bE4vR0hzRFg1RlRoUzhnMSt6Yk5jYkhMSkxra1BjTTY5ZStqYVJHTDBDZmhs?=
 =?utf-8?B?QVMya1VFTFhpVVIrZWdwWlBwbHkreFRCOXBEYmZld1BRblI4SzZOWlhBbzVK?=
 =?utf-8?B?ZHVaSmNhSnBJZTdDd1Y1U3hEWmRVYnVOYXdlNEkzdjlIZi9RNDMvWFp2ajBa?=
 =?utf-8?B?WkpUdkluYnVNRVhkclUwMy95T2tDVkRjR05kaksyTnA5WmhvVnkvaFNDZExI?=
 =?utf-8?B?ZzJaazlsVk1wV25rS0Q3S2xKSEtKeUUxc3dpK0F4dUpsUzIzQTd3OFVmSk5k?=
 =?utf-8?B?anA0Qi9jK0QvSW5KT2VqaWNrRDR5RjYyaWVnVU43YkFWbnVvT2hPdHU5OUIy?=
 =?utf-8?B?N2tvYUlzN3F6UUJCWjU3M0t4aDBKSGlGVW9YWExUeFByKzgvckZsNmM1c0JH?=
 =?utf-8?B?TWNpTW56NUdmWnFubVFrM1p2TGRVUEV2S3JEV3NDcEowbW9FTjlvZHl0a1M3?=
 =?utf-8?B?dnhnNUZoTTNDZEhXTVI5ekhwbVB4QjhHRWhVcTVuLzlJZHAwWkpkbVNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFRwVDlMQ3VBWFdsbkNrZFNQM282aWhwdSszdjNOSmNXQ2ZxZnRoSGtKZytE?=
 =?utf-8?B?MHpIMkZNRHhvVWNqNEVudTZJcnNOVUFDQzFDMHF0VjFScU1sQUw3NmtIcy9m?=
 =?utf-8?B?dEdibTI5Wkk2UEFvejlVWC9QdkNPZ0dNSjg5N2hXdGVXK0c4NW81Z3BCeGNS?=
 =?utf-8?B?bk8rK3RrVWRVWjlsZHhrL3JIZUdFeGpWYlJSOWhXc3BuOGdxSFhGQmlTa1V2?=
 =?utf-8?B?UTN6eVFPbUVlNk5ERUtOZHpzWUcvMm1YckZxMytaOUhpK2NRTjA5WUtvL0l5?=
 =?utf-8?B?Tm5pa0hCVGtJbWIxOHpOU2JraEpJWDJWMWJUcGIzSlFjVDRzU1ZaWGd0a0p0?=
 =?utf-8?B?N2N0VHU4QlZUQ3BVWk1CU1ZOSktSM1ZSZ2UrS01hTm5MY3d0aWFndGNlZFFV?=
 =?utf-8?B?QS9VTThQVE1SdWNXRW5qN01JcmZzYWxvbkw4eHpCUzVVcDJaYysxYUxFVTNv?=
 =?utf-8?B?QVN2eVl6QXNQNkRGd3FlbDdXWW9uN04rZE9BOTFXVVhCaUZIT1BZWHNSR2NL?=
 =?utf-8?B?cnA0OFMvbEJEWjJFQnVpRmxFd0QwTlNxMzRqK1NxckJEazFxbk5iUHd2NEdQ?=
 =?utf-8?B?NUNrMUs4YUpSSjhpWUJrejlIYjhaZEtSL0JLdmh2WnBwNHBmYWcwVmkxR0dE?=
 =?utf-8?B?MnduNHdYNjdQY2o0aUJ6QVNvYnAzcHppV25zZk1ISTg5MWdzVmhrTHF6TkxZ?=
 =?utf-8?B?WktiOEMrckRUMUZGN0FsL0V2aVBTa3dQaENPcFRacmVlcER6NlNXRlVLdDFE?=
 =?utf-8?B?M3Z4ZXVNWk5mNFVwRkp6aXFLVjY0UGRiUjhSMFBydGhXWUVyRXA3ejFoNTJ4?=
 =?utf-8?B?ald5eEhDbnFNK1lwUm1rTzBpREppY2R4em1MUFl6QitLUjExRkV6cncvS202?=
 =?utf-8?B?L0tCSm9aZE9UVzAvWHpwWDJVRFpKdW50WndFZHV1YTYvQXhXYjE2ZllYZXo3?=
 =?utf-8?B?VDAxK1dIbU9CY0VkdkFWUStKSmx2Z2RlMmRlNTNEV2lBNUN0OHFuS2NZamRk?=
 =?utf-8?B?L3FJR1NBZHNFTFllZDQ2Rzk2WjZ1Y21wNUZQbGVIS2NDMnhCNitJOE9TcHBN?=
 =?utf-8?B?KzluaWxGdXRTZTY1SW43NWRpR1BYTWxQR2hpZk5zSEVVNUVza3loeHUxVHBF?=
 =?utf-8?B?TldWQXFyYkxqcjFLQVQ5OUNJSHRWTlFkbkRrOUVwN096dFFtdmNqbiszbzhB?=
 =?utf-8?B?TFdDNW5lZmFOVFhqSHNIRERsUEdTRk15MEp0SXVxOXBEdlFyZEo1NFc4ZWJ6?=
 =?utf-8?B?ZStjNGQ1d2pzR2Z6V3IvcS9HaFk4V3Y5YnlKdkFBenVJTTRCeEVGOStwaktR?=
 =?utf-8?B?Vm1zM1l1cGlFV2JMUmlrbUtKdWI1TUxFWXpjVXhrMHpvR1UxSXdZZXJ1QjZ2?=
 =?utf-8?B?ZFM1Nmdja0JoQWRwL1NmVVBvMktPSXpVRTh1UTZZeWZ1ZzlaQ2tDeXM0dThi?=
 =?utf-8?B?dmZCL2NzN3d4cC9laXFzSFk1NmpUanZmTHdqZ3owSlFwaHdHSkxaUXc4K1Ar?=
 =?utf-8?B?Q1dObW9HdWt2L2JkYi9KNm8yYUNXbktBWkIrMWNQZzB5dll6R0FtdVpIZ0VI?=
 =?utf-8?B?akh1WlN2R21Cdk1VU096OE5TYmc0bDlRZGM5eC9OMGhxeERKUTVwOFlwVTh2?=
 =?utf-8?B?REcrUjE3ZEVwclJTS3FuY3lqQlNBejhReDFqRldXYnVBdUpIakZTM0RuVXkw?=
 =?utf-8?B?UlZJdVY5VGppcUJOSTlxNnJPYXoxY1JBVVo2bHFoRnFVUWMxU1ZERlZaODVN?=
 =?utf-8?B?QzMzTFc1TVNJdTFOZFl6RlUydjFzeDBxRXAyS2wzMjhtWjhwbkNEZlRPQlV1?=
 =?utf-8?B?RE9XaDgxZ1JoMVlrallhdUkzMVJYWlJEUlRZeCtDSmNkZWNKT2VoYzdRdVgr?=
 =?utf-8?B?R0pacG5Dd0RFV2I1dmxKaVhsenhFTnY2c0xEUEJZWWNQam9vMjUrbllmdlB1?=
 =?utf-8?B?aFlmN0JCZjI0c0p6MnVZZG82Sk96aVA1aUFvTzQ0Nkc2NExZYWZNRHR1QU5y?=
 =?utf-8?B?RGQ3NHNzVkc0blVCaGNXbzZ2a2F1amFjM1hFY1ZwOFNvcGFCZTZGMlpPeXVC?=
 =?utf-8?B?RU03d2Z4NlRKYXdhbmZka1EyYk9rYmhEcStlT0JMeFhRL002U29YcGJ6U0c2?=
 =?utf-8?B?bG1IODJGcWoxdnpMWTM1dGpzdXdFaVBKakd5YzBvRnRXc0cyejJ6OXN0SktF?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3d63a2-fcb5-42de-831a-08dc67a26e17
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 16:44:11.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jp5yIqAJklO9tU1Suq5YHIyW436qpeLXq4pFABMfvYl9MEnvLwzI7BH8774t+qP66WtUfPuKDOLt1j1lQcu3SPs30XAoNsIwDgIbqHp3N6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6031

On Sun, Apr 28, 2024 at 01:47:29PM +0800, Dongsheng Yang wrote:
> 
> 
> 在 2024/4/27 星期六 上午 12:14, Gregory Price 写道:
> > On Fri, Apr 26, 2024 at 10:53:43PM +0800, Dongsheng Yang wrote:
> > > 
> > > 
> > > 在 2024/4/26 星期五 下午 9:48, Gregory Price 写道:
> > > > 
> > > 
> > > In (5) of the cover letter, I mentioned that cbd addresses cache coherence
> > > at the software level:
> > > 
> > > (5) How do blkdev and backend interact through the channel?
> > > 	a) For reader side, before reading the data, if the data in this channel
> > > may be modified by the other party, then I need to flush the cache before
> > > reading to ensure that I get the latest data. For example, the blkdev needs
> > > to flush the cache before obtaining compr_head because compr_head will be
> > > updated by the backend handler.
> > > 	b) For writter side, if the written information will be read by others,
> > > then after writing, I need to flush the cache to let the other party see it
> > > immediately. For example, after blkdev submits cbd_se, it needs to update
> > > cmd_head to let the handler have a new cbd_se. Therefore, after updating
> > > cmd_head, I need to flush the cache to let the backend see it.
> > > 
> > 
> > Flushing the cache is insufficient.  All that cache flushing guarantees
> > is that the memory has left the writer's CPU cache.  There are potentially
> > many write buffers between the CPU and the actual backing media that the
> > CPU has no visibility of and cannot pierce through to force a full
> > guaranteed flush back to the media.
> > 
> > for example:
> > 
> > memcpy(some_cacheline, data, 64);
> > mfence();
> > 
> > Will not guarantee that after mfence() completes that the remote host
> > will have visibility of the data.  mfence() does not guarantee a full
> > flush back down to the device, it only guarantees it has been pushed out
> > of the CPU's cache.
> > 
> > similarly:
> > 
> > memcpy(some_cacheline, data, 64);
> > mfence();
> > memcpy(some_other_cacheline, data, 64);
> > mfence()
> > 

just a derp here, meant to add an explicit clflush(some_cacheline)
between the copy and the mfence.  But the result is the same.

> > Will not guarantee that some_cacheline reaches the backing media prior
> > to some_other_cacheline, as there is no guarantee of write-ordering in
> > CXL controllers (with the exception of writes to the same cacheline).
> > 
> > So this statement:
> > 
> > > I need to flush the cache to let the other party see it immediately.
> > 
> > Is misleading.  They will not see is "immediately", they will see it
> > "eventually at some completely unknowable time in the future".
> 
> This is indeed one of the issues I wanted to discuss at the RFC stage. Thank
> you for pointing it out.
> 
> In my opinion, using "nvdimm_flush" might be one way to address this issue,
> but it seems to flush the entire nd_region, which might be too heavy.
> Moreover, it only applies to non-volatile memory.
> 

The problem is that the coherence domain really ends at the root
complex, and from the perspective of any one host the data is coherent.

Flushing only guarantees it gets pushed out from that domain, but does
not guarantee anything south of it.

Flushing semantics that don't puncture through the root complex won't
help

>
> This should be a general problem for cxl shared memory. In theory, FAMFS
> should also encounter this issue.
> 
> Gregory, John, and Dan, Any suggestion about it?
> 
> Thanx a lot
> > 
> > ~Gregory
> > 

