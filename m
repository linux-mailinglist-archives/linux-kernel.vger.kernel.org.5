Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B47B0411
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjI0M1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjI0M1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:27:35 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFF1BE;
        Wed, 27 Sep 2023 05:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irrH46qA+b6cQmp00nQ3AUvpNDKAefuUWuIBRJhRwjGqETtdm06u4zighGc/dKNXkEitnJvGVfaHhMdqM6hciceRO4yNGlz2db8+JJai7h0YHlUuC/nQTlWrwaJ8yFLHPHeutLkYxcY2vf8HByhnT6GB4VwJ20IbY9aEKyqNil5/57X95KVvJUKgBklyuHdFg+bTspJ1kkI77Sm6geEjyy+IiJ973ZBp3i5Qvsxh+dO8rVI6j69L3N+d0nUDQzFt/17fQvNOLAeNBihSQnH/QVWbgGNRJ5zmqHGSJomJ2AlfdrZBlhrAGFESOqe1iCjpqcqvNx6w30uQ8v7U0G6gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypreJhlI5ztDAx9ETL4uwlW64cL8JvY3OuMHb3MXoXA=;
 b=Ba5c0vfjVGOP/cMTtaUvhnvEBmOQO4cQgocF9aYt+PosB00asbUM4sxVkHJwUgP1as21yA+2HcSvFEIXM02OK2mkViqqIrFB2L6C4Ra/YRYLvaxCCRPZzd+5YBSyo+xpIjYL9E1jlO7sbFSaqHwbOm5XfnzbEwj4bJYE3Rnl2JQAw+o6qygyIQB7EhhxaSpCKxqBMjPjyVeAV7y4MoUvLkxDzAq1U95xGQpJYZdkvHw9DKZ6E77VaMFPdkHcrDeb8KsiwdNPjupK+26Q0tA+hKQzsRivPOCPB7WsruJKKqex1mZ5BQuBm/ca6h+lGcc9+lh0wVgXsQSRciqj5IPqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypreJhlI5ztDAx9ETL4uwlW64cL8JvY3OuMHb3MXoXA=;
 b=fQn9EaTzdp5bMpw9OW3QFBmYpJlXb7Iv8osLpD0OBJuc9Vt67PjaYfDVg8CNjOuuVjRSqd38KU1dQykStXeGpd+/ZBWa1v/MxPtyRJmd0VzVjK9+r+tvP7n6G65MOu3DYygt3C/X/NvNX+XySfb0hQVaS9fdxp9W2JrdAoOwwCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:27:25 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:27:25 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 11/11] MAINTAINERS: Added maintainer details
