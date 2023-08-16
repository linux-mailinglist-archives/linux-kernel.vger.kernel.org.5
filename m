Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C877E8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbjHPScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345540AbjHPSbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:31:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5024519A1;
        Wed, 16 Aug 2023 11:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+8JuXEvxF8VSyPTLTSfzzzlRe14LL6QggDbDCxjzBf7b+89pMAxxU57C2z8kyYzdMK8x05KcFEdAU3M+ZJ0WL5POxkN3O3BSaweiUFxQ8BnsABueRC1Vp/UhoIFNpfqQo42r69BS8/bcSPf5tLrvup8Tjl+SypDi77PDkd6/OkgLg3Us71lYhgeYPWe1Ho7BaKxo8CgNEXLZExNaqTLBD1uUlD9iauP84VxQKfmqS40QiGDEo95uaUGo3kHTODTLncCadgXiPoNYZ170NUQxPVGVfdhU1XQ6EJa/2ej8NsVjQExurw0Ubimb99CtLppplbCp8AhyxmScnNteY9lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BnfSgAaPgCFNbDNytPDTdgaGyTZ0n9K+idJLqt10Cs=;
 b=iVQCWQZb4BgSQEFHGvFAnr0PsXFpnKkRHaupR2hCsd/IvtAkC/PPYUfaACfPdvfQC6D99rSb53cpKqUQ0Lo5O8sGnw04312vu2zU/a9RelInRMxXELWl42ZAKNBzgnlzjTr0E4RwW8q3An4S20BDwUcNny+ryHc6nIlLCk+Qswk2ZBIO+r9XD7WiUiBRpA2iYgf7DMQeX1QALaVng1+gGMtRPLNybj2V3GRxNqZ7A0ax7rhdfQvvArsGIlccPmkw1qI5e4sj6DiH3tielK147WKHinMQz7opYEDLwMPEeJ1tO6E/79Mvh6aknDN+56y1bbV2NkR/ozvBWkhS01dB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BnfSgAaPgCFNbDNytPDTdgaGyTZ0n9K+idJLqt10Cs=;
 b=J2vmuHssah3UYksvcMACznZCOW1nLrdK5Jwb5NF8cBxr9CFhkErECQfpOcotxRWZR51uSMs7QBF3UKfnOUuHX1bEdL/xMkWhDlw/gk5yZjteSe1U++OeIO9Aj5AzykN/8SxrqbeK5WGiORh55FoIVoBqMex3Lng2OAhz6EtjZwls5CLE1fyPLQNIji7zJmCbGyW222tNmDx3PdbzDPrdvmkSoJvRRH3KAmtyAA85BNf9FJERw1l1AYLlWJQP7RUu4YMXgTAx9MFO1UT4ZCQY4Ba5SjDbkAswIipC3g/EBAKfZu4M8hUZ540c0bifb/j5Q8jGzJHBatSn48WmdLsYCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 18:31:20 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 18:31:19 +0000
