Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D177CE1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344760AbjJRPtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjJRPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:48:48 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C9A130
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGrhov8fI6zL8mWhSFC88UxAjsDKtPSeyQIhcFXsNu0fTn9Th/GwutiML7b2b0izNTrRvjnHoRNy3dwmPrtw7liZuve4wOzSstPm45fWg0iWtch57UyyHC7K9+MKjE/bB+0Qg/D1ZwAcp7FcCn/Q3z7BhDVfUnr+ZYkCsE58mnUx8fMbvh5OgbPYkGNN780JAFjrEwovwv65AKO9A7DTNkswONpoz68aBFfl5it5oSrxp9k14k92dT1YsmVhAJbKBzgQ70VfTVZk/IHr55Q6kviuO59L9R3SG/BX6t2wBiHoBFB2G7zqeQ14RqfQZLG6qoeQKMKgqdWbhKQTgUgcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRiKdLELnJRJ0nyk972LH2tykiePszc/EPeBiGyUew8=;
 b=NsSBsUohwxo9xnO0SFbnH/gBNUk5jgf7tzmlREUaEkznvpaOGkyopvdc8tjs0sj6EfwI35m5Ijvd4YCGrLgfyVWE4pQ/vPnryTHSGlhHMk7X/cS++MN6lf5gJpmGwojwPlV6wb3DMTnzkyzeoJkeLga0F/5jNEnOt8TzI2UUDB+xI1+gPMh8AdWEsbCMf1SwehuEaQpharSvGIyXUWbgMCP4+g6BzQnh4l8jFI8JTrosCjrvESiz6ZKcCFUrruCCIiDST9jht1gmpQspUcs8n56GBwNyETo6DQpKWnBYx02vvZw4c/aVYO7YkQzyv643riOa3yPSK4l7QIhsgfi6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRiKdLELnJRJ0nyk972LH2tykiePszc/EPeBiGyUew8=;
 b=Wll0VfR3jRzEhCp4FzPqF9wn/ris6GnAoNHQ/v7ficZ8qc9ycRqux/h/ojMJA2wOSPLII/k7QDtmgMXSKxhNCMPBs4JDFBQ7Ujtq/I+BZU0/mZb9RZOpBOTEWBSA38O2jr0+pvRtFAeZOsAoQoHpHZrenPVz6Tkup0xEJd69TRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:48:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:48:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
