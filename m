Return-Path: <linux-kernel+bounces-166531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB38B9BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68891C21897
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8291384BE;
	Thu,  2 May 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ioMpRyCh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2119.outbound.protection.outlook.com [40.107.21.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD49219F6;
	Thu,  2 May 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657756; cv=fail; b=qZaDe4PfzEYZYtz6gkGZ/MBSP/NBe64RDHBccV4Z00ZMtpUxZVkBxRBKz7LBZm5PEedyXRqey/v/DLoayXl2RD1qun1ANW5M8iqSeuWy9tCRLJrz4ZBUAw8e7eEOGnkRUTt+gysewuzWR3FkutdkgGyGwAF8ps68ieeXdNHaxYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657756; c=relaxed/simple;
	bh=VBfI+ZrKdCZqrZwaz2/ctSQ1ZBvblnkckE+UBkzINwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqt5PgpaK4p42BWtaZvZarAK28Ot0px/+YPSwUnLZtGd2UMoh+Ir40h/0YVF4Znru6jTf5rHii/+46AUSdp+4JBg2p/FdKR9nN0zD4XiJ1pLDk6QhNXBy+2DR14jK2jCHcd38MVy8bYPkbpccj/+kMdIcKaXeamzocJegupIEa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=ioMpRyCh; arc=fail smtp.client-ip=40.107.21.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI06LwXn/B3WPKj0XCc5FwAU7uFPBJqecAAzn9CJm19jFxJ/3YmKz+u8PMPlK5SqEqe52wahyZW1eVSKNELdVCL3tALqsI7Em6Td5uxIy+VamuN5Yn0znDx4/+oHmBaybybkL2WTjPnHkR/TeU6Iy5NLf6MdL/7EfrjKL1raRaUuk0eYJ4JA+/jWI162ePIKI9c4KABCMYtAP1wR1dF1fxEJnZmqWFu/qEHwnDe+RakVzD/dhjK5msQ/wMl+3Yh54Ho0v2iKev2vW+IcjqIyvaraa6/UWKmWqfId6HxG7FKPbExaxR3hWvo0omLgJOq8YBcI/aBXq+a3rERxfhvgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpOlWxMMz+YIclQqiUd1Srk8t354R2lG7K+QccLIznE=;
 b=jc6SfXMYOBKf1m5jmEqGsytj3F1Gximf71tstLBd/dEU0MrxYfMz8aLr5oSTMvMDvPr43br0JqcbNIQVU/0DmB5K3C4zdpxSfDtTkuWrg8bUtIlqiX0r4hzchyDoRHKeQL9C+n6cI7u5UuscB3xdrcVK1TGKNGnP42BCIRLWGqH6U0tmxsJhFIJsOi+66XN8A3NwIxyPcUVs9aCPc3XNjcVKBKHCu4rrs34/u6+s0+MHjTStU98oj8QueWIOLafVyWtzDFyv6rtFBcBGlZvFPVZWfM66nTYB+bfpJI48k000VJzO/EibhtyklHmWk0lxqq2oEOhzt3cH/vu6PO5zhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpOlWxMMz+YIclQqiUd1Srk8t354R2lG7K+QccLIznE=;
 b=ioMpRyChQk+aN8981eschhwxgJoN/twoVjedGQqUcTP53iXcSquxWUwdTQhFnPY8t7V5MyLVKH1BARj2pNU2iVRlmCdnybFWt1wap5r4QlUJxUKNYrnxFslqVuPsbL0RyNwQJoFYfNLQdp8l9/e0cennPR2fENOUxRS4wpIDgok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by GV2PR02MB8457.eurprd02.prod.outlook.com (2603:10a6:150:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.39; Thu, 2 May
 2024 13:49:05 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%4]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 13:49:05 +0000
Message-ID: <44f47927-52aa-5248-6ae4-21028076fd51@axentia.se>
Date: Thu, 2 May 2024 15:49:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Content-Language: sv-SE
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 =?UTF-8?Q?Jo=c3=a3o_Paulo_Gon=c3=a7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 joao.goncalves@toradex.com
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
 <20240502133623.0000463e@Huawei.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20240502133623.0000463e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0000ED98.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:3:0:1f) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|GV2PR02MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ed68ce-d6ef-442b-7091-08dc6aaea1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkxCM3VELy9KWjBoSWJ1REhoT2Y0eEw1T0o1bkVuK09BaEEwdC9vd1RQOUty?=
 =?utf-8?B?a1VzUVlnUVpNbjltdWMrY3VXMlZjRkhWalRhcnMrRUhXWWNHdm9MVWNRZGhz?=
 =?utf-8?B?OXV0bTVsbkNLd3BSOFNZUXMxWmo0ZWIrUWxtK1JHNDBFYXNPa084elZTRWV5?=
 =?utf-8?B?R3dSNTJPTlJ6UjE2WGs1UVUxUUFWbWNjNmtwcXZ5azBMc29aT2FmQUR2V1l1?=
 =?utf-8?B?RjdwSDk5RHRXTldLN2kyanVSamtURFJqTEtCOWFzbUZNeU5XV0twUm9ONlkx?=
 =?utf-8?B?L09wakU3ZWtTV3JzQ2N6K2xCeDByc3ZIQi9hdmtab2JrUUtLS1JlTm5rYzU0?=
 =?utf-8?B?c1RPQVFETy9waUJscmRBaUhjdFpVK2NvUlhINjFtZXdVMmV3WGVyMWdCekdu?=
 =?utf-8?B?TUUzSjl0RFhnMm5naEJ2OG5XZDZkZ0J5bzBvWGpGOTBFMVE0NmdZaWhGdjNZ?=
 =?utf-8?B?NXdYZllzcHV4MnhPQXU0S1AwRzdLdktxS0hFcjhXU2pYOGNwTktYazNESG5i?=
 =?utf-8?B?Rzk1cW5VUnpUMmhvcjFYQnB2NHBscVM4ZWtuaFdzem14ZkxCUHlFOHMzV1dm?=
 =?utf-8?B?ZFlEVFg2R25RVlpqbnZHTThuenFXOUIvZUVweTJhdTU2UmM1a1pFdXVwcU1C?=
 =?utf-8?B?blB1QmxIemMxRHdNYmJmR0RJa2lQOCswM0gyY0J4U1pRSmttTkZSYW9Hbkl6?=
 =?utf-8?B?NTNvbmduT2htbDV1em9uRXJOdnRGUklJV2lGTG1UcHhlU0hKWkdFemk3eGNG?=
 =?utf-8?B?ZU5vVUI1MWhnVk5Sd21GL0d4Z2JndEhaMVA1dFlWZ0I5MVhqVmlRWXRUSDhs?=
 =?utf-8?B?a01ERVZYSXpuNzlrQW5QemhNWlVGc0tlQlE3RzJPZWh3Y3l1V1cyUXkrSUxJ?=
 =?utf-8?B?K1pZT0FpVG1ibmlTM1ZnYXpLNXpJT1JST0podFYrMUFmc2sya2NnUjBjVCtW?=
 =?utf-8?B?TDNYR3F2UTFFb0gveUxLbEZWckMvQi9UaGJkQ3NBM3Q0c2d5L0l4YStDRXo3?=
 =?utf-8?B?UWUrUXE5TUdmSmNJZGNkdytKYVpmM09IM1FucmExUGhTZFBudHAzc2ZCZWNE?=
 =?utf-8?B?ajB2Q3U2cGNZYWpFN1pmSms0TVJZMDBoRnN3em42c2tyRjhnVXVucGNqOW43?=
 =?utf-8?B?aFBVYSt4a3FPQXJZUlJqSWRQMkVQOGtISTBsWkJjQjBGOEUyUkwrZnJ3TGZ3?=
 =?utf-8?B?VHpnYlgvK08yUitoMlJSeGZnM2dLTVF4SU1XNnNyWE83ZkJFZmJkUUdpaHlt?=
 =?utf-8?B?RTFiQlpBT0RzOHdrcU9DTkpWbjl5Z1NIUFF6YS9JUDZYYVNpN2x2OGNRaXgy?=
 =?utf-8?B?SlphZGVsZkVPYXAvc3RLc0Z6ZCsxQmoxOTRPYlNoWXMrWFN0ODNPNEsrOUhP?=
 =?utf-8?B?S05xTU02WkdVTmNQb0Jja0I3Uy9SYjFsU0MwdVZVL2gxLzgvcWZRQ0FNNktt?=
 =?utf-8?B?M2hBMDJlWlpyaDdzdUNnV0NpRUZTc0dwb3dGUUp6eUt0Wnl3K3ExdE8weWhi?=
 =?utf-8?B?YXBXMUJneVRUNlYrR3dUT0FPOFF0MWZuZWVXaVVHVFZ3akRUN0lRaTE4UG94?=
 =?utf-8?B?UUNxSmVpejJqa1JGclF3VVplY250b1R2TVJHMzVQNDZqYzQzT1R1NXR1aDdw?=
 =?utf-8?B?TlJwWS90YTNHUjNwZTFSdXp2bTBGQnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUFkbzNhZVlmaXpLVUtrQVBQeVdiZFFqbGZlZlJuRFhTUTc1TnRJZTFSNU84?=
 =?utf-8?B?dnpUekZvazl1ZEZ5bndhdjNVSFE4UnU3U1hQZXA1SFJxcUwyV29rbmV1VmdZ?=
 =?utf-8?B?WHdBb3hySnllQXB0ZktyV3BOSFg4YzBwenJRTHJ4SG1NYnZvR0htOUpoNTQ4?=
 =?utf-8?B?dUpZbjJxbU5mSS94WnorcEFiRk9vWkR3dG1KNEtGV1kva2d3dW5LL2t5MUdF?=
 =?utf-8?B?UVNGTllUR0JOOVRPSHhNQlk2d0llb1pLKzNkMCtvYUdwT2l6RWVrS0JmNVpQ?=
 =?utf-8?B?QTRwc0tiMURWNlFkSGNlWGovUHA1dlBneWNkRXdzM3pBNVJ1Ymc2VHZZc3Rt?=
 =?utf-8?B?dVppR0pZbEE3bVBsbEluZTNOTmRPYTdaRDYwZTh3UktWQVlTN3Uvb2toSFlJ?=
 =?utf-8?B?eEhxemtsbVhOSyszbEt1dlJLdWVNQ3NRTE0vM1hQVW8xejBMTDB4RVpldHBM?=
 =?utf-8?B?ZmpyTW1VOTkybnBFNFdGQnZWTlB6ZzcwYW1GektJcjFJemxTbUQ4UkFpNmZZ?=
 =?utf-8?B?ejBOMTZNVUt3VjlsbXo3Yk9DWGwvNFJkQW5ZU3NIVGMxSnoySmVjZ3NOQzBY?=
 =?utf-8?B?cGt0aDdtTVJqNml3RDZrVFVTazFwV0lvbEtnMnNsTE5tbDZqUDN0REhhVUJw?=
 =?utf-8?B?N0cyWWRGYnRYRWhXTlluUVhRdWg1NTU5K2RyTmhRcmtBMFpIT2NYNUNUMzVH?=
 =?utf-8?B?Y2k3RGxmOGZKdk5lVk5qZEtpVU9FaVY4TWxqQ0RQUlZ1R3FoM1N4eWRnQ1JO?=
 =?utf-8?B?anVoT3cwWVBNc3VJWStHdlpPeHcxQ01Lc21sOFJsT2t2c2doMnNJbkROampw?=
 =?utf-8?B?bldISWhKdjdRUi9YQVRVYjVuKzRTekFpeDFkVzd3MFVEemZONXNKSzV3TWNJ?=
 =?utf-8?B?eUZDNWIrdDQ3c2JLUzl5TkZTR2liS3ladmFNRTVOa1Y2MUNYQjRJcEhjNzR6?=
 =?utf-8?B?K2hPQUNoNHp5ejFOVEgwdjhQcVlxNFFiRjVwSUwrU0E0WWVVd1BIYytPeUxh?=
 =?utf-8?B?aWxlc1lFME8vc2hPaHlmUXZHQm1kRnlkNlcvd1ZlTFI3Ulk1NUtoK093L2RN?=
 =?utf-8?B?dEdzMlova2pKQ0dVVS9IRkxpMGNQUGVrN0VUTEhqZ0VTMWF3REd5UVdhMkg1?=
 =?utf-8?B?ZVVpV0FhVDNoajhmTXVlYm8xVmVMN2hLWWZXczRlTmFPMjJoL0NERzF1WmJL?=
 =?utf-8?B?dDRWWHhXdlJFUDR5dExkNzkrZkkyWml5L3dZYXYvZGIwekllZnEzRkZ3aUF6?=
 =?utf-8?B?QkY5NC92NHY1NnR6RTFheVVGN2JBZ1dBbTlEK2MwKzQ4Wjk1bDI4cG96azRk?=
 =?utf-8?B?b1l4Y1J1ZytFdGhPNzZXK1ZzWGkycUo1REhWRnNOLzhYdXNaTy94UHVVQjZV?=
 =?utf-8?B?b2RYKzdmdmtORE9FTGhQclNyYy9hejhzeWlXQjE4RllkdTR3MEhNdHBJT0My?=
 =?utf-8?B?NGU4Uk1OME9tQUNqblVHcU5qQWo4dGZDeXVJcStsYkRLZkMrcC9URHdNZGtL?=
 =?utf-8?B?OVgrL0hDT09PN3NHdWtYai80Q2wwTU8yQU12Y3lKVTNBTUJaTHBONWZUUHlC?=
 =?utf-8?B?S3hNN3J6Wlh0UEQ5OUdzZVd2NzhGNjJBWCs4Z05wanJmVng1MitML3lwYVN4?=
 =?utf-8?B?UFFsd3NYOTJwTEVQUTRiS1JNNGwrVlk5RFFxOXpaV3krSVAyUkFIdnRUbVBn?=
 =?utf-8?B?WHpGckM3Sm4zSVQ5eStUR1dia2hScVJhd3Rqc2sxK2xnMGVUT05leGRaYXU2?=
 =?utf-8?B?S0szc2tlWUJObWM2YVFIdzZmSUxNWElVNXJKdnFScFUvSllPTVgxdmJEM3J4?=
 =?utf-8?B?Z3dzRE5HN090VWYwMjIvVFRsMFFHMnV6c0RVL294bHF2L0llN1dnUVM0bDdu?=
 =?utf-8?B?cWVTQVNlcjZGRjhBb3QwRUpYaXpHV3pDRHkxeFBmUDIxQ25XajdSNEQxR2hZ?=
 =?utf-8?B?anFDemxLVlRFL0VlVERLNVlnTFZ2RGpMUVM2QUo5QW42V2hrVm5HRGlWMHdw?=
 =?utf-8?B?SEVhUmN6ZXd0NTdtWFpWeDF1MlJoNU91VkNPeGJwRnZvcG1KeTZPWHhnZXlN?=
 =?utf-8?B?bGtmYW5MZTJtYkd1Z3JFdko4UVh2alh0bkhyY2NpbzBtV3ZjQlU0ZHlqREw1?=
 =?utf-8?Q?uyMLWKufk5S1RdGzmUVKnhinP?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ed68ce-d6ef-442b-7091-08dc6aaea1e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:49:05.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8jE3M6SAaL/eZ+6jJJwLWB6FrB/Lyv1MKVPqPcZWi/DYBzWBW6p8xkZZALpkSgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8457

