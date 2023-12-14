Return-Path: <linux-kernel+bounces-266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3ED813E75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164792829CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2222DB6B;
	Thu, 14 Dec 2023 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nRZ6lvRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dbPLz/5r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B86C6FF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMIW7b006605;
	Thu, 14 Dec 2023 23:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PE15cxvoWVkDwemZm6Q3fshZA2pegTEghYzghOU9IuE=;
 b=nRZ6lvRc/GX2kBwcpYddHj6vFb3wm0KTZzXSjT7l0Rz39OES7SQNMTM7xHWVO/hX53AT
 t57csE7fUzkHNtQn7FzzR/xOhU9Ai83CStItoBVRypIM4s+ZRxOmWViYqRzdhSr//REs
 35Zq0u0bg0xcuqZTZsGA4deSEZegh0Vw+slfOqdXJ1APQq8n0wxUC+7UZ9V8MvsADK7t
 BldQgLWphoOhHCSAXNap3XSNGYn2SK4yCvs40gCBaz9rmlXc+DrYij2Unbs0lgy6NIZQ
 1oHT9aaBY8yeBCgQ/ABOqcQClMiXX2oM0nAksCF8Aujc1xrmtZ/TbkPOSovYkiQczi1y 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df8st5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 23:59:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMUCS6012954;
	Thu, 14 Dec 2023 23:59:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uveph82s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 23:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSV/PgCxcLjDxRavow5PhlhOk9xhN/W/DJWQha2rnyqOQqcvxyylkiUDtQHMfZRyDH+QJMb0npyusygJ4ap1q2C3S8H/MNc61JS08+YC04PZVFBaHdXs6t6EREOdlaGZSZRzqyGHdfwVk7OeR8zmV42a7AGK0ia6XqXzbrnS4R8qarsol7Lsgag2yUVU4YPddcnGMkSNndgcdLKMwi96udxmUKih2WCK2sSU7VDj03007fWnc+QHAwitFDhCRSFYborigFfKPh6veghEaPWGoR60eZQC61EdkgFpE5K5Bpi6WrhfDZFfkG/IrAnEbk/bNmeAlDZAMbEjwltTcp5RBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE15cxvoWVkDwemZm6Q3fshZA2pegTEghYzghOU9IuE=;
 b=PEnUBGKPpEsBouma6ZNMKb6pkuGpEfu+6ip/I8Yj75iCcdzMd6n83kcrn406s150o+5zQhcVi8t9T4SWle6BjRr8QmxbdmT89QtmBWMnt8wlYRhdU1pNI4hNQ6qj4FkpAmpYRxSDF1Nv22Jc/lsOR3es4UxDf8VkU/znNEH9XuWVh1WwpfbUB+rOQEhd6ysvz6hpsv4L+5w0ZlT2wOk237pf1kdR1IuKt9X+HHndPVm9v3Yr5OlzvQUscwaEROhdS7cld0nfEtT34PABxVScHt2aBBfsLZsD+mHTZkjXKgguwKNdvKl2WatGWFcb5ckqy+ljQq+VFS3WoBy8qkso6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE15cxvoWVkDwemZm6Q3fshZA2pegTEghYzghOU9IuE=;
 b=dbPLz/5robwBiVo908IMZHmlaed0GX7vpCnL53U9pZPAX0Fc+GvWxb2Zb0sSlwVAq0MhFLUsZCV2NiPwb3uI8i4eGogBoCY520VJRO5LbhGZWGOncjjDS1DvU6lFQswj1TazzUWPFn2sdM7HBMx8aTpySzwv5evDhXY9v98+K5c=
