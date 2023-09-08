Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798D7987F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbjIHNeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbjIHNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:34:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA51BF5;
        Fri,  8 Sep 2023 06:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqhNWsjEeTfxrn1jStt8dYj9eJyIVn97atz38MLNL5FBUSlZRQ5eR7PjJFpo0g3f3X5JrQ4Dpuy79r1rI15iCrYNu7zesnrKl0zV6/mOO2d9RPtbmHYnow0ZhyKJe4JYT2uhgM5cZ/STr1qoNtVCdWX9CQ0FGgcSothbkk0o7K+W+NVhvLqt4ej9CgvQryncL05a1NtbD5i9UBZ3ABd+QeOTzyH1+80xOsFio569EAqV6YxWlRyV7pJxXXP8epULK7KvkY720yWUWE+RGjjVQPU6L3wQyWP/YzAKOMAy/yhe/duzcwc1pCTvkMBTyWiXYh99yDUNaRTUt6rZ6BWtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySJTRLEGqGbB3AVN1DuxY0Qnndm7K6rlK8U+gwGYmiU=;
 b=jPQSH4YHiEK75OkYlw9yPZmxg5uzr8WMA4bF5OYSBY9u1weEGw5o5TEsR7k+y4E7c/j6nqvXdmRjzJlhcxC2Zou5mEZZAxcI1RqxyFoW5jNJhkvFIrZl5Tpfn7um3sMjiVFI1N2uEDSmVfKqLBN3r42Xp01PiVsKsTvgQ3yWQUBRtcQgUa/S+IXaGD9pCmJikidd3F0vWrVUZi1Do0yky4dsMzDZhRnVPCcEgZyTJ1R98xJ0NSc3TmqCE4QtgVZTYxHEANcnBl8mcgGATvxAvAnt5cMLZTptifkDssS7TiKOiv7EdixIlEkSL2rdS1ufMV9L5WBfrVOuA5NceYTv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySJTRLEGqGbB3AVN1DuxY0Qnndm7K6rlK8U+gwGYmiU=;
 b=RbrFflcdmJhOmSikz9mFDYwD9QkQT5X4eub9LMe3UeJc30cyYYOMSM6WWxKe1BsaqVVXljQH2MgKSyG37Z+7DHE6JkSp/rVVWU1/WzDDU7WbcrYVErNNS8UItNvCnZW3rF+2BltWmLUer85h8EoJi8QeRJew7pF7ih+FbPyLGdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 13:34:05 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 13:34:05 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/5] net: dsa: sja1105: propagate exact error code from sja1105_dynamic_config_poll_valid()