Message-ID: <e8a414f0-ac55-9ac1-b115-94daa5914a9c@nvidia.com>
Date:   Wed, 16 Aug 2023 14:31:15 -0400
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
 <f9f3c150-2b5e-7bd0-1c1a-062bd1f16fcd@nvidia.com>
 <64dce2f2b99f5_23f1f82949f@willemb.c.googlers.com.notmuch>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <64dce2f2b99f5_23f1f82949f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::15) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eaf0462-d11b-4a2d-8c26-08db9e86fc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 244sFdBLJDtohsWz/lT0aWp86rfAfvSaQsXeLq/wd1TevKdlVXsWQGQmOgWMLEqpZewGAXD3HaXckga1DSqBr7wkM3VALS0mmwgzQjoG7F9aT5MhtjW92QuT/h4btpC2lsyFVDwfzBjchzDj2BcJhMG/8fF0W959sb2/WOjzLs85SApTjtxrEAfbvub0drPd+Uvf91GWi1VGtHK6C8N3y4xR591b9qPSM+09xrvnfKBvoCW5PNJsL7Vq58bXTEu2FiaUtIPSQKzWz/1RGBVGjHs8xIi6dlGinkvLxeDuE2kl3HYGp/I1WtvY5Ri7XkSE4HkzqO+6e72Hp4Bv8sYk6gK+o8wuymfxl7bScZXWifG72YMENjvGc0ToiQub3B8CraK9ppcmci/810U0MD36YBQlCw8uFWu8uLolJpkT0ZQbz8OpCzvyRO2QwPBmma4ueAT0XWLDFMWk3zFnxfNwwZxeaWUdG6kIBUIkiSykkfgEhucgQGf3vsnnTVDVpTyqEQXtwrsviI0ex0Kj0KlgsQz6VP8dHoajosRtCpdH6MokQuNGTqwJc/4SK9Y0d4aGL7elKro6IfT26H+++ZsQe0XgUWw6nyyA0Iv8qKgrfGDSf7L8mMYYerT1i0bCcfGK4ZlccwKPI0xMxkxTmVrrvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(6512007)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVM5ZHlOOG51REMySVpHMDFDNmRkVE9pK21xSDlMNytSWjM2Z2NmcnNUVmxK?=
 =?utf-8?B?UXJsaGQ1VWFZTWR5THFrN0s5MVRYOXJVYjlRdHFzVWlTNXZ0bEhtOC8veGRY?=
 =?utf-8?B?N0FDb1ZVK0pvTjVkZy9JRFg3Z2VXZ0ppa2lRMVNKRGpRUkI4NlR0bmZQQ1BD?=
 =?utf-8?B?eHpxdEtDZ3hyWDRjQ0E4RkM4cW1hUUJZRHNEUW1qNHRwT3ViZmhXdllkdTBD?=
 =?utf-8?B?ekhYOGJzTXJIcFlZdDJTWTZiczgrKy9WYkJCOEszMXBCVG5qYjZjTHZpWUUv?=
 =?utf-8?B?UkZGMmxjRlgyTWhJNWlDWTNkQ2RKMXNGVmVYdnpieW9WTzF6eVpBSnlVYmYz?=
 =?utf-8?B?SE9aMU5zdGJlSkJVcVFyN0VqR1BEOXJncFY0V1dqQ3NZMmRvWjNESERDYnJY?=
 =?utf-8?B?UHQwbElDMElOd2JXMjJLOGsxZXVKR3VSYWRmM21JTmtZQUwvc0JoUEN0N2Iz?=
 =?utf-8?B?MEd6K1ZTYmN5UlFWWlB5MXBlZXVKWE1ob2VvMzJ4WUJXS282d0VVeXN1Ykt1?=
 =?utf-8?B?d0l3T1NQM1Nic0Z2UVhvL1BleUpscWZhZGh6YkcwMVBiVEE3Q1dpRS9RR2ZZ?=
 =?utf-8?B?MEZsdkNwUTRTaUZiQjNkMVhNYjVHR2lidmtSNXNyQjlsTzh1V3dMTGZWNW5P?=
 =?utf-8?B?UU5xRjVObVdKNHBudzFiLzZxRGcyVTJWazhkV2FUVkd1VVNPUnBZeUxSUjlY?=
 =?utf-8?B?M0VuSzluVnVRUW9NalNOWFlscDZ4VnIyTTRRU1hkSWVhQUtQdDkwMS9zRzNp?=
 =?utf-8?B?ZUppOFV3c3ljOHB2VFJBcnBJZE4rZG1yb1gvYlRyREZNNUJOQkxUU3Bwd3Zm?=
 =?utf-8?B?RjFjRGtsN1l4MEFrQm9TUml5Z2dtT3BKRkhJWE5EN05WY2NuWURKaTVMUlpz?=
 =?utf-8?B?cVVUb3p1aHNxNU9yVjNrTktTWFdsNFZ6dy9qWVFsVGQ3L2RJWEo3SlIvbmhi?=
 =?utf-8?B?OXdoZ0R6VGdITUJZL1lzSk0yaEFJdUhHYTdVbnVNNkVPcWwzeWxDTUhYUGtQ?=
 =?utf-8?B?NjZLMk5HWDZ3YTZXRTdWaGwrcmhObEQraFUwbTRoSTNTejNlaU9WNWhZZExk?=
 =?utf-8?B?emF2dEllOHBCdC8zMWdqMW1DOVA3MDd6WFY1enVRdWJhTTNyOXlyaHFNaDBT?=
 =?utf-8?B?ekpDQ0xnRDZOWXNwalNneDQwK3pZbGJhVXMyNnR4dU9HSWpwUXA3cGlNMUxN?=
 =?utf-8?B?bWwrY21qTHRFS0NDaUpud0g2ZVBTTUJOREhuRFRtakVTb05Td1hiejVDVzRK?=
 =?utf-8?B?ZXd2eXdqM2FWRmUzSzg3R3krT3Y0d0oyQkVRa0pNOC90OVIrbnZkSnMxSy9M?=
 =?utf-8?B?NVU3NDIyV2RMSGdHdGtjWU9naXd3dlZZZmdOVWtqbU45ODIyZno1NnZPckZQ?=
 =?utf-8?B?Vitqbm5ESUdQN0RNcVVwaExrd0lUYWcvRGpRbGhkTE4xVjZ5VHlkV1RQUnFn?=
 =?utf-8?B?OWJwWUZFd1prYURtMjBOazZoV3IxSlkwaVdRdW9tbmFEY1NXTTJHNlkxaXox?=
 =?utf-8?B?NE44M2VEVEM1RjRUQVhEUW00VHA4dlVjZVUrd29MLyt0TTZxamREM0ZRNGdL?=
 =?utf-8?B?RFM0ZkVyb0c0V1RPb1ZHLzNLNlpVaFk1eVRwUE9kZHlrbnVxTTNJZjhYc3BS?=
 =?utf-8?B?eTRMcFpHeVo4ZWVVNGJnQjlUd3pKYm4vb1FjbCtYSTRNaENPeGtROEtJZi95?=
 =?utf-8?B?cnl0NnMzTkxYem5obVhydWJqM1BtVFI3Z3ErN3NISTN3SWRVRlJHM1VmY1Z6?=
 =?utf-8?B?Sk90UUpIMGRHRkM1NmlId0V1aHpMbzRLL0FVdFRRS0ptZ3ZqKzNtOEJvZTdl?=
 =?utf-8?B?ZUZHS2RmdDB4RnNMVEhaYlNaeWhBY2VSK0JWK1g2cjJvaUIvU2padmUwRVp2?=
 =?utf-8?B?NmhtU1BaMk5UMVJneW50TlR4OUVOUWFqdG4zUmJKOHVVSVBGK2VLVCtFRVJE?=
 =?utf-8?B?U3J6V0tLOWVoYjQ0Uk12TG9VczdET28wWEFVQ0NKMzJhRCs4NmNNRDZGRlpm?=
 =?utf-8?B?WDFKMGY3ZmFneUovV0NMbVhyTXNadEtSbzRVRGpaVEl3R3k4dkRWbEpidUsz?=
 =?utf-8?B?TFZQaWUzM0R5c1RKTngyeERKdlJYQUYyR1dYbldOdFdNRVE3MDBPekswcVds?=
 =?utf-8?Q?7atX2aynV0Tjcx2GiT85Igl3e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaf0462-d11b-4a2d-8c26-08db9e86fc14
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:31:19.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CkO+cylfKnslvAcZabqhA4xZFxP2jPh/rdgE0b/xEbVOOGlq+2IqSb1XbY9lVR1zKtuKJNstmxF9qDRpjTz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-16 a.m.10:53, Willem de Bruijn wrote:
> External email: Use caution opening links or attachments
> 
> 
>>
>> Thanks for the detailed explanation.
>>
>> I kept virtio_net_hdr_mrg_rxbuf and virtio_net_hdr_v1_hash structures in
>> virtio_net.h, which can be forward compatible with existing user
>> applications which use these structures.
> 
> They're UAPI, so we cannot modify or remove them anyway.
> 
> Which is exactly why we want to be careful with adding anything new.
> 
ok

