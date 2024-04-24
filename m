Return-Path: <linux-kernel+bounces-157589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690AF8B1341
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E090B22C40
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57EE1CFB9;
	Wed, 24 Apr 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Id1ZyGqt"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6891A716
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985813; cv=fail; b=ow+wReJA88X/rWFptsjxcCDVlO9YZ6I0dEJPhMxdQN1eddKpsPRFCXZM7QQYA1vtxqOzmhbfKSVRCrENyNtEEiE/QW4C5HIfNSMWNRhF6Tle2ii+/2D4WlrOUJaQ6XmeK6Uc7HuFG63GJjaNy8ZrhWibIDOyBmz51lVoDe4L5gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985813; c=relaxed/simple;
	bh=JtY8tQ+1QuO3zmpnTY4I7fghW9PnP7UtxV+vonHGN5c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q3U4IQ9QkOwXsFpYqi2/5ENfvU62uF/4FSfECCTg2Ci8DaI1LgystIvSdSLwkAcjOOlajKGbU1uQ166olTbNQa2M+AhulNfiQQqmMntsEU5gsQ2pYMw1B8yvmm21NOp9eldcY+YIHq635XtZxWTHRK1u+93XQaIFZLwNtlP8DQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Id1ZyGqt; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU0aYs4TTAlFA73kgaA4wkHhkysMDz29IwExZRzMh8r2eA1zYs14BXa4pkcwsmNbfV1qCJDk0w1W0rz/STCTPe9LR5moVfKZTySeZRYQBP52hXCHI8Pf8pMm/rby1Y/CKU4OJeknf0v+BepHXULtJLZg0vHsCt3wSs7WtlQ0L3LhcWHElbTIGZKmNFOX1N4bCWleP7DtTf2FYQvTAghtpdR1H6jGFPkjEhIR23r1sns7Hv/JaJ/SPCdcLbh1dWFq3cgkjIaAzOtuEZFpFE7TeH7wDxee2DfSJ60p64sXI9Ity/cpc84zkNnByo1AibGKgNx3+rX96xXUTGfsTs5gNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zwM5Rjma17Z3lhzSMsAFEptsm0lFEnQt1p+MxHhV2g=;
 b=d3PyOGa8fmWXjcig79dvzy9OFZ85nYIq+O8aoJw3mdpTLF4EZgoATUzgE7hatxJAXYa7vVie3U5dLmhBEqDAKWH1LJ6+OHOtNgzfKJ05hdkVP97iNfJw/fRz7ygj35q2G/bYv+8Fa56c1ao65Cc7M/swO6QZK8cjsea2Xp7mno1nUgN8jAtL2l6vEuNuaZg98RIyj3sHfUrsQwMwtagSaZCsSIWhL7Ac+fAhxV//bqDd4m7SHPVnRGbu13UL9EgvvPRg5wZV6aOB7OytGlryWyzarIoh/L2CuUh9IcnPj7taNMPiPpxTbs2b59l1iCeg1xVteW/nmtz66/HVEOhI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zwM5Rjma17Z3lhzSMsAFEptsm0lFEnQt1p+MxHhV2g=;
 b=Id1ZyGqtODAusrNawg3xPyh/BophY0m1nujQcpYs0REQZTR3BgkJ92gTKKjVKCjk3v8/0uecB8wXt+q07jhWdnKByxEN5e0CCtrQsnBron3FfR++VCJaHnocDYenRTgFtYch4Wbuu+mcQHPzUM5NKjnPwgIZZn7YubUDCNhzLQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 19:10:05 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 19:10:05 +0000
