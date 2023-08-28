Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4078B83B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjH1TZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjH1TZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:25:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDC11B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLlLty/e6W6shEj1MCqunBiNbgwfmeMPmbcGd3yVHfpDJOecs+BZ1JbysNOlYtDgIKsheuPA3Jl2BsfJ/bnEico3TO4u0L6BOsh35wuHASpSZlzgoPSb1uXmuTqCTOQgxQeHgKctWarxX9RUoF0e1n1iESqz3WfRoHqljrw8uBA81BQaTB/44vGXE4b7/2Bm2QMrzduIIQ9jYLvcZfo33InXIVtG2r8FMZx3CtK78dw+0dxKE8Sf0RFjnKWun/zWGtiBc5tUoy1OnyNnaeHrYwy9xjbF1friZ491XCyivvq2fWZnOnia9KURpruEEpIUxgXgvHRihnbOJUIjvayQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzgWTGxreWwyCNHEV/vYS77lUOa48jaC+9zSYxnSbJA=;
 b=HDlDtL0w8o5rMRsZ0sKXE56EMOXMZS+uyx3v/jASRctNMFLxKhtqmUecS5QNBN8QpBnuXb+dKJTEhRRhZpSgsXZUcwaeIJrOYvXkOUFVkC4P6z9Yf6jITws4gvwvyUTRyYkN1nNXkNJP0hitY26vhRJ7z+QdHkuPuwx8nyNLIPwf0qQJuts7AXm4zEesOT6/IWbpOpiMO5GSVPcDFTY0sbn8+gdW+au9ppXbrVEUn/PHE7HN684diNFWvF45EHtxxa3GWBRDlBWfsSeVgqkKgNP3RaRCBIPhlVJsqcq0tfOUDqUCTFT5AkYis5vfKCFHxQ7mKRuiM75BsCxoSzCx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzgWTGxreWwyCNHEV/vYS77lUOa48jaC+9zSYxnSbJA=;
 b=SAgVI8d4z7fC6ao20mh/ryAqPSRrycFDU8QQwLwjdHVlNwo2Y1jgg2PlH8isWKEMhpG4rpLXyfUmaKB1Os6a+0ZiuqhFJPSPmrcwrdqrRJrgt6+G3BeVKZxhMcaXi+jRJii0PgmlYZAZhbf0jHBvCWu14VLL9G3WqskSZ9pZJ0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7462.eurprd04.prod.outlook.com (2603:10a6:10:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:25:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:25:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i3c@lists.infradead.org (moderated list:I3C SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/2] i3c: master: fixes i3c bus driver probe failure if no i3c device attached
Date:   Mon, 28 Aug 2023 15:25:01 -0400
Message-Id: <20230828192502.3525418-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0067.namprd08.prod.outlook.com
 (2603:10b6:a03:117::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c8b3ef-86f7-4920-a3de-08dba7fc84a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lqh5Sxu6Ntxh6M8eMT3tWHiF1fr6PRTQALdU4GGao83Zu5N5aJDOV8RhosQFvzoRi0BH+U9Uwtk+fT2f2UhpXg6QKAT9FgxKbDVaqiZx74QpZjeZZglOcOJ2EAKZHnT+c0f01RejrIDYVNLxCruhSM8qndJWJ5Gy2tApzJSVHyfwZiPc4OtpRW3R165IVc1cESk2xku74w7VsksKqJTie1lCULWCiubaU8Ok4Fujogi0d87cGqTDuwc0RboUI/cuAk9EfMmpH4yZvFDZ3reIDRcLk1elU8Iy918EIQb+9/F/2Ts6i1Q5E7nFURo6H6plCDl48AqfYOXkz6k0onOYvCNU7ZTkIoB+5gPdPx6nhQT6SFMUE+6xEJlQjf4vTsBypASiqXqjVBGrleWQHJrnkuQZT+SsY3V8D1N1SucizyrJBJRE5L8ov0QXRgmTogRWgPJ5ksrtoVUd4OJ+ECLqV7YKxm0TVERzcVu9Mq19IHNUxFyWnqPvG0V18KtsceEfzZgXKhJcrKSsmmV+PRc2zUzJ6ViGJZQQ9uzDYeQ8czR23aYwhQ51HQi8NMGd6szRZcI2iXNPQyH0wSlNOVE8VnA4/baL0ujNxFhVuXnuMo/+dSjgpUUS2d9ndchAjcZXLzjIR+sIIukRVTPgxngXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(6666004)(6506007)(6486002)(86362001)(36756003)(26005)(1076003)(2616005)(52116002)(83380400001)(6512007)(316002)(5660300002)(110136005)(38350700002)(66556008)(66946007)(38100700002)(66476007)(41300700001)(2906002)(478600001)(8936002)(4744005)(8676002)(4326008)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1f74kCU48yZNM/txkVkG1hqXYTwHkoOCCw2KlhJqBVCYQnqbl75telTFhwh?=
 =?us-ascii?Q?JOxpBn2Bb/TqkApMN8QnpUVID8wJ0vmItFPYv8ejtjULSKp8TTYss+f/Wz5L?=
 =?us-ascii?Q?q3jT6KyOycIxhOq8cCcX8HB/zK09Y1NzBwDrhrXE/hOFaEBqN6jMeO7g+7qg?=
 =?us-ascii?Q?e0xYddSH/wlRasEe4Co5vZ2KiR55It5stm2dBN6nCma7rEqPHjo8A2Y/QF5w?=
 =?us-ascii?Q?I2HdjTiZut8O+Qen9FUUXzRJxSIZMc20E4yEiYyc0wLPuhVqTkBrM1ErQbxv?=
 =?us-ascii?Q?UiObsRI1/KfNcYKiwPRxyGxgLN60EsIZomKaPE3KR0hWsWOTitlrb4edJCYA?=
 =?us-ascii?Q?IrBM3lbxNvr4GJ/C+cNbea9qI7jJqTB2FCX4jyFajFxES8tfSb3Bb5psMG06?=
 =?us-ascii?Q?+ghhcHcMs6eKBAbFLqyOnnsOKDCPYLHNW9xHT3GEnWi9h0bAsxVs15Jo+cWR?=
 =?us-ascii?Q?m4NEJwF3uoEnen+COVWpX/ZYBc5bW7JBNHo70488LanCNoeNbj6NXHsZGfd4?=
 =?us-ascii?Q?VYSdKrKD1353YwcUdTtyOBq/Nfo8ZY67SfqfFlCMPdOwoujf4aDDavE8ijG3?=
 =?us-ascii?Q?9Ptlao944fKgKfr2WA5IxR1HmcIEGbs1GyjkwXPpm6GhwSCKJ3RLoIXN2xgG?=
 =?us-ascii?Q?DZPVmcviPiBIARNlOaniNgMR47+HGW6ao9GDro61wit3FH/t7aJ0/coKGctI?=
 =?us-ascii?Q?+pbqHXGxtdbQ3vOk9G2L9TUnllB86cGVj5bnoljH/PbUwe/N8Q0+VRbAJMkq?=
 =?us-ascii?Q?TD3lhP4yQa3kRRiCNg/bx052QFByyQ3ofaqOKf1MVQrjKGgAjZK2clgpBSTs?=
 =?us-ascii?Q?/6xibHq6vcGN8gaD+m9MJMGjTGOJiAQ0wJAnvlvJ4Zb5vfuKEQmax/TpdaWQ?=
 =?us-ascii?Q?ecPMoLETxsxE/WDdoXvzSOUv4MboIdafcmiE6ROrXm8KcgjpSmSDrG43hImc?=
 =?us-ascii?Q?35S3KQCgrXewQO2QtINn2F3+uVul5oFsj7Dr4phIL6H5N86O1WzUBw7mLMWe?=
 =?us-ascii?Q?4f4PLhgmf+5tWIG+BntQIvOcPz96RofCOfkTobMHIgpM3tkqFArulDfRYCzJ?=
 =?us-ascii?Q?yYP4kLVOZqR4G6hhchjkO0z1I4XeerDJI733m32Sr17CeDyrPMV9VNsuH8vw?=
 =?us-ascii?Q?dZQ/7jcq7faoXo1/kyvpXM/8Tq592j74IFX9UFKO31qznOHqwasL7lRwZAVW?=
 =?us-ascii?Q?zLcSSfM6NSE7rnaZacHXHQnwiH8qZi3hmlLwsvPZQfIyOv4W+66hx5cixuIH?=
 =?us-ascii?Q?4QwOKMpwlDQw54yWhpLFlg/IxTh+bK2he8LT7ocznRRO/DbYSmRWmu2JcSy2?=
 =?us-ascii?Q?BdYh30G0/zf08uW6x9sggoqXO28gqDOXb8MdUDyrZw6kQuQNVBdx6ueCxNPu?=
 =?us-ascii?Q?I2O00/0OC5+6dC7V8g9r+wZ7bir8lGB5LiDV1w//DzCwApyWXxBXNxV1Ngek?=
 =?us-ascii?Q?1F9uP1B2m9/pfRnOgZQVvGjimVlARdbmvYJmRXufi9K2zvMHVU345GeKmuC0?=
 =?us-ascii?Q?Z8OHvqn2kXkgpgn9eh0Cm/yKWWtwCwLtgfsHp0gFST13O9ZFrZVxu08oW9vX?=
 =?us-ascii?Q?+dBLUPCGl+qbsU1VWsU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c8b3ef-86f7-4920-a3de-08dba7fc84a3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:25:20.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+9/ywk3fumcc12ocvo2HYUFZAaZGoXKGxzMIFn008/n0Wcg4ugQjSoCoXCPiqcxvha/wA2GMRujKkR1YjAmqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In i3c_master_bus_init()
{	...
	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
	if (ret && ret != I3C_ERROR_M2)
			  ^^^ // it is enum i3c_error_code
	...
}

In dw-i3c-master.c implementation:
dw_i3c_ccc_set()
{	...
	ret = xfer->ret;
	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
		ccc->err = I3C_ERROR_M2;

	dw_i3c_master_free_xfer(xfer);

	return ret;
}

Return enum i3c_error_code when error happen in i3c_master_rstdaa_locked().

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a78003..00a82f3ab9ac0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -783,6 +783,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.34.1

