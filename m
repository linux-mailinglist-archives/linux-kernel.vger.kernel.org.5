Return-Path: <linux-kernel+bounces-58474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394884E6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C0EB2C1C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C29823BD;
	Thu,  8 Feb 2024 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d/onGp+Y"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516D823A0;
	Thu,  8 Feb 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414091; cv=fail; b=J2lsGj4n3QTdgTyPT8PT37bR+ztyr8L0PgaU5tDL/3RPSWbvhVetdWD8yU2/wXztwhkF6FDGVEtKaBydQbDedytFUbaHd83FZxhJZdFNeUOHcjstG8J8VNjW2rsQRj7kU7Kjev2MLnXaTDSidPAAv/ZN14J0jDNKbmJ/0XSizeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414091; c=relaxed/simple;
	bh=s4bZjb2OIAPQ6Ozag9DrsuskdL+n+8gvdtUl9l1Ergo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kvEsnuwJO8ilvhGTfbgb6X8VE77KCoF5BqBbexZyKFCkpfTdRxPDWqwWvSVnD96kSAuuLA6t+X2vG+w8lz8SFvlXnOay0oKr4Oy3P82A0nnEyEXtc6fO9s0xThtnYuuEbqVstXLFxCE/tRHE/wa5mx+w26+VUQcdl4pTQ08amcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d/onGp+Y; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyQEi9hvBEEH+oxu2jkA7f+RqHAXMUCci5En18ToTYoCsOQddE7rBCgP8EuteG4cMY38+CIlqPSHWX+iDpYdp3CSPWwey7LiWqI23v80kKQWzYyIdvbD5e93UMHO6A84aNSuem4rHR4ZyWUZTDO/EbgO7rTEP2rzdirIBCy1UoEHeche0aio1lhPYQAuWT1x+a4dp0kA0fo6kiGOAep/U0FQvU6ZhjWjeI8mAbWsVAm/AepeZ6IIf63aPLb5FJzKV0mE1zYMQiWjBH35EBHDRy/b3xjCGl1wK3Q9hYKv05hXkuN0xRcy8nnDV4ZM+NbfacBQ2n/CCc3G9ks2/o3Mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SIEmTs0ThzfgJxTkybnElNg03GmYbf+WErFGnp/jEA=;
 b=YB+CK9GvEphi1ViX1b7dEAtcmfkZ/SIE7v+vDiZHM9ve0LcNjpwQUnKpmlHneIAOL5NOvD2nPLYG9cfp2iqfHRhrd3XE7Jm+xiMyy0lakXKWk6tgvhpCh4X/CozPqYqABSbPP3rwelwBB7r3k3XmIJnlj2c1BHrupctXoIwLPXy9G+SB0TMkXHQRdz2sp/oS0epmkmz3FhA+Rzu2njdGcBPd4svLtZQVb0lS6pbyupkpyj3LkR+ITuLYgeA9ioOetLFeCFma8dKWPiKgDz/WSnDFgB4Zu+j4nqreYLcrSC+LdsDhexqE4GXbcuDNnobv6tFEsoK5qkG++2SNonEFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SIEmTs0ThzfgJxTkybnElNg03GmYbf+WErFGnp/jEA=;
 b=d/onGp+Y/yDtU5s7cag1l2n4Y3Pe+DCy6etJVFz9zLwwQVLLuzkXrxpTG46wDQxAqnh1JO9f9ifFL8YD9r5k9AQmqFYTRWzZJMNnCsLhoQXpxFdm3Ya0PTmZqe97VhEqppIgu0+TpsS7QuZqx7b3pM9eR6Ob9FcWY8c2D0SxFKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 8 Feb
 2024 17:41:26 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 17:41:26 +0000
