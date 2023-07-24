Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212D75F9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGXO2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGXO2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:28:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC0A4;
        Mon, 24 Jul 2023 07:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2Kb+P9VJl0vEwKAm0Lni7zYTGN6fAh49P2U7xAoroMfdC6+7BNjXBn9Djxuu3Nerl7ZIy9SVxqVU0NXB06OeUd+y/ssX/gfgbJBcyOG6/hHOgsyURfW51bo4wpGR0+PuinkUAVePKjBM7et5D2C84jCX+E0oK0r+EKvuc55RJEpgpPWyRFD3uM9ahLAJmvtl19CTfyin7cPj6IpnLyAcds0ie2SVMm/bmWgAJ6CttaGxVyxrFWkSOflGw2tgFs42sxiqdGmAWnYAy/5uB3oXDnd/SqQOjUeKIx5Siva2z9mJhNcF8rLg4PLYfuqGMajtXfMP9oMUfcYF3uk4rlG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyOgDoN1xxs9FWEXRHGJq6XTdrxTXxyn0hX1IyjlzYk=;
 b=ZYi8Fg9gq4J+wbEX6JZ0A429ZL9b8RZRoFgRhL5MyOjZatKpbLd7KNsvVOqQV3evq6VIBtoLPViP1plHtSP30qD3FdINLq+rL1uUuaviSMIoqXgyPgQH58tkRDReVZKkL8OtEB8tWbmJuq7K56CAazjTdQ2POS/Q7hnDlLppCkGVpcDKQcQ1e5v7eBtYv2PPebGbt/l0YB1QoWzbTEgvp6YB6W3hLG19AfofGncTFDwpCVrSOMAQG4RoM3eqt99yPl464/JmmEvRb5CAP2LWfIzFR4pMUE7O8v2JBseVG4y2SX8nc6nnp0T6JqY/qZQdg5K0K+9je6Y0nZpa19/Pow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyOgDoN1xxs9FWEXRHGJq6XTdrxTXxyn0hX1IyjlzYk=;
 b=fYDCV/pPcaNusLxPR7zWrMaI+4Js8FvLAb0pAsnnXMVQ/rP7BabD0aSIg2EBtW0nmtchGFeC3eSzehXalN5sr4Npp97H3ShFwZ9DzMNdPb0zIr77qKgvNVh9uTTFFuycQlTU6EuIgwAusyRYEel7Md9nwe06kMYT7628Bhrxx8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5602.namprd13.prod.outlook.com (2603:10b6:303:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 14:28:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:28:08 +0000
Date:   Mon, 24 Jul 2023 16:28:02 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
        Petr Mladek <pmladek@suse.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] netconsole: Use kstrtobool() instead of
 kstrtoint()
Message-ID: <ZL6KcmKWCI3BtfUn@corigine.com>
References: <20230721092146.4036622-1-leitao@debian.org>
 <20230721092146.4036622-2-leitao@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721092146.4036622-2-leitao@debian.org>
