Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE55751C40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjGMIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjGMIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:50:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9427B2D73;
        Thu, 13 Jul 2023 01:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US2G0/vkzjwJtmrOHVCGMFq4QESk/xm/J0PfROPmGnKXYqwGqBfXNH4BLbj3HxgAvc94e+XMVgOy+F4C+Ov+8ah/4BMr3RiRU+VNVf0289F7G5s4vPK/LvdzwhqgPitc8adDUwdCEd5LlPt8SMwfFzQHvMayjlHWGZdwiVWNeZHfjrvrv+PiAaHgvtnbpJw2hCrEGajoQEzv9Yqeb70Irp+IqLa7S9X+mkLUp9WBperYMAn3ahdL0em1UsTYPfMqg3hktHUV1NQj4iKtIIVSFh4OsGvPuM5Cdq3HEKpiFko9gKCCxPSnHbceBxL59u39HbGhqO6M/2jJCZq5KTIr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs16/0/fftcDctaR4ITkt1pnH06KMYUAw4LbOx9nuNk=;
 b=m4N8IeGGr+TXAGfM9j/eBhCnXwJSuPC45vNQQEdi0bCWs45Y6MJVcAxF9AxixCoRhZIRJoBcyg80dsSCjh+SolgVS7ItyfwDvHXJFluVG3KyLKXbJ+8p4MuGI1KesNvOMADlcmeWFAa528HMvvepPphuYD0txvWFWQt4i1S3ZpmQXBNGCh2FuE7KaxynoHOKh3OkMrGrGMHPH48A56bpm2Yy0CmJpF5lZeXVlhZrzx3KHHpLZrg9dBP4xklzC20ncOJ9gDlN8SslhggWj5Kztoa/EZCYpPusZK8dkhKyA7sMjn2wEZUYaBdckTUoGZRDwpy5vOfj+hVVIBFaPkrBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs16/0/fftcDctaR4ITkt1pnH06KMYUAw4LbOx9nuNk=;
 b=CV2wmfVSKzq2lfqwJ1OJWGYtOxZ2G+d2NE9YS6+E1EkrAaLegOpYy12cFPh5FMSlF9KI7+8OMTJRUymVYaPXU4MJhinAitErhMthp4i48hu+9p6l2zRfhGp6tJSxbmp1hvRj9UuztlvQRQ6N9ptmbbX69BmQmtxsgCuIklVtnWBYEidVjfrVTUohGk4a7wzopgeXqWJJOsHY810foRm0GCuXYNB3q4wS9s+r5/cYLhjp03sMLhUp2XHQ7uUbBLBqkeWXmp66wctmVOqvm6pm9CKAkfRSfgg7hUR/2NSmjBkf8EzHMLoKg2HIb/JLvuh6D7rN5CWsd6uoQBJNjLa8Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:49:40 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9df7:40a:ebff:8332]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9df7:40a:ebff:8332%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:49:40 +0000
