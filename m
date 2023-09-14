Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8879FCCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjINHHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjINHHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:07:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE662CCD;
        Thu, 14 Sep 2023 00:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F50VCTDLXnWd5EkLPdXBBola2ugBKskKLTSwZASqorhsGb3p0F7HMak42vciAtSEPP8gqlUZ0aPAVd0wNCdejxIZvpsScHqPnasPwMza7vzOUnBuS0phf2zlGvJLdq4H+GHGwWSG8NgwKLJkOmJfVeqDiQXJ4lve+16MHAyNsI8acEeLy7OzZEcOUlvX6gO3kEjVgth/+7CYey4pHnICEScHoIbsXBUzhHNiJEmK96kXWi9dUhDDuSbRNveZI5NnVMox83LUsv2IST5FU2apgRf0LGAp5iYBCicbzmyyybwObw5LSiTWXAWGqU8TNFJ9aCASl+vngdgXV34Xgtq31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpbg+Xj9NL50HAbQf3ZQ7PmXQHiyE7zB5X2SgiVY3eY=;
 b=HVlPmILxvvJJ7dYdw922R2UCwXXWB37ifCL0pW4UjPOuG92DIOuKbPdxuVuZtw2kaSg2uL9nvEa47qGVdQHYK47VF5Zq61zRo75n9ce1ozUYeNwe5/B/pgO06cO3GzUzph3N6oxX5AQss72/+lW0aq/SBY8tKT6t0P/WBFgza/kKN+VTveceruowtzsjR10ZhLfQBuDbl3mjKYZLzHyx79CsyL8/Wqy6eaw+Lvv5ag1+hb9M8nxUpGV1DXgNoYfPtj0E+bMo+x+80RIBdX08DVabVrM/gjAIudeig2is1vxfa0sbHG4tjQVNb2HTPwewAxifFfjuN0Z242+5ZiNVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpbg+Xj9NL50HAbQf3ZQ7PmXQHiyE7zB5X2SgiVY3eY=;
 b=ezcJdNdqr7PHGwYvEd0A7F5x1IF4gc7JPZAyjrLarQlhU8LQQvxcNsJ/zBzV5r1jqc9ijp1pAvzVyoPRHjj0PRAfk8YKIcEW8Pjierkc5ubB330KI+YVYodtgNqa/JoAk8nJ+/gXCBDi4EK3RQcnYMJ8SqxBp0hByABSGNAW4gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 07:07:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 07:07:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Thu, 14 Sep 2023 15:12:11 +0800
