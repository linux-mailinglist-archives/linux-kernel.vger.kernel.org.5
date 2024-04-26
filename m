Return-Path: <linux-kernel+bounces-160285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707E8B3B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BB7B25D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB1148FF2;
	Fri, 26 Apr 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KSvn/mnV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FE824B3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145330; cv=fail; b=AORCquL+xdftLn4jmqdk8coAiCHcymVuHtJNEYtNLklLynktHtF0L3LtNY6rcQ9MRP/i16mHlz7hsXL2J2wr+odx0ZtI0b39YYZzmERYBWSKBCE2zrzSqh2m5/Y1I3QQcphAxR6wPRY3+aYeTm9MqrBFzDXrnkClLBS3CH84hME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145330; c=relaxed/simple;
	bh=9lvEnbDrULLDizu1wWgrRuLiNOPAWOUlOKlOkrw96gA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sYV1Hpv5y1UfWnd3chryr0Cl2nXRWCPOwDNEKGk9lTUSkKSzQqOyE0ElTzKMYet7GzOGhXG6Q6MYV3Eu7bF0CeGZKh4aW3tRdMFx6JCCvB3vtrxBZIfJxaGHkKMdbWbGstY0QYNUAZtw9zzQpDdAq+mHCa44WufuwAAsCGEAfFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KSvn/mnV; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWhsVx9Z+/OCliMyQLnKCO8fqZ+8q8ca1KmJudJr34et4Ih7Wv4ySpUkYd4M73JHO/AQ37V+BJ+YwBWVrAVCzUWksPxKv7fcopSrZ8J4oIc3lW5jt3BNECgd0gOUDvHOQfX3xKH9Ryg9UfNbCAITlEJbZPUTFe1UFLy7EvwP02vdjKaokKMixdstrZvfYnXGS3N521iN2/62RCo3vieslBK/3h3O+LiF90S2jDKcbeT4yFyjfOkMkvmG78i4IBeYoEbGof7J9yMYNrvfyL8v925iKYUejMwbSESBZr6WZkP4N7ixr87WP4m2GQLW1wRi9BjxkuYUvP3aWDAMF3ddyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23psoH5xXHYrL/rB26JC1BU8wV61KHjsZNkhGlhOO48=;
 b=ZsUYG9J3HWCN62p9a16wqrzCs6fyGmF0GgiFxydl04+4njGpJYI26vCNyr91krqli2eYxU/cf3ZU6jfI3ujfisJI20Uhx7y4L7CBIVzxjFYyivaPfkzYXL3K+nn/WaBfc/yOPzZbZX8z5mSXvw8j78rdypagc2cEtBmDW9HtG7ajoIeWMGKXcanxlae0ztHDmU2t7rjkJ06YWcoFZ+Gp9aNYNPxwCsxGwaLajS2tMN4rWK2AxqNJLmO4AlgrjQ49c+oAVjtobRSK7tQmBjRcLJ0IofKPtNNS6lpQWQQkcqVrDFK5T+w7b5xS0F8Ta5LbDbS4oJ3j/YhcWVwLDrT5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23psoH5xXHYrL/rB26JC1BU8wV61KHjsZNkhGlhOO48=;
 b=KSvn/mnV/sKwuLevEbddKd+qFLn/SN+85QhIAUf0lXWFXGtUaGY5EsfYjXHfOS3IBRWDJ928MOFx8OgtmE0cnbXRVuYsGXyDZKbeFyxYtqWBKJoZnbuesj+vuG3ikf/+0C6KJl3K9b7TdgLaR0OMRYlpZu9+6kRIPCEKWrSQ4oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 15:28:43 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 15:28:43 +0000
