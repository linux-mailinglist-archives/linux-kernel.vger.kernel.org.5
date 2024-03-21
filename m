Return-Path: <linux-kernel+bounces-109588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBDB881B29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E821F23F55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355F16439;
	Thu, 21 Mar 2024 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E5hicQ1p"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F125CB5;
	Thu, 21 Mar 2024 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987270; cv=fail; b=DugnV0GVfWP8Hsm3Fc38sn1cHB9d5sqkQc86Lsd4CWvudFu8CmYblS9rt8bd3M0JpSboUma+jbW86Oj79tuTqY1YF4zQVUne21CGvK7CEA5I+ZdHf1BaodnQCsuSWsn848e5WOUCTk12byJyLC6jj3TGlI+BuzzQrCSw/PsXDUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987270; c=relaxed/simple;
	bh=Pc+gtfP6kQja3AW0I4TzzyEIal4WHm1KMZo9d+/jax4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9DnAVpiZIZMHofrjobCqK4OD+8pw9Sk9c4C7zEEJeacBrIuwFqAOfOqlEUUEHgGleQNE4agUWfcsSHKVnSc+ERWyc5lEZ31hqwxDECA6R2KACYVatbR6LZoJCrSEuUt668ykJ/FyoYRongKoZ1HfZ3wlvUpmJ1sMIN0OmnGefY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E5hicQ1p; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM0hlhnEnzC1GwIywfpsMk1orr2zSTilYGB/+sms3x6oMn4XpIMjCHMvpiFz0aw99/JD6gAotnjfYT9UtkCIkri8tEMQfJjhgmKmkpCjE5j6D8TOQMcnbBfm8AcMQBGvrUL0DEajt9NxErPr40r51Bl1qaxl1AQJa/CxCasNUqnyynTgC7uZ3O1vTstnlEtu4uhfqz6mBhQUBIZEX7ytcMyV+HLTBwYix00DVa8B0p9V54CQCOoAcuz+lmttfq6Rz5vS/AxxP216UuF8UlAaPzp2AkSSrgb/e/UZYLjE8/hv9/S3e+Iwk1EexARDhrytMn4ixMpBK3SeiF9d+NO//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc+gtfP6kQja3AW0I4TzzyEIal4WHm1KMZo9d+/jax4=;
 b=A0NIcIoazSCv0zpok+/KE8TuiZhRJL0mCc1+oxeLwUWdtg6XpD8ATSFe4nmJs20KRtTJj1S5vkvKpAqHix6D7OwDg+fRgCizLW7CmsejBTns4ugtB5xikGDMMGTkTYSOrZGrY+mAfzE3AtC1rhOLvYtOLzFct8C5RNnWfi8jDEjQ7pY42wOsHC7RtC/XkDev+qQW8B1D31tObBYRI1FMu8J06TM7SWLMswgHrDAr+Lp9kYpaHl6ehlLkb4ELelSxnFfUAARdMjo65w/VJZ8fU/KWB/2YbVYX92YIGlc8wXf/FjXFoh9wA1SDS+oqW4tYzqpNdS73UCoaY4eE+raP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc+gtfP6kQja3AW0I4TzzyEIal4WHm1KMZo9d+/jax4=;
 b=E5hicQ1pcsr59pRkWCnH08+w02tuV9IMPOzi4oz3bNMMJgq+QeRjShS6DgT+gJJT9ymCqwB8Vi+bJPTLMNLqnwFW4NssNaCYVQhHLOEYo3D3qEI28LHeeh1GkWri+hKCOR8/7CrMagZA7MLQ5nBWIGSfq9YpLbGqsPmqFd/d0ng=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB8565.eurprd04.prod.outlook.com (2603:10a6:10:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 02:14:26 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 02:14:25 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>
CC: Francesco Dolcini <francesco@dolcini.it>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	rafael.beims <rafael.beims@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgASwFVyAA+7oAIAAT3UQ
Date: Thu, 21 Mar 2024 02:14:25 +0000
Message-ID:
 <PA4PR04MB96382B94DE69E53451DDB9B2D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb> <878r2fevu5.fsf@kernel.org>
 <ZftVAiArz_qu1jur@google.com>
In-Reply-To: <ZftVAiArz_qu1jur@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU2PR04MB8565:EE_
x-ms-office365-filtering-correlation-id: e0775a81-5ea2-4637-b321-08dc494ca19c
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8YehQGnrkl/+ADmI2yw6c6ARGewzsJapuBD7z/zc/xA7z40UpmQR7YSCgOpR7Nxl1lW7qZJDCh+3kWuPa6YsgskDFOYDxDujY/66zEJ78Xbmxnr3mHxCRwKaeXktN1nL2K3E1oFNjp86p5obXGfuhZLOV8+EJKogwZbv4aYloaxjmJvirXP8zKR9QUbDCZ/ApK1q+zTMLxOiPd2gm5GJa7xMp9EgMVOj2upLenaWh+FpuMssjKkRG3C9c4AAitp1hid4d3gI/oqw04qMImFwD3MzsA+Uz6RqoF0+yclL5aB9od1/NF2E6jDJRglX97FQEInQqBwiEnbzPYzZ9sU7B2GI+Knnrr41nq5H3kKX6KaQk+1MAsm1GFBVdWriILlp0EJYDJ7khSr9WYFxQsXFYUQM43/ythNLVddfIuv4vsO/EvkuUJvVdB8dHOTpQeG9Whsd8vRr4fZ55x2RyeQomJ8FzY9P/shJQ61C7fbZYvFRhYwUKs4l8TQVBrA7cSbV/tysfkju8+DfA+DmchHk9NyuuRK3fS9UJtxKtnsCG9ZgNAG3A0tmnkHsC1p6oq8uKS8M42+2x0TBRXo74Tv7DCDv7c7GPTZG+Nf/VfYwn2gRnr1FE3WRKc8bdeUUJATCRa36to3PFMb7zwQ3/05ajQrH2rXrvjyW166d1S5BSufJpcdLNJDilVcS2yUpBxq60uCTuqTp++Syy3LrHGCIzfzcr2ZGGmy+E/AU2RdaYSQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fuoUd/13PmkAcpdCcnf1N5/hX+8E7zAu6bVoGRCz0NOCeupoo3PPJ5ADCgiv?=
 =?us-ascii?Q?8RRMrLkv0WuoFQxEBCtaPsRnHVu4MHYoZYjRZ+He9I5wmpW3SwRbD/FsZDBW?=
 =?us-ascii?Q?Dlf197m6Z5W7h3wy0M+7SOpV/r8yY83HSoaOLfIHcdmW6otwWXEAUgMjtgC7?=
 =?us-ascii?Q?+y9Ubzvl6HuKTSGOwhzOrcaXblNdaVxkdjXl2RF3m8qq2UAuUZJ1ODM4VaK1?=
 =?us-ascii?Q?GG70vgQQyGZpR0aZCGU+F/O3itG6XQ6cBbmCi7LW+3SbLDMzPtpTchyEslkN?=
 =?us-ascii?Q?8fmvms34JZrjStM+g/HKvbegrmAIXTXoVvDZ7ZtGJkuCOl9olBhzNTEXkRUq?=
 =?us-ascii?Q?anx4ag/LFTPpTUY6iW+lUNE6uxt11SOEM7qWzCtiMgRV6bOcOJsyHJWLSuI/?=
 =?us-ascii?Q?bPu5/PP1VYPY3acK5n6v/pFAyTTKbKuyjaofsXEIZMPGU4mYnE5F2kK76Dw2?=
 =?us-ascii?Q?zDoHiXD+N/Qus6uO3I0MVDCR7Pc+E9ldNuAS6LRJiMGXZytO+i9dfJn4De7v?=
 =?us-ascii?Q?/Olon3fLfWrHdDu2KpFTlWYvrC+YapoDZU/1TL4NpeXlLkmeMqziUTadDcYv?=
 =?us-ascii?Q?k0Gi1nn4HsXmf8B5OblMiFXqjvao/C/giOKaiDYjZSDNibt/BaVKf89TO9HS?=
 =?us-ascii?Q?aY8iYmjl1G+DcmmsbqPgg6qTg1sWPlmno2ohoy6wCll5NUzCIpGAfrAjbgsG?=
 =?us-ascii?Q?/O4x6Y9ZHNXgOL+FsS51tmolJ3mizPgLQJFrFLIKgsbn2nK0FzjrNinmKDaW?=
 =?us-ascii?Q?as8/l6EptiisT99S1CHCzb9I5t/KCqDy5vQ531VBix6Mi75o8aHtDltQUtEf?=
 =?us-ascii?Q?yCqTYLLjqVrsEkBeW1t55VtHF6nfr+++K09NYNiNoqZM1kUa4XJkS4xFUFgP?=
 =?us-ascii?Q?Fs/eF8DGU+aGJEiQtzbo1mJIzp5n24yQaccmbEUMDhEEj0SziuJf7alWqov7?=
 =?us-ascii?Q?6rNUb3X8a6t8wcf8sl6F04bBUHtuGoMEZFORmTZR6FLsibcRNQTMcyUa38/N?=
 =?us-ascii?Q?hCXcWs6g86huF+71uJIOxFh9RcgczGpRRrVf3KYqtGDeQ0aAD2OzEGx5FqY4?=
 =?us-ascii?Q?Mn26LDfhgi9x1Iq3L9qYnKtLJ7qVTPBfi4VmoMk7xfj+IuwwYiUuCdsBRcWv?=
 =?us-ascii?Q?FdkJCUKd5TsEB0fgXfLKuXvKlGZAjKVKMwtjcGjQ09Zkt0qxAc96F98Zmila?=
 =?us-ascii?Q?U9/Z73TQYPPxgKQJAytlMtCLmdOlJqCuhwnzqQ5ijb5XRQ09zpm/fSD4nk6b?=
 =?us-ascii?Q?a5ck7J6LJ1/291n7KAB45UyTN+OMnBltFQfJqTOEQ7FOtKFRY4oyn6SjMv85?=
 =?us-ascii?Q?Umj0a43uO1IIRPZbflz1Q7Pr8s1TnOkUc/g11imHj1MUTKwb82ZEVxv+wpab?=
 =?us-ascii?Q?ZYeP0+84X1yHdl4GXeITKy1BiWZ4MdypJNCFzbAm98iBmhjHI8bw6rZw/owX?=
 =?us-ascii?Q?ISX1R0Qv5vFwBNLNplcRS2Xr0gy6BKl+aRsS2Q6Y4ESYClIgSzlySJAGhUGo?=
 =?us-ascii?Q?UXc/v29msEVFx5g4u4nUoZqyKgrLchZFjek6v3rC59X02C4VTsIBKNYZG04p?=
 =?us-ascii?Q?LbR12lC7bMiteEuzxYTMoDrucwIPbNrmeublwKuq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0775a81-5ea2-4637-b321-08dc494ca19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 02:14:25.7386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye6YcsMvDyg3USKOFMBPoJtqWt9Sk9E57rcNWUjwwbgsbA0hUrqXvqf9Y+1HWdjD0oSXvE1abQzwpSa10moO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8565

> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, March 21, 2024 5:29 AM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; David Lin <yu-hao.lin@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; rafael.beims <rafael.beims@toradex.com>;
> Francesco Dolcini <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host=
 mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Mar 18, 2024 at 11:24:34AM +0200, Kalle Valo wrote:
> > Francesco Dolcini <francesco@dolcini.it> writes:
> >
> > > Hello Brian (and Kalle),
> > >
> > > On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> > >> This series add host based MLME support to the mwifiex driver, this
> > >> enables WPA3 support in both client and AP mode.
> > >
> > > What's your plan for this series? I know you raised some concern
> > > when this started months ago and I'd love to know if there is
> > > something that would need to be addressed to move forward here.
> >
> > Based on the history of this patchset I am a bit concerned if these
> > patches break existing setups. I'm sure Brian will look at that in
> > detail but more test results from different setups we have the better.
>=20
> It looks like the latest patches generally avoid touching behavior for de=
vices
> without this feature-set. And I've given it a bit of a whirl myself, alth=
ough I have
> a pretty blind eye to AP-mode as my systems tend to be clients.
>=20
> Yes, testing is always a concern for invasive changes, but I think we're =
in OK
> shape at least w.r.t. regressing existing setups. Or, I won't provide an =
Acked-by
> until I'm happy.
>=20
> Brian

No matter with or without host mlme, this patch is tested by NXP QA, Rafael=
, Francesco and myself.

Thanks,
David

