Return-Path: <linux-kernel+bounces-155789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54C8AF720
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29C528FC78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31851140394;
	Tue, 23 Apr 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wz8wtpKc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57213E031;
	Tue, 23 Apr 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899813; cv=fail; b=fK//3qb1Q9ZNj/YDLBF3DZC0phFvbsMmUoL/fT2096Kz3Tsxc4b1vBJDsbL4FTxn3HTpNsknBnu2sdZ3FAzQ31tkbNkqK82VjZSMbc+0qhmGavSsbSPSGP3hAK3jvs4mXmg50KxY4LUhDPPmSRR0B/+tLK79gKz56QqklkLpBp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899813; c=relaxed/simple;
	bh=o1667HkmOxANeiD67xNYLdcQT8/JCF8/4d42IRkJqQ4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GZG6m1OWTFI1UkkKLrd/dZdIqBCkfeWrNz3F5Y4JSIsSgiP+f7qFeRDlQY4nG/pw+xgH/A2E1QYFJ8bWavA/necwNrzflRUK8pWbWSeewAvlbJ6rC6ZhWSQOC3MGU5RyO4go/+kczxNddorrnO6bm6lOSo90lj+Z5X5RyvIWjq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wz8wtpKc; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Duox8PjqRuXKZB5WIUSGbC+Tmhg8+Oolo0W5p1aspTM4H/imgCrtwTLwhW5x5ClybwBiRmptiYT79hl722/a8qtmTR42oazOAmeEnB9XiBiNUqTcBwwM1ULK3s5VeHYGeuu3G+hSvn92CDYYPNTzbQC5zHasR0j9zzSfO5HrU1hiZRs7quJEQFFxR1plybiGFlphRiV/YLo3Jybbyd1/j+1Lf6AwuE8olyO095f5OfmndiWsKCHt5qLotBoCPGB5wsN5I7f9OVEqYhEhgngDvBUM/Qp4HURh6p2FXPZ9ZuI8JBJEPPkLB5DJ1+izpNfmRbzCm1ac42USopbXMjm4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK6fPEckKZJjWsOg1S97lDBq1OWdiUauxctUj+wYTOg=;
 b=OHzJUrrUqvJ+gzSqJFuOeFTnIu1XqkMCYXeAC8fzvI30YPjh8wrLK5P2vOSGZQpPORbJuS4bgYkyJ7LYumD/vA4Kkm4Nz/RXPhieR4j6bjWXixpo7dPI/5SskZhWFYFP0LeYWvnYC7MQhjY3t01AKaj/SuZIdbPuYNHSPbOxEism3sdN/DowK3qHSkPqXO1DAPF8MzqLPlmX+WzWQgjheeqsIxTPPdxads1OVLGsNDtp7rP7/S+X8KgjLIDwBrNEKsewZjvCrBrxwHbRoVKkqnJIMswCsNKQs8byYRVMzo61/s8dFaYTcHMKYTCW1LolfrXpt9oKnurVU0kT+v1pRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK6fPEckKZJjWsOg1S97lDBq1OWdiUauxctUj+wYTOg=;
 b=wz8wtpKcOM+YGMPGSc2DoXdyYUWAzW9P+fqfP9feHyoEeMwxd16YGXdlVYtuCzpfnfOqP1tKIgV/ntp6zd6IclBytY/9r7TkGInB/FYxh26+RaiRXi6Zhh9BA05j68piaor3jvNKvch4IYafsMkxkBwWVKuJUaFxPKGJ7mDcpXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 19:16:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:16:48 +0000
