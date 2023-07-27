Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457F1765280
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjG0Ldm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjG0Ldi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:33:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD2C2D73;
        Thu, 27 Jul 2023 04:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1xsy9b4Sw+tfpoOZW0mCcquea3GadCbdHSDqzwWzgnF4z6OXaqc9SAC9V/Ms/WQLTRhQJEm+5rEEXM2hnUfoAcpvhd8jwgyD2pOZNccQVkKTtYifJBy82yyd1GP0QhhS26NI5ZfaC2iQcpHQbqaKGOW0BvEuCNyPfTX+SJ3OYLcIqiT57v/CXQqqYVdFx97Muo4mkgpiXCU1Sr/njA9H6/ojdbzxvISzOTzLfoyeocXTjIklhKjFMvktc/QEoaxJUAqUTshFDkgNM9/oQSGk3QbBQ8Ax7IXmjgP8eDDt7PgG69fBhVWnFMwfNGRqR2YL3+/YjyhLfnVqH6wfkqoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdMKNmcrRd5n0OglJ3qTHDFThsXZE34wObrA2YgRWic=;
 b=aErJ4M9DJBqCo7d3HKxu7DSnIFIfTaJEa0MuguzqgpZsh5Mqjx8joXwavleQuXMelo4XkRt8c85uxSZpWircr6dIWz/sx0paj1Vi0YgoV0DCwzNRIUAGTFPuIL8nisBVruWccD91mzEiAWDdS7mLasxUMqfnJX7QGFs6xC26aVXhof3Hm9JbHRWt2Y7YIHFIjn/RgX2HCVx6cpZa7+VOulRJZ4i9HpsljYfkD595y7Zz0r/p7qCkabjRb8U4r5aVDuX6yv7E29TuzzBacCiC3/WxwXdAtZV38ow7E1WFt0uKeBj2eYVCkeQxyunq52e9wVusr6d3SxWeTolKGItX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdMKNmcrRd5n0OglJ3qTHDFThsXZE34wObrA2YgRWic=;
 b=a+qQkK9wOF2KQ1aTaun4O7uGUe8ESkZwBHRt/CC4/YEF3+kKcqpuE5OvhPpTAQqzjZSOGP3dT2SHGFH6tP5edbcnsfeuegm5/JXDwkSsAcU6yyAXTOtmmfe1CdcvocFg4FUMSzE2I5kIU1CMUYm0qKMTtiacmMMB0x8ghk1inR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3761.namprd13.prod.outlook.com (2603:10b6:a03:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:32:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:32:37 +0000
Date:   Thu, 27 Jul 2023 13:32:31 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dccp: Remove unused declaration
 dccp_feat_initialise_sysctls()
Message-ID: <ZMJVz8hZjANnvIv9@corigine.com>
References: <20230726143239.9904-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726143239.9904-1-yuehaibing@huawei.com>
X-ClientProxiedBy: AM0P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::35) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3761:EE_
X-MS-Office365-Filtering-Correlation-Id: 1957438a-8853-4160-3994-08db8e952dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ltPmtSuPFiNVw+lrWkahTHPMW8FhTUkkP01yJCYKK01/NaqDrQnaB+7uRZY6WblyDRB5Vu/Ca1P8xKzQarokhTjh3n4iJ2fMfePOsOFG8rBOZoCT6wOi/iiyEimLWiYARlhYXIb1heSNPpj6ysdBFeabO3f9pt1mwk4/5LruUHAJiJmKuFvAxBF9rBzLcvDv6j62ijdwtrvzeVwwV7ZQP/Rbl5ewTpkdh9aaUsjqQl6LvbrlTHZa/xN3qllVsueFv9+ROcEUvPIjw/IUTi0dDfPK6iv9BhUcgnHFoe52gKhLr84N+PKCFEJMRMe0P/G5tXUgOG66xJMBFQleHlL8BabvZN/DgIzCNi3D8mO1XgXjp7ewYj8NZs8do5beFItz9GxO/g/TW6Mn3qikk2UoWQUYKCAMwmD6362AXnd00mDFamoFp+7AfXhdWfWtaW6ZYybNJPTEn3MfwlMTXNeH/vZDxodS6csiv6mOiRNwJriPbfddmwWWWpmseNslKe6bms8NLCDFLV9ldOnd+997XVFX0ZF1QPdnV5VqFQR0OiITnZbyKrccuEZJ7F75Qb/qbuR6u92G5evrR7aVOzDcFDcSEGXyaqLnHDBump/nS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199021)(6486002)(478600001)(66946007)(2616005)(38100700002)(6512007)(8936002)(5660300002)(41300700001)(4326008)(66476007)(66556008)(316002)(8676002)(6916009)(186003)(6666004)(6506007)(86362001)(44832011)(2906002)(558084003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6FyIKEpa3399swyXrisGudbVQO3BVzCbAHivgzX/MM9g7cltjz3JXLtMUQy?=
 =?us-ascii?Q?eLrV7YulQnRMiaSFO6t1ccigq2L3sTvTPlmWAbe1Mpx89CdFKIuRXc1XHI+Q?=
 =?us-ascii?Q?JBVuN0I1fh9IomVlt4XnuFVHMxegYW8WaFgKj2afoCDzDk9NGCpMs0Z0PsuR?=
 =?us-ascii?Q?pNNWQ366uA0pD1rQG9GqrTpPTK1nJUyJyA27Gxf36VDLjbc2Tj3pAJjJEqeC?=
 =?us-ascii?Q?YFD6p07PomE6RJ2rMZJvkwkSBHfzN0d97uFAuN6ekH6kc87kmzqEz2iYQnUO?=
 =?us-ascii?Q?unzTPL3saZXbmV062axfXjWCeaUQnDXClwjA1ODuc6LwMH75eKJ8qPh2tYoK?=
 =?us-ascii?Q?ZGvd8BzYahyQQnHz6JtS4i2Vs9UHOm0VPI63FWAYoi0U7AkD6isrtpaBDm+Y?=
 =?us-ascii?Q?QgaVFeC+zXjbsx7HsKqrcsx0F+PybsJzJy6xWqx6WkrX44aYym5QBoght6bI?=
 =?us-ascii?Q?kEZQxbu5MRrEEJOtsl1P0lVDffzk7GTlFafHAG6W66P/myjJYIfkZueuFxCP?=
 =?us-ascii?Q?CuTQcBc0hYGVCk9/iof+JDCtYFD1Co2kpkEUHHpq4S8wAPZqyLTzyAR3htlr?=
 =?us-ascii?Q?Ug3LN20JRpKdiIZ69+WUrgSdlC92/JxnZN68mTAomF80ycqpSf5/1ZzvY8Ot?=
 =?us-ascii?Q?6h4rleqzu8uk/dHO7i+ANkze9H7MZV2OhRDBuHPQlaEUOFJVGT6Y7aYdUqSz?=
 =?us-ascii?Q?91t1tCrrzpPovV6M6droAjnvLvD82J2v06LaZZg3JdPAobLzqG0lnBqDyH47?=
 =?us-ascii?Q?kdh+AXP5oPyw/B5PxActlQOmBWB4bgYhvQG2+leZ4qrjlMaFpEkaLMPeMQYQ?=
 =?us-ascii?Q?OaAHlsJ9G55GP93RpDv9GtDkELeBal9vjvrzTGxB3+cPHlpYuueKCGcc6Pdg?=
 =?us-ascii?Q?4P3g9IQnZIzVyCcw2Di0NYm+rKwEITrT1S9mA46pLdD2ZKaCvml8zKKuq97a?=
 =?us-ascii?Q?8OqcZg8sY8fDfY3Kvy3elJJ2zG2tcv1iJO4FMZHziKRsOroBlnSWJRlz34s5?=
 =?us-ascii?Q?wNw5u421c3FGkJsCo/nGV6R7vryRMc7dctS80ep+/UBXjj2t3OcY3r40qtTc?=
 =?us-ascii?Q?ZRdu2kj3511PNFit3sbeGwqqz/E8sVX2Wda7VXNqSlfhkQd/oZPPRe/sp40c?=
 =?us-ascii?Q?E7DklAVH2KpmYqmpgo6oYrGDUCT+fCK2zIx3zWnPT3micGDeSfdcYMPnKfso?=
 =?us-ascii?Q?osLv+jUGzW96IcHti+yuz23maP+Am3mwGb/RjtZkKnxlW4mLrVzh3UWlOZQ0?=
 =?us-ascii?Q?d26FdxdBTufFrqvktIfAVAUV0lMGyvgcv91ij1iFfgUN0niF+NKnsvqcbEfv?=
 =?us-ascii?Q?pOiRXxvxNOrJR5YYezrqTrVjbf5ZF9KZqZwpNRVDE7YewMmcvnHgNOBo09kj?=
 =?us-ascii?Q?8+xblGLYBMhyExhjF0YNSiT6jxmGy/5ME0VxyyOYZBMHP4999C7+j0aX2am9?=
 =?us-ascii?Q?UKPgrXrtebMgmr4MLUGOIWa7WK5YtGm6LjrIpHCsAteKihdqdJ3/mcF20QG2?=
 =?us-ascii?Q?7dpXgQ85yp4Ci38VcwuL4bdDQFt4CZzaRZjTdikKeMItnA82VoIwZN4XDgho?=
 =?us-ascii?Q?51GBypxTgR+ZB7htP6ElSaky8Z9uTN/oyoH2AVGeF8Qm8UvmwrLOz6qxjEcd?=
 =?us-ascii?Q?TgZ8bRRPW1oLnHlWa+lhAo67S53m8rYSJsAzYIun8APcACxYlVD4jnUKf63s?=
 =?us-ascii?Q?HL6ZcQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1957438a-8853-4160-3994-08db8e952dd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:32:37.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jWNav4j0K0+JUPFk1Padz2FTE55x3uUJWO0Hul2ZZgkrvE/aRPfe+gQaYc1nNZRscjD0HdMsizYQ3okzV3pyGGKEZUe3J/Ucy6QB8FipPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3761
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:32:39PM +0800, YueHaibing wrote:
> This is never used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

