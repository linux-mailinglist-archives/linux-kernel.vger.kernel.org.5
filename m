Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75377B46DF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjJAKcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJAKcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:32:50 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E35BD;
        Sun,  1 Oct 2023 03:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGmmoe5z4/Sb6QDiWxYhShWCwf8dIVTXZ1/rTJnMniV9ankkZVJMfoesZle4mrrgfGoj0JZehcv77dkcTJ2GkMld3udSM1roP9Wzxv7Qa0zFGjlLoPBx++Jq8mrmWP6v6mMbO5RX4K16FxFATU6FHFtdnvdpFF30XES1h0343iz+SNQdH7hZL2QmXTUOpuxLfPayBLMGVQUIFH+g8lBdBC0zOMFG+AnLeZUT0i1v4GffZMbSCt7j51ngjUVlsmcSiXKyP87V/XA9bAZSZvJiYzlF+WAt4utir9JgYw7rI04lOjyV1jCNyPJyrdSimuuzPeJTSAm46R5mAxC1DfMPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpJklLT6VgI5rBAKC2l+q2qtBzWGN8sCCrQyOagt79E=;
 b=D6Qv/ToCReNKUROmwnzaOPDLNXqS317fc8NGa690LlpFk63H4GckLCUNEDoZJJoIoQfs89Ijpkt2t1bAmDysOSLFCgNlg+7sfMXzqFrm07pVJ6/vRfvSokJuroQhReBc4Ib6Js47SCG1vmUc44qWfUPrHekjZdM03LwwAfnHEeIeFTKTiEXs61z7Yh73XpgGAZL3cjPWKdQUV00M85HXxYMk2znKZS2PYgSBzAw+kUJHD2LVFZHtnETNEmsDFN2rrPi4AQsflc1Taw114CbXKK5FwyCRcNHrXVhR3yc7/GHaHIbjudTVYTDuafRhe92SwDJgvzJEFlHnb6jHXYIBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpJklLT6VgI5rBAKC2l+q2qtBzWGN8sCCrQyOagt79E=;
 b=BvUqczfyLYNdia6Oh07QAb/WTu4OFaWKT/Ex3NAX97/wxGCGArZkqy6vbB7EeSF7w+F3K7kmKemITFaSyB4QBYK0CI/VN+2cXF/KrbLIbM862IOu2AXgxO1DzL4TbLCLCaMt0C/IBR9RxJUfuk8B7N6zW99jVAN1nNiNDjfGFXMlyL1QI8/AJecMfkLtoserRPMhQsAdpmpCNVn9vWcD2NdnPswKd+k1tD4qeAsl8RaODWKATtkdsr0piaGJQUvXfAeyrTdOojutE/Dv1hneR1z3L0fC8nNhxq91+nXziIiakTRUpXy5Jw4Pm2H4Ign82tOYNBKOZl/boUf2x7QBdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Sun, 1 Oct
 2023 10:32:44 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932%4]) with mapi id 15.20.6838.029; Sun, 1 Oct 2023
 10:32:43 +0000
Date:   Sun, 1 Oct 2023 13:32:37 +0300
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
Subject: Re: [PATCH 1/5] mlxsw: Annotate struct mlxsw_linecards with
 __counted_by
