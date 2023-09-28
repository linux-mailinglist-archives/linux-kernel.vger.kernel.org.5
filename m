Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B317B2404
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjI1Rfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjI1Rfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:35:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2101.outbound.protection.outlook.com [40.107.243.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C4E5;
        Thu, 28 Sep 2023 10:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1xaaJTaVdWbyoTq0g6xn1Nm849hXpYs83Xktcb8huq4uHphf56kxK7w+pr/+cvc+fDSNPfVIn4nvbROl7TQz3FRMzH38ouRyLINbuz7BluQ3JRqE24LpDRh8VFxr3BVHF3AtQ1Veck0FQEJiolfYNJzasD62LtXesdgxicttb4juuciHNXhxthjPjfMMhnnlmZd3+N2P7Ln1gmdNX+v6Qw2DYeezVwy6cgb+moagTszbCi/CdKCaE4z9y32SNqdzaSPnI8SLPchJzoBpcklJ64s6ur4XDktbdO/KlO2BpXq6bG3Ryo5HIRaKUcZ4j7I6El124nBqE9OqOW5AS1RBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG5cZneviAYxigkN8R0RE2aUed0AecBs60inoKtF6Ss=;
 b=T15fTA+YWBsYs3jKBEjVkrLaTY6hGrokSWc8QB0zZS02CwZdmTPjvjHJ/0Dx9AYo2YGrse0ELShve3LJslkTZerkYyeRmFSlSYWJfHeGn+QuuQrTldSaqztRTVtrd984y9gTPnCXjcj++GNGItlyuDmQEuZGr2sQ34mjN/CAytfBUsrYuJiugOTyUafpXGEmRGS2af+vX9I11+GSjgpNuUNsFafzHwRCsnS957JhYP593E74zCHgeqcp0l5u07ssme014U/v/QCutF6z7nUhNI5BnTzqWJbw8FOcsyLX7V9/qg0IEXwPr6KnG8G440Ji7MfU0YBPMO8ihUnmERKIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG5cZneviAYxigkN8R0RE2aUed0AecBs60inoKtF6Ss=;
 b=EUpJ3+mrTA+SFmTHthGEefKYORiiwX0SbU6iEFOYmzubmtwlOPS57XJJXq1/aJYr+Eg+myCYEcTtU++Gjffs1iv48ruQ/OagzleNyQiAqC6LCmHRp472eyO0mDgThDDoR8XhAa3NOfwat0SCiWLXnYGBwyuJgKlLvM5UOubEYaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7492.prod.exchangelabs.com (2603:10b6:510:f3::6) by
 SJ0PR01MB6511.prod.exchangelabs.com (2603:10b6:a03:29f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.36; Thu, 28 Sep 2023 17:35:23 +0000
Received: from PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::db82:aa53:7ce5:618f]) by PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::db82:aa53:7ce5:618f%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 17:35:23 +0000
Message-ID: <868165e1-64d3-6241-c62e-19f0c91be64d@os.amperecomputing.com>
Date:   Thu, 28 Sep 2023 10:35:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
 MPOL_MF_MOVE are specified
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     hughd@google.com, willy@infradead.org, mhocko@suse.com,
        vbabka@suse.cz, osalvador@suse.de, aquini@redhat.com,
        kirill@shutemov.name, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230920223242.3425775-1-yang@os.amperecomputing.com>
 <20230925084840.af05fefd19a101c71308a8cf@linux-foundation.org>
 <90fc0e8d-f378-4d6f-5f52-c14583200a2e@os.amperecomputing.com>
 <CAJuCfpExMWXHfZjgZ=UKf4k=zxrNOLx2R-a_wQdZ3O_+JTOq4w@mail.gmail.com>
 <20230928093809.75de08561b0fa1af03bf4a89@linux-foundation.org>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20230928093809.75de08561b0fa1af03bf4a89@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::13) To PH0PR01MB7492.prod.exchangelabs.com
 (2603:10b6:510:f3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7492:EE_|SJ0PR01MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3957e8-e042-417a-171b-08dbc0494b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WenD9SORYTMYVcINpkwmRVyWkBAogjrpdPVYrdVz8kPo1N6rHR/TZu56Op4rxrvcPhxVrCuXFGR+IZVnaqPz9fq8e0l2eSnJIeA9ylVAYAttM1+XqxKvqSf/Fo/ioEoDhxHvdwHhv1a2V7bkXjpQXPHbHQG7kizQnmL4HS6Q4Fx66l/EU7Wk7LFaxMRxWcxJ5n6V3+0T4zWJpZcrUtWymwJw9EaRbE8l83TTQ4dp8mm5vhMFOUHNZUhVa8YnKRz941UrJy2yJMKqN+CGb17JkeFZaS0z4ljSljFw5qvSSxGaw/y83XJ85eWhGlryjtkijbBksHPjsMVc58FaGLnxt0AGeMAhUxBrjur84dV6G2W1A59BVk5I9ijsfvj9ibK6bzvhsHs7OnLqYlHztseBiyIwhmiIasVKOp5P+U4qXI5kPPklZKrOaFSj57wamjGRAJT/EKwWGqVj1UbMKrv9zrStyufesogR5XXceCcs5OKu5ctbsWqTj4oQ4Dz2wNZzS8n6I+jT8FNyo9LhYW27f/RY4Sm0oJ3hQfKW1c3qzpSOAMPjMIExhBTB6ow7EPYDARpmh7m4fjtQT8wttY6x2by/oiqsZPT8IGo4K9tq9aqmvb7DdIZvGsb+EkaKZyX++aFoFUW2yTU1ChTG+Du0pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7492.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(2906002)(7416002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(110136005)(316002)(26005)(66556008)(66476007)(66946007)(966005)(478600001)(6486002)(6506007)(6666004)(52116002)(53546011)(6512007)(2616005)(83380400001)(38100700002)(31696002)(38350700002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhnMG1GN084SEErR3JWeUtPT2VmaEU2N3ZxcHlEaFh0b084TDBSQVNoOU1V?=
 =?utf-8?B?Q1JrOS9acVRyN0JKWVdtb2NyZ0JRc3kxcjJtdll5OGhHTVF6eUZMRXI5TmJV?=
 =?utf-8?B?OHpuampYdnowS0srSHZtajF6dWl5MkJUSFo5UkNPbnFRQWV1bnpKVVBtZXNt?=
 =?utf-8?B?Nm5ZRVB3Z2tUL2JKRzBVSWc4em0xbDllZTB2alRjdUdJNzRPdWhCNzNkN0d6?=
 =?utf-8?B?U1k0NGlCam9VV3FpSitSZFhjYkN0VFFEQXpEdmRORFM3YnBFSE5FeDFJT1FD?=
 =?utf-8?B?UkNGT2xIaDhBZmN1RVdYY3BaUXB0bytrRit4QUtlSkVFcUpLcm9lajZ0TEhq?=
 =?utf-8?B?ampIWSs2MHNTbFU1dzFock56V08yT3g4aXBzRDAxNStJU2RGVWJxNmV5TXdx?=
 =?utf-8?B?V2g3Z1FrVmpPcDVIWGZmVFJLZ2ZVSDc4T1NxK1lCdE9RUjVKcXliNTlNZlhm?=
 =?utf-8?B?Q0g5cTUrekpGd0Z2R3lyeE9MTHpHWGdvbElHbCtPbUZTcE1Sc2FCaThhc21X?=
 =?utf-8?B?OTRaQnhRa29mUGtCSXJZSGhyb3YwN25tNGtRbFJEZnhkS1hPTFVleHJKTVVm?=
 =?utf-8?B?ZmxrUE5VMnlZY1Z3d1VMK1E2cXNFVG8yVnNRRUpwN1I2V25KT1pUUXFtUHha?=
 =?utf-8?B?dVRkcFU3OEZsS0pNalFtRW83V2lKQllFalJoQnN0UVh3Mjc5bEhHVmdKdjRw?=
 =?utf-8?B?OTBKMGVIVXIwUloxR1hRRmg5TWlUT0dHUGdwVktSQkdGYWZwR1kxRTU4dWcv?=
 =?utf-8?B?VjkrQ3RNYnNMY1V0YllPeXdTQXV5QVplOStaSFNPekJNeWl5OXY3eHB0Rk9K?=
 =?utf-8?B?ejE0MDdoUDlaSmkrY0w0R0tZTEVLb090Z2RJczQ2RFFXK1NsV2R6ZzNDZGNs?=
 =?utf-8?B?OGxFTEpLeGkycGpRbjNEbkxVcTZ6SUc3MVVFSDFvWU93S2ZQazJQQTFWbnhB?=
 =?utf-8?B?OEF3TEVhOERuK2VSRkVUajN4QXJlSmFtdG5lMXRsQ09nTzdkWHM1ZXVkOGk3?=
 =?utf-8?B?eWRBNDVDeDE3Z1F3R21Pc1hnOGQ2VFBSM0tHYlZPMGZNRHAzY3B3Umhibm96?=
 =?utf-8?B?ZDBZd0tFR2lxWis0bEl1cnFiWE1kZll5MzRlZFVQbkZvTHRGeGw2YnV1RFR6?=
 =?utf-8?B?NzJQVFJrbUVvNllld0thejNPQTFXc2JTZUZzTmdON1dvbU9DOXprVmZVMDdM?=
 =?utf-8?B?dUZmMHZQc1RicVlGRWx2UTNDektvbE9zeXJhQXhFME4xbjlneUY1TXdXc1hK?=
 =?utf-8?B?MEk5VUhsNHpTWUJIZmJRempZRUhmV0gyS0lrK0FNNmhWUnlXV29FYmthVWRX?=
 =?utf-8?B?MFRXemJ0WDgvdkdPNmhVdWRUY29ZZ29YdzZaWFhKNU9UYndwY2t6eFZXSStJ?=
 =?utf-8?B?ODQyTEkwaW4rNWd2VFRsMVNoMkhrZG43cUdQVW9zbkgzS0JOSm5hSkh6MXZV?=
 =?utf-8?B?eFd0eHNBc3pzSDBoeHJGR2JOcjlLMVJUZ3ZHKzFHZzFGU1lGNWhKSSsxaGd1?=
 =?utf-8?B?MWd5MG1oNDQrbDkyaW5NbDg3cktjd2RsOUVxYnMrQVNpTEdFWDJVUE16alZ2?=
 =?utf-8?B?SytMVm1rakdQSXJETlpDajQycThWald0MzI0THZEWVVYRmNqWVd4ZDdPZHJV?=
 =?utf-8?B?MjFtZk0vMXFLdHAxU3IvL2JQb1JpU2ozVGM0NVRMbGZNbUhSclRMeHVwM0NB?=
 =?utf-8?B?WCtOZytjNGc3UkFudnUrb3ZWOVNMUHh5clIvb0luQ3N3TnVTRjZjYzNJSGd6?=
 =?utf-8?B?QU1jYWZ2S3g4S2FkTVdqS1JUbVpwczVqUTBTeXVyc3JoSk5Id1dmQUVUYzFG?=
 =?utf-8?B?ckZ3LzUrdlM1VHR3ZUtHN2xNQXdVbkZHcUxPVGZyb1VQdit4dS9tZGI5eERu?=
 =?utf-8?B?ZEVRR3V5U1dzeTFlM2d4eXVRR0sweHNPdnZnbU5UVFhvOGovWmlWSU41STBw?=
 =?utf-8?B?dVB3dUxWQnFVUmczYmJKNW9uWGp3QUtqbDQwQ2RDNHh3VXRrNXRXU3ZTZ0M4?=
 =?utf-8?B?TVN1M1VnbS9DSmlXc01MK3lvQVF1V1c1dVQySXRlS1ZqZ2wxN2hKVWZtdHVl?=
 =?utf-8?B?bG1LOStDMnhEUXFQQ2ZSMUVaTEM0MkdGMWhUSGppUDd5aGVSZ1RhUTV4dW82?=
 =?utf-8?B?QVVTOE5KQXo1N3BoNkRUL01iWUdobFZwY2NYcEdsOTV5VnJYZG1SRzkwNXVa?=
 =?utf-8?Q?i+V6osSxdwqQNMRb5+A7ajE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3957e8-e042-417a-171b-08dbc0494b5f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7492.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:35:23.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ/O5NtYHT4vzwsSNR1PsFo4/CNllHd1hGC4DoboVNtuFVzEKa+YJnmfQjei2nSMOmIJaSBYg7MQC+mGeyJN6L3IOm8uzIXgqrQfJq6wei8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6511
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/23 9:38 AM, Andrew Morton wrote:
> On Wed, 27 Sep 2023 14:39:21 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
>>>>> The code should conceptually do:
>>>>>
>>>>>    if (MPOL_MF_MOVE|MOVEALL)
>>>>>        scan all vmas
>>>>>        try to migrate the existing pages
>>>>>        return success
>>>>>    else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
>>>>>        scan all vmas
>>>>>        try to migrate the existing pages
>>>>>        return -EIO if unmovable or migration failed
>>>>>    else /* MPOL_MF_STRICT alone */
>>>>>        break early if meets unmovable and don't call mbind_range() at all
>>>>>    else /* none of those flags */
>>>>>        check the ranges in test_walk, EFAULT without mbind_range() if discontig.
>> With this change I think my temporary fix at
>> https://lore.kernel.org/all/20230918211608.3580629-1-surenb@google.com/
>> can be removed because we either scan all vmas (which means we locked
>> them all) or we break early and do not call mbind_range() at all (in
>> which case we don't need vmas to be locked).

Yes, we could just drop it. Keep the code not depend on the subtle 
behavior of queue_pages_range() by keeping it is ok to me either. I 
don't have strong preference.

> Thanks, I dropped "mm: lock VMAs skipped by a failed queue_pages_range()"

Thanks, Andrew.

