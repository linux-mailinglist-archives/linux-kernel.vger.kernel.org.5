Return-Path: <linux-kernel+bounces-166711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707AE8B9E70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B6B1F2118D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022F15E214;
	Thu,  2 May 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs22RGi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9C15CD40;
	Thu,  2 May 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666924; cv=none; b=KK2ioM2+c1r+2mB7PT7ZwmsSY1NsS0jmcCv7zHLkyBEtKL4e6nGEszrtgv4qvy3ObMaR8RkVMhsn/6YehGt7+TJPQM8jfirWOB9XVFsyyT0cqsX39KUiHc/blzAaCynCVIfCEdM+aYjV94tz7naDaY0+wPQNQR0RHhjwf07vP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666924; c=relaxed/simple;
	bh=NgUrHm1d3fP/DVSv0zS8qOV1V2Le1HkNbk1ehfQZG5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dp2lb8BKEU3iK8RD1kNOb+lesR9QQ5kJ1EA/hxHJdaK0/8NlrOLETHhhDY9l84zO1YtClPBUvOomUAR1lpmXY1sqI/q98XAi9o2up/uh6xPQBcOwShMb9vfTDwDbfVLo4thOgLvLvE+MhaInWxK8MPfvW1OpvRGqL42NvLhaEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs22RGi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5653C113CC;
	Thu,  2 May 2024 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666923;
	bh=NgUrHm1d3fP/DVSv0zS8qOV1V2Le1HkNbk1ehfQZG5E=;
	h=Date:From:To:Cc:Subject:From;
	b=qs22RGi0tyXio6JUFU/Fq5arumfgrakbBtuloUhN/zXCeheNENo+BsdO9RgFcbvfg
	 oGUHfWUsOCyS2Y8QvsfqjGnrDGwCswbsvdduuh2Tm5uBQthamRMns+QKVDL/lP5E4k
	 VUm3HIDrWtTGiuCtjLK+2+NOAGFRVb5LWHPK4S0Ip9c4VXh/OKdejiFf5cnZIyC3Ml
	 zqg2KA+qvdE0c9N1XxQU7OboG/esMIXykICwsRThnUn86E7aAkcyP7drXWtIIw1Oo0
	 ROc389MEv+bRR0VrehhwVMCwmBeLWJxoAAaGn05+L4+ikRV0U/0S7I4bDc95oqPFGI
	 APicbGx/EjgSQ==
Date: Thu, 2 May 2024 10:22:00 -0600
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
Subject: [PATCH][next] Bluetooth: hci_conn: Use __counted_by() and avoid
 -Wfamnae warning
Message-ID: <ZjO9qCx10KUJbK6w@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time
via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
(for strcpy/memcpy-family functions).

Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
getting ready to enable it globally.

So, use the `DEFINE_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

With these changes, fix the following warning:
net/bluetooth/hci_conn.c:669:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_conn.c    | 38 ++++++++++++++++---------------------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c4c6b8810701..e6838321f4d9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2144,7 +2144,7 @@ struct hci_cp_le_set_cig_params {
 	__le16  c_latency;
 	__le16  p_latency;
 	__u8    num_cis;
-	struct hci_cis_params cis[];
+	struct hci_cis_params cis[] __counted_by(num_cis);
 } __packed;
 
 struct hci_rp_le_set_cig_params {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c508609be105..6e60e8287956 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -665,11 +665,6 @@ static void le_conn_timeout(struct work_struct *work)
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 }
 
-struct iso_cig_params {
-	struct hci_cp_le_set_cig_params cp;
-	struct hci_cis_params cis[0x1f];
-};
-
 struct iso_list_data {
 	union {
 		u8  cig;
@@ -1725,34 +1720,33 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 
 static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 {
+	DEFINE_FLEX(struct hci_cp_le_set_cig_params, pdu, cis, num_cis, 0x1f);
 	u8 cig_id = PTR_UINT(data);
 	struct hci_conn *conn;
 	struct bt_iso_qos *qos;
-	struct iso_cig_params pdu;
+	u8 aux_num_cis = 0;
 	u8 cis_id;
 
 	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
 	if (!conn)
 		return 0;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	qos = &conn->iso_qos;
-	pdu.cp.cig_id = cig_id;
-	hci_cpu_to_le24(qos->ucast.out.interval, pdu.cp.c_interval);
-	hci_cpu_to_le24(qos->ucast.in.interval, pdu.cp.p_interval);
-	pdu.cp.sca = qos->ucast.sca;
-	pdu.cp.packing = qos->ucast.packing;
-	pdu.cp.framing = qos->ucast.framing;
-	pdu.cp.c_latency = cpu_to_le16(qos->ucast.out.latency);
-	pdu.cp.p_latency = cpu_to_le16(qos->ucast.in.latency);
+	pdu->cig_id = cig_id;
+	hci_cpu_to_le24(qos->ucast.out.interval, pdu->c_interval);
+	hci_cpu_to_le24(qos->ucast.in.interval, pdu->p_interval);
+	pdu->sca = qos->ucast.sca;
+	pdu->packing = qos->ucast.packing;
+	pdu->framing = qos->ucast.framing;
+	pdu->c_latency = cpu_to_le16(qos->ucast.out.latency);
+	pdu->p_latency = cpu_to_le16(qos->ucast.in.latency);
 
 	/* Reprogram all CIS(s) with the same CIG, valid range are:
 	 * num_cis: 0x00 to 0x1F
 	 * cis_id: 0x00 to 0xEF
 	 */
 	for (cis_id = 0x00; cis_id < 0xf0 &&
-	     pdu.cp.num_cis < ARRAY_SIZE(pdu.cis); cis_id++) {
+	     aux_num_cis < pdu->num_cis; cis_id++) {
 		struct hci_cis_params *cis;
 
 		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, cig_id, cis_id);
@@ -1761,7 +1755,7 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 
 		qos = &conn->iso_qos;
 
-		cis = &pdu.cis[pdu.cp.num_cis++];
+		cis = &pdu->cis[aux_num_cis++];
 		cis->cis_id = cis_id;
 		cis->c_sdu  = cpu_to_le16(conn->iso_qos.ucast.out.sdu);
 		cis->p_sdu  = cpu_to_le16(conn->iso_qos.ucast.in.sdu);
@@ -1772,14 +1766,14 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
 	}
+	pdu->num_cis = aux_num_cis;
 
-	if (!pdu.cp.num_cis)
+	if (!pdu->num_cis)
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS,
-				     sizeof(pdu.cp) +
-				     pdu.cp.num_cis * sizeof(pdu.cis[0]), &pdu,
-				     HCI_CMD_TIMEOUT);
+				     struct_size(pdu, cis, pdu->num_cis),
+				     pdu, HCI_CMD_TIMEOUT);
 }
 
 static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
-- 
2.34.1


