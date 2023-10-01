Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB09E7B46E3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjJAKeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJAKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:34:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0133BBD;
        Sun,  1 Oct 2023 03:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLfVYSk2ILAHvNrghmXY82dWUTv4YC/50kXeS9lm32AlK3CEXeTqGJa//hkJvj40eQeiBWE/NKBGtczJlEy0K7vpfZU4d4m0EILjzLKBATSqozl8Yx0XUs2FPkiGvw0kBOxCTju2NqJfG8IbOMkJv6gzsTvjjl09tzX3WITENJgS2zbYGe3/2t30XHglq6r1setGEy9DQDrduCW64WogcPZjx6f2aQOadypKKSCnMeXmpPQIBSXTOoHPhqGTeFU4iCET2zBO7Wuwf+Q77LeHSpQmAHB/XWZ0YQB5BJ/7k61W91xF2Xc4JWgW4uIgLq44e7VIHTiSphtY3nAO9ssuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFJf0FJ/VXifoRa7k8WEZJTnrBvHgcveqOggbDE1POw=;
 b=mBKj/7r91oIhoMdjAygOYb1+Ve8DypUVGOUh8hLfIBFIS+HxKXidZixKZ4KkuXWgRKJvkeK1XC4V3qtLwQnMw8neNeqtdmk7h8s3PO67Ge8OhNo7BeEmBAnos4+1dE+g6QjKRxoHZ29Jrv0zg/TbZqxpK0FZV9ZICgbOrvtJxw5qP0Y4vEkptYTWDMWsYKxQ8yPYlqbB4I8lGivXxjBW30mT4LZlARZ4ELTswqyZr5E2FghoAqZ4q2xzOTqq/pSLinbeC21yN3zCbZQt4uK6xKDt9YIC+dcS/iC8hkXOAg8m+ajzUAvReLlnF9gr69EJQdWe5O2htVaZfnTCbEIfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFJf0FJ/VXifoRa7k8WEZJTnrBvHgcveqOggbDE1POw=;
 b=ZO6ZDidT2d6rY+nY24FRGG2Q18AVjnwXifKBdBO3y93EOt4LwBLU1wk5EzreLBzehy0FgDY1UyrqsPSyA9FoClab9xwnabeuacoD5gwp0nh/4Q7bbm7kaJBGbO+rtPf6VhgMmh4i+JJw3554UF92JFedW7D4mt059kkI1tvowqmn6VmglI3Q89vdAloPAzYZjotA8HeaN52FzO6i0wToiYx2aq67tj830tvJHWJ2h7c5QVH8IGwXumocgO2K3low3lqDoORIhfIwoKabLDmpxPHzy9gTA/I75taoZuPlFO2fm9LcPzSDGKXhHNNUw1UVuYXgj2PMQ7OXAtn9m3CNLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Sun, 1 Oct
 2023 10:33:59 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932%4]) with mapi id 15.20.6838.029; Sun, 1 Oct 2023
 10:33:58 +0000
Date:   Sun, 1 Oct 2023 13:33:53 +0300
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
Subject: Re: [PATCH 3/5] mlxsw: spectrum: Annotate struct
 mlxsw_sp_counter_pool with __counted_by
