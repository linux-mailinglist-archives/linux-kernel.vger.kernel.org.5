Return-Path: <linux-kernel+bounces-160754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5AE8B4260
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49780282D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290E3B28F;
	Fri, 26 Apr 2024 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJDm2U99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04821101;
	Fri, 26 Apr 2024 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171970; cv=none; b=PYdAHyp+nFO/EoupNM9Tr7UWzHovnPLSQwX6ZJNpP/vs6FG686I9j3aPiF/MNPxeINXxvJ9dXPfWCW92nuGgfLWTx2Mb35ybnBLLUDRTSfHaBcYJHQ/MoOLfEFY2/ACSVaJb4yQHJnO8Niat5M5TrsBLbKrodSnLuOq77QgV/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171970; c=relaxed/simple;
	bh=GGKvZY/aR+pMIP6jcgcCcgx8wajd6k+Nq0JvOWeoq/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tZm6yY9+GpEhzq0FSIxTODenVI9Vm4abzKDlXHhmK+EYudKp4fuG8puFvkheiZWY/pJYB1lwHH16nc4M8/kSfvzfMVjf27VTj38gPkLIJlaxq9aGKGEFKEkG1V+n8e5AantGpRQ/2g8PY1g9GmFRLTafBbk8t2VMTVjyt80a3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJDm2U99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE99C113CD;
	Fri, 26 Apr 2024 22:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714171969;
	bh=GGKvZY/aR+pMIP6jcgcCcgx8wajd6k+Nq0JvOWeoq/A=;
	h=Date:From:To:Cc:Subject:From;
	b=YJDm2U9985ITJNTGGqD9z04mvBoKHm7XhoD9TMfQ1axuXVQe2yfyDLjgCLCeCNxAg
	 kifRR3WzkdHd7olWi7Z7cq6Lb9ZKjlx3xWS8Ha7dR4GPNE+4JI+zn2f2wZD58acrLR
	 dhbLXcwTExWFLNLXotRIy9epW87F9wRp/nl6Pe8va7yImlELjmhPne5F0MQgpBp7Dq
	 11q0Zl3l9YVTimdHXFsuCqQDQNkvFDo8AaOHq9jIAP7dTqv0Z6ddWYGbLr7SATCli8
	 apqF5E0ksjadwDcJAPG6xMUCDISuhHIx72Jthda+8dORes6NHpBtAIfGLJNl5KQ9Ft
	 1QBgRtVpK774w==
Date: Fri, 26 Apr 2024 16:52:46 -0600
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
Subject: [PATCH v2][next] Bluetooth: hci_conn, hci_sync: Use __counted_by()
 in multiple structs and avoid -Wfamnae warnings
Message-ID: <ZiwwPmCvU25YzWek@neat>
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

So, use the `DEFINE_FLEX()` helper for multiple on-stack definitions
of a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

Notice that, due to the use of `__counted_by()` in `struct
hci_cp_le_create_cis`, the for loop in function `hci_cs_le_create_cis()`
had to be modified. Once the index `i`, through which `cp->cis[i]` is
accessed, falls in the interval [0, cp->num_cis), `cp->num_cis` cannot
be decremented all the way down to zero while accessing `cp->cis[]`:

