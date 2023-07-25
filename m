Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0C761694
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjGYLkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjGYLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:40:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EFA1FF0;
        Tue, 25 Jul 2023 04:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwzxsrL5piW2pwbiFX38kd0DMdO2LJKeqjGiQcq1uswnofJBZrV6cCSk/3aLM95EOjxHd6IDEcFJwJWi1H3yuAOjCnziC9rV04OBtUgjhU/TqBWSOkhROvf4ojjW1894K9qFnM9e2rqwIg3gPQNdua8jea/8mi5PsfuFtDKEkmxS0c4KK7t/Yd8qGMhjJl9wnT3Ajlqet1BFaMafdw90bpEQ9Su+NyjjX/CEYMx2Cm3B8e/qX4x+P5WKcd4qPVeWtMfXhsgAvimGFpbN2Qg9DH/KbsfKWZbiWPGC5/cHd2zSNGbmubA+VZiXszkZGgKNkwUsY8kDyR++nlK11qTDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHiiqgDWV2JYaiP1ccIi3+BZXnv7+roB6jd/06tkbtk=;
 b=FHsizqzvCdJfBwfDZ5ZFg2lbxx961O22qMgFW6G7y2lNScZwY8oga3lvolRgVstwRl6t4yzuOHlFOKoW7wseLvfD01fgNo+KzEhzKSfmlBN1fuZPkxvH2VdkKkhKrfrw8EpIONn+VRNKAzcpK08scShyRxmvXzfU+eAd373q6ifAPeXILSiEy4Vt6SehCje/72FdMEcrh2eV0FbycJlUgxal9qOzsT06OAZSEfCXwKChrOKs/QcRMAZ8V3CmbJHZqvG7uQJosAo3gvvfSFussU3wO+Uqc99PQ0A+WJl/SpL9qXf2XeNegu28M9aQFAwqT1VqqpnR5jhQtur71f+2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHiiqgDWV2JYaiP1ccIi3+BZXnv7+roB6jd/06tkbtk=;
 b=jIr2N/eTtJbfUH0FHZARw2Bd+P3JPTACX4TztpRq4Vayk36e/smh39uX/OrGxB7RIUS4E1DjHm2GnZVxM6FiX2eW4EXBydCK1HgvP+lGEKivdH77slsD9hT/KfLpC0gKMswwBLFBP4GZYe9qYSzdMeM2wolLISlAHqXNB31rWAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5628.namprd13.prod.outlook.com (2603:10b6:303:183::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 11:40:15 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:40:15 +0000
Date:   Tue, 25 Jul 2023 13:40:09 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1] macvlan: add forgotten nla_policy for
 IFLA_MACVLAN_BC_CUTOFF
