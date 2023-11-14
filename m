Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA80A7EAC80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjKNJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:08:13 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8468123
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:08:09 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231114090806epoutp02e86636e3582551533ebadf505d08e5d9~XciSm4TH80917909179epoutp02r
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231114090806epoutp02e86636e3582551533ebadf505d08e5d9~XciSm4TH80917909179epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699952886;
        bh=Vp4dd4/NjtzTg6uPkQ0NQC0+Zz9GCW5jd8SMRqJkBew=;
        h=From:To:Cc:Subject:Date:References:From;
        b=p0iK73Bg09LChraEpvQnysniMfkk34PwWCTAhjY6BSOLZHTuhR9LeXS/Ey47O01Yo
         UNtaYHcW5aY3psuge2qcv5eXm8a3SgbLx3qTctGp7wIPzns3n59lju9/CRgh7WXBe1
         RBg3ocrQutbHBJHo6EHMZIu3X7sDXVuIs6cQ7cXo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231114090805epcas1p2cc1703367d5b6380e8335dfb7ffab8d9~XciSNdOlv2649526495epcas1p24;
        Tue, 14 Nov 2023 09:08:05 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SV0nd1PFFz4x9Pv; Tue, 14 Nov
        2023 09:08:05 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.56.08572.5F833556; Tue, 14 Nov 2023 18:08:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231114090804epcas1p35fde5f79e9ad1419b3199e6cdc45bc0b~XciQzpEib2665226652epcas1p3V;
        Tue, 14 Nov 2023 09:08:04 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231114090804epsmtrp14e771ce47042c22e21a099d5c3946e30~XciQzCfsO2768527685epsmtrp1C;
        Tue, 14 Nov 2023 09:08:04 +0000 (GMT)
X-AuditID: b6c32a33-cefff7000000217c-0d-655338f59077
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.F4.18939.4F833556; Tue, 14 Nov 2023 18:08:04 +0900 (KST)
Received: from U20PB1-0469.tn.corp.samsungelectronics.net (unknown
        [10.253.238.38]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231114090803epsmtip16997e4ecf1165d871aa8f532971a0e51~XciQnWWIy1771417714epsmtip19;
        Tue, 14 Nov 2023 09:08:03 +0000 (GMT)
From:   Jong eon Park <jongeon.park@samsung.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongha7.kang@samsung.com, jongeon.park@samsung.com
Subject: [PATCH net-next v2] netlink: introduce netlink poll to resolve fast
 return issue
Date:   Tue, 14 Nov 2023 18:07:48 +0900
Message-Id: <20231114090748.694646-1-jongeon.park@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQPerRXCqwbJZ7BZzzrewWEy/OZXZ
        4umxR+wWD6fHWlzY1sdqcXnXHDaLYwvELL6dfsPowOGxZeVNJo8Fm0o9Nq3qZPN4v+8qm0ff
        llWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2x
        MjQwMDIFKkzIzvjZspGp4Jh8xYSJy5gaGKeLdzFyckgImEisWjmTuYuRi0NIYAejxL6b/5gg
        nE+MElee3GKFc449nsgI07Lx+mEWiMRORolzbVOgqjqYJC5MXs8OUsUmoCdx8dlxdpCEiMA0
        Rokjs1aBtTML5Elc+nWBBcQWFoiWWP/uKBuIzSKgKvHlXBPQJRwcvAJ2Ehf+CkJsk5eYeek7
        2ExeAUGJkzOfsECMkZdo3jqbGaLmGrvEtW4jCNtF4vaHTSwQtrDEq+Nb2CFsKYmX/W1QdrbE
        i2PHWEFWSQgUSFw9ogRh2ku8v2QBYjILaEqs36UPUawosfP3XKjb+STefe2BauSV6GgTgihR
        k3h48i0rhC0jsXrFXTYI20PizJ8WsBuFBGIlJl6+zTyBUX4WkldmIXllFsLiBYzMqxjFUguK
        c9NTkw0LDOFRmpyfu4kRnBy1jHcwXp7/T+8QIxMH4yFGCQ5mJRHePM2AVCHelMTKqtSi/Pii
        0pzU4kOMpsCwncgsJZqcD0zPeSXxhiaWBiZmRiYWxpbGZkrivIoTZqcICaQnlqRmp6YWpBbB
        9DFxcEo1MMlvfPLB/oUO5/zr5umn1F393T/KPcgq4D3XtOJs9//uzYfbHHOCgj7ni674bi6x
        LDiFL3LS8uUaF274//wkKbN+itefS7kra15fmHj3ps3E2XtZ/70Jb3m0ZsPHpJtfZkSeYPii
        PdHvipeTmATXpv6Fc6+vC+GeKfLKQd9TIfa6QU+CjI1d4qrklMN3Xr5tMIy4Knm76Ngub8Mv
        78WVV+749cTPZYJ235YpG14ofmO/qDRd3dsrYgprzdNZ3h90xB+6nz21Oeo/6z/nVHvFJW9P
        ZGduO355c+rmT2xCveWdz5/6ZK9qqVywWu73pfkP/E+UyfMwePTqNFVoabyaK2bQt+y90w8x
        jaPXGphlK7OUWIozEg21mIuKEwHo9XzEFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnO4Xi+BUg+ffmS3mnG9hsZh+cyqz
        xdNjj9gtHk6PtbiwrY/V4vKuOWwWxxaIWXw7/YbRgcNjy8qbTB4LNpV6bFrVyebxft9VNo++
        LasYPT5vkgtgi+KySUnNySxLLdK3S+DK+NmykangmHzFhInLmBoYp4t3MXJySAiYSGy8fpil
        i5GLQ0hgO6NEy7y5LBAJGYnrC/YB2RxAtrDE4cPFEDVtTBJvHp5iB6lhE9CTuPjsOJgtIjCD
        UaLxkCiIzSxQJLH+yUI2EFtYIFLi/9d9jCA2i4CqxJdzTcwgM3kF7CQu/BWEWCUvMfPSd7Ax
        vAKCEidnPmGBGCMv0bx1NvMERr5ZSFKzkKQWMDKtYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/d
        xAgOVK2gHYzL1v/VO8TIxMF4iFGCg1lJhDdPMyBViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9y
        TmeKkEB6YklqdmpqQWoRTJaJg1OqgSnwVceefO9izpLnkVbXCsq/HnP1WcKp+2jup5kfVn06
        tO3U58RLP3aWbIxoCBQ0fi8yb+mLPw+Sjj66GTLVTE/cNUxI5vqE7PY4b55TJ/Tz1/vFr8+o
        fOY29fKX0LVs7QdsKrjDDllf7fI7yXJIr9btF8/lR6oMi1jCApO2O+dbRsdOe3t21Xa3X1Nj
        2+a8UDpz6MEL19TSf40JNmt8DC1XHN3DlS3qf71yq17MjsjPjW/3Jp3hWxiiJn90G6Nxb29u
        05MlVa76dhUvxLmOvT8s1d69ged8MO/EVYpVpvISn018ry2Y0n52z7q1UjU7HeunVgUExyQe
        3WAamH/n4NX9uZdPHbrUEn/f1/71z8NKLMUZiYZazEXFiQCO/pQXwwIAAA==
X-CMS-MailID: 20231114090804epcas1p35fde5f79e9ad1419b3199e6cdc45bc0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231114090804epcas1p35fde5f79e9ad1419b3199e6cdc45bc0b
References: <CGME20231114090804epcas1p35fde5f79e9ad1419b3199e6cdc45bc0b@epcas1p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In very rare cases, there was an issue where a user's 'poll' function
waiting for a uevent would continuously return very quickly, causing
excessive CPU usage due to the following scenario.

When sk_rmem_alloc exceeds sk_rcvbuf, netlink_broadcast_deliver returns an
error and netlink_overrun is called. However, if netlink_overrun was
called in a context just before a another context returns from the 'poll'
and 'recv' is invoked, emptying the rcv queue, sk->sk_err = ENOBUF is
written to the netlink socket belatedly and it enters the
NETLINK_S_CONGESTED state. If the user does not check for POLLERR, they
cannot consume and clean sk_err and repeatedly enter the situation where
they call 'poll' again but return immediately. Moreover, in this
situation, rcv queue is already empty and NETLINK_S_CONGESTED flag
prevents any more incoming packets. This makes it impossible for the user
to call 'recv'.

This "congested" situation is a bit ambiguous. The queue is empty, yet
'congested' remains. This means kernel can no longer deliver uevents
despite the empty queue, and it lead to the persistent 'congested' status.

------------CPU1 (kernel)----------  --------------CPU2 (app)--------------
...
a driver delivers uevent.            poll was waiting for schedule.
a driver delivers uevent.
a driver delivers uevent.
...
1) netlink_broadcast_deliver fails.
(sk_rmem_alloc > sk_rcvbuf)
                                      getting schedule and poll returns,
                                      and the app calls recv.
                                      (rcv queue is empied)
                                      2)

