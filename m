Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33911758565
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGRTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjGRTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:11:16 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B81F4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhUdJH8okiqrosMwlEfDQXvMHqYCgeiQN5uqVaYLEFe+hWBZXkmaC2oVrF/CNuv+UAlbOVYPZwqy5+as46DlImXbCkv3ETVNXM2Iy0k6hD5xyNmA4mC7i7b/ig9O1U4erw9pgKI8nUBgDT2x68IxN4FWqY3bUKSaieg8+sCmZWlrcXdwt3ys9tMisaJCEAgCILRCmmHFrkzToz29v5kS/urfW3Sq583Tmjy5UMSIQka5EDqXKgx8bfQmKGFC+LXPz1fj43W29WkoMH3i1orttH5sdAg1cUfq7FuWdiUrU08CMmA1aFA0QlfVXsWEm8yIZWN8JZcuF4/4C3vRrrztOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrxjaOvc+L81jEldUssV/SOKQ0yv/kHPqrCqpmLys2M=;
 b=L8c41Re60vvPUrhq2OctfhTYPe51IdcNFottzKDATvee2cIovaWUs+GfoRPtgOGlP2WFOO/4/cAVQaZZC2XCKUZu8Nqx+T+pxYWqgmeLT9JTxlDc1T75viLhUfl715zJom19+LxuMhnPmpTnPpPnlGYj+0HrWQs0SAO0ST6oxwYmCUrMoGu8jgblEAjGQPyQVCc2vvM+h3UmcxDpPm4xYQrH5wHnte9DZn6uDXR0w0BbLmJvXlr8KsQT6mnBLRiaJg4EiIFzmg0y1ph/uNnX6xOSEvtdzLn+tDN9ojj1Np+kRSL334tjpfZu5aJccIaWS+jiCkHp66QOsLIwmOujYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrxjaOvc+L81jEldUssV/SOKQ0yv/kHPqrCqpmLys2M=;
 b=mDewX2FeXI3dW0j2/VPxE2Fr0kwVl/XjpuUf/SFFisv2rMh977BH3TUZqoJbHvO9U3KEmyXdYVnqas7XrMvYGxVzsjyV5dH/1lxbxxyGyIblwE40W0lUNprh4RPvMJmPsEFcbvhKS0LoUvwH0Xp61OQGSLgKx2RnVEigSjWROuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 19:11:07 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::d271:9942:132c:5adc]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::d271:9942:132c:5adc%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:11:06 +0000
