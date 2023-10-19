Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFB7CED83
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjJSBUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjJSBUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:20:40 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E67B0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:20:35 -0700 (PDT)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.187.19])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 67B18100004D1;
        Thu, 19 Oct 2023 01:20:33 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1697678432.833000
X-TM-MAIL-UUID: a3c353fc-f5b3-48a8-993e-84e00a2af078
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id CB9441000179E;
        Thu, 19 Oct 2023 01:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jksg8j7VbiqvZIjj4n4ACGIfundryLRjgzBqRPpti1Wkt3sIKQHglXV+YFsR0AGIUPEwTfwCd8ya4vTFhv2bowU4SKNlgK0D1/xKuQMiBDZDs/uqCz8ReeJgYyyGMupskawbQrNs9El8C6NpJDp2fo0SgdlmWr32vpaSzXvITISUAHG2xtkq5Alq9ou0cVj3nZK4yIsrhWNPA0CXhzynPCJij1fCSW9ZWxMdiZwHJ61w40pnehnuJH8vT/ucc/JAX0euvouMlQcquykJWLvIyQIJj1jIWO/t5tBRQQZBdqq7At6+lEF62uGNmRFl5kVv8LNGlND3cC/5YYG8f79haA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf8ADurVAExiXRWNH/YmTmGeaZLtnBY5G7jHDYYYD+Q=;
 b=O+hXcympS1iT46EPVmCRjC4CAQeO1w229h35D/GeywbBs/z+1wsXrnUxbF24nFBxeOOahhnOruwDqnvPPvpg5xwjnKKXB6E0ihxzMYPyDu0db56+cEZmoV0GsCI+mkKfJBeawMwffOscNvYFSY9leiDfx742+JJOEx3mgNIuq7ojVZNGHYn5hXeX7ZNVR/ic+SOZ+GSqlmBdiuK7xLiJxHut4Dqm2lGFa0rtJ223rzIGFDKasP2S4oEfPn6cELp4uyam3boV96OJ0ggw3L5CQipdNr9VinC2X7lFXt//1oYlQ2SFAvNZI+QB5EyqgZiZbznpNYvSPKE//cG5gAeI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e50c5a67-d2b7-4ef1-8aaa-309437fa8cb5@opensynergy.com>
