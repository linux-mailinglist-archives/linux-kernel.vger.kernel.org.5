Return-Path: <linux-kernel+bounces-165088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47A8B8797
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B133A1C2260E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDDE535B5;
	Wed,  1 May 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="ghXJh+jH"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2103.outbound.protection.outlook.com [40.107.7.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0A502BA;
	Wed,  1 May 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555374; cv=fail; b=rqr2GRHa7/xONtW2MB3vWRJiqf6Mhye/U9qi3kO8I4RZ5n4lvz9pZxFI33apK5Qq11gFrKa5GO6gyYfvi0eWcdwTpeB9tXI4Q4EZmAQzgabVQR9KKNwR10LBLmvtDOlLP37j7T+8s7qc/P1iP3CM42AndWTFiFoUdEn+ql1l/nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555374; c=relaxed/simple;
	bh=5G+JkVz4+8MVWFlYWcs0BdLwj13kOotWSNvaOQ09KtY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SkBjHjpYuxmtUJGfca+MUB2DJsfz3PSWqDsN/mWYBCKO6nQCnXWuTdf45d2y92HRE1Gn7hXzHWLQpVl2s7qd/JuvNXu5wutNgalqcZLjPDfp4o/zSmFDhFvrlcqoQpBHx6T3ff1JBpUEsSxcakusdOf/2VO4yiVK9DZT/to1zDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=ghXJh+jH; arc=fail smtp.client-ip=40.107.7.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M49lyCRROm2O9YxLOUrpJUhYE1Cp6BWAoXwdw7p1IdrGz5zIDdxnjFDnqtYEGfzn8+bqEjEDGwOTnSXeTn3iGuL6/9IrNNm18M5tbhO325zoKHWAqdR9XTgaUUb6Fg8Lcf03KQ3CX+Wb+3TJh+0tJniVudb3pi5fknkRlSY0Cm9aS5sI+ZlSLetPGQHEgWPTHQ+tRliXd8LLvHUMj0FDzcl3QWzPV4BoK+jtASiqdgPVY6Jadbx6REl2dNTEv3TqFk9HtDn4hWlRB5ZA7FjGJqek+Np1QPA5DuzDj8jS0kV2fkwB7Alsq6++yIvaz8V5KQ4zg52gA9vYR/oPwqMdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbmfLfPLXykBCsVtPQVYtQfnhl+9BbPC6bNGkRusjlk=;
 b=hQHBgMPzRcWBij00tV5ZKnDKOGQWPQZvdLRc+7aXnlqVdEVSfkRbxeS6AnKYqAYJ4/lqkO0TXMtJmzooEnxcwMXVysDnccK+VfDanukfHu5+dOO9eHCJqzrybCWlCj+GOoy0iLdZN8rcKaay76lE6Ki/bqFOpoV7Sr7uRGIAbQN/WjyDjESTEs29HbLfRHo5QmOtdkbjwPhLuo8IUu2ywJtWKBtZYIEvjx6KpgOeoTKKgGE+i8UD/VF4yHPUEK7YninxH4r+7hJnxNvW6Z5o7kxTY7fy2U0eIeEKxC6ZbIeZ1Ce4gvz3gANfaOJkM5OuBDEbwGVNDyGO1qWMk2vr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbmfLfPLXykBCsVtPQVYtQfnhl+9BbPC6bNGkRusjlk=;
 b=ghXJh+jH808EOWILomhYPpYlD8B4vFkw2doXBtiUcvOsfNqDS1cIOidauQ7kOuWlo9/80oPwpnKvJd1pruhw4vCvB4hcTBpq+pCb7wVbqb+UbcjWGaksmdzJ/roLfV5uGP6Aejuv+f5esmzvOjcFok7307BjEHNcNHL8Ts+bkdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=surban.net;
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by PAXP189MB1925.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 09:22:45 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 09:22:45 +0000
From: Sebastian Urban <surban@surban.net>
To:
Cc: Sebastian Urban <surban@surban.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7] Bluetooth: compute LE flow credits based on recvbuf space
Date: Wed,  1 May 2024 11:20:52 +0200
Message-Id: <20240501092053.72045-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::7) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|PAXP189MB1925:EE_
X-MS-Office365-Filtering-Correlation-Id: 4588a9b2-3f05-4041-26ab-08dc69c042bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ywYvR8TSaoq25UiZPO0PHSKjMuPVw5EtrLWLd+onqJfvNcGvLKxoBblkVD3?=
 =?us-ascii?Q?lMDShV2BYjQuiF5fkq3h3jXv2SaWznTnkisf5tMp0Aus45+WBko2imZVmiaH?=
 =?us-ascii?Q?oEtGMLTxbdusnSvdd1AuyTfaHllY3ShiW5oVWY27uSC4+dchUSRPOI8qsiEs?=
 =?us-ascii?Q?xKHiFKmQSR+LI35/sXPnaxkOF+qaCoU1TwBxF+kunuur7h0W1Zep2VGq2lai?=
 =?us-ascii?Q?dVc7vcovU00WhniY8gQo/EDWnpUROcGPYs3MoVO6jVVOW3Y2SR5Hz5f/Gg3c?=
 =?us-ascii?Q?gbEfveHYIxkN2ZFcmKZwvUcCRVAx8KcDYdZE0QZs8Yd/IB49LvlQzQyVK1SU?=
 =?us-ascii?Q?sdcpag/ORpQc6revrYh1WppMYc7zMaAhwhM1vRhQBLlksZ9IHxEFTjB6Gm5H?=
 =?us-ascii?Q?vUOAPFP7DHdT4N3orNNjGvgQ7i4JvqE/6/F1LNWMD4OubuGW+P6pwkqMGBTa?=
 =?us-ascii?Q?1cOmreldXK6PMcljv/aAZC4Xpf1dbmsXFrZDAcao6jtDJQs3C+XvojNqfKy7?=
 =?us-ascii?Q?5j1eCuZWmM5XK+dfvbkwzP4zV1iWfakfgeJ2gwTdgQCZaEs8cBgELm8lMqTP?=
 =?us-ascii?Q?MjbINYayD+EUpB6ZLiYK0S11UmqpcLLAhIBe8i19ygrsnVTnvjyORz152Itl?=
 =?us-ascii?Q?dc7Szq/8qJjhIC18YscIyyi2XbEImS97Na1d9FUcMhx7fyVjZur+OWvQwTAC?=
 =?us-ascii?Q?u2vtsd7FPjIsQoom9vVIwPF3RcAAnFOpcUHUqzS893sEtyDk25Ic/tLvNSCp?=
 =?us-ascii?Q?HvKDp1djHQaOAAPfapJXmP0VDbxnDdz4FywblN4Ye8s9qsH8ilwVmeYv8DAW?=
 =?us-ascii?Q?NrXPZcrFfon7nQA0GqmAs+P0D+F+g13MDJWNXb+HoFL11iFDnthizu3thmzs?=
 =?us-ascii?Q?JpPa5wikZvwJBVFnoj6CV2g895/XC4AcgkF9SQnjhrU8Yt+uLsTNh/dDyzAt?=
 =?us-ascii?Q?OU/uVXWmES7a0F2qUpyc24FsNAi6zGYmg12QH3x3DUm7n0mqnB5j9M7FpP/z?=
 =?us-ascii?Q?0Azg9Ni5J9hA231SI2W688/R3abmOZ1kx8JZE4wxaiwnOCif/Q4WRYC78y+E?=
 =?us-ascii?Q?6L6kvWxd7Gg4Bm/ZdDFm/Mqk1JU6hcz7JKscQoQBtbxvlx6467SPTganBRDH?=
 =?us-ascii?Q?gowBL2zg5Qcp11m1kvBQUWLleGdJ8spfSSmV3bby5e0t8jtAnrNpKqXqI7O9?=
 =?us-ascii?Q?6rl2OYpxrFrtS3pOhslWAHgx5t+SZPAnzIZXrZklwfA0eMWV2fOUfXRg4HoU?=
 =?us-ascii?Q?3DnL2DoSoS5rYdKpUbfT0c4gyQd7r1ls3uZbvRhZcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9PI5YZIsFacuogplt3vQDQZVU0Cx5EkvBY2ewvSNGsLd/qQzkRpVlDoCR8u?=
 =?us-ascii?Q?SqnnU0OejNn42jhi/DpkW4aDPDb/vGnv69ag5swNhNNg0I29EOxuuCy1YQFO?=
 =?us-ascii?Q?qA7eKn+yqMZOXV4WtZSuyy8MSK18kIiyZogh/2AA2uZW3v2FPlbogYGymFO3?=
 =?us-ascii?Q?uI/ie9gwu3onErnbAaMnITX1kTVdHY0Zp0wKXPNs1OeEe0hW3mM2ZMAwlK44?=
 =?us-ascii?Q?d8l782lpMIWZfIdoDY/PHLQcmnUcZiLnl43tal43d7Ve7OmGC9vk9LTAMemx?=
 =?us-ascii?Q?toa7nen8ZG4vwa4oqOPDK+14AZb0unNt8GCW9xaAOYf/p/MqB1K4/CAr2nyD?=
 =?us-ascii?Q?UmjKN4tDw/50FWL5cKeOShYc9xmr0LIS+aRs1+PtndZ4PmNZZ/cxs+/hTZBI?=
 =?us-ascii?Q?Rfej7UjWe/16Pnr71gurFcE+OR0LoBDqZbXCjoZ+aHWJBPyYohxKovxDAvdI?=
 =?us-ascii?Q?3WfdCmGEKFQr4s/jmGMUpFku0k1RYMfbQSI9adRScX3PaGfIV+2vPABmFCBx?=
 =?us-ascii?Q?oHEM4zRszV13QEWITfIrZp90WVKilC5reA1z+9i9tG+c7Wri7oquGA8qPmIH?=
 =?us-ascii?Q?ktumF+VfhoT8fEdVXlVj1hHJbsfnou5U7L40XmG7Z3KOSp0Rs1gqHjs+SyxQ?=
 =?us-ascii?Q?IFrNx46hpEw2vMt06lT6baTJLCxIFnY65D1sAkfwyzYLGvqfHuC6X6kpe005?=
 =?us-ascii?Q?0QmnmfLKOOuvUJmzhLFyyZbPBQIF7rk1EMHMJ0oaGE6GRtGp2lWJzS2OuZQI?=
 =?us-ascii?Q?JRN3JO+MPOd0ZU+1tQ70QGDv1xrqGNe6wtQQtnxjsexoQR2TQ2OBC20GT3AE?=
 =?us-ascii?Q?0yHI6lp+n/xeCl/7B0tPnmbuRb1nlIPUx20qZEpwvm6LlWhV09KLRbnWDm36?=
 =?us-ascii?Q?iqhpYziGhGf1FkM7Q7XFeyekJoalVZ2h4c1A8M4luwtUCz3jN8v5SyQC2lao?=
 =?us-ascii?Q?vjRpcmLmpoN6HOH/LcqdMrLxFZ+dE6X/mrjzVqVqubq4OSE5BnxyPTFoUaFO?=
 =?us-ascii?Q?sV3HQnZXROuq5KAhsNUjYgx//NKBG2qtDghzE3GRxjEWMyZa4jr1cWaypYf0?=
 =?us-ascii?Q?ATKaPpfow0UyLpWwt0w2y2Ir81MovWZoVvkR7VZgHB4Ifrg9YrEMxfTklCcE?=
 =?us-ascii?Q?ufEfJYfHskgHLWoq3BdZt4+TNKCC0JC4HRhyfXKLuhrIN/4uCozCy7odDUpK?=
 =?us-ascii?Q?WADFDKjCR1zidRobgZtCzuYZQgt36RUwL+H2JeCuN7EObc3NUklWuSYCABwC?=
 =?us-ascii?Q?lh0l3qG7ioFKJolMTHzDLGF76+UtAd37pxC/IO0aotyJsSysnkuutBsMRIeT?=
 =?us-ascii?Q?JY06V6sqjrQqNcsXg2hr6171UkmDmxU3b2ZSUxbFItx7WzRh+S2E+ZY2pLuy?=
 =?us-ascii?Q?bnG/Ty8IqvKbqEv2B11/7m0alx+mtLz0/ML1KEwIpI89QNdyH8djYxDLUDCn?=
 =?us-ascii?Q?k9jR388QBTAQ24E5ufwO9Fjr0Xe6Y+EKWBEiM/SOwE2OEgw5y2XbnHs5R2J7?=
 =?us-ascii?Q?2bQl7eIGOB55Hxytgrj0ygmFXrasFSHmnwUltgLo6GTyOGTQD7w+KwIorSRv?=
 =?us-ascii?Q?5y7Q3KdP4qJUmxrPki2td6EOXtXV/pykFJXiXmpKN33lJxZil62dSiWpA+H0?=
 =?us-ascii?Q?MkZ/lHmBuu3pAJGkJxgp/59P6H+zwn0IOac+IUHTF+UO?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4588a9b2-3f05-4041-26ab-08dc69c042bf
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 09:22:45.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlmD6yNsGuYbzQmlzXUVSt+h5BDDR5hvKX7CQ4zNpH2ziaR6U0PIGGHl/RGpZ4QwiSeZIhVnjAf4+px/My/O2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1925

