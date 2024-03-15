Return-Path: <linux-kernel+bounces-104394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD587CD36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85F42822EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C631C68D;
	Fri, 15 Mar 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="da+gFmX0"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBE18EA8;
	Fri, 15 Mar 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505405; cv=fail; b=hK4H5tbCESny0To4OMtikjBI+fISLmutmjpDTkXoo361kLmyMK1OVVbquPuBT5GpkPpIvOs7sqXgKcImEYkP5z30E181XHvsMpd6emt5yCFw7ivndgzBZOuQC5vB7u1VdMUfvello5u/brglwpkP+02dkM65YmcmzOMaoPCwyMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505405; c=relaxed/simple;
	bh=5A8y3Gu280r/ZogjU5KKGqVdLbh86gUDA/Ec96JGmRo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNNHYfRYRTKiu7LcFwsniPIVawSid7YY7N1pZD8pp6nnu9VKgWkR4MbEeWieXDiEuMYA1Tat7cCiLXElw4Z4ScUyRLvtldPpj4byT8Ja+1JlXGyrpoF/dPoeGfBPVVU68G0c6RF4gbR1lMeJc6r+BIKlZCvO6ihqXTMVA/nlzeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=da+gFmX0; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWL4aOEcw7hIfCHPNjP8PgKEQRdL4rj0Jql6QAbAgo3gQQTDb20Qv0SgG3/3cbRLWZglwTVeV+jc9JDsmYHlPBU5YRLFK9VwR6O0Gz+drPvRzgdSKWYEFc0bhOJK43AMGmJ5UZErmn6KOXm8yQlBW+cYlIdN+4OjywmJgqmSwhz/szSw+aIYbLW5CFSIOQCaNyWaQmwM1cjXKdgmYLaEBuCdz+e/l6QwizLf5OW9TZmcDSA2Kh0XPWvebTodjLGKygbHcLjbApiLuJR04n3y/jl7/bM5sDxmr2+UGfPLi45GuddrgbEYkV1P7S/QZgmTu3sEWySd9TATmTTlmXt5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZXaC6++kB34GZhQjmk0kgCzvSQZE15IlGYMAqSuhGY=;
 b=lm9ILm0E55QbTQSYkeGiCdlcb085NmtZmiUs8B5IZg5Nj2nG7lPHUFOVAvZm8AbaQMzg6Fg0+I/JJkearTbo3YL3RkH46D7aforuwZExgVG3bAuVyc/JJG+oRx9YzaZiD/gYQ6/nVzxhlbFgBm4Ky7A/S7K2owxQB1BLdCn/Sv+MhkgL1HFoa6egJcq5Ck+Lzz6GhmYRMB+whVAs7eDAcxkgUuikZg28kPXxmb/LzuyS75soBnLYJCCGz3f/aZHDEKXk5ePoHwH2lyKEQ0+WN19fYyQN4Um0xJn4LUO9eZdR8XqyM1sDrjfIIsGx/Q0f8eVu0g2b71xmV2rpe7Up7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZXaC6++kB34GZhQjmk0kgCzvSQZE15IlGYMAqSuhGY=;
 b=da+gFmX0sr1iU3buMZK4dYXhE47gxS9NCjtshTZQ8JVpse8vzxUKbABt3RnR1oNpFDAWl2S+wwEz21kj9SkckN35f5maDTUMiXJGsA2xFURC7nbNyo11epFFBRbAu3AMLiW9Lqa6SqaNgcJ6MuOdLFN/+cyIMvhOGi17XVKF/Ik=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM8PR04MB7458.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 12:23:20 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 12:23:20 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"clin@suse.com" <clin@suse.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pierre.gondois@arm.com" <pierre.gondois@arm.com>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Gaurav Jain <gaurav.jain@nxp.com>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, Varun
 Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH v7 00/11] firmware: imx: NXP Secure-Enclave FW Driver
Thread-Topic: [PATCH v7 00/11] firmware: imx: NXP Secure-Enclave FW Driver
Thread-Index: AQHaCxfFw0Cl3dFwdUaygfBZpVb04rE5j3OQ
Date: Fri, 15 Mar 2024 12:23:20 +0000
Message-ID:
 <AM9PR04MB8604BC2E75B4A7B6BFF6BA2795282@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