Date:   Thu, 19 Oct 2023 10:20:19 +0900
Subject: Re: [PATCH v2] ALSA: virtio: use copy and fill_silence callbacks
To:     Takashi Iwai <tiwai@suse.de>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc:     mst@redhat.com, perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
References: <ZS+392ZzVIoEyv8n@fedora> <871qdrn6sg.wl-tiwai@suse.de>
Content-Language: en-US
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <871qdrn6sg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::15) To FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:22::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR0P281MB2382:EE_|FR2P281MB2330:EE_
X-MS-Office365-Filtering-Correlation-Id: bebe1dec-514c-4d47-2fb5-08dbd0419649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRM31kLYZxcAm4U1IGgr0hC8POktOxVaybqVaap2Agkf+wRTEv18CXPYrRWaNdzv0jmZhnB2e8amwkGs6UFe3SU12jviod4Gwv2KUBzO9bCULr5qToGZ1fa9iB/uazfmr0IKaD78VDSme+VV4ZTzqYfn4fL2e1Xdi4JlKFRmb7oXY4WilnAGt4eGOG2MyzmjXFAodO7spZU/mVR7vd5gL6KJk/4qBfsU/V2YHuBbK72vLQv2J5TTN4CMz54QkoE0xrTRme+pO+yEXsLG7fiMnGmix59h9zTPI8yR7g47k7XcDhJqcAiK2prHlcrxL6TUK78If1uK51BejOwxnvsMV5V48GZTOTdeWhOsbPbXIYIRCHspU7Q0Dvw6/L1Whm3lz6RkCdCxtgmNG9+rp0WSDXKLjwBR5BqagbKAmNKWmD+rbzndU/rt1b9mu3VJwoyuADJ6oJzQ5gtmhbO6GAJu+XUdm9g494OBwmqLTFDsb3gP1mP2uMjuRRO1kDbCqCf4kHyEZ35PdZK8GonfHl0Li7EYPxG/xuKbuSDd11LG6Fafgm/XY0JIVzvLKZEfJqj7egt2QoJtLgOeiIBT8P/1y3A8+QhllWQtHzGKgfNtq6V775Zm/egvZOfYQa81SUum9GSZch6IrU69WmSQ5kEUHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39840400004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(66556008)(110136005)(66476007)(316002)(8936002)(42186006)(478600001)(966005)(8676002)(5660300002)(2906002)(36756003)(41300700001)(44832011)(4326008)(31696002)(86362001)(7416002)(38100700002)(2616005)(53546011)(83380400001)(26005)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5MdGFGOUxPcUhuaFU5TWF5U1h1MldVaElMRFp5d2k2RW52NXZtRFN1Z0lP?=
 =?utf-8?B?QTlZSnozcTgwQ09GOHBXYTRoaXh5Myt3VnNyYTE5aXBFUk5QOEVnTHQ3SHB0?=
 =?utf-8?B?RFpFcHVKdWdoOEJzUjB3ZFYzRkt2NkpTakNxNjdnMFlUQjFNRFBIUk5oOHlT?=
 =?utf-8?B?M1NwYmJHS0lDMmorY0gxQzA0Z2ZoQzgxMWdJdlRRNXh1eXBnK2FNMmJkOE9a?=
 =?utf-8?B?dmp0Rk5ZUjQrT0lXWnVNQkVnc0ZGNk1jSWRGUFo5NVhnZWY4Z1AraWloQkRi?=
 =?utf-8?B?Rk55djdEVGMwNHluZ2FaL3dYK3dQemRhSVozYU9ITEVyQlJ3MmtUczNYTU04?=
 =?utf-8?B?ZjAyL05KTDJiOFdBbWJ0WGxpczBtdGR3ZlRkcmVlNERtcVAyUEUwaTJOc1hD?=
 =?utf-8?B?VXkzM2QraDlBaWxvOWVoRFo2QmNkTG1XOWhJRkJFM2RXZ3VhMk0ybmdEaGRj?=
 =?utf-8?B?WHh3UnRncDRnVFZJdUEza3AzSlJJbmVRRlpmWUxReFJqd3N5RmJQVXduMWdH?=
 =?utf-8?B?QSswZ1JDUUdSRFByKzRjblFOTFBLQUN3eVJaVkU5dFcrQXR3WVR5V1FkUCtF?=
 =?utf-8?B?ZkFQQTNjb1RjNVZCMkg3SnA4dkNReXh0ZC9BUGQ5bXo4STFqSWViN1JDSTZI?=
 =?utf-8?B?Z1RNdEczMGkxd1dDSDNraHRwWmExUjJVU2EycnpNN3JRN0xZaFFsZ2hJY3dG?=
 =?utf-8?B?a1pzQSs0WnNLOHp6cUplMzhmWm9iQmcxSnE0Rlk5ODZ1YTB3bzhYSWtqRlFI?=
 =?utf-8?B?bXZhTDEzMGFJMTI4a3FOYUhSUmwxTng1NnZaaWx5NWo5VE9WNUt6S0tkbEt5?=
 =?utf-8?B?c0FRc0lFaks5eHZXMnZXVWUwVkdSTHVZN056akprbVJLLzB3QVdNOGFzd2RO?=
 =?utf-8?B?dVg5cTlvRjg0alJ1Zm1FeE9ROCtMNlUwYm9DT0FqSURLcVVoak5FVzJlZDVk?=
 =?utf-8?B?UjM5Z3ZISGVqdkdSVEsrT25mdCtDQWtNcisraXF2dmZ3SDZVRnFyRk9rVGRp?=
 =?utf-8?B?MHNOQU5LUFdaenZFdENubmNlSHVvaS9mVkRhTEV4TE9CNzZsWWxJZHRmNStm?=
 =?utf-8?B?TEhia3g5VUgwcDNXZE95L21MbXcyMHVNM2lxR3R3UVl6VDg4cDVDRW5PTmpE?=
 =?utf-8?B?WlhYY3dUOGIxNHFURXF6ZTNHK2t0REN3VytvUmtqQ21tRmJVTDNhL2RXMGtT?=
 =?utf-8?B?Q1dNNUhpOTB1TGtwTkNZYy82VmhFSXQxQk9WdkJkN3RuVFYybWdoVUd4NERS?=
 =?utf-8?B?eGxPWHlsdzdHN3pQL3pFUC90NjVqY21ZdnBxWXZiejZJK1ZTNWJCMnlLZHNp?=
 =?utf-8?B?R3BzY0pDd3E0aDhNaVpucDNUL2kvWkxjREFDeWE1blZGd0NzcWpOQ0xQKzNH?=
 =?utf-8?B?emVtKzBYUStwelNaR0RKNHV1ZHY5amFBNnM0MVAvY1VOY1VTTytrYjdURU1H?=
 =?utf-8?B?SkpMdklacGNxU1gyV1I4SG9UNEV4V0VyUE9FMnZoeXB6TGNhNlVSeEtoMDlW?=
 =?utf-8?B?N3Z4RTRsUDRuN0hRUEgwZ0hkRmQwWEo4Tm9aL050djR2NGpDSGNGWTdqZ0Qz?=
 =?utf-8?B?M2dRWUN1VWFhOEdid0MyekxoSVpGRTREOThBRmh5T2JOYXdnYUtGS3A4Sno2?=
 =?utf-8?B?azhPNWRQQkVacUJxSTd4TGJlTkdLeFRRTmJFUEZFN24vNjZjQnV5VWlmeWJm?=
 =?utf-8?B?cDdwMDdJMFJZeU5DWXY0M0RuOEJsQXAxVklBR0s3L1JDb29QZkE3NGVuNytp?=
 =?utf-8?B?SEVYVzBrQ1VJbHVWVkJ1Z0lMUW5FVjhmSXRVeVk1aVY1TG4vYVpHeVR6c1BS?=
 =?utf-8?B?MXBITWpwek5YZjI2L21EbjBkWmtidXhBUHBvdGlSNmNiV1g0dERjdzVGKzRI?=
 =?utf-8?B?NFRyNnVML2h0Y0JsWnlobE1jdHRlQy9nUDhBanJRSG9LWThZakFUZ0VqdXpn?=
 =?utf-8?B?OGNpaTQ0Si84NHM1c05ZeUVxbFlVS05pbnFKZ3FzMVFKRUdnNTlMdURzVXdh?=
 =?utf-8?B?ZWRSWFVrZSttNllDTWdGbVZkUUlwZ044R0R3QmpqemR5bCtLbkpvb21kNE9R?=
 =?utf-8?B?K2w0Z0FJVTVVSTV6NGxEeGZFUGl5ajlOVHAxVjVYVWJ4V013azRseUdMeXpz?=
 =?utf-8?Q?t3D9KhRvGnxBGyrn4Vg/GXlDr?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebe1dec-514c-4d47-2fb5-08dbd0419649
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:20:31.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS7tR2gJvvjDPvpND1pyLvKAoMJQfLJsqXVmzBkV/LRzeY76638/Yyl4IwWKeuEvsHXamFAWtJ5dvlXV6YFDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2330
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27944.003
X-TMASE-Result: 10--27.350300-4.000000
X-TMASE-MatchedRID: 0+daXaNUWRV6u8Ra7Bkp4ww4DIWv1jSVbU+XbFYs1xLykUQ3+1QpKU3S
        C9bkE9YyNr5aA8MV0XkcydMA6f+1WPujgI8W3VQdrf03Gvoif/fn0oaU6WM++6WXeo1JBrZgw5n
        Zy2X+Nx7e+5l0TSAQlxCNJOxfs3EOC5yGwbf+IdgsJRkKgHlrKG8lDAHJQfo4uxtkhcNHU8oUS+
        eIOZZCPodKFEXU7ctQ12qbvVPRySQoDQ4wSBO3SRdLtszs/yIYEkUS8Erng9q2gwaXPtBp+ya2Z
        Yhi6NLbDbopmLJYchOBariVNrrFRXX/e6Wwhp/J6x+Q+uPsJqpxd2b9FYfw7aFRWC8HCKx2feEy
        sJu+yTJopHFvth7VZA5pdByl/RFheQczFQh2XEsD7AbA+ThQk9ztvqTn5fr3MCyfT2VAUIXaiin
        ot3yvwUI5EMS4xHCcY6NiQNWkjVsldkOpPw3c45/KMn5sGLoglZroRtOiCG2L12p7cZqBWHUhg4
        grojSzdl50cfr3QRNKV13hwcvu9uPXzq8/z8gYsX4aFYAMIYOVlsxwvB691Zq9yKH2z9zouhCa9
        ZJvTFsnCwTCNGqnQA2HX3i8MKsscRyh6V9KDHJyIoQdDbaH+hSqHA2q+Ri179D5zLNFLFFDmpWA
        k9AhwYGwjJO9Z+9p6xA0Ava73nAPm15xyht8lcTvQx6Ny2Cr+sMesHlgpMuEJNgyBSJlsiqhjeL
        NyvT7eG3erYjBbl1+3BndfXUhXQ==