Message-ID: <bd7c91c4-9528-aaeb-9789-03191dc7761b@nvidia.com>
Date:   Thu, 13 Jul 2023 11:49:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
 <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
 <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
 <6fa5ec73-e6c6-cf8e-b11f-1a57f0fc34b4@nvidia.com>
 <95210a8a-c70e-c312-2c47-4f5ee9329586@suse.de>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <95210a8a-c70e-c312-2c47-4f5ee9329586@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::25) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BY5PR12MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbfe983-5137-4056-543b-08db837e1876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNQU+YGh2Mf6fTcPdGIiS46yZID+SFaLIo9RtuNnTDx3M7Wa+2c8uTmUR4SAeGy+FK7uP1l42Dx9uszsBjKDNnuIcTcNQG5yYuI0TAeaLOd7cryA4mdJT887IgC3w0bXEFiwmzrtFETPOQRsjLjy7jaeoGznfcaUa2ecKJAtJBqUNIGTSl7nyWIEDIBkJGgsA7xae8zD/GQdxiDyF+VpajrcLhH29JWdYxq7rcsKBRpMb65CHBdd+1YFJ5Skij2bYtdh6vljLKRw0sMPCvPPqVTEyHar0JYa4FMzCzLa1xupVltgkz7J0WFovEZAO6mKBldVJMMjGobCWWNyt7QJZ2J5zf4csZ1AQWlH4e3lIGrH7/vqo6r+0xLEq3kyVGclLg6J36XSJrZYs5GE2QROAuc9Mtl/qmYqzqqdlHAmGOTfUviSEnhaSexNlHnLUgOcG6X3tfMmqNKYU8qCkiiqBt0IRrCQvH1sHmlcBVow8bA/SxPuPws79Sy+t12VpcWyMMMyBDhHjxJWEyG3BGWuwCZ3c0ApD+MevtHUIoVlyMtLlwB3nDRV/vt+L4DggLDA7IvS/RdSHmTkcLlVjUJ3sQIi5z1eNiEg0iN1Y9MmwNe6ggAW4wGcubEWxADzoBso5N+HWwOmoItbt5J5SdMTOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(38100700002)(86362001)(31696002)(36756003)(31686004)(66899021)(5660300002)(6506007)(110136005)(54906003)(6666004)(8676002)(41300700001)(8936002)(53546011)(186003)(2906002)(2616005)(83380400001)(316002)(6512007)(66556008)(66946007)(478600001)(4326008)(66476007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ZiYkFnZ0tjVzRwYkluMDRxQnhtRlF3RVRMR1VVbk9CUTBGUFpIYzFMN25D?=
 =?utf-8?B?aGlucXdhRno4d0NKdnNIMTdLTTRiVk1OYWFhOXlEWE1waXMzZUNZdkIxTUNx?=
 =?utf-8?B?Slg0aGJvdWZxdCtMT1J5VEo1Q2p5enhEdzFlSkxaK2F4eWI2dmtVNWxMU0hv?=
 =?utf-8?B?L1FEOVdmaDlkOXBHV2FVcmROblQyL2Vib3pmSnZKL3B4dGNsUzR3SnpFak5O?=
 =?utf-8?B?ck8wU0Z1bWF4MDNDb1paa0tvaUxNMDFLcC9JOVl2SithcGZQRUJhR1dsQnJR?=
 =?utf-8?B?enlYMUhCNWNLT21IOFM3c2NHaDlQQ01NMi8vUWsxY2hJdDdtaUJabFlXWnVt?=
 =?utf-8?B?TVY2a1lFS0ZyRmNVQ2htbCtIZ3IzbUlZbXBsd0tTYjE5VFlkcVRHdzRsK1d5?=
 =?utf-8?B?ZkxxL09VcHFoTm80VzZHWmxVaTNxaU9FVmRuZHFydWR2Mjc2VlFod1RyT3Zn?=
 =?utf-8?B?WDM1eDYzbEhPTE8zVGoyZUEzcncwVE1TS2EzYUZqUFBoR0luVGFxbDlCNlI5?=
 =?utf-8?B?SHoxRnRycndxeXh5WVpLdzNvWnN0R096VWk1Y0ZpMGowL2lsWkw2NVNrcUxE?=
 =?utf-8?B?RHhKa3RuN2tmMVU5SmgwTGlFdGxzYUN6NHRoNXlXUkhYZHo3d0JkcWpwRkU4?=
 =?utf-8?B?cjNQMklEa1FBd0wwaUFmVkUvNENPNFR5eFJDWUFKMjFYZ2Mxekg5ZHdQSmFi?=
 =?utf-8?B?ZHo2NFFIOUpBS3dEL2RIRVBraWFYZnNKVVlmYjhwRGwrcnR2VUJqcnZqcExB?=
 =?utf-8?B?akRUUldWSU5Jc2J3TngxV25ha2tBMjRiVmdrV0NCeGFVQ3JYdGFsZ1B5ZTJk?=
 =?utf-8?B?Z0JnVzVia3RMeDVtN3BudHhFakF1MUNQc1J5QWdLWWpsTlB2cEVFUm5rMndZ?=
 =?utf-8?B?dGM5VmdZMFNVOHNndm0xREZuQW95a2wrcGdjVzByK0VUZElOT0VIaGdNVHdt?=
 =?utf-8?B?M0c0UmF3MzE3NzJRa1l1MXpEU0xPQi9ESENWTE1oUXBoMWxuaHB5Q0plTmJu?=
 =?utf-8?B?NmE4aWlhcFdKQWZ1OGRkc0Q2T3JhK25rQU01V1llU3ArcTB2Z1lhMm1ycWVh?=
 =?utf-8?B?SjZzUVRrZnk4RW85aE1DbWg3R0xXekFWdm9VWDQ2REFKakViTEZOaDRSVm5k?=
 =?utf-8?B?M0MvZXN2aU5MOUo4NHNkeEtSKzZxcHZlWDNNOUFlNGN0S1RMMjEzQWlZdTdS?=
 =?utf-8?B?YUpROFBzanF6OFIydnVXSlhVb0wyU05VRExNRlJSRU5iNGxwajFhOGovSFg1?=
 =?utf-8?B?RDJYV3V0OUVubjd4TXUwRkx5MnoyOWQrYXd1bmxWUVhnVUMvS3VhNVk3VUJp?=
 =?utf-8?B?eU1WMWFNUXNRWVNFZVo1blgwaXdzUWQ0bGpOVHR0eVRmemFjWDB0Zy9NSkVo?=
 =?utf-8?B?NHd2K2FocUI0bkFnNU9QcUFTUnVHMmluenAxaXRVdFlSMmJXN24yTmphWjZB?=
 =?utf-8?B?MDkwMlJSQWhYdUcybWVCRlE3WU9QVHYvODJpcS9ZZXRxeWJMdDBBM0lkWkJl?=
 =?utf-8?B?MFRsdnNtMG1yM1RSTDQvVVYvWnhhWUpnNGpSaG5CTU5sSE53aXh4SGFRczlp?=
 =?utf-8?B?dHpaeFBZR0x2bnU2aGJJR3o3bFRrTTIrTlNLdzJGa3ZqeWc1THlzdEZEMFZV?=
 =?utf-8?B?ZjlmMUVkdm9kMkVKZUVFaHFuRSttL0JZaHJ5bnpOeU80TkNlbUJHM3dNNjJH?=
 =?utf-8?B?alAxeFFPSFNCTlhMRk43UktYSHIwVXVsY1BWQkZPamN6RWRxNVdjY1AvTE9T?=
 =?utf-8?B?RTdWMjFqSVF0R3d6RStBcVFGSVMrOGVZZ21yZFpCLzhuWkFMNUpoVU01clNv?=
 =?utf-8?B?V0NrUkdrcEMzQk5LWTFpZ0JxYXdrYStSMzI1QmNWTk1zelVybFA3T2R3VjV2?=
 =?utf-8?B?V1Q3Mm4zZWxTMEtVY3JNTTlXS2I4UzJ5R1BEUkpMWUVRZDl1NEtiSXdrbThO?=
 =?utf-8?B?bjlGNHBJTGNvVUVoZUNEVXlyU3NCZ1Y2b0lUNWtMamtjd2ZkcjRQMEZmMlpB?=
 =?utf-8?B?VDBCWXA5MUY5aHR5NFNDc0dXT1EyalM3aDRWTEM3Z1lOd1ZTZmN5NG5vQkE1?=
 =?utf-8?B?eWtxT1pZNGVucGlIbDBCdThjUE5KWS83VlFiMWtGM096eGRpZGhZMDd6dnM2?=
 =?utf-8?B?OS9VSDN4alIrTk9EakNmbU1rcmFpN3JHTFo0NWJYbDRIQ2o0M1RRcWZNSEVu?=
 =?utf-8?Q?f5J4MyBaWFdSypHZWg2DIXPSJd0gq5f6iko8Fai+LxJe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbfe983-5137-4056-543b-08db837e1876
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:49:40.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZL4sLFsL3QCU/J2Ub99k6ZzFcAqBVbZpNHdM88dS03EWWcjpVvB5kgPDqR6bHj6Vt9glGsGtFOQNBqD7heg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2023 9:00, Hannes Reinecke wrote:
> On 7/13/23 02:12, Max Gurtovoy wrote:
>>
>>
>> On 12/07/2023 15:04, Daniel Wagner wrote:
>>> On Mon, Jul 10, 2023 at 07:30:20PM +0300, Max Gurtovoy wrote:
>>>>
>>>>
>>>> On 10/07/2023 18:03, Daniel Wagner wrote:
>>>>> On Mon, Jul 10, 2023 at 03:31:23PM +0300, Max Gurtovoy wrote:
>>>>>> I think it is more than just commit message.
>>>>>
>>>>> Okay, starting to understand what's the problem.
>>>>>
>>>>>> A lot of code that we can avoid was added regarding the --context 
>>>>>> cmdline
>>>>>> argument.
>>>>>
>>>>> Correct and it's not optional to get the tests passing for the fc 
>>>>> transport.
>>>>
>>>> why the fc needs the --context to pass tests ?
>>>
>>> A typical nvme test consists out of following steps (nvme/004):
>>>
>>> // nvme target setup (1)
>>>     _create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
>>>         "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>>>     _add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>>>
>>> // nvme host setup (2)
>>>     _nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
>>>
>>>     local nvmedev
>>>     nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
>>>     cat "/sys/block/${nvmedev}n1/uuid"
>>>     cat "/sys/block/${nvmedev}n1/wwid"
>>>
>>> // nvme host teardown (3)
>>>     _nvme_disconnect_subsys blktests-subsystem-1
>>>
>>> // nvme target teardown (4)
>>>     _remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
>>>     _remove_nvmet_subsystem "blktests-subsystem-1"
>>>
>>>
>>> The corresponding output with --context
>>>
>>>   run blktests nvme/004 at 2023-07-12 13:49:50
>>> // (1)
>>>   loop0: detected capacity change from 0 to 32768
>>>   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>   nvme nvme2: NVME-FC{0}: create association : host wwpn 
>>> 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN 
>>> "blktests-subsystem-1"
>>>   (NULL device *): {0:0} Association created
>>>   [174] nvmet: ctrl 1 start keep-alive timer for 5 secs
>>> // (2)
>>>   nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 
>>> for NQN 
>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>   [374] nvmet: adding queue 1 to ctrl 1.
>>>   [1138] nvmet: adding queue 2 to ctrl 1.
>>>   [73] nvmet: adding queue 3 to ctrl 1.
>>>   [174] nvmet: adding queue 4 to ctrl 1.
>>>   nvme nvme2: NVME-FC{0}: controller connect complete
>>>   nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
>>> // (3)
>>>   nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
>>> // (4)
>>>   [1138] nvmet: ctrl 1 stop keep-alive
>>>   (NULL device *): {0:0} Association deleted
>>>   (NULL device *): {0:0} Association freed
>>>   (NULL device *): Disconnect LS failed: No Association
>>>
>>>
>>> and without --context
>>>
>>>   run blktests nvme/004 at 2023-07-12 13:50:33
>>> // (1)
>>>   loop1: detected capacity change from 0 to 32768
>>>   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>   nvme nvme2: NVME-FC{0}: create association : host wwpn 
>>> 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN 
>>> "nqn.2014-08.org.nvmexpress.discovery"
>>
>> why does this association to discovery controller created ? because of 
>> some system service ?
>>
> Yes. There are nvme-autoconnect udev rules and systemd services 
> installed per default (in quite some systems now).
> And it's really hard (if not impossible) to disable these services (as 
> we cannot be sure how they are named, hence we wouldn't know which 
> service to disable.

Right. We shouldn't disable them IMO.

> 
>> can we configure the blktests subsystem not to be discovered or add 
>> some access list to it ?
>>
> But that's precisely what the '--context' thing is attempting to do ...

I'm not sure it is.

Exposing the subsystem is from the target configuration side.
Additionally, the --context (which is in the initiator/host side), 
according to Daniel, is there to distinguish between different 
invocations. I proposed that blktests subsystem will not be part of 
discoverable fabric or protected somehow by access list. Therefore, no 
additional invocation will happen.


> 
> [ .. ]
>>>>>
>>>>> It really solves the problem that the autoconnect setup of nvme-cli is
>>>>> distrubing the tests (*). The only other way I found to stop the 
>>>>> autoconnect is by disabling the udev rule completely. If 
>>>>> autoconnect isn't enabled the context isn't necessary.
>>>>> Though changing system configuration from blktests seems at bit 
>>>>> excessive.
>>>>
>>>> we should not stop any autoconnect during blktests. The autoconnect 
>>>> and all the system admin services should run normally.
>>>
>>> I do not agree here. The current blktests are not designed for run as
>>> intergration tests. Sure we should also tests this but currently 
>>> blktests is just not there and tcp/rdma are not actually covered anyway.
>>
>> what do you mean tcp/rdma not covered ?
>>
> Because there is no autoconnect functionality for tcp/rdma.
> For FC we have full topology information, and the driver can emit udev 
> messages whenever a NVMe port appears in the fabrics (and the systemd 
> machinery will then start autoconnect).
> For TCP/RDMA we do not have this, so really there's nothing which could 
> send udev events (discounting things like mDNS and nvme-stas for now).
> 
>> And maybe we should make several changes in the blktests to make it 
>> standalone without interfering the existing configuration make by some 
>> system administrator.
>>
> ??
> But this is what we are trying with this patches.
> The '--context' flag only needs to be set for the blktests, to inform 
> the rest of the system that these subsystems/configuration is special 
> and should be exempted from 'normal' system processing.

The --context is initiator configuration. I'm referring to changes in 
the target configuration.
This will guarantee that things will work also in the environment where 
we have nvme-cli without the --context flag.

> 
> Cheers,
> 
> Hannes
