Return-Path: <linux-kernel+bounces-128421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B08895A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D63E1F21BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131CB15A4BE;
	Tue,  2 Apr 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UtY9jzjz"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2070.outbound.protection.outlook.com [40.92.64.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAC159910;
	Tue,  2 Apr 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078609; cv=fail; b=tPa5spYCCM65ZsIh80nCLLd5NgrkHLBu4DKEDjvgaVZDmr9evwmwDwAiGuPWIw1OMjoFtv1jOAotdx7jr1Nl+EnpYAghJvyfmXyXdxiWPWVTwn329eK85J7qXmb/7gBeYn+vTMZZLhpzNkTLQcLjwDn5SO9MPqCk4Mgfpsc2ML8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078609; c=relaxed/simple;
	bh=VluldfqZ1kI1aLnwZ4z3hFegEApeqefFuaCZ2Z+A4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d91OP1CCp+P7NPzfNFO7S3YiYc+6Dsp0TYp+YSK5upA3+M5qodKNoHaJEnBmPUYBmdjyisVfX7KkyeEx8ShEaPgIAgEBDHE4v8eqVKDFOPP0p/IEHg8Ystbx1PtIDx0l0ywHE/vfFaXLstCD2xZkvLWRLDeIGT44I0KfFddZ8NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UtY9jzjz; arc=fail smtp.client-ip=40.92.64.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIUh8tkf5vOyNgQk86hZmJG7BWzqBUbltR4DyO29DN+JLxNUDUdzGuKcf5bwIIXuOP4BlmIwWRdJJA2E1DtxkMrqic1OkClDQu0y2zYx3No85LU7QqnxJofXAp2XCOR6fEXkc8AZjpA5vJgPS9Ommfuk2+qwc6gUmkNvPHciJRMqY3rpYKVErqV+aaVeRAZxWLlKqbaYnHw5U/2XyJBrdKyM5ujOPMWzIqvIFe1AOQhdlOAMD7iiXOJsDxgkFveMim2E/Cf0kKnWh0VpaeTMF7SeF4wVwpIAVkSPwZzW031Zkf/merZ1DdJVcfD+vdHJQzk3I5DGuxN3il2YJGYxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOf4JsvbFxqSs+I5Iu6VPtGA5J5AitWiKg6exGKbJBk=;
 b=ncby+dTj97F6hcurMgtOVwMIxaifUw02DvMQBsLAO053zZEdnLqLQUZZlOKKcKezdFB1qssqTsMVB039AbmQ34CqZawBfq+a2Q1is+Qa8avozCgjK32TYKK4GcEjHV7DaWqW4rsa7JmdqotyWb0goUOPw83Kq5Q7CZrVZ4Gq/O6OyAjtQsKB6yQibv+IJSwGvFgtkV+JdZk6pKjJ78P20OE2JhE3rd6rfog2C/1O1ELgxJ5xccZ7c144vzAm3+muAQWOH5ivM5/cSuVX9NurVmlCPGFuaN5pfN/x6EypbT2NSrR8VCqpmBVAEB3I2A32dPnd9Q8fxcpGFykf9HUOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOf4JsvbFxqSs+I5Iu6VPtGA5J5AitWiKg6exGKbJBk=;
 b=UtY9jzjz7BLGsYPJRz7LwMf4HHs0jNi4Qnd2qqSTCEFk/sUGEJrIo9QBzvLzXpgpSeVSDn/u9x9qoyFdiWYiNhYwdoa1OFytbxAyisqak3C7IVj7fGj1z7yPO4THi8Hfpnr4aEU57/K/oxIJ2JO8EQvKQwCe1sja6FCts462w66xJF+x25QOq87/zVVKq7oP6oqjnpJotoiTmF8WjhrAA4kUdPqQu4yNCtUkb9+pbJcYjXfl8IiRaYeVy6Z4DuG9lw3hbINNquQktX6OSBcUGhtAD9nWNhsiK4mjxK87G2XpvgO4t0/AGwcBwDSieuMPTnDjtyV04Qy7aMSW8uwy5A==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAWPR02MB9685.eurprd02.prod.outlook.com (2603:10a6:102:2ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:23:24 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 17:23:24 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Tue,  2 Apr 2024 19:23:01 +0200
Message-ID:
 <AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sphM8RT/ZYwIuTzAeOouErfqArUAz4XW]
