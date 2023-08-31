Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C424978EF59
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbjHaONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHaONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:13:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D3FB8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHi+GKUVWMK/Sh1c7GOAvmwRfXJyyVnE3ZBwLz7yaoEOpVqKSRNqniHRzifwGsXkovyRCcvoPx0MRw+Pb3gSttewyRxRTqpcQ6i1rDh/v/9NIHdsJihbSKRgtOu+uk8SFP+PX6s9v8RILr+ev1vHxs3yB9o1jCioRVmORwl0yR+MuiupcjFZYIXkfXYa5bgVSBGrgxEIVNpSRnEiS0ekvvudkXtH/5R2Y8UHKF07tpQOtsu5oTrhAt7CvJyXhczdatR/lUijuppU0dRaywzC6jNRn4+h/8tEPnVH2fvRN3CH0v79Qj+20RLs6Rs8xOOKlOP4KAaQUaB8MPp48GtGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXCgGAgo2yg7mxfrE3xiHcgvOzmTe2mgO4psV1SyNlw=;
 b=lbpjw9rvAKn2rgXaAwpN3OR80IFu1huvroHKqZrXsV6Sn7S3RmfgFZrSDFXnuQ0LZS9KeH1Sp9UccBp6pkiMm/1Xk2GQI5RfRLA/BRX6BL0htLG1/XhYTdXeOZQgspLyb3Jq4hLPhukJ2Zkscx/qd0ndXxoNEO2AH0PJm0N2AexZzohFS5zE6aLWyyOZMEhS9YGJX7s8SjvboSs2vEXNL5WeBYEjtRUBUPi7qwNiRXjociANOgTmA3zUdCoNdOSV24s3FM+AgE+moY/fpxc6JEDrqsNdA0956vDuNPxugkHM13QI/prZHKytoQrCRohPUOyF+hqMMQWBp1kGq4KRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXCgGAgo2yg7mxfrE3xiHcgvOzmTe2mgO4psV1SyNlw=;
 b=ThtlWjOm2M4sFPMWJ7XoJItPggxONLZ06m/DgumXrySdh28gVO4RYmx4x5HeRmDdairS2LYLi2WdnsqsLmPE9qZlhI1F3DhUCfpmQh2f+caNY5AcL2uyrVkvD+TSDhudqcFRa1aWpF5GOHJ86yOkfCqKiqpPxiR18bHqv/xjDnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Thu, 31 Aug
 2023 14:13:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:13:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] i3c: master: svc: fix probe failure when no i3c device exist
