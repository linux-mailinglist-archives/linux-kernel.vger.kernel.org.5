Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01DD751DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjGMJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjGMJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:58:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82026B2;
        Thu, 13 Jul 2023 02:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTBaBBAehK6G/wlwIdxMUaLazRHoq1SddUQjuDVQjlHEt/QwG/MCvO9c3IQpUYCxojAhb7EPxARlSVK9S0BAHqsbieAVNAejt2S3HUuJy4Oqc0Lbrrhg1a/Np0tlKY/+FPd8O+Po/RO+tWD07078fo8B7ESBNTtNQ8nNl8IYBw8Yig+3GTkZSYJzd3+Y2c3hGs1hjHJLQMhV6+0wPuKFHViZ26Mr3ynUq6b55wY6adOIcvbC1VTwHOKqAdpInxHHef/HwvT9cT6PBS08vn4YWrzoLIf+ddFQBzFqLAcCP0JEtgZcH1gz3t5KM6cgfkeZaIsbsCF8bZO2NFnogmsrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRTDiqmdCfToqvdPWTbRjeqf7lir1cK26jDv5B73a/c=;
 b=PPp70zqQWg776PExdbtRKXt1EA+fh+xEulZLN8jLXN0GkdOShOxrt7Os2kA5JaIw42+8++uERY2kXXXaN8L0qve1j4gvjwqvAqEKUOK3YBWEJb+Q1o43Ha+V+eFlvRRx2A+h3AAS77SFAXuriFpvhGXwNh9PJ3R7w8Y7LBaHuIxo1GCu1O+q1u+f5dnE4d8zyqafR0378WIBL0WvtDg6+b5V34ji5D2tp6l12yaBQqPjxmoQvENV6p2KXpMRv+kL5GIcjLGPv9zDJGesM/E9ZedZuXkQ3JzFP6lwuXNLwiCT+xjfI1bsmNLHJtvwVpylXXvg1/Ugcphrmwkr8igVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRTDiqmdCfToqvdPWTbRjeqf7lir1cK26jDv5B73a/c=;
 b=l9Wu42ENAOeo7osur5h2aty8JJa2+V8WY/QMvTG2NkDY04t98IGraLARnvjAc8UQ4j5S/Lkk6P8MAcxfctGynO+v35D59OU4nTO07IPSMrxn/DU7MIUggLnYAUQqi+TEbTMe/1fbtpMB6DAbgHl7EjjY4bzrdQWQ/GofI4AzGYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 09:57:53 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:57:53 +0000
Date:   Thu, 13 Jul 2023 10:57:46 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com
Subject: Re: [PATCH RFC/RFT net-next 2/3] net: stmmac: dwmac-qcom-ethqos: Use
 max frequency for clk_ptp_ref
Message-ID: <ZK/KmtfDPE9iMlO0@corigine.com>
References: <20230711205732.364954-1-ahalaney@redhat.com>
 <20230711205732.364954-3-ahalaney@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711205732.364954-3-ahalaney@redhat.com>
