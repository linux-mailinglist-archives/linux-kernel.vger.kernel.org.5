Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40817BAA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjJETfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjJETfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:35:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1BDB;
        Thu,  5 Oct 2023 12:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKAodqFyc484VSKKdNf7LFOxHtZ0GG4bz32n2Kf9peU1cM8b+cGkABJrRqku3rCWt+mc9PO4DOthutPeehR/Ya1EEzL1vtV/sRQv0xxsb5/OwaAQcUcrPpUfJjxuTEYBQiW1BRt2KIYqvXg4AxjmtYHJodOwXANIhW//L78bpWASMw+NbISlpNY5CkFVPvLiR4SxtJV9lnFPZR4tm5MidrQmK/rlaVoIhViLvCx6ZGXlVUUDGThW5ZgnL7cQvRWXggLPjjSfGYrDOOiFSUessOxmonqF06lxxWwLJP4khOgJymfIoNj7sTw8xSU7bhl+71tF6qQJyye1Z9zWRb3rJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xghBELYAjpDis2PtPUbXCIj9Gx2BK7QPaWIBxOX+J9s=;
 b=Mune3fW/RpXpONt+jRWZLYSwnHqyYlYOHir0O/0OQ/P8qqSNRn4mzWOPEst5KhG0QLnTPdXIhE1SaytYOtxhs6n0NY4Z5lUgHwnXZxjZU81U30S7DnNl/j1C96P2Y9DkWt8SCQCyAJvdIptpDA3IXFpFjePC5/c5m4gwblkF4LqhZd/ZtgYMop+4RUIOhDb5cmMa+Y1XydoypOEHfHSdA0ZzNI3+MCOkD2oTTbxN/fz+Bk+EVS5y1K1nKL1vNiTYGuB+1xm0l3XMG+zBL60QWhjENr2R26N7nw5RSnhezg1KJqvFfBKza1EJZXgcUVGQcXTfbs1SWqLWXlurIxWPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xghBELYAjpDis2PtPUbXCIj9Gx2BK7QPaWIBxOX+J9s=;
 b=RA1KXcFc1qcs3lczpBk/p1HinqzdRHxLowkU16lS5KylDt9wep/5WpJXTZnb3UeDKNcCS9G7t6GSft4R/ypLmPccGiVopoBOnGw9TM71oq3qx57hog5zpn21kPALo5SssY2KhZxXHxkmGuUzesUnIBeOdfqQpi97LbiuRwOzckMI1zycyIf6vUdHXl2Mux841JQ8FsXt30x+YDF7A5md/HY7YlAVEhWelx0Xe1oZSC0ARn82w2+DaRxRquo4EjbsGQ7aYpke9WTAj1p7FsuNpvFa4Qs3Ps7dfn90GeQySx8v9b85awcS2v3pSNMKzPK1xihBnmpbZrsg9zmu1bbiRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 19:35:43 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::8bbf:3b92:2607:4082]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::8bbf:3b92:2607:4082%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:35:42 +0000