X-ClientProxiedBy: MA2P292CA0024.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::6)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240402172301.8191-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAWPR02MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd1ad29-fa6c-4628-66dc-08dc533998e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tKB6n5bD5Z6COCR3cfYxjJXpdHZkogZRRTaV7boPqmwWnx42fiiLfijv3BK8ijij/hu77UyXc1mrOvvfgTAwq1EfkIuno5GHXSzp3vvRZFAJGW7nfg3k7aqzJTbNRk2QFmp9LFKT9xCoRmIsSJhvpCD2PZOVQRi86XEaNhfpd7HNJfJJ3CJ2wHfr7CzEldW8j0AyS98mQ4dIfA3mARWAylpmeRCWwI1GVe7PNnNGsgcEkCUu6HAlU1DJX34W40CXHB0Px/ElUDQoaO5r8/XxWqXuSwyh5TEsRc1FdvNwTA62CGpVCGI98Xyf6LIDeZR7Mje53Gc7zWrofpna3hq2FlIjuxr0t3986SKy1k3LdfYlEo0NaDA7tczh1YmeNcE/Zj+de+Hx2XjpycOhIM3p6E31NnJbe06BDZsQKAk05gHNGtjh/CTRau7sdwGUt/idoGCriR5VwJ0zmUb6WpsnvdnwCSdhygWkgl0KC3nSYkNHOTPiNPu1tuH8VICdriiONpIu2QXJaKv7EhleGk/+td10ece1kammvFHtRE13gipaeLt8gHz8iZ4aHWZf8eo7QpbA46Yu32WvqXVp7c55t8BKQ6YGAr9eZHeWmfjx8oEL3RLyXKseqABxLsNuQloESsO1cMS0mJ8nTepYay3pFJedLZwRJRp/goig3jgftYKq+Zn6rzpYB6X2MQOcZvaVUmxZusWA9W+Dmet6XzL3Cg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISSefjsqABQJ6AWzuI4VFHIhHmObJLxSPFfV4yeSPcBJNCLtnPV4P+d04I/H?=
 =?us-ascii?Q?yb5BDqD+5nJfgl+xCzZem/NJcXedyxeExOANgswgRpH+H0a0ZXDO96Q97VEJ?=
 =?us-ascii?Q?GpzIck+LNK0lQ6ZANqIeT5jBiSJ441i9N9HCt1XV8N+fckhZXLwAXMGZWdDo?=
 =?us-ascii?Q?ooeH+vBBREsom3SKiiX8O1if1oD4fjXhcwl01yY5tye1SEmBzXL1XDKGn+0R?=
 =?us-ascii?Q?pG7iY8Q/ledkhlWEm7eevZy6BpQZY1r4ijh65L/0eizj8Dxrhy546MdmjEex?=
 =?us-ascii?Q?hB8MiwALmN4fSN1SZC5pMnxBjfrcZwaHJue+a2f5d2VM8fUkawGltkKnXzxL?=
 =?us-ascii?Q?IOzgY4H6uJjU7ivvr+XpBrRy+Bj34+puwyRJV7tSrDtxZuL78npMB9AUu2dr?=
 =?us-ascii?Q?uoUv7MC4+2K9GA+J2xMRyX1oD2C2judzbClQtr9MrX5wzcMdCn65wWm0yb5V?=
 =?us-ascii?Q?ptX5EmfWJRHW5QDg4C3cjqLcri7RxwQSweKGD88X/vVHE8qBFNa3VohS2IsT?=
 =?us-ascii?Q?qMPeG6V0J3A8/oQ1BGiJuFL3su6H5NJf3aYsn8342kJ4VmxZMvLnC731a8Rb?=
 =?us-ascii?Q?J0mikboq6Bwf+aAt7zNo3jbBKNoykiOfK7P82JVU05g9CYla9pa8PIq9wXsQ?=
 =?us-ascii?Q?kHsOmLggMhKu9tVBgbMmwwA98Xf8OySgtMtgQjkipkaC4WoBgX9WYpsh/C24?=
 =?us-ascii?Q?W5BAWA0Yn/ILoq5ABfU49MshnrJPF52R0ZePZRMWtTanjaqtpW41QbKEKVux?=
 =?us-ascii?Q?kfziwvea6CwK7kDhq71jVRTLeJLNZh50H1DGXjngNCDe9iqwfb9fO0EN81OK?=
 =?us-ascii?Q?hKZUAkY3YSgAwrmkoCqt0zYvxSDfvVOAUrnYXbBgG8nzAzRUOSQnQ5qoBund?=
 =?us-ascii?Q?Yaci5qZhd3DFjHBAVAsiRnJqyH1g1nA93KWCHizYz1OUXkQ0V1vh2JJ9buQP?=
 =?us-ascii?Q?lc/6PrjeG6WBXdOrASSSYKM7fbe8KdRZSgMxzbKJ9DumMpU5uRe08dLxz/tr?=
 =?us-ascii?Q?lbLizhHiTHk2hBetMIsG3JgVBChTkHOr8uuUhkOhmgSQ443bOrWi6oYpHrma?=
 =?us-ascii?Q?EristBBoJjj6DraOS2vZWlqL5uIL0RtpyRpXIV2Aiy1wZdLqPP/40tXGDcDW?=
 =?us-ascii?Q?x1wR0uJnRVC8POaWcn75T68fAN9rkQWtfkMDt2Di7ulYumYiqXcUSEQFx9vC?=
 =?us-ascii?Q?Ip+xWuywTju3eMArxu14b7x5TQWkeUWohT2vT3hnPjx9PQld0fDKgOHbwEAM?=
 =?us-ascii?Q?ZABAswmpkK/Co4BBZ1Gt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd1ad29-fa6c-4628-66dc-08dc533998e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:23:23.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9685

