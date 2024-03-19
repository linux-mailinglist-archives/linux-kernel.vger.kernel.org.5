Return-Path: <linux-kernel+bounces-107290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1C87FA76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38B51F2236A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324C7D081;
	Tue, 19 Mar 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="Kfk1WLC7"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBC7CF3A;
	Tue, 19 Mar 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839469; cv=fail; b=PQC50cqjf5+tfckmSz8hoEGXbXSEtI5V6UNLSI/4O83tLh7t9CW9WGAW4u1TOY+eseQFrrkSozAB17LHJndoAMEeQPqoN7yXBxDjvQJs3yxjJL4yp2F2YJYZGljd/s35/GnPG8p6ejhhEXVtbwqp4W+fBGRe4N++9dy3cDySklA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839469; c=relaxed/simple;
	bh=08LRLOtFn+nH3MmU+R5lA7yoR1Mua5m6sKulxxdBTZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l7rQVn8tEngUWZLdge/5tQM8gSJWfdrKYusXtte+Jrudwulsxgj6+1Aj63wcunjt056ZzKQO/9gVJ4Lx6blktM5ft4Nfq1cNn9rYOVssSrF+EYXpCwxbzvfK/W9AeU8Ulal+F6KtWxtnVgiel6VTQ2iYgBVFQYvioLfbDV/U+gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=Kfk1WLC7; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZjdldsU29wSyigtgAlUcINqPzElN9tq1LVdGmo8r4m6QEDkLDn5rD57nrDeTDmuUjzAyqXJflQOu0OPL5cjL+vnRsTIYNCgcDkN9vmqi/9FnTbAkVpmteuT2Kc4tev7AVGs7NbfTFN3yVb59OIv1niU7Pflcws3nc/iILLSzXBgRRXPT3thQixMJh8Gf0vLE/gc7TYwL4inSskhmYJoQ+90GNV2Z5jbyC1BjrqjlEtBM4NH77eN7SsXl0DY9GVGycYfCkBI+0a6X2uoG9V9l5Sdtp0RIfP9hgJtICDF6Ag7LoZ9fycbD77LUMIF20a49WRdQa63bPExBvi6cnnRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08LRLOtFn+nH3MmU+R5lA7yoR1Mua5m6sKulxxdBTZA=;
 b=Jg9fB1h3+ifIdc43BwttxyrrGog8JUl6fVvX+ZeGRl4mdrRZOJHCIk4v7eYkvcA9fJZhlK/3fBDvpLRRC6ElwjXnJHHJg9F+0X+Mh56bJOjRL0I9Ef+USGnRZdT9JYl8zccqZb2+tLhYvV1/fhuM0fbE3URD1h99nEMIbHIKmST5UJOmxbG++g8UL7Qp6BzhmPRioLOuusKG68Alm5wk/0T4DyUilHNdKEcY57OKRkr828Ti7SOyiTTwCSg/FC9Ql5aJNnX8xdneOLxZVSnNMlSiVfPRUhKBYioVaZ+7MeajSkqdj/Bli/KaonJ5VUBxZMzDkhmAhumwcoA8oubgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=google.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08LRLOtFn+nH3MmU+R5lA7yoR1Mua5m6sKulxxdBTZA=;
 b=Kfk1WLC7npDxKO+6okTxyih3HCfQRIfdfljNOyYJmGV2dEqffzsYVQ2JsKrD9j8iWnUJcThPsML1o8dIF5jOf69VwrjZM4HKnzfT1WGoh1L2jcaUKJTwi5i+1i894/9TPlAkGEUiw8hb7z9HFceJYGcQpyOQidO6Pxh8/C8cPiqD6uEkGIcowzFOZpfYqnADUMJY9VxHLUbGwxia/7dzlurQSLIIORTIByw6+wa6bLkT6VCSNfybIj/z2KA8fOv3Wjq/KVAsqZoTogoOW7WFQsYt+hUgIaLwQq7caROwYjVOe+FR+cevZo7J2nV+NwFZw3Y1fgM1F+Iq8qSPQ7cmdg==
Received: from DU7P194CA0017.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::6) by
 GV1PR05MB9795.eurprd05.prod.outlook.com (2603:10a6:150:86::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.28; Tue, 19 Mar 2024 09:11:00 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::2) by DU7P194CA0017.outlook.office365.com
 (2603:10a6:10:553::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 09:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 09:10:59 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.41) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 19 Mar 2024 09:10:58 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by AS8PR05MB10561.eurprd05.prod.outlook.com (2603:10a6:20b:5ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Tue, 19 Mar
 2024 09:10:56 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::b777:79ea:2f7f:8765]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::b777:79ea:2f7f:8765%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:10:56 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Justin Stitt <justinstitt@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] tty: n_gsm: replace deprecated strncpy with strscpy
Thread-Topic: [PATCH] tty: n_gsm: replace deprecated strncpy with strscpy
Thread-Index: AQHaeYhZ+rm2Dpa5Z0qBCeHxLCBLHLE+xrjw
Date: Tue, 19 Mar 2024 09:10:56 +0000
Message-ID: <AS8PR05MB9810B8AC6B5033FD6660EC69832C2@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com>
 <9bba38df-5881-43f7-b1b3-f77e7b57bbe7.6c628ed6-0c2a-48f7-ba62-bcb23589b41f.60196f95-e445-4678-a450-875badf86498@emailsignatures365.codetwo.com>
