Return-Path: <linux-kernel+bounces-152989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABBA8AC729
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F04E1C21690
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9452F9B;
	Mon, 22 Apr 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BU7ihPvr"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB479481C2;
	Mon, 22 Apr 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774877; cv=fail; b=F3uTTKgqIkIGTnlfWLCISHyrnAGd8NDyCu46ll3nEJMroEfqg9jgIk8LZBvsGrPK/M5tsR86UAPk/7vbRv8igtO2u3yTgehYsnIF2VwhhFH9RCWiDw80q7CIGGSdRywJGsS7otX6bN6Nkre8y6HxiGx82g/hXXhTDuC1tSYmjsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774877; c=relaxed/simple;
	bh=jwW5xUOW4sSADJvMwGl1SmwrQ6jX6ujgXBCvm74iufw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gOhRXw0mTSoiVcGOTDnvn97egwFwVp/lcxpt3IibXMBXHHfJrNMhxhZoFHDvn2wtVG9abZwJoDnj2euNyeL2wb5Et9JwbYyLXrLIEqcZ9Og18zvdnTVbINyWT+L9q3qreE2X2zbkrPZ9PFhY3ZZsu4wjmcIWzO6JcV3q7aOYa64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BU7ihPvr; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvkCXQzNGVhMZhl4y3wH5Si2lpUo9gLpUBq3sItnMLhPrSlx7gmB6YHFOq6I1YJ/WMmZvslyind6QAFdnFNfzraprPN5M2iZKj+B7tUKMFWw2sfMuthM42knlxz4I66CUh+B50yxFXapf8fJruByexWEVjxIWwpYiIMY32GE959JpYfy4cEiUY1GuUIX55QDIio+JI2hA0f5fZ/RgSLR1JJlQkNX/+qCxKtYDtjeFS1nlomblyjHc14jtd2UyemvRSbUF+EjgL1MzACR35IXAHm07dYXrNZj8prpkIQbGkZJ8xfIL440122yfb8D0HtbXnGbupWxTw5fp90vn0ZFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwW5xUOW4sSADJvMwGl1SmwrQ6jX6ujgXBCvm74iufw=;
 b=kxs2R1s94LYbEhlVwzoTA2ob6lO7PpgfTZGBflVnLjIk6kxVikaP5uRu0AHxHMQqmo+K2+wT3bVrOw2DKKrtxCW4AyIjPDXoVWSic1BdhWm4JrBEzQKndiWIpHvalBu8eElTB9Y+jYlk7p0NgfzLMl7VQZrVZiMICa4fFam2malysMLVsb60KgjjTwVu5ZADRi0QuIM9xrv710uwnXK59WOI8VTqQgvKWxSLLTPpe87xkRXh2GHmUejBZbCz7FOycqA46aI8ohSudPLYmEI5iOBlFSXoPR/I2IEdYCDsYh6dz8d61PNDIfkB4+zrEogSfmZ/UZaQYixtmyX2daDirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwW5xUOW4sSADJvMwGl1SmwrQ6jX6ujgXBCvm74iufw=;
 b=BU7ihPvrQJ3bCpVxLxnis8q2tyjhwrmsdf8PDFkqnnwYwbESQoiJsVe16MnbmZbVsl37V2tZ42ceKRFp1s3SLzqa7U74EDM37ym5jv/4S5LMjvo2lBeqaErsNM+ghGMgccQIKnJaTvl8W9nqFLtUVNLug8SMxrgtHRoFVMmDMTc=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 08:34:32 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 08:34:32 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kalle
 Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+PhwgAEpDwCAA9ThQA==
