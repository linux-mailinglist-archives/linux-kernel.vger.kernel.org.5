Return-Path: <linux-kernel+bounces-8810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29F81BC90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3085AB2172C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250DC5823D;
	Thu, 21 Dec 2023 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="USd/XpK9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gA1CWPmP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104158224
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLFPtq8005764;
	Thu, 21 Dec 2023 17:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tbW6OqWS6TeDF6NPQxV98J0jxb9WmP0gE5G581JmwfY=;
 b=USd/XpK9ggh4BQ01RZl0xb3BUJrHPOUvIsgdJYD8YY+yNYHXcZ09w0kTNBCvQfh+/qWt
 VBqouhigYvBWfGQEgMAU5uhRsGFBXoJJ0CoaHpllAMT76x85C0gME2Y8JJksPTB8DDb4
 QccHE8dS8shb1Wj9KMovVx8S84Jkx46PWJx8LSYNPcd/ivNBxhk6yF1aiNeDW8PJZdDr
 Eg4fbkueItpBrPhAzW+RyBGJoDjpbaKfO6Jqd36QUU/AqeQq8dreq9PU0WR8IkjbfEAl
 5p92/3n27EaVYFeoFWR1Q1bvJSvHOVOI+ovJ8a9aQKzoW3AXAs0CisBP3E5nQJbQafC3 Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gukeb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 17:04:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLGnnaI024146;
	Thu, 21 Dec 2023 17:04:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bbj9qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 17:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU/vMBztYe0IRuo67qFT5HT10Np7oKuX7DsZEdKPP2x8aSCKoPSK7ujpjcCtsbBkpnY+Qviqoa6RuaKahlNc1CxSfW6vzCuHsv+7si4b8obWl5ssU1jwq8RXSO7ItuuUd3mP7Aq2a4q/uCUrr3NCwuRg4b5mqVacY20spigwX9mHVOrQPbCDRz/3hwjWXNTNYMg65uMyKBir0zQkgE8Q/WJlG+SUflWg1OME+yG0npMqZOjbnQrqKmgvm2WlYgpf3oEsps4IQEZ4x5bvCUZ3MtO+aYhp6B28ZNJxwf+HThymzTv18XBnQgtqqV+7O7UovuhLbUt9G6XH+3v7PoXlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbW6OqWS6TeDF6NPQxV98J0jxb9WmP0gE5G581JmwfY=;
 b=CmnCUSneoZ/P2fuaNHfyujZz6nSGP2SSMjzlKsAgQqn+lNTBjxVcIjgotr8RnqMGOO0BwUt6w4oBNU27+rAidTkNlEp+99EIhHDKrZgO+CAGupgsAHlkWC6ionkDtnTDekLoMDTKtXBSY4YZdQEgaKFWWd6VDYabWRiX74+QM881T8i7qNPzweTW/WYjNWz6xYlTS+EszBKZxt+tzGalkP8EJZhQEtq5bNIGjdAA9SiA3BqQFdTQEd6WbHDNfRlXqZvKdLY3BOR0h7BO5wSKfkHhGsOtqA42GCqVO5HR3aGPa95wSV25mNCozRX3KySPE9nK7OS4vmzGvmPcY2y4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbW6OqWS6TeDF6NPQxV98J0jxb9WmP0gE5G581JmwfY=;
 b=gA1CWPmPDUjpvKu4cLqtALDLfhsfiw1NdYGg4fSB9DQMA8uY0sK2SmYJlcclykfim9RSGW+Y2ec7sYlSYgX4E1plwQHL+xGNr3DQqNhDMhGTUWvtoXcAsG9nfNdWlEOVtTZe5EXYgfLk2jTsKaVh6YDOpGRi0dAX+LmM4SGI75U=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN0PR10MB5287.namprd10.prod.outlook.com (2603:10b6:408:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 17:04:30 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 17:04:30 +0000
Message-ID: <2769a37a-fc76-45b7-9ae7-d328778a25fc@oracle.com>
Date: Fri, 22 Dec 2023 04:04:23 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Fix tg->load when offlining a CPU
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org
References: <20231221164014.447122-1-vincent.guittot@linaro.org>
From: Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <20231221164014.447122-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::11) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|BN0PR10MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: e167a597-a8f8-46be-169a-08dc0246e563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EeMfl+QBdC/ypgQQfINTiLYE8ylIByRpAI3j1Jr2/2SmHHW1jbp3gp35BxQD3NI3F1SFfJ51HnTMniuRdTagdLxJToZMmmLRiD6EjYxGrYzGqTGbWjpsyJK9j+5Ld32g8FPeyYVKqz5PH3e2RQu1gVL6J1uUsSX/04/PdH19JNkwzXRT0WwZDUEQU4xMxJSBsbzWph+prksc5QhptkhkHxlCNGSJKfOpaNtZrRbHvySoUopNZT5BkPAeyaDMfPxV5+nu7v98mHcKoaQfUUFjA3nwE2fNBzU0IZBHEgUOsZpioklhqNTOLlHIKa3Zbdq99ETTGxq/FlQnbBcYy+q/WZyot8YHzUTp80jFQSPyAYJxgRrbwDtMSEpWmrcHac745PJ7ygwHZMD6ni/HqamHYXpm6RHoqPJkOrOGXqE1gAbbizFwnI5nuo4qGBQjZeXbpZLNQmeTfByRl9r82sAIZSHE8GvCxJ6IhwFXtUSlms04w1z96ZVtKITCMMSC6i2T/csJ5Vj3NXgiJXiobQVzsnUQnKslPfOCbXt3vFEl5Hho/x7s/9KZos3HcUJ96c3+QfaKR3w6IWkKFrIcCRQ8tZKY0x8PBbWbl9QYLySy+oh/01yP8mBhCLHLVAl5ptuUlLY38tuUU+0nrbp8Bi1m7e/VqQLuUPvugmdFliF+2Sk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(6486002)(26005)(31686004)(6666004)(6506007)(6512007)(36756003)(53546011)(66556008)(66476007)(66946007)(8676002)(83380400001)(8936002)(2906002)(5660300002)(7416002)(316002)(38100700002)(2616005)(921008)(41300700001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T3NFZFNkS3dkbE9nazI3SStvOEI3NjJoQ0U1bFRKejdFSk9RemlXVFFmQ1Vq?=
 =?utf-8?B?dnNVbWJHVnlkTUQ5VnQwVy9weW4vbXpiMjJweXQ2RFo1T0VuZGd3QnI2dFFo?=
 =?utf-8?B?L0lTKzNiaEhVY3BUZUlWZUppSU9reWNqRTlocDY1T2YvbDBGbTBBQVo4N3E1?=
 =?utf-8?B?dDJZSWp0K0ZuZmJhMVVIdkRERkZ4NnJXV3M3M2FtczJ6UVFOeXpUMjBBVndw?=
 =?utf-8?B?czE2MXNWcW1yYUZBVFh0VkV1Ty83cjdHeEVzdE91QVFBc3plQnU3NjNubVJY?=
 =?utf-8?B?WnJNdDNIMjlzR2Fsd2hrRHZjK2hBZ3NIUGZ6MHAxRVd5ckF4TzVNZ25YZFAv?=
 =?utf-8?B?VGhxT25VSU52WExKT3JzR2xXRGEvVWdhb1Z2NjVPREJGVm9wa3ZWci9HeEtL?=
 =?utf-8?B?aldjNmdEaHcyVG5pZkZIWmJGaFJBYi82cHczUXliZ2g3Z2FwcTd5L091K2pK?=
 =?utf-8?B?ejF1cERaUHdPRjRqb1FvTWxLcVljQ1NlVXkvSnFZN0xYQ0ZERDFFcU5vZGZo?=
 =?utf-8?B?eHlkbXBQeTVSdi94WUJIZnhCcm5LN0RHV1BHNUdXWktHdWMwWk9TcnB1Ny9N?=
 =?utf-8?B?bXFlcldkUHA0blFlN0taR21QYTFPSHhLcjZ1eUk3VDZhWFFyRTNhejVreGsr?=
 =?utf-8?B?V1NCZHlMamxRTWhyOVZSOEd5T1J0WHZHUlU1YzI4bVJhMHBiZHIvbEwrS1o0?=
 =?utf-8?B?T3lJSnVEV2h6c1RyNEhPSUUraDB4MkFPZERmRGZ4SFY5V2RlNmx6WXZQRU1a?=
 =?utf-8?B?eVo1b2VWSzlRT0FKbjBrRDdwTU9ONWF1UU5NMzArSmxTdkk2YzdoSDNIdVg5?=
 =?utf-8?B?QzhIRjhmcmVGOVZubWdBSHhFRzJhenBUcytBOUhaTlJ4TDhWaTM2dGFyVGlI?=
 =?utf-8?B?c1oya2RpQU1MZUtYYkNmVGtqdkhHR2oyR1FVd2tjMi9SQkkxaENjZnlhbVp2?=
 =?utf-8?B?ZXl3TEZNOHg1QXZsVkF6aWMyckwxT1RoTHI3QUtGTFJsVW45bnVBRmEydTZv?=
 =?utf-8?B?UEsvaHBpUzlPOXJKM25WcjdnOXZXUGRzOXJKMUhEcVlkb29xdjZpZzBBRGVo?=
 =?utf-8?B?bUNqd3FRb2h0U1AzL0lIaitxeHEzemRPU3hFbk8xeDJIcTExZjJSelRyOHVo?=
 =?utf-8?B?NnhDb0JhTVZMNVJ2cDR6UUxVY3JrNFFOSCtDbjFYR0IwcGU5UzJEV3FRQVBL?=
 =?utf-8?B?dWNsL25ZT0VSSW9kbFJjZFk2Wm9IckNXNmI3SFNtREZsdW1GOG5JL0xXTzZt?=
 =?utf-8?B?dG0yRVplbXh0ZWRlY2lvdTFtcFZNZ0c2VDVqNE1OZWJDWURQR0E2S0daWXpi?=
 =?utf-8?B?endicW5vWnNyWUhKNHIxMnJFWXdMZmJHUHhRSjF0UGZ1VE9KMnlnVEUrOGxq?=
 =?utf-8?B?VDdFRlg2QjlIV3FncmZvTCtlN3p5Ui9hR1hSa2F0VTBsRVBRSjdvUWNpN0Z1?=
 =?utf-8?B?YklBMkw1RlJabldHbG1VWm8rSnY0dUE2OFdQdHRIS2Q2S0ovSVVsekg3RDVK?=
 =?utf-8?B?THI5WTlaeG9rVUdUUUtDdUJ1ZXMrakYzcmlXVXQ3NWZrSUppenRMZ1QwNEJG?=
 =?utf-8?B?cTVBNW1ya3A3QkFPY2g4TTRuRUo1czJhd1VRUThNMys2YWVPOEFnNGRsYzdH?=
 =?utf-8?B?aDRIOExabXFnMUVZT1JCOEt3cVhScGt0UlpiUDNjbU9HTjJwUjgzdDBBcnNT?=
 =?utf-8?B?SzF1czc5Y0VPRWJPaWx1VW1odlRsY3F4aWhjM2VJNzl0UWRjalRpMlRWUk5l?=
 =?utf-8?B?blplVDdkVW94d20zRk1neUQ5SGZFTlhvbys2WU5IbGxXcStKTGJUY28zQ01D?=
 =?utf-8?B?RHFsbnFpMmJxWWxkd3d6MFRFdk1ndUdTNEtuK1lYZ1Fpa25oV1JvdUdvcUhE?=
 =?utf-8?B?dzJCTmFGVytEZUp2dzg1aVJaM28rb3lENEpZY3kwM0Y1TGZyZ0R2d2RsOTUw?=
 =?utf-8?B?d05mL0N5NStia2dURU5mTXFCaElxM1RMM0NNS25RYTN4eHhWK3gwUndZb29k?=
 =?utf-8?B?Kzl4ZmRjOXhyeTlRUXp5Z1dwbGRPYWZ1ZXlVVEMrY0RJMWhabWhNRHh5VlA0?=
 =?utf-8?B?VTQyMWhkNzlGYlA2ZVFFUkVUd3AzTitaUzhYbjAvT1dESktCRldHTWdDSzhk?=
 =?utf-8?B?ZGloOUNBQkhsM2lhK0E1bG9YdThCQkNKdnJRa1l5dXRlaHBJNTlVQm81OXNG?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ScWq/imTrgnlrYqdKQdGFnCJh6NFfSoKPaEg8qyFS1sOsrXB64uUns0XJuZTFhhtD7oWw0ivOkLmwjNuSwHnuAagWEQqZBbjx3Tn2rr2bIykNR99nDPoPK+xR8It8IZp5sJFy2r0EGcp+Gjv5MVgLMx1EX0mbs/qt90GDcTnRMgNjnrwRZEAY6jQvf9MMRP+5zGIvFncG3BqV63ZxH2zoKtISUZ7ZG1/rGZwVkUhfITHrVkFXoJMADi5CBkc9Z++BqUWl2zWchgi5BTya+Y/lPVdL96lbsLRvTlC4QodgYwShxqsMDgZmlgCfVUv5tqCN9iYTSl7nSSypPxdT6IO66tESaDPzdN7yfFVujvnfLLriuhslATHwCGX5fX026C6UFDYeJZBsWAkbrheUDacjuYlzrgvgKD+ZSkk6zwCJC9rBT0MlXTIzOdyImfhGbjm7Dgcc50PT8N3exZO9g1NpUwJvnYRLqC+nht3F/sDkqjzC8oec0nLJGzQ0/FghGXBek59wfjpkveEQlpFCdc7f5KtsE5KrR+noiHE7qugsaGbEjNRwudBPko9DMUKnLWi0xkTpM08yrkKDjdvkU96kW4kyOYD8ijVnZd1hu6vshc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e167a597-a8f8-46be-169a-08dc0246e563
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 17:04:30.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGV7JymVBHbUA72v5XhXv+2rU4orcp1jTg5WunODhZgePkioLEPSJChs0aOisTB2hrFWKU22PAWYm9v0jcHvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_09,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210130
X-Proofpoint-ORIG-GUID: vdTY_ejyld1e9lbcEK60O9s2o3zPNTkP
X-Proofpoint-GUID: vdTY_ejyld1e9lbcEK60O9s2o3zPNTkP

Thanks again for the fix Vincent.

On 22/12/2023 3:40 am, Vincent Guittot wrote:
> When a CPU taken offline, the contribution of its cfs_rqs to task_groups'
> load may remain and impact the calculation of the share of the online
> CPUs.
> Clear the contribution of an offlining CPU to task groups' load and skip
> its contribution while it is inactive.
> 
> Reported-by: Imran Khan <imran.f.khan@oracle.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-and-tested-by: Imran Khan <imran.f.khan@oracle.com>

> ---
>  kernel/sched/fair.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07200b4751b3..07edb7dce671 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4094,6 +4094,10 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  	if (cfs_rq->tg == &root_task_group)
>  		return;
>  
> +	/* rq has been offline and doesn't contribute anymore to the share */
> +	if (!cpu_active(cpu_of(rq_of(cfs_rq))))
> +		return;
> +
>  	/*
>  	 * For migration heavy workloads, access to tg->load_avg can be
>  	 * unbound. Limit the update rate to at most once per ms.
> @@ -4110,6 +4114,49 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  	}
>  }
>  
> +static inline void clear_tg_load_avg(struct cfs_rq *cfs_rq)
> +{
> +	long delta;
> +	u64 now;
> +
> +	/*
> +	 * No need to update load_avg for root_task_group as it is not used.
> +	 */
> +	if (cfs_rq->tg == &root_task_group)
> +		return;
> +
> +	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> +	delta = 0 - cfs_rq->tg_load_avg_contrib;
> +	atomic_long_add(delta, &cfs_rq->tg->load_avg);
> +	cfs_rq->tg_load_avg_contrib = 0;
> +	cfs_rq->last_update_tg_load_avg = now;
> +}
> +
> +/* cpu offline callback */
> +static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
> +{
> +	struct task_group *tg;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * The rq clock has already been updated in the
> +	 * set_rq_offline(), so we should skip updating
> +	 * the rq clock again in unthrottle_cfs_rq().
> +	 */
> +	rq_clock_start_loop_update(rq);
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(tg, &task_groups, list) {
> +		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +
> +		clear_tg_load_avg(cfs_rq);
> +	}
> +	rcu_read_unlock();
> +
> +	rq_clock_stop_loop_update(rq);
> +}
> +
>  /*
>   * Called within set_task_rq() right before setting a task's CPU. The
>   * caller only guarantees p->pi_lock is held; no other assumptions,
> @@ -12423,6 +12470,9 @@ static void rq_offline_fair(struct rq *rq)
>  
>  	/* Ensure any throttled groups are reachable by pick_next_task */
>  	unthrottle_offline_cfs_rqs(rq);
> +
> +	/* Ensure that we remove rq contribution to group share */
> +	clear_tg_offline_cfs_rqs(rq);
>  }
>  
>  #endif /* CONFIG_SMP */