Hi!

2024-05-02 at 14:36, Jonathan Cameron wrote:
> On Wed, 1 May 2024 20:38:53 -0300
> João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com> wrote:
> 
>> Hello all,
>>
>> We need to support a hardware that can measure current and voltage on
>> the same differential analog input, similar to a multimeter. The mode
>> of measurement is controlled by a GPIO switch and goes to different
>> ADC inputs depending on the mode. If the switch is enabled, a current
>> loop with a shunt is enabled for current measurement; otherwise, voltage
>> is measured. From the software point of view, we are considering using
>> the iio-rescale driver as a consumer of an ADC IIO parent device. One
>> of the problems is that we need to change the mode of measurement at
>> runtime, but we are trying to avoid using some userspace "hack". The
>> other is that for a minimal solution to enable the mode from boot, we
>> can use a gpio-hog and control it with overlays. However,
>> still would be better that this was done by the kernel. Do you know
>> or have some guidance on how to properly support this in the kernel?
>>
>> For the in kernel gpio solution, this is a draft of DT we are thinking:
>>
>> current-sense {
>>       compatible = "current-sense-shunt";
>>       io-channels = <&adc 0>;
>>       gpio = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
>>       shunt-resistor-micro-ohms = <3300000>;      
>> };
>>
>> voltage-sense {
>>         compatible = "voltage-divider";
>>         io-channels = <&adc 1>;
>>         gpio = <&main_gpio0 29 GPIO_ACTIVE_LOW>;
>>         output-ohms = <22>;
>>         full-ohms = <222>;
>> };
>>
>> Regards,
>> João Paulo Gonçalves
>>
> +CC Peter Rosin who wrote all the relevant parts you need I think.
>>
> 
> Superficially sounds like you want a mixture of appropriate analog front ends
> and a Mux.  I haven't tried the combination but it should be possible to do
> something like this with 
> 
> An IIO mux via this binding
> https://elixir.bootlin.com/linux/v6.9-rc6/source/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
> (that includes a gpio-mux example).
> 
> Consumed in turn by a pair of AFE devices.
> 
> Then you should be able to just read from which ever of the AFE device you want.
> A sysfs read from
> /sys/bus/iio/devices/iio\:deviceA/in_voltage_raw
> will switch the mux to appropriate place then request the
> voltage from the iio-mux, which in turn requests it from the ADC IIO driver.
> 
> /sys/bus/iio/devices/iio\:deviceB/in_current_raw
> switches the mux the other way and otherwise the flow as above.