Previously LE flow credits were returned to the
sender even if the socket's receive buffer was
full. This meant that no back-pressure
was applied to the sender, thus it continued to
send data, resulting in data loss without any
error being reported. Furthermore, the amount
of credits was essentially fixed to a small
amount, leading to reduced performance.

This is fixed by computing the number of returned
LE flow credits based on the estimated available
space in the receive buffer of an L2CAP socket.
Consequently, if the receive buffer is full, no
credits are returned until the buffer is read and
thus cleared by user-space.

Since the computation of available receive buffer
space can only be performed approximately (due to
sk_buff overhead) and the receive buffer size may
be changed by user-space after flow credits have
been sent, superfluous received data is temporary
stored within l2cap_pinfo. This is necessary
because Bluetooth LE provides no retransmission
mechanism once the data has been acked by the
physical layer.

If receive buffer space estimation is not possible
at the moment, we fall back to providing credits
for one full packet as before. This is currently
the case during connection setup, when MPS is not
yet available.

Signed-off-by: Sebastian Urban <surban@surban.net>
---
 include/net/bluetooth/l2cap.h | 11 ++++-
 net/bluetooth/l2cap_core.c    | 56 ++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 91 ++++++++++++++++++++++++++++-------
 3 files changed, 132 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b6eac37f5b74..2dd77de38d1d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -554,6 +554,9 @@ struct l2cap_chan {
 	__u16		tx_credits;
 	__u16		rx_credits;
 
+	/* estimated available receive buffer space or -1 if unknown */
+	ssize_t		rx_avail;
+
 	__u8		tx_state;
 	__u8		rx_state;
 
@@ -688,10 +691,15 @@ struct l2cap_user {
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 
+struct l2cap_rx_busy {
+	struct list_head	list;
+	struct sk_buff		*skb;
+};
+
 struct l2cap_pinfo {
 	struct bt_sock		bt;
 	struct l2cap_chan	*chan;
-	struct sk_buff		*rx_busy_skb;
+	struct list_head	rx_busy;
 };
 
 enum {
@@ -950,6 +958,7 @@ int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		    const struct sockcm_cookie *sockc);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 142cc1eaeefa..9ed68428c679 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -454,6 +454,9 @@ struct l2cap_chan *l2cap_chan_create(void)
 	/* Set default lock nesting level */
 	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
 
+	/* Available receive buffer space is initially unknown */
+	chan->rx_avail = -1;
+
 	write_lock(&chan_list_lock);
 	list_add(&chan->global_l, &chan_list);
 	write_unlock(&chan_list_lock);
@@ -535,6 +538,28 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
 
+static __u16 l2cap_le_rx_credits(struct l2cap_chan *chan)
+{
+	size_t sdu_len = chan->sdu ? chan->sdu->len : 0;
+
+	if (chan->mps == 0)
+		return 0;
+
+	/* If we don't know the available space in the receiver buffer, give
+	 * enough credits for a full packet.
+	 */
+	if (chan->rx_avail == -1)
+		return (chan->imtu / chan->mps) + 1;
+
+	/* If we know how much space is available in the receive buffer, give
+	 * out as many credits as would fill the buffer.
+	 */
+	if (chan->rx_avail <= sdu_len)
+		return 0;
+
+	return DIV_ROUND_UP(chan->rx_avail - sdu_len, chan->mps);
+}
+
 static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 {
 	chan->sdu = NULL;
@@ -543,8 +568,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 	chan->tx_credits = tx_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
-	/* Give enough credits for a full packet */
-	chan->rx_credits = (chan->imtu / chan->mps) + 1;
+	chan->rx_credits = l2cap_le_rx_credits(chan);
 
 	skb_queue_head_init(&chan->tx_q);
 }
@@ -556,7 +580,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan, u16 tx_credits)
 	/* L2CAP implementations shall support a minimum MPS of 64 octets */
 	if (chan->mps < L2CAP_ECRED_MIN_MPS) {
 		chan->mps = L2CAP_ECRED_MIN_MPS;
-		chan->rx_credits = (chan->imtu / chan->mps) + 1;
+		chan->rx_credits = l2cap_le_rx_credits(chan);
 	}
 }
 
