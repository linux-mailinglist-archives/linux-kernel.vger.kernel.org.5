Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED927CCC87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbjJQTrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjJQTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:47:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F093;
        Tue, 17 Oct 2023 12:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlVhrw3aDaguBif8afw2uCR3QLVB3asY2tBntn40sKD7fBYcf4Oy0+biOv3OMKFij/IogFcEdSqXs33FhffdNbjMP1EPOhcNj7GsueufwEezoKK9H8aUoFBGo3CgGer+H4ibuvVu9y5NbGAhFoYAtldUJIRfc9aRYfyXcIKSsPjwWaV4KJTG98wNf7vswmVTgNnI2p/c6oyZN9TwlDLz/YQIav+HG/a6SURYAxUYrMGOBNV8ftb1vBzdTCzZUHaXvlu3tcn7JXj+P+6q5FzyRZthxSQbqqCond4Q408YsRNYhWzNHdqXwI4uJnCAFkAn1ybzKeBudqAxOAYQcY4g7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ullkdJJ/EiGV/THB2JFNeF46ooxPxd0mtzetQN6b79s=;
 b=EtDEf5ujX16sVQ26EXOeqeNTQBqd9cl5uqo/gvJ5szKXg4Qh/TfJ4L3HEtraIVZ+7y2BP3xK2jvU8ckhwLN5zsKPimNjeNlQETkL1v7ApViG/yaZcHXDlEqOtwmM2AiHnln7vsjAeeAitkElRAtzRcIjbgL6TdrR0inO395VE5EB4Nb+LKCsEkQLXmQ8d7FUWTSOleFD9M7Atl4qF0InPk1+UxTQGUVr7grGc6DnBBt9QEkUrPw7TWZpyyzgOk79X8huSUV+JcMgO69gK/g1TerfLUtbdbNYXYt8iNlrenKjmNcse4cThq4L5uLkM7Wk0Pp9F0Xe7DJ9X9ArJlmPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ullkdJJ/EiGV/THB2JFNeF46ooxPxd0mtzetQN6b79s=;
 b=dVw7gsHbsIshVOej6tXQJB1P1koNgR1DUi6yL0Mln9W8Jql84yTYxmuwhmexUi70CYHVPwIGI5vciQ3tOZY1owWgcyrrNgqAuTKNqqfx2+VHaodyECJpdndLSDcDBrUYcXq5M2c2qWS7LqAuXSwFYAHpOo/3TamgeBWUGdabmu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:47:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 19:47:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexander.stein@ew.tq-group.com,
        alexandre.belloni@bootlin.com, conor+dt@kernel.org,
        conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        sherry.sun@nxp.com, xiaoning.wang@nxp.com
