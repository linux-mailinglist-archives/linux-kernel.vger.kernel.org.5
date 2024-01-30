Return-Path: <linux-kernel+bounces-43802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA28418F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F14B1F24FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746FE364C0;
	Tue, 30 Jan 2024 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="PX9wLsmz"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2056.outbound.protection.outlook.com [40.107.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABA364B3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581069; cv=fail; b=MSpozXbF7mKDeoBguarhPbYyWxdKx5v3nwxwbex/K3fAgWu6BzUwW5TztDFkZDWp+U6ot49nKpbOGFgET+FZ59urXi49rCvV8Mb3ODA/HMKDEInL8D/edyCCRryCp6+iYGgnBSo1MqnSuBYlSntlbSKwkojs1yXbbpdroJHQJhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581069; c=relaxed/simple;
	bh=atMEqvVFqz++yeb1iWv+CVCjc5B3z83sb5UaemB2Qfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kK+2XGb7K51ZaZ47wR44CYmZJCIWU50DaJQ+G9Hp6VzuGKHww7JcGT77yp3ZQIhuG1Vzdu/yCbbQkq2muto0/Q82dcTuKpoycLzyE9Se+ed056S+M1JdlklZubvQa2lWe3vTzjyIdJSRzn4AeJMHB2znMmOUCtFVk2XlKK906zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=PX9wLsmz; arc=fail smtp.client-ip=40.107.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifwFzZ98JTllEOMGud+LT7A3goxSCZqW+K5ze1ZNnr49Jzb2xzlLi1+97EcGO++4W7wkbofgFeOVQF3LzmZv9i0wjEfc5yDbkmysBr8L6g7WKSDhVkIlbkObX5AQZL2eGeRkhjlRL8gTZ9ovTy+JiNEtWjGqLUrgCwifcJRWBll9dwMLFd2vOJJnXn1QtRahGicgD8Qvrdoz0GR1cyuiq3zwNmRWtk0GHZCfp/hwJBFM4l9khMOjagh2KO78jCx2XB9CWR1Oe5SlxjB+aTD7CK0W/uej3EiESgFG2XlJof7OTVid53/DiOcmVaomvTgr+N0I4jNQSLqYB9lhuU4LGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Skh+gcgmbCaVhQHgESqR6Df05Hu2BJPcHH4GeeNys=;
 b=Vbl3fezPSZ8QqhCXTGS+4xA3D9EkZX0CUvYOZvJBCBSD2FQGps7Cr7j0YKaJqL9eq8P4KwewB3b+c2AwE2plVBHsvR07sJWQmUva2gcf8FADDgabMc1Z26PWLoSj8UTh5ypAedD+NDcFPmnw2KFd0KRLX/6iBKc+rMqKdm/anlcU3hp80u7Nf7spC4fhlYpjI4FdXZMeP9MerIIqR0InUC/JlHqFkzYlulIkBRNtsAZZd2oyO+wJ0kI798oXHcu6vxMaCuY6SIka4LCU2ki+1cpJ4XByJRCjBZis1S4yxhKTuWd9Mz9+yGoHP0SBay1spnuOm2nd7bllj76+joyz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2Skh+gcgmbCaVhQHgESqR6Df05Hu2BJPcHH4GeeNys=;
 b=PX9wLsmzykmjYxW4fNAiU2JhgqbFIc4pWw9wQAMMZrVjkx7PNMyKlqmAKYiPFxmYcDoCeNqP53UJdowVOdRec9JWZRMO7FHPYKnQVQjtmtduYGrOYxJ3jRYNFinE7Av0X3oEJsZNpxdJJi4SYtPoWKCbN2lhGBxJhtBVtL3d0Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by TY0PR02MB5921.apcprd02.prod.outlook.com (2603:1096:400:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 02:17:42 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::f4:dbf7:9c0c:5388]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::f4:dbf7:9c0c:5388%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:17:41 +0000
Message-ID: <20fdbfaf-aaa3-466e-8797-1927bf0bc804@oppo.com>
Date: Tue, 30 Jan 2024 10:17:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
References: <20240117230032.2312067-1-daeho43@gmail.com>
 <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
 <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
 <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
 <CACOAw_yqrtEhq4wtJbs7CVn260h7iZyC7koCWH1iMyeQo5140g@mail.gmail.com>
 <e879da72-4c4f-4aed-8081-784f2de5c887@kernel.org>
 <CACOAw_xDDoOQEHOAXkG+8PF8yD0MtUAW4J04tYcPCh3VMp7FGQ@mail.gmail.com>
From: Yongpeng Yang <yangyongpeng1@oppo.com>
In-Reply-To: <CACOAw_xDDoOQEHOAXkG+8PF8yD0MtUAW4J04tYcPCh3VMp7FGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PSAPR02MB4727.apcprd02.prod.outlook.com
 (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|TY0PR02MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 43630786-c27b-4d3e-316c-08dc2139a2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s3dgoqKbxVXs2DKn89tR6JxtA8j4CH3eP/5gFdkvajnIS+p+mFe00dZEjVFAYw6C247HP4slIju+UrAv2EG6XJK52RAxvmok4i2ZlxwsmXG2MI4yxFw2Q0/afSLJGtAD/ELcrb2GN1O/ttItZz6bF/wVj0soslEAxnRNa03xk0ir4BtJMPkCdnGqpjUEjey3ZgT/y2kdlVedjlkYoJiIBxlI3OsPztOsxHgAQdEAqVk5mIyb+0DgLxzP6Iw1iNJeFJckUlH6kMKevvWC+YdxsrIf/TiZpK5B+BPA/XcsXc4vfaBct8x7+BLHV1+31vktrLt3QgV+A7nslmKWLSxXTBsoJIDcDsVS2gsJj+Ypgqxb5XK32zsZ+eej9dJmMz1cjbBDQ1SfBDpNpDz0Jm0oAV4X6amdqXdmfhid4oDsg9kYbbRgQIqQgCwGEeo+6MalsvknruppMIiSwFW2x1j1pMWBLHqsh3ZSVZ1CkbCfVk4tRyK86RxJFruBt9Kx4L9lwXtEW6GhuocUK6siU7M9aHNywYzXkY6wlMA/K+l3u+Wt5os7ltnwhzz0OkucMiVjSnJswD7YuKWVZPGWQ37r8XXziEYDzJ1b8cK/WlsUw+E5APfFjEjlajRe4RQv8tXZQZ1ZjcORfmOV6t7a+LAjxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(53546011)(26005)(83380400001)(6512007)(6666004)(6506007)(36756003)(86362001)(31696002)(8676002)(41300700001)(5660300002)(4326008)(8936002)(66946007)(38100700002)(66476007)(6486002)(2906002)(66556008)(2616005)(478600001)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1hQc0lET05vWk9HZWhqNEowQnRvNEdvOFhueThWMWVxcDZYRXBEUWE5V2ox?=
 =?utf-8?B?ckdmbDQ3VDFWMmJDSVlEcW4yVmZ3bWRyOXFtZndZNnRwQlZibFN0TVlwQnY0?=
 =?utf-8?B?OUZkTytEVjJCRHRFZ08rT3lYWUlTYUVVZ0VVTlhiZjBSRVlNVUdzeVFiM20z?=
 =?utf-8?B?UzlYZFRTQk5PeUJTK04wUmN1dUJSRGNhRnhZSWxBclUwd3lyS1paYXlwK1pF?=
 =?utf-8?B?dFRrcWdDNitkRHBDYWZwV0tQSFNDRFFmVDl2VjhNSGFUQ2t3N0dQcDI5SGdP?=
 =?utf-8?B?d2RuZUJZckZaVFllckd5c2tReDVYR3JFeHhGT05YNEhnbmNodEZSbWVUQ3I3?=
 =?utf-8?B?TVNSZXZoMXV5QmxmNmVoVS9ubEprWUdCRDVNVXAwWk1Sc3Uwa21oQ0RpNHdO?=
 =?utf-8?B?MlRuSjlIdGNDcElZcytCVjdER1FZenZ1T2xnNU9wQU91VmJtcGkvVzVxcnJC?=
 =?utf-8?B?SjVtMWN5UlJvSU0xM1ZYdnRCNlh0c0ZXb3UxOUt2Yk5SM0hMYmhkSlVCR2l6?=
 =?utf-8?B?UXFUQml1bHM2R2RWanFIa0U2SFJncThqUVFkcCswTzV3SXBJUFBlS21iK3Fq?=
 =?utf-8?B?VEt4N3JnWldpVnZYYzJCcUc1ZDluZXVwaTlqYk8wdkpINE5sLzUrejg2a3Fr?=
 =?utf-8?B?bGRoell6S00ycm9GYi95WWdxMFgrR3NaYWV5RnI5dktpMXE1TFBCY1hSMW9i?=
 =?utf-8?B?OEtVa3lFNE1xdDJ5ZWNSUDc0bjBVU3J6ckxzWTl6VldJclh4RlN6bVBIWlNM?=
 =?utf-8?B?WjFsUDc1SDlqNnhEQXJGd1FCQlhEbUdRREJ1a1Y4STBhN2VyVXNQK3hHNjJr?=
 =?utf-8?B?b3k1S0xrM3poNmc0V3VTbHRtZU9kMS8yaCtwOXFKK3FmK3ZoMUZSQkU0MXE3?=
 =?utf-8?B?d0Z2T2JLVWNyMUtnTFl0UTFEQUhkbHZCR1RGeVZMUDdsdUwxM2FkUnh0ZFNM?=
 =?utf-8?B?NlFkS2NYODNiNVQ2QWk1TFRiVkdTNCs1OWJOUTU5Unh6WW13YWM5dUk5Qmhn?=
 =?utf-8?B?cnhuS0ZHMWEyVm0rVUd6TXZ6UGp4WnhOT3lEZFdoak9jSTRVbWYrWG9rNVdF?=
 =?utf-8?B?RHpYbzEwRzZoYWVsUG0zdjlLbWxHdDdtV3dYTWlwakd5Tk1vMFVQUHNXcnpU?=
 =?utf-8?B?RFU1UjVaOU9NK1YxU0VmNjdBaFpib0J1N2tDSjZHY0dqcmx1L2JsYXVjM1lB?=
 =?utf-8?B?R0FCRHV3MFEyeThNYzl1b3hKUXhGZnBSK0QwRjZ3R0Q4WWpTb0JmWCtrNUNQ?=
 =?utf-8?B?NUFvbjlrekowZDlKWlVmTC9QZlJFQlR1S1M3bWswWlJ5R2VITGdqOWNXdnha?=
 =?utf-8?B?WjdDVmZWbTI0MWJxV0k2dkhoeWVma1lCZlFRNTFTdDhha1pydHovU3g3OXBn?=
 =?utf-8?B?WG43eTlxbjNXRjNjWmJVZmU5MjFzWStDVWpzQ3hXdTNPdmNuMTR6eTUyYm0y?=
 =?utf-8?B?SG1xY3BrRDlEbXk3MTQwNFNTR0V0bFA5VHJCSDhsbmEzcUhZdG5lZmdTVmF4?=
 =?utf-8?B?eTZWWEx1TVhOcDVTZXp5Zlozb0pFS0ZNZzg1bENsSEYwNjh6SWw2Qk8vSzB2?=
 =?utf-8?B?RlV6Y2syQkZDcUhFRW5UY2grVDVKaFFuUDdEOTZqSFBrZGJiYzFBZk5sR1Ra?=
 =?utf-8?B?WlZ0aVFkS1I3emJndEpWZ1FGbEdwREduYnovc3k5TTl5ZWJNR1ZkSkU2Z0xY?=
 =?utf-8?B?MUtCMUhORUNWcG9FUEo3WTBzdkt6MGhtMjFTM2tWOU5KYW0xaUZMdXRnQlAv?=
 =?utf-8?B?TUhRdVRFYTFnb3FJNTU1Z2JwRzUzL00zWWJwamdqdlRuZVFnOXlvcTRBeWRC?=
 =?utf-8?B?c3h0ZTBSS3VJemJhNW1FNzBUdzc0bmZlWG5UKzFPbTF4TS8vTDJlOEtaVUt6?=
 =?utf-8?B?TkRDWmhGZVhKYld1dUZuSmpWc0NpWk16cnF2RGRTeGxQclg5UkR6aklQcXY1?=
 =?utf-8?B?ekNUN1Y1c0llV2ZIMmRUeDY4YnNscWRWSVRNSERZclY3VjAzcHNCam1wQWZY?=
 =?utf-8?B?SUtJWG90UVliTTNLOTVLeXUySjNGMnlXcVpKZWdNM2RKNWVtQit5SkNROWRq?=
 =?utf-8?B?U3NYZGdldDdBQ3UzcGdrK1hrbEVPa1hZUmRoSmIyUTc0YzkzK2lEK1pWK2JZ?=
 =?utf-8?B?RThkcGpjNkMwS3dVaGFBR1lETldKUFd2eHhaUjgxUkJKZ3djcHlqczFGeEU0?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43630786-c27b-4d3e-316c-08dc2139a2cf
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 02:17:41.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmPpquYoTcnxSl74JONgZAA5XS3jXSkEHjFo0uBayYzbP2Dj5UcOqh4tEwrZfzFbKYEMVqulKXhin4dV7wKMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5921

cur_seg[CURSEG_COLD_DATA] will exceed end boundary of main area when:
device[1]: zone device size = [2 MB ~ 10MB]

So, if there are not enough seq zones for six cursegs, we should still 
assign 0 to c.cur_seg[CURSEG_HOT_NODE] or reserve several conv zones for 
cursegs.

On 1/29/2024 11:47 PM, Daeho Jeong wrote:
> On Sun, Jan 28, 2024 at 5:27 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/1/27 2:17, Daeho Jeong wrote:
>>> On Thu, Jan 25, 2024 at 5:27 PM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2024/1/26 0:25, Daeho Jeong wrote:
>>>>> On Wed, Jan 24, 2024 at 7:34 PM Chao Yu <chao@kernel.org> wrote:
>>>>>>
>>>>>> +Cc Yongpeng Yang
>>>>>>
>>>>>> Daeho,
>>>>>>
>>>>>> Yongpeng reports a potential issue: if c.devices[0].total_segments is
>>>>>> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exceed
>>>>>> end boundary of mainarea. Could you please check that? though it's a corner
>>>>>> case.
>>>>>
>>>>> Can you elaborate more?
>>>>
>>>> Since c.cur_seg[CURSEG_HOT_NODE] is an offset started from main_blkaddr.
>>>
>>> Oh, Got it.
>>> Then, how about this?
>>>
>>>            c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>                            (c.devices[1].start_blkaddr -
>>> get_sb(main_blkaddr)) / c.blks_per_seg : 0;
>>
>> Better, but log header should align to start blkaddr of zone?
> 
> It's already aligned here.
> 
>          if (c.zoned_mode && c.ndevs > 1)
>                  zone_align_start_offset +=
>                          (c.devices[0].total_sectors * c.sector_size) %
> zone_size_bytes;
> 
> ...
> 
>          for (i = 0; i < c.ndevs; i++) {
>                  if (i == 0) {
>                          c.devices[i].total_segments =
>                                  (c.devices[i].total_sectors *
>                                  c.sector_size - zone_align_start_offset) /
>                                  segment_size_bytes;
>                          c.devices[i].start_blkaddr = 0;
>                          c.devices[i].end_blkaddr = c.devices[i].total_segments *
>                                                  c.blks_per_seg - 1 +
>                                                  sb->segment0_blkaddr;
>                  } else {
>                          c.devices[i].total_segments =
>                                  c.devices[i].total_sectors /
>                                  (c.sectors_per_blk * c.blks_per_seg);
>                          c.devices[i].start_blkaddr =
>                                          c.devices[i - 1].end_blkaddr + 1;
> 
> ...
> 
>          total_meta_zones = ZONE_ALIGN(total_meta_segments *
>                                                  c.blks_per_seg);
> 
>          set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
>                                  c.segs_per_zone * c.blks_per_seg);
> 
>>
>> Thanks,
>>
>>>
>>>> If c.cur_seg[CURSEG_HOT_NODE] was assigned w/ c.devices[0].total_segments,
>>>> and c.devices[0].total_segments is larger than segments of mainare,
>>>> c.cur_seg[CURSEG_HOT_NODE] will exceed the end boundary of mainarea.
>>>>
>>>>           c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>                           c.devices[0].total_segments : 0;
>>>>
>>>>> In the case of F2FS_ZONED_HM, we have the devices[1].
>>>>> Do you mean the case we format the filesystem intentionally smaller
>>>>> than what devices have?
>>>>
>>>> I mean blew case:
>>>> device[0]: conventional device size = 10240 MB
>>>> device[1]: zone device size = 2 MB
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> On 2024/1/18 7:00, Daeho Jeong wrote:
>>>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>>>
>>>>>>> Make to allocate logs after conventional area for HM zoned devices to
>>>>>>> spare them for file pinning support.
>>>>>>>
>>>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>>>> ---
>>>>>>>      mkfs/f2fs_format.c | 3 ++-
>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>>>>> index f2840c8..91a7f4b 100644
>>>>>>> --- a/mkfs/f2fs_format.c
>>>>>>> +++ b/mkfs/f2fs_format.c
>>>>>>> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
>>>>>>>                  c.cur_seg[CURSEG_COLD_DATA] = 0;
>>>>>>>                  c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
>>>>>>>          } else if (c.zoned_mode) {
>>>>>>> -             c.cur_seg[CURSEG_HOT_NODE] = 0;
>>>>>>> +             c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>>>> +                     c.devices[0].total_segments : 0;
>>>>>>>                  c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
>>>>>>>                  c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
>>>>>>>                  c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);