>> virtio_net_hdr_v1_hash cannot use virtio_net_hdr as the first member,
>> because in virtio_net_hdr_v1, csum_start and csum_offset are stored in
>> union as a structure, and virtio_net_hdr cannot be used instead.
> 
> Oh right. That wasn't always the case, or the reason for this.
> Not super relevant but, commit ed9ecb0415b9 has the history
> 
>      virtio: Don't expose legacy net features when VIRTIO_NET_NO_LEGACY defined.
> 
>      In particular, the virtio header always has the u16 num_buffers field.
>      We define a new 'struct virtio_net_hdr_v1' for this (rather than
>      simply calling it 'struct virtio_net_hdr', to avoid nasty type errors
>      if some parts of a project define VIRTIO_NET_NO_LEGACY and some don't.
> 
>      Transitional devices (which can't define VIRTIO_NET_NO_LEGACY) will
>      have to keep using struct virtio_net_hdr_mrg_rxbuf, which has the same
>      byte layout as struct virtio_net_hdr_v1.
> 
> The union was added to overload csum use on tx with RSC use on rx, in
> commit 22b436c9b568. I don't quite follow why there now are three
> structs, rather than two. The first two seem to both implement csum
> partial. Anyway, not super important here.
>ok

>> In addition, I put this new structure virtio_net_common_hdr in uapi,
>> hoping it could be used in future user space application to avoid
>> potential risks caused by type coercion (such as the problems mentioned
>> in the patch description ). So I think it should be in this header file.
>> What do you think?
> 
> Adding anything to UAPI has a high bar. Do you have a concrete use
> case for this?

In the scene of with and without VIRTIO_NET_F_HASH_REPORT feature, this 
patch has been tested on my setup, and the function is ok.

> 
> This does seem mostly a helper to simplify kernel logic to me, which
> is better kept in non-UAPI headers.
OK, will change it.

