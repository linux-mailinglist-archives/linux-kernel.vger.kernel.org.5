Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3E765287
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjG0LfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjG0LfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:35:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429893A87;
        Thu, 27 Jul 2023 04:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtBY/wEqWNSmL+RcvVFs1o3x3iBzZDvb0FZiq2DeaCbdrsvANKmTTqv66ncjhntAaJiW+VSs1NsTcYqvQi1Fa8XjTSUln/UVznSUWdiC+/8Y1CcMdRkpKOO97WEm6f43OPnBd1GkAHwAipJytZCgsCyJl7NxBOyvH26kZCWLrSfcqCsgdTgmKmol88Ir1pSNynaaSpKa3C8+OR0AlFxCDuuhvZxz9bsfUckBJNovJQi7l/2A0kQ9Mk3mx5V/Up3TQU6bEKgaDWuIZYmZuIe5H0EfuKIUgwUYYh7w/P3Ojevl0nGjXxc7k39Anuf3ViyUBmo0/cBJrBKsTgfptieCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDpyILXk4cTIQxfIbIkeFcLHsdpbxPoVMmMZb4iop2o=;
 b=bsF9MrLL2J9HcZ5q2C39CdGOLhBJIzKFfu7ujM8xovj4TsUW0FFXSoaWKh2iTq12fC+pxE1vF/Pb5kb0XuNhU8arWegsEU0IteRuzy/CNXKjpzt05/cHXNAUEXvoWFBzriWEKUKj+HzDo/ZaEZNZEXE3LfVu9+uaW76nJ6SP9P7a7DY0q8WaPSdwCWfphAr+oPu+CuSP95Jb3OIYv8pb+DrAf17ceHZ+K6SDImXzzGzfVj1VjgC2cXLHe4Q52PlQ7tc5WZFXCSddu5yiO9aGGfZvtWKgDoCr7848B0GU4q4Zi6sQah4CxkSUcEesM2o1no+AeRvCKdxAZ74/QupZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDpyILXk4cTIQxfIbIkeFcLHsdpbxPoVMmMZb4iop2o=;
 b=cJNPb7WWeGHpMB3iZpn/isAbFOb5GBNjOxeV6PlXsSPiskVXHC6zLEyqasJtxru7DiqkiAzbeSniVCD/Fb5Pv7wvgt+HGsZJzic9Cw2sC4kJR/0X9nze7oFeCbrHLbl0mQyvrmXwlk09P0co4vcx2yWzrt6KloMCIOsGI04/xzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3761.namprd13.prod.outlook.com (2603:10b6:a03:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:34:28 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:34:28 +0000
Date:   Thu, 27 Jul 2023 13:34:22 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove unused declaration dev_restart()
Message-ID: <ZMJWPqfBPJatwF7g@corigine.com>
References: <20230726143715.24700-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726143715.24700-1-yuehaibing@huawei.com>
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3761:EE_
X-MS-Office365-Filtering-Correlation-Id: 388253e7-035f-4b71-55a3-08db8e956fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgI9rD5cTrWXO13OYUwCXUZfXHcV+9kKO3bahNkjdmVNqxvhO46+Aw4L9FPi/OPx3JW8ILgnNf/ujhq27rgXF224coyCUNtGvpW4I7p8GIjfeQGx0evJDaCmu+THbvxzTYpAGq8keMwoP+2QFfcoUAdArEwjw+y4o8hL3LOCqEwWG7z4lQa8w74IgFu9P1Bcgm6tf8/Rr54EizgkvcurCQVybDo6ea6wuLFxnQivjZdNmA4ygY/f09VTREdpYhS+MU4rcIeJYekgcncEhzEb1cwtHgj2YJ+iIRTMBpi6Sy2q4AYPuSLCUslBWLLreQisXLYJ6Ey/GWWSDOIB3V2HU0Oy6mLRIQ7nCTCMjM1theccTVSq/qa143+AmRn84OmPJ8hQ7wvIdNd5kNbL6ZrRP7CgU3urlvbgY1o3QZEYEzVSQboldsByPhUa+k4V5OFaLWbWOOT8qNNDWy+vChuYDZGzlHcsw3Fvtmze0go7ojqvU5k5kVqO3qA53lfPcMvd0WWzMMqGnl+C+GL4961HqhR+0yzZaipY2cyBcbkCQu844vXlQpc19HDbMF+Vz6T6ae4/9BL249DPivQE8DZGrJ53jeSRFWrXU5SeJGX0e+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199021)(6486002)(478600001)(66946007)(2616005)(38100700002)(6512007)(8936002)(5660300002)(41300700001)(4326008)(66476007)(66556008)(316002)(8676002)(6916009)(186003)(6666004)(6506007)(86362001)(44832011)(2906002)(558084003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8K5hgkJ8BF/hhi3vXTnZLeeH5tiWKCowjN5OBR4kWGmTn0EZNfkjYEuZaSzA?=
 =?us-ascii?Q?U1XfRDrQ2tEeCPBmYXmYCh9IdL0fdRLVsFw3VOWRX+ndbEyOU1vmvVfzkTIt?=
 =?us-ascii?Q?lTnb9m+Lp3wt8UVkqa0ei23P/OsJkU2SbiEfMOGGCAlEABg19oaO9mtD43Z+?=
 =?us-ascii?Q?HEIzvSX8pvWHCk+5pnvRi7StuRilmqHoRLc7O6/JkhawBQeJjXpf4K+GUiJm?=
 =?us-ascii?Q?kNUNcPo3HIeMq3Izaf1BWx1p4bvMDTnUA8a//QH2ySiGwnH2I40khZjG4ZM4?=
 =?us-ascii?Q?QSvI7e29d6uWxatVc1aYsoMqM5AMh/galIuM8+x5u4CDXTMpnmb1Qcg09Dyb?=
 =?us-ascii?Q?ZzN3XPOF8BHfwj2Rz3QMR2EwD7HxGqsLhgRTf3o9e8SJf7H0TrG/kT7xrDGd?=
 =?us-ascii?Q?JDn/I9hHOeIeRBt/8CRV0HjQBOyd+41jbgZJdnLCMyeKhtrp+0AvLalm/TKS?=
 =?us-ascii?Q?nXgfMglXLEeNsqnQzM6M3VkysICQYGTL3tXt/hFl1l/ScOndDG60FRHS2S7T?=
 =?us-ascii?Q?tSHETozCX+2qi/91scHsL/5ptg1ijuAD2bTjQrBGkICY5uI+QT2/fM2YsoIL?=
 =?us-ascii?Q?CqbOO1GD/AJZcLMaHCeQt3pfYAfwucLyNib/E3FMmt/wt2jMDtSUYrNfjWdX?=
 =?us-ascii?Q?IMsOg+jhSti6CvuD8GlxAbLJigGISBVxWotfuEvOtDQ0LBYzWk6phn/OVI7R?=
 =?us-ascii?Q?p2ck+xpsAKdB2kspn7PGfmB22vvcAS3Dgx6ldh5fP1H4WLLL+yEicOZEfqH1?=
 =?us-ascii?Q?cY9M1nH1lFEg14/rE3Ld8Usq+WO/yrRLajhMIcpnxGhxwpJg413RQ7C/TwUL?=
 =?us-ascii?Q?QIchTg43Mng7igxI4lxAg64vko/q7U/jvnAtb/UDo+//RNv9ySQ9NG7hxGU5?=
 =?us-ascii?Q?dT0E2HOGaHHxeiJ7Th6WEXz3cxFCRb0rdsjFL2rjWkPg7PLKjVzZOnMS3iJi?=
 =?us-ascii?Q?sX20KNg6RzYzNeVWOHT5ArYhJvYSd2wJA4e9BUidg+CFWJSWHTJDZYL+Mdap?=
 =?us-ascii?Q?Ion975hKYg9fssVLRUbQlbMZ8y+bO4X60nj3u6bmfm9WTsq5UTzuySh4K7nQ?=
 =?us-ascii?Q?k9goJS4QHGiaHaktMNoi0tCICXCDuOLSdpOzY//tTsyWlMpuGzksdGaV9Nzp?=
 =?us-ascii?Q?jM5lKw1Yrf8QhY2N6HXY0el+UCVpWbrsokaUAedxd4VILLUy8kb1lBE+LoQ/?=
 =?us-ascii?Q?PrSLodmMFYHfNBGOjTA5K4PD/8KJJ2XM7nVJyFcgoiDPTEUnEzZapPJMSoZA?=
 =?us-ascii?Q?WWmW87hwTVzq14BFxqvObBiOefAO0DoUNQQQq/pNqEsrzKOIU43nUOivuXY+?=
 =?us-ascii?Q?GVe9qZY++OwS3xaZjTjJjANlZxvjuPt9oxrIfLs0WUQ9RnYMBgQLoQnXHZ2U?=
 =?us-ascii?Q?iq/ElAIuoJ9H6m2mQLZc7bxL+uBe9Mg5Xh5EU2bR1GQTcNx5U/HlkttXgk0m?=
 =?us-ascii?Q?DxcESgH+CVwIpCqxkyDYlfRSvPVESl7VCRIjAjGQy/y7OWIwQbtx+3ybGnhy?=
 =?us-ascii?Q?3ay4Qszlib6dkc3eBw46kcxlTuzbHhzqHaVFOSatwTgzXj0CgNTLdQZwap4U?=
 =?us-ascii?Q?/Cp8pfoxbW/n1Pq9i6XTWzvVM1HPspQmc61S1RKll8Io8aPqV1pQs3R0BU82?=
 =?us-ascii?Q?lALATT5WSyKfzCiusdBheTEseGM4SLRSL18rqIeBDYQZZg3DnaP1jh1a0ogX?=
 =?us-ascii?Q?ArBWRQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388253e7-035f-4b71-55a3-08db8e956fc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:34:28.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stshL6Y3EUlF89JR3S1rjeitNaXc089NWNFfX4JEeonvTM3E4+GFU1PIH25I/lcnaVFIwY1tDBBkpnDSHyzWAPBl7ZzbYtWGttBPKlqUvyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3761
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:37:15PM +0800, YueHaibing wrote:
> This is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

