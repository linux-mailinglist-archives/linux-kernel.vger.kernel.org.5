Return-Path: <linux-kernel+bounces-157928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C188B18C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EB8B24EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1E11721;
	Thu, 25 Apr 2024 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IvOG/M18"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12BFBF0;
	Thu, 25 Apr 2024 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011000; cv=fail; b=N6ZZ5FZdcJjnfHqMJH5O6LEJKT9vUuinXJWvqau9POZvwAV2q3IyECTAlvtoPk9LnPSyBPhZ1u+1Nk7CqWkBUTO455T03qIK8pxzaj3dE5lvcOHVjcbQT5PqefYjXKT0Z0B03Mu7Q2VwYEq1honWcrXqPFRl1ilgANIG59MElC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011000; c=relaxed/simple;
	bh=7VEhY9BRveyuBkoWGsz4b0iAE3NXfMOJZQwFTmgDpMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=byAuUwQ1athHKVJIPLucJt0W+7ueYsecUFDu2qCE5UzFP97uq0pkxjERVe1fEOWGexNkSOjey88C8T3zN91YFoG6U047JJQaIbLb/yxhnIreqXLvWbVigermXZGdj7N332Ws9O+fkBcKzdBE12qHzG1ie/FnS7kzuYeVe4BM5mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IvOG/M18; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewf5PXL8mm5K8Pxbl2DBVHCi9Dhq/VxG9Lm9MO6QtT+wSDQvHaWsWVnDlVZthwsfG9BybXM0JDCXIvHdn7DriX88aC9vTimYzVMnOyiVje6KnKd5y8BKGOOomxee++ycrOS5f8n0tq6KB3vekNrEgG9huZ5t1zgp806OSseUSkDlD07mtdump6E1Ah6/HnqmaH7BcEX3eHYsIs1pUPEe7Nav3OAmdIEp8wkI9HreUHKl1LO5AIxHLOilrqMEstmZb997NYzF0h5/IXmrCxqh9l710AvJ6qTf0TD6ziZ7AjKOIn/17/fEQ7ken56s5C4LJUcU/j1qxUGzgENWtk1USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VEhY9BRveyuBkoWGsz4b0iAE3NXfMOJZQwFTmgDpMI=;
 b=gqejPP4l7C5IYt7A1DqZDxCHUrG/ywbBW6r4wkzHf9VXE1Ib+a2VE/4PqOk9j7IftLx1ms2rMNjS3RInEGmFWMkSY3sGFenEKzabSoGWuuiKefJO8K/h+lV2cLN3QDp8OLsgIwL9oKAj1oig+p6fgDvQQan9pEk2ypyPXuc601FCSuEqMA8gf3kE0bkay9FZMc0UTrSmraR+e92a24fQLjA46Cx5hc81XbB4morXZxwg6fnw23BlVf2eJT7tTi65M+j9LZQGXax/MUeBrPL7YsBQD0yZeU0jIC7q5297NfsABmKoEDkjbqUVEM+1d2PI/676VsbXKf7o4yPbyUIRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VEhY9BRveyuBkoWGsz4b0iAE3NXfMOJZQwFTmgDpMI=;
 b=IvOG/M18fLkl+pUYJCl4q5Hae+9jYaDbU9uOz1g2UIbIiOM9LZBQAemfj8eHjtp9YTqbDUiVLaHbPbBLsI8HxNOXK63WplnpYLi6Y8AXfj5waffLo0HSBdmVY9BJx20NU235CcZdow/vi8XN2io9Wa9dHfcQz+vZSkPhkBBwREM=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 02:09:52 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 02:09:52 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kalle
 Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+PhwgAEpDwCAA9ThQIAEUQKw
Date: Thu, 25 Apr 2024 02:09:52 +0000
Message-ID:
 <PA4PR04MB963851B236BFB174CD5FF88FD1172@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7647:EE_
