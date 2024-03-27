Return-Path: <linux-kernel+bounces-121627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DEC88EB19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC351C320A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5261311AF;
	Wed, 27 Mar 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZj28CbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D912FB15;
	Wed, 27 Mar 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556635; cv=none; b=s2ugyc6MQRYpP/QFTLHG+UXu+9SnoSlxGw7GyC0GzjNw8kNFb7WJvEvABEp4lK+IM+tBUkNGRZNqBmTvUlNM24TnSGWIcE7TYIVAKF1VOPHZaScpAUwliCh0c3rHPPFY3ctaZk7QzHYPWhBRHegOCLYDhwdmEzmOCDcXtHfdR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556635; c=relaxed/simple;
	bh=DMa+KfMNGcimOcuzIGLRTSIwI3usV9npphrNB87qJZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jbY9hEiyK7bjAv35m05erzZyc/As16JPffSjebRemvvFfe76MLbPDNL7bAelpJkQ0BAaycpJsE3f7+1EafmfR+7PMuM5xRxb9scCGOYU49YjetOOC92FKCYm6b6tUAg72Acf9gJGBIsv12uXzBnAhJv2X/vxoIDLEI14RPqePyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZj28CbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0740EC433C7;
	Wed, 27 Mar 2024 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711556635;
	bh=DMa+KfMNGcimOcuzIGLRTSIwI3usV9npphrNB87qJZo=;
	h=Date:From:To:Cc:Subject:From;
	b=LZj28CbCAHN4JNG90ot6H/8+L4xX9sNh4QWYA34rndqOkaLX3oHSxmvxcmiR9fflx
	 z1NI05DxXuZStR2iotTTgD/zUjfmqTUNBsdIY1l/LFP1+YWmXf2xop9ZZXftC8XLCf
	 ilv/SK6+o6iAZmiZB72SUm6hFvDxjI4FMDlj20iKi+WnUbnp/eVQ/bhdXfynMyR5Ru
	 hBNQzyC5B2DoUt7FIkkFisiJ8Envu7CKLV0VuG+UeKdJfLUgFS28gCk+4OpEE9J59i
	 Su0rWkScLB0VTR0mOoD8BwrSczhAKHIaMLRsKCahXToZCUvMic01eaDkQXcom8QKMA
	 xdf9/GypLbNAw==
Date: Wed, 27 Mar 2024 10:23:51 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] Bluetooth: L2CAP: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <ZgRIF1bkXlZlaK22@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There are currently a couple of objects (`req` and `rsp`), in a couple
of structures, that contain flexible structures (`struct l2cap_ecred_conn_req`
and `struct l2cap_ecred_conn_rsp`), for example:

struct l2cap_ecred_rsp_data {
        struct {
                struct l2cap_ecred_conn_rsp rsp;
                __le16 scid[L2CAP_ECRED_MAX_CID];
        } __packed pdu;
        int count;
};

in the struct above, `struct l2cap_ecred_conn_rsp` is a flexible
structure:

struct l2cap_ecred_conn_rsp {
        __le16 mtu;
        __le16 mps;
        __le16 credits;
        __le16 result;
        __le16 dcid[];
};

So, in order to avoid ending up with a flexible-array member in the
middle of another structure, we use the `struct_group_tagged()` (and
`__struct_group()` when the flexible structure is `__packed`) helper
to separate the flexible array from the rest of the members in the
flexible structure:

struct l2cap_ecred_conn_rsp {
        struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,

	... the rest of members

        );
        __le16 dcid[];
};

With the change described above, we now declare objects of the type of
the tagged struct, in this example `struct l2cap_ecred_conn_rsp_hdr`,
without embedding flexible arrays in the middle of other structures:

struct l2cap_ecred_rsp_data {
        struct {
                struct l2cap_ecred_conn_rsp_hdr rsp;
                __le16 scid[L2CAP_ECRED_MAX_CID];
        } __packed pdu;
        int count;
};

Also, when the flexible-array member needs to be accessed, we use
`container_of()` to retrieve a pointer to the flexible structure.

We also use the `DEFINE_RAW_FLEX()` helper for a couple of on-stack
definitions of a flexible structure where the size of the flexible-array
member is known at compile-time.

So, with these changes, fix the following warnings:
net/bluetooth/l2cap_core.c:1260:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/bluetooth/l2cap_core.c:3740:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/bluetooth/l2cap_core.c:4999:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/bluetooth/l2cap_core.c:7116:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Add a couple of code comments.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZgMpynzZ8FltPCi3@neat/

Hi!

I wonder if `struct l2cap_ecred_conn_rsp` should also be `__packed`.

