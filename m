Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2E77D8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbjHPDBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbjHPDA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:00:58 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1FE6B;
        Tue, 15 Aug 2023 20:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le/xzgpb35FDLKwVZKjXmctoK3ax5xC059cOhek+Uw6gAt9aWCnjh8b2PZOg+B3FEd8sR3AZcwQwB4MHXTqkIzS4JrvD6qlLJLtZwmFN1AYLyVUFtXojc3CV2okpHa5G64DWN6ouO6jij7t75n/b57bQGWMNKfelTaKxId83pi6NvjYzjOg1psV3rCPywR1iiM3YBbpdsG4rCohuuQ1DcCs9GwxSkr5j/bFzpO0fjpwbIM7zFbfhArjMMJT52NNwkhNCczd2YkYDGK1Igk6H6eRKsVUbxqtCpMQa3jImsJyQZr0drGjOfIOGbbKIrvFfuykG5JzQ4ZiycnA7q8FQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCyOIP/uyxVyZtyqLq9xfiQS29wIxXRBNMOAsqWVxyo=;
 b=lSRPo3K0FWFvHAkf9PQ66D9OtS8jAkN5mlNFohAw/XneBgaK+cJzdzxHLQEaOGUOc6SCpWAa1wJP2nYTYdzPIiLGXSKNbk/65y1aNcFWabXQaOLeKfvV8PsLr50OA4oLGr46SvrvL16VayJe2Q0KjEKb6ZGRAkr0w74REWdXvURun3po/K31EBWbGrQLhT6XeS2vXGghxd4NnUNty7v6dbHNSe+S49tRrZAIN+fUzW/OL3OhYW5FfIiXWLihNArzfDCgRff1kzB4S8Qa7yQVy5Q0PrgPhz7DlQiMSQvOmrg///CFI7tqVDCSbSCm8ukO5SE+vOIar9AjYiFyHBFqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCyOIP/uyxVyZtyqLq9xfiQS29wIxXRBNMOAsqWVxyo=;
 b=Z3Ac4P4s7ndhB6EsMpGR2p7pvYuyQRHyQgZOy37FyvXwhZJXJmQLJ9h3p/+wagMQtarAiO/FCeSCf9LMxROKN+Bj3ixcWJitRJn21wxCIVp1JvNH5NS6cGunbH6W7j4QI8c9BaxeWIHdmQfXlLdbX31BZsSkoKH0LJuGPmkQ/9CbVE1VYycvJ0h8QujVkbI6ITDOTYb9KF1hcrR/QIfCQZOdmXOteXkQIJqLPc0Pb7ekl7dgqDiNrXlhIfUw9UrUMeRDGNwZoCSGxfgPFa/hwooV78JIKUmDYT7N7whJo+94XYbvQ49r2wrt10V8YArBNHMxuAU6HIZWOezZBOvtXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 03:00:54 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 03:00:54 +0000