Message-ID: <ZRlLEX8DvxFUdR6y@shredder>
References: <20230929180611.work.870-kees@kernel.org>
 <20230929180746.3005922-3-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180746.3005922-3-keescook@chromium.org>
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6246c01d-7a8d-465b-b188-08dbc269ebd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAu9OICrHyrl5nULZcaJc8zuF8IqckYEi5P8hL4bh8ROgKHqcnw5sScy8SrWUNpwTeUnFA/E8ndQlpXAbmG9OVPjWqQ8BT+AJiuKQOzDcd+BFE53eQn1VvE6qmrK8oKVIq4ABkAXSlYgSt23nGa9D9UBJdjhQ41sYXZk+4sFpRGK2e3ut9DHEQ+SfloY+guRBvHH7J31RGPl79zSVhLI6fEH/u4W3oIh1dG9h4aHzMXaGG7G1P3SdgupdQg4p7uuT+YUsF3J5Lp0X/ZYjKJl8eDYQdi3uvs6yQtW1MCShbBE0p8KUm9Pi6BdthwQ22PO4sjsPqKbuFH7x0+y41W0GW78Y5nd5yiiJrBKM6xpFpai66Kw5PAH1t3TKTiLBDLD0HsmK3032dmVOh12JBwIBtml+Clt5229c8Pi03Vf0rgWe0LHKrNh09O1gwjn0e7SZiduHP8pGONG/9NXDmmhg1SU0D+lOXYsCk+vXvEOoKW8q10QPSOhL8deh1XJhLSLcBPh/by9/thu4R7rLpzq3p8REPQBk0HBBEehOUdUyfBmKu7QqbUOUvs9yWzrwBR+RyyGA/FqP3mwahcRlhQaj9VfWEl72IbeQm7xV/M7nyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4744005)(66556008)(2906002)(66946007)(66476007)(6916009)(8936002)(316002)(4326008)(8676002)(41300700001)(54906003)(5660300002)(6486002)(966005)(478600001)(7416002)(6506007)(9686003)(6512007)(6666004)(26005)(33716001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dKrlMPhlxn3YxMnsur1c9IMYbKYGpPTt7HWKNr4AeLqxcmYGd4Slbj3qaoJi?=
 =?us-ascii?Q?Ism/4IAupqj5SHS1/pPeXxzfwx5+9Fa8trDwIMJNhS1QAN86RbiUhfAoSz8e?=
 =?us-ascii?Q?BQaNy5XBZgNhMePGZkvRGiWGY6gTz8FM5p6fi/S1ndwU2uTuKy32ovxNMXUX?=
 =?us-ascii?Q?l6fdEySvrKXCQHVnrROXBlO3pXOgEF0py4Pm0ShUcnNh3wUt2pcvzAwKxl0F?=
 =?us-ascii?Q?r1G3nmWAcs/JztuiecgIbmpXETh5CEFYkMPpQSRYgFBeGVZMXdce710REhqz?=
 =?us-ascii?Q?aSKASF48kq4zF7Ojv8Fpp0BTWjIQ/f/MPqtzR9EUrcXIHA2bNh/+UH4cWrv2?=
 =?us-ascii?Q?rcXBy5Ptmh+ydI6IQkq6Wk/jsSEUz1XZoUEecW3QZnL3XMAQrf5wi7PtI9FC?=
 =?us-ascii?Q?j5qsUEQvGERsbsgj5yysqP4atn0nmvhB6iIaaPVbbtclh1uIZL/CZE9JxCI0?=
 =?us-ascii?Q?swOwFQP77SnKmwS80AqG1dU/7tih4jdHx+5EJt8ws3GlQvZvTIW7650UnJPx?=
 =?us-ascii?Q?8qFl73QAs3p7VxPsq4XGaJfZInbxQbv6U86ANNu9hPq2pUvHFZ8UxlWK6WD8?=
 =?us-ascii?Q?G+bXBAuLqxTXpi038lfr2p3j9a6H0MeaHx1A9sBVEWoQ0QkrJHJO1M8lMvAs?=
 =?us-ascii?Q?6+kFDRS2LjBl6GvSUVPj7u5MFruOixIZ58qkAmCbIBeHtW9umkgt1l4QPGuJ?=
 =?us-ascii?Q?/aYM1QzjFwXCu+XqsdjpcZ8i5OIRo5Tz8I7nY8TqgneLR64OmfnfY07z5XrA?=
 =?us-ascii?Q?4uNt34KZsIOdFDJzbK8DK0wdwPj+qVigCoZpNmiOaGw3MU2I0NEbINkCh/P8?=
 =?us-ascii?Q?YQCmYMOtVcSTzhcyGSmjZF9kPV/G/Vy240z5MThkG+CrWlkibPaqMzh25tHv?=
 =?us-ascii?Q?/+Oc+RUOEaAQqZeTaAbAlbpmOyAnS+vyqPav7epbV/rswPS05AQ1nTTsa153?=
 =?us-ascii?Q?7aIZ1ZZw9PwZV/ZNc9dwxftiW/mtrRnJHuJFNtRM9ZhigMFQvrqJ4rdgbDl4?=
 =?us-ascii?Q?xXdaOOOezmfgELdRlamJOmN7+DRfSQ+OZN77rYlQiN8EwnEhVifOj7Jb3lfL?=
 =?us-ascii?Q?HK1lBP6cza20P+IkP21ShqHoy+F8KAh5plFfQVsXNtds3k9ndL6/QqcUC8ng?=
 =?us-ascii?Q?T3EsWJnEunRcHjV2GtSdIFAKkZT7N8SDgD5dhbBcA0o4aJ5Ls9pS1rmfdDDz?=
 =?us-ascii?Q?895V33f+yyhpUkSYr/xjOVQ/a2cZ6AFiP122Zn0b7yCINSCQCeDHd7jaVGUm?=
 =?us-ascii?Q?+9uUEbhd/3mI/Lj+GVqyWsHEQvse4Y5oipg/ksIWrXhXGUwN2k3ZNeu1aGIq?=
 =?us-ascii?Q?3wEzIploVAx5Lw1eUjj12jc7kHBmF9xhyRAl9l0dkSx5WK+Ez+5ke6h58Nca?=
 =?us-ascii?Q?IR/asUkXwwLCvQ8dcUpP7cnZISCiBwaViccZ5fYMkijpaPlZgyHLm+lAVReE?=
 =?us-ascii?Q?6qwjlNuuoVZU5JBd5swjxP/bAc2U3korQ4YtA/HB5Z2/zAniJsyxho1koZAz?=
 =?us-ascii?Q?Q3nA4uPWZyQWElJKJrXS+kvL97hQxKcalK7W8qsmfcOH2dgwU736HOUkUEwm?=
 =?us-ascii?Q?Xb8Juv7BC5Xu4PKLXBJqP5prV9bgZpcDnDuuVaa7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6246c01d-7a8d-465b-b188-08dbc269ebd8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:33:58.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqP1icaOC9hEleUnsZ0jLxZW/q6eOvKzEO8513+OvXp2oDVashKb22OGyy+wsI93qB9lb7ivHo3/J1VsNjUZFA==
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

On Fri, Sep 29, 2023 at 11:07:42AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_counter_pool.
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