Since you appear to need to change both the gpio pin and the io-channel, the
mux isn't a perfect fit. The closest you can get with the current code is to
create a gpio mux, I think. You would then use that mux twice to fan out both
io-channels, but only expose the "left leg" on the first fan-out and only the
"right leg" on the other. Something like this (untested, probably riddled with
errors, use salt etc etc):

rcs: raw-current-sense {
	compatible = "current-sense-shunt";
	io-channels = <&adc 0>;
	io-channel-name = "raw-current";
	#io-channel-cells = <1>;

	shunt-resistor-micro-ohms = <3300000>;
};

rvs: raw-voltage-sense {
	compatible = "voltage-divider";
	io-channels = <&adc 1>;
	io-channel-name = "raw-voltage";
	#io-channel-cells = <1>;

	output-ohms = <22>;
	full-ohms = <222>;
};

mux: gpio-mux {
	compatible = "gpio-mux";
	#mux-control-cells = <0>;

	gpios-mux = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
};

current-sense {
	compatible = "io-channel-mux";
	io-channels = <&rcs 0>;
	io-channel-names = "parent";

	mux-controls = <&mux>;

	channels = "current", "";
};

voltage-sense {
	compatible = "io-channel-mux";
	io-channels = <&rvs 0>;
	io-channel-names = "parent";

	mux-controls = <&mux>;

	channels = "", "voltage";
};

What the mux solves is exclusion, so that the gpio pin is locked while
measurement is made on either current-sense or voltage-sense.

However, the channels from the raw-{current,voltage}-sense nodes are exposed
to user space, and it will be possible to make "raw" measurements without
regard to how the gpio pin is set. That will of course not yield the desired
results, but is also a user error and might not be a big problem?

Cheers,
Peter