Message-ID: <4d025b89-fa7a-df4b-37d0-96814a2d2bcb@nvidia.com>
Date:   Thu, 5 Oct 2023 15:35:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kuba@kernel.org,
        Bodong Wang <bodong@nvidia.com>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <20230723053441-mutt-send-email-mst@kernel.org>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <20230723053441-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:805:de::28) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9291253b-07f1-41c2-ed5c-08dbc5da436c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2RyMrc29EMSUxlqWdlOvDGIlPfGfCxmjJrDQjW0E4SUgEfQ6YZo+WwTThtvSTbAJv2Z4naSDRX+hGTcw8wh040TxBm83OhwMLQHb9FHfRWgf7onkh84cEvH2ZYgT5lHwAmaqZt4hWzLYsSrER9nZ7zbXW/pM5PF3NHgE05OA+u/mf2ymP8tukYW7wHBjsUulNeIk7BgLcfIsoHRsGKC253xKk0ezsQtvRkt3dfCmyddXewfqHWmQFAvU3Qk3LJhIxilVLEMZn9XRg8dgwxYaKYPKEOpqcVwbmI1x1sy/tsOe9J2v/q1kWPEsd49/0ef58uAF2YRRI8ei8x1cHEw9glNy7Pa24VGjpTDVQLtS7pbsAaoJqYbq05uVtJjUCilkXICFKaxxDhgnAejsMPoX8Hd1cvBE89gv+EmDSk5VK760HWUeT55tr1RI/AGPDWFC9Nf9pLE5cD4UXPpSiLJQGStfF0qyxer8jAAHjODFaCSNnOLeeQUm/L3OG94Th8chHW85z3rxvzkNQx0sjAAkbOApG/01JZt3RONVqmFmwuUOi46mh+kt64llvbQbPYvLd8LdlzfRFs37jtfH3oHzg7fvZXsyuAmmW8lCQkSu03KepQl6YtLs9KMjT8cfmOd5Z1GcSpeLXoLWBDWNDdha1FZvs6DZFecd/rb7dtEPDanX2QNna0CfIFEJ9uO/0wo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(8676002)(4326008)(26005)(478600001)(6486002)(966005)(8936002)(107886003)(66476007)(316002)(66946007)(2616005)(53546011)(6512007)(6506007)(6916009)(66556008)(5660300002)(83380400001)(38100700002)(6666004)(31686004)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG9GSzhDRW5tTVpObjFUTTNyaHhwSk5nTXFvazZsTlB5WU9IZkMyejN6aEdq?=
 =?utf-8?B?ZWsrZE15anF1dnFVcExTTExxRjY5N1ZxYzE4MzY2bEFLLzRWNjNlWnJ5R2tM?=
 =?utf-8?B?SkFiTEdSSjhIZ0t1TnE3enB2V3hFK0ttZHg5cDN0TmlpekhhYUUyTVdJTTZB?=
 =?utf-8?B?SVFVRzI0NFRPMXZxVkFUNnNQamdkcUNjeHRORWtSUzZwVnozUkNMQUdmWlc2?=
 =?utf-8?B?OGhkRWZHcGpTeWhkRk55VVNBTXlYK3VpR1JuYjlrdGt5OEJJRzNhSW8xY2lY?=
 =?utf-8?B?dDAxNVFjbGpQK3VLd0lMOFFRYnpLcWhMaElPMlAvbmFabExpalVBUFJkaEcz?=
 =?utf-8?B?b3Fzbk1zREtyQjgwWFJralFLT1ZDOFNSWDdQYVgzbUt5MG9XV1NtRjRQeGpo?=
 =?utf-8?B?cFZZR3V2WnpNWThYN1A5OXlaNEdnemg5OE5mRzZUQWljUklYb2xRaVVBQTBz?=
 =?utf-8?B?S2VsVitMRVJOZVJFZWV6dmY3cTFTZFNZTytWdHBQcTI4aHY2RThoSEZSTXgv?=
 =?utf-8?B?d0ZHdm1zM0pGRFYwUnlwQUJQYVE4R2JlNzAwL0oxdzFJaU1yQStUUXZwU0hE?=
 =?utf-8?B?QU1Fc2hYcTkvMkEyMzJhVWprQVdrOE8zeWFJQWs3QS9tUUJRM1FhYll4Z01j?=
 =?utf-8?B?U3MxRENOSXFCVmFiUGRYV1Z6OXJoV0E0aUN3aHQ5dmk4UGd0eGxSaGJacUMx?=
 =?utf-8?B?RS9pUW81Q0thZ3k5RkwzZjMvYmhFTnFTdDFiT3BsL1NQRisyWFpzc2hKV3Jo?=
 =?utf-8?B?U01zU2t1STAvSjFON1VkWExJN2xtSWl5OHkzVnQvR0c2SEpqN1h6cmw3NStG?=
 =?utf-8?B?aVhEc0RrZ2xUaGpNSzNPUnlhaFdNSEFDWDcxUmRRbnBuc1p5UFBEVFEvclIx?=
 =?utf-8?B?MkZCMnV0YWh1T3k0dHlYZzZTbm1VczlJU053bjhNM2F5bFlTVnFiYnRmcmJi?=
 =?utf-8?B?ZzVjQVFYTkZlNVRHaDFjdCtlQk5TU2xqUi96SE5Va2R6Z0FxMGtoVXluczNM?=
 =?utf-8?B?Z1JNQmJJbmYyQ2E2Z2pNNmQrN1g4cFpJNTlBdDQwYjVaT1c5YzJscEMwRmoz?=
 =?utf-8?B?emI5WmlRMndBSG1MYWNBUnJ6ZWJBMkxBeEM5U2NwS3pwdzloK0VIdWdFVW1t?=
 =?utf-8?B?Y2lHU3lTSFBBSnlQY2M2NGV6QTNjWWQ4RCtFVVhtSjhURjdVZ0FVbkZGc3ZO?=
 =?utf-8?B?UHdBUS96OU16NEZxbCs1NU5hSFE1Rkt6TjkrZW40SG5LNkJsRjlPN2laczVz?=
 =?utf-8?B?VFQxUGFLVW5FL0hMaFFESCs2Z3EwRVFERHo0c29wT0JndXpIelJucko1SnN1?=
 =?utf-8?B?VHRoT0JMSmU3NW9DVmRaWDl6OHp3VS9DbnBGRldFU0dCTmk4bW53ZlZMVXNa?=
 =?utf-8?B?eDd4cHhVZjlUYU4zUXZqRjlQWXF0bE5vaTdpMnIwRGs0VDFmMS9tb2ROZWli?=
 =?utf-8?B?eHp0Ykp3NGVYamdUdXl0VFliQXRUMWY1ZkRGRy9iQklCakZ2UXkydkxVMGxy?=
 =?utf-8?B?NGRJSkI5WG55UkNMY3VTbk90bnNjZGlmT2oydE4xdnBjRFdnMG1FWkd3TE05?=
 =?utf-8?B?b0dOekI1WDUyNXB6aTJxNnZjd25YTzR4ckRIcG9rOVpNeXJnY1F2OXdvUTBL?=
 =?utf-8?B?VVdodE1Gbk52QXpWdVJsK3lPMkpydUlyeHhZRGNJTnhaVXJPRW4zWFVZYSt6?=
 =?utf-8?B?Y2lkOGpEUzRlZUt0Q1doSjV6SVBFbWNqS0JrcmhKbWcvY0JzMHBWbUJjVVRo?=
 =?utf-8?B?NFBIZWpJQWZtcjFvaHlEd25QTmRIbWwzQ2RWYmx6WGN1SzBmaU90RTk4Skg4?=
 =?utf-8?B?YnNubjRlZE1kT0NVUU5pZnhOT0RUSmpWQzVERmR4bjhpYUhOa3Z4UVMxZ2I3?=
 =?utf-8?B?WHFXRUhmR2tlZDBkODM0M21nWmdrL3BHcE5wWXp0NjlBY3VJbWE5WFRUa1JI?=
 =?utf-8?B?eHllMzdQU3FMYjBJVzZFTnJ1cWp3dFpQMDVreSt1aWpoOUhsZkZmTzdla2tO?=
 =?utf-8?B?S3lOcEljTUdQRWh3L2FGNnQwcXdxRDZlVVFFaUFUQ05jMndPQWFMSWJ0blJv?=
 =?utf-8?B?eExTQzF2TUgyV1JhcWhSSm5ZV1pFd0lCZTlRaW0vTjdSWTI5S3c2U2R0eElM?=
 =?utf-8?Q?D+8oPd8tLBiCMCpjyZltZT6JH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9291253b-07f1-41c2-ed5c-08dbc5da436c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:35:42.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNdG2fPL130YTEC5tclus1JfmffT4dayGrRo9pCWnAFZuWP7V6zpZzFDKsbnFtDr95HCCk8+pQSNWXJk1+Iajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-24 a.m.2:46, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
