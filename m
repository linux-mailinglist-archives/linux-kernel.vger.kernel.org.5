Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4A751BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjGMIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjGMInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:43:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2116.outbound.protection.outlook.com [40.107.223.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD9A1BFA;
        Thu, 13 Jul 2023 01:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoHElnw/XPtBntF0sgopjwJUws28dcx5ZQSlu9qvZgB2jD468kwNIZpMOBVgfwdygpMg/SHxqIsXPkwSfXff5Bfrb5pyd663wxznc6pOEPNrjadbrYDQdo1IYtcwAeYqNjhvEf1NRsT11DSp4axR3guKrPp+RIbkumbnOkpC9umUqJ0RyjuID89bupf3+DSKmvkG19EgLP9IBRRfl35QwNtyWYkuEoTxgzryzzRlbE6/91xFixQbs7WjftT1//UX5cmbT3sIOfAX3AWfo5XzokpPRrXsuvnTf5UnnMu2zmK5aYnpGNJmoPYS/l88vjFqEqwtXZc+kW214LnBOqkltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhcFODDryTkPO6RCHGtSt1n7Ym8gCHEKh+gTW5lBHR8=;
 b=FL3dcd4ZzJFrE/NOvZWYxVjC9v3YFfw/RaXTyOCNQzbHjlsXUnhxMpkvzxMpl8/J88caJcH7ovu8rbjTwYMHXNesTFtNhvSRBpb0K7IQk40eSpE5dnwAG0rEI2L5Qu2pj3+nhlkAPiKW3ra54kL4yKQDe7qpaMM908sMlPb2o+MrPxEiicqojPl57pAs2+gsTu30DeTvYkZ54CuoBrubKQCEHSiIA8Jd2ilCwYwkcahpl+UtURrGNPI1Y5s8LpzorAJBgG8nT9w387sDG36CgfAQY4U1E8IeN+HCVlHq8tCsG3Bq42KxiJEjBf1gldn3IuKgneg+u9VVWXsSnI04ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhcFODDryTkPO6RCHGtSt1n7Ym8gCHEKh+gTW5lBHR8=;
 b=kpxkciZKohh94ClJ1OLa1+DU6IDlPk2PTQPFusMLvhTbEB0B9zUFHFRTzzpVd3C+MaZb0d9ignJQ8xA+jzdlunCn6JKIv8aZK4nr1eoBRZtZEixkJ0MLsqYzWlCYLa4aaykMh/0UECRsOUN5/OkyxcDUptUo9AjMvAORbr3YJ7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4903.namprd13.prod.outlook.com (2603:10b6:303:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:41:36 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:41:36 +0000
Date:   Thu, 13 Jul 2023 09:41:29 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     yunchuan <yunchuan@nfschina.com>
Cc:     mostrows@earthlink.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xeb@mail.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/10] net: ppp: Remove unnecessary (void*)
 conversions
Message-ID: <ZK+4udwfawcJq5qC@corigine.com>
References: <ZK2Wf4man0H4e9Zz@corigine.com>
 <284c0843-b749-00c8-95bc-6a0b220d9421@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284c0843-b749-00c8-95bc-6a0b220d9421@nfschina.com>
X-ClientProxiedBy: LO4P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d898344-7590-4eba-5d63-08db837cf7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTIoVzt5evTIehh6jq7X5L+ndHKOU7uKb+2AWvIEtM354Cz90qI334Cm0mPIyGVYOdzqog38iU7HE3v+rmgOeUtvtsVTzz0+aF8kv0cqJrDx/P5Ob0RXO5O1uKtMmwQsVXUmKK30dSXkZf2pXXG536qhRxjj898lvJSEtGJMbH9t/ZEczQljS3rpo5eraB//adJHpRpERQt6p5f6r93XJvKWjyLZU2aLrj5pyKLbIAfCoxiYQHnwyh8haeg6WqcROxq2lTYbamLFDgJnES0zj+yirMmRDQUrAYqMsgjTfbJhStLs64o0hmO69tzLDpIGt54StypVxSmS2C6HQyKT4fBNz2GyIsd5mOce7GibeQtjbU2gBaUXMSBnJc+x5GNVKjCWPZkdRVQ0kZA19apyH5eKn8Ij7djjoIboHQerbzVyiJDZlZq7olbQ2Ia172dSPCk7hgZNZCxGqZY2tr09wedjRKmcKxPtA8+YTxT+qUCgRW27mHrVhCNaeRwtucEQpVqN8hQy92ruUfR3xd7z0Am1mG4WaHWT43BDBbiK8+TsZiQnLiCMaqDSLIHCb7X8PXj6YL1QJZTz+uEJFz7CTlX/AUuRX8+h3YOC9J6gR10tDnhtUS9/20MsViyF26Ab/KMIPXpg1H+SuoooJKNpyR2d+nJ9ZiO8AjWuZ+HDVno=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39840400004)(366004)(451199021)(38100700002)(478600001)(6916009)(4326008)(86362001)(6666004)(6486002)(66476007)(66556008)(66946007)(6512007)(316002)(83380400001)(66899021)(41300700001)(53546011)(2906002)(36756003)(2616005)(8676002)(8936002)(26005)(6506007)(5660300002)(44832011)(7416002)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWRDjfrQl7VWvqauNPwwZ4n/+s9ZZ57/wBQofTR8Xu4hv+37dzKZBYBRaRxp?=
 =?us-ascii?Q?QlLp45nCiKI0bneCL6BsjoWBZqrdgpq//3icgP65g7f9xm8RZEyZy2uGJzA6?=
 =?us-ascii?Q?sgGMH/sdc1bcXDQc5+co72Xxv32OLMtOMqPhP8BfFmKKnjvo1o+FJA5wVZUz?=
 =?us-ascii?Q?8URf9wJs7UxNq10A4e8zqt3OKIZadPvGy7WitoubVmy53ITXr48CeAXfSlee?=
 =?us-ascii?Q?xsL3KrR/yVHvURDNM6iOJdV+rA48SIJ+QOFLD+KUPlsAOo96NxJx+2bx4czq?=
 =?us-ascii?Q?PBCtOLORKJ9X6SYa/VAGEG5sL45jMWRfKWVux7ZkX+3kpjA2fzW7r+j/Wv8l?=
 =?us-ascii?Q?vRu4YrdUCT8xvzF+HRMShzF2ZsSVR3lCvBUJYuB5WP5Ysp07RMh+SI8j2sDW?=
 =?us-ascii?Q?ElgsUS1bfR6pZyfJ875VmJb0b0nH25W0oYcomCszT5A+OBAs0laQ5nE3/4ie?=
 =?us-ascii?Q?jn448QAbsgN5hzfuEsZt/2s19MHTW+u4v8fwnNGEGVlFqLd1NVuu/gDWhfnb?=
 =?us-ascii?Q?+7zUweB3hcsum9ibEAyMRhD8rtjv5NlJ+o13aHQgIQ7Y4R/QTx60ETXEDRMA?=
 =?us-ascii?Q?430i1mj8lJA+OaWVKVtba4cATXH/6xDCTArwqkk5LN3qFHbuyhVUChr5X3cm?=
 =?us-ascii?Q?sS9/qXi+NetcUVaJwxkyWqMXeKVaObk9VsSWb9Xq6TfQRoWmVpCV135SJ/C+?=
 =?us-ascii?Q?IYKfyp/A8cuG6e4SxIpZ/kGVMFK9bLfPYH2EEoJjIKNMV3Fj/MbkmPeEFQDr?=
 =?us-ascii?Q?XauCws4mbe9u/t48pahMgP22I+KBBYzjWzAefJlDwcXA+wTd4GLFk9+IIbju?=
 =?us-ascii?Q?DKIKpN0Vbt9poxrXddl5LjmqxTmAPnAH5CqsQd5qenTU7nShMEm7wT/XCBm6?=
 =?us-ascii?Q?zK/NmumbMjuz///fUT66YEvniLf1Bri0T722CAD+gsytFf2h1b6bLSel/X9A?=
 =?us-ascii?Q?Kpt4cKuX0Qp355T878dapfbN5pyUoR3Yts+aK2CEppjS2qBhd5gW4igzG/Lx?=
 =?us-ascii?Q?+HHuqYezvvoSpaBDkPtzGBlwmvtP3ghgLUDzn31xYMu6m8IVl9npOSfDZAXX?=
 =?us-ascii?Q?yOaH+crPk3juYCheylHwIJiqa7VmPEMu8wd2Z/hMRDl55v8bOZzrq5jI1ZOi?=
 =?us-ascii?Q?MinDXMHhwyDrc95++ozlXuPDZEeeAmSyUU4UsyCbAbCiN9SVlkXIBQgat3oc?=
 =?us-ascii?Q?6CWFncvze/D2AFxJq1hLLrmnvwESQKWO+3o+FrJbPKFEIlpyQtBQuZK19wnJ?=
 =?us-ascii?Q?HOBFFT40TjmI3u5+XdD9GOAil3BldCk1mcN/4DnBODkJHMgJHhCylkP6h/mt?=
 =?us-ascii?Q?xQjkZpOfL4fU/5vpLI2kZC89HhVbdzH7wq1AbnwIysg5zdl1QEISdqkHSV8p?=
 =?us-ascii?Q?AMZNCXcLhTPdp6QRVN7mDz8n2xiVfuupaL5R6u3/HgVs3ZX/mnENV2jxKCoD?=
 =?us-ascii?Q?yaSMO3z6Yytfm44SsPpBi9PuCDuPZ2t37/zcEeQ3eXWZt1yXQHLR+Zzh74aG?=
 =?us-ascii?Q?ZoaaC6Ip9/KRMC+iKrXSG53AU4jeqle2NwSoiahEBJkQZkCiyaTIGfY0PWjN?=
 =?us-ascii?Q?RghWX9yFRu/vZaNuyKM8THRP9I4UmocRUFDn3iRCVSovq21I2HMyBfsWgRAs?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d898344-7590-4eba-5d63-08db837cf7df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:41:36.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkUtT/gzSZqeOvzjFOPQEnxCzpdyyX2BSYjjOn+yJIhPHbhENZ7AXN1l+RlHyFC8gTc6Zxi15wP4VHAJEj7u0lNWuqKQQqkoKaHdJRS4z/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4903
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:44:40AM +0800, yunchuan wrote:
> On 2023/7/12 01:50, Simon Horman wrote:
> > > -	struct sock *sk = (struct sock *)chan->private;
> > > +	struct sock *sk = chan->private;
> > >   	struct pppox_sock *po = pppox_sk(sk);
> > >   	struct net_device *dev = po->pppoe_dev;
> > Hi,
> > 
> > Please don't break reverse xmas tree ordering - longest line to shortest -
> > of local variable declarations in Networking code.
> 
> Hi,
> 
> This can't be reversed because it depends on the first declaration.
> Should I change it like this?
> 
> -	struct sock *sk = (struct sock *)chan->private;
> - 	struct pppox_sock *po = pppox_sk(sk);
> +	struct pppox_sock *po = pppox_sk(chan->private);
>  	struct net_device *dev = po->pppoe_dev;
> +	struct sock *sk = chan->private;
> 
> But this seems to be bad. As the advice of Andrew[1] and Dan[2]:
> 
> "
> 
> When dealing with existing broken reverse Christmas tree, please don't
> make it worse with a change. But actually fixing it should be in a
> different patch.
> 
> We want patches to be obviously correct. By removing the cast and
> moving variables around, it is less obvious it is correct, than having
> two patches.
> 
> "

Thanks, I agree this is a good approach.
