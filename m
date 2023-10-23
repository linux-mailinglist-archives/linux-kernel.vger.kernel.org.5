Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543737D3C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjJWQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjJWQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E6010DB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1kEb/HtXe8z82lgXkqqIdG8l5+6CupeCbPBbz2vifYsXd5MAQ5s2SG0w7G4j411cs8gNmvCmHn5mVN1P5zIFr66S9j1+nCwoH17CA+g+htTSRz4ECrEFYtJMWdSvOk5VvfHG44zeRZLEkaAoWYeib9WBTHVeRO0f07lkaPiD4/FEehEty7quIVxThmmHkCNE3NbTt2WpEtoQm+9oIbU1fxFdXa/xzcxyE+HVjGnoABWWUd0ptv7CPBx4uTWPyjgDgl8XJjStv9qN0+7Sy4IpBOvcUNO8c0C5+4XlwvxkZEreShxG96ViKBQkxxZ+2VbFSoZ+E8hsNG2acU4smDwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU4Cbhls3SW1lImnaGTFfi2FqvW7XvhiDiskv1v3GyE=;
 b=Runx58+tzrbXHdf9ap+UXV6saHtPvsLXh+ROLB+nrIRuzKt5bxmTSvDP/C9YdlZRyUl9wXhg/Bhp150e57uuKWDxxfocVyJkEAiWRGTmkA4h6MhrF9T5jdeUFFoM3c3DrwhctI9Gybu1mlnkTY1g0EhgKniis8DRdWZGkDe2n+JcfJSSocSplKSK58/mlI0ZVRUZz4sUP9GqUTZ2W5NR90JpxYZ1+g0rzJrfonMjAz325DupeZB98GwxewpTi0wkc8uBF0hap59pnrD89hiZZejbwXS4pX1gxp1mZA6sNmlDXiKuV0qMhJJUlkBPqqk5nrO3VCw/C6ayR/deepq8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU4Cbhls3SW1lImnaGTFfi2FqvW7XvhiDiskv1v3GyE=;
 b=nMydSNsQkxIYKcHXm0iV4jNqxqCJG16D+H0ldoClMPcJR124kadj9snCHDMWjiUrcwx15xqDTg3nEJPJoYz/aZ2gVleOJLvAk16Z3tIlpYZIMb8nE834D9/1EJ1LUZv0pidwlzdR+hzTPqi1g6y+rjP0RLJ7ucA2At0t9g7U+Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Mon, 23 Oct
 2023 16:17:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:17:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
