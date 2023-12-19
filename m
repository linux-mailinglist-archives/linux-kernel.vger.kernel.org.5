Return-Path: <linux-kernel+bounces-4757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6808181A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D38D1C23290
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D5848E;
	Tue, 19 Dec 2023 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+kuRftP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W9ROcfdx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330579D0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0JvBF019051;
	Tue, 19 Dec 2023 06:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=M9FwYRUuknOPK057Bfy7g4jcFzIf6x+oXZaRLcU/Raw=;
 b=V+kuRftPYVShD98MRG2xwXTgvdSYLRoTLpnS/VnnqQMjbH6NPyFLvopKblCdJ+lkZI1W
 +R0UuAUpi3XtmDx1lb//nyJ4W9EDo5kGTqZ3ovj/VKtnfAMgJUhDK0adZSrN432NDDRj
 A5iuc2F+a8X9vP+Ok6Dud4VB27Jpkod6eLt3LpY1Qvdt7D/EvK07XNY+FmvIlEHoq6AG
 iaN7FRhpP8m2km23ZdzNseoMPDrEEzrdso3wjjo7sd61jOGKCuxq9Et7fLJsI+sVUClX
 cH50596KZG1EzcZZvyHsbzomJcLfGll58cex/EdanVoVg1g8NsPzHMAytkFNf5IoPSdi Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gud52t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:42:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ6c3ec022281;
	Tue, 19 Dec 2023 06:42:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6g2k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbrJFwYIBpXMcvJcUDvBUGaFkESxkC17E2unSJNbVQW89fhNPQEEHQsz/1BOevu5bbtp477pQmQNrqrsasUomJsOLyCAq5SBW/RTDxtmMR8N0IU0eGOXtQCEIecz69ket9nW9VR8excmGX0uLosVQq+XhU/12uHJik1K/YOq05MYnTvmz4mzy25C8On8wL82cZgdjyTGDpYPo2ymSUzkNJ6r4LaYulfCvNWAWx/TP1Dyd2zBokcYEJpnnApyGm8N6rVXl3zdyzccXNFo1JFVWXBVHXYz4fvFXCPgSiwCPGjkJIEZ6FG3/Sc0nZnlUJUeYxViSWb4CDUNN7gX6dUFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9FwYRUuknOPK057Bfy7g4jcFzIf6x+oXZaRLcU/Raw=;
 b=UDRnhpAxZ250BgJZj7nJmkOZndNqGbLHjFEkxSNrn+MwTJEcREAnUww12NTVicX+3/BBcWRQeHxaMN9rP3qmR9z3VqHTHoqvqYxBhAyv/Akh1VfRu6VWnVqcQpX/slP5YcZ3RsNX/qY95D6dpeG385cPTL5rcKt7WcsnQiQJHryWjxekji/sJdYim7sntmPAYBmd7rpmnRrZCUpRGSGfs5N+e8yb5TwiNPKHr9L0lLGFzQbcNdOzHMKdTe4kOiQIhdYvSJz676+gOf/e+L6mNpwAeW5zNcn2sjI5azEVPG/y4qNGEIjxKyUfpkJ1IdZS5andOimItKOWgDyDDEHeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9FwYRUuknOPK057Bfy7g4jcFzIf6x+oXZaRLcU/Raw=;
 b=W9ROcfdx9GzxWbwWkb+9kAfr6nWsdXclZzrSllZJ0Hm+oyx7IbU2tCMmCGOY5dTSFHvkpuEclYSpnKgol0gHTniJvR3WHyp4VRa8D6T1wE5NcUFAdQHQ6LbuI609El5Tn57Y65AM3sR64hxTPUFWb/S64lgHcJrlKqhzgI8skL8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 06:42:01 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc%6]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 06:42:01 +0000
Message-ID: <1c13b0cc-098c-4f75-9f37-a53a66965409@oracle.com>
Date: Tue, 19 Dec 2023 17:41:51 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: fair: reset task_group.load_avg when there are
 no running tasks.
From: Imran Khan <imran.f.khan@oracle.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20231215052652.917741-1-imran.f.khan@oracle.com>
 <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
 <d8507f86-2458-4b01-a774-5102473e657e@oracle.com>
