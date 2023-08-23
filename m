Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229CB78581A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjHWMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjHWMwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:52:46 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1433CD2;
        Wed, 23 Aug 2023 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=wyNeCKg8/s
        oZoxHdvCQHzGHwLshE1piKoTbUovUYGFo=; b=uTRyrk5JFE069PU//T+FQMfIdW
        UmD9030YFOf77bJXIZWapmpbIBPBBuzBVXylhy4StNZLd3eL5VCLSb/LoJI5yzDA
        Lw3K84SbUAkRl5BW8UekmnxMW4FEXI9zE7ZVcjLNvmbWukyYA926DhLcGhFEVWNE
        Iq2ujTq2hJ10skziA=
Received: from localhost.localdomain (unknown [10.193.157.69])
        by coremail-app1 (Coremail) with SMTP id OCz+CgAnbJv_AOZkVlAnAA--.23146S2;
        Wed, 23 Aug 2023 20:52:18 +0800 (CST)
From:   Xin-Yu Liu <by2239112@buaa.edu.cn>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     baijiaju@buaa.edu.cn, sy2239101@buaa.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin-Yu Liu <by2239112@buaa.edu.cn>
Subject: [PATCH] net: bluetooth: fix consistent connection failure caused by the loss of HCI_Connection_Complete event
Date:   Wed, 23 Aug 2023 20:52:14 +0800
Message-Id: <20230823125214.5910-1-by2239112@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: OCz+CgAnbJv_AOZkVlAnAA--.23146S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18uF45ZrW8JFyDXw1DJrb_yoW8Ww18pa
        909ay3urWkJ3Z0gF17Aw1kXFyqkw1kuFWUtrWqv345ta98tr4vyr40yrW7t3y5WrZ5JF18
        ZF40qrsrJF45C3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
        WUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82
        IY6x8ErcxFaVAv8VW7tr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUejgxUUUU
        U
X-CM-SenderInfo: te1sjjazrrjqpexdthxhgxhubq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a connection attempt, if the HCI_Connection_Complete event
is lost and not received by the Host, it will result in
a connection failure.

In that process, the hci_conn, the handle of which is still
HCI_CONN_HANDLE_UNSET, will not be removed from the conn_hash
as it would during a regular disconnection opration.
Consequently, when an ACL connection is initiated for the same device,
the hci_conn is found in hash_conn based on "ba", with its state remaining
BT_CONNECT. Then the Host will send an HCI_Create_Connection_Cancel 
command, which will result in subsequent Bluetooth connections 
for the same device consistently failing.

In order to solve the potential bug, if the hci_conn's state is
BT_CONNECT and handle is HCI_CONN_HANDLE_UNSET, remove this hci_conn
from conn_hash. This adjustment could potentially help ensure that the
specific conn is cleaned up at the appropriate times, then the subsequent
connection for the same device will no longer experience failures.

Signed-off-by: Xin-Yu Liu <by2239112@buaa.edu.cn>
---
 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 76222565e..219c62579 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2886,6 +2886,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		} else if (conn->type == ACL_LINK) {
 			if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
 				break;
+			if (conn->state == HCI_CONN_HANDLE_UNSET) {
+				hci_conn_cleanup(conn);
+				break;
+			}
 			r = hci_send_cmd(conn->hdev,
 					 HCI_OP_CREATE_CONN_CANCEL,
 					 6, &conn->dst);
-- 
2.25.1

