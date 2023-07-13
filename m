Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE1751DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjGMJ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjGMJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:56:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2106.outbound.protection.outlook.com [40.107.220.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE61995;
        Thu, 13 Jul 2023 02:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L69HZFuZqO8Gne8/ihyqHrb7/0G5b+YUWOX0hV0m2LyOfYuZttYpMyEElWqT6PcQvgDMfvPVKdZKSaeFDuWpJx5OO9HZw1amp9sy5nv7VnYH/tjJyn2FbmUg+++LhuBO9W3KPmkTsrV6bGAvtvJe1drUg4WLUJEDOhr5yRdMkUggrIpMjOIbLmEu7NSZ7DoBuchUYvJt58BukBwlGbM5BU3KFw7Sl31BXPFPZCehn7nBzyTreZkts8mz1ROQPbksBaadT04CUicuR654lS/YvicvH7CIbs8PADDslDSchNesTrKH6pCPkmQLFa/Khb7PZn/XEWI2V82P5esIZurT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J4cXW2OdTPZ0vnkflTrBd+DZw5A8mw6NbxsHpeJ8hU=;
 b=SF4+8DgilK5XpmQ4j6rGdSfPW/Pdxl7V6X+2KaHFjTCQKUBYb9ACozwtcvy/Q1q8hVadHSA9fyc+B/JcthQgXo2iG4AvOdteI4FwvMi7mwdAOYTB56+jWyEV0FH61KyxxGamdH1U4q1SgYMOwXTIvs6pmbnRk+E99bJb43e44M515KS6Kna1w25WDkyc3b0g/QwwPo7CZB71hBVMjT8K9J/JPcLvYLwgOBM9LvixEPArZNKjwX2qmyRNQgUr+1R76sBGRpRTbrByIzHXDqTy42940tJSMFIsSVhxWYjBDVWhPTUJoiuQO3pWjFQG/oI/uyu5s5VC4p9J27kqCDRvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J4cXW2OdTPZ0vnkflTrBd+DZw5A8mw6NbxsHpeJ8hU=;
 b=kHxTgLgQ9HpuX0wExQerwr9fv4k1eMg5LYNpIEg34lw501ruFHiCxT4W4U1bnLeD2QwrwHszX4KZRsJBCkFb6jAxz11c5PVtX/zUvtjQ+e0mOJJ6G/mkousYhZnZGGfOiYdSUSAyHCaGjI9HazMQqFAaDPwyQUHWhFFwbTa1hJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4917.namprd13.prod.outlook.com (2603:10b6:303:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 09:56:39 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:56:39 +0000
Date:   Thu, 13 Jul 2023 10:56:29 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com
Subject: Re: [PATCH RFC/RFT net-next 1/3] net: stmmac: Make
 ptp_clk_freq_config variable type explicit
Message-ID: <ZK/KTU428rXUSLyD@corigine.com>
References: <20230711205732.364954-1-ahalaney@redhat.com>
 <20230711205732.364954-2-ahalaney@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711205732.364954-2-ahalaney@redhat.com>
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5a4fe6-d854-45ed-936f-08db83877396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cZEhWDHK7oAFJwbc0EL1CPCT5niTXdCDNhnaO+QcbP892TxEusYgKFD4ce3mr36Elo5iNFkA2fk2X+12Lq1AJP0Vu3UQ4bABL4mnljCSR/6lqtvLRqIV8M+NXAUE/WSbphXa6GFdnrU5rbUYrZ5FZweOTmLRXa7wOCTXr387kuB0fl5D/o0nMBQiABiWuQ17IZxnofeAfF3y1cWrYSSNlxZKXDWwVjAxTfuiLfK5pnccYRtHHlQOMh6JHlazKJRjIR9vjUXFh+iOeqgiZKaYFUIQfgaWVggJXGdbcK6bDE9RZPv+RsKkZkBHvg7+MJu+QvCznJRuutcOW9Up/YyXQq03pJZmyyXw/H43PodecAjthtG6oCogAgqAq2wk4F5c2qxFebhIw/7cJ8Gz0vEJBIarAGRVT2c6JaFfmAAOaPBKLrtwqOd1SeuvEmxHniUmAHmE2jYiHqyFpeY4aCHbDdP1uLAOQS6fdlWnlanT5HNltf/oh8cFtocrkSvxc4ctLJfPuSpziwMx7vvS9QQYkCUpOPj3kbWYJ5isuTOD8KMBG+ciYuifjWOXU7Y1i30TXruDxm9HECrXzC7Uu/ANxcPNoZim9nA00dvpSTTH/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(451199021)(86362001)(2906002)(4744005)(44832011)(8676002)(8936002)(2616005)(316002)(41300700001)(7416002)(5660300002)(38100700002)(66476007)(66556008)(36756003)(6916009)(66946007)(4326008)(186003)(6506007)(26005)(6512007)(478600001)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGXovC34QzjzkN6qz6L43jhKWQC+NM7q4pfy43PjQImuYD9riTcDfcM4FgYC?=
 =?us-ascii?Q?14k+Mo70XUs05HpYqOsYrQrKIATQ63u9W339bpHw36OgppzJluKllmSysWx6?=
 =?us-ascii?Q?5d81Vo5Se1VN36G/XqayDHp8+XVZ6Pr/u5qrUCiSoL3U/nwvc1X9mNeB1piI?=
 =?us-ascii?Q?M2WlGBJBfLXl6DEUSFKi3A6dovNjbx6vjaAxTDUv8bZOSXQykdUvhmaArHvY?=
 =?us-ascii?Q?1BDyf3M6xu7NYFaY//Arh+jdjE6mE7g0AoQrMgtr254ToLIzOTljh5Vfk11X?=
 =?us-ascii?Q?nLYb7M+ifu8oM0wNV6UNSCEZ8f6BHSxkF1rcHabBM8F22EEqFWie1gOKmnug?=
 =?us-ascii?Q?IuaygL5lLfrA1fN2z19BTL9XFqX05Rxm8kTfsMx2bP5/us7K4uqsCtyx3vcb?=
 =?us-ascii?Q?4BB0NzwgLuYeY+jK537x6C7Pcy9XkeiucyP+NlijisJ3+6vVtDL5ZEwYlj7M?=
 =?us-ascii?Q?mmE431/xYd3x3ra1/xIeaB9bNUtdsqgcSFQWsufh36DXx/BEGE+5604YqUvz?=
 =?us-ascii?Q?lQkdI3rTSPGiNx9qdXnaOYa3H/uCxGmM5GvSOWVShzk/ZHkzJ+oSR0Ty0i1O?=
 =?us-ascii?Q?vbM96M461sZJNWFxgLRW867N4y390oxBDjUlBPbo4xCyXZSy+IHO3H7gjxl6?=
 =?us-ascii?Q?+eqoOOVAJJk5qSEBQxfobuQ6yWOgADQBrByR84mLflGb78iWugiSvrhU/RUB?=
 =?us-ascii?Q?nbGirZ+KL1vBMIZsgqpf+rUfjVm+KON9VesmnDotnnSS3EPEFh9ByY8PrELf?=
 =?us-ascii?Q?LZjyjMpk4Pqmzgz51bXNTcWlgX65xGc4/bZMqOkiheJXGoNddA9zW/vbQt4l?=
 =?us-ascii?Q?3sY1uRmIDJlJ1oflIRjRJNWuD4RusCeMP08ni0cTnlmXliZBHmo679uaYeem?=
 =?us-ascii?Q?cF8QaOYKbhCuZVI2A64OJB7eVeyKRVZ5iaLywajju/xE4sy3JFLrXYCN+bDR?=
 =?us-ascii?Q?G3v4F1+xk4noUUI4rCMTLEyXcBMi7hKYQOfVGTUv7rNDrN5syTrM/f6dV4MK?=
 =?us-ascii?Q?YQ7WfoVQCP/+OJjjpwz54s8HxsdhLTFCsNjlkXhd9sCOJJhmgJlP6lNZQZhE?=
 =?us-ascii?Q?H+mrtx3+NTmSHkOREQDS3UzFKmCaeYr6wp+8LOXO6ePTFkfn6hkfV6+do5av?=
 =?us-ascii?Q?Kc2hSUQgjr/I15Y/6vroE/eFfzxVNnfsP+HdZK+utOUHDc/8oDxLhMtuGxPv?=
 =?us-ascii?Q?MWN5BPGs0xgFAFPYINmNNcL0jGZKf0/0Kza4nKzZWkGvMrRghp+qaCNk7RnY?=
 =?us-ascii?Q?FyqVRokvYBk0nSBRBYg6Fllxto/r8ONzzOng6UmcBIfpmKeDvlXmg5TLbjTd?=
 =?us-ascii?Q?UZEZSoFuh1BdJ8KQtIh3Hne2OAsxR/mzwE6osJgKrPcSKlNxnv4HxPPBNABk?=
 =?us-ascii?Q?a4XfPaGn4uIbUrw8TDFNEMRSelOBE29/bognElO7b/MUJ3Z5ykF2KaRjyxkj?=
 =?us-ascii?Q?XtDrxYotFHZJuUJulQxUjK/NOOtzz8fEzvAFHeDyzJZLfj+4uevErMO7Hd/g?=
 =?us-ascii?Q?+3zDyU16ub59n8ZRrfWPneXwFtRZ4F9n/4+f9+Y3hl3ZJkJnz6/eGQ8KBBv/?=
 =?us-ascii?Q?M6Nsb+pXjJeQNp/FygP4MeyUQxlg39Awk4TdVYxDFAmpS924pX+EYj4wgX1f?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5a4fe6-d854-45ed-936f-08db83877396
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:56:39.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEke8FQdpyLaQ1tls9aBjMRxlZ/ntvd+6pYbBmux+r36nn30igInntz0Si3kC+96L9z5kupwUC//CadNa3r376ieDdpav+V11un6NAojuLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4917
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:35:30PM -0500, Andrew Halaney wrote:
> The priv variable is _always_ of type (struct stmmac_priv *), so let's
> stop using (void *) since it isn't abstracting anything.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Very nice.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