Date:   Wed, 27 Sep 2023 23:24:01 +0530
Message-Id: <20230927175401.1962733-12-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 719b34e7-043f-46c5-f4fa-08dbbf551b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvwPhToexW+r7wml/qVy99edPzFXL49bZSDzitCTF8eb4x2TLhMmoEebd5S4O8cW01vpzCtUI7DYQP2EyRZQ47dPNZpJOnyl4C3RpyLV1ZwdIIxTMVCH6zTXn7ae0qsx1PkcJCty+wK54Er/KN55Y4OeWHQl2g3qUMrxims8urCO1yH09r/9PiDC9ZqQO4WXdgkd9k6F4NFpXKqkeAt5bkIlkpQ4beIvPh7n5rB23AFDD0jAouWfFuxGWjkw7mUYpNMB8/eJv5MvduQJO2YnbFpEKJ37NGm08txHM221fX5uUwh6SEH/Hn7mbxq+80hBCxTua90v3ewj83Nhsgx6FX7T2Zu3fydOowc8VAn/Bg1uuinYP8yDhi8WwMeJVDz0+eJBHqWuYP16WDfjCnIfcdGp45pfH2cI3wUlXxlaYsaQOG3MKx34Tlo5AMQbrSbthOKqLQvDYfcqD63TuLuRLGaRGLHDpVXp+7sjAFg7CuIp+DdB0TlIyxY9zJ1GBOSJeuITf8mDTL4LXETj/l3VjYkT522oWnwRP83hElGJop5aDdQUGEHzV2JLdolDPtE7+ZiRXpo2Yna5qT+vraQn0yo3oz+bKhDsAFRnsP+S3WQf82PX/UKLb/GbKB0Ta8V2z77LriJhXb6Ru4+SW9Y9LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(4744005)(7416002)(5660300002)(316002)(921005)(83380400001)(44832011)(41300700001)(6636002)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9/OzcedipAPYkob7ROJcYgTTBZjzlBDNxVAMJIkZK0hRiW64r2rZLJPrS8V?=
 =?us-ascii?Q?vo4AeerxNZXSV3nRyCNy1+rDNbWK8Rz7HNI/ceJG+X9mv2IfTooL3uFdIkl3?=
 =?us-ascii?Q?SQ4DPhCmjqMDSyRy+L2gUSHAw+ft9Qal8uK7okuJJ0hgAbuPLF/VKYG6ihyH?=
 =?us-ascii?Q?Fs35Ra32q7PmXpwioyY1fZFYicPmvyR8ox8CjVGFaGCJbuh7Maj+KLaPxbVW?=
 =?us-ascii?Q?Lkkt90WL9/6sAMb7+4a5kzbp86Phampr81tXk3JIKjtxKqNt4YNav5MLQqk5?=
 =?us-ascii?Q?7gX8UdIIcOuLf+2ca3BIGzYOcW8mOSIWrI/rgEYMAeNGyCQ7QdQVC5DBX4M/?=
 =?us-ascii?Q?1CVrEDZfZ912UiaiAIMiEUi+h6/7DXzB2VbclYT6ewHp3SAkSSQKliPtS76j?=
 =?us-ascii?Q?CUd2k106pdTRX27Tq0cHpmqPr2dbzHWpNkTT4ZNJB23F6nlKgR7RpyRsPqD2?=
 =?us-ascii?Q?eU30vHx39JzTXgRQkCzGu/Fguytbu4/sr18x30sDoa5VTMzNn5yHw92bw5sP?=
 =?us-ascii?Q?UgLbbIsWPuswO0bYTEvOFv56L6SErSN1bLarx6+KMkie7irdmDzOzoI6vZND?=
 =?us-ascii?Q?Mvk64bKjEmo2tZ4Pz3xA5OVvarewGqR3tTY1B7Svy1TWe9fNldOevvC3JXec?=
 =?us-ascii?Q?X7SpZYtz2pEuc42qbWQDHjTWTfWPVi1w2X3IY7fxaIeApGKmL4LZo4yZgnPj?=
 =?us-ascii?Q?XhgVKhMXz/hmeh+yRWLjkIZRZxndb7Qa1dmSDSAgKTFRAvO6rMbkYdc6Bv5X?=
 =?us-ascii?Q?/cV6NFV7zYOSUrr+do0fP8nLgczYUotU3eQL//TBtqgjS3RS19zZBOSRmC8N?=
 =?us-ascii?Q?NZIbS7dwG5Ctsy4RbcSEYpz3ST9vm+etAjMQ7T8vQ35w7gfToVN2twPLQJRa?=
 =?us-ascii?Q?uJ+uHBaLZF+o4yrUuwV2cWfvQqjjHZ4wo+XNccwkOYpA2HHW2KweGDOeTzo/?=
 =?us-ascii?Q?N3zl3vHuhCzppz414TWdUW9UPZdHCaMEbR62gdFcKx4Y2MBN39cF4JI3rnTb?=
 =?us-ascii?Q?nVoBSWhRc0b/SVqr3L2vlJXmGwVnuor1Sxt1puYkVkgrSrcaIecv0/ySu3bt?=
 =?us-ascii?Q?O/1hCJ92eFl2fsXmc/YgrzuQteWiy74GZ5OaUWgJawDR9a0qpAsXMCmS9mpo?=
 =?us-ascii?Q?GHiP7Cuk5qjMvsEM/oJQvJ+V5q/3VLV4V1tTphc9qWM+nxaq0NRF0AmAP7br?=
 =?us-ascii?Q?XWnU6EsMRCoBv47PIn4FkArVCeeyg8pD2P40EYPq+slZtcGjRRmNu6ITDK8J?=
 =?us-ascii?Q?7z2P1FVr+Y+GZNf9ns7J/CdRiptjQFHLHA85aP2oxerLi7O6U/c6cpa1X0sH?=
 =?us-ascii?Q?YdcDK3mE7uYEzho18z+ldEG4pRVND0GcpFB2GPRfxrMEg4HG0ysY2zuryoeQ?=
 =?us-ascii?Q?rRrEjd+27f3jeXJ9wQB9RPuLjnDjFK3lHD4bqDeNG09QcLAMlIQHACYytRaa?=
 =?us-ascii?Q?KLQybMj/poVxUnfgCzE902Xjl44q43U/ZSTKlHYlCtAaNozDyqc4z6D0spNq?=
 =?us-ascii?Q?MDql+FbR/Pj7040PxTceLy8KygOevnnfVwWVdKXp5WTDd2suKINVZqxw643O?=
 =?us-ascii?Q?rfzBozWvX6GQxC6W20JeLmMVgZMkbkDxO/weldUI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719b34e7-043f-46c5-f4fa-08dbbf551b4c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:27:25.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGZou3ZpJW/AsV1HdwayV2Lu6V1IpjDCAwX8mFl7Sjqsl2JzfYDJDucIzhj6b6oui9GTAM/LEtqfkGU2XB7yEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS: Added maintainer details for se-fw driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..61e69dc247ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13758,6 +13758,16 @@ F:	mm/
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
 
+NXP EDGELOCK(SECURE) ENCLAVE FIRMWARE DRIVER
+M:	Pankaj Gupta <pankaj.gupta@nxp.com>
+R:	NXP Linux Team <linux-imx@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
+F:	drivers/firmware/imx/ele*.*
+F:	drivers/firmware/imx/se*.*
+F:	include/linux/firmware/imx/ele*.*
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.34.1

