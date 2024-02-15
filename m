Return-Path: <linux-kernel+bounces-66237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B57E8558E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE091F2643C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DF3FC2;
	Thu, 15 Feb 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZFyede4K"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693117E9;
	Thu, 15 Feb 2024 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707962865; cv=fail; b=RhUc2YQlFIdSQPMrviPOU1Dk4LZ4f8cU1M1JmGirPN4gY3nApbZgitUDxw+iQYelpu6/btHctVKkbKjl5wsaW6pWKXy0kXvJpvhw8OodazBjjCEA0Lgi54BPMaMtKOGkGa6/6b8tLw1smPIqYz9VNbHo+QdXzAOj+V+QjxY0zSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707962865; c=relaxed/simple;
	bh=1H4qA5Jdp68tC4EFQTpsnpzb80mRzHcT8eyA5x7R3uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QXVXC1w9jKeySMiZfNptBwRCuGx1KlpKzNEKzVy4epKrgaSrrLri18C2q6vKkquOU3Mm8dZMoyvibmnibHCix4G++ifkAYhqNhRNzVQUHV4NF/vk00PDGwivz4DzauZvVv+s9PoiH5NwdEoJ+uE0To65e5xNbzKUmQ+snhnefV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZFyede4K; arc=fail smtp.client-ip=40.107.6.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0NtIid0R/tPVU1kMLUYKoBy7dh5nr0JPONmSXkb0BjNmybDwDnouiwpo+vFYcWjSXpAsxuOI+6fUR/qhjMKsA+vV0Aiyxf/9wU4kJBe9GQVTlE/s0/9HlvYMpVDRMDEt1ZD8nsrUE15RKg5yKaSrJO5qC9P3+oW/5W0hBNThb0V/tOrJXcdV7EFkmNApsndXAoKhT9QeU1qdm2es8CkZpfxtpDm5OI7JOhhhCeA9BTiJTYzu98hRhzXxxIGt9Y435gSayG2Xn9jsmsw2l9F/PG5R5L6D4+pPAMK9tRwcGO3+ERhE6s8jh7EnfCBw0Te0pVtzGjel2hqf8ILjBJthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujAz05cHmjgfoOeuk98potflZJc5GBvQ1QWJyKV7N0U=;
 b=cKV7YrbQHNC+irjfARlQXvgzBcWJJtYrU20N4FJUHHezeAdiYR1LEhAc2FdjJkKzjcgWMlzPHg2AG0L4JVK105tM/4ZmiEeVYV892boqlmoWvCwF2fcOYFzIdAF2EE888ESpc+IG+v9j/oY/NYmojrou7UsV+4xlIyOrXcZfIeVRPRR+nJxTa+1ly745uaRbpm+98YYS5cmm4MERr67qhNHgRv8XODPfAqu5z44L6PBC+SWDU6bVTtcqgpFcyj2D41Tn2EkJ131A9mG7qdBrYgkVhHO9oMdvjJnZRA0B3NX5TV/snBca/+ZTbGhJq94gZdFrW7uUbNgzYh2b43VqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujAz05cHmjgfoOeuk98potflZJc5GBvQ1QWJyKV7N0U=;
 b=ZFyede4KGlv6Y6X8+xHxrA6/I3yvJc43nqI1zH+ufP+STWy8GfZUTBMbCQ/uPOz3FqJVSkPB+kfxCyOwii7+D1Vm2kQ0bS9cs7M+spZm1qqMr44s0LYZjUyNn8HDP8HYQUUvY6VGzlSfwtfVQWSukwCEFqKFrT/Vu0GFu6xWKMI=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU0PR04MB9564.eurprd04.prod.outlook.com (2603:10a6:10:316::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 02:07:39 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7270.033; Thu, 15 Feb 2024
 02:07:39 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Rafael Beims <rafael@beims.me>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHaSjEAO+HQnD/Ih0ixtnf/7VSxSLDyBCEwgA2BHICAAKZRgIAKoyig
Date: Thu, 15 Feb 2024 02:07:39 +0000
Message-ID:
 <PA4PR04MB96381141AFBE8E61B8DD94F9D14D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
 <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
In-Reply-To: <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU0PR04MB9564:EE_
x-ms-office365-filtering-correlation-id: a971062e-eef5-4f8b-cce3-08dc2dcae327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A5x6s8wN1zrd4p+W228L4jt9hDPzd5HS3NDJ9N38UK6DzGJrV6SLWmNNEhXfC79LpmbIZM38fGEgNzPZLUSxakuPZEBiVjV783bDOm5OGwxWd33Xu590YnB8JjS86+o1EnBAWxPIQK5NvGx/uzaro7TN8zMOXoB18stMf6Tc0Dnx9Eqr8wet4sk93IpLKvQ+ZhugI84f2Whaa9T/1fFE/Ut8IJCUZIcB95RT7wC7hSmRYQj1/rtFJ66XxV50IZ8F8jd00tgptaNruT+JeSHErDgXIw4RBRpbNJwVARzXGPfQW1vRZwX3W1fjxXlXH+AXuP0gcujZUL7FRJ2eti1zdqTeCnFjX//4O0l4RqzodT5Ny7RizPOP8yI1/Uwb3OxqeYveK0S8NPmNC+wDAwyQAVVH1eGy3HojKM9P8sGVNaLXaXOweoh2D3HjKw3DlY6LtO9bHt8wZBbl73X/cA5uhaLtcvFV/ht56kBBvyRsyKtEaQgYC0H2lBDbiq2L6nl963U2xCsLSmSmJNDhVuxH4mRZGmEt9OPeQ1BEfsC+oGQzJSiNrPM8WPbZa5JAVetFhvIPOI+kNtllMA7/EgFStwNGQcjuk4rIloN2HH9jcFmE6mSXZEvD+kruWoVaTjXG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(122000001)(8676002)(26005)(4326008)(38100700002)(38070700009)(8936002)(41300700001)(55016003)(86362001)(83380400001)(33656002)(5660300002)(52536014)(54906003)(66446008)(64756008)(66476007)(76116006)(2906002)(66556008)(110136005)(316002)(66946007)(478600001)(7696005)(71200400001)(6506007)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J+/+O6yymStz3xxdg+sGFB5szUgOa1DvpE10OojMDgqcUtYH9R9r9q3/nI4k?=
 =?us-ascii?Q?Yd2JatPYhm0AGstwATfF6hpeji/7tC06DvZvAo8wq1OpFoHkcVE1qxLYuzI1?=
 =?us-ascii?Q?jmji0KFnEM6dSPdNytFWDK2AMWaMCju1NrO6ikp6+kNxqSWOYj9h+GkYNeDi?=
 =?us-ascii?Q?FCdPd3x49rmGh7F1PCaE6PYT5MgIdiJ3PZ5kHc1sY60rFHfR+dRuTdalz6iS?=
 =?us-ascii?Q?znDMKAtTmM8PiIxQtgnWFcEAj/o2jRUk0W2ubHHuFtZxGT/CniAXh8h1vpuf?=
 =?us-ascii?Q?AnjHyQhrikse5Q747/M/30aw9ZeQwBq+LU+CUXO7JZyvxo1HOv8vXbK1GcJr?=
 =?us-ascii?Q?a6/VlezB46CoKDJTHTW8rqGdmrqHWKnaSPPytqmA/J0/4HzOe5IX0OXzvouB?=
 =?us-ascii?Q?kon56+C8uVVy+Kj57maJArVR8XFuP6qTiaWAP2UXKc4Pn31hZtAl0u5pmhr6?=
 =?us-ascii?Q?R1ywLRw7OTTb8TbXWBpxOPcr327P3xo1JIhtk0ra8isJ+a6AFB6lF8+hIhSg?=
 =?us-ascii?Q?SGPLDum3J1AuAeORmZloHvbSk/90H3J/ZeHHddR8FKY5ZFozSVkvOoQpED6M?=
 =?us-ascii?Q?ETZ2a2Z7k+T4jV+dx5dQmIyCRmIawiwCgFcAjD4N+iOAgVq2v4jjGCFUjJHp?=
 =?us-ascii?Q?rk3OEts1E2iZj4nAiy4cGDldMFlxV/hNZm9nuYW+0vrlcv+7o0IKU1o9b1xe?=
 =?us-ascii?Q?hcZSS7ojHNO/H/R+lL504GNrFg9gM27/wxgdfVFz4i8fMHOq0hSMUnNvWctW?=
 =?us-ascii?Q?xwQ7g6VSv/QNlsgIKzc0O3Is4lqHgylPYu2bFL3+YQXqOv6QoAS6cHEz4YO8?=
 =?us-ascii?Q?ZjfBAYSrl4tIetfyEDtwENQPCgDEqcDGflAxlvzw1+gXUWv6iN8AWPgDJ3Dx?=
 =?us-ascii?Q?K3IultupppQAs3/gw9gisvWXr4lbnEi6zOBGnafqe1XtzunR4gKK3OvE9mbn?=
 =?us-ascii?Q?po/YNPZZ8OYj3tdEwvyTfIoAiMKO9vLdwQVVKmV5erSiPZhvKKzGWYyp637s?=
 =?us-ascii?Q?f4TbZWV7fR7zdSIOPf0/eSS1i5bRgrU9rP3dNVj7FMXA5S4hfhAr6DsKDpDa?=
 =?us-ascii?Q?9JGILWIdIQrK9NLXSLHg06nbfbc/Rki9XtJsE2chT2HetW1EoBLZtleV2Uxl?=
 =?us-ascii?Q?OvvooaZPTrdh9FrmnDL8dwxywfbcBGRTWN1nZzgpaME4oY5hMaeUDrgSVSdp?=
 =?us-ascii?Q?dSSz91mWZcl3beVmEghMqhNQRanJ4YhHFl3I4kekwYm08FPStE56Ryx63/Ym?=
 =?us-ascii?Q?2+11D1d78rTGdBG8K7FnLuhzijEdwIxVVYoa/1xIosf+awK5wgmf+9ij0gMf?=
 =?us-ascii?Q?l62dsHphSrrtoWlOQAdlBLhnMUPBFbvNm9QeTq+qivNqiTOwm/WkTWxoWnrY?=
 =?us-ascii?Q?ok4GuPfT/hjX9yVN++dIX0ckC/KZoc91ASBj5tyamPoi6eloHVI7DU+a9ozA?=
 =?us-ascii?Q?Wzk9X8qiHkSV30cA9c1tQ77dGJwAbG6SMfUtS5bgWEccLQOLJ7s82oiG+mDd?=
 =?us-ascii?Q?GI2DeWsjqK37mnHupuM3sPp+T5HO2lY2fUyCfndR1IyJ8sU/yn4s0/I1A54Z?=
 =?us-ascii?Q?TTjsY8cn/vnCFS0i9ye5m7rS/q7/IRiVGAMT8CR1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a971062e-eef5-4f8b-cce3-08dc2dcae327
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 02:07:39.6929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WH4Ah8AJ5KJuZE4L3wnlZqmLgTIoxbLCdvwqhz8DWG22h8F0/qBuaiRBXbpH/CIQV3xhNd9Rfzcxs7lPB2+BLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9564

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, February 8, 2024 3:25 PM
> To: Rafael Beims <rafael@beims.me>
> Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; briannorris@chromium.org; kvalo@kernel.org;
> francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support =
host
> mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, Feb 07, 2024 at 06:30:03PM -0300, Rafael Beims wrote:
> > On 30/01/2024 04:19, David Lin wrote:
> > > > From: Rafael Beims <rafael@beims.me> On 22/12/2023 00:21, David
> > > > Lin wrote:
> > > > > This series add host based MLME support to the mwifiex driver,
> > > > > this enables WPA3 support in both client and AP mode.
> > > > > To enable WPA3, a firmware with corresponding V2 Key API support
> > > > > is required.
> > > > > The feature is currently only enabled on NXP IW416 (SD8978), and
> > > > > it was internally validated by the NXP QA team. Other NXP Wi-Fi
> > > > > chips supported in current mwifiex are not affected by this chang=
e.
>=20
> ...
>=20
> > > > > David Lin (2):
> > > > >     wifi: mwifiex: add host mlme for client mode
> > > > >     wifi: mwifiex: add host mlme for AP mode
>=20
> ...
>=20
> > > > I applied the two commits of this series on top of v6.7 but
> > > > unfortunately the AP is failing to start with the patches. I get
> > > > this output from "hostapd -d" (running on a Verdin AM62 with IW416)=
:
> > > >
> > > > nl80211: kernel reports: Match already configured
> > > > nl80211: Register frame command failed (type=3D176): ret=3D-114
> > > > (Operation already in progress)
> > > > nl80211: Register frame match - hexdump(len=3D0): [NULL]
> > > >
> > > > If I run the same hostapd on v6.7 without the patches, the AP is
> > > > started with no issues.
> > > >
> > > > Is there anything else that should be done in order to test this?
> > > >
> > > >
> > > I applied patch v8 (mbox from patch work) to Linux stable repository =
(tag
> v6.7.2).
> > > Both client and AP mode can work with and without WPA3.
> > >
> > I went back and executed the tests again. I re-applied the pach on top
> > of tag v6.7.2 to make sure we're seeing exactly the same thing.
> >
> > At first, the behavior I was seeing was exactly the same I reported bef=
ore.
> > Upon starting hostapd with our basic example configuration, it would
> > fail to start the AP with the error:
> >
> > nl80211: kernel reports: Match already configured
> > nl80211: Could not configure driver mode
> >
> > After some investigation of what could cause this error, I found out
> > that it was connman that was interfering with this somehow. After
> > killing the connman service, the AP would start correctly.
> >
> > I want to point out that this behavior is different from the unpatched
> > driver. With that one we don't need to kill connman in order to start
> > the AP with hostapd.
>=20
> Any idea what's going on in this regard? Is such a change in behavior exp=
ected?
>=20
> Francesco

When I tried to test v6.7.2+ (with patch v8) on NB + SDIO IW416, it needs t=
o issue "sudo systemctl stop NetworkManager" in order to test AP mode.

For i.MX + SDIO IW416, it needs to install following two files for client a=
nd AP mode to "/lib/systemd/network" for systemd-networkd:

<<Client mode: 80-wifi-station.network>>

[Match]
Type=3Dwlan
WLANInterfaceType=3Dstation

[Network]
DHCP=3Dyes

<<AP mode: 80-wifi-ap.network>>

[Match]
Type=3Dwlan
WLANInterfaceType=3Dap

[Network]
Address=3D192.168.100.1/24
DHCPServer=3Dyes

[DHCPServer]
PoolOffset=3D100
PoolSize=3D20

I think this is not related to driver.

David