X-TMASE-XGENCLOUD: c6379135-309e-49b6-b3d0-d057082d082d-0-0-200-0
X-TM-Deliver-Signature: 4E2E8D0F4B9F376DEBC124A174A1973B
X-TM-Addin-Auth: GAEFCnFsah310md1HnB79FGLTgvFkLFYnX5KZbrz7oYI/thXkI6K0PUxtN0
        gT67t5te0QpzMI1HWVolbutRaBxr3339ouSmc5fdPohimgU9eGy2fx8HCQX+r5/L5OEPGfD8ffj
        42b5cpOfcRsFFTPHflVYWyyl9bONuG20NxEdlISjtxR3slFfpVKxgUrmFADz3fw+AGfQgb3NM/Y
        Y3ozht1TMPH2RMRTfV0yk8/cO2UDST9xh36bbSgFLC2dC33607eTxIeGkXeLtmm+7ewvErQAVuR
        pJRzah7Bd+q0gtQ=.DkvDMS0yeHgYnKftnsFg/oqf4hB02/rcMaAcDbeHRFhvzGgqCg1ciqh3G/
        K8ERrKIpnbHs6zFqjGLxppIt1WTNKPPDlOQ0WWpK5vlkW7LQV6iHZBuSG3sR26o/GPTa2qv0M8W
        zGjfk8iQfcU1692rilFYe7YZw9+cbliu24EMq1WYs/TDAptZ+SkErnWgM0XnRe8FSQ+bPHtuS3c
        j32Rl0X7LtP5zqGm2PjB38eRq5+grhce9Urqn8wy0w1J8GU/QvZrauU01gMtpA6TYUaOByKXvvx
        +taLEowRtZGkBiCwva+qVG3SswUOjhqZYbXCoBglutCG59DNyFJRu5RJwzw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1697678433;
        bh=eVMFAFdoIfvrqzVhsneZDt7MOvUdX2fbf1KdxxiXDWE=; l=5010;
        h=Date:To:From;
        b=MN5l5FvcvXdFupw3he6UL0jUZ7yJGlD+M1Rfc4MY02LvqBVOBLmAZQ0wWlYh5umpB
         Z2rOYWgFl+mCnsjkOL5kAJrLW3ddX3WIRGTpcacYT4m48s6bOK1kcaDfYFsasx61Gz
         tbFXHGOhHl9wxxMt11rVbp6ymq/AWlq24iAn6XcpdAZRLl+PWb1560OwIt4ul1Oqhc
         hSdhGagRWwSn4RqY8/G0FrtoIx08BbohhXqv9841M8qUaQdY6ExHfBahVybGKRzgvc
         iBfwVaDJPjpDRn5nJ89fgDq19LRi7KpqpELk7jCIorIpsX5W9dNIviStlXK5fEAd8z
         AgLvu8OWLBEDg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 19.10.2023 03:07, Takashi Iwai wrote:
