Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384DC7BC189
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjJFVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjJFVqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:46:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E3C2;
        Fri,  6 Oct 2023 14:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgRN7TGdkmeODkDIE4kXSLRI79n7IzTn+aU5/Zr2PR9T+iPPXNtuqsjPK0kMwN8DlORqETL5hEdcona88gqSbtHcuPOVmnGwc6yLjzIsuOLPbv6bqxG0iNXiLqm5iCzZNL21M6hBJnQincPW1yjHBDCVknQngerGwdBV1OzkF8mKGwg/FtGk2qRK/1M91cwDAlujwi82+Q9opYaxH97TePo4CqLNc/DWtV/8Y77PM4MPUITmPUvuuJT6IauH1CHwpAg2g4FM85yaFb6Bo6MANgL/luO8huZrX8ZnSchVQ06Xe39EFchsJNFbazuY8giDLfpCIodZNq8iJL39V6+/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP57sDKjvmaIva+WWlewlz0NZIa+gt0sC2OUJ7WAm2k=;
 b=nVMIjN7AN1mC1c7ClJ/kxTYWLd9GNXjQX+hVwM9z7xyLOK1Ap65hmc/ev9d2nsutUJce5HZR2uKm9Q5zSDZtC6O1Je9vUiJ2Uf0VUowtfl8EK26EMV6pzVBdyoD4i2Ks82za/MQZgGj8H9ECJFo0lfzgHw6I7gFrAJH8Q7mGVl3OmbKdkStzjd97awpYEr741JrtJDLSj7e7/hvuq7wDV6HDoNPwqy6vGlVya7wUbZgzrD9dNQub2AK2EkWWVXaytexAKBBDKJ87qG2DkpmdSpxjoKr448ozx83juhxQfUe3oNf4eXMLOypieKNloiTZ06S1WFPQnyFChXZfxOYTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP57sDKjvmaIva+WWlewlz0NZIa+gt0sC2OUJ7WAm2k=;
 b=NjUWIaUc4BtAMf3NeDDGBzJx6NBXGw1csuccY62Gq4B2AdMSipSAjfs0VkJZH/oBU7oI08KuiRiJAEJvWU6DdRj57ACmDC0gS2/EdMujqfT0JdYlCJ7W1wKKO59nIHZauZmhrI6TfAmuGcGeLWGtrsV0j8urZm2swdGyxXf0KeOM8MNALoh83O0Dbtjq/2rH/aF4I28hXFVZCiHZwfubOOnvi7ALaMw+hWzrm7z8DI0i+jm2/4H9/lrBYvl9ihqw4HR5zeZDgM+ad6Kk0p+BAc+F/NTKa2Hhtjj1QwtgO4X7VxFtSfkTTIsjuao6eZ+6E7qNSPZpn8rsrnU7YxAQhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 21:46:50 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d2bc:4f24:dc01:48e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d2bc:4f24:dc01:48e9%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 21:46:50 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     "Nabil S. Alramli" <dev@nalramli.com>
Cc:     netdev@vger.kernel.org, saeedm@nvidia.com, saeed@kernel.org,
        kuba@kernel.org, davem@davemloft.net, tariqt@nvidia.com,
        linux-kernel@vger.kernel.org, leon@kernel.org, jdamato@fastly.com,
        sbhogavilli@fastly.com, nalramli@fastly.com
Subject: Re: [net-next RFC v2 0/4] mlx5: support per queue coalesce settings
References: <ZOemz1HLp95aGXXQ@x130> <20230918222955.2066-1-dev@nalramli.com>
        <87ttrq802f.fsf@nvidia.com>
        <150cef65-1de0-4145-a917-18a3665808c2@nalramli.com>
