Return-Path: <linux-kernel+bounces-119853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88D88CDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB351C356B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCF113D29F;
	Tue, 26 Mar 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfcaf5a8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9B481A3;
	Tue, 26 Mar 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483341; cv=none; b=RHiXz0PiE189ehr1mTjEbyaZVPyKc01hUJYx/7YIbj3hxjKAxLr6LPgFuqglMlzjBVE0m8hZp7YeJo9u31O+NkieC9y7ENhxxw53q/om/kyzEgzmaGOWPEOqbLcex8j1szJNdej1rdMNoeczEp58KdUfneRW7DpkKU7zLR9bYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483341; c=relaxed/simple;
	bh=AuH91+XAC9x3tWG93Os1gH5eAKyi9I/hJTIUNi92asM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rxf3Kgq9p7D4e3odmT7nXBvqM8eUo2fn2Lo5OvL2iR6Mq04wxuJRkRh39qIrxA4h6vPwVU14paQ+YljdJS3trazqCO7AYXM1Ps4VWVbIyeBAln1yeJAyo1ojUlfOfp5M9WG5cm/uLluxLpyGu9qUW/DdNEfdJkdX4bWudgFK9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfcaf5a8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFE4C433F1;
	Tue, 26 Mar 2024 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711483341;
	bh=AuH91+XAC9x3tWG93Os1gH5eAKyi9I/hJTIUNi92asM=;
	h=Date:From:To:Cc:Subject:From;
	b=nfcaf5a8rvquSAYnLlPDcF3wgRuunO69mzgkilV8t7J4sYr6t8YmZeQuYj/mPLJSg
	 wsgYMGKeNLa9WmORtf7r8TlRTa7PtFLJ4jQh2BsiCZzbTTW3DbcGOl++VIJya3DpMN
	 9rFdrP2FvPSUjr4bUF+QSL28XsrR8abZuK/JWCQJ+QSId7fQLT6uP20dm4hNzav5Ql
	 9kUhrxiEbkorZvM6I3sq17lEbxaJmw0SgX1zvE5bGLcj7tCAuP7rK74KGDBuqfbWrp
	 7r4A5bfl7mA+MjFzzUehn4XQ7RddpInO8XbHJrKZyQG0EVogiXMuBNtAU1RLoVEnYr
	 B2vi4LfS1GjWA==
Date: Tue, 26 Mar 2024 14:02:18 -0600
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
Subject: [PATCH][next] Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZgMpynzZ8FltPCi3@neat>
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

Hi!

I wonder if `struct l2cap_ecred_conn_rsp` should also be `__packed`.

Thanks
 - Gustavo

 include/net/bluetooth/l2cap.h | 20 +++++++++------
 net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a4278aa618ab..92a143517d83 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -463,18 +463,22 @@ struct l2cap_le_credits {
 #define L2CAP_ECRED_MAX_CID		5
 
 struct l2cap_ecred_conn_req {
-	__le16 psm;
-	__le16 mtu;
-	__le16 mps;
-	__le16 credits;
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


