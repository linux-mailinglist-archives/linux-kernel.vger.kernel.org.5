Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC180319E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjLDLhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjLDLhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:37:43 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECAEB0;
        Mon,  4 Dec 2023 03:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjutKVzrYO/ptM0lLPmwyndd1ndrmY0Jidl5Cepo+mpC3xEfepyQ8HYmQo4WUUUgrSU87DRaPEdbpAiNwIlT+Jz8mkytitWo9k0MuGCQ/UPumAa7L3yxew2FA38m/prhJhDAopxeOONeAtxzjdyEEBr094N7Ax9cyAPLsL9rV6FPPddbUh5Jd7e0M/sDBwL6M5jBgsOeY+nyaTm1x+eg+E0K4SY8R4FwTDE+sHzF4fAuOiRZ5ukHLqgf5nava6fOABv648JrVN6nso1F8oMdKK9iTsYIG2ijmfLQVAHwdMWEMZSkQtMUk5t27yV2o/m895IkvSLRAWSTInOBqz9hNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsI8AmSHxDc9++mPZHuKZ+nURaI2GVzQqSoLx25NIb8=;
 b=JO4K5FXGuVc3mrHMYN2uvIJ0l8b50mdWKgLcqKF2YIiy3npY4x/J05izRA6HKxP0Pqo+KAaT47scMQibhrwiUCAmXMbcoomXqkzwvhSOERBY9E2L6orSvGeS15YHi3Vefnv5mLQdvzskOPJp461Og1kSZU9G/t2NajhjB8y0Df9cisQ3iuYNlTAdFkJM5vxMOA3z7Z8/tTH+/IPdSaZKicJqhVvm2cexiF9yvP5c4VxYbKhPu8s5Q4EkchN1VEjsffD+yOl6KgBygs8m6lB+wxGiZAZdmCmwBdXEh6nc2Q7mDfJq6VxG4JluQ/PaHiXK0iPi4TBjO1ROukOXkOUgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsI8AmSHxDc9++mPZHuKZ+nURaI2GVzQqSoLx25NIb8=;
 b=eVIm0y3N8lbJ7NzOBxO1mBnfB539S+Qim0EzjpeR4b375ynuKbsRFQGtAGeTPy4yiGMHBjCAoObDYA33nt0SksIhuM0tsxGT+PaAOLy457fIOpynFWXBp40utnLPjEnotgn6ekCMQMFcVNhdlbKK7KjYvUqzY4cwCQ81C8yC2KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DB9PR04MB8089.eurprd04.prod.outlook.com (2603:10a6:10:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 11:37:45 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7068.021; Mon, 4 Dec 2023
 11:37:45 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH] ASoC: soc-pcm.c: Complete the active count for components without DAIs
