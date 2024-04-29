Return-Path: <linux-kernel+bounces-162589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DC8B5DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A5128A63A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4704F82D62;
	Mon, 29 Apr 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OY4gJVyC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E79823CC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404585; cv=fail; b=dDIx90wcKNd8ultnb1m3fbHKR3RzasuNaTrd4rwSy1JFWUA+pF1osPpWPL0Pi9Cj0PIsA8ya4osluB2peBV8FPTGpPonXr2qTgyk5C5pv+tpbBXx0txFZiKu7LWcloF7/eXce9QTb0j5+RMov0YxQ+ZbUMWZRc1h5MPIQcgLLL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404585; c=relaxed/simple;
	bh=7FPL1I0cN7BoFc20UyVH8NhxEnaUBA39IPHHorkPD3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7G51hhXFWBhg/cc/gkd4USpCMkrlXPJrI9KSrYv1dzF2j3AwF5MdxuR2jngK/JCG6WVdG2z1UMAqA65M+JrQT9Aa9ALCyfNcjBgpieUQ+chcCCJWrShJuGIafcXjRe+GcT3EYqNOrZaUgoR8uX9zXdcbW5QuoyxdQb6l09+ijs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OY4gJVyC; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0ztAXith91Ry3kB3hhfDKBRfHtLpEDQnkRwSlW8YmWSxQN7a4hHnHzG4Jvqm69mTdXgJQY2rBhEAP7d4PAJJlecoLJl5mpsAZ/jT0Z0BNYpBWJFgIBv/wHxC3ByF3K5jLnVDD/2OS9WTOQPHT+bfdtUYcyQ9hqIktCeuY9TOC2Pfadnl0GqzA+oaZzR70V5roJf3ejFLRUrx2IgY9uRrZUZxEFOAuE+Rw0xuotWWwRtbp1ZuhaJA43HbGQr5IDppcC5kyhXJ22Jp/U0rRzXKSBYIjGuhBULjlof3iZ03NBHtKvnE3jaOQwoRfXrPbZRhqnBRzw6itJ0UnJRjNTnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jrv4R1D8NcF/cIKzfVyMhDSiozmO7/WefqthU37gPug=;
 b=js4Uf2p6olN3g9fM+8608DlJWcPD0dRl1OU4grDp3ajx03YVL914Pleu4bluYwzAg+tjBkscya0gay7sZZs4SrnEqaXbbkRfy1mU9giddJ4TRnXYi7cdQm4mB+dl5W5inlJgN2sjUj2+T0dj1OOMnZyjksKjENHVWLgyzSIk8iXwymW7p5cVRggZhW3aHvPxIs8+dX8XMx21Ft4DIDEyf6kOT19wY+suY4tZcyi7N/B96jomwJNLNqENkAT/4opccRpVXhHsfpfib9dGAFb5TQ5ONL7HnaprAf9hi+zxaEnFROUlqPvneXVA8Qc7gwpUmScXZymBe/vemXGi+zoxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrv4R1D8NcF/cIKzfVyMhDSiozmO7/WefqthU37gPug=;
 b=OY4gJVyCWm5xBr8LsccGZIG4iOVP2j7y/FjNh1wJUJaH3QAOg2PXTwTrXEkrdJppxKsyu3Y16v6BBFdVIarIXMWyCdDv/g7RezekoRbC5lqY7OjS4ZZdndJbySOFOsOaHRyvu0KLCYS9oRXdq2gzh8ebzNXWt4jBl6QL5/l6tsKS8qwsUjim32mFaWfM4Xq59SHUFDKkrueZjv4pxf0Nd/QYwKQ4oGcc6WC0/B62QyfgJKVo3FwfE++kFTs9y0nC0k4ZOwb5IzBjq69jcr8WAAfHS8YD1Ndl3c4xpnujiW1NtpcRvnkV0v9TU89UJbJtQ2FfvUw2h9ZfpmjNq48GmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Mon, 29 Apr 2024 15:29:37 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:29:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Mon, 29 Apr 2024 11:29:33 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <F7C88EAF-67B7-454E-A083-3A68A8BB27BD@nvidia.com>