Date:   Wed, 18 Oct 2023 11:48:09 -0400
Message-Id: <20231018154809.3304558-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018154809.3304558-1-Frank.Li@nxp.com>
References: <20231018154809.3304558-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ced5ba4-5fa5-48b4-bf87-08dbcff1b55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7rB+zp2xEpftdMfpGDFhcqR1oOQQpS/M33D9/C06whG541Ky63FESVJxYqQJDxB/hxsK3B0KdZhB+maHpFgBJ/MHACzFE+YIie1ZotqKm0dRMSs4m6rasjVO4992ZSRqCAHTByGPDk3fLB5yKyZalNm/zqGChClEO31ei7Pq0XuSIQeNSGjxmD2GnJNFI1YBBluNHvSpC19j4wpZQEcf4a/7Nbf2BUE8raoRMhY9GhQ6kYE/NnZ6tyNf+wpniisqujoiaOEtGJy0Imu0RxAm4Vu5FferAhgqUma4QXIlXCb9GtDVBjC/m99tk6WnS2F9wZrDobQ+XXxnNeSkzKSyHP0v1QXRs736p8b5cVg+S4dOx3qq+r7ys6qNZdhOVtkI1egVvR5yI21EQG2P+gSH4GdfT+aWBgGSAqa8yNhg/9ytWhcpuPoD/GdBAe7cJFijLCpPN3jhwyxN/ATH6TkV02YLybGpnLIIuFIHWNKWS2V5YLIiCOvKGaTzsyVziLZl6x1KP+F1sUSUc9gdkoq4OGj3/We5dGY4xaSlh2M4emzjCt52xyVMppVe6C5au3Aw/k1bO79YzeNUJpzmdPlj8On3MY4C4yEVaU//ioFqqr0XCJjFFnVCNUPVVNAmmeh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38350700005)(52116002)(6666004)(6486002)(6506007)(6512007)(478600001)(66556008)(6916009)(66476007)(316002)(66946007)(36756003)(2616005)(1076003)(83380400001)(26005)(41300700001)(38100700002)(5660300002)(4744005)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rmakb5F2Gaiw/HJwAu8lZOW2FjbOSyvvMyZQUYamq2/rTF5E2aume+2b4pkB?=
 =?us-ascii?Q?KZIJ3PkEpR5bLc91CMNc2qbdcLTkF+8MClUpjGnDtQ5rUQujP8JbXNhcVih4?=
 =?us-ascii?Q?oqpXDrY0apzXFpyBtXeAh1BzoEpJZ9taKpuAbZB7rHarSPSJsE8AzyzlG+iB?=
 =?us-ascii?Q?ggkVph8yRrZvTTpPr8DUR1oT3PQqCTdlLvPTJfaBLufcvKi/rMHi6vnVyrnF?=
 =?us-ascii?Q?LTfvx9qFv5Uk4psCbDtDExYasGamrcst2U0UxWzGyQSHoUTId/B+zezeWxdI?=
 =?us-ascii?Q?U3D7uUDIk37oCC2mS52hEvWaWgWxoIYajFd8x4Jz/r0zsEb7iBybgs3e+/nt?=
 =?us-ascii?Q?gdf3iI5XKH1QDrCqnwVws+9Gf9/SrEZgqOghjLHLModR2rUwW5QdeYK07N9v?=
 =?us-ascii?Q?Jl57c5n7CuGrfzkOJoIcpcKIYvbxsFiQTqlyLll9J1KGduUDIaQu64sNFP3A?=
 =?us-ascii?Q?A5G/lEs0bKH8J1eUKCaPa8JrW8b8wXyfwNFbBOtDuQb+XepEjCpCbqYHwTsT?=
 =?us-ascii?Q?+4L/vHz56lsVvLqeC5Jzb3GOzw/NH/3SWy0RUl+R9rwNunM68QL1087yBpmS?=
 =?us-ascii?Q?RXoKT+dyt8GYraDDgYqqiSdf5DP1h3IiWG9WDK+a4xflWk+akoHrPorn9HHq?=
 =?us-ascii?Q?TkzNsWDVbIZOaJG93hxu6yPvgFh7bJsl7tUMEYLzxp6sRxfE5vCsRojQluoi?=
 =?us-ascii?Q?yZzAjSa6DzsNt07PgM6lo6+bivWqU7fh1d8UjXyLHt3kKKiF72KEQdGRAe2Z?=
 =?us-ascii?Q?1Ab8HL6uO1TvngoDYYSzJDIDwEsPXXtTZvwS+8+wcZvbDZmx4lrukeRkDFUS?=
 =?us-ascii?Q?RBw/OjLl3mTeJBSIALqwjzMwJOqc3Rgph+C8a+eUQ+6ueuIokjw8Ayut1RMV?=
 =?us-ascii?Q?3DbtmMnnXgUXaHcZQZN29nYLphi71TPAes+MhRNdADbXmrdLScugxSQ/uMLc?=
 =?us-ascii?Q?5CUMIl4QSk+m+/NFwErMWH0hf39KTy6si64+682h/zD4vPPQYH0DCiOS/q05?=
 =?us-ascii?Q?5mKnEydI3fEzo55v8wxkIdOX0MSb4NMuy+XcZn0O/uk0RUNO7EXRmKxHVlXg?=
 =?us-ascii?Q?B/61d47Vr7ggkBXsqvfQfXIGObb7j2bgmJmXlQMGCKHC8d+J4lU0R+dPCgJh?=
 =?us-ascii?Q?PhcQPfXUReyJPXVMNj3T5WQFFDV6Dz698DSUrkXW2m0qj3azvieKN01FC5XW?=
 =?us-ascii?Q?9vPxfX8qXe2ZvsISWwYgcC4SVEYjST6SvPD8GGkAF9FJWIDrbb8wVywjWcV6?=
 =?us-ascii?Q?RsfvI0y9ZpXgHj49X2Oh9YYDMmqTo0YmP9VlN4Xz2yh/gM/ZstvkPgPpyZSf?=
 =?us-ascii?Q?HcwHNTp3cWmhXBBQhM+wxfBafSs6retjBXhgCgv8xtjQkbfd+sFBfqJfUa2B?=
 =?us-ascii?Q?gm237ZztTdtJhrT5oeWnTiRPDA1iMTxythrOzKADZeH+BDtRzAEGoDmTHkPt?=
 =?us-ascii?Q?aCqQGjSr/swI2GY6OX7JYZrxQkCUU0C30JSpSP8e/fj+pvNCV6asSie5qhYc?=
 =?us-ascii?Q?xvDQUvDRAXkb8UIQX6GrNlw1xmXiSlorseficD7LNn5qH00eKffQ6T/W5SmN?=
 =?us-ascii?Q?ORBTV554vizIKXcIeWWdmTVHLbt/qQjzsmXcjXRa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ced5ba4-5fa5-48b4-bf87-08dbcff1b55e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:48:44.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbpqE8UHBIPP1/uHbGLSYPsaISRwc3jvcX/n2y6D2SyY5TyZzhRUHb4atlURTi/QlXz8vDTz+fBwNYhZqjfVkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IBIWON timeout happen, SDA line will always keep low because miss emit
stop.

Call svc_i3c_master_emit_stop() to let i3c bus come back to idle statue
when IBIWON timeout happen.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Update commite message

 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index b113460f059c3..1a57fdebaa26d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -404,6 +404,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
+		svc_i3c_master_emit_stop(master);
 		goto reenable_ibis;
 	}
 
-- 
2.34.1

