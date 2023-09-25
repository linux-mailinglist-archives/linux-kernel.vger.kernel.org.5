Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC27AD39E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjIYInS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjIYInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:43:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F71AF;
        Mon, 25 Sep 2023 01:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYIgPsaDf9mWJvdISujiw6jPt9t4yREldR/3U2078PFvPJkuVlckn/iBq9k+ror8ryAcGwlPPAZQ+xqfvt6Mf9pocyWa1wRswBe489XFCOA7X2FA81xrkQi/OU91KdJdk7ddzvK4/6dRd3L1HGBjbJxpzmcLFsL3O8yVc2lpByiTdydEojkJXoV6rtGD9u8Ju3v2N2Ku6jjMgep48iepzqOXfIgkhMWnhjcczjQN1CWmOOf1PBLkl9vJXrSPzULhWKFRq374f7hJfwJjmNDCjdUtB7LzOtVzuZmk053E18XZCXr10qObz1zcxr3D5i01z4j8vFLeUCiquRhYjo/eJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2asvlerv7C2e+KPm4Do0sCCrp5lzLyK8pn1i/O+XdOQ=;
 b=LQWnj/m/0B+i748O7X4TqzE4Jhr++yejEj82X2k1wZJ2CYEKJenj6yHuDAPnxYA6CAwwYSYOl/owzFee8O109zKYk/dwFW/15R06m/v3R8+cX6dSY1Pvri28KaUYqNulWvsmdBvti2D4cPnJsIuRXbLHWhxh8XJ5rv0MvOkj3biPhUgD62HUWWXva+bA1tS3F2jf0YfnlEQ5NaWrk+yDQFeGywHtMqQLciyjXcDv66f/FpF09bIQbEqkQX4doJz92tNFg2kekPvFzDK9SPqlfG18B9qi86TIjVCKwl6TaHjy1BJ4ft9Upd+1AV4Csim/dGLarCc/DPfQtalsfYqziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2asvlerv7C2e+KPm4Do0sCCrp5lzLyK8pn1i/O+XdOQ=;
 b=R6vqPd8ZiiHgtzDE1H3tvEdBvuemL0C0Au1wgQaA3zEEHuxHREmfuDYehpl4KSNCtrAiZcoxI9cihuZJ4Rq8Upe8mJX9ytr+xMwBLU7SHJmNFu85jEBTiKPu05rWzDRY4I7GccFYueTlqE6xyUAhpXjNIhZYI5PLNibptUWbkeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 25 Sep 2023 16:47:42 +0800
