Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30A175C2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjGUJXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjGUJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:22:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2139.outbound.protection.outlook.com [40.107.244.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2330DF;
        Fri, 21 Jul 2023 02:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgpjep5uFJZfewKYL0GX4o0iTFDJ0V6lrbz8dpM8N1flAT6wl7xruYg3fWRqB2bRqiHt9jOrQuJD6UXfVkgVNNwwjtGhVHjcAbkmRwN8vA/5BFAKa6Zt6Dn7e2TTjq0meUzV1JI41lL1MCqVVxy1V78v9aAGDUkUkUfLzNmZ9HbcSsctGfXADmp5KBTeSMm/sb4nWhbxt2v4GgQ1HAQeOoPynz+tUT5hle3fs16J3zx5Tuopuj84+0RplqG+fkXnQZ1TLatmF/jLHA/j+DAdPThuVRtiGPbUrOIPB2iQyTZR6ZF3ilMl9qT6z9ogwVAonkE3Qeiia+3dIMGKt+5AEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz8mHqC2Ef19wexneXnyjbdqZZ4oeLZvyePTfyC6xqM=;
 b=WXBvz4ZeoJ0egJp30EQYXz/EXMMd5erWGhe19wC3rNBi97sMq3eE/yAVqedSmCBbAxVOUGNI9t8z5nLt/R4M2XRPOvyGqs4N40F15fqKVVhD/X03CIjVId4CAzUPO9pwM83kPphDeCYEKKW141NKsm9/f89Vrqbw3cKGfgEhmMzTFQbRP8vePFYGasRnWZn6QjugMs0gWbZaP1vByX2V52XO1VlppuilTuyrqyJ5L526A3AJmG8boXgUQwpL1oWqiz7RrI0tBelt3leNY8Ro9UWcvoVIWV5udKJ7NnBkGOrrBYuv/Yy67pnabu/NvfkY4if8wmLVOnjaI7fYAbWg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz8mHqC2Ef19wexneXnyjbdqZZ4oeLZvyePTfyC6xqM=;
 b=dMhwNnSXQUv1rIZBpV3cEPglo253verT4CYvC5j4BjLqsv6vem8IwkqoWkQ+jyNomgS5ITuNtRRmEJ3nCpEEg+lfB/Sr9XA3KR5xOaOgyTV4CQUUR8/SNvrNmlnYovwRNS4mbzxyLLBITmEAGgZ+DIJTcEM0zZdgM+jepDuq8JU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH3PR13MB6337.namprd13.prod.outlook.com (2603:10b6:610:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 09:22:33 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 09:22:33 +0000
Date:   Fri, 21 Jul 2023 10:22:21 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 08/21] zram: Migrate to acomp compression API
Message-ID: <ZLpOTTrYTxfMqYen@corigine.com>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <20230718125847.3869700-9-ardb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718125847.3869700-9-ardb@kernel.org>
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH3PR13MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c1034c-aaed-4420-c1da-08db89cc036d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3sOJBMejdX1zakfvc+13yXfwwWfhkSlDMvZylT1ILKt5nsmH5nfY8blpM4FkImPb8US/2wZIiufv4g16r2THEwTASNmJWZGlKxFhtc+oWs0JDoUpv4kA40fAozdnz7Xz7EFaVz052k/J0TYAYtECsDnR42280XOSc0tmN0kMXtzvX/W3UAtMyvXmFJGmkdF80YjShiC8WHj+iuCrGTBguyYlKbEKuxjdp1vwbuS+b90lO860zbtGP46Ehbx5QVEQpBANn+Gd52G2DjyRzRVqt5QXfJ5ssr3a73tZvWLHgzk5FP6l0lCsQQvW/IlH8Fc1jxmvkF3rHA1yS3i9v1kk/YncVMGSF4mjUr9gaHQ/uxZDryXcFFo59fV/hlv9QzD1iSjjmWneCDrO7PxIr3VsetxwXlzCJG5QF9m1zzn/w6/ouGS330RPNPXLFEV2ER1ZsXayCHMhc9Ptqo5JJv5HEi57ufnHu3m4M/pY19kAP1YDKBWSeilu3/scyFPGEkiMVMVKWIwfprUKHNQlidlnYGhioW8PmTtQqYC0EEXtuJDyK/+52b5HwDKafTlFa9innIKD2MkIak4of+ggVBAsfYgyXtf7p0JNBkwv4VTHco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39840400004)(366004)(136003)(396003)(451199021)(36756003)(54906003)(478600001)(66946007)(66476007)(86362001)(66556008)(26005)(4326008)(6916009)(6506007)(55236004)(6486002)(6666004)(6512007)(8676002)(4744005)(8936002)(44832011)(5660300002)(2906002)(41300700001)(7416002)(316002)(38100700002)(186003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jrxi+iTtHL87U5yNuPxCTOpAq78+AtuvDK69MTZxnDvcs5sfuh9TNi5iQus+?=
 =?us-ascii?Q?ji5LIZyqyPP2LkqHMIVQUj1QYxyOI+9sM5d/GzXSyFulbpXhL6/Ftdi5FAWg?=
 =?us-ascii?Q?YPsQpNzXQvCHS4zXHjlCyQCKvYeX9Govt5tMWFJktwDmMwTFYVfZhGXeAeCU?=
 =?us-ascii?Q?qJunbZcX1St8Aj0mgUnsmpc3HSDjfT0Xmw2+L/8jy6W7U627XLkmSDDtDWk4?=
 =?us-ascii?Q?aa9DvRtY7M8JdRMe3/ebIahi8sMN6tA6PnPpXo0H74BybqiD4wKW5CFl5bZH?=
 =?us-ascii?Q?RLtPDOX5Q+gwfntY7Cfo7UZlLaHhAg9Ex1X4aj3BjJFYdrRoveJ1qgmahhzv?=
 =?us-ascii?Q?XQt5yumAB8P51gfBqbrtnF9XKk7OB9VWYQAjtvQ5sMdIyQrwWDAQiCtUYfxQ?=
 =?us-ascii?Q?RHJV23/SxFHOVfvTCZuij9pqbC8HHhP1NuFgAEGBUr2Cm0MhARzfWpSBsj6o?=
 =?us-ascii?Q?bl6r816JJ9jgF2FBZAoG5vmRZeXfi3fQZf/FuuLQ5fgxGsUwMl4Dc+1nIXVw?=
 =?us-ascii?Q?P7a0WAIPYxBRo71KnW/7WCFrcbgXgkNUnaeK834EIkt0jidjCE81O1yyXjqG?=
 =?us-ascii?Q?2jax/m7aL/CROS7XCGi02ih2qmqsg/bbkqwbsrOm8HKR2/ubJygo6UxhP/RS?=
 =?us-ascii?Q?rPAtrq09WTTVaIiy2UkFS3j5+3rACsHrPlQepJkSh8ezWzDi7JpStRLF3Sg0?=
 =?us-ascii?Q?RZO3uvdb3Zr3P5IDCX1Eqd9oNBb0CGwtiecIRCVry4DV5ZtrzOyCX5GVigvQ?=
 =?us-ascii?Q?xeVdjHaDK1U+UmIY4wEQShikb4TVK4P/lwwu4+uHQiJrAxq47BviZ/zVQmyQ?=
 =?us-ascii?Q?aibI/aWXdDIuwL//RNk1fvGDuKv9IjsMlop2abm5HL3ecvH0J0+Wo2ULodl4?=
 =?us-ascii?Q?xXpPsHH9O8w1iGipBPhANQWBP58TV/sQgnoCNjWk5VBZKGOPkVjT/dXjGbNP?=
 =?us-ascii?Q?JdKUFQu8yY9AY2VzfqbZzsQmPREGJtcL/nz48OzK3nro+QDTPkD6qloe9weu?=
 =?us-ascii?Q?DkFqQls2bDKxlqSBafv5WZx9BdYsP5WCykLA66ttYpAqfhEztX0ZAE7GXYrY?=
 =?us-ascii?Q?p3mI4HMqTTNxThr9I0iHau5EZgxw5tGZe6H05jKyhpVtULK7+SryR9n8R15d?=
 =?us-ascii?Q?zclj4xR+VQP/3EM31RxqKaEwEc+RnK0dAbnvJILdWPUmuoeHVV/NEiIXpiHn?=
 =?us-ascii?Q?8e9zS3SIIuhxsD5hUe9T+FE7dnpsTBsc9+tEcP0KrrW+iLvrbUiJ55GsUSk6?=
 =?us-ascii?Q?yH1KlfniUyUsNMpmLCaa3VXNbRXqqtrA5Luzorhy7YDvbcar9eU7U4wrI4eT?=
 =?us-ascii?Q?GE7FSir0Dt6T90zfvpw8oZ6srcT9jswRLsYEIcHNRwUFfK0lfFOk14/r/9Jv?=
 =?us-ascii?Q?5XLqHd0DwU2YrxmY+zLAkfB1UagUY/3taKF48iimNuCr7bTJgJ2YC9h1tond?=
 =?us-ascii?Q?j9K9oEkLxg/0njT5Mv8q/29oIue00t01MENWPW/B4H35AUENQ1VnfqRLthlg?=
 =?us-ascii?Q?vO+W6g4JUm1yuqKnXesPATHuRSEZB2h7N7/0gCPRi+IGazv4KFoz4bMSYGCY?=
 =?us-ascii?Q?BHC+BeBgaAmPaWoKNvOnA+fkGjG1H7PiSHhI/LwEbPXkyhzdLB+QZVRlDNUC?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c1034c-aaed-4420-c1da-08db89cc036d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:22:32.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjiOPs83ASTe0WAUkXDMSkQV36rMnfIALN9EvAMsRxPKFpMRY+NSkRcYuO/4oRapKFd4/RHP5CRl2KtUrZLgYTpUPTuEFWjGWt0HKJVuSDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6337
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:58:34PM +0200, Ard Biesheuvel wrote:

...

> @@ -1618,9 +1614,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  
>  		num_recomps++;
>  		zstrm = zcomp_stream_get(zram->comps[prio]);
> -		src = kmap_atomic(page);
> -		ret = zcomp_compress(zstrm, src, &comp_len_new);
> -		kunmap_atomic(src);
> +		ret = zcomp_compress(zstrm, page, &comp_len_new);

Hi Ard,

src appears to be unused in this function with this change.

>  
>  		if (ret) {
>  			zcomp_stream_put(zram->comps[prio]);

...
