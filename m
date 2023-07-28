Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42BB766ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjG1KgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjG1Kfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:35:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::70a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B863C06;
        Fri, 28 Jul 2023 03:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QygF2XtbF7B/Qb7OxQUK+6mO4ZENM9Z6xufCYChKmjle0yy8DrNXVz6dksL2z09zR3l9A+Z1OM6sLviPGdiY/sLta65kLM8DgilSO7LEeGAK4oqztrceXwPvpmxXTanZiOVbsXgxVjN5FWgXoaHFQDwpPDfIm9zhoG55jskBNCStSB3jTx5LDcoRqPIZ7YntY1837jF2JS+yM1fJ5Bsz1CXQlzr9qdWlyx+fksjEQOnCSy5mwWunwjPovk0WdEqE9SjL5dv4ssybcuKUuWJP1UOUqg9VEBT6l+NWkEBzYnJ0PAosMvd136c4y/jlE1MDobBJL2kLTDvoD9UA4dFHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXcGluViIPpRrioTylHhsvgGKF2Ehe6axA96lTV9yk4=;
 b=m26OpFkfPgZz+osQNHFooEZz+iVNyRtwrH/2Tr0rykTTwRcW2INv/iQ0AoaJwTCTjoOhPPiP9udTMxUSePXB0ezVeWNpJr/zsW9kXsZ2KwiuBwEBdrHga9WNsch6M6PrOAlR3OtdTVPAHdQfwxMJdLsM9oieRqYDKBlzcZZfAgwPvV7vMxTZmNTLqHYbjqEdsSnCH2B+Ow9GSvS5hUW2kt6c7PSvCEOTKIculuNgmhz2IAOuuQIw1mWa29IH8VzbwDuQ96mRGMF3NMZq3lK7mDPM1lkT9gHZEHE4hYdqwlbdLxUTp1e8JfH5iEEqlUJLRnhjYPz63RWQc70Wi5I5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXcGluViIPpRrioTylHhsvgGKF2Ehe6axA96lTV9yk4=;
 b=m0ijiTVRomzsDuxM1zZEkFvOYzUtAlxVYCRyQxTCDqxQ1s6gKJLLfrbSqcfoZu8vhsuMowtjlUqThLJkRjwIFjhzkgS6YUii7fD6jbNKcXKseafW/19TZkT1VIwTuYk70pYJgv9Of68/nDndOSyFxq+xNvHvaruWvJRFcXOvjG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3878.namprd13.prod.outlook.com (2603:10b6:610:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 10:32:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:32:49 +0000
Date:   Fri, 28 Jul 2023 12:32:41 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>, lee@kernel.org,
        linyunsheng@huawei.com, davem@davemloft.net, edumazet@google.com,
        richardcochran@gmail.com, p.zabel@pengutronix.de,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
        wsa+renesas@sang-engineering.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <ZMOZSeUaVIaZzZph@corigine.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
 <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
X-ClientProxiedBy: AS4P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3878:EE_
X-MS-Office365-Filtering-Correlation-Id: 70480a06-6ffd-4179-31c7-08db8f55fd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIxFgWA1bejLi0DGi0v2EluUg9ZryloKwR74kChQizDFSXlYcr95kcBLUcXqQupZ+3wQ5ckCvn44J172XYUyJAK/4g0kdkYV15ddCKyNv38V2I3TmUt0LchTCUQEo3Vu+24T+Lf5GxwcrXo0O5LP1rhyKRWK59aQnYmJa0wg7vLW8eA3xGn58Kt5lBdYKLVDKoOwCn6ivd47TZFCa3+Eh8dY/p/u4HEgyd96x7hlwMxRoErE7+uMFe/ayqfkNj+f6/ddvXpHk793iZHcsA1XBLrTXtJFakX10HdUsre0WAuildj4mVSZSHExjxkpss3lcoNenbUGnua55cOpMGUtcQmcR3O/E92gKW4DVV/ObJZ4VU27wgY3LKWI2xsacsLDtkNlV9pfnc32GGhlrXHltYjuxx6dx/FVfFc89jzyOmQ8QHI+pEJCtti/wUeI4jsEObUw93xRrADCISywqAKYBSJmuav/oWVjVlkHVlOKCBL/2cKhY31NCLZzkTkZiokjuImvosRDu+NtLlmlwK3fAZJxmZbCsr/pML8Pf3O4xclEcc8LWs30HjdoxT2cZxIxKGMOgRj8bn1hp6MhxJEmOzZpIO29ZC/F1uEE+tyRg1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39840400004)(366004)(376002)(346002)(451199021)(6666004)(6486002)(83380400001)(478600001)(6506007)(53546011)(6512007)(966005)(66556008)(66476007)(4326008)(54906003)(38100700002)(186003)(2616005)(66946007)(6916009)(7416002)(44832011)(316002)(86362001)(8936002)(8676002)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34g8gikSAchuxECgW1KsQeG1MWSctBh+rr9lXjikkQjUVNIPIshb1+izyMo/?=
 =?us-ascii?Q?ZETfTRThlpxaRrFeCpPPiNcTYgkUW/8OiBsQcjKpBn3vAgo0bOY1zewMFXrd?=
 =?us-ascii?Q?sVSYqkPAIU23PuCIMXCfuG+l6xwyy4rJDVoTL63NaISfZtspnPqJPrmWbnWD?=
 =?us-ascii?Q?vWGH72/wXuj95HcBB1SATH15eCA6GwTMt0BSIVs5zfcdI8KejRiZccqDxefd?=
 =?us-ascii?Q?/0OTC7Rh4tYzlF8ORuGktLU6cKo+/soetP7EQ4v1GprGOr++6RvJNlol3VoD?=
 =?us-ascii?Q?JXLgxSpwbVil+fyLiJU7PHWvC4ZlOUa3UVNCOqH1IFVQpcNlw6YkSYiGTeOW?=
 =?us-ascii?Q?Fj2fKy79g1sRNlBxdaDG8tJpus65Od2zgIzC1jPugtf+9TYnqsT0l9Lnpz+W?=
 =?us-ascii?Q?RGWnC8e715t4tdt+46DGrlh85w3ij9UPUpCZIkuciMgdMkE0Ycej3YrjbPwS?=
 =?us-ascii?Q?dvvv4YE1v+JJZK8M2Rq+Pj8iSOjjld4xPO8mtfO3mhsnXiNvqRH+Ztw9FEkD?=
 =?us-ascii?Q?aMqSR4gFlC/nG5uCHyPRR0GUTMeJHg92nPzbdK6TwLjr2F4oFlrpGqHH90Wb?=
 =?us-ascii?Q?v/Kn0bQmRrFmTP9b5gfEnz8uL7qXLG0dzr4+a/mZ6juFc2QGAKB86tIfme6d?=
 =?us-ascii?Q?O7YQbkmV1ZKieFa+K1Q4KDYc/22oYabViqeXyPtRvxaP+FS7CvnNMGJx560u?=
 =?us-ascii?Q?U/ZvHY6MAyAjq5mJewjsG4F7pzFAU4iY8++s/gkjwKRQhXml8FcdxtwSaWbr?=
 =?us-ascii?Q?6qhzPqHAkrFx+z+hVRyxlbAyH+CJdfAbGbFnS1ugWAu4it2rngLyBHpT+WMN?=
 =?us-ascii?Q?GYH/YCk3XRCosxh2Le5ge/k5/eqSvNd988/HcX47GsAFAKvlyG5BEX5rnKm2?=
 =?us-ascii?Q?/tqfB4u29yw3xiVm21Zjudj8/Va0ecd5YWhNj6oF9q+fU96y89oyPuWmrVab?=
 =?us-ascii?Q?0AOTmtXkG7ZISh3feC0dxPAvvTxMneba5gnYPtJVJUYjLcCdVcct+svQOw8N?=
 =?us-ascii?Q?MFwlsZoE6pVSx2niTQD+RCFf0MxtsUjM0QDwxRcC7CeVlCvPcv0wAqQDAlBC?=
 =?us-ascii?Q?jreCimU/k/3JBpE7BXMFKhMKIJj2io9oXGYlX21kgSnHwopAcGCp4J/X6Lm9?=
 =?us-ascii?Q?Y2uPLWvF4O8riMnW+ynKqAeZRWVGMapSrGSsVtjnCBHnLnE8WTHW2dpMyJt1?=
 =?us-ascii?Q?UfiG4Y3roZQwHsF4YtXTAU1TNKax8tSCsgDkDPCMkEow+juCFTQjefYImghi?=
 =?us-ascii?Q?6GGweWPSGamH6WbulAhpiJ/6coRrt5i5kOqh9fp7dkUZK0TSKttnP4xDZyhD?=
 =?us-ascii?Q?lSoMGs/CiC7VLg/MNDLJSGZ6kkCU852kgWAKUJzxo/QSmxQMkY1oodX7eDFq?=
 =?us-ascii?Q?HkAtPCZD8kvf1EOhBeSAOa7uZCvlmS0IQLqQl2T7q1TNwZgrodkC+V3ieLIN?=
 =?us-ascii?Q?qW9RWJFeJxwY9L6BBiIwPqAjx3rFRIuEO63t4KNoE7hrgr4H+gA5c19RBxjA?=
 =?us-ascii?Q?dnIGvKELdyYBF1bSNB97PjKBPXFekL1CMeR6gnHTLDbdk79Utl4O6SEnN50m?=
 =?us-ascii?Q?SKvfNcEex3cqO7vcm5zRbQLHUUoT/aUVVJa1+f5QEEJRePWvzIOUFD4MhCXQ?=
 =?us-ascii?Q?JE6AfoBDaRkVQMrsBp4+pLPxW/xnNrdL3unQ0bsWyuc9Myl7740aotQi4Dho?=
 =?us-ascii?Q?rv2u8w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70480a06-6ffd-4179-31c7-08db8f55fd4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 10:32:48.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEGULMCnDIM9WrqCcJA1aAuXdj6ckq0lZu7RlHOMFhHMv8PZHUaAfhkFcSMYWetCknM0Wk38aB/73ee/1AnVj39FzpB8QiFf3b5Nt4JlL8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3878
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:48:41PM +0300, Sergey Shtylyov wrote:
> Hello!
> 
> On 7/27/23 11:21 AM, Paolo Abeni wrote:
> [...]
> >>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> >>> index 4d6b3b7d6abb..ce2da5101e51 100644
> >>> --- a/drivers/net/ethernet/renesas/ravb_main.c
> >>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> >>> @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pdev)
> >>>  	struct ravb_private *priv = netdev_priv(ndev);
> >>>  	const struct ravb_hw_info *info = priv->info;
> >>>  
> >>> +	netif_carrier_off(ndev);
> >>> +	netif_tx_disable(ndev);
> >>> +	cancel_work_sync(&priv->work);
> >>
> >> Still racy, the carrier can come back up after canceling the work.
> > 
> > I must admit I don't see how/when this driver sets the carrier on ?!?
> 
>    The phylib code does it for this MAC driver, see the call tree of
> phy_link_change(), on e.g. https://elixir.bootlin.com/linux/v6.5-rc3/source/...
> 
> >> But whatever, this is a non-issue in the first place.
> > 
> > Do you mean the UaF can't happen? I think that is real. 
> 
>    Looks possible to me, at least now... and anyway, shouldn't we clean up
> after ourselves if we call schedule_work()?However my current impression is
> that cancel_work_sync() should be called from ravb_close(), after calling
> phy_{stop|disconnect}()...
> 
> >> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> >> more suspicious.
> > 
> > Indeed! But that should be a different patch, right?
> 
>    Yes.
> 
> > Waiting a little more for feedback from renesas.
> 
>    Renesas historically hasn't shown much interest to reviewing the sh_eth/ravb
> driver patches, so I took that task upon myself. I also happen to be a nominal
> author of this driver... :-)

FWIIW, that matches my recollection.
Although it may be out of date by now.
