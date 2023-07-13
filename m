Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17334751BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjGMImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjGMImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:42:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44A5254;
        Thu, 13 Jul 2023 01:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAg9uHBLerG9G4sakFAHpqLp2lFHATa3McAjTmSrN3D+LApniBs4K7DCAT2WNpsuu/uXvyZSnCfDwzEF/Vzpz86w1Jb7/oi6GoGg9ZPOboy/IBNdI3E7Vtr9iWAh00w0WH587eLPZySubnQ0lujWBe1+ssxpp3ph9vIz4eZNyEQETJ7bWGYjjcwDn4PK+WXCtAO4PLY7a48rzo10KE3szpC7r99e1c4ph83LV/SZej5cC7XbF4WLKLVxNnSbP1t1iJ5ZJzH5pzJhdTR6OUZmMFHA2jWSVKwKlEPUSXOpUcKjX0uoCShRiZ1U5iY4PasRPw9XKllB1xfGUVOcfJF6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpZFY14jlOY/H3o28bfR5F8srul8P/YUbHP0ZqUB06o=;
 b=VjldtiTjfy5wUBi0MoKsJ116bzNOmVs3y7NpUgviHDVWbdy6R++ru3ePIk9WOcz6qV31zYtll9oFYYyPZrUH+i/gVfXM31jGWeMUPNx+5M5t0g0nCQsRSvjtN3+u53ORex7apPeL5Z4X3+ay/23cMnsUWcfGadz8gjJLVpObmqq6qKacycAhyc0ALPNlBoGuz49fQOR6qpzYz5osI5PdY43Xbw0aGmTnvd3r62nG/hw8pbOVmEHH6nko3EJ+8iqmj4jZ6VIjwDMahCTpT0jgaZ7jIdRYD+zCJarhsTFxEtAfV0MGuhifbJf1en3siNGRzNc9is3YoRX/X/3ALdi8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpZFY14jlOY/H3o28bfR5F8srul8P/YUbHP0ZqUB06o=;
 b=weLJF3AM5njgotszid2UsX7i++rebMWJ70EhFEzvodhw7Rhy1BfbbI/ex0ImHk3F74dTi/DYxZ4V16ssolAguQmJdEtAXuVwAlYpVF+WA7941xtSLBD5nrcK2DenMyrQbwN1CRUKsj6vqMw55//JAHae8y6BUz8ZrMZTg+676jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5866.namprd13.prod.outlook.com (2603:10b6:510:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:38:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:38:49 +0000
Date:   Thu, 13 Jul 2023 09:38:43 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] wifi: airo: avoid uninitialized warning in
 airo_get_rate()
Message-ID: <ZK+4E7GMIUtzc9Qw@corigine.com>
References: <20230709133154.26206-1-rdunlap@infradead.org>
 <ZK2QeBZKWi0Q6vuW@corigine.com>
 <fc25d296-b245-9a5d-302f-c313f239569e@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc25d296-b245-9a5d-302f-c313f239569e@infradead.org>