Date:   Mon,  4 Dec 2023 19:15:32 +0800
Message-Id: <20231204111532.3165-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::34) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DB9PR04MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4851a649-db44-4b1c-14d4-08dbf4bd6f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dc7/fZk17yOCpqasuc3ZRcZdjCk+EwXpL9EwIc350++TMyJ3GdMbOnaXPgF+/wl0zHxAZaWFEHmNUES6ho/XwOfz1WbP97uJNVcOO6kcPD950AnYx7pgxTyiC3HX/V4otnfkLDUs05xu2N49B/9QVJTQqGRr7SYKv3CZ5ej0AToRMkLZpJPzcoLDlwk+6o+j2HWvSQ6UBTCKRBKLQJOxEmPSH9rQdnSoOx4g9J7n1LMTwfo1Kt2LblOHvHJaneCgEygiaF2kCcOuPt4L1Dh/g+jSLrsiY1QidHkXbMN45FvqHPSI9TYoM4cfkZO90nvH8J0OW1Es1Phf+rRHlLSYOCBVSwgnBBDoZdVuiI7qt8B2IHVAthOf4YoQZVuugZnJlGgAmT4izHMoAEgE5bexxdkqs94fXPd/vK55I9rSOvQMH0hcmyzgqyDnlryi1fDXTFpyF896x2tcaOIYgyxGuvlE/BW0q0OmuIVjQB6tjDXWiDgfRaRDv/FnycpJkJH0r+znoXt3JWR5hKmGxZ93thlKUReWHKYHOd9AXPv5bEeKof5V2DQnJPPIG0dw/15JNl9Ao+WprQDiIm/wYns7IPOTCbAaRxXuNVcV9cuMAOCkm5AIWE29hUkttr2um6E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(36756003)(41300700001)(38350700005)(5660300002)(2906002)(44832011)(38100700002)(478600001)(6666004)(6486002)(6512007)(52116002)(6506007)(2616005)(1076003)(26005)(8936002)(8676002)(4326008)(66556008)(66476007)(66946007)(83380400001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FcDpz8NkdOEmb1CWBSBGU7YmXgCo2Y3vyGu9jVGrO3qVoPnMP/fU2c0j3rj8?=
 =?us-ascii?Q?KrLzY3bLI8ADLrZNmDpWJBzrBOQTVuGriqdqQa8zbtO+/r3Sa2RM87jp4q5I?=
 =?us-ascii?Q?10KpOCK8dDeGaLUIO14rUlX9mHXpdh9XVvCMNTVBZ1mivV2poNPWJuZhUmSP?=
 =?us-ascii?Q?XZOZw6QF7gjii0cU4HOmjzJ6RxWyRzL0jqdLnfsqM+le9NICaaygMitpQz+6?=
 =?us-ascii?Q?bW3FAK45cG041CW3ZjZ+BGFZpEZKs0Dlw4aF+Gzb2LciZkhWgF0z6xLlhOCe?=
 =?us-ascii?Q?ArIb+61naB57TlKYjJ4KKZ6f0sf5ZWwsX0j7h8IR86CILmWQ4J3bbV8LEF/+?=
 =?us-ascii?Q?YS+Y9iRpLULPUR0WWodDIneU+Nacmx//ymZGQ1YKmO2Zzahcc6plHAqqH16t?=
 =?us-ascii?Q?v2BwZ0HAmxPapOGKvQL2yjMB9WBirX0ygDeGy9PaCdpN5beOVygFk93bDcQP?=
 =?us-ascii?Q?ZCtFMQhoHrMqGDGWaBfA3Ui86rJ4tLpzgLavzeqBub8+aFac6kZX7kZ5SXWd?=
 =?us-ascii?Q?ifE+/bVYSUR7N6Jn7M1HINWw+tiCrPmSFyFmlJWC9tPAdhdMgz1xhZMm162O?=
 =?us-ascii?Q?ANPdCed9qG5jIjMAF+q9jO83edxY8vuTWps7/6qvbWq5fPYeJ/MEf6iwEGlm?=
 =?us-ascii?Q?CQsp+DKjVLpIFNEPgfM1omUIPaX7DXZfvXaMah+l8nWCS0YwjMFuWE5BQnWH?=
 =?us-ascii?Q?P59mpFZwz8+jyGRGRxsMv3Z3LPA32Ky9pQmGgMffuQTnkDNPZ0qsQW87YoFC?=
 =?us-ascii?Q?3VALW7l/jlUg0Lm7na+H4SHBMcWmnuKudNFiKbs4g9JyVkgQC9v+q3dk4+XB?=
 =?us-ascii?Q?LJaIwHEb9DNdyKjVDV5QAm/g+tfV7YYEJjtTaiJrSaW92xVgf2PP3+InIyH+?=
 =?us-ascii?Q?XvTWXdYZHBoFZ9gKmS6pp+U8T8wAAo2kQSpL0RMOe8pp5cBkR8TLSJBvlBYw?=
 =?us-ascii?Q?93rhxBN6KgksTjXGlTk/b7dYYAZlfLg9jEG9QEzaH6Wur/QBbjbGcuHbp0k9?=
 =?us-ascii?Q?mUEl/VnyuzFtpuwMx7NMIl4iPgm2QyXFWH/LZl1WiTSSZc0sIqMv8AoOOS8L?=
 =?us-ascii?Q?XbhgNeVACYdUuMVxhpBbjFeIPgs46LYaa+n8L5SHu59BpJEGrlF+vj76thoo?=
 =?us-ascii?Q?x8WimvfM05ynugrbUyfskX2Y4K9TTZVF1TGlLCR/zWcubJtUaEjl3mBL4rhq?=
 =?us-ascii?Q?B+Q6gdlXrBY2BQW822CJyM2Nh9d44aFNgeJauJhztlC8AxJZCu8Mb/8FR5Dk?=
 =?us-ascii?Q?aZefL4LITqeUqOj8qTkQufaHcXsuZQDh4UGBcx/HjHKQX2947cW6BNcg2/xZ?=
 =?us-ascii?Q?AwOurXlh90WmXUidTCQ059+gTxGYa3FzEgWa6H+emegi+Ynbh8Dq7pDBfHm+?=
 =?us-ascii?Q?ZxxuEVLL6xPhg/X8N25Xqq9nkGSnrfDh9g5ojsmUZgJh0o+/iyH/2HFZbpI2?=
 =?us-ascii?Q?yhGpz3IIJyeojurVG9TQhXr4VNeEd9kUkv7MKTQz6B53eOTmHzPIBBpF8urd?=
 =?us-ascii?Q?jfLtoTTEsC6rBMDXChpnrpeZGAgP4rb4pJVoCXvDVww2t55pHw1j+x4iLO+j?=
 =?us-ascii?Q?LStPWrSWmw5BV2AZ3Ai1Sq8N8xvJJOIC4uc2uI5b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4851a649-db44-4b1c-14d4-08dbf4bd6f0d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:37:45.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oq6mKeRDkjHhR32SNRfVfcM+PeKF4Jo6BmzI8/wtV4njuOCu2r8sU7H6ru8o1PuMTHanosvy56H/ZF1Qm2bQeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some components like platforms don't have DAIs. If the active count of
these components is ignored pinctrl may be wrongly selected between
default and sleep state. So need to increment or decrement the active
count for components without DAIs to avoid it.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/soc-pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index efde4203bbf7..7dd4d41f680a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -292,6 +292,7 @@ static void dpcm_set_be_update_state(struct snd_soc_pcm_runtime *be,
 void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
 			    int stream, int action)
 {
+	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 	int i;
 
@@ -299,6 +300,13 @@ void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
 
 	for_each_rtd_dais(rtd, i, dai)
 		snd_soc_dai_action(dai, stream, action);
+
+	/* Increments/Decrements the active count for components without DAIs */
+	for_each_rtd_components(rtd, i, component) {
+		if (component->num_dai)
+			continue;
+		component->active += action;
+	}
 }
 EXPORT_SYMBOL_GPL(snd_soc_runtime_action);
 
-- 
2.42.0

