Return-Path: <linux-kernel+bounces-50205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFE8475BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3CF1F229E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781EF14AD29;
	Fri,  2 Feb 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bte2GPEB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60EE1487C7;
	Fri,  2 Feb 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893620; cv=fail; b=YaSIcU3KrIsNinPKSV6o/FQnJEM/t30lFn/7C7k+cydbBVjcXNgVdBYRD6wL2CrU1B+6UB5ZGKg0gUCwvoEoxpPfFqV2pWRr++T1ghAM7Iqd8+nPZzPQrIUvSN1RbMQFL2njR0XZLXN6ZzR7vjIvIq8Le5tzfGHj4CnJvoWp1os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893620; c=relaxed/simple;
	bh=LtnIMEV/n6eeuhvQFhZKJBw4jLFSxDuseqfMp/yPpbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IhdM01Eg2TvV8Xy112SCh8NFynADn/Tpi5na6A6YQB7a/Puo7vdKszQKYskCk4vg8aQdVllfBbdWwA1MGo326m5oYy+ION4BHVG9kK4VgA7KLCbf5xHTacJbPb3h7+hvsH8xW1Pt4LEaOcjQsPufeGu2OHf8Cx9oXRZ9enxDB3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bte2GPEB; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS0shZN3LxEo7TtxU1XhBH2aKbhRCg4y8ZLv8Jip9Sus0/zB2xiMk/6A7zbZTo19uzNuQy5SOAI0uEYgLYbNbbc+EpYnjDFwjZkVtoiup5hvqbKII7alms+GSBesyq5OjrvDsopHXKcAOM3peY/SeQQtCN9SVTwuBe3rqjFfgdQHPajgymXVEuy12RCFaA1SES2rg4IPGtRySeTuLxjjYuE+vrSgFSeeCEC63Bu/vbWOdAiV8y7VGgR+4+N+4FkA9uZE7YqRMPvioTZyUJdqdmKT6+LBtt+CB5/eX5XIJtaUyQYh4RV5fXOBojX66KHxTLxwaZ7xeOgB5aS1MPMh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/83am6JUwPRSuZjQ+p0WEehvOdlW2BlBiMRBUCl+DkI=;
 b=AXGMle5O81Zb0DqQxWYz2muDjiBxA71/P2YMC8BkeWpPvpONHBKN6HCIJfAJCsO0MxqsyxAW3VeOp3NGZ6VJJoj1RmG20d9Fs+5CLunHMVu1f2ejCT+OaLP/h24E8iD7SvnrzmTXhlJTVvasw1xyY7t//VETcWoO1QWms/AqXsmINuWUMsHU49bxJLnVpY7/vYuznRElWaJI1qmdLEm0tl7XgOm/rZWGRQdE4c9OCQ9jGQBu8bNGLbELTiXzIzaMRJJ7FVf1NjZ3Rc/atkzFg+PqpiT8iqmOKj6z8JGcec+Rei99Sqp7jY4MrBUuzprILLsCAYI8Mko7LoQAOSjUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/83am6JUwPRSuZjQ+p0WEehvOdlW2BlBiMRBUCl+DkI=;
 b=bte2GPEB+1dm70A2v+T/OXwSh8yNJb5G2zQOy9lPqByVlgIearM8466W1qhu0+X5x4BMeKBcWZ1Jagf19L+07YpH7X9VDFalY+V7utyl3/4nkCOXAB2duKNcuIxiB8jBzfzzAmzotQr2WluyMa6Y2+DmaSUDjOwAth8hcky4XlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Fri, 2 Feb
 2024 17:06:52 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7270.012; Fri, 2 Feb 2024
 17:06:52 +0000
