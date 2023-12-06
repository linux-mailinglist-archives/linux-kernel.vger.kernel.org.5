Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED0807ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377369AbjLFVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377309AbjLFVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:54:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16B10C4;
        Wed,  6 Dec 2023 13:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnFcSiiF0Ne9odh0DXAsgmsodGrkpJKuiiITDhfchgcbgvvQpgGJrPQD9KEE3oBEhfOtpiGe5YWblqmtgxXI+wcULGYhk79Ib3iNoHbSOK+juK4usUFY7xwWuS6hAg6MAEhqcTj4PpUK7mvf+5c/KcZFHSbwQBGXatgvs/zUyhz6QVLji6EeUzIAqRuCOQBvVosUTWtxOw3iD5obqGkkNX5880GIDmWuwfWqun50fTKybK8l73Gt2j28wfG6ITWQnOBaOFkg2wN13H4OSYRfavwiLxwmeqdi1lYsbrRk5uCsdj3NoGG1B7slzLrThO0APFyo91eW+VEFsZdDMP6zPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddRBmLsU7Fgh0EYx/ZY5RT7OJTj329hxU0m2SmyinnU=;
 b=QuExojh5puIyUZCmakUcJYE8N6qbtKruCuR89bbh71FMvHxcLvlXmCYcLTUnO6kWI8DdpqCq3SXAcFOr9kMqFE2p4CiAb8fOg6A3f9VhlWZpaKBt0JldOtk4u6PjrQNqMRpk5mNaCURK4N33TD6Eo3diJKRTXcZwkTK5+fueOUphndwmn/pH7wxXZ9xmWLDHL0gyAGCqp8R3WagY5T96nmjZGsKEilkSEU/ARDOwVFZfuRDDJlGbN+qz4NkQjhdsvKXlweKwclTZq/F+HwI9AsjFcexDPjJ5Fl/cAbVEUJH1UjsBGUzLbXrR7Dz4Tz1D2d8YM6PS5ji/yKTIWXQKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddRBmLsU7Fgh0EYx/ZY5RT7OJTj329hxU0m2SmyinnU=;
 b=bBnI2Pth6nzuDL4VYZ4T3RoqGyKEvemdyZmld006Eph22GIpaihFgyKSoc4O5ZxBil5hK64xuIcHYLDIMPgczfcQyhthIcjgSrh6XqakQV5w5nAyvkQ/FtWTJW8dWlgEyzH5MTGGMXx8sZOd9vX5IPdhtD6akWyvKaoDccdhKHvYVrArVz4uZainNp4KtyhrlKEP4eq8yCWBJe8a5NCTu9299EzmXZNNhUmHEZL4/uBanKJMPS/yBM4ztuTKIC4FmXEvFXHAZ/GCu8lbT/BV1RnMH6tzVJupNMG1XqP9dmb5kEQaFN3rQTjJQfXp+JKnNDr2c9L8w43ZDKTiM3YjGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 21:54:32 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 21:54:32 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Input: i8042: Add a quirk for Framework 16" laptop
References: <20231206212140.7458-1-mario.limonciello@amd.com>
        <20231206212140.7458-2-mario.limonciello@amd.com>
