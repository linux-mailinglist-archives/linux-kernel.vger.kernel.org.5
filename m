Return-Path: <linux-kernel+bounces-23850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC7182B2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E992820C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96EB56761;
	Thu, 11 Jan 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LVMJuFxK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PKWa+yHC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED15674A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGEp9V029727;
	Thu, 11 Jan 2024 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=l+VPlUVY4gqDaXNLrVxyEh+85njFIMUIUQhexnwxZJY=;
 b=LVMJuFxKFwBUGRmtc/X2gQ7NcX4TYHMVx2yk1trdn/9tQwczmoudugrrqB3huRytEd/p
 JZxP/y0nni2IisCyDoG44HentfUbxLIwyUU3pcAXTkgsmtr5rh3pprBmJ+amfpHvc5k7
 axgCIO7svspn7Qs86hbAkRmoZxYfMBvLgpemvbUMh2JDutTgoZQa8PyWITyj5F2yekJJ
 53dUiaqD9YRfYD7bnezPST582qO9TbCL7SyrjO/VVTVCedhYatrI7NpquOpSxDjhfRi8
 ffY87FINmtbJUa9IYYnI+yGVcqbjoMxvfzZTWgRd9ghgJdnGb8RXcgKqMIlfZLnsLfwZ IQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjbc2rytj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:18:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BF14UO030079;
	Thu, 11 Jan 2024 16:18:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutqc6aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY6p+2ARIA1Nos7J6bMcyxpBqNT9sTaJnVHvk79Zx4BTwqOfDITsQNaoQS4nhboaq+vhoJyYvToyqfwefevTamW5yi/iXdyBPOX+aHQ1W2Bc8agKSduU/eehhv8FoTl3uiMcWVEkVaj3lFgM+dRu71L9PWTlNGr4y/y4CCFlUW7g3OI+d7lfaomyg5BdzKIdF5oGiooLMOvS5D8up5HL7Oh0rPCgzWuQwEhfaQ7GEEU64TXFfc4nuxZAd8iEOgdNPxvTndwU+XX6MvsDf5o7JZVaQ/ckkDXu0phXf78+0fQn7MYjJNnovigXly7asqlai/wgjQ0fLzx8XF8ZE/WPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+VPlUVY4gqDaXNLrVxyEh+85njFIMUIUQhexnwxZJY=;
 b=KuDOd/bvGtxEJY220k07mh3kfT81eugcc+ZsUE3SSDTyn6phzPe61RT4o+1Iu9nTr0FD8+pMmYGppYTL1QXplpgPuzeayCZatUIn51dSblo/R2lDyJHu/gOkCxKNvag7deItdlSEuPhH6zX/EmdDe4mjyP3BgDubmWeFGhT9V+GW2w7wy/Vk+PutiA3qmdrwecyIBNYLXJFB82vtOa8R+aQWamgFO7o+KkIIEoqYE5VTue19+o9Z1qZpkzxH7CWBIrjOpqdjJmJSW/IrcJjVwTwjr8G0Q0glldT8wVgJ1OgibY0S+Qhit6wtAYxv1gbzY2KmCZ3THt2ZlsDR09TI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+VPlUVY4gqDaXNLrVxyEh+85njFIMUIUQhexnwxZJY=;
 b=PKWa+yHCAEAv9f3BcbD+g3kkFUmKxDgwPEZk/Ka/7i+WoZ54p/2NcIyYsZ9mreknBru/Sz6rUAiiUIaaLaXMHDGRSSmVAH6JLXqGImMYmzhxwpyg7g9BwE7LpVpO3WbQ9IHfKxyLQjC+lKVDm60FHMs3rouOIio0Rlwh7DuvBOs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 16:18:00 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::45f0:7588:e47c:a1ac]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::45f0:7588:e47c:a1ac%7]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 16:18:00 +0000
