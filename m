Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B88077E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379183AbjLFSqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379152AbjLFSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:46:41 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6486610C9;
        Wed,  6 Dec 2023 10:46:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOWr53mqnVzcyzI4GJSijoSPgu8/HFnOE9qy4f+LDQyR7ERDGMmpRGoSPw8UaPuYpanU8p/ePEQ1mTEq9bYAxQwmDk8FQw+gEJI+gEr63xFN7aBizgyfiHm7GHUezRJSQmfngK2YqjM74esD4sSA0qVKE/e5aa3tsbX9qLmilr9+4QfKUUxNX2WngpPH11FF4dPgqXUzrPbVs/nceT7O9wIbRzfGcE4lPDzzND62AunMQWOHqXrncmO6e3++fq0RL0iPvgZf7dEzzzDjob2jblaveNwow7PeghWkByxKCQo9cMaa0hGz11fzQWOLYUZks8xyuUlJtUQq7985cYsPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDdwhv1Rn+2IRFL8jhpO4NOTD19NFwrgRhDzzBg7lxI=;
 b=n1nyQTa/qT361qwadCUBzzynxtWvZ2/DRlm27XiYw0ofjeVBK7MIH0cROWICnt7hoe4A9rGy9CJkZvU4wEC+ROIbY01/t0EAi6V+9W5zs9zJ1Eg6YnpxOT1C9tjxBbdz5cgcoCO/XkgC6zNIsJmipHMSZ3JlOtrg4uXJPob0V4wpG2JJ1qUJQBI27Q9HWwTU9FBkmtDY8eXl/4G+qycDmwAQI78eaTWU5my8aVPIjsJ4DotkrSdiZFhJFYQkwsowqF6NObT0lL+rHXzdhEccjtX8AxJqIwyPo348NB13VZbVyEmqcU+AuuCuB1WR/ze0R4tMagddwY/7cHEO2TZxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDdwhv1Rn+2IRFL8jhpO4NOTD19NFwrgRhDzzBg7lxI=;
 b=arLca5+dD2Pqh+R7LM3cKH4OYW8E4jnwsO2qieGei15CiA+ffzlT0PcU7DlGBXVKszltLXRXhzI5lun4qQuGopQi6nbXch5ss1IW3Ttu3P9/41dwQMLzhcQLDcQRIxz2kBokUNfSNB5qdTsS33ZbDq57poJIdWEyi+aNf/j9X+HdkspjB33/0RWMssDWY8QyHIaGxzL7VmRK8Fyafc8d/VB0DCtJappn3mD1HnJfmWMwnwnkx1VjPRtgbeAHUjtSiI5wmkjn3iRpn5OhqdAgbRLDRmpxKSZFcHhgg4aNIfLmhlTJEEanPTGQAAbhZmSv3gKETC2gxdAzKY3oqhkdjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5276.namprd12.prod.outlook.com (2603:10b6:408:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.36; Wed, 6 Dec
 2023 18:46:41 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:46:41 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: i8042: Quiet down probe failure messages
References: <20231206175818.2568-1-mario.limonciello@amd.com>
Date:   Wed, 06 Dec 2023 10:46:27 -0800
In-Reply-To: <20231206175818.2568-1-mario.limonciello@amd.com> (Mario
        Limonciello's message of "Wed, 6 Dec 2023 11:58:18 -0600")
Message-ID: <87zfyngoe4.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5276:EE_
X-MS-Office365-Filtering-Correlation-Id: 79505db0-d844-4db1-7c71-08dbf68baf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztuz+2SvEYxjyDb+vGcQaXitHeqvLetGH7x7raLSasKwH56sBjU/j0TVGJu+/u0cB2ntVqvna8+6qqo/xx+iQZXQi7XCCjgEQEhIW6n7xcadVt9OGo6NR0+Fo7AuYgtYCPFvh8kt7FN96Wsu9zgbuDBWKAB74BP6O3eaUgYRmIqi+ZwyUL2jia1nwnYGjL4iCh8VlOP5LoRwhwlVUUhiw0EcdeSwjEP1PqwBJsIlnLuZxEg2eXrPsAHpieWiWmIXlOtNWszFoLcH5PP8zvIqf+WV2D1a+/A94abDzlFuBGIFZpVhCWCYMJ7eOR5cjgW5lnjYPpv78Lk0iZMdJ3hWtQW+tM3iB7u2ED4kQUg21KEOb4C8pkhJRZ5t7la3uIDE3/woS0IWtnNcMtkKQXVw6Kz0DBuE9SPbqxtcFNQwideQa4mPrYRIUUKnf5aAMp1ZNGxp9+C3PHf+qsPgxcFCk1/x0vlZNf+pFlIcXvftiyW/jqqzZIGO8akDRf4wo74ocJzc578B5Mtk2QIIAU5w+2ciB48toHy1CJk4U4eQndjbx20oQd5UTJp92xbraeOCduLg5qQgQinjbF9mdS6iuEEGHM/Bty9KwlDlkKHkPUUKmCc949LJf/ZvUJU4YGlt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(6666004)(6506007)(83380400001)(26005)(6512007)(2616005)(66946007)(66556008)(66476007)(54906003)(6916009)(5660300002)(15650500001)(38100700002)(41300700001)(2906002)(316002)(36756003)(86362001)(8936002)(8676002)(4326008)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?938OqVwgyvNXS6ETfrAqYG1OJfvJoWdOyFMTDwRsoH/BCVZvLPdizwNX3c9y?=
 =?us-ascii?Q?Xfc/D6+I4Yo9xac1NX8nenE5LnaYp+CFgHlzJo0ROhr5B3VzRowskU2EW++t?=
 =?us-ascii?Q?3REIM42oFpxeZsUrVfEYSoJIBBu71VlK6PymIBqgR5YWh8Jnim/DDamVz7ce?=
 =?us-ascii?Q?CEtC9R2ghBZcWMpdCFZ6eoNpWXGeJcUu6PMJ8a/1pcE1AR/Q8eviwWI3T+rg?=
 =?us-ascii?Q?f1kIMrzA3mUvnX7cXm5vOyhLZF0P4VJ6rAu+dlsHssGfR102uxfxMqBaYPsT?=
 =?us-ascii?Q?+a8loGguoZ93eJcOUesOG6X1qgejc/W0+f37NTS6XurXV0wy8rCY14IyYdWK?=
 =?us-ascii?Q?XZZhGQKejlnuqptt55/dj2Y+V/JKLzLkBmNWHfKCTQYNJV8TiyZvATo2pZ4c?=
 =?us-ascii?Q?1KP1dtWsGfx03HGrdhQpM9xb8eJo9CP5yz3FRyhC4xDXRQICtvDFvdCA/EJt?=
 =?us-ascii?Q?L8zo3a63iHbNO/KpUFKswKN2V3nnhjMkID3y2WnhVb2uyVC6TyI4ve0zCs5N?=
 =?us-ascii?Q?ctOsq8ysdYdpO3d5H6nGXp8BfdMBEisQNOpo2OzxzL+R9p+rMQ5+auRllm+1?=
 =?us-ascii?Q?TjQ0EOv5HphtbTPNSR1Q0RIOCYv4G7x2v6t+kxDaVh1xsBwQFRLHdxu1JziM?=
 =?us-ascii?Q?mIFtKVyPdGqkW5Ch5ON207Wzg60Uw5lv1s15c2+Y4a9c2VRTEawlZ8hTYnBj?=
 =?us-ascii?Q?+3twNL1VGeXbU6OxYntRd9yRSy+IPBpno8kcs5Ouz3oBB+OA63vdfFVypKpK?=
 =?us-ascii?Q?bjMJUudTqOvt9xCqNJIzkgSEyTjuC1c6YIUJFCEs9uTWXVg+R8rdEkexifyG?=
 =?us-ascii?Q?SbxEyzKpPATZLGgk9zdw3CiL7mPgqsct8aAzcZqnTL7bprtUh4JASc3LCyCM?=
 =?us-ascii?Q?QMcZDOcLO0VJ1KELAlgwNB3t4VckdSOQw8m7KPaoJdPF5xE/1/YjfGPYtF2d?=
 =?us-ascii?Q?3LM9olT53GoZV0iTAR8Azoxca1JOp9Nig4aAG6mdFpp8cnip56OVRBHrda5X?=
 =?us-ascii?Q?qwwF0hifg3mhnpXJ/RoT2BcrdePWIBrvECw8tBsI8tTrfnR75Lvqev4n6qz+?=
 =?us-ascii?Q?3qCGDz1ImMzJC3ENjLAYwdUqUtAYFrCWm6rfd+ZgrniboWtvqErAawTVUvRx?=
 =?us-ascii?Q?5YoOPbyLsFTipH/H5iFLevKpO3GQaVeIha+KWiDOtQoXQYur1BKtm6oVMYWa?=
 =?us-ascii?Q?eW7yYilJ8lMeyWRVRqc5stKnGGeQ1CJqs4fIUrWAKJ2ElPO4Bhmg6YzLW31W?=
 =?us-ascii?Q?Y8i6uJFcvAhxEXXzQZYI4NXrtvXixaE64CMoSlAo+KXp6GIBDEam42EmAR5y?=
 =?us-ascii?Q?0PZylxhdI+CBH1QUTiWhqyYkHHULbOh7IkB/sg3wEr1JaTu4Du0Gn7DSpA44?=
 =?us-ascii?Q?i2ZyEEt17mY6YXH1Typfvfo8jTkJaqqKXHEl8nRln/RzvHrn0FT/jmkkBlzW?=
 =?us-ascii?Q?gQ1DIApwc29VkmaoxR/dNtdKAqFPQlAvn9K33ca10Rq2ei3U1d1c27D1NDrA?=
 =?us-ascii?Q?9YXwSOM8BD+TlI1+/bPa9+RTkpNOLKc3th2VwcQ+YBH6k4RKOgJSqMgVFaoF?=
 =?us-ascii?Q?Rh0w89yEDCP/wXC7CUf4c0QywBN8SvQuBD2YgYfu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79505db0-d844-4db1-7c71-08dbf68baf9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:46:41.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/h6fcFMWkZP4qdDFpC8zTBz7yGPzHqvrEYKEbEwdcm74bQ6gMPZbCJreYvweer+IjCmotgT+DoTGxA9mQmUHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec, 2023 11:58:18 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
> following messages are emitted:
>
> i8042: PNP: No PS/2 controller found.
> i8042: PNP: Probing ports directly.
> i8042: Can't read CTR while initializing i8042
> i8042: probe of i8042 failed with error -5
>
> The last two messages are ERR and WARN respectively.  These messages
> might be useful for one boot while diagnosing a problem for someone
> but as there is no PS/2 controller in PNP or on the machine they're
> needlessly noisy to emit every boot.
>
> Downgrade the CTR message to debug and change the error code for the
> failure so that the base device code doesn't emit a warning.
>
> If someone has problems with i8042 and they need this information,
> they can turn on dynamic debugging to get these messages.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

For the Framework 16, I think the following should be done.

Use SERIO_QUIRK_NOPNP for the device to avoid the PS/2 controller
probing. You can find examples in drivers/input/serio/i8042-acpipnpio.h
under the i8042_dmi_quirk_table. This will prevent emitting the first
two messages in the shared snippet.


>  drivers/input/serio/i8042.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 9fbb8d31575a..95dd585fdc1a 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -1008,8 +1008,8 @@ static int i8042_controller_init(void)
>  			udelay(50);
>  
>  		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
> -			pr_err("Can't read CTR while initializing i8042\n");
> -			return i8042_probe_defer ? -EPROBE_DEFER : -EIO;
> +			pr_debug("Can't read CTR while initializing\n");

I also think this error message should be pr_err in the situation that
the SERIO_QUIRK_PROBE_DEFER quirk is not used. I think what you are
likely looking for is avoiding emitting this message when the
SERIO_QUIRK_PROBE_DEFER quirk is used for noise reduction purposes.

> +			return i8042_probe_defer ? -EPROBE_DEFER : -ENXIO;

I do not think this change makes sense to me personally. It is indeed an
I/O issue with the i8042 controller on the Framework motherboard, so the
error should be -EIO when i8042_probe_defer is not set.

>  		}
>  
>  	} while (n < 2 || ctr[0] != ctr[1]);

--
Thanks,

Rahul Rameshbabu
