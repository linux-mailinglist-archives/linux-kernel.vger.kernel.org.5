Return-Path: <linux-kernel+bounces-45629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1664F843335
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1760289C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D7538A;
	Wed, 31 Jan 2024 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="CtzJDLwQ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3E522A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667276; cv=fail; b=lygafxLm+0dhtDCsOPFao4+C/bso/N4SJ7PR4bvX4c1JHsxypaCKALDzaTO/spkYaMuMAJMWuqAV/7+hxUWriUCMS7n1Q9tzqI5mTMaFYozcDn55SVhy74pEh2FqwcvnokpUCEXSx6WRmClTfElh4ZuWo35Jjsl2Mf5Q10lPj/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667276; c=relaxed/simple;
	bh=kNBahNwC4y6uSc4B6gDNPhe/hsZ1m0FsM9Fz0gXBd5g=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EGnYiuN4+0DxW1GDE0/ZbGM+Mh3UPSasNsBcC79b5T/BSKwZ0qtSs0430U5T39HDI7njyW4bGHecaapjToRcyTd24eCkKnbD0pitYzRzUTyTUG/8AhOAvpYttih++Ag0W9UkFOsNatF7bWR/4IfiUVsOvyVA+4Mytv7Iz80+YkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=CtzJDLwQ; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmbQzIRad22gBo7sb+VskR2/hca3WGvLzFpoxY1AFIrgR0f6yeUNiDGCqTtoQGz2vOV9/RrN1K8eJmDKx4OzR0sXNXSKTa07e5FBuHCYQtELXmzj7nxunH8TRqUtIfbX51ALSREihAVGYGlLEjcdY7U6nO+nHNKqUf3DYrEEfo2g203XkYELanL0KnIVohiz8HTmhpvnNJnL+ybthg5P+DN966FdUZrzH/1Ty9PxPADC9k1ZlN+5Jayfv9OwBBIXZmGISNu10LLNxwr3djDKf2knLHeS3NM/myljh2aE547bwWDRpO+FNubdAlcIz41ObXSu8lST4fpWWNai3AV/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okNLaNGXePTVJbp77CNYVaCk87E46KUhrp+gJGH4DV8=;
 b=YHVEURb4QOOukePw1bVE0Boz78A6ZUGdLUKJXdbK3VUwSMT724/DrUEmROrv6LOStnDw2J8XuwJVbmagPDISmCDEwznMn4jWC+NbRmbBaQoqEIpDaEG8qtdBwb1qkpnJ4eNJaR6koJDliF0pNcEI5WXHw0cBH4OpHjivCmq97F1J/UtHv+vAqgPPeUfTMra5QBU8KC5RlD4ZODL8iNfCv5aQQAVnzfYbWhSaULhBZ/HEFUVdgBOjGrkSvFyupIJpQaKcT3jW5ZJKswkhAW4mxa047EtAUZD92Y3mTbpOnzdUJ3V1WkYc/TKYL+q3YoAZwAlFxGUItnHMHCVkltUHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okNLaNGXePTVJbp77CNYVaCk87E46KUhrp+gJGH4DV8=;
 b=CtzJDLwQMUSmflkzlmB2sE7nmOnDT3LjoQvM47fXIJuUhVyDP3kKdWX8Y78HoDC4w21EQzLXAfh/X62CLqePzqxuG/ePsU0ATTAOSxGIMUkJ3qIsZbax12AivG97K/vsufsh7XmR7p+5R7Espp3cJ61ro6a1eeqXa1lg5CHadCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by TYZPR02MB7906.apcprd02.prod.outlook.com (2603:1096:405:af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 02:14:30 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a815:49db:df99:5461]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a815:49db:df99:5461%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 02:14:29 +0000
