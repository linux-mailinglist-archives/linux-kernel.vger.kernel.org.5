Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B490751E01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjGMJ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjGMJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:58:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2126.outbound.protection.outlook.com [40.107.92.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9A2691;
        Thu, 13 Jul 2023 02:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5TtCq0+X0FZkux0tIfiV6mV0Ist2ouaq6DirynbMKgetmT1YHsDGKAu9vbcWA31f8tfp3AJfR94hNyNAGKwwGuAckmLVHkZDzQ45pk2w+pxzf2f08qINA4e+6HAguVR2LkjKGUntoecQM4zuix56ImdcnlKHrQ9G13utbQ+btzrg/rI8UdRPp5+OBE3JaHngLZLJ3/sb88hpTevhc6Ydc6Azco8kOxTvtC2sQJ0SUXVgxXxwI29RzXyunt0An145nfMHO55i/R81x9S9D+qHwjpONX7GsQQqid6MsoJLfvvoUp39THzc+wo5/aZIDLprCxXV36jr1gD5JvIy0EPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eU/zDySzTzNKYcLdEnh3W9jTVuF8vGTiZHoiLY8zIw=;
 b=G0dWyzX/rzSnbN+hZCpR1M9h6zRzhB9IO6+lCJhqdWmAAmfbqnEXoRniyua+iOQQEOe9mO3RO4IgE1QQZKV+qygGXZvFLjGh+RKl79ormnoxtiuvCedkR0wTh0p/XzKogBpCLxGz6Fl3xupaNjHp0e5Bsy0UWW8DhVVlUESy8nQQ05DZPXgxSXhGntAl9BhR/MA1eCm/QKNmG7dreDzxcm2lWEsLw9gjVlgjcVhoL+RbwSV6y9V6XTxvoma4H7ejJ5PlD7Ky1C5wSNPW8hBVImWz02IGOzKDUH2PDKa4EsMNJXvekVGgNt9WOgjd+FGjOfv75LxNXvmHgzq4/KHzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eU/zDySzTzNKYcLdEnh3W9jTVuF8vGTiZHoiLY8zIw=;
 b=Q32wh/zLikEUb3kh/gUb08JpR1jDmylP+iRp2DZ6WIg2OOI6vtVA5NyBY8bZKcaSLVrOsMt+lrYWtVgAU+b5N01GQAGfHaXSx3Dy9r6nSLKTwDNv0gXMgnuMuxV9HXqRAXs4i62MFD06fdF+GNJLaD68iQ+9j7JAlXAhQBRwo2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 09:58:25 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:58:25 +0000
Date:   Thu, 13 Jul 2023 10:58:18 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com
Subject: Re: [PATCH RFC/RFT net-next 3/3] net: stmmac: Use the max frequency
 possible for clk_ptp_ref
Message-ID: <ZK/Kusx3BeCznDoY@corigine.com>
References: <20230711205732.364954-1-ahalaney@redhat.com>
 <20230711205732.364954-4-ahalaney@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711205732.364954-4-ahalaney@redhat.com>
X-ClientProxiedBy: LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8eca8d-bae3-4db0-f936-08db8387b33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Np2QeTDAgiBXito+cr0fnxv379K6zDiS9J4yiEwcOAnYrrWQWzRgjxWol30JOPG2jIw9fv3Dq+/xE3k6PMWv3wV4OJkDBy8N6ZAbFjQx9wiGV4M/4zx+FsyR5OrmN/sXTSnChRbec/zj5JN2OLPseebX4JQ3K+VZQ+ppEFTn64IqOMDnM2xGLI4NhYBGCm3V7XKI6beCQfPEed4Q1Fcpkv2WXFMv0W5jccn/fHqdoPVQ2FW5UaFQ5kzjuaOo0Rk40sre1WznxxB3KPF6J+FT3RgSYW8Ji3JKJovZOXwwBcB7Rw7JXrceRwIrFmgevUm3hh5wRSMd6gzDNoWNackO5Ij9Jd26jcw+z/tIRCIKfUKz2T/7/9h7Rm00s1Zek6xhnKK2C+1Iam8wHsoi0TWQ++DkBmZApxmjoTjHf3Nn5laoM/+kUhwMiO3netSf0q5/MwneVjS6yM+JfkpD7MSfMKZtZPjcD5FlPwUd2GCsjRWO7+SAmKDTsEE6g5+hPbuWH7DM7Xo9ErUr5gKLdJSQbAHtJt3ImDqzr/pvfmeskeW42ghZk0BPU9H05QXsYvA7nwdGnpDTfKvbJgJ4WrvIJM3kfg02ZZNmaeFzBmJ5uks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39840400004)(346002)(376002)(366004)(451199021)(38100700002)(478600001)(4326008)(6666004)(86362001)(6916009)(6486002)(66476007)(66556008)(66946007)(316002)(6512007)(558084003)(41300700001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(44832011)(26005)(7416002)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTYdZukiuarug8U7jUBDwlEaD9c6fMoakQw141apjC0lX5wXEx7JaEab4/HG?=
 =?us-ascii?Q?TpARjCAc1gz9/m+iV3km8BFVX/tDk1Qi9TAqxX0Hl/V3TjyF4d1i6L3p5nS8?=
 =?us-ascii?Q?TpRKQzSrWKSvB3yFP2DOtndvAvuVgSri5d1p/t1noZaaxi29D9EnQNKB8HQG?=
 =?us-ascii?Q?L5MDyaSzhelRuhakPWCuU8uCJmKbKCbg10iXpCm3itkFH8vnm6sLo05hQCX7?=
 =?us-ascii?Q?Hl5txweO71QVyEkOPnVdBRInHA46ZEiWSjFMbGc259FIPwHTFx2kuiQvCEJO?=
 =?us-ascii?Q?99RzkfQd/kxdIlSKqu2ks7buedtfSkx3sLFLqllmxUQgK81Bfmkw6Gs4Q5Yo?=
 =?us-ascii?Q?DIv3kvMACPnOq7UWRDQIm5cQr+Y1GJkrThIpb1owmkBDYz3ZjB+GJeaP4V+z?=
 =?us-ascii?Q?+OpX4xpnJPDC716UC+A8jUDShQkBJSfElj+IT70IFBUxx1wxYaopks4ezaEe?=
 =?us-ascii?Q?bvF2GuLIKoFHe0t68kO/aUKXt2QBua/V08c619KneYp3x8cqnmkjH0E2meYz?=
 =?us-ascii?Q?lElL7drWJe366ZbiNozJV+VEs7QpXO/FFm64cGTc6WaraufMaTGhkrr0GQ6Q?=
 =?us-ascii?Q?ITDatOtuPVq3H11iXh46tjsyd0yaGU2XyhMyfCFgkrd5CTCaQsq8DLl8EaRe?=
 =?us-ascii?Q?K5kv3hv3tUTU+aRDCFnU57P5fEH34pZ5p21ZwFreeIvrkMXQGlKRf7/VZiWG?=
 =?us-ascii?Q?sD1QC6KNA3MDL7gtGEvhQadV4GrFDXTpMZun1xCRnaGHQNkJ5MApv3WL+5HX?=
 =?us-ascii?Q?UMP0ha+vgcyWwS4sP/jt8swZo9bBdc6H4LqjbsuyrZIhGJYhSAZTQuIoIS08?=
 =?us-ascii?Q?hrQCe+KbEoa8RDivVV0Gh4LysROUZJspseMubcgtm6uDKm2LWguVzSx9TPoM?=
 =?us-ascii?Q?Iqt4uJaxyGem6GA0g5gsDuRCGxi+/JwBRWap80U13VIxDMy7+M66Pqza1wQx?=
 =?us-ascii?Q?8lvpVZXNYjEa+cBB680wXY0ph6dpSA256gF5s8gVZOGcdr/f4PwcxZ2/FnTa?=
 =?us-ascii?Q?rRPRBF3CLik/GfzAYjNsQn2NEr/jaS5tqoF6UsEqDMZyDlmrdWfSNRYpPGH9?=
 =?us-ascii?Q?FeHNTw4BClLAtsX5KQ0YZ++QMdAcvSvuozNc6D3Ib0cEXW+z3qTqQZLPLK0J?=
 =?us-ascii?Q?Cy+71jXSOfKbpEJdou2fwo0qwc4me3zZ62G+0kBVQf2qtA63g7h4YwzJXl8a?=
 =?us-ascii?Q?r+Ed8JO1xqb+QmSEXcrc/v5+X+MqiHwlYpzok0baCI8kTqX57ogGIO6pIiDy?=
 =?us-ascii?Q?4Jit/VUkI+VqwrX4J2jpZyPiIq2hUIMG56nsPpsXQA2tolLAR3A+9AvtMDen?=
 =?us-ascii?Q?ELC5TPjgqCkQKXNDj8KvUdD0dD3++Y2f7gnfF46EymRu5UVAGe93UtCuiWk6?=
 =?us-ascii?Q?ujKeRG7tLod4JzvT7kwK0RuUqe9jg8Gh+pEclmxS9tWfnKmOzP7PeOm8JoaJ?=
 =?us-ascii?Q?SeQdElFdy5souXGJvvbgk4v8h+ibcDsrUZYJUGyN2dSkyYDcwqEpm1BS/1Ro?=
 =?us-ascii?Q?jvvQ6e4NcPHtpLYNLB4zh+QrmBncCFdFHhl4XmUHdydWr5rJC57fWpX7WQd9?=
 =?us-ascii?Q?tGr69pfsUF5kfbg8bJtER3oYxjSrXCgBcfVmeJycEOBNRS8UPZ33GDAzSfJT?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8eca8d-bae3-4db0-f936-08db8387b33d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:58:25.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVUGkYT14TjiG9D+AJ6H/m2vcRCNgLJsW4VKndU2irggi+F+IOaz42LFJIQ0kvsfKgzl0fimnVvWZAtbXxan6PH3QZpm29TNC5VCZxSseLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:35:32PM -0500, Andrew Halaney wrote:
> Using the max frequency allows for the best PTP timestamping resolution,
> so let's default to that.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

