Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57D8085E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379162AbjLGJaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378774AbjLGJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:29:26 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659FE198E;
        Thu,  7 Dec 2023 01:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqanisSfJBShAo6ndOh0Oflmd9bQOGjZdmnJ6oIV/fFRvroNqAlcNt1VflKJ61UucU+QM7Qfn58oisyv9v9GCv2TRwTYDlDxXU5iuB6EEwuq4+FXSdi/yCcrz5YpY18LHJPhsthtHeGwYpN/3w6Hcdpq5z9C9tawEA9EZ7JBcOhIY5ot/R2gjRjsBDuTa16h65ZXXqmbO4/qI8aiB6UKYtQcMd/sgUf6f+5POaGp13IYVV7n+wY0znk9CSRLPQWx2aqyvysH4CPFDzMn1RiMX55wmW3wnkhrMnzbB5JrYyIbuDsw/4LDnRSHXYF2CrGMw+qGXErla8P7z9PJ8Ukf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK/+dcPjoh8l5MHlNwTMn5bW8NhswThJJBqDiUKZPUM=;
 b=Wd3egoUIL329Z5YZgT5SZNBFdLOfOeSJd9OSFKXQ9OgrxhqRKBeEBrW+16hS6JimXis7hJ72A1jpPzACe7dqE8pKH4CSjT+gR+he43dqlD9C82WG3zuwVioFrzZOoUO0eW8mx6X3kveVa3Gs5z/FR48aeJnmt1AmRf78sddHnWJrjPl4Ni+n2v/fSZaoK3adT2toZlBcqOPaffmBvMX8lJ74gejwYEESRQPltxqQAbG9DjkIYnjS/Hm8r/Fvof25/oN99+VwJiy1fkyKt0FZvTAbHdy1yEZBI5ThNNjmRIAgs5mUDXAIisj3lHgWw9XFoov99HJfPC4UxmTmqqa2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK/+dcPjoh8l5MHlNwTMn5bW8NhswThJJBqDiUKZPUM=;
 b=Jsr/xv8Rpmzq8k06gKrcVYZLCEm4ZYKLIpxiSEtGNe/jCnEfy3MFjT11zV6YdyEvLfpjXfOvqowWEkRIxW+FlQWJROi396tS0sA5xHTwYMuoHU1x+JMoDn7nzjNeoyAf1vEGTaXrsDX86iTcsCDN2o7G9A0to0kE81NCoEPNZBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 09:29:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Thu, 7 Dec 2023
 09:29:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
        glen.wienecke@nxp.com, nitin.garg_3@nxp.com, chuck.cannon@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] firmware: arm_scmi: clock: implement get permissions
