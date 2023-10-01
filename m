Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711A07B46F0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjJAKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjJAKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:34:36 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22764193;
        Sun,  1 Oct 2023 03:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlUpOVVTGIScnUrySz55NPcKfRfMLPnYoqn4NDGrCoCCoz1oyzAsSBoX+mV7LB08cxwuyonLThj5wv5qQqCsdtybkPJbJelyfAsdxohJJSz7PFup+iwJctmFUzAYepxbjvNEQM0+kLV0VIXBO4iodwBgqd7HNhrQbZLrz/H60koHa30GJWGhMQiCJs7Ec872HFTRWGGriU5TsYm+Orh52+VR27nXP9k8sNS/8RJUzmzkuchsXoI17oipUpR1t0snm+xdk3fuxCbAcF3OsWpCTUIph2+gy/4YgbIw/usfuNUCeWw4u8a6k+Yql6oiqp3f2cAg0su1/sg0MM8IglZRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3BLUHTb8rRWZaxb7Wgm9GOGtSuDJ10OlWI0zJ7oF/M=;
 b=Bo7kGRpTU5FottaBX4Tw6Azzi5w9BerX6MmA8yuHMfUm2x763lB5DoZvqXpA54IHS87IOUnx5VKMrjdn3GWlhkJETZQm9fzcvrZMOA8wl57gHpNu+AoUQvbP9grt3/r/1dfL9NWL4ktg0FQCxUAm8V4JvbalcwsA5qJUE0nRD0S0fvNjTVlKJeMNwt+50qhE/xKPvF+axeeKSPaPADCW+0+9hjpz8BKcH09Jd95agX46q+Ri0Nj9xuK8PCNjOtsNTAOJ7+ZKlQPnBW9flmaT6fxC7S54rD/D0W1vah4ZnLy7TDRiVOnnANzT1/b+9wiQullk3TtkbAUi6YGsPdG4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3BLUHTb8rRWZaxb7Wgm9GOGtSuDJ10OlWI0zJ7oF/M=;
 b=m5H5yAtaAbsG+UH0rQZMIyKLT5wjcVrDiuXdqxPcW0MxW7nIpRMnJq4qjw+Z7Xb6DMGLHPfB7rK/N3mmPc6T9HiZsMxHyr/z+Z5B8s/X+09pO5z1oMIAKex5hhZuO3nIIvdp4Z87PVnIO+6QTTEAi/+TLqBCzVpKmnteuJ78ltxE2bGMiRJ8J4avwHrU47C6dDuCXg1xaeadz6ObabfYa1m6CcxTP2WLzIaWJRXJVPnO+iujslTy9UXmDZlv8ti0ye1t46uFD03uVTXwPxYa+AeRPI2xQa+0YvF5UwOi2AD5BRPL2O4aR00Xv+iX1feglAtmB8XYj0Snti7aalGh0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Sun, 1 Oct
 2023 10:34:30 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932%4]) with mapi id 15.20.6838.029; Sun, 1 Oct 2023
 10:34:30 +0000
Date:   Sun, 1 Oct 2023 13:34:23 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 4/5] mlxsw: spectrum_router: Annotate struct
 mlxsw_sp_nexthop_group_info with __counted_by