In-Reply-To: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM8PR04MB7458:EE_
x-ms-office365-filtering-correlation-id: dc008eaa-4cf7-4a21-558e-08dc44eab34c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yL5SxgBDYIfMS4nH1rDy/qYw22h4z7DhTRXUGLTvv4tQsoscd0acJcErZqxm2OZNsB6p3gHS3y9TT4s26hDtvLOGeubkToBi2JF7iowb8Psac0kf2QQKUbwf4SEiL7877IRHvzXc31RVtnSfUMCe6XSMHZYClLocBQR0hO6PuaTAQS/j26ovz/AuaqJINcEbmlNjnVFZj20kkiaQITFH1DFYBtW5pUy1FmKrcq1/ayoj5ug3G0eSeCXYBsASuinpkLMvMlWJujCl9GZcwqPAziswZv4HggIjyv7zOkhteqXY14KWWZnvCfls5Fc8cs1gWqpenjON/8odoisKf1mzjRRmBZWeOUzo/djw7PY1pK0gsJElwgIrabD5nVks/MjZtBby3efrbsQD2B/cqdWnUt1vNKmhvRTpXFH91hI4Y6Bzp7+OU26wumW+2eKjJc3Fc5IMQgqsSZ4O7BmUiGurcho/eZzshecs0cLF4qC3159h3CO1XMJrCUMVOUD3zHHIRX2pjYoPxB/QveZsunHvM1w+XLprVPMZkmet8i/Tr1YP1S5BNP4mJYYta715lb59y1MVTeceK8/8PBQDzmtqg6PHcBn75dmUtG8A/pV0aLoRiYq57SN/tJev2EWtO6H8Zd9VXtfcz0t/nUYUVwW8CSvizTX1S82khuuJt/aGwON2JXOxeR5OfqKf4DqDn+U7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?81kqxKviHLYtaPVmr1kfp0KUjyFmfMaLJ+aUMTmD3s1cneYr/iEvrp4bsVdV?=
 =?us-ascii?Q?aEJ3N+OhC9pJEls1M844ynQUVPLf+9TBBXp4oP6ql3rbJeFYJp1Qoc7Uft+T?=
 =?us-ascii?Q?+zecEo9NFezW0muCn5f3V1D2U0wRdya1hggKBFiiiYIS7LyZC/Q6lkvu4RBT?=
 =?us-ascii?Q?A8bI1i1/5hXc4xnDwbcoIk7frT1o5LIvFQXB5UqE6eqFj9kRqefV6kXs1M2a?=
 =?us-ascii?Q?+z2JZALYi6P96yoDiPMciKPQgd36oMow/3XCQ/vwpB+vNIIz+PSRyTYrYvWI?=
 =?us-ascii?Q?V7OJuhpUWXNL9RjvFY2Fzm31odYESoUo53YWHp4X5Q0NgM7btR7Yb/iBS1ma?=
 =?us-ascii?Q?boVYnuAvDVfhxe9GB+3wVUyTruOxsPtmp4tGCzgsSqc74OjOXqjjxrIucCbR?=
 =?us-ascii?Q?LCh8qAAFhlgk18Uo2p2CDuP5NXdSdT1X3MqaCCKEPvNfkoI/yzKCj5rLl1c4?=
 =?us-ascii?Q?uBWg4q57tRdB1KPsCFrbsfNUH9u0O3twMLJFlG1kK7BtImRkvU/u+e3wBI7e?=
 =?us-ascii?Q?RfG2ieuO8EOeSkOaLeFFPgf3s/BA0qLxVvBXDx0azRYPXADqZI+QhIPMXuy1?=
 =?us-ascii?Q?viS0hVzcUF5u1bC0vkUXuNCjqOEDiIxKGyULZjRrLz888rHHpvXbWajcG0xg?=
 =?us-ascii?Q?b9tqk7rxv+ej34jhtQTKgkSeJRzTCSMoHbFD9ioMVDeV6LhvVxUeNOL1s97S?=
 =?us-ascii?Q?1vsFyf12x2fpDVzw+SXG9bmifXZtUIhMknWVGlq78UfpVXTzeJeWD6xz97v0?=
 =?us-ascii?Q?iRi2NmnNjcmsLCJBwcDH3CtDKUULhFMLXVrgj7vxaLud+i6fsu57dkygN7ts?=
 =?us-ascii?Q?I8v+ny+aPQpoX92l2BTCVT8ba70LvqY0/6YNDathe/aG5Hy/PgDFKypMjZWU?=
 =?us-ascii?Q?/ImoGZjPivNLsO8JZ5nq45H9+hFYuouwyZf4onKoQNbbuAKknfo3EcxPjsHh?=
 =?us-ascii?Q?yYKncoDABCl9xyF7/SWiYkMM7hVp7yWpRwc0GyNeuS0qq49HN+wH6ZTmU3Id?=
 =?us-ascii?Q?Vlvhfwrx2dkbcV9mTw6PjS3g8cE+mWQ4cl6laDw2d+O9sl4Y6IhPntluPuiI?=
 =?us-ascii?Q?QMdO+oMSarGuE/FmkLRoXVtFess8M943zpS1AbdZMbw2vlgA5cQvPQISNHmL?=
 =?us-ascii?Q?TEpGIg5TI+Eob7CeeAbvahd6MYwPHztU2tc0UweF/uxQEuD+aBvvO+lyTsGx?=
 =?us-ascii?Q?rgAjH2L5kq4G052DGwCenM6jH+uIl0ImD2WmzIowzmIKb5PjTcTVhjQEQ1a8?=
 =?us-ascii?Q?M1Rp19zvJsF+PnmeC8gfXH7pintwVrkTB8+sJ0d+vGTjPdbSennXZiflf8Yy?=
 =?us-ascii?Q?fWPrPpZwJk0gtdWvqEnigHBHzuFP4uNCQRpJc4QuwO6t+NEBoEFDLL/OEHsJ?=
 =?us-ascii?Q?2U6kEAB2X60Mc+1yUL08y+/oJS66HcLx3DSsI5UHSbj+p9GNhmRVhjNoHiFa?=
 =?us-ascii?Q?CpJnvfyHjsYcmfb4wjWH8hanQvcb/rRtYrT49utAAS8DcGdyXIjmHG+SstnG?=
 =?us-ascii?Q?c118Uxk+izqm/xb2Pf5CZ2yPCPZ3CY7BRXM1DlUZtPI/m60Yi1n9h5N0QXtX?=
 =?us-ascii?Q?iYzK6NX5GASjD+dO7HbF6Cnrvv+QeZlHOeD18tem?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc008eaa-4cf7-4a21-558e-08dc44eab34c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 12:23:20.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JMnBe3BzKvO++AmYuDON0FJCuTHMFB+OswanMjeTQCPlDB2WTCqEV8KdaPkPC8jD9fvnKm7hDWPbgfHpnGFDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7458

