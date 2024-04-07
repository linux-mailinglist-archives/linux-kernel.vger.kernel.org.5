Return-Path: <linux-kernel+bounces-134108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA3C89ADB4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2751C1F216D9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7973423B0;
	Sun,  7 Apr 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="dqgDA9Ru"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2133.outbound.protection.outlook.com [40.107.7.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9491629;
	Sun,  7 Apr 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712449650; cv=fail; b=lYcZIXjm+GcL54A6FPQgS8PokYcGbaQuCQB80hGHIDWV4KU0rqyS+ZhL8TjNBt0wgJTMYJOTsgfE1+CscsU33NScJgVp5TBQsrO0ZLQSOxmlGgIf2eBs+lCbOJ0qUaeOsPqgs7T7EJHynY8T8Oo6aeEL3qA2crOaRJsFddw1+6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712449650; c=relaxed/simple;
	bh=m3+ZTF0QIaURnZx+lJkK1NadXFQtdgF/dzosX265xkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bteCdyXfOW9Skso/Fd939xcvktvmrTcgmQR0yOebSTNtySGLXvWZuoL/ab66hwtAQONJuUkFgezDDhHEvi1+lKdVTxwjDu7j1lhlXB3fpred5qtJgTRW0o3NXCfxxo1EJ2MUlSoihWbE1GG9ve+gqPP1v6+jYV0DSXC2u29LoZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=dqgDA9Ru; arc=fail smtp.client-ip=40.107.7.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY5PaRFCf8ctDdnzBAyP2Hrxlb01pNEwsygRhQmYyO+v3Ksfg/dkODrHPhwkCuLrmQ2fWufyIfsJuZsX222KzGFSBzMpTM/JJXZLS71QbaqGSsjz01Kvzn4pQgtgqEqmYxyCYlD1EiCzU0f9jItHGPOptNlrKBRF7Y3GRtm+93oKj0bHEmGgwgOvxqPe0iEXnKDS6vXoCuy6p2PDFi+KHgMDVPcCr0XzmZ7pLhp6kNkgdbyZhPi1hKsrJuD9nfuJEGhYVwb4if0CPcMk1DzbkLO9jTDgBRhZNDmROLwIngaidF/acmYq0h/48+04lPgTXIdIX4tWWkdat1LheiXWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3+ZTF0QIaURnZx+lJkK1NadXFQtdgF/dzosX265xkM=;
 b=Tox5yJYcC0nfvF3e5HC+SmLB93nrz/Au5A15utnPjS2/liYoPvGKJycdA5p7aDu7tIw59u6k8vUgFWq1erXJOTbXE6nm6RsVbaNLBhS87Y7gaot2UmJuhfimNcy7qbV/pthQ7SWtfzZcfHkrp2dIY5/bl2/ivUOuElUtvc322XgzGXwj05vClhgMFoTcyhKjM46WjJVV+iZ7u/9sziwhNraktx4AWOUszSjYiFJUrfMImTYkWgHn2KKMFhjLNrKHvF9l75Efph++yA7lxS+/GtEfYTseKKDuFwIrOBg1W5bqaxr2fP7hy5g2tR23xq7b7uhI5gJZyl+co8Gx56bAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3+ZTF0QIaURnZx+lJkK1NadXFQtdgF/dzosX265xkM=;
 b=dqgDA9RuOfrPMf0xn6f4b+4P6dnHgpJZsogkRyF7Bqk0ErhSGqkVaMPojt0NnQKJR0aoFwELHR/qVDsQc54QfEG8RpJDEnTVKuMLP7dtyPPbFnpcfNWOr2udXHKKdtpQ6FagB0utX5jm3F4EjlQch6xsgIaZXhYe8vE2eENmf3M=
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1339.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 00:27:23 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8%4]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 00:27:23 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 1/4] serial: amba-pl011: get rid of useless wrapper pl011_get_rs485_mode()
Date: Sun,  7 Apr 2024 02:27:06 +0200
Message-ID: <20240407002709.16224-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
References: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1339:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JcEFOKDq3EnDXNMgzbd64RR/DiZcLk1gLC+hQxacdt/HRt32QRYr/ot9QWl02F1V329AfNCUxTqBaNXVL58yRbLrpSgfc290iSPXrPiVjKoY2zqlS0uts6FhnzZUyfinY5dfuGiemxk96JffKBZwV1qq5Wff6NRIzZSxY9AKZlivsCS5T600uFKOq6NE/cseBW0MI2yJnrvmDvxRIJis6IQ0CXycKs7HWTk7+6qjASL7uFytLd3l2TmHgdDkz5S0ZLD7Y9Zh3h7K05Ov7ojiFH3qXsgFEM1HE1ZF6vEJHPwHNkdpaO8EtZ4/YC3oEdQc6KtTuDULwQ9uKbdzZtWJiJ1uYQ/nvjLy7iBcMLTw3EkYCazjKxWq84ZAaCdC1lHtto6H9SqOpGxHYemQNtJPPiUFnz78ldtyF9aZv9H4ThjF8j9dyX3Vkg/ig5t0uRKO5XzT7YMHdoLccXfPt5jTAW4JjxaFwwp5vsyON3mWKdlkjYIdzs9l8/FaSrt6CmtIBrrbZOUNopl8Aaf731w5Mff6c49hqcPrVapP9d7eP+RZ8EwT/LeqtH+OcoO1JcG63nKc9CzDZqJo+Vqxy47bH+9bgiF+cEDSejD3pOzd9m/YCueCFqCD5EvtfQDy7bDFz8M77ijCN43VzulHB97iz8DNjmv73RXlLNpeRzwbJf4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+jHr2uRqxSVcaKd1q/PO3BFrVXwtI4PpbCKrklJw3ZrdRvFE0dOc1Cg1Yqg2?=
 =?us-ascii?Q?Y5Z8rzOSa07Bhh+9rpSfmSkJxeXy2/Ha7DCu4rrzj9xjocjgsibS/sk2D9Wk?=
 =?us-ascii?Q?UCVGwGcXMVrW5Nqa4F19fZWpPcQKxdbog+9Hi6tIUZiO/Rb9AMfF8sSGzzPu?=
 =?us-ascii?Q?l643sw4cuysWQVFpW7KbljOJLwqbaS8zk6MD7v5rKslMuoCh8873+vp5KIE2?=
 =?us-ascii?Q?967/DurVnAxZT9FZQ+yyz+rV5ys0/PmWuuzVbCaT23esJHkg1+d6xbG7yZXl?=
 =?us-ascii?Q?D5WYDOuMC9xHALTFhAS/MtqDzbYhdHJmL7dx0ScmxBNF+EYJPtJvyj9NFn0m?=
 =?us-ascii?Q?phzSrkvOXBbGGNqYPKSYooZhtM/pgPtRuLli7P/nCaO60chjkalk8lfKUnRA?=
 =?us-ascii?Q?3uEDhqLjyVKJZvoDj2jOQ9z2EVI1tfsSw0899Q9RZvtnM78JXA7ChxgYK/e0?=
 =?us-ascii?Q?ZqbbMb/OXIANa3X+iz3LFJgimdNiR0nC177lyGTRdVlR/+wOjzo9vOJO/Tuu?=
 =?us-ascii?Q?tbKdkbZZMFQPu/c5otZOeAoA1P4i8tExC7BlGxH3+1+HcnvXZZDHQmYq6xCM?=
 =?us-ascii?Q?N34RQ7Vn+gZE8MRsDSsbivmCFOOshbpxxaP3x6By2tE3g2GxMMjh668AlbH5?=
 =?us-ascii?Q?tRGt9ugPCSMGAYOVZ6rGUImh7eqNUneEJn/LQAiXTCid+okrDDvssyroogYs?=
 =?us-ascii?Q?SvaUlJs+WadnihL6droKt4B6VyjlBxWKxDy/B+YgnV4HAyTnnZYwFeVfMvFV?=
 =?us-ascii?Q?25dcrPtSQhKstc92PZiiw+82xtZxtFYMps+9DQehLtst8EETr9bbq36IALHZ?=
 =?us-ascii?Q?UToFZKE/pv4KEJO78yZZHO8sof9mCKR53FWFDqD41JHvNK8/w7lsh2HmrsdV?=
 =?us-ascii?Q?BrG7r60SE3UaEgd7bk2anxApljEfz9XPYRo3jUHTnfnW9IgV1zCSy+3O7F9t?=
 =?us-ascii?Q?qXqAOeyurJePNUjpcVVx8tewtru/vZzfJ/WWlnW1Cjujsdo6c3o+MvlBhYHu?=
 =?us-ascii?Q?OfPxPGPKIdkhxpl92b2oOM33eyK8J+t7VGkVXFwSdRP7BiYJ9kQLJvb4CzsK?=
 =?us-ascii?Q?4TYYgyEbgTyqZAr4aeY5HEzaBdv0V9ysg5h4fHJIDhpMaSVCEWTJpNk7iiPH?=
 =?us-ascii?Q?IQi7vbzA19RLX0ZtBANUJ6hEuY+PFRB7r9H/swOmPc+tuM8KOrjnNjTGfr2q?=
 =?us-ascii?Q?BArqokkystWtFP7c9hdKTNBka/K8FnEaz360j2+OsX3wKIUimoRizA0PL5WY?=
 =?us-ascii?Q?lcKS3TPuQIBQpdKFqSBsPBjvj5u/fnHARosC1rJylNNwa/fnX8PWibMVNRhd?=
 =?us-ascii?Q?Mhu3R3Z4IwPmZC+X6j3GMYAqKsO4T+M5RPtrQ0CJzR4w4EOY4y+WtQAmTCjo?=
 =?us-ascii?Q?w48hMOjWK3G8Y9ZskzWVf1QVhtNxvOr4gXGT6WvMkNCe4kGUAbnpMja4HwCZ?=
 =?us-ascii?Q?xms/RIdiDJtu5YPSaZFShhdoWcliPXoU+nrhu5NnY3tAvT5vhNr8i7N8fK/m?=
 =?us-ascii?Q?3AgYZz35yrsGPIIxmPdLlCB22GqBQ34ol6ZYWsy3TnkhTiaAJqGokHLGyOTj?=
 =?us-ascii?Q?r7x5RF79NPO8CK+q3e9baW6+A8SD65351wp4tHdrCTjKWMiI15HFAZB90Ph1?=
 =?us-ascii?Q?bxTnA3AU86hf87a4qU23VFZyQA23tAnQyf3As6xrHQV5?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9412c2c9-cbec-4f0a-411e-08dc56997e01
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 00:27:22.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dO4PEssGnPqeRdeqI5iqNy1RHyN2hbg6z08S6npcQx1ti4qbKBUezOCR1Yd4wJH7/lOhnNyIQfVvoofacuXKKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1339