In-Reply-To: <64037B35-3E80-4367-BA0B-334356373A78@nvidia.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
 <23fbca83-a175-4d5a-8cf7-ed54c1830d37@arm.com>
 <64037B35-3E80-4367-BA0B-334356373A78@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E6212A9F-003E-4B1B-9273-B9B52ED02B95_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:208:329::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 8990ad65-ef76-4cb5-3aae-08dc68612d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WllUYVRReStESmgrclF0TURMellWOGdLM0tpdEVxenY4b0pHNGZZR3R1UVJ0?=
 =?utf-8?B?Zm5pVTJpWm51bFJkenNHWG9BOGd1QlNQcGdqOXlEVC8xZXRubjA0UGZMaFNr?=
 =?utf-8?B?RllOcUdHeFVDcFJqVDRFeDFTZy9seTNjS1BqYUQwT3poNHpOZEZXWi9lUHcz?=
 =?utf-8?B?d21iUWpLb1NCdjNsZDhSM09wWVA3ZWRRZ1gwZVhBeXFER2FIdG8waXVZRGRE?=
 =?utf-8?B?T3haUTRQTVBRRFZPYUhTV2hBc2lER1d5WGVYN1pLRlRDb1M5MEh5dm0zdmMy?=
 =?utf-8?B?NkZCblVBUzF3SWlwTTlHSEpXNlA1ZG91THZzZEdEb1paTzBXYm9FZ2pONzlK?=
 =?utf-8?B?emV6dTRJeURJSXplc2RiVHdiWWdKZTU3dHdmNGNWdFhTdDkvSUdUMmlGSC9z?=
 =?utf-8?B?bE1YZU53UWtYR2JQS3lpRDl1UzY3T21SWlhmMFFwN3pBYU1MdHRHZUIyaTVR?=
 =?utf-8?B?cmhSRmp4VGVONTFuL2NwclFDby9uOW5RWWRkeWJaUFhVSDZZNEp1WFVtN0J3?=
 =?utf-8?B?OVNGVm9NNklRRVJaWkt5azh1R2d5amFFMFZDeHZvcWd3WnR1N2pvVGppc202?=
 =?utf-8?B?SlFXMDlSeHU4ZXpKbEwveEwyNTRUN1pIR284MUlkNnpaYm1kaU9KRVhjbE4w?=
 =?utf-8?B?TXBsR3NvanF6ajFYeWk3WnU5TWordFFrR2xuMlVNTXNkV3hHZWgvOFkyTlNr?=
 =?utf-8?B?dGdvMnFBUyttVVYwb2xzeUJYYlJNczI3K25ERUIrak9SWFBwak9pd0R5ZVF5?=
 =?utf-8?B?L1NtelorSGxLM011bDZ3eUlHNkg5QnpkblF5Y3JVbXZmZVd2M3ZvWURiYmUy?=
 =?utf-8?B?UlMzZWMrenZSWlg3b1BTSUVlNy9ubi9qbE16bnE1eFlHSVJyM1ZwVTJzVS9r?=
 =?utf-8?B?NFYyYkducDRIbm9Zc1RkZGdMdmoyTWY4QngxdndUaE85dldURXBsSFhiUHZ6?=
 =?utf-8?B?cVdBRWJWUEVVYWNqMTYveG9BK0cyQjZHSVR3Z1ZkNFZLT1BNSmFKbzZhTlMx?=
 =?utf-8?B?Q0wvckF5RDF6SFozNzdaVTNmdUV3MFF3ZFpXazY1cWhMS1FvMmlZUUM5K0xx?=
 =?utf-8?B?R0Jxb1RoN3RiZWtNanlSS0VUYXFPNzhGTGZzbWV4Q1BYYmt5ZGZ2YlQ3VWxN?=
 =?utf-8?B?MlA1UFZYQmYxOXBqSHB2VzAvV3plWUhwbDV1YU9CL0lzWEMvYmJyWmdqbGMw?=
 =?utf-8?B?cDliVG1kV1JDbHBvNDF4anNDRUVIVHA3MktpNWV3eHh2NUJDbjR2QjRQNUo2?=
 =?utf-8?B?Z1NNdHZQNTlNOUROd0g3OFMrQklPY0FadzlrZnFOS211dExJdWExY3BSNFFE?=
 =?utf-8?B?QUdBSGdlVDh6SW5MVGFTWS82Tk9SSENabGR2UzJqRmdYK2NpU3VQZDJpSHdI?=
 =?utf-8?B?VG11NGc5bVBLS3FMU3lhR0dXVFlZYWVaU2FQY3lOT0R4WDduVGxmS2ZjWkdm?=
 =?utf-8?B?bWFRRWtqbFk5R0M0dlUrTllNV3dzSURGeVk2Z3NQYVA5N28vQVAzbnd5VEo1?=
 =?utf-8?B?ZUdmYmVmYlJoRmljcmRhK2kvRjVKdjlqOCtWeFdaU2RiUEJpRGo4ZVY3MHRL?=
 =?utf-8?B?QlBXVEFpYzhFTDJuZWppNVlXOHRJYTF4a052WGhMbzNab3pPWkhTMUdaTTlU?=
 =?utf-8?B?OTVwanUzQU9PbXlYSjcxcUtKMGlPRE1iOTlOWk11dXl5MXF4UzMrbUk2WUND?=
 =?utf-8?B?eE1aNUQzNDd5ZExVS2pFYk1SMTRXVEt5anVDRGJnMWNqbGUyUnFpN3N3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDhJZmJJcXNueUtkN0N0VTRYK25aWVF2Q2dIRzJuMmZxTmY2eWIzNUl1ZFpu?=
 =?utf-8?B?MWhkMFhKQTY3SXlrUFB4RHdXRFltVWh2L2wzeGNqemx0M1Q1akQzWU1MUzZT?=
 =?utf-8?B?dmwrZ3dzbEY3SFRRc1g0RjZKWG0xL1lieC8zVnZEY0VvaVlOTitXcmVsR2I5?=
 =?utf-8?B?QlpKT0NwN2pBU0E0aWFlZXI3VStvaDE4ZXNyY1VJMktvekdmaXRhMFZRN0JC?=
 =?utf-8?B?NmQ5QWJTcnJneFdhV0FoUk1mSGZ5aW5VdVhBQzk0L05qVUJKR3IyRUtsMU5E?=
 =?utf-8?B?S2FWYjk0UXFpZXhsYzlUZXhPSGZMSHY4WGxySDN5VzR4cnhCay9XdzQyM2g5?=
 =?utf-8?B?NVFHU0c3WWdwTm5aNUo3V0RkSEdZY1hxR0hPb0xMMlM3aHdyekpvVTQ5SU4x?=
 =?utf-8?B?WkFqV2F1RXBpNGg0Y0Q1cWFobEsxR3lTMlQ1c0tlVE9zREZzRzVES0JONTJv?=
 =?utf-8?B?Z3RUdGZCWWg2NE8rV2FMUkJtQlJaMGY4bi9nSm5wYmpsZjBPSW9UbGxPS3lG?=
 =?utf-8?B?VUNYeWNTUzlpOFZSZzE1dlhSaVJrSFUxSTJJNUV4L1p6VHJiSkRrQnBsM1NP?=
 =?utf-8?B?Y0RxU3FDalR2TlU2b2QvQ3VkVFV4TGZjQmMyUUtFdFZxRklSM3NHd2dCZzB5?=
 =?utf-8?B?RUhmZjBhUGRaN1ZZcmM5SVFxN1FxQW02clJUVm9IMXFhN21sZGZydS9iak5n?=
 =?utf-8?B?amM5N1BBeDN1bk9GbzFWSnpaWUxmL1ZGeXJRUmNCWG54Qi9pRWw3QTE5aGNy?=
 =?utf-8?B?MmlZeUJ2aFRPaEdhSTlmazJXQWJ1K1FJM3JIOThkZ01xYmhFZWQ3dWNwS2VK?=
 =?utf-8?B?TzQ1YS9VOFpuZS8vSk9hTXd6UmxqNlQ5ckZnbkpsd3k2ZlV0ZDBKbFV2Lysy?=
 =?utf-8?B?K1d1WGF6UkI2QkZGWjE5bElwcHoxNkphZm8vclpQVzR6TVhyaE5yRHVNdUJP?=
 =?utf-8?B?eWRhMHdLWGEyKzdJZ3IrQ2Nlc3UyUDFlV1VXcCsrL2NibTNNQ1JpTVoxNFdE?=
 =?utf-8?B?a2lXaVMyeVRydUJRQXdTV3ZVUnhDOGdRckhxTHZkWlgrYXdoRjFrT040dnpX?=
 =?utf-8?B?WjQ5bFN4aFA3emtXWGI1YUxNZERkZDUxWnlaeExSdDI4TytZS08yTUJ6R0xn?=
 =?utf-8?B?R2xzWDJJcER2NUwyNnhBVkMzK044OFJIV3JBam1ha3FkckxEbXFhWjlVVGNR?=
 =?utf-8?B?MFphS1hhQVphZ2lCYXFRMldBMGdySG00TFN6VzNkdXlWM3A5UFBJZzM3cjBD?=
 =?utf-8?B?MlNsWW9VdWdTRHl2QnhTcmE2SjhWMU0rVWoyS3daWk5hZDYxc2NGekFiTUFR?=
 =?utf-8?B?Nnc3Q0kyN2JwbWQ5UHk4cllIQk9qMUluWUZ6UmxEdXByRStkZU8rM2pEY0lk?=
 =?utf-8?B?SXN6cE5WSmZYNGJlSDZwU2lHdlMzamE3UFZVV3lyb1VZajJrcjdwMkdCc0tk?=
 =?utf-8?B?NStlckFKN285SEM0M1lYV25xblg4OE8za2QycS9MYUpaTTBxUzNmZk9jOW8v?=
 =?utf-8?B?S2FqVW1rc0ZNMEhsNU5ETE9ZQWsybnVpZyt0NUYrQlVEM25pa0Q0eTBYUHdD?=
 =?utf-8?B?TStyR3pRSjBSNE5mQUcxVjVRT3A5dGtNS2JsQUhYTzFQZlY3VVdPMks0SHpS?=
 =?utf-8?B?Q2JlZUZPWnMvMUJEWEJ4Z2RyK0FqekpkY0IvRWx0TkhsZXNLa1hiZUd4emV5?=
 =?utf-8?B?SXFYZjlpRFNmQnZhOG1WRXRmaW1ZN3U4QkxkSFJ2UDR6U0Y5SE5TeXdHOTh4?=
 =?utf-8?B?RHNDbENyUUxuaXVFSmo1THdkSk10Zis2QTlMRHhSbFZ6YjRHVENJTDZESVZV?=
 =?utf-8?B?UWhIMllTNEVKWW9xWGt1NU9UNW1qa0JCK3hleGFTZWRHclpHODZZVlY0VEl5?=
 =?utf-8?B?TmIzL3Q1UENzMzVUUnkzRmw2L1JxbVVFSTZRYjlTRmQwSSt5LytHbVU1QklP?=
 =?utf-8?B?QXJ2QytncTdoT3BPYjFIMDZtL1hsTjNySzNNd01IbmRzYlVhSXYzWmpaT3o4?=
 =?utf-8?B?YkVLeTlONko3UURjNHoxWXBLdDRjMUVaWHRTSFduMTBtelEwdUJhSjFVQUlq?=
 =?utf-8?B?K0NpN2tqRzFGQThIaVVWem85bS8ra3IvV0JnRGQ2R0FvYmp0VVZ4UVJFQWlh?=
 =?utf-8?Q?+WqXMsQtqph203qKzmx1qGI38?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8990ad65-ef76-4cb5-3aae-08dc68612d1e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:29:35.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6pR9CdE0V0oNQeAZKmSrdUKN/jwIC9sKZ5WcuDvQ0DpoHjlMNIt0gesA2haB7HK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567

