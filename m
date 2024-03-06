Return-Path: <linux-kernel+bounces-93224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF696872C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC7C1F27217
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213513AE2;
	Wed,  6 Mar 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o3dgxg6x"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2AF9C3;
	Wed,  6 Mar 2024 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690480; cv=fail; b=jvNRWXqe0QGean1CYLvZNXMjpkzoWLGFWLKK20Brw/EQPsJH+HoXXc2/O4z1vu6v4lhbU+qPAo2ItVU+ReoORYcfVTmXoSQvbu620UCeTou3wh5GsUWP04+V0Yhaz1Ve9dwvqvT+vAx/RmeuMo+SJ76RD1pBfGXJUNS/Lbl+cZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690480; c=relaxed/simple;
	bh=J6An2zYFqcajOorjrd68setFQCYjuUw/8hJGdexa3+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCnA94sFU/QzUYLa2cU5f5bX+w+ZmjrmopwNe9nqvxYlPdlJRhs3pMRPaURTLBDtY8KIta9R5MQvvcLAtYQH0jyw79kz25AdIpQmPIVIuUwaVN2IOEArxTEdv8Odk/qmJdfsbRY27wLUbprk1k3+9bv/DDA6XEmCIbrAbxghc0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o3dgxg6x; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LydfAAgmErz1KfFUxijLI3G657oLMhV5HL43cxyz2LWkzAzpP/1zd7X03heHurEKmWiSOkF2OhBFUJKeSKd77thbm7MRpyr5Ln37U6XsZ1mVVeA0o7Svw0EK2Y8uNkPirzNxEspCSKRt2jUJeM478RUn+HaaiorXCm5DdJas2bCdUcRHc20Qg2dpFfXplL2mwVqi8ZlhsKB+fS2Nsis8u0c2+QWBxyFg1OgawykqliLVN44UnUeWBhOby6T/tYFEQ0kR/DD2j60uPKMIfvUqS103grLlJX9zZIzaw7KSMt4EW1WyUJiRVGMPdadEE7NDEi8PflEw2Mrolx/XTI4N8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqRQp8Mu5Q28d4VujL1Lni3d2a9/VWNXAOPpWcRbLiU=;
 b=GrtCX8OoRwqrUhcmgCxfSILsJnXRFafk/JeKBFvzoCynNYHl018sf+wxHjwogVEmi9m4dGv7X/I+WRLZugMrg5GehXn96SmblnXnMAs3sa2K1Wr0vqcZv3EN9zRUZVAIgslvnr/BIvCIDQtqJ6tj1noZXwIEg0T4gRVJZq4G2GuTX7B0STTgWZO8rW+Og6cb00yDW2arYuldxAH0XJbl8eOCq1u7lrz2PvXsCyAPUjKp5WNqesZPOFArVpz17n0QarkLV63vlAx8vdgMiCKO1VvO1El3Xw3bxoFXHgvBwwYj043Y/2WZlF/Vmqlfxa8dj0H9kNAYFgzRJuBT9KQOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqRQp8Mu5Q28d4VujL1Lni3d2a9/VWNXAOPpWcRbLiU=;
 b=o3dgxg6xJIYg4H/bhMZN3T1SR4qIFfqjLZJQW+5tsaIa90sb1p55zu1y2/y8OnMnfBu5ThwpxlEToHx+SNA6y5zRCmmL/LAis2I2vdkGrnc168T40R4HSuk5A0ITl1gPq2V5pLWz19J4XSYLt67oP7KzPxmArdIoswBqt7khGb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBBPR04MB7595.eurprd04.prod.outlook.com (2603:10a6:10:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 02:01:13 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 02:01:13 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP mode
Date: Wed,  6 Mar 2024 10:00:53 +0800
Message-Id: <20240306020053.18054-3-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306020053.18054-1-yu-hao.lin@nxp.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DBBPR04MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ebf5c8-4b8f-4521-079c-08dc3d814cf0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 Ye3g9e9XwpqgyT2gcN31ZbTAYIdkNBqw66aJ/VPrmUAOLyN/3Ritp5OJdhcxtRjDzS0dB4O2PicB++jhDz8QXVaiM5aqfI8wVHTTCZ54If8UQ8pZPGHq5HwLh22lLwmfD2dIG6lGmP0AWilCszEbBOXOTfHZNtVJ3rNJac+hyXyvHw+YTMCJQ0Y+c5ZjeXFfZS7ceagP+AKM38N+3wizcChTcowRMZ8KNfgQ7b6BblDnYFFw968HGrW2gmvZgumkR616HDQm2aN0C+CF0bBdJYULFdfgu4susdG4ThL8C3DA/OHAtAuyff6BZW0b9anCB429puZiMPqZF5SU+oFM2vHdID3I4nOuef2Dv+RsGiOG5O9M18NENjasCmvpHdJWYKn+Htg6tlRsLQF4+jEaO1jyvMxWMxaOAj/b9gRkUXu+8KjXWaYkcLm505Ogue8nRUWKsRchM3j/OKGYU+ieqY/ApqDsA6XKkTWm4/MNo6tFo/7jiA5fK7nP/pl7NO+2tlYbzu30rqGXhUqdgVldm/e6OV4bCzBBp5RwORRQvWnMKhwJf8N1+TfGzzN//b884jl1FpFmGup0SzpybufltN63oZgjD9BlPP9Fy+ZL/DeHqWeWxgcw5c0iV1nBmCZXuiKTO+VqqkvFoSCvwabw5s8DmFyJRwrbJv9lteIImDBlO3s+KUUK91rm9S9VIxHO1qZ77Hq2XrJaAglAAMXqjA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?A8eoiHlknR4nhDpvONoRxgLn7/c2BI0f3Thy2tAsUnLTXKPzOY/x2tjAKrGd?=
 =?us-ascii?Q?aAjZjvRYXQHAtEpqWwFj88GXXqdg7FIVLdkV2ZD8DZomaUomJLFXQ2lXx853?=
 =?us-ascii?Q?zqbQIYm5vVFju7UWHinzienEmar1T6XFEpwv0monJo8rGzOIJLDho5eUaJr6?=
 =?us-ascii?Q?SzA9XirOtVfPwdE+QF4QgmZfOsrpLMWfx6rnMWofgxt+GzyWb7B5plD1Cdeh?=
 =?us-ascii?Q?oL/ngO5AN2FMhscdtpG7CAdnhR5dpkq4Gl97/GWYd887WGySmnYL6W4jMZmM?=
 =?us-ascii?Q?39sKqp/tPmabGiUVw13gqpjpEonbGTiiW56AQaOmFkHhwMxnDz2SNbH6auhD?=
 =?us-ascii?Q?M8HjAEZVOjdrzyYRJ9YXMzk4mvMzMbOw+6HfO2NBCia/dD1zmUgKaL9TQap7?=
 =?us-ascii?Q?kLBaJMSjUxIZAkZhmH9HyCmDWvuqWvPNPJCYqJPE83RLeMDjG2Pr2J2A6wEF?=
 =?us-ascii?Q?wYQu/pEQmDKquNtOpsc/6u85VQePBTHxp3BqhkrOFO93aquUOXEqQbQhtbFY?=
 =?us-ascii?Q?GPLkPymvUY5O8zk/paGg3845g9/I1n7voANjJTgyheGmUT3Y9pdzlJuq9f9p?=
 =?us-ascii?Q?Dq+qdMY0zwNvvc93Ft5Yaf2wsjvuNTpq+i+v8oPFNH49n7J/aNYnBSFnJImt?=
 =?us-ascii?Q?2JVIdkbyU/6kIeO9LYRPRk/3I3804LdnAo9WOTfSSLpBUgfIKnNy3I72U77M?=
 =?us-ascii?Q?78Qj3VEy7GwC7VPfs4QNT9kMSUybXFZ9gbtugzYvH0lVP/08joiW0Oq0rF+O?=
 =?us-ascii?Q?yEe1JwcmixscZbjwj/4VqLiI7h8OA+SrskyWnaDh7Ui+IdnWXep8AiShHaZG?=
 =?us-ascii?Q?qhu2ZZEdqG/NGD+TEJRekagTvulKhRsoNBwV9dnA8KB2+rXH6LKk9OlluNNq?=
 =?us-ascii?Q?tkuNhmKVX1ux/1eh9yNPcumvykiJyK9ElYvIWOzWwFBKBSq933WO4K/9pjYw?=
 =?us-ascii?Q?IFTCLE2+xaF9b3KC4/U8loG9x5HnLeDfyUT5648fDU2xmDAKYVNgTdT9oio/?=
 =?us-ascii?Q?rF6RAy3kjlorW2JsCc123i5JncFULxeYBBLlgdS1shvEZlUZ/OcJS/4YV8f5?=
 =?us-ascii?Q?DT3hen7o3d6/8J/Ov/NFg1XIvmDgicHVF3j4orAn3FrGGA6EdKlOHqf5fYjC?=
 =?us-ascii?Q?FuoQGE5EAgKJsLq8XyyDAgnc+MrDs1ejWoDYIDE5goWqCGhiBmwga7oayR5y?=
 =?us-ascii?Q?8oDeIu/2KIXNPSSqLrRfKJdO/MK2rphSryGUnbU67xO40vjl56n3G1xLXDrK?=
 =?us-ascii?Q?YNhqoWt1C9aztkoPgRdSguDlkoqfHxENgK0oWf3ev9p8PyY/F/re8V+3Z5wD?=
 =?us-ascii?Q?SyxSggAb+RfLvgJ/O8zAD99mAMicIGnfmGN5ZlCiy9mv+J6/NVRlD6uwUi/O?=
 =?us-ascii?Q?jfI5XOebkNHE7A0hcxhjoi6NVDUuk7u4zon5J7TDUzgZxWwAm57nmELf796N?=
 =?us-ascii?Q?vAvVsZ8fWGHSKRfsUNkUYVBzXoVx9PH0bz+g5/19eLZkwpQ2I9VkknQQr1QF?=
 =?us-ascii?Q?yELV/19pkhWqUFrke3fOp91T1JEwnWTPsa+kXMIovyHXNJWxMAiy3NDDnbMv?=
 =?us-ascii?Q?Uhv1MbU8HleIRiObrsoaJ/V/xpC1+KHn+Tq1bDHo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ebf5c8-4b8f-4521-079c-08dc3d814cf0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 02:01:13.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjn84+FMylMgKyoaac+za4F6Fbsh3bizgYK2BFqvKXt7A6PDg7Xtsbn2C1FaDILvNEqwREMhNcK4OKYgXuqJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7595

Add host based MLME to enable WPA3 functionalities in AP mode.
This feature required a firmware with the corresponding V2 Key API
support. The feature (WPA3) is currently enabled and verified only
on IW416. Also, verified no regression with change when host MLME
is disabled.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---

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
index bcf4f87dcaab..316f2ada9bf8 100644
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
@@ -4663,6 +4721,17 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
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
@@ -4705,14 +4774,18 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
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
index af82f0401c63..c0614c246b5f 100644
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