RHVlIHRvIGVhcmxpZXIgY29kZSBjaGFuZ2VzIGZ1bmN0aW9uIHBsMDExX2dldF9yczQ4NV9tb2Rl
KCkgaXMgbm93IG1lcmVseQphIHdyYXBwZXIgZm9yIHVhcnRfZ2V0X3JzNDg1X21vZGUoKSB3aGlj
aCBkb2VzIG5vdCBhZGQgYW55IGZ1cnRoZXIKZnVuY3Rpb25hbGl0eS4gU28gcmVtb3ZlIGl0IGFu
ZCBpbnN0ZWFkIGNhbGwgdWFydF9nZXRfcnM0ODVfbW9kZSgpCmRpcmVjdGx5LgoKUmV2aWV3ZWQt
Ynk6IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNh
bmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3Nlcmlh
bC9hbWJhLXBsMDExLmMgfCAxNCArLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvYW1iYS1wbDAxMS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYwppbmRleCBj
ZjJjODkwYTU2MGYuLjNkMmRhYzBlYmNkZSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFs
L2FtYmEtcGwwMTEuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jCkBAIC0y
NzA4LDE4ICsyNzA4LDYgQEAgc3RhdGljIGludCBwbDAxMV9maW5kX2ZyZWVfcG9ydCh2b2lkKQog
CXJldHVybiAtRUJVU1k7CiB9CiAKLXN0YXRpYyBpbnQgcGwwMTFfZ2V0X3JzNDg1X21vZGUoc3Ry
dWN0IHVhcnRfYW1iYV9wb3J0ICp1YXApCi17Ci0Jc3RydWN0IHVhcnRfcG9ydCAqcG9ydCA9ICZ1
YXAtPnBvcnQ7Ci0JaW50IHJldDsKLQotCXJldCA9IHVhcnRfZ2V0X3JzNDg1X21vZGUocG9ydCk7
Ci0JaWYgKHJldCkKLQkJcmV0dXJuIHJldDsKLQotCXJldHVybiAwOwotfQotCiBzdGF0aWMgaW50
IHBsMDExX3NldHVwX3BvcnQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdWFydF9hbWJhX3Bv
cnQgKnVhcCwKIAkJCSAgICBzdHJ1Y3QgcmVzb3VyY2UgKm1taW9iYXNlLCBpbnQgaW5kZXgpCiB7
CkBAIC0yNzQwLDcgKzI3MjgsNyBAQCBzdGF0aWMgaW50IHBsMDExX3NldHVwX3BvcnQoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgdWFydF9hbWJhX3BvcnQgKnVhcCwKIAl1YXAtPnBvcnQuZmxh
Z3MgPSBVUEZfQk9PVF9BVVRPQ09ORjsKIAl1YXAtPnBvcnQubGluZSA9IGluZGV4OwogCi0JcmV0
ID0gcGwwMTFfZ2V0X3JzNDg1X21vZGUodWFwKTsKKwlyZXQgPSB1YXJ0X2dldF9yczQ4NV9tb2Rl
KCZ1YXAtPnBvcnQpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKLS0gCjIuNDMuMgoK