The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
trailing elements. Specifically, it uses an array of structures of type
"batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
declaring a flexible array [1].

The order in which the structure batadv_tvlv_tt_data and the structure
batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
type error.

Also, avoid the open-coded arithmetic in memory allocator functions [2]
using the "struct_size" macro and use the "flex_array_size" helper to
clarify some calculations, when possible.

Moreover, the new structure member also allow us to avoid the open-coded
arithmetic on pointers in some situations. Take advantage of this.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Hi,

I would like to add the "__counted_by(num_vlan)" tag to the new flex member
but I don't know if this line can affect it.

ntohs(tt_data->num_vlan)

If there is no problem I can send a v2 with the "__counted_by" tag.

The Coccinelle script used to detect this code pattern is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1) + sizeof(t2) * i1;
..
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Regards,
Erick
---
 include/uapi/linux/batadv_packet.h | 28 +++++++++---------
 net/batman-adv/translation-table.c | 47 ++++++++++++------------------
 2 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 6e25753015df..49cd345b84a7 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -592,19 +592,6 @@ struct batadv_tvlv_gateway_data {
 	__be32 bandwidth_up;
 };
 
-/**
- * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
- * @flags: translation table flags (see batadv_tt_data_flags)
- * @ttvn: translation table version number
- * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
- *  one batadv_tvlv_tt_vlan_data object per announced vlan
- */
-struct batadv_tvlv_tt_data {
-	__u8   flags;
-	__u8   ttvn;
-	__be16 num_vlan;
-};
-
 /**
  * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated through
  *  the tt tvlv container
@@ -618,6 +605,21 @@ struct batadv_tvlv_tt_vlan_data {
 	__u16  reserved;
 };
 
+/**
+ * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
+ * @flags: translation table flags (see batadv_tt_data_flags)
+ * @ttvn: translation table version number
+ * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
+ *  one batadv_tvlv_tt_vlan_data object per announced vlan
+ * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
+ */
+struct batadv_tvlv_tt_data {
+	__u8   flags;
+	__u8   ttvn;
+	__be16 num_vlan;
+	struct batadv_tvlv_tt_vlan_data vlan_data[];
+};
+
 /**
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b95c36765d04..96d22d8209f4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -856,8 +856,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -876,7 +875,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
@@ -936,8 +935,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		total_entries += vlan_entries;
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -956,7 +954,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->ttvn = atomic_read(&bat_priv->tt.vn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -2916,7 +2914,6 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_tt_req_node *tt_req_node = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan_req;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
 	int i, size;
@@ -2932,7 +2929,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!tt_req_node)
 		goto out;
 
-	size = sizeof(*tvlv_tt_data) + sizeof(*tt_vlan_req) * num_vlan;
+	size = struct_size(tvlv_tt_data, vlan_data, num_vlan);
 	tvlv_tt_data = kzalloc(size, GFP_ATOMIC);
 	if (!tvlv_tt_data)
 		goto out;
@@ -2944,12 +2941,10 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	/* send all the CRCs within the request. This is needed by intermediate
 	 * nodes to ensure they have the correct table before replying
 	 */
