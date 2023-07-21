Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDA75CC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGUPuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjGUPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:50:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C095B2D71;
        Fri, 21 Jul 2023 08:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRNKKOVnMNodoPrgT6pcQ3jn4mIi6n1l0loyUQnzGD6UQq2t/MOljVwfyKI6bOwSDbjunz3Qlw71PnFBPAh/87rD8sNekZeIMkoMBWt/v9krk64A5x+KPhWIX2UMQFeMoWk20WG6JldyvNZVNgNkdrkN7dn8jc3DtWgRz+7FtW6ANt24lGfTX7if4rGF4AxTPlBAcsqiKUrYiWAfvhvGtSRmsHBaMy/ehQw+jWRqLIO59ujsiU3+jkJnvN0hyzkGffo+rBuj/immHiIr5erDk9unzg5yxvU3gAi1Q0Y7lBx5LIJ/KNXBQiTP464c1SFlSbXlLx9dX8siHxje53EXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeohQXrzNj+BBBjb7sAkY3moi2hie3MSLERuAT9PHqg=;
 b=D8Wg4F19d0WHiEsYv0qQ7LMStuSpx7Fu/NFiLOwemd7JK6++CAFc/BQM5rBvxm7AeplVqPPCAVmueQ7K8da+WcBlMj7+x0QWn+2Lunqr0vJg93kbvq5Sja8kCOJZit0iHDPNzavHQ8VfLhJQ7EI/rzlqLul1kwfpGI1gDF3XgLba5c1Obcn1twQM8bZFVRgZddO4xvvDYDo/SVvWtGGxztbK4q8ruDgA9JsEWCRIVqmiZy7U5FTXUSqelB2rhBJ+a2Kp5UE679HC7v7rBr72j+4BkIpeHE7WbNjobNdZ4nQ9fSRKj6OxCXw3ak6ptI4yxVEbsrz1ebAgyMqimUjWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeohQXrzNj+BBBjb7sAkY3moi2hie3MSLERuAT9PHqg=;
 b=OCJalKCR9pH1yAAnsqXKkp2ag1lHk7HYDTjezdg2fnO3uVi9HD5QOuLB+BMR3aVsVXhfNt9BsnMdZA/zSwTUplLUDd61S3sU9MUTdpStgTuI1N1P376dVDtncloxS5zDe6/V3yUd1uzlbkOZDWNDhocPF5fV+KAkF/uWimcLbXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB4947.namprd13.prod.outlook.com (2603:10b6:a03:357::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 15:50:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 15:50:05 +0000
Date:   Fri, 21 Jul 2023 16:49:55 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
Subject: Re: [net-next PATCH V4] octeontx2-af: Install TC filter rules in
 hardware based on priority
Message-ID: <ZLqpIzpHMUiQcstf@corigine.com>
References: <20230721043925.2627806-1-sumang@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721043925.2627806-1-sumang@marvell.com>
X-ClientProxiedBy: LO4P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: da152793-76f1-44d1-5bb3-08db8a0226d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKSyORUN+2QDc/k+CXs5JDXsPqnHVts4QYnLud8zXsEzOoJSAO1T/jwy7AWHA1ziUjQPvPQ0Z3iyRVyBOtlfzcrDXOlnJcyDIWap0BzLbqtTt+ETtR6ASmu2AYb0gYUNzEI2OwLT9KY56FwFnayjG+zUBf++OHmdIKxSaY8fb+azQRLtcnUnZATjfqwKG1KUk7wBM328nH+vPvaDRdxljAHR7agsQ6A+r4vxceWy5s+YmEF32BkX0iN1D9MkGO0ASgo1L7p0xIHzc0pX/8cCHDdRcYK9bfjvvq37vTKdKisX0eSg67efKgCOIU2hG9V/CZ7TWHOI6Ges2rRLwB6e0oRLrxPiEOZNSb8IIhj5b7fORn1XhFRb86RROThfpEJ8BbPyJ71Fs7q+iCq8DPi4y264zRcRjcW08XEzvWhZUS5nJYzKfT2CllsIorkZQi3o4+a2PktbQbLoU3gpMGC1Th6AuM7d3VVkES9bs52KlXvHzjIAUYRbqNpVUY+Yr/bpFHpkcHpJQFupj03KQvkFez5b7oUqa3QaeNNXwS71he58pIPFSfvwi31IPPZsK0sPkzrSx+WqLvGWC4a0L8odpYRjsGNt9Ih8uYWa7ZDG3iI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39840400004)(451199021)(6512007)(38100700002)(83380400001)(6506007)(55236004)(186003)(2616005)(26005)(7416002)(44832011)(5660300002)(4744005)(41300700001)(8676002)(8936002)(36756003)(2906002)(6486002)(66476007)(6666004)(6916009)(66946007)(66556008)(4326008)(316002)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEtN8kYxqXWEGDbmJ65+SjeD/dGAl2FraEK1eDudhzw7pmCK7Z5LpXvWcfTL?=
 =?us-ascii?Q?jwriE4fOvy+ixz1P36kkWrYL9xpthiffd9sNYeBg1ObmJ2PO8Z3YMFVGtB1O?=
 =?us-ascii?Q?XOpHYpWm9qiIAoheeiPdGRHX3GcjswEWwXCauX+UADFXURwmcI0omJIq7jvV?=
 =?us-ascii?Q?0kYGQWktT3Hnuuyap3r00iz7jCu+wJmeYCysV6d8TBAlFVC2trGJMCnciwed?=
 =?us-ascii?Q?v/aUUJjhvF7bV79aJN4eyWBv6+zDc1zS6WcLZZW/IMLDbkIZpSE1nhce6uX0?=
 =?us-ascii?Q?wshV+JTWqJ3Z/w/Xo1sSVUtzotK83iPX/+xNKvPdPeAQyJ/4vcTLsz4Dd+k7?=
 =?us-ascii?Q?TMzH6/Zz74Z8zUp+ZNPRluTyMaejzV7/VXqZ+am2oSDm4XU4YDcS253acB8a?=
 =?us-ascii?Q?MOTwGgpJEj7/qy1cbsU3PXzdkq5gAzv6puiwFaZYLu8aGsSVzrTZTEei9ZZK?=
 =?us-ascii?Q?hhSCFTzTVqBBl8RoT2ECqZKsYo81r1EmFhzd0Ao7N6ZLr8R5nJYH7IkW9Nx0?=
 =?us-ascii?Q?lkUe0/TsVc2V2zZV/dV/PhAtZV4QRwAdAzH4DF3e9EWOgKg/AJiDQb3UKlXa?=
 =?us-ascii?Q?ai6T21foeQIY+wsFNth5icwnHdwLlCVqU7XtgFqGH32ilA1BaBIkWg8osg4y?=
 =?us-ascii?Q?/Ufgs2/x+r26r7BgcBJiIPMgINMrh8s/7wRlInbC4vWraGRCcX/NPAyOf+li?=
 =?us-ascii?Q?yOACoDmNxbjT+VbdKofB7Nn5lV1ZqpW3HiDcSF9ra81LeJH0cRFFEe9l6APZ?=
 =?us-ascii?Q?heLpXPWaeuFMJsmXE9stgCMZe2kshvlsEC9y27mWQqarvK0ZADlUJ56OSMEv?=
 =?us-ascii?Q?+/DtjvcieVXFuTpQ+N78gQssoBOOyGh7DBGLDv9W2Gg0B/ZQ7ZqMzYx4VU82?=
 =?us-ascii?Q?5OiO9S1TEIbhtYMMBpWuxq427d+vaS2MjGy1blWFEz1CugHt37R2F3FB+rEH?=
 =?us-ascii?Q?tmg0mnjL3N3X0C0Rxe/pyl9fbTVTvSm5Xjs1tAZvmeUFUMOU3C3sfRR+G0IM?=
 =?us-ascii?Q?Zn6Y88yMErSK1YXFVM8kXKSfgvTrXv+Qtk6csJXmMk/4yaxprhQTkb1evu1Z?=
 =?us-ascii?Q?1l9qs9p7zzOThVoOG/4fZViv5GIzzFbsRPN7W/IVvLMggUYpFeyCz72gqq2Q?=
 =?us-ascii?Q?jl/nYU0S2qNUfsNNIzjTc7EvjLf6hVnfeTXyH+g6XC9+Kp0HLuFlXCWoAJfj?=
 =?us-ascii?Q?78IGgirbndBqXQz67KNEOm4q2h4aE2WLxs0tzmvwnnAKvnZugfiS+PJqX7VB?=
 =?us-ascii?Q?EHzQ6pK7jZTDrrnDRSTNVlgBHQhMDo3RdQOcdhrnJ5d3ZaEYYdQPBLmiyLwz?=
 =?us-ascii?Q?9PR8fKwM3WJS4MpZK+Nf960koTbgymWqNYnG/1YAnmnP6ZqpsZwyem9XOq9G?=
 =?us-ascii?Q?Z44fp8go1+Qe3UbOD0w1t8fzZUxOQjOe/+X+z7R38wmf+zAi/4xkpc2qErkF?=
 =?us-ascii?Q?VN1WJH1q4dzsP7cIXfUY0c4rrCT2moGdvXLUls0S7l5/4OWtNhW1vrMaV3dk?=
 =?us-ascii?Q?3pnouLRCw6MePiuBHZ5EvXlFge8aaXwJbfpSoipdM4dh7Qm31JwtYXFqkB30?=
 =?us-ascii?Q?LBgs0kM4MXkf4F5aJ/LK7S+qugizWy6Ao9+oFewQGNqmMF3WciUsi26VCNkN?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da152793-76f1-44d1-5bb3-08db8a0226d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 15:50:05.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aehjnnwzKQM6dJHnZF++0f3Q0c/oVbvRS+sc5oEQMaKpeJkW4QlmlVzr6Cy3ngVpHoJnuyBRqhiUVTP3oOchbSYJIvMJVTw7tiNkowkr77k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4947
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:09:25AM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

