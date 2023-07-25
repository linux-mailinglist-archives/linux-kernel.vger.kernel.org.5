Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAE760720
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGYESd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYESb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:18:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1231E64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7+gvPGRkK/jNe1uwlL3Z5N5mw6agSvQ83LM1orsDau7XpShUz3ffgEjPu+F1V/rJVPapAaC0uToFn/zGN81lC70AD7g/NJlwBtpaaBuSFAoF0i0p8zYcTtF8EbPwZ07UTAH2FtuAdo1EGh7ryMMwoNHbe7JKDKHBnsU7Hfvi6ijxv/6SqNUTMUFAr15Ch3IWSRx+EvDVMOhXpxryuqQU/gFHSqs8GOxSdADoD7RTlO2sOjFde5hlUahYZN4xt0tWjge0AX+m3e26HNWATr8LwcQwX7BxgtQNXJbhvlEHKgeGAW4FGvssewDRP7mdrDGxa+IBn8aMu/hvlQOkipYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+rZtYTckji8hLYuKss5BkixsMVRbimqeOgkurUK1uc=;
 b=N8ooT7sktk1cvpPI6L+X6HGma4VQWN61KcEqzcDs2bG/8+yscZG/YFRmU1ofZgUi0o8+7sWCmZRhpmnf463i1tLvaI2TctR51dKWkJp6+qZU5pVmB4tdCs805Zf9vCK0Z9mklUuoOky50fCkZcRbp3P4MBmzU97vVbmATJGXLylZWhiHS5NiWOMRwZZpYHGfHPI0+lLhD9qKH1MewVLubwlMhWDAVCVLJUehEqQjwvWubGYYT33c/yg+9q1cyFkgGnX12/06YYAx5k4u4iol+P6SEWF0XjW83vEd8vKP1cEM8eB+9RgPMiX28kIFO5ZehherFazu7IzUHjQivj4VkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+rZtYTckji8hLYuKss5BkixsMVRbimqeOgkurUK1uc=;
 b=TuJ3sHvG5qDSQFEH4J9RvvXwokwJPr16q/BSQ+p3rMt1qw87C+zfNgfOBHbGRP+M5J7Szjq+V+VFooNhJH3QlbITDADz/Czga0u6dK+/+BYcuprnCRa1ryTjbJrjuxvtne8z6YH+3LSAQl647tBE07APtQZjLX9ExXPY+2nCGMw4/Z0m4Vyv4hMVxcDRMCa1KhIAO+hdS8dZiHO4nTXfRd4J26IyafFiloqCTtRKOUXsQPxLwfdJBIkzK3vWB1dpi44AidpwbjDZIk2LTSZlZ2B65cOOECetqs3y1wBjFv27SICa96L/twzV5rGEsQ1fPwYyWNaVmY4+GU+KTHTpoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 04:18:27 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 04:18:27 +0000
