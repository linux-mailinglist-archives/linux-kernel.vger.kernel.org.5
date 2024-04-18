Return-Path: <linux-kernel+bounces-149551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456858A92C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F413B2167B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1389657C1;
	Thu, 18 Apr 2024 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dJJlgHlK"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3749B6A340;
	Thu, 18 Apr 2024 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420428; cv=fail; b=EENHvADx3BfCzjipB9Oqe0BzgfK9E0frfdPpITHYxLlktXMRTAF5ds7Efurs3aTLhDDD7Ud1GWvD2ysjJ1LskZOd6101k7266es8vSiRVqNUlpnAwI3tGKgGwC8n12RYgV6eVKYpx2DAMlx2X/lYXpe8yw6cqbApMU/qmDV6WzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420428; c=relaxed/simple;
	bh=No+ySWoB8YT14eTAwus89GVYedIKYOLphsguf7CWiVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHN2fUMmLgP+ZyEzsKwGWcgePx2U+NJx2/Mj/Tt97vvUe41JeG0W2CGUbV4FWnXVj+PS1HtZKxEQvNlm+QvM32rrb3MzU7CFh+a7T0JEArc3f90OzMTnCKS8AgJFy+SJJAf7wn4xKc2tMYTK4AaOzxBEo5oGbScvuG0q1P0oFkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dJJlgHlK; arc=fail smtp.client-ip=40.107.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiRWMW7Y47l8LRif8ZHZOk5Shsxq2LGo41jb2SIbw61oE3G1yrozRXlDmEHHisuivA+rkXCJFVinWEB3dSaEwUJzqJs5EmtBgLZB1xlA+mfptESpRDk8dOVIvjXJw43To23R3eTou7Wt0g2CjSJV0wNp0SjO33IN1ha4YxY2QLsI+0WqJiO9TbP0Sp7t/FYffHQ6rsg6+Wr3C7uRvClFN/wEbnlIuieei1l8oEct55m72gudwUIdVnM3MA7OFgyaXWPI9oJGcCm708p88EPEop8LwxCTBLXajaEREB49ljhLO+rS8NOKi4FNOHMU0YYmlA7dN+s1SOoLnOhAw4D12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ukk3/23Zsktajjl+BPiTBbKoIpMgGusQ5MYaUqlqDA=;
 b=NCW4VA3cbiCDPCu5eoTognc66HgjCoUfxyipyUTCMRj7WqHE/gUOZPngz51YQ32A1cNbom1pK4UTzTHHsQt7/eZ1SQohc55J030LBZG6YFhsA4zT0adX2Enb2mR7pUd7eMr+VnYZNURH7wTf0Q2NuxoQrETAwc7LVRnUN6c3Uf4GRPSK8A4GQcAJH6/SHQe0I3PkZw1V0rIj95LfkGOtE0Pnf1lA6NQbikNO15MrxDdZnR5LGkwzW7L0s5MPWCMSq1qQlj4I+/Ia/BFEx5tkCZJpWGQa+O5JIAr6Pyz7YS1MVqtiC9q23lkUiTkXc16j89VqhnrvSNwpfJZYFDJ5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ukk3/23Zsktajjl+BPiTBbKoIpMgGusQ5MYaUqlqDA=;
 b=dJJlgHlKiHqj8dIP+Q/IWct91nqcEkrxKKAsPfHhcHel5NJWnmvnnwtH9PTeQd2XXUdycRjAv0hXipZN0wzF1g5YqgOy7lbEQRjkKcf4/BOvj+X6hlzmKt3yJCQvmtPBBjyAqKwc0d0ugCrScib74/Sn4snFWI+iiVYPRombTEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM8PR04MB7828.eurprd04.prod.outlook.com (2603:10a6:20b:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 06:07:01 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 06:07:01 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP mode
Date: Thu, 18 Apr 2024 14:06:26 +0800
Message-Id: <20240418060626.431202-3-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418060626.431202-1-yu-hao.lin@nxp.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AM8PR04MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 48971aa6-41d5-4e0e-54cb-08dc5f6dc379
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 /kKQWI6/jRQExr8lG7hvmu2vSIiDfx2guIsQz22EScmZwp2IuK1m8xyMYur7BxcH9qmrc6a0fzkaR/uL7Qtg3DRLMgRTlpfsTAaF1Ue/7WqQIOmp3jLDOXG4RLEuSDm8i34XpMZI/Jxb46CrbH5p/BDE0G78hm7PZUNBR6YPjZbuJzqtwRYGVTMKlMhT4tzQK8zSx1dFuN4TiqJfaH0ijbI6Bl9wZhhrSoTD1fS9ccDKi8I0RI8g0efyzCNp7QtzOoD3mwZ15I+H7XoMLniKP3yHgRMoUvSS0whc56lT01iNv6PTtnsztasI3XwKoVze7ZXBCTjqC39KTZWGM1dMmpUnkff7zEYv8dkucJa9cser8QROcexVJwtUzghPOk5unVNlE5qiFnfWzYB6HEREJ73afE2Q2zfPvI9RPmUCvsugiHSDgtFaGGg7R+5sFE3EEVEIrOsQkgV4S1z8c+6uuv6qBiSUWUjTElxBJ7NyY1fupwaFBiFuMcUtJlzkjCKbnK99huzphZXUJaUV8KCGjVyIAiVed7noPClXIw3K2lA9Czhndhf0ZZM1hykimixTGc5hk/NMQ10C/3bhC2l8rzoMVFv/bv9yPesLoX8AgkQvHqm7COVxgykhGgri1zrQsHaT8TqHJ6bNDE1sfYPm1Ou6FJC/WdFRMYuiarA5VWoYybAl0b1cQ9bF1vUsi7fknNiAgzokSGdlBOyIYTkREQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?I2duPJW+tHDvuJGVVLNIQRTUqPQukH8opl5sE0FOi3uf+/g+7B60gs6AYoGi?=
 =?us-ascii?Q?Eq8zOiWGa43JG2XuhfXZ0+UIkUYbITHZ5mZFNABd1uvd3cCKRsFC/o8ND4U7?=
 =?us-ascii?Q?3Bsv0mDpM8zcfMnVWentwwA1anNw7nsdNibzTigcodwcrErqjBLTaUld2iby?=
 =?us-ascii?Q?lctVDKGB6Rc78849EvwGrYV5ivDg/6rvp69BXlYsqr5OrBv1Vxi6UAMt6kPs?=
 =?us-ascii?Q?gIFI1eLtyeSnSqvsAx0N8fH0Vv6Pps98cjLdgnV8KQNKcb5w9GlZo2fNRXH8?=
 =?us-ascii?Q?826OER+49EG06CYzoasuSDabhSkuGHX3ala2Wf4YZ1bnuY5pNHJ3Lgt240AI?=
 =?us-ascii?Q?AzjR8g3SqJBLOpg3AYhrt9lLrTkr9j2XLpqr5IOFlrfl3bY71IboeEs7O6A4?=
 =?us-ascii?Q?2NvSV+vawG5Z6eN0Yjsh9dWHQN00UtAvc2aVOhI4uFBoEr2mbvJuTs+XmIK7?=
 =?us-ascii?Q?rBqDJe7NrGybO6gXkF4d+vmYpvq3+Igz/Qd59FFfL2q0UZ04C+pmFpmw4i6e?=
 =?us-ascii?Q?8NfgHwESgvymRI4KJN/Bfr0xZkVxjMkVL8TeTmpa4+8D96Wz9aQsnJNyrRrt?=
 =?us-ascii?Q?AACYWiXLnMH/vsUdtcE+ZMSEGSotM4szXvztdmZbvWldsTqEnCne3dDAb7hZ?=
 =?us-ascii?Q?qZHY0X2YwM8SWIzjxeiHDsYkHSLKwLDernWtUbviPVLmF6fF6+bYfNvSE4s/?=
 =?us-ascii?Q?+jNFGnknIJ6yjMi/tuXFTJEsxZAlK2neJ65RsSshvZiljKzmKJmeC6Y6hxUD?=
 =?us-ascii?Q?4DsH/72Z1q1GjZT+iYJn0aLbqjBkH7M4oWFrRGHoNNu0xSBVSFnJSpcuB0dy?=
 =?us-ascii?Q?OtwFpq4GvbJRhnk2SNeJdsh28f1EQO8SbB79Vx/06DlfteyWFS4c5ZBO1Rto?=
 =?us-ascii?Q?7Gb83bR7Iq2oiJhOg0Iv8n0xTCMtquLmA9QW8TLR/nLzKSMtt84Fiw+M/Uib?=
 =?us-ascii?Q?TKhdMCECYkBGZvYLfDtLYu7n9xs54ItE+RhFGL+RYLQPiHPfl7uW6NoiGX84?=
 =?us-ascii?Q?hVg0FlapaN7hJ4hMNamSVgX+/iDLV2KfzFvXrpATyOW4AWazOsKBDY0owlQF?=
 =?us-ascii?Q?m2itpc0+NJ6luQUb4nW4dXA8YfKdO1NKk5kA8FPWODwj5LsE21t2JBrD2FPc?=
 =?us-ascii?Q?OEM7cwuSaxG1Dubl6nZiI15stvo+lNYzp80V3hDhZhgNI8hkfoXUAAqkQ8ec?=
 =?us-ascii?Q?lGNZ/LSbO9MR3CFm3PHqPoQFfW2QK023kU4n1nUAZCGQSK8w7gy97YKYB1wA?=
 =?us-ascii?Q?3SbZRdXLxpmAACRkTO/URaZ6tIRFlybND4aXpZuUdBNFkl+zIjryqhk2i/Ou?=
 =?us-ascii?Q?CCEDTZRUuOYX3N4JkX7cfo1Z1VGnME9h5RISHvU9KU7+RTHwjDxEC4mv02Ug?=
 =?us-ascii?Q?qkhzMNWnWqpuvkOvI7OQvpRLtXN4Utz3CDjY+Ndyhy0Rq0SnriHp0U8F0MlG?=
 =?us-ascii?Q?UB6boj5/6INVxqIjRi0z1hw1zCWWMiK5ZrDEVaq3DccXx9QVLzxxrAjOe2Jq?=
 =?us-ascii?Q?9Nw80qwr41s+4S0aKSklg/GcwMZVf6l1vHsIVszj524wX51C5mZLfUSAFIyr?=
 =?us-ascii?Q?uL4CEPNbJ+Se0+OD4EsYYxNPvrQECeD3yip1gz1n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48971aa6-41d5-4e0e-54cb-08dc5f6dc379
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:07:01.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLYSlAdrE9C0tsOIAykRuo8bdcXIcc1rSFi60gINdYae9dPxdO07lVr264EfB4BD+0UDgXnT8GRR49ZsWcnHMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7828

Add host based MLME to enable WPA3 functionalities in AP mode.
This feature required a firmware with the corresponding V2 Key API
support. The feature (WPA3) is currently enabled and verified only
on IW416. Also, verified no regression with change when host MLME
is disabled.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---

v10:
   - none

v9:
   - remove unnecessary goto target.

v8:
   - first full and complete patch to support host based MLME for AP
     mode.

---
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  79 +++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  21 +++
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   |  24 +++
 7 files changed, 301 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 53eeda388802..e122cc686dad 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -221,6 +221,26 @@ mwifiex_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		return 0;
 	}
 
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
+		if (ieee80211_is_auth(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: send auth to %pM\n", mgmt->da);
+		if (ieee80211_is_deauth(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: send deauth to %pM\n", mgmt->da);
+		if (ieee80211_is_disassoc(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send disassoc to %pM\n", mgmt->da);
+		if (ieee80211_is_assoc_resp(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send assoc resp to %pM\n",
+				    mgmt->da);
+		if (ieee80211_is_reassoc_resp(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send reassoc resp to %pM\n",
+				    mgmt->da);
+	}
+
 	pkt_len = len + ETH_ALEN;
 	skb = dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
 			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
@@ -505,6 +525,9 @@ mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
 
 	wiphy_dbg(wiphy, "set default mgmt key, key index=%d\n", key_index);
 
+	if (priv->adapter->host_mlme_enabled)
+		return 0;
+
 	memset(&encrypt_key, 0, sizeof(struct mwifiex_ds_encrypt_key));
 	encrypt_key.key_len = WLAN_KEY_LEN_CCMP;
 	encrypt_key.key_index = key_index;
@@ -1712,7 +1735,7 @@ static const u32 mwifiex_cipher_suites[] = {
 };
 
 /* Supported mgmt frame types to be advertised to cfg80211 */
-static const struct ieee80211_txrx_stypes
+static struct ieee80211_txrx_stypes
 mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	[NL80211_IFTYPE_STATION] = {
 		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
@@ -3951,12 +3974,43 @@ mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
 	}
 }
 
+static int
+mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u8 *mac,
+				 struct station_parameters *params)
+{
+	struct mwifiex_sta_info add_sta;
+	int ret;
+
+	memcpy(add_sta.peer_mac, mac, ETH_ALEN);
+	add_sta.params = params;
+
+	ret = mwifiex_send_cmd(priv, HostCmd_CMD_ADD_NEW_STATION,
+			       HostCmd_ACT_ADD_STA, 0, (void *)&add_sta, true);
+
+	if (!ret) {
+		struct station_info *sinfo;
+
+		sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+		if (!sinfo)
+			return -ENOMEM;
+
+		cfg80211_new_sta(priv->netdev, mac, sinfo, GFP_KERNEL);
+		kfree(sinfo);
+	}
+
+	return ret;
+}
+
 static int
 mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 			     const u8 *mac, struct station_parameters *params)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return mwifiex_cfg80211_uap_add_station(priv, mac, params);
+
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
 
@@ -4194,6 +4248,10 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return 0;
+
 	/* we support change_station handler only for TDLS peers*/
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
@@ -4662,6 +4720,17 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
+	if (adapter->host_mlme_enabled) {
+		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx = 0xffff;
+		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =
+			BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4) |
+			BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+			BIT(IEEE80211_STYPE_ACTION >> 4);
+	}
 	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -4704,14 +4773,18 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
 	ether_addr_copy(wiphy->perm_addr, adapter->perm_addr);
 	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
-	wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME |
-			WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
+	wiphy->flags |= WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
 			WIPHY_FLAG_AP_UAPSD |
 			WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
 
+	if (adapter->host_mlme_enabled)
+		wiphy->flags |= WIPHY_FLAG_REPORTS_OBSS;
+	else
+		wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME;
+
 	if (ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 				WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index da983e27023c..ea6ebc9c23ef 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -635,6 +635,8 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 		case HostCmd_CMD_UAP_STA_DEAUTH:
 		case HOST_CMD_APCMD_SYS_RESET:
 		case HOST_CMD_APCMD_STA_LIST:
+		case HostCmd_CMD_CHAN_REPORT_REQUEST:
+		case HostCmd_CMD_ADD_NEW_STATION:
 			ret = mwifiex_uap_prepare_cmd(priv, cmd_no, cmd_action,
 						      cmd_oid, data_buf,
 						      cmd_ptr);
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 0f89b86aa527..65799ae3bc72 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -211,6 +211,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
 #define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_UAP_STA_FLAGS      (PROPRIETARY_TLV_BASE_ID + 313)
 #define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
 
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
@@ -407,6 +408,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define HostCmd_CMD_STA_CONFIGURE		      0x023f
 #define HostCmd_CMD_CHAN_REGION_CFG		      0x0242
 #define HostCmd_CMD_PACKET_AGGR_CTRL		      0x0251
+#define HostCmd_CMD_ADD_NEW_STATION		      0x025f
 
 #define PROTOCOL_NO_SECURITY        0x01
 #define PROTOCOL_STATIC_WEP         0x02
@@ -417,6 +419,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define KEY_MGMT_NONE               0x04
 #define KEY_MGMT_PSK                0x02
 #define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_SAE                0x400
 #define CIPHER_TKIP                 0x04
 #define CIPHER_AES_CCMP             0x08
 #define VALID_CIPHER_BITMAP         0x0c
@@ -502,6 +505,9 @@ enum mwifiex_channel_flags {
 #define HostCmd_ACT_GET_TX              0x0008
 #define HostCmd_ACT_GET_BOTH            0x000c
 
+#define HostCmd_ACT_REMOVE_STA          0x0
+#define HostCmd_ACT_ADD_STA             0x1
+
 #define RF_ANTENNA_AUTO                 0xFFFF
 
 #define HostCmd_SET_SEQ_NO_BSS_INFO(seq, num, type) \
@@ -2331,6 +2337,20 @@ struct host_cmd_ds_sta_configure {
 	u8 tlv_buffer[];
 } __packed;
 
+struct mwifiex_ie_types_sta_flag {
+	struct mwifiex_ie_types_header header;
+	__le32 sta_flags;
+} __packed;
+
+struct host_cmd_ds_add_station {
+	__le16 action;
+	__le16 aid;
+	u8 peer_mac[ETH_ALEN];
+	__le32 listen_interval;
+	__le16 cap_info;
+	u8 tlv[];
+} __packed;
+
 struct host_cmd_ds_command {
 	__le16 command;
 	__le16 size;
@@ -2409,6 +2429,7 @@ struct host_cmd_ds_command {
 		struct host_cmd_ds_chan_region_cfg reg_cfg;
 		struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
 		struct host_cmd_ds_sta_configure sta_cfg;
+		struct host_cmd_ds_add_station sta_info;
 	} params;
 } __packed;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index e8825f302de8..516159b721d3 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -158,6 +158,11 @@ struct mwifiex_bss_info {
 	u8 bssid[ETH_ALEN];
 };
 
+struct mwifiex_sta_info {
+	u8 peer_mac[ETH_ALEN];
+	struct station_parameters *params;
+};
+
 #define MAX_NUM_TID     8
 
 #define MAX_RX_WINSIZE  64
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 7b69d27e0c0e..9c53825f222d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -1398,6 +1398,8 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
 		break;
 	case HostCmd_CMD_UAP_STA_DEAUTH:
 		break;
+	case HostCmd_CMD_ADD_NEW_STATION:
+		break;
 	case HOST_CMD_APCMD_SYS_RESET:
 		break;
 	case HostCmd_CMD_MEF_CFG:
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 491e36611909..073c665183b3 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 				bss_config->key_mgmt = KEY_MGMT_PSK;
 			}
 			break;
+		case WLAN_AKM_SUITE_SAE:
+			bss_config->protocol = PROTOCOL_WPA2;
+			bss_config->key_mgmt = KEY_MGMT_SAE;
+			break;
 		default:
 			break;
 		}
@@ -751,6 +755,28 @@ mwifiex_cmd_uap_sys_config(struct host_cmd_ds_command *cmd, u16 cmd_action,
 	return 0;
 }
 
+/* This function prepares AP start up command with or without host MLME
+ */
+static void mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
+				     struct host_cmd_ds_command *cmd)
+{
+	struct mwifiex_ie_types_host_mlme *tlv;
+	int size;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
+	size = S_DS_GEN;
+
+	if (priv->adapter->host_mlme_enabled) {
+		tlv = (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + size);
+		tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+		tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
+		tlv->host_mlme = 1;
+		size += sizeof(struct mwifiex_ie_types_host_mlme);
+	}
+
+	cmd->size = cpu_to_le16(size);
+}
+
 /* This function prepares AP specific deauth command with mac supplied in
  * function parameter.
  */
@@ -768,6 +794,144 @@ static int mwifiex_cmd_uap_sta_deauth(struct mwifiex_private *priv,
 	return 0;
 }
 
+/* This function prepares AP specific add station command.
+ */
+static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
+				       struct host_cmd_ds_command *cmd,
+				       u16 cmd_action, void *data_buf)
+{
+	struct host_cmd_ds_add_station *new_sta = &cmd->params.sta_info;
+	struct mwifiex_sta_info *add_sta = (struct mwifiex_sta_info *)data_buf;
+	struct station_parameters *params = add_sta->params;
+	struct mwifiex_sta_node *sta_ptr;
+	u8 *pos;
+	u8 qos_capa;
+	u16 header_len = sizeof(struct mwifiex_ie_types_header);
+	u16 tlv_len;
+	int size;
+	struct mwifiex_ie_types_data *tlv;
+	struct mwifiex_ie_types_sta_flag *sta_flag;
+	int i;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_ADD_NEW_STATION);
+	new_sta->action = cpu_to_le16(cmd_action);
+	size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
+
+	if (cmd_action == HostCmd_ACT_ADD_STA)
+		sta_ptr = mwifiex_add_sta_entry(priv, add_sta->peer_mac);
+	else
+		sta_ptr = mwifiex_get_sta_entry(priv, add_sta->peer_mac);
+
+	if (!sta_ptr)
+		return -1;
+
+	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
+
+	if (cmd_action == HostCmd_ACT_REMOVE_STA) {
+		cmd->size = cpu_to_le16(size);
+		return 0;
+	}
+
+	new_sta->aid = cpu_to_le16(params->aid);
+	new_sta->listen_interval = cpu_to_le32(params->listen_interval);
+	new_sta->cap_info = cpu_to_le16(params->capability);
+
+	pos = new_sta->tlv;
+
+	if (params->sta_flags_set & NL80211_STA_FLAG_WME)
+		sta_ptr->is_wmm_enabled = 1;
+	sta_flag = (struct mwifiex_ie_types_sta_flag *)pos;
+	sta_flag->header.type = cpu_to_le16(TLV_TYPE_UAP_STA_FLAGS);
+	sta_flag->header.len = cpu_to_le16(sizeof(__le32));
+	sta_flag->sta_flags = cpu_to_le32(params->sta_flags_set);
+	pos += sizeof(struct mwifiex_ie_types_sta_flag);
+	size += sizeof(struct mwifiex_ie_types_sta_flag);
+
+	if (params->ext_capab_len) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		tlv_len = params->ext_capab_len;
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->ext_capab, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	if (params->link_sta_params.supported_rates_len) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+		tlv_len = params->link_sta_params.supported_rates_len;
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data,
+		       params->link_sta_params.supported_rates, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	if (params->uapsd_queues || params->max_sp) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_QOS_CAPA);
+		tlv_len = sizeof(qos_capa);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		qos_capa = params->uapsd_queues | (params->max_sp << 5);
+		memcpy(tlv->data, &qos_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_wmm_enabled = 1;
+	}
+
+	if (params->link_sta_params.ht_capa) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_ht_cap);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.ht_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_11n_enabled = 1;
+		sta_ptr->max_amsdu =
+			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
+			IEEE80211_HT_CAP_MAX_AMSDU ?
+			MWIFIEX_TX_DATA_BUF_SIZE_8K :
+			MWIFIEX_TX_DATA_BUF_SIZE_4K;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_vht_cap);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.vht_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_11ac_enabled = 1;
+	}
+
+	if (params->link_sta_params.opmode_notif_used) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		tlv_len = sizeof(u8);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, &params->link_sta_params.opmode_notif,
+		       tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		if (sta_ptr->is_11n_enabled)
+			sta_ptr->ampdu_sta[i] =
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			sta_ptr->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
+	}
+
+	memset(sta_ptr->rx_seq, 0xff, sizeof(sta_ptr->rx_seq));
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
 /* This function prepares the AP specific commands before sending them
  * to the firmware.
  * This is a generic function which calls specific command preparation
@@ -785,6 +949,8 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
 			return -1;
 		break;
 	case HostCmd_CMD_UAP_BSS_START:
+		mwifiex_cmd_uap_bss_start(priv, cmd);
+		break;
 	case HostCmd_CMD_UAP_BSS_STOP:
 	case HOST_CMD_APCMD_SYS_RESET:
 	case HOST_CMD_APCMD_STA_LIST:
@@ -800,6 +966,11 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
 							  data_buf))
 			return -1;
 		break;
+	case HostCmd_CMD_ADD_NEW_STATION:
+		if (mwifiex_cmd_uap_add_station(priv, cmd, cmd_action,
+						data_buf))
+			return -1;
+		break;
 	default:
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "PREP_CMD: unknown cmd %#x\n", cmd_no);
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 3817c08a1507..42c04bf858da 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -497,6 +497,30 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
 	}
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP)) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive auth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_deauth(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive deauth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_disassoc(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive disassoc from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_assoc_req(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive assoc req from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_reassoc_req(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive reassoc req from %pM\n",
+				    ieee_hdr->addr2);
+	}
+
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
-- 
2.34.1


