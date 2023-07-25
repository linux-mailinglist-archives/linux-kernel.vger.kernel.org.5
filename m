Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA93760603
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGYCtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGYCtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:49:01 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98C91198E;
        Mon, 24 Jul 2023 19:48:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [125.119.240.231])
        by mail-app2 (Coremail) with SMTP id by_KCgDHHRhMN79knIaCCg--.11044S4;
        Tue, 25 Jul 2023 10:45:32 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     lduncan@suse.com, cleech@redhat.com, michael.christie@oracle.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        vikas.chaudhary@qlogic.com, JBottomley@Parallels.com,
        mchan@broadcom.com, benli@broadcom.com, ogerlitz@voltaire.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v2 1/2] scsi: iscsi: Add length check for nlattr payload
Date:   Tue, 25 Jul 2023 10:45:29 +0800
Message-Id: <20230725024529.428311-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDHHRhMN79knIaCCg--.11044S4
X-Coremail-Antispam: 1UD129KBjvJXoW3CFyfXFyxur15WrW7uF1xZrb_yoWDtFW8pF
        y3Was8JrWUtF4xuF1fXr4avrWavFWrW39rtFy8K3s5Gw4qyry5J3W8KwnY9FW3JrWDZ34r
        G3yUK3Z5WF1UK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUCg4hUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current NETLINK_ISCSI netlink parsing loop checks every nlmsg to
make sure the length is bigger than the sizeof(struct iscsi_uevent) and
then calls iscsi_if_recv_msg(...).

  nlh = nlmsg_hdr(skb);
  if (nlh->nlmsg_len < sizeof(*nlh) + sizeof(*ev) ||
    skb->len < nlh->nlmsg_len) {
    break;
  }
  ...
  err = iscsi_if_recv_msg(skb, nlh, &group);

Hence, in iscsi_if_recv_msg, the nlmsg_data can be safely converted to
iscsi_uevent as the length is already checked.

However, in the following parsing, the length of nlattr payload is never
checked before the payload is converted to other data structures in some
consumers. A bad one for example is function iscsi_set_path(...) who
converts the payload to type iscsi_path without any checks.

  params = (struct iscsi_path *)((char *)ev + sizeof(*ev));

A good one for example is function iscsi_if_transport_conn(...) who
checks the pdu_len.

  pdu_len = nlh->nlmsg_len - sizeof(*nlh) - sizeof(*ev);
  if ((ev->u.send_pdu.hdr_size > pdu_len) ..
    err = -EINVAL;

To sum up, some consumers code called in iscsi_if_recv_msg do not check
the length of the data (see below picture)  and directly converts the
data to other structure. This could result in an out-of-bound read and
heap dirty data leakage.

             _________  nlmsg_len(nlh) _______________
            /                                         \
+----------+--------------+---------------------------+
| nlmsghdr | iscsi_uevent |          data              |
+----------+--------------+---------------------------+
                          \                          /
                         iscsi_uevent->u.set_param.len

This commit fixs the disscussed issue by adding the length check before
accessing it. To cleanup the code, an additional parameter named rlen is
added into many consumer functions prototype. The rlen is calculated in
the beginning of the iscsi_if_recv_msg which could also reduces
unnecessary duplicated calculation.

Fixes: ac20c7bf070d ("[SCSI] iscsi_transport: Added Ping support")
Fixes: 43514774ff40 ("[SCSI] iscsi class: Add new NETLINK_ISCSI messages for cnic/bnx2i driver.")
Fixes: 1d9bf13a9cf9 ("[SCSI] iscsi class: add iscsi host set param event")
Fixes: 01cb225dad8d ("[SCSI] iscsi: add target discvery event to transport class")
Fixes: 264faaaa1254 ("[SCSI] iscsi: add transport end point callbacks")
Fixes: fd7255f51a13 ("[SCSI] iscsi: add sysfs attrs for uspace sync up")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1 -> V2: resend with correct CC list

 drivers/scsi/scsi_transport_iscsi.c | 72 +++++++++++++++++------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index e527ece12453..62b24f1c0232 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3014,14 +3014,15 @@ iscsi_if_destroy_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev
 }
 
 static int