--=_MailMate_E6212A9F-003E-4B1B-9273-B9B52ED02B95_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 29 Apr 2024, at 10:45, Zi Yan wrote:

> On 29 Apr 2024, at 5:29, Ryan Roberts wrote:
>
>> On 27/04/2024 20:11, John Hubbard wrote:
>>> On 4/27/24 8:14 AM, Zi Yan wrote:
>>>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>>>> __split_huge_pmd_locked() can be called for a present THP, devmap =
or
>>>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>>>> unconditionally on the pmdp and only determines if it is present o=
r not
>>>>>> based on the returned old pmd. This is a problem for the migration=
 entry
>>>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must onl=
y be
>>>>>> called for a present pmd.
>>>>>>
>>>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any=

>>>>>> future call to pmd_present() will return true. And therefore any
>>>>>> lockless pgtable walker could see the migration entry pmd in this =
state
>>>>>> and start interpretting the fields as if it were present, leading =
to
>>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable w=
alker.
>>>>>> I suspect the same is possible on other architectures.
>>>>>>
>>>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And =
for
>>>>>
>>>>> Yes, this seems like a good design decision (after reading through =
the
>>>>> discussion that you all had in the other threads).
>>>>
>>>> This will only be good for arm64 and does not prevent other arch dev=
elopers
>>>> to write code breaking arm64, since only arm64's pmd_mkinvalid() can=
 turn