Subject: [PATCH 1/2] firmware: arm_scmi: clock: support clock parents
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-scmi-clock-v1-1-bf8edfb0546e@nxp.com>
References: <20230914-scmi-clock-v1-0-bf8edfb0546e@nxp.com>
In-Reply-To: <20230914-scmi-clock-v1-0-bf8edfb0546e@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694675547; l=7633;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ErGHLOqEK1WHpE9AKwhhDhglPm0XzUGpJH0MFiBpj00=;
 b=oSBrjTe5BDYPbqxQB2fTTlNytF2dl04naMOUohw3HUNy+7K2EhChJ04mMC77mn+yZQw2a+9Tx
 c+/QgCiTe+sBOTUuq+mVJc7UWzPuFN7fBaGFpdVVjUwNxIZkX1l0pEn
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bc39e4-27a4-4a2f-ebd8-08dbb4f14754
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKQJPCHR5o/iJEqzmJScbH3stYWBaNVYtvwzQ6baGTJoP4xbfMIwvhowqkYa5e47kbX0BugMzIg6/wqadylpPgAZAp2x+vGIJmOZLKIuvXR56d33z55JYo2/bTNC/cT/BbIiom1LbH0jT8Nfm/ygH/7L3cNaqPVsE50kIQWpLtq1bQU1r/QQ/22MoTMg0vf6iSZ6qXExgxqymmMOHFycZZU/sxwpCBGcuUyM14minNo4DFi7PvfMljlM2dmzgAQ58XNo0y8hTkNIU+3ZQxGtyc1JOrNcpQuRFY0DlRnWsJmaJPlvRv/ct5ydeXZINGL/yRTSPSnkkksmDcOjhZ83OS6hng0YCOLZabsHDkKfKz5IV3yhiqynpabL1rLA0HwVlIJ7dkeUAn080gnC5OKe5bkYfSKDjByecyMlXWfdeW9JM9sq/U2cNPc/wuYCt6eWuhTyuT5Kz/3dgsaA2HEXBPSuKOXdA+g2+VY6GOFPgalfpIctEwm21zUIygMWnZ7QYspn+bDhbrz1Cg8SFIcAOqwIDe2ENFlgaZzDCnhPz1BrpcB/O7VzhXTgMoqG5gWfYIwiUFhq91AdXvSBxISgEPCICzT3TmqRq3JP6HIcQM7mY1ozYKxcXzzE8uaW6ibh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(316002)(54906003)(110136005)(66556008)(66946007)(66476007)(41300700001)(478600001)(38100700002)(38350700002)(86362001)(36756003)(2906002)(5660300002)(8936002)(8676002)(26005)(4326008)(83380400001)(6666004)(6506007)(6512007)(9686003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzQwMWdGZnZOdnlpdzRFRVJ6UEswTmp6akx1UXV3QXNNbmlWQlBPUTM2WEx1?=
 =?utf-8?B?eGNKNmdEdUJ6ajFiUlNTQ0hBeVRBRDZhRUhMeHVVMUwwaS9SMVYzdHBjUlEy?=
 =?utf-8?B?WDEyTlRhcENQUlpkakVYd2U2YUNKQUxCa0kxcmptcmsvU1g4WjhoSThMOEsr?=
 =?utf-8?B?aGY2R0xCVkF0Q3M4ZlJkYWFyb1JQTk54SkRZZExNcGJqVFhaRzFOZHRQdFNR?=
 =?utf-8?B?UkhIc1lCL2NwNFdKdDY3REplam1MT2hBYmJ1ci94dmV3MGhsbDZ1blV6VVp4?=
 =?utf-8?B?TGlIaXBFZERnT0JkMGVpUkxUN0lJOWN3OWNiVWpZQUdpbFE5RDNyaTRWdmJM?=
 =?utf-8?B?dzIyZi93VFBtYUxzbXc3YXVkU1ZVcE1ubktlTjgwcEdJbVV6dkZSUW9NMnNS?=
 =?utf-8?B?SzUxaWhjanc3ZFJ3VjdaUThEbmRVYUZOL29obnJYRFpLTFhIRGxQV0JNcHlY?=
 =?utf-8?B?dTNmVFRLWlRDNjdKMnhON1AvdGZxU2YrdXJjN3VUWGN4RGEzdVI0aW9VWVFy?=
 =?utf-8?B?MFFOVnUzMDFoaUhlMERiS3l0WWZLV3N5SHFCOGFhVHpoZWZpbUc4MlNmbUhQ?=
 =?utf-8?B?aTZKNEpLWDc4K0xqclFoYldFWVZZMnlHQm5UNDhraDY2RTZDclRwbmk0eXJj?=
 =?utf-8?B?NG55NUtPYTduVXlreXF5T0JPQ09mMmozMVFab2lvd1dLdnFrdVJSck91eDhF?=
 =?utf-8?B?OXFhQ2t5RXhoZ2FmV3ZXb2RYTk9HdUs4YVZabXpFL2gyUmVkVFdFL0ZKVmVU?=
 =?utf-8?B?RENxUE9HMmFPOVFzeTVzWXM2TW8vQ00wN1hOSVVJU1VoRCs4N0lVYTR3MlRs?=
 =?utf-8?B?ZUZSamNhays1UU5BeHdBa1dqMmJnbWRtM3czNzhqVmNBektJM3psU09KTVEw?=
 =?utf-8?B?czJMNkJsQ2ZkZkVjaDFxT1ZMemo3elcrdDZKKy9EbjhHc1VrV05WTzdOT0dO?=
 =?utf-8?B?YTBNbzMrOU5EVTRHb1hRNTZOZFpaaFFYdmlEMHZ0VTNaS09lODJSM3FsNDdH?=
 =?utf-8?B?azYwbEVpODNyUHpseUhEc1hscVVmYjlDRk9WeDhva2FzMVpxSXdIU0JWdlpx?=
 =?utf-8?B?REh4UkhQSWg5V1BoSE04b2ZNS0JYRU94QkRQUUdGNlQ5SnYwdWRpd1FSL2tJ?=
 =?utf-8?B?MU5KRkh3MW02RUNWcVFYTHRVeG1lb21FL0NNVmQ1MTk2TEtZOVJjcUQwVHBq?=
 =?utf-8?B?T1pkREJhakhOK20zVk13Y2N5RFBXOWdmemloamtKTVF3TTNqUEFkdXI1RmVh?=
 =?utf-8?B?TTJSWU1zMytiWlNqTEVCc1BlWnkyVDFJWUQ1bC9GQUxwWS9Wb0xZbUFHN3ln?=
 =?utf-8?B?bFREaTN6N2YreEtHTHNMbGJlOHRkT2hoc1ZGVnBhelpPNWRCOWE2b04rMGJ3?=
 =?utf-8?B?RHJ3TmphUlpZZXJDeEp6S0VjZ3FwVmpEbDh4bGpYdmZzUzBOUUl0UGRBWXdh?=
 =?utf-8?B?dEFpekdBMVNiRjNKbnJzL1FuMnJyUGFzLy9Ua0ZxTk8wbnZiaTRjVVYvbzQr?=
 =?utf-8?B?NjFoVjEyRFQxYmZPOC9UM3M4RWhGVlFMUjBCQUx3bGxVVmZuekZraWM3T041?=
 =?utf-8?B?a3FQZWdxOHZqNmozTmlmSWppN2FPU1liNXBncUZjaGFORkVpenBlOTdaeUlF?=
 =?utf-8?B?OHVtQXMvbXlHRkFYVytlcFA0Mk5PRDVWUjgybXdZcFRUOWd2dmZXSm5qdDhq?=
 =?utf-8?B?NFRVeUduMVFnTk1VNzZWVDNCaXNzZFRDTzVOcndPZUV0bWpFUzVjc3QzRWdT?=
 =?utf-8?B?aWxlRkNnd0FBMTZ2L0tvSi95OXliOTdic1NFMnp1ckJSZCtoMHZSWVhqNGNI?=
 =?utf-8?B?bXRQczFOT1diMUlvMjM0SXFHTjI0S3ltUGl2bzUxQXpqcUhxRVI5S3BoVVdM?=
 =?utf-8?B?NlhLSmpscmoxeVBqNXNSWjZVMHhyYitLTXEwaVNPcks5dnA5MXYyem44Z25q?=
 =?utf-8?B?VWZJSHVQcHZEQUYzM0JzUzFET1MwVnlQbGo2eEVrMmU2OTJsN1JrUFhtWFBq?=
 =?utf-8?B?SVdOZkRmQWpOUE51eEcwNXZnOER0ejNlOUFMQzZkRVczTVUyUVBrdUdMZENh?=
 =?utf-8?B?MVpDNFBmMkh6MWJPR0N2dHF6OXAvbmpDTk5OM04wVlo2ejM3a2g2ZlpDU05W?=
 =?utf-8?Q?jcgtGy8SdMaCNWABM0GDu6I2T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc39e4-27a4-4a2f-ebd8-08dbb4f14754
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:07:38.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtwkXhLtuL+0hAHrtWn9KEEnYrgdyEGnkpJoEWso1TwnD24c6xUuqmZeCkcXzC570zjjWEIrSzCHc8UDGjipeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628
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
index e09ac428fa1b..e8c76f1155cf 100644
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
 
 /**

-- 
2.37.1