Received: from BYAPR10MB3558.namprd10.prod.outlook.com (2603:10b6:a03:122::29)
 by MW5PR10MB5875.namprd10.prod.outlook.com (2603:10b6:303:191::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 23:59:02 +0000
Received: from BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d]) by BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 23:59:02 +0000
Message-ID: <9792a7f5-62cd-45e1-b7d6-406592cc566d@oracle.com>
Date: Thu, 14 Dec 2023 15:59:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: remove redundant lru_add_drain() prior to
 unmapping pages
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
 <ZXuJKAInbgtuSU9b@casper.infradead.org>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <ZXuJKAInbgtuSU9b@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To BYAPR10MB3558.namprd10.prod.outlook.com
 (2603:10b6:a03:122::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3558:EE_|MW5PR10MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4a50e9-21ce-4d6b-34e1-08dbfd00a5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4zHmHShayn3eTno83xtzmoIFXqJ8hsyxC/2xh3QmVnUwonijipewmm9WYBRnwVNvgVurhsv0jY3cle+y1o1hXZccrUuOmbpmsyq25dLMIcSJC6zwu8pFBGft/p7eUG9hpVbV/b4aj15o3gwe27zeWi3xSoa1QBipLbPRNn6Q8bjRBBscTNrax43lxyvTR2afzr3vgceg8vvL7b8RFIthMd63QJY9jdU7WuqyK407PsLMJfZbt/gcckfH8wQmNYab5n5YtZ/KaJRFLkzS+lwirvFY9qLCJ6OW+6NglUJq5I2I9+NCedfN0tvyJoGaaitKjeQ4JwpILFHmDFsOTmJPYBcTbcrNf1rocpfXpC4vVxQmq3Zj/RZO2eYC+KLWb/JOkeeNdCPpFTLyAVpkvgujVBXh37iCocCAhVN2Tw8dXxP2RHbZ4ra3osXxRcMTIMl4+PmIF9kXSEjNE+7H4DG1nWtohByLGE0fApObX/BOACjtcHQLew4xxVYEgg1PY6f1R5yVSGtyJ2Wm54rhZLdfET2eZ5vliIRuO85i4KUXPVz4yMXxFE62CPhaecYVDsXmQKDhTVDGITz/Q8s0mveV/ay1/JwVh+0mzdUuUAEQGgI+ad9GkLsXGht6OuZiJPde46R9gQORHPr9FNiSVnnLmQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3558.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(5660300002)(6506007)(6512007)(53546011)(8936002)(4326008)(8676002)(66556008)(2906002)(66946007)(66476007)(83380400001)(316002)(6916009)(86362001)(41300700001)(31696002)(478600001)(31686004)(26005)(2616005)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXU5NkoyZ1l5a01KNCtqZHVGZ2hwak03bVpzVnFJWkRxT2lndkkyY2JCWWZY?=
 =?utf-8?B?eWRWMGQ4OSt1NVNhTkFrWU94VUJ6NkM1YzJDVDJTWDR1eWUwSTdIMko4WEF1?=
 =?utf-8?B?RHRxbmRFZ2FTSGN5R0xhTkhnejBjYzB0b3hib2diQy95OTZFQlpDRGcyNzFB?=
 =?utf-8?B?UXcrOHZvRmNtbTdQUnFOUk1XQUJIdjlkQXUwZE5YNnZod09tLzVieVY2ZTFB?=
 =?utf-8?B?MFNPNXVKWUtlNWg0MlIyTmZ1YWFNTDhqUDRwUkhpUFpPbk5HYVJ2V1ptWHNZ?=
 =?utf-8?B?OHQ0WVlUc29CNXVNRjQvZkpscTBzSFI1UDVpdVA2NFNORGpYenc0YUVwVXRi?=
 =?utf-8?B?VTFvekJwaEUyRFliT2FaQ3pieWdWcFRidkxudHIzTnhBZnNmSHRnNFc5b0lN?=
 =?utf-8?B?eVhlaGxwRVdvWmxPTjNCT3lTekhyMUpjSUp6eldJSlg4VWl4U0VqeURmYmIr?=
 =?utf-8?B?eXhMZVVNY0o5ekZJOERLL0h2cGV3dDV4R0pNSWFkbElzaE1VblJXUGVmMnh4?=
 =?utf-8?B?Q3NnRTJvN2dDQ21PNFllelhNelhveWI1dlRTMmJuWmVuWndiTFRQVGp6dnVo?=
 =?utf-8?B?RlIyUUVxQkdsNjdDNDVXSDliZzJlOVJhRUcyaElDQW94TUcrVTJOSlFiYW05?=
 =?utf-8?B?d1BXMkdPaVRJWS9MbHFtOEdoSWpLcEVmblhFMURnSkVQSEU1WXVISVE3QU5x?=
 =?utf-8?B?MGVUWVJBMldwSVlzanhha25VNGNuaE9jNytEUmN2VnpMdGhUOWFJcHBJK2Y2?=
 =?utf-8?B?aFJMdlNFTUg1SE11YnVqWkxldTg4b3pLVzZTbGp4T1RLREIzdHYrcU4yOVRx?=
 =?utf-8?B?ZkNJU1JKSlhpQzJKYnFHZGJQOXVJdnhpQUxJK0M4MThjS281VCtKS1hOaFdP?=
 =?utf-8?B?VGJEVU5iemFmZDdMZmh2L3c1bUVCNUNQSjQzSGxTU1JjWGVPR0NlZWF3OUhP?=
 =?utf-8?B?clpvVlhpaEN5RW1SdUd5K0tUT1lTN25EVHBTWE5TY29BbTAxd0l0Y1NLeHFJ?=
 =?utf-8?B?TmcvWjFXTUdpWjZGdjdVcEFidHZrSTdWTmdCNUJ3azFDb3pLZExJZ1kxeENO?=
 =?utf-8?B?UnlkZXZUNFBXejNNTm1lUVpkbk5MK3cwT2FmWC9qcDZPQ0I1YUJUdDZjMUQ4?=
 =?utf-8?B?L2VCRUpDMWcrZytBa2RtWVZKM3ZoaXp0TzgwQytkQjVCNmwySlNCeHYwSkRq?=
 =?utf-8?B?anJBS080Z0hlMjQwT2hsNytVOVNaSXlmbHJ5emhnV0pZR0RLdTJPeFZOQmVO?=
 =?utf-8?B?bnhZUEVEd1FjcUpOUlB6elZ6K0tmOG1FQ1VUaS9VQWxnOHZqWHo2TTJMOW82?=
 =?utf-8?B?bHVORWFwdGNFQ3VDRFJ4dFdFM3pLWVRIaFJuMjhIQ2ViRElROHFYb0libit1?=
 =?utf-8?B?V29ObjBNWGx4bDJIZ25oMnplVU1rQmJYZ0dBR2hvOW5CMGtqMTA2Q0laanJQ?=
 =?utf-8?B?WGdNRFVTaXBodFBrL0RXa2N4RWdwL0VWTnNQMWNwdXVuenBWZDdVWUhNd1Zk?=
 =?utf-8?B?dGtoLzNJRS81Vng3Q3NFbE5seWZDamQrNGRwcE1kZitEaTNnc29zNEIyOXd1?=
 =?utf-8?B?L1d0Mm50bys4TGRyWGFiZVp2NEcrL0h2dlFvL3Rid29ITG5Bd1ZCMGcrUHZL?=
 =?utf-8?B?bFFpZWpkNDdDODRiRHBjeG1xNDR5c3lkYzFBeFN3MkRWTEhhWDN2M1pnT1gv?=
 =?utf-8?B?WExtYXkvM3FSRW5nZjd3cXpGQTVqZi96K0pHb3pKNUxOTHZYR1IzMS9Qb1R4?=
 =?utf-8?B?N1pRZy9QbERzMW1KcUxSbUZtY2tKejdWRTJZRlpWZ1l1bnRZSUk1UDVoZlo1?=
 =?utf-8?B?aTN5Q2tLZ0NaS2NkVFpwVnZ4d1VBTDBlWHdsNzZGNytQUUorZE4vUVJvR2VN?=
 =?utf-8?B?YlJmOXNiR1k2eG1UbitFWHJXK2ZabGJmQVNyYkhyam9RRE5HZ2U1YjhBL1V2?=
 =?utf-8?B?a1hkVDNhdGt1bXpHVnEzU1lFOEdBRzhqMWtLSmtKZE4raVJsT2crc05SUkp5?=
 =?utf-8?B?eUVLRVliS2Q5TTlCRzlrNUVuZWM3Tm9ZNldiRVlpWDVjUk9tdjVkT240amJl?=
 =?utf-8?B?dTdMTzJsUTAyK0xxNFdNcllrVDVVMEVsdStSMHVkbVBNVGZpNmRTTzJGYm5U?=
 =?utf-8?B?TisxeHI2ZVBKOGQwWVAwaVljNUpkSTBkOXVwcmhDMXhxY25lY09mako0YjVy?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GkkMpUw9KYxpKoiVbxC0uT7wRdr4BPqrEOfzqNzntfh6Q0PExuJrba9o9XnZskm/904jCiPqaGhPFmeUPCk7CN3UxI3SdxR/F3OJhdjc3rXKVg/36rTYqMvfLJK23PQXyCA5rf3W0ujyF/SPIsLNuoDfFEQvSKaiLj3T6wfNK6j3o1wohp8Rg/cgZ6SjLywhDqPp+8F8dAZXSEK3cV2FhiMa2h2usnZrjHFFjrT3MQ1AuajioqesiiNPjPUSF4+HnK5XFRUzHzPQHFV69njOeea67cklCn03VREl216WGC7rxjmfdvA9kiBk6h/zYyrzKvYL1Fq5dPOyiFwVRUVKhWElkUCm8ONcV8UunoJCHMdf77C9cZ3rI3vNxnb1FsJgiR9ZGZubfNcIFd8Uf9r4NDgpdzctV829V8Cia0263Q5hHBYAZ8UJxPePfpRp1p6cVAvQC0eBgdY0VNM4GyYzr7Xa71nS108uNnZLdzRIAm+21FeMaYPtQjDXat6pikls0kgzbCrbXX1Z6Qo73YnPiefDA1dwgmN6qm3HsHGJBwaGqeEoRYdGYEibtD0BQPzFT9zZ1/9Aeb4HUa6j88nJGoVjHmHXQXI2dBVv9vZU6bZjt/imA+Y84CUP9qnaXxBUHRz+bbb7q++Mmp+1np+pxboV0TpTEDs8V+rn5cPyjbPaahQnoaGDIRMFKaKZ0lHCHjZe/Kt8Ci4j+j4hK9zwwosyRAb6tajSDQ8GW6N9oNK6tN3UM0tEw27PaVoSCoi+EVuok4HyynORlxLjj6XnQLzmwO2SN9vtSQld4GK15yPxCHCmMCSwB7rRU9QbzCZEhVRogRw+jXu6UHD0MfzBfYpOPIK2aGUuoGCNkBNmU31miF+DYhYZIoxh+prq13Jg9JRc8UUinFf6nSqQFyStYV2bGmTaab6DWPcqFGSBT6o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4a50e9-21ce-4d6b-34e1-08dbfd00a5aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3558.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 23:59:02.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xau37Cb2fnO1YU1x4hyd27cuBYGtoT37FkhVJQbhJN3jzVqqC5cyVSpe44HqwDxihdiGcrmOdn2HAO6ocAChE3RPQTl2dCuGjJoWZY1bQx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_16,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140168
X-Proofpoint-GUID: HzDQTlBgjOrYLVC8yR8T71KA3lTW1EgR
X-Proofpoint-ORIG-GUID: HzDQTlBgjOrYLVC8yR8T71KA3lTW1EgR

On 12/14/23 3:00 PM, Matthew Wilcox wrote:
> On Thu, Dec 14, 2023 at 02:27:17PM -0800, Jianfeng Wang wrote:
>> When unmapping VMA pages, pages will be gathered in batch and released by
>> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
>> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
>> which calls lru_add_drain() to drain cached pages in folio_batch before
>> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
>> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Remove lru_add_drain() prior to gathering and unmapping pages in
>> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Note that the page unmapping process in oom_killer (e.g., in
>> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
>> redundant lru_add_drain(). So, this commit makes the code more consistent.
> 
> Shouldn't we put this in __tlb_gather_mmu() which already has the
> CONFIG_MMU_GATHER_NO_GATHER ifdefs?  That would presuambly help with, eg
> zap_page_range_single() too.
> 

Thanks. It makes sense to me.
This commit is motivated by a workload that use mmap/unmap heavily.
While the mmu_gather feature is also used by hugetlb, madvise, mprotect,
etc., thus I prefer to have another standalone commit (following this one)
that moves lru_add_drain() to __tlb_gather_mmu() to unify these cases for
not making redundant lru_add_drain() calls when using mmu_gather.

>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/mmap.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 1971bfffcc03..da0308eef435 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2330,7 +2330,10 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>  	struct mmu_gather tlb;
>>  	unsigned long mt_start = mas->index;
>>  
>> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>  	lru_add_drain();
>> +#endif
>>  	tlb_gather_mmu(&tlb, mm);
>>  	update_hiwater_rss(mm);
>>  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
>> @@ -3300,7 +3303,10 @@ void exit_mmap(struct mm_struct *mm)
>>  		return;
>>  	}
>>  
>> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>  	lru_add_drain();
>> +#endif
>>  	flush_cache_mm(mm);
>>  	tlb_gather_mmu_fullmm(&tlb, mm);
>>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>> -- 
>> 2.42.1
>>
>>

