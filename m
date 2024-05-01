Return-Path: <linux-kernel+bounces-165125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976AA8B885F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE828513E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F4535B7;
	Wed,  1 May 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="PzPOt61J"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2118.outbound.protection.outlook.com [40.107.8.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C951C30;
	Wed,  1 May 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558154; cv=fail; b=aMgl7D00EkoPAkKqskWcWsrhpMVQvkP+UUvEC/7s/9PosoUOoQdhqeyHdR3VA8/iXi/TxX4SbWecdjY4tO3EY792VJNQJ6V7pdkLwjJOyBzyA1yu8bPy9jPo6bICLQt+yhjrrpkpsgeFo/AUi1fJJcBj9I6Vs8++YsKskkdja0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558154; c=relaxed/simple;
	bh=XRT+abQWXc9fXd2TVohvDGyxNpY72K4TzxX3lirH/c0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oVdAMi0lZYzqfBYTu6RSj0dRYhqVbKi2i0KDii3uO63qY+dn68rzdDdYECIyFvSA7+E+j/ZUqDoXGBygbjTjcepqNJn/xTE+b7zQClcwNThxJT2oyE/UPNkH2T53exfBMpCL98dtyTlAHOri73cKHPfAC75qukTMSOEcbAnjchc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=PzPOt61J; arc=fail smtp.client-ip=40.107.8.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvl69Ddoce/2zOXoHTDauh45vA/Xsq0rVB4WI4hJuicoNwDkQ74A1IC2GVIPWD3xYJIDI21rdCy9FXzZwHJf+UngcqFJn8SCqlA6bVofpiAQcC22FmgDBfLuGKiw1XbOnm97Scf0ZQSitwk963QV8pYtTmEEOvZ3WWReAJCGhjeOoElIgo7ZhWdE0+kibBtKOA4ubZduKmPC9YLsNbkvCxGwAuq2dlJM8MU1XXLupegApud+r0SVPN3EwBu8duuTdThfTCLFEuebcZbVt8qTsajkHT3n8a7jaQrMeOIaKvG2zrsjGGM9jo7n/hxSTn43QWaVdWg4nfgu98a9BW5FHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlgiUgQkSMToAeONFEzCxZKHP2lmRRV8asJLV6GHhsI=;
 b=mlR3Wiy4TXt1IzPPco4dn24G/pDqtluKuYunzURnnLx9KMaxhzcANQNYGPmq4ZKaQpmFn48J0Tb2/rTE8X1e0NEJCvbO6Wn4k4OXW3SCR7cee8JAcJkcGmBkZQwpZiK/wQQ5Sd0LwglpWDAlCG8nwyUvkUaJpx24JXTersfYDnmR5hL2d0H29WYsY9qD7gSD2Ox22NbXpKIuy8U/mwsZpTY4h6sazYfV/Y8YiV+DimlZkQdcRx2Tm6jUFwl0qjlDAzAezCbVKySaL3lmjttEgEPUNtfNwGN/pwH5pSnrAXGpDxzhULuoXO4xk/9G6py8F4O5LYb+2TuPal9oQWbq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlgiUgQkSMToAeONFEzCxZKHP2lmRRV8asJLV6GHhsI=;
 b=PzPOt61JUGrH6SONCztwgLlyJI1osZ5JAnlbF57eR5zUXycsiElVYM4aEQ9BMU5I2QFxvICXGeHPbVXGihY20pCvunSzJz4Es9jxJyscbh7jdrAsmILYqz+Vgxck8nhrG++vAR+krnp6qek7PSZX7vCgK8fIuLP6Avn/S/Js0pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=surban.net;
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by VI1P18901MB0783.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 10:09:07 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 10:09:07 +0000
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
Subject: [PATCH v8] Bluetooth: compute LE flow credits based on recvbuf space
Date: Wed,  1 May 2024 12:08:58 +0200
Message-Id: <20240501100859.175690-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|VI1P18901MB0783:EE_
X-MS-Office365-Filtering-Correlation-Id: f7077d98-d03d-442d-6f85-08dc69c6bcc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWEyeZoQMR34bHW3zV1wBhjBIdpXUg3j/ELFBKxJgYOR9JwAiNTCgfTIJxxZ?=
 =?us-ascii?Q?i+rdpMJEHLQ/0WzZTsUVTlfTh7CRzn6jchvT7mIWkyZAByvJoKWD5LgRCPWx?=
 =?us-ascii?Q?mhPmvDRmVk84aqUOfwdwgtT7iBk5Sj9+2FamhwnaakrUcqTfw/VVEJ+mnkTv?=
 =?us-ascii?Q?MriamaEPYRE51f5zFR3cxBl0pvO/K14ft7V5oqVzw14yZFgJtISx8LeiwfWI?=
 =?us-ascii?Q?Mm/UB4ETUSBaXBJYGh0nk/s8fGHWfXnGddiPwCAZv+bsFFJDXN4OOXG8zjeJ?=
 =?us-ascii?Q?CH0WX/fELvUGnVG/PJdAPgNyAwiYxRdig0UMmzZHcVvEjYiGdnfOQuBAvdqv?=
 =?us-ascii?Q?v+kI41LrW7aKm98kRv0KZxF1YFX9tsI6+LLmdzyA3H+q2Lu03wGc1mpliOSG?=
 =?us-ascii?Q?O3PvnfmxLz19M9VQ7LQMenWbvtDbhl/M299wRJMu4ZXQBGV4hZ0hY51LgiNs?=
 =?us-ascii?Q?zR9OarHEh5jOs3MFAo++f65V+x1PTK7NoVzeMpHPiI+zSCQBy5q4g8cm4/Lc?=
 =?us-ascii?Q?UZyDh8vo7C3LnGUbJj6RTlpSUEDymrxFKJAFvTy7DuwV3xMP4NCOZpEC86BF?=
 =?us-ascii?Q?8y58z7PoPvQBQ5SAT+ugeir3rxToxT61NnJWGhuckcMu321EGH9aT22jKdf0?=
 =?us-ascii?Q?MVs5JjvV/4Y9DPahCeThSmL3KqbyEb8VJq1VwIEGxHFdqadTce9xmEIZOrsu?=
 =?us-ascii?Q?dvN3CN3TOQjXWFYs8FmdwNJVzNLm/wYH2gEenyt3UOPqF+qhTXdSt8z8YKkx?=
 =?us-ascii?Q?ZlvP0OeZUwfOqpOtjE+DSweSraHnGnCTyktF4c1ZIrOGnk0U4fwzKbU/Juxc?=
 =?us-ascii?Q?qtOhpcP8zlKP6P0hjgRGmU9NMuY9jS04NWVCtjzvQB+jg+XCRvDAnlfDtdgf?=
 =?us-ascii?Q?SGme/SJH+CBhDBdFCdukyzC4ynQwS1Nnl7c5/5wBvQGwVOgQd15vr/ZCIPB8?=
 =?us-ascii?Q?8425KJosjl1IQdhe3iNZpJvhW8a/bYc+YuoIaQ/DkR4JlhEQgE9OwlNIi1wF?=
 =?us-ascii?Q?d64IjFzspnrHXfTD6U+oV/k6zWQfkFuySzFoV7e6vHVcEeusS3q8l1RTUDuE?=
 =?us-ascii?Q?c6IO5X5CZGy1l4dXrRcrfnsL8S05LOriEbBoxKbgfhGrDlf7c3JYUEgko/jB?=
 =?us-ascii?Q?KzjiEZddZcZ19ukiQqbGtu2JNXOBMu7oEkJf+L2+iw4rtYVDJTggFCfcEedU?=
 =?us-ascii?Q?5N7u5vStl7qeRrDMRV7TByy67Qp6AvjXm5tgo9Ew4E76wNA7HJuXE7coGOCG?=
 =?us-ascii?Q?gbfiq41x1oueVrHPhBRZcFR6ESDUL/u8j3lwFtmi4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXJht42mo+oR/Be1+gWIWT0UPZzJisq1NSBf6BXO6bT/6ArQ37TSK31vJoV6?=
 =?us-ascii?Q?d8EA0jJjGvNr+Q0z7jrIdfYmjuzYnQOvYqIZGYE1AgFr3fa3puRm3V5bD6Ik?=
 =?us-ascii?Q?rG4HgQ/G67mw3lm14R0A8JvArKhiw/w4H6duJGX1ubDU0rfjN4GosY0fUe9m?=
 =?us-ascii?Q?amV9VhTm+qWHPfpOTQuHdDXEFPrY1vy3Anxz6xlRr8i8dG0gxAMmna+gILew?=
 =?us-ascii?Q?XSYREGrB2YsdBHyRQsylBJrt4LgINGMemcIWx92BYt91FwRk5ux8b6WdEmzZ?=
 =?us-ascii?Q?YZuc5ieeLNj+HeS97U9szFwfDlWq/AnwtgB6K1EH9ZKrkVJD1vbNLpokzv+I?=
 =?us-ascii?Q?wgBeF2m0IQf/ZXFW4eZXgZrY14SKBXqfdKdDNBICs9tHVYG/V1rGXE70P9DD?=
 =?us-ascii?Q?bYMq71vlxECVcWkDJCYfwO8ZdRoJYOHs8PRUPQrB7wkbi7ktNroSAUaLd1Ap?=
 =?us-ascii?Q?TPfs3ZyyrF7a0DNBoCYvGLDw5hjuZQlse3SwasCFLpbZsPnsxhoMr9iy1XS9?=
 =?us-ascii?Q?ct/lExviHL1C63VuqFX+FZ8I31arDDh2HT7TWnmQ6isrBLdeeF7AiN3tNfLg?=
 =?us-ascii?Q?u7pzdQhc+UlhdmH1xikPx4v5TuxvcsMJjNLMw8hTF8dMdmOgk3NLo2TCb/UW?=
 =?us-ascii?Q?PNjMJgtM8/OYgFA4ElSehZcxNLses/Ily4nRe1UUOMD7yMOEIAc1Ok70gGEv?=
 =?us-ascii?Q?FKMVkiU8M5DTCqyWbBl2dsfbcQl4N2e7hIj/uyw2kXoI0J0FwCi5vtST8Yzc?=
 =?us-ascii?Q?SjR6x80Yph5iTAnwYcTYs6X7Yql9IW3/o5oHUu05/f/rADghIaD1xXQQeVB4?=
 =?us-ascii?Q?FhUTEmmSILf4tpdO50LVSi5YN82n4ur/DtsJElHe5mRr6ySp4Ouyvgh/Dj0z?=
 =?us-ascii?Q?QPlYC25c/QfD0wkB6jjFirP2THvxs1MTUYy54IHWWrDn5b8fPyLc2RBEFmAq?=
 =?us-ascii?Q?PhCaHDYUsz8gio+2887FjFBbYZkd34hziK+t3qzIEafDumTr4SwpFyFPTq/E?=
 =?us-ascii?Q?4mv7a6DYjqcDX6i9Q/3bsffUuyPeKIbbZ4Eq8tlu+mjmF5Gl/nvpuE1PlPQt?=
 =?us-ascii?Q?Gr8TsjoQeFOnMC6vpj0uIRl0C7bax0jOc6tNsKFKGxiwhVSpK/FRzIIjc4as?=
 =?us-ascii?Q?6gSWilLesX2/dD3TOzNWHChqjQt8V5M6Rq7MxYJRetUyAkFzUnJ7lrHnS0am?=
 =?us-ascii?Q?VY/bT6ezQ/chgpGR+hBpj4+M7ORSWvUzioNgvctK/tiIG4QgJdcly070N59i?=
 =?us-ascii?Q?oEL2a2tSEnP3PpfLQ/HyQ3WkEWxixq/rQBqHy6sDgkcrSZQobur9Jx5SoscE?=
 =?us-ascii?Q?vMEIW/4SYQkwdpDupMWMouem0/0EhaDnpRqPpRN+7YTgi2JhwOO04NGuHA1+?=
 =?us-ascii?Q?p9cAZbv/oPO5VEHvc/Wz8pNOOf6gEc/m3wj0m0YtIfpMKBtAGnrGR40DOnk+?=
 =?us-ascii?Q?cNHthYGywF/vt96RTs2iAr0lxon2NZ1r73gM5KIflMcsTAXRf43W7ursO/tB?=
 =?us-ascii?Q?MzOfS8Fw88rZfCoMu9Sh0WW8FdlX6wwdsMWH+7QoY30wL9QvdYoGVPEtmM3W?=
 =?us-ascii?Q?6ogA/Y03ClEgbaXGr1GVHzFdtQbN8nEFc9g8q+NA3e5z5k4hxLQUTWX+QrYJ?=
 =?us-ascii?Q?1Vax8EoAaZJhRj1NxoDwvVKuXprobEnXFB7brwer+VH3?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f7077d98-d03d-442d-6f85-08dc69c6bcc1
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 10:09:07.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbhTQQL07aYcE3MrjYJz3HDnHOAelJPTjltCAfGkmL0cWNjoYbU9hZqi864UD5iwjj57cduaAp0F5I17HU/3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0783

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
index 142cc1eaeefa..b818660ae170 100644
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
+	BT_DBG("chan %p has %zd bytes avail for rx", chan, rx_avail);
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