Date:   Mon, 23 Oct 2023 12:16:57 -0400
Message-Id: <20231023161658.3890811-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023161658.3890811-1-Frank.Li@nxp.com>
References: <20231023161658.3890811-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a567a4-ee41-4744-32c6-08dbd3e38a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2o60YH4aEIGMS0wnhTWPT8LWlysfWkLHbhfGfnHjDd0twDX0W8LtpdCVfGrxKezf15mXeVNaiDPl9GJcj+PTNGZp9IvMaIhP5Ah+MBsuCvmdCuJFz4lDjw9e+jRLuZo13IOwRFx0svTQEItgNxuPTByOqFGAOieqKsO1f/iFP2o188gOsPMlWngyRswrR+v5f3cgMVWfKCNJnux4UinTA4YNX7Flji0HILGWkZnq23x2jwELyJwQq656wiXDAkNZKsnpmiLNWqAUIjbFTs0OAYzFlv4J2viwbLSI7Vjbh9w3mNAIoV+KvbpjbnxUuWv8H5ugg6K25NHC5iy8CZVa0AVHk9ek6fE6FD9Ce9D3xFZB1yjyfjcIBPhQ2KCyjP1jcByS5mtiI8qzvVIH6oJntKTQlCtoGQ90JvUg/gYxnYqn3Fn/o0lcwlppKetePSabv15etZtbcQ7MoRTIYLLTI5y2Xw0/pFM6rNcrnWJnzS8e4rBSoVUO21ysTyUI0uTBlchI1KmxzbJ3QjRmVrxaJPWAtLpw2l6k1WGuFkqRpwgGq8slrz7lPFdSlqbGPqhnQFY2l6M07LbCmIrDDFixGIdsMb9IEIxitsGRFKpDpwSDKSS6z9OPdyRdnYMfS0k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(6506007)(6512007)(6666004)(86362001)(316002)(41300700001)(6916009)(2906002)(6486002)(5660300002)(52116002)(36756003)(8676002)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(66946007)(38350700005)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcmzQ/Bic81S3jCB9xE9Yhc+KTggFhQp4cN+3Er43R2qojbpCYsXLP37PcMZ?=
 =?us-ascii?Q?DufKDE7pDQJ55Je0i73cnPepL3yHg+HQfDv4Op8qkNw5amd8jFrXObN2Y79J?=
 =?us-ascii?Q?yjfq1pk4yi8a+VYVOCBMSSI1kqJjSvhCI7944i6C7lKugkW2M2UnfygUvwm8?=
 =?us-ascii?Q?7S5vsZIwH8TbcPn1HlBG2zmgasHr77I6L56LYl2zkR/K7W/VqAJcAhPMG2nR?=
 =?us-ascii?Q?gVDmUBfN0UwTwtwENr6X9TNk6kGiH0S+rs6jJtNEi45BvKus1XUsjcFTknzz?=
 =?us-ascii?Q?pjDDBv7X9Ljp9gSPXmytWEZJTLZLQqvEspdtdh4++zM0RuvlO63B6Wfm5X4x?=
 =?us-ascii?Q?F1EXM3HUKxUzFink8XNPpsZLsbsPWyMLHU4Vwgk9dHr0L2tvsKxvVP9nNG5r?=
 =?us-ascii?Q?HDeGL0YTOm5qwoU2610MCRvDwdty2vExuPIoxwLGc5afrdJ+jIafKTEYlAlK?=
 =?us-ascii?Q?GB/pN4MMeXr1shcmgCeYL2tYD6ZoOrUsC8o25iwA6JnXsp4O8FM1eiStBjeN?=
 =?us-ascii?Q?jJ5R0cDj93JUdb8Sc+m2HXwYysr8SHZH3nPiZ5a5Q+ZURdgFCSTAb96lffhq?=
 =?us-ascii?Q?sqAghgi0DhhPchDoTbxCX6aUoU96ZUzpIvn6EZShaWnFYWpfrYF6dLuIGJxz?=
 =?us-ascii?Q?uMLfUaNEiA+PLcXCtUpGNbvj2JeWpH3vZNGmOwKzAImOgbciG54S7AMHakOl?=
 =?us-ascii?Q?DT6gpegKuza9Iyt0atfrNWTmPIMJNOSffDaUz/DXtxmdefdfwB/bzCfgp7hn?=
 =?us-ascii?Q?wyo6pHx0i+uL6VflzykvMjnXCm74elcCzKbsdR9IKRHj3DI5F4xZLObd0gsZ?=
 =?us-ascii?Q?5RhhQDKQz3Qz1lqq0z6fCv46JD3FEB52ayTtoP9Jd2gUIvLzodXI1ILv/Irm?=
 =?us-ascii?Q?l3Au2TiCRj4vCjMqjeFfOkutoovFasFi1g2I5aBzIDELfI29B/BBfZQUskYz?=
 =?us-ascii?Q?p7pZurHItBXUEv6/c2qZC18+wvLd3VqMfcB7cK0Qi3lP/OdT4Fd9RiiK+NT/?=
 =?us-ascii?Q?rf6XQe9T5kL36Byg6pTPyyPWOZPHzqwiwIBOTJVOpTSlgfvYfnjh9molLQU/?=
 =?us-ascii?Q?MkNZc+rfHJVgHwAq5HPVjYx481FqNBfdJUSkTzIqSJcCBy4zVVCJmhu4XL6T?=
 =?us-ascii?Q?kF4LzCg6gwg75wtHHvxKOGdGI/7eKAaz1biFfrckghEDYesaZf9/QTqpyrLJ?=
 =?us-ascii?Q?LEwn2hxp7Iw9OXRQfSBJFADpHOS9gnHQcjieniJ3WmmMnQZUO4hvT3pu8dHk?=
 =?us-ascii?Q?i6DlDmBnIdMRV+p7t+i8+cprzn/Irh3HoiajEkbAQLyY0smKKKk24G5fjz7M?=
 =?us-ascii?Q?BrCjAw35kioeio6P3v3BvAoFEhcgcaq+I4kkPpoqCuZmnkmRwRTSLYMIJl3z?=
 =?us-ascii?Q?Kzz9Rk/SrUMEPg2E3NTwuKwgnqJNQwtuW9krnoNdv7OLM1u346w9dYR2dIUw?=
 =?us-ascii?Q?PGFg202eIqe9hskiRXD0BXLI8ihqKmB2s3VOZD0doGL02JTTAtigXho4pPpJ?=
 =?us-ascii?Q?ziOatDAPDMvr1O4wIcSyxfPToVCC4+8G4u2O4lENJmoWixkayKVyveODa2gw?=
 =?us-ascii?Q?h0wzFvaoXAOtwshcwfhMStkGt5Yd4nRusT/xoohu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a567a4-ee41-4744-32c6-08dbd3e38a68
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:23.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giuBRlfaHk3hLM4JmCSETV7BP56CetrOvBakPF6dBSzikbmyUh5HSdPMlysFO5LVA7P7/ex/JZwooFCU96yPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon IBIWON timeout, the SDA line will always be kept low if we don't emit
a stop. Calling svc_i3c_master_emit_stop() there will let the bus return to
idle state.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - remove duplidate in commit message
     Call svc_i3c_master_emit_stop() to let i3c bus come back to idle statue
     when IBIWON timeout happen.
    
    Change from v2 to v3
    - Update commit message and add review tag
    
    Change from v1 to v2
    - Update commite message
    
    Change from v1 to v2
    - Update commite message
    
    Change from v2 to v3
    - Update commit message and add review tag
    
    Change from v1 to v2
    - Update commite message
    
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

