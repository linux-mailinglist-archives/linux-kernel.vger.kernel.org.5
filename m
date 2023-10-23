Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1027D3C19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjJWQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjJWQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1A10CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEnTgr4uz2GhbpBNOlcEoKnkMloS2sDKKkKLTLltEf65KrsPVigmVbFYTlnbEMLv1c8X3QQFxzT3VNssbmNWHpaabWe1cPlLJOs5Z72nwBmDlxFHRaq4XyVFNZpyfVZuLdOhW0bXvY36bfaRqbmrWCoUtAdlVr6ZLtP9r2kCQhw5IH/YXxR0/rHCFFnydPJM0Vy06Hu6FytXa3odODox0Fm4S6qH317mqfYmDBX9iDKx9cMxRHvpF/5XDITmVYZPD1OwDT6+UNFYP+E6Gjail/tq1ht4SU2sSNpIXzU7/zUXyvReeDkgBOt4jBO+ZSfWRsO5KzvsDdN1aJ8aRfm64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Eg5x0kveUbh+2VLsIws1d1wUUv0QNkE46sI/KeRdQ=;
 b=eRsX5YV8+u4UqoH611YbcOc6K/dLREz8097MsRG65zNVXCI63tTrU15zxsTh80UqEwwzutq+lxdiBbxxl0lwJL1pVtzI5GI262sf9ywavGD21kVXYp/hQSqL1NzsF2JeBVEA5JeFK5Tv+B5ZkQ4cJHuYFNJKBHW8XT5lfAxwwjeeadVf1Lch/Mze02e2CQEcqNmnXfo5wbhi5OIaiwbpYEOKKT4XifiO5ofm5ZpydqPsLh4/gcAjaAKXCDEcF6qaSvrI7ybt14zkciDa9SD5o8yAgDxatgoin7TSs2E/dVkJ3WYR0Ix2AR+e0l26gbbZvdeuSBKUgp1igrfKqbvFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Eg5x0kveUbh+2VLsIws1d1wUUv0QNkE46sI/KeRdQ=;
 b=M4IVsNvYUbSIaNCQkpM55WwkhvzRFYSjYcn7DVy+SbFHJaP6gANqENhO8mNMBxrq0KUVEEmHn9jwe5UwrI4BqZBO/CgAqHwDARvXXajaEjF8sPuWSOlk/HpkG1LuMjvWCOTIhVMfMihXlrlH4VI2B80Lkn4PiemltwtLSm+IAxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Mon, 23 Oct
 2023 16:17:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:17:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] i3c: master: svc: fix ibi may not return mandatory data byte
