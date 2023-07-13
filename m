Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57CF7525B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGMOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGMOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:55:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5DC270A;
        Thu, 13 Jul 2023 07:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+DXSnIQM7z5CWs80rXZcVtLHqiK4bNOOk/7cAAZuweISmmA9q2CgxS353hOZp9+fVGkrDN6BAfcEC9JFB07URYOC//CWMh9E+1R2ZXskyJHlrlAVsnSZeRWl40iNsBxPjnURqkrXSt8Qk32bWzpvxl0kgYO0/mShTtekQBLr1KpCPoBZo9ssY7CIy6DlR38hZon8FwE1igeLiSn8yz1ymgvYakiaZDGqEZEu0KJFoO1yALX++Xb6ftILD5AkGsouxQvwnabSYAh2yOxUfly5O2ZBAWGLYXJp2LwRU6DLaEELXPHdvxcdKK7U3WtECyf4e7kO1ln/XmTJ5JQcKLJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K88bsinaG/iZwas0uHBzlSYeUrpYiqhfZhJyj0evjc4=;
 b=gIA54T1ygwRG/FLic0DhRj+MU5lvuQZC1Atxuj2x+szC2muVRjFms7F7YHlT3SOEo/MqBuijTMYvPRlLSwppyI4A+JEoWA26Zp1p0TMPUJqbhdqupjTORkwGy0+uxAVa4GTdR5DJQTQ7tpUmvRPbMnIIuEQ5c+p97X41Lt4iCNdMzaKL9knlwlOWjTAMpx05h6do+yedc0Dzzc1vOGkNE3T3IVbqaazw3w7XkMGul33He0TkLeBGy2bv+P0rDRrdZqQnjSvWl29VuvNI0iZWv3HDVoEjQtYVs8yAnrmmcEFjbRxaA/ET2THbXdJz0R5VzmQj+bMmuCxjVza2qL5qfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K88bsinaG/iZwas0uHBzlSYeUrpYiqhfZhJyj0evjc4=;
 b=T3NoakaPmYjEiAFwwU9hPV8a0cvA1OgDLg7ldNqXpOqIrKQ/Gdw6rGInNSFmYXYpqbDgKUGWEDB6g2SVvdgGQqgN8f5mZYgkIwAne5cgYmb4AiQ3IcsHgqAf9tJevTqzlhNgOn8+20kP9tW+p0xvlbe3iGcCu0e+TCqrirXvoZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3712.namprd13.prod.outlook.com (2603:10b6:208:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 14:55:22 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 14:55:21 +0000
Date:   Thu, 13 Jul 2023 15:55:14 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     mani@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_clew@quicinc.com
Subject: Re: [PATCH net-next 2/3] net: qrtr: ns: Change nodes radix tree to
 xarray
Message-ID: <ZLAQUhAw4yqEW6Y6@corigine.com>
References: <20230712112631.3461793-1-quic_viswanat@quicinc.com>
 <20230712112631.3461793-3-quic_viswanat@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712112631.3461793-3-quic_viswanat@quicinc.com>
X-ClientProxiedBy: LO2P265CA0372.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3712:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c42915a-4a18-437f-edda-08db83b12e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9AN0Aarpj6350xi5S0FoDJshQSnByg5i8wykuwtn2GN/ZpBN1fSDDfflvYZaeTMjskJheODt69oIWQxthBwhSzEyxknk53+6rltyEvGVJuWUTx53oTK1xVKyzIXoRmyAyu2ndsDjOrw3P/iRi3Ufih7G1gVxiyi++EfIejxKFn9qAWbfiTS4aRsWHhXDY5bCssMyRg9sMrfSqeyuHoesDnD5mlccUasMtNZwmwDhaJuk9b1wBofaYRID7NVuqqvTPR2xmBjjKFnLUKn5Cr0RiY/3vStfv4nOS9sL2JoNKfP0HypCHfCrJ0VYlvS9s5P4syR99WMFoswb0rYZ8tAaighL+lX9O7Aaxcksf4XlFDOztGjAgr4cvKYbunmhiiKW3JIiR/kPx2/CcytegATxUUoKsR0oX02bQc+TwBZvatgeR/egt/ng9ZTaTBXy4c0EiZlczDhw8enKflSTJPWA7aUrTukCgkWzlmG5teWEJeTEi6qXb/YZDtd0BEecPcc/0ok+OXx2oBs/l3ly4Ac72ItTruJbJe9appIOcDfmyCLhC3UvbbF/28HbVbf0GldPrDKzV/SetOUsQKSK2intlxMX+odu05ZeuGhqb5Culw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(136003)(396003)(346002)(451199021)(66946007)(6916009)(66556008)(4326008)(66476007)(478600001)(86362001)(6506007)(26005)(186003)(36756003)(6666004)(6512007)(6486002)(83380400001)(4744005)(2616005)(38100700002)(41300700001)(7416002)(44832011)(8676002)(8936002)(5660300002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2NkkFI2iW0RalOoDHj4L7tqq+/Ni/g3iZ6SPc8f6oyZN5eLVCzzl5/rquNU?=
 =?us-ascii?Q?nLdhKJODIzGXCsVd7PMhqQvWGnSSypflrwGfotPFpKrWAWNLlWo1nAag0rXL?=
 =?us-ascii?Q?vviYMrqP21+BYtCPcx0JvAogO9XPE9rP/pJDB4c8L5zKUgeivQy+NL5NnCbb?=
 =?us-ascii?Q?FykZr+Qkldk6g2SHNZ2vqXn/LcRaTfAXdmOVrWQkizYTaGFCjNzROhd3nGy/?=
 =?us-ascii?Q?GQLmbYq1qKneqe5Fi8MSizGST6yaCjjsZrulrbKDCwiJRELv2YbuRgqZK2mB?=
 =?us-ascii?Q?THTcNjcaLStGMYcQlaz470+j76AoxMVNYOdpg0Dn4bd5/69Y9Sc0tdEVDG8+?=
 =?us-ascii?Q?g4ludrb2XukVF+EI+R0Hk6IYDIqEuHGxnJJaOxixcWM2D5GbSS0ONbjAFsvq?=
 =?us-ascii?Q?updqEPIZvGqi3E44xEbNF/8h5A19pW9PVakcdZdC6My40HJMcGxk+XNBc2rn?=
 =?us-ascii?Q?WZnAs2Slf8/Auo4iuwhAVZwvitqWJTyHutDb65d2QFi22AgjoA0Vgc62UO29?=
 =?us-ascii?Q?BVbmYR20DniRwC0536fMuSvbJoGtuud2BgDmtB+5LhlVd+DnCTXOSTy9H56S?=
 =?us-ascii?Q?AjPH1o5A8NBCOZM7Hec6hmo5HXH8ZIf1wWD6l2W+7hCcGIqAfbd342BqjsuC?=
 =?us-ascii?Q?bYd7Gngn86DCqBrEUZTbTWie34dlOOWqezUC1Vqcd0hPPzhIzTyNfkoj7zPN?=
 =?us-ascii?Q?DS570qDdpHG6jbAKmx9XCwvFiJ5S80icxBF6mtPTwwpnmxdyaqIspYis0mTW?=
 =?us-ascii?Q?jBqcwXiB5hZz17IfG4p72cwadNejuR5xbsl9TlyYSPhU7nTuQYZ+M33iT/eD?=
 =?us-ascii?Q?qhdm7I5dWlU4Ihu45++K3ban4qq7UyZRRPs8LxPDb3cQjGdWhFs33tTK4tMU?=
 =?us-ascii?Q?R9zayFn4EJ9E3oeYuRUnOfRwhWagE5G8wFMZfM3qOlJRTK48lbzXQJsB7hEX?=
 =?us-ascii?Q?jZiWdUPtWelzMRkd9ip4mpNqYRJYcbgPuUHhbh8NOb+7ToyOk3zYaweGK6x/?=
 =?us-ascii?Q?DO57LeGMwAUpLdgwNeDBG7BlseMRWIO4dpXcertbWUauwhyQqhXiCxgyHkPy?=
 =?us-ascii?Q?LHQRP4AfQBqsgWboGG+ipEI70e19sf3BOVkBIZaFnK0C+U8AeHkJlxRndAJb?=
 =?us-ascii?Q?Gy0Q2cnh6DtPRc6/ngqga7PUhmuXBfFnghv6aEUsYZ0DNNWDQAGFtSTx2STs?=
 =?us-ascii?Q?FuCoK0x+dVkerdmcqDTvK9aDsMmG2vkVNcderxwyU7099yTF3lQdrrt2apmR?=
 =?us-ascii?Q?k+3SgznNJx70crY2w3G76kgVavxkSNbm2yrXva2CybAJGxBdPIm/f5s0zfwY?=
 =?us-ascii?Q?R/VELKF5s2A3eow85MGRJ3wfSgQ9tpe+MCGeRda9pwblVgBJAPKhuFTwrH0a?=
 =?us-ascii?Q?ROG3bO88fmIe9GT0KJJKRLLwy3nrsrI3PMtUlPHtsctLor9/Gd9BdKHvgAs1?=
 =?us-ascii?Q?3QmlYCYYI5EMZ5PtzaYti7c6okG34kdFMjAVUBDV/SG3URFAOU6QyFJA3KYJ?=
 =?us-ascii?Q?OGiMkax8dzOH/lKiSaWTSa1Uh+vR+6KB8iL0Lm0Q61+akR3xgF9+RQ5Bmqmz?=
 =?us-ascii?Q?2NZFIZJVxg5o0K1utnlfoJqVnGs2DDXtVT9aCjAeFiDs155bZXRjNsxzjgPw?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c42915a-4a18-437f-edda-08db83b12e92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:55:21.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWpjNFrmhdwNKMz9ygt8W0XqL4p1RC+JWYTtdrCweg8SQwbawuvx0wiLyN7UDpm5JG2yhl0Tfg7SnC5QPz7XxVThCz4OjiwGK/jwMItUjd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3712
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:56:30PM +0530, Vignesh Viswanathan wrote:
> There is a use after free scenario while iterating through the nodes
> radix tree despite the ns being a single threaded process. This can
> happen when the radix tree APIs are not synchronized with the
> rcu_read_lock() APIs.
> 
> Convert the radix tree for nodes to xarray to take advantage of the
> built in rcu lock usage provided by xarray.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