Message-ID: <11ebc73f-6469-4c97-9da0-0728edfb283a@oracle.com>
Date: Thu, 11 Jan 2024 10:17:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 07/13] vhost-vdpa: flush workers on suspend
To: Jason Wang <jasowang@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-8-git-send-email-steven.sistare@oracle.com>
 <CACGkMEv8TXXTrCW=hf1sJ+V2a0eD3w1b1Yub4FnGZ0=Du-RbtQ@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEv8TXXTrCW=hf1sJ+V2a0eD3w1b1Yub4FnGZ0=Du-RbtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:610:11a::9) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2e82c5-df9b-40a2-1205-08dc12c0e159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Oj76ONmve0RGPyCRUKRJCI2b35gNxP1oNRNWp8Q6V6lhUdbXh+vxjyAzSzqTs9+Vzx2/H2Lnu70U7htNZICbPSZNnNdBIkg3AEejR2Uxthpj0DSV/dVi/lkP7c/UBq94dE3ZpH/JKmxhegEZK0vDOGiBGVOKXA8ljToUaSmWpBn8Gfpb4nuNGvUHxAfOo6hHoaEnxSW6lSnvmtLhRAycOq3z1f5krvpFtRvppYdBiwP3gPXwCv4ddZQ5mp3D7NlyuXyV6QDIt9muI/I0GZHJtIpnAkMWLVvXh7kb8lyz4rI5KqFpHzDC1NfD+TRHpeAYFW+phH6ni1k1obDswN7najtbUY+y/i/htgxGvSxdyE7+fXS+v7Z7R4O5K6capGZWXJIFKiW7oN4qOjLIyHHSnxx+z5IFDgLt7o3JCJoWgKTi4VBGajTBmgmV1EoW+NL5XKLn74QwQxglI/Uv2w1s/Vq2YdZWqBdkgOjIy4L7CJfnkeli5TcraND4Pyyl9J3IDosTgGtQ7L+yuQkJC8ZHDWZv1N3E6ZYVKCsKGE+C6RT331FpiC4htiHSWuojO6nzzKQCkoXymcB0SCq/DYCpsEAlJSz97j3PfXHEkZYjFS8ub8FuArknDWW0PGiAXUfdwm9e20Kgfv6tmaK7BonV7w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(36756003)(53546011)(6506007)(6512007)(66946007)(66556008)(31696002)(86362001)(66476007)(478600001)(6486002)(38100700002)(2616005)(83380400001)(26005)(5660300002)(15650500001)(4326008)(2906002)(316002)(54906003)(8676002)(8936002)(41300700001)(110136005)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnZ0UHdFSFN3UGMvaWhtL0FJc3pFTXBaNHllR1dTaW1HMnk4VVhSaGk1ZHND?=
 =?utf-8?B?RWlsdW5LazFZUERpWHFscWYzamY1VXlnTzRseSt5akMzTWs0dEJwMDI4SXNM?=
 =?utf-8?B?MjFNU1RMZDFSdTdNVW9VUFdZMUZjZ0ZHaVExZ1hnekx1aFNWdTVJMkQ2ZnVp?=
 =?utf-8?B?MmZITmgwNGRwL0daYnZwazFRazE0bm1ENXpub3pMakswRXFJV1ZJTlpTUkRv?=
 =?utf-8?B?ZEpad1B6U2wxNGxSNjlPVkpOaXRpajlzRWNxTDg4TG5Ick1LY05iMFpjcm1x?=
 =?utf-8?B?V0U3VkkwRTlFYldwY0pVV0tRcTI2dFRWUGdsTDladVdncDlTb1MwWXZ6dkth?=
 =?utf-8?B?YWh0cFYvQ3p3VHkwM2dON2t3YVlWTjdlWURvOVA5MXAzT0oxSzBZVnR1bXUy?=
 =?utf-8?B?YlMySVg3dlNDWG9VZGxPWDkrU0wzWWFzRm01dFdiNmdacTIxWCsyU3NTSWxq?=
 =?utf-8?B?L2gzelZSS2xWOFExYnloZndMQ2hab2ZjeTdjc3U0bU0xZjE0QU4xUzlSN2h6?=
 =?utf-8?B?VjZNZkF6clF1eXVJSW13YUhKc01iRHUvRkVaYjFnakg1WG02VXlSQUJCU0Jk?=
 =?utf-8?B?bXlzd3JKeFJTTS9IYW5lYnE1Y2gwTVZ4YWRaZTBETmZ4Y0hCdlpldExiOHpk?=
 =?utf-8?B?SWJTNk9HRnJuVVNDdEUwYlkvaW9zV2hGUjczYnI0K3U3NnBLaStjZGM0Rjlk?=
 =?utf-8?B?TzR0VFlQbGpYOU0yQndpZDEvMkFRejJhQysxdFczVS95V29uS3JnMUNYbnlM?=
 =?utf-8?B?Y0hjdEJ4NW9NbCtjUVI1SVlOQ2tVWlNNdGU4TjhQdmlRRzJVM3hsZmNjU1hP?=
 =?utf-8?B?TzFKTFluakNnc0VHY1lyYjZKWW1pQ1ZtSlgwb0hDZTZSSXlROHovSTNneFls?=
 =?utf-8?B?NWtXanlBOGgrV0p5Qy9WR1lOSnhJOUY4alo1eGF1bUdSaG5RcC9rbEZkdFM1?=
 =?utf-8?B?VGlFVEJ2eEhteWlVcysxbk03bkU1R0tYcEZzSmhXdElBaVdmQW1nNTdHNHdR?=
 =?utf-8?B?MnVwN0l1aDN1VGNqSFkvREpmSlZId09idWZDdWRJbXh2Qk9JVkhBbWc5Mk9D?=
 =?utf-8?B?YzlRTERac3pua2FKSk1sU3JCSEZmc3MyVncyQU9ZVmRhZHZLZm5QVm1ZeDlv?=
 =?utf-8?B?Q2RVbXZRSXFjUnk1djArYzN5MjZyRDA1WEFYeFJReEt2c0JldG1uNTJGeHd0?=
 =?utf-8?B?SEJKL2xCZnd3SmpPYUZJOGQ5cWxIN3lKbFNoOVc0ck9BQ25GSkFXVisrUTZ3?=
 =?utf-8?B?Q0N1Z1phQkdzMS93Ty9BeVBNUHdneDgvYXc3SlduVU5UYW5CdHlSbnYycXEx?=
 =?utf-8?B?RjFrenZob1ZVTXM5a2RNemhHZnVJK2RmWVB2SkxqSlFnKzJMQkNobzNyRWpw?=
 =?utf-8?B?MjJBUElqdlA5dGkyN1pYZWhCbkl3VGpBcDdmcnNlaW0zdFQwWU0xd2IxOTBl?=
 =?utf-8?B?ZTB3OWI4aU94WFZVT1JCMmVkWGZMRlhxbDBoMC9wUzcyVTNwV042MUdpcGo1?=
 =?utf-8?B?OGV3MEE0M205cEYzUkZmNzdGekdzK0NSY2ZHNnlYWVFrUVc0ZEFpcm96bmMx?=
 =?utf-8?B?d1dQSHVwTkxpQ3lpQmRFYkpjZ3BsMkUrMHVhbmo4SnBoRXlMc0JvRTk2MzR4?=
 =?utf-8?B?VGoxanVMc1pvZkQ5citjVjFuOWxnVkVlaUxhOUh2amgxY2t4OXJsSjBlRjV3?=
 =?utf-8?B?aTNRSFJ1NnlNeHZYcnBGNTlmaVVqSnZ0VjFUNzVVRnJYRUFOTXFyQzBUV2Ev?=
 =?utf-8?B?VFFWMERBN3Yrd3NyR0N1Q0JVR1pUemQ0VmhqWElmQ2RjZ1ZyeU5yUVQ1cFUy?=
 =?utf-8?B?dHpab0tmL1NBeElaNFZiZTROU09RZ0pub21OTldNY1FhRDlxSUVrZjMyV0tY?=
 =?utf-8?B?MjlnclpJUmEyM3ZoTVUxR3ZMTURFMi9xQ1NQWVV5RWRoMmxzK3paQUhYVHR6?=
 =?utf-8?B?Q3A2ZmdSdEFRWFRMWGV4OW15a2xaamFoc3VxSE8yMUd4WEhtODJ4MnZBQnNm?=
 =?utf-8?B?VGxzLzFKWTFiaDJ3VGJPdUpuTVpaaTh1R214SE5IcWdUNStmQXkxQmtlYWpu?=
 =?utf-8?B?Q3RHU3l5bDE0aHZwTHNUcS9Td0Q2cVAxWE1VcE5hSkc2Zi9RUVZTNExFWjZH?=
 =?utf-8?B?NG5uQk1LdVpnUlZWZlpzWWl3alh2TEJLY0x3djZEclZxMXBRMjdFNkV0dDlV?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XNLqTmJd8bE90pSHuiFRJRPR+R2t3HCmDT7F20LhdYyZ7MnZQ59uBVZbo2+EZ7q6b7IYD821qbaXWG2xpxk4KhvZnL2qjhqpT167Gtso3UZLJ122DIglY9cf+vTtxvsXXrs8KwAJpVMRE2F1hCpCB59c9yadYL5okXvN53uik8/W2ZAS2FY/RCMWRqsLUQ2PnQn0tUnVXr1NOqG+FG6E9OrO/uIeK63ESl19M/8xwJWIvsRUO0rCFSsWVj4WtOtp2LfO9TqlMo3dUgqScY7Z3VL+gD09mnmuXxCrS+Qvn0JMGPON/eY/Jzvr9n7fyiN1xy9X1EDjNcVdAePZrAoHvHc4dwhrAjmZ8rVR3n42uyca/kuT+AsTYFoMrRgQPECivXm16uDXRo44Gd1MzxgwCMc/O5lHdm2FJ8IHlRgRidw35E1uhtLWT1aOcyG/JPFEYvc7N7sw8qgfUPKs3IH3wiYnTS6p9MbwdFXQ1sVKTR163TEOgqhyGWBlFEJXPRv5JUeXg0DTPEwqJGB62AQMI1HketXEYJAl78SxBXOVp4Ss+z/79cYlvU8E1JqiD7owV6NY3XNFFlS2aZc8LBDB51eH8Kg47O/TofzNHhv+EKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2e82c5-df9b-40a2-1205-08dc12c0e159
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:18:00.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1PwjD0nC73bBw9tkzSpthHDcRye3AsExAa0T0AAvCHG2600wTetMfHP+vv/Ml+HNNFgDODk63+p5iazRw634qoOr9Zwv9vaz/gQ+im5nzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110128
X-Proofpoint-GUID: ldSkE6H0h7e7Z-vu91NS8hMU_nXn1ZX6
X-Proofpoint-ORIG-GUID: ldSkE6H0h7e7Z-vu91NS8hMU_nXn1ZX6

On 1/10/24 9:09 PM, Jason Wang wrote:
> On Thu, Jan 11, 2024 at 4:40 AM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> To pass ownership of a live vdpa device to a new process, the user
>> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
>> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
>> mm.  Flush workers in suspend to guarantee that no worker sees the new
>> mm and old VA in between.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  drivers/vhost/vdpa.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 8fe1562d24af..9673e8e20d11 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -591,10 +591,14 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>  {
>>         struct vdpa_device *vdpa = v->vdpa;
>>         const struct vdpa_config_ops *ops = vdpa->config;
>> +       struct vhost_dev *vdev = &v->vdev;
>>
>>         if (!ops->suspend)
>>                 return -EOPNOTSUPP;
>>
>> +       if (vdev->use_worker)
>> +               vhost_dev_flush(vdev);
> 
> It looks to me like it's better to check use_woker in vhost_dev_flush.
> 

You can now just call vhost_dev_flush and it will do the right thing.
The xa_for_each loop will only flush workers if they have been setup,
so for vdpa it will not find/flush anything.