x-ms-office365-filtering-correlation-id: d4e1bc22-404f-4548-9161-08dc64cccb07
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P0Cl57PuzO208IBa4LcIjOT/YgP5Hv4f3Dl+nUZpFm+dsYZN1H5Gdl0jfNCJ?=
 =?us-ascii?Q?5dB9xCoSY5eOsEx3ssaVj/iW/qGkzDUsvZwVYl78YQdH6ly8j4rNuSRJEo8S?=
 =?us-ascii?Q?c60xrJ6ckBGv73NfGlfenSxqn6NBdJE+9opmpZVZ2ZeP7C9NbxlmOTJup6zh?=
 =?us-ascii?Q?7/uAXspdjiZ7gZccbMyyI+mO1QQdZEzdVQw/pFfP1oM4kz0ua+hpp4ljRB4/?=
 =?us-ascii?Q?7CtHsHywU6ejkNdLFTzYf9nagdU2tq7g0Y5IcerjFRto+NdvO+5pmG5mC7Hy?=
 =?us-ascii?Q?EOSMcC8MGCO7QQESo5Lqx2BkOsQbnpryFi0aNUd6N2kyY+w2GIxC8mAO8Czv?=
 =?us-ascii?Q?uny6nlTc5wzEzgCHr+upaOYgYpaZI4xqo7u4+vj3YWGvY3R6lgTgyDeVP0eL?=
 =?us-ascii?Q?itTFqMVLIq/6lVNnefDkQgoaW7oIU7zZfw4wPO0vpUGAKJd8Ne9eY9L/AVyD?=
 =?us-ascii?Q?HdWR4hjxvCr9Bop2ii+Yteupe6c5+CL6zgtJx8zTD74kkjwK/+whdMR0bnaY?=
 =?us-ascii?Q?7hfTrFmvcJyZbmuCSGAUPIKzaIhzTqdC+kbhX9tQx8mb0hWx7HMv2ppy2zws?=
 =?us-ascii?Q?yTDcYRDURPI3aqrAB1KziA3jdhEkQu3f3Vc9PvaHDyabw7mURUclUxmK0faG?=
 =?us-ascii?Q?UlOpm32KoKi9L/Ib3NpyadFjC4Q4CRuxywUBze6FPxKl5/soQQ1xuJG+qAz4?=
 =?us-ascii?Q?KsZ5JjNlubU9ob/cIRrZJvz1Ky8cj3CYtvFZw83EdyFUCNNvYDS3VhOCa2ed?=
 =?us-ascii?Q?tynPWEZ3VwovxxUIFIrDwKnFcfgsH+oKEIX7NGrnnlyf9hl6gox6kxWPBR3M?=
 =?us-ascii?Q?fxJCKQCN7BfVSFW3MrA7w9LxojmTdrvq6Q/7FEW0QNSsgSajvjmiBLUoR1tb?=
 =?us-ascii?Q?3YMvmU6h17HMRNIZfkBPuXQUI1QV/QHerGAIq4siKzG3GBkyX7MaRGKVzbLH?=
 =?us-ascii?Q?wjYKVH8i4sQbMK4ni+5jVfxO7X+7ShypiuXctbB9jhnnhJTOxK7BnZ0ICQto?=
 =?us-ascii?Q?pD3bxpiyT3e1TJPwXNHq4l0au98UoSTixpDG9+XOlHULFfV2l+iBKak6/073?=
 =?us-ascii?Q?jmgQhQ5006WNyL87LimpcxORjKziqVC+wNqAeofdCwIMxbFJ/sreX1L7YUug?=
 =?us-ascii?Q?jIHZTMoQJYsMFiNbDCY4iaAZi5cPEbRWbkNBMFfqxADvlNKGE88vwmRLUpwL?=
 =?us-ascii?Q?IDzCB8IRPiXGtfgRUnnVl33Hi/TmzYo1WEb6QYFG9VsWgj5qDp6K9YZDqxgC?=
 =?us-ascii?Q?aCgCYp6EjzBChlhVKPWI+40RV6pS8Si25L71wrzkv2ThfvBeiVJsz1480MYj?=
 =?us-ascii?Q?pg8WYNDspvyW/fJMqLbPJ8oqk73vpmVTOvw8KnIG2c8guA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eORZRyuRxsWTFodhtzVu8R+LdoIaB6M+bMnG56e5/Bb+Pg+x/LFwwYzkaCpy?=
 =?us-ascii?Q?yxYmG/SoRQbWE4GzMM5t/QQBrDfGJgYUnNBaSpFK3lyh16X1gO/LLRzfDpRE?=
 =?us-ascii?Q?EKjbur7qfHFKWQMYYB1LwB9RRZYyMWDhDUZs4f12qemlWMyvDYAS+V3yiNmw?=
 =?us-ascii?Q?3la4L5D9ADzkwUMI1htd1iOcuGmmcqnfCt4OliGHxxlywmijKTdZd+5NxbCQ?=
 =?us-ascii?Q?WLVb2eF4vN7EEb6U+2AtWrc3NIi9up/lePRYWVZvuXHsv7vXLb6zL8xDJlGd?=
 =?us-ascii?Q?Guy6R4fd7b5qVqU4hmkIcgcbkMuooc+SSUCHiWC7SRrKFAQhJyRFleN31+35?=
 =?us-ascii?Q?dKbx07BhOh5f7GdD8pOLZCVWWU+XE/10ldWB25AFwPt0JvxJLS+DZOBtb/iU?=
 =?us-ascii?Q?WSUoQ5xC/cAZIyQZyNUIWzdTpVfXsrLmQ5QyaxrZR8yVGzS9uKllNsGV98hk?=
 =?us-ascii?Q?oM87exDaA3WEdmuEXFdHpu2gyrZsSHZe2KoOlEd4NYnmTRH6iS7MoJXFFi37?=
 =?us-ascii?Q?/N+RK4ThS4I84Y2Eg0b63UCqUPxegwK8DUnPE5rnZAd8/yW7V0h61ipWEb86?=
 =?us-ascii?Q?6XlxQ5TAjsW5M+CqwyPL4PQqjeJk+DKOwfvJScslSeVY3U4JW+axuv0pXcEf?=
 =?us-ascii?Q?6s3kJgZVOXR6yFZFrcuCZKd1Tfj1A6IN3CwPfrYDEtTsBmAtrtcyntSALw+3?=
 =?us-ascii?Q?DjNpTQ0pwCnDpOHfJr6iM3k1WzxFutJVDwMkowpwKRg8lhItzjHrIOr7l3SM?=
 =?us-ascii?Q?2vUx4OA84HkctR0DLmROP43zMkmOFZdSfOVxOj2BxsR/YioUC+B6UGg4Y4p0?=
 =?us-ascii?Q?5aj2fv2S9t/9ePF75SiH5UO3sGrQ5KZxU391i+UYZBN6VGRGBByvDvcQBxZf?=
 =?us-ascii?Q?wPkw3q78j3WDdIosGaJ4asziVel0XM7Gsiwy3+Ag7VKUUvWdh2Mi2s/77Cys?=
 =?us-ascii?Q?UmsTwvc7L30dyPtVXPvDGxrMMOpeBOMNfInSxB21RqqMT+Pn2Vz4Nnv2hYzr?=
 =?us-ascii?Q?aCX0tfCDa16fKEFj1D24gnLPDlpWKnWsgLSCefY4QMuTrbvFKU8aRABxGM6b?=
 =?us-ascii?Q?2PQQuaPnzxR22l9c9rIh0opV6dV5JlBhDAHrsDq8XG/uuhXWPplY8AfgE5AB?=
 =?us-ascii?Q?dhuxo5zSRF37J3azYCRGctoORcIJCIb+9w8q4oIIWdBdHxDPC9x/ElROikuI?=
 =?us-ascii?Q?n3lgLsSGaRRLQFfKc8DS0+uAetbUCWMBibCxzusdEyFpS7220IjzVWAoUwY4?=
 =?us-ascii?Q?CqVnRnPcgsdlQg8fOoWv7p+A6feROUO1bekRuKVin3zkQrF/jHl3+OmHmZ6k?=
 =?us-ascii?Q?miGqp1s6YtzQV4ru+iWhw4skIP4RMzlmUetxX+IxMlxMyOcirWzm3tB4EdhW?=
 =?us-ascii?Q?4udGIUcF43xKlcs6f4frxqduYLsCZ9aDFk1DJDTm49kiEFUKR4ZfxXdTc1f+?=
 =?us-ascii?Q?H05BdEiMepfoDvaAy9FW5f1PkF8GRxz8P6jUUAaXZJSamBZRPs3p3xPCxnfF?=
 =?us-ascii?Q?dzgfOo2I0cfRMOktcPNMUJyDfPYPKVEO592S3LcqlkrwuA9K/p2K1Ey+XJgX?=
 =?us-ascii?Q?QTK8zJI5hxy4V4ZrLTTi4A0cqjGnsZrbP+sJn3Yy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e1bc22-404f-4548-9161-08dc64cccb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 02:09:52.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiSmdZ1fmYGXlaSq+o554I3RE3e5XlR1gEvsTTNQ9zZYuu0dywcbLApVQv+s+gefRIkGd8SVNFUUH4tONjDe5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647

> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Monday, April 22, 2024 4:35 PM
> To: Brian Norris <briannorris@chromium.org>
> Cc: Marcel Holtmann <marcel@holtmann.org>; linux-wireless@vger.kernel.org=
;
> LKML <linux-kernel@vger.kernel.org>; Kalle Valo <kvalo@kernel.org>;
> francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>; rafael.beim=
s
> <rafael.beims@toradex.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support hos=
t
> mlme=20
>=20
> > From: Brian Norris <briannorris@chromium.org>
> > Sent: Saturday, April 20, 2024 5:42 AM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>;
> > linux-wireless@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>;
> > Kalle Valo <kvalo@kernel.org>; francesco@dolcini.it; Pete Hsieh
> > <tsung-hsien.hsieh@nxp.com>; rafael.beims <rafael.beims@toradex.com>;
> > Francesco Dolcini <francesco.dolcini@toradex.com>
> > Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support
> > host mlme
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Fri, Apr 19, 2024 at 04:00:17AM +0000, David Lin wrote:
> > > Can you let me know what does "external_auth" mean?
> >
> > Look around for NL80211_CMD_EXTERNAL_AUTH. It's in nl80211.h with
> > plenty of comments. (And also cfg80211_ops::cfg80211_ops,
> > cfg80211_external_auth_request, ...)
> >
> > I've never looked at this interface before, personally. It seems to
> > rely on cfg80211_ops::mgmt_tx support too; that seems to exist in
> > mwifiex, although I have no clue the quality of support there.
> >
> > Brian
>=20
> Thanks for your information. If "external_auth" means only offloading SAE
> authentication to SME of wpa_supplicant and hostapd (driver should hook
> cfg80211_ops. external_auth() to achieve this kind of offloading).
> Then it is not the same as the job done by this patch.
> This patch fully leverages SME of wpa_supplicant and hostapd.
>=20
> David

Should I give more detail information about this question? BTW, if there ar=
e other blocked items to let this patch be accepted,
please let me know. Thanks for your help.

David