-	tt_vlan_req = (struct batadv_tvlv_tt_vlan_data *)(tvlv_tt_data + 1);
 	for (i = 0; i < num_vlan; i++) {
-		tt_vlan_req->vid = tt_vlan->vid;
-		tt_vlan_req->crc = tt_vlan->crc;
+		tvlv_tt_data->vlan_data[i].vid = tt_vlan->vid;
+		tvlv_tt_data->vlan_data[i].crc = tt_vlan->crc;
 
-		tt_vlan_req++;
 		tt_vlan++;
 	}
 
@@ -3001,7 +2996,6 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool ret = false, full_table;
 	u8 orig_ttvn, req_ttvn;
 	u16 tvlv_len;
@@ -3024,10 +3018,9 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
 	/* this node doesn't have the requested data */
 	if (orig_ttvn != req_ttvn ||
-	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_vlan,
+	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_data->vlan_data,
 					ntohs(tt_data->num_vlan)))
 		goto out;
 
@@ -3370,7 +3363,6 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	u8 *tvlv_ptr = (u8 *)tt_data;
-	u16 change_offset;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
@@ -3383,10 +3375,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&orig_node->tt_lock);
 
-	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
-	change_offset *= ntohs(tt_data->num_vlan);
-	change_offset += sizeof(*tt_data);
-	tvlv_ptr += change_offset;
+	tvlv_ptr += struct_size(tt_data, vlan_data, ntohs(tt_data->num_vlan));
 
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 	if (tt_data->flags & BATADV_TT_FULL_TABLE) {
@@ -3985,10 +3974,10 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags, void *tvlv_value,
 					  u16 tvlv_value_len)
 {
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
+	size_t flex_size;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -3998,17 +3987,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
+	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < flex_size)
 		return;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
-	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+	tt_change = (struct batadv_tvlv_tt_change *)(tt_data->vlan_data +
+						     num_vlan);
+	tvlv_value_len -= flex_size;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-	batadv_tt_update_orig(bat_priv, orig, tt_vlan, num_vlan, tt_change,
-			      num_entries, tt_data->ttvn);
+	batadv_tt_update_orig(bat_priv, orig, tt_data->vlan_data, num_vlan,
+			      tt_change, num_entries, tt_data->ttvn);
 }
 
 /**
@@ -4039,8 +4029,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	tt_data = tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
-	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
-	tt_vlan_len *= ntohs(tt_data->num_vlan);
+	tt_vlan_len = flex_array_size(tt_data, vlan_data, tt_data->num_vlan);
 
 	if (tvlv_value_len < tt_vlan_len)
 		return NET_RX_SUCCESS;
-- 
2.25.1