@@ -6519,9 +6543,7 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
-	u16 return_credits;
-
-	return_credits = (chan->imtu / chan->mps) + 1;
+	u16 return_credits = l2cap_le_rx_credits(chan);
 
 	if (chan->rx_credits >= return_credits)
 		return;
@@ -6540,6 +6562,19 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
+{
+	if (chan->rx_avail == rx_avail)
+		return;
+
+	BT_DBG("chan %p has %ld bytes avail for rx", chan, rx_avail);
+
+	chan->rx_avail = rx_avail;
+
+	if (chan->state == BT_CONNECTED)
+		l2cap_chan_le_send_credits(chan);
+}
+
 static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
@@ -6549,6 +6584,12 @@ static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 	/* Wait recv to confirm reception before updating the credits */
 	err = chan->ops->recv(chan, skb);
 
+	if (err < 0 && chan->rx_avail != -1) {
+		BT_ERR("Queueing received LE L2CAP data failed");
+		l2cap_send_disconn_req(chan, ECONNRESET);
+		return err;
+	}
+
 	/* Update credits whenever an SDU is received */
 	l2cap_chan_le_send_credits(chan);
 
@@ -6571,7 +6612,8 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	}
 
 	chan->rx_credits--;
-	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
+	BT_DBG("chan %p: rx_credits %u -> %u",
+	       chan, chan->rx_credits + 1, chan->rx_credits);
 
 	/* Update if remote had run out of credits, this should only happens
 	 * if the remote is not using the entire MPS.
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 53a4c0db3be7..03d904d6bfc7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1140,6 +1140,34 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+static void l2cap_publish_rx_avail(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+	ssize_t avail = sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc);
+	int expected_skbs, skb_overhead;
+
+	if (avail <= 0) {
+		l2cap_chan_rx_avail(chan, 0);
+		return;
+	}
+
+	if (!chan->mps) {
+		l2cap_chan_rx_avail(chan, -1);
+		return;
+	}
+
+	/* Correct available memory by estimated sk_buff overhead.
+	 * This is significant due to small transfer sizes. However, accept
+	 * at least one full packet if receive space is non-zero.
+	 */
+	expected_skbs = DIV_ROUND_UP(avail, chan->mps);
+	skb_overhead = expected_skbs * sizeof(struct sk_buff);
+	if (skb_overhead < avail)
+		l2cap_chan_rx_avail(chan, avail - skb_overhead);
+	else
+		l2cap_chan_rx_avail(chan, -1);
+}
+
 static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			      size_t len, int flags)
 {
@@ -1180,28 +1208,33 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	else
 		err = bt_sock_recvmsg(sock, msg, len, flags);
 
-	if (pi->chan->mode != L2CAP_MODE_ERTM)
+	if (pi->chan->mode != L2CAP_MODE_ERTM &&
+	    pi->chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    pi->chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		return err;
 
-	/* Attempt to put pending rx data in the socket buffer */
-
 	lock_sock(sk);
 
-	if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
-		goto done;
+	l2cap_publish_rx_avail(pi->chan);
 
-	if (pi->rx_busy_skb) {
-		if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
-			pi->rx_busy_skb = NULL;
-		else
+	/* Attempt to put pending rx data in the socket buffer */
+	while (!list_empty(&pi->rx_busy)) {
+		struct l2cap_rx_busy *rx_busy =
+			list_first_entry(&pi->rx_busy,
+					 struct l2cap_rx_busy,
+					 list);
+		if (__sock_queue_rcv_skb(sk, rx_busy->skb) < 0)
 			goto done;
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	/* Restore data flow when half of the receive buffer is
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
+	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
+	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 
 done:
@@ -1462,17 +1495,20 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct sock *sk = chan->data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int err;
 
 	lock_sock(sk);
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
+	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
 	}
 
 	if (chan->mode != L2CAP_MODE_ERTM &&
-	    chan->mode != L2CAP_MODE_STREAMING) {
+	    chan->mode != L2CAP_MODE_STREAMING &&
+	    chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL) {
 		/* Even if no filter is attached, we could potentially
 		 * get errors from security modules, etc.
 		 */
@@ -1483,7 +1519,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
-	/* For ERTM, handle one skb that doesn't fit into the recv
+	l2cap_publish_rx_avail(chan);
+
+	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
 	 * have already been acked, so the skb cannot be discarded.
 	 *
@@ -1492,8 +1530,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	 * acked and reassembled until there is buffer space
 	 * available.
 	 */
-	if (err < 0 && chan->mode == L2CAP_MODE_ERTM) {
-		l2cap_pi(sk)->rx_busy_skb = skb;
+	if (err < 0 &&
+	    (chan->mode == L2CAP_MODE_ERTM ||
+	     chan->mode == L2CAP_MODE_LE_FLOWCTL ||
+	     chan->mode == L2CAP_MODE_EXT_FLOWCTL)) {
+		struct l2cap_rx_busy *rx_busy =
+			kmalloc(sizeof(*rx_busy), GFP_KERNEL);
+		if (!rx_busy) {
+			err = -ENOMEM;
+			goto done;
+		}
+		rx_busy->skb = skb;
+		list_add_tail(&rx_busy->list, &pi->rx_busy);
 		l2cap_chan_busy(chan, 1);
 		err = 0;
 	}
@@ -1719,6 +1767,8 @@ static const struct l2cap_ops l2cap_chan_ops = {
 
 static void l2cap_sock_destruct(struct sock *sk)
 {
+	struct l2cap_rx_busy *rx_busy, *next;
+
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
@@ -1726,9 +1776,10 @@ static void l2cap_sock_destruct(struct sock *sk)
 		l2cap_chan_put(l2cap_pi(sk)->chan);
 	}
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
-		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
-		l2cap_pi(sk)->rx_busy_skb = NULL;
+	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
+		kfree_skb(rx_busy->skb);
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	skb_queue_purge(&sk->sk_receive_queue);
@@ -1812,6 +1863,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 
 	chan->data = sk;
 	chan->ops = &l2cap_chan_ops;
+
+	l2cap_publish_rx_avail(chan);
 }
 
 static struct proto l2cap_proto = {
@@ -1833,6 +1886,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
+	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
+
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
-- 
2.34.1