Thanks
 - Gustavo

 include/net/bluetooth/l2cap.h | 22 +++++++++++------
 net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a4278aa618ab..7d4a3e766e7b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -463,18 +463,24 @@ struct l2cap_le_credits {
 #define L2CAP_ECRED_MAX_CID		5
 
 struct l2cap_ecred_conn_req {
-	__le16 psm;
-	__le16 mtu;
-	__le16 mps;
-	__le16 credits;
+	/* New members must be added within the struct_group() macro below. */
+	__struct_group(l2cap_ecred_conn_req_hdr, hdr, __packed,
+		__le16 psm;
+		__le16 mtu;
+		__le16 mps;
+		__le16 credits;
+	);
 	__le16 scid[];
 } __packed;
 
 struct l2cap_ecred_conn_rsp {
-	__le16 mtu;
-	__le16 mps;
-	__le16 credits;
-	__le16 result;
+	/* New members must be added within the struct_group() macro below. */
+	struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
+		__le16 mtu;
+		__le16 mps;
+		__le16 credits;
+		__le16 result;
+	);
 	__le16 dcid[];
 };
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 467b242d8be0..bf087eca489e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1257,7 +1257,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 
 struct l2cap_ecred_conn_data {
 	struct {
-		struct l2cap_ecred_conn_req req;
+		struct l2cap_ecred_conn_req_hdr req;
 		__le16 scid[5];
 	} __packed pdu;
 	struct l2cap_chan *chan;
@@ -3737,7 +3737,7 @@ static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
 
 struct l2cap_ecred_rsp_data {
 	struct {
-		struct l2cap_ecred_conn_rsp rsp;
+		struct l2cap_ecred_conn_rsp_hdr rsp;
 		__le16 scid[L2CAP_ECRED_MAX_CID];
 	} __packed pdu;
 	int count;
@@ -3746,6 +3746,8 @@ struct l2cap_ecred_rsp_data {
 static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_ecred_rsp_data *rsp = data;
+	struct l2cap_ecred_conn_rsp *rsp_flex =
+		container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
 
 	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
@@ -3755,7 +3757,7 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 
 	/* Include all channels pending with the same ident */
 	if (!rsp->pdu.rsp.result)
-		rsp->pdu.rsp.dcid[rsp->count++] = cpu_to_le16(chan->scid);
+		rsp_flex->dcid[rsp->count++] = cpu_to_le16(chan->scid);
 	else
 		l2cap_chan_del(chan, ECONNRESET);
 }
@@ -4995,10 +4997,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 				       u8 *data)
 {
 	struct l2cap_ecred_conn_req *req = (void *) data;
-	struct {
-		struct l2cap_ecred_conn_rsp rsp;
-		__le16 dcid[L2CAP_ECRED_MAX_CID];
-	} __packed pdu;
+	DEFINE_RAW_FLEX(struct l2cap_ecred_conn_rsp, pdu, dcid, L2CAP_ECRED_MAX_CID);
 	struct l2cap_chan *chan, *pchan;
 	u16 mtu, mps;
 	__le16 psm;
@@ -5017,7 +5016,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-	if (num_scid > ARRAY_SIZE(pdu.dcid)) {
+	if (num_scid > L2CAP_ECRED_MAX_CID) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
@@ -5046,7 +5045,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps);
 
-	memset(&pdu, 0, sizeof(pdu));
+	memset(pdu, 0, sizeof(*pdu));
 
 	/* Check if we have socket listening on psm */
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
@@ -5072,8 +5071,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 		BT_DBG("scid[%d] 0x%4.4x", i, scid);
 
-		pdu.dcid[i] = 0x0000;
-		len += sizeof(*pdu.dcid);
+		pdu->dcid[i] = 0x0000;
+		len += sizeof(*pdu->dcid);
 
 		/* Check for valid dynamic CID range */
 		if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
@@ -5107,13 +5106,13 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
-		if (!pdu.rsp.credits) {
-			pdu.rsp.mtu = cpu_to_le16(chan->imtu);
-			pdu.rsp.mps = cpu_to_le16(chan->mps);
-			pdu.rsp.credits = cpu_to_le16(chan->rx_credits);
+		if (!pdu->credits) {
+			pdu->mtu = cpu_to_le16(chan->imtu);
+			pdu->mps = cpu_to_le16(chan->mps);
+			pdu->credits = cpu_to_le16(chan->rx_credits);
 		}
 
-		pdu.dcid[i] = cpu_to_le16(chan->scid);
+		pdu->dcid[i] = cpu_to_le16(chan->scid);
 
 		__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
@@ -5135,13 +5134,13 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	l2cap_chan_put(pchan);
 
 response:
-	pdu.rsp.result = cpu_to_le16(result);
+	pdu->result = cpu_to_le16(result);
 
 	if (defer)
 		return 0;
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
-		       sizeof(pdu.rsp) + len, &pdu);
+		       sizeof(*pdu) + len, pdu);
 
 	return 0;
 }
@@ -7112,14 +7111,11 @@ EXPORT_SYMBOL_GPL(l2cap_chan_connect);
 static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
-	struct {
-		struct l2cap_ecred_reconf_req req;
-		__le16 scid;
-	} pdu;
+	DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
 
-	pdu.req.mtu = cpu_to_le16(chan->imtu);
-	pdu.req.mps = cpu_to_le16(chan->mps);
-	pdu.scid    = cpu_to_le16(chan->scid);
+	pdu->mtu = cpu_to_le16(chan->imtu);
+	pdu->mps = cpu_to_le16(chan->mps);
+	pdu->scid[0] = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
 
-- 
2.34.1