Message-ID: <3a4e1892-c68f-45cc-ba61-ca7d675e95c8@oppo.com>
Date: Wed, 31 Jan 2024 10:14:25 +0800
User-Agent: Mozilla Thunderbird
From: Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
To: Daeho Jeong <daeho43@gmail.com>, Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240117230032.2312067-1-daeho43@gmail.com>
 <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
 <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
 <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
 <CACOAw_yqrtEhq4wtJbs7CVn260h7iZyC7koCWH1iMyeQo5140g@mail.gmail.com>
 <e879da72-4c4f-4aed-8081-784f2de5c887@kernel.org>
 <CACOAw_xDDoOQEHOAXkG+8PF8yD0MtUAW4J04tYcPCh3VMp7FGQ@mail.gmail.com>
 <20fdbfaf-aaa3-466e-8797-1927bf0bc804@oppo.com>
 <CACOAw_zKTPD5epxD2RsvarDJJUxz8LEhFvkWJex19XtY9hxa0w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_zKTPD5epxD2RsvarDJJUxz8LEhFvkWJex19XtY9hxa0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|TYZPR02MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f9d963-af9e-4727-62f6-08dc22025b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qVVMVRiH9gnuWl8qSKaAB1AO8mmgAtwjKq3T0cwS9VI2PbuUFmmXHGpUoYecxXVdqOufS2v7or3LO55PgfmH1kXWwEPeQsTarleXWGmDXTV3Sc1ye6ybKQJ+cFDlaX4R7k76m6upQDyzY6LsfrHd7/PjghLwLNbcKTLQi8F8Hjsufz5ubgduZ8lODzlJnhA28SevvAmIV4uUDALCK+dxjAVMrCLawlMQdALOfS0hD4c3jjAbubr4sDdGrKGPQEuoqsT+fd6ScVMtFlH8OdE6Dte1Yqj3NcHXw4abScj62TZbleOYqR6HBp66L9DAF7ZNDYqqivL3KhQxwaU+9BIeCiAlS2DC7U6T/4z2+InNBlOTiBx+T847OreCsYnziqK/YiEkJ2o64K9azX4Z4S+k/ZSc66zbkOMjcbCyyezZmiSUfZaByN3PcSB9xq44DyMpfMjW52J4pPC2EkJ9p0d3Jx3x//o45NIz1f4jm1FTG+wN1T85keqkkWmbzbvvP6u+qG1JJ1RT+Ey34ZlNop367yHqzrG8XteE0B8vc4UsAMDcE7tip9vPXCn6Sj05hB3MOtdmHpefvbGpHlWcFp+cTrip1+OZ+IzlutmOJvErCWdQzzUROl9gsEbJn5ixSrUmOJvcscgkde66Yd57hFQtEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(41300700001)(86362001)(31696002)(36756003)(38100700002)(2616005)(26005)(6506007)(6512007)(66476007)(6486002)(2906002)(6666004)(66946007)(110136005)(53546011)(316002)(66556008)(8936002)(5660300002)(4326008)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWtoZDdTNlovWDl5NHUwYUMyR2F4VnJ0a29rVVBXd0ZBSGNCWGpKaEg3ZlNu?=
 =?utf-8?B?NGo3bWkvcUJvektzd01uVW5YZ2RhWXdDS3N6dS9ucEhmUVBlSHpWQmJIZi94?=
 =?utf-8?B?VWxCcXc4cCt3TlU1NWZFMUd1TEJJOTEvdlVXbDdzRUEzc0ZYS1RqR3F2UktD?=
 =?utf-8?B?cUgxSlZNZVVJa2xSRlN2RjhlQU1ic3dZMmVqajZQR2wwazVBU2Vwbm1RNDZa?=
 =?utf-8?B?Y2RqaWcweUl2bklOTXJlUUxGUXZKazZrWHBHVkNQdmxmSitXZzZKMDhabFQ3?=
 =?utf-8?B?S1ZDM2R5V1IxVTlvTXBzc1hoRE1sVzh3K2NUZVZFUTAyaG1aNkN0RC96WFVr?=
 =?utf-8?B?QzNYa005NHhZcEVDYWg5cVRPUzVldkJOZUxUZ2JSZUlmZ21BOEpYRlJndmRj?=
 =?utf-8?B?ZWw1dVBHTlAvNnBYQjBYQzM5SGk5S24wbHFUTVhsOHZ5dlNEWlZmNjVjck56?=
 =?utf-8?B?VkxsYzluSjdQenlITmNad2RBZm5hcWJPaUR0VkJySTBZTXR3V2V4R1JwVEMr?=
 =?utf-8?B?Q1EyeWZkTVB6ZExzWmJwc1pFTmR5ZlI0eHdHRm5vOTBvUG5Ndy9lRUhrVnJj?=
 =?utf-8?B?cmxTMkdIT0s2WHdpMWlKS1ZmRXhmeWwzcEt1ZXhBMkU2OTBjYXI5Zk4weGpm?=
 =?utf-8?B?U1lBdUhHampxL0IvU1dZMmcwQzNPSDVGS1UrRHJ1WDVYZUpUYXdQLzNnQ0Fa?=
 =?utf-8?B?MTVBanp2Unh3MW54aXNPZ2VlMTJ3U3VBTWJWOCt5Vk1TNFl5eVhJQ1VrTnhj?=
 =?utf-8?B?MTYrMksydzduT1VaaWJrcmljWW9UaWNERE9LY3pCZjFSc0pCZXFvZlNMcW5m?=
 =?utf-8?B?N2lFTzVHYzZxcXRjclVuV0RJRHBCaHh4VTgwVEpOWFRjZkJsVENWcEN6QWNL?=
 =?utf-8?B?b1BVMHdkbXJISnNIMmpTc2szRUZWYnJvbkZrUDRiVjRUWUdLSEphVWplSjlv?=
 =?utf-8?B?L0pjeXJYMCtCSFkwOVRydE1uTGRaaXgzY0RKd3Jsd2hSbWN3cU1vK0lacDFh?=
 =?utf-8?B?UE4ycElvM1lZMC9oUFl1WUdkRHJjWGJTa1BVNGk0RWdLNkZwQzh6c1RZb2Uw?=
 =?utf-8?B?ZHhBb0IvSXVESEpoY2pteVNFZktVYXdmbGRlSjhiaGVoTjZlSjlDNlhLMFJO?=
 =?utf-8?B?T3dFbjB0emNxT2FGdzZBQnlCYUdPaUdLQnRLazJ0dkwxWmhyYnA5NnFOYW8x?=
 =?utf-8?B?QkVjcVVYV3FHNEVPSUxOUXliVThJVkpIVTRtWDgzeis0NHM0YkxnL2lqWkk5?=
 =?utf-8?B?MTgvK3JLaldFcXNzK0tJMjJwNHkyTUZ2a3ZMUzlzOWJha1VIR0h3QkF2c3RY?=
 =?utf-8?B?MG9pWVY1VGZ3aVprU01qRUk3MkJmL0xieWRYNnNSTjg1bDhQSG5uMUhOU09M?=
 =?utf-8?B?bWRjV2RHR1Z4ejVSa3JLd0pJckpvY0tOWVdOTWkraEMzcEdDTmF5RmxmTytu?=
 =?utf-8?B?ZFZqOUZPL1pNMDUzTTcxR0JwOGI0WUMvS21yelZtVGZIUU82YUxuS0FxRGFS?=
 =?utf-8?B?cEJyeWxxTFBnS0RianFjVjgyRnJkZHgxMHJobzdhT25WUWd0RzlmbUFQVU9L?=
 =?utf-8?B?QU11Z1ZkcjhFUW1oc1JLc1RqQ3NWTTdZVmNkZC83aDBXM2cvMkl4c3VqbnVq?=
 =?utf-8?B?VHFrQ3piMWx4a2Z1ZzVJT05TcDNyOEdXQXNXWFN0RFJXS21TN0wwem1ndTQ5?=
 =?utf-8?B?NUZCS1BoZnBNK0lIQ3ppZmUxZ2t4OUJhMk02VzV6SEY5OG9jc1RTK0FDQlhF?=
 =?utf-8?B?SjZqUm5aeUp5dnY5NnZsWnZrKzBFTlZIbjBTNlFrYVhndUxhd1JqdWVhUC9j?=
 =?utf-8?B?UjlLeEZQbUx1RjNUZldXanpQOGFVU3VGYjFNUGlqc2xyYWx5YldicElpeGFn?=
 =?utf-8?B?M1lFYlo2L2pKVWtHdEM2M3JTWlg2TkRRUTdoZjNRczRZYW5yUlZzQ0JuU1Jp?=
 =?utf-8?B?bWplbFVqbXRLdVVCeXR5N1k0UXBodU5rTE5DYm5qd0lsTDAyeVZSbmZTNUhC?=
 =?utf-8?B?ZDhmQjVuVGxOREpjUTBFcGRjaTkvc01MeDJxOFdvTURTMmt6RmF4a1c1V0ZQ?=
 =?utf-8?B?cUxaNjNLV3pjTkVhalVtdXdEaHUxb0Y0VmNwRkJTNWd6MmVFZWtLYmEzQ0Ra?=
 =?utf-8?B?a1lzMzZldU1zUXI4M3RzQkNTV3dlb0JSZlRvWWRLellGUVBCM0RxWWRRNGYv?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f9d963-af9e-4727-62f6-08dc22025b02
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 02:14:29.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3uDmTYBM4Zx1BWIBC1btkpJ4rTkJU26poIKElelGqZmeF+v6hIHpRMI2pJ0r7+900QjuHc+7eM5qeq6S5xAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7906

