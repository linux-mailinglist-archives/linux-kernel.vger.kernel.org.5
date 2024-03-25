Return-Path: <linux-kernel+bounces-116877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3988AFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02949C04AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F3524D8;
	Mon, 25 Mar 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="EffP/mtH"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FF1B7CE3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364670; cv=fail; b=UGIed1V2EP+gV49Nu6vi/XKUJmfwkLgKbsCk39IBUFy0Lhi5n9+T+xf/3hB3OXSlB0SjIzBX13i+s7zpFwCRhf2plx8Nr1u7aS/Z86j13RrC0PqxzNtyuNKox1GquynWAAm08+P4Wo34bxwBIOpDFwUfUpbB/aotpUTarbE32eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364670; c=relaxed/simple;
	bh=uwLAFG3YtlQs8DzdJy7AVwMYReJK/uIC2RWLXRef93s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b161mtCcf+PTuj+kp9G508eSN2gXZiOIiWTch+vg4n9Oa54RQgZwy8NrOaR96ghuC9WnSH2SNanHwXnnSsoGFNhzs3YzOW7AjRABSyS89m3nSiqH+78XJ3oeBlLjV3uRmGYj3u01pPJxTeVpa3SqAICFbnD7f4RfbsPoW6kgyCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=EffP/mtH; arc=fail smtp.client-ip=40.107.215.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0kmf30+V63d5FfsRFQVpYLo3Rz9NlvX/ukO7M+VbPKFAiJww9oFfRFWGROj4unQJ9Xyx/T+XKm82kpT1fix0KYou4SbsdVQZtzB/4V/RD3rIjHGVB9tmjJeQPWVv7Tx61eQYTcTOoMOjHR5jkmm6fvjZbTzR2ylJ1wOFZWzUqcu1+zryTMYB/d6fbp5eOc0k88fOWxdgEt/QoQj1hTiHrNbz7I3/6kyd6gawFM6Iyvg2I6451p3vPgNn/O1tcXlVSxkinK+9Sto5eMNVZgdxWoAWqjKEvFoFRlOG6PoN15OKkB9Vuqxq46ExRuaWbTKYha9QXxND9QlMoZKh9rOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG7VTbd0cEGa9QCWFI9+pgRa/zqNboFBoSDZAj5VLGQ=;
 b=U3W7BmqDyr4rdrgsr3F26AtCkxTFONf7LkjRfnGfeS/PsejU9oD1OzPsYURC88MIB1Moqs/prND6Evk0BMBFDi6H55FlQYWWJ42CkjmwJgzGpeOaHx4J3xPVPK//5w7Vk65k/979wvkmdx8oB2FX5P2LrGV6F+o6akZOTBJBsk0QH88DqrwXBWLdkeXA9sD+Lx3yqXcqI6KwA+Q8PWqf6eLqFGQrJ4+wChTBgXqjNqjcCfk/DUW9z4q4Qz2mivgp/brxzgUotgXrcaFn4IaFa47n+EqnR++i6ChJ54YQa5GTaekxhQAJaLO+Kuhxhcw0wwVihlWM72zprkzyLHZtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG7VTbd0cEGa9QCWFI9+pgRa/zqNboFBoSDZAj5VLGQ=;
 b=EffP/mtHpFcH2BwzwW4bKHhuCmSoymNHvrohRAyPzAGNiRDZ/19zhUq0k4hub0WOAfWFnOZCZ6rnu2uMg28eAahVVqvym/VwLWrQoSim0fCw3pIer481JN1xx4LErVD+HtYw9Wg10AMoatSNURbzMcX6J4NYdMnYRcYOu9ssaUTiozoyr4iGDmHJI+ZQ9j0lSygLOhRnQJSuQxgjUvXetcnktPgDD4a6ygLBvh3HJKXu2lvqTk6iPZAnkxYyj3OpUl7g0Aq2ozOdTGHt9OeTkfhaO8HOuNbzGbN96Xz0ugD5G/b6iFsk7pwjDwVgbBnJdgdYyzoI+YysCHQZYyCe1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TYSPR06MB7307.apcprd06.prod.outlook.com (2603:1096:405:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 25 Mar
 2024 11:04:24 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 11:04:24 +0000
From: "gavin.liu" <gavin.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	yuxue.liu@jaguarmicro.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vp_vdpa: Fix return value check vp_vdpa_request_irq
Date: Mon, 25 Mar 2024 19:03:33 +0800
Message-Id: <20240325110333.249-1-gavin.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14)
 To SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|TYSPR06MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 37605ed6-fb5f-425c-2203-08dc4cbb549b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2U0zMlo097Z+HtCq+qdRnDi4EIp9P9vlu8sL0MH1pzfyCKncFdLvXkoV3TufvVp3wkTGffiiALwhyv38UCR1J+PH0AmMqWungm4RWW2zIEKvU+jLsqBibnNQSZhhaK6/mQjJGwg+jHDvSVPjM4oFJ/UEf45W71FmdZk7h30I/ABmja6qyK9iySKHeLMIMj0Cs5TR09GULUS+4Xam0yrHXMJIjp+guN5cl2puGto7+lqAs9qqWW3onNGxBZehwx2N9fOp0OqdOYR8438KWoahX9w7DyGHbBdy/+HtsREtWzJyBTXv0ravMXOXQhdZUyT9vFhDgIU6fjIXDxz4RbDtoVd+VcN+VcV7GXahMa86c7zTOMy8Y1B3NkoapCi4fQtFIXJi5DxYBJTaJ35ZCVTego1ngdt2EVMEm2xzjTzlx8mhLuR2hO1SJE2dJPG7bWCyv4g1/q6IegHy4pNdMB4iV6A5DkPACKbf++XJCO1OA4RpbJqUoEpEqe/8/XfdBeU2I/FCRa5a3+3YFeer97aBzBiwXW+T2JyvlfghY/QvfSdW1ZhOUBUXJemJsrjKGnpDssQknxm2KO05a306v1KOwsbGlAkHdWRDU5curaMRsMjPdAPh5xj/yI3Mya1cOib+gbpKGdVhOI+4HN7QaGRiz6FszxQNbWVaolnTJB1ET+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iteP994K5hqGgV9JMbf/kvvwHbcaAFN3smncOuwv/VNKxrCM8BMPeK+NWlpy?=
 =?us-ascii?Q?p/QtZ85FSoIRhlYJ0Fc4yrLfYw7tleaGWnXj35Q2WE8WtkOMEvfOzxkMS72V?=
 =?us-ascii?Q?yLB4JKk5P8Qq+CZsjmlpZa6CB/eODTs6vvzMzCXPaKuu8RhIqkSpKBJ8AOAk?=
 =?us-ascii?Q?Ap0qJt8hXUt9ARedNoBVpFkEriqVASBl4idbCYwrMQwpSdoJ+Y+elTS309vr?=
 =?us-ascii?Q?SEEeKFVFnpbFv+Oq8rnK1opZ2TwIs4Fx52cyqNZPmNV4cd9d0vAX/NZ+XV3M?=
 =?us-ascii?Q?99Z1gqguei8uh3Qq+56uqM69Z3lmXEgPigdD/yRgbkZKrN5CgXLcuodLbqlB?=
 =?us-ascii?Q?8tcU2iAFU4JxuC4PSfMuv1Zc3CBF3TVIugF4wDGZBIMtGD6XkXVWx5wkEbLB?=
 =?us-ascii?Q?4Crzrh3yCQoxmjg2bFQrjYXvrLqVoHM9EuWUbGeeLNXDy00/MWoAlqdQyASI?=
 =?us-ascii?Q?y0GrV7zjl0tWROGM71YkGj63IxpWap+dhViuBT11smP9GgEt796Go60sFdmQ?=
 =?us-ascii?Q?mG2yge68sCTpShuk5yUm643RqDqr07crskQsu24P3wiNbRI+ZFpY5mnh/rQd?=
 =?us-ascii?Q?7EwhWMqFiZUekY33poKsOiBYFC67BmGknzsOODwuwMKH0p3aNM8jfBGJFW9y?=
 =?us-ascii?Q?iripHI2N6RtJM0EsQq87e9UFpAoTU+l4Rtx/AKaEEXnqFN6PHyOwQeOV/5il?=
 =?us-ascii?Q?DRcj2Ls+/mOwA5korYmPNnY09BL22vehvez/b88V8CjG4kFhWgiQMG89R6LG?=
 =?us-ascii?Q?K7sHK2aDTcKXzMTlVvaLALwDEXN9MhsOhDWvnapceOOZkAEw7h3DogoFUAG2?=
 =?us-ascii?Q?NVofCkAvtPwUJLxCUfIgUFy0BtACu/EfOGVqq/ttNKo7TpFBCapneHcEWfdo?=
 =?us-ascii?Q?L1VsPZ4L/onXqKhjJJCM/DCHAnDFEJkYMhUEBZIxM9D/R1dj7BrAMDoaCp+c?=
 =?us-ascii?Q?q5DihAODJ5VutwekcvL3RuJV0x7jCO4raBaDx10l74AEHfLLUoA9jrEFKk6w?=
 =?us-ascii?Q?3DJTob8ab6Wux3SBSODq33tSiNSj8vBGHQt/fvi3wun4GI3jV9kQHztCMei9?=
 =?us-ascii?Q?cW1l0FBvV57yRiO2BbprSMnSXlf8aeEKndYdP28svpoPaG3axEbOSjeTKZCV?=
 =?us-ascii?Q?WlWjQ0nEMYJ6XaA2Hw2TRKJx44mXgy2libo8iTUsc4w6K0CrnWeU5SVg2RNs?=
 =?us-ascii?Q?4FfafDDnz8unDKL1CtTrF8IHGwf+mfKTUoovY6ch0VR+WiHIQWxXyI9oonjL?=
 =?us-ascii?Q?dmEdAv1k4oOREwfkNm1A3ob/OpPVwPBx7qdNKgyzWPQfuG5Kwo2Ymodxt1vR?=
 =?us-ascii?Q?9uCsO/1HO/CNR6bpU8ovA5fwMQuVHF8pqHJ9dLJwTd3oiIw6e8Nn0shQXAGU?=
 =?us-ascii?Q?fdKb5Y/FM0r32S58bkuDUvfqJe5mkObX8SKl74vuLais/+39L/wa+MSfFQ4H?=
 =?us-ascii?Q?o9RuW9dLcfviSQgRy1ioZppdM0a33cqmFu1xOjQJLo1P0SPm9xP8aGNNiHLY?=
 =?us-ascii?Q?uAwSOLTfYsp/b9PavoVbCB/vnCYiYQ0dv49fP9eTkJ/R/QImTjnxJ7+o2zjE?=
 =?us-ascii?Q?Yey5VmAsPRheUOJ78f1tlmrEe/Av7rgKIAyotjO1q3gjfuVNLtx4gqsXvPM+?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37605ed6-fb5f-425c-2203-08dc4cbb549b
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 11:04:24.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxr2W4X5Ws3rfClkQ5Qsj8vCcHlpU0QFX5MbnO0+iuhNEUebjCD3quYa0A4AIIFvVkON23m7wKkn627rU03rbEoXrw+O4DNibIncOpT1Flo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7307

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the vp_vdpa_set_status function, when setting the device status to
VIRTIO_CONFIG_S_DRIVER_OK, the vp_vdpa_request_irq function may fail.
In such cases, the device status should not be set to DRIVER_OK. Add
exception printing to remind the user.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---

V1 -> V2: Remove redundant printouts
V1: https://lore.kernel.org/all/20240315102857.1803-1-gavin.liu@jaguarmicro.com/

---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index df5f4a3bccb5..4caca0517cad 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -216,7 +216,10 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		vp_vdpa_request_irq(vp_vdpa);
+		if (vp_vdpa_request_irq(vp_vdpa)) {
+			WARN_ON(1);
+			return;
+		}
 	}
 
 	vp_modern_set_status(mdev, status);
-- 
2.43.0


