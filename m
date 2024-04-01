Return-Path: <linux-kernel+bounces-126460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8389384F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EC01F21339
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E15B8F7A;
	Mon,  1 Apr 2024 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tw.synaptics.com header.i=@tw.synaptics.com header.b="pqAeAYqm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2113.outbound.protection.outlook.com [40.107.223.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042848F51;
	Mon,  1 Apr 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952332; cv=fail; b=TV81ZW6p3C5D+KhfM+CyDRHiNTVlZAp/Cu7kopSwHuDl+0rS0HPCrNlWM1c3XMumNkDF1HPxLtAbLtxofisxMVhiDLIVdgxvn7Oo6xgisLJQ+fqrYDZ4asDAShQqXpx3YE/8MrSEMjVVe/qMfavOdZlzgldEHgW11WVs/NK1OOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952332; c=relaxed/simple;
	bh=fMueFQ3ukYd5ZNbdj20ZNi1fWSobiLPgSS2PurZ8CeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KyzMqWeFO5BWvDs8g0cl4Gz9jJT2fPqi/+U5g3yDdVdBV9NtTLeQTWxtTGoOwVUpjCdAd6VIB9lcBF4ovEX9+vG3PvnjtM4ksveZmt/QwRQjKdEY34kPA5jUknmaULsNW5QkEn9kWX/sphgAoJov9c8B0Lp8H+looG87n0zaDCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tw.synaptics.com; spf=pass smtp.mailfrom=tw.synaptics.com; dkim=pass (1024-bit key) header.d=tw.synaptics.com header.i=@tw.synaptics.com header.b=pqAeAYqm; arc=fail smtp.client-ip=40.107.223.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tw.synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tw.synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyEhO94JmVGPM3Y/6sqAFhGdpWJy+mqK2CRLKUlzL/nHCG3SbMkjvjvuvFzT1F4qiRvoTbCUYVMTmTu2D+RNSRhJ0s/eqPSfzOX42F2aAslB0o2p4tKIyDMsTTbVRtneRtJrTeaIQIjiNJDwKmdh3sSawsPQjgeNewr7j8hpDynxzh7BVTjTonHbSo413Lua8C7ovsLE2q0GUMLVqgx84INH5vzYdDxyDr1Yjtb2mKgRwItD09zPavxL9rZQ6qcwgUVpi0aiPWeFgjJs/fvFmMw2G4eJ2Oj0QRXLObnfbBtfHSo69XhGnsJe7L2who04BUya205GitCPozQ1UIjoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9aXyX+bJYqikQMHQdr4lGsmmsbIACKenehEp5o0BB0=;
 b=SmKkNWdp9XtYHyIF3frlsnP/K8aeaXr5cIJwYeDUSnb3v2U2eI5YSgqBYgbgXXyuDL1UpyKldljh7UU/EgY/b7L7Bj2vHipa1CihlVgYKNicUGLGIXsNJfSS+mh9uNaYm4iRz1q9IGe2qx63zn8qPc/8QWdTp2kv7fTp13QAQtHxc7MpQIIemKxr13yZxImJvs2OkGLCM+0a8Hte6PUK4z3NEEsPPehX1KeMfh9YU0ovAvJA1HBue9PwpZT4U6wOdg/lyM2IiLBZEOSWXtqQFPx72F7ttm6DfwdSw808xnuKkepRe+/a23PyvunlJcE3/TISuMnbVKxElOY0XKH5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tw.synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9aXyX+bJYqikQMHQdr4lGsmmsbIACKenehEp5o0BB0=;
 b=pqAeAYqmm/aHABjKODS1cHPBOD+WoWBgdgAWn3Pfl2vlLv44o9891V9GIGBp8slCQNWLK8lvKiWxnmscUxyWyr1SBb6Lv4L+0q9lCk1ivYu3KCaX26MrNiDH60JLJsklqPeBnASYQYiug7NgHMhbuPshojaLb0UMQ99Kk9zL5fA=
