Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C737EFC1F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjKQXZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:25:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2065.outbound.protection.outlook.com [40.92.41.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2CD7A;
        Fri, 17 Nov 2023 15:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR2+hZUL8x6jqZJuPd+x19oqrLSQboUbmqhJ4iLPk7Qg37dAgfJSkDFxiWDx+zTPSStyL3SnU0RVrcq3N3a/Nr8IrGSFKolbNrh1GW08ysDzuGxcnjnjAqXGEd1yyY4DlkgzpAL4enwchNuULUMXyNPrvMYyX2l83p3jbtQ5twpJzU7GPm5Xvem1Il/sIjQEfIGqFtY9N8ibc13X1i6SbDFXzLWpe1SYDTmOD3moQZK1hkIDDmFx/Z3CHKG9Enleut1kfyB9OhYlqzI4hgnsplVu2evcoF+lpDWkfqfvNYpv2JlnFuUu3NXv9Ln6pZyNmoStTpTdcnHL6hNdh8mOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l6ghdF3Y3OC+NKRGDbiNXVrKM40+5YLguD4TuM/l2w=;
 b=lOC6W8voCdG/k0+AX9pZ5mqlqbqzZEg9STXifb/ohREyhPCHczkaxW/iIp4XqGBEuYNxlk7gN/isr/bbA6n3jq3neRsnFvwhOL4mzbOoFW6RhZCkjf0AvZiWgJOFdTOliDMTHQTPuJTAVo/V5NTDSyaXJtRN0XhBblWTM0RbLiWoDXHPEVNo/HLjXVVJuXqheD+QhNn4qiMUXsaNvoF1duOZXeDMF+T7ksgaa92t/nrE6uczRWyhIs3wHDPUsewFI8XWRx/fXko5VTttdCjyBXabD6baebMqs8K/5zZezLVwIF34qis1TCIV1RjRyRnkzs75BTcMXcN3R0v/HGuGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l6ghdF3Y3OC+NKRGDbiNXVrKM40+5YLguD4TuM/l2w=;
 b=CJfTj73WHc8CjoUTwi8juE/w/EOxR15wZ5SL9iu/Dbf5WGmXLeVZRTTodiFJuVpuYB6GJUNdO2OsZZfHGN3maUnqTaQkTTGVt0ZkX041eDJRvySJG6p/9MM8vAjT7qVA0cBodvzg64fp5kBungrT9Q0BnQptvzlzLMYBsiW8JV5UNBoax0pQfevyU9Um/4VMOJKz2UYyMKADIQnM2TfQz4/CLzTQ89cECea2Qc5M0vEfrCHJTxxnvIM4bQR5phJIrrt4q89P4+U5/HZ92jalo5h2ZC/7aI+PN7Zd+2qv55BGqpkUXxz7qV8qYqEqBfMtLLJRxzbSqznqg2am9FsbIg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV3PR20MB7169.namprd20.prod.outlook.com (2603:10b6:408:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 23:25:15 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Fri, 17 Nov 2023
 23:25:15 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Sat, 18 Nov 2023 07:25:48 +0800
Message-ID: <IA1PR20MB49536A1E4C97EA62558C6CC3BBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117-kindred-manor-863549870bcd@spud>
References: <20231117-kindred-manor-863549870bcd@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RJkU9cbkDMHgrrcKjiEQvrqQ9e37gzXS0yhkCwBIEdg=]
X-ClientProxiedBy: TYAPR01CA0176.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231117232549.57371-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV3PR20MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5818d864-9566-443b-166b-08dbe7c473ee
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgUmz6bRNjhPH+tZ4gTnDxCuidQRcBbV6bbWoiHOLwQeDwaXDyUMt8HJ8VGUs2GQ8FxZ/+wNOFgtmRvYkbgh+LWBLnLRvdcnX/XudP9/KCZo/iEfHOMFijfdRSAvJY3YXpjYDssrGs2Kb8nH0L0+lcZ82VyZSSvGxlCGHrvxL0chg5kyD2qU5xh7uY9Ro3RUPBAAj2Hh6pfJB7ss21c9P0hrOuQj+JzU8LcVCAPMGQfBWiXTDyDjJuqn9mMc2gaKcOdRN4FTaQjnT5QFLzbb0sxd6ZWQWoqGiDCbnXWmJWfJBPqJYbxp+p2Ukc6JZOq+jX31eGRAvgFG3wEngSZMw5HpzR4y4nRu1JT6jPh7guwbG7dCIs/urVAE1jw9upf3R8cDVr+bp2AGW2w5c84USyya4dUFIDdUHKiDzyWB6IAdbSXy6DcnkHRswvh6lldb4ieIjv+S1PmpWD9Al3B2YfRYC7TS1TDInGYhdlzScRubYTBkvHh0ZR1lJItHlR/JZfBKF/H/FzJW0KkXyCbqdQQ5bCQ7znuEP5K96Eq5MMVkRQpH5p/WFNa96S8ho5uNCkVbyG3ug6SQZr2aVGd7KrwNt9mFXiiHOCMv9vuol//GPx05OL6iHTPrVvIHC6qL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UIhoiHJE54Ql1Ysg9WFpdJsXvWGqwzCRBShdk1lzDU5lSrdd2Tl/tWlNEVxd?=
 =?us-ascii?Q?Gpk5fWlZFiHmRguRP9jWk021mvPXLOZch3zTv+d1sgnOMg88yOqOOSsbBZm4?=
 =?us-ascii?Q?Pk435oeYYUA4vYNKRvdmjCZsaainawT6RQBnEZDD9lFQ09li5wj4d5+1F/fF?=
 =?us-ascii?Q?/qL5IuA6AHL57ZpWdzslxuJFHoXzwMl7M6caBcXV8a7cFuJ6J75/OK62GdLH?=
 =?us-ascii?Q?QigW2vqGiYDJKhzGXg2vs9hOcsR4YUtd+oN1w33ucXUw1zYscyhMs+BN91+e?=
 =?us-ascii?Q?u8Is4SibJ9u/EzanInnRlKyZPN05CrLm0XJos/4Ab44lz0JbQkrPl79ILkuk?=
 =?us-ascii?Q?Gr15mpNNJO+A+sK1n8/ZiPmgQrPmir9hKvoHC6/WfhWhpehGUAJHD4yMBhpA?=
 =?us-ascii?Q?yIH8HpFrZQKTPnqYrUdnzB2f++N28RQMxmKMItj0GmbYpY0QrksQQo9P3kSs?=
 =?us-ascii?Q?s9ykAvnlwSi0GKyJsyXi67LtWddIuyPuV/sX1ukwkKdVPssqOfhErliHymk2?=
 =?us-ascii?Q?49mm4Iqu/3RbdgTc6OldLUPklKatacyhRnqut+G6aHJ15WBgdPLQHZu3MAK+?=
 =?us-ascii?Q?wn/Jm0J8HZhu+HC0p6IXh292yj3bv4rAzweequ1av8f3ay7IjIae3fP+9zqU?=
 =?us-ascii?Q?XByI6bdVjqWMib+GP5wHV/7+mJEyZwBmOam7XFHi8ESNvxtM5OMK/+IZi9c0?=
 =?us-ascii?Q?vJNNrh7M6YZRc4ALKL89GP8D6cLn574uz7P/thagzM2QF/D28WnfejuldAAQ?=
 =?us-ascii?Q?BUIKiOeuy0gp6VV3eyn6v5h4mzZdC+q0m0MfYPn0JZ3VRQpvBNQ/L9xtoa/E?=
 =?us-ascii?Q?jr12YA+BtZ8P8JsRUe2ZHNBGN4/oDELyfikceJ5jktWB6WaDIE5ZmsdIfrnW?=
 =?us-ascii?Q?UxvOy7F6e5bIOiiAyjfv2OL8bRe7mYirHKu340mk/U+OB1BQzHltlMCEkHk/?=
 =?us-ascii?Q?YLimTCwgT59qjUj+fbS6hhSAyXP+f8449vsCEPsmCzGhMyysRGtliTxF6yTP?=
 =?us-ascii?Q?PZ7HPBYbY1b95saMR+iINj/Tq1aMLBN/f+SsxEDlxz62wsaVm9duHCZvcUUa?=
 =?us-ascii?Q?BGum4gA0EkSJEQG/wsYZGEkrPjHAjxfK4G1OcQaSI3wk2QLn3hp298ivMBIO?=
 =?us-ascii?Q?2mG1OXvQGOS0mzWthShyvxBH37JDfimTdStrv4f3UagK/gY5bNxqc/F9Uoq+?=
 =?us-ascii?Q?JeEocap3SL4yx1umu3hLIFfgGqkM8dZM41QjcX2Dj6rHFVdVdxexB8WUUzw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5818d864-9566-443b-166b-08dbe7c473ee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 23:25:15.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR20MB7169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Fri, Nov 17, 2023 at 08:30:21PM +0800, Inochi Amaoto wrote:
>>>
>>> On 17/11/2023 06:07, Inochi Amaoto wrote:
>>>> The timer registers of aclint don't follow the clint layout and can
>>>> be mapped on any different offset. As sg2042 uses separated timer
>>>> and mswi for its clint, it should follow the aclint spec and have
>>>> separated registers.
>>>>
>>>> The previous patch introduced a new type of T-HEAD aclint timer which
>>>> has clint timer layout. Although it has the clint timer layout, it
>>>> should follow the aclint spec and uses the separated mtime and mtimecmp
>>>> regs. So a ABI change is needed to make the timer fit the aclint spec.
>>>>
>>>> To make T-HEAD aclint timer more closer to the aclint spec, use
>>>> regs-names to represent the mtimecmp register, which can avoid hack
>>>> for unsupport mtime register of T-HEAD aclint timer.
>>>>
>>>
>>> I don't understand this reasoning. You had one entry, you still have one
>>> entry. Adding reg-names (not regs-names) does not change it.
>>>
>>
>> If no "reg-names", all the register of ACLINT should be defined. However,
>> T-HEAD aclint timer of sg2042 only supports mtimecmp register. If no extra
>> prompt is provided for the SBI, it will fail to recognize aclint timer
>> registers when parsing the aclint node with one reg entry.
>>
>> There is another way to avoid this by using an empty entry to identify
>> unsupported mtime, but Conor have already rejected this. See [1].
>>
>> Link: https://lore.kernel.org/all/20231114-skedaddle-precinct-66c8897227bb@squawk/ [1]
>
>Perhaps you misunderstood my suggestion. I was looking for _both_
>registers to be defined in the binding as well as adding reg-names as a
>required property. Doing what you have here might work for your use
>case, but does not make sense from a bindings point of view as there is
>no way to describe the mtime register, should it exist in another SoC.
>

Thanks for your clarification. If I understand you correctly, the binding
should have all registers that ACLINT has. But for specific use case,
it should only contain supported registers and omit unsupported. Please
correct me if I misunderstood. Thanks.

>Cheers,
>Conor
>