Message-ID: <debd333e-6897-476a-97fc-02246e97a24c@amd.com>
Date: Fri, 26 Apr 2024 10:28:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
 <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
 <20240426152221.GFZivGrY86svE0RZ00@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240426152221.GFZivGrY86svE0RZ00@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:806:d2::32) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b4f6d2-3c5e-47a3-dd72-08dc66058e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2N3c2lRR3ZkWWRqK3llaDRteFE1WmMyMW00NDI2elhMbko3UkE1UURBN1F2?=
 =?utf-8?B?TUk5S2d2cjV1cTBIR1Jjb043b2tyWkNqb2xzbjFKSHRSWTBYNTFTRWRyYThS?=
 =?utf-8?B?Qm5CRzBjU3ZmUzFsNkJzZ2JQN2tBUi93aUpUTjZuN0JIaHRaZlBHRzZ1eXpN?=
 =?utf-8?B?WGRMTWo0KzBpRDhCdFdDdjRGRy9JWmRMRkNLeXY0RUxvMUlkQjUzd1RjOU5U?=
 =?utf-8?B?blV5eEo5WmhsdWNRbXZNTUhwQUdBWU9Ja3pUV2dqdzBQM2IyWFVaTzliSllS?=
 =?utf-8?B?K1g1T0JLMm5hVmloT2lUNldHS1p4di9iNUFYRGhZZEtJU1laOWw0bGJFUVFH?=
 =?utf-8?B?dC8wcEd5TkUxNmhpZ2tZU01PN0NrUWhnV3dpbUdJSGwrMlFyakFBRHBPLzdX?=
 =?utf-8?B?Q1lZRlVXbHZ0M1A5eEx4YTZRcERGaTB2K2pJVmxXbTg0YzdZaUp5VmtVWEZy?=
 =?utf-8?B?S2lBWXhRQ0pIV1pPZnlsNXJ5RXZnSlM5QUJ4T1BrenFYdzRkN2pWYU14aWxv?=
 =?utf-8?B?TmF5a1ZCa3BieUNHZktZSzR4QWN6djN3amF0MU5CNkxGaGVtZDdyYVlxQk9j?=
 =?utf-8?B?MFRYZEoycitJbkFyb3F0YzV6bGp3VzBXc0ZNRlF5OUtSNnhiTHUxU0VsL013?=
 =?utf-8?B?NDBkaEUwN0wxYUFxZDRwSGJHZStpTm5sUnFQWFRxMHJIdkMxVEl6SzNlUlZY?=
 =?utf-8?B?QzZzSlhvenN2SkhFeTNmQXFaUWNZWEh1SUtVdmtFQUM1QXFGQ0E1RUJFSzlo?=
 =?utf-8?B?QnF1aU1IU3liWGR3T0RhN09EYzBqUjU5dlVpdCt3cGs2QktSaDJLaWJTMjNq?=
 =?utf-8?B?UXZ3ZlBGSjZYUjEvSzlPcmRFV2w5TTF5SS9EZU1aZWhRN1F1VEh3YkVuRWlt?=
 =?utf-8?B?QWxzN0VpU0tzY3pHdVEyd0hBRWlJSmgxek5lWmxwV1hQbUZqTzQyY09tVlY1?=
 =?utf-8?B?aXk1dGQ0S0lDMWkwU2xIL25aY1pscnN0MVB3elgwbjAxSllPa3BPNVpzMjl5?=
 =?utf-8?B?UUhtQ1c1dzJVSlhzVmFvOGFjTHdqR1R4R01PaGExZnF2M0t6N3N2dDJMaE9N?=
 =?utf-8?B?VkUyM09wZFpjOUhOdXZUUis1Wm12d01PWGQ2V3NxRkVQUENKazdnZVlTN3d3?=
 =?utf-8?B?NXkrRWd2dVlzQlIydlg1NytPSEZiWWJZckMrMWpXcWYzOHpJUzJXRUhpOHJl?=
 =?utf-8?B?ZGxJeDNvdUU4UmdWb2V2MXNWSGJ0dGZ6ZlBvSEQxUnBWYTUydDd2OTkrSm40?=
 =?utf-8?B?d3RlS3Q5SXFDWWZHT2pYU1VPYzhqZC92d2VOUTVBWHFiYTh0a3BjWTZ3Rm5B?=
 =?utf-8?B?dDJueldyaVBLbFRSK2NCOVhwU1NNdXVKd0RpNnZvVmFsK3VWbm9oL25od3Nl?=
 =?utf-8?B?VVZCUSt1Ti9ZRk91MVZPckNQUmhFdnMxZ3VTZGhBNHlMZ0JTVzNGVjZhRDll?=
 =?utf-8?B?MHZHbHRzSlJxc2tWdVB3UDRUY0JjeW1BbVZMcnlaaGZXRU8yWjdhOHdnOGQv?=
 =?utf-8?B?R3BYcnZtVGIrSHVJN2V4NHlHRmt1QXRqUHdBRmZlaVI4L05vS1VMbkJreStC?=
 =?utf-8?B?TjdOeTV0NWxibHJZaUhZbjZhRE1Hd0F5ajZLM053N1RKM0ZnY0FZTmZJbmJk?=
 =?utf-8?B?dGxUTUhqUGhZcVdLMXNBWStIQitERFliaEZ4Y0VBdStXaG9lbVJxblUvODEv?=
 =?utf-8?B?ZkYzZHV2QTE2b2pjSUtKdzgwcWJUc1pzSHY2NmdpZU5lRjBlWVVDTXlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkdJWHNXSURzSCsvMUU3Vi9Ja0JWMnBNa3o1alpEQjRuNXE1c2VlQjhibTl5?=
 =?utf-8?B?Mm9sWUhLNzI4YkJmYlV4UVpSVEJTcEJ3WXNTRjYyQksvdTVkOFZ2RXg5WU11?=
 =?utf-8?B?bzE2WmRibGwwVkpURW9Xb20zQXFvTC9YOTltNFhNSE93d0ZXMFliN3V6OGNW?=
 =?utf-8?B?Z3N0bTlOcWlnVVE4aUdKQTBEMUloWEVmUlo3KzRmTHBHelQ5eVpiSWZvZi84?=
 =?utf-8?B?Ui9zd243bFc5ekY0OGQ3bm82L2ZOakQvWVBPTjkwaitPNDMwamNnK0lnMWpx?=
 =?utf-8?B?YllsbEhHbDZ4VHVKZVdJVjRpWVVhejREaE9mTkNBdFVBNjdYS3orT0FYdkRq?=
 =?utf-8?B?dkpIR0ZOdVNIOGgzQ09oWUMxUWJBcmJZR2pDU0pCQjRNSzVobFB6Y0ZSR1Jv?=
 =?utf-8?B?c0N2Tld5S0NEV1NScnJxOFBucVRvcitFTmZwdzBPRU04OC9jTnp1Ylo5V1la?=
 =?utf-8?B?N002WVc2c0tDaUo5c1JxRE9WS2R3ZnAzKzltM1dBRzZlaW9sOHpjVlo5bDc2?=
 =?utf-8?B?UHBEaW4weUhWU21nengwTW1nNitreWx0VFJYc1hBQ3ZGMy9RSWZKOVVxelhz?=
 =?utf-8?B?b3lJQzhwbFQ3MTdaWXpXRjhwZU5HOE5zZ01kbzFVWFFxdDA5VXU0bk05ZE4x?=
 =?utf-8?B?Y0tTWnVZZmRzTFM3Q1BJQmlNNkVJcXh3WjN5N0JiZlBlWFkxUXpKekQ2Zlhk?=
 =?utf-8?B?bDZoUjFabzBuK1MydUpUeWprbDYxTXg5Q3VPc25qZ2Vha3ZDOVF4Q21tN0FQ?=
 =?utf-8?B?ckM3RTdpWHVIejJjVUl4cnM3bHRyN2tyejNMUDluamRobEpwWXBIYnY5VXd0?=
 =?utf-8?B?WHBTa3ZlZkRWWW1kOUJlMWJXYVYyZDBwN2RUdzRNNlNSaWJlOXZtbFJNMmJ3?=
 =?utf-8?B?ZmdzR1F2UGwyZFpOVUJUREF6YVh2T0VqdWJibmNIYnNxMmo4ZVBRUW9aL2la?=
 =?utf-8?B?eTR3bVkzV3VNSldsS1pBNDhnbXpWeVphNVNCNS90d3dmbUk5Z0Q4SHd4OGRO?=
 =?utf-8?B?T250YmFYQjF3SGxTV21tNGlzd2NFckYzZXY2dkZ1WUFkbnk1YmcyNFBRK3ox?=
 =?utf-8?B?YjRnMDJ4RFl6dXZsdytONU1VK3ZJVzdiWVlkSTBpdUVQUWdMTVFKYjByazRr?=
 =?utf-8?B?Ym5NSkFkY1hwK25RdUFoNGpPRVJXMFFYTzlZMUo1cS83RHhleTkwYXNod21a?=
 =?utf-8?B?WGVIMXY1R2k5U1lnL0dpZWREMUVuTDdGTFNYVG51b0k1YnQraCtJNytNU3Yv?=
 =?utf-8?B?UURtTmwzemFVTUhJSTZZYStEN1N3ZzdwQ09rcXJmOW5zaTBUNWI5R2M3OERY?=
 =?utf-8?B?bFlWV3NzSlNlTk8yelZoaVhWcllmK2Nlc2pBTXloTnl6M2VnTDc2Ti8rNEJI?=
 =?utf-8?B?SVo5NnNDZEZjblBYQk93SHUxTjF5ZTdmV1hFL1c4MEtSdUNCUmtIalo0U2Fu?=
 =?utf-8?B?bG5TekNpNDloS1cvTWtyaEg2UWhJTjhCSk5ZRDJOVkhiWDdoYnEyaVdrbGRa?=
 =?utf-8?B?Sko0bTFPbWVscHdUOHNUaGMreVhjMUswQTUyQ0RkY0t4M2VNNW9pUTY3VnIv?=
 =?utf-8?B?eHFQWmxLaDM0OFYwY3IyTlRCU2drVHRiYTRDTW1idTNUSVZGdWdzYlZ6V2pU?=
 =?utf-8?B?djd5WWpyUFY0TDVmc1hzZ3dRcW91SDZZRW1nejFyNGZFSFpwbDFQb0xmVHZJ?=
 =?utf-8?B?QkJkTXJDMjlQbDNFMnR2RXlUNnh2SE5DSGJnMy9oTFlneXlaWHpKaG9HVGp3?=
 =?utf-8?B?REdqdGFGMWlLQm1zVDMvVytVNURucnFabCt2M3o5VFA1WHBBaEJxaVNZYkk1?=
 =?utf-8?B?aE1kWjZsTE1tbW1LVEhsMkpIdFkrOCtoZmRkWSt4ZThTUnUxSXE0dEJYaTRC?=
 =?utf-8?B?cWlOZk96NmVpakp4VFBzU1BDb2E2M3daajR4dm9ZTkVJS2o2Y1dWU1l4NEtZ?=
 =?utf-8?B?c05WRWxXWkxMdG9Ja3RGd3pCZ1JoTzkxYTR3SHVlZ0xnOVNmS3EvWHArMHp1?=
 =?utf-8?B?VFV2Y1cxRFdJN3ZLUGgzdVpmS0tzcTV1aWRJMFlzMUxsZTc5RW45MkIvUmN3?=
 =?utf-8?B?dVpnT09DN2ZodVArdjVVVnNxWWFLYy9WS3BCMEd1QXhNNFIwQnRjTks2UjJ2?=
 =?utf-8?Q?rslW+/hhhHpsuerhTwJGAk44z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b4f6d2-3c5e-47a3-dd72-08dc66058e9d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 15:28:43.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqBVYWn/Iztdct8aCp9ksi251LRcFSqKiZLuFFMH7mje85cq+7wpQrVLD2BDZLzzliJ8C8xFL20z52+JLPsqKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669

On 4/26/2024 10:22 AM, Borislav Petkov wrote:

> On Fri, Apr 26, 2024 at 09:47:02AM -0500, Kalra, Ashish wrote:
>> I should have mentioned *chained* guest kexec above instead of nested guest
>> kexec.
> What is a "chained guest kexec" now?

"Chained guest kexec" is when we are in a guest and kexec-ing into a new 
kernel and then this kernel kexecs into another and so on ...

Thanks, Ashish