Content-Language: en-US
In-Reply-To: <d8507f86-2458-4b01-a774-5102473e657e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::15) To SJ0PR10MB4479.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 726feaad-00c1-4d81-7610-08dc005d9a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DHGdKymzEXxRLn7Cl8I82rbnNlTJVtsECCthKCTlN7ridG+aPSAtMtc4E6CVbzoP++MUu1GbMiGCCXgpWTPrPAEieDYZkKNkBDnXrpFbDWcY2svV3TPLc8aEBcFarUgWbE/O0m7dn6RtH4Vx29+lzO/PKcbarPDMN6HQYMeqPBtUmAe4dBkSKUamWRxplWepLu3F68z3eEqvCbP5KpZqqvm6itNDPGsYkR0oCQVTtSG6rPFp7yPVZKQqJi505bYAauqVhSyg4C/sDf3EaGR6e2CCXKW3fI9TEqUaeUCHMPdRqzXbvQ+TvtWhowajlAjEflx9Jqhi1QKQpG7U0fCqq0hH4yhejYzfTc9DsKQuG/KusVXLzRr/S/ivQkP9wTjlGTWbUSYMU4TQHtRjpZXmRKB7GogBlx70cE/7/YwrihCzFJqthB066q6vRefVeHxALmRg9KgHmgNE8VDfTEcvj24ilIt3NyzsATsQjCRwUxL2SELtZMMAj0SUg4MpFVK9Y98FcTPkb8ifJodU9lUtlOP3FPLorxjw8ghaqO8m7Rn2SVjxWyAqgr7OnXS47HOnQwWr2RwM0b+wz3OO3Y+Y3Pl94Oc7CW/vaz5rf/2mdNcfb5IFgLQGENJ8PSN62cOsz4O39uDtcSmZhmcybIj34w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31696002)(86362001)(36756003)(31686004)(6666004)(478600001)(6506007)(53546011)(41300700001)(66946007)(66476007)(6916009)(66556008)(26005)(2616005)(6512007)(38100700002)(83380400001)(2906002)(7416002)(6486002)(5660300002)(316002)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2J1VEFYcTVxVkRFSlA1dVh2YWU3N1dqK1hCUG5uUVVBTExGVVdIckducURv?=
 =?utf-8?B?RVEyckIyYVhJV3dNbFVlZFBJMFd0VFZqQ3ZxeTA4a1dQdmxpMXNzZW03U3dP?=
 =?utf-8?B?d01Pd1VrZ0F2cklQWkpPbzRSRXNWNS9jeUVRQjljbTVnWTlzbDY0T041S2tY?=
 =?utf-8?B?U2ZncXBCTUg3QmhrUlRPOE9nMWQrUWhTaUIyMEw4Y2xub3lxdDA2ZlVBYnRR?=
 =?utf-8?B?UDJ6d2V6dUFwb2FKZW5pZU5QQXNjVDd2TTJLLzlWdnFDQUFoQml4QkIrbUlI?=
 =?utf-8?B?MnhBdUFrQkNFTU9WUTM0UitYaEh6cjJCL1NHNWw1OVBLV05ybVpHcGpwOS9D?=
 =?utf-8?B?M1FXRVJISlZSSkFqbDBUb2ZsNklZeG1wMVJJWVdzampmampLSWs5aHNNQkw2?=
 =?utf-8?B?Um05OXVEcnJtODM4MktLc1AweUIvMEJvQjVmK3VScHg2dGUzMEVSM1BIcEJR?=
 =?utf-8?B?VGtNdDQvMVlsY1Vnb3FsQTZUS3BtUkZUQ2xpeTY1UXRKMWo2UFZsSm5ITCtn?=
 =?utf-8?B?TVNqbmNLNW5kNk84SEREVmpTTHBxb3RkZ2lrdXl2MDZwRWxYNGI3d3Rrd2Y3?=
 =?utf-8?B?NkRXaGd0KzF1eUFVMU5JQ3k3NG9OQ28xYzV0VnptcldaYzhjclllUy9yTFp6?=
 =?utf-8?B?bTZTMmphYWZkN0FpbDIxZmxLNnN2V3YrRkF5ZDE1RDVMd2Q4Z2FwUlAzVEla?=
 =?utf-8?B?YXZKR1NOKyttN0owVFppSUJQMzNvZy9PWi9XTWkvOVVITCtLUjhocWp5UFFJ?=
 =?utf-8?B?TGIvV2luTTloQVY4NERYNzlTMHZSYUExeXJ2MzNnZ1A0MHJvRzROanpKSHUy?=
 =?utf-8?B?a3d3Y1I4QWhXb2o4QzJyWmlIa29XelVlRTJJZVlVanVJNVRoeWJlOTVTLzg3?=
 =?utf-8?B?T1JFM2RmbWNYT3M1WVRLSEdYZTRrbGZXVVYra3pwajRYQUVHanJrNTFEaHNn?=
 =?utf-8?B?NUJZVmtaNGluT1FBRVYzNTBVU1FKbSsvcEVzNWdVcENyWTA5UFdwMmlaZlZH?=
 =?utf-8?B?UjdaOXZVaC9TUklhc2xGL2VmZ1drMko2QU91K3FCQWRpT1dIUkZ3RzFVMjlw?=
 =?utf-8?B?T0MyOW5mTlI2Lzd4NzROb0F6aFo2OU1vUDZ4YXR3STB4azE5N2Y2TE1yR0ZH?=
 =?utf-8?B?Ri85cmU0TkxhWUYrVitMS0dselQwdjRHdXg2WWM3YVlqb3Nhc29kUXBFcWh4?=
 =?utf-8?B?ZDlUOWo3RjlXdXNUUmx1TFhLTS83MWlHVVY4aXhqNi9aTEFmbEJCRW1qMCtB?=
 =?utf-8?B?VGthNmJIdWdLT0lEUHU5TkEvUUlNWUl2SWdyZVZiOTdWc0FuL3B2aGx1NlB2?=
 =?utf-8?B?dlQzQkJUV0JoczNqSWlVSTlwanhBNzN2WUFNd3hwNTBQY2ErTmpNUUQxZVdN?=
 =?utf-8?B?N2F2WEJRRFB1aFdEc3R3dTErTndkTkRkYnZtcExTZ2ExYUtKU081aDROcUlY?=
 =?utf-8?B?b3lFeEs0WkVGSlZPZXhwek1Ud1k2aWZwd0RMRVdjVlFxM09kQXFIS1k1ZGNy?=
 =?utf-8?B?aVZwVUZyeWMzQmJiVy94RG9HM0hGd3Q2c3Y3cTgvYnhuMEVRRzhzODV2cVlQ?=
 =?utf-8?B?SmdxeHFiR0FkajRsWFpDaTA2WmkzdFpIRDNNdSt0Unh4bm9HdmJXVnJvWkFL?=
 =?utf-8?B?TFNSa09JVmxNQkJtMWpXRUh0MnErVEZ3TXcrNGpQb2Y3TTAyYTVZdnUxTG9i?=
 =?utf-8?B?cjl5UXFxREpGNjhhRDFrbDIyTVcvZ0FxU2N1dUlWN2NvL1A5QXIyeGx6T01T?=
 =?utf-8?B?ckwwa0E0emZFQzQ1czJSdFlFK3gvWlcvTEJLbGhXbjAyVmpiZkRUY0I3dXlm?=
 =?utf-8?B?ejRWbDQwR3pPS3Y5aUdwLzBtWVA5bEorYTVyVzRsMVpBR3RybUVMd1hnZk9o?=
 =?utf-8?B?SHVIWEk2MVc0eTM2cWk3SVFOd3BhdWRUTTIwaXc2R1hjcnZQWWpjTzJEaW9E?=
 =?utf-8?B?MHlmdDBIbmNjNkhXVWplc1Fwcm9rb3B1b1RjYWlTZXdPSTVFcjJLYlhUdE5R?=
 =?utf-8?B?NVAzdVpHYXUyMXFRNWlZVkhpWDNvQjBiRnEzMUJ4MWxZa1JLeHBsL1EvcVJW?=
 =?utf-8?B?RmZKR2ZNK284WDR0bzViMGg5ZWV3UGthU0ZBc0dWUnR0Mzl4emovZ29VaXUy?=
 =?utf-8?Q?ibhaz1s/QgnYdP80Mo8kS7jF5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vGipZywWJxlUEZPEi7X/Ym3Nyyr37DiDdG2UtAXMvCISzvXDNFYpajKqB2e3+4fN90XOZxMA+ND+qadzZ7lpOUS28XD5vXDtxh+Vlp8+xh58LZmwIrTOYiRmYICoZ4GpT5i5DwsPzOkByRvelEH9dUhkfdaqzQRwtsJIw1dsawL0ugbLmLiU3nY67+BgpGf7DoJScjwcqEATHhfTW6Ox8eMAnTj3lbrizswvybonaA/sS6v9wXDkMEB/OycrAlVVbqSmzVhv0IGu51VyIXN3DWEHQA/pHaDSrDIy8iSiJYu7BLQyXJvuIzEaJopGTCnGYsN7NOqNluNobaiOtqSYK3EqRzUpQJ8V+TC9+BBE8eWTQk2sQiXOAS12hlx1DWCCHj6OBAkgS9nYFfLQN8hih2z3e1K51c5WGm5cTw1AWyvkbtJ3SijoOPECRDJ24OyYNxk5DYkH9MWiH4hAOa/hH2syHxa6QTDrJxTxq8Aq+V47yV5Gusm6cf521aS0G7UHkLM78WkUiXtPHPudAImz662uSrAbiSMnF1I4WU9qzKtcYsuvO931GT1rnYgMoFFeHNqv+/06i5Mbsv32tGFicZI8BGasbPvQDUo0/nJ1mmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726feaad-00c1-4d81-7610-08dc005d9a64
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 06:42:01.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHW14JnMfKvnutpBhqwx/IjI6ppbqBrQUSSA8/g/eB8NmusU+vq/NJqEgYlhGT680lkY0mGZ66CPtyxzLtP7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190047
X-Proofpoint-ORIG-GUID: 76SyY8QB4KJf2YZnzEnhEYEwSudmhH6E
X-Proofpoint-GUID: 76SyY8QB4KJf2YZnzEnhEYEwSudmhH6E

