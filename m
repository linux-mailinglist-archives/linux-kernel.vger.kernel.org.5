Return-Path: <linux-kernel+bounces-19897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E082765F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2C41F235D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777F54675;
	Mon,  8 Jan 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hVmxvtkn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bApAX2je"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186BD54BF1;
	Mon,  8 Jan 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408HUj6J021099;
	Mon, 8 Jan 2024 17:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rxNNjTY0x7KcDcmT9G3Ix4RKytyB572QIFMjyky/XOs=;
 b=hVmxvtkno+wRMjhc4vcNWtZ7ppEyzK95KGZowjwV0f8iGq+kN1a7fb9NIkjAr21fTDHX
 FKvbhcwp6blAkxTxg5kvMSGResgQ7Z5WQ0do2YSDonyPi9D3f+W+roVoldgDXNaeWuyz
 pLgwB3dxr9Q2KJ0atGnv5227o1N9CxszKGUPXKoSw2Snj4LHfx9RwoLsf3W8gu/0U9z1
 07wniTxey0SKjqJMNPMCI9ecErCzAUoCQzzOIB6/cja9M/aOc/B4RvGANcCbMggYp5KU
 8DZZlac/yhJm1xwpq/bFYrPGoBeww97INKWxLhElndBA5LYeQZFU8GcFwO2raZMRfR0K OQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgng9r02x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 17:31:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 408HQQGS035189;
	Mon, 8 Jan 2024 17:31:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu37ahk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 17:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNJoQyqLbzal4HsOtHiCQUJauZxaXeSggotoXhfsCzunPLC4mviaILfhseVVhXoqXaQ/vp0z37/lPXZaZ+zH8urksjdGEWRfkDWRxnEIDombieuqDscqMXOQ9GI3d2q3gMVuc7En+IXE3k4dTn5Z2amWvrkf4YUC+tdXVmTnuuHDdJzvymbdcWRJV2CamVtrzln2Ts+oq5y8XrGXfMMQrwkacwTJfbx6HBLzwDRUN1TTNi8hgK93UgNPzitc1K6DGCIMSJs79t71uPFXD3hjc5lcZxTi05k6jhQRu08dVkkfOJPqOhawcvojEimN/42M5oo5xQOtcCY8BZ+4m3Zwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxNNjTY0x7KcDcmT9G3Ix4RKytyB572QIFMjyky/XOs=;
 b=oNuNx4KKgtEgIzaT5gdCW9p0QtR87kQ3cY1ZgtoqkCnmVXrgQTGrpOdly4RXEQ4lSDJyChpsLaFRzVUxk2lKu1gSFcUHjnDQ0NhhIx9whKrRlxvqljynwDaJAShhRfQxHJGPB4HQ5Utuct6kQanyZ8/VUFC1b7lwDwqPyb6fidlgbmh23pcrKmx/Oiuux2mloL+r75iRoldrXpzKI2P3Y7GZ5Or5CEdwRmgzifKmL+X+qExNEHqTvhpN7gLxusoo9shfxFXHzpYOsID7MpRmTNRSzmYG0iXdWsPWBTfZjb6TQQkN96itLBuYVTkhUqyZ7G+xyVSH0R7WezqGBgzVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxNNjTY0x7KcDcmT9G3Ix4RKytyB572QIFMjyky/XOs=;
 b=bApAX2jePITvdtHIzlDkPLbe1vOLPCoY1U9a9gtSXgK1sXasPCpYwkdliSCMKjrTm81sZQmXqWBirKvP183C3miznEgfHEUUcPL/g4CfLauB7biF/E0rZEMhDHvYxzk3i51/XK9ISVl77GJ3rusndn688exxCt3RnVbg1zrBWTY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH2PR10MB4231.namprd10.prod.outlook.com (2603:10b6:610:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 17:31:55 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:31:55 +0000
Message-ID: <c9aff51d-918a-49d7-ae31-395cc6a5881b@oracle.com>
Date: Mon, 8 Jan 2024 23:01:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org, error27@gmail.com,
        gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
        darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
 <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::32) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH2PR10MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c83d55-3a21-4b52-3dd8-08dc106fb568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vuo42c3iCXrCVlnCaO8yXD6otnIcev8i9Tjd2xI4Cu6HUwxCBUZzYc0K5GTwNY9GuiCapTYz3kXGJwtANKWIgosrJl1wofzz7iEJ59rnbfNwT2jjM0Gtp12+l2B05wrzn3AuEQ5HBqgn5crwRRvglHAItuhToI9haTggj5g2MYQnTl+eC+qMsKrAZfpJ7s5J9QbjKMr46euMSox7beKqdIzeQAYNfx5dUSNrZmhBOqE+O6RSphwEpvBGkcMPa09ul6jkjuDVpQDUD6zvw91UDGl3ZlAhRWyqqR6mgod6KwdLbgqFSgyQavysQs7hpL2OX/V27RDWflpNjitsyxlS2BnctgY0rBq+4ca9HvE/bhcVGdklGyXVUk4oPggKrwCbFHHVWlolfON2cpLLgsFWSNVRVccpGtgK5paso8HXxu2xBHVOJQQ1EfS2/7ahjHUieV54NXXZvhlbhesENfSMP/03m8Sd8GGbdf8RxnEHL7J5g+3WVm/dHoGU8Fq9zaaI1aepf14rRTgz0YEs8g5zbOvt/CGy4xy+W1V24fgbBcOWkGsU1UWKiU6k2a+hEnENeARIwNQjyvxkoSltziXzRU6x0ex619UeRZ6yYUZ3f2U8VSjOaV+a8uDWVwVX5MhrxK52qJSOLcSjVY3xhIOzO8pWkynC2Y9XRmFuy+Ln0EyfJcuX8u+IIGFFF24wkJUz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(8676002)(316002)(86362001)(4326008)(31696002)(6666004)(45080400002)(66946007)(66556008)(6486002)(478600001)(54906003)(110136005)(66476007)(38100700002)(31686004)(30864003)(2906002)(5660300002)(7416002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWJmaXYwNENYRlZrTzZzMmZOcjFndEgrN1BBRWVvcjhTcU1QQk1WMm5IcFVG?=
 =?utf-8?B?V1JHeHNpYWR2YzhTbGJFUlVETUk3dEFRYTcxeFNFSUorVHJ3OStaRks3TFdz?=
 =?utf-8?B?eXNZOVlyMGd6WE42VGFhK1MyTUpFQXE3T2ZOcW0xaU1hTkFEZ251M0l3ZFM0?=
 =?utf-8?B?aGZ2bVg4MDFzVW1ZRzh2QWZUbWp2U1A4VTdJVVR3eDBsL2ZHT3ovUCtMN3M0?=
 =?utf-8?B?MGVzYTVxOE5lYXkrVjZHK0tvVkViUitUaGc4YXltYTQxVHN0cVY2ZkpHd3hh?=
 =?utf-8?B?bVZMMWl3WEZ4TGIyaXppc3BhZDhjY1QrdnkzUGdrZ0wvOFZuaytyT2k5dkRi?=
 =?utf-8?B?UUtoZjljY3Jmb05ad2x3c1pteHZvVWxmdVBESGxKMXljK3Z6V2tFcGpaSHBY?=
 =?utf-8?B?dnlFNStzTkZaZzM0V1RBWU83THMvNzJrYnREUThvUXo0WDFLY3Q0a1Rkb0dq?=
 =?utf-8?B?OUVYQkxjc1dTNVVQcmZKaVJVY2xjazNNSVdESk5DRGc3UWtJZlFIVEVxZXhM?=
 =?utf-8?B?bHI0bnZERDV1TC9sRzEvVmhtdGpmQTlFVWR0cktKMis3d3dwZ1p0RndwSkpZ?=
 =?utf-8?B?ZkZrdmlaQVZNejFvUFdTWkl0cy9hM3NKOWVoU3Y4OTFkcjY3d1FEaWNwVGl5?=
 =?utf-8?B?QmFuWjlrM3BFd3JsM3hvak8ySVlPWGFicy9ER0twTTQvb0RXREVUTWZONUlw?=
 =?utf-8?B?RzhKR1RrcGNQL3hxcWFkREJXcmV5aExKbTAxUUdJbnA4VVZWTEREY0x5dTE2?=
 =?utf-8?B?N2w0TjRqNkxXZWVMWFd1UVc3cXFJV3ViRitFYlBCOUd0RlBQUTZtQzJDZ09W?=
 =?utf-8?B?RFVvTWJRZE9MTEtnSjV6TnNYbWlyNXliaHF4dUtSa21uSlhtTVBFV2lPeVBm?=
 =?utf-8?B?em1lY3hQdFZVcnhvOEdSNzRWZGtTZ09CYW9NMUFwUlNueFR4Y1RiTkRCSEZ1?=
 =?utf-8?B?alRMZncxczZzaFJ3cDhsTDBlcDZUeWkzcW5MMjhWM0Jmek44SklXRWI0NjZz?=
 =?utf-8?B?c0U5RldRZ2NGdVNLbHNzRW0rK2d5MWlaUnhNbWxCV1oxUnZZSWEzdXljTWpJ?=
 =?utf-8?B?VnI1ME0wbnN3MGswNk42MmRRTlJFVFRxNUJ2akozaHFxMWhrUWwzdEE1UjUw?=
 =?utf-8?B?WmxCOGwzbVV6ZmF5d3g1TUlQaGUyRXRHZGtVQkhyOGtwT1NpU3dvOGpoVjUw?=
 =?utf-8?B?N1BqZTBLMzZObEJyWkI5ZHEvdkNxYjZPOG95cWJzY3VqSVBJL1dJbm54QkVH?=
 =?utf-8?B?SWNiT1FYZXRTZFRzaU56Zk9uazMrcExRSThBZlZzNGhxbHZBbVRsNXRwVWR5?=
 =?utf-8?B?MUxsbDU4Kzh0RWRXYjBnUWxQVGlXRUJFWFJnSlZmYzJrb29WSFJWYyt3S0x5?=
 =?utf-8?B?V2lvRGY3WnZsMFlab2l0eG9HVlR5M1ovWXI0akNMQ1F0TmQzN01DdVVKLzJF?=
 =?utf-8?B?N3crVHR6ZWNWQThEVVp0M3pvVVRZdkJlbWI4eVlFNWVqMWk3WUsveHNhVzRU?=
 =?utf-8?B?U3pwZTlmOFVmUmk3blRGQ2h2WHdWWGtSSWIxYWZ3b28zMUNDQ2FpN2tBTWM4?=
 =?utf-8?B?c3FiaHg1QVlveXYrek9MQmFhSHo3YnJDbGZOL2pMQ0FZWFdRRTh4eHpuWk5z?=
 =?utf-8?B?VVZLMVduTUZCU1R4dExYRWRqN21iY1FwSU9mb1MwTC9NblpRMGY0RHc4dWQ0?=
 =?utf-8?B?NWRjY0d4L2p1c0FhbDBQWjJOWm1oa295WHVOZjdURk5Ndkx6dzg1T3Q5Vkx4?=
 =?utf-8?B?YkJPSEhrZWhKa3ErUjZIamsvQjA2bGRnbGg4akphWHFtZnJrNGlvR2R4alhp?=
 =?utf-8?B?ZGFabHVhTjh4OEJucTB1cmVEZ0psYVgvcXdYVGM2eVJoV1FHNVFUUGxTR3Ju?=
 =?utf-8?B?MXBsbGRTUXppRE5LQ3diTE01SFU1TjBLS3lmSmltMmZXZnFyQUVkTVk1aWth?=
 =?utf-8?B?ZDFkd2htY1pIbVg5aDhLanova3NJVUFrNXlwZGYzc0JtZ3c3TDVoRTBLVkxJ?=
 =?utf-8?B?amN4MVJRNVhlZFZjZkRvb3hrVlVFY3RscElHeWZKVUE3Qng4WFRLc2tyYmdl?=
 =?utf-8?B?MnNzenRuTlpQbUh0eExSL0MwZXZlVGcyWXZIQUNwQ1ZldFZZS3hENzJsakJr?=
 =?utf-8?B?eSttWTRDdzE0alUyTVZVelpYMkV1NnFRdmdwRTU3OXJiU0NHcFRxaGExLzhm?=
 =?utf-8?Q?2B59CHg4S74g6YxthkOTieE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lcNzEea/QbQD1tqbfntgGd+kNBLUGcutgCTUQOqjVpM8x1CFf/3ekTvUsFGSPrQ1+n02MQjh2IrXMFW5kJE/MQoqe8H71RAAmsa4MzrRvLDrtJ7bExWVQKaKrMTocFAEyVM2vSqOc8UX5kfpOXHLLxF4Z6/1/wXRxAeLXqQJPfGKqHDstFzJMFgWJ8X/xKHUR31HCmPTBVRfdG3JxjPbHTBMt7IIm63is9hwm5QE9Yc0wA+q/Su2VlxIH0p4bjB0yWdLu3UpdSXINfYkHcHdlyY5aYKRVTn/OlTC+ZDSvVcdIZwJOJuFC4PyKPHNsZSVVio2fbZBNdmS5xol+w0p9v5ObfS0KkeNkJ9rMFm48lLosVIVzImJt6R5pDGx357hneKGWzx1ysuwfWVv/NFoxqtBHFHKN2USyKOV0Jmp+lXl+bP3qW331e/udKhHg33SH+nGD4aD84qFnodPtT06hNd94HNvehmmE9d83aAkXTzH586Q2o4xCTml9OwZ9CSnPFgMF2lLfrZFqf9rlPk65M+TxEdE1FLX60Pu0cKUQ70bZzbpKrCAat60JScNZYnRWBwGE4/vbhhdV1uaiI8Z/SO9ggCOZdvXkmz+pCWRilk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c83d55-3a21-4b52-3dd8-08dc106fb568
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:31:55.3167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNYMhVtM8CJbJ46D8b+1jqYiGUDI34/9WWB7bRgcav1XCgoKv9F1Z+52nSBHaARJJGeqEJ4kJ5qucx8LWba2fq1wbjLrvbXfofVv08uXPo6hUFq5K0o+c6jFz26KBPLO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_07,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080148
X-Proofpoint-GUID: eSrqK09hZopV_u-R8dpVj6kry3Y0Ia6s
X-Proofpoint-ORIG-GUID: eSrqK09hZopV_u-R8dpVj6kry3Y0Ia6s

Hi Gustavo,

On 08/01/24 10:33 pm, Gustavo A. R. Silva wrote:
> 
> 
> On 1/8/24 01:33, Dan Carpenter wrote:
>> On Fri, Jan 05, 2024 at 08:40:00AM -0800, Harshit Mogalapalli wrote:
>>> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
>>>
>>> memcpy: detected field-spanning write (size 56) of single field 
>>> "&dg_info->msg"
>>> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
>>>
>>> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
>>> dg_dispatch_as_host+0x88e/0xa60 
>>> drivers/misc/vmw_vmci/vmci_datagram.c:237
>>>
>>> Some code commentry, based on my understanding:
>>>
>>> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + 
>>> (size_t)(_dg)->payload_size)
>>> /// This is 24 + payload_size
>>>
>>> memcpy(&dg_info->msg, dg, dg_size);
>>>     Destination = dg_info->msg ---> this is a 24 byte
>>>                     structure(struct vmci_datagram)
>>>     Source = dg --> this is a 24 byte structure (struct vmci_datagram)
>>>     Size = dg_size = 24 + payload_size
>>>
>>> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size 
>>> to 32.
>>>
>>>   35 struct delayed_datagram_info {
>>>   36         struct datagram_entry *entry;
>>>   37         struct work_struct work;
>>>   38         bool in_dg_host_queue;
>>>   39         /* msg and msg_payload must be together. */
>>>   40         struct vmci_datagram msg;
>>>   41         u8 msg_payload[];
>>>   42 };
>>>
>>> So those extra bytes of payload are copied into msg_payload[], a run 
>>> time
>>> warning is seen while fuzzing with Syzkaller.
>>>
>>> One possible way to fix the warning is to split the memcpy() into
>>> two parts -- one -- direct assignment of msg and second taking care 
>>> of payload.
>>>
>>> Gustavo quoted:
>>> "Under FORTIFY_SOURCE we should not copy data across multiple members
>>> in a structure."
>>>
>>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>>> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
>>> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>> ---
>>> This patch is only tested with the C reproducer, not any testing
>>> specific to driver is done.
>>>
>>> v1->v2: ( Suggestions from Gustavo )
>>>          1. Change the commit message false positive --> legitimate
>>>             warning.
>>
>> The commit message is fine.
>>
>> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>>
>> But, I mean, it's not really "legitimate".  It meets the fortify source
>> heuristic, but it's still a false positive.  Fortify source is
>> *supposed* to find memory corruption bugs and this is not a memory
>> corruption bug.  It's just that these days we have to treat foritify
>> false positives as crashing bugs because people enable it and we have to
>> fix it.
>>
>> Let's not pretend that fortify has helped us in this situation, it has
>> caused us a problem.  It has taken valid code and created a crashing
>> bug.  I'm not saying that the cost isn't worth it, but let's not pretend.
>>
> 
> It's a "legitimate warning" (which differs from a "legitimate memory
> corruption bug") in the sense that the feature is doing what it's
> supposed to do: reporting a write beyond the boundaries of a field/member
> in a structure.
> 
> Is that simple.  I don't see the "pretense" here.
> 
> BTW, is this _warning_ really causing a crash?
> 

