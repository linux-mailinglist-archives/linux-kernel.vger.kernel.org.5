Return-Path: <linux-kernel+bounces-146361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E668A642B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6528133E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746FF6E5E8;
	Tue, 16 Apr 2024 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Twy8jQGU"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D396DCE3;
	Tue, 16 Apr 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249692; cv=fail; b=U49qHdm1Nj3Nv7nkZoYrTvhS0cFhyLxNuEmwFtnSDYRbJM4XzfCqQemR/PCAZVBpXKcZwNW3D7PByHCOEH8NyAa1e5zr22eUv3cJsoIxeA2zpaGKvIo3hoRJECLPlXj76RZmuhKl3XMm0ir7Me2wI/COGSnadmV9rJSOxFzo9bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249692; c=relaxed/simple;
	bh=KSmPltwVZQvzrSyOWqE4B/Ar+KJ/2EkJxupXdkYelD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmhXO32hwCjDhNwpOidlTY8jvnIwetLO4vfXuL5n4GCRDM44qtkenh2Nq1n+5g21eDWquFJBMudl03mgWlJlpJAvNr0/P3yvZLxAnJzsLxskAbnTQ/+2dDv3LQq/sen8tTtfuuBGi+Ak1ee4weF7dtxMU86uN1knWm3dUyoa6jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Twy8jQGU; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFF+HfgSBLcrdKtOBfEwH3BhO9hh7je4T8E6xQ3J4R35BiWFNJlLNVK6hUOEczU+Nc6ZatBZhNkwTaZXd6VoUHAuItk4iWWRpFSGNUBXY1QvXy6GFQr33o0yN3LgnAXBBPcTJrfCxQfVf9sefH8gqb/j6GljynOd3suif09Gox7B3qi+WVVsRNft1wWBvzuIFuzUcET1FxbvOYrktHcfcnHSJAvvuhb5j2l7+w49jD//n+oe/B6aJlKDSeFBKSHKzAV6xeG2Q25ai9y0r9WCuRj8OWSQWD4tqqrSHYw261PMarx+wlUaYn+r25RKrzAvvC8rnT4wPqPPV+QBX8Sb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4dWuYCWNnSxkT41Og5vrvBLO3JF6VjGkDdVzSdKUj4=;
 b=hazLW5nSAO6lZ6LFmJDoV9nz9rnywZNf+eixAHLCeQM+JZKHN4MC/LUoLGLWqXfibt9FcyIgnrUgoa3VK0iNFObSpqXTotaevXcvHgL3VDSFCQt5Xmk88+VOVB0m1kuPGZS/meFTjKyWHAGKXiu5yDbU8zdBnmP6ukEqUuWBh1TpgfjRd0HlBbkj/gZGqF2QRDLrKb7nsOUJ9ERV6f5RtSuW0p6zqciFOo7mE7WmIilS9ZkbYrrEuVukqNoaz0+m8IYSZqk1bx7ScuI1yov9sUqBGIB2spLvAwvGJCuGgyyhl4Gs/D0OM4CI1W6kKemG5hC7L653fve8UwCnThPxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4dWuYCWNnSxkT41Og5vrvBLO3JF6VjGkDdVzSdKUj4=;
 b=Twy8jQGUQ4aGE3xD8zLC0JVL6H/BdIdLzADMJ5nxOP2O9xHLK32OQ5cNF/JkFPAf32g5Y8d4yG/khFvp5Rgx+Yk/Grox4/MbU3KgnHY8C76BKX8F7594OaTgeq00hb6vKyw3lGUKJ68foHo/A1/O+AJvFCF2lyq3XYZ+FhpgAoM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9969.eurprd04.prod.outlook.com (2603:10a6:20b:67c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:41:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 06:41:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Thread-Topic: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Thread-Index: AQHajG9fogbrSJSEIkC/zlbnV4Z6dbFp93iAgABErECAADwqIA==
Date: Tue, 16 Apr 2024 06:41:25 +0000
Message-ID:
 <DU0PR04MB941794994D2D0A2CE5D0C33B88082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>
 <20240415225637.GA234203-robh@kernel.org>
 <DU0PR04MB941714AFCDC74997BFF34DFD88082@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB941714AFCDC74997BFF34DFD88082@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS5PR04MB9969:EE_
x-ms-office365-filtering-correlation-id: 32490c32-5fc2-48eb-c339-08dc5de03cbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HGdqhWScfC1BlfkFb8I/z02nHe8EhhTwHO98A/ozN8XsXccm2/akD4dQr7+SZmyBlSuls+69s8YY+KC5p8T0iAgi1fO6GcZD8+6rcVqW+jJ8bQELhhl3buhM7oficb6A0rPgTZ91UXWETlyJwDR69FgqURuoZmLWdet0oWFuiKON3YJK++4cePMuujvTvk59RBHwsWYzhSPCWfxlDUx3l7NyFSTlf0ma1G8CDJGAU9G2s9MD7qcOfjf21sRi1hPEkbDJfQzMO/rKTo7Hg1cDjultR2AsI+ct15zfEtbGfkZCI/8JNu62Zi0PKi+zNMP0vmEOeGfk5gho0DwMW4JzWc3jsuUMG/exBo1Wg/rQJE0SkyN3CS+ejalkXYXaJbLcbF3b4hxMKi6P3FxWCIg7dHow9Rt4Ju139YzJk9K2clETdn/VFzm6t1rQnxRqImSulaMXLbbPIQSS0n3wC2rU0x0fEykHynBf3tbfFWSmMLUPqI9nHUcEeFXKkXSvc7T2CuzWMu0VdFd/MXqyPSMOdQYFIzo5K9bJeNhDnG/agYPOFBGXMKFKIb4NBuZYDucaB3tkGtVNPBR9m3nK0GHr7xesZVz4OuhGrxoRk50MdBwHV+2Ei4UD1Atc6DSUdvQCIHaeK34d5GNV4o22EYYG+T5mYouLy+5Mm0TUjIha9wRsdZFK0rUUz46wplHhXOpmxnXB2qz0yDwZR4h73dFferfGWCp22G3na7oeMOmWbUU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wa8ehcEj+Vk87xjH63szBYzVTv+R2Vn5FqkSrvfvxTEQXWTSN0vYEGCZWLhs?=
 =?us-ascii?Q?WuTGyrVkP9HWAC3aR8jYH+rUp/vXRW5tGQMUzz0+dnjn7DpinAN7Bep50Vp1?=
 =?us-ascii?Q?NoxRIRV0jc5/hGTaFxbSlCkO+1mt/slE9NVGLzZzE4hhkK/6THaPXSI0Zfl2?=
 =?us-ascii?Q?+kN9w8VVhl2+Z6xyIvUuHk0jZ1Nygk9hxGsA1GUxZMCOoydOn6E6wTHN7lAT?=
 =?us-ascii?Q?IJlZibX1qVD6u8BV3phqe5v+PGFHYteZHCu1tIPjOIYAwrhXS/L4gbkxoae4?=
 =?us-ascii?Q?WFeSAOcrbfInzFxSIvRbckp0KoKXwF4nQ8vttZEktMj1xjz1OqN6irrYmhAv?=
 =?us-ascii?Q?Y011hOsyBoksCxYWs7P0ARM0xLUrZo1kDnQ+y62JCT9iy1OBZTAgKSrteMwt?=
 =?us-ascii?Q?HE3bjIdQ8ZPVN3wur/aqmvHqzQZfo2qaxQAXBTrlIHB0YuTebVFL85Pg2n+S?=
 =?us-ascii?Q?706xuSX5LH125agEht/XQe+1jre3VGDntxp51jeHvqjGJUyl2YYpdU1RTmeb?=
 =?us-ascii?Q?1UtbdikaT1DoVNIQJqb/Dng/OxucYoPa5UyvHb6UKnJH2f4ZJQ2TfaZ1X3Uz?=
 =?us-ascii?Q?dHkn/hIk5LEQ6HdWdrSRK0vLrmoLmGBXk1Sg8yiMeNe1kZAgF06TBDQsxVez?=
 =?us-ascii?Q?XDYWbghFabFGptY27jvXZ5vzLuarkUDvZ+Vi8doApxbKnMp//3RP77/yaJwj?=
 =?us-ascii?Q?R7TaicgGAeFe6yMu6YcfWyzM26XFFKzmFLPu//jISOPkyoLDpyhujZvtz0d2?=
 =?us-ascii?Q?9hRD5ZDQ0/Dj7g2F9Oe8MDqCStFVKticDljvdNgEMdtdxWh1pSsj/yOuGF3K?=
 =?us-ascii?Q?tUZvYnaePZwJK1ZLEEv1NMj7L7vn2l3QF7IsvbQVpBf8ZPSS6MJylTucUjgB?=
 =?us-ascii?Q?8yXjWMHvcTikrgceSrZ1yk0MeYeZtSGEnJkuZMtjUV59Kv/0Hi9fFAyUyry2?=
 =?us-ascii?Q?39hOjDmpONfM4/p4KuBirAaM7m3zlCQwsoMni3rrzkGSyU+BO3mV0SQsO47C?=
 =?us-ascii?Q?wdhcC5rRDP+N1ZKLw8HnqfovTj0coAeIZmQBPRh353PVKCbY2/CY8W8CGRdM?=
 =?us-ascii?Q?rP1Svs+fk94vy0CxQbIqLcvDYt/7CewQgdUMuAjMKdph8baMTgDl9GgRUGg3?=
 =?us-ascii?Q?HE4xBPJ19VnKctmD3Q+2wEmy9+4Ue8hC4jMkoriGfcxqL9U+XMXvm3CT68sX?=
 =?us-ascii?Q?EfbDtiqfbI45WD2fr8abTyjI6EMKGAE7tirr0TATi69fKVcWkKYZg32zh+De?=
 =?us-ascii?Q?fKqxj2uFQ/a3+qrePts7PwGuw0z4fwhxq0IjAOWBqhoXJxfUfQNsgh0tJUPx?=
 =?us-ascii?Q?waOSDGSwUKl917YWLCHF0Kw1pI1jWh/7+QETqGZLvoBVbRT1P4gwAX8M98dw?=
 =?us-ascii?Q?LQNaxvoG+QKWgyj6oN9r/Y4L0fs3iaAe5vtxRA5pLUOkH3Q+wjalXlA7udr3?=
 =?us-ascii?Q?XSIjE+g0lcVeK/i6Hj3v6Q2o50xgYC6F0KqYgnykHppHaGUWP2oaJoE7za1Z?=
 =?us-ascii?Q?ECckeHlo2ELHXlzOXpk0GrnQoTMBNhXW78dBWpPXYHKaSm2IKkJk/kO59xDf?=
 =?us-ascii?Q?uBLj/2h2DK3x+9BDt24=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32490c32-5fc2-48eb-c339-08dc5de03cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:41:25.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zj6zJzFdy2LGoraMfzOyI5Qjb87gfSqCbhFxw8BYLAsfrj2sbtB5YpELVYrA24yJWI/D5gI/unR84ZUC3kGUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9969

> Subject: RE: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95
> SCMI Pinctrl
>=20
> Hi Rob,
>=20
> > Subject: Re: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support
> > i.MX95 SCMI Pinctrl
> >
> > On Fri, Apr 12, 2024 at 08:29:26AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX95 SCMI Pinctrl uses OEM specific units, so add '$ref' to
> > > '/schemas/pinctrl/nxp,imx95-pinctrl.yaml' and an example.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8
> > > +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > index e9d3f043c4ed..ebc6c083b538 100644
> > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > @@ -249,9 +249,11 @@ properties:
> > >
> > >    protocol@19:
> > >      type: object
> > > -    allOf:
> > > -      - $ref: '#/$defs/protocol-node'
> > > -      - $ref: /schemas/pinctrl/pinctrl.yaml
> >
> > I don't think anything from here was actually used...
>=20

After some check, I work out the following:
diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Doc=
umentation/devicetree/bindings/firmware/arm,scmi.yaml
index e9d3f043c4ed..26b7395c4326 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -262,9 +262,12 @@ properties:
     patternProperties:
       '-pins$':
         type: object
-        allOf:
-          - $ref: /schemas/pinctrl/pincfg-node.yaml#
-          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        anyOf:
+          - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
+          - allOf:
+              - $ref: /schemas/pinctrl/pincfg-node.yaml#
+              - $ref: /schemas/pinctrl/pinmux-node.yaml#
+
         unevaluatedProperties: false
=20
         description:

The nxp,imx95-pinctrl.yaml:
+patternProperties:
+  '[a-f0-9]+$':
+    type: object
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: name of the pin
+
+      nxp,func-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Indicates the PAD connections which function module
+
+      nxp,pin-conf:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The PAD configuration
+
+      nxp,daisy-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The select input register ID
+
+      nxp,daisy-conf:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The select input register value
+
+additionalProperties: true


The node will as below:
           scmi_pinctrl: protocol@19 {                                     =
                       =20
                reg =3D <0x19>;                                            =
                          =20
                                                                           =
                        =20
                sd-pins {                                                  =
                        =20
                  sd1cmd {                                                 =
                        =20
                    pins =3D "sd1cmd";                                     =
                          =20
                    nxp,func-id =3D <0>;                                   =
                          =20
                    nxp,pin-conf =3D <0x138e>;                             =
                          =20
                  };                                                       =
                        =20
                  sd1data0 {                                               =
                        =20
                    pins =3D "sd1data0";                                   =
                          =20
                    nxp,func-id =3D <0>;                                   =
                          =20
                    nxp,pin-conf =3D <0x138e>;                             =
                          =20
                  };                                                       =
                        =20
                };

I will use the upper in v2.

Thanks,
Peng.
> You mean this not used?
> allOf:
>   - $ref: '#/$defs/protocol-node'
>   - $ref: /schemas/pinctrl/pinctrl.yaml
>=20
> Or below?
> >
> >
> > > +    anyOf:
> > > +      - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
> > > +      - allOf:
> > > +          - $ref: '#/$defs/protocol-node'
> >
> > This must always apply and should not be under the anyOf.
>=20
> I just try in arm,scmi.yaml:
>   protocol@19:
>     type: object
>     allOf:
>       - $ref: '#/$defs/protocol-node'
>       - anyOf:
>           - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
>           - $ref: /schemas/pinctrl/pinctrl.yaml
>=20
>     unevaluatedProperties: false
>=20
> And in nxp,imx95-pinctrl.yaml:
> patternProperties:
>   'grp$':
>     type: object
>     additionalProperties: false
>=20
>     patternProperties:
>       '[a-f0-9]+$':
>         type: object
>         unevaluatedProperties: false
>=20
> But the following example always reports:
>                 pinctrl_usdhc1: usdhc1grp {
>                     sd1-pin0 {
>                         pins =3D "sd1cmd";
>                         nxp,func-id =3D <0>;
>                         nxp,pin-conf =3D <0x138e>;
>                     };
>                 };
>=20
> arm,scmi.example.dtb: scmi: protocol@19: Unevaluated properties are not
> allowed ('usdhc1grp' was unexpected)
>=20
> Do you have any suggestions on how to write the yaml correct?
>=20
> Thanks,
> Peng.
>=20
> >
> > > +          - $ref: /schemas/pinctrl/pinctrl.yaml
> > >
> > >      unevaluatedProperties: false
> > >
> > >
> > > --
> > > 2.37.1
> > >