netlink_overrun is called.
(NETLINK_S_CONGESTED flag is set,
ENOBUF is written in sk_err and,
wake up poll.)
                                      finishing its job and call poll.
                                      poll returns POLLERR.

                                      (the app doesn't have POLLERR handler)
                                      it calls poll, but getting POLLERR.
                                      it calls poll, but getting POLLERR.
                                      it calls poll, but getting POLLERR.
                                      ...

To address this issue, I would like to introduce the following netlink
poll.

After calling the datagram_poll, netlink poll checks the
NETLINK_S_CONGESTED status and rcv queue, and this make the user to be
readable once more even if the user has already emptied rcv queue. This
allows the user to be able to consume sk->sk_err value through
netlink_recvmsg, thus the situation described above can be avoided.

Co-developed-by: Dong ha Kang <dongha7.kang@samsung.com>
Signed-off-by: Jong eon Park <jongeon.park@samsung.com>

---
v2:
 - Add more detailed explanation.
---
 net/netlink/af_netlink.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index eb086b06d60d..f08c10220041 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2002,6 +2002,20 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	return err ? : copied;
 }
 
+static __poll_t netlink_poll(struct file *file, struct socket *sock,
+			     poll_table *wait)
+{
+	__poll_t mask = datagram_poll(file, sock, wait);
+	struct sock *sk = sock->sk;
+	struct netlink_sock *nlk = nlk_sk(sk);
+
+	if (test_bit(NETLINK_S_CONGESTED, &nlk->state) &&
+	    skb_queue_empty_lockless(&sk->sk_receive_queue))
+		mask |= EPOLLIN | EPOLLRDNORM;
+
+	return mask;
+}
+
 static void netlink_data_ready(struct sock *sk)
 {
 	BUG();
@@ -2803,7 +2817,7 @@ static const struct proto_ops netlink_ops = {
 	.socketpair =	sock_no_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	netlink_getname,
-	.poll =		datagram_poll,
+	.poll =		netlink_poll,
 	.ioctl =	netlink_ioctl,
 	.listen =	sock_no_listen,
 	.shutdown =	sock_no_shutdown,
-- 
2.25.1