>>>> a swap entry to a pmd_present() entry.
>>>
>>> Well, let's characterize it in a bit more detail, then:
>>
>> Hi All,
>>
>> Thanks for all the feedback! I had thought that this patch would be en=
tirely
>> uncontraversial - obviously I was wrong :)
>>
>> I've read all the emails, and trying to summarize a way forward here..=
=2E
>>
>>>
>>> 1) This patch will make things better for arm64. That's important!
>>>
>>> 2) Equally important, this patch does not make anything worse for
>>> =C2=A0=C2=A0 other CPU arches.
>>>
>>> 3) This patch represents a new design constraint on the CPU arch
>>> =C2=A0=C2=A0 layer, and thus requires documentation and whatever enfo=
rcement
>>> =C2=A0=C2=A0 we can provide, in order to keep future code out of trou=
ble.
>>
>> I know its only semantics, but I don't view this as a new design const=
raint. I
>> see it as an existing constraint that was previously being violated, a=
nd this
>> patch aims to fix that. The generic version of pmdp_invalidate() uncon=
ditionally
>> does a tlb invalidation on the address range covered by the pmd. That =
makes no
>> sense unless the pmd was previously present. So my conclusion is that =
the
>> function only expects to be called for present pmds.
>>
>> Additionally Documentation/mm/arch_pgtable_helpers.rst already says th=
is:
>>
>> "
>> | pmd_mkinvalid             | Invalidates a mapped PMD [1]            =
         |
