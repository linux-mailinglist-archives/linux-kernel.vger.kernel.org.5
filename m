Return-Path: <linux-kernel+bounces-9601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBED81C846
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CDF2865A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85C14007;
	Fri, 22 Dec 2023 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsVQlh5P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nZBWEhPB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047FFBFA;
	Fri, 22 Dec 2023 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMAU1M8025290;
	Fri, 22 Dec 2023 10:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ThDPhtk2D38sJCJ74BjOj2KUsRq980tPpPUfv7e7/mc=;
 b=XsVQlh5P9ddN04zmdiuk5NC353uvk8Z9bwI+BmrGxRrED805U6tOykNgUzcFrnVabvaa
 v3lKstVQ4w2HwQXl3mVxCesll+ZFRvJCFebZUG8TX3mgGzj6hO8C7YZxBMPi/vFaOCdt
 vo2vugq3Y1ayyAx6NXGq93PGAncyz6+zznCXAKMwl26UMptLdke9WEW8QXAsoQa5FB7j
 op1Y4coAzRtVonXIGfo56MZZP/EZjfIOIAvboFgLu31g+p+hGxtMbqn77kaA42FyeiXm
 6NkP2IwCeFU1Gb0iFC7WEPBSWDCfUUTaMSIs+IJKw0gVDeDRrGBnHwyytYHlV+uN2cQp /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v4atx3mer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 10:36:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BM96p89031036;
	Fri, 22 Dec 2023 10:36:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bkcduk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 10:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/eFxrF0UQfY9DJ8MzdUMGzIfEdBzUI3sJi1WdbCsf41XiByfEsDG7c3Q54z/T9u9mQrHmf72cCIV5/ncv1xSFW0j0sPh0A9fE62OPf5CHDWZ+53ig/K6se1otzAiNay1kZyhj2gcc7YJBre5JimDfCPQhsoTm2TQbWpZHbj/ACO8KuSZffruhW5oUarTG8EHd/7wVxWnotuSwWBG0mpZmnsSK+Fv+tupLANsL1BA7AfNNiOb+Amdot3t4TlhP7Ik2YZ6BP3zBDJInXdUA1jsnVVPbL/x5LwQro/c7qEMri05t0inVrJUZiBHhlkqp02SPLZBY1BSy2bnxX3kz4Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThDPhtk2D38sJCJ74BjOj2KUsRq980tPpPUfv7e7/mc=;
 b=kyu6xICXSDMhbU07h8wHL+sD9LIycFwHAFCjkM+9qeqOqaszlk+QpcgNOJdLPZBjJMcC7JIp3r2lskbcMbi8JMYsXLWN/R/Hi6IxMnqkxhZeutKXIXyikFoknQqiMQsduHOexIOz9v0VXOgGIvWUzTxjxQvBeeyFixpONzwZqYPPzARcv/WMM7Flj0V9bFA0GbogdD3rndzU8pd4SczxygMKZ94/ckIHSkjOk2XrxEFAFOsUhDxE7wjbLFgFIT8cXX8mP8Vw4dwrUCR5vMVw8I0NiYZxOmcrM17iyWv/xcmUL0kveX6m5YewttXAe9Bh6Vr4FENd9o6vQp7v+0LjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThDPhtk2D38sJCJ74BjOj2KUsRq980tPpPUfv7e7/mc=;
 b=nZBWEhPBQ2EikKuCIdeyNGEzPRVtlxW35Z83LffbPlTkRumAvLU8cMJlKT/W1Os1BKcb/r3E24iOVwo4XcMt9nxF6thxMAQ8tZBBPOr9whP7MPE+2vlNZp4KKs5teETE1y+j/GvWdJuHaMrocam7qYf2u6kENKwdJTciJCYmG9M=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM6PR10MB4202.namprd10.prod.outlook.com (2603:10b6:5:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 10:36:37 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 10:36:37 +0000
Message-ID: <2436ecd5-8dc5-44c8-9a81-f7f7f00d7b70@oracle.com>
Date: Fri, 22 Dec 2023 11:36:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] doc: Add osdump guide
Content-Language: en-US
To: Ruipeng Qi <ruipengqi7@gmail.com>, corbet@lwn.net,
        rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org,
        bagasdotme@gmail.com, carlos.bilbao@amd.com