Date:   Wed, 06 Dec 2023 13:54:25 -0800
In-Reply-To: <20231206212140.7458-2-mario.limonciello@amd.com> (Mario
        Limonciello's message of "Wed, 6 Dec 2023 15:21:40 -0600")
Message-ID: <87msungfou.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e510fbb-2fe7-4be8-e827-08dbf6a5ed6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/6N/FVPyb5TYqEqQfA0qaWPYRd6DZMumLasaOIdb8g10dYH1aax7Ds2tAxGM3EnZkc/fVqX7iUaoMkc92yyC3eQ9hsSDwjSfEO26YMTgDkAnFJO8iCXwzO1i8cj9/WIxPR2y2e1DcUKzCgT1jmy/6s5Cu1fTonMhN2dDdVQUYAg7ORY21w+FE3BwYxUJMS69z1xfIIIyesK1ZFS8QBRJpDlz3vTFGhWuq3Y2c90Hxgm/dBWc78bXnMHUZoA3esNc/BsGVZpNSZffFxIatGEQk1ZLgx9c2LzTvCAPltXw9UVdtGjd3ULsVxc+KSOCbIdE8qpYTel6S6SFowJDpJgPW6HlaRklrt6W12y+TimcajZ17GSqt38kHPrIOjdny2OtQzyT+/3LQH0uAKKWYEFBkWJUnXZwMyvBGNJN7oO0sS1UKC5eutQlVAKRx4sx1gH9JHh947IJ4vv7FoRNE7isZIthmyURjn9m3DD54FLxT1P2SGO/kjTq6PUnk2xCU0PgdidW4UqcH3x/1lxmJAzwRQcA87T8Qz2tFtvZBlvY+aL0pox6sT5ya7VKh8tmZm2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8936002)(83380400001)(4326008)(4744005)(8676002)(86362001)(36756003)(38100700002)(41300700001)(2906002)(5660300002)(6506007)(6666004)(6486002)(478600001)(26005)(6512007)(2616005)(6916009)(66946007)(66476007)(54906003)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIvZjgg8pI8EZaqJ9pUgBymX89Fqru3+yjJnalngCqTFKSQPF8AqI20Oj2Lh?=
 =?us-ascii?Q?TxmqmSnL5ClwrAnUW8uJ/FI8FoKgIh7EraNteWwj2t63uDm27qete2s1cORr?=
 =?us-ascii?Q?9YR2etbA3w9OXfKr1djfb/B4Nm7fDJW2gupTZtlHOWLJgq3P6YGUWY7/hx06?=
 =?us-ascii?Q?YL0E7cQxajbRgdzF1tLZPxf69Tk410sBYUCjL3AvXHwYG/E4CKfaAEtyqwLV?=
 =?us-ascii?Q?wNUUGglbKmHs5rC5HTg5+G5gN8FFEJwk73/N4kFxWPL+yCytldvgimNYuuVK?=
 =?us-ascii?Q?AZS7q7embsrrbiIaj3EUv6aFacBQe0egEW58wzRR9JZ8sQJ34EJCCy5FRwcd?=
 =?us-ascii?Q?wvhgGST2uLFNAAtraqJ7IXL39O7H0+CegmgcLPuCjp1gZcUImtcD9aobq7NC?=
 =?us-ascii?Q?2aY2tsYXuvlxnRvO3+m9efmMhnLjV+cz85TvIIuMedgmD7+DpFwvaK9iDgPj?=
 =?us-ascii?Q?uVY8VBL5hGObuKBVTdMRVOPq8gB4nGD/9Kg6A0ZhiooDxAtdJ6SKATZ+Y4Vg?=
 =?us-ascii?Q?Uaprhuu1Riww8+deKF8i5y52leacQ2XHk5+pE7Xrxe6UoxS4f2zVHrg7YfwR?=
 =?us-ascii?Q?PM3GZs5eZqxgIJioAyS1tmWx/aSsWBA9V8RWAkwI6HA/uZ+1cOlFiymQHx+q?=
 =?us-ascii?Q?0JdW0vL2KxOd97KC8+kgBhdUoFfo187blxZfmwXK3V4hzDcuonvWPk9AKGfS?=
 =?us-ascii?Q?bCn1VKx7HeHiUMNb2t4x3j1+FcETnXCEV+RO6bC8/qBbGU7boI9fTw9yF1lA?=
 =?us-ascii?Q?Ip99YXzSX+Jqc6GeNsbLHx5JIqFCq6Yvp5nW3LLaZKFAgxOOoH3gZUfCms4g?=
 =?us-ascii?Q?mB4hQ6l46RjSLV8F91U5L94Q7Z2xAWrWWqSzwQ2ebn6z/QAaJoFXCuyzOT9R?=
 =?us-ascii?Q?WWUvtMsGXqkfbhuCx1oQkrQvyVIgK+IgVvivNYdAxM+5sFm7A71E5UY1nQGn?=
 =?us-ascii?Q?quXD0RvHLFj80eO4MnmV+hWYYQ+TLjs2PQ9v+xSGrQmU9FgZ0MCWKHRdeBbM?=
 =?us-ascii?Q?Qemovq3umzwNZrpioqTL0450OB9e78wWOL3XG7XWjwxxd1x7/NarfsXE4Dg0?=
 =?us-ascii?Q?P7XWAQUyIbiBrKXi7+YFsWWfCuWuECOvsQNOPZWyBiEx7z1Wn1/8h7S0teCC?=
 =?us-ascii?Q?g/zk71/nfM1TS5XHQt0GZvggbdRaoeePvKKO0T9qqJnA0sY8rjmlolXDCZ8a?=
 =?us-ascii?Q?g9su0GajMHf7cjE0Q7E0P61lIdTSZmT7xvd2kl9EG1K4GLr+70SxzN37ea9S?=
 =?us-ascii?Q?fB09+2i4V/uBXYZC9kDDzeZ9t9G3k4K4sfY5PWJoBhMqDHBc1MAfhUwnpB3p?=
 =?us-ascii?Q?5Dq7Q9XpD2RC87g57dwXm2PipXEVisk9tFr/hCqIUlHst0iA/anc5U2fG1a9?=
 =?us-ascii?Q?s9RXrGMbCE8S0/HKSGI/er6A1BP7l3j7sC4iZRRg5h14tZX9RLPW95FhWgPB?=
 =?us-ascii?Q?y2Jqw5ZywdmJwMavhQxhsQGCieKOYv5visb5gKtYVd55/51SnqNWxa3sYh96?=
 =?us-ascii?Q?HojH//487oWV3Vm2FsJkmOWHszzpc8tIZYMn9L8r5xk9GqP+HSxuiDJRcl8C?=
 =?us-ascii?Q?9dVC+X4f0Yh4xZm82wm9Ht5SJs8rskVbNp+9mp44?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e510fbb-2fe7-4be8-e827-08dbf6a5ed6a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:54:32.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7tzgKoj8ql5Z+kAO9FHKnHI9mPG5qxWHp55cRLz/QHx+yyfx9AQe/gfTKlO5XhXqzmCGzOTAiwYBXsKGDcm0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec, 2023 15:21:40 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
> following messages are emitted:
>
> i8042: PNP: No PS/2 controller found.
> i8042: PNP: Probing ports directly.
> i8042: Can't read CTR while initializing i8042
> i8042: probe of i8042 failed with error -5
>
> There are no PNP devices as those listed in `pnp_kbd_devids` but
> i8042_pnp_init() ignores this and still runs and will continue to
> try to probe.
>
> As there is no PS/2 keyboard or mouse in this laptop, set a quirk
> to avoid this behavior.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