X-ClientProxiedBy: AS4PR10CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0497af62-ec42-4fc9-7cdf-08db8c523374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rKT8CBz4hRA9SgmrV1kzy7o1YiU4+Kz+gSDBllrRuGnxlF5l7ZYhWdem1XvHFSKJZagVqtN61rF8IZ591aw3vx65g8v7UMJI9iUCngaPDmX7hkq3RqAg04hHMM6cx4/clm7DM4FyczG4g8Jt8NjW8V4a+ccQfm+l1QCM90D+E9l2oSRkFFvhMIboI5cC5Ki2IvPfnIJF/o1fyuOKa9CjCgq0mUEFx8qO9vVfVnHVWhvguAaAUZfcHeiCx8yFnq483sQq05F5SIc3URYdzlYHTG0WpLEoUuJ3jw9YPzjqhtqgZV2Bw+1OwP/sf13tN91OTiuZL0np0oWA2HDtCEH4ke69nLdW4vIR032MHiBZqz53foZ99LRCL+dEl8CXNmDBpsgECk/j8CEnwyBuwejPGKFaLuDucMRwEte8QF2MbQY+70iz1qwRw5mWQPws4KlXHXGRrOJcWnj4MigodTF5pj2ZDmbYtq/iEAJFdu2gCMTIw6YCNnsGlSZCABAUMooLAXkFfzg7D1HEx7Ji+FIa/9vIUM3MEDYg/HCfZpMBuKkJTPPoWsP153q1/fS5OXYsg8bxl6HFCbcVugL/SOz4X6vPonbWYjAvb95fWRB4mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(451199021)(6486002)(6512007)(478600001)(6666004)(54906003)(86362001)(44832011)(4744005)(2906002)(186003)(2616005)(6506007)(66556008)(36756003)(38100700002)(66476007)(6916009)(4326008)(66946007)(41300700001)(8676002)(8936002)(316002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dE/vTOLLY2yhojdKmMVnzzZDFixGDF9cXVYW+pXO4cruv4iWNs0i2Duod0GP?=
 =?us-ascii?Q?xmTFx1XjbV6uPo10o+gIn4X40CWKM/r+Us2ks/5BABSDY4fL7KPcWTCktXh0?=
 =?us-ascii?Q?t5KO3dVULqUDynG0aK6pMKupqWefLJnWguqhRdgmnar+H62x1m+WIkn1Yrqs?=
 =?us-ascii?Q?FAHUIu6fvadgys/r/zOUVJFVSxKYnqVvkjGpgVpGFyBVCas0T85Gr/xzH8cO?=
 =?us-ascii?Q?cJGcAwo/uhYWJuO4f4mUk8w77+KBVkJYpnCNUsRAcb3JB07s/GuMkU1+Mtwo?=
 =?us-ascii?Q?LgD8xVm2gt3VolUfIWa34N9ICXm5zqruuTqzqPTbXLGdZCmHzQTOziHrL/eB?=
 =?us-ascii?Q?L6R0eqAAESvs4eqQ2BN6UQczOLGFeTIESG95JRkhs4LuWpWfhmSA4JyQRZgb?=
 =?us-ascii?Q?szxi593NL6Q8nixJc5+0+GKqGM6FmieORqBe0npK9ZxPfvlezMKLBFvj/Mop?=
 =?us-ascii?Q?mrrYePH1Krjld3EVAFwGLXfaVL5HrJRztM4CROp+ufZ9GuZq/3gaQ/EDobHF?=
 =?us-ascii?Q?b4PvxROfsqoEnSVY0NmEytXWWZJO4g1Q0ezkDZY5ysI59nMKltPLHlB5Qrpj?=
 =?us-ascii?Q?u+AsPpTB9bsCE8Rxh4PTC7Y2f4qlR47zojBHMEo4P8Tzs6RJAXBbIzUs3jBO?=
 =?us-ascii?Q?l+qjV/rw7Atd+gWRZd74Li3w4+bCpvcdLy1P2eIoThcPAqjiRawBY/M9qN+R?=
 =?us-ascii?Q?gM7bTBs0pWXf22E+AQz7uMGOoF+zJdmrJZkjqVglJ8eO7KD0IkvUpQVmMmtz?=
 =?us-ascii?Q?IvP6KtU0+tq6msmnSDteNMDCREBzUqngIOPz0z5xiwVxXbO9nOrAzd2nRXsw?=
 =?us-ascii?Q?19CeWECc4mTiqxoizdIwvVcRX2jp8M/q5dg4XZtcOdDSjLTTpJRcQcnzQ+2F?=
 =?us-ascii?Q?3nwoxyRcA/VQP/3LjYVM/oQfT/MtJl3cAU+ukfR7+Xo9GsbtQ5Bj2xNvkHJ2?=
 =?us-ascii?Q?f+f9dCeg+2rCkgYlz2UI+EfXV+zbSpHnmxLRWPnIF+q8YyB8idT3bs83V/NA?=
 =?us-ascii?Q?s/XcEFyh72rLcmLCUF75foStdS42YXgfuVlB19KKEB5FxTUni6HdkHGvBjUY?=
 =?us-ascii?Q?Z/PCE7xVO9egtFRju3UTmQlPUWtMsWT6RIMbYZUQuqa82WzY48igN7NwHw7N?=
 =?us-ascii?Q?+I9iR5j9YZrTlAUWvUvehfbREuBQEt6Vi8A3zCj1nQuPvEV23j5m66ZUn7WA?=
 =?us-ascii?Q?IqhsXgkQmcRXDzk2ThtbtQ/JfM+LbYOuI49HAxNVR2ppXBXeNtbHHpRvFHEx?=
 =?us-ascii?Q?UEUxud9kt97mzS2VaOsGr2rvpMnvYikGv8XScgHCPyM2zIzDyjsD189/QiFx?=
 =?us-ascii?Q?wNynRAO80lS/co9MbQuJWY3I0ZRJYoSR89oGJkQbB9OrAoSgdZxIG55JPSXX?=
 =?us-ascii?Q?42+Dg2/5x8HUzPZh/CbGBGYai5CyztXGc4F4BVoyeeb8ygvZsnc1as1Qi0ZA?=
 =?us-ascii?Q?uPLE46KARqF+OPzAxRSEvT/wThCRXxd7+MHtDaKLXfzt4oxDoSH1IlnH3p0F?=
 =?us-ascii?Q?8Nb9t6QPKyrg9ddk4o2IZPLUhboPAqiGjOmm+0jHnK7DE9d5qPnzR3H3QOND?=
 =?us-ascii?Q?YcMQ/6jeeFN67WibD3RvcrQJphC0gkwkrc4jy6Ws0s7ZHgckwTkjV8Ddrdkd?=
 =?us-ascii?Q?30XwpLpH4MWWhjg+ImC6ab41vSjKSBk34vl47ew8lymjAQwZdZP1q8mITCTg?=
 =?us-ascii?Q?kDusng=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0497af62-ec42-4fc9-7cdf-08db8c523374
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:28:08.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5w1nM2rXzgypual5wAA6dFmBdWt1T13u93B6FS5zwItTv1GWOJUxEVryQ5UUbexr9x/Xk+Vo1qsOPFvfhaVaFC73+m7SpC6TpXmhyCc9gOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5602
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:21:45AM -0700, Breno Leitao wrote:
> Replace kstrtoint() by kstrtobool() in the sysfs _store() functions.
> This improves the user usability and simplify the code.
> 
> With this fix, it is now possible to use [YyNn] to set and unset a
> feature. Old behaviour is still unchanged.
> 
> kstrtobool() is also safer and doesn't need the extra validation that
> is required when converting a string to bool (end field in the struct),
> which makes the code simpler.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