>> "
>>
>> I read "mapped" to be a synonym for "present". So I think its already
>> documented. Happy to explcitly change "mapped" to "present" though, if=
 it helps?
>>
>> Finally, [1] which is linked from Documentation/mm/arch_pgtable_helper=
s.rst,
>> also implies this constraint, although it doesn't explicitly say it.
>>
>> [1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com=
/
>>
>>>
>>> 3.a) See the VM_WARN_ON() hunks below.
>>
>> It sounds like everybody would be happy if I sprinkle these into the a=
rches that
>> override pmdp_invalidate[_ad]()? There are 3 arches that have their ow=
n version
>> of pmdp_invalidate(); powerpc, s390 and sparc. And 1 that has its own =
version of
>> pmdp_invalidate_ad(); x86. I'll add them in all of those.
>>
>> I'll use VM_WARN_ON_ONCE() as suggested by John.
>>
>> I'd rather not put it directly into pmd_mkinvalid() since that would s=
et a
>> precedent for adding them absolutely everywhere. (e.g. pte_mkdirty(), =
=2E..).
>
> I understand your concern here. I assume you also understand the potent=
ial issue
> with this, namely it does not prevent one from using pmd_mkinvalid() im=
properly
> and causing a bug and the bug might only appear on arm64.
>
>>
>>>
>>> 3.b) I like the new design constraint, because it is reasonable and
>>> =C2=A0=C2=A0=C2=A0=C2=A0 clearly understandable: don't invalidate a n=
on-present page
>>> =C2=A0=C2=A0=C2=A0=C2=A0 table entry.
>>>
>>> I do wonder if there is somewhere else that this should be documented=
?
>>
>> If I change:
>>
>> "
>> | pmd_mkinvalid             | Invalidates a mapped PMD [1]            =
         |
