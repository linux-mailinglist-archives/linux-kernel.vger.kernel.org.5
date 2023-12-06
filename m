Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480D806CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377882AbjLFK6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377877AbjLFK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:58:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2075.outbound.protection.outlook.com [40.92.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520DCB2;
        Wed,  6 Dec 2023 02:58:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHcG/viNDxIrDQmN12kNB4D+2SvzffH8P7mjXmjfD7u0IneKY2W0NffBZUWUEd2ye8YvUC+QFCQQDmObFsZ+33T6thXvd9NmUFIqH4fdzcNOnb5DPg7AOOj3knvlIeunQp6yPsMrrLKLW/nxuTkm3uxvWEVF5rb0+A32l+7k/2K8khq3nop+HbFtWYaB5KsE2J36o2AUb3iGF4a4J6LQNE2MHJ42sByFgNlRWs6BcRxlZwtv4FKvn6q9o4V8Em/r+VpsfO85jnDva9x9NwVZKEJYn3WEHxPBTfcia7Znzc8w4Yn0zs1pkYVmtrLMQk3NWryM7hxdGMq01czIZb8AnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV2Je5NXPF65eLH605WcDrI/xhr/d1YXzYC85nKp0fA=;
 b=DzI6gQjBLt6zHyZgsi/wCSx5LlgVxSc+45eeh0jWv43zGsVDOXCfr3TuO/BRPT6xY0HDKl0iUv0qjJoQl/iXgoS4R5jUwKfbjZElUMAx9cMKpTnV7TQgPzq4GzQQlAxfb2IP9WZXSB6bjBgxwWOeF9n4s4xOA2ZN2237Mk6T//OY07EGVIcjGn++KV8wduX1ZXMdOo/9o5sZe/QXi8M3hOuPD6IT/TzI/GRyog37AozwabL7bTa7s4DGAC4LRlwzejyAbhEm6VLK68SvENFZ/QM4tEwbAZmrZJvfplKfdN4qBaDV/qByYxMm2queBujAyGAE03W+VG3Qvfy61yJ+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV2Je5NXPF65eLH605WcDrI/xhr/d1YXzYC85nKp0fA=;
 b=nyfJb7QQ+9/7AS5Ey8QcYpknItgDz89gG3D0l5guIaYyrPYHFvW+zOI9QbeXMPRn0LBE9Sdc0kXSIF9YcUpQUSaruw/7b/NvAkZyhGms/wbsWq8uum30U+m/dF+BkiV7L90nF23kLjHmKlDZwAq16exDVoTpxTCDcIe2glD1MtmVHiM4DYHRv+ysKXAqQ7ie9DdNehZrwgY7oWYqxXn84gjSbfddqTh3P1szx+mQUO3RKyRUyl0BjKfOl0d7u5Gq6DBUX/9GQ5uJdefcegCofMezs3YzZLciZPVArnzQ7o8Z4DaGo1XUxXmqvAhBG1EJb9y3ucfJUZG9qlOun4U5VA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB4863.namprd20.prod.outlook.com (2603:10b6:208:3c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 10:58:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 10:58:16 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
Date:   Wed,  6 Dec 2023 18:58:11 +0800
Message-ID: <IA1PR20MB4953C55E94B9F020872FFE90BB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f42248f1-c8fa-4ca1-806a-94c06cba8689@linaro.org>
References: <f42248f1-c8fa-4ca1-806a-94c06cba8689@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Nw/7bhyGp8sYetpLAoOeNzhvvTLRBJKXHhDmXwakh1M=]
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206105811.781975-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9684a1a2-c52b-42f0-e9c5-08dbf64a3f46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rp6u9tD6sqn4+d3Lp02DBTt2YWK2aTP7VU8loGUy4qW3zo+4Te2durbZpppE8pnIrBV7kNMkjaj5tM25y9rTqwTNZ5C/1o7qf+mbpdH/T5CwRfNRjLsTim2vGRh18JLuzEW97xawUUWOjJu6N/ZMLZGghTmGD40QI7Wm1VvheomjMXwQEmD/CGIkpi2Oy1NW3ZyJQFn62mMjuRa2OFyQ+h9rnE5MJakirMNimhLgsJaBI79+GMe3l/zkHle7mAFZJwtdajdwxvcZ7D/DnIzmb2HI57WKfdfcSXh8DDOR/XCoHENdPcn7TcZLBHyFxCRScCoqmQ87lXMVdVBoHYqWBFt1o2IqITOKhjmW533DdrBmPlf0whXzVMWU341UnR6/2XoCgHeWLxlGTF2BKi9GhgqKK/4EWSyo0oPKSOendaFae9BZi+ewZQ3/cvsFyA2xkl6xeueDe/5EakwHNImdjnZaJnmUvvEJleFKxPaNEWwWRYd6rOCdHFdDQ4BGhuEz19DaIHY1XS2PBnFltP5Ofns3nMUpsreCwz5sYNic1KYDHJTMV1xLmTiHbsxTENsnB2lubvoQpgr8VzGH84E1nP3aUn/4K/zduFONJB6+GvJhbQtMIq48VNJD5PGRLsFc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6okzgXVzc6EUk3JEPNq8ifWBx4mrjcesSHvpta8yueU6P+njSVXk5FMbE5kc?=
 =?us-ascii?Q?33aPL8p8zmVB2dcOGFMX4Ba98382MlrsdpxihEcg9y2yqIqDKWa+eKvuUP1n?=
 =?us-ascii?Q?SYaFDiDBesVoNvqWU8osVZuZKh7e5qh2/L1UNFUFeotG4e2bEEd5fimmZesh?=
 =?us-ascii?Q?4YpSgbfMxWi1hsdb6qKAb24sdirlaSSNtl5O20B4SWerKPkFxEvVWY3zq1Ed?=
 =?us-ascii?Q?ZFKyu3jYKqMluYf/U2yEZMKE3p5OBzrp6b0JDIILapytp1TVG9SuiLpo2+/f?=
 =?us-ascii?Q?sdKEkcKFY1zKQdI80v5AVZ2Av1Fly2bIH9sHngQX+ka9K1ei4zZL3dmN8Q6m?=
 =?us-ascii?Q?P1poobwSpSSPYDd6A+paLbMbWuOXw/LsON9FSJpmarYJrmUK1GQf+M+lSoOG?=
 =?us-ascii?Q?YYGX752ICV9KXw7JY6DxFDj/Q7DVei7yaCHU7WmJ9TVCPAtJ9mpDkO5Y+niz?=
 =?us-ascii?Q?Xjmb0GkUubgC7I8cpInu1FvIB1/T1grLnQZ2uC+5UM0rvCKSQOoFbC7yWn0S?=
 =?us-ascii?Q?7HyiNWiqR9vRbdY4dbnItgjKrimUu+QqJdYAaTcz+rfhTYSAJEB4p254nik0?=
 =?us-ascii?Q?HA0Q+IOzKrfH0nt92/vJkfdjP0GrDn8U1b+RASb/RO7Elgvud2i7aoAr3D1m?=
 =?us-ascii?Q?T9bfJyj6q1ue+RCt8zHSon1osIylechQ9Janxd+0SZH555AsPd6NzMS4n8el?=
 =?us-ascii?Q?ucspxSdK38GO7dOjkysuoBMzCTE6sC1rApZASpVBEHB7ywAiKjc8sQ/tsMJB?=
 =?us-ascii?Q?MiB1C9jzFCa9o+mQGVr2RAfqp+OeH3ZsVHzZJWA1R5FLVQDcL7nvTds+GuMU?=
 =?us-ascii?Q?9syyr8/JUoqDLajLPj43eqOi8mELPNyMOXMGoQfK1avAVJR3Ug9DJOK3A7he?=
 =?us-ascii?Q?WgH/mqfbtIxbg3hpowSV0WIAFspwo4pSUxe30TT0RHYFibUYBJN5BxJVe5Kp?=
 =?us-ascii?Q?I7YwgUlgNXBxbzJDkDQWP9Q4z4TQxSkhDYxE2jxUx3+E8jJ7vzTe6VhpV9cE?=
 =?us-ascii?Q?lOio1++CfUGe4DY/0iR7CLmA9zzOx65lteMsrpNguQCn17o4w5X53iFvPgoi?=
 =?us-ascii?Q?nrsI0473QrRZ1pONoAS69KOdAkvtqdo9JXFX/cR6ZvxlEz5RpZF30nFkTZzb?=
 =?us-ascii?Q?Hkx1ahxmRywwggx90UAIgXU9KActQQ7eX42NMFCKVevW0V2pRIxQcjL6X+ng?=
 =?us-ascii?Q?0r5FSAEEDpcfr3FfEDTUSBW+kVlYplyuGYz7gwb75pqXkdf0jQhAsW5Cmj4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9684a1a2-c52b-42f0-e9c5-08dbf64a3f46
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 10:58:15.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 06/12/2023 03:04, Inochi Amaoto wrote:
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: osc
>>>>
>>>> You have one clock, why do you need a name?
>>>
>>> I am not pretty familiar with this. I just wrote this binding by
>>> referencing others. Maybe use "maxItems: 1" is just fine?
>
>No, just drop clock-names and get clocks by indices in the driver.
>

OK, thanks, I will remove it.

>>>
>>
>> I have referenced this name in the clk_parent_data as the global clock
>> parent. Removing this will cause driver broken.
>
>It's not related.
>
>Best regards,
>Krzysztof
>
>