Date:   Thu,  7 Dec 2023 17:33:44 +0800
Message-Id: <20231207093345.581048-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b79da48-4b53-4ca2-1c80-08dbf707007d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Yk3+oy8JY3i6B46Cy4VNsZDiMmEP+2CM45FjwdPdYFvO6er0YZq/qb0n2dSYW2b4wwRqL8wKXBD2pBWw26XWEReZhiVa4mSBJa2GOLiE7tsDaoNx5yteyGkbPDHJEXkKNzL7370oPt9+uI+lGAaYRYDbb5fhgR7XAi5/razcNn1zQBZxXBGuu/oOUJadv2j3KH5mixBdRz6GgIL13tIaea3qkQznwXGpHm5UjXest1iy+J19aMXbvK6iDHxh8vAHFl6gHb+D5P9DrLsnqNOsT8JILncEQ3+07a74UE6H1Xp0/k+VdhUDDwWTUhHwVTzUzDCsqDMRTnfue5MCOhbmCO3chQjtJEhLj/Aazhnxq+R/9ygpAV4mAJl+cGdegIgtSL5BSFX4YkAyx9smI+bwBp5Jat9WmwcXQvKiU3dCrtVbg8a9EGOgaqp/eIiw2JKVsAGu3LXPD7CcThkMai3UWrtpEFRNdPbJmQ3m0hdZGmu1sazQ4E9qBKTWLTBIiMab8mGw64CM8ODw8FmztnZqTSGzVC83fwDmsBs/wcB6aPC/bKcMfkuyFHtAgWO+LBocj6Le7+gzksEUQbzOR+0Ne0Vqey0g2TJbdWI0sKWJg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(4326008)(8676002)(8936002)(2906002)(66556008)(316002)(66946007)(66476007)(6512007)(6486002)(966005)(1076003)(478600001)(38350700005)(2616005)(6506007)(52116002)(41300700001)(6666004)(83380400001)(26005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zn+wHjycWwYuCx+wOLKEwLnwh3n2LQpvILNgjLyti20HMuLxxLIKKZ9On9me?=
 =?us-ascii?Q?GaLmx1xkUKYdeB7sYGImXLRodOa5aCHkX13atj9j/9HNv2MJaUQTKbvD6thn?=
 =?us-ascii?Q?frwMx79n7fLOBymQmA6q3RV+1akxGK68sbk2e9S6kuHEyTQpffOrO0kaBgry?=
 =?us-ascii?Q?n+eSizAXaoy17rf02vXWc28EmxgmzeNl1qLl5aCD78Xt5ti+xfP0ttCvFR9H?=
 =?us-ascii?Q?kMB5XLWJgk4CRZ25cGAzXYDLcgWt7AP5j5rk1oYgEgEP5+ZOauJWG6THxq8X?=
 =?us-ascii?Q?PjjLTVCvsok4+VbckR2ooi/YtkfbsIaUTnbaJ+9Sj/w1+GVesMUuiUnsHEp3?=
 =?us-ascii?Q?o6+QE3+7UxN2Tl388Exa2pr/ImAohVlZGQIu+KClle4eA27vW5ieAJc4ZdvY?=
 =?us-ascii?Q?d8CveLOFvz0MWgJN3hV0egABkzR1OyTaZp4ueOw9nXDm/g2fnmoA49pD4dnA?=
 =?us-ascii?Q?zSUEnHHV87g00Tp1cV7f6qCWwQCf5EfP4K5xuUE55olZnc1afwXBB1O1qe5a?=
 =?us-ascii?Q?ikwLPhufLHDyajiPXXy170w3gwEGhPqw11+cLeQTgkiZoSi7ItJ5kdTXW6Xi?=
 =?us-ascii?Q?AmVn9PTdNNAtaoAMSErM6Zz+AVYzWu9hT2V0xRak9ybVQUq+o0FRvPaVKuyf?=
 =?us-ascii?Q?5e7UTvbXHeXuV2npPPZxPbYlWPU1EUsJ2x0xfVLvv0py8buDFN8S0a4l8pW2?=
 =?us-ascii?Q?geyrdD0yyPVNr5htFkss4PRDnCsTKvE1pHCy3C8Io3qIo3gu1NMAit0HjcM5?=
 =?us-ascii?Q?cUvwgfACCvOXQzrVFQlHuL8shlUcSh/46bZFFgWQJn6kVYYRFhhtqEiIPr7D?=
 =?us-ascii?Q?D8lSGu5u96cuMOHonVntlY13HZm0r8HZtybcqAOGSbriVmVlWhx7atrmEH62?=
 =?us-ascii?Q?J8LM+/t8V3/vyQ07jAcRC1TDvET5h5U1jael0aI8E10etJardY8Dt6FbflO/?=
 =?us-ascii?Q?2cSEGAMX6BjN8r75newmN9sLEvk3SQJy/QCqdqocMMfWGcAA18Ejh2zAoPMq?=
 =?us-ascii?Q?yMItJT3AOGihZ/94OoCpDxHqLDMaESMHqK9Cs5bnOs4I6tR6JGn335v2Yllc?=
 =?us-ascii?Q?6izVbt6uMdGSZGWDWRl6/7Td6gU2FZ489ELuYTBmIBgIIHOr13a8V5AaYwSN?=
 =?us-ascii?Q?ZD3DLFsvB3+wHSdZmX5JV4VtjRnYGBMOYc+A8u+lwe6iAjshEzf/R9gYUxyr?=
 =?us-ascii?Q?bsKfipPjyjWjMHzc3jCK6fpO8cws1PxdQGRL5FffpMtq+gobcHPn/ym6jh5Z?=
 =?us-ascii?Q?BLvUjP5+J8M3H82OEV1qgGN3+nwywjxGur8xNieMtUjSW8u0QB6LCPpUBmV7?=
 =?us-ascii?Q?hdS7I2fojx2qeJ/4YmU2cyaAb5Il7i9pH2E2gtAd8VylioBeOgA/5mEuGl02?=
 =?us-ascii?Q?FRlmWoYeonOLCBrb6unuA1l/It0xNHYHAUeULkZXSLrL8OvZmQsTn1qD2Pis?=
 =?us-ascii?Q?1To64qXKrneScIoMv4tHE+dvhO5NE8Xl2/7dPZTU6sIqFR9M4HovdLu2jqha?=
 =?us-ascii?Q?xQvTNLMOnulcNqWSehBrtjEWJxXnnj+Ir6RYJzmuzA5UVvTpMMw3XW+VeKEv?=
 =?us-ascii?Q?J7fJn8RjHoP6brE7mSheFamql4Au2FfB5DsChHRX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b79da48-4b53-4ca2-1c80-08dbf707007d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 09:29:25.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9GTTXNqV5w7BsW7EZTWDo70mtFYzGYGgKVRolxvj9lbJ47+q2gqKmedXnBtshTfxKWEkDT7m2OkNEQ2fXgdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
is to add the support. Add three bool entries to scmi_clock_info to
indicate the operation is forbidden or not. If the CLOCK_GET_PERMISSIONS
command is not supported, the three bool variables will default
set to false, otherwise they will be set according to the return result
of CLOCK_GET_PERMISSIONS.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Take Cristian's suggestion, https://lore.kernel.org/all/ZWiqqfQ73tezFmSk@pluto/

 drivers/firmware/arm_scmi/clock.c | 53 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h     |  4 +++
 2 files changed, 57 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 98511a3aa367..0e048530bea2 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -25,8 +25,13 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
 	CLOCK_PARENT_SET = 0xD,
 	CLOCK_PARENT_GET = 0xE,
+	CLOCK_GET_PERMISSIONS = 0xF,
 };
 