Date:   Fri,  8 Sep 2023 16:33:49 +0300
Message-Id: <20230908133352.2007218-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
References: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: bfddfd14-ac41-425e-aeb7-08dbb0704558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvd+oZA9MprYD3NHC3S6DVKi7sn+eEvrKdN4ytciunQChPFIif1M7jniAfM54TQObK9/oP3twNNqn+bkw5YZgCQuK3a6G4ZV6/mF89xxdTjayficnQr3OEup8C1baHGOYpiNWw9b/OHcNbiTTlnki/O44jJ7a6ouFfkt1gjGdJzD6PgBwK973MpArIJnmH5tDkSMqgDHkX3gs6eZNgEckTQVZc7TSdbBURr9N67wB+EzVoUWJSAyQtLtF3rP47WVTFtrhvU7uqqQVlfypHJBTGrSPV6WcOwdgWSy//C9wp+eZnDNCFL7V+wGGXyui3ZmFZLRoXNfpZ6p7gOxpQtgOJZ0pnW101hJ/47tIp+AOyKAODzggXV26C+G+Xryvh0F/8AgwbUrWezGkuIHRLeUTHx2tJ0R1ADN2CZA8Unt88qLwbPbqPzkwi37BCtZUlYKIhMSgmCo6i0rYQLsTOAF0rgq4oig0MWx/8eIuG+xH2YyOFNxYkovacmp7H6/oPEAGVSCnP5feAppDxw3JYJ20llxGmYbI6+dCmgShxREtEJKlpvw/eAmlIdfzXZ/GIiVpHJ5RoUE9M6IjsiAZgmOAm9xIEqhdZtu1fyhB4lxSro6V+crPeIYnhnCMtv5px1h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(2906002)(38350700002)(38100700002)(36756003)(6506007)(41300700001)(6512007)(6486002)(52116002)(66556008)(54906003)(2616005)(66946007)(66476007)(6916009)(316002)(1076003)(86362001)(8676002)(8936002)(4326008)(6666004)(478600001)(5660300002)(26005)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mm6nMtPIt8qqPTr7ooXrxWUuo1wPGXjLroiPhq4SqB/U2EuOz9F0j3WcNeKQ?=
 =?us-ascii?Q?y2Z53iU6WfSrJ412tYGAFpDyEEsrBevcBrAdNJUhXLNQSWKDINPm5sJ6WcOe?=
 =?us-ascii?Q?vYXqGj38SAGeCoiKlgJGrzUPLjJzmbUi2IqpPPKfaSHF5HY4avAf1DHVE4Nx?=
 =?us-ascii?Q?sRf86B+fsTupnMhjXbFp79suH3Fl5QCu+nEv8em4eZXLTopFVKb+6XtRc3LB?=
 =?us-ascii?Q?T2rmWey8067NPPYutbbrZ028t5zkVEt+yzOGNEk70FL9Gg9FTzd3dj9UyW3K?=
 =?us-ascii?Q?ibE+Rn+ycI3apRIV17b3o8pWg6748ABIMao/ng6n3TtzXCQLUD+gJdjozTCB?=
 =?us-ascii?Q?uEWN3b2/uUaNJuXtnUlOuBek8lTEhVlLg7bGJCauJU4OJ3TJwsYGmqSRlpEN?=
 =?us-ascii?Q?UrXBEoF3y9Ceb+ggKOvGBQ3T933lMPU4iO6bB5dU/1jaIruVPhcmcnasPbR0?=
 =?us-ascii?Q?1OtxsHgwYl0YihQ6b2CcOLlB++QOCC4b3p8Gzqak8xj0wcDUkQe5wDPBplSH?=
 =?us-ascii?Q?bXliK8rA+iYfyTfT6BcSXT92evVKN1/UNlEyCCNeSNRolYmw/+WzOtmVbRiF?=
 =?us-ascii?Q?z27h2zAS2DGPCwb3LAehdIUgQuJmdbRRAWy+QvaxojJRBvmOpIuHNTcGRKbr?=
 =?us-ascii?Q?sIJObbl14ZHdv394ztLKmw4YJOjMZ9/CzRqumGvKUBqikY283TmAtSVmFKIU?=
 =?us-ascii?Q?LCMPCfBfp7pEQRgSywnKuPZMLihMy+4EfvCTmMZQokQ9svZA2iM4wuQDPXnm?=
 =?us-ascii?Q?VZMiBfBe+XDvvA/HUSMoKUwXs7Pe7GRiGPB35JuGI4HAI0321RJrLE0F372E?=
 =?us-ascii?Q?yOa7GARbz7A+rAQpSpXjUIEOeW/GfnzT679bIaOuT6eZgFNKABEHhq2YTWQF?=
 =?us-ascii?Q?Rik7PPZ8PYPNWssep5M57oCQ2lbHRJgg/ov7IDWVVjUorzDdQyqmCY8dcyWV?=
 =?us-ascii?Q?3iy1o+9rUQ2Dl/gC7YFDmCNoPtTtrRFagpvOIgnOHy5tSEt7Q7B7tgH4/QJy?=
 =?us-ascii?Q?7ibj4kfLcJdquQSt/n01fPpXyqY9/AEf5xRn9S/CL99GLnQpPVkgGx2qwmF8?=
 =?us-ascii?Q?lensxPoNZ54jT3UonJ/PJn+ccS/vKIz11zDNQlahPBp0GZG53K8OEHQT10VB?=
 =?us-ascii?Q?Evfx4+Znywv8IeKcFVdJKSZ2jqQkg0Ix83LdDC2o2XfJ8klr7JtZWGUZASCR?=
 =?us-ascii?Q?V9CRqwXUMLhUb9I0/Z+XbOrLwyIg0ce1/gtpDKDoqUSoE0+qpp6X5ca810fr?=
 =?us-ascii?Q?dihteCB7j6hCQTzJDi/8enuo+msagQUhgVMz/gd2+v8igcZaCam6CsKC0u+B?=
 =?us-ascii?Q?BCRfhnLJN2rMdHWi+3zA8bkkDHAASNREtebpgwPailtQnFq1gDaFEY99pXAn?=
 =?us-ascii?Q?/cL9IlzUf8ujTDtUNe2FWOvf0cdgo6M0nIHQvi40Onsqs0UnG5P8P8VQ9/WX?=
 =?us-ascii?Q?svgQ8Y77f3TPer5f4fOeURRXsf553lnKYCmIaCr7UVgW11BJn5YO8yy7gg1N?=
 =?us-ascii?Q?KZTsZOCTIaSLUQI/CUffIWyn10mF4vvdls7oOaCYzmJMLs/pVunwQP674FS+?=
 =?us-ascii?Q?KHcyWHJ7yxfSA4A8JlZiDyELuDl+hXkZ66hUGAiRvtYwEvc79Yko26fW7Vhn?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfddfd14-ac41-425e-aeb7-08dbb0704558
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:34:05.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNOB4KaqnTlFsXR57DgYFHE7g6x4I/VJeeaKnZxdjEosVziz9xb29/VevFVkDcb/hOFZQ2uldoL3ZNqxZG8zHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sja1105_dynamic_config_wait_complete() returns either 0 or
-ETIMEDOUT, because it just looks at the read_poll_timeout() return code.

There will be future changes which move some more checks to
sja1105_dynamic_config_poll_valid(). It is important that we propagate
their exact return code (-ENOENT, -EINVAL), because callers of
sja1105_dynamic_config_read() depend on them.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index 7729d3f8b7f5..93d47dab8d3e 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -1211,13 +1211,14 @@ sja1105_dynamic_config_wait_complete(struct sja1105_private *priv,
 				     struct sja1105_dyn_cmd *cmd,
 				     const struct sja1105_dynamic_table_ops *ops)
 {
-	int rc;
-
-	return read_poll_timeout(sja1105_dynamic_config_poll_valid,
-				 rc, rc != -EAGAIN,
-				 SJA1105_DYNAMIC_CONFIG_SLEEP_US,
-				 SJA1105_DYNAMIC_CONFIG_TIMEOUT_US,
-				 false, priv, cmd, ops);
+	int err, rc;
+
+	err = read_poll_timeout(sja1105_dynamic_config_poll_valid,
+				rc, rc != -EAGAIN,
+				SJA1105_DYNAMIC_CONFIG_SLEEP_US,
+				SJA1105_DYNAMIC_CONFIG_TIMEOUT_US,
+				false, priv, cmd, ops);
+	return err < 0 ? err : rc;
 }
 
 /* Provides read access to the settings through the dynamic interface
-- 
2.34.1