X-ClientProxiedBy: LO4P123CA0355.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: a9890963-3345-4040-f26e-08db8387a037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcW+vNpn5PwBHm/hXyB/cpDHD1w0Gad02hwri//XrjF3/qm+02faEL1IfVRd2In/UmN6JlUFnLiH0zxeT74zd+bvBqLJ6EbE5FQgFgpkKkWGpc/EUYQWwD9sVgPQsxtdqI1gQxAfZxpNkzw3VBaMqZsYbv/mwMsRei4ueKJLDgv0VUcRl4OVjJ1v/hBHRIyXfERR18idaHHgiKhzcLHHDRWkxYW+LW+KWOgIQvYdHionAkbxqkLIu3CAEERknF5Jp4DIxUmFnvCHYOE00L1ekLp9GYTvWppVhfuH5ZVvdPcqVcEb/zGive5YnIcknXc/LWrSKOGBWb45Stu1Apbpq+7Ct10fzTWpm5+wpHiNGtjHwOmMcRCaiL8+aH4Y0AynPqyzgEw8PJmQSSpyL5HvpuCXl/1JWT5C0xQ4qUDUpHsBcidiY5NxKaxgqw/kDwbNGwF8LLc8cW329gnzS2rryK1sVAxrrrSCM38o73ZxaAWA3BMqDYtxFnmA4nzrRc8HzmTaytzb4Tht4FCDrXgOteX2y8l5VJcG+VQpIC/M44wWvQoXKq+8zNbDw84SlwZFZL9czHw9FTUbfBkYoVaVPJ4R5vEHvZgmYLEIpc1ycq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39840400004)(346002)(376002)(366004)(451199021)(38100700002)(478600001)(4326008)(6666004)(86362001)(6916009)(6486002)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(4744005)(36756003)(8936002)(8676002)(44832011)(26005)(7416002)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZsqMNPIbbfzDFhd1gqQ8MnNAuUgpjqvl4qFnvEfBJHo+NfIHL0ihyXXiPvf?=
 =?us-ascii?Q?jz03tsnTA3OSjrUgcTTdvkR6hNfsEmHAcQuqBF79288t8k2sB8m3EAoYNi+I?=
 =?us-ascii?Q?9Wk+mYnqve+dgO+nzILcrHnc/P+VRS3/XBDPtX9hjjVA50HuPc71BBcOy07M?=
 =?us-ascii?Q?ZtmPBSFWELg5om32BzfRAkWMjsmke3134pKQ9rNkhomS5IzrWo8pomEqxume?=
 =?us-ascii?Q?+5d4MocSKNWHzAjOx+fzucpoatq98hIDHwvvCmHIk1MCFr9sMkXN5ul5Dhpa?=
 =?us-ascii?Q?/CybIsTaxuOGnx+RodhAJLQ37pexYGiRKTkvFyFtSoTTeB7eyAZxp9gfzVfb?=
 =?us-ascii?Q?sWPs5hn9g5O3jXACpTomAQ43m10pKM7c8IF52e9n18Taz6PT3dEh+LglGA3M?=
 =?us-ascii?Q?A2hWIEL+2D5yUiA75GrFnfL2HtVP26NGQLwjt4cGMwsOOWSoCd+w7Nk+THSw?=
 =?us-ascii?Q?YCPtMpHExXvwfpRTWUuUtlRRb5v9d1RUpNDcpXVw6j3nIBI8bqfrTHcGMoeL?=
 =?us-ascii?Q?bXThTFIqofe05gyZKtkNFaLAOoVe6TVS75gg7cAN5vU0sOS1BTZhCXVXc2yZ?=
 =?us-ascii?Q?nlG16W4qysFb7RGXSCi0Vmlh1/DfSTv1wsx/ozHezgP0QzpXOywzl0uOexnM?=
 =?us-ascii?Q?8PCnEWcF8Ug1tAYzM7ex5XRdTldCO4do33DT6bFk1o3/sJYMwJWdDO/A4ldl?=
 =?us-ascii?Q?cuVa3W2lTb58MG5mjMCKv4rqJjrx6CzUZew6+XxJYlapcLLRWPredQpIleig?=
 =?us-ascii?Q?TfyJD5Oj+fX3+WyXNk3NrV0t7Hke8Pb0jc+aUHIkvjOY+NIj11ksJwFvcPeI?=
 =?us-ascii?Q?Syn8quToFnnjF+qAle8t4fUdHXQLUaO8dnqq1qaCkPas6HiXLxB5CWH4Ukpm?=
 =?us-ascii?Q?v6ONDFWecLcIE9gkD8dPIms93CNo5e4OSTB0wbiO+WK6My6KVMP/TsBFB703?=
 =?us-ascii?Q?0E2eCK9c62FzLrLyP4+6wk5yKH0uf7NE1uB/FJVmQaeKoZSXxNJ/Xs6dVlos?=
 =?us-ascii?Q?AQz+2F3kUA5+/fdOAcVBAkHqLno54hmoEISuwwJvD9EQkjsB8gkYrMs3oBEb?=
 =?us-ascii?Q?tegTm67siDYi7YdhIL8q6cJm2RQgvBPWeD6Yg/ibGWId5ETPV832gmxVLgYM?=
 =?us-ascii?Q?0VRtQI3xRTvF7BMFZkFY6Y9Kgb3QFhVb7HS+i2Z8cvTknKrJR+ZCUF//8MPf?=
 =?us-ascii?Q?Wx2hWPUkapLTnKkZ2my3h2fd8h4aAJR1cNEy/OeWtnRoiJbWL4z42H6k9f5F?=
 =?us-ascii?Q?0/sqCcaE5y7kxDjdp7MXUoixtg536z55Fq85bK9e+3zdGjaJGQZAu+F19zmL?=
 =?us-ascii?Q?ZrIAwqXZ4za54E+FPSO+hJpsL/t80Z0QTErmqNpM1QYUXnF8Jx+onqFeZ5rz?=
 =?us-ascii?Q?EO2sKXzzijfFnnOXIppDbi7CTzl3uczZ6C5Zo12sZpK5iHNZ7+KQQEg41nNH?=
 =?us-ascii?Q?pSOMdRkvpMB7wV0UiCHXIiwGLgPJt+3lvrRM6/tXmAOBzwow8+Lyb2rVjdiR?=
 =?us-ascii?Q?v9avz4z3NT56IfW1KXaBRBr4f5NCR3eNN7wGO/jZwFcUQJ0tDa6L6rL7Y7ym?=
 =?us-ascii?Q?abcBu6kUQrPs+qafaIH+QG+JWQYtqIY9/TUs3uc9E+9Q8cOoZ39hMpKU2hvB?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9890963-3345-4040-f26e-08db8387a037
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:57:53.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJ3qaQrAhuokG1GLeY7CTzfmJbZIIW5AGxL+dNYIRa9xIuLcfxiEyE5zmXkmMx/S3mkeLKLO4ZR6RE4+8qdzy8UZhDQ1pEuD9jZc0ziYHRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:35:31PM -0500, Andrew Halaney wrote:
> Qualcomm clocks can set their frequency to a variety of levels
> generally. Let's use the max for clk_ptp_ref to ensure the best
> timestamping resolution possible.
> 
> Without this, the default value of the clock is used. For sa8775p-ride
> this is 19.2 MHz, far less than the 230.4 MHz possible.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
