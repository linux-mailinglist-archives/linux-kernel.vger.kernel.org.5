Return-Path: <linux-kernel+bounces-19798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE6827466
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FA22880A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2851C4F;
	Mon,  8 Jan 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ts4Oi05d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HNR36JhJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20E012B6F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408FiTJj003838;
	Mon, 8 Jan 2024 15:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : subject : from : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=y02SomEmtAp7OsimyYRbBkIezca5LH2nk1K5UtWoQ6o=;
 b=Ts4Oi05dT/uclHY0RklyjG8qNsv98yQ/6fZeLvW+krtanI6cTRtjo8E4AKvU12p8SKJS
 x0/wqph3Jfad7IbL9+ehAqiT2MF8H/NVvu0EKyUrwYh7EZ/VUOzQf4Da1YgdNbfQb9jw
 WQjCfO5fbfDDhax/2ZA2i/4G08QXkSd9ARmB98wWVHklggJwz/HnigE4Vvc1fwWbCCTe
 fblbDBLcvSCCNMUxc7ddcXZZyR6fzLV+3BM6KlANqTOPKF3T08dRDl939O5cbxlWb2j0
 VtBJx8C+MPYfLhZ9VNeU9Rh9l0Unt4ZEG4urB5RrPGCP+OMQb6DjsGNtb2d31+vwbnPN wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgky2r04m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 15:45:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 408F0vXD013679;
	Mon, 8 Jan 2024 15:45:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur9v3es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 15:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8OouB/V8KbJuSxQxU+seeEiw17x542jF+WisyOJ64mFnt1HiPV2knIhQvZFE+quEZm4QkfwLlnIWHgV/xEy/ZfZTd4BvMWtteAWF9TOs4kx3+8MlQZTVlehU0tfbTFdDuTMyaQCWqsy3jLToL3PkvXDC1Fpl8ktb0C4o/IWkcZi8R2ISpUTEiei+N+/waGSjcMrGrGFjBgPvT0rBvmHA29XjKxWh2LqQX2DgFpgr/AeihX9PHyOmWQGgdQYxuPDga69l5SUEpRZCiRMgpPM59Ox9HiB5eFlAzmE7jIYoUq8IiX+lQfw4Q7Zi+dU7udMHk/ACgYfIs4B9EXI73hFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y02SomEmtAp7OsimyYRbBkIezca5LH2nk1K5UtWoQ6o=;
 b=B9cZZp8lMBoHiVZr43CZwrwvo8+weG623byCHMd1XdDMusmYrl9YxUfwEFYIAbXeqZZnfXNvD5fjHOjksdUuTVysMgLUz9Y1I8NsgCjDRMI+4WdZ9B8/mKV7NDxZAt+We7ORbNqowerB6sE41V/Uf1Y98gKE2/XhXgYb9BKU7d9AfYrB2lkS85xn0vsnW2IELgdgalv7MUlqxbgJKm6Y1bFfixdbQnoUwGBDHK0sbB/RDjPzxgqaAuHl5vpb1St5HbkvN7vy/1zUjU5ld8LgBO/f7F0nfpZIX6NddXiHd4HLgHdvxEi6MXPIer6xn6+OeLfdQZHJPRMRU5d+3Fvg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y02SomEmtAp7OsimyYRbBkIezca5LH2nk1K5UtWoQ6o=;
 b=HNR36JhJTe9lN2iLdv77B7ds7qvow46pQu36sTOCtuQ6Obr0/qzHCIr6kgEPabX2i8IgaQYljY/2L346/FO0P+nZJ5XpIGUgcSIQjnifTEruSnvFsDXG2E/wuBCcM4X0aeZu6saouX2Bc7T8UIB8LYHHKHEkOZlSUxtENLhIi40=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:45:08 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 15:45:07 +0000