Subject: [PATCH v2 1/2] i3c: master: svc: fix compatibility string mismatch with binding doc
Date:   Tue, 17 Oct 2023 15:46:56 -0400
Message-Id: <20231017194657.3199749-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1cf941-bf5e-41e8-7136-08dbcf49de90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkr0PV5q9OwIltzN9DusML80Bz3d9x3BWfinm/espudKZo2Fl8CIba6mYwtr6QmfjquLIaUDw+e3vwzrgByQ9/TObqw6HyoB9mRR9cv3eb9vRis3PgO0//DrWr084K6z0nNDPK9ajp4d00YpdPpDJPb2J3nivd0kCCz5Knz6gaRgRjqKT7mCzDwOt1CTUqMLZXozKcKdS6EZPM5AbUuENn2eHWDW05YGI77pdCMKjcecL+57tJLoomQDQf4maWT5aActL/qJRmQ+g69NjnI4oepynavXQkcjYeUeSqlhZcL4/D+TFkYGLt/CnJWVu0PLnDTO5y4AiQc4DqMABVPs+jlvLiM9Uw92cQfKmDhoXAXKo9mcSDWD8jYbpYQpH6mXy/a0Mwi/D9XQM503tGzr65WJbM1XNwW57/NxSrYGmlzNvwG4A7FQGfZ70ow3WsfKCMf8bauOUw+dnu+NkL3ZnfmJmMTmU8QfqSfan5nMEcAAinLCtB/0OgU55tOo43eNDDAUbNwzV3Mmc+FCnSKbMhTaA+bsVQiOlGi6fa2JduK2j99cc/FUnI3snOlS0ctb41ygyVUjKGaep8Sp2oWRsEwfhv7mhcVrgN/Z0cGJMU1BjnYBPmBxCRsLc9UHEDKL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(66946007)(66476007)(6916009)(7416002)(86362001)(66556008)(2906002)(5660300002)(41300700001)(8676002)(8936002)(4326008)(36756003)(2616005)(38100700002)(1076003)(478600001)(6506007)(52116002)(6512007)(6666004)(66574015)(38350700005)(6486002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJlWHdIdkxnNkJQRlVVTTZBYjBMbzBERXkzYkY2dGJrM05kNVZJMkFXS1lT?=
 =?utf-8?B?ME16ZmgwT3hKYTYxd0VoQkxsNm15MGd2RTJsMXk1eXFzaVJ1WmVDT2U1N3N4?=
 =?utf-8?B?ZytvSnJrTDU0WFIrUHlCM1RxbUJwNXZSQnNhY1V1cTBIVmFkZGFKbXE3R00v?=
 =?utf-8?B?K2VaSWJzT0tjTVZGbXhERmZZYUF5elhpY1hKeGFCRmNCVUhYaVdZY0lpbEZa?=
 =?utf-8?B?MWhiK2ZseEFZSUtiUTVWSUFsZ3N2dytjQlcwOHh0UHMrM05vUEhGak13N0VP?=
 =?utf-8?B?Wk5GNWlRRmVkV1FBNE02dWp0SkRpK2l4MmhQOGtmdzlHaWZWNGc1M1o5WUY4?=
 =?utf-8?B?dWJNazZIZDRZUTFpOTFBRXhsVGtxWkZ6dHpvQVRqTy9mYW1abFRQUUI3b2Jn?=
 =?utf-8?B?b3VtOXc0TnBWL3lpM3ArVm5tQXA0b3lEcDVOWWRZVkxMS0dsOCtTN1FaVXB2?=
 =?utf-8?B?djVlTUJjUC9HeTNrd1VGVGdnV3hHSjBjSklLVmJZLzl0UElla2hJTmprU0ox?=
 =?utf-8?B?azlsVHF4WllabWVYejdScjgwTk9xOGtDU2ZwZldyUUUweFdzWUM0S2JBU2tr?=
 =?utf-8?B?ZnFnVlZWTTZ1UElwdlRmL2NteUZmNm9wNkZndFc0ZjRGeDkwZXBoRW9FVi9Z?=
 =?utf-8?B?bXl2VzltOEF0alFwLzZPajJuWk9WaFhaZkNCZGM3N25oRnNiNEF5bTIrcFhF?=
 =?utf-8?B?RmNpV3I4bGZQajFZSXg1Wld2YkJVZk9hR1BRZTROblNCam1uVjlMbEk1cndv?=
 =?utf-8?B?eHBsODlXcEN6K2l5RGNpdTZlTm5RT2thWkh6ekd0WWkxb0hlUjc4MnBsU0Y2?=
 =?utf-8?B?ckNGQWVWbHZ5b1pBQ05PRlEyckJXaGl2bG80YnpKNXZ5aW9iVDB2RGVoa3lN?=
 =?utf-8?B?U2svUXdXa0R1N05WM0lmMUhraTd3eWxVZSs5UEJPajgvVW5EZTBQK0RtbURq?=
 =?utf-8?B?Z3hVTmIvSlQ4OWs3SWNRdy9kQ2NYUlZXdkhuU1VaaC95TGlmZ3gvdEJ6MUph?=
 =?utf-8?B?S0RMRVZKSW9LYlhjRmRrQmRjQ2VSRTBQNUd4L0ZDUVRoNmlmU0diVVYzUER0?=
 =?utf-8?B?QWlFeHppK25OTnNhNFlod0FXWmQ5cWlaVEV6N2xpNlBmSWswVW1NekdDMUhv?=
 =?utf-8?B?QkN5TVRYVWU2K2Y0WGlkL2NCNE4zdjJWeE5iOUdSYzBtSlo0VWFKYzUvelA4?=
 =?utf-8?B?WGFaYlhQYm1jN0xoNTZIcmpWOFRzTkZBTit6dVFQZFZoMXhXY1JnQnZaSGRR?=
 =?utf-8?B?ajRCYkl0bVBlU3BZYUNrUUJnOFJ2TVdBakpnMUtzWjdIdnFLQkdJazEvdW16?=
 =?utf-8?B?NlBpRExONm1oaUlPV1JTUTVTN1ljdytuM25DVk82QlliaDhxMHdUcS9CcWh6?=
 =?utf-8?B?MHYza1I1SUZjN0xHUUZ4OS9hWHB6aWRuYThNNzhCc0ZyV0hITjk0cjJpOFFr?=
 =?utf-8?B?bnN4em9NS3poTHRGUGdMWWlHWk5oaVpBUndsZXRpRGtVbXFUUnZoSzhsRzY1?=
 =?utf-8?B?ck10STZxUjJMOHVGa3R2WW5mVlBKK3d1K1VDdUJyc2VVTkhnQm54SzMydWFS?=
 =?utf-8?B?MjhOZVhpZ0V0MnBGVkV0N3ZmcGdJeHpDNjArRGswd1Rjb1lMVk95b2Vldm80?=
 =?utf-8?B?Z1RxV0NRRXJ2RnRDei85NnUyRy9PaFVYT3AwSVBmbDAwUTlPNVdKVXk0eXZ2?=
 =?utf-8?B?RmtEL0p5RXB5WjN4UHNBdHlWTys3NWNYREhlaHdhVTZjZlZaZ0M0eHlNaElS?=
 =?utf-8?B?enRnK0g2TllIRGY4MHBPTE1QRng2ZzhvQ1RLWTUwcVhaakx0R0JpVjViVCtN?=
 =?utf-8?B?ZlBnZ0hNY3NnVnZTUmlaZUw2NGJwcmkxb2s0ZzJET1kyNmJUMjlmZXppNEo3?=
 =?utf-8?B?a1FZeHExQ01ZSFhIRWpMaWFuTUY1c1pBSHRwd0FsMWMyS1FzWWdwZFJ6S3Uy?=
 =?utf-8?B?UlNxUXRvZUpNSzNjeFk4d1ZtSHBZZ3RlT1pXcVZhWndFSFRCYWp5VEFJZDVO?=
 =?utf-8?B?Uzh3VmUrVGt1cGRjQXRVKzNHYzVMWFcwbVl2czBRanVLL3VMdExaaXZJTTBY?=
 =?utf-8?B?U241dEZRSGNqMW5SdFNJNGFpbkFncnJVRGlycUx1U3hJc1FoTk5zNjQzZmIz?=
 =?utf-8?Q?u1E/eCLHR4+kk6GOvYCe+xnbH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1cf941-bf5e-41e8-7136-08dbcf49de90
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:47:17.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4dDZs5t1R42JKXXO4sjkp0ZNQVPfw0FpGmKPjbDv2ctbVWxnGiz7RK4fM6jMUaTe5dYM3XgaYUUqpNmN59i9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the binding documentation, the compatible string is specified as
'silvaco,i3c-master-v1', but in the driver, it is defined as
'silvaco,i3c-master'.

Rename 'silvaco,i3c-master' to 'silvaco,i3c-master-v1' to ensure
compatibility with the documentation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - Miquèl think drop silvaco,i3c-master totally. I grep dts tree. No
    upstream dts use silvaco,i3c-master yet.
      I have not add "Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>",
    it is different solution with previous one even just one line change.
      I think v2/v3 both is good, feel free to pick each one.
    
    Change from v1 to v2
    - update driver by using compatible string silvaco,i3c-master-v1
    
    Change from v1 to v2
    - update driver by using compatible string silvaco,i3c-master-v1

 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index cf932ee056ef9..e307ba2b965e6 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1650,7 +1650,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 };
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
-	{ .compatible = "silvaco,i3c-master" },
+	{ .compatible = "silvaco,i3c-master-v1"},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1