>> "
>>
>> To:
>>
>> "
>> | pmd_mkinvalid             | Invalidates a present PMD; do not call f=
or       |
>> |                             non-present pmd [1]                     =
         |
>> "
>>
>> Is that sufficient? (I'll do the same for pud_mkinvalid() too.
>
> Sounds good to me.
>
> Also, if you move pmdp_invalidate(), please move the big comment with i=
t to
> avoid confusion. Thanks.

And the Fixes tag does not need to go back that far, since this only affe=
cts arm64,
which enables thp migration at commit 53fa117bb33c ("arm64/mm: Enable THP=
 migration").

--
Best Regards,
Yan, Zi

--=_MailMate_E6212A9F-003E-4B1B-9273-B9B52ED02B95_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYvvN0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU5EsP/jX9kKlvVVMQIlhUryVCz2PvipCqXDttfBAz
+5j3ZUiVectXBVKmEmDFk7Iaa0oVDfmYgaqEXDM6r2NL5fKfl56id5selREupYWU
c94IsoGcIxFZX9r2ZW1iLDeZtXX92hUG+6iZD8D7J3kcUr0O2vkbs49zmEmlucBq
pB+iqdct7+4cefLoSEc7qkvmfW6b6WQ7Shn0LIz07iLLgfY0d7ovVJno7zEimaXM
txwSb9qR4Ei5agrrLadIwmA2roRqGzw5DpBHHlZpauD+oJUc4MC2GFeHo+SJw9C5
aOdGMJ+Te8+LjV9Rwkg/CMAS7MXnljItGjD4dXQ7zNFawBoA95hmKIChl/0u7QuC
vONQ92x/igi1/CCz9cjcJre+RsiILKFHMWaUGQHskdKc7acyvIkb/V74eqSc3bFt
BMbIojEYTZzQdX08fSHpp43acC1nUEL+Uc8GRaAT3jZKwFUot7wyybhrT8SMffWE
fMcZssuQ9fzJdFy2+hYR9cle7O0eHrTmHhYUzNnAQJz40G4TwiksDTwcV6zUB/iH
Wr7He2PfKlbIxMXEgmb8RE+GCW43Z1wNvo1Njtn0v5ly52N0Qj3Aj/IOw5HIBOQ+
gCASzf+QrmhU+IujZtTrkSnej1Kp0vVEd+eNCmmIDMI+3swZqlwKYVe3s0wNOC5v
lwMgYhAz
=C5Cs
-----END PGP SIGNATURE-----

--=_MailMate_E6212A9F-003E-4B1B-9273-B9B52ED02B95_=--