Message-ID: <ZL+0mUhvnvDyyK9o@corigine.com>
References: <20230723080205.3715164-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723080205.3715164-1-linma@zju.edu.cn>
X-ClientProxiedBy: AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c727e2-77e6-42dc-6a26-08db8d03e9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBj6m9MLLzO/ZCV/eUVyK1owAF4n7A47hjnIT9ofgzziuOJIC8Jg42BMyL/55uKh8LNB9rbm72eEf9acTH9AEMF54J6JvoQ/UZq+RIPnv/svCbsiGudPNiTiqKbJ87Ud8v0fD04NpwkV4nXYZG08/sF/CFvc5exGwED2hc0588B9XFBfUPcMdFGCTJiMIIzT5+tMvVrFqdjJdh6lLwFmu08SBqTqz3Jpzuhqgb5d4MuEAmlXB7223pXKxbzO9Kj0aG3OpK8Dm/zb7K5YVNJpnbb5Bc6ZcwdkgL2Zq9ySB2p64iFBRqygqcbAjJmDI0K+YwxQE4cFqLjKdKE8rfPNayCzyD/7oXcRZ0IlnWW3h5KOyQYapF1zpBKGYeLPOgjvnePNN8jECqeurcITHQNx2gX8N6mJEWAtceDIkGryxLzcfO+CFEQXKyTuK8/ggkY7LJEhtIVbHSjG92Uq17T1FsnAFYdT9K2j9rZQQlmmSQhuTWnfBMoTT5HEKpiDVWzeE33F3/V7IVr6v42m9LgPbQdDO0TNpbKzTr0Nb+eHwGoNrtCuHVHCJE/gUxsXB4eLMu73lvekUdE+a5QFWo7vcVQrQWbsIUEqWUDX6RKpN+5Id2yfCmhUpfgWnuGUF190zXk/7nbnlKku+8HP0Vmt71kOW8NKWSHw0rYHBwKgMWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39840400004)(376002)(451199021)(6486002)(478600001)(6512007)(6666004)(86362001)(44832011)(2906002)(186003)(2616005)(36756003)(6506007)(66556008)(38100700002)(66476007)(66946007)(6916009)(4326008)(5660300002)(41300700001)(8936002)(8676002)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dpVFnsra9jgGg5bn27B6E/hPIR1xMmQc+ocb88IjUxE9WhKFx4Xbf60kCA7G?=
 =?us-ascii?Q?3TPUQ0kD7a6AxewajhRexYDmRuoucZnOnyjX+ioRlsTHUKsswRqhLh1ZJyuc?=
 =?us-ascii?Q?nfwdjnx16ntmsjCtdJnwDP4RP2TtDBWEiw2Ehnf+d+LAY2z11/T1y+8bZCs2?=
 =?us-ascii?Q?ro7MOBs2jCOzy0TMlxySsMoBel7dhgGpokPIakL1YP3nmkeI154HeEKePHbd?=
 =?us-ascii?Q?pM/7kQFb+VyxuX0Ho55IPQWIbru3sut8eat+YkWgXv244+Q0xpcboo5K4szX?=
 =?us-ascii?Q?/s5zP8vQ0RaTfgl0Yan/5px1RnYAfbTmpJP47viMzFVlZORwIDyO7u4xjgGf?=
 =?us-ascii?Q?5X3zw+6sV7SnQPHiFku4eJOMTCPc5iIdmh1uahfHPBrCjdXJVvS/mH1LsXs3?=
 =?us-ascii?Q?UZcrfvQYaAKdlz4JSjeyiBNgSGTpacHgXE8kfyuMQzDUZ4mZgEgso86wFsuv?=
 =?us-ascii?Q?OwQ6qCT1qB+kedwCufPWYAwk7af6PgGgFbhLj0typVoxviZp+QzicZ7ruuMr?=
 =?us-ascii?Q?WIfDWRFxYET9iiV5Fr5fhltnz9A2DcNgEuIDk+ZfHNQUa+lWh5KsJ/l5YHrF?=
 =?us-ascii?Q?l9v3RPuGnDfgFQ/pmZJbeQ/4KFM1RrG/qXzzAST6PtTb8IUtnLrMBes3Gt+W?=
 =?us-ascii?Q?T7ZePOZeygH+BCgZsOVRBJOJ5eaVwKqGpBAC9mJfMP2d/9Lr17vdRxi/gdr1?=
 =?us-ascii?Q?8lGwwudRufBRXPVvKWLlII8G9Aci9p921ngAMWwpHb5VpIsz1dtqIjkssSnq?=
 =?us-ascii?Q?aGXzCCtoIUjOW+MBzZPnK5EfrFDcyIrzoP/vgHaVF+u3y21Q2TJkhJPxH07r?=
 =?us-ascii?Q?Xyip15ZyjsWdf+azfKH8oUmO000S327Tihgb05f1Fnj9iQg3D9SIcoEfjPrq?=
 =?us-ascii?Q?Qh7kUybBBG5+5Eg9+ChutvJS18zykW4nVwtMUTLyf2b3S7L70F1BSPegjGBo?=
 =?us-ascii?Q?AbNZG+0Hmzo/4twTM4GQ+Bqrixd1Lz3HTFQGt5AZo9PNsuDvQp+iISwVMTYr?=
 =?us-ascii?Q?hiElaGZb4/2GBsvx5aNkUviKcLmGpDkyJ3SEKeQ+C7GYK4XcrIRfuz7Xul0o?=
 =?us-ascii?Q?r8Dson6VdlFmD9BrO46XV9VDTbodFljo8UlZRHdKxXo1Iia78TsV9IANH9Sd?=
 =?us-ascii?Q?7SIrQhW0U2zd+/jbP4/3aXW7kAC5tREQfbP6YOesgnnvgDS67S/D/mEmcHgm?=
 =?us-ascii?Q?pYujxNGOaRkNyyocUTU6FovQdS0KUCkrttXg5bCUwU0/ztFrjyBZsdTVsoAE?=
 =?us-ascii?Q?XkJxtgIbsJstObZr4mmocHXVw9q30jb2jbxIkaiklsdcVpMa5uxRwWAdxLvO?=
 =?us-ascii?Q?jBNdCeZ5YZNdMeO8+kEy+mqZ4Ivlt/k4i3i+rFh6B0wiIh6xaJpy0LpdT4Y2?=
 =?us-ascii?Q?Q1lzu6Q5EAIjDlzkmMlc0aJj9ZFJVeKB0/r5jxMjYCdFKQgyyut4Q4JkfLqR?=
 =?us-ascii?Q?6d+QGnOVESO6g7MTWbBgDxlgfNjfVgBVdbURpu3V7stNQuHytPoJRBm8i/5u?=
 =?us-ascii?Q?XYttT3wWQNnTizxclxrOlZn88Naba4sLSTtfOmJylbCtzRJ/fvhIWKz3Z6Wi?=
 =?us-ascii?Q?CrrnMc6vGMXE/eul+yAoGcrAyKot8bwdlNTvtUWQmxHo0ZH33IrbQq2wBOKM?=
 =?us-ascii?Q?qRuMPHkvSF6BDX/sRH45QKpW8XCb4Kki69Vc+xbsuDQqVXmK9xYMA6J3Jj7f?=
 =?us-ascii?Q?OXVdtw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c727e2-77e6-42dc-6a26-08db8d03e9e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 11:40:15.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0AmqUFeSjkXb/QBhL1vLNM6EC3GnUXynDoMhdS8CBgUiukfktzFWK7936MJar8qJVC3vI3RgMd2ZEpfwR2gkUZZz0+WTyf2YxWyNIf9YRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5628
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Herbert Xu

