Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E128A7C88A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjJMP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJMP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:28:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F087B7;
        Fri, 13 Oct 2023 08:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3xmHRQF+qmIl6L8eb5qa6pXnxwj/Vh0rxCwZyUR+QrA0bBrsiZ3nV8W45BOTyV7Z+q9OshSuvIivlN7B2KNS/ALvnltcJj88/uV/+UNZE9hUIMXxufsDqH1+KFLfE6tNGdFYMVzkniKnytVfimlh3ke5hljTqhoVOd45mIm3cZ1QYLW2RY1Fm8UKKWvOLJtsOP+UJiY4tuuo7uErOcx3G8H9msTSU4iji7wn5GrDZnwBBgKD71URKWVhowQhJBvaMk0/ACabAPpM5eaEGLhmst5PQcDEFKHO17R3Cjwc2kWkkrLmD/uxZ3Y7uKj6ZQ2rnn85ETBUrWGMooqTK2LtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=VYOfLpv9xO/Lt56tvveLjAKtSu6Ba0+l/uC313vSGxYZQYLKS5/CjSDHKEn2JfjdB/UTAncend9PN/sfQuJkiIIX5RNpcqnp1CzmVLHsQa+8lC7GFmNIy4HqEdHs4Frgl8CS3V/vWPIMCcJSBWJ1egDsYlE95C0YTzeELOCKpcoapGL61D8jFeMy5TC/DTaExjj4Z3W33TLfBTa7FNV4PMDo2z+24NouoTJ1VYrJ4riD0oiFZ8tqcrsD81TM6DHXPvfvbNvLoPqAWlbSZcxud7fPNuFOnS0O6a3hZDioLxye37vK7Rv6ruHurO+sa25vUWHG5TkLF6lK6mo85Y0mwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=JF7bCf6S9KCh4dahM27VQpynCIiQPHZGlfSnLSwt/sQGdzL3/yOOEGrNLUPvcLrR+s//Z77OdDgiImJjXLpvlI4JKYQ8PfvnYBIVlQx58v86m0E6H/pBlIm+ikObxakKzAvlZNexVdCiDQHTsot3NQxyqqywvwtAiNQPBlAgMD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 15:27:55 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 15:27:55 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        alexander.stein@ew.tq-group.com,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH v4 1/2] remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
