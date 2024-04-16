Return-Path: <linux-kernel+bounces-146786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC38A6AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CBC2827C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9943912AAE6;
	Tue, 16 Apr 2024 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WbcTx6Vt"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9F12B17A;
	Tue, 16 Apr 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270397; cv=fail; b=hMo94PInDVHHokH7dDAVZ+Mxf4scfv5KBLhfNPcHG4Nc8dQtaAbEQImzhcbuoE8AA7gKjnXKBl2jNeeDDB+wAj1YQMS5buII5SxH9LcWl3sP/f542vOkAryqNfmzrV2CZobNXKqKYwik81bGBf8Krlp+omTvvF+DZp1whp2jT8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270397; c=relaxed/simple;
	bh=STtncVIwz3DpJQatmcg+q5ffdNoJ/YEDsPRC5CStLzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgIQh0mja8jUn58KbSjvLWVJXt6LjZ8yjE6wA0EAeYVL59BSpil6V5WWwAzHhrO3dhwoNEAi5XfZ2CPPb1PSaBzkteZCf9mA8jmuWKr68X7Tu6wgP3guwynaohTaYcmm0fJSnzR0GHVI/hjguNNBwy5yxmi00tT2Fmk+HdmPZng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WbcTx6Vt; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeKMYNdgZmviL2zCAvfnb9uZYrjAvgCxaYOJWuHP0N60VUuHsGYAhNpUQr8daZaOPgenPw5fPJd72ElGMG/HtsKHsApgtPOkoV9RviH9+YEbkcnSNh9O+5L7z3b2xCAgnSjIVjmUp/iA7Qcd6p6m+8BYIsfn0cM1MhXZ2985G21kWRcQRK9Tl1B6hRPGfhnAXPdn+3Ht9k8c/tRfLCQQIMoKT+l3mM2OgWIKMB+UI94ZJm5IPJx+IoUALN7jwrwxLEEpekuvjHNx3fe5MxkiP1J//wvR8HXHzYyACd5AfVfqb63dayXfJldN4hWXcbTfWD47x8Lihg1oS6OenRQcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STtncVIwz3DpJQatmcg+q5ffdNoJ/YEDsPRC5CStLzo=;
 b=n0XS1iwsnqD32KWiIMqdjlZHGvOKld6RtbpIXb2cFl/BbXaZvWzyNIN1YGebn+BcxmFId6naRn5tGBxzUo2RJWXhUO42f1yhub/fz8HKdd1JhyD6tTxZmcWMFD8YHtiVcIo0VT601bZs4a+vag2dWQfqYhUg8C1Chdt4skJl0EoFKmMKof7TfrRHVmgzAl14iE1emhRvyvzBbPG1so/+HsR+dRJG+0wwkYkxVKp5KRVGn+x9pwpGJeNWi4P4OfDeHO51yIvJ4OjUL/u2kCjD33OzbYOkANcWOZgP6zjRNtsrF3fFjP3iiwfHkpZp7mYyxcdZrU/HJsQYHaVdKPuMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STtncVIwz3DpJQatmcg+q5ffdNoJ/YEDsPRC5CStLzo=;
 b=WbcTx6VtWN5zTJYcCj4WgzMjRCcKs+NGWrBVrIjDBhRtsGgjozY/gyuVOZP8WZgmSGZ8AZNeiJx8IKpnEoRCqjwUWo0xM4J6NrXZkzqqMm+zVwuwFbu6apBw5J5+pybJUEzY8GveMuvv1l2r9TrxYubk9E+CceA6W24HpTh55aX4iEn4BBXtixzxjoaEfmwLIrLqB2KjN99vzDWXG3yXibGbyd3i4lUA4udI0Hh7m/RyQGVqdK6JjeLv8zHN2HkERXrTutsXiwAU66aqDr5bEfYsPQtYpBAEjXhkGb9K75lktCmq9hU4I3jxw12qBURfT6/UVPvKOIm+5X2yASX9Yg==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS8PR10MB6842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:26:30 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f78c:73e8:b33a:7211]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f78c:73e8:b33a:7211%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:26:30 +0000
From: "Starke, Daniel" <daniel.starke@siemens.com>
To: Jiri Slaby <jirislaby@kernel.org>, Yewon Choi <woni9911@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
CC: "Dae R. Jeong" <threeearcat@gmail.com>,
	"syzbot+6e3e8f30f269f5028e5d@syzkaller.appspotmail.com"
	<syzbot+6e3e8f30f269f5028e5d@syzkaller.appspotmail.com>
