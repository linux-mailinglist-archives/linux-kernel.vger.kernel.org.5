Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40580C492
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjLKJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjLKJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:29:36 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C998AF5;
        Mon, 11 Dec 2023 01:29:40 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB9TUX902633390, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB9TUX902633390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 11 Dec 2023 17:29:32 +0800
Received: from alexlu (172.29.36.158) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Dec
 2023 17:29:30 +0800
Date:   Mon, 11 Dec 2023 17:29:21 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Max Chou <max.chou@realtek.com>, Karen Hsu <karenhsu@realtek.com>
Subject: [PATCH v2] Bluetooth: Add more enc key size check
Message-ID: <ZXbWcZPq_2zIbqEO@alexlu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [172.29.36.158]
X-ClientProxiedBy: RSEXH36502.realsil.com.cn (172.29.17.3) To
 RSEXMBS01.realsil.com.cn (172.29.17.195)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

When we are slave role and receives l2cap conn req when encryption has
started, we should check the enc key size to avoid KNOB attack or BLUFFS
attack.
From SIG recommendation, implementations are advised to reject
service-level connections on an encrypted baseband link with key
strengths below 7 octets.

The btmon log below shows the case that lacks enc key size check.

> HCI Event: Connect Request (0x04) plen 10
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Class: 0x480104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Capturing (Scanner, Microphone)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Role: Peripheral (0x01)
> HCI Event: Command Status (0x0f) plen 4
      Accept Connection Request (0x01|0x0009) ncmd 2
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11
        Status: Success (0x00)
        Handle: 1
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
...

> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
> HCI Event: Command Complete (0x0e) plen 7
      Read Encryption Key Size (0x05|0x0008) ncmd 2
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Key size: 6
...

// We should check the enc key size
> ACL Data RX: Handle 1 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 25 (0x0019)
        Source CID: 64
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Count: 1
        #35: len 16 (25 Kb/s)
        Latency: 5 msec (2-7 msec ~4 msec)
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
---
Changes in v2:
  - Fix compiling issue reported by sparse

 net/bluetooth/l2cap_core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17ca13e8c044..a9809fbe6b00 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1669,7 +1669,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_chan_check_security(chan, false)) {
-				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+				if (!l2cap_check_enc_key_size(conn->hcon)) {
+					l2cap_state_change(chan, BT_DISCONN);
+					__set_chan_timer(chan,
+							 L2CAP_DISC_TIMEOUT);
+					rsp.result = cpu_to_le16(L2CAP_CR_SEC_BLOCK);
+					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+				} else if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
 					chan->ops->defer(chan);
@@ -4202,7 +4208,15 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan, false)) {
-			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+			/* As slave role, we should check the enc key size when
+			 * l2cap conn req is received.
+			 */
+			if (!l2cap_check_enc_key_size(conn->hcon)) {
+				l2cap_state_change(chan, BT_DISCONN);
+				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
+				result = L2CAP_CR_SEC_BLOCK;
+				status = L2CAP_CS_NO_INFO;
+			} else if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 				l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
-- 
2.39.2