Hello Vincent,


On 15/12/2023 8:59 pm, Imran Khan wrote:
> Hello Vincent,
> Thanks a lot for having a look and getting back.
> 
> On 15/12/2023 7:11 pm, Vincent Guittot wrote:
>> On Fri, 15 Dec 2023 at 06:27, Imran Khan <imran.f.khan@oracle.com> wrote:
>>>
>>> It has been found that sometimes a task_group has some residual
>>> load_avg even though the load average at each of its owned queues
>>> i.e task_group.cfs_rq[cpu].avg.load_avg and task_group.cfs_rq[cpu].
>>> tg_load_avg_contrib have become 0 for a long time.
>>> Under this scenario if another task starts running in this task_group,
>>> it does not get proper time share on CPU since pre-existing
>>> load average of task group inversely impacts the new task's CPU share
>>> on each CPU.
>>>
>>> This change looks for the condition when a task_group has no running
>>> tasks and sets the task_group's load average to 0 in such cases, so
>>> that tasks that run in future under this task_group get the CPU time
>>> in accordance with the current load.
>>>
>>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>>> ---
>>>
>>
>> [...]
>>
>>>
>>> 4. Now move systemd-udevd to one of these test groups, say test_group_1, and
>>> perform scale up to 124 CPUs followed by scale down back to 4 CPUs from the
>>> host side.
>>
>> Could it be the root cause of your problem ?
>>
>> The cfs_rq->tg_load_avg_contrib of the 120 CPUs that have been plugged
>> then unplugged,  have not been correctly removed from tg->load_avg. If
>> the cfs_rq->tg_load_avg_contrib of the 4 remaining CPUs is 0 then
>> tg->load_avg should be 0 too.
>>
> Agree and this was my understanding as well. The issue only happens
> with large number of CPUs. For example if I go from 4 to 8 and back to
> 4 , the issue does not happen and even if it happens the residual load
> avg is very little.
> 
>> Could you track that the cfs_rq->tg_load_avg_contrib is correctly
>> removed from tg->load_avg when you unplug the CPUs ? I can easily
>> imagine that the rate limit can skip some update of tg- >load_avg
>> while offlining the cpu
>>
> 
> I will try to trace it but just so you know this issue is happening on other
> kernel versions (which don't have rate limit feature) as well. I started
> with v4.14.x but have tested and found it on v5.4.x and v5.15.x as well.
> 
I collected some debug trace to understand the missing load avg
context better. From the traces it looks like during scale down,
the task_group.cfs_rq[cpu].avg.load_avg is not getting updated
properly for CPU(s) being hotplugged out.

For example if we look at following snippet (I have kept
only the relevant portion of trace in the mail), we can see that,
in the last invocation of update_tg_load_avg for task_group.cfs_rq[11]
both the load avg and contribution of this cfs_rq were 1024.
So delta was zero and this contribution eventually remains undeducted.
In this case scale down was done from 16 to 8 CPUs, so CPU 11 has been
offlined.


cpuhp/15-131605  [015] d...  6112.350658: update_tg_load_avg.constprop.124:
   cfs_of_cpu=5 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 0 delta = 0 ###
 systemd-udevd-894 [005] d...  6112.351096: update_tg_load_avg.constprop.124:
   cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 0 delta = 1024 ###
 systemd-udevd-894 [005] d...  6112.351165: update_tg_load_avg.constprop.124:
   cfs_of_cpu=5 cfs_rq->avg.load_avg = 10, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 1024 delta = 10 ###

.........................
.........................
 cat-128667  [006] d...  6112.504633: update_tg_load_avg.constprop.124:
   cfs_of_cpu=11 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 3085 delta = 0 ###
.........................
 sh-142414  [006] d...  6112.505392: update_tg_load_avg.constprop.124:
   cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 4041 delta = 1024 ###
.........................
 cat-128667  [006] d...  6112.504633: update_tg_load_avg.constprop.124:
   cfs_of_cpu=11 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 3085 delta = 0 ###
..........................
 sh-142414  [006] d...  6112.505392: update_tg_load_avg.constprop.124:
   cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 4041 delta = 1024 ###
..........................
 systemd-run-142416  [011] d.h.  6112.506547: update_tg_load_avg.constprop.124:
   cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 1024
   tg->load_avg = 3010 delta = 0 ###
..........................
 systemd-run-142416  [011] d.h.  6112.507546: update_tg_load_avg.constprop.124:
   cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 1024
   tg->load_avg = 3010 delta = 0 ### <-- last invocation for cfs_rq[11]

..........................
..........................
<idle>-0  [001] d.s.  6113.868542: update_tg_load_avg.constprop.124:
   cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 1027 delta = 0 ###
<idle>-0  [001] d.s.  6113.869542: update_tg_load_avg.constprop.124:
   cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 1027 delta = 0 ###
 <idle>-0 [001] d.s.  6113.870541: update_tg_load_avg.constprop.124:
   cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
   tg->load_avg = 1027 delta = 0 ###


If I understand correctly, when CPU 11 is offlined the task(s) on its cfs_rq
will be migrated and its cfs_rq.avg.load_avg will be updated accordingly. This
drop is cfs_rq.avg.load_avg will be detected by update_tg_load_avg and hence
the contribution of this cfs_rq will get deducted from tg->load_avg.
It looks like during hotplug load of one or more tasks, being migrated are
not getting accounted in the source cfs_rq and this is ending up as residual
load_avg at task_group (if these tasks are members of a task_group).

Moreover this looks racy and dependent on number of CPUs or some delay.
For example for scale down from 124 to 4 CPUs I always hit this issue but
for scale down from 16 to 4 CPUs I hit this issue 8-9 out of 10 times.
Also for the cases when residual load_avg at task group is low (like < 10),
I can see that both of my test cgroups get similar CPU times which further
proves that the unaccounted load avg ending up in a task_group is eventually
leading to uneven CPU allotment between task groups.


I am debugging it further but in the mean time if you have some suggestions or
need traces from some specific portion of sched code, please let me know.

Thanks,
Imran

> Thanks,
> Imran
> 