Subject: RE: tty: n_gsm: race condition in gsmld_ioctl
Thread-Topic: tty: n_gsm: race condition in gsmld_ioctl
Thread-Index: AQHaj+0lLWtf51OqqE+4kuIvMRZt1bFq0sPw
Date: Tue, 16 Apr 2024 12:26:30 +0000
Message-ID:
 <DB9PR10MB5881D2170678C169FB42A423E0082@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <Zh5Zj35zeobGGzKj@libra05>
 <69b4cd22-3a02-4d5c-a110-152b8ba8200b@kernel.org>
In-Reply-To: <69b4cd22-3a02-4d5c-a110-152b8ba8200b@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=cd9348bd-3e48-4faf-a304-f8d78ae40813;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-04-16T11:48:53Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AS8PR10MB6842:EE_
x-ms-office365-filtering-correlation-id: a0f8cefb-d9e3-4ed7-8816-08dc5e10722e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WNGlsTXnxCbxylEaQ/B8FjDQYpy6jSr4+akScXI89wqGabcXnWTq05/MB1qGyR52ulTeZTqktpr4/kGuk7L60JnVLfowks6R382HxX08T2eeJlX2zEV5D3JSumk6DCOmoTEUOdzSPNndHU7aUQZhkNBHJZlTSomBbt+GZ6bxeDZHxuvFxC3Bh3+NRbBILS2H6hmyINRW1nR2otUCnR/J4ydcCdFqoZgPm5ZZ9FnZxuWMpIrQOl4LSXHam2D/sy314NKcZOlxBA0hP8WvJ9ijmd++2EsezbPwtgey/YlS/SviEZ75ORVS1bLJaBaDTo8KbaA395CFQOO/LvSZWgXvBmREbaRP6qQGVwRV/L6cuDpBjaviStqWGqRjM/zzlrxhTY+H9N1c0xPh6TjQ3mPLsJVpVXzZGCglQPaHKknyO2xrLQgPvU2UvI22bsC2+vS8fz9AGkG08+tlVqnrdFKgDKGCJ8UV1p0HVGH/Rc83AOjl1zKMs8jPM8NHM8ZsMWYcMJTtixSFDb1AldAcska3VNptos8kITsjVH1triwqsDlZyjHsgc+6Hwel1Qm55o36AGg/4RwG2zVo1Taz1OtPTHrWnbos1g25W25N5CU359SMyeWQIePFU+aqnFGT2OMR9NtheT8Ig0gd8kX98dF/kHEOcFCbAzmdgWz08c96AfX8OV/nfq2DtTTaZukooc3prPxsa7H6CSyDPm7As5lYVwuw5zHbOOMfNZdsCmmkQrU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fIowiVSkFI+KS1jmEkRAE7lnvHllXDsqD2vrp4hrERSGhi4sdrm5W+UwW5Cc?=
 =?us-ascii?Q?J0l7nyOAw/w68K4kesFfkIgJjkaRDBLI4RbXBSt5PJb28cGRo3ADX/QDHrs/?=
 =?us-ascii?Q?os938bb+QZh05rQZznKaqd2p3yUILUjJq67vyTyE9OhuRyG3Zge02Jx4evpD?=
 =?us-ascii?Q?wM8fmrBAhd2SXQQE4taZVSRW6yHkIuslpcS/RLSm0TzpU9HTbYnxvmt3VluG?=
 =?us-ascii?Q?UyrrFwGEHq0wnB2i5/+lO1LB3DBT/V+BEOkIwtK6Cj1JxMD1xrSJ4NjrlHMK?=
 =?us-ascii?Q?8pfAvDLXiofBq3k6e4RWjqVRXIJQls3wWQplVnjzCPgu5nB291YbSIyKtGr/?=
 =?us-ascii?Q?DM2jc3BuRmNoJfZQwPWpwz+vG10plWRykvSCwV93WtfJk+hMdHsldMMtGS1G?=
 =?us-ascii?Q?HwVk5n/XDCkW417uF0cudGgGPw8IBQkEgxbhtf+68X7JmE77uDs53RO/4flU?=
 =?us-ascii?Q?MbNgwK9PO+UtQtivvU4L6WUbl0Y4vlistdfYNSnRkOvIjb664B4+9U5Ew/8h?=
 =?us-ascii?Q?sFGHpNucSbUdScDMOcMnr+H9wA32tXahJh/WhmGSpDLmF7kXmzXeHYV2ypB4?=
 =?us-ascii?Q?8oXqp2UtdrTMrwDI8MkmQT1tM0kIbaEoQ1M1xCTGUX/D0hXBt599hTrSBOBQ?=
 =?us-ascii?Q?Z9XFUkwM7M2VK3aOzxZc5PGG044nZAjtFsn7/P63XNZQE6ne3U50jpt7rrjY?=
 =?us-ascii?Q?9h8ov5w9c9qtEGDBmZvlxg+GYEmLa750sAwoLjMqvWqxEBWYltMHHypTbc1C?=
 =?us-ascii?Q?vqNQrJlhLOd5VIdttHsqHTgfBvsWw/Srf8GfvDEaBH+IqQwkM7dfOftVrtiX?=
 =?us-ascii?Q?Gi00TrsaaI6k+PFCIqQxcKxzIaU00J2RIMs7fZPP/aDYNWz8AQoDYkUUYPzs?=
 =?us-ascii?Q?daDATXBCT8M1XiC6yLQNcly03dl/PfNM5ooAxHHG79m4Z1aq1xoTBdP3sVxX?=
 =?us-ascii?Q?nKmW9TMSQ5KHLJWKbzEezsfIKtQAKy+whpyPr/Z7U5i4qDDtE5fSv59Ou2rr?=
 =?us-ascii?Q?hhE208//fLDD5R6GbUJlHTEl8WAR0Plt7oAD5OX+huuRaEq0OcqDj2PB5qyF?=
 =?us-ascii?Q?+TEMgYbMuY9qp8VYKuWaO/1DkXHz7kGqkCzbdXyB1NKRn+tlPejM6A/sWHCe?=
 =?us-ascii?Q?cyRQep+ZouotOdNAcQWTQV0eAgEPXMcwQ5pWAx39DuYgyaZfmYnRny0lUVUS?=
 =?us-ascii?Q?wFaI+rWNLD1AevR2TF/iFaqtSbAebpdzATexWJZbzPycFLNB+ua6s7mP08ys?=
 =?us-ascii?Q?lGz9Fxl3Bzpn/I9Sh9dPocWXaOCECK7TpwzeBEVt5afUjUKDoIFL3l5InmA9?=
 =?us-ascii?Q?+QuS50eJtmn+kRS5Ewgai1Uum7s7U9Jk3ZHALURtzz5cGBMAW7rebuoHbpKF?=
 =?us-ascii?Q?UoPwq2Vlr9eKBnnMcjzG0+Hxxvplls7MnurSDoweriL/MH4Y7W6IvijlFrhK?=
 =?us-ascii?Q?sIbcaAdMi/CApiuqZe45WjGDmV7LUI9hqosoFfnt0si504oFL4uQXsMWmJwX?=
 =?us-ascii?Q?3Qm6TpTXGvTBPvhPfT/M/wAu6mpCeojn/l8WKJXswUMdrLrsmlJVQa+IT7Uo?=
 =?us-ascii?Q?3JdXmT92aQdS8umVKXsjYyF/xlv7rXpAzugzR24X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f8cefb-d9e3-4ed7-8816-08dc5e10722e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 12:26:30.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeHrdNRRQf1KiYXEziGPzGZBW0jHhKh9b1zthbtLEMTr4CE4qVv5C4kAP/CK8vETpObkQKbvYGUlf+06iYhM0l9mJmQFo5d4pNAxgpcMmHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6842