Message-ID: <78af3df9-693f-49a5-b6bd-02a146506e7e@amd.com>
Date: Fri, 2 Feb 2024 11:06:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: Fix
 Trilok's email
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: corbet@lwn.net, avadhut.naik@amd.com, alexs@kernel.org,
 iyanteng@loongson.cn, 2023002089@link.tyut.edu.cn,
 quic_bjorande@quicinc.com, quic_tsoni@quicinc.com,
 linux-arm-msm@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240202164119.4090703-1-quic_jhugo@quicinc.com>
 <2024020223-eskimo-armoire-a517@gregkh>
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <2024020223-eskimo-armoire-a517@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::11) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 30173ddf-40a9-4346-da5a-08dc24115a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	He6bXBNlDsty0XX+y1JCJnBGPTZJ3Xshce0nAKe2hxC6d9F/krpnB66Hy7+psJqLJ74XsmKhr0EieCLjIah1mzQMpTuDmcMY4snQyX2qaHBbviPbjcB+Ej1zhA/hEXi6OvI4uLGG3Smxy3bUN83GC/f2bdoLAMIdi0Az/tsQBGz8jR1FKfc7WiTe5yxQP7b991q0N7tYhXyoYRR5u1SG2+54rzRSyRSKuuXzU0MQz2k+VE2IEKdINfKZUIA3wCBM1baM98DG5rCXOTONbrpVa9STa7ucXUun4p6TOI2vz2yjPTA41U2GT79pe78bD98G51+RYzwS3Makf8j0UYeuPQFNimDQxkEBUAsD5K4vPFwlkfongEofB6h04SptONF+NfpGzyziLXqDSOivaLJQ4Us1zpDRyYFpReUh2SoKzAWyXl/YQgEWBiYgPTy5AkejLEZwAzjkkTq6do5GmW5cFBfnzivc8RC9qZ9ysMSOonzzHo8yszmkgxxssGDuVnN6pcl27tmpFTp/KO55qMMSGKa2EtVVtBZyzZWCVUQKT3QEHH5nYKllWRmLTHXo3vfGJMU+I0lwr7UgEWyWsG2qQ/XqVPzNdheIGA2fDJX4qQIjcVBV6EAhcrtUgiYI1Ne14j27vdRkec/Mt+sV7LeIyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(8936002)(83380400001)(86362001)(478600001)(31696002)(36756003)(4326008)(38100700002)(316002)(66476007)(6486002)(110136005)(2616005)(26005)(7416002)(66556008)(5660300002)(44832011)(6666004)(6506007)(8676002)(2906002)(6512007)(66946007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNGYlhtUlJodmhCYXZSL0RNUnh6eE1sMWtYVzhMRmMvN25GTWg2ZkN0SHZB?=
 =?utf-8?B?M05qQW1jWTN0NGhySFNuNm5BTTJ2cTVpTmJJVGo1RWR3aGFUVHgxRGR5ZGJ0?=
 =?utf-8?B?d1VWNFdQOUtVN1d4dnd4NnYvRzcybmNoUE5NejlLUCtoSWxlQmhGajJFS0xJ?=
 =?utf-8?B?cGFtSjlFOE44QlJYNkRtRkxiQ1J5ZHRTM3hpaXQxdnRvQktTR2o5UzF1QldO?=
 =?utf-8?B?Q2FTSEhJd3k1VWdiTi9XY1RiZzR6VkJBWEpzQ3lEY1lJeHAvOFdTbkVhaHFp?=
 =?utf-8?B?Y3pjbXBEV2tsMU9vTC9pM1JiT3RqZ1A3NEhBK0JDaVBiY3N4M0NKV1hrSjZa?=
 =?utf-8?B?Y2cxcm9KaXdHenlWVnN5bCtsMmZDcmlmZ2FyRkNjMWQ1U1ppcW9JazhhUjZJ?=
 =?utf-8?B?WXl1YUhlNllMUkFEWkNoK20wY01nWHV0bzFlRE9xcEYwSjlWM0hJaWpGMGJF?=
 =?utf-8?B?RlhLMFkyR0dCcWF5Ty8ybUN6WW80V3F4b05JNGY3WkU3UDRUUng0YVU3R3R0?=
 =?utf-8?B?TEU4QU1NM1lzMXJQUmN3TFF1VVh2T1RtcnZUdmhPRGxidmFFdG1XVHpaRXNB?=
 =?utf-8?B?NmxwNFZUNFB0RnNWT0w0ZHYvZEowNjBNaEVIRjBQYXR4S3VoOVJUYnlVekdQ?=
 =?utf-8?B?aWF3OVpsQW5pTmxOTUdzMTA3OU5Yc0ZKSVJoWDdNOXZyQ2VuTGJpamlMVGVs?=
 =?utf-8?B?SnYvMlZ2Y1ZjT2MzTW04MTkzT3lUYUFnNy9pNFRQWXYydmVqMEdKSzJyY0N2?=
 =?utf-8?B?ejFYYzZpMXNYdndSTzI0ZTJYOG5vcm5KWElndDlxM3ZiVkIrTjlzL3MxK1JV?=
 =?utf-8?B?a1JPTkdpcXcxVFRGSTJpNG5pOXhQYXhWRzA0c2ZSL2xNYnE4cG0rTWlrOGhn?=
 =?utf-8?B?cTh0YXBYTnFLc2F5Q3RPbEpLQlFkMkZDUFRRc1hrUjRWZ1M4N1hnWDB3aXRY?=
 =?utf-8?B?c0xVRGE0U21pTHVrQjhVM3BLY1g2OFJqbXY1QStwWmtlZHprOXdxTVQ0VWxh?=
 =?utf-8?B?akloWkNpOFpaM2tFQ3h6SWpjVGZGcWNJdWNveDhBQlc5VW1ua3EyaTFybTdk?=
 =?utf-8?B?NFlSN3JYU2dpUGtMaFhPaFNyalpMcE1DdEhBL0FHUmRwYi9qdjcwQ1F2TVlN?=
 =?utf-8?B?K0Jic2pnSjJPWXNuOHdDblJsb281Zlpwckx5VFQ5RlZRdzB5b1gxVDVLamdP?=
 =?utf-8?B?c1ZTS1lKVklVaGdOWE1pVzYreEhZZkkvMi9NSzZ6R2l4SkpGWGQ0cGdEQ1kv?=
 =?utf-8?B?WkR3eURNd2NTM3dCdlJQU0ZaUDR6VlIvLzdxYlNGdjUrWm9xTDBTM2o2c09o?=
 =?utf-8?B?UWhRREpFUHVoa0l3ZGJmMkQ3eDZzSFlTNTgybkJKVFFzMk1GdnBVRUVRVGpV?=
 =?utf-8?B?M09ISmlRb1JtamRWZXBEdUNuUi9qUDd6R0NCWlhjVUNuNVhCUWZUWmJsT0Ir?=
 =?utf-8?B?bkZJMG9iQlJoc0lHYkVXSHMrNE1ZeDU2blA5RkR5d1BpdWdGM3dzQ3VTZ1pW?=
 =?utf-8?B?S0RlTzBhNlBwZ0lwMm9VNzNNOVFPWWtxbUJXOTgxY3NXTE5kWXJFTndiZitw?=
 =?utf-8?B?VFdTK0JhajZpYzlHUGZ4c3NkTmdjQWI3Qmk2TGpqUVRhc2dXQ3ZHNUJLWUhG?=
 =?utf-8?B?ckZ5QjdKQjczcTVrZFNoSURaaURhWTFLWklPS0FEWG5qUTFTa1dVNjF1VExP?=
 =?utf-8?B?ektxU0N6MUxBK1JJSEhOMnZ0SE1aUFF2V1RaUGlDcTRGOVorcC9zTEJnbUYr?=
 =?utf-8?B?RTBrOUdUZEJnazY4RVY5clk3VjFNMnR1c0RpMThpSnVhdkRFNHZrSjErcHRk?=
 =?utf-8?B?RGJLS3Z6bVZxOUFZQU14VTRMZW9zRktSbTZ6NEtHY1hvbkdEdmpRcVQ1enRx?=
 =?utf-8?B?SXZ1UUN4d1BPak1Qbkt3SGFadUpNR3h0L0V5bWU2c0w3WWtzM3FlK0k4K2xO?=
 =?utf-8?B?OE5OK3ppYXlkYmlPbW5yZlE2TW9NSXN3SzdNV3FjZW02K2krb2RtNEVXTGll?=
 =?utf-8?B?bmVpNkV6MkhaVGRodVZWM1hVOHlCaitpc0xXM3Q3cDN2Z2hYdEt0QW5RRjQ3?=
 =?utf-8?B?UjBKZFZObU1xemlUbXRpeHo2ZEpkck9wL2s2b1hLYWVKZGtJTUhvcWxEdVhL?=
 =?utf-8?Q?exw0JTIGor7uvCADLtfeoKjsE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30173ddf-40a9-4346-da5a-08dc24115a3a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 17:06:52.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wzwreqe8DYHm8C1+ytmBCPM71ggMzN6EREIbyTIQRvVCUghNni7CSa2w7gLm7ZvvwlegJL+EEeAe2duxnU0YzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

On 2/2/24 10:48, Greg KH wrote:
> On Fri, Feb 02, 2024 at 09:41:19AM -0700, Jeffrey Hugo wrote:
>> The servers for the @codeaurora domain have long been retired and any
>> messages addressed to @codeaurora will bounce.
>>
>> Trilok has an entry in .mailmap, but the raw documentation files still
>> list an old @codeaurora address.  Update the address in the
>> documentation files for anyone reading them.
>>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> ---
>>   Documentation/process/embargoed-hardware-issues.rst             | 2 +-
>>   .../translations/sp_SP/process/embargoed-hardware-issues.rst    | 2 +-
>>   .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
>>   .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> I think we need an ack from Trilok for this :)

Assuming ack from Trilok, regarding the Spanish documentation,

Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>

> 
> thanks,
> 
> greg k-h

Thanks,
Carlos