I think we can say this can cause a crash in a way, WARN_ONCE() is still 
a WARNING and we can have systems with panic_on_warn set.

Eg: on how a crash would look like when panic_on_warn is set.

[  173.803078] ------------[ cut here ]------------
[  173.806961] memcpy: detected field-spanning write (size 56) of single 
field "&dg_info->msg" at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
[  173.817612] WARNING: CPU: 4 PID: 9003 at 
drivers/misc/vmw_vmci/vmci_datagram.c:237 dg_dispatch_as_host+0x88e/0xa60
[  173.826031] Modules linked in:
[  173.828765] CPU: 4 PID: 9003 Comm: r Not tainted 6.7.0-rc7 #6
[  173.833502] Hardware name: Red Hat KVM, BIOS 1.16.1-1.el9 04/01/2014
[  173.838689] RIP: 0010:dg_dispatch_as_host+0x88e/0xa60
[  173.842953] Code: fe ff ff e8 a4 61 70 fa b9 18 00 00 00 48 89 de 48 
c7 c2 e0 c8 20 92 48 c7 c7 60 c9 20 92 c6 05 e3 62 22 12 01 e8 92 c2 38 
fa <0f> 0b e9 82 fe ff ff e8 76 61 70 fa e8 71 61 70 fa 48 8d 7d 0c 48
[  173.857632] RSP: 0018:ffff88810362fb10 EFLAGS: 00010246
[  173.862078] RAX: 0000000000000000 RBX: 0000000000000038 RCX: 
0000000000000000
[  173.867885] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[  173.873689] RBP: ffff888118f94680 R08: 0000000000000000 R09: 
0000000000000000
[  173.879503] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff888118f71130
[  173.885317] R13: ffff888118f71100 R14: 0000000000000000 R15: 
0000000000000000
[  173.891124] FS:  00007fced2868740(0000) GS:ffff8881f4200000(0000) 
knlGS:0000000000000000
[  173.897658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  173.902397] CR2: 0000000020000000 CR3: 00000001198d2000 CR4: 
00000000000006f0
[  173.908222] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  173.914073] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  173.919901] Call Trace:
[  173.922117]  <TASK>
[  173.924075]  ? show_regs+0x9b/0xb0
[  173.927151]  ? __warn+0xeb/0x2c0
[  173.929981]  ? dg_dispatch_as_host+0x88e/0xa60
[  173.933769]  ? report_bug+0x313/0x410
[  173.937010]  ? dg_dispatch_as_host+0x88e/0xa60
[  173.940804]  ? handle_bug+0x9d/0x130
[  173.943922]  ? exc_invalid_op+0x36/0x80
[  173.947195]  ? asm_exc_invalid_op+0x1a/0x20
[  173.950768]  ? dg_dispatch_as_host+0x88e/0xa60
[  173.954524]  vmci_datagram_dispatch+0x1da/0x230
[  173.958368]  ? __pfx_vmci_datagram_dispatch+0x10/0x10
[  173.962583]  vmci_datagram_send+0x2d/0x50
[  173.966006]  vmci_transport_dgram_enqueue+0x2e2/0x410
[  173.970228]  ? __pfx_vmci_transport_dgram_allow+0x10/0x10
[  173.974689]  vsock_dgram_sendmsg+0x391/0x610
[  173.978336]  ? __pfx_vsock_dgram_sendmsg+0x10/0x10
[  173.982568]  __sys_sendto+0x4dc/0x540
[  173.985767]  ? __pfx___sys_sendto+0x10/0x10
[  173.989289]  ? __pfx_vsock_dgram_connect+0x10/0x10
[  173.993312]  ? selinux_netlbl_socket_connect+0x37/0x50
[  173.997588]  ? selinux_socket_connect+0x76/0xa0
[  174.001449]  ? __sys_connect_file+0x5d/0x1b0
[  174.005078]  ? __sys_connect+0x113/0x1b0
[  174.008420]  ? __pfx___sys_connect+0x10/0x10
[  174.012031]  ? count_memcg_events.constprop.0+0x48/0x60
[  174.016346]  ? handle_mm_fault+0x2c8/0x910
[  174.019797]  ? ktime_get_coarse_real_ts64+0xa0/0xf0
[  174.023862]  ? __audit_syscall_entry+0x393/0x4f0
[  174.027769]  __x64_sys_sendto+0xe9/0x1d0
[  174.031090]  ? syscall_trace_enter.constprop.0+0x138/0x1b0
[  174.035604]  do_syscall_64+0x45/0x100
[  174.038765]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  174.042953] RIP: 0033:0x7fced220eca3
[  174.046040] Code: 48 8b 0d 08 83 20 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 0f 1f 44 00 00 83 3d 49 c7 20 00 00 75 13 49 89 ca b8 2c 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 2b f7 ff ff 48 89 04 24
[  174.060689] RSP: 002b:00007ffe5f77d2e8 EFLAGS: 00000246 ORIG_RAX: 
000000000000002c
[  174.066898] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007fced220eca3
[  174.072766] RDX: 0000000000000020 RSI: 00007ffe5f77d400 RDI: 
0000000000000004
[  174.078573] RBP: 00007ffe5f77d330 R08: 00007ffe5f77d310 R09: 
000000000000000c
[  174.084376] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000400730
[  174.090185] R13: 00007ffe5f77e520 R14: 0000000000000000 R15: 
0000000000000000
[  174.096014]  </TASK>
[  174.098021] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  174.101976] CPU: 4 PID: 9003 Comm: r Not tainted 6.7.0-rc7 #6
[  174.107921] Hardware name: Red Hat KVM, BIOS 1.16.1-1.el9 04/01/2014
[  174.112923] Call Trace:
[  174.113973]  <TASK>
[  174.115922]  dump_stack_lvl+0x83/0xb0
[  174.117975]  panic+0x697/0x720
[  174.121972]  ? show_trace_log_lvl+0x3bb/0x520
[  174.125942]  ? __pfx_panic+0x10/0x10
[  174.128925]  ? dg_dispatch_as_host+0x88e/0xa60
[  174.131924]  check_panic_on_warn+0xb6/0xc0
[  174.133970]  __warn+0xf7/0x2c0
[  174.137970]  ? dg_dispatch_as_host+0x88e/0xa60
[  174.141970]  report_bug+0x313/0x410
[  174.144924]  ? dg_dispatch_as_host+0x88e/0xa60
[  174.148898]  handle_bug+0x9d/0x130
[  174.149968]  exc_invalid_op+0x36/0x80
[  174.153969]  asm_exc_invalid_op+0x1a/0x20
[  174.157970] RIP: 0010:dg_dispatch_as_host+0x88e/0xa60
[  174.161970] Code: fe ff ff e8 a4 61 70 fa b9 18 00 00 00 48 89 de 48 
c7 c2 e0 c8 20 92 48 c7 c7 60 c9 20 92 c6 05 e3 62 22 12 01 e8 92 c2 38 
fa <0f> 0b e9 82 fe ff ff e8 76 61 70 fa e8 71 61 70 fa 48 8d 7d 0c 48
[  174.176923] RSP: 0018:ffff88810362fb10 EFLAGS: 00010246
[  174.179922] RAX: 0000000000000000 RBX: 0000000000000038 RCX: 
0000000000000000
[  174.185967] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[  174.189966] RBP: ffff888118f94680 R08: 0000000000000000 R09: 
0000000000000000
[  174.197968] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff888118f71130
[  174.201969] R13: ffff888118f71100 R14: 0000000000000000 R15: 
0000000000000000
[  174.208924]  vmci_datagram_dispatch+0x1da/0x230
[  174.212884]  ? __pfx_vmci_datagram_dispatch+0x10/0x10
[  174.216923]  vmci_datagram_send+0x2d/0x50
[  174.219924]  vmci_transport_dgram_enqueue+0x2e2/0x410
[  174.221966]  ? __pfx_vmci_transport_dgram_allow+0x10/0x10
[  174.227939]  vsock_dgram_sendmsg+0x391/0x610
[  174.230883]  ? __pfx_vsock_dgram_sendmsg+0x10/0x10
[  174.236021]  __sys_sendto+0x4dc/0x540
[  174.237970]  ? __pfx___sys_sendto+0x10/0x10
[  174.241968]  ? __pfx_vsock_dgram_connect+0x10/0x10
[  174.245969]  ? selinux_netlbl_socket_connect+0x37/0x50
[  174.249969]  ? selinux_socket_connect+0x76/0xa0
[  174.253968]  ? __sys_connect_file+0x5d/0x1b0
[  174.257966]  ? __sys_connect+0x113/0x1b0
[  174.259923]  ? __pfx___sys_connect+0x10/0x10
[  174.264922]  ? count_memcg_events.constprop.0+0x48/0x60
[  174.267947]  ? handle_mm_fault+0x2c8/0x910
[  174.269966]  ? ktime_get_coarse_real_ts64+0xa0/0xf0
[  174.275924]  ? __audit_syscall_entry+0x393/0x4f0
[  174.277970]  __x64_sys_sendto+0xe9/0x1d0
[  174.281972]  ? syscall_trace_enter.constprop.0+0x138/0x1b0
[  174.285970]  do_syscall_64+0x45/0x100
[  174.289966]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  174.293967] RIP: 0033:0x7fced220eca3
[  174.297970] Code: 48 8b 0d 08 83 20 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 0f 1f 44 00 00 83 3d 49 c7 20 00 00 75 13 49 89 ca b8 2c 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 2b f7 ff ff 48 89 04 24
[  174.311883] RSP: 002b:00007ffe5f77d2e8 EFLAGS: 00000246 ORIG_RAX: 
000000000000002c
[  174.317968] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007fced220eca3
[  174.323930] RDX: 0000000000000020 RSI: 00007ffe5f77d400 RDI: 
0000000000000004
[  174.329968] RBP: 00007ffe5f77d330 R08: 00007ffe5f77d310 R09: 
000000000000000c
[  174.333967] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000400730
[  174.340923] R13: 00007ffe5f77e520 R14: 0000000000000000 R15: 
0000000000000000
[  174.345969]  </TASK>
[  174.348922] Dumping ftrace buffer:
[  174.348922]    (ftrace buffer empty)
[  174.348922] Kernel Offset: disabled
[  174.348922] Rebooting in 86400 seconds..


Thanks,
Harshit


> Thanks
> -- 
> Gustavo
> 


