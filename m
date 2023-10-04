Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9717B7760
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbjJDFN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbjJDFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:13:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2135.outbound.protection.outlook.com [40.107.100.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AF9D3;
        Tue,  3 Oct 2023 22:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHNiXOXxtNhouLTq6PRRLPHK7W4WFKXBUY4kANiBQkqJLLrFx8o2WxQ+DKQWjP66sFuTw4zpsqvveuoZxpJO5kdWavvbM94RQDkqWgTc1ac6Si89/CeIc7u9ARuQfZ1ScpkY3iCX+GTAWLrLuAyPLe2yaG8ZvimMGR3oo1XxReO0Vi6xa4fPVAZvbPqAGwZvFfAnzDkpfpCRwNIIL3uKguqL+2m5mmetOQa3RboN4mhUlmw+6JRLnhNL2cerEkfQeY+qFT2nHEfM92ZYuWYhOmOVY8aysEu4QlLHQGPTJuCaH4MzJ8Sj6NZqr/ST8ZwVG5KKijk8FA0V5D6OGOal0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujsIH6B7MX90cG1QIfl9mLuTEjCvd0hKAsf0RJbCiAQ=;
 b=JHKfPYDxAUo5nh+121BIU2jSWDhdUz+RJbo3T1/x4E/p76cTKzt3mAjiGhiCSgjIMsmFRhyhRuY80JrnaoT1CBdZVrHwdOO/mzRL+fsUnRGN5BJbUaSmet6QL+HPH3odKBhmG5sBJw7dMjdkx2Jqccnx5XIwN593TKqHmflGuZzvUO0hsy5RdWYEompBIIkyFqp7UUmeX6XRNMAdWNnC7T8Nzu+h+zPO488g7762ppQPPMIJNY0T0+Srhm3KfQM6rO4e00jgPTxTmxL4xmhOm00E0PVyGSfRhAlMh8RtwzInGbQytKlNTp5ISxtFw5ukDvIWLYCo7bdOKMaTYIKZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujsIH6B7MX90cG1QIfl9mLuTEjCvd0hKAsf0RJbCiAQ=;
 b=sLBWjykx8/IEyDNCS8c7KueqlAsv9b5jWurNWP1zd0CpAjLpdtFtTqoRxbD0kRv+cKbtXQmk/q6goC3sVovRd/Q1fTrGk4RL4GCG9GsPCfyqJoRH5sdBnHVkBO8FOHh5NjgnvOz9AF6KnvMeHTx/VFZDAYOh489A8G9E14i35O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB3721.namprd13.prod.outlook.com (2603:10b6:5:24a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 05:13:19 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 05:13:19 +0000
Date:   Wed, 4 Oct 2023 07:13:00 +0200
From:   Louis Peens <louis.peens@corigine.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Simon Horman <horms@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] nfp: Annotate struct nfp_reprs with __counted_by
Message-ID: <ZRz0XNOJaFUDJ8yN@LouisNoVo>
References: <20231003231843.work.811-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003231843.work.811-kees@kernel.org>
X-ClientProxiedBy: JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|DM6PR13MB3721:EE_
X-MS-Office365-Filtering-Correlation-Id: 1048419e-4a2a-4fd6-f913-08dbc4989f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcLqzu248NgPizpvNHgSRl/wmBAAMZ1/fUFih7lFf7e8++bdL9uurp6uNmPVesDIBkkO/oss5fWoyHfFix+9wxq3L50qL4Kjlj+ezEaZsEQjThY55Dw5twXoE+NN5Xg6zjt+vNqIUoRkHs9ZijlX/TEjTNoZI+Zb+UlkHtqE5bnAJr3Mpqoe0uTIgN8LPqTgqAMLXBtGJtGkHSPuB+D9ZsTHWCBzJsYyTXlW3fypOKNruptB6a/dIeVZlx98Ta7HDZAkZIGHvhu65NT1gp8+A+Fq5r1LZn85XSnoLjjRBTpEUQLUUWiUPGzBnD24TOqoiYtZYqzharieN797/kaQMa1wq+gzuboz4THC7XVpZ+dwxxttTXyic2VvVacBS22bxgIJm8CdCVP52l9gnnleMVZZIQRurWVPvHnAXBClzQIOfwex8tVjLtjRPOxhqHAmJGNtOMCZFzbVXeR6ga9bLN9eMSq3U7GtDn4JsxD6eDNDFEED2vQyDrxHrsoETwcxteJkgLV7Tb4ytD6NHirXten5ELUebe0PnWwbaMl3HPi4gFGK8Nkh9j+jbCCBznNYPokbmIVxTtWPBPn3Xpis5j5puSWRasUCYI0akyeviXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39830400003)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(6486002)(966005)(316002)(6506007)(66556008)(6916009)(6512007)(9686003)(66476007)(54906003)(66946007)(44832011)(8676002)(26005)(4326008)(5660300002)(8936002)(6666004)(478600001)(7416002)(2906002)(83380400001)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfrIEYcD6jtZfd+YAhJ3m9svti2cklTBVsIxGBPuVsgvb7JeN8MUd6dqVGdL?=
 =?us-ascii?Q?M2iARxMI1pSx3YJg9r32cAYKB1MpRv4q7jfvWETQ9nl5whbRFUQwXEJE7oiQ?=
 =?us-ascii?Q?rXEM2FGLMHc1x2QVMH5UyCQFwIUtrEgzs+cf7iJIjF0mOWJDcJUAB8GvL6c1?=
 =?us-ascii?Q?ZMdzDfeQ6Xix8ZDQbSl/AWSJhYGZ4rZhdcGU0YalH9WiHNMMYxrjv/c4XhBe?=
 =?us-ascii?Q?gw8JK8ep11F19TRb8zsluPekcAZC/JpBSPO82s4gDejGpanf1OPwgK1QUXYq?=
 =?us-ascii?Q?qBPS0H2niemcNmeIBmcYMplTkcsH1igod8db+v4zoPIyir4a3lE6cJ8NXXET?=
 =?us-ascii?Q?kQYCiWty8hWw/QbkDvCilgPY1FSCb4wTI7w1yhv9FEUax+LPBp7HoiYvYvBU?=
 =?us-ascii?Q?nePDUwFhTVtpuK70g096s2JPJZw+pkr0vmVtrDPceuQ56n7wUPbAUgUvbn7F?=
 =?us-ascii?Q?DltC4nKavkifgcLXCzzjvKEfE1xts/KebEBv2DN8tGxxlW/gfTTXYoUoyTw4?=
 =?us-ascii?Q?SosLHMpIDicIywPGXy6hXcZEvcX6gwWu6uJHCSoYLdOfLg8YIVpU8Xxazlfy?=
 =?us-ascii?Q?vECejO2ZURO/EglWqfNav9vuuVwvEhY4Ost8UgnDFTjAhr1XyqrAULz/6oFZ?=
 =?us-ascii?Q?iFa4g4e5zOWU9Lk9E2HUkt5B11WVtmLYeORaK+cWGQRpQAi93lqoMHni7EID?=
 =?us-ascii?Q?zP3NE73Fbn7+1DheMH4MB0RWALvNGaKKMUTRarH5XlOuJpydBZOUNxpf9pTS?=
 =?us-ascii?Q?zqPN2xrpMghGQnv4/JN+DG895Jl27qsy9vL05cR8c2Z1ej07FcL9XWlxyrzs?=
 =?us-ascii?Q?iLvUyWss9ko2xkKQADlrIwoC6w2ZFsjrmVMExYySnI7oDK4BCDVpaJGk6nxV?=
 =?us-ascii?Q?xEKST4+Df+7YnV05M31+DzeiQTYUXNyBHaQbsIBggmjB2+rWBZlf+WXihz6H?=
 =?us-ascii?Q?OXJZTW/etLAgHS3idfUcjav2Apfqm8C+LoT1nbS2QIHjVUeGhgG8ufTycQoA?=
 =?us-ascii?Q?t5tTG2UtzZGS173FbWZxnZWQcTVAiBEzxnu4F7YbARdqf+vAWDxr1TT5p2zU?=
 =?us-ascii?Q?+WK7Njf6rZOjgUau8BlG3p8Xq4NKwuUZimPJ2Z19KOr6Cv4EAqfDr/HG99tr?=
 =?us-ascii?Q?GsWyuWujoSYgEPHI+y8yA4GwlDkjoRwpG6x91tWqLcigd486poLpFAK6F7Jl?=
 =?us-ascii?Q?BRhbVHOGZ8hYlengByoGdmz7w9hp8Tj4haTEzdqF9imIEO1Yo9bDC3+yXN6S?=
 =?us-ascii?Q?4DUGZMna7hsR3+V+QNHwabaN+765VlXQpg8THYXzhrurW8R1Vlx2jVFnVkMg?=
 =?us-ascii?Q?0R1nO7VpJWmflMykdz5eEjgA7RRJGLaVrakPbxLScJEaTcwqPnIVyByPxQOy?=
 =?us-ascii?Q?nhmDiZNMczkv9yfKU23/Rf9ODm4ghGmqYpKU7xCYaAyWMTbENucBcltDgQNF?=
 =?us-ascii?Q?rti6sKBi4D7ITq0MByGjUYwo8LwmjCZsUB5TTdfiWCG8F2BypVo6PIf16YWw?=
 =?us-ascii?Q?PdRDrHQEWc0yn06vgqn0YgJavMzT2MOHSpWa+gtTnsvjNCkjlNizbVRpTB5C?=
 =?us-ascii?Q?9fe2h69kaPcuqNJyX9uzGZVJO9REbhILPlIQfb0b1cDV27ZtbG20tGDkLFME?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1048419e-4a2a-4fd6-f913-08dbc4989f3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 05:13:19.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNYsdON2dCSmfAf6mTh1suoSslhFiETM0EtLlGXH4ZRThkcuGef2PeHG2JsiezOsJmEbZM0hDoVut6lZC0FRJnv57ErnfJUWZJDLoSI2t/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3721
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:18:43PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfp_reprs.
> 
> Cc: Simon Horman <simon.horman@corigine.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: oss-drivers@corigine.com
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
Thanks Kees

Acked-by: Louis Peens <louis.peens@corigine.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_repr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
> index 48a74accbbd3..77bf4198dbde 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
> @@ -18,7 +18,7 @@ struct nfp_port;
>   */
>  struct nfp_reprs {
>  	unsigned int num_reprs;
> -	struct net_device __rcu *reprs[];
> +	struct net_device __rcu *reprs[] __counted_by(num_reprs);
>  };
>  
>  /**
> -- 
> 2.34.1
> 