-iscsi_if_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+iscsi_if_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev, u32 rlen)
 {
 	char *data = (char*)ev + sizeof(*ev);
 	struct iscsi_cls_conn *conn;
 	struct iscsi_cls_session *session;
 	int err = 0, value = 0, state;
 
-	if (ev->u.set_param.len > PAGE_SIZE)
+	if (ev->u.set_param.len > rlen ||
+	    ev->u.set_param.len > PAGE_SIZE)
 		return -EINVAL;
 
 	session = iscsi_session_lookup(ev->u.set_param.sid);
@@ -3118,7 +3119,7 @@ static int iscsi_if_ep_disconnect(struct iscsi_transport *transport,
 
 static int
 iscsi_if_transport_ep(struct iscsi_transport *transport,
-		      struct iscsi_uevent *ev, int msg_type)
+		      struct iscsi_uevent *ev, int msg_type, u32 rlen)
 {
 	struct iscsi_endpoint *ep;
 	int rc = 0;
@@ -3126,7 +3127,10 @@ iscsi_if_transport_ep(struct iscsi_transport *transport,
 	switch (msg_type) {
 	case ISCSI_UEVENT_TRANSPORT_EP_CONNECT_THROUGH_HOST:
 	case ISCSI_UEVENT_TRANSPORT_EP_CONNECT:
-		rc = iscsi_if_ep_connect(transport, ev, msg_type);
+		if (rlen < sizeof(struct sockaddr))
+			rc = -EINVAL;
+		else
+			rc = iscsi_if_ep_connect(transport, ev, msg_type);
 		break;
 	case ISCSI_UEVENT_TRANSPORT_EP_POLL:
 		if (!transport->ep_poll)
@@ -3150,12 +3154,15 @@ iscsi_if_transport_ep(struct iscsi_transport *transport,
 
 static int
 iscsi_tgt_dscvr(struct iscsi_transport *transport,
-		struct iscsi_uevent *ev)
+		struct iscsi_uevent *ev, u32 rlen)
 {
 	struct Scsi_Host *shost;
 	struct sockaddr *dst_addr;
 	int err;
 
+	if (rlen < sizeof(*dst_addr))
+		return -EINVAL;
+
 	if (!transport->tgt_dscvr)
 		return -EINVAL;
 
@@ -3176,7 +3183,7 @@ iscsi_tgt_dscvr(struct iscsi_transport *transport,
 
 static int
 iscsi_set_host_param(struct iscsi_transport *transport,
-		     struct iscsi_uevent *ev)
+		     struct iscsi_uevent *ev, u32 rlen)
 {
 	char *data = (char*)ev + sizeof(*ev);
 	struct Scsi_Host *shost;
@@ -3185,7 +3192,8 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 	if (!transport->set_host_param)
 		return -ENOSYS;
 
-	if (ev->u.set_host_param.len > PAGE_SIZE)
+	if (ev->u.set_host_param.len > rlen ||
+	    ev->u.set_host_param.len > PAGE_SIZE)
 		return -EINVAL;
 
 	shost = scsi_host_lookup(ev->u.set_host_param.host_no);
@@ -3202,12 +3210,15 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 }
 
 static int
-iscsi_set_path(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+iscsi_set_path(struct iscsi_transport *transport, struct iscsi_uevent *ev, u32 rlen)
 {
 	struct Scsi_Host *shost;
 	struct iscsi_path *params;
 	int err;
 
+	if (rlen < sizeof(*params))
+		return -EINVAL;
+
 	if (!transport->set_path)
 		return -ENOSYS;
 
@@ -3267,12 +3278,15 @@ iscsi_set_iface_params(struct iscsi_transport *transport,
 }
 
 static int
-iscsi_send_ping(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+iscsi_send_ping(struct iscsi_transport *transport, struct iscsi_uevent *ev, u32 rlen)
 {
 	struct Scsi_Host *shost;
 	struct sockaddr *dst_addr;
 	int err;
 
+	if (rlen < sizeof(*dst_addr))
+		return -EINVAL;
+
 	if (!transport->send_ping)
 		return -ENOSYS;
 
@@ -3770,13 +3784,12 @@ iscsi_get_host_stats(struct iscsi_transport *transport, struct nlmsghdr *nlh)
 }
 
 static int iscsi_if_transport_conn(struct iscsi_transport *transport,
-				   struct nlmsghdr *nlh)
+				   struct nlmsghdr *nlh, u32 pdu_len)
 {
 	struct iscsi_uevent *ev = nlmsg_data(nlh);
 	struct iscsi_cls_session *session;
 	struct iscsi_cls_conn *conn = NULL;
 	struct iscsi_endpoint *ep;
-	uint32_t pdu_len;
 	int err = 0;
 
 	switch (nlh->nlmsg_type) {
@@ -3861,8 +3874,6 @@ static int iscsi_if_transport_conn(struct iscsi_transport *transport,
 
 		break;
 	case ISCSI_UEVENT_SEND_PDU:
-		pdu_len = nlh->nlmsg_len - sizeof(*nlh) - sizeof(*ev);
-
 		if ((ev->u.send_pdu.hdr_size > pdu_len) ||
 		    (ev->u.send_pdu.data_size > (pdu_len - ev->u.send_pdu.hdr_size))) {
 			err = -EINVAL;
@@ -3892,6 +3903,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	struct iscsi_internal *priv;
 	struct iscsi_cls_session *session;
 	struct iscsi_endpoint *ep = NULL;
+	u32 rlen;
 
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3911,6 +3923,13 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 
 	portid = NETLINK_CB(skb).portid;
 
+	/*
+	 * Even though the remaining payload may not be regarded as nlattr,
+	 * (like address or something else), calculate the remaining length
+	 * here to ease following length checks.
+	 */
+	rlen = nlmsg_attrlen(nlh, sizeof(*ev));
+
 	switch (nlh->nlmsg_type) {
 	case ISCSI_UEVENT_CREATE_SESSION:
 		err = iscsi_if_create_session(priv, ep, ev,
@@ -3967,7 +3986,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 			err = -EINVAL;
 		break;
 	case ISCSI_UEVENT_SET_PARAM:
-		err = iscsi_if_set_param(transport, ev);
+		err = iscsi_if_set_param(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_CREATE_CONN:
 	case ISCSI_UEVENT_DESTROY_CONN:
@@ -3975,7 +3994,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	case ISCSI_UEVENT_START_CONN:
 	case ISCSI_UEVENT_BIND_CONN:
 	case ISCSI_UEVENT_SEND_PDU:
-		err = iscsi_if_transport_conn(transport, nlh);
+		err = iscsi_if_transport_conn(transport, nlh, rlen);
 		break;
 	case ISCSI_UEVENT_GET_STATS:
 		err = iscsi_if_get_stats(transport, nlh);
@@ -3984,23 +4003,22 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	case ISCSI_UEVENT_TRANSPORT_EP_POLL:
 	case ISCSI_UEVENT_TRANSPORT_EP_DISCONNECT:
 	case ISCSI_UEVENT_TRANSPORT_EP_CONNECT_THROUGH_HOST:
-		err = iscsi_if_transport_ep(transport, ev, nlh->nlmsg_type);
+		err = iscsi_if_transport_ep(transport, ev, nlh->nlmsg_type, rlen);
 		break;
 	case ISCSI_UEVENT_TGT_DSCVR:
-		err = iscsi_tgt_dscvr(transport, ev);
+		err = iscsi_tgt_dscvr(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_SET_HOST_PARAM:
-		err = iscsi_set_host_param(transport, ev);
+		err = iscsi_set_host_param(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_PATH_UPDATE:
-		err = iscsi_set_path(transport, ev);
+		err = iscsi_set_path(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_SET_IFACE_PARAMS:
-		err = iscsi_set_iface_params(transport, ev,
-					     nlmsg_attrlen(nlh, sizeof(*ev)));
+		err = iscsi_set_iface_params(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_PING:
-		err = iscsi_send_ping(transport, ev);
+		err = iscsi_send_ping(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_GET_CHAP:
 		err = iscsi_get_chap(transport, nlh);
@@ -4009,13 +4027,10 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		err = iscsi_delete_chap(transport, ev);
 		break;
 	case ISCSI_UEVENT_SET_FLASHNODE_PARAMS:
-		err = iscsi_set_flashnode_param(transport, ev,
-						nlmsg_attrlen(nlh,
-							      sizeof(*ev)));
+		err = iscsi_set_flashnode_param(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_NEW_FLASHNODE:
-		err = iscsi_new_flashnode(transport, ev,
-					  nlmsg_attrlen(nlh, sizeof(*ev)));
+		err = iscsi_new_flashnode(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_DEL_FLASHNODE:
 		err = iscsi_del_flashnode(transport, ev);
@@ -4030,8 +4045,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		err = iscsi_logout_flashnode_sid(transport, ev);
 		break;
 	case ISCSI_UEVENT_SET_CHAP:
-		err = iscsi_set_chap(transport, ev,
-				     nlmsg_attrlen(nlh, sizeof(*ev)));
+		err = iscsi_set_chap(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_GET_HOST_STATS:
 		err = iscsi_get_host_stats(transport, nlh);
-- 
2.17.1