Subject: [PATCH v2 1/2] firmware: arm_scmi: clock: support clock parents
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230925-scmi-clock-v2-v2-1-2d4d7127ebc1@nxp.com>
References: <20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com>
In-Reply-To: <20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695631674; l=7660;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=I5CZ2Qn7LgLIw2TZ0HWKBbX3pRk3XUdTgQ12BXXB9xw=;
 b=BaxM4fssNthqVgBM2rlDSSS1j+UQ6wbN8TqQSlaZ94bsMEbicLcaNG77lBdnke01nlz03En++
 fo2oHmy7W7fAhSV9J1xUhT2WQMP19cLelP8CDuJU7Yh2AbRpqHDTSDA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8d56f4-abed-4019-663f-08dbbda37044
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XJj1DsSO6rqKNqmUpUQ31o/pD8kWfbiiSLoeiLiRV2v1Tb0jgOHsQysY5Qa7lDGhtx9VU7YeCDQHfVQcRXgDJkxdNp33F8xst4C0uv2JKImXJGsDpF/SyEF7Vc6JFxfMpBrEFVgGvPqYy1Y1+E9V5Wbl/unAmTIcLa8/3TfFdW+1AXs1Hmqmd5kaOhSmqVWtUCRoV367Nn4ecLDwQl0WtlnzwQhpYkA8bt9hUivBHGZMTZBx/zW/30YoYPVGLSqEyyMH8dQWoteLofuyd5CBIFbqFCGHXJ9vDDQbw/CkP1d4InN81bBTbj9Wv0n/jljvCq8mkP0nJ4NPAhG5hOD1dqIr4oS6ssPpJA7v1xxxVWBaoSCCUd1TBtmC+JefYFodTPYQWI9la/nysAhSSNa/+C+vTsYrVEEeGQqkIUuEWq6fqjsZW8Ko5tXUJhNoek8V2VNIWjiYTdnc8S9wpswKOtwGILeCn9zQPYBq/+ifUFRBFvY+T0uZIpr3LbWIa3pZdBrC/Ufiz0LkK6CH9Ar4O+WK0oKvGthKKY0HQgWAlp/zj9opxS6m4NIa5XAKiVfjRXaooxe8IzpzQu0VbipFA2YCeP0z55u/CA6QbpDC1DxX3NyJ68YK9WYlO6XvlY8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(5660300002)(8676002)(478600001)(66556008)(110136005)(66476007)(66946007)(4326008)(8936002)(6486002)(6666004)(6506007)(52116002)(6512007)(9686003)(36756003)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU0zaVRmZ2pVU1djZjRkOGUxN2xDUkRwZ0VQMnhGVHYrTmJ4aW9DaU1iUFJp?=
 =?utf-8?B?dW5tUU1ZTzZ5MkhOY1k3eWRVWkRsQVlKNnplRGh0U1ZDVTFZMWRKSVA3em5w?=
 =?utf-8?B?UG1sSGVlN29MblBURktNMEU3TkRjWXcvcVY3S1lScEh1aHd4YzlsWi9wRWFi?=
 =?utf-8?B?UWNPd21sV29hcTQ5bnptMjVrT1QzRXl5b0tDUjQranc4eEN0NVJHQ3pkNytH?=
 =?utf-8?B?VHd5ZE96alFiT1dmdXJhQnRuNmdlSkIxNm9lYlBicTg3NUMvOURqSjBVUFht?=
 =?utf-8?B?bERHZGpWejBCbEttVVAvTXZVRkFjY28zNE9SV3lkZGN1OHUwZHpZUVNydnhR?=
 =?utf-8?B?TGRjRVh5WjNEdnZkdFpGYk9Xd2kwVys5ZGxXalhEbG1OejgzcXpST09EWlNo?=
 =?utf-8?B?S002ZzlCbVcxYUpWcTBPR0hKOTRjYnZ4OUUyTEtVMUN0S2lMdGZQZHRlamQ5?=
 =?utf-8?B?eHptREoydHBIRVVVWVdBRlVuQUh2SnJxK2VyN0d0eUhNQStic2srOSsrTjVz?=
 =?utf-8?B?ODF3MzBiNVlGdnlYeHBiczNZcThSbFl4M1pqamRJQVEyR2xHSzFoT3M4TEpX?=
 =?utf-8?B?QkwyQ29GcmFMbEQ2SG5Jc2V2aW9EcFgxVEVMZkowUmNVdGNDRFJ1bWlWNHd0?=
 =?utf-8?B?cXB1dzBZRjNNcGVFU2xFMUMxNlVaNm8vVTNKQUhSVDJKdGRhZStLZGhoQWpM?=
 =?utf-8?B?N1liTlR5VXFFOVdlQmZMZVVhaDhlQUhtRHV6UkorenF1TXdMeFZFSXQ2akY0?=
 =?utf-8?B?UVl1NzBaV0drMTlVeXR5WExHeVp1dFI5Y0g4SHFBU0tTdXU0VDJCYlpWREVh?=
 =?utf-8?B?NHdIQVFoRVRtWmJ2SWVudm1nanVUUVlCSTV4UytLamJmQkF5MUpKMFRZbDRj?=
 =?utf-8?B?bForOG82N2gyd0YxTmJ0dTlzb0t2U2pZd1drNDZ2cXlDTU9HWU13cVY0YWRG?=
 =?utf-8?B?dEZkaXdQcExTNlJ6NHFRK00yVkpSV1FQbEt4TjMxS0dHTTh0QkM3SDBSVG1k?=
 =?utf-8?B?YTc0aTJvd0ZRZGNzMHB0T2FOcmY3VWxhMnNNdk95dHI5UHA3bWttRHZKTUJr?=
 =?utf-8?B?MXpBemJzN3h5ZTdoR1BHb2NMeEJCcnRFMm9JRVpvdGlKUHhIQ2FxRzJaRnBP?=
 =?utf-8?B?ejF4WXNQdU9lV3hWRU85bkVCTlhDMjBTaGhkOThBZWExTHFSY09kT04xcmhR?=
 =?utf-8?B?M2s2NU5LYi9Oc2IvN2M3MEpSOXJmTEpzdGVtWEZoTVdob3hLNWJCVG4rYjVm?=
 =?utf-8?B?QlI0TCtXbSsxU3NGeEUwSFM3Zlh2TkE0RWRUR1llcDU2ZkhhdzV6dXhraU0r?=
 =?utf-8?B?dmJ5YmFTalNWbmI0T01pQVdWdUhEWHlMM3ZuejA5SFBmQUNJM2hmdkFSUHdS?=
 =?utf-8?B?QTVseDhyWjVCa1JaZjNCNWhsSTV2N1dHUTQ2Z3NsMkV3bWRhZGErdHpWek5V?=
 =?utf-8?B?Ly90L1VSTUNEUTU1Y3VNQXBFV290WUJGS0VRRGRVdnV5Nnh0MUpBYlRLZDk0?=
 =?utf-8?B?WVlwRU52bU1JbWEyc2VrVnFkYytVMVZSL2ZGSU9EQ21oZy9wdmVBRWJjK3pR?=
 =?utf-8?B?Z0xGMWYrZzlJYm5jb2Q4bG1nYzgyYkdtRHd6a283SjVIR0ZSVnV4R2tpMVho?=
 =?utf-8?B?OFFib0poNFpWVWVSWTJRMk5YQ0FUeU8xV3drNGxJRWVQSE4xQWJXL3Z3dEZl?=
 =?utf-8?B?MEEyMHQrWUcweSt1WXZXZXlPTXdIeGNJazdoZTdpYzRXR1JhOGJRZXhkbTA1?=
 =?utf-8?B?ci9zMm9yZWNmWXVKNmFXN0F3TFJ0VllxSHRGTTJwWEZzTGFTcHlFcWEzU21S?=
 =?utf-8?B?ZWczQ0xwMUg5YUFDK1VFTUpJbHVmeEFvT2U4czR6Z1JYNE5FUjlSSVhiWGpT?=
 =?utf-8?B?UDY0WmxtOWt4L0NpcVRudzYzeG9LVjE1V1F2NHl0U2NNUmlwbktxR2tNWUdV?=
 =?utf-8?B?TWFnSDR6eVRNbDNNYkQ0TktDVDRjQmZVNjhHaDhtZmp5NmM0U3p4RWJBNnBZ?=
 =?utf-8?B?SU0zMVRhbDI2ZzNGTGZmVWw3UythSTBkL0R1d1R5MnVPaTBpYmVmUE1GcFpO?=
 =?utf-8?B?clFHRzJ1YTNHcDNDVmV4SG1IS1ZMdkdrRVpiV244QnNnLy8veGNxcTFIdXZo?=
 =?utf-8?Q?TGvlyf4IM/FdJUzAM/IdS2nBi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8d56f4-abed-4019-663f-08dbbda37044
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:06.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sirHYlZqxSfCxKUwVuiiaxlw1PpM4bjKwqnz/VdtYg7iGGNWQykiLxTZlnh0Rg+pvSQRU4KjaHONJCuc2tuStQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI v3.2 spec introduces CLOCK_POSSIBLE_PARENTS_GET, CLOCK_PARENT_SET
and CLOCK_PARENT_GET. This patch is to add the upper three new
commands.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/clock.c | 156 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   5 ++
 2 files changed, 155 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index d18bf789fc24..38278922890a 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -22,6 +22,9 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_RATE_NOTIFY = 0x9,
 	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY = 0xA,
 	CLOCK_CONFIG_GET = 0xB,