+#define CLOCK_STATE_CONTROL_ALLOWED	BIT(31)
+#define CLOCK_PARENT_CONTROL_ALLOWED	BIT(30)
+#define CLOCK_RATE_CONTROL_ALLOWED	BIT(29)
+
 enum clk_state {
 	CLK_STATE_DISABLE,
 	CLK_STATE_ENABLE,
@@ -46,6 +51,7 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -281,6 +287,35 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
 	return ret;
 }
 
+static int
+scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
+			   struct scmi_clock_info *clk)
+{
+	struct scmi_xfer *t;
+	u32 perm;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_GET_PERMISSIONS,
+				      sizeof(clk_id), sizeof(perm), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(clk_id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		perm = get_unaligned_le32(t->rx.buf);
+
+		clk->state_ctrl_forbidden = !(perm & CLOCK_STATE_CONTROL_ALLOWED);
+		clk->rate_ctrl_forbidden = !(perm & CLOCK_RATE_CONTROL_ALLOWED);
+		clk->parent_ctrl_forbidden = !(perm & CLOCK_PARENT_CONTROL_ALLOWED);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk,
 				     u32 version)
@@ -307,6 +342,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
 			latency = le32_to_cpu(attr->clock_enable_latency);
 		clk->enable_latency = latency ? : U32_MAX;
+		clk->attributes = attributes;
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -327,6 +363,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_change_requested_notifications = true;
 		if (SUPPORTS_PARENT_CLOCK(attributes))
 			scmi_clock_possible_parents(ph, clk_id, clk);
+		if (SUPPORTS_GET_PERMISSIONS(attributes))
+			scmi_clock_get_permissions(ph, clk_id, clk);
 	}
 
 	return ret;
@@ -499,6 +537,10 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (clk->rate_ctrl_forbidden)
+		return -EACCES;
 
 	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
 	if (ret)
@@ -585,6 +627,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 	if (parent_id >= clk->num_parents)
 		return -EINVAL;
 
+	if (clk->parent_ctrl_forbidden)
+		return -EACCES;
+
 	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
 				      sizeof(*cfg), 0, &t);
 	if (ret)
@@ -668,6 +713,10 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			     bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (clk->state_ctrl_forbidden)
+		return -EACCES;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
 				    NULL_OEM_TYPE, 0, atomic);
@@ -677,6 +726,10 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (clk->state_ctrl_forbidden)
+		return -EACCES;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
 				    NULL_OEM_TYPE, 0, atomic);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..ad75784b567b 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -47,6 +47,9 @@ struct scmi_clock_info {
 	bool rate_discrete;
 	bool rate_changed_notifications;
 	bool rate_change_requested_notifications;
+	bool state_ctrl_forbidden;
+	bool rate_ctrl_forbidden;
+	bool parent_ctrl_forbidden;
 	union {
 		struct {
 			int num_rates;
@@ -60,6 +63,7 @@ struct scmi_clock_info {
 	};
 	int num_parents;
 	u32 *parents;
+	u32 attributes;
 };
 
 enum scmi_power_scale {
-- 
2.37.1