Received: from MW4PR03MB6651.namprd03.prod.outlook.com (2603:10b6:303:12e::17)
 by MN2PR03MB5343.namprd03.prod.outlook.com (2603:10b6:208:1e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 06:18:46 +0000
Received: from MW4PR03MB6651.namprd03.prod.outlook.com
 ([fe80::ea0d:c340:3e10:c59a]) by MW4PR03MB6651.namprd03.prod.outlook.com
 ([fe80::ea0d:c340:3e10:c59a%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 06:18:46 +0000
From: Marge Yang <Marge.Yang@tw.synaptics.com>
To: "friederhannenheim@riseup.net" <friederhannenheim@riseup.net>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Scott Lin <scott.lin@tw.synaptics.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Huang
	<Vincent.huang@tw.synaptics.com>
Subject: RE: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver
Thread-Topic: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver
Thread-Index: AQHagTjnr0tKQifYmUyrnsfS+tAKTbFQwOmAgAI0AdA=
Date: Mon, 1 Apr 2024 06:18:46 +0000
Message-ID:
 <MW4PR03MB66512E92870E3700B64B4F8AA33F2@MW4PR03MB6651.namprd03.prod.outlook.com>
References: <20240327214643.7055-1-friederhannenheim@riseup.net>
 <ZgWuq1bDWNRtrImD@google.com> <5dcfdc9c77b1dcd73815b8eaec8a4717@riseup.net>
In-Reply-To: <5dcfdc9c77b1dcd73815b8eaec8a4717@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG15YW5nXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYWZmODdiN2YtZWZlZi0xMWVlLTgzMzEtZjg1OTcxNDk5Y2RjXGFtZS10ZXN0XGFmZjg3YjgwLWVmZWYtMTFlZS04MzMxLWY4NTk3MTQ5OWNkY2JvZHkudHh0IiBzej0iNDAyOCIgdD0iMTMzNTY0MjU5MjM0OTExMTQ0IiBoPSJ5M25OWkE4dnNWeWt2SjAvZnhMTGRaT0l6ZnM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR03MB6651:EE_|MN2PR03MB5343:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zYKN+DoiQJcb0xDZKLCkhkn06L8hcEbCUZ++FAHdqK6vglp/4ftVqliUQzIl2k+5Gz3T6BG4KBv9SOzLuQk6k2mlco9nOdSvSFWbJmCK1DjVWYxmPvsijfWLshORkOVW0VNCHQTtggmgDQ8TcqzgCZVm3BCl/gkuetdFOjNLLrXQ3vZPkPNSiJ3vhRJdtF2UHY/VZlIqbaF8qzC78e3RyG4fBOPHpJjwUMho1HtQdHOXC0HpfqtGvRHERtkkF7Q6fQsii6pv+8br2gutohjyVpjEYMkOdDD7rM/AC9pegElPvSIzxgRXOzlgxFE8kU09Hx5cxffVPvNEMuqhl2gKDSp9gNTemxmxsgeAoMCunMc/kV1mrtdj7JVvLwNCcqW8nvNvjxhgoRD+bwr5wo2nPSGr8jQZ53YI34UaW44s0be2RL8KTeCwII0xTzQvYBwRw81uM3Hb9m4b9XiI+uUopX7fbz5yS9hOWuRN+cAhCHN3rV0Qmqkm1UNvIexdkc7e5LH3jbIUfLcogguBe0rIgBrgFvZdv0zR5P8QXv8bSFombzWbEfmg6UQdLPv/VmgQfOui97+IUoyAYlrLd/2jxPnCURLE+TgQY3lfWMTBmHE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6651.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LAfsHkq8UU8jFw+V0zqu/ZtT3hDoiX9dvmiiWkb+lAjzbubITXztaqJa/idh?=
 =?us-ascii?Q?jUygOhm3YqKLFM5Ls5+WSY7Aa1veuK9lfhAT8XS4gvQIYOwUf18KZIbok4P7?=
 =?us-ascii?Q?JfQITKiPe8POoi9rqLSn8cssz15J7kxnnuzx9cN7yJiIIZ9GMcyExQjhAVUU?=
 =?us-ascii?Q?B3QweItGtXJIyfzmMPNKDRVl4+HcKTTkLN3l3YAEA3BAgYSapYQJEYbB2Fx5?=
 =?us-ascii?Q?k5pvHQCZF86sNK1JIwUJaA3MKUzfKWnqj/SMHTIKlX6ls7Uk/gW6Q9i/FBp2?=
 =?us-ascii?Q?0QBUmbKjeSz1MgkxpeGJIBOGkNWCzNkFTM7eqFysiCLfUXmiPGD+v3hGopxv?=
 =?us-ascii?Q?Qf8ukef3xtL9pB1W0XnqLJImAGZ61A1gA4vJIA1j/YZQoGe8QDkp5OtY7RSC?=
 =?us-ascii?Q?vcd9nxd6UpufobsAp1XnEhNJbCrcTrYukX73EUH2LO40eLYsydJ5zt/z5VTK?=
 =?us-ascii?Q?mIqjLKGE3aFH5eYNMnAGxrPdGDWtgeDfGk4NwSupDlCJas9831wkVGzlXSFx?=
 =?us-ascii?Q?vCxeV5TfI+C7QQCQ4spB4uWHhdlQrOOoXYA2wo4ZZORrdOK6psMnt2Nw5Oxn?=
 =?us-ascii?Q?zk4b/FV7foUhoCULMkRf1o6h6NsK5/IJuOb7/jDmgWLLwShrRjT4t+rIsEkS?=
 =?us-ascii?Q?NIBrCUqr93pUits2oRjlctiYATsL/1HwmxGDpvIkAnkDYwCNncgSJ+e1ESUA?=
 =?us-ascii?Q?6kyZE01WYv3/rISfSNTw58iccSx05Io5bert392QfyaoqRS1CSDKgVoBOWg3?=
 =?us-ascii?Q?SpLhxP6mWcpw0i/yARzSIsHQ+ePwYQ46O0GSDMb+Uml9hBaChMz5i4htvOCk?=
 =?us-ascii?Q?fOnc8qBqKh5qyVgVGh5jEqdAtsD7BdNh7wqtlhi08xY6Cfv2VEQWpODIzLEo?=
 =?us-ascii?Q?gC6qDqlVM34O2l1MDHD0jeD5keYMDoBJ5WXQArhUT7TwzIO3BSSurq7uITmo?=
 =?us-ascii?Q?9eO0gB/BvJhfuksMaIWrlKp0cgY7fUqNqMyABIe/6GL/kN8ITHh7B4hdBPPU?=
 =?us-ascii?Q?JSfVNo6VXCUoGfRiWXa8VV3VEMAtXGAKeqPG/YVuKoi1zCaYYk0WG6kEhOql?=
 =?us-ascii?Q?U78NZSxmfR2/kDS3yE00f7aYhE+IPaF0uDNcq8hkj5alB3kTeRSRYLx4kXwT?=
 =?us-ascii?Q?IrKcVcW71Eisk7ni/8Lm5DLaH4zQ+Rxd+fdwpb0dIeG5fUxIYG/XXrnlr/Gl?=
 =?us-ascii?Q?iDKZidfpanU+6nNQaNtjUYGBc0WtFqMk6pxbKR4V+yO2Czw/20KHK7+rIEa8?=
 =?us-ascii?Q?lnZEQ44e0f2iILSKkVApyrAFucQcWIN7zd/NWK5/Ff59zkSBH4jYfzFYc/Pa?=
 =?us-ascii?Q?Mtke3NoGL1P+vFAbc9QF6WBi00gy8BalzuDUeoP1nro3c7+19yCwM2mcDoIc?=
 =?us-ascii?Q?W9pQxSBsNh3UFYjA9Z4DwSP2DqgBb5QN4kh3ltZCwAmBkUoR2N79PIrJKgtt?=
 =?us-ascii?Q?ZVtdvaOBycmK2tuB9qtHC9V3EZGXk1M6iolK4W0v9dx5Y+qJdd5XJtYERScr?=
 =?us-ascii?Q?fyWK+wjBkGvRaNzT0X1zR58s9Vqq3Srje1njWifB/5y4N7l8SZGWfdie9ggv?=
 =?us-ascii?Q?YrCXiE8u83Pm7KvkpVg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6651.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1284f5f4-c588-4e29-4859-08dc521396b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 06:18:46.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vT3adXTxsOOL/LJcVoG3SyulzTBiP2nn4OcAoLcM2o0zgo6otrWGkLnOXbl8oZ3WVrZz6a8OEXD7de6xKm0ArA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5343

Loop Scott Lin

Scott Lin is responsible for mobile products.

Thanks
Marge Yang


-----Original Message-----
From: friederhannenheim@riseup.net <friederhannenheim@riseup.net>=20
Sent: Sunday, March 31, 2024 4:35 AM
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>; linux-input@vger.kernel.org; =
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver

CAUTION: Email originated externally, do not click links or open attachment=
s unless you recognize the sender and know the content is safe.


On 2024-03-28 18:53, Dmitry Torokhov wrote:
> [ now CCing for real ]
>
> Hi Frieder,
>
> On Wed, Mar 27, 2024 at 10:39:12PM +0100, Frieder Hannenheim wrote:
>> This is a bit of a stripped down and partially reworked driver for=20
>> the synaptics_tcm_oncell touchscreen. I based my work off the driver=20
>> in the LineageOS kernel found at=20
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_Linea
>> geOS_android-5Fkernel-5Foneplus-5Fsm8250&d=3DDwICAg&c=3D7dfBJ8cXbWjhc0Bh=
I
>> mu8wVIoUFmBzj1s88r8EGyM0UY&r=3Dddk_91asmhyAjxFmXHNIQZ2mVcW0D_eq4tb4409nZ=
94&m=3D2_iuhvyQkYcT-qsozPf_h9irH_AlUtaQ020UAxVQhZ3SuHgXYihgVocHyTV-zNSV&s=
=3DFT4Hkpxkhqktmhyz4RWC9lGAD4DvNBS06wQnn4ofQkk&e=3D  branch lineage-20. The=
 code was originally written by OnePlus developers but I'm not sure how to =
credit them correctly.
>
> So the first question is: does this device not use Synaptics RMI4=20
> protocol?
>
> I am CCing Marge Yang of Synaptics who may shed some light on the kind=20
> of touch controller this is.
>
> Thanks.
Hi Dmitri,

the synaptics-s3908 uses a command based protocol whereas rmi4 is register-=
based (as far as I understand it, I haven't been able to read up on it prop=
erly since information on the internet is sparse). So I'm pretty sure that =
it can not be controlled via rmi4.

Best wishes,
Frieder