Message-ID: <c94d14e6-439d-4126-a44a-10a62ebf7d23@amd.com>
Date: Wed, 24 Apr 2024 14:10:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Apply RMP table fixups for kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, michael.roth@amd.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <20240420110812.GLZiOiHNP4Q6YmWOLl@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240420110812.GLZiOiHNP4Q6YmWOLl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 8895f4d1-c341-4523-6829-08dc64922648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlJPYTk0aG9ZQ1ltWHBsb1JYZGtvOHlmVXpaeHg0ckN1dzFrQytBeUQvYXE4?=
 =?utf-8?B?ZDlFc3I4dFl0SWEreWpwN2FrSzAxSUJ3Q1N5Rk5ud0VCTFg2MmtmVGNQMTZ0?=
 =?utf-8?B?UW8rcXNiY1pzRUpKUjBNYm5PUjBDRThPN204Y1g0aGdiZmlSY0QyWGhwcXM1?=
 =?utf-8?B?M0ZDZWJKd0ZsdXRxM1dvQnBCeVNuNzlxQk1PQ0REdlVqRjFoeGlLRGFlei9H?=
 =?utf-8?B?Z0w4MTJHS1RHTk9ScXliSUY5ZG94NnNSTGhKM3grd3FXdFFab084bnFDeXZK?=
 =?utf-8?B?QWVqaWlnVlJKc1hBMGowUTZORFlBclhPUlJLaFpWc1dDNVA4MGxkaWhYbHFu?=
 =?utf-8?B?VjBqRnJmVFRDaWdoT3M3b0lMb2FwNkpCeXhsSmZuQldJRkJNa0pSNWl2akVl?=
 =?utf-8?B?T2FwQjRRWTNRWW9RaU14c1VXakE0MFJQU3I5a2NnaWJxdE1sUDY0YlNIYWY4?=
 =?utf-8?B?VVh1RGtZRUVnVk03b2pKNDNrWEsrdFJyQmkzeEQ3Z3haUzV5QUsxSFErWEdu?=
 =?utf-8?B?R3RLczdraXA5Y1hMRUg4d2RQbE1hL1pLVUNjeUFNdmFoUXZFOHk4RVNYQUlX?=
 =?utf-8?B?RDlPRGJaMUw1bndjbGZYUlNHOVBxWHZTVW5kdzBJLzBIdlJUVnp2ckhydW1q?=
 =?utf-8?B?dzkzWnVaeUlyMDExd29jaDRsdmdZcHN6aGo4L0szOW4zalVOV1NuYnpKUzl0?=
 =?utf-8?B?TmkyazEzQzUweXc4QWxJQ3Vmd21FWS8xRXpQSHBMdXc1YlNLZFM4dmwySzRs?=
 =?utf-8?B?U2tncEpwSGs5c1ZVUU9qK1ZTMFRoMHAwVlRqM3AvNGxDeVEyc0Z5ejZkZWRk?=
 =?utf-8?B?RWE5clBMVTlWYkZJalNtSVBjczNXMGpSMHg3c1hLd1Z2Rlc0Q1QvUFA3aVln?=
 =?utf-8?B?ZHU5RmgyVGIyME5kMGZOTWJzRjJrZDdMTU56REFYOWZWejNKT2tVOGt3NHcz?=
 =?utf-8?B?RmxGSDJmS0hMQm5IczBKWGlhM2E0NVdCTGo1WXl3eFFtWDhxaVhURlpxcFEx?=
 =?utf-8?B?Q1B0M1l0MzZmWHlzMFFjdGFJZVN1SitlUDlidkFlMG1CbDhjTHdjRWQ4Wlh0?=
 =?utf-8?B?SmtMa3NEaU1jcXVTNlRDSTUwbC9udWlPei94TWJ4dDFDdEV3N281QnZsZUFJ?=
 =?utf-8?B?Wkp3RzdMZDMyRzBTZVdibkNZSlUzS3g3eWw3ZXh6MnAxUjM5dlp2bU5nejFu?=
 =?utf-8?B?NWg5dTZaUVZKcER6cjNDNXNYanlBN0lVMTBsS0dSc3d3eUo3aTNzRldnd041?=
 =?utf-8?B?MkZRSUpTZ2JSeTFVTGFiclhhbndSZ1BGNnRBMWl5UEtvTWpxcXZEWHZnWFNz?=
 =?utf-8?B?Y0oxc2o0dWpycXNjZTVxVENKNWRwWGdRcVJiM1FidFM5WGhmbm01anF4TzRo?=
 =?utf-8?B?ZHhQQWlkS3B5WW41V0hQcktpODlKZWg0cnU2bjFtSVhCbTZqQm4yTnJBRGZI?=
 =?utf-8?B?MHBHa0J0SE5STFBqdXlHWjBIbmxZZm9Jb2RWQ1NOK1p6TnRpSVRaVnQ5djIx?=
 =?utf-8?B?WjBJTE9LTVdQZXhTWUxLK1Y2bGgxZzA1OXRPdisvMVVGc0daR0JrWVUvKy9M?=
 =?utf-8?B?cCs5MDNhc29ZVkNxOWhUUnFYNUtWWG04VFVaTEFHcFJoMDhhUExaNE1ncE5l?=
 =?utf-8?B?QTZlVXpJbDdKZ3lRaTE4TnRXbXFzRmJrTmh3ek9ZVk12U3h5d09PSWZFeUJO?=
 =?utf-8?B?eTVFV0VzNGRxVThVQXFzZmpXTC9XY0dNNno4dEdpc2F6TGUzdU5YZS9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU1HSy9hY0RFSDIzQWxDanhhQnU5YUQrR2FUL0hMR1BVRGc0bERZR240NERR?=
 =?utf-8?B?ay9aMWhqTlg4TFVnMXNvZGlWQTNIdEl3OFp4MGUzNVMwK1Y5NUZic1ZRa3NM?=
 =?utf-8?B?K0NhaXRWUzV6ZGY3SGhOc25kbXl2MVVYS3VoSXFvUmdXTkFGdTUranNVUUIw?=
 =?utf-8?B?NWJFc2cydVo0TUI3ZnJBVnAyRTBaNGNiSSt1djFGSDVoSEpWcjVyZDFrdEVt?=
 =?utf-8?B?Z1Q4eUpFbkUzRTdxWnRaSmxWTnY0V0Q5TDMwRmI2d28xdVlIOGJNaXlQWnFw?=
 =?utf-8?B?Qkc0elpyaEE2Tjc5bVc0OFp2M2lzczQ2bmtxSS9vTXhlRXJ3N3BPZzVtOGhM?=
 =?utf-8?B?RGFheTFueklBK1dzRS9Hc3hmbXhYSXpZQ2hYYUh5QmdRSDNjTWljaUVHUmYy?=
 =?utf-8?B?Ri8vblFnR2oxSWNmQ0NGMlljcTJ6L2Z2S1lKTmduMkRrNEJWTmQ3ZjRPMUhR?=
 =?utf-8?B?ckMxUlIwb2VHQXZOV0NDbDZvQWRJOUJqNlZDODBjM0RVaHB1SGRobTRiK3Nj?=
 =?utf-8?B?a3MvaExxY2lrVmRaSnVOd3VYZEVpdDZUOUREdUZCV1U5enV5Q1J5YmtjaU5n?=
 =?utf-8?B?MWZkWFRUclR3c2o4dDVOVHFHNzU1dXk2dWdxMnBHNWNoeFdtSC8zaUszVXc4?=
 =?utf-8?B?bEMrTklNL2hoZUhuTmhhL0hkcnhVenNOcFRLYk1KNk5DL3hQdU5MNmdDcGp2?=
 =?utf-8?B?RjlCUGNmeDVtTnRBcXp3UUNTZ3BaM0crSkF5a1Y5Nm5sWUJjMVBvVEZqSUhR?=
 =?utf-8?B?S3dEdm9LWEVadlpPQml0NUh2YXVnbDRhd0lTMDJ6SnI0N1ZLZEgvVzQvVFd0?=
 =?utf-8?B?a1c0Y2ExMnRzeHFDaCs2R0VFb0tCUjJBbk5pc2JnYSt1L2Z5UVJiYXBmTGpF?=
 =?utf-8?B?SFY5djlCTEtkaHBJeFptY2UvQnBlMWltSVVSRVBHUm9JaWgxOHdZbm00YXV6?=
 =?utf-8?B?cXlmMlRVanNMTERpQzhKc1ZOdUp4UU5ITXBRQzVLeDFOdmZPY0psSHdTREhi?=
 =?utf-8?B?SThwenJwdkRtOXRYRHlRTHErdnBwejVvUTl3eHpiS3dZNTlncjNyaFcybHZv?=
 =?utf-8?B?T2hHREJCV3FSTGdqN04wVU9YYTcrRm45SDF6RTVoV3lwZmkvSnd0MHJmMUdp?=
 =?utf-8?B?THp0QkQ0amtaek93SjU3RHpQZlpNR0VWK2ZURWRMR28wdTFvV3RDRTBBckFo?=
 =?utf-8?B?MlVTK1JiVVdYTE5SVmREMmxpS0lQU2dnL3l1bC9XejBKclQvYkRoY1NBNVJE?=
 =?utf-8?B?cEVyeTRUdmtQV1V2N01zc0ZKaElCY21GVE1qbVAxa2RaNjgrRDhMVHR1SXd6?=
 =?utf-8?B?L2M2MHFvdFN3NlFqcHE5dUF0M2FQaktLK21zRnBZVW5Hc2xXV1ZGWFJ3TnFl?=
 =?utf-8?B?cmt5Q3NMZ3hLZStlYzJ5ZHM4M1YvMlcvMjh6RzJISzV1alRSNUNwWGtvS1lU?=
 =?utf-8?B?Tit3UHZZSC9jTFYvRDEvaTUwY0c2UzNSdmZXaUpaYkRFUEZtUVZSOE9FQk1n?=
 =?utf-8?B?b3lnamFPcDhuRWJ6V3pWUnZSSzJvYm1acnQrVVQ2M3dRdklMbEVKWHY0blZy?=
 =?utf-8?B?R0VjUGp2YXNXcUdKbS8zTlRCVHFFVXRvU1FTblF3V3lKaHlNdEFLa0JvelBu?=
 =?utf-8?B?NzVnWFZTTkxqRE1MK0I5WU41VkxTOGJJcFI5SkU3Ui9VMXF5YW1seENMZVdX?=
 =?utf-8?B?ell5Qk53alZmWGhUc2NjbmxDSy9OUmQ3bWozaUo3ZmVXWDJwZnNLVytMVVlM?=
 =?utf-8?B?eWlyNXlDWjNzWjlVZG90SXArTUQ2MzR2ZWVTNDk5ZGRQZllZaHdOaTUwaTR4?=
 =?utf-8?B?SWhOL1JqVTV0YVZsRFY1OFNiRFQvam9XelR0Q0lGNkRtRW9ZcnFxYm5FaTgv?=
 =?utf-8?B?L0ExaTZNTzhBaHV2WmlFUDR1bVh3cGYrNmdIT3dpVjFPd2JIRFlyU0ljWXI1?=
 =?utf-8?B?ODBIUDY2dE15UHlzaEp5UUI2enVRSTVXdFM4bUhpbStjL3hqUXVRK1FsOWFh?=
 =?utf-8?B?Vkg5MUVlODlieWZKZmtreTh1cWllTlRwUTNpdGhZS2FzSlM3RTNRN1d2VVI1?=
 =?utf-8?B?VUlyUHRVMEUzK09YNkYwdWwySStLc1VBcUxMLzdMMGhEd0J4clN6aVJ1WU9j?=
 =?utf-8?Q?ueolSI8mSbfYqXEatK3kEHlvi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8895f4d1-c341-4523-6829-08dc64922648
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:10:05.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5nbcecWGT6s7fG60ivTkuiFcuvwdhbKuKYrFPCF2O38hr7+7hbv0sVQA99/Pr/yYE6Y2RLqU3o0K649pEV40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

Hello Boris,

On 4/20/2024 6:08 AM, Borislav Petkov wrote:
> Drop linux-tip-commits@vger.kernel.org from Cc.
>
> On Mon, Apr 15, 2024 at 09:08:56PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> Handle cases where the RMP table placement in the BIOS is
>> not 2M aligned and then the kexec kernel could try to allocate
>> from within that chunk and that causes a fatal RMP fault.
> Is this something that happens on existing systems currently so that it
> needs to be fixed upstream?

Patch 2/2 - includes the following Fixes tag, do i need to include the 
Fixes tag in the cover letter too ?

Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")

Thanks,
Ashish


