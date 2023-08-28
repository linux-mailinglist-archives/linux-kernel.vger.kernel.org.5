Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A9978B83C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjH1TZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjH1TZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:25:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD22122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clr5sepU+apYMmDoA7zIyFFiwunAc4drcMhzuT5m1KwNObI913hL8cKpb8DmMV6KAniNmNpMzGPHanHO8DnWJEXlwVdFZh3R8JPvldHtOb+yxMjIQnjsRsfTFxTzDfd/Omp6FKkEGnit+COIcoaeB8XeJQJERJDZUCQxeI6wD6w/2ZFfgIfALbXeH6mpzcLkgjblNaJmJSOsUPmz8A2U044G+KO3hTiaz3Ju9wGXG/iX7EqwLnKrvU9CudHyIcblKyXeBKA1YOgPa99pMLMwBumkS5793c5RjOjNfmUdwzSgQGh4terncmdGEy6DlFU6dvOAzRHGKq0R7nPm8Zh8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JkCMzwP2pi5MtOkISXsvPDy7HgD65tBmAtTNEJuu1Q=;
 b=cdcjfudKhu6LwW8g7KdnjP3qhTjN0zy40NMsv55o8lm8K+sb7m8VuypFZcfs5LCgNMVWErRiBogPNFIdAXKtAkIIwYmUfm8wcXtGyENwg3nC1rQRXFIn4gEW6cAITLJGQnTzwrqDXWpY69pEKAdXoIO28Hb7/FbhjNIesmZ5rXxIMJnQM0lX11HwaQe4Rbn5UcB87Z1DfCV9AxYZ9mC97F9lQ2BDSpUKp9qa6znSeueJwY8AqMIHPaDK1zOTmhaXXl3BD9UM1c0wVAOTjSmudai6ec0Aui8cueKn9pOHgafr/eguDhMlG4lAVHsAtzAMx3PYGLp65lADB4samdpGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JkCMzwP2pi5MtOkISXsvPDy7HgD65tBmAtTNEJuu1Q=;
 b=JUTiYY1S0tZ0q7xT9j6miBWZOjuZd/UemAUfyAUDA7vqcp0K129sYHvapP6144Snhqg519R42ljAhUNPMKBbRUGzmwoAWJBzIsKfHTnDqgwo/WPaNmjHuOCTvvWw0gTObNm5D8zp+lnwbZ8G3er47QU+RJZfWkLzqPJDYpmrKgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7462.eurprd04.prod.outlook.com (2603:10a6:10:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:25:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:25:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE
        MASTER), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 2/2] i3c: master: svc: fix probe failure when no i3c device exist