Message-ID: <f9f3c150-2b5e-7bd0-1c1a-062bd1f16fcd@nvidia.com>
Date:   Tue, 15 Aug 2023 23:00:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to avoid
 typecasting
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Simon Horman <horms@kernel.org>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230814171845.65930-1-feliu@nvidia.com>
 <ZNtYpohWyjnb883M@vergenet.net>
 <05348d62-586c-4b1f-40bd-5541caca0947@nvidia.com>
 <ZNunz1hbqPKpcOgA@vergenet.net>
 <CAF=yD-L+d34Uuvt3sOFOnxXhMmoMXNfHzcaSPk=t1PtiPUHZ1g@mail.gmail.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <CAF=yD-L+d34Uuvt3sOFOnxXhMmoMXNfHzcaSPk=t1PtiPUHZ1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::25) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: d6118c14-2cc0-4dfb-575f-08db9e050182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MhDqEIcGc9ltMPSS9IHEZFS7zoWTyjUpbTBTS5NjaUf7CVDXeG/wlHpTiY8jnbgV+BxnqBZlpMSyPaJ6anqRpaZkhEgk4OLc9oi+79TDmN4MIiaVlWBIbrIiKF6jVXh1ZePHwbNJxSsDZpXtPoRv/NrTJmxmuMsHAYadBtZMH1kiguYe+1RV3eeoUL/vG8a+SGCAy4KBivqPpQ+4EPsBm4Z1RXMNKgTMUvgc++jkkefrbU+A2uR7BaKbE83AVHOALjy1XHN3RaMQgVAZOVB9TCnJTTvH5bQ2/kFH5LB2N7GTrf1dt0HICb+QMJlpSPuCRYf/btg3Ac7xqkjnmFH9LwEOfj4j4zEYQPMAI8snMwSXHcGEcKZARGJ8UEV6P0CBDT0qlCOhLK8iH5giqETKzrZ4D0T4HD80EPncdL7tLPc8OIZslnJf4kbVKEAMYS4GczzLeNE+wn6KTC1aUvusMJBu4QRTHB+DXoW/yVikeXdgtPXNLJZw/vVrjAgoRftvULbrSMQvcoQlQr3/twO35ioreL7AEVnFzv5pQPGeJqfrYTn5krunjtpuwOXcZjZ05ehsKW7VKxevXvANOEuxttATrpMqjHhqCbWzax0cV2HJB4yhgu8fH57wgVilpGgXz0awADCohInuAF2xjpDjLZPpZ4AHnKG8lxkXVG3bnNCDwLsoQfAB65658RDJ5TB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(54906003)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(966005)(26005)(110136005)(7416002)(5660300002)(2616005)(83380400001)(41300700001)(316002)(53546011)(8936002)(4326008)(8676002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJnYWRuYWR4RDJsN3ZMeW1zdkRQSEluK2VEYW9WSS9Ua1NUeTIwQkZVN1Zx?=
 =?utf-8?B?bHhHOFlvOWI5ZkpiVXZGRnQvVTlzVGEycWZFbmNPZ3lJL3N1UWZKa1ZQNWRy?=
 =?utf-8?B?aFdVcVdDRHd5UlVoNUtvVldzckVNRFd3SkFYZWQ1TE5CRGIxaFkwTG1qK0RF?=
 =?utf-8?B?bmFnL1FTQ3dveW50ZXgzazR5OUo0NDdaN2xLMmxiWU9iZjNWQTRlU1Ribmox?=
 =?utf-8?B?UzltTTdRazlNcjUxNkRhVmY0cGMvWW5CdkVUSjZDUHRES1NxS0Q2RlJwMDZa?=
 =?utf-8?B?SVMrVXRaQ3pRR0VNZTZ1QzRjcnZkeTJlU1p4NDBXdUJpU1p1aVVRUTNkVWda?=
 =?utf-8?B?eUdwS2JsZ0ltMklBVUdYSjJSSkd4THlQdDFiNmVDWlVMTW1VbFdlQkU4Sit3?=
 =?utf-8?B?SmxjUTFIMjVWVUFrV080YXQ1MEE0YStVbFI3QlRpM3FHYTZsUGpaK1F4Mjc2?=
 =?utf-8?B?b0tNcWhPWmdscm9VOTI5cGNwQnZISTdQc0ZrYVcrY0xweWRpWXFuaDZYMVJK?=
 =?utf-8?B?VW5UdUpKaGtlNEJTL25qSFpWcG5xMXNBdTlKRlQwZi8xTlRsc3N4TGVUTXVQ?=
 =?utf-8?B?elhoT1BJKzRiTnR5Z2hqOGEwTU1iaEtCaU1wMG84UkFqZDJndG4xYjNDQVIy?=
 =?utf-8?B?OElKVmN2Qmw3MVBWcGlZbkgwbkZmTFJveThhcDFrQUZnMDZnY1NudHluSVBK?=
 =?utf-8?B?TmlndnZpcEpwdUlyZklaODBScGpydmRWTTE2VkFNYjBxM1k4YlJ1RjhUc3c1?=
 =?utf-8?B?WXJ1enE3OHRBNnR1bG92R0ZxbHo1V0d2N0g0V1BObExpSTNzcVc2NG0vV3E4?=
 =?utf-8?B?dlRwVmFMNlR5VFd5dXlrem5TdjNMU0hPazNqc01CY2UrUW5xSmNoTjl2clJV?=
 =?utf-8?B?VGFtSGkrR3hXdjFSQ3huNTZQM045NjhBYzlXUWZoOTh6cW9lSldUMEdGQlht?=
 =?utf-8?B?NjAvVEI2ZWxWVEFhMmZkOXVBb0UvZ0ZVZUY5MG9sbDhETVhYUFJyK1AwdUFa?=
 =?utf-8?B?emtSODZZbmZnY0Z5OWY3UWs0VE9rNDF0eHF3QVhsUGFiMnBuSndoK0xNc1M3?=
 =?utf-8?B?UzFEWWp1SWZiV2xBcTlSaTBKZjJPbGVSNVkrbExCZE1sUkQ5QzBzSXltNUpz?=
 =?utf-8?B?OTdCV1lhai9Mclg0NUZqSEMxUzNlWWZFemVLRWJhZTQ1Tkh3NDF2TFRHNGEx?=
 =?utf-8?B?NjdpMGM0cEF0WlhGL0VCTE56YlI3SE5aUjY2U1dlSEEyeXIrRHFRV0J3WEoy?=
 =?utf-8?B?VVM1UDM5ZWp4N2krWm1tNXNFc0NSbUZ1b1BNdXhPWXp3MXpKelAyanBXZkU4?=
 =?utf-8?B?Qy94QVZOK3poYnU1c3ArTmtYV3p5NXVKd0ZDTWpMZGVTMC9KSDZpSUxCVmY3?=
 =?utf-8?B?YlZsQVpCWnpwSC9HUFVQdVZUVHhIZUh0U0k1UkNZTithQ0pOYmEvNUErMHk0?=
 =?utf-8?B?bitUOTEyOW1Ba2JId0hjR2lSeU1VQ3J4ZlpNeXoyelhDdTNYT1NJTzAvMTBP?=
 =?utf-8?B?aW5YbUNKcmFaek9jbVgvd1ROWlV6WDljdnNTU3BId2JLRXdwbjZySUZKaHNR?=
 =?utf-8?B?RkpEUW5ydTE3Rm1pY2lSTGJ4TkZsc3BabFluMlJ2RjdsUUgzdXdmTkgrVzVm?=
 =?utf-8?B?NVd0UE1jalJQN0VDbTVOQ2dpNW9nZWFYeU5Kd01HQUFVY3NEcFdRdWpiczZD?=
 =?utf-8?B?elpZSythS3o4a1laK0J4T0hva0pXTGNLYjdIOHIvSy9HbmxUcjR4R21UdlB3?=
 =?utf-8?B?T0pDTHEvd0FpamRRRVZBdTB1NDJmTURocnhaNytYUGhpZFFpdEJmUTJPSlZh?=
 =?utf-8?B?MlREUGQxakhKWDdKbEtoM2dPblVNbGZ4aUJoejJpYmJRMEc4SGNOM2xiV2tB?=
 =?utf-8?B?WGovNE9Rd0ZnK2NvTllCaWVtNm8xNE1VZ2F6NktnVXd0UDd1TGtDVFlkYTdD?=
 =?utf-8?B?RTVOWTJtUXBRVCtSRFJzTklPUWhrSWhzY0piZ1dPNG1Jbzhhbm1GT3dadlda?=
 =?utf-8?B?UXJTbnZIVlRXM096Q1B1cHNGQVpBMEd4dDdpYnlWbGVTVEMvM2RBWUx5SlJ4?=
 =?utf-8?B?ZWVQakFtL043S001MTVrSUFtVmdZcEt1VkY1elp5bmlxZkM4SnpOdzQ0Mkxv?=
 =?utf-8?Q?RuIwbAswTyz6jTa+CbOkffEYc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6118c14-2cc0-4dfb-575f-08db9e050182
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 03:00:54.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXFke1T6OW4te5BenTAvAH9WCARbRsyWc1l/AJ6TITqjIIKfsYNurxnj6mCiN1+Gk2r++gWUp2RvsjZz92om1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-15 p.m.2:13, Willem de Bruijn wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Aug 15, 2023 at 12:29 PM Simon Horman <horms@kernel.org> wrote:
>>
>> On Tue, Aug 15, 2023 at 11:09:02AM -0400, Feng Liu wrote:

>> To clarify: In general new Networking features go via the net-next tree,
>> while bug fixes go via the net tree. I was suggesting this
>> is more appropriate for net-next, and that should be reflected in the
>> subject.
>>
>>          Subject: [PATCH net-next] ...
>>
>> Sorry for not being clearer the first time around.
> 
> Right, this should go to net-next.
> 
Will do, thanks

>>
>>>

>>>>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>>>>> index 12c1c9699935..db40f93ae8b3 100644
>>>>> --- a/include/uapi/linux/virtio_net.h
>>>>> +++ b/include/uapi/linux/virtio_net.h
>>>>> @@ -201,6 +201,13 @@ struct virtio_net_hdr_mrg_rxbuf {
>>>>>         struct virtio_net_hdr hdr;
>>>>>         __virtio16 num_buffers; /* Number of merged rx buffers */
>>>>>    };
>>>>> +
>>>>> +struct virtio_net_common_hdr {
>>>>> +     union {
>>>>> +             struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
>>>>> +             struct virtio_net_hdr_v1_hash hash_v1_hdr;
>>>>> +     };
>>>>> +};
>>>>
>>>> Does this belong in the UAPI?
>>>> I would have assumed it's a Kernel implementation detail.
>>>>
>>> The existing codes, virtio_net.h is in uapi/linux/, I added the new
>>> structure and followed existing code. My modification is related to Kernel
>>> implementation detail now.
>>
>> The header you have modified forms part of the userspace API (UAPI).
>> Perhaps there is something about virtio_net that makes this correct, but it
>> seems to me that kernel-internal details don't belong there.
> 
> FWIW, I ran into similar issues before in a draft that added timestamp
> support [1]
> 
> If we're going to change this structure, we should do it in a way that
> is forward proof to future extensions to the virtio spec and with that
> the fields in this struct. Especially in UAPI.
> 
> Is virtio_net_hdr_v1_hash the latest virtio-spec compliant header? And
> do we expect for v1.3 to just add some fields to this?
> 
> The struct comment of virtio_net_hdr_v1 states "This is
> bitwise-equivalent to the legacy struct virtio_net_hdr_mrg_rxbuf, only
> flattened.". I don't quite understand what the flattening bought, vs
> having struct virtio_net_hdr as first member. Another difference may
> be the endianness between legacy (0.9) and v1.0+.
> 
> Since legacy virtio will no longer be modified, I don't think there is
> much value is exposing this new union as UAPI. I do appreciate the
> benefit to the implementation.
> 
> [1] https://patches.linaro.org/project/netdev/patch/20210208185558.995292-3-willemdebruijn.kernel@gmail.com/
Hi, William and Simon

Thanks for the detailed explanation.

I kept virtio_net_hdr_mrg_rxbuf and virtio_net_hdr_v1_hash structures in 
virtio_net.h, which can be forward compatible with existing user 
applications which use these structures.

After checking kernel code, the virtio_net_hdr_v1_hash structure does 
only add new members to virtio_net_hdr_mrg_rxbuf, so the spec should 
only add new members, otherwise there will be compatibility problems in 
struct virtio_net_hdr_v1_hash structure.

struct virtio_net_hdr_v1_hash {
	struct virtio_net_hdr_v1 hdr; /*same size as virtio_net_hdr*/
[...]
	__le32 hash_value; /*new member*/
	__le16 hash_report; /*new member*/
	__le16 padding;	/*new member*/
};

virtio_net_hdr_v1_hash cannot use virtio_net_hdr as the first member, 
because in virtio_net_hdr_v1, csum_start and csum_offset are stored in 
union as a structure, and virtio_net_hdr cannot be used instead.

struct virtio_net_hdr_v1 {
[...]
	union {
		struct {
			__virtio16 csum_start;
			__virtio16 csum_offset;
		};
		[...]
	};
	__virtio16 num_buffers;	/* Number of merged rx buffers */
};


struct virtio_net_hdr {
[...]
	__virtio16 csum_start;	
	__virtio16 csum_offset;	
};



In addition, I put this new structure virtio_net_common_hdr in uapi, 
hoping it could be used in future user space application to avoid 
potential risks caused by type coercion (such as the problems mentioned 
in the patch description ). So I think it should be in this header file.
What do you think?