Date:   Tue, 18 Jul 2023 14:11:01 -0500
From:   John Allen <john.allen@amd.com>
To:     linux-firmware@kernel.org, jwboyer@kernel.org
Cc:     linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] linux-firmware: Update AMD cpu microcode
Message-ID: <ZLbjxUdcyPlLTY3w@johallen-workstation>
References: <20230713180511.2872093-1-john.allen@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713180511.2872093-1-john.allen@amd.com>
X-ClientProxiedBy: YQBPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::39) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f181d93-a969-45fd-06c9-08db87c2bcd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXnrq+NpJrgkTedwC//xTcfkXgr3M6Q3DbmZOoqDxyLuG6vipxjSc9pa1UDHvUeuikDvaZFmbglbUWIJfx6I5CjpoWZukTqy6F62OnwgWQDxClJZanrCwIiaOZnwp9xVv9vBE9wTkIbIXY9KRforjZ7LbZrGP5g9EhZR5PiqtVd4KbiJI5TMuzmmeV8yspdFDwS+uuJtonP/28woK+oxzdB5mRJzVP++XzXfhkLPheA9dz7yQworAI5Ktsrmy986Z6xiglFhna09oATRBu5lzk+3n9pb71dqM79s6ol9BzOrPwNNrAJKIPbBgxafGUK8zcshay4ZwjOlz2jIixUg7QOCH80B2WFxvw61aXUZtgtU8RPVYvRQeA+dZYt6DELsKDWsROvDhVeSU/HqgusqxMykgPQ4pUAzEcUUsxcpKsWK0vnPjiilSfVxFkwOaqUg9N0Tqyzw/UWB/XsSjOedGdE0hmp3JSRDnTavK72Y1bYAVbbdhzYj9gGzkYDQ1NguYHuxkouyNPHwi78NDXxYdYI/zSwfxhE6jj1TWfpKuCCz9Xzq8b+m8zX5Cfmrpngn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(9686003)(38100700002)(6506007)(26005)(186003)(83380400001)(2906002)(33716001)(5660300002)(8676002)(44832011)(478600001)(15650500001)(19627235002)(86362001)(6512007)(6486002)(316002)(6666004)(41300700001)(66946007)(8936002)(30864003)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXSGObJhMIrVqJTqvg8zDBIj+yVbpTwnv4e6IcwU50Q0El62/lKVNPk2Cek4?=
 =?us-ascii?Q?Nqw69SWXnO4i8e8LkDhuvk41Ee8I2HnBOwSwCsh5a0XWOL/xnTa72ARkdL7A?=
 =?us-ascii?Q?zfUVR4OMbhGQbIvAYl9WAJUGDP6V4BOnNXjOziocz3St/ve6SPf5UI/Xm8dF?=
 =?us-ascii?Q?PwKCIRSORxPtwEUBpZ4AGo3c5FozL2IKiKrfxhyswx7oBoQabdZUw4VMy5cY?=
 =?us-ascii?Q?jzWwxdYK9VKEB4ib8W2mo2jjshBZSzojVY8QT/kA7fqgMA3askPYJHhnqjLp?=
 =?us-ascii?Q?+HXZoEVfepXK6t6iAHmUik5Zb0NCc/pM6eFseQJsgQRWO4XomXfbTRoQ0fR/?=
 =?us-ascii?Q?Rpjm+egJhGdOB3UNSwSoretBqxb589YhpNbdL2+S9HJnoQ5tsBrKFYm4RL5l?=
 =?us-ascii?Q?rU+dKiNJQotY7cwMOeYe915g6Y1gbbRRBi6he5RJCNU19Yejb7TcUKu89t5Y?=
 =?us-ascii?Q?73VtUoM8/GrrrUzGS0bKLxzne3AJ6vAOlNbroVa2Kx5LZvii5lqqPNrU1Oy1?=
 =?us-ascii?Q?ZqfUpb5bzIjZU0u+8OqBZ59461KRHeXnBcj/ylvvr0pfBqFkU3Jiof1ndxj0?=
 =?us-ascii?Q?dHr0zRiTOhPbB8j7sG+iby+kp1NKr4O97Zqbe/52TEUhvT0cnL0/Qhq7+H1T?=
 =?us-ascii?Q?4KIsnzaabyuCEiUZvG/gfX9iEDpJ+Jsi7aExwNLE/YEoJuy4WGB8Vbx9BpbT?=
 =?us-ascii?Q?p8yLcnfx3O4qrs0VUD+m+5kG6xG2ufSbbKnT3pUfUckv/UqS2mvSwc065Zvi?=
 =?us-ascii?Q?7wcA4eZhY6w+Hm6QzvI6O4RugUhIW+v2FAgwr3MIjKj+eGfKqrWRb4Vr2WPQ?=
 =?us-ascii?Q?Pf65BUL3AmvDff6yBc+icKgAt23hAjGqLNo2f0+UCdvzbWX6N3EbWCXKuVae?=
 =?us-ascii?Q?bhkdVnlG9TweepLEyxZZIgn2CPkpgegNYAWP5/SAo6HXjR4fekxDu7iC7vQ8?=
 =?us-ascii?Q?rqlRZW33PVBegjZhMcxT68dw5vYf7YnPNuVMv9e4AcXS+8vh8tl1xKueDYz7?=
 =?us-ascii?Q?wEK0RQaHadcAuT35eBV7XGlhssMNJKy3ZyloQia7WAe5oSqQoN6zRhJ1K9VS?=
 =?us-ascii?Q?5g/NDixH9L1IgLJlWzjlIAOf89EkF4XRYRgfJNo+5qrz6RKh3JkJeoXe2mcE?=
 =?us-ascii?Q?ydPqx65f5YwCLwM+725nQ5w8+W/+v3ezT9QKeNT/U15uPXmOLc7MZI2pLHCG?=
 =?us-ascii?Q?BpbGIvN0xZmQczhlxEFZkjxStPII5FYRut0IWgDCONuQPVcQKrAixOHBbZ6m?=
 =?us-ascii?Q?fucNcrpeH48gl6hN98/bl40ufpRsZ48HDE3145Hi8WdRJ9Bu3eROzBfYPNtS?=
 =?us-ascii?Q?k8sVIzOyOyGah3ByIeMqfUbPIVj9fYHBNB35o9F0MN6pnEE86+InYwEDO2Lg?=
 =?us-ascii?Q?G9xphyRyDGASfFu7+rHruXnDBRlHQtOkkZAmlBvSdGJAiLSWmV748HFBkHg6?=
 =?us-ascii?Q?I2torx4L2r97bBmS6/WcanGx9rsHTTLRmGA8hTu+fkcdcEEyB1LGMwd58wKU?=
 =?us-ascii?Q?Yy++uWN3T3rLf37vQSewxakVMIP8XHmlwe8mRbL4QUfHP9oe8UOa1ZFLR4wp?=
 =?us-ascii?Q?XpT/UowqyOkOD9HJ+WXH3yNzqPg6T+RVahzBiGxj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f181d93-a969-45fd-06c9-08db87c2bcd1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:11:06.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr7b8deeBg16qFWGfFgBb+o9V+QszZhF3HTwJ63Bq13MZPg6qp9rIGkS7iPxqvmNyZaBw1K8kXYlpqV7ultaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Please ignore this patch for now. I will be sending an update shortly.

