Return-Path: <linux-kernel+bounces-100777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56D879D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2DD1C2159B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A714291E;
	Tue, 12 Mar 2024 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kQKdatTc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2055.outbound.protection.outlook.com [40.92.18.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090E382;
	Tue, 12 Mar 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710276815; cv=fail; b=G8GR0YYAIZAVYLB5mMzAh0wYuIz8umFFNQZ82dAiQvkCpFHHV78lI29nc146dY0BFzGVyARoIaJy8KNAmaiI0KF3YJBzuH+5+bGmLsbaoHKahRKG817fSlITAlwAgoLtX8nyt11RBr1COpNhTNFH21bWyk4xuc/Mk5VvgmXgzbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710276815; c=relaxed/simple;
	bh=1I1HO3lFWvGy7TtQYHdQN/BuERhN9IiQ4TtWWWoMdBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IgPchGg79XQRm6tRRX4OSfJrb9DyQ5dUR3T8Fqs4PmWQO6bLdECSaK18scNObEo4qomdP+Rjn4RJamaOwZxpxig0ohUVjGtVgvDbaRdcbyBw66XOe98J81Raf9MyHL/W/yX39sHzwfQ8WNmYP/z6HXBFaUrtYeRxvXQVCK12Q/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kQKdatTc; arc=fail smtp.client-ip=40.92.18.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPNQh+JZ86vaUm2osokvF0PqY3ouxG4zoGlImeBEYMuOc9frS3cAnfC6I/sxMOKgR3N76mKogcaYSTTxv9nzOfLvrS6uWJJgwlISekjJwyDlMfsSBXkObFagV2uO+p12q3Jh6XT+e0uf4VGkXSAw3Cso/XOPDC/WS07ybK1yi8nMSVx3a90rhOlNcaq6/ipAyfzy4KRLXvZImNCdGRiT4+HmuKQl45DzEGNHDcI/oin0WEjAFzYFs/1ERNZ69pQ638tGjwHRa+rr/HNaASjRu9BzN/yuf3Q5ppzJKzszhiXtC+XE+ZaHoclpTiQESI4l/p0raE9DxOAyY2IubRnB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I1HO3lFWvGy7TtQYHdQN/BuERhN9IiQ4TtWWWoMdBs=;
 b=QoWNLguXXoUCk+p7Bs1rNh7/G9IU+oUsgbIWZouh5wnhvnUTV0zf3WTKJRZkpz5BYbZL9b8vzdnavalWJtmkayhWEaDkwHwGbGV+UX42P8Z5R02ZTkCgOu2QkqH/S1cDjpzC6Jg298qiDxDxUwF7W9IgItQHjmJTgxdpP4mqWL7VaIME/lMQC14QbJmHCpHfUrObMlqfYfcYE5Jwy7vr/lAobl0aCklSsHSKxXvNzzVaagLlKfecMLc8R9hTbWTC7h3JP+meSdAZxCBZlI2/NynDxD2nbFM4UAFl1PIoRb7tmUyzUQlUIqVnN4WUvnwQcQwfb4gwkRJu0tvb33tX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I1HO3lFWvGy7TtQYHdQN/BuERhN9IiQ4TtWWWoMdBs=;
 b=kQKdatTcTObje0a+Syfb2Ygm5jIDlH6nBNEwSSpTJkUrkGtQlWLd4hsfjT0eilyhSZu70ZvLXqY0Kf7GsdNYz9J2/qqWTsGOPkJ+LjFBiTEh1RlA5RyFK2K8WCNES+wtvqs46p1J9Zce/SpetUh1bX1bxIV/NJGFq5vE050ZubtPqoznDKpdsB08FbHxvNEfqnoED538hn5Q9RwCRFvn2jlb7x39ZzHMufxQJIbUEBjLw8t7BHgdQOgcD1UcglwONNNnFCrgPMe/1X56FalcYCRE3dHEIqOoc5T74kYCTtIR4R9dhYh14gPtN+R0Y6bRturliByVn/DCSGPcP+7F6A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6659.namprd02.prod.outlook.com (2603:10b6:a03:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 20:53:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:53:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Wei Liu <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>
Subject: RE: [PATCH AUTOSEL 6.1 3/7] x86/hyperv: Use slow_virt_to_phys() in
 page transition hypervisor callback
Thread-Topic: [PATCH AUTOSEL 6.1 3/7] x86/hyperv: Use slow_virt_to_phys() in
 page transition hypervisor callback
Thread-Index: AQHadLzVAkgWooNpOke57f1qHnLiFrE0lO2g
Date: Tue, 12 Mar 2024 20:53:30 +0000
Message-ID:
 <SN6PR02MB41573B4014405943158B8F31D42B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240311183826.328535-1-sashal@kernel.org>
 <20240311183826.328535-3-sashal@kernel.org> <ZfC8j2eUP/139bSh@duo.ucw.cz>
In-Reply-To: <ZfC8j2eUP/139bSh@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [p4AxuvCEP9ab2a/wg0UxEbie6jPmHgLe]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6659:EE_
x-ms-office365-filtering-correlation-id: 8124531d-182f-4a87-df63-08dc42d679b7
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnoAVlBsXi+5fvsd/1azsy4llBB8dZyMzxQY0WiF4l6L+rY+Qbb1zFGaQn+wQ/kn8iEScsYZTrGSNviEe2RQrMGKt0V4xQL2EaNMiD03rZj7gjbhe6elPFfg7k6It5k5rFQeC7SWkqyPto/723vJVRSlkJTgrte/eAxss7cR4jqvWvBpdx7DP+eLtbgoRUueyKWWQSL7N5g3IHvAq8ex+3USnEFkUuTNE2yAZmm7Zt2G8OE4XJy0HGwJKpT0WTNxZFGOnxGGlxNwW4HsDnssibKBfQn4xxs5Yy1UNYtz3Pa2JWluxcKNrk6BJMs9h71wfFVkVplUXKZvh+BeRNxfWYpzD8/eYGYIqyi3ZBsgbALN69oo1AztHHd6hdp4bEdFnCex+XUgFe7dPiOf/lQ9NNfJhLC9Jt1QPf5zCA7LTHOQp09tG7ia/KoM+vkMdqLqnNUPmFsZ316/5jqaaKxP7EI22cjnvKQhdJx/zhzH3S9LpbK9HHU6UfnUr2o+Xz0EYfxFu/52v+5BBEDEiqNausTlOSaTC8oq1pSad1sO9TKymV/B1a1uzEUiVB0rIsrdgh54zgu5UWWj55RAKGfF7J6caJuF5lZ7DuhoJ2q4yymCVIeTKTRNc99Dk4x4OydhsL+LdQrHnq7wD7uFtRIHAeK2Njmy/i1qWDk7MEJPtrXOyneHjkXMgUb87ol8c/N71KiZsLrlt0HGn+lst1sqM/iYAfeZJicO/uMyTGzMm1B0MWb0lEhaG7PxQKVlr0xUU28=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 at1/mPvQL4+XLawtqVGQk/3EPFsejh0g1UgMo7Tbf/wqMqKjNdNCdwG55dVNpNz/jr5owqkie09/48d8PGTi2AKZxevnF0J5tRZUFmNIfVAV4UK1oCWpU4ZDeoyze8ni6cDbPbDGYZPVPbsYA9IFjgi4ACcnGtxD/Kqv3M1NOGXCk+yKCWDZl5JL5rOPwpwJGD/b7GjzmzsAeS9jDPnFSNbopl8S1QjsDh4TzgzpGq4JBIU9D3HQgZkZ4+JGANiaEr4Ka8IpH11DA2zG8ndgICMXGVAauphxgWFeoTYG2iiFswZQ9Cm6JHjWO+JobQ2jm4d60Q370sDFgoIATkp+9JD8W1j1hhgQhMJRa6nsCRWXlqv3AuHmTwTCgYc64SQ6PSOZeHXfgZtXkzw/wMF0MmFYetJMFuA9AduCr81Ik7JKN4Km2MPiXN5z3D70/0PNUfSPV/y96QaPqccri1xxaLQsQTxA6zZgT0FJBDY3gj7QcdzO6H7uVFKK0O/97OiwsWel49OBS7w6x4vjgmTeljYqX5kznsuYEFAqUJ3UJmT0axg9HeNUqdeA9At9S1hb
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f+PuGFZfH5YHlZFnWGfKLsyg9pt3+BP3ATX82seJhdQdiECQjF1ckfZOHZHQ?=
 =?us-ascii?Q?47YnupYZnmDSK0DTqCnYzXE+AcjmXqEs564pABctOxUZqfHSHXkVfKEL+7o0?=
 =?us-ascii?Q?8LpU7tMqPw6c3IDtsgPvy6aOAtiuFgjhkeSz/h9NdHh9SyH77EhW9jyBmYaJ?=
 =?us-ascii?Q?PVyYC0kZ1sTbG0D74rPICsbEY7ypM0/+6hCUKQ5x+63PCo7X19o9Jzo6K4WS?=
 =?us-ascii?Q?Uyvc+3Lc+ErBHWdB+c/J9czEM+ic1EPMVqr61/3ij+u/mnCXJx8+ac5/c6Rl?=
 =?us-ascii?Q?wAU5U4/aXt8CM+GVtUowax/LjGHCg/PdDTJyawJVoweYCb32/IuY2EeOetPE?=
 =?us-ascii?Q?lSmg2ugFqz3YluxAZS5AclTKDVSc8MR+oLZLpqhuTw+joGt7CCx1s7kwWVWY?=
 =?us-ascii?Q?YMno/pwGhA2EbVfKykNT/TZcISUwXmIrUo57hClPg2jAZiMT/9Hk3hCpuDzG?=
 =?us-ascii?Q?Jqr4C/WB0G3ITx281uBTeAicEWpZz6QRF1QZb024QnM8JfNN+qczptvljVdO?=
 =?us-ascii?Q?8IBaGpPjkQmsTyX9JNYtFrUOE/0/+urRhwhMG4GJeMn9A3frttH0HdN1qMJU?=
 =?us-ascii?Q?W9l8rvUvNFUOD8vRafYCW7895OhwvgCOyqKtZp9g+spQIsKNd2abxR5YT+z2?=
 =?us-ascii?Q?07gzzi1Rei4oFh9pHDQDjQ3rzhn/O4WVGXOCRiAFgm/XlGTFltiWOJKEqAkH?=
 =?us-ascii?Q?UcsiNyPO7/taXFs7+qDH1VLjnPTcslRqVsE9mlqwGnNMxMgfu72SnnxIk/lN?=
 =?us-ascii?Q?+ErvQWwSWM63a7v7BrblnHJfkPARzgRxO2UYOR9zMP+efvHrWbrpliN9Lh0d?=
 =?us-ascii?Q?kd5KxH+4ES/o3Pc3q9zY3JoYWBgnx9D3tDNDm7gPf0mp+R4TZYf1lErGzuNc?=
 =?us-ascii?Q?uZ2VizLXAvYckt2PBW3mjL+/in7RXlAv6sV2fJkzNTG7V6JKWBETZ+OwgUtq?=
 =?us-ascii?Q?zONn4fDXnNB1957Tpuu3C0aTD2NL0SplYiL6Q4WxKjEpEq7WfCLN+PgY7/xk?=
 =?us-ascii?Q?f2ZLNnSYOQanVEeYAgzSmZOR4dc86AEk/MU0V3mP8m+bpI5xoQWvsLueykRa?=
 =?us-ascii?Q?kfdsFoXHGqelHw6KOrmVBVmr8y0kNZdJFs4O7CyrFuyIdaPcobXllNuXOAdG?=
 =?us-ascii?Q?49qwaxU74szkbMjlL4qMLTFfm2WS2kSV4jeNVA59uXYW+j77aUT7oUxzeXBy?=
 =?us-ascii?Q?03wkjAQcnHE8EaFlxvjgyAXePogj5o7iHw5RPw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8124531d-182f-4a87-df63-08dc42d679b7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 20:53:31.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6659

From: Pavel Machek <pavel@ucw.cz> Sent: Tuesday, March 12, 2024 1:35 PM
>=20
> > In preparation for temporarily marking pages not present during a
> > transition between encrypted and decrypted, use slow_virt_to_phys()
> > in the hypervisor callback. As long as the PFN is correct,
>=20
> This seems to be preparation for something we don't plan to do in
> -stable. Please drop.
>=20

As the author of the patch, I agree.

Michael

