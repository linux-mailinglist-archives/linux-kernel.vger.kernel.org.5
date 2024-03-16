Return-Path: <linux-kernel+bounces-105208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3F87DA87
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920131C20D64
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C191B96B;
	Sat, 16 Mar 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="LA44o8ov"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6D182B5;
	Sat, 16 Mar 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710601664; cv=none; b=caaexmRCDFtLQh3isLDDoOeRr+THCtzS4blaz+Il+nxwFxP4jIrmoxglyOuaeKj6XHczBNNUYCLSGyXkEJfV7IU8dYymIlStu6SbGS0/xcRLCxGHhQ7Cmdf5eOTEflljS2H2i0c9JaiTeU4zbi9T55spynnated76G9v8dssn64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710601664; c=relaxed/simple;
	bh=J5p605901tABr3dI/WUTaNCBGV0Xhd0cnesQah9lOaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyx8ZrlwaqRRXrvxawmWPAiqyNSLhDWwHCCi7eHfK4wfc58HpQcU1afDymUe/cdsOun9CYp30wQenpie8wmOQDmzvnyYLRwwB3H8u24O7sFOTLIpDGRZAkTRiVoNs7+SaRUxQmp3dnjDMMFPIsh+DcPt+K1lfkk4FdrB+fIokbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=LA44o8ov; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710601648; x=1711206448; i=erick.archer@gmx.com;
	bh=W75pinddEAgthGH8bYZ1ySORlAJyGbu0JP47ZCwRdRU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=LA44o8ovtqdbYhjPnl/Uh79Fs+aL9rW6ZqTNfgm+dMGgSsi+LHdU2eRjvsAXZZXb
	 S6rn24BzeBICWgtijWNqN6lXoej87Lik2cWo7XlwJ8Rw4TfQiKGLKQnH+OBR2yqG4
	 JsYQHIZ1GfFcomHrBiyXuqeZ2TN5n7h8fz/9xnzB5LPaS7aAm87BIokHtOKYGQ+k/
	 5wL4/OTX7NjF25GRGnkpqdpfgBu9v9p7u1vQDTSf3sF2dIc+rbmuNH5rvTS3wI4Xp
	 QdKqcSmQnx8YD+clyddw/rGVNkAN1N2vNozaLTtr3qLHBEg035rQZY6gVLzBSouHU
	 Cra+2rK6YpFkZwwPqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N0oFz-1qoqXS3lHJ-00wiZD; Sat, 16 Mar 2024 16:07:28 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mwl8k: Avoid overlapping composite structs that contain flex-arrays