Date:   Mon, 23 Oct 2023 12:16:55 -0400
Message-Id: <20231023161658.3890811-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1090b22c-74d4-4639-68b4-08dbd3e38793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOayPqRAm1d9ObrnFbDFrySO+h1SeZuHIyndiZlVwXqzWp6Nemzxk11touoRt4k9yUnyYdIBNiL0iA0QU4qu4wlPYM4bm6pnITBH1/yU7IVRvaXA6RgqiCv2xiBV2zsuyq0X37riL7KzCYcrsOdQN8CDUu2n8jL+3TjNypGoR2JoDjSDSbmXfG0DrmAlW62JbYb40OzyVx2GBIwkLp/PJz4Gzi7L4HsXfNBgkyfOHVGbYIPtsjbgTpImpxw10lBiZplx4/zknzbvAYcp1JgEDTtnVBx4Xl2eINk8sjRQTHLuEhaffM0Hh/R4QhZeQbuQ6atbTkQ7a2LWTdWiaO2mys18159RLHJIPf2jDrkcKPa00Otgp+8NLbeyH4L3QjuQ6sIHZ9UyRaM+wXhPd5QlC9hgfkH6xQ0B8JROlh9mI5WThsK4q0/67tMD/gsUc19VNbuHsP9IrGPCKEIdlQ/8PaadK0XBf1mXEMZJeTm8WeRikmMyhUV/r56EyoTvgiBtsYpcdUABw8lc2CK/UogKk/zbrxWM7fNHz7iyNfAuXcI6Q/v4msEuWEROdD0nxDwCBtDQSOIDDEmImYwESZ6JD+NZ7NJjjyseFPa3JJzd7jsIjD8VweiPKNeWUEY3dkCd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(6506007)(6512007)(6666004)(86362001)(316002)(41300700001)(6916009)(2906002)(6486002)(5660300002)(52116002)(36756003)(8676002)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(66946007)(38350700005)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0axMwlIomY2+G1KJdkFqix9Mo4htMPR0YywEiu0RJCLrzMF9VLRYPKZFF+b?=
 =?us-ascii?Q?gtZRtqtKmt4q66NeaCd4/shde5MAoosJL3alQsh9PtATadobez5Vei8ACij4?=
 =?us-ascii?Q?pjf0s8QlUs7jfw7P7Av0AUMqMEFLEPmxIzZuhrQP6tI0/gPgDdVa+rNslDSd?=
 =?us-ascii?Q?XYn0iZoPDoOXEHioHC7DBzEH9WB30TdmHTHt6oO2zYYqqKmpJ5P3BVdNOQ4Y?=
 =?us-ascii?Q?URLwFYGtrOwNYkNZbZ2cYbms881ozHw8iFXCbbHLT8Q3ujTkxjSGxdw5zhvc?=
 =?us-ascii?Q?kttD9ul/Ag+CBzvppy7SntXX2xhVMFEtfFft7+lNfh0q1cFReggpA2z52UJw?=
 =?us-ascii?Q?jHBVXH2f9gtGx7JfIz9UZw0YLAn49yek1Dx8YSwzHqHExLLvlADoy2dL5eWj?=
 =?us-ascii?Q?2Q53bkldqcGchvmBkS5N6u6dz4QvQobdQaj0zKu64YZSCYIsj92CvdALuV+M?=
 =?us-ascii?Q?pHFuHMxoAtsyUuNkWNh2GpSlT8Bb6gXHFIRm02MQBuceuQeYVTrWVwjUW9sm?=
 =?us-ascii?Q?dU+ng9qqSyIOdnJkO4KQZ/zwLoPEbNuVypi98EGSX3z+Pwp+01aka1JreUxn?=
 =?us-ascii?Q?wX4aS369y9ixVcnpK5vTDf4BQlkIDKNelgOjkIWt0nIQtFraCxDqdORpWBIX?=
 =?us-ascii?Q?BQP7bdIuhv5Cu8ZWUBGnVjrVwkXdxSlmPDvGIA7D5TlpwnikShA0VcSVyTZM?=
 =?us-ascii?Q?R1/JD+q0GRsfZDUHijMy7OddhqOdWS0D/Z2ovosivGDI7PSssseSQ3rW5s5z?=
 =?us-ascii?Q?LKVzGNRcWuJlPu5+kPPUaQrxG554+sgP9Q/3irzAp4+OIbmQz36Q4VUlFXvh?=
 =?us-ascii?Q?X6rM1rnf8dEXduNqmExn0nzJSKSL2/TEmsOGRUvkDqh59zfvLbVVLkfqNfNC?=
 =?us-ascii?Q?37D7QjNQKzIMPwlm1WNTBddI4FfYKstlT0ujuM5DyekhRFu8pZO8aYzRo/uR?=
 =?us-ascii?Q?FWuuSm6SbmXWVevRo1lNwPB9TZC1xtjqRGzvwugdYLJB8qpU0fqceypW8jd1?=
 =?us-ascii?Q?1pYqTX976gyY4GaEfhXioTqbOknbyKx5CWdb/H75vp5eEzRHD/pt2pJF9s/J?=
 =?us-ascii?Q?nuWWS05kjt9ixzeBTuDY9rH1pD4wjJymnh3RuHvcUzR39buxLW+dKi9oOagA?=
 =?us-ascii?Q?QpKjc8JQwXww+TIe6jAQV7c4ZubXgDTcxDcqDbidSSDv9HCUb0QZPoepXqRW?=
 =?us-ascii?Q?SIekJRMaAYY8OBInYLwuLV5azlcnMxCTgnNOvZFK90Hgvn0muWmpyXuu6Dcw?=
 =?us-ascii?Q?xZXCOItnFx0ntilVL4LY0pn1XV0/W5H4V4Yu15zB1Omhqo9H2M/LYyOgKucH?=
 =?us-ascii?Q?cjMAAcaOEDstNhEoXxsGy8AGjSesZmjwe1PQMhkz+FAkDgAqlpCgSlUQdL7Z?=
 =?us-ascii?Q?7bqgUviDdbadNnIJzXCnPpuWCv3OxfEqBuul6EqrAYcoFBJJF05vkqPCo8iV?=
 =?us-ascii?Q?nKxDrbfG4Y+INNf4wFLFThmUSGMxaRR3Oir5uTlUMgWy7e81nUu4ecYBdi9N?=
 =?us-ascii?Q?jwA4Xm7yGLByegqU7jpcafl5U8VpoqQ5Dx2KqnbK9hyH+A9ldlY9UMkH9tB3?=
 =?us-ascii?Q?Y28UwFHmuV9nQpnmDrhSXhH3vEUh2sdU+o0qlsiR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1090b22c-74d4-4639-68b4-08dbd3e38793
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:19.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1Heo6JT1FJKSp5sPlkvWlKQNiOIn6xOHdZiLUs+DaLbYp+vVXd74xOEU1UWGCeSHiikmVH49LbfR7YkpbucgQ==
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

MSTATUS[RXPEND] is only updated after the data transfer cycle started. This
creates an issue when the I3C clock is slow, and the CPU is running fast
enough that MSTATUS[RXPEND] may not be updated when the code reaches
checking point. As a result, mandatory data can be missed.

Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data is
already in FIFO. It also works without mandatory data.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - add review tag Miquel
    
    Change from v2 to v3
    - update commit message and add no mandatory data in commits message
    
    Change from v1 to v2
    - update commit message
      it also works without mandatory bytes
    
    Change from v1 to v2
    - update commit message
      it also works without mandatory bytes
    
    Change from v2 to v3
    - update commit message and add no mandatory data in commits message
    
    Change from v1 to v2
    - update commit message
      it also works without mandatory bytes
    
    Change from v1 to v2
    - update commit message
      it also works without mandatory bytes

 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index abebef666b2bb..dd06b7c9333f1 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -332,6 +332,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	struct i3c_ibi_slot *slot;
 	unsigned int count;
 	u32 mdatactrl;
+	int ret, val;
 	u8 *buf;
 
 	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
@@ -341,6 +342,13 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	slot->len = 0;
 	buf = slot->data;
 
+	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
+	if (ret) {
+		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		return ret;
+	}
+
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
-- 
2.34.1

