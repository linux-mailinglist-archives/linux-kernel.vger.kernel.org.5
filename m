Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5225875F9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGXO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGXO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:27:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2095.outbound.protection.outlook.com [40.107.96.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72EE67;
        Mon, 24 Jul 2023 07:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpRGH8GqX65VsLri36UYWJKXAFGQiNYw11b5mupvMCYp9WJiYat9PQy9Nrg5eHSo8fsroIAz+rTe4oTLGDj46RIUxsbM7HXugftoKdvu7PAgIGaFmJ+sc4iDZwOSg3RsXPfX+c6Uwgaj1yoYVvT7PhCqgqvG/zdIbjrKZoImWfa0SvhLTyG9ImzODaKHd44Qw7R98V7y2iadehnPni/+fRyCW5JTGkd5EAHJM7byhx6O/uFhEifd6d4tUzeB8TnPRI3BR6TMyeWVP9gwmL4TzO1UXXFYEblQBcC084ItOtUXsk8lOysmg2vmnkRS6uuR86K1m0H/oISXPdjyIM8vhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPFL9IuYU0OFrHiiQ0Tn/Q6B8pBvS8+PxYspI2D9PRA=;
 b=Ca30ku/VhOY7ikT5vd1h+CTRxfRgUxw33ZbNedFd7bj55NyLIJpWpAPgFysyptLLFmsO1fxc5TgZWhuV3A9wlCqWfo4kFoOh2oiIfNeuSgpNuQK/QZ/DpQWIqW3EJWVOWTAa3/ASBdNl+WMt0r7MIsOtUfxxp4/b7C0jBuQjRhAd4av4Y9ghyhktJBC71KhxznCt3IQDgm1ugiL+GSxVT8Kn2CuQDBupBmGBTbcOZ1uEk/9EJX7gEv6FaloOFzi0oW5P+Fm41F6Xjn9G5KCQXAjlRuD7SIsHdTnafESHS9i8XQOcArsi021d8aWMTdvGwwmJlyIJ0Mx+aLCBO6R6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPFL9IuYU0OFrHiiQ0Tn/Q6B8pBvS8+PxYspI2D9PRA=;
 b=W/5IsgxtZTJS5PXs+4yRFhqYRnQ0cu9FHI3Hik8lKaTOPlpVj6Z/K/z5c4Nt8eJxRxf9rIMK3GHBRRg4mbDHUD2rFEvOqMvpTQhJFK7jQ/avOTeUwNpxKRB6Mh7OwJfONOWh8CvnFz1dkKKhk4r9ZvFLwgJM9Qm+nw0HrQKE+/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5030.namprd13.prod.outlook.com (2603:10b6:303:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:27:19 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:27:19 +0000
Date:   Mon, 24 Jul 2023 16:27:12 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
        Petr Mladek <pmladek@suse.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] netconsole: Use sysfs_emit() instead of
 snprintf()
Message-ID: <ZL6KQLUNIyXHAtOy@corigine.com>
References: <20230721092146.4036622-1-leitao@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721092146.4036622-1-leitao@debian.org>
X-ClientProxiedBy: AS4PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e5e8ae-e1f3-4cca-55ea-08db8c521611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iMbpgvgRMdBtV4GeM88LocLGeUrE0Elz2DIZ2baSFScg9DS++K2QDB3FIDMDDZEWRyIVRdfURnjYrp555ADp7I1FWQPhaw1R91/M6YWKMVdI8FlAs/k8o+38Gip4Nr5kuCBJjqLTqcBTHiQBpzxKlOfskCsTwezqca0D254Ey1bY5UJpoWzOg8NBNcVpfM/mbcHeaLdikg50iMmr7vSF0GCRiJLIFa0fzq/V+xYoo36B95ZoEzXNUArdYGOUABWh/3rR/jHxqy2NFN3DFoaI5i+4xeb5vOkBa+Bj/JEmII5EPAVYl0P4aXFZZ8OeQYbIxBuzf5z2GT2Q3NLQOe558ZPtX3LzcN6jyHdl8FrDD6rUHi1CU2QVlFU1kGIE8Eb1OacB5VZHhiZqhFZdaYpw8TdjlH1stJSldkY9vqqRuve8O/coWLxeSKUKx+s8IeMgwsHpGFTZVjmjcpKTXJReJ06709/kf0Fmg/k0H3J5vEAfmO4swMgSQZJ2NPp20xqJaKyyufR/fWOpJqeVOmhT2z8TR9n0KrJz5S9KIYmk4WUgydDmMP0+CtEYGDPf2VHbcUKi8VBQ52JCg0L6bz278FVDYsOWYH/vyac/uIte9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(136003)(366004)(376002)(346002)(451199021)(2906002)(38100700002)(478600001)(8676002)(6512007)(186003)(2616005)(8936002)(86362001)(6506007)(5660300002)(4744005)(36756003)(44832011)(6666004)(6486002)(66476007)(6916009)(4326008)(66556008)(66946007)(316002)(54906003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dy+ru3CN66ODHpKBZUPpLU8Rwpg4WxacuAuARCWZPFGjh+vrw54H8n1QXbF2?=
 =?us-ascii?Q?usN9MkGydNgy7SUv+32gUvERsbaaB41xNN3hrH+CPWuyTR0S46Nq/c4wueVl?=
 =?us-ascii?Q?oMGn+ltrGJekr21k/7hniuZ+EA/yeHJ8EGuOv4/obwSSBbsPDMhXBVdkJ84G?=
 =?us-ascii?Q?es/ksOvoqfsd0c7unAFOuwmfQCTLvd2oWxWnYmoC8koRgnkcEVvWybMo3soq?=
 =?us-ascii?Q?He7BQ9nYHmTQIZDtA1R4kYistnDk/1d2DmvXxk0X4pvAy5eXSAM3gToI3zhn?=
 =?us-ascii?Q?kJxwX3EhMkRsnzWlMOR6awleViTpSDBngpKBqC5zlYhLFJN1pHVhEYbsMpJI?=
 =?us-ascii?Q?agzny1R9dNqT/W7fKhYs4mIjUj+NEfcchTd+zdf6v0Jzamn14GJ0Kdm/+fpY?=
 =?us-ascii?Q?BDj/DkaHnt1fuSdDbjGJ+XgLP8/VE7VSPyiN3+dGLoteWEtqdi+CqbxAm90F?=
 =?us-ascii?Q?vAK/Z3WwTMwLW0JteGz+HaGwY37Ee7sGW+FSQx8t4TfpzyBfNZjEkhjZIBpG?=
 =?us-ascii?Q?CW5ASGYEBkRMU5WitGMVV2ka+1Qk9y6upS4SRBJR97wqHllmFibL2GpJz5d7?=
 =?us-ascii?Q?R00a6+NQWRuOA1bBXx3afpiWSc4bRqbDSbOz4VwSf6rbtn730vmoLcFDCO+8?=
 =?us-ascii?Q?KQSTECy1/BZ3xwTGMDgRrhOvcz26iyTEh01moCnvK6vByBzhTBy0cBrXlWAl?=
 =?us-ascii?Q?S/BLgi7Z1Z8vCgvLdkC+6oKkZU4tCABRS7VNXR12JdS+NHjMW4jHuc8t8ey7?=
 =?us-ascii?Q?BRLTgpe0W2T3DqS4I5UXWzRZa9aIDyOONVbpX1SIpQkaRTYocUrx7d/Q+aAs?=
 =?us-ascii?Q?s8iohUCQ0yE7MvpuMO4KUJVx/V9mrsSletjWDkpI7Ihas2ezWlTi7vRdXsmy?=
 =?us-ascii?Q?comVU8I1NhtRjirtuWPrCsFJiyzQ7bdTRHJYgB3Oq+V69VMEJ3u7/6HtvqP2?=
 =?us-ascii?Q?jCFw9lLL7cDl5lBlRCc3GuBF9HHJ1GSo7OJmAKBp3z9Qry9Mf4StiVQPg5ex?=
 =?us-ascii?Q?0tU+u1w0/m19WDgiDrGeQgi1M5uE6GndSW3oT0iobiEQcmi9FdRXXsHpjC+g?=
 =?us-ascii?Q?HW+BE50bruCDuN4RnhSZcYAFh88pAU4Q+7d1NuGAZJosEOlH9CPfbfpjSqOZ?=
 =?us-ascii?Q?4vTFDOXZ+h+ugUC2UsUnf/pWMrzFKMCmGt0Hv+0Bi1at4569Xt6EqG0kGTI1?=
 =?us-ascii?Q?rvDxcJifxowwduQ/TvQoX/WP1B83bMTUAsbZVcDlHhL3K9uWzFFxu07N1hIj?=
 =?us-ascii?Q?Eg/ePmBMA/7jMegDrzdKwvsu8Xv1uKXyfpwiK5VnXFEnTLFUUqmNFqEpWadH?=
 =?us-ascii?Q?2qTqlw0IHwkEdz6B30vU39S5IDF5MW+XVCRyNk7BK2IDxhLqVS9odagD5mAo?=
 =?us-ascii?Q?F97ev+V7ym6aC9gbvNbByzRuFEU5h8p1ON89zB/xkEdT5dNogeNN0GQWf/p+?=
 =?us-ascii?Q?WjgE0ac3Zg9lYcmXjPiDRoi4Z/CWgjW2Kp7YLCmJKnNvCpMnAaCS4VHf145a?=
 =?us-ascii?Q?kCHw4CHNYN5DCchGcY4VDgBH61l4e62cihr009l9QgQLPhNbsCbF2zvwwFDE?=
 =?us-ascii?Q?5hJ59LeRM+R+9xz4do7vqTzkyqfTAt9e4tpjQcnKgE1gcXV8vd14dhASxxmr?=
 =?us-ascii?Q?pR7z9CKaKZjP7CS6mFn1oG2UWnlWc/uHgHQyIXrfu3SNAvxyEQ1MS0FYk5Qm?=
 =?us-ascii?Q?1vbmEw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e5e8ae-e1f3-4cca-55ea-08db8c521611
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:27:19.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpbCkLG52u5fMvIHC3Hjrf/cYpG7ApQT/u3Km0gP8t2Tyo7Z2f/DYbm2vXKvqAw7J+krR0whDQ11hot3K4A2JilKu/bU/Tpijrh2Qkmu7os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5030
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:21:44AM -0700, Breno Leitao wrote:
> According to the sysfs.rst documentation, _show() functions should only
> use sysfs_emit() instead of snprintf().
> 
> Since snprintf() shouldn't be used in the sysfs _show() path, replace it
> by sysfs_emit().
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