Cc: skhan@linuxfoundation.org, srinivas.pandruvada@linux.intel.com,
        qiruipeng@lixiang.com, linux@leemhuis.info, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231221132943.653-1-ruipengqi7@gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231221132943.653-1-ruipengqi7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0083.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::19) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DM6PR10MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e267ab-9901-47fc-a1a3-08dc02d9dff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V7nmaTqUT+YQHEmI/W2FDmZOoF3iOy8RmRqcTJOvH67YAMnxQsG0edkef3fys3NbWlYp/v37UOWtqgEVBVsv/rju9sDkneYB8nsn0ZfXYOZUTI1TR6gTTnFSM2ur3rakTtTFPt25ogZGaPB782I5f2dirZ8twCQqL+ycdERa5xXe5zsvoLV52FfmdT0lk8pZvfaiat3rionNBdPYm9U47I/XFNjNYTYZr6SszI40VUKVRxkpgHBnY9mr8Ivl6heU5UkK8DJrx5pxn1sWajpEAntRU9hgjFY0zFIXBmickPBPvw/hAxY0s9HUTemBCZUynVe21mPlFjVuO8uyI0MdRiBAMWgwqc2txBq1h2tl48QeualxdNM5qzwTxV7dw8F5Q1G3kKZcEf9zsjupMJ3BzHrlCyWV0pON4MKHDWgjswHZD8S776WtzbmDi3Ztg61veRVcZKydSvtbrSA2tPb04hsrv41DHAWWzLOvyhPzAVRnHjcQcJZ0ZXZPRrxDKZlm4jOU0NiyzlkEwSwUzmF2OUN8EQcOV8CKaHc4Bo9ulOdAJQaYy2qGAFSxWGUblmSzn9mFBPV6zBTxrr3pM6QFoI9tWe52vUbc3/sjMnnK35Z+oRvz2Nqa8I8aal2Q2M0/HbOfLnTEUqEfZ4vBNFUwMA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(44832011)(6666004)(53546011)(6512007)(6506007)(478600001)(6486002)(31686004)(83380400001)(26005)(2616005)(4326008)(8936002)(8676002)(41300700001)(2906002)(31696002)(86362001)(36756003)(38100700002)(66556008)(66476007)(66946007)(316002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZHp4cDJNOGRkN1cvMnVrY3ZOU2Q3OHNzZ1FGdWE5WXNnNDMvZW1YR2Fla2xy?=
 =?utf-8?B?Ujh5ZDVBQWlPYldNQkRnVFE5bUJKbVIrUDhzWHdKV1czc0Rsd3ovWUNDK0pj?=
 =?utf-8?B?Zk1BRWdJRFcySmpEdmFCTlpJWEZrTmpXeTgwS29mMThaeVN2YTZGaklEcnFZ?=
 =?utf-8?B?Rk1DajBwOW9RNGJCUW9JaVgxZ3VObUxwQXlFMGkyNTJJWkl3bVNzMzhyS01L?=
 =?utf-8?B?OU5QMTl2L0xrNS9PenFWOUswVGJ5UWtlMVhJbWdYNm5NMTVJZkxZNWJLNDFM?=
 =?utf-8?B?Vzl2eVZmc1l1UWJPOWlGSkJEVlRCZkNKQnZIelVyWlV2VHdReUh5R3Nxd1BI?=
 =?utf-8?B?ZTk1RW9kN3l5N1RUbXk2QVBVZHBJOFlSZjV1ZitWMnVPMGlEWmZQTUovYk1C?=
 =?utf-8?B?M3pBN1AvbGpEZzBNd1NrM2Z5ZHQ3Z0g1UTFTcXQyZXN0NXlGb2VHOFllK1Ns?=
 =?utf-8?B?VGNyTmdDanVqRjRIeVJaK2U5a1Z0MFpGdUNaTGRYU0RqVVpnVVlFUEdseGR2?=
 =?utf-8?B?eVlYYmFxT2xkRGk2em50NDFUREZWWUpRRThCYXVRdGl2VExrdGdQTG81MzJt?=
 =?utf-8?B?eEpWamlWeVdvSDdoVmd5QVR4Sm51T0VBRm15a2xaU3Q3VWxiei8rbnBkTVJ1?=
 =?utf-8?B?VVhIcVlKTndOS050Umo5Q1RpQmJTcU5aY1M0YVp4TWVoV0krODZYeTJKY1RC?=
 =?utf-8?B?ODhNZjFFaGVKSjVQNUYvVk5BUGRjVkRqU3Zkek9LRTRGMDdOUmpRcHFMbXhy?=
 =?utf-8?B?UE8wSVl0SzF1ZE9iVTVCbEZLYVRUTUc4dHF3SHVZUkFJRmVEbjRsaTRPZHpP?=
 =?utf-8?B?bytpblNlR0NPR3k4cHdkMFRUOGRUYlNzbWRra2w3aTNMMCt5N2dsZXJsd2w5?=
 =?utf-8?B?K3ZkaXFIamtRT0dIZEpkUFBneFdCMElYZWtualVWME5pVlcwNll5Ti9nZzB1?=
 =?utf-8?B?b0ZVY2taR3luek52dUxyMit4QnByUnVlZW14SVQ2SWFDdkhLWWI3eXM4clM2?=
 =?utf-8?B?aU92OFdiT0U5aGFhdUtjem1iZWZ3M0dlZFV6SnR4U2ZPQ25ZQ1BEUFNmdVBY?=
 =?utf-8?B?WTlwa0NiY255YjVac0w4SW43R0JydDNqMFprMk9PTGYzei95b3NnZUlobXhh?=
 =?utf-8?B?MlFGRVpyVE1ITVNXM0N2cEkwcjdrK0JuQkIxTnRZNTUrYmkwQ0Vqb0RrcVpE?=
 =?utf-8?B?SW91VjR0RlpyTDRidmpPemZKYTZWMHFWZDlrU2VlbnE2a05zUXgzUjl3K21K?=
 =?utf-8?B?NWlUM3JJWTdueG1QeER5YlNBY3ovWlJXNThwb3g4NmVBR09UR0c3amY3WnhX?=
 =?utf-8?B?YnRFaklvbDhqWVpYQ3Vyb2ZlVHozeGlUa1lXWG9DK3RpbG9taUp5cXBhbkRu?=
 =?utf-8?B?MEd6RWJVb1BWWUZkZEpBZE9VQlAzN3dsbkU3b29LKzZkWVplSisrWTFZV2R0?=
 =?utf-8?B?cGlMQ3c4Q1lQV0dqR3k3TmVzY0IvNU1NeDZwcHR2dGtIU09KRlVGdFZIUzAx?=
 =?utf-8?B?dlQxQ1hraFlzanlpV0VzdS9KbWlGN3M4Z0lPMmEva21Vb1g4bWFEbk8yUlc2?=
 =?utf-8?B?RzUyb2EvQ3JUbE1ZQm0wQUdVR3FMNFFwWkxxQ290c1pyWnd5R0FQbVgyR3Y1?=
 =?utf-8?B?UGhIVmVFNmhHdERBWmFDVkZrVFZMaHdGVUZXN0pyNjYxQUpxWEVBSUtrV1R6?=
 =?utf-8?B?WXV6SGZEdWRZbEtEY2Z5YnB6eDRRQlBRU3JIeWtCbnVMNHQ4YXloVVlZd2l1?=
 =?utf-8?B?T3ZCdHRDTHpBWm1DZytEcXkveWZBN3EzTTU2ajJ6ek5wVUh2MUprY3Y1YU1p?=
 =?utf-8?B?dWJMVHhJUENmdjY4dE9iR1F5d0pGdGpMdlpNZStWeXV1d0lhc0I1UjZJaFNF?=
 =?utf-8?B?dElRUUxSb3ZrOHZKS0dObVZCZWI1Y0xjWjd2enF1V0wzeGVvVTUzWXpEaXhh?=
 =?utf-8?B?b1A4MWZuM0g1OU8zZkMrNStlOEVoSy9QT2c2U2tFbkZwSGhUc1VzZFkrWXlU?=
 =?utf-8?B?cW55VHJoSGRXMXUzVHBNSDhkV1RYanNzOXFHTXlqOUZlOElkQVBnckJTRDVp?=
 =?utf-8?B?R0JSQk1taEVPck5MRjBCUVE4bU9EYkt3c21ENW9WSUdaSWNuMWI3V3N6cnFW?=
 =?utf-8?B?S0NTQmdEcXlCM3N0VVgzK0N2d3hMcllVanRJRmkzdmFESnZUSmd5Y1ZtV1Uw?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7KfiHdxfqwktRj4Rur6DZnVBrvjNT+qcJTZy2OZlAewcUpGvrJycGPB37Eh4VXsEtNfgFwtKUZqFlIpYPOmEcHDFJDRVdjsCOAYLPk7NsIU/v3chzSvpBFF0D+urBN5tLMCS9kwD7QjcJyaXyuwdqjNhWwRHIVWNbU/iwA96VuBzZbEaV0sw/v3RQZOFj4FkciyV+J1r5d6ZGitHJ77qbzXjROSqFVn9BUIi/OOswWern0Ls5XMRRX0aU9I9pODW8NizdSI1Bv10tDrimwB4qapIZCLc1FIfuNjWIueclBMO0dwRjDbiG6etckQdboPBrxUSgI0JuV3xues3vfJMdahHysOcFShKIbhnV9J8+7IghuO56imfTlv0JOq2rfK3uWsG3LNuT7fqSz/O9CknqmQbH5APltdR6/2w/XflbGmIUd0LLa+S0l/RXX89BHEZb9hVQbuCn8GspHDxXVM3fdyvtcmkxC8CzNlEDcmPBakLwWPPOC6KEiQRYVsYwxQCgtD0WHKnuTFSDk99iZUW1sc+CRuekIfevnfM+SbzZHYMbeFuBYITuHPIBLwDnA1S+XfcT4Xnx7oLuR6K6+hdiGZcL4q2L3eakvrQx2CUYaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e267ab-9901-47fc-a1a3-08dc02d9dff8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 10:36:36.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s6Sv09yH1HLr6WpDCynQi4ychcxg91s5SuoI0f5Pw3DxFkdg2TAko3F1sL0OcTteX7BQdzVAJtxtE1pOPHXZ+u7SU1PvPPbbpNK4jTo8T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_06,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220076
X-Proofpoint-ORIG-GUID: ve5UhsJVIGP_okjB0jfqbXGGy6lHkPqk
X-Proofpoint-GUID: ve5UhsJVIGP_okjB0jfqbXGGy6lHkPqk

Hi, comments below.

On 21/12/2023 14:29, Ruipeng Qi wrote:
> +++ b/Documentation/admin-guide/osdump.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================================
> +Documentation for osdump - The Os Minidump Solution
> +===================================================

I would title this simply: osdump

Also, a general comment: is it "osdump" or "Osdump"? I think you should
choose one and use it consistently.

> +
> +Overview
> +========
> +
> +Osdump is a new crash dumping solution aiming at specific embedded
> +devices within Automotive or Industrial having the following features:
> + - limited memory.
> + - require quick reboots after system faults.
> +
> +To minimize the dump file size and maximize the dump process speed,
> +Osdump provides the following features:
> + - excludes userspace memory, focusing solely on resolving OS-related issues.
> + - eliminates constant data such as text segments.
> + - core OS data for dumping, this includes:
> +    - static allocated bss and data segments
> +    - dynamic data such as:
> +       - slub data for small-sized data
> +       - some large-sized data alloced in pages.
> + - compresses dump data to help reduce dump file size
> +
> +Considering the large volume of non-contiguous data, a binary data format is
> +used directly.
> +
> +By utilizing the dump file and vmlinux, a standard elf format file can be
> +reassembled and parsed using crash tool.

> +Declare
> +========
> +Mainly test on arm64 with 2G DDR, selecting slub as SLAB allocator, 39-bit for
> +address space size.

This declaration isn't very useful information, I would take it out. You
already wrote that it targets small memory configurations -- if there
are hard limits, those should obviously be stated.

> +
> +Configure and Build
> +===================
> +
> +Kernel config
> +-------------
> +Disable CRASH_CORE, SLUB_DEBUG, and SLUB_TINY, and then select CONFIG_OS_MINIDUMP.
> +
> +Dts config
> +----------
> +Add one reserved region for osdump. Its size depends DDR size you are using. Here

I'm not sure about the use of "DDR" here and throughout the document.
Why not simply refer to it as "amount of memory" or RAM?

> +add one 16M reserved region with 2G's DDR.
> +
> +osdump {
> +	compatible = "osdump";
> +	reg = <0 0x64000000 0 0x1000000>;
> +};
> +
> +Build the image after you have done with configuration.
> +
> +Trigger one panic and analysis it
> +=================================

*analyse (or analyze)

> +
> +0) Precondition
> +---------------
> +DDR won't poweroff during panic. Its content should not be lose.