X-ClientProxiedBy: LO4P123CA0348.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b02bcc4-9301-4b15-79e2-08db837c947d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwpGK4Ap9UaaStqk2jPPsiLSO8nm5PymxqO3zw+oZsFpqyvfnX7WWiiEBbx5nq00QN8If1yil090pmVQKwUpeZeRPhNW3LaSWCUyeim5uFqtYhc60zsK2ZFuCN8/sESU7nPY02JAxvCLU4WqjBzoB0ZIPQbwkRY99Az/UkBkeKH1VDTaTSRoJZrrro7xYp0xXALqlAd2PhMWfQ25geIAX/vnvrLKN0XgCLXS5DnM7bE7/wVYvAhyU87kPxnBRQoRvt8N+OCv3YnbmYlR7VFtEyp01RPrf0mAsEBvcOg6B8qWKdRCLvWd43KHH9K8dv16qewBrp5fB76qM+IwfIgcI5wmga5lCI32tCVDPaggZXTFMwf4sD6KMV1tVCm4iF0twMvuwXyV2fP+3MrZIJcPh8zg9QtebWVtGF7v+LtWV6z2sR0SpdM3dnmKDMV8+WXIH/qOfCpPk48ZGw4t+Ahe4uePGavF2R5fSMk60wq7T5NCi0WqDCHOFt1viPOBLrtLFYI/HbypDh4eTwuCxjRNZ5t29ILo9Ef10D4aQiFB2h0BFh7vXADhB2vJbHc/Gxde/b33mk0pdwbhUZSusgfo7PdBCG7gFgBFu2BOLxGdTRdsRLuzfCGTdgM4KC+omPB6cOFpMGPnRQXfEbE6tNkV1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(451199021)(44832011)(41300700001)(2906002)(316002)(7416002)(8936002)(8676002)(5660300002)(66556008)(66476007)(6916009)(4326008)(66946007)(53546011)(26005)(6506007)(86362001)(38100700002)(83380400001)(6512007)(6666004)(966005)(6486002)(2616005)(36756003)(54906003)(478600001)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sCGOKe8YgLfSbKY/hRmWFwehti+9QHwy2rH87UMQ65KKC5dZ6YBqE0DcN/Br?=
 =?us-ascii?Q?N3wv1werG6um3Sx0rvKkZX9guQJrBFuup/b7tThZmCPJQhQKiDUiE4fDyLK8?=
 =?us-ascii?Q?f48rEWpJiys98FVEFAw1kMe+aAR29cUYHmTdP8c20sjmRr0lx20qbaX2+XhJ?=
 =?us-ascii?Q?g7DzpLKgd+htCUpYeg3saom1QIFbyu+XGdMEvxQnMecF0ljf1chz0Taby8hy?=
 =?us-ascii?Q?dyDGZoKKpqY1qFW9edFO75tdd0IpNYfzWRLZBO9EgFR71FZeZjp1nYO6d5A6?=
 =?us-ascii?Q?YlkmyfAiiLNmY9rAmQKQFawKa7QZ0U45PrSq46q6dJPR+nx4DTz/Ycpcu2Eh?=
 =?us-ascii?Q?TiH5h4M6eNBpAwuEhBStyLehGPYrKxSRrbdlLbFXPyosXg5abP0QNVwSMveJ?=
 =?us-ascii?Q?nbrs7fNGTQKkcBU3KQi6gFWiHI9qNnPFhcwtPe2o0WkghU2txj1HR7VSgWmh?=
 =?us-ascii?Q?hiGvZxfy9vfA71uWSsLTkZXQboOTIs40bZDaZeg2/LuJvqjjQq5NI4lK8AH5?=
 =?us-ascii?Q?v8l1fMDygn8jZoFK43m6LsdkXq0ZpT2opY6s/rdrUuOkVeDJ5pbrE73V5ruo?=
 =?us-ascii?Q?RsxAC9WJViYzrqNcJb5ZPy3nYSQCwh7SqjtVr+eIq6ZzYod93W1GEF6SLM/l?=
 =?us-ascii?Q?dWbWk5DX/xJlIBWCZ5H/iVZL4Lv+K3mgoiUF2LBGc4FaBIUMaZK1E+301aj1?=
 =?us-ascii?Q?p27bqD8v0gucDWqCN4+bq4br9j1mVWVSpS8iQlYZ2TMaDsLqr42EUis1rSJ6?=
 =?us-ascii?Q?k2pcc4MNK9GaFVI7c2sp9jGG6D7EF8F2w/366W8B8ctWU86jtNxWGrjeu9pg?=
 =?us-ascii?Q?X4KA4R7agVG2oaHoT1oZ/ZCPqSHnqlA5yviDwnfMW/noRHt0/U0FSe42Aj2l?=
 =?us-ascii?Q?FGPBM1puW4kl42JU/uzZiAd+wyuKFYfafkpCNvGjI1o8uOd33ci5wLs5RjT2?=
 =?us-ascii?Q?I2NpPStfCDosl7i59lcVvLNWJHYqO9uvmEW8E5znjJxVX0V0N8xHHNn8nIWM?=
 =?us-ascii?Q?CCgzVLEHmH2OXrSXbH6K7VWFQX2mITctQo73K+wfQrQAG1sOjy1stnoOtUx+?=
 =?us-ascii?Q?9CU/y7iz9OjlLtrtBQRqc0gDMK2RlP28RCHqWT/dS6MPALnNvwF4ddWMDSNX?=
 =?us-ascii?Q?OP+4HT8c8XCo5bbOLEV8w9qJiWNn9yfiJRyAAYze6rPg2UNLzPy0y2knzWls?=
 =?us-ascii?Q?qFuX5VDrvy16eMNAF7Y/0EfWnKzoQ+grfQdWhPVsBJE6ZKKHBwExi1WNUwhP?=
 =?us-ascii?Q?d2SbgRED7vzkYd2ZKK5jjIyeYLz5EzYNcJatzOHjYik/GErgo2Mqyyu+qqVu?=
 =?us-ascii?Q?ckrcxueaIMkzuIO5nDTWO/dQ8N4+o8mT9EGPdIkO2ojioUC3M1Xlf6Il1sEU?=
 =?us-ascii?Q?syL4HhAkcCFdY8lbasWpU2k1o+q36uLfUFV27sYud+T/YrLrIBifGNhxlDSk?=
 =?us-ascii?Q?AkKu6PsSUpfMWr5tETCLmqrY9yQFKvD/PfHTJ2BoJbINiPjWpq3s+5JzCjTs?=
 =?us-ascii?Q?s63LT63BUL3dagqjenz4ccEYZ0XIK3tfh3HVvKnV54maMwKawtpNGDDlSlLy?=
 =?us-ascii?Q?vAkd9zTXOf3SPtz8Cju+KhkByXMpMDlYlav7fboA/KIJzPxRY8QawAsoq0MF?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b02bcc4-9301-4b15-79e2-08db837c947d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:38:49.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImApln75Sn1VC6+REwiRtt409VFYvJIm6v/fUm09J9jIVyOJcDjo7JY17JPFLS2yKPUdWYNVPJIDI7iZd+smeqCEheEhdKHFk+bb/3QSI4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:07:57PM -0700, Randy Dunlap wrote:
> Hi Simon,
> 
> On 7/11/23 10:25, Simon Horman wrote:
> > On Sun, Jul 09, 2023 at 06:31:54AM -0700, Randy Dunlap wrote:
> >> Quieten a gcc (11.3.0) build error or warning by checking the function
> >> call status and returning -EBUSY if the function call failed.
> >> This is similar to what several other wireless drivers do for the
> >> SIOCGIWRATE ioctl call when there is a locking problem.
> >>
> >> drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]
> > 
> > Hi Randy,
> > 
> > There seem to be other calls to readStatusRid() in the same file
> > with similar properties. Perhaps it would be best to fix them too?
> > 
> 
> Yes, there are 40+ calls that could have problems.
> Please see this thread:
>   https://lore.kernel.org/all/2f6ffd1c-a756-b7b8-bba4-77c2308f26b9@infradead.org/
> 
> This is an attempt to shut up the build error/warning, which only occurs after
> this one function call.
> 
> For such an old driver/hardware, I don't plan to do massive surgery
> to it.

Thanks Randy,

given the circumstances I agree this is a reasonable approach.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