net/bluetooth/hci_event.c:4310:
4310    for (i = 0; cp->num_cis; cp->num_cis--, i++) {
                ...
4314            handle = __le16_to_cpu(cp->cis[i].cis_handle);

otherwise, only half (one iteration before `cp->num_cis == i`) or half
plus one (one iteration before `cp->num_cis < i`) of the items in the
array will be accessed before running into an out-of-bounds issue. So,
in order to avoid this, set `cp->num_cis` to zero just after the for
loop.

Also, make use of `aux_num_cis` variable to update `cmd->num_cis` after
a `list_for_each_entry_rcu()` loop.

With these changes, fix the following warnings:
net/bluetooth/hci_sync.c:1239:56: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/bluetooth/hci_sync.c:1415:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/bluetooth/hci_sync.c:1731:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/bluetooth/hci_sync.c:6497:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update `cmd->num_cis` after `list_for_each_entry_rcu()` loop.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZiwqqZCa7PK9bzCX@neat/

 include/net/bluetooth/hci.h |  8 ++--
 net/bluetooth/hci_event.c   |  3 +-
 net/bluetooth/hci_sync.c    | 84 +++++++++++++++----------------------
 3 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe23e862921d..c4c6b8810701 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2026,7 +2026,7 @@ struct hci_cp_le_set_ext_adv_data {
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
@@ -2035,7 +2035,7 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_ADV_ENABLE		0x2039
@@ -2061,7 +2061,7 @@ struct hci_cp_le_set_per_adv_data {
 	__u8  handle;
 	__u8  operation;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_PER_ADV_ENABLE		0x2040
@@ -2162,7 +2162,7 @@ struct hci_cis {
 
 struct hci_cp_le_create_cis {
 	__u8    num_cis;
-	struct hci_cis cis[];
+	struct hci_cis cis[] __counted_by(num_cis);
 } __packed;
 
 #define HCI_OP_LE_REMOVE_CIG			0x2065
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9a38e155537e..9a7ca084302e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4307,7 +4307,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	/* Remove connection if command failed */
-	for (i = 0; cp->num_cis; cp->num_cis--, i++) {
+	for (i = 0; i < cp->num_cis; i++) {
 		struct hci_conn *conn;
 		u16 handle;
 
@@ -4323,6 +4323,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 			hci_conn_del(conn);
 		}
 	}
+	cp->num_cis = 0;
 
 	if (pending)
 		hci_le_create_cis_pending(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9092b4d59545..6e15594d3565 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1235,31 +1235,27 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_ext_scan_rsp_data cp;
-		u8 data[HCI_MAX_EXT_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
 	u8 len;
 	struct adv_info *adv = NULL;
 	int err;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->scan_rsp_changed)
 			return 0;
 	}
 
-	len = eir_create_scan_rsp(hdev, instance, pdu.data);
+	len = eir_create_scan_rsp(hdev, instance, pdu->data);
 
-	pdu.cp.handle = instance;
-	pdu.cp.length = len;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+	pdu->handle = instance;
+	pdu->length = len;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
-				    sizeof(pdu.cp) + len, &pdu.cp,
+				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
 	if (err)
 		return err;
@@ -1267,7 +1263,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->scan_rsp_changed = false;
 	} else {
-		memcpy(hdev->scan_rsp_data, pdu.data, len);
+		memcpy(hdev->scan_rsp_data, pdu->data, len);
 		hdev->scan_rsp_data_len = len;
 	}
 
@@ -1411,14 +1407,10 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 
 static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_per_adv_data cp;
-		u8 data[HCI_MAX_PER_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
+		    HCI_MAX_PER_AD_LENGTH);
 	u8 len;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
 
@@ -1426,14 +1418,14 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 			return 0;
 	}
 
-	len = eir_create_per_adv_data(hdev, instance, pdu.data);
+	len = eir_create_per_adv_data(hdev, instance, pdu->data);
 
-	pdu.cp.length = len;
-	pdu.cp.handle = instance;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->length = len;
+	pdu->handle = instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
-				     sizeof(pdu.cp) + len, &pdu,
+				     struct_size(pdu, data, len), pdu,
 				     HCI_CMD_TIMEOUT);
 }
 
@@ -1727,31 +1719,27 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 
 static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_ext_adv_data cp;
-		u8 data[HCI_MAX_EXT_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
 	u8 len;
 	struct adv_info *adv = NULL;
 	int err;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->adv_data_changed)
 			return 0;
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu.data);
+	len = eir_create_adv_data(hdev, instance, pdu->data);
 
-	pdu.cp.length = len;
-	pdu.cp.handle = instance;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+	pdu->length = len;
+	pdu->handle = instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				    sizeof(pdu.cp) + len, &pdu.cp,
+				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
 	if (err)
 		return err;
@@ -1760,7 +1748,7 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->adv_data_changed = false;
 	} else {
-		memcpy(hdev->adv_data, pdu.data, len);
+		memcpy(hdev->adv_data, pdu->data, len);
 		hdev->adv_data_len = len;
 	}
 
@@ -6496,10 +6484,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 int hci_le_create_cis_sync(struct hci_dev *hdev)
 {
-	struct {
-		struct hci_cp_le_create_cis cp;
-		struct hci_cis cis[0x1f];
-	} cmd;
+	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
+	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;
 
@@ -6526,8 +6512,6 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	 * remains pending.
 	 */
 
-	memset(&cmd, 0, sizeof(cmd));
-
 	hci_dev_lock(hdev);
 
 	rcu_read_lock();
@@ -6564,7 +6548,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		goto done;
 
 	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
+		struct hci_cis *cis = &cmd->cis[aux_num_cis];
 
 		if (hci_conn_check_create_cis(conn) ||
 		    conn->iso_qos.ucast.cig != cig)
@@ -6573,25 +6557,25 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
-		cmd.cp.num_cis++;
+		aux_num_cis++;
 
-		if (cmd.cp.num_cis >= ARRAY_SIZE(cmd.cis))
+		if (aux_num_cis >= 0x1f)
 			break;
 	}
+	cmd->num_cis = aux_num_cis;
 
 done:
 	rcu_read_unlock();
 
 	hci_dev_unlock(hdev);
 
-	if (!cmd.cp.num_cis)
+	if (!aux_num_cis)
 		return 0;
 
 	/* Wait for HCI_LE_CIS_Established */
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
-					sizeof(cmd.cp) + sizeof(cmd.cis[0]) *
-					cmd.cp.num_cis, &cmd,
-					HCI_EVT_LE_CIS_ESTABLISHED,
+					struct_size(cmd, cis, cmd->num_cis),
+					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
 					conn->conn_timeout, NULL);
 }
 
-- 
2.34.1


