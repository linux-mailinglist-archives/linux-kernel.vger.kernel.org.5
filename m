Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3D765254
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjG0L3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjG0L3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:29:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2110.outbound.protection.outlook.com [40.107.220.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23FA30CF;
        Thu, 27 Jul 2023 04:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxvEXIhfbuju9QH9ry9Fy6C2KfV5+QeNRywLHO3M3G2eE+57Rhq7kfgzwcYDBsZOXJ4sKnHJevpdar0k2yEBSxECn1lTQ6y9npHF6VPqJsiZV5TVfDyLy2OK5tqB9J7kj3xhGBWeJI/ihb5ZEyY5MmeXmBYt64fbNQuhbchU8jAY0uJqP/HTIGcgRheea5eeRMFLZ84hzXkwC9gQg39EL8TNx+flEJECe2ALaZQ0ExnIKa2fWmkovDVfQaOo/kzsE5swM9214B7m+jzkKhel47QgEZHD/Scd6V+jG9Zrv825uistn6aYkYWwROGcJmPfuQZgRyiRIgiuTFq3OxXpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1At6ayDDP/04qN+Uus/x8mxoTo98nP1tWBSkoOhmp4=;
 b=lmO2vmHGB6QXQzz9Jws3Qktx0fVgm9mJQ0jWoq0dklvyAmBqWtXEo6Xx9bitzSRuILDyLXepSYBMJFJq2q+TJ2CfB4+XHbCCYWbkeFoRaoOAGfkK2JXX63bopDJBXyer8VhpjAOuvWtsylSB/iX3KSKMrrXsls3GZUf8GJqCnuwr7YESCOQgoSODpe4Oc+SlwkBb4yDuCIoLkm2jf2BeXsTucIumpzpMvKXR6KUTeDJZZwYtzCZUxnO53eZvIRnnT4b/nsheqsiKwz5ow5QPNgQPfJyRwaEZsakoDlLm7L6kJPHomxw424vGxD2dcy4JSmcOOnWLqL1u0sCCfP6y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1At6ayDDP/04qN+Uus/x8mxoTo98nP1tWBSkoOhmp4=;
 b=j6wgjcPRdCU65stXh66CHEyzp6UKpccLA4uCZb1HVNStLk30EQkbXRraGQ8rF8kgrfo+TBGUJymvl0mabAaVcgOBJuG1cIxcKfkHkO9NuewXKGldOaoEQ6OFB576J5uQQbDZtwICLABXRY1TS+BX3HduFqbSAWdLmulRApDEGFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3687.namprd13.prod.outlook.com (2603:10b6:610:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:29:29 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:29:29 +0000
Date:   Thu, 27 Jul 2023 13:29:22 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        idosch@nvidia.com, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
Message-ID: <ZMJVEjMQ0o/0GOKU@corigine.com>
References: <20230726143141.11704-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
X-ClientProxiedBy: AS4P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4770831b-d895-4670-697e-08db8e94bd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SR3dH7kyWE4oycc8EZEanF6DeOL2YTLABe+sw84r7bJO4Y9+mkoBrox9k5WrGUMHamZEAvwZrBneQsbbqxTTMwM0g6jWHfLO++/+UHlvY1rfh9vaxX3W+zNfeQjCoXoNaynMGyxyQKAPzFeH/N1n7focqzp3HU6G2SB80CvRgH431YtSVZRHOGyZVd/UMYl7eoGrgxAZnkYyW3L1cmkgdTL1D8sx+aaqy3/pzkNul7iswMTjSd8yXBX+961SXIkSIirktrmI/CMme9d2bPy71zxj1ldTTFKfsId9ONO/sgkloQIj3uSAg1nHCj1wm6RwkfgSx6Ha9NN3fPUMKbfaLmFakeFh0FmTiG6aV7sJtC97Ui0ZzxJUngEqkgJLFkXQRGn0teAM1VtfdQnGqZzzZBmygbLeEqV6yOyD04hWQ5r8si6ZaaDaLokjcsOhpxdZmB8QtN7aku6YmgBl3NYdiQQXwd1S5AzT5GI7aDNoryZ+7p+jULAUOvVrxOPAVqUzbi8gbIhOqfMWQrFbEeyk+C4yKXpjrBbB3cf9NKW0RFx3XRc+aE58nUWePCPn4h4+Nfr4QKOZdwvRbxRheQajKXPbOBxFE/cBNa8EhPIfM8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39830400003)(366004)(346002)(376002)(451199021)(6666004)(6486002)(478600001)(6506007)(6512007)(66476007)(66556008)(4326008)(38100700002)(186003)(2616005)(66946007)(6916009)(5660300002)(7416002)(44832011)(316002)(8936002)(8676002)(41300700001)(2906002)(86362001)(558084003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0VdOSkp8Nu83RxOJpGgn+MqfGMpM6Mb94QFdvwKEl/5XNlGKbNiMEciNzoOU?=
 =?us-ascii?Q?9AHXPGqK9b6baMpNc0joRDBBhPtltvVI2iVqcmnV2SE6tjgYeqjkd3LqOdio?=
 =?us-ascii?Q?pHlYCmgCYioK/1XAU6Y4gqS9dAW7pU99zLb2klKoxuBI14awq4XRO/UzPBkt?=
 =?us-ascii?Q?71sygpVxpg/vkWSUG8iTcvyaPxnYCkLcCLqS9O6nZUKfG47/MncLH3mtBaq0?=
 =?us-ascii?Q?2hM0iH7qokPBp0eOnV8rfu+7C1Yjd8mPZecvjlqW8zjKc5Z3I+wUtNCDpmBA?=
 =?us-ascii?Q?8yob8xbC8bfwROE0nblFB6sTvhaO3aqBZIsvW5+4AjXFTrVzDemB4APOpa2v?=
 =?us-ascii?Q?G5rmsnh97tX2vqGisgtplRf5krs6+EW2d2Q8a4wQp9XGLcMqoiY5fN+itOHO?=
 =?us-ascii?Q?HtKACYBBkQEE6DVD5PohzOS4Hk8ku2eWkk+MP4dF2On6HKU16wGcOOoclu0G?=
 =?us-ascii?Q?ju7WdusO4W8gbxuQxEBSxLZAgl0b6ijfwavG/i2SjOw9bn+xbzi3Wk0bKQSy?=
 =?us-ascii?Q?kJohVCcIPUPZEIZ/IHQm5R9yQaZ1ItaJ29KjRZaVvmhmDswD5ZYwZLahGtqW?=
 =?us-ascii?Q?z+8Hz+Gcd6MteKDLkxIp99MPLsx6LEQ890Bue06o5IjPgFMFo5VaEXulCTGS?=
 =?us-ascii?Q?kRvXGo7abgseQuokfJ5rX09WRsnJNTKTlEUIYjjLfxzEftLUq2c5E41DKXdX?=
 =?us-ascii?Q?cgRbnEI/kx7kNumU5BePfmPyFOCrYCM5WFXQ2UlDieXI3VtjggnbP43fFrhi?=
 =?us-ascii?Q?LWMiA7LiA4TtUsMK2CU+P0RzTcqgY+2wlwusV89/GJ8E51MAdCeBcjFz8zQX?=
 =?us-ascii?Q?pG1o0XBTamurLuSQPfKR4aNOuHdU6ciNsx9wnLriUF7BgrroUgYGp40GqExk?=
 =?us-ascii?Q?ZuRxb97408vAeP5iEphA4CXyWfyfAYMmrJP3qzNdC68hEUhPe/oPI3l42z8E?=
 =?us-ascii?Q?KiUQA7RMuLu2d4HcMDwLIcian8rCt97YfwdUBa5dvUCLnM4K14Qjuj6jg3up?=
 =?us-ascii?Q?Yv3Qirqq9IfivbYAMtRvvD0FElfQLoiuutLl5h2L1f6+Kc7SzqXXr7VzziMq?=
 =?us-ascii?Q?PxQM36GW0/hCwbP+RXoZO7D9ki7gfGMnInce7bSxAPYQ8uSW7l+zSGW3qifP?=
 =?us-ascii?Q?8rhX0EdLAdvwJB420EwNLL0ASFqBzOSQzze1DqD3RQIay2LeLJOgD9rqTJ/T?=
 =?us-ascii?Q?4gCyZuNx4RSXIOk7ylky8+/ZZr1Lw0dMMQck/UbILp0KTtajoozU50SmJZ7m?=
 =?us-ascii?Q?+/z6Dy7xCm1dS6pO/6uVMcUUlI3hNoijJ1n2YYwqLqHZxMF6AgoXP9VEktED?=
 =?us-ascii?Q?V7CpeZcyZWczHb2ImSqkIwjtZdSTVpRa7+C/RAW/zEfY3kHeyeGY9dwuyS7r?=
 =?us-ascii?Q?XaSgUCpEtNsmHWoY+Zda9Dpj0b+3H7JUZ6LYfJWvUvYP8fcb+Apt5aoK+RsD?=
 =?us-ascii?Q?N8HN5ly1yM+auUCrHkDD8lIzwKpnA8QuCyL7denYmlrbmOqGOhEEUB9onXhT?=
 =?us-ascii?Q?KghnUi1tNZPs6HmmUJ3uAmYTxedkJZr9VE587iXCJ2yDqfcfU9gKQ4eNWUOg?=
 =?us-ascii?Q?edhD8UO1asCBacHfJtD/cZA7ORaJMu5z8Dk1r5gNWyJdeyr9caYBhqlxa5xT?=
 =?us-ascii?Q?gulxB523EInKlKhlqXf7NobkwNVV1BoOvAgjb/NnQMBXXSJLBSgEqzwbVv+2?=
 =?us-ascii?Q?U+JaOQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4770831b-d895-4670-697e-08db8e94bd70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:29:28.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSP8d4WM3gQF4BAmUTUPyAblYRETDlucHWtvFDS1aUU0jYvJu0xMqy8hertaeG4VMACAetM15A4oaHNYNFVYA1tcoRGV2C+8uvLf8yIev+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3687
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:31:41PM +0800, YueHaibing wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