Message-ID: <ZRlKxeF2T6AOnWm2@shredder>
References: <20230929180611.work.870-kees@kernel.org>
 <20230929180746.3005922-1-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180746.3005922-1-keescook@chromium.org>
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 08842954-c57c-4d01-a5b8-08dbc269bee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GF4zYSbox5LP1wkBLDcqO7pkMPUZVEdl4n40q/T8JmAExY2XCtieepcD+ef+x5POwxbMsdQi8nPrY+i6QuU08MUvXgxOoc/t8EFyO2XYvY4fzWOW4Gp05c2YAYgqOsrk00pwVWKepPPPx4Vy/D9uVK5Gguj0WfCLPwFD3OkYwab6QhPrFM4hlE4VMFs/tZQcjpiMipgYY8PXkPfjCBrWRSroXFvy7LAvrbSiyiceL6ydEnDId93nvZV3nNHQzKZgXcDfCG9j9hO7UXx3nE6I+U+wmA4bRvvLKW7T16Es2DfbO1qcWGpoHaRh7/KSvJXeQD/taEdRAlP60CAX4qOjh1hZ3r5/5BuLLwF7SL6PVvjoC9j/eAOasMWRzMjsuparIvx0kIU6wXRI3xpsBz3IplbZP3J6Qw53heFMq64Ji12JO6k3JYXGunac0ke6fGQwro/mca2ljI04B3O3+/hQ2pCFcWzTSOBWM3vvFboIMsVnxgG0LpAHS02Zjzos2HI/5PIM4M67cKBkJfimI5MZLLJxybebBMQyoI/VSrvZxuDZqTgMhs/J47+8kvCcfGZuX/iwpF/UYFxIY8kqc0zqQKhHoJ+m8xcT53RgL1wdMLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4744005)(66556008)(2906002)(66946007)(66476007)(6916009)(8936002)(316002)(4326008)(8676002)(41300700001)(54906003)(5660300002)(6486002)(966005)(478600001)(7416002)(6506007)(9686003)(6512007)(6666004)(26005)(33716001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7n6zT0yQspueOVE4cyC5sDXvIVM1sv1FyJ7n3dX7J/VaB/N2ksPIgI9czBg?=
 =?us-ascii?Q?4/8E2nAtaF6NNfq2R1EHPFi/R/+VoaHeH7ikFok8fnABm8BU1jGGBGDy4ljN?=
 =?us-ascii?Q?OHB1XFQIGh1qDIzA2nM/qeJIT8uyDfbdzo46DtYjFCn8fXZNf4pXlEahzB/n?=
 =?us-ascii?Q?hjPlk0A2vrkJafyz9Vr4zYGn3wUBgv4hg4nQN5yOcfYHmODtZoBDGuEJEdZY?=
 =?us-ascii?Q?vQO4+PJrMKinca/ODQIXB7ItsyP7xiGAPRj2ZgrDl3ak7Pxo+1VJzHxmRN8e?=
 =?us-ascii?Q?C50AqBOxOAzVbTVcvzA6wXajgvncUTn9v93levX12PjJao++WCaubfLcQlPE?=
 =?us-ascii?Q?d4RcUxvCyDWplF0Z/C1LSb3yhDlToykErkR9DfKMc/mE1xvBELBFPrkC/4JH?=
 =?us-ascii?Q?7o9BgUkt1OU0w4/pP1DR2FFbvPA12oYAmvZU0voU98WqhA+Y6FyfiJjfpBgJ?=
 =?us-ascii?Q?k5algsyBD2znbDydZCjESdAet7vYIAN0HAFqF5KL17yCxt7rHZn37mIqyfxK?=
 =?us-ascii?Q?XkkdPC1AIdUgdHxNZDTNJcvtapEsH+7/ScqJZ9okwLGPnIApKTK3mVuXqBNF?=
 =?us-ascii?Q?TRk1X5kJ0jyKv3jw5yeTLSaNE0W84Bvx+8Al5nzIiYOvl5apkuUwKYdbrTDR?=
 =?us-ascii?Q?047gCPB7b9ZC4yhfZZMVRff+wToTnCkHWDaEc3jlOlqt3XHP+LMloauej6jN?=
 =?us-ascii?Q?T+LHh78nA5HB9UkWJRKVrFAsQjmHbv38+NQ+mrN8+pXYM6/AozmReCatXLuy?=
 =?us-ascii?Q?W0RiuBJTiYERSHsSH/CgXagg3ItbT25MMyJ8DiCQwNCwIzGWOcGqXXw0BapP?=
 =?us-ascii?Q?UrGp6Hzca2MSM9wkGBA5eWzlRIPMdvPHSuxxr9OJKVozp653LgBSlGkmpn2L?=
 =?us-ascii?Q?PttKyfCm+t6PNUY9UGgY45otHV/gEQZC4JuHYJpao6Aj5TYtf6EG5GNgjubI?=
 =?us-ascii?Q?QMxX6aD4vIKfwA+DQziv7CP7VDNdYrVirHP2tCNU1/JzbSJTd5bCW9vKQ+Iv?=
 =?us-ascii?Q?L2MEy3nAoZfRIH/xqskLf/acagt/nIMDr357VKzrfMJw8qelChCFw4cKLW+u?=
 =?us-ascii?Q?CoFV2uXmaNWk6a3xoqCkDFi+2t10TMIKQNQ/ij3Lsa+NQQahnGBnYknfSFuO?=
 =?us-ascii?Q?88RL2BKDF3GmD37cAQGgN2Mc5SaqdWA68e+xueMfzv8iEBIPClt5VA5nNstr?=
 =?us-ascii?Q?mv8kKSEI+XgE8X+qDJBFUSm1A2x0FwrTu7hxogIZUSlR6TGSvO5H4zcWrJgS?=
 =?us-ascii?Q?3wDAiPxOwlypZ2S5p9l6U81pd5m7OqXPIfj+m7GYEq2q1krdW12U7AhjDpUr?=
 =?us-ascii?Q?0+j1aVclo4CF1cGu+SZLXjOqJqvDBwm4ujmgTLoyxsuahRjoaDuYbAxNjiz5?=
 =?us-ascii?Q?0VpVmaJjrIFuLzS5BEhoJacJGWZpIaTqIZM97YoZQto4sOHHXwxzrux3uiyJ?=
 =?us-ascii?Q?WCdOuT6aSP2Qy0oh7lLjPyovVJPniZHKcd503/eJ+HPHmhxaIZKASTO08NPs?=
 =?us-ascii?Q?ERY11U99Ba928XE1hO6Tc7GVH7HQfVqiDGFw7la1NpA+FMhIPON1woFx5uuo?=
 =?us-ascii?Q?Hjht+7DMkdTbcCc6J79DyErCND30AaVHJ0TAznUH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08842954-c57c-4d01-a5b8-08dbc269bee1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:32:43.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI16VG70bbCJTCOucYMza4wzCRJ+SxR9QBoGiyJggaEfMGDcA6lLCV3MAb2o2h4Jce1xcvzEB08SeZHaboG7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:07:40AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlxsw_linecards.
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
