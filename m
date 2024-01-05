Return-Path: <linux-kernel+bounces-18187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B78259CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2485282B32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F30358A7;
	Fri,  5 Jan 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFkFE+Qp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ah0g6xg6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964135288;
	Fri,  5 Jan 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405Hxl0Z008067;
	Fri, 5 Jan 2024 18:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mdW3+s5cUzrk+ZFj5faXJJ6HBpCY7paoST4yu/O9VvI=;
 b=EFkFE+QpHgTOnndSZkx26tMA8Fnq4CGyenZ7IyHJVwaFmgLv0TyG83u+1dhioK70QKBq
 72VsuylUIvfeGjMtzpOTgHUqncKbA+LsCN/v+8y1k7KWqudpnbY8+pMrKW6iOE+i4esI
 AiUVXCekeooT9SfwiNQJ5dfR453P/kpokqeQnXoxwCk8rA6peG/AUamJye7Aa4d2zzbb
 jDZTALCnGfq+1mNclMO8/CuuZgJyLzDHcO5CnZseb12jIJsuaUt3Smo8kcEoUDAi+ofc
 6IGiQE4uRurcdCwUFkbJIGEfuazeqjaVPDFRYtMtbaaB9vsx40mzEjb2bE8rwK7VSdqx LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vepnh01an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 18:12:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405HjQuh010808;
	Fri, 5 Jan 2024 18:12:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve1760uge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 18:12:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bArG/+GbugAq3R467h/bTIqSZsIrEgZp54XiQ2t3Z2nSCm6RWbyUCpIYFSkVeccDDwDQK+IzLDSfa2JtWb652GrL6Qe9LsDOMbqp9EGMhMPH28hl1g958KL2yWXEPSYpnzEa6R921iBlfqQF5HPiqy7ruRQCz/p+Hk4O6xu1RB2MM5jc57Kzup3BKIbd7Gr6aINALyTLxKQJBoEcdyzY+NzeLn6hodjp57T2OnXMZf63l/QJHzQI0AkBMgZK7mZe0RCxzK+Z5pe/jyl/a+E9uScV4BUrOraKK822ICWstswEyKfxTYxV4kQB7JBqztk4sBsU0QPqRkIl5ZlmP9LGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdW3+s5cUzrk+ZFj5faXJJ6HBpCY7paoST4yu/O9VvI=;
 b=NkUmWSwtqD9biH0eoUM2vHQQ0X2yBEiAwnC1AiGG5ZSFpHX2BfIkbJFlf7THzNnwY7We8wodxe27kYz8GfXrHnDOR6rh8P6aTme+FArBWh5FYdZoEHOy7G6hDrQm8hQT2IOKmBPlJ5EysZCgbrjr0wMHQv9iRUptPZJ5cRuxI5rW6DphXr5Tg57INzj55k5Xa1bESxtg2LxkxvuyFRBZBLiLXCkcSdX6g8Jxatu5znG3y5psUu6BqYUxWE3I7PeWqthjgYZou5l96gH3d/Sb/3TEDH/dZU3Wue+VHXyJerX5yM3FRkQDVMq9OdVzSx8eF9Z8wryf2csrg5VdHkOzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdW3+s5cUzrk+ZFj5faXJJ6HBpCY7paoST4yu/O9VvI=;
 b=Ah0g6xg63kV5pFUj3PoQx1f8iz0F5o+BVsROyxWgzBAiCvCHgD0luD3R6VZplRtofwa5UhtSZnUY5ooUiuqWNF0Et2ikYhS7JhNi0Xq5NUivBfbYa6COhv4xg/oJ2PaZKQAoFO8SJh9SCAzMOwCdx0adA6W6gNzuwjvvRnIySpA=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Fri, 5 Jan 2024 18:12:15 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 18:12:15 +0000