Date: Sat, 16 Mar 2024 16:07:12 +0100
Message-Id: <20240316150712.4633-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m/Y2vi9nmlI/NiXbgUQ5DDJjboaYsWDeDUXiKSEfx0PQOHXWmQk
 kYydip+skzBq8DiwmPmsCGFTwKZhPq3sIfeXszakwyzEJDF6UKS1fgpVymeDn9yLC25n+Td
 blSXCODiussc3fy1fEmY3kCIHFORpXzj7C9ZUvb3w6QEeKmkzTW4MclT7FqJVmZEFlvWpTu
 pPXE+hBXN6QEwXKxJz7mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+2Vgn2EaA24=;bHHNBVybvXhLwBKhYkh8U/zOZtl
 wMx4CDAkit1G9MvMuenFngaH57XyyQ+fsQIhz4RAFbLjgsRmmJYwhcxf0xYqOSwyWBHMnkyrh
 Rojsom532ztn7+wC7gHwz52WojC9DzPa+7gJzt2tCuXnvx9oHIq2Y2pIoP4f/hzkCgE21z53e
 AXOpwXU+/tEg9ivVX+YCAJ19iarnvGYankIPFBm2HKGTKS//7yERoFKo4az5b1knnqSvsLgbO
 MAQDzxAACuGRxZT1WxNEMb9YF5J7pSydkrpkGakeDf4V2bkD4yccxqGeXE1ZPInZJh3lwxKZZ
 69VHczO202Qr/DPa1M2/k8yinvsSwVUr/tvgE2WY2/lVilK2yG1MY3yjz0drXANyIxAxhIafy
 lry2eC5ARR1HA7CYZ4yC35wO6FpLcWbT2bi1/EWQWOzovdIQSNyCk+i5GYCFqrUCBZ0Bug2iM
 B/vlEN/txI2L1dpQW4a0UFUYotGKRzQHStSDn+6bVBg3Cx7YMqPjskvNFpwQb56luO/+8h5vs
 CHLzBHxHJdlS7/FB+5RWRBnrJbG4R7dycLdJgQXe6fNi//DdoMQBTAUHgzAi8mYQk8zyoPeGO
 OhHbiMlR6S6Vgjr2anlD7TovNYWa8RECgHYG9aokGx9hFTwVm2Z0KyM2JBIAp1wJ47KOGyQl1
 Z5uLBQBC+91XgkBz+SDoniTJJ4MA6DuL3yolmTnAYhMLRCU/feZh/7AFyE2o8KWhiqKNnJm+O
 CND6q1oZwqpHeeglVVxpjbG+blbEeWF72Tv/E1DA6zkn55E5Dsgr7hYaqUaoLGtnpJB7aoa/S
 Jutbqo65Mgt995/SdvuZI/taA9J5kH+CB7gt0WcSmN5Uk=

When a struct containing a flexible array is included in another struct,
and there is a member after the struct-with-flex-array, there is a
possibility of memory overlap. These cases must be audited [1]. See:

struct inner {
	...
	int flex[];
};

struct outer {
	...
	struct inner header;
	int overlap;
	...
};

This is the scenario for the "struct mwl8k_cmd_pkt" structure that is
included in the following "struct mwl8k_cmd_*" structures:

struct mwl8k_cmd_get_hw_spec_sta
struct mwl8k_cmd_get_hw_spec_ap
struct mwl8k_cmd_set_hw_spec
struct mwl8k_cmd_mac_multicast_adr
struct mwl8k_cmd_get_stat
struct mwl8k_cmd_radio_control
struct mwl8k_cmd_rf_tx_power
struct mwl8k_cmd_tx_power
struct mwl8k_cmd_rf_antenna
struct mwl8k_cmd_set_beacon
struct mwl8k_cmd_bbp_reg_access
struct mwl8k_cmd_set_post_scan
struct mwl8k_cmd_set_rf_channel
struct mwl8k_cmd_update_set_aid
struct mwl8k_cmd_set_rate
struct mwl8k_cmd_finalize_join
struct mwl8k_cmd_set_rts_threshold
struct mwl8k_cmd_set_slot
struct mwl8k_cmd_set_edca_params
struct mwl8k_cmd_set_wmm_mode
struct mwl8k_cmd_mimo_config
struct mwl8k_cmd_use_fixed_rate_sta
struct mwl8k_cmd_use_fixed_rate_ap
struct mwl8k_cmd_enable_sniffer
struct mwl8k_cmd_update_mac_addr
struct mwl8k_cmd_set_rate_adapt_mode
struct mwl8k_cmd_get_watchdog_bitmap
struct mwl8k_cmd_bss_start
struct mwl8k_cmd_bastream
struct mwl8k_cmd_set_new_stn
struct mwl8k_cmd_update_encryption
struct mwl8k_cmd_set_key
struct mwl8k_cmd_update_stadb

The pattern is like the one shown below:

struct mwl8k_cmd_pkt {
	...
	char payload[];
} __packed;

struct mwl8k_cmd_* {
	struct mwl8k_cmd_pkt header;
	...
};

