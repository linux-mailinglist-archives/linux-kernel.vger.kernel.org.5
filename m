Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC778A148
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjH0ToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjH0Tnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:43:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471C189;
        Sun, 27 Aug 2023 12:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF+XbKUw6ec/MW2VurdMbDN5nZ1HaClQj80+svKIjVlaIfdHaPnEbXOtSkGTqkGSAqEfA2sHdM6I0yxvke7WGgu9sHQNQ3PDrhquJAHCrAP823caQTcEaYQMg78Zq458hrr7UWGuUH26mUC7QLNKhkf3gqS5iixhIegSiWcXl8JUcESkS/UWdh0KJPMCnvkBOPiaX0vLyNswnM3QG/fz1OKM9vpSXb8X4plZGZ01oSKQFO1P2Ka+i/xDZpwLI/UV3h73PT57M6zpG2k0dzugzc1R5UHSKuk3KaZLC8vprjY4nh9TK4aMKq0jS4T9e3lukS+KNIgPKv3rQ67Ybn1YRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOVax7237eMS0vXgcLV8ifjXZ/J9mX+15qTZpsBSUEM=;
 b=iF8akhX3Js9N5RnFeRdFOmxf7EnzGOKbgSoMaTG+pzAvKqvBbSZyeyFBvkdC/UmViMGP5+cms7zbffVodIhOeoUWh5z5mXw2u7WlCE2bm43PUufA/6EvTcNz1/66/i8fFxTWAOiMYZwAFrb09njdcdvreHZEevNs6V3fqxVS4oLGkgMkzFBlxhJvnvwPc25q52Zqa9ICMI0go4IQWXeLe/DvPhalQgHi/hdY3RxcFawXPsTCAYN8Z/2vG13Rre4oIMBy3DZpRcYDanhKMyB6POo2qkfqo5EP1aILdnSya9Fstlj3+i3kiYyfc63LtRIYOax0gi9SPJVfFbvO8Pma0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOVax7237eMS0vXgcLV8ifjXZ/J9mX+15qTZpsBSUEM=;
 b=glX4xrFVmj3S5OpjJJLEGCY9moM+cdztggoEWmkvTMfpFPx9M4Vjthl8Ey5Nqz8ry+vLlIszMAGBNpROtoJ/RGQWOtLqAUDI8jdQVCkkMg3WukZzYab3A/EI1qsnRF6uzK8Lqr0ZwvAuMFMnNqBehQcvnirP2r7jigiR5B5wiMSOo77ZUy8TtcNYtVoxyCnXc0nBN3ezI109jsbdrFWuAsr93Hi63O+w25fmyfEo4iLddYaLBJ6HV5HEnFjw+HCjl/L7lLj6ciOUmWNXdYRKgQBPWRf6Ns78hASBReBxZu5imxnlP27TE3lQ5xlZ/ohk8xCwI9XJx5cLuyl/V3i1dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 19:42:33 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 19:42:33 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] HID: nvidia-shield: Fix some missing function
 calls() in the probe error handling path
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
        <443aef6a6d90011e8fffcd43e1a88cd9e98594ca.1693070958.git.christophe.jaillet@wanadoo.fr>
