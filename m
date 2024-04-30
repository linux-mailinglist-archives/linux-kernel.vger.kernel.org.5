Return-Path: <linux-kernel+bounces-164817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD6C8B8356
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352441F25F98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B2205E17;
	Tue, 30 Apr 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="IYb1O9wH"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2118.outbound.protection.outlook.com [40.107.20.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39651C2307;
	Tue, 30 Apr 2024 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521108; cv=fail; b=V9ZZ8WDf0oJd0mbdb40/bq9BOYwr1g99G/qVzzyTxEfLsKxzYWdmt1IE7/0QwPQyaBa6OsG7imybJ9DCubfrs78DPogURXqy7b0wYKzS56eXYWTEiRtSsA0UMi4xEyVnFZMLC742JwGiKBw2cUDB0ZWl/99+r9q7s/0OPgVcfzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521108; c=relaxed/simple;
	bh=6Efqn5OoWKXgGODlntpUwOq6/r+prGgmnj0zwQVneTI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kPyEVkxgum91ZGaHXa9udJm+xsSz6GdfJctUaEQOG8yG3/Gb+Z924f6YCYFWbvpvsNoiZKj0igXJ5rADyq2e24z8btAfY7kz187AlySCDxRmae//WUfwF2t3I6kEfcH/ezkdQUK0+ESeVu1vbLsWyuHONxqw8vrOKtKQ4dYuwH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=IYb1O9wH; arc=fail smtp.client-ip=40.107.20.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaFSdvzX2Ezv7GmrdJmxvNU/dmiDk2SjP4xTdedzaWXOjFILcld5w9NCZpweSu2yG4vk6T7tjiM+GlwDz+te34I/WryCafAvJnPy22jOby4CH1eV4kWjb/JkYZZwGXzJPW6OLXDnKC9THxeUZpiVvGXFmrNSK32EKM6IoryaYnddnRajCM42TAu8A2el+wjBxIN7sTDhDWXJxYEtogtznkypbRppnEC3wDBd/OGrNRZAYUzJITQHoW7Pn7gHD9Mc3PJwcCDgVwqiXhJOB2SOTrPlfYhVqIVhWadwER1l/oKpwP3YvG/pMpVZ+PPWGxdsSaqUWbr9KgTEKyXRDUyMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tryQzr4vJ2JI1HLV0HD6UjTJdUcFula2R5PDXt6few=;
 b=UFggp7bSI47/tYxtGb3YEdTUOhoZTEPnql73el4950HMFqe7pP24mCl3biV2rn8t6oUb50CXWtMQsFaDuAkVEl+1s+nlhgVj++3chS/PeYVqRMUJKz7y7KlwA5g9Ezc40+wQOABbrX6WqStd7XPpcucKq3MP0XD/ybwJSuuDST/aMKkpTxvmNZVoZYa1NGKiBOBTDl6RAh/c3FK6czf/UbcPXUy8nqWouxr49ZMTKK4vUeECA1Yio2zHOLe+1N+QIVIQT3shFZ4X9scMQw6VUoiB6nQFPGM7qtEAELwOjnz9NU5I7q/x7sp27RbOFs3g8vGmIf2RLQUI3gqflbwyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tryQzr4vJ2JI1HLV0HD6UjTJdUcFula2R5PDXt6few=;
 b=IYb1O9wH4UzkB9hSZ4m+CYvjGNpbI4x1IRsiCwVmm8H9gU7hMVx86HFid8SIlocUlKdRZ++yCKx6zvSeeb4k4B7aG/vottvB315StfxrWREzyjgzuDnF2iNpfBTEKB65vW0b8wCCErRX2wUS4tSkoCWMzAEsqa40bXf7zbrBK9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=surban.net;
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by GV1P189MB2666.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 23:51:43 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 23:51:43 +0000
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
Subject: [PATCH v6] Bluetooth: compute LE flow credits based on recvbuf space
Date: Wed,  1 May 2024 01:51:22 +0200
Message-Id: <20240430235122.37716-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|GV1P189MB2666:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd0a678-e80d-4f1f-ba3e-08dc69707cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|366007|52116005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqecdf3Bt/kdbP1W3syF1fwUpuczOYS56ShqL6s3w0zLAMXt2d+lbtDvh7DF?=
 =?us-ascii?Q?sY3L4FWVhCR2njtXyy5iSTf6LTWgAhDBbicNurbS49qb+npYZO7DhiV2y6Ia?=
 =?us-ascii?Q?siVYVtbfv/ANLhRlisHyKBeR4Iw06E9sd5JmP1fLFPDDDRMZzY4Cdow0G2gj?=
 =?us-ascii?Q?DXQ6g5Q1l0+DJNif9zxWQByTaffT5ix58YD/EF8MXnWX0Js0+603BY5NithA?=
 =?us-ascii?Q?cGLF5i7AX5lwNzhDcHbgLD75qQFXiAE4mudn85ypGPeLs4es3XY2Pj0D+HTy?=
 =?us-ascii?Q?gqX3T57geMpUJg8szs+NtWdofuZSPz9r4SEG3hHyiHvyNMfK1R40YW3tYzDL?=
 =?us-ascii?Q?p+M8yY4qn8YCPL1M9NRSrHW1p71tz4cTwmme0HE3X7DyEzQXiFOB2YLkz2kR?=
 =?us-ascii?Q?1+MyJIgf10Hvuu2jcDhZDvfZVej/NOrlApmsFlWs78sTUTQWfUTjMi+yJewo?=
 =?us-ascii?Q?adPUN4mOKFw2nfSP+4F8xRBhYStwBz2g+CjLNWKrMNIT07rRB+k96geTsYQ1?=
 =?us-ascii?Q?ULG3QLKVaGrzoGkb5sQCxLslBCmRkQKxZEtGnUTjEGtcNEY/hQ/t1laIR+lV?=
 =?us-ascii?Q?QT0ZsR95DOSRM/CNrBSg9gFjuO2lxsKeRvTMy10Wt/CRBsi155lWmCCZ0V4L?=
 =?us-ascii?Q?Zz24H/BJXs8/CIR+SBCUKcT38qJlEe9xAZCu+tkn2sbRhgZNJajlkUWH7YMH?=
 =?us-ascii?Q?aIZQYlU3s2N1nvthox0ABcFVPyPJuI/Hm3vh9VZbM9JUHuZvOXm84t3aotK1?=
 =?us-ascii?Q?rB3WvqF/tOtxVco4LTw9rWprBwXFm7RuPcUufwpQXjPtBnC6E4kkZFzUHio3?=
 =?us-ascii?Q?+/y7gF9N5Jinaq4HRX/zq7rKGQRyvPjOD/J1Q+ZdcohT5oU8BBKPGHpIUYF9?=
 =?us-ascii?Q?4npP9DEFTcTpwt1SKtuKMbIsnf94Sx02wSbdI6BiQs8zBSgzpB/GI/zXV2Ev?=
 =?us-ascii?Q?atfd02vPu8z8PSi84VOj6TbpxEuU37JXiyW3aZa0LgM0ZjwLMk8ZfVVwrZSv?=
 =?us-ascii?Q?VfbtDN2JQ+9/03ntYsLMOeECfcOFcygrFnfVhOufrYWEikF/MhFR41p87UW8?=
 =?us-ascii?Q?iS0ik9UZq08G1x0EXtTkvj/XMPkhIf/5W9kVg9KGo1ZJ8NK1fUyzlkrLaazl?=
 =?us-ascii?Q?6ZIIeVDygOC6UOcFn4rXjES89t11jJ39JYJgvD/OQvDK1tYk81RUj41QSmZg?=
 =?us-ascii?Q?vjfAf7MW49v5V5XP8DSAHy1PIXW+fnVPM+b02BccgPKgZH1zG6Pgw23AL1sZ?=
 =?us-ascii?Q?/0ThpzwEt/M4Xi37zPj/q4/y1THG+Iu+ZUtQIsb13w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fShtao82Kd1nB5guk6Sfo8lYM2c6bqnY5eiz/PeXYxhUImT3dLszZJd2hYYR?=
 =?us-ascii?Q?QflBYigg8RFCGyy4D1J8cs9B3tmtimAjtfQDKg7jTKa59SggX6Z0HvQevZ8i?=
 =?us-ascii?Q?LLvmltvlyRk95xYiuELa5nQ8Nwg+1/S5hhpNYoRD3Jcua7o8tEnSTQyM3Et8?=
 =?us-ascii?Q?xky17sXLeQk/AZCQmBXpx90TQJK1tETEV0ONjNlEgFkzc7s+xG4fKm5FDfrE?=
 =?us-ascii?Q?65FCRHWvErSvaZCG4mAGQnrPjoYJlnxavLpMoUXkgkQsK51zWehmcM+b2SV8?=
 =?us-ascii?Q?fFxT68djMpT+de5srBlycHOGeWmbXJah2c0VQnRGNYpGYxtf/+W8HKV0I4Db?=
 =?us-ascii?Q?J53gGwAd6laF1R5y68AXAKeCTa6LIBkkwkayg776Z8Z2nzR6Qh2xvERcuxzE?=
 =?us-ascii?Q?6B066CXX2LRTNpcOr4xgk66pthZmnW0BUjCwUeLSCQgTHAcNBTCaJ3mLcAzJ?=
 =?us-ascii?Q?Qb68iLXBt8g6a4rBQb9kFy9BIEDrrJNoGKFmRK4/Ta0h4r1/jS3AsrdYR1E1?=
 =?us-ascii?Q?oVq8rdVpQGnFVH4Us2ah3J2Eq2pXKD3V4PJwq6HIxGmbDkVvTwYDsjFy9o0r?=
 =?us-ascii?Q?/PAmU3uMiPNz4L6VDKt9/N6J6tJzd2ocL0wOrP0WHg/QlKYAhUm1649u0fGr?=
 =?us-ascii?Q?YlEphL/eP2dktiunpN1s/XtFnPpFnzn4Dw9FjbkYtJ8B1j6w3t9IZKTkGDZy?=
 =?us-ascii?Q?TRERYfYSQsdLuTj3rAbGBPJUayvRCn5ROyQRirX6O2j0CFxhHkrQDOODSWTT?=
 =?us-ascii?Q?k2IGJMI0eOrZ5yrFa+bxL2WF8t55aiuQf0iGFSvyksyIvAUqdQ+/rpJswiS+?=
 =?us-ascii?Q?sM9dYihGCxf/9NcTXwOML1TxIWfktFnT8uvlnkCtpcpU0FDjmi5FGYlyxmgD?=
 =?us-ascii?Q?ud7EmCZJO53718aAWRliN2hoVrv8agaTLIFXzxMDccWPny9jtOF7VtePzNoL?=
 =?us-ascii?Q?gJF0iSPTrlD4HNP/DjncL7KNPBf/cb7S4J6E4mAK1cxMnokLnOippU4dp5dY?=
 =?us-ascii?Q?ffyUrqh9dLZnenGTd+QEa2E4u5wse8jxVd6HbBNPHu+mj1EOFwSoJIyLVH6T?=
 =?us-ascii?Q?IbIyQrOujchbCfHEYzP2SddnJGyAHWS1vHSMTatiYzrhlpUMCclvM+GoGPJs?=
 =?us-ascii?Q?E4L2iGNWkOSbO3Li7g7yryfTgasq63RJJHgD0fpnr1XFMq1IMAk83oDRq30H?=
 =?us-ascii?Q?H4m+wGVZYVj1zIKCvoKUrEyzrOAnuAksOrcQNeE/56M5ohrgVmCK81WSfLwj?=
 =?us-ascii?Q?1eLLgTx0GRtlxUDTgrbl3hSB4umvdhV3794UMUGlAu7Fh2hBcfmzQL/U5uum?=
 =?us-ascii?Q?Px4wlJ7ShKOsQNjr+ddJqoQEWX4H3idpNwf6sT9PyJkUKg+LB1KKj43D/plt?=
 =?us-ascii?Q?a50CRKy0NwMUv9MfZh123Y6v4Hy6PEzzuhJei/zjSyO/UvEH1y8GOCCTb40N?=
 =?us-ascii?Q?EYLFxKSdB8g8iQeZudDb62d2KzHeBdMzl8n3zKZLRBcPAUP5+xns58Y6tCk5?=
 =?us-ascii?Q?/1CFn8VGGZ+xObqi+eLcogBsRn9vKAj1Y5mCjPFEYXJizrqoNP8YM5oIz5Ok?=
 =?us-ascii?Q?6rNw6gLYAf/T7ZCXg1pKidFdLQ4105DXbZab2efwaNXqgrwEappW9KSzrYHT?=
 =?us-ascii?Q?9LQqiYQdfzp6teCOZIAKg04kVzpCLOhfjHdOu8cE0ohA?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd0a678-e80d-4f1f-ba3e-08dc69707cfe
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 23:51:43.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUoLSPDkYi55iNfz5r0oLkySFaKuZL4jI6EQHjG1ny/9KgGBiBkCp0wkz2/tF7LZelgO2KdLbTpWOtmw48O9UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2666

Previously LE flow credits were returned to the
sender even if the socket's receive buffer was
full. This meant that no back-pressure
was applied to the sender, thus it continued to
send data, resulting in data loss without any
error being reported. Furthermore, the amount
of credits was essentially fixed to a small amount,
leading to reduced performance.

This is fixed by computing the number of returned
LE flow credits based on the available space in the
receive buffer of an L2CAP socket. Consequently,
if the receive buffer is full, no credits are returned
until the buffer is read and thus cleared by user-space.

Since the computation of available
receive buffer space can only be performed
approximately and the receive buffer size may be
changed by user-space after flow credits have been sent,
superfluous received data is temporary stored within
l2cap_pinfo. This is necessary because Bluetooth LE
provides no retransmission mechanism once the
data has been acked by the physical layer.

Signed-off-by: Sebastian Urban <surban@surban.net>
---
 include/net/bluetooth/l2cap.h | 11 ++++-
 net/bluetooth/l2cap_core.c    | 56 ++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++++++++--------
 3 files changed, 124 insertions(+), 26 deletions(-)

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
index 11a83e32e276..e699b29e80f5 100644
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
index 53a4c0db3be7..a2861bb4a7e1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1140,6 +1140,26 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+static void l2cap_publish_rx_avail(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+	ssize_t avail = max(0, sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc));
+
+	/* Correct available memory by estimated struct sk_buff overhead.
+	 * This is significant due to small transfer sizes. However, accept
+	 * at least one full packet if receive space is non-zero.
+	 */
+	if (avail) {
+		int mps = chan->mps ? chan->mps : L2CAP_LE_MIN_MTU;
+		int expected_skbs = DIV_ROUND_UP(avail, mps);
+		int skb_overhead = expected_skbs * sizeof(struct sk_buff);
+
+		avail = max(avail - skb_overhead, chan->imtu / mps + 1);
+	}
+
+	l2cap_chan_rx_avail(chan, avail);
+}
+
 static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			      size_t len, int flags)
 {
@@ -1180,28 +1200,33 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
@@ -1462,17 +1487,20 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
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
@@ -1483,7 +1511,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
-	/* For ERTM, handle one skb that doesn't fit into the recv
+	l2cap_publish_rx_avail(chan);
+
+	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
 	 * have already been acked, so the skb cannot be discarded.
 	 *
@@ -1492,8 +1522,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
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
@@ -1719,6 +1759,8 @@ static const struct l2cap_ops l2cap_chan_ops = {
 
 static void l2cap_sock_destruct(struct sock *sk)
 {
+	struct l2cap_rx_busy *rx_busy, *next;
+
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
@@ -1726,9 +1768,10 @@ static void l2cap_sock_destruct(struct sock *sk)
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
@@ -1812,6 +1855,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 
 	chan->data = sk;
 	chan->ops = &l2cap_chan_ops;
+
+	l2cap_publish_rx_avail(chan);
 }
 
 static struct proto l2cap_proto = {
@@ -1833,6 +1878,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
+	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
+
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
-- 
2.34.1