In-Reply-To: <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|AS8PR05MB10561:EE_|DU6PEPF00009528:EE_|GV1PR05MB9795:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 7OIfpu3L7eK/r4rLoP3k4WGOEE5bLNRDw2Xartcs9ZZLwEdoP93ksSCOqLL7F0q0z65q2yC7jfrCxW0EFw2/Hg7w3mkSmjGDTI9RpNyFE99t74iI17rBexGEXQXPC6QesSSD1JarK4eRmPgSh9KKAe6vL5PCS9YdtQDQq2f1E5CTx4AAymy62UtLhdBUHb2UCFu4eYNNvshcpIq6O6gK0qJ61GbbHNOqIS50DKzr06RqHqvtTrm3R3ktFcOsHRiN8ZC6zV2GAaBCMTYLKpne26VJm/RArjuODQTo9gA3VCsfvwxugnfVgCj0So3m/kz2aCOQ1cL4cXATLmD2SLGJhzSNrYiPIoRTfyGdF3auVulm922/V9aSXQTDPEpaxaAQMRIoWVxE5/tIMVMx+FbvMT17n+yDoTW3MzLzHS9LXhF78wfQ6hWtWZXcNZ8mDQtxLkyrAf4815saEoITGB/8/DAE/y0938XDWVZY1S+50+1qlym8KUIlxHV3sc01B/zyw8OcIAvO8yEgbVM9bCHhmbq24+ZT5gE3a5oykiR1llBhzbAoA01mKN0nYwTof/jaG2THlnfL8h50Ke/5g9LYGlKNuXiji1tVZeoPjomk3yMczYnr0vl6CCcGOxvR2mglkwSFOwYpLDYfUhmczqBNaSnrJfSnjnMclzz4sNWZSAM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10561
X-CodeTwo-MessageID: 87209540-bfbd-49e7-be57-bdfc8584ac16.20240319091058@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 382050fe-8917-4c9c-a3b0-08dc47f47e76
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0AprxdN9Lb0Ly/L4kgH4Kuvib10zr0OFRR7bEPEdiUy45cuqSXGduJbakH6tMvBd5TMmLGNKNw7SqnscVmxqVgh2BhQ8tjxie//DmZpqix3+zxoHOYB29JHjNSi/dBAvlFM5W24idTnyLYJ9+5T0NIIEzqyIG4jzYzOmzw8BKv+4q5hFKICvLKGZF0pwAitNr1uB3uoRQmvBUT99IQ7lks7nLu4eKyaMCmreifhGeQvmwmYD0BFmV7OyqqJhmRCS92G4HnZmRt6IHZxZGZ/ZyMiRl//8FddfK0vnpGC8aLFaTKyBRs46Q4oryI4kg3OMzmMugMuViObLlaBlXdLoaYsLvGmEiB7cgkVtjj6M5jhtQUwQIVKK0EIZ6tKqs7NpYCCV66IoIJ+0WDy83ffQcYXapEhPiAI3fjRWCLIZjShbxmE7NzG3zrjjDntR4w6Nag5Z76rkbXsznctu2gbdab/5TCffdMHuSnyuw7UCxkgde/zsAGMUjR5cQxPGi/dsJ90csCPQV/QoUOSlY9CN7kjtXpMOE/vbT0EJWQCDHDwVTl8geGO4KtkuyldM4SWoF+IGjoRigwGl0NUCXyFFTjsE3RGRLT2CH8z6ZPfhubQdrplIeyD6wJ/rl+lQ5GcvU2R8ZMshPol8T3ehIjwQ7Vp9WZNGUDJGkkM6gKaMN6f1ASJ/ECSEwj//R3kKamQB84Mr564MduWjqDO9uBUI99RFdVURfYuDuUGrVO4t5Ke0vq14WVM+LupbM+Jf6VZV
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:10:59.8908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382050fe-8917-4c9c-a3b0-08dc47f47e76
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR05MB9795

SGkgSnVzdGluLA0KDQo+IC0tLQ0KPiBOb3RlOiBidWlsZC10ZXN0ZWQgb25seS4NCg0KUmVhbGx5
PyBXaXRob3V0IHdhcm5pbmdzPw0KDQo+IC0tLSBhL2RyaXZlcnMvdHR5L25fZ3NtLmMNCj4gKysr
IGIvZHJpdmVycy90dHkvbl9nc20uYw0KPiBAQCAtNDAxMCw3ICs0MDEwLDcgQEAgc3RhdGljIGlu
dCBnc21fY3JlYXRlX25ldHdvcmsoc3RydWN0IGdzbV9kbGNpICpkbGNpLA0KPiBzdHJ1Y3QgZ3Nt
X25ldGNvbmZpZyAqbmMpDQo+ICAJbXV4X25ldCA9IG5ldGRldl9wcml2KG5ldCk7DQo+ICAJbXV4
X25ldC0+ZGxjaSA9IGRsY2k7DQo+ICAJa3JlZl9pbml0KCZtdXhfbmV0LT5yZWYpOw0KPiAtCXN0
cm5jcHkobmMtPmlmX25hbWUsIG5ldC0+bmFtZSwgSUZOQU1TSVopOyAvKiByZXR1cm4gbmV0IG5h
bWUgKi8NCj4gKwlzdHJzY3B5KG5jLT5pZl9uYW1lLCBuZXQtPm5hbWUpOyAvKiByZXR1cm4gbmV0
IG5hbWUgKi8NCg0KV2hlcmUgZGlkIElGTkFNU0laIGdvPw0KDQpLaW5kIHJlZ2FyZHMsDQpNYWFy
dGVuIEJyb2NrDQoNCg==