Date:   Sun, 27 Aug 2023 12:42:16 -0700
In-Reply-To: <443aef6a6d90011e8fffcd43e1a88cd9e98594ca.1693070958.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 26 Aug 2023 19:42:18 +0200")
Message-ID: <871qfoqnl3.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb52a02-18fe-4c82-e9bc-08dba735c1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NplNj3S0htVOBSVVPD8NFnIVnMb73RvmaG4yAwJGwVOYd1r9wpiD3XgCt7ie7iPiulIYvUPa1dF9czrmBfo98ye5EIVqsRcr0jRagu4DKHgvXCx7i6XZWOUZsf/vfldjbdqRYLv0HISfHu8NVKD5MibuWVyPqe0RnKZ+l64Ob0Mqx5h5E9cv7i8Q+s6X61AQoH5VU84RhfC4VfbcS6DSas6w+FAgK1bwleSRBB0sMcxB1nsyLRV1Hn+pFb7dMeUsjEOMOJCZHGhIwMUjHsWfI0nlj+QUycNRJO98UuaWM2en+tE9kDANKjWFEwMmsmb1DOh7O7dUnlt2GnROpC6kcIOS0mVAXe2y/t17iHiEu/7BEsLbKGJUZ5XXKTKBY5slFWMPxehHn8oL8iwOobGajBXRd2WNwQjphEBNNJcElHUcQT0GJBsg/1xGXLQTT6pTkTcW0m1wfhsP7Z6fR5xHGcE+QOs6fphFWehLlrrJDGTWx8J58u1M5GH/oQIUTOFg4+K5ODjFiQVLQrCj3wmr0vj3QlJVFTK+ZVzPxk8GUhLJI/cWnMVgzaCZOhC2agaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6512007)(6506007)(6486002)(2616005)(2906002)(5660300002)(86362001)(4326008)(8936002)(8676002)(66556008)(66946007)(36756003)(66476007)(41300700001)(316002)(38100700002)(6916009)(478600001)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8nK4zLSsuROY+qYu9sLm+2/KxJ1idWF8LCWzgU5dMKsBHQ9pFneP6hGthXi?=
 =?us-ascii?Q?7kceSMb/jXLsJKBlw0C9Rpa+zyIFNLZVANDgvBJvyyfiQzhqIJw3Y6ILrmCr?=
 =?us-ascii?Q?AExCEVp2w0OYkxuFB13bgqjbJ/mKt8tZw4X3OLpnrizj7BBDKF+P6KISutBZ?=
 =?us-ascii?Q?SVNaGnESo4Kv8ogh+ZB4Iu9wgCefghUeja//NDXCiBXWivssc6ZxyX3elgyF?=
 =?us-ascii?Q?dhfelXZokdmLv6WGWlub2jcAhCJbJW7fzIAxwhRA0iYv1qipTjSPbQq4uYZP?=
 =?us-ascii?Q?t1K4ZP8mrQtGSDqaa5dRgJdCweZ2dxI6GWna8GR+U3LKgUo6vsqsRFYIMtz4?=
 =?us-ascii?Q?7r2oHx4Uorfnn0BFSFJ3AMikyvXupWyKoc6ppGigxphs4mYVw3OvtNkLqTQT?=
 =?us-ascii?Q?ONmCyIKjGt+STyoG8A8tP8UZmDFWTn4dWZcHx7V2wN+w1TFEKNBtE7o3qh+V?=
 =?us-ascii?Q?h30tkALBatISmNuk6fPKxPl1FYzQxsdZ+HQb9/daQTBh3pAa0kETu5kCHCbY?=
 =?us-ascii?Q?niDjUj+xlQrOgGD04B5z3NpEXqDgIVOPIGbFliLmQrqb0rQI7Fpmr4e4EtEm?=
 =?us-ascii?Q?ZRD3QEOx9yV2AQy2J7xcyd1X8YGgREVY447/VyK1UDkqqH/j8XIgiZhZ7HGb?=
 =?us-ascii?Q?2dAoxIwjXRjRPR1R5eXj95dZUWzjj5qxNtlGGhYgRj4lMw5pqLfPKqvjVhYb?=
 =?us-ascii?Q?77klIl/ZdhrWi1Edmw+PZS/6m6FcaeIj1LWOQiGpR1Vtf+5PPL1Wc2kUgR/v?=
 =?us-ascii?Q?EZraKsUOu0vagL/QfvMkwbFDS6ugpzR3ewbVZ6eKw5AKrHDU0XNq02TC0xYg?=
 =?us-ascii?Q?BTU94a/lQRX1eQfzOIzR/j5Jqzu7D3uEnw8M33wVGVjvk8cWnz7fFEm9XZpW?=
 =?us-ascii?Q?fN+xTYU01J0HNBfwt+J6JzmOJhIJRabrHxxCV+AxxgUzFJkyTFrLZk3AIbdA?=
 =?us-ascii?Q?xNX8xgmld6S54aYCO6MtZBuwG0vyviDgu8aPtdaIzDrG1kFjtfb/hv/eCvZU?=
 =?us-ascii?Q?26b+lDNxM4lVhIke7RsfOwJM0RupiYImYhs9qhcWs/NVjxycUHuWJg6ZpZcu?=
 =?us-ascii?Q?YsonlGErt/yuGTxpcPyWQvBmPhH8zSmq7BCD7GdNLVNxtkyDuVTEDzdwbecF?=
 =?us-ascii?Q?21I9hcPNxYqL++Ra9LRn/CJqSutxEHEPvxGacJEc805uC9KHVPjRwJjsAN6M?=
 =?us-ascii?Q?2o+36eiBbP1H76GWyTGVaiIBXDiRPHtfJBFwkXN8P9nhvMWQenJ/WrK57rCV?=
 =?us-ascii?Q?exCcepesJCTcqqyGH3ku2oDUU1T1RrKJMyTOfisRzqrFs/wahqqjf3JrN6R1?=
 =?us-ascii?Q?EzrP8IqQvJKOIWMl55yaCr6IsilakfgXMrA6u8JmScEK+cTg/xjAxkDi7x38?=
 =?us-ascii?Q?6QLPHnYtzcZkp2qQNnKViRP3dltT+NKUl5YCoQCH27HW3g0ZJ5kuPg2twPdn?=
 =?us-ascii?Q?KlrwqqtrYV+gRyvjwWqqbBfiXAFHX5hAPnpdKuV6+0zy95VSLYb8/8UKsB6o?=
 =?us-ascii?Q?TAn2e9JZ6oPEo4EMa3ATpbwbP3bZv6Xzh50FJsHHA+3EED+39PrDrIUxV/XQ?=
 =?us-ascii?Q?Ebkumo9bGdQVkzWWuI87fC0U9XOw4Eql5FsNwJyG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb52a02-18fe-4c82-e9bc-08dba735c1a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 19:42:32.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S97MSmM4S6omBIGoZ2AdvNdavNhCLmPoo6/Ocgx65ZCWlwewIOJZ2G0VTi8spFJIq3c0kptCCdafdtTIFgD2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug, 2023 19:42:18 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> The commit in Fixes updated the error handling path of
> thunderstrike_create() and the remove function but not the error handling
> path of shield_probe(), should an error occur after a successful
> thunderstrike_create() call.
>
> Add the missing calls.
>
> Fixes: 3ab196f88237 ("HID: nvidia-shield: Add battery support for Thunderstrike")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/hid-nvidia-shield.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
> index 66a7478e2c9d..849b3f8409a0 100644
> --- a/drivers/hid/hid-nvidia-shield.c
> +++ b/drivers/hid/hid-nvidia-shield.c
> @@ -1074,9 +1074,11 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  err_stop:
>  	hid_hw_stop(hdev);
>  err_haptics:

Functionally, the change looks good to me. Can we update this label from
err_haptics to err_ts_create? Because of the label name, I accidentally
forgot to add other cleanup in this context originally... (Rust borrow
checker please rescue me)

> +	power_supply_unregister(ts->base.battery_dev.psy);
>  	if (ts->haptics_dev)
>  		input_unregister_device(ts->haptics_dev);
>  	led_classdev_unregister(&ts->led_dev);
> +	ida_free(&thunderstrike_ida, ts->id);
>  	return ret;
>  }

--
Thanks,

Rahul Rameshbabu