Date:   Fri, 06 Oct 2023 14:46:40 -0700
In-Reply-To: <150cef65-1de0-4145-a917-18a3665808c2@nalramli.com> (Nabil S.
        Alramli's message of "Tue, 19 Sep 2023 16:42:27 -0400")
Message-ID: <874jj34e67.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf6cf79-ce29-457e-8836-08dbc6b5bee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4X2ifJKskpIYrWa13MPuPoOxcpmYUyckCL0OTmnXh4ygi3JxdpBmD7lx6luVstCpOs/HFcM/14cAXrhTXwbFCYRJENIiztS6OzPGOFCXiwNtilnbOx4f7ptK5N7cGIk7dwMuV6qVO46zGDiu5c3JKkC3x0cu6SkA8vOoktMIHKbCKHPFDBhOObxRQT7a2Sumho4weEQ54R8X8ACldde4DCBDpDpIxWHp9MoYEuVhgXX/IrhRrFbA8OJWpqSyfDhY4pUJfaqKC5DXYK4ZGngdZO+YyGxNPkLGdD5KDnXAXdpBo9kmL3l46zZyzaYlDiKW/TKn57KR29c+MZXLdcNbGP25TUbJSGezbbDS9hyBf2vrDsd8BXbnB8ptEIMUs7QBoQucJIoWRu+jYoRBcQtoIdt0sUPmFomIuButwJnDc24Zw8fdCPKanCkdA6opTnUC8jAt5wdU6uJEtaF09aojx7Xm0HQn+9g87SRMCyFt/bSfQ74rVyxOUDLG4/fn3DIYSgf6LS8Qm200tGDdm70AD+8NSssIlvMQaGsDzbEbauXsfxJzPlpHaF8SovYPcRinp+9HLrkoKGW1f0K5h8ZiMJncmoYK5sF4lp5sj0yHcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4326008)(8676002)(83380400001)(5660300002)(66946007)(66556008)(6666004)(6916009)(316002)(966005)(6486002)(26005)(2616005)(8936002)(478600001)(66476007)(6506007)(6512007)(41300700001)(53546011)(86362001)(2906002)(38100700002)(7416002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O63R3pZr7Kid5wgx03vPo9bqiDIw6wrGLQk+VlkdlHitdlOqYnC2v869LmPC?=
 =?us-ascii?Q?wM4knbgK4ddx8AAxQgKvfH48N2FsG3XI/nPoN66yK2qISB37NfEsF9qFqCBf?=
 =?us-ascii?Q?DiCzfUdeqJrTuiadlET0Rm2niyB/A1tfC4trHjxQBC9UEAeU7WyGSotH0pJ4?=
 =?us-ascii?Q?PZKZTfgpt5EfeD+CeHrSU13KrGT+UdGNC799Tz5SuTXqCXR7C5EhYfmqnoRJ?=
 =?us-ascii?Q?fOPZitwUaGPRt6qXL2fWms6cxOCeHY+fElF/Qhw9jYBX4H2NTwJAXDFJGReS?=
 =?us-ascii?Q?O9H8oTKOWfX+P03LVLslgMUMXZszWCfIuV7UU2xgbqcUaZuBPRbKSSKK6ka0?=
 =?us-ascii?Q?iCTCz08mQxEmIqX2Bklpjdz/9OqrtNhJXnX31csGmnLT5KMDLLrRjKTgHk/P?=
 =?us-ascii?Q?H8pLv3+u/2tvdOSwu5t9nI7XVN4UlLlBZwxEDgPyhKdmaoiKugfCMSW/he5G?=
 =?us-ascii?Q?cXEY3r1RX3TSuTpKJ32yiF9U2szW7N94NJx8G0aXVR/PySsjBeEUW+nYnTiC?=
 =?us-ascii?Q?r6QEdwSyn+AsNUmrhZoXytPlWyARhM6LcODophOgnUohwPhkHg7l2ZHUP0Zb?=
 =?us-ascii?Q?mHgZlUj8jJPWLWY4PqIiPfPcBw/8lIsddhkOOc0xa/CEjHGUQ+O//mOslaOY?=
 =?us-ascii?Q?xT3T2QTDu1iaqqxSDeajwxeB0dwrZgrL1uOy53ApLzrVpEnp++UW24w76uSk?=
 =?us-ascii?Q?FzTGLRgU3pwvBQQ/wGEwRP2wGYGHCZQx79fRJ63wr7ZVSTUogcqZZrh17kFA?=
 =?us-ascii?Q?hJ2mrzBdXt3HsuScTZI/P7q8TDvz+90thvW3Fq1F5bqm2z17/cyqY8yemPDG?=
 =?us-ascii?Q?Eny4IEw/uT66bQ5umwfpI5Rd6Qy1RjCa64u+MGEv8wWJTdbWPupXuFnpB6GI?=
 =?us-ascii?Q?8HY7N0z+h3paJMXnALavEKGzoWaueSQX7zz/p8CqmSuj7t4ziLl3jWMlIIFK?=
 =?us-ascii?Q?4NRfBlagU4DP9MnW5vTNwcEUJ2OHUYfgPKhb76WZrEE9fwbvDurthvMmQa8G?=
 =?us-ascii?Q?tGNselduwrY4N+lWIwEz7I6VXhHzbfUEunVPaIMH4lMIZAWKIxkyCJuogcYL?=
 =?us-ascii?Q?/lvWmvRgjxdsbHUtdX2O5SNziKC2biWsOnxRCTr3L9qW2o9FxTZNmwEJ70Um?=
 =?us-ascii?Q?IrChe+a+nhSJHj3k1qEOBtPrdVEtpQxpdOpxIKut7oiUZ136npuK7F89xyim?=
 =?us-ascii?Q?zysnV3nQ+QsdqxclquOjVLpBxy48GS7i2vWfxAiRCmFB1aNJlAbyc2N0tQrq?=
 =?us-ascii?Q?RC1E4tP9xNZZRmukaQbqoMIF9iGATNxVtlmgIkyDU5hUGJYKBZd3qRVCTAiA?=
 =?us-ascii?Q?E82ZBY+xSLpkRhAXXEKpVR+qRD9rk7vuvFrxFBdq6dYfMN8hqom4hq/GJeXT?=
 =?us-ascii?Q?/YX5n7XT9Uc5SwTDVKc+ey0+qD/u6JZcfJKuNIRR/AIU40DQodfWtjYNhZs7?=
 =?us-ascii?Q?3wsgiIqWbXzUppwFY14CyLp+zhVu/keh0bK66CCS5HjGZcqBH/Ttih2Xoobz?=
 =?us-ascii?Q?zlfKD5YIIVQ1kN8LaZ6KTwKrZjMJKanrQ9mmZ0CEQYLVH1+/wERn6AKO4GrE?=
 =?us-ascii?Q?1ejqHkpxC86zXt6z0zCPkXHLO7aWMC2eZsbg/7Ui/NQyQEwhY9KxncoBdpsq?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf6cf79-ce29-457e-8836-08dbc6b5bee3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 21:46:50.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV8VsPXt9PTymH59M0MzlUIR1LhH068q/o8eLF/YYpGSNEIdy85twunk2biTe0LD6DBNPqcGqIkw+OcMNi2j0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep, 2023 16:42:27 -0400 "Nabil S. Alramli" <dev@nalramli.com> wrote:
> Hi Rahul,
>
> Thank you for your response.
>
> On 9/19/23 14:55, Rahul Rameshbabu wrote:
>> Hi Nabil,
>> On Mon, 18 Sep, 2023 18:29:51 -0400 "Nabil S. Alramli" <dev@nalramli.com>
>> wrote:
>>> Hello,
>>>
>>> This is v2 of my previous patch:
>>> https://lore.kernel.org/lkml/20230823223121.58676-1-dev@nalramli.com/.
>>>
>>> Saeed: Thanks for reviewing v1. I made significant changes to support
>>> per-channel DIM settings. Is this ready for an official v1 submission or
>>> are there other major changes you'd like to see before I do that?
>>>
>>> ***************************************************************************
>>> Version History
>>> ---------------
>>> * v1: Initial draft, individual channel DIM changes not supported.
>>> * v2: Support individual channel DIM changes.
>>> ***************************************************************************
>> We actually began working on a patch set for the feature internally
>> inspired by your initial RFC. If it is alright with you, would it be ok
>> to have you as a co-author of that series that we should have prepared
>> in the coming days? We have some minor enhancements that we think will
>> improve the general architecture for how we handle both the global and
>> per-queue settings.
>> 
>
> Yes. Please feel free to add me as a co-author. Actually, I'm new to
> submitting mlx-5 patches and a lot of credit goes to Joe Damato
> <jdamato@fastly.com> who had this initial idea and helped me develop it
> into this patch, so would you mind adding him as well? If you would like
> you could start with my patch-set and then revert it and add your own,
> or if you think that's too much trouble then I'm fine with however you'd
> like to proceed. I'd be happy to test your patch whenever it's ready.

Thanks for letting me know. Adding Joe as well as a co-author.

>
>>>
>>> Nabil S. Alramli (4):
>>>    mlx5: Add mlx5e_param to individual mlx5e_channel and preserve them
>>>      through mlx5e_open_channels()
>>>    mlx5: Add queue number parameter to mlx5e_safe_switch_params()
>> We currently are working on a variation of this without needing to use
>> mlx5e_safe_switch_params for updating individual channel states (our
>> variation of the feature avoids needing to place an instance of
>> mlx5e_params per channel).
>> 
>
> Oh I'm curious to see how this solution works. I look forward to your
> upcoming patch, and would be happy to review it as well.

I just wanted to let you know the patch series we are developing is
going through internal review. There are some bits we will need to add
to this series for supporting changing coalescing parameters such as the
cq_period_mode *without* needing to create an entirely new CQ (modifying
the existing CQ).

--
Thanks,

Rahul Rameshbabu