Message-ID: <863c6e42-09ec-23cb-6b71-cb9bf4b564fb@nvidia.com>
Date:   Tue, 25 Jul 2023 00:18:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
 <20230720131423-mutt-send-email-mst@kernel.org>
 <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
 <CACGkMEuk2aBhnViZkAi8tbNc8AnJ1FY9uk9rCnmmiWVGwYsLUA@mail.gmail.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <CACGkMEuk2aBhnViZkAi8tbNc8AnJ1FY9uk9rCnmmiWVGwYsLUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0097.namprd05.prod.outlook.com
 (2603:10b6:803:42::14) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcd2d61-0544-4ae6-f6d9-08db8cc631cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKgNaRDPOisSAwST3QiwiZeJX3u7YAxrO74erIl4ivivYNCW+RDinBsQ223i3d3EIN7wXLaIYPq5fEHgC61gmpON/J4/uhf8hKK6Ht6/aGhU2Rii+GWGheYo92l3PBBc4r+vr98wVNU+3OjmDsmn/LIn/C6VKSddgsIRw9epnl2cZ3P4M67hYO1F1+CNXU7XMnyyDbTgOEaERCwZ/ixabEJwESUh9o9iZVuBKfYkjJJ1X6WUrdYVDsqZmz/GD1Z07zxn1PnaJMwB3ojQlL5OYb2HT+7rXtBdRia9OKmMG6quq6o2FKItrsLox7P6ARXVMlg1rNLnQND84VltgcacAbHEZNN4KY0NAxwauaqx2LvPmibbYTepYCkEG2JEAx8hTYwH5dnCL77si+XJ8vgPVmuDX1gofzlwTmjcDsntkf7kM34DN4Orb3+V1IR6KACpGzJeSeKmyXp2LqTtaMqYYf1bqUtqcla4vo816p7NaCH/kdgmvXJdvZWNseYu4SUzdoIKv7NqAArlrbujD89XLdnf8//ARunFHsdngsErqww5FWKKUBsJxX5zO8ejGydZ7GL9nE/XPB0HVj2+Dts1I/bNvF0pXnRA5TKoQp7FYhbNxXXt8Htdaybry+K/N+Vl3Ds/DFVIjbGVoj5UaMfI0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(66476007)(66946007)(66556008)(6916009)(4326008)(316002)(478600001)(38100700002)(6486002)(6666004)(6512007)(83380400001)(41300700001)(31686004)(54906003)(36756003)(8676002)(8936002)(6506007)(186003)(26005)(53546011)(5660300002)(31696002)(86362001)(107886003)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dtOHp2UnltaTl6SzdubE1vc0NUMXN0Z0hrTTY3UXl3ZEdYVW54dFlnbysv?=
 =?utf-8?B?SklQSWtmR0ZGUkcwdUFSd3c3N3dvdFlQdVNqZ3U5MS9vRElpd29vWWhTMThm?=
 =?utf-8?B?UVJ2L0pibFM1YitOd3NoYXI3d3NGWkNwNm92U21iVU81SWY3MEVTWWdJWWd0?=
 =?utf-8?B?MFhCU3ZkRWw3elRjdDk3UjhUTit1MVRPTE9vejVaREdqczR5MGx5bXdDSmFF?=
 =?utf-8?B?ZUI0ckxXVE5kQWdpaGkyN2ZuVk1ld3hlb09zd1J6dUdUTDBMVkptME1SVXlm?=
 =?utf-8?B?SERHZWdKNTg4ZC9PZjRnaEJZeXg1cXBnZmZuOVAwT2ZlbHJsVGZ1clJaZ1NR?=
 =?utf-8?B?VUpyWFRPejcyZnJzNnZrdmlnKzRNb2ZObkJHZUl6bGRxYnZWRk9aOFN3ZC9y?=
 =?utf-8?B?SDlSaGV5S1lVYzltMDAya3hhMmRLOGo3aHdYWnlVRnAxcnZ2NnRvN2JxcXZI?=
 =?utf-8?B?Q244Y0hBaUpETTlmNUg2eUNjcFRYOFB2L2Rjb1kzTHZua01CREYxSndUYVZp?=
 =?utf-8?B?SUk1eVNMMDcyUVJHUXhGQWE3djdtUk1JOXhBSVhUbk5CQTY3bWFpZ25nUzNM?=
 =?utf-8?B?am9vKzJjRHF3TjBPWmVyVzNQdEFxQTBsRUpIditqUmFKYm5BN3I4cHpEdnM5?=
 =?utf-8?B?UXM2WW5MejVJalVVc25CNzVEQ1A5VTdDaHpQMmI1WDFzWTlPQjgwdGhURDd1?=
 =?utf-8?B?eExOYTlBWWFRQXFoRllROVduMnltNDhFNzZmbFd2b1BXQ0pRWFZSSHYwQndR?=
 =?utf-8?B?d1pVbWdWSTJRK2VDWURWRU1yeU02OWpRZ1BIR2VsVlJWNmpWaEFyTVlqTUpE?=
 =?utf-8?B?RnRYSDRVcmNjR281SE91K3JidE0vcVUyM2djTHBUTUo3VDRLeWpFNFJyaWJi?=
 =?utf-8?B?dHJGMEp4R1JVTGJSRUFsRjlYdithd3V4c0trNmsvM0FFSEVUZGtZTldUS25J?=
 =?utf-8?B?MHhuT1BxUFlNRTRZUjJkWjdDRkkwamRJK2s0S0VBRi8yTmhtOVpzWkY4a01q?=
 =?utf-8?B?U09WVkRIYk1MYitQcXlpZlV5T2RLSmRKNUlGTy9YYUpRR0p3dVh1azFTUWFE?=
 =?utf-8?B?TWRsU0RpR3p6OWhwbkxlKzV0emNZVkxqK3V5dzRSRkRhMmJIOWFFSVUwVlQ1?=
 =?utf-8?B?dGNuQ1B0L1loYTlDMDNnaERPMGVUSi81YnpEeWN2V2g2RDE3b2dVNWhXMFd6?=
 =?utf-8?B?aEdZTDUwaHpQME9yVjl6YU56elNDOGl5VmhoVVM2ajY4YURpQzFNWEVBT2tL?=
 =?utf-8?B?OG16UFdzTFlUci9Rb0FJb3Zib0ozRjhxMExvNlFLTnBMTVU3TGZkUkcyV3I1?=
 =?utf-8?B?TEhzeHJSNEJsVVZaeUxrWlZaZUVOS1c5eFd0QjI0RUdPR2NyVVErY1J1N0Ew?=
 =?utf-8?B?RlR6TUp1L0h1Z3lpSHo1c1VYTmU5KzFFa1hDNU01UnoxVFdPbksyRjlsRnZG?=
 =?utf-8?B?My9SZDZxMDhIM0lHd0FBdjdlMFFUVGhFQVNCdnBlSDlldVplNlFRMktQUmlW?=
 =?utf-8?B?UzJVRlhQbzZ0clRiZDBKbTNVMkRDd1lPZEEvYWMrY09UQmoycW1IUmJ3UC9o?=
 =?utf-8?B?MkNlU2xZdXl1Mm1oc1pWbHE1NmdPTDdNOTkzdkE1ZE5ZNG1PT2tBT3p3YWZX?=
 =?utf-8?B?aFFIQ2E2YndoWlAzdEpXN1NiUEhFaTA2cEV3VGNxcFBqQlFYYlNxanZmMXJR?=
 =?utf-8?B?TFlQSTNNSnZJWVMxM2QwUVgxM09tY1l4V2JDZkppSG5mOUJRNSswcnJlK2s3?=
 =?utf-8?B?ZWpDNS9lYVkwRExtcXpPY2w5ejZzR1QvanY5NjNkbjFNdFBVSUh4Z3JqSFY5?=
 =?utf-8?B?Y3Vzb1F5ZVplQ2E1MzA4NFhGbVkzZ2xJOUpkL01kOXJSSEdVZy9LYUtoN1Nj?=
 =?utf-8?B?TVhKaDU3ck9PSk1tVDRGellUeUp3WHZ0UUtkYzFKTFg1aVBYaHZGaTA4cXNk?=
 =?utf-8?B?TWVZRHF0ekVSWDNRUHk4bFNsZ21aVnRCOHFZcUtRUDZnemk2TGdsM0w0WnJN?=
 =?utf-8?B?K1ltdlBMYlFtZkE4T2VCa2RvcC85aUtQaXhML0JMKysrSDhsanMwRkMyTEZ5?=
 =?utf-8?B?SmtxZWZpQUFoWU1HVnI1MUsxVXFBVWxqSmN2UlVUa0lLWjdhQmJMRERlNzRs?=
 =?utf-8?Q?7z2lrPPmj+LpGmlpO5/Qx4Ekh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcd2d61-0544-4ae6-f6d9-08db8cc631cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 04:18:27.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxrbkmfHli+0GIQ42QcX+88PM6jHHp90iZsf8YIEqE3KZHU7OEIx4xwbCZWwrbM/4xiEhBaC4DDpnK4vtuxbSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-24 p.m.11:41, Jason Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jul 24, 2023 at 9:14 PM Feng Liu <feliu@nvidia.com> wrote:
