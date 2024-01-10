Return-Path: <linux-kernel+bounces-22298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD274829BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BD62866B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC44A987;
	Wed, 10 Jan 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aOX1o/yM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t+16QTQM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D4487B3;
	Wed, 10 Jan 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ADmgVS012125;
	Wed, 10 Jan 2024 14:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=H9sEIVldnGoRgf2kcOhFR1BmIPPOXZOZtCap6s9EJbc=;
 b=aOX1o/yMVcNSg8wGytHjL6WQbtwmQF+fH7yDX2cI4NP0Ozgdmpub2DP1xPTThpggAmNN
 +iHgN83OpiwdOjZgl8PnkHWZH7/s9RtwsFrZ+fDiyy0RmMZM9DTTr6BEOEEuWTnqDfsC
 ORyMe4AKRTzn5VXtLPWbp6vQi/MlV5yWCHpVVEjBb3uzvoWEPGA6pmjPITf3c/asPJit
 +Gfhr8uqj+1oWJMoqtBFJHgAWsD2GmqBkSZKRlEg92xdrvpBb2ixMddTblkNwUqm4oMD
 k4D5RsYvyc5ojJQvSYlRx4CYanCGUivl9mHmG2s3D2U7/fwoW/cQrWaVq9LL3L+lhZJt Gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhpg7gs7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 14:02:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40ADE3Q6035144;
	Wed, 10 Jan 2024 14:02:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu64347-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 14:02:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/ot7XQn3pPU+NB4dYfEVKUI2RFyyp14GcMHrxX4fAjQhOeYBLVS6G+CSb4rheKNiQWmfmsaC3z4IcOThEv/6CtoyIpSlcUaZO48Mcwa1UJiszWOW+HjdUgzDBtmFFGChaogVge+FKN6195NnHXn/nT1/B1UcYND9FdfrxJFF2/IGsyiPc58M5gLTrnAV8SecBlIDnZsvpaYym7D3a9CBc/YnA1TImBFJ0vuqig/Dbm9Fk1LdNhVVlvpYY+ABLexKUQW33B3AH79ds79/AaGsSbWXcR5hib1xJLyk3W4knXqVbjsO0ysHk6onNp6YE1GrIOlkgkDRZT0LawkkJJ+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9sEIVldnGoRgf2kcOhFR1BmIPPOXZOZtCap6s9EJbc=;
 b=LJ8yUIx9j2XBgxvJPQkLUzm6INkgnud9SvuFj5jpBt9pG3kpR8q2IiQulyuhz/h1j/YBnu6/CZhTwQX3poE0Q9H8Mea+AfSOnczyCr5OzqpdNFzfI+jEvibjMTiHAtvQId9m21oqSQgrU7gGiHLl0dQC3+p++Iw+atBsHCwptPo3ITN+y4iX4fW8slvjBGZKp6/vOb4DLcHq3d5AGb63zr09ovs6y8nt2Iq57zmN1dFg08+fk5U/0KxtmfVzMCUShGovxxp7Ii75eOauHoNzw5rsg0ijPTrlOpPnX6Wtn2vwZYRET0umQNGnJRw4z3nFhIqw2meyGkibvMXp57c0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9sEIVldnGoRgf2kcOhFR1BmIPPOXZOZtCap6s9EJbc=;
 b=t+16QTQMs9Dp+D4ALglZLqKnl/nAvqniiPuRFee9539otAUwPBEES8MqBsfkWtTyXAtnd8ERfbgLYl+SMFLECRcY/ES/cPuYvvrB4OLbPYO8VzTTCO5tlS3Uhf53ltTa5dBoCGTb3Ls8lxiV5yf6HLtv/yAV5sunY3Yj8rMs2JU=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ2PR10MB6990.namprd10.prod.outlook.com (2603:10b6:a03:4d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 14:02:20 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 14:02:20 +0000
Message-ID: <2fcdab38-de57-47c3-9de6-99c4fec7a822@oracle.com>
Date: Wed, 10 Jan 2024 19:32:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 0/7] 4.14.336-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240108141854.158274814@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240108141854.158274814@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ2PR10MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 106a6ecb-fe48-43f3-6c33-08dc11e4c307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xenvJ+Va2VIrXuG/ovV7/KMt/xEQtaKKWOjLCI5IzuYEywMMZz+YL8JSrXcc620DHQylk4/TwjEirZ6kim4858hu7v3AB+C6izQczjyQO1Kll4yspxqlJqx/j0CZKQZsOjbo47MNZbN0jF2OPpI+k73OO2uKzAGGEY1bTkGWEYGbmiUzJ+p8b+6feENtLo89vKr8Vcca/A58OLawgb9q8xZQT1kuVor1WSkvJit16+t1YDfOfgkeKQycp1pw4v0Qb/k8DQCQuc1yzsBF17KJEcjIGRXk0h/LcpiUF2MZpGOri+ptsQX6NVcmK+uK0ecb/O7JDtMLCMMzL+ukRClInm4zUqbTc/BF9Ab577vGZzy6slbE35te3YfELdc58ZFSa6NTy56DwPvf+HTNxCHHlLFMP25i7Fw7rTGg8fHPgweDA4qTXlzZw4PUUl3sn0qIrzSr9Oyl0dGhDgVJe1dfghAek198l6eFQHKs5wuP8uc6hHENiik2H+++pqSYhJZB9CBy1muMe/1tvJ8MldR7rtSAnkLXXdSQuXeZuu3RZwprgQnvZ6AqUX0APTwHOJ+1C6HJc9XPRnV+8c9g4NQzW3sUOZPfLS1O082Ex1NjMMRE3sGHVg65D1YVjQPsFYiPsfqBjZlSwEh3p+PCO1N1vg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(346002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6666004)(478600001)(6486002)(966005)(66476007)(4326008)(54906003)(66556008)(66946007)(31686004)(316002)(53546011)(6506007)(6512007)(31696002)(2906002)(5660300002)(41300700001)(7416002)(38100700002)(86362001)(8676002)(107886003)(36756003)(8936002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3o4NU9qQ1YrOTJwZ2dseXVFK2Foa3NCakRoRVZKUXBjOC8ycnJLcmo5cFJC?=
 =?utf-8?B?MDhzeS9oWGQ0b05Pbit2amxZWUsyMjdwUlZEdU9BQy9DLzduUEhpSkdZdlRz?=
 =?utf-8?B?Z2pJZDluRGNZREM4QStLTTV2RTRJR3Y5RTZ1WkVvOHVsZFo0c3dDSW5ESk5N?=
 =?utf-8?B?RGNKdEwrb1lZek9OY3NVNjQ0M2JaQ3VaUndvTG9RaXBEbWIyTnFVandjd2R3?=
 =?utf-8?B?czdxOEJMcVlmUU1LT3V6MDZFUkdwVTlmU0R2WUhqNlA5Z0RWeXpXLzRrYUFR?=
 =?utf-8?B?aWY3MjFKU3p1Wlc0eThKL1pYeWN5TW1UYmttWDlDWmw5MnN4ai9FRmNjdTNy?=
 =?utf-8?B?NlA4OWtXMkF1bHZISVRMNmViYm82dkliVHJvYWx3Nm0zcmRLVHc2NE44ak95?=
 =?utf-8?B?WUxwZ2NFZHdwWjBERWszcStjaXpvdkdPb3VpRGVQc0NraXpTQXNSZWlGcklM?=
 =?utf-8?B?anhiZjI4WE1kbHpvaXNsbmUrNTZQTFUxemFHL2hiZHIzWmJQZnJ5WmpoRmp6?=
 =?utf-8?B?U1lad21vbVJ1bzM4ZTFTaktZRXBEWENMb29yakUxS0FadkNxN0kxeGNkUEJD?=
 =?utf-8?B?RGo4NTlCNWE1ckp3YUduOUIwOFR0dTNuZmlDcHNzQWl0QS9ieXA0TjhSQmFz?=
 =?utf-8?B?VTBWdUhTaDNyUnZGUDczWldIcnVSc1M2MkhjZDVUNG1pRDdVTXQzZVBJYWR1?=
 =?utf-8?B?cmFRNkhVaGREWXNRUDBEbm42dW9ZQTE1dEJpUWI2M3ppWVJIaG42SCtaSGNU?=
 =?utf-8?B?c1p6dm9udlBNY25RWFJRYkpZb2YxOWIxNy9OR3FudnFJenN1SWtCS3FBU1Bp?=
 =?utf-8?B?Y1VwU3NqQ1htN3Q4M3ViVHZTSE9pTldLNzc3SzI0cVpRUzdSaTRkbmpvWlpk?=
 =?utf-8?B?WXQwR1l4K3k5Ui9KSSthMlc2VUtjcGZ2TTZGM0xzdGR6cDd0ajVjRzVvZFJN?=
 =?utf-8?B?UEN3RmhHQUdQd0sxMHpjZUc4Z2F4REV3L3NLd1Jva1FaYW5NSThzWGpUV3dk?=
 =?utf-8?B?QUxDM0l1K1dVUWxweDdJZjI5ZzhVbUFFd0RBOWpKd2haRWFvVDJXZCttWERu?=
 =?utf-8?B?eGJiOThwRjZHUEtMMWJpcmxGcWVDeU1jRkVPUktKTTZNZkJaSlFhbXV1VTRC?=
 =?utf-8?B?bTlON0hiZUNhUnZYNnJ1S2pwd080VEdIZU90cW14YTEyY1VRKzF2UzZkZ3BX?=
 =?utf-8?B?RW4zWWF3cWhWT083QzRoblVpU3BJME1sN0VTRU44d3ZON1FlNEJxenFudVhp?=
 =?utf-8?B?NlFRMWhZMUtJdlBJaHA4aG5ZVEV2R09QUkFZQmt5QmQzdHMyaEl1UlVXZ2NK?=
 =?utf-8?B?d3luSEpWeXpSVXE3bXF3NzhMNWdENWRYT05Rd0NSUnA0L29ReWFrRjg4bU00?=
 =?utf-8?B?Zll0eDhhajZNRFM3SzEzVWs0Y1ZuOTM5WTlYOTl0YmFRb25TVXJkQ0xYNEN5?=
 =?utf-8?B?UXQ1ell1aWVNZkxkaXRzeHRsQUEwNnFrMzVJUkwrR1haeGhEWE5la2swWkcv?=
 =?utf-8?B?YW1ka0swNzRDcHJub3BLNEpzOXVzODRvSWtlOUFCRFJvbFQ5Tk9sN1cxclZB?=
 =?utf-8?B?alFueXdNT25VZUdyb0htQnoyZERuRVl5ZnFkYWpzY1p4elF1aWg0MjdCV1hx?=
 =?utf-8?B?TEtWMHVUYXlCaitLSHF3SmwyM1d6aDdBcHllUldpd3I4NHI2cVJ5YlE2azI5?=
 =?utf-8?B?bjVzcHNyNHlWYzE5cTFyZmFvMGtBODVpM3krcVJkY1hLdUQvUDBFMmRDQmp6?=
 =?utf-8?B?aHB4N0t5azJVVnQya0thTndZR0ROaEQrbTE0QVlPU2x2aHUrVytjYkpOZlJU?=
 =?utf-8?B?QUFqbEdLL2k3akFGNEdJUlRzNkw3SDJPL2JkbExVaEV3Q1E1T3ZKM3FWcUUy?=
 =?utf-8?B?OEJqWkJ3RXJJd015NExjNDdUU0xnZ0tmZHNhdUE3bWVGMFYycHdwWnBMWklM?=
 =?utf-8?B?aG5LOUlsWVY2QStvYndickpHUm5MbHVHSjhUMmZXVzhYMXNjT0tPWlBjZDB1?=
 =?utf-8?B?eUt3akIrWDdOQTVKWllYSzc3bGNiL2hHcHFPTTJJZXNCVEt5Y3FyV2dYQmll?=
 =?utf-8?B?bGhHMWRaTE5UTVFyTkE3L3c5WTZxQXhVRXBnWjlMam5WZCt2ZmYxNmNKZnFX?=
 =?utf-8?B?dHFJcEd3VHBaOVdzSGJWOVJRM05CWDdwNHR3YjBrZFkySlF5bzN5dktoMmxQ?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YQz8IVvfM+VQfCi0+5UxaJaOKOwJIsbO+mLyvIMJm3cnt5SLpGTNuqZfYEELetP6rXKF+e9RA4PQ2Zhdfm6o3O5kg77LNdkOMUpG60LHUt7MUCBbLaop+D6kiArbthfu4zR5c02CSFWF8b0DPV+gkRjIEINRfUYSnhgvhZlqTOeO4CxeBECTqBWm+2FIrJ3wupSn7kdVl7xF9YhEkFM+oXJEhykqOlqlRzOwjYkmaqUNUqGBiViRMcQ66ZLZp+x5M/okk1Nz12dxt/LxwelZU9HIoGPxgA6P/Kd5znoIdmeDl57oPx4/4Fb+6IaHE48RREWtqwa1rTpJejyV2wtA08yzrVuZoTVDWWqFnkJI2zjLjQru9gq8rcBWxGqeAuPAmXK9npjSJYijhhq3d8qrnAWl30LQCIP4tl7WpruD6o37/XZoOujhMrRDe3HoGCq0IqZSXEjhOUpUhZ3V6Z1jcHBAiMUef5UxUqZRAllp5L/MmUAN+iAluLFslOeDV0iDoSyt9BKI6XQPPfyfGSuAs1Axj9NkfsUDs1XnbYTDlHkDIuZtFw9CVMneagxV9VfXgPhRESfgecj3OrrAm7oXRGSDrp7+WFexXX+3BnzrrvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106a6ecb-fe48-43f3-6c33-08dc11e4c307
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:02:20.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0PBYtpLlKUhdO33kEB1Thr/mSu1zbgmp+d/1rBWlHaSEGQkKWgZAyiW13puFcVW2e94TPZ3C7Bn+/DExIdIg8aU6IMTQdN9iJXvKxCbnmpz4o7Icy1HXaTiJ192d8HQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_06,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100115
X-Proofpoint-ORIG-GUID: 5U7WSEqQNKYdE3EzgvuXqnQIzlOExVGS
X-Proofpoint-GUID: 5U7WSEqQNKYdE3EzgvuXqnQIzlOExVGS

Hello Greg,

On 08/01/24 7:51 pm, Greg Kroah-Hartman wrote:
> -------------------------------
> NOTE, this is the LAST 4.14.y-rc release cycle that is going to happen.
> After this release, this branch will be end-of-life.  You all should
> have moved to the 4.19.y branch at the very least by now, as this is it,
> time to stop using this one.
> -------------------------------
> 
> This is the start of the stable review cycle for the 4.14.336 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> Responses should be made by Wed, 10 Jan 2024 14:18:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.336-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