Message-ID: <ce59e493-59ba-4875-97b9-17dba71f8302@oracle.com>
Date: Fri, 5 Jan 2024 19:12:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Adding warning icon to warning admonitions?
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
References: <ZZgSGFhvT3SOI4fe@archie.me> <87edev3jya.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <87edev3jya.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0269.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::19) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 55859bab-690e-4770-6073-08dc0e19d8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NrUT4Nzser1sBNwcQG8IYLk4e+YdleaVC43eLSD2f6qKi+m3IZq2QOmQig6eaLlUgJzsTHC8lVoOJOA3uJDE7Lu5Ihhj+FlFHYEbIC9dSfeLGU8zTAnxK+UMrbtrcv6gz9tfZCuop3E6ep8tTpdUU4HkwniyO8NiljONEIF7b6YrlyYPpVyIuQ7B69F7UWBwx2LeBjbnE8Ul4JYtdN3SrhoHlhqDind+RYVitHL6c7V6w595ly3SDiw9Wcp86pxEu9395k0wJpFO9qd4N0vquX87j1rp4y+zyK8txIQLCB/u7+W3FJ5tLY5wqKQVpHjr6QXHQYzugmz7kJ+1E/Bilb/nsaQQr+ZjsYOyqhah8b6e4fs4Wbh3eUaiYYsmFne91erGk4s1eZNPnySRlztzBKgnR4CTju2y/SAPj+4yhCalUc5CDqSuz4uDk+9voC1dYzBCpGyHExKJLUqup0omHANMesMycL3emvVRTxDBqKc7Sl/TwiUu8Tn7DgiusARm42CNgbJnD/vV0fI4F58OGoBrbiRfrUJS06P27RTPYXBHyHQ/XgohT1Z4r4f3yEWnSU2CZrX7Y3ofQeZ9U/yquccyQX8q6Ix/Bic96YJ7VSwF1aBkTb+FO/AshA/2vopZdHYynoOxTgbM708TpBLykmczHWtvcQNrsFYZOGPS7da2uh65Ishe4wtFUgdqFVrN
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(26005)(2616005)(6666004)(53546011)(6506007)(110136005)(5660300002)(44832011)(8936002)(83380400001)(2906002)(478600001)(66476007)(66946007)(41300700001)(6486002)(4326008)(316002)(8676002)(66556008)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnZBY1BlNDd4eU1RSW1xZE80aUdEN01ORW5JVXkydmlhZUxXUmpjMi96VGpu?=
 =?utf-8?B?bGxzaHlIb0hsVDc4WW9LeUZRbWZhbWs1ZUh6a3BvZ0ZDdXVHNlk0cVoyMEdz?=
 =?utf-8?B?dGp5Y3VSUFR6ajFqQncrSlZidzZhUVNBdVNETFo1OGx5TnpLcUhpV1BNdVFP?=
 =?utf-8?B?c1dJSlJkdXZ5UXJKY1JXYjRvMXNma1Z1aE45cTNiTE1CYlFuajBqTzY1cHIz?=
 =?utf-8?B?d1p4bWhDbElacHFtQ2NzYTNEYVlEUVgrb1VvclZpQkQ0Ny9EVXhydzlOUEt5?=
 =?utf-8?B?T0kyei8vbis0Q1VpYTJHanp0TE5nQjVPOUZpSEpzZ3BId0ZsMUJzcU1IdFp2?=
 =?utf-8?B?eGFwVGZ1N2p1M3o5ckVXeW9GZGhNN01mUGczbTZsdTkvWHhXRmlBckxBUnRE?=
 =?utf-8?B?ME9SenpZUUhoVnBOZUZQZEhLNy9UcDZBazkzS1hJNnNUREltMXFZL2E5N3ZY?=
 =?utf-8?B?U2Y0Qks2azZnb2ZzYnNrclYxWTlBOStIb0NBR0JUMFdBU3MyUG5XNStuM0JN?=
 =?utf-8?B?K3BrUW9CTGpBdjRxUytRYmgxakZwcjh1c0xrazQzZm8rWm9pMTQzQ0RPKzFw?=
 =?utf-8?B?dGE0bmRTQzlDeUpKT1pUdW0zMGlZTFRBRkMxZ0dFZzNPZWtCZTBhQzNRR2Jh?=
 =?utf-8?B?ZWgycFkwMnd5cGtmNmhaTCsxMnh2T0ZCRDdmamhHeFhyV2lhdUl6a0dHekgr?=
 =?utf-8?B?K0wzbDVEeWRNbUEyUXI5U01oZERuQmMyTmxoUjdQVkpGK1BkQVB0Q0ZmODRz?=
 =?utf-8?B?UzJHNnpDS3pLSkMwa3V6M24yZjAzUFAweHZZK1gxaGFDeFFhMDBkbzRJU2d4?=
 =?utf-8?B?S2FPRjdWYldhdGszTEtQMUNqRUpPbjA5Z0JpMW5vcWNOVlRVWmdpam5qKzY2?=
 =?utf-8?B?Y1J4bkpjbnZsTVdHaS93ZllkREhWODY0djZQRWovdDlJNUtCYVEzYmkvb0R3?=
 =?utf-8?B?bllxYytRbmVrV3dZeFpZODliVFMrNzNiQUJPd3BkamZjVzRHUjFBYUFkK2x0?=
 =?utf-8?B?dlR6SWJQQWpENzJ4K1BnRForRXYxSFFzVU8xRTJpdDExTEVwVUY2S3hoQ0M5?=
 =?utf-8?B?WmVDdDF4UE9UaWZ1dXRXeWVYYUxaQ2tXUmE4eE9tV2NkMWFMcDgrTmtyMTJQ?=
 =?utf-8?B?Nys1cUtHT2pCVU82RHpLbWpmcmtVT1hSMXlvYmFXTmd5Wk81OVFvSnhYUWtT?=
 =?utf-8?B?OFBtR2FEdDFMbzdhWTlpdVFoeFZHSjd2YlVzQ3NZTWJMbzhScTBRZGNzZ2E3?=
 =?utf-8?B?TGZlcUhBTUJ0ZFA3enMwOEIrMUJscnE1K3hibDZmR2o5U2RPU3ZVWGFra214?=
 =?utf-8?B?S2x6SFdVRHdrZmxBdi8vMzBDTlI1RlYwcTlxdXdtYUpnTzFQOXVocUZxUkJW?=
 =?utf-8?B?T2t0YStkM0lFS3ZHUHpwUTc5RTRIZjJFTjIzbG5rb1d3S01zTWxuUG5VTHZx?=
 =?utf-8?B?amRnc3A5dGFqSjVlYkVKVHlGN2ovOVNkWWlYY3AzN0ZsSmkxSzNxTnJyem5k?=
 =?utf-8?B?UDdVU2M5U2lHTWljdnhKQzRsYlh2RTN2WE41TTByVFpuYk9JOGpLaExKT1V5?=
 =?utf-8?B?TElFZ1BtbktRODNBVGhpQW5GaTM4WTM4YjR2NUpJMkVmTjF2UUo5ZC9NRzZW?=
 =?utf-8?B?dFUreFhtWXJYd0ZrckU3Q2kzaWRpMEpnYkFUMC9CTXd5bU5Xa3FyRzVCeGs4?=
 =?utf-8?B?TGEvWGxRcnR4Q0xKejRTSTRQVHVsRDhzVi9BOWJCcFl5TVlpV3ZTL2pWeXoz?=
 =?utf-8?B?bG9aOE1MRTAvN09RbTBjLzk0QzJ1YjlHU2c2UXEvajcwVXMwUlJ1S2FHd21N?=
 =?utf-8?B?dGJKd3pOaDEwcS9USjc2SHM5b0l0YUxNSjBpYUZIMlhXT3RYbHcvRWVHSVB6?=
 =?utf-8?B?eHFnTW1EWUNTZ1A2b0MvYmdMaG55Q1hHSnhNSWpNdTRBK2pPaXlCc3NhbjJn?=
 =?utf-8?B?NFovcHhyd3BjSjJNOThBUkl4SFZsNUF0QjBSMjdPR2hQZFVFSHdjMS8yM2lP?=
 =?utf-8?B?WEg0SmFGQkErZStleWlBVnc1T0s0UTdReWVlR3lGVE5QOEh5amlKRklrejBM?=
 =?utf-8?B?TFBzbkRzRzJ4TC9UWTJWQmtpQUtDUy9QOWFzdHNJRi8rcmlKZVlobzBEeThs?=
 =?utf-8?B?RW9FaDlYVENPR3VGTVRPMWwrQWp0anRXa1BsekhETjY3cU5KQ1M0b0dPeWND?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O3D8PcPlBAqvqxIKJXJRs2dTnPv6IDKZIusBrgYTsGjB9fpNGwvFamX6RHBZiYj+/f6v/EUM+Ey7sYNggGHrATrDG1+pl2c+uLmM3Wgc0SDGgYaDhiclxpdZuNqZvskTSuAuwar+CqTK7NXEALhzsYMN9tfxaed3QWVarTz1YEVhR9adY+HkmjkezZuordX3TdG3cTUzqIwgbIIoHfNPG+rxDbLNC1qsxY5FlDuDfQhbVRobEAFYxgYyw/82mI/3hYG8Zpb3n3hGJ8jmvORSQBJB8UrfPn+cfXDsO0d174xgO7PSLdUMMnbIDXMjdmKAaHMByU7ZHmA87RcPHwl/6TZ5HYz/aNFYsgHxLeLL9X/5522eK+ybzVJU9FZXZd6n+C83/sGphK6sLcXfckhUR73hXmsgCmeGpODUtQfFbLZ8/nWt65bzyJVaOqkCVIk5z/MTa0SMM9HVJ+kCmVfBdpRKhD9XEHlGTl/q1PzrKkH9QXMprDtonjsFskhXgFLkqS8OLSCRJVhzuKBnv0RBWgIHrGeAYx1L1uCQAPU36muMtCSJsdHf5Rhewe77EhZpn6Ywh66KmYiN+XrNdxG+ECdNMlceExJPs0aQpofea8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55859bab-690e-4770-6073-08dc0e19d8c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 18:12:15.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cJEMuUDUXAX8p0twd46mJFGoFd4tc6pQbfBUmdr2UWx7UoonjyyeoAOoMt6fGuaVVXrYFN2qenk2N/Le8bZv9oXGeNPEjffyLYtD8z4D2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401050149