Date:   Fri, 13 Oct 2023 18:27:30 +0300
Message-Id: <20231013152731.23471-2-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
References: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0169.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::6) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|AM9PR04MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb4fd61-fe36-42d6-62ae-08dbcc00f93a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+hcCS1hf6b+Y7g4AxIFAUZaJr2+SHRdgS2I9Z5KEDJv1iNH+Ep44AsjPtRQNE7Laj1VlVtHfgkfP+nYdfqO6FxyUQMXg4gYYPN2JTC5fXHyQKISfEE2GzaWw1mftX7rHi+KDnq9MQ8tsA9r5IFH7yyuvgdPFv6busakr8InZM3mEQ0vwrb4Sj+zZSUAk4B+akb0DRkYTQC//lplflSsHoVewl9b4GjM93WEANnyqdG+8rFC2EXyd5/+hOUeljvltv1qVrmsOHVwF4gMA0uRHLVfkjZ6ULKBshxGRZfkMEdNFj91rw9GE7DG+VBDcCwHPJNoz7mni6mPhoOu7G+P5XUXvD5siOdWgOW2Jx0PwT7JhggKsWJ1ODmw5WGGELNpbNWTjQjkufm355pe7pfW8NuF3B//IAaMn58nRkJ0oalHt/xeIHOlW2/grr993dsXxDU2NXI8YGzyDeY6t99VTHB+x0zymEMnf6LOd25PK3Klfcf1BruNvAJKYeWQHtY1FW1h50beDIa5vse+1WpzjAessDys1as7ZgNtazYwLh7HDrwOe5yhgonVMeu2c0KHxR2G/uK32vbGlKHFs/x+rslTwa17w1XNe3sGlJdehUWlZnnX3ancaO+kWJ1fP9riPFJrTYuk58GkU6wJHGkhKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8676002)(5660300002)(66476007)(66556008)(54906003)(316002)(110136005)(66946007)(2906002)(4326008)(8936002)(41300700001)(7416002)(38100700002)(38350700002)(921005)(26005)(478600001)(1076003)(2616005)(6486002)(6512007)(6666004)(6506007)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LEA4ub3Klh//0zceBcXICEbbEbfbE5+8tPKiV3WB27VdwD3FPTLcmX8wb73h?=
 =?us-ascii?Q?ImO4wKK6XbbB/8qH+5WfQDERK4Ubtq8E9rYz09g2duJTZL8S6Amb/pzk85ch?=
 =?us-ascii?Q?XtVj1L29fGRQ8QmOhBnV2VnwIbDa4kwXzvrs8v7P58CJJIsGXT4ezKsEHaO1?=
 =?us-ascii?Q?u2tuuwsncp3Hu4JIULPBUlzT2tZ6vD9Tqjk8kAj2mufkOExuLDNDChqzW2Ox?=
 =?us-ascii?Q?aSxQjhseNgh1qg5c7O41EXLSsLZ7uDpI/KUX9bOGoY4eCb57ebiah8f5pqUV?=
 =?us-ascii?Q?dSKnHj2ONbUw7kqW3TBuT/yMZQrJtxX3ZvElz9XIjM9ZThT8XC19QZrrXWXd?=
 =?us-ascii?Q?oH2Tt0ifx+6kTR4SocMYphmsj8JwhnADM2hIqH2ZcZ/DQtuK/xNNeaAYgNLW?=
 =?us-ascii?Q?Kj34mhlVrFdRnyD1z8pi+fQU1tz+Y2qA8c9P/82tJCk7hfSbWbB0sUdrbgnE?=
 =?us-ascii?Q?orBU1CkBI2OYTIQjeSu4mKnIeRH9t8K5xnTJnJMMPUUA7SsXmK6WZTHCZNVv?=
 =?us-ascii?Q?vsyEyk5QuoG1i1xXehmI4UWvOIXJ3wq3j1ozRCU4OwOCu50ZVlFkXhL7HDnz?=
 =?us-ascii?Q?V5LoPAJaXvgTDbX1m6QbjAJJRB4iTeB0tKhgw5n57P6c8q5OCvyVaIfjJnYh?=
 =?us-ascii?Q?wL2ySEf6/YkoRq3HowwIGw7Jm3YRJbKL5oh989yOVbnmfdy6BCClPSD7QsL6?=
 =?us-ascii?Q?bk3ACPHo91/nkJIRnk6Sjg+QyDotRc/o1U8AZVIACsL5fMiSXAbFoZ3xHuYj?=
 =?us-ascii?Q?7kt4zutuiu833JSvXVE4MVsAnz1CTRopxSHgqwqstMqJzUYaLK7qlQtPNK+C?=
 =?us-ascii?Q?taZFeW2KgM3YV5iCrC/2WgYMzIrFG6K/TNtG62gOJmvI3Wz14kFcWGtJ1NYu?=
 =?us-ascii?Q?gmnrcRA0al6ULgg5vlozXFqj2IQfFC16OQat3Ok6SYRrdJ7beLXFyziid1Lf?=
 =?us-ascii?Q?P0ZDKNS5GeUa8IMeV+OqUymOg4yqZJm97GsbSJFAJor6ESpBab7MK+xESZpO?=
 =?us-ascii?Q?y59BGr16UuY/1oEREMk/sE8P5MGMgsYie7yU9SstVsN+DXGeQmdj3VPg0Tru?=
 =?us-ascii?Q?Tps6FafxAkqbODO6LoEx2Sq5SKishI+lPRaFt1c4KHs/m6qH1B6uxVq9j/OV?=
 =?us-ascii?Q?o3LHh3H3nC4P7huvE8VmF8KQ9wBflHT4qNGDrOk/XucH2MS9R1SLfErSOkEQ?=
 =?us-ascii?Q?V4VTzurMpz3F+iP5Q6J4RLD3O4SOm/g8lL20va0Fwv8yGcD/XGxz080FK7qJ?=
 =?us-ascii?Q?Uxbbf0looPQTDN+sZ5zpkLC3CEHt5xSy2tEI4pjeuUwoXAdy18IJfkGhwoY1?=
 =?us-ascii?Q?HnUD7EwT+dSmeK+FaDjr9KFqBaBZ85ZqAs7S8ECY5QPkWbSdNGxNRWvWIN9p?=
 =?us-ascii?Q?c8s1EqBJE0SrNk22QY9eCX0myWm89NEoJkdWRpdCNRy0w0pi2Ld75cg5DkVr?=
 =?us-ascii?Q?QCZ0UOsNhnWevABZqe4qv19vSxt5tTgRTk/nyV1nKPL5Jjkh1qya+UwbqIqm?=
 =?us-ascii?Q?8ylYw9aNswN1w0oB3YakrOxJ+osL8eAf6GBTk+gp8cMd9Oq/pweFUvlY4nQ4?=
 =?us-ascii?Q?zfem7FHjg0zzPMivj1wenBPIclyCD0B6HAV9FGTz0Si2mwqZl2zSDsK6uR0P?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb4fd61-fe36-42d6-62ae-08dbcc00f93a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:27:55.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9OJU9I89vfgJ6HA6nqnmkdVTjW8NsRpbxAoSJKcxtKsOmF2BwAtkY+yX1ZtfBtNArvcofHm2JT6bTNgXP7Swg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8114
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

Add the .find_loaded_rsc_table operation for i.MX DSP.
We need it for inter-process communication between DSP
and main core.

This callback is used to find the resource table (defined
in remote processor linker script) where the address of the
vrings along with the other allocated resources (carveouts etc)
are stored.
If this is not found, the vrings are not allocated and
the IPC between cores will not work.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 8fcda9b74545..a1c62d15f16c 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -940,6 +940,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.kick		= imx_dsp_rproc_kick,
 	.load		= imx_dsp_rproc_elf_load_segments,
 	.parse_fw	= imx_dsp_rproc_parse_fw,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
-- 
2.17.1