Message-ID: <ZRlLL7gvrQRC5Ci+@shredder>
References: <20230929180611.work.870-kees@kernel.org>
 <20230929180746.3005922-4-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180746.3005922-4-keescook@chromium.org>
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f8a873-fc27-482d-252e-08dbc269fe78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fh4iQthEqoVtZwnC0cI6J6qSFrMRA+OaR2B+rLhyPo6qBfh421afPSjGBtsALDpq8VcHjiUycZ14A3OkfeylBQoDQtB1uD6G+BUL/kIa4V3jRTPXKXhBz+tCv58f5wzk8nKICPN9e/pyxnNBvYxK7xYDudH8qq0sANdz9f2hbEvhg58ZwRRTshE/zfxvpnv1eN+1tcXBgqqJaEB8WS8jHJ+9cHUsmyFOAKxA7ETXIKBgPFEdsw3m2F7OvGhrlvAfYcyTAAeAzlgmm5gxPdQVh9yAvqMDzUEgHU9BE5pe1oN2MlsuB9DZtWV3PE6EK/z2ynHcf7EZ4rxDKhSFwbzi8sb9Jsgd/LNZ6tNaKCTQDOMRxEgiv1qAFP0586+iKOkwfNQkBkLNTj7PswFEb05dLiLvc6/dso21bVGSYSYJ8PcYJpL3/JPPGTBMEV7jbOlDOlT4SmE4EI6PH6RDM+Rbk5Ls461oXbkFEviExBTxbAPBOaS1IrxlI+lWlJ6Bf2wW5dYWiIe6SXRSF253hXH9bOYkoeXiatFQU7xrHupFS/MdyyHUezLrtARqGpOKO9TJEGdbJRlWUydzjvMT5skTGdryA2C6p/9BQPDJTIAq8Ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4744005)(66556008)(2906002)(66946007)(66476007)(6916009)(8936002)(316002)(4326008)(8676002)(41300700001)(54906003)(5660300002)(6486002)(966005)(478600001)(7416002)(6506007)(9686003)(6512007)(6666004)(26005)(33716001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsBOBaM1C9Q3YVi55QFScqsNZU6VA9wIOwLOPp2V9FYTYdKA6L6aLNtgQptq?=
 =?us-ascii?Q?icl0hpQPVYv06hcFV4xJfiqiltunnSrWICrlGOg5Teva4NKvnmpBP8yHbMXa?=
 =?us-ascii?Q?QTK/hoSKlxRm64f3QMoaS2xyLyt9MJS/e8/KRetS7g6DdLqu8sdQkEbz94mF?=
 =?us-ascii?Q?uX5Iq0yIMpe2SJIe6HlWj7h6CRUi5g8nqWjP2hlz57k1N9cPA7WTlbOKK1UZ?=
 =?us-ascii?Q?mkkdVxUUWTVA8fA4LwJGo1atraCDeZ1wJ+cL8TDnFF7VQam1A47zIjAHZMnB?=
 =?us-ascii?Q?MZLvU0cdlV9d/X7xNAHg+jc9MuoluiTU5RpNpQLfXo9a6CqWWH+zrBP7GCAT?=
 =?us-ascii?Q?nqNgjsbWBHEPnNf8XoeArtbfz5TDOFTVHVbZQqHP+wyvL6pbVE5xd7mW3aYo?=
 =?us-ascii?Q?RKpFTJmfK4odiU+E7ceaM1OEi/1znZLFJ2SKpttj7TAMVeiqMZfHhAHC2zW7?=
 =?us-ascii?Q?0+LbpSw2anEyIK62olPGoiZ2eB8ZtNnvRhc3clW+VpZRjrZ/pN47n7tK+mje?=
 =?us-ascii?Q?pXAbe49CLeiaUJSa4zLac5+0oSDnA1W0Lgg4tJWusbrCCTmaKi9XyMbFmkww?=
 =?us-ascii?Q?9XxWaifv4+UQD9gcawbTWM5b+OaYtrkXP8evwCMnIdA23AvV7D8Pm/52Nd/Y?=
 =?us-ascii?Q?6ljVI9C6I4Zdx09FUdfmTA2xHMWqYUlp0Rdr/V8O1hANHit8h4NJVTh50HHW?=
 =?us-ascii?Q?z7YlhBYg0Ij7p5b8+08XOEhJSzreIjy+bk1NtCkKwPsdXql2ff7Y/AjF5MKn?=
 =?us-ascii?Q?o/7G/jZf7XdJ/kk7Gtr6eahC6YsHgafKy45QBjbH4RErLpNZInGjk2gPdSy6?=
 =?us-ascii?Q?wy/kG6wet0qHIxwX5Ohzx8EApiYYg72sqCnDAentqY2SYEf0GtBNp5Ssn557?=
 =?us-ascii?Q?YPhRmJqNIwrzGo2eAab5Nj/ZpDQ821iiBFrQmGvdwwSFozDMcf/mBmXcNhwH?=
 =?us-ascii?Q?XGK2H5b81zhJ8WeZo+XfK78R/CrP7+RaBSpC8GOjp/AeRKZngEPKdFHvLQbx?=
 =?us-ascii?Q?FN2N8VF7RHGZI3TxQl63D7P5YQgjvJwCQTg2K0D50w1dG5hEVZpQXR9c/nRp?=
 =?us-ascii?Q?QK+5IfgCQP0QRo1ol2CVG+NsTHTM0yJ29/nsAgus9nA8mHmPP0lDdUMN4tKv?=
 =?us-ascii?Q?HAsvNLiStXgQYMUXvLQfY042lt1YQJ5Ytmbfi8cNBBHCQT/EP2U8xyWlocAs?=
 =?us-ascii?Q?ONVHFB+vawGVuDQdWHXojYRefE56VMPHDO+3PRcfngDOD/S7ZjlS4/foE2RG?=
 =?us-ascii?Q?xQeRryc1YZ1NiFt4G/2lHLtoxwK8d2dPYB4cfJ5oXjAyOSXcF2R8sShevBQt?=
 =?us-ascii?Q?mC7Pw44AOAjjVqX1wLdBENzU2WinH8pLSDsOCCaBUq3x+HeEl85IZs+WqwTF?=
 =?us-ascii?Q?PuF/9VZ6wBM7qImMUCQsQc4LpNobpT8DXTf8xrkxRsLc6hajHEu47BSGvk+z?=
 =?us-ascii?Q?Y//pKO0OCw+UGeHVyWeOWa0muFDUwONUUOK96n535+Lz0sfm6kSavfLh5Il0?=
 =?us-ascii?Q?OX75jn/S/zCBa2UStwI1+WE26+9PlLduYCyHCjO81cgjdPhA7F0FyNX9DKZ0?=
 =?us-ascii?Q?MBRSQrIVgOcXLjuQqTbG6495uwDZC9wO7MwY79SE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f8a873-fc27-482d-252e-08dbc269fe78
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:34:30.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHDHvQaKTCuf1CMBdX2YM6TTMHt5ZCsucYNfJpiHXcxGFCPMlWeQthUXaPcUEL9OLIM/lHYI/qnzVg2eCOSj+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:07:43AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_nexthop_group_info.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
