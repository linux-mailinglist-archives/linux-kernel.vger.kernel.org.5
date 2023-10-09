Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD817BEB9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377840AbjJIUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346656AbjJIUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:31:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D95BA;
        Mon,  9 Oct 2023 13:31:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE88C433C8;
        Mon,  9 Oct 2023 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696883503;
        bh=xaK2DMT9p8cdvjJ5eMYdV4mFYDZb/2yZjgUx3PDg2U4=;
        h=From:To:Cc:Subject:Date:From;
        b=box2g981w42aOfic7W3fkG/XekqUpb4n8/3IUFQZ/90A46ASXNrLJonm/21Fh7jon
         YmP6417D/od5m4stjAkk7Ebq/hHf8rcbGDfHRttqYwR8Yo2s1aHAD5JIKZZCh4Aa2y
         3345UqrKQW00s0+Qx8nKvt3SxY9K09IJhyOPCM/djK5wfN/YRsBI2g2ue0A0smfvON
         cCkEZ1whXbkZwxExrFkMqcs2wUcy9XXHp4hSXpMYpZIMjDRNwTYS0luoL7zAUu2ztC
         jaKOrxpIcyp/8MdawfbgkiD/mWFKKVXHqjvLfkDqzF+wbaz5i3sYOVcn9Fb/xWQg36
         XJ384d3P4TIBg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Lee, Chun-Yi" <jlee@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Pauli Virtanen <pav@iki.fi>, Jakub Kicinski <kuba@kernel.org>,
        Claudia Draghicescu <claudia.rosu@nxp.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] Bluetooth: avoid memcmp() out of bounds warning
Date:   Mon,  9 Oct 2023 22:31:31 +0200
Message-Id: <20231009203137.3125516-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

bacmp() is a wrapper around memcpy(), which contain compile-time
checks for buffer overflow. Since the hci_conn_request_evt() also calls
bt_dev_dbg() with an implicit NULL pointer check, the compiler is now
aware of a case where 'hdev' is NULL and treats this as meaning that
zero bytes are available:

In file included from net/bluetooth/hci_event.c:32:
In function 'bacmp',
    inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3276:7:
include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
  364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add another NULL pointer check before the bacmp() to ensure the compiler
understands the code flow enough to not warn about it.  Since the patch
that introduced the warning is marked for stable backports, this one
should also go that way to avoid introducing build regressions.

Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
Cc: Kees Cook <keescook@chromium.org>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rewrite completely
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6f4409b4c3648..9b34c9f8ee02c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3273,7 +3273,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
-	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+	if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
 		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
 			   &ev->bdaddr);
 		hci_reject_conn(hdev, &ev->bdaddr);
-- 
2.39.2