*lost

> +
> +1) Generate dump file
> +---------------------
> +When a panic occurs, it will dump core data into specific reserved region.

what does "it" refer to? Maybe write "the kernel".

I would also say "the core data" (instead of just "core data") since you
defined the "core" term above.

> +
> +echo c > /proc/sysrq-trigger
> +
> +2) Get dump file
> +----------------
> +When system reboot from panic, run the following command to get dump file.
> +
> +cat /proc/osdump > ./osdump
> +
> +Got 13M dump file on my side.

This isn't a sentence. Maybe write it out as "On a sample configuration
with X amount of memory, this results in a 13M dump file." or something
like that.

> +
> +3) Run crash tool to generate standard elf file
> +-----------------------------------------------
> +
> +crash --enable_raw_dumpfile ./vmlinux ./osdump  -m vabits_actual=39 --machdep\
> +	kimage_voffset=0xffffffbf8f000000 --machdep phys_offset=0x80000000
> +
> +Add new feature for crash tool that reassemble a standard elf format file with
> +the dump file and vmlinux.

I'm not sure what this line refers to.

> Will submit this patch later.
This information doesn't belong in the documentation.

> +
> +4) Analysis with crash tool
> +---------------------------
> +
> +crash ./vmlinux ./osdump_elf

I would add a sentence above this saying something like "You should now
be able to use the `crash` utility as usual:"

> +
> +Note
> +====
> +disable when select CRASH_CORE, SLUB_DEBUG, or SLUB_TINY.

Again, this needs a full sentence. Something like: "osdump is
incompatible with the following options: CRASH_CORE, ..."

Although you kind of already wrote this above, so maybe those two things
could be merged and not repeated.

Please also make sure to thread your emails (using In-Reply-To: or
git-send-email --thread) when sending out a patch series, that should be
the default when using git send-email.

Hope this helps.


Vegard