Date: Mon, 22 Apr 2024 08:34:32 +0000
Message-ID:
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
In-Reply-To: <ZiLlPOvKlfCySZwF@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM0PR04MB6851:EE_
x-ms-office365-filtering-correlation-id: 2d84d209-2e56-448d-2d2d-08dc62a7089f
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mgSwrMvTTT7bSjvJFt3J4CKCRDjExKQTPakUZE8IRaWRDua2V2FxT99k0XRL?=
 =?us-ascii?Q?tyP+dallIkWq9ivlA1vpROw2L72IWyPRuf8hTsz0MjSaFSkBu5Fqr+5mT5C6?=
 =?us-ascii?Q?M9eXlBp7TVTHB6W38goAZvI7yjZS1qBWKqOcrD3v60M1XxubVE2y7UdSt3t6?=
 =?us-ascii?Q?3sWMZKQEKRN0Tn+slp4dUroLGMxTh57a7KYfL95Nt0aRudVygeig3X0sn3t3?=
 =?us-ascii?Q?OltiUDveuYNwos52NfLKSxi2k97nev/5z5ksKkW8xN4KGfdhGSydilZVAXWt?=
 =?us-ascii?Q?kZKJxadnefxBJnWFeVDsXFl6bqQIQU6O85+8HqHDS8Sq6q7pTeuDuGJxIp8b?=
 =?us-ascii?Q?5RRAGYScVxqCyiJI2wktNP3cHmFKH7G0Fk6JuqD7NoqeuMmkBH0i7ZJlzDHb?=
 =?us-ascii?Q?LSfh6V7qwWWZEvywVfej1L/ozR0C+VCB152Xz9mNX5b0J7Er6Kyy3xMvX5Wi?=
 =?us-ascii?Q?7i/I6ww7sw9NkhBUd+cNbs0fphCmiWBr2BwE9j8Y2ndhtI5+QZ6ILzCqQ+eL?=
 =?us-ascii?Q?M14TZJ5gUUPzI3+vHDdJO6KVrLWe9o1Yt40vnfk5V1GooKXrSZPPgoN69gaA?=
 =?us-ascii?Q?S+7Oi30cmhNVG/2gKHDDroNg3SAAXCDIk+MXhR+E0Ywjn+5dRa+d0iCstng3?=
 =?us-ascii?Q?ANlkXLPbz6q/jDFvDLI/UDN8Xlbj9TmUlmoFI4ePo+k3pOcjAEGhKilp0KlS?=
 =?us-ascii?Q?rlKCJBGq+15cL8gkPEDO2tQs0XbumCx5EqwoqFqD3TJyS8DcHZUXHh07GwE2?=
 =?us-ascii?Q?AwCq96lAK0mAuFQ49hgdzo6EuGmDj/j2hfliRGz16Qsr3vIXIjGlOqjxX3nA?=
 =?us-ascii?Q?85EONDjtuVc77XbRlwYM10idj1SxQNgF219My2M5rPdomE6PYD0l4O+Qteoq?=
 =?us-ascii?Q?B30UzQ7rdnhIbw6lyF8xWn5Nx7TKxz5eocS+8ESW87GZL/YBBpBeEH9pNFUz?=
 =?us-ascii?Q?CWAHebM3WH3+hicuaLV57nxFShKsWFsWQHfJ+/mcJiYqw2JXlXv8qFKw0cQ3?=
 =?us-ascii?Q?F4QokGYcYv2MF5GgKi/MsnVbEEx1zyl5/7JK7bmEZOMudvgh73Qac7vSvDdL?=
 =?us-ascii?Q?xbJp2fSTODnM2c5X07cxdyoNAYzlG9rsqr/O7r4lxn11pqm7BGrRRbjcGukf?=
 =?us-ascii?Q?GlHMDvSJpqxb+pN0HfX9O/fyIHGemZSAu6imvzcRJz4igyiLx2gZQaxls+P2?=
 =?us-ascii?Q?ymRmRkwJN7olLg6fnfDadxu/4VNpIpkzhRhaWjfcd+O4Oleacp0z7/5wrx5u?=
 =?us-ascii?Q?GBq0ByLUBu1mASEtQItnZdSF9moKnk60BDlhA2ahH7Xx+jRnnKcXRKWcasFa?=
 =?us-ascii?Q?nEVFv8jvGCUVz7DYhutONYD00vMX3R7jsmfxyNgPX59/WQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cgq4icvdrGsDgl56/yWxk0ZX3yFiJX7GwB1xDL0UneQ98JboqomFsccPB2QS?=
 =?us-ascii?Q?GlgoifdXCIM5cKjbNEqEqI/4PTGUk4Ug3dS1Nhk/Bqe/AMNWM8Pg2LBhVtM4?=
 =?us-ascii?Q?4Gup6+g+WdBNaG24Sf1Zk0dot/juEmpOFkY96KzNfnxQ5S7MwNtE0egpHFGN?=
 =?us-ascii?Q?sDwmObvZFNVMTkMe/XRZNYsJtdSUxKWzYd14xaNFNcQawe9O89fpQbSyU90E?=
 =?us-ascii?Q?Ri8s0Pz7KQkuAloT4t8knAabFaU6eHG6GSuGMnFlmf2yePU+AnbymbxEdCH6?=
 =?us-ascii?Q?PUtSsQirPE8waFwPdtok/K4mt0UM2msFLZMS+f1VVmVYZvaT8i4FXuxrT9NS?=
 =?us-ascii?Q?egv/rtumzceqSw3VQTVCFyBj3tM+6PcVDMvWXSSUUfFJafJRVEt6YJXc/0LM?=
 =?us-ascii?Q?aLzL5x/GZja0SaBFEwvsO/hegmDfAUDW7hVI46+D0b0DvSdj0N9FdT8e/gg0?=
 =?us-ascii?Q?pDsU9CcLPt8ojCIh1kSI7i9BNwHnx++PLKnVeMAtbqWZ1/WAyMyeySMQqtjm?=
 =?us-ascii?Q?GwRQILG8MfXWV0jywt++7UPP0xxtQZO+rIgJdCr1tcb+uzy3VOaqAmu3Nuwy?=
 =?us-ascii?Q?6BBqJgg6y8Tq+dnpff7Rw+Qvxbh7OPvLvl+OTW38w3cqi7tpzkwHD0ASzUsu?=
 =?us-ascii?Q?0I4vdQfIXVg7JER51sFb/yrTB7bW2Jhd+f5jNOUQr3mNGbv3oLDswyhcphx2?=
 =?us-ascii?Q?JTfGxtAO8Zpr74B5wQJem6SABjyscPbiFIsR6pdppv5yEZGI7KRI9iek2gzU?=
 =?us-ascii?Q?7VFhl9Bq56n2/jKIEHZGbrgSplKExmX02BZeWXHqpLHAe5RT5mav7+xUMNEP?=
 =?us-ascii?Q?/MKqWblymAs9Q9cO3Q7Lw9VF9wppBKaRRHjSYy25FJGdHyDmKEbu2MZnKz+l?=
 =?us-ascii?Q?3cOx6xspvTHcUXZyjtQoir2RrBdd1hhBj58ESuFK0DNeAg7efgw/T2BiXUq7?=
 =?us-ascii?Q?6p4eZdhim+zE1+ZcyNy1VA2eFLPanP8CXPtgIk6AGgfgw0mSmi1N0lCBqOj+?=
 =?us-ascii?Q?U1Vqn8ehRPFUHkQ8O7k2XmdoaDkTAnRLMPA+yQkqjH5WziuLBF9R+2a8pPBB?=
 =?us-ascii?Q?MeyxhMpQmOAJ03FJIkFyxZsHe2x7GhBOrriRoQJFMuYMYPPBGRFI/Fdn+I3i?=
 =?us-ascii?Q?6mDZvkxRmKbATAGnbPTB0+eETbQLr83AYdehzEZL+qmsfQM4IzKwR72yqEMb?=
 =?us-ascii?Q?UrWdkXbQKhe4gqk7hmYB9TGkmx7KDomN2jfUyT7nTtBzl1JPZgfDNo/i3rQ3?=
 =?us-ascii?Q?5J7+5FRiwDsIJ9t/Wsk8qpVlcjngEpD5g0qvAxK1KNx2szlmHfJk4rigoO8z?=
 =?us-ascii?Q?KsmKcbrXbNddpL8Q99GUmNqVciE6omzN+k78VRIT5pYUAB0hUK6to55SzFzu?=
 =?us-ascii?Q?z0N0rgFKSWO2MLwtUjUCmAzNVlWLfsz5Sn1Kx2WUv0MyLkOHutTSR+cmlWAQ?=
 =?us-ascii?Q?b2gOuU9F+tF+PTR6a51CieZ3icczi6LNyZWiwB12DXgcAJe5upMgxW07OFbx?=
 =?us-ascii?Q?iLJDEG53//BHPVKWa3g19CK/v3byE3gvN8PkkKErv/oD0waMKUcqvJLsOn1z?=
 =?us-ascii?Q?l9KjZSdUQ1sOs3CbrTQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d84d209-2e56-448d-2d2d-08dc62a7089f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 08:34:32.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEA57f4jxvY46IqlG4dTPaf4VAppNaaDRQ7uBP2jtYRNsRp8wjVfS7DTJpootZ9cjXuFORHNfR3jgB/kqRpDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

> From: Brian Norris <briannorris@chromium.org>
> Sent: Saturday, April 20, 2024 5:42 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>;
> linux-wireless@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>; Kall=
e
> Valo <kvalo@kernel.org>; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; rafael.beims <rafael.beims@toradex.com>;
> Francesco Dolcini <francesco.dolcini@toradex.com>
> Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support hos=
t
> mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Apr 19, 2024 at 04:00:17AM +0000, David Lin wrote:
> > Can you let me know what does "external_auth" mean?
>=20
> Look around for NL80211_CMD_EXTERNAL_AUTH. It's in nl80211.h with
> plenty of comments. (And also cfg80211_ops::cfg80211_ops,
> cfg80211_external_auth_request, ...)
>=20
> I've never looked at this interface before, personally. It seems to rely =
on
> cfg80211_ops::mgmt_tx support too; that seems to exist in mwifiex,
> although I have no clue the quality of support there.
>=20
> Brian

Thanks for your information. If "external_auth" means only offloading SAE
authentication to SME of wpa_supplicant and hostapd (driver should hook
cfg80211_ops. external_auth() to achieve this kind of offloading).
Then it is not the same as the job done by this patch.
This patch fully leverages SME of wpa_supplicant and hostapd.

David=20