> We think either (1) gsm_dlci_alloc() should hold a lock(mutex) and do=20
> internal check about whether gsm->dlci[addr] is NUll or not, OR
> (2) all callers of gsm_dlci_alloc() should hold gsm->mutex and check=20
> whether gsm->dlci[addr] is NUll or not (like gsmtty_install()).
>=20
> Could you check this? If it makes sense, we will write a patch=20
> following one of the suggestions.

We are currently dealing with multiple race conditions in the n_gsm. Not
only for the syzkaller reports but in recent exploits for example, too.
I believe we need an overall concept/solution for these.

Currently, the following actors can race:
- ioctl (e.g. resetting the mux or one of its DLCIs)
- ldisc callbacks (e.g. receiving SABM or DISC in gsm_queue())
- tty callbacks (e.g. gsmtty_hangup())
- internal write task (gsmld_write_task())
- internal timers (e.g. gsm_control_keep_alive())
- driver removal

Each with another and ioctl's from multiple threads.

Guarding these is not trivial for the following reasons:
- execution context may not allow sleep (timers, write task, tty callbacks?=
)
- creating an atomic section may conflict inner sleeps (e.g. ioctl)
- dead-locking needs to be considered
- locking may introduce high performance bottlenecks

Still, not guarding one of the racing actors does not appears to be
possible as I see it.

Unfortunately, for the same reason the sleep while atomic issue when using
a console on a virtual tty has not been fixed yet, I have no solution at
hand. We are dealing with a quite complex situation here.

Nevertheless, creating many small patches here and there should not be our
solution for obvious reasons. This does not give a complete solution and
makes it harder to find the remaining corner cases.

I can assist to find a solution here, but I have not enough time to do this
alone at the moment.

Best regards,
Daniel Starke