>>
>>
>> On 7/21/23 17:10, Michael S. Tsirkin wrote:
>>> On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
>>>>
>>>>
>>>> On 7/21/23 16:45, Michael S. Tsirkin wrote:
>>>>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
>>>>>>
>>>>>>
>>>>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
>>>>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
>>>>>>>>>
>>>>>>>>> Adding cond_resched() to the command waiting loop for a better
>>>>>>>>> co-operation with the scheduler. This allows to give CPU a breath to
>>>>>>>>> run other task(workqueue) instead of busy looping when preemption is
>>>>>>>>> not allowed on a device whose CVQ might be slow.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>>>
>>>>>>>> This still leaves hung processes, but at least it doesn't pin the CPU any
>>>>>>>> more.  Thanks.
>>>>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>>>>>>>>
>>>>>>>
>>>>>>> I'd like to see a full solution
>>>>>>> 1- block until interrupt
>>>>>>
>>>>>> Would it make sense to also have a timeout?
>>>>>> And when timeout expires, set FAILED bit in device status?
>>>>>
>>>>> virtio spec does not set any limits on the timing of vq
>>>>> processing.
>>>>
>>>> Indeed, but I thought the driver could decide it is too long for it.
>>>>
>>>> The issue is we keep waiting with rtnl locked, it can quickly make the
>>>> system unusable.
>>>
>>> if this is a problem we should find a way not to keep rtnl
>>> locked indefinitely.
>>
>>  From the tests I have done, I think it is. With OVS, a reconfiguration is
>> performed when the VDUSE device is added, and when a MLX5 device is
>> in the same bridge, it ends up doing an ioctl() that tries to take the
>> rtnl lock. In this configuration, it is not possible to kill OVS because
>> it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
>> net.
> 
> So for sure, we can queue up the work and process it later.
> The somewhat tricky part is limiting the memory consumption.
> 
> 


Hi Jason

Excuse me, is there any plan for when will v5 patch series be sent out? 
Will the v5 patches solve the problem of ctrlvq's infinite poll for 
buggy devices?

Thanks
Feng

>>>
>>>>>>> 2- still handle surprise removal correctly by waking in that case
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>> ---
>>>>>>>>>       drivers/net/virtio_net.c | 4 +++-
>>>>>>>>>       1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
>>>>>>>>> --- a/drivers/net/virtio_net.c
>>>>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>>>>>>>>>               * into the hypervisor, so the request should be handled immediately.
>>>>>>>>>               */
>>>>>>>>>              while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>>>>>>>> -              !virtqueue_is_broken(vi->cvq))
>>>>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
>>>>>>>>> +               cond_resched();
>>>>>>>>>                      cpu_relax();
>>>>>>>>> +       }
>>>>>>>>>
>>>>>>>>>              return vi->ctrl->status == VIRTIO_NET_OK;
>>>>>>>>>       }
>>>>>>>>> --
>>>>>>>>> 2.39.3
>>>>>>>>>
>>>>>>>>> _______________________________________________
>>>>>>>>> Virtualization mailing list
>>>>>>>>> Virtualization@lists.linux-foundation.org
>>>>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>>>>>>>
>>>>>
>>>
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