>>
>>
>>
>> On 2023-07-20 p.m.1:14, Michael S. Tsirkin wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, Jul 20, 2023 at 10:27:04AM +0800, Jason Wang wrote:
>>>> On Wed, Jul 19, 2023 at 11:46 PM Feng Liu <feliu@nvidia.com> wrote:
>>>>>
>>>>> The 'is_legacy' flag is used to differentiate between legacy vs modern
>>>>> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
>>>>> However, due to the shared memory of the union between struct
>>>>> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
>>>>> virtio_pci_modern_probe modifies the content of struct
>>>>> virtio_pci_modern_device, it affects the content of struct
>>>>> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
>>>>> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
>>>>> device is probed, mark 'is_legacy' as true, when modern device is
>>>>> probed, keep 'is_legacy' as false.
>>>>>
>>>>> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
>>>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>> ---
>>>>>    drivers/virtio/virtio_pci_common.c | 2 --
>>>>>    drivers/virtio/virtio_pci_legacy.c | 1 +
>>>>>    2 files changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>>>>> index a6c86f916dbd..c2524a7207cf 100644
>>>>> --- a/drivers/virtio/virtio_pci_common.c
>>>>> +++ b/drivers/virtio/virtio_pci_common.c
>>>>> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>>>>>
>>>>>           pci_set_master(pci_dev);
>>>>>
>>>>> -       vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
>>>>> -
>>>>>           rc = register_virtio_device(&vp_dev->vdev);
>>>>>           reg_dev = vp_dev;
>>>>>           if (rc)
>>>>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>>>>> index 2257f1b3d8ae..d9cbb02b35a1 100644
>>>>> --- a/drivers/virtio/virtio_pci_legacy.c
>>>>> +++ b/drivers/virtio/virtio_pci_legacy.c
>>>>> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>>>>>           vp_dev->config_vector = vp_config_vector;
>>>>>           vp_dev->setup_vq = setup_vq;
>>>>>           vp_dev->del_vq = del_vq;
>>>>> +       vp_dev->is_legacy = true;
>>>>
>>>> This seems break force_legacy for modern device:
>>>>
>>>>           if (force_legacy) {
>>>>                   rc = virtio_pci_legacy_probe(vp_dev);
>>>>                   /* Also try modern mode if we can't map BAR0 (no IO space). */
>>>>                   if (rc == -ENODEV || rc == -ENOMEM)
>>>>                           rc = virtio_pci_modern_probe(vp_dev);
>>>>
>>>> Thanks
>>>
>>> don't see the breakage here - can you explain a bit more?
>>>
>> Hi, Jason
>>
>> I also think there is no breakage herea and gave an explanation in
>> another email, please have a see.
> 
> I think I've made a mistake, the patch should be fine.
> 
>>
>> So are there any comments about this bug fix patch? Can this patch pass
>> the review?
> 
> Yes.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Thanks
> 

Thanks Jason

>>
>> Thanks
>> Feng
>>
>>>>>
>>>>>           return 0;
>>>>>    }
>>>>> --
>>>>> 2.37.1 (Apple Git-137.1)
>>>>>
>>>
>>
> 