Message-ID: <6d22d04c-07a8-40b7-9f29-6862a48f070d@oracle.com>
Date: Mon, 8 Jan 2024 09:45:05 -0600
User-Agent: Mozilla Thunderbird
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Subject: [GIT PULL] jfs updates for v6.8
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:610:32::32) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2837aab5-4674-4d52-23a9-08dc1060ca55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FRhBmqjGU4XsKapz5JvY9mYp0fm1HZ5z312d9bLHKk0DcEdvSmlZVPDVuVdasc13pthbAQqEfkCz7KFrurqg4PYiOXuSxTV6ZrmgY5780yg5Yuqq6v3P+Qhb8JThSmo3KMGTulE9qUnPMHZgnjd2mq0R4WgeczgRvvYGgCEOrLRIPaMxLJpVvZnkgQnVrcP9G1mEOpmA23qVVP8U8T4ybXWdFrKMVbORF8LfYq2nhonUTpQUmAqpr2YzMqFh/0dEv/J9NRZ4ErPXVe7tYrBErl9iZZAxwFa3OcpX0/U76SeCjVl3YA1lQhnDmBI4KhvRpQUA11o5js03KS4Kt2ugi+SZUyFJmnsyg29pSHRwTxhlttDGnb56/nPRmxgs9eSrXXaBiIRTan6FbWDypTv0ickKHjoXpZubjHI6RlupHJ6W0qALp2Uo3976sofGvRk2K6UwAwhtkoJpQ9zUCUZIl5BUS5uKHPX7wwTWInLon3vdZShe7dkuIbIKLRActmlTa9geG3l53m/EjkMquY9OMDdrD+Jc9RYiRceKVmr5cbi9cNP754SaQjdW8VwRIPCWDCuf9nSZAe3vWSB/ZJB0oP7YGhdzLWJxEI1LjwVgMvROFVK0Ehxz4oHI/z5vnxvXflr7/mldd29wNTsjo6E+PQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(478600001)(38100700002)(83380400001)(6512007)(6506007)(26005)(2616005)(8936002)(316002)(44832011)(5660300002)(4001150100001)(2906002)(31696002)(86362001)(4326008)(6916009)(66476007)(66556008)(36756003)(66946007)(6486002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXV5S2lDbE1XZHFXMldrK1hwWlBvWFhXUnVRS1JWdTREQTMyQ3AwWjhsK0V0?=
 =?utf-8?B?ZXNQY3hZQmc2cXNUbUdJUGc4VGhPOFVvVlFsbDNBUDJTMWNRMTVIZ2s4eVNT?=
 =?utf-8?B?N3d4ZStUSEpIUjViMDMwR0pzM1pMSUFtd2dvaVdjUVJ0MmR0eHhSYjRlR3pV?=
 =?utf-8?B?eXVrUWJ5VWJyL3ZFUjFkMkVoTFVXREljY3NlaHRXVUVGbVBaNUNlL2NxQ1Fv?=
 =?utf-8?B?NGFNVC9OWUduVmhzVHNMZk5JeDZtUENDNk1rWSs5aG9kQ2JlVXUwemFKNWZT?=
 =?utf-8?B?ZzRSSmo4NGwveEc1Q0NybjlkRXhRQWpRYlMrc1daU1dMSnFPSXRoMzlDbjVw?=
 =?utf-8?B?eml6a3JseGxTSUgreUhQa1NMTDVjM1pEaUxJdndpZElxVHRWNHBicmFHZ3RJ?=
 =?utf-8?B?QVhzUXBzam4xTTQxSjlvTUlnNDlTeU0zVFRMbUxCNHNaZFhleHlza0dONEVw?=
 =?utf-8?B?WnROVkxJZnV2Sy9iSEZwTGZrUko4dy9EeWxFREJjY0F6M2hRWHExaTlYSUEz?=
 =?utf-8?B?V0tBQlBXTldSWFNIWmlVMVpWeWowMjZmQzhLYy9ITjM5LzU2ZGNPb2lUMW9x?=
 =?utf-8?B?OUVqMXpCazU2K2diNjZYVGJlSVVlN295YWVrYXZtSDc0N0ZxWW9VallKU3ZB?=
 =?utf-8?B?TkJuWHBMMUFOU3VTbHI5WnJXOTR3dzBtSlV4Z0FTSjBHbnN6RFhnOFRmRTlu?=
 =?utf-8?B?bXpTTTN3Mmh6cGg1dnRNa3h6OWJUWlNuN0Nzem5KWUtSYnF2Q3VmSFZMT0V1?=
 =?utf-8?B?Vy8xcm9NKytiajlBR0dPTnBUYVlocWpiaWJJL0t6ZHV2NjQ4eGVhNW5iN1kw?=
 =?utf-8?B?V1FiaGd0QU5DVFlrQjFxb1M2aGFnVW50ZWZsczNRcmo5ZnpMNjZDVVFteGpV?=
 =?utf-8?B?QXNvTWN3MnFEbW1OeHN3UXc2TXF4RlJlWGdVVkUxV1hZaFFqRGtIT2RHS1la?=
 =?utf-8?B?NTZqa2VGdWx6WjAxZ1pFREhWWGs0SUxiTTAyRUJ1UW9PNTJBZDFxMkxZTjZa?=
 =?utf-8?B?T3lQTDJPOXNpZmNYVEx4NXI0b2VtMHZSZktpdVphdWlQUVA3ZTVvM3F6OXIx?=
 =?utf-8?B?QWpOT0E2b0tXRUJpOXNLWHgxYTJVL1k5eWJZeElpWVI1cm1iUXRZanFvVHd2?=
 =?utf-8?B?OVA3WmVyNzB5bTdoSStQZ3hTM05VWmpkdVNSaERSRWovU1lOdkphbDhBYzhZ?=
 =?utf-8?B?cThFNDJ2em5oVUpqdUZNcmx2VWRFc0dRZmJydklJbkxsKzJNdU9qaTZtcjZH?=
 =?utf-8?B?R2krOHFFZ1RVaW5FanBQWkNkYi81S2gzYVNLVDZIeGpzRy9zYkJEd2hSMkIx?=
 =?utf-8?B?a05QN1ZYUEQvWU1hcGw3TWloSDg5dUlvejgyVURxY1RvNFkvZTd5cEpkUi9E?=
 =?utf-8?B?ZGJ0Sk9jeW40RkxPMGxQNDE5ejA4V2lxNHhlb1B4eW9aV3EzQllsNkhaaHFC?=
 =?utf-8?B?bTBlT1Z2Y21hL251ekVEZklzcjJoL2JLemJrN1RndGtyVzhnSlNYb1d5amJi?=
 =?utf-8?B?QUpyTW80ZERkd1E0cW52LzVqYTdVMU9lU2thWlF2Z2hFc3M1VWhCVUl0NG1M?=
 =?utf-8?B?UER2UGFNR2ozbDZFYmlUQmhKQkcvakpsbWV6RnhVZ0VTUSs4ZW5VSCsvdzVZ?=
 =?utf-8?B?L1Ird2FCQ2V4T3R2akRTditXcDM1QzNXRmNSbktKaTM3anYzOU1ZWE5yOThh?=
 =?utf-8?B?Rkh6MXlKQkQwQU54dDM5dHNFZThSL3VjUWZMT1Yxd2pJYzkrSGEvRCtrY0pz?=
 =?utf-8?B?N0xpdXVMM0pTTmpzd0p3ZVRidTFBWlRUY3J4dW0zL1NBbEh0Um9XdEJrWHFU?=
 =?utf-8?B?SkRrQXBEdGpWM3RTTmkwV1diTlZFRXdnVjY1d1pkaFcxalpsVzl4ZEY4Z3py?=
 =?utf-8?B?dHBaZHJVL3NtQ0lxcjRRUUkwYzg3ekxVSElCQTRVelhoclBsK09ZM05tbVha?=
 =?utf-8?B?SmRFT1R2U2I3VCtvT0N5eHJIbHJlS1hkaEVjODlNT2xSbEg3NUlaMWpxM21U?=
 =?utf-8?B?OXpVMHkzU1pzZk1YQzhPaG43S0xzSzlrbE16MURhUXhDMC82ODE2WEhEU3FK?=
 =?utf-8?B?dzg1K1pRSmhTTmVIU0ZVM0ZDYWZPVGtPayszdld4bm0rT2V2dEg4bmZSeU5m?=
 =?utf-8?B?elpldEYvUTg2R3kxd2hSU2phOGVFMzdNOXZLUXcwRjlQWHprM2FtVms2L2RB?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nb+Ng1BKGGlGRbACpf3eOrllWEvwzTVT6l8kGR57+Ciq5Lp+ep9oYvUymI0j1xu1QSrlDQDjmZ8wP5D2bnKxvlH1m3K7bGROAcDjpCt0GnJWEFEWFpvW+evBQexsr7Vul4uRQynjlTgjOI0PeikZouV/AZ8vUM4dkZlq6loJ5BZEqE5DFf4EHmxtP8Y7OqPMYKpTNIRz9Ni4FOFeDR1NEvtuy+OR7s2+r0Zj3ibpodK2V3/fz8ZySDspNvNJ83hBzwVA1tlIF+EsDoPJG5QOma0KS0oDQiaxWspVaGK5dc2D93rFPqcDRER61kFOGpLbI3NzZV60DIKMYk43hrPvPmSuLUAjOeDWpnXWQXZT7aVmdHm7XwM6Ky7d7lGa3r3jjYVboVnYPKForpsOB7Jdg7jEFQtJuJmNNBFA51euqmBW2BpbC2FR07bbd8zJSbgp3M0XGFimjVN/f7wZ2ctJX+MXUQZIvX4RmUiEDDboxZ4QPPHKG+4V64o/A2zG2X+UtKKkwJIufxHENRSibYHwz+qVVpGamhCBCoGnDssopvqcngnro9YftVZCi7o78A7n/pay7/yOvGNHYF9kNX6d/A+14n3m8fTE8Vr/uO/JcRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2837aab5-4674-4d52-23a9-08dc1060ca55
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:45:07.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkRtzWXJssNvot+s0OGTyRIssdLdLGzi/NKigde2YUKjTbdeWqCOA0uBEJoaFsWXD4Y2m3QY8sZ1525ZYTDI/RN10ENSb32+tivr3jShZMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_06,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080134
X-Proofpoint-GUID: 9rt-KrgopXrdw7eVJxp-yEjQjNek3LUQ
X-Proofpoint-ORIG-GUID: 9rt-KrgopXrdw7eVJxp-yEjQjNek3LUQ

The following changes since commit c2d5304e6c648ebcf653bace7e51e0e6742e46c8:

   Merge tag 'platform-drivers-x86-v6.7-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2023-11-21 11:56:57 -0800)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.8

for you to fetch changes up to a280c9ceeca73fad22af79b08b470fc7126cf1d5:

   jfs: Add missing set_freezable() for freezable kthread (2024-01-02 11:06:52 -0600)

----------------------------------------------------------------
Stability improvements.

----------------------------------------------------------------
Edward Adam Davis (2):
       jfs: fix uaf in jfs_evict_inode
       jfs: fix array-index-out-of-bounds in diNewExt

Kevin Hao (1):
       jfs: Add missing set_freezable() for freezable kthread

Manas Ghandat (3):
       jfs: fix slab-out-of-bounds Read in dtSearch
       jfs: fix array-index-out-of-bounds in dbAdjTree
       jfs: fix shift-out-of-bounds in dbJoin

Osama Muhammad (2):
       FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
       UBSAN: array-index-out-of-bounds in dtSplitRoot

  fs/jfs/jfs_dmap.c   | 65 +++++++++++++++++++++++++++++++----------------------
  fs/jfs/jfs_dtree.c  |  7 +++++-
  fs/jfs/jfs_imap.c   |  3 +++
  fs/jfs/jfs_mount.c  |  6 ++---
  fs/jfs/jfs_txnmgr.c |  2 ++
  5 files changed, 52 insertions(+), 31 deletions(-)