Message-ID: <56f9a311-a786-4586-8b9f-4db918667434@amd.com>
Date: Tue, 23 Apr 2024 15:16:46 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 04/16] x86/mce/amd: Look up bank type by IPID
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-5-yazen.ghannam@amd.com>
 <20240423170608.GCZifqgD-N2B7vm6_D@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240423170608.GCZifqgD-N2B7vm6_D@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:408:e5::27) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 725e068e-4452-45f5-2c72-08dc63c9ec63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHo0S1ZoSlRQUlYwTEtXNzBHSkR1SXBEWlBKR2JoVG9HOEFXUWQyaHZ0cnRu?=
 =?utf-8?B?ZWVoYlVHSG5OYmVCbXJJSnBUOHJEc2NJd1BKT3pOQlpoMEJzdDc3clo3ZzJY?=
 =?utf-8?B?ODYzbVZmZS9XOWg1bGY0dnYrcUMxcHFxTUxiTDIvR3NEbTJrenBiR2RlU0hU?=
 =?utf-8?B?YjZTQU5Uc3NIR0kvcFgzR2JDQnVZM2g4eXBoV3NqRk1GZi9xdnVtTXBPcWQr?=
 =?utf-8?B?SjBNaDNuenZTVVVwcHI3aTM2bGptcWJTb0dzQWxiSUMwWWVmVlN3WjFmbUZL?=
 =?utf-8?B?enVJUHI4YzVmRUlUMC9iRms1VitGbWRmTFhGYkppK09ielBCN1NsdncrS3ZB?=
 =?utf-8?B?Yjg1MkYvV0hTY3FxZXRwaWplK2pDMytVM1lpdlVpUVBiQUdBbEZJUEZBUDAv?=
 =?utf-8?B?OGdlNUpzbVpZLzhFbGtXSnZNN255OUFJYXVBeDJ0UklON2Fycm5tc3owZWNS?=
 =?utf-8?B?TFpJcE1oRXlWb3JVc254YUxEbHQzT05ZQjI2c092bWVqQUMyRnMwTWlickNV?=
 =?utf-8?B?b21PblUxUmdnalp6QzJ5RWl4L2R1SGNxL0s4bU5jc0NPc0RMR0pVOEJsWjVC?=
 =?utf-8?B?eXVpMk56aysvdWdZVHlnSmR0NDlEWmdLbWltUHAram5adjd0Ty9GdHJJZ3NR?=
 =?utf-8?B?QkFYUlBwbVgycGd5Y1VvTzNqdVNMRWg2V0E5aUxrWEFVbXQ4bEVQb2NxZDRE?=
 =?utf-8?B?ZEJXSnFJMzV3N3FsZG1nSTg3aGxsdmtwdVl6SDF5eHgzTUU5U2g3R3Ywam5I?=
 =?utf-8?B?S0J6MlgwRURUQXB2ekd4d2N4aVlMMy9YWS8xTjduNzZ4SUdMaisrY0JrN2Ir?=
 =?utf-8?B?RjhkMndBZFZiSE1QbzByVlJ1Q0d1Um5PbmIzU1BGNXd6em00YWZmSGRkanZm?=
 =?utf-8?B?MWFqY1pPcTNKcEphNm5NREtHdTF4SmJTc2NqOEt3UmV3c1J0WkcyWTBhSExz?=
 =?utf-8?B?eUFwUjFSRGFxRVdlenVsMDlBZTFSanVISVBxNmRaeEJaZDRxK0oycnJzYmNt?=
 =?utf-8?B?dFlZVmo3cmpxZlBCeEVpY2srZnJiR0dpcFdERjlzSWdveVpqaVhiQ0pUSG9B?=
 =?utf-8?B?UG5ISjRKcm9sK3R2TlMvN21meDl4MDZ5WG1vWTNzeWJ3dWE0dDBuQ1p5WHRz?=
 =?utf-8?B?ZXBZL3lWS3lqZkZHemdBaTNGMC9zdndrbitOaUx0SEJvWFZXcDJ6eGJhSURr?=
 =?utf-8?B?Y3dFZ0RiNXJCazZYR2Y4VWFuZGNwUitOV0FIaVJlR2pidlpCY29VMFpza2VT?=
 =?utf-8?B?WnBkS3VNNlJKaklzVzV2Z2hTdDNWM3ZNNEo3TlZlek5TWllGY0pTTlZ5QkJ0?=
 =?utf-8?B?V08wTityZTY1YzhiMlRNdDJYSmU4d1pDWFFIalF3ekJnUFByK2kyUWI5b3d5?=
 =?utf-8?B?WEMrQkp3cTF1ak1EUjVFZmJFempaNnlOUVRYUzV1SWNqWXJkeWh1T0psNDBR?=
 =?utf-8?B?NFlYLzNtY1k2OFh5U0JVZ1NLbWpST1VqdVBlaXYrY3BYd1ZkanZhbXEzTzY5?=
 =?utf-8?B?TytlTjl3Z0tPTW9iTGZKVFVyc01SaGdEdFJpMHdsVm9lbFMyM0YyY1NTVEdm?=
 =?utf-8?B?TG12Nm9yLzl6cllmSTAxbWFQRkhUODFJS0FPVWdiNVBXdmRZWHNqTUtERk5D?=
 =?utf-8?B?eTFTdUJhSExzdTl5cU1oVEFFUUF0dVlIaTQzcGRoRTF4MnJPUFNmTFVZTzlK?=
 =?utf-8?B?c00xdVBGVE1JZGc2YWMydHVkeTNUSk1wN2RZNmFjR1FiMlFXUFlRbXJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWNNeUZ2U0xoeElPckF4RzBKTU02K3FkK3lYNzV2eXJNRDd1MUpmRytyaVBz?=
 =?utf-8?B?eXFqdkYxNjdEcnZpakMzUkU4aWpwdWRPM1V1YXN3elJWRUFBTDNmYWVLZDJn?=
 =?utf-8?B?WUdxallIelZkQXhFOEJnZFp6S3JaTXRIZUJSYlp5cEI5QXpFd1EvcGRWNENv?=
 =?utf-8?B?ckdYOUdiSEEyMHF0M3JBM1FOdEo0SHJaRHBDYUVOcnJYU0JoY0RtQUIrNXhu?=
 =?utf-8?B?ajJPSHk0SExRNE1NTWxxaTRKQW4vdDJZSU9taHRKeldwWXpPcjY0dUVEWVVq?=
 =?utf-8?B?L2hDNHlaWUdCdFNER1J1dGJ1ODJzS3JEd2xwZDlDM25CTGtWSk4zTitIL0k4?=
 =?utf-8?B?a1RESjlmUWJ1QmxCTjh5MjVLNHg2ZmYrWldudHpiMEd3RUUzTGFGTDZFdW5y?=
 =?utf-8?B?enpra3ozakdYYzNPSVNHc1p5OXhjd0k4bUlKS2lVaWhDWENJV1JIaWpxbjRI?=
 =?utf-8?B?WWRNaHQ5VlRNVUtqRWhzWEowOTA1dUhtM01CSnBidjFkb3UxY1ExNFp0MkZU?=
 =?utf-8?B?OUVISGFiTFFkam9mR01NVjFCUnZUOWJ0RmFKZFFPN0F6LzhHV1dVaVNWaHlw?=
 =?utf-8?B?MnVGVzN4eFlsU3htMDJJbWU0THBGQUdJZExsNWNVeGM3cFFQdkxnaDcrWGgw?=
 =?utf-8?B?YVlTMXI1OEtCc3BmdzEyNXllc1N3ZFU0cGZDc2tzTFB1Nmc4akpRcTZJYk8v?=
 =?utf-8?B?VmhJUVJVYzQ3N0lGSWdxd2JxbVVIVGNBRG5rOURZVFB4bnpLUURqVXU2cmI3?=
 =?utf-8?B?ZFFIMkZNWnVVeVBYU1R4WXJYWmIxVjlYSFczNjhkSVF2REdhL1IvdmFVbXdY?=
 =?utf-8?B?RWE1eXpGZEFZcXMvYXVwMDNlZjFvUFBydnlXWHF0T2k0cHZxbEhyWjRNSmFS?=
 =?utf-8?B?ZUZtNlR5Nlh6TW9tTjFSSUQwby8zUlJGbXZ2VDBoRUZUODNiUWl2Q3U4aHNj?=
 =?utf-8?B?a0J2OGowTDFEbXZKWjZKMTdUY3Y3ZFBZZzVyMjRUczlwa0tRMTVwOUFXd1Iz?=
 =?utf-8?B?RUw1ZmJQU2twcEx6VVI1K0d2ejhpMnBOYXNUYXpMMDJtZ01QSnVmUm1CQm1Z?=
 =?utf-8?B?QzBCOTZyNWFBeVJWQXhrSXdMSkxpQ0dmQlVQVHZhM25QQVNVcDkvZEc2SjhY?=
 =?utf-8?B?Y2hZKzgrMVVWSVI3cnl2WUVveFhqaENLSnVjVS9kaGNtSmdrS2NYeENXN0Ix?=
 =?utf-8?B?Zy9IMGVXcjh5YWdoa2Y4alF1ekNQMnlOTlBXZFo1cEROVGhLbHVTcW5Ja25W?=
 =?utf-8?B?TkkySWZOdDcwWDRwcUZMSnpObFpTWFE0WDhHVkNwdEVvVEhaVmhybk13MjZF?=
 =?utf-8?B?V2hrMThjbm90djlmMWM2d3F1NW1LVmNFZ1NteWpDbjBPUVM3bXIwVnFWMjFr?=
 =?utf-8?B?cFExekVXNWJSU2hIVWd1ZUpEMnFES3hDTy9CY3FqclM2bm1YQjA5aDV4Tkha?=
 =?utf-8?B?dHVyVmdVNjBuYTd6WXRDV0Fwdk04OUM0eWYyRGNwMnpYWktBMDc4U1RIVWEy?=
 =?utf-8?B?NlhMVW9seEtwcDNPV1p2NGZ0Ny96Vy9NTU5TaUViNHdWZTNEZW8xNVExd2RY?=
 =?utf-8?B?WXoxZFRTM09mOTdrcGxORzIzVkl5VDc1NEluQmFCdFkvQjRLS004Z1VhOE5T?=
 =?utf-8?B?QmxwdmI0cUVQOGJvMHRWTFBabUFkekVtdTlwTURRbXpkSzBYSnlMM1N1RHVy?=
 =?utf-8?B?RFZubGpJUHpST2JTQ1NVM2ZCd1VxZ2lkMEtEamNKbFhDQnV6Tk1yQ2VrWVhr?=
 =?utf-8?B?Yyt5MUJzem90K0J5bEl6ODR4enBiYjBsbFJudXJSd0Q2bi9sRmhyQUpLUzRo?=
 =?utf-8?B?ZGdDSHkyall4VUp1clcwOUkyL0NHN1dvT2FFMzBIdEs0Y0tTVXBHajJGVUpl?=
 =?utf-8?B?RTRJZmhIcXdJOG15OU1LZFhwVVp4ekl0dUE4K1NrSCswOHRiUmRYMDkxQVBl?=
 =?utf-8?B?eG8zSGFsN01CNDVzRURud2hsZVdnR3dEK1NoNGZIWmU5TFYxeFpiQlNsZEIz?=
 =?utf-8?B?SG9ra1BhOUIvbVMwRFlQOFBZTWdRdHMwaVJhcW84VkhNZEQwT010RTAyV3Zi?=
 =?utf-8?B?QUJxSGZPVlhDczB2M3pYVkJjRmVLVkZBYmVqazdLc1FTaXdzdDhYV0xJOVVM?=
 =?utf-8?Q?qbUmFZ3t+CFIPPDR34RvUTqhg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725e068e-4452-45f5-2c72-08dc63c9ec63
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:16:48.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/50Wq+MH1ClHKm43UIvWXe6pPd7saor8rzM5JO2Rtvy92RWNS3Ynv14YDwd5hoJZbtobfH1dz2aTZy8kiBrHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303