X-Proofpoint-GUID: -Xw7KpTcnuhDZjRF2vbDjYIXdQgbKSXF
X-Proofpoint-ORIG-GUID: -Xw7KpTcnuhDZjRF2vbDjYIXdQgbKSXF


On 05/01/2024 15:59, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> For the icon itself, the approach is to use Font Awesome [2] (many other doc
>> sites that uses Sphinx also do that due to site theme they use but Alabaster
>> theme don't use the icon, hence this question). I personally prefer regular
>> icon variant (like in TT), but alas it is in non-free PRO plan (and only
>> solid variant is free and that is what Sphinx themes using).
>>
>> Does adding warning icon like above idea make sense for the kernel docs? And
>> does it require non-trivial (complex) changes to Alabaster theme?
> 
> It can probably be done with a bit of CSS tweaking.  I don't really like
> the idea of requiring the installation of another font to build the
> docs, though, and Font Awesome looks like it could bring in licensing
> issues of its own - that's not clear from the site at all.

You could use the unicode symbol as a replacement for the graphic by
adding something like this to custom.css:

div.admonition.warning p.admonition-title::before {
         content: "\26A0";
         font-weight: bold;
         font-size: 120%;
         padding-right: 8px;
         float: left;
}

It doesn't look great to me, but maybe with some additional tweaking it
could (e.g. text-stroke property, sizing, positioning, etc.).


Vegard

