Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46D97C70EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379045AbjJLPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347171AbjJLPFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:05:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2120.outbound.protection.outlook.com [40.107.237.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF20A90;
        Thu, 12 Oct 2023 08:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAoduIdB0EMI1EeBw2WRb2PpXJqj8GyO7f6Ak4DGdbZ9uT10s6zuT5UvaL10RtxSxskN4CpleV0ShtIDi9iV1PAN46v/7HkESEbAFWQJ5TudqQHAdENANssH3dxdbyJ573AMKv7bsBw1A7e8l646Hj4rcoqMxN4zwzxB64ItUF4VrQRfMnLmwk1VljjdXcHgQ7/7kAXtI695lN0JYZ4TGpLjp0V3SMfqZdSP7ca02tUIloLVVKmkVDHKLpWnm2klWgicRdFhAk8BxyKRiBYz6BKQ6rFeMyT9eFuIHIy+QTbDIC+CHY7eRMn1v+xXr0XdtmvQABBXHd07TqAPSKJ1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmUoEMxmtg+XrVh3zuQOm0jIaQC1m5ysRiLcOu4e+10=;
 b=C2rkWnOwc8E/DK6cGt+vB+73eDa8t7CmbSnXnBby6hfSVxR25f4eAFcznz1qNqC4SolEPlplVJOJspusDq74BwRcYBYT/wMpUWqqwsl8mCyLEyvd/dgpiJSYcfxd0gColnWbXrqPMNhf7xL/DgTiQeEQLQzjDx/TXzOo5X9liO7TPtCrqtcky2xfTbZE7t7/bkrZW/hllvAqOovUkw5XGu+9DXTsAiS6uTRuVdPrzRiPlh5Vqr6+WPSD1g1Zmjsi/GuhvSv+we2z+XDpyXH69vqVpzPaOlazIs+EJ5DRgy6LaCuG2Am9UZvSaGRkTiUgKwp7mfdKfTXfIOnc9watZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmUoEMxmtg+XrVh3zuQOm0jIaQC1m5ysRiLcOu4e+10=;
 b=OIEJ784BiolHSyhvIsbRwQu8ZL4J0QM53JkcXrO2ma+yiS3PitdlxA8Pz6Ujkr27eyGBeshf/QMq2g313JNJQ2bLpRgSUpql5aL1Kmg2mE3e99dbUxVWf9togXa4CZpECebxtqLStsrOGLxC1BxsP5pQzfXSZQ/AQK7Fobvg31o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6000.namprd13.prod.outlook.com (2603:10b6:510:16f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Thu, 12 Oct 2023 15:05:36 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:05:35 +0000
Date:   Thu, 12 Oct 2023 17:05:19 +0200
From:   Louis Peens <louis.peens@corigine.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nfp: replace deprecated strncpy with strscpy
Message-ID: <ZSgLLwDD9J3uDutU@LouisNoVo>
References: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c8bfb7-0c19-46e4-cf3b-08dbcb34afec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHNlTejOU4s/xbIEVXIdpe3oSkAKisBtoSc34SnpxFDhs26n8yGoFpJKHnamQ0uQqXXW8eMUykOrUl/av44TmhWihjarXh4uSZX+MFulrWJrS5IBWL4kToHTe2s5RJzIQDJFl9JJ9naDno9m56GQK14+mTWle8LNESuG2Yg1PSxpyWHJO1TM9aUUofuLmwvn2WxWOXxud6+mns1xISW+InHxp6Y1VkKAh90GpwxX/GEdk5oAXbCZZbBZKnK09tmtJBQmTWSjCshdpNUDm7ZInrbx9wDyI9WuWlkF3ZO/bqSEYG1OPGCDG7NKCcUIua67QIlbB5Vrcd16IlMjULi3Pe1BFf+Z9oOvLS0xKY5DBOI139b4+e95VHre/rR109O72ZZuA7IfPJDs0k8ChJS3A/FNDJgXkmayxoaHSOimI9u+eXCSVt3SOXqIHkkNKwKbqI8tF6UVsdBh2+TD8QBSZADpPHtWtEiCEn7fzkLioQo7+5mQxxP6nRz+KPCiAhOgRwjQHcD4oeu5knyHXb9VCG2zGsAospHmEKUm7fTwIpFo3wIIMqFMZMh92stK9myeOd7MOooNOBSp2NObbluXtLJmLz1Et7iqgb+Om0rlqV0/wabvWYr7rLwxzTq2hD6ufB3k203b7eGtPuMNPynzbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(136003)(396003)(39830400003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33716001)(83380400001)(478600001)(6666004)(9686003)(6506007)(6512007)(6486002)(38100700002)(54906003)(966005)(316002)(26005)(66556008)(66946007)(6916009)(66476007)(41300700001)(8676002)(8936002)(4326008)(44832011)(5660300002)(2906002)(86362001)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?64vkdV8kNrnRW+//kKx7FosAlonD6MqSeTigTDPdKCE+6OyFCvl89HyDSHRr?=
 =?us-ascii?Q?5qAPs2PBgnTRYwQSLpNSsnDPQJAlOGGbr407yVdGAjT7QRxC4YBZnYpJMPiD?=
 =?us-ascii?Q?8QfrGThlJOZZQBdjv0rnoq4JXJVjBxDh41ZaHtLDeMM4z01GUt/f/I0/lwN9?=
 =?us-ascii?Q?OPUIpWC44m+YZWPHDlp3D3wOOAuWydMpllyuUdDitZb8DtIuAXMuR+lZWLYS?=
 =?us-ascii?Q?fvIzLcCI2tnrCWpTubU4DaVttvJScAIQ4p6kPkEUNUN3/amI8T6HmEgWpXw8?=
 =?us-ascii?Q?47InZIHU/ZxUACONVo9VssCSKtztPzZ6/+sG6yWDgxkMxhUlNUiOmWzJlmr7?=
 =?us-ascii?Q?L01nAsdFtbkPr7k2S14EDnx/yWsrYyiig+Bqx8TVl3uhPaKXl9dmlYzQucNs?=
 =?us-ascii?Q?R8wAOcxDbMmOdoeaIql4vt5PT+21170VRapt8yihvi3eHcpJCTwS9TdT4K1I?=
 =?us-ascii?Q?1B6h/u+4IXJLOyb2mWjKYTM76RpR7NmFvsqqOHXfXKVAgo5Y1aygHqi2Ml3G?=
 =?us-ascii?Q?yIrqlolMb3mXqRYBCE1U+1Zg5OwR6Yzj42EgmriGPcd0e1Dw+ZzcEhZI+24z?=
 =?us-ascii?Q?BfuqsJIXNGeiMr0L+0Bd/HB96QIWfNt5lHvLhNJJi2v7g8jamOkKLVzqvMTL?=
 =?us-ascii?Q?7y1KSP8ONSSpulqcfbUivmB+M/xHaDkjGXPgMsmzGnS+B/EWnmK8GLCQoVfK?=
 =?us-ascii?Q?Fx5JP9PiB2n9gF015QrItB4WO9LgrOOZhT94380wTN9ppbSDSMVUnHv7J+/z?=
 =?us-ascii?Q?bs4qpIB5HP7hMFNPWpMUjBGMHxjFKnMSZ0pdU9h/XzBGE3SK9kUHYiqIJSPb?=
 =?us-ascii?Q?yRvuRlJBNqnqk5Rk6QpDUdoi898c7+mdlT3k/8gCzra9A2OBU1cA9Yc+TKCf?=
 =?us-ascii?Q?O+xXv2YOtvILAy6oNDUxBcyeZljEd9yebJMZ9EvcUCzzb4YQwTou6wg/WMPb?=
 =?us-ascii?Q?3gwo/RSh3uNvR4N7e1J1AkulD6t0faUF44q5ejGvoFjcf10QwhI+F/ROurie?=
 =?us-ascii?Q?6t58QmnTGb+BJ3t88LwKPAzsjRDRv2lME285Us+9UAOytkOuoV/ZO9bkLcid?=
 =?us-ascii?Q?FZqMi685lK2DlUe6zEaKP8K1D4pykL958bjEk3vWuon1/Gw05P/VbOopZrpz?=
 =?us-ascii?Q?BCaA5aEIx6cjXtuUReEgzRKFNlc2OHeympY6dzluAY8mx+ujwFd7z0hMZz+P?=
 =?us-ascii?Q?MY/7ZXr07d57idkwwZpyF2dmP4+2ApEUJVaIXufkhCAE7G7fJ/AMD7IaaWJG?=
 =?us-ascii?Q?Q8wHefI2AgZzMkDSz+4F+1l3/dUA4Mtvy1HP7qwoOyTQKm5IHR2amIOmMU3N?=
 =?us-ascii?Q?TGL3ooI0l8LWwq1vaEobBHrn478o0InqIYLBHhVwtSZG8rZSOaoVmua8osLG?=
 =?us-ascii?Q?JSdrfcybFvbGyWYMAwiMZJk5WBhEkjytzNmzUjdsiyT5HeXicqDZ+5htxPub?=
 =?us-ascii?Q?jCtdA65SnTJkGiEnQANagxbrdERqbxDBeFArvVrJlDWUhW5uybFqg+7umsGq?=
 =?us-ascii?Q?kT3zvGDlv8CGoI/WfRkJdC1CAwrZH9ocObG6xtO53Nj7H7aD80J+PDmIJ7GF?=
 =?us-ascii?Q?Wr5MCapaGAbyhre9OcesuRck4YF1eUV1L2fJk2jga0fFdCVafSV/tUyHbphB?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c8bfb7-0c19-46e4-cf3b-08dbcb34afec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:05:35.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uuki/S7+5OTgzF6JppymcTbPc4QzxtnE6qXunOYwDA8d6bkM5SKvMn/iU+H6RCLSgkMDSJAfvkp7Yu7ACgw2T6lpWqPXZWzRi6ohScpdlfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:48:39PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect res->name to be NUL-terminated based on its usage with format
> strings:
> |       dev_err(cpp->dev.parent, "Dangling area: %d:%d:%d:0x%0llx-0x%0llx%s%s\n",
> |               NFP_CPP_ID_TARGET_of(res->cpp_id),
> |               NFP_CPP_ID_ACTION_of(res->cpp_id),
> |               NFP_CPP_ID_TOKEN_of(res->cpp_id),
> |               res->start, res->end,
> |               res->name ? " " : "",
> |               res->name ? res->name : "");
> ... and with strcmp()
> |       if (!strcmp(res->name, NFP_RESOURCE_TBL_NAME)) {
> 
> Moreover, NUL-padding is not required as `res` is already
> zero-allocated:
> |       res = kzalloc(sizeof(*res), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
> sizeof(dest)) rather than (dest, src, SOME_LEN).
> 
> Typically the pattern of 1) allocate memory for string, 2) copy string
> into freshly-allocated memory is a candidate for kmemdup_nul() but in
> this case we are allocating the entirety of the `res` struct and that
> should stay as is. As mentioned above, simple 1:1 replacement of strncpy
> -> strscpy :)
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
Thanks Justin, I did also now check it on a nfp.

Acked-by: Louis Peens <louis.peens@corigine.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
> index ce7492a6a98f..279ea0b56955 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
> @@ -159,7 +159,7 @@ nfp_resource_acquire(struct nfp_cpp *cpp, const char *name)
>  	if (!res)
>  		return ERR_PTR(-ENOMEM);
>  
> -	strncpy(res->name, name, NFP_RESOURCE_ENTRY_NAME_SZ);
> +	strscpy(res->name, name, sizeof(res->name));
>  
>  	dev_mutex = nfp_cpp_mutex_alloc(cpp, NFP_RESOURCE_TBL_TARGET,
>  					NFP_RESOURCE_TBL_BASE,
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-1812b8357fcd
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