In this case, because the flexible array "payload" is only used in the
"mwl8k_load_fw_image" function, it is best to define a new structure for
the packet header called "struct mwl8k_cmd_pkt_hdr". This way, the
"struct mwl8k_cmd_pkt" and all the affected "struct mwl8k_cmd_*" used
for commands can now be defined using this new header structure.

For consistency, although the "struct mwl8k_cmd_set_pre_scan" does not
suffer from the overlapping scenario, also use the new header structure
to define it.

Moreover, change the prototype of the "mwl8k_post_cmd" function and the
"mwl8k_post_pervif_cmd" function because it is not necessary to pass the
whole packet structure. It is enough to use only the header structure.
Also, change the return type of the "__mwl8k_cmd_mac_multicast_adr"
function for the same reason.

As a final point, refactor the necessary calls, use the new members of
the structures and change some variable names and types to achieve the
desired goal.

Link: https://github.com/KSPP/linux/issues/202 [1]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Hi everyone,

This patch is based on my understanding of the code. Any comments would
be greatly appreciated.

Also, I have verified that the old and new packet structure are the same
size:

struct mwl8k_cmd_pkt_old {
        __le16  code;
        __le16  length;
        __u8    seq_num;
        __u8    macid;
        __le16  result;
        char    payload[];
} __packed;

struct mwl8k_cmd_pkt_hdr {
        __le16  code;
        __le16  length;
        __u8    seq_num;
        __u8    macid;
        __le16  result;
} __packed;

struct mwl8k_cmd_pkt_new {
        struct mwl8k_cmd_pkt_hdr header;
        char payload[];
} __packed;

static_assert(sizeof(struct mwl8k_cmd_pkt_old) =3D=3D sizeof(struct mwl8k_=
cmd_pkt_new));

Best regards,
Erick
=2D--
 drivers/net/wireless/marvell/mwl8k.c | 145 ++++++++++++++-------------
 1 file changed, 75 insertions(+), 70 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/m=
arvell/mwl8k.c
index ce8fea76dbb2..57de32ba4efc 100644
=2D-- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -586,13 +586,17 @@ static int mwl8k_request_firmware(struct mwl8k_priv =
*priv, char *fw_image,
 	return 0;
 }