+	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
+	CLOCK_PARENT_SET = 0xD,
+	CLOCK_PARENT_GET = 0xE,
 };
 
 enum clk_state {
@@ -42,10 +45,28 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGED_NOTIF(x)		((x) & BIT(31))
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
+#define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
 
+struct scmi_msg_clock_possible_parents {
+	__le32 id;
+	__le32 skip_parents;
+};
+
+struct scmi_msg_resp_clock_possible_parents {
+	__le32 num_parent_flags;
+#define NUM_PARENTS_RETURNED(x)		((x) & 0xff)
+#define NUM_PARENTS_REMAINING(x)	((x) >> 24)
+	u32 possible_parents[];
+};
+
+struct scmi_msg_clock_set_parent {
+	__le32 id;
+	__le32 parent_id;
+};
+
 struct scmi_msg_clock_config_set_v2 {
 	__le32 id;
 	__le32 attributes;
@@ -167,6 +188,81 @@ scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+struct scmi_clk_ipriv {
+	struct device *dev;
+	u32 clk_id;
+	struct scmi_clock_info *clk;
+};
+
+static void iter_clk_possible_parents_prepare_message(void *message, unsigned int desc_index,
+						      const void *priv)
+{
+	struct scmi_msg_clock_possible_parents *msg = message;
+	const struct scmi_clk_ipriv *p = priv;
+
+	msg->id = cpu_to_le32(p->clk_id);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->skip_parents = cpu_to_le32(desc_index);
+}
+
+static int iter_clk_possible_parents_update_state(struct scmi_iterator_state *st,
+						  const void *response, void *priv)
+{
+	const struct scmi_msg_resp_clock_possible_parents *r = response;
+	u32 flags;
+
+	flags = le32_to_cpu(r->num_parent_flags);
+	st->num_returned = NUM_PARENTS_RETURNED(flags);
+	st->num_remaining = NUM_PARENTS_REMAINING(flags);
+
+	return 0;
+}
+
+static int iter_clk_possible_parents_process_response(const struct scmi_protocol_handle *ph,
+						      const void *response,
+						      struct scmi_iterator_state *st,
+						      void *priv)
+{
+	const struct scmi_msg_resp_clock_possible_parents *r = response;
+	struct scmi_clk_ipriv *p = priv;
+
+	u32 *parent = &p->clk->parents[st->desc_index + st->loop_idx];
+
+	*parent = le32_to_cpu(r->possible_parents[st->loop_idx]);
+	p->clk->num_parents++;
+
+	return 0;
+}
+
+static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u32 clk_id,
+				       struct scmi_clock_info *clk)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_clk_possible_parents_prepare_message,
+		.update_state = iter_clk_possible_parents_update_state,
+		.process_response = iter_clk_possible_parents_process_response,
+	};
+
+	struct scmi_clk_ipriv ppriv = {
+		.clk_id = clk_id,
+		.clk = clk,
+		.dev = ph->dev,
+	};
+	void *iter;
+	int ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_PARENTS,
+					    CLOCK_POSSIBLE_PARENTS_GET,
+					    sizeof(struct scmi_msg_clock_possible_parents),
+					    &ppriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	ret = ph->hops->iter_response_run(iter);
+
+	return ret;
+}
+
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk,
 				     u32 version)