Hi all,

We took a step back.=20
We are doing internal review ongoing on this patch-set.

Thanks everybody helping me improving the patch series.
Thanks. Krzysztof for your guidance for the entire patch-set.

Regards
Pankaj

> -----Original Message-----
> From: Pankaj Gupta <pankaj.gupta@nxp.com>
> Sent: Monday, October 30, 2023 3:29 PM
> To: shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; clin@suse.com; conor+dt@kernel.org;
> pierre.gondois@arm.com; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Varun Sethi
> <V.Sethi@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Subject: [PATCH v7 00/11] firmware: imx: NXP Secure-Enclave FW Driver
>=20
> V7 Changes:
> - 2/11 DT Binding: Disposed off comments from .yaml
>         -- added | to preserve formating.
>         -- removed extra spaces, restricting under 80 col.
> 	-- replaced the "fsl,sram" property, with standard property "sram".
> 	-- Added details about usage of sram.
> 	-- removed the property "mu_id".
> 	-- Added allOf:if:then: for reserved memory.
> 	-- removed label.
>=20
> - 3,4,5,6/11: DTSI changes:
> 	-- removed the property "mu_id".
> 	-- rename node-name & label
>=20
> - 7/11 firmware: imx: add driver for NXP EdgeLock Enclave:
> 	-- Removed dev_err for the cases of failure in memory allocation.
>         -- For others, coverted dev_err to dev_dbg.
>         -- Updated the commit msg about the details for userspace lib
>=20
>=20
> V6 Changes:
>=20
> - 1/11 (New): Kernel doc: "Documentation/driver-
> api/firmware/other_interfaces.rst" is added.
>=20
> - 2/11 DT Binding: Disposed off comments from .yaml
> 	-- replaced the "sram-pool" property, with standard property
> "fsl,sram".
> 	-- removed the additional details from the description.
>=20
> - 3,4,5,6/11: DTSI changes:
> 	-- Validated using the following commands:
> 		--- make dt_binding_check DT_SCHEMA_FILES=3Dfreescale
>         --- make CHECK_DTBS=3Dy freescale/imx8ulp-evk.dtb;
> 		    make CHECK_DTBS=3Dy freescale/imx93-11x11-evk.dtb
>=20
> - 7/11 firmware: imx: add driver for NXP EdgeLock Enclave:
> 	-- Removed:
> 		Reported-by: kernel test robot <lkp@intel.com>
> 		Closes:https://lore.kernel.org/oe-kbuild-
> all/202304120902.bP52A56z-lkp@intel.com
> 	-- pr_info is removed.
> 	-- macro "devctx_info", "devctx_dbg" & "devctx_err" is removed.
> 	-- Updated ABI:
> 	    --- Users: user-space SE-LIB, crypto-api, imx-ocotp-ele driver , smw
> 		--- IOCTLS: Updated the ioctl
> 		--- read/write:
> 	-- Correct message header validation.
> 	   --- segregated handling of the error, while msg header parsing.
> 	-- removed TX and RX messages static allocation in state container.
> 	-- ran coccicheck: make C=3D1 CHECK=3Dscripts/coccicheck
> drivers/firmware/imx/*.* W=3D1
> 		--- ran on all the patches.
> - 8/11 firmware: imx: init-fw api exchange on imx93
> 	-- removed TX and RX messages static allocation in state container.
> 	-- moved the header file ele_fw_api.h, to driver/firmware/imx/
> 	-- segregated handling of the error, while msg header parsing.
>=20
> - 9/11 firmware: imx: enable trng
> 	-- macro "devctx_info", "devctx_dbg" & "devctx_err" is removed.
> 	-- will remove this patch, will send this patch later, including RNG and
> crypto-maintainers.
>=20
>=20
>=20
>=20
> - 10/11 firmware: imx: enclave-fw: add handling for save/restore IMEM reg=
ion
> 	-- Linux comment style fixed.
>=20
> - 10/11(old)(Removed) firmware: imx: enclave api to read-common-fuses
> 	-- This API will be used by imx-ocotp-ele.c.
> 	-- This patch can be sent later, when the changes to imx-ocotp-ele.c
> will be sent.
> 	-- "Documentation/driver-api/firmware/other_interfaces.rst" will be
> update for the exported symbols:
> 	   - read_common_fuses()
> 	   - get_se_dev()
>=20
> v5 Changes:
>   - 1/7 DT Binding: Disposed off comments from .yaml
> 	-- to use "-", instead of "_".
> 	-- to use generic name, concatinated with soc-id.
> 	-- removed mu-did.
> 	-- renamed the ele-mu to se-fw
> 	-- moved the file from .../arm/freescale/ to .../firmware/
>   - 2/7 Changed the .dtsi, as per the comments.
> 	-- removed mu-did
> 	-- renamed the ele_mu to se-fw.
> 	-- updated the compatible string.
> 	-- tested the DTB.
>   - 4/7  Changed the .dtsi, as per the comments.
> 	-- removed mu-did
> 	-- renamed the ele_mu to se-fw.
> 	-- updated the compatible string.
> 	-- tested the DTB.
>   - 6/7 Changes in driver code:
> 	-- replace pr_err with dev_err
> 	-- removed export symbols, except one, which will be used in other
> driver.
> 	-- Each API, send-recived based on device reference.
> 	-- Divided the commits into smaller commits.
> 		- Base Driver
> 			-- Added ABI file.
> 		- 7/11 (new) firmware: imx: init-fw api exchange on imx93
> 		- 8/11 (new) firmware: imx: enable trng
> 		- 9/11 (new) firmware: imx: enclave-fw: add handling for
> save/restore IMEM region
> 		- 10/11 (new) firmware: imx: enclave api to read-common-
> fuses
>=20
> v4 Changes:
> - Post internal review, changed the name from "ele-mu" to "se-fw".
> - Disposed-off comments in the dt-binding file.
> - Removed the non-hw related dt-bindings from the driver code.
> - Corrected the File MAINTAINERS for correct name of yaml file.
>=20
> v3 Changes:
> - update the commit message for documentation.
> - Fixed dt-binding checking error for file- fsl,ele_mu.yaml
> - Coverity fixes in the ele_mu.c
>=20
> v2 Changes:
> - Fixed Kernel Test Bot issues.
> - Removed ".../devicetree/bindings/mailbox/fsl,muap.txt"
>=20
> The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded secure
> enclave within the SoC boundary to enable features like
> - HSM
> - SHE
> - V2X
>=20
> Communicates via message unit with linux kernel. This driver is enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
>=20
> Driver configures multiple misc-device on the MU, for multiple user-space
> applications can communicate on single MU.
>=20
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
>=20
> Pankaj Gupta (11):
>   Documentation/firmware: added imx/se-fw to other_interfaces
>   dt-bindings: arm: fsl: add imx-se-fw binding doc
>   arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
>   arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele_fw
>     dma-range
>   arm64: dts: imx93-11x11-evk: added nxp secure enclave fw
>   arm64: dts: imx93-11x11-evk: reserved mem-ranges
>   firmware: imx: add driver for NXP EdgeLock Enclave
>   firmware: imx: init-fw api exchange on imx93
>   firmware: imx: enable trng
>   firmware: imx: enclave-fw: add handling for save/restore IMEM region
>   MAINTAINERS: Added maintainer details
>=20
>  Documentation/ABI/testing/se-cdev             |   41 +
>  .../bindings/firmware/fsl,imx-se-fw.yaml      |   83 +
>  .../driver-api/firmware/other_interfaces.rst  |   67 +
>  MAINTAINERS                                   |   10 +
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   10 +-
>  .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
>  arch/arm64/boot/dts/freescale/imx93.dtsi      |    8 +-
>  drivers/firmware/imx/Kconfig                  |   21 +
>  drivers/firmware/imx/Makefile                 |    3 +
>  drivers/firmware/imx/ele_base_msg.c           |  271 ++++
>  drivers/firmware/imx/ele_common.c             |  294 ++++
>  drivers/firmware/imx/ele_common.h             |   40 +
>  drivers/firmware/imx/ele_fw_api.c             |  118 ++
>  drivers/firmware/imx/ele_fw_api.h             |   26 +
>  drivers/firmware/imx/ele_trng.c               |   47 +
>  drivers/firmware/imx/se_fw.c                  | 1376 +++++++++++++++++
>  drivers/firmware/imx/se_fw.h                  |  154 ++
>  include/linux/firmware/imx/ele_base_msg.h     |   67 +
>  include/linux/firmware/imx/ele_mu_ioctl.h     |   74 +
>  20 files changed, 2738 insertions(+), 2 deletions(-)  create mode 100644
> Documentation/ABI/testing/se-cdev  create mode 100644
> Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
>  create mode 100644 drivers/firmware/imx/ele_base_msg.c
>  create mode 100644 drivers/firmware/imx/ele_common.c  create mode
> 100644 drivers/firmware/imx/ele_common.h  create mode 100644
> drivers/firmware/imx/ele_fw_api.c  create mode 100644
> drivers/firmware/imx/ele_fw_api.h  create mode 100644
> drivers/firmware/imx/ele_trng.c  create mode 100644
> drivers/firmware/imx/se_fw.c  create mode 100644
> drivers/firmware/imx/se_fw.h  create mode 100644
> include/linux/firmware/imx/ele_base_msg.h
>  create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h
>=20
> --
> 2.34.1
>=20