On 4/23/2024 1:06 PM, Borislav Petkov wrote:
> On Thu, Apr 04, 2024 at 10:13:47AM -0500, Yazen Ghannam wrote:
>> Scalable MCA systems use values within the MCA_IPID register to describe
>> a bank's type. Other information is not needed.
>>
>> Currently, the bank types are cached during boot and this information is
>> used during boot and run time. The cached values are per-CPU and
>> per-bank. The boot path needs the cached values, but this should be
>> removed. The run time path does not need the cached values.
>>
>> Determine a Scalable MCA bank's type using only the MCA_IPID values.
> 
> Lemme get this straight: You want to switch it all to use this new array
> smca_hwid_mcatypes[] to lookup HWIDs?
> 
> If so, where is the patch which removes the _old thing?
> 

It would be part of a follow up set.

Here's where it would finally be removed after a bunch of refactoring.

https://github.com/AMDESE/linux/commit/291c85ae22277

>>  arch/x86/include/asm/mce.h              |  4 +-
>>  arch/x86/kernel/cpu/mce/amd.c           | 99 ++++++++++++++++++++++---
>>  drivers/edac/amd64_edac.c               |  2 +-
>>  drivers/edac/mce_amd.c                  |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
> 
> $ ./scripts/get_maintainer.pl -f drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> Alex Deucher <alexander.deucher@amd.com> (supporter:RADEON and AMDGPU DRM DRIVERS,commit_signer:91/89=100%)
> "Christian König" <christian.koenig@amd.com> (supporter:RADEON and AMDGPU DRM DRIVERS)
> "Pan, Xinhui" <Xinhui.Pan@amd.com> (supporter:RADEON and AMDGPU DRM DRIVERS)
> David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS
> ...
> 
> You need to CC folks on changes touching their area...
> 

Yep, sorry I missed that. The same is true for the wrapper struct patches
later in the set. They touch all places with MCE notifiers.

Thanks,
Yazen