> On Wed, 18 Oct 2023 12:48:23 +0200,
> Matias Ezequiel Vara Larsen wrote:
>>
>> This commit replaces the mmap mechanism with the copy() and
>> fill_silence() callbacks for both capturing and playback for the
>> virtio-sound driver. This change is required to prevent the updating of
>> the content of a buffer that is already in the available ring.
>>
>> The current mechanism splits a dma buffer into descriptors that are
>> exposed to the device. This dma buffer is shared with the user
>> application. When the device consumes a buffer, the driver moves the
>> request from the used ring to available ring.
>>
>> The driver exposes the buffer to the device without knowing if the
>> content has been updated from the user. The section 2.8.21.1 of the
>> virtio spec states that: "The device MAY access the descriptor chains
>> the driver created and the memory they refer to immediately". If the
>> device picks up buffers from the available ring just after it is
>> notified, it happens that the content may be old.
>>
>> By providing the copy() callback, the driver first updates the content
>> of the buffer, and then, exposes the buffer to the device by enqueuing
>> it in the available ring. Thus, device always picks up a buffer that is
>> updated. During copy(), the number of requests enqueued depends on the
>> "pos" and "bytes" arguments. The length of each request is period_size
>> bytes.
>>
>> For capturing, the driver starts by exposing all the available buffers
>> to device. After device updates the content of a buffer, it enqueues it
>> in the used ring. It is only after the copy() for capturing is issued
>> that the driver re-enqueues the buffer in the available ring.
>>
>> Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>> ---
>> Changelog:
>> v1 -> v2:
>>   * Use snd_pcm_set_managed_buffer_all()for buffer allocation/freeing.
>>   * Make virtsnd_pcm_msg_send() generic by specifying the offset and size
>>     for the modified part of the buffer; this way no assumptions need to
>>     be made.
>>   * Disable SNDRV_PCM_INFO_NO_REWINDS since now only sequential
>>     reading/writing of frames is supported.
>>   * Correct comment at virtsnd_pcm_msg_send().
>>   * v1 patch at:
>>     https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flkml%2f20231016151000.GE119987%40fedora%2ft%2f&umid=2f305b77-83e7-47b6-a461-a8ca67d0bfe2&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-2d5775265e7e1741ae8eb783a3cb78ed553093c1
>>
>>   sound/virtio/virtio_pcm.c     |  7 ++-
>>   sound/virtio/virtio_pcm.h     |  9 ++--
>>   sound/virtio/virtio_pcm_msg.c | 93 ++++++++++++++++++++++-------------
>>   sound/virtio/virtio_pcm_ops.c | 81 +++++++++++++++++++++++++-----
>>   4 files changed, 137 insertions(+), 53 deletions(-)
> 
> Most of the code changes look good, but I wonder:
> 
>>
>> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
>> index c10d91fff2fb..66d67eef1bcc 100644
>> --- a/sound/virtio/virtio_pcm.c
>> +++ b/sound/virtio/virtio_pcm.c
>> @@ -104,12 +104,11 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>>   	 * only message-based transport.
>>   	 */
>>   	vss->hw.info =
>> -		SNDRV_PCM_INFO_MMAP |
>> -		SNDRV_PCM_INFO_MMAP_VALID |
> 
> Do we need the removal of those MMAP features inevitably?
> Usually mmap can still work even if the driver implements the copy
> ops.  Those aren't always mutual exclusive.

The driver uses a message queue to communicate with the device. Thus,
the audio buffer is sliced into several I/O requests (= number of
periods) of the same size (= period size).

Before this, all such requests were enqueued when the substream started,
and immediately re-enqueued once the request is completed. This approach
made it possible to add mmap support. But for mmap there are no explicit
notifications from the application how many frames were written or read.
Thus, it was assumed that the virtual device should read/write frames to
requests based on timings. And there are some problems here:

   1. This was found to violate the virtio specification: if a request is
      already in the queue, the device can safely read/write there at any
      time.
   2. It looks like this breaks the use case with swiotlb. Personally I'm
      not sure how the application handles DMA ownership in the case of
      mmaped buffer.

To correctly implement mmap support, instead of transferring data via a
message queue, the driver and device must have a shared memory region.
We can add mmap in the future when we expand the functionality of the
device to support such shared memory.


Best regards,

> 
> 
> thanks,
> 
> Takashi

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