On 1/31/2024 2:00 AM, Daeho Jeong wrote:
> On Mon, Jan 29, 2024 at 6:17 PM Yongpeng Yang <yangyongpeng1@oppo.com> wrote:
>>
>> cur_seg[CURSEG_COLD_DATA] will exceed end boundary of main area when:
>> device[1]: zone device size = [2 MB ~ 10MB]
>>
>> So, if there are not enough seq zones for six cursegs, we should still
>> assign 0 to c.cur_seg[CURSEG_HOT_NODE] or reserve several conv zones for
>> cursegs.
> 
> To tackle that case, how about this?
> 
>          } else if (c.zoned_mode) {
>                  c.cur_seg[CURSEG_HOT_NODE] = 0;
>                  if (c.zoned_model == F2FS_ZONED_HM) {
>                          uint32_t conv_zones =
>                                  c.devices[0].total_segments / c.segs_per_zone
>                                  - total_meta_zones;
> 
>                          if (total_zones - conv_zones >= avail_zones)
>                                  c.cur_seg[CURSEG_HOT_NODE] =
>                                          (c.devices[1].start_blkaddr -
>                                           get_sb(main_blkaddr)) / c.blks_per_seg;
>                  }
>
It seems fine, thanks.
>>
>> On 1/29/2024 11:47 PM, Daeho Jeong wrote:
>>> On Sun, Jan 28, 2024 at 5:27 PM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2024/1/27 2:17, Daeho Jeong wrote:
>>>>> On Thu, Jan 25, 2024 at 5:27 PM Chao Yu <chao@kernel.org> wrote:
>>>>>>
>>>>>> On 2024/1/26 0:25, Daeho Jeong wrote:
>>>>>>> On Wed, Jan 24, 2024 at 7:34 PM Chao Yu <chao@kernel.org> wrote:
>>>>>>>>
>>>>>>>> +Cc Yongpeng Yang
>>>>>>>>
>>>>>>>> Daeho,
>>>>>>>>
>>>>>>>> Yongpeng reports a potential issue: if c.devices[0].total_segments is
>>>>>>>> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exceed
>>>>>>>> end boundary of mainarea. Could you please check that? though it's a corner
>>>>>>>> case.
>>>>>>>
>>>>>>> Can you elaborate more?
>>>>>>
>>>>>> Since c.cur_seg[CURSEG_HOT_NODE] is an offset started from main_blkaddr.
>>>>>
>>>>> Oh, Got it.
>>>>> Then, how about this?
>>>>>
>>>>>             c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>>                             (c.devices[1].start_blkaddr -
>>>>> get_sb(main_blkaddr)) / c.blks_per_seg : 0;
>>>>
>>>> Better, but log header should align to start blkaddr of zone?
>>>
>>> It's already aligned here.
>>>
>>>           if (c.zoned_mode && c.ndevs > 1)
>>>                   zone_align_start_offset +=
>>>                           (c.devices[0].total_sectors * c.sector_size) %
>>> zone_size_bytes;
>>>
>>> ...
>>>
>>>           for (i = 0; i < c.ndevs; i++) {
>>>                   if (i == 0) {
>>>                           c.devices[i].total_segments =
>>>                                   (c.devices[i].total_sectors *
>>>                                   c.sector_size - zone_align_start_offset) /
>>>                                   segment_size_bytes;
>>>                           c.devices[i].start_blkaddr = 0;
>>>                           c.devices[i].end_blkaddr = c.devices[i].total_segments *
>>>                                                   c.blks_per_seg - 1 +
>>>                                                   sb->segment0_blkaddr;
>>>                   } else {
>>>                           c.devices[i].total_segments =
>>>                                   c.devices[i].total_sectors /
>>>                                   (c.sectors_per_blk * c.blks_per_seg);
>>>                           c.devices[i].start_blkaddr =
>>>                                           c.devices[i - 1].end_blkaddr + 1;
>>>
>>> ...
>>>
>>>           total_meta_zones = ZONE_ALIGN(total_meta_segments *
>>>                                                   c.blks_per_seg);
>>>
>>>           set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
>>>                                   c.segs_per_zone * c.blks_per_seg);
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>> If c.cur_seg[CURSEG_HOT_NODE] was assigned w/ c.devices[0].total_segments,
>>>>>> and c.devices[0].total_segments is larger than segments of mainare,
>>>>>> c.cur_seg[CURSEG_HOT_NODE] will exceed the end boundary of mainarea.
>>>>>>
>>>>>>            c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>>>                            c.devices[0].total_segments : 0;
>>>>>>
>>>>>>> In the case of F2FS_ZONED_HM, we have the devices[1].
>>>>>>> Do you mean the case we format the filesystem intentionally smaller
>>>>>>> than what devices have?
>>>>>>
>>>>>> I mean blew case:
>>>>>> device[0]: conventional device size = 10240 MB
>>>>>> device[1]: zone device size = 2 MB
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> On 2024/1/18 7:00, Daeho Jeong wrote:
>>>>>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>>>>>
>>>>>>>>> Make to allocate logs after conventional area for HM zoned devices to
>>>>>>>>> spare them for file pinning support.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>>>>>> ---
>>>>>>>>>       mkfs/f2fs_format.c | 3 ++-
>>>>>>>>>       1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>>>>>>> index f2840c8..91a7f4b 100644
>>>>>>>>> --- a/mkfs/f2fs_format.c
>>>>>>>>> +++ b/mkfs/f2fs_format.c
>>>>>>>>> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
>>>>>>>>>                   c.cur_seg[CURSEG_COLD_DATA] = 0;
>>>>>>>>>                   c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
>>>>>>>>>           } else if (c.zoned_mode) {
>>>>>>>>> -             c.cur_seg[CURSEG_HOT_NODE] = 0;
>>>>>>>>> +             c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>>>>>> +                     c.devices[0].total_segments : 0;
>>>>>>>>>                   c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
>>>>>>>>>                   c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
>>>>>>>>>                   c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);

