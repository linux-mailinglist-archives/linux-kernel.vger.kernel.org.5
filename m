Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808267E00C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjKCHXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKCHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:23:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911018E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:22:56 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231103072252epoutp034e9064fd6ada3ec461b8919f2fbb8558~UDARU2LST0543905439epoutp03l
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231103072252epoutp034e9064fd6ada3ec461b8919f2fbb8558~UDARU2LST0543905439epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698996172;
        bh=ZNVUfTg/9BZ7OyZwtTDsZ1BFO44+to3o6/WMTGGwevQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=g1GcMpruSt9D3U1ltqyCmnFER0opYxCoHtOhLJJv2XYdogEbiEq0j1N9mwIO5p5T+
         h+6kdjVELEYgrjkdmrCrJXA90gyK2EZusReI5nAI43QgCzqyWrJYTBOgxJeIbiGczL
         Mn647DCyWo/1+UqFL2SQVAv7NPthObWZJ+nIpyd8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231103072251epcas1p4d1add67878735b68f69334c9415b454d~UDAQ6y4tr1445014450epcas1p4h;
        Fri,  3 Nov 2023 07:22:51 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SMBzH230Fz4x9Q5; Fri,  3 Nov
        2023 07:22:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.A5.09739.5CF94456; Fri,  3 Nov 2023 16:22:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77~UDAKxBb-21725817258epcas1p4L;
        Fri,  3 Nov 2023 07:22:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231103072245epsmtrp111b49ab8961f54b37161752f43882b77~UDAKwSGOv2665926659epsmtrp1M;
        Fri,  3 Nov 2023 07:22:45 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-0f-65449fc5ee71
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.03.08755.4CF94456; Fri,  3 Nov 2023 16:22:44 +0900 (KST)
Received: from U20PB1-0469.tn.corp.samsungelectronics.net (unknown
        [10.253.238.38]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231103072244epsmtip2395650ac5fd52ffd76f820f0942decb0~UDAKg1lEu2477024770epsmtip2N;
        Fri,  3 Nov 2023 07:22:44 +0000 (GMT)
From:   Jong eon Park <jongeon.park@samsung.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jong eon Park <jongeon.park@samsung.com>,
        Dong ha Kang <dongha7.kang@samsung.com>
Subject: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Date:   Fri,  3 Nov 2023 16:22:09 +0900
Message-Id: <20231103072209.1005409-1-jongeon.park@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTT/fofJdUg7Yz4hZzzrewWEy/OZXZ
        4umxR+wWD6fHWlzY1sdqcXnXHDaLYwvELL6dfsPowOGxZeVNJo8Fm0o9Nq3qZPN4v+8qm0ff
        llWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2x
        MjQwMDIFKkzIzrgy5QdzwUzhip5PHWwNjM/4uxg5OSQETCSedfaxdjFycQgJ7GCUuHttIzuE
        84lR4tztFiYI5xujxP83B1hgWq7dmwJVtZdR4mTrSjYIp4NJ4sDKzYwgVWwCehIXnx0HqxIR
        mMYocWTWKkYQh1mgl1Gid8c/sCphAX+JPxOagKo4OFgEVCXmTREHCfMK2EtceHaRDWKdvMTM
        S9/ZIeKCEidnPgE7gxko3rx1NjPITAmBa+wSrX9fMEM0uEjMOz0RqllY4tXxLewQtpTEy/42
        KDtb4sWxY6wgeyUECiSuHlGCMO0l3l+yADGZBTQl1u/ShyhWlNj5ey4jxFY+iXdfe6AaeSU6
        2oQgStQkHp58ywphy0isXnEXar+HxMqJj5hAbCGBWImlp7awTWCUn4Xkl1lIfpmFsHgBI/Mq
        RrHUguLc9NRiwwJjeKQm5+duYgQnSC3zHYzT3n7QO8TIxMF4iFGCg1lJhNfR2yVViDclsbIq
        tSg/vqg0J7X4EKMpMHAnMkuJJucDU3ReSbyhiaWBiZmRiYWxpbGZkjjvrWe9KUIC6Yklqdmp
        qQWpRTB9TBycUg1Mup2mLs1uWb8YU+p+/bV5/nHtTQMWSc/0rfX2Cvvrpkn/zyvdHWEi8/Pv
        0jNlfsU1DwL16uMrpYSUJz91ixfNzd9b3eP6s3JH2UbmNy0vBPnlGzndvdIVTW78DW4V731w
        SUjBgs/J44P6lukuJqXXrohMlvCOu911/2HeMa0NTMEtJxXja/v2ll2eWr7lc0FMWdLx/lX9
        cYuT93Udf39Bg8Xy+iHFhZrXuh4u7k2X6Di23V14wu2Gjgen+RK/NW69PyWyg/31ofn7DK/8
        ln7qumf/tsn3b76ceVPS6MpejeJ157Lz484+fiv43MXPz1iW6/ojGYaXX8TXTnd3697+9t5Z
        pwub1HhiCjRnvf+hxFKckWioxVxUnAgAQnSA/BkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvO7R+S6pBtf8LOacb2GxmH5zKrPF
        02OP2C0eTo+1uLCtj9Xi8q45bBbHFohZfDv9htGBw2PLyptMHgs2lXpsWtXJ5vF+31U2j74t
        qxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mq4MuUHc8FM4YqeTx1sDYzP+LsYOTkkBEwkrt2bwt7F
        yMUhJLCbUeLZ0v1sEAkZiesL9rF0MXIA2cIShw8XQ9S0MUn0P+9nBqlhE9CTuPjsODuILSIw
        g1Gi8ZAoiM0sMJFRYtP1PBBbWMBX4tKtD+wgc1gEVCXmTREHCfMK2EtceHYRapW8xMxL39kh
        4oISJ2c+YYEYIy/RvHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAgOVy3NHYzbV33QO8TIxMF4iFGCg1lJhNfR2yVViDclsbIqtSg/vqg0J7X4EKM0B4uS
        OK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA9NxZTP2eSoZz4Ueiku11J5d+MTPT3inz+7/apyf
        P348mv1z35XykO8ufi9v8s5oWNe/aUFMnZecxSoxcfcLCa7Oe+R7o9I0w3r7Nc4u2ezwd9UE
        9glRq5O/scx24nSeqNgkdjipZ4VYsHrulqiyrxE8KWHnjcI/3Hwc7aUTe7LzSu/lu7M58md6
        mRxLb//OnVbItT86zjnzpPQBraPr267GVH065nj7vPDGMvfFqw6les6+wrZg1p6rWWY8jkv6
        9HZyXqnSn+wck5W355jVn1Tlj/U6RxuPlxWUsrLMnnqsyfS4y76pTP3u3+e/+Xolt5Bxbgnn
        3qN34i4fOXMtu7WKh1OH5f5FLhVrj2ufIpRYijMSDbWYi4oTAfkO2rvGAgAA
X-CMS-MailID: 20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77
References: <CGME20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77@epcas1p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In very rare cases, there was an issue where a user's poll function
waiting for a uevent would continuously return very quickly, causing
excessive CPU usage due to the following scenario.

Once sk_rcvbuf becomes full netlink_broadcast_deliver returns an error and
netlink_overrun is called. However, if netlink_overrun was called in a
context just before a another context returns from the poll and recv is
invoked, emptying the rcvbuf, sk->sk_err = ENOBUF is written to the
netlink socket belatedly and it enters the NETLINK_S_CONGESTED state.
If the user does not check for POLLERR, they cannot consume and clean
sk_err and repeatedly enter the situation where they call poll again but
return immediately.

To address this issue, I would like to introduce the following netlink
poll.

After calling the datagram_poll, netlink poll checks the
NETLINK_S_CONGESTED status and rcv queue, and this make the user to be
readable once more even if the user has already emptied rcv queue. This
allows the user to be able to consume sk->sk_err value through
netlink_recvmsg, thus the situation described above can be avoided

Co-developed-by: Dong ha Kang <dongha7.kang@samsung.com>
Signed-off-by: Jong eon Park <jongeon.park@samsung.com>
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