Date:   Thu, 31 Aug 2023 10:13:24 -0400
Message-Id: <20230831141324.2841525-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3e98d0-4828-4a65-2515-08dbaa2c7ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+CKOrGWcb0mVYH83rmmEoqrJH+MK9nMlmnLvcIs9Tb4+ejfjNyuHfgtwg/wxD1z08YwnntkeJrHe8MRUIqGxCaeyVwFs1RhmKOsGsiwtncfAcSPaLD9N8ub7Fl/Rm9FZ9fBQ/+yWLKWQxfKo4MBsMnsayZUIeqH/nLQnzl/YN5MOoqAzznuC22YVWhY6X/MitLZtXqB1EGaLGB5AshGcK2nQYafLlKRBPY927BnBXEq5fhDO0RwJIY47xEGomGKoh3khGYaAnM6KS1C12XpB8o54EmpTw7pVwqEBYpIidbw4CZyxDM/wjuSFNU4EFWywZh5x/kez8lGqOeBuXDi9j5PCcxVGv7km/PdQqhGuGHaAuyj43BqpEhOZ6/La2jgHxdgfP2MvTmP/NMTRpRYpSJNe7amVutBoHeecRRwVgEGfR4qtxyoc4pXSi78ebDGp+nTnl2U5/7u5nsak/qy51PdAKHSDlbBlOWNzm1KP2rqpAREGJ7bWN6iY3kieJDPQXMUrmBKJ5+BXALCUzkSyFwnUmXlPXwf5fFPNXVr2ADRYM7sGpgPqVCc2/DSHLWvVx6ZZlkXeKqN9sF7fU6g5yrLM8GAWeSVdmfNsYg+5yrwVoBk3fUDRNo/SRukY9mCjn2CsV/GcWHC5iTG2m5uRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(6512007)(6666004)(6486002)(6506007)(36756003)(38350700002)(86362001)(38100700002)(2906002)(2616005)(26005)(52116002)(83380400001)(478600001)(1076003)(66946007)(8936002)(66476007)(4326008)(8676002)(5660300002)(41300700001)(316002)(66556008)(6916009)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E1zmnNs3t4zVP29sU0zAH5iV91e522Cx67iLbUCB/WyU+ILxhvBDJY+Y0KTE?=
 =?us-ascii?Q?ucqvSorzjxthEZSv9buzooJ/Fizh4ujKzEkvlwgGuMQ9AvE8LvrxjUJG0/t7?=
 =?us-ascii?Q?nIpGXJIe+akXhA34hW/lkWdBNQALvXXpWnF71H+sMix2ljOhKNGNVJtahxt/?=
 =?us-ascii?Q?YGhizDBmNT1NME1kx7tyPbO9y09vWj2OeNJGKcckGvErDFippVjVzmX58LtX?=
 =?us-ascii?Q?rnj46+jRnjk1VpOM+5wh2PNN/UxqFhOkVBE6H+JtLbj8yswW5YNIID+IdkAB?=
 =?us-ascii?Q?xreTNHQK6t7+TTZKZAcImNlko3ST7w2vrc5lsFrpRK8o8HY4N79HRu//sGYv?=
 =?us-ascii?Q?xNTXyFBlvIIwHDvUobCFMmaccCqrI260fcmmFodZf/oDp10bxvPCYHU8eWDD?=
 =?us-ascii?Q?JpkAtMn+wEBERpIu4Kmr3WFlSdffyaX7i8HS4GuNGo57qd5JuHTmZbQCFjUW?=
 =?us-ascii?Q?gyW/PL1l4Lu3oAuhF9J6GxWp5/FTcvMAaU+KCJyLwKSkDwCJMxGvBqlAVP59?=
 =?us-ascii?Q?+nY/TLD3Mei7rrCktNOBD6vWry/8aVc/FVfwSh6n0o1ki1hCq2Zi7bY8NWBn?=
 =?us-ascii?Q?qAOvrJ8AZJSG53cFjE4nRArnM5xx0qJxG/YIev3UNBRO4xTMksZjKQmtB4Vl?=
 =?us-ascii?Q?ppnFIWHw1LPoB0iMxUtV4awV0qKBZXShRSNt7BX1SrbjaUjc6nOlC87vXasB?=
 =?us-ascii?Q?6/X6e9CI/kIHpCX9OZt0oLWrPQ9CXHhpXECAdrc9IThHGMrg7HPyp5SAL8jO?=
 =?us-ascii?Q?mC9/0UWs0sNnzAivdN7OpUy3+mGLswSXEaa3b3Xjuo2MPsz9MX0kdwhiXXrQ?=
 =?us-ascii?Q?1vJpXbr7Ca9eGBIBOvicDEmPO2rmHnYv1w6nz4aTpKFv9g94dhCtcUzzaTjU?=
 =?us-ascii?Q?NDe63A4JpygamIWP5ju2+ISRDyIKRubMFScJDJ2SC8FOpbo/WYdPwD9LGnbT?=
 =?us-ascii?Q?yL/v2RtEqoYarusBRNgKcsfwiNYYn/HoRLIkgy7cP+Q0D8ndaopWP2LGFGbC?=
 =?us-ascii?Q?ump2c3i07AS6Ch7FTaAzqIEri5ab279+BRdpTPf+DyCLHNUpl6aDflIkca37?=
 =?us-ascii?Q?AEZ9g2WeHX3hmv3mQyY5xSb5MzdV4jaiKeufMWb66il3DXSHt4jIcpGEXJsY?=
 =?us-ascii?Q?Nx62z233yYnh8TksdzYNXz3eIklCov30ydMRN14ggCs/QJbR+0g5sV/YFBtq?=
 =?us-ascii?Q?/PFUQES9ZwVSw/Sj3vrvEQ4fQIaLSVTfvUFqCJI2XQXsUXuJD8EgnY5Yb8nH?=
 =?us-ascii?Q?8S5SFzIHk5aZwxOosULGSdp2/4jZHv4XMtqVNXKIcIhkniBeyfOONp1zU5Ws?=
 =?us-ascii?Q?x0nQZWSCO5r9alEkyPcSGq/r1lHPIGCgqlskciLCluR1cWB3GkyByD+0mSjK?=
 =?us-ascii?Q?8zrzcS2se2AIT009Nz8wLKsC1JY/7T0+Qw2FfetTx5XDkrIpcCl+5WOMwSJe?=
 =?us-ascii?Q?//eXuqPu69aT3dNZDa2KZUGpvHPxcXkyPBGSSFRBOKIYReTrw1IhKHJOTcZA?=
 =?us-ascii?Q?Cv0HYV1lzdPAC6wHFLc0Bh6bNmDjMYAxjeMVjRcnhygSFcAOIwgEtAnzq9cw?=
 =?us-ascii?Q?R+uT0uNjem7oEQ9VtcEYGmCxaHMBP8V9TZuNPmEd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3e98d0-4828-4a65-2515-08dbaa2c7ac5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:13:42.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lbI0p4ZzZYcE09Zj5Oghb2r7RjWQLdcT5lLeXqFOmQA3I191IGxV3PWtKfA5Hlb5iz3QmTxWRR6JzGHVbxr4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C masters are expected to support hot-join. This means at initialization
time we might not yet discover any device and this should not be treated
as a fatal error.

During the DAA procedure which happens at probe time, if no device has
joined, all CCC will be NACKed (from a bus perspective). This leads to an
early return with an error code which fails the probe of the master.

Let's avoid this by just telling the core through an I3C_ERROR_M2
return command code that no device was discovered, which is a valid
situation. This way the master will no longer bail out and fail to probe
for a wrong reason.

Cc: stable@vger.kernel.org
Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v3
    - No code change
    - Remove patch i3c: master: fixes i3c bus driver probe failure if no i3c
    device attached
    - After test, only need this patch to fix probe failure because
    i3c_master_rstdaa_locked() already correct handle error code.
    
    Change from v1 to v2:
    - rewrite commit message
    - cc stable
    - add empty line in daa()

 drivers/i3c/master/svc-i3c-master.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 770b40e28015e..cf932ee056ef9 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -789,6 +789,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 				 */
 				break;
 			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
+				/* No I3C devices attached */
+				if (dev_nb == 0)
+					break;
+
 				/*
 				 * A slave device nacked the address, this is
 				 * allowed only once, DAA will be stopped and
@@ -1263,11 +1267,17 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
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