-struct mwl8k_cmd_pkt {
+struct mwl8k_cmd_pkt_hdr {
 	__le16	code;
 	__le16	length;
 	__u8	seq_num;
 	__u8	macid;
 	__le16	result;
-	char	payload[];
+} __packed;
+
+struct mwl8k_cmd_pkt {
+	struct mwl8k_cmd_pkt_hdr header;
+	char payload[];
 } __packed;

 /*
@@ -652,17 +656,17 @@ static int mwl8k_load_fw_image(struct mwl8k_priv *pr=
iv,
 	if (cmd =3D=3D NULL)
 		return -ENOMEM;

-	cmd->code =3D cpu_to_le16(MWL8K_CMD_CODE_DNLD);
-	cmd->seq_num =3D 0;
-	cmd->macid =3D 0;
-	cmd->result =3D 0;
+	cmd->header.code =3D cpu_to_le16(MWL8K_CMD_CODE_DNLD);
+	cmd->header.seq_num =3D 0;
+	cmd->header.macid =3D 0;
+	cmd->header.result =3D 0;

 	done =3D 0;
 	while (length) {
 		int block_size =3D length > 256 ? 256 : length;

 		memcpy(cmd->payload, data + done, block_size);
-		cmd->length =3D cpu_to_le16(block_size);
+		cmd->header.length =3D cpu_to_le16(block_size);

 		rc =3D mwl8k_send_fw_load_cmd(priv, cmd,
 						sizeof(*cmd) + block_size);
@@ -674,7 +678,7 @@ static int mwl8k_load_fw_image(struct mwl8k_priv *priv=
,
 	}

 	if (!rc) {
-		cmd->length =3D 0;
+		cmd->header.length =3D 0;
 		rc =3D mwl8k_send_fw_load_cmd(priv, cmd, sizeof(*cmd));
 	}

@@ -2201,7 +2205,8 @@ static void mwl8k_enable_bsses(struct ieee80211_hw *=
hw, bool enable,
 /* Timeout firmware commands after 10s */
 #define MWL8K_CMD_TIMEOUT_MS	10000

-static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt *=
cmd)
+static int mwl8k_post_cmd(struct ieee80211_hw *hw,
+			  struct mwl8k_cmd_pkt_hdr *hdr)
 {
 	DECLARE_COMPLETION_ONSTACK(cmd_wait);
 	struct mwl8k_priv *priv =3D hw->priv;
@@ -2214,7 +2219,7 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, s=
truct mwl8k_cmd_pkt *cmd)
 	u32 bitmap =3D 0;

 	wiphy_dbg(hw->wiphy, "Posting %s [%d]\n",
-		  mwl8k_cmd_name(cmd->code, buf, sizeof(buf)), cmd->macid);
+		  mwl8k_cmd_name(hdr->code, buf, sizeof(buf)), hdr->macid);

 	/* Before posting firmware commands that could change the hardware
 	 * characteristics, make sure that all BSSes are stopped temporary.
@@ -2226,7 +2231,7 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, s=
truct mwl8k_cmd_pkt *cmd)
 		return rc;

 	if (priv->ap_fw && priv->running_bsses) {
-		switch (le16_to_cpu(cmd->code)) {
+		switch (le16_to_cpu(hdr->code)) {
 		case MWL8K_CMD_SET_RF_CHANNEL:
 		case MWL8K_CMD_RADIO_CONTROL:
 		case MWL8K_CMD_RF_TX_POWER:
@@ -2240,9 +2245,9 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, s=
truct mwl8k_cmd_pkt *cmd)
 		}
 	}

-	cmd->result =3D (__force __le16) 0xffff;
-	dma_size =3D le16_to_cpu(cmd->length);
-	dma_addr =3D dma_map_single(&priv->pdev->dev, cmd, dma_size,
+	hdr->result =3D (__force __le16)0xffff;
+	dma_size =3D le16_to_cpu(hdr->length);
+	dma_addr =3D dma_map_single(&priv->pdev->dev, hdr, dma_size,
 				  DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(&priv->pdev->dev, dma_addr)) {
 		rc =3D -ENOMEM;
@@ -2267,7 +2272,7 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, s=
truct mwl8k_cmd_pkt *cmd)

 	if (!timeout) {
 		wiphy_err(hw->wiphy, "Command %s timeout after %u ms\n",
-			  mwl8k_cmd_name(cmd->code, buf, sizeof(buf)),
+			  mwl8k_cmd_name(hdr->code, buf, sizeof(buf)),
 			  MWL8K_CMD_TIMEOUT_MS);
 		rc =3D -ETIMEDOUT;
 	} else {
@@ -2275,15 +2280,15 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw,=
 struct mwl8k_cmd_pkt *cmd)

 		ms =3D MWL8K_CMD_TIMEOUT_MS - jiffies_to_msecs(timeout);

-		rc =3D cmd->result ? -EINVAL : 0;
+		rc =3D hdr->result ? -EINVAL : 0;
 		if (rc)
 			wiphy_err(hw->wiphy, "Command %s error 0x%x\n",
-				  mwl8k_cmd_name(cmd->code, buf, sizeof(buf)),
-				  le16_to_cpu(cmd->result));
+				  mwl8k_cmd_name(hdr->code, buf, sizeof(buf)),
+				  le16_to_cpu(hdr->result));
 		else if (ms > 2000)
 			wiphy_notice(hw->wiphy, "Command %s took %d ms\n",
-				     mwl8k_cmd_name(cmd->code,
-						    buf, sizeof(buf)),
+				     mwl8k_cmd_name(hdr->code, buf,
+						    sizeof(buf)),
 				     ms);
 	}

@@ -2298,11 +2303,11 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw,=
 struct mwl8k_cmd_pkt *cmd)

 static int mwl8k_post_pervif_cmd(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct mwl8k_cmd_pkt *cmd)
+				 struct mwl8k_cmd_pkt_hdr *hdr)
 {
 	if (vif !=3D NULL)
-		cmd->macid =3D MWL8K_VIF(vif)->macid;
-	return mwl8k_post_cmd(hw, cmd);
+		hdr->macid =3D MWL8K_VIF(vif)->macid;
+	return mwl8k_post_cmd(hw, hdr);
 }

 /*
@@ -2350,7 +2355,7 @@ static void mwl8k_setup_5ghz_band(struct ieee80211_h=
w *hw)
  * CMD_GET_HW_SPEC (STA version).
  */
 struct mwl8k_cmd_get_hw_spec_sta {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__u8 hw_rev;
 	__u8 host_interface;
 	__le16 num_mcaddrs;
@@ -2499,7 +2504,7 @@ static int mwl8k_cmd_get_hw_spec_sta(struct ieee8021=
1_hw *hw)
  * CMD_GET_HW_SPEC (AP version).
  */
 struct mwl8k_cmd_get_hw_spec_ap {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__u8 hw_rev;
 	__u8 host_interface;
 	__le16 num_wcb;
@@ -2593,7 +2598,7 @@ static int mwl8k_cmd_get_hw_spec_ap(struct ieee80211=
_hw *hw)
  * CMD_SET_HW_SPEC.
  */
 struct mwl8k_cmd_set_hw_spec {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__u8 hw_rev;
 	__u8 host_interface;
 	__le16 num_mcaddrs;
@@ -2670,7 +2675,7 @@ static int mwl8k_cmd_set_hw_spec(struct ieee80211_hw=
 *hw)
  * CMD_MAC_MULTICAST_ADR.
  */
 struct mwl8k_cmd_mac_multicast_adr {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 numaddr;
 	__u8 addr[][ETH_ALEN];
@@ -2681,7 +2686,7 @@ struct mwl8k_cmd_mac_multicast_adr {
 #define MWL8K_ENABLE_RX_ALL_MULTICAST	0x0004
 #define MWL8K_ENABLE_RX_BROADCAST	0x0008

-static struct mwl8k_cmd_pkt *
+static struct mwl8k_cmd_pkt_hdr *
 __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
 			      struct netdev_hw_addr_list *mc_list)
 {
@@ -2729,7 +2734,7 @@ __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *h=
w, int allmulti,
  * CMD_GET_STAT.
  */
 struct mwl8k_cmd_get_stat {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 stats[64];
 } __packed;

@@ -2771,7 +2776,7 @@ static int mwl8k_cmd_get_stat(struct ieee80211_hw *h=
w,
  * CMD_RADIO_CONTROL.
  */
 struct mwl8k_cmd_radio_control {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 control;
 	__le16 radio_on;
@@ -2832,7 +2837,7 @@ mwl8k_set_radio_preamble(struct ieee80211_hw *hw, bo=
ol short_preamble)
 #define MWL8K_RF_TX_POWER_LEVEL_TOTAL	8

 struct mwl8k_cmd_rf_tx_power {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 support_level;
 	__le16 current_level;
@@ -2866,7 +2871,7 @@ static int mwl8k_cmd_rf_tx_power(struct ieee80211_hw=
 *hw, int dBm)
 #define MWL8K_TX_POWER_LEVEL_TOTAL      12

 struct mwl8k_cmd_tx_power {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 band;
 	__le16 channel;
@@ -2925,7 +2930,7 @@ static int mwl8k_cmd_tx_power(struct ieee80211_hw *h=
w,
  * CMD_RF_ANTENNA.
  */
 struct mwl8k_cmd_rf_antenna {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 antenna;
 	__le16 mode;
 } __packed;
@@ -2958,7 +2963,7 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int an=
tenna, int mask)
  * CMD_SET_BEACON.
  */
 struct mwl8k_cmd_set_beacon {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 beacon_len;
 	__u8 beacon[];
 };
@@ -2988,7 +2993,7 @@ static int mwl8k_cmd_set_beacon(struct ieee80211_hw =
*hw,
  * CMD_SET_PRE_SCAN.
  */
 struct mwl8k_cmd_set_pre_scan {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 } __packed;

 static int mwl8k_cmd_set_pre_scan(struct ieee80211_hw *hw)
@@ -3013,7 +3018,7 @@ static int mwl8k_cmd_set_pre_scan(struct ieee80211_h=
w *hw)
  * CMD_BBP_REG_ACCESS.
  */
 struct mwl8k_cmd_bbp_reg_access {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 offset;
 	u8 value;
@@ -3054,7 +3059,7 @@ mwl8k_cmd_bbp_reg_access(struct ieee80211_hw *hw,
  * CMD_SET_POST_SCAN.
  */
 struct mwl8k_cmd_set_post_scan {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 isibss;
 	__u8 bssid[ETH_ALEN];
 } __packed;
@@ -3142,7 +3147,7 @@ static void mwl8k_update_survey(struct mwl8k_priv *p=
riv,
  * CMD_SET_RF_CHANNEL.
  */
 struct mwl8k_cmd_set_rf_channel {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__u8 current_channel;
 	__le32 channel_flags;
@@ -3211,7 +3216,7 @@ static int mwl8k_cmd_set_rf_channel(struct ieee80211=
_hw *hw,
 #define MWL8K_FRAME_PROT_11N_HT_ALL			0x06

 struct mwl8k_cmd_update_set_aid {
-	struct	mwl8k_cmd_pkt header;
+	struct	mwl8k_cmd_pkt_hdr header;
 	__le16	aid;

 	 /* AP's MAC address (BSSID) */
@@ -3283,7 +3288,7 @@ mwl8k_cmd_set_aid(struct ieee80211_hw *hw,
  * CMD_SET_RATE.
  */
 struct mwl8k_cmd_set_rate {
-	struct	mwl8k_cmd_pkt header;
+	struct	mwl8k_cmd_pkt_hdr header;
 	__u8	legacy_rates[14];

 	/* Bitmap for supported MCS codes.  */
@@ -3319,7 +3324,7 @@ mwl8k_cmd_set_rate(struct ieee80211_hw *hw, struct i=
eee80211_vif *vif,
 #define MWL8K_FJ_BEACON_MAXLEN	128

 struct mwl8k_cmd_finalize_join {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 sleep_interval;	/* Number of beacon periods to sleep */
 	__u8 beacon_data[MWL8K_FJ_BEACON_MAXLEN];
 } __packed;
@@ -3358,7 +3363,7 @@ static int mwl8k_cmd_finalize_join(struct ieee80211_=
hw *hw, void *frame,
  * CMD_SET_RTS_THRESHOLD.
  */
 struct mwl8k_cmd_set_rts_threshold {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 threshold;
 } __packed;
@@ -3388,7 +3393,7 @@ mwl8k_cmd_set_rts_threshold(struct ieee80211_hw *hw,=
 int rts_thresh)
  * CMD_SET_SLOT.
  */
 struct mwl8k_cmd_set_slot {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__u8 short_slot;
 } __packed;
@@ -3417,7 +3422,7 @@ static int mwl8k_cmd_set_slot(struct ieee80211_hw *h=
w, bool short_slot_time)
  * CMD_SET_EDCA_PARAMS.
  */
 struct mwl8k_cmd_set_edca_params {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;

 	/* See MWL8K_SET_EDCA_XXX below */
 	__le16 action;
@@ -3502,7 +3507,7 @@ mwl8k_cmd_set_edca_params(struct ieee80211_hw *hw, _=
_u8 qnum,
  * CMD_SET_WMM_MODE.
  */
 struct mwl8k_cmd_set_wmm_mode {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 } __packed;

@@ -3533,7 +3538,7 @@ static int mwl8k_cmd_set_wmm_mode(struct ieee80211_h=
w *hw, bool enable)
  * CMD_MIMO_CONFIG.
  */
 struct mwl8k_cmd_mimo_config {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 	__u8 rx_antenna_map;
 	__u8 tx_antenna_map;
@@ -3564,7 +3569,7 @@ static int mwl8k_cmd_mimo_config(struct ieee80211_hw=
 *hw, __u8 rx, __u8 tx)
  * CMD_USE_FIXED_RATE (STA version).
  */
 struct mwl8k_cmd_use_fixed_rate_sta {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 	__le32 allow_rate_drop;
 	__le32 num_rates;
@@ -3606,7 +3611,7 @@ static int mwl8k_cmd_use_fixed_rate_sta(struct ieee8=
0211_hw *hw)
  * CMD_USE_FIXED_RATE (AP version).
  */
 struct mwl8k_cmd_use_fixed_rate_ap {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 	__le32 allow_rate_drop;
 	__le32 num_rates;
@@ -3647,7 +3652,7 @@ mwl8k_cmd_use_fixed_rate_ap(struct ieee80211_hw *hw,=
 int mcast, int mgmt)
  * CMD_ENABLE_SNIFFER.
  */
 struct mwl8k_cmd_enable_sniffer {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 action;
 } __packed;

@@ -3671,7 +3676,7 @@ static int mwl8k_cmd_enable_sniffer(struct ieee80211=
_hw *hw, bool enable)
 }

 struct mwl8k_cmd_update_mac_addr {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	union {
 		struct {
 			__le16 mac_type;
@@ -3756,7 +3761,7 @@ static inline int mwl8k_cmd_del_mac_addr(struct ieee=
80211_hw *hw,
  * CMD_SET_RATEADAPT_MODE.
  */
 struct mwl8k_cmd_set_rate_adapt_mode {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 action;
 	__le16 mode;
 } __packed;
@@ -3785,7 +3790,7 @@ static int mwl8k_cmd_set_rateadapt_mode(struct ieee8=
0211_hw *hw, __u16 mode)
  * CMD_GET_WATCHDOG_BITMAP.
  */
 struct mwl8k_cmd_get_watchdog_bitmap {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	u8	bitmap;
 } __packed;

@@ -3865,7 +3870,7 @@ static void mwl8k_watchdog_ba_events(struct work_str=
uct *work)
  * CMD_BSS_START.
  */
 struct mwl8k_cmd_bss_start {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le32 enable;
 } __packed;

@@ -3960,7 +3965,7 @@ struct mwl8k_destroy_ba_stream {
 } __packed;

 struct mwl8k_cmd_bastream {
-	struct mwl8k_cmd_pkt	header;
+	struct mwl8k_cmd_pkt_hdr	header;
 	__le32	action;
 	union {
 		struct mwl8k_create_ba_stream	create_params;
@@ -4070,7 +4075,7 @@ static void mwl8k_destroy_ba(struct ieee80211_hw *hw=
,
  * CMD_SET_NEW_STN.
  */
 struct mwl8k_cmd_set_new_stn {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;
 	__le16 aid;
 	__u8 mac_addr[6];
 	__le16 stn_id;
@@ -4206,7 +4211,7 @@ static int mwl8k_cmd_set_new_stn_del(struct ieee8021=
1_hw *hw,
 #define MIC_KEY_LENGTH		8

 struct mwl8k_cmd_update_encryption {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;

 	__le32 action;
 	__le32 reserved;
@@ -4216,7 +4221,7 @@ struct mwl8k_cmd_update_encryption {
 } __packed;

 struct mwl8k_cmd_set_key {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;

 	__le32 action;
 	__le32 reserved;
@@ -4504,7 +4509,7 @@ struct peer_capability_info {
 } __packed;

 struct mwl8k_cmd_update_stadb {
-	struct mwl8k_cmd_pkt header;
+	struct mwl8k_cmd_pkt_hdr header;

 	/* See STADB_ACTION_TYPE */
 	__le32	action;
@@ -5174,7 +5179,7 @@ mwl8k_bss_info_changed(struct ieee80211_hw *hw, stru=
ct ieee80211_vif *vif,
 static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
 				   struct netdev_hw_addr_list *mc_list)
 {
-	struct mwl8k_cmd_pkt *cmd;
+	struct mwl8k_cmd_pkt_hdr *hdr;

 	/*
 	 * Synthesize and return a command packet that programs the
@@ -5183,9 +5188,9 @@ static u64 mwl8k_prepare_multicast(struct ieee80211_=
hw *hw,
 	 * we'll end up throwing this packet away and creating a new
 	 * one in mwl8k_configure_filter().
 	 */
-	cmd =3D __mwl8k_cmd_mac_multicast_adr(hw, 0, mc_list);
+	hdr =3D __mwl8k_cmd_mac_multicast_adr(hw, 0, mc_list);

-	return (unsigned long)cmd;
+	return (unsigned long)hdr;
 }

 static int
@@ -5234,7 +5239,7 @@ static void mwl8k_configure_filter(struct ieee80211_=
hw *hw,
 				   u64 multicast)
 {
 	struct mwl8k_priv *priv =3D hw->priv;
-	struct mwl8k_cmd_pkt *cmd =3D (void *)(unsigned long)multicast;
+	struct mwl8k_cmd_pkt_hdr *hdr =3D (void *)(unsigned long)multicast;

 	/*
 	 * AP firmware doesn't allow fine-grained control over
@@ -5242,7 +5247,7 @@ static void mwl8k_configure_filter(struct ieee80211_=
hw *hw,
 	 */
 	if (priv->ap_fw) {
 		*total_flags &=3D FIF_ALLMULTI | FIF_BCN_PRBRESP_PROMISC;
-		kfree(cmd);
+		kfree(hdr);
 		return;
 	}

@@ -5252,7 +5257,7 @@ static void mwl8k_configure_filter(struct ieee80211_=
hw *hw,
 	 */
 	if (*total_flags & (FIF_CONTROL | FIF_OTHER_BSS) &&
 	    mwl8k_configure_filter_sniffer(hw, changed_flags, total_flags)) {
-		kfree(cmd);
+		kfree(hdr);
 		return;
 	}

@@ -5260,7 +5265,7 @@ static void mwl8k_configure_filter(struct ieee80211_=
hw *hw,
 	*total_flags &=3D FIF_ALLMULTI | FIF_BCN_PRBRESP_PROMISC;

 	if (mwl8k_fw_lock(hw)) {
-		kfree(cmd);
+		kfree(hdr);
 		return;
 	}

@@ -5304,13 +5309,13 @@ static void mwl8k_configure_filter(struct ieee8021=
1_hw *hw,
 	 * packets.
 	 */
 	if (*total_flags & FIF_ALLMULTI) {
-		kfree(cmd);
-		cmd =3D __mwl8k_cmd_mac_multicast_adr(hw, 1, NULL);
+		kfree(hdr);
+		hdr =3D __mwl8k_cmd_mac_multicast_adr(hw, 1, NULL);
 	}

-	if (cmd !=3D NULL) {
-		mwl8k_post_cmd(hw, cmd);
-		kfree(cmd);
+	if (hdr) {
+		mwl8k_post_cmd(hw, hdr);
+		kfree(hdr);
 	}

 	mwl8k_fw_unlock(hw);
=2D-
2.25.1


