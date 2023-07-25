Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7414876160A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjGYLfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjGYLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:35:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2090.outbound.protection.outlook.com [40.107.223.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA565199C;
        Tue, 25 Jul 2023 04:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/UiiorLh6atgTX5l+MIk5bi9m8i5D3RsrwFZ9FMUTJsIc7jneQD4QbrFMFOhs01AQES80Ft+y1RcTvNC9EOI5BW8iQrdnrhVbuUIefS1kspGZYn4cJ34UOf+ipiEZJYR7VyzUWlTFwM/KCg8sYyeyp74i2j8LoVlG3q+U1JVT3rNGgtN6kpCSb3oRLoJEn3UDpqCrAJPbf81/u23D+6nUVt68y3A5h97KRpm27c8DE3mORw6kllXNGF5uxmY4zkoJ1LBiUCVK00v7MGQPSpwAnpytXgqiFOwe1klTB+nxiIartev01fXANjqWhk8gs0c/eeG7O3rgKhVJ/My/vziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWL/uO6Yx1/4HsHO3Yolk2P+/1SIwN9IvZmQK3+X3Do=;
 b=F3nGHwJe92+vcaeh90d4eqPg/QnpCqcB5MLWGZhR2O5TpKZL2SJTTDQ2aWYdHYhQmMuIt0RN0eMjE+wGHqoDmZSWs/0fz5CzleBYl1LHxCAwH2Q4PKK0hlNp+zHmQCC5XWuepY6fovDE40x2mbFedeLRkXZUonS0WuHOTbTW1/7CdqYMFuE8RHMZvPnutcZPayMSUtdKbFPhzTFs1FPHFbMTvc6mDF1EQGo/cHTaCxfL079wa/aOqL/B6DGLx4+0vy2DUlvw/i4YfB9WnCLyssjHUWyq+a3VRRqVTEKzJH7iFyI2DitYg8ZfAxK7K53JMOEIkMz6sJAIGSkMzHS4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWL/uO6Yx1/4HsHO3Yolk2P+/1SIwN9IvZmQK3+X3Do=;
 b=LRKZ49UKrSxYmDTLuui8Q+OM21W0xFkGsjuSHmXMPDAcdQwGx9h+nexVNefM5zKumAASuHAGK1b62hYqFqaiwaG2yl5TjmelCln7hHv7V6GeTNpzEltUhuyByhRlZ/5VWEoTFDtWcLHvX1rxKOUA+6nU1X73rQUKAYe6B85/sJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH8PR13MB6184.namprd13.prod.outlook.com (2603:10b6:510:25b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 25 Jul
 2023 11:35:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:35:20 +0000
Date:   Tue, 25 Jul 2023 13:35:14 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Message-ID: <ZL+zcukc8fscMrYG@corigine.com>
References: <20230723074110.3705047-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723074110.3705047-1-linma@zju.edu.cn>
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH8PR13MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: febe403b-101b-43d4-acb8-08db8d0339ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iM4Gd0r93aSLF9D7GFrSwM/8jOrOqLV/zl60QLwuFl9DR/ljWP3Ptw1AtvlQv8vxM1zHIU9lWliXCJI+rNUCmkpsG3saT9veKOBGPlH4cYWgJnjt3H29lTHPtIgeaaNC754Ytx8bXiYdDdG9teGtTYzUyXFRPdjWnl7JowbS49B6N68gErkgBRb1A53UzjfMLIRaululyvss9+CIC4Edw0ArIYSkgEO1yiARzXSBd5HMUYF3I+MMmTAjuEuDRKIUzOlS4KshL0X/QQwLwwCbBk5HB3vXgePej2/romYHdEZJUSwSCv/9ghLiJswKESAt6AfepjxsQUk+CX0vrYI75aZ94/GysO0o6lusGQaXTMsZmxjq6h4BMzUkGFAQgQ4JtTFHc4EaH87011vWKUY/vICr2JKWcUJh7lrTj2L5srsD8TeqtkxrJyIDcZ36uzE45rnm5R0VdukyzdqETbTxaGErS9RDCaY3NntBj6sn4g/wunYnKsesYH6KjP0vVUsd++ENgfcw647hdbWa791nb66e2cxJ4FYqGUCCS/Wccp2sHRumPGaNHS/9R8SdSrVdAhyr7Y6gukj2/IlDPOvOae7uEzx42kFvofOiWtgNmU5D772nBZbCGLRuZGOjaggIXj4Wg1yGrkALP5QJKBwnct5nBzr6rWld6KNohQbArtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(366004)(396003)(376002)(136003)(451199021)(478600001)(186003)(2616005)(83380400001)(6666004)(6506007)(6512007)(4326008)(2906002)(86362001)(41300700001)(5660300002)(6486002)(66556008)(6916009)(66946007)(8936002)(66476007)(36756003)(38100700002)(44832011)(316002)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvc1M2m5Wax0Rmp4KtZJYGt8ahmA3yKLNvPe38J1pBSfvz9oa5tt2Fjrox/O?=
 =?us-ascii?Q?qOLUy5+AJCL+fAy3GGkhfe/g9ozPLSw9Qe0sg/JEZoWjPzrqcEBgjW+4gvgL?=
 =?us-ascii?Q?RZfpcprH4MnZicsY77lDjS81U1o9Fj15mx5j2Xybd1t2i60wVYwyiKSWPv10?=
 =?us-ascii?Q?XGMLVZajmmDJM7MjEb/hU/bVlUkZEXf7JdAX3NYAdDkjiUEsrF8xd92Wgrcy?=
 =?us-ascii?Q?aBMM6BzZBLTIyinPTQLbM7qaPjEwqqrXCNhtb3MPlstx0wKKhE4ymh+ppjG6?=
 =?us-ascii?Q?8XTLGK9kEcqB5KFz4wHJR0vezIMHR+fEyPB9Vtnk81aTsQAaquUU6EcyEjIt?=
 =?us-ascii?Q?SPMhOlx6niBjYct8ueu7CVKX0jn5onZ6sbJmbXxIXvKTumexruUEmEgljKt6?=
 =?us-ascii?Q?hulSZR5aPgnOoB7WkhVuYPvsbfvMu8h5c1l3eO74+Y7Lyu8BuemvIHMpLSJ1?=
 =?us-ascii?Q?PPEaPt+oRXzhzIPFdCaeJYViuoOJzCMSxAUbih5idem+lcNBtmkbIgvVehI+?=
 =?us-ascii?Q?VAernDrPtKlNwetj1j4i5xHvLfpbbosACEBssi9NEmbXIrGohTXqDoA6XAGj?=
 =?us-ascii?Q?FKgRuhjw16xk1vflDSbKnUnWi6r+TALn2m5qzkN2EpyF659gXghVCrOcMAu7?=
 =?us-ascii?Q?pInVyp7ffp2Z+zCbzIc2rNi0mXhsR597A3i2r7pYpNgQ+nC0V5lEEumHEVnn?=
 =?us-ascii?Q?eUj1cygkasFaKCw/75yU1tNRNzr1+A5/Secnq3qcyvHQWjhcUlr/cthhXXoQ?=
 =?us-ascii?Q?FEnnjafxGJHVe1HdUja8cnb9lTk1Y3tjsDZjJeQZDkGUSM/Zg0Z/97/EFbt1?=
 =?us-ascii?Q?fxnalcVzZvdEk6LGvoJpHhO/d++ju02VBS1fwUzABJ/nOeZ+Y72veDmRCp2i?=
 =?us-ascii?Q?LMOjlOC9ESmHkvkrxIJQNDhHwlKW9Hsk6nMPKnuhuD0R991/K7QjCkBmo7t2?=
 =?us-ascii?Q?na0qCeIxwFYHgF3Ue71uoCF4Uk17Mzi6C1dg8INGC2yeXj6GusFEz4j3R0iW?=
 =?us-ascii?Q?+ig1s/7eA9umYTTHr8lyyRk+2jmlDVGXy1Bz0cPCxhY0ukV3uYA0AULDLiSe?=
 =?us-ascii?Q?6J6G4638BgVYEqekk3vqH8mpjoykz7FRV+HjlJ49nWJ5hiU90voL05FetJ+D?=
 =?us-ascii?Q?WoShiKO3Lqspdt/r4Bo3U8cghtkYmLqiZYghFMm7UYWq/UwIMWtyJ5hG/KUU?=
 =?us-ascii?Q?PK9FgK9zFx2Z8Kwr+WaPuJSs39hvQr6ALHo58iwvLkhmvTBw0s1mVqrqnLnE?=
 =?us-ascii?Q?OSP6LDmRJ+hafPtbyg+1UT8+GStlp9Do94gLpetQZVkrh361YMIrHVoUZvGj?=
 =?us-ascii?Q?qOCAe2S/4mxZR9fb6vseiwrMs72qUvLDoyUnz2A1QILEPFzDq6M2UABQ/sB8?=
 =?us-ascii?Q?DgGd8gUFJ5i76DH8kR2PlW2C8S1CBrhW/qVc9msfs4Fypw/lQpAauFZS4zdM?=
 =?us-ascii?Q?QEihvIAbAhq8jGt/jIxP1pCJ3HxjcpoIiLz5fkuPGjKBiG2iGb7LSF1tqTFl?=
 =?us-ascii?Q?63IDIyrJd7D8P5djnllojvbV7o2RtJM3wWM2z6Kc1UytF6zD/jvygKv2kHst?=
 =?us-ascii?Q?KhUVXvMvo5dNITgnlQe+M2rW2zjZ2OWbjAWDZ7bhWOg/PTn46uTpd/vwQdcv?=
 =?us-ascii?Q?KdvPecFI2qBYtKJaSfU/aZ/lQeJFh2DpsVJfaZpnUrrchVHnnAytCJtCDVr5?=
 =?us-ascii?Q?vVWbsw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febe403b-101b-43d4-acb8-08db8d0339ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 11:35:19.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHXwYal1bPWVVHO43VwkkJfQz7r4/5rCnxY8/DerYLMjX0vxj6OsCB892pRK4GaNuoVWLSOITd9Rdpmdt8/dh0kWnZMPXuwfqDLfzAVAZnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6184
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 03:41:10PM +0800, Lin Ma wrote:
> The previous commit 4e484b3e969b ("xfrm: rate limit SA mapping change
> message to user space") added one additional attribute named
> XFRMA_MTIMER_THRESH and described its type at compat_policy
> (net/xfrm/xfrm_compat.c).
> 
> However, the author forgot to also describe the nla_policy at
> xfrma_policy (net/xfrm/xfrm_user.c). Hence, this suppose NLA_U32 (4
> bytes) value can be faked as empty (0 bytes) by a malicious user, which
> leads to 4 bytes overflow read and heap information leak when parsing
> nlattrs.
> 
> To exploit this, one malicious user can spray the SLUB objects and then
> leverage this 4 bytes OOB read to leak the heap data into
> x->mapping_maxage (see xfrm_update_ae_params(...)), and leak it to
> userspace via copy_to_user_state_extra(...).
> 
> The above bug is assigned CVE-2023-3773. To fix it, this commit just 
> completes the nla_policy description for XFRMA_MTIMER_THRESH, which 
> enforces the length check and avoids such OOB read.
> 
> Fixes: 4e484b3e969b ("xfrm: rate limit SA mapping change message to user space")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