Message-ID: <3281ec05-60cb-4fa2-8562-afa93e770159@amd.com>
Date: Thu, 8 Feb 2024 11:41:24 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
To: "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-2-avadhut.naik@amd.com>
 <SJ1PR11MB6083E1876B8CFBA76F1B3806FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083E1876B8CFBA76F1B3806FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::18) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f35735-82d8-4837-0b0a-08dc28cd2c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nu9PadpfGhIWit9JnoTv9mGbcjfnfADjfUS/DLcR62ueUIqM8LzUvy7JkPfdGOT6QS9Y/d9OxnTA4K3pIwCQbIdBTwRtMeNStn4xXgoDA1tOePC4l4f8TrJ1Uukm6sv2eP/xl9GaN7GyAopGgX/ea6kHGHdWp2v+FCjQS3cYcAvPJcqkIwzHu7NvHUsS4lSMk+Qb8zcWqiMvC++0+wNQNS8IqVBXwrQFxdvc+VonnkYv3vFXaRU1jrfXPs4VwDC5mUnYuAv9Lfhxh6N/rFwu17cgAfbjH/vVEV0zPMhg4i6JQCU3TUdCc7COEDOJiDYQ2bL3oGTOeXb2+h37sng30TRv7kygcLpbYfUtIhbOKyQ1/dKYqkEUgk6g+mvahrMQaFVzZCIkIYWseB+ANJg8jDFRKZGgM9BmPW6/6fTkNT4nVzc/tfWHkyz371IRpOBer0If7M/DVgVa6sOupp41NF6FX6a7YtHrcocFNldg06Rz43rEJu9TAvQ1F3HmNAuf0pWNgENNEWnvLDbaZQ1rKEPp+mmHef12cNitQ4lid6VbyaDFPiuNO9BEfmpJJHMp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(6512007)(2616005)(66556008)(4326008)(8676002)(54906003)(316002)(66476007)(38100700002)(110136005)(4744005)(6506007)(8936002)(53546011)(66946007)(6486002)(478600001)(5660300002)(41300700001)(2906002)(36756003)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty8wL0FZSGplSGt2TWczMG5KYnJ3Z0EvQ0pZQVhiSFFJQ3JwUGpweUJoVGpZ?=
 =?utf-8?B?WHdKb1V0SU16cmZCeFo5MkZnOTV2dERQb3A5bldqQnhYRGJ6QkhYVEV3dDJ2?=
 =?utf-8?B?S2JEYStSYzM0TFFtK1QwdnJaVVBjVzJBdGhLK1BOR3pqWGxCZlpSWTE4QjlZ?=
 =?utf-8?B?OXVjMG1QN1JxNDg2dmVad3NWZWVYRmZUbTNTS2hyelMzelUrQTVadzA4Zml0?=
 =?utf-8?B?dWVHa2NmSVl3V0RZRXJ1cnkzNExjZXpyRld0WDRLZERFM3dMcG8zUDhjUm1U?=
 =?utf-8?B?eEQ1RUtKVlFtd0dNZEpzZE9NVEZydDN6ZGlsTFdFVjREYitKQy9yZENTS1lW?=
 =?utf-8?B?NGc0MEtmdVF5OVlzRy80MmFJU0ZYemZ5MkJIT1dHSVpHcmJiNU9nNzMvQWJo?=
 =?utf-8?B?c0ZvR0t0MlVuWTJxak4xdDVERnNmYWZVOElrNlFkaW45WmNiY3U4M29TNHNU?=
 =?utf-8?B?V2lSbDUzNmgxOENHd21Gb3hMVThtQ1Q5cnN3bnBLUkVEUDhEUG5hSXd1L1Ex?=
 =?utf-8?B?UVNteHc2OTNFRUdVNTREckRUSHhvNFRPb2dXbG5kSy9PTldHSlhQSndFeXkw?=
 =?utf-8?B?UFlGd2kwSmVZeklBZVNVdDR0K1JTWUt6Qzd6K2s3dnhuelp5ZW9aVi9aSVRU?=
 =?utf-8?B?UjVXL2hmeHVJMXZwQUVEa1F3RlFSdktiYnVzeHBYeCtmVyt6NmJNSWJaajRV?=
 =?utf-8?B?bXFXak1aeE1ZaStzb0VGUWNZSjRrRkVsVDd6SVJHZW9EWlRVMk4ydmN5N1hr?=
 =?utf-8?B?K2dZQWNzL1QrYnNUMDNiWGJmMUtSeWdhQUQwZWkxYUs5SjZDTkhlSStGY2lk?=
 =?utf-8?B?QkhzS09CbUM4SmhIQ3Eya2laWGNibDBYb3VHSFRjbGVmQzNnbk5YcWp3aHdr?=
 =?utf-8?B?c3htQW4zM29XNlF3czdBTjVoYy9uR2Nad1B1cmpIVmduRmFDZEsrY2NORjIw?=
 =?utf-8?B?Wm00dTNCc2lrdTU1MHM1Z2JmNGx2RGJEa2FZcEJGY0ZTR1ZTeFMycE5Pa2FG?=
 =?utf-8?B?ZGs4U0dZS3RKMmFHNE9SVEdsSXJOb2lJMXQxWGFWMlZScmUyOHI0MXFzeTBn?=
 =?utf-8?B?UHJWQ3FZSmxhODhLenBjWk4rR3ZpOTQwYktFTVgrbkRnOFNwZTZDc1RVU3Jo?=
 =?utf-8?B?RXM4ZHdUT2FmUHQwcUVqbVdXN2I3ZFdManpNQ21Nc20xRmRCSW5HVTRlVSty?=
 =?utf-8?B?b09TUHhUazZwWnBZSmVMS2txRjFxRlVSNEdWZUFNQ2V5UlNIc245dEg5WlQ1?=
 =?utf-8?B?WUM3L0tEaXM1ZkRHY3BDaTFzaGNFN1pvUi9CNG5tR3FEWUFUVFRzN2RVWjVG?=
 =?utf-8?B?YzArcXJZbkVWUTVabmcwQ0pUNnMzNU5QY1JvOE9EY1l4cWJ5aXpjYTlVSmZK?=
 =?utf-8?B?S3Fkb3NDcE54L205S2ZNdmNZS3Q4UldicG9wSXYrQWdKTkhpVjA0di94ZGNW?=
 =?utf-8?B?eXpkNXNhbkNIS3psbFB2akxqdXZ5c29RdFgzZ2xCc0l5STNCc1VmSlBjN2g1?=
 =?utf-8?B?ajVGeEJWYWxjTWZxMlJhcFlFYXNCZGNzOTE1KzRmcllCUm5pRjBZekYyUmxj?=
 =?utf-8?B?cXY2TkN3N1lOVTRVd29PTHMzb1c2VGdGYzdFaVdSUzFRY3RzTFV3UU9NNVBo?=
 =?utf-8?B?NHZhR3JQK285V3kyMmtDZzZTMjQrTkN2VHhYK1hBb0NnKzhCTDlnWldNZ0U0?=
 =?utf-8?B?UGM5N0dTbDRPNFFMOGNJVjVYS3QxMFBpZGYrdHVESGNvdEJENzljdFlBZTcv?=
 =?utf-8?B?UHJjeit5M2NGb1ZVSS9kZXdLL09nTlVwSFV3NjdHRmZEeFlpSzYvcjVtTGsr?=
 =?utf-8?B?YjBJVzlESndmUlVuNnBQYUxGQTZWb0pSOEh0Zm9iVUE2UWtuVWVVaVVBd3E4?=
 =?utf-8?B?a1dJSEZzdG0zVU1PSWM4WHJ1dTNIc1ZxM1pKaUZ0OWt4QittR1ljT0ozWmNB?=
 =?utf-8?B?VFhyK2JFbnd1YWN3NExIOWtQd2tyVHRrME96U0hOYjVxRk9rckdhcGh2VXQv?=
 =?utf-8?B?dC9IUlYveW1Nd1lIdkhmNWhNNnBtQ1o5Z09rRElwK0NWRXNGOHkwKzZaNDZo?=
 =?utf-8?B?QTViLzNwcFNNNjRRc2Rmcm51ZGtRcHlRaDZrTzBvdDFGcG1XWUp6dHZPdTNn?=
 =?utf-8?Q?4sg/W5JqPyPB/GR55YavL8LzC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f35735-82d8-4837-0b0a-08dc28cd2c8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:41:26.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +exFG5QNjrF8+ZDVmNSkI7ciafZQqk2CItn64EzSCusSSl7Dn67b8jJ5lusl9KKG8fMpfkMDQ92hXefmDFZc4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

Hi

On 2/7/2024 18:02, Luck, Tony wrote:
>> +#define CPU_GEN_MEMSZ	256
>  
> What is this define?
> 
> Why isn't this "sizeof(struct mce)"?
> 
> Or 2* that if you are trying to reserve enough space for two records per CPU.
> 
That's the memory in bytes reserved for each logical CPU in the
extended MCE Records pool. By current size of struct mce that
equates to around 2 records.

Will change it to (2 * sizeof(struct mce)) though. Feels more
accurate. Thanks for the suggestion!

Do you have any additional concerns/comments on this patchset?

> -Tony

-- 
Thanks,
Avadhut Naik