@@ -211,6 +307,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_changed_notifications = true;
 		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
 			clk->rate_change_requested_notifications = true;
+		if (SUPPORTS_PARENT_CLOCK(attributes))
+			scmi_clock_possible_parents(ph, clk_id, clk);
 	}
 
 	return ret;
@@ -228,12 +326,6 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
 		return 1;
 }
 
-struct scmi_clk_ipriv {
-	struct device *dev;
-	u32 clk_id;
-	struct scmi_clock_info *clk;
-};
-
 static void iter_clk_describe_prepare_message(void *message,
 					      const unsigned int desc_index,
 					      const void *priv)
@@ -457,6 +549,56 @@ scmi_clock_config_set_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
 	return ret;
 }
 
+static int
+scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      u32 parent_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_clock_set_parent *cfg;
+	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
+				      sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	t->hdr.poll_completion = false;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(clk_id);
+	cfg->parent_id = cpu_to_le32(clk->parents[parent_id]);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_clock_get_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      u32 *parent_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_GET,
+				      sizeof(__le32), sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(clk_id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*parent_id = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
 static int
 scmi_clock_config_set_v21(const struct scmi_protocol_handle *ph, u32 clk_id,
 			  enum clk_state state, u8 oem_type, u32 oem_val,
@@ -647,6 +789,8 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.state_get = scmi_clock_state_get,
 	.config_oem_get = scmi_clock_config_oem_get,
 	.config_oem_set = scmi_clock_config_oem_set,
+	.parent_set = scmi_clock_set_parent,
+	.parent_get = scmi_clock_get_parent,
 };
 
 static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 27bfa5a65b45..3175a9b4b8d8 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -16,6 +16,7 @@
 #define SCMI_MAX_STR_SIZE		64
 #define SCMI_SHORT_NAME_MAX_SIZE	16
 #define SCMI_MAX_NUM_RATES		16
+#define SCMI_MAX_NUM_PARENTS		8
 
 /**
  * struct scmi_revision_info - version information structure
@@ -58,6 +59,8 @@ struct scmi_clock_info {
 			u64 step_size;
 		} range;
 	};
+	int num_parents;
+	u32 parents[SCMI_MAX_NUM_PARENTS];
 };
 
 enum scmi_power_scale {
@@ -104,6 +107,8 @@ struct scmi_clk_proto_ops {
 			      bool atomic);
 	int (*config_oem_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      u8 oem_type, u32 oem_val, bool atomic);
+	int (*parent_get)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 *parent_id);
+	int (*parent_set)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 parent_id);
 };
 
 struct scmi_perf_domain_info {

-- 
2.37.1