Date:   Mon, 28 Aug 2023 15:25:02 -0400
Message-Id: <20230828192502.3525418-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828192502.3525418-1-Frank.Li@nxp.com>
References: <20230828192502.3525418-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0067.namprd08.prod.outlook.com
 (2603:10b6:a03:117::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dafe4b-b769-4f43-85df-08dba7fc8674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OU1sqROa2fHGkdRwUMrjCrF5eZIe7vlDPJ35fop/LILj74ytS91p2dbEmdhZlXWdUjToTfvq4RhnRMJdHossLcIghfcJHYJYixsbE4PvysF4jgKI9j7if46AJGDpfDypPsetxbCbNbn58k1fdoZn0ERmz2M8BWV6D5NyIgJIxA9v4sJPVGG2cfjI9BIbyS34UymEFxxPrLBZwE09PlC7MzlfuJz6XZ1uTqapytwNr1ZwzC2kUmnU1PUsHQgwJrr/VLEZRQy16pAUE+6ZYpS+Qm6e37C0OwSJ9xf+SD1+wImymxqDx/qpot4bn3haZ486j1MBSde3mLARWrSiZM8oKAqPEt/oe9VuNoAdjZZWwR8oU6HD+zDYNEyfi9PcIpUGL12LAqb/pRG4XtlFLUjMuj8tNiO1XKGA2xPKhTgGwP7Rl1kBpbAC9XVLAfVG3iFj2jqbXMgJAF5/o6mZ6esf+YJSIj3NxL6HrB73gHqNPYL9Zhj0Kwlg66xX/ZWv0XHF+QBed7wBYIsui5rFomNKrmDv0l/5nvFfOJbbaTH1zwjrWoNVaLwbcSeV+BwwEylJKW8ZoVwSHnOqufsti80oHIOZwdTC4U+2/DokMRN8xSXc1k2rBA1Zuq7MldaEG56qJqVaK8qHSdPa1nSVtN4Y5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(6666004)(6506007)(6486002)(86362001)(36756003)(26005)(1076003)(2616005)(52116002)(83380400001)(6512007)(316002)(5660300002)(110136005)(38350700002)(66556008)(66946007)(38100700002)(66476007)(41300700001)(2906002)(478600001)(8936002)(8676002)(4326008)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNJjX6id68U8tsP2qWUFOaOIZnhY6nHQGOsTJclVEE3GG4DGiQ/3JReC9/Sa?=
 =?us-ascii?Q?2xbyvxaWFi96YLJqJ4v7Q0rheywuYxki0k00m2WeDtvwAiA7ObaCdE6YKtaJ?=
 =?us-ascii?Q?OKaGPfiM4HeLq281acaz9BX/9ul2NMQV98M1DdxyEqGjvz3efwNHTk6d8G9h?=
 =?us-ascii?Q?a7j88dCKSaTK9r4YRKsfvsrUhbicTQKhkIk+FsirSBGbmoJzilqu+vGHPwPZ?=
 =?us-ascii?Q?+e+2vq+1jPKnWioSjVztxAm6AhGMo0GA0gYWE7uGIIe2pyDVnGQ6VNrgi/wM?=
 =?us-ascii?Q?ZahnS4kvCiVAIst67HpaBQ+LKixm3gfIu3yoAvexdMvntoft9M9LItJ0Z7jr?=
 =?us-ascii?Q?rqn6GJxbtiV1QnSXGOnZPW8sTW7uGcATW3dwm3Cx7EdDrUQnHKljmxMmGAmI?=
 =?us-ascii?Q?bbfShaYk5yTPElt0ekOAJ+mN912irENu5Gh/N6hvyROEAYuM3PogCX01IXRE?=
 =?us-ascii?Q?sxie3OTCeZTBrFxN/vdl7790JaXRzJZNruENj/i10kTRfhFEiH80ySdY9J/7?=
 =?us-ascii?Q?Zhia4OnwHnXvEbhojrumcQJcQXMJCYTYtQwhf/y4djmPECLAOijh52YkV2mh?=
 =?us-ascii?Q?IJqhs0FUlZBUPgZmtvK5D/aTkbHsiZ+o1On6nPVzxBV9JTjO4gIfAd/5TN7S?=
 =?us-ascii?Q?QMJjB8/tAZYqjerXPF1dei7Bmjmo2YT3N1GkKkS3BgXBxdkzChUWaq5euAKf?=
 =?us-ascii?Q?29yfGC8fW5Vq3ups0qfANCF/U+XcGfn1oaS5c2fmskFiT/cguPDONpoe40rR?=
 =?us-ascii?Q?AoGSQgQZw+LZldM2l3ILlndOzK6Ia7NN6pOaCHKsEHK+AFQBsu/VT79PnrJ4?=
 =?us-ascii?Q?RV1lXeDNxXg/9bHGWAmy46hr+tP8XfOBgpZBUZJ1byPEYUUliRvfi3sRF4NF?=
 =?us-ascii?Q?MONYXKi5V/Tt9I430xLhN7YErzrMO2RMRZuURIIPb2G7Sg/xEb1EqtHIii3G?=
 =?us-ascii?Q?7M6yjke1ADjhvZa4dXgGN4GCaxlh6JmqxnxBQGbN/vYN+X48frcPIObeuxhA?=
 =?us-ascii?Q?6t6C29b1cdufNkCH27yUHOECr66b2dcYkBXEZ4OVV1MNz1d3ziodrzu/bkhS?=
 =?us-ascii?Q?kUGcB2x6QofXYp+tu6NSKFwv8/ea6J9mYGNNZBDoz9W/ZXOXN8bx9HtN2Z9O?=
 =?us-ascii?Q?ERoFV8BJadM7l8jPcp0qNo9v02dnU8J+VLR7SZrDbHRdicu4Nw4wRP7Bbg2P?=
 =?us-ascii?Q?5K3Q8tQUBih/I4qcRXX+zNVPl5NAzF7nVbKgmUMTT018nt7oAoGngS/ymS8Y?=
 =?us-ascii?Q?yxiuN5SSEBp2i/FnAD6tGckhdjlhJFrWpl/+IsMRAn79ZkpLcww5poHVgEpO?=
 =?us-ascii?Q?oFn115fUU3Gp7RHAQkdUFh/CCblXfAjeTZdmTd9PccOvzL51SXuAHlZXTzCe?=
 =?us-ascii?Q?m9IaUnYcpUNVl613Qk/YoRqM0tHk18z2EBdGToaueS/rhM0R/Mt1A+0x629O?=
 =?us-ascii?Q?iR4dcF8PEffT+lfITounFRlkHLbzgiV3T6Czpzq11XoWmaPzHJoJ1+0xgfMo?=
 =?us-ascii?Q?k5m9lhjyxwuoi6gHiv3g2vzfVY4UW3esfOdF9rhp8GTvWF5uUfl/qNzrASiI?=
 =?us-ascii?Q?kch3XlTLtOulHACBi9Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dafe4b-b769-4f43-85df-08dba7fc8674
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:25:23.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtROGoIo8ZNe6PRvIvWIZnoz4poUlRC7o7qqV6Q9FtiNUqbHYj4HRQU2/VaFcKje22Cw5pawNFi2adnzSuq23g==
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

If there are not i3c device, all ccc command will get NACK. Set
i3c_ccc_cmd::err as I3C_ERROR_M2.

Return success when no i3c device found at svc_i3c_master_do_daa_locked().

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 770b40e28015e..a5620103acb73 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -789,6 +789,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 				 */
 				break;
 			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
+				/* No I3C devices attached */
+				if (dev_nb == 0)
+					break;
 				/*
 				 * A slave device nacked the address, this is
 				 * allowed only once, DAA will be stopped and
@@ -1263,11 +1266,17 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	bool broadcast = cmd->id < 0x80;
+	int ret;
 
 	if (broadcast)
-		return svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
 	else
-		return svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+
+	if (ret)
+		cmd->err = I3C_ERROR_M2;
+
+	return ret;
 }
 
 static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-- 
2.34.1