Thanks,
John

On Thu, Jul 13, 2023 at 06:05:11PM +0000, John Allen wrote:
> * Update AMD cpu microcode for processor family 19h
> 
> Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
> Key ID          = F328AE73
> Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  WHENCE                                 |   2 +-
>  amd-ucode/README                       |   6 +++---
>  amd-ucode/microcode_amd_fam19h.bin     | Bin 16804 -> 16804 bytes
>  amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/WHENCE b/WHENCE
> index e53002fb..67df1707 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -3912,7 +3912,7 @@ Raw: amd-ucode/microcode_amd_fam17h.bin
>  Version: 2023-04-13
>  File: amd-ucode/microcode_amd_fam19h.bin
>  Raw: amd-ucode/microcode_amd_fam19h.bin
> -Version: 2023-01-31
> +Version: 2023-07-13
>  File: amd-ucode/README
>  
>  License: Redistributable. See LICENSE.amd-ucode for details
> diff --git a/amd-ucode/README b/amd-ucode/README
> index 0d97f910..01da7ebd 100644
> --- a/amd-ucode/README
> +++ b/amd-ucode/README
> @@ -36,6 +36,6 @@ Microcode patches in microcode_amd_fam17h.bin:
>    Family=0x17 Model=0x31 Stepping=0x00: Patch=0x08301072 Length=3200 bytes
>  
>  Microcode patches in microcode_amd_fam19h.bin:
> -  Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001078 Length=5568 bytes
> -  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011ce Length=5568 bytes
> -  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001231 Length=5568 bytes
> +  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011cf Length=5568 bytes
> +  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001233 Length=5568 bytes
> +  Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001079 Length=5568 bytes
> diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
> index 4bd623e14006b3a2eeb287e52708d3bea1c3a728..ac1079fbee6ef651ca6a1ac0c25ff464cee7c75d 100644
> GIT binary patch
> literal 16804
> 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
> EAMA=c3;+NC
> 
> delta 15278
> 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
> A>;M1&
> 
> diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
> index 7c5193cf..7c712434 100644
> --- a/amd-ucode/microcode_amd_fam19h.bin.asc
> +++ b/amd-ucode/microcode_amd_fam19h.bin.asc
> @@ -1,11 +1,11 @@
>  -----BEGIN PGP SIGNATURE-----
>  
> -iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmPS0gkACgkQ5L5TOfMo
> -rnMWewf/SNlPcRuJ/RPEKThbPJyToBi98e7QLqlGkuIQ7sZBjZ/zZIycQDkQgjVV
> -MpO8E2yxn0Pp/2T6IzGBLPWpMVgvCabIn2gRe3qvRbJ5dYnxU3I5hfCITGHG0z2K
> -OgH3Z51aKZGX0fCRHKdrtVf9RMdcYcVHD9NU48q8x8gArdRg+IZSCPzqD3dNw7nT
> -TS2WHNiMzyqXkkqqkroofljUSZcuMIqDDEsfIB9LDQjFCMYEththlC0m0wz1QIRv
> -HJCJZ8p/E8xMPLEp0JvhA1zxBePlyKmKtHLxhslyvEePJif5fHECEx95Q2xYRS+F
> -rMXPlWVgxXzeM1NUxEBDM8vI6gaXtQ==
> -=+Rqf
> +iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmSwLLwACgkQ5L5TOfMo
> +rnONIwf9E22pFDlKfIBtIwSmvRzwlYKoLFH9xi60F7DqzfS1GRJB+WDwy7RyiJCM
> +yOYnxt9JAZhn8Sy2l/FGDbdCBx9way9NUV8WM76XtPlGSjJdC+/alqzqQiBJY7TI
> +kSfBsNGpqn/4ozTkeZalOJwanVPiEmQcRVaRGCJApfYS3MC6ceTcqL6aSGs8QTr0
> +VA8JHfA7sn/9F/XK60gUfaU4XJMSkcxzihPGKvQ3aL4nI2ypFhs/lS1Riai6YCLw
> +903QVGSrqm/G9lPzy1Lr8OAn74xGm9qlcFpw62X68v5ApHJ9PZovHilhAsAWxddB
> +wTwJUYsYEl20E3ETV2+wSmUN/OV50w==
> +=o76x
>  -----END PGP SIGNATURE-----
> -- 
> 2.25.1
> 
