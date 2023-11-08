Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA57E610C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjKHXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjKHXdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:33:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A3725B5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC5kKozR5i+E4x9rTxQGqhQHVgjnfLxk4rKnaZ9zgK0qDLAsNZp55GtGDLfQhX83zg7UKEPFfydDkaZyNUzseO2N7tnpUCtzaN4sJrCEDEGjz4NaoKyvBMaBOJkqoEe0+YiJZL4veZd4Ll/2f0lu0+3WOPa5f2Zk44PCPbUQhAjCK63soZukMfstoSmuy6kgKPs3Sbycsdqz2NKUmK+zrhI75WlL3AP3SLiI02QEJdsLz9vKc93OSQxsORJTlcW5t9LYdl+jkVAKVgDd6ADcC0aAxyR4CoAXC61jDzgVYtRHImn3856807c8QbPNbBC7qoe9xYK2mALyx3gR5nz5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvgfKzgbnHa6en03kImK/HJq3yuZSnBFHOwnVByaZvs=;
 b=IluYXh8qk3k/y6QVZOnnUQRfn5VnJAIIjjNLfD3NcmXRA9mQ1fsp6Cl0lbUyhZkxgj3naD+5QFRUAKsca0sSmuMGdFfPAK+MsD4jP88jR1nE3MWbn9n4vXd1mE6+fu9/DeOrY/gKk5LAxGI+AkwvmIpI8Qqkr41aLb1HrhBSc87+pC9z/7DF3JZcyaYvTnDV9f4baFWQA2O4H02zt3dEQH/kCaBMZJ8TLwnbtYhyGOhp5FP/eR01CDxgyo0AHhFjJ1aP9JDrWx91MOaVSdzCaCsIvdkKIUP7AciY9wYWU1lm+fyFkomnYE5Gja0hjk8E9P1u2iMtMR/Lcs1lIIeKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvgfKzgbnHa6en03kImK/HJq3yuZSnBFHOwnVByaZvs=;
 b=ILDlR47fum2HY0+64F6vS5cjaywVNboVHgW2KL4hZNghus+Z3TI+r1tv3AzkJlJ7XzrjRSYyZb2g8T0nW2oOv3BzlDSh5/RuQ+iCh89Z7oShpzJC3Z2AmXHG7x4H5oOqCpBAkHKE9wvwdORnO7E/1B9ERd+MN3SVhX/z8f9WgtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB5628.namprd17.prod.outlook.com (2603:10b6:303:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 23:33:17 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.019; Wed, 8 Nov 2023
 23:33:16 +0000
Date:   Wed, 8 Nov 2023 18:33:13 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        naoya.horiguchi@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Message-ID: <ZUwauTb/MqvyUEfI@memverge.com>
References: <20231030180005.2046-1-gregory.price@memverge.com>
 <ZUA6qq6zXuc0fqOE@casper.infradead.org>
 <ZUA/IzTMokFsXS5Y@memverge.com>
 <ZUDFSEvpxxoGWmdG@casper.infradead.org>
 <ZUCD1dsbrFjdZgVv@memverge.com>
 <bc332eb1-fe00-416d-b915-b2957d7b25b9@huawei.com>
 <ZUpZCsR1rmIau8wv@memverge.com>
 <cc4ac7de-97f5-4131-804d-622fb158dba9@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4ac7de-97f5-4131-804d-622fb158dba9@huawei.com>
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 471061f8-1a95-4b3a-bcc5-08dbe0b3152e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sJTMkEl/HUf/44IZNB4enX+ZBsS4/59rE00g6QiQfvY2OFZTv4ih8Z9H2CX1h1FcFiZpBxAgLbQQJsIcEH8HSZ7kWb00HuYll1mCghopXHRkCVCirLQCf8rVSUyPN0sXhOTmV1PPkuzKpibTpDBMKXfhZmIzShnJpgw57nL1dr3LQbe1pWku6Clz6GugAIHxVAispC2kx2kdcpolH9YhdWuweiddwDZzMcnWgdtNPOF9npRoNGR8G1z1T/ACGbKxgxVXXEXM5AJQOOLdDAgSTesH3VWVzRknvxLya81MecYnEu6zmJiRZ1gupyRnrjVz2O55PpM4zLg/OQZQBl6IAwgS6OGhJJhKpyp199ueOTp93Trd22wavaXMTkW8I7+cLrC0qAftQ1cTvrVUDDA/O1GXj3zZabqgcJoxokgq2Eu1bxjbdkTzuiLnQCIg/e0KMx/dkuyTruqhFWv8fOV4RuMwnE9kSOsNSMmqzeThg1Xh/V+4q0bg8G7b0HMM01WxZeYcy9beRMV0nA9NLXUekQfmUEXAJlXz681w4u/i/OFfbkQbiARas8QoY9mEovt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(6486002)(6506007)(66476007)(66946007)(6916009)(6512007)(8676002)(66556008)(2616005)(41300700001)(316002)(2906002)(8936002)(4744005)(4326008)(5660300002)(54906003)(6666004)(44832011)(26005)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbATZL1m5d6SVChNboROfNC7d82E1iNJvXiGb3R8b9d4bbWlg+k9ZQtTLPVJ?=
 =?us-ascii?Q?O4vkWsj0w36fLXutS0XU/pLEk4ZjsM7pMldIp3Uz/2Gx2fzKcbvC/TNwaVhe?=
 =?us-ascii?Q?X5eEiACT/uqZ11IWRPyCoHlGI/FhSpUYCP4C+gwV9b8Fg1E+CSRsXd0XT61a?=
 =?us-ascii?Q?5uLigiKtd0QqQCLDc2xDewoN9OQmAGYV6QHkilDJp7vIgtcO4Rk3uOaFmr6c?=
 =?us-ascii?Q?JMJ2+ODYt7rcpH70Ce/QUKUpxHeAUOz+phYdWTjGcF+eOiJR/l2gN+Kksrue?=
 =?us-ascii?Q?TyDAW2Q42m4D7Da8Et4Gsqw7/TQWjkGMG8dlBiez4qvfKLWOn8KNik9Eg3P/?=
 =?us-ascii?Q?Uz90/47VhYpv3hI0OVxY2VPPj5ofo4dL+ywPYup8/yhltkPRuutKqH1E2nOF?=
 =?us-ascii?Q?dZ3E5OmDjPMuMcDNSC8Vx7jnR4owFs+UXZ9xkozb/CpKkln+XeTWNtiYtU5d?=
 =?us-ascii?Q?siODhr0OlHgDzmstXr43DWbosjvYdjWWst0CpmPrFH26xSht3l20kkb03mhk?=
 =?us-ascii?Q?ZKRbmqDDylgkILdjvZcUbChRoAIdA+B12ATjiz4F1ASi69K90ujF5xekCF9u?=
 =?us-ascii?Q?HhYVLni0XjqEYJAcKAkihVWeM2eUpnPxnBYNNNqufi0340KH0PSaeDuloP5n?=
 =?us-ascii?Q?Yl9PGJJUSfRL5aFl2dsEX0oraNeIqPM9s1wpBdg6TvaGpSeJ/3cmB6X6cJss?=
 =?us-ascii?Q?41jjxjIPUW6UMkMzFb0ZRiPxSUB/gZa3whzrsRpamhvDVpiey7ucqSFCt5bT?=
 =?us-ascii?Q?7uKcLzhIfZ/4N2M7VlRWyFZpUpO85q7ClfkSmHgaYTKCrrN9TOaXtqqpSAcj?=
 =?us-ascii?Q?/3q1aek8SQl+xp/nMBwV+mBEZN1PexexKdI1eqqYu5agbJsxdjoiDTHg6kQz?=
 =?us-ascii?Q?8SlZCOFYCZBMq5ixMVX0997MkDTtO55JZ0IrghkFb1+mAzFpESbcL18IFoum?=
 =?us-ascii?Q?j1P4jObTE/lYv+4YF2BaB7fTLhgu5mswS2/7/ns3FP7L3MBBX0rf5zhUXm7o?=
 =?us-ascii?Q?Daix5/PLzAvS7b8+OkNQUutS/djDfTWbFuNfz85kE7+ijnbn3fWuNwafIY78?=
 =?us-ascii?Q?65Kgfa6kzPV4OrOJ9jIc6MspROIw6fFxprwVV5DC9KVeYaij8FdfAgcqbSvi?=
 =?us-ascii?Q?XKKW2Xs8E4zpytDR2Lz6nTqQCkYXk/g9oI2UA7aC0Ur883PyF7GjTsRov3x1?=
 =?us-ascii?Q?yuVCXfX/6Jp79G7xiaRWJLAwWHbXCRo9aiOsG+0NONtTVUeApe5lMnkd7vle?=
 =?us-ascii?Q?M5TxstcA0crCbmbHzGKABq0Z3t34WoLdNoV7tCi4EO/hEDqiad6RYyI8YU1P?=
 =?us-ascii?Q?HLtB780ci7r8uRJ1KWDLBaCC6ck6JkeVmjhSP8HLDr75D1gb6MrAtPIBHdHi?=
 =?us-ascii?Q?jnFY5t0XKOFTE3JPcbNb7OwijDIjIZPtLyuQ4Uys0UfVPDKrjOh0TzYM4/KS?=
 =?us-ascii?Q?ujmx4o8Rajnw5Z4NpzOMoVwQFJT6L6aONiO5WhLi8ym1WC0PkA/d2Wn/OaA+?=
 =?us-ascii?Q?vmYYE7piWuMybqsFs5mABJtqR7vko1RjtSiAvMECMfstpd7nH3hULjgKuDhF?=
 =?us-ascii?Q?yYJ3ttV5IgURi7ZSFX+wOTXQD69E98F3o5oyz3Ik1k4IuwTrLuSweU3QKL6B?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471061f8-1a95-4b3a-bcc5-08dbe0b3152e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 23:33:16.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XMRdec0fKdXmCv6rvP6JDHV1HOlsekoyVAWiQfO4eRVpF66e2VZkiFpekeh5MtZFV7Jyvq7sx2wRep4DoiKf1o4HyPPEhrrIkelI+kAab8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 10:01:19AM +0800, Kefeng Wang wrote:
> 
> Yes, I see your "Node Weights and Weighted Interleave", this is an
> interesting topic, we need some easy and efficient way to use tiered
> memory.
> 

There will be an LPC talk on it next week in the CXL track, presented
by another group that's been testing it.  Please tune in!

> > 
> > There's only a handful, so yeah the best way is probably to go ahead and
> > swap k = page->flags for k = *folio_flags(folio, 0) and then handle the
> > couple of outliars.
> 
> If you don't mind, I maybe try to convert it in my changes.
> 

Please feel free! I am happy to help test, CC me on subsequent patches
please!

~Gregory