On Sun, Jul 23, 2023 at 04:02:05PM +0800, Lin Ma wrote:
> The previous commit 954d1fa1ac93 ("macvlan: Add netlink attribute for
> broadcast cutoff") added one additional attribute named
> IFLA_MACVLAN_BC_CUTOFF to allow broadcast cutfoff.
> 
> However, it forgot to describe the nla_policy at macvlan_policy
> (drivers/net/macvlan.c). Hence, this suppose NLA_S32 (4 bytes) integer
> can be faked as empty (0 bytes) by a malicious user, which could leads
> to OOB in heap just like CVE-2023-3773.
> 
> To fix it, this commit just completes the nla_policy description for
> IFLA_MACVLAN_BC_CUTOFF. This enforces the length check and avoids the
> potential OOB read.
> 
> Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

> ---
>  drivers/net/macvlan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 4a53debf9d7c..ed908165a8b4 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1746,6 +1746,7 @@ static const struct nla_policy macvlan_policy[IFLA_MACVLAN_MAX + 1] = {
>  	[IFLA_MACVLAN_MACADDR_COUNT] = { .type = NLA_U32 },
>  	[IFLA_MACVLAN_BC_QUEUE_LEN] = { .type = NLA_U32 },
>  	[IFLA_MACVLAN_BC_QUEUE_LEN_USED] = { .type = NLA_REJECT },
> +	[IFLA_MACVLAN_BC_CUTOFF] = { .type = NLA_S32 },
>  };
>  
>  int macvlan_link_register(struct rtnl_link_ops *ops)
> -- 
> 2.17.1
> 
> 
