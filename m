Return-Path: <linux-kernel+bounces-142763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73858A2FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5772824D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4E85931;
	Fri, 12 Apr 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dJ7lCYUh"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF681AB6;
	Fri, 12 Apr 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929843; cv=fail; b=e5rQ7Wa8iAh0vitWQNu5AnJL5mFOYsBjK1c7t1r5omTi0/RdtxShgJPzwESaJ+NXns73IJGfkXBOVJmQiryx99DnUKrvFZpjhius5Ma4PnvUFRYSsEdsapUzjYBi7gTrYlLGAe3g83BG52/SzCPoswiqRY9R7rbhVvSDk20DC2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929843; c=relaxed/simple;
	bh=XxPtttWLIm5jOXSmHwPAdk89l47i2ptzKNawjAqkqsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RllYoe99bMMMKR9KFroAU1OPpD0ZaPApYpmSJQffYlolQg7pznG/dvx5s2+XHalqP1Kp+HkU+4aGQ66eyEBVIDMfTxd0xltWZ31n/UoQSLut6qo1oIdsX6tANRzkoLg+G3kMcjdU17hYgGl7F6dxqaYT7PPTvUAq+b/6ngWATgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dJ7lCYUh; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH8sgYdSGNFigEEyzvER17IRWUV1q2oC9XOM5fsYFL0ri0OoWlsANRx9zbHBY6wB3iAbzEiryu91XGuzFaT6FRwPM6l56tPJtDtCZjOyRqtIzKcbL2fgkOV1H+vad8hWh1+UU/cFdOfzoXwUyTBlCK57hyW2BD9fZaCQeTNKaY9yrsoDroupKwliQ1jUWz9DwuA3AdV5OYcgqixc4PawkdpXDTemKao01eEwBBw5LL4ZMq+BS3M+VNgEOadVj1Tx9P3oossLI7wYEF594UilLCZZf1Jt93LJT9QL7Jf8EVRZ0ciq7+nIwFFeJyqpDW9vIfozxqmNu+tFZguIzvgr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQFD0/ELK9MtXQYt8JaCoPZNTRJgJ+8sy0WZ/gXQdAs=;
 b=CKr4VFDyhz+g7OdiAV6Nhk1z7413jj2gisXEAtOyVJjlNdbw1aLp0rPdzYy7zah1pk8tZDGNmWC6CwU8HdTmiC+nwqVmpBndJZoc22zTGVAiV+vtboEEgHK5gt22CSpSQUEsHKDTi8LHRpnbpAVwN4pIRMBdDoBJqk4z51KvGlrkzoY915w9V6kp7793HHLm7XY7y8fqFeE+1udrC0UVRWP9+rGlR4JpcM2Zh0gO+DNFQwk4uDsWF0SYZyAtuhm9GbqSwE1o052Bk0v8wVMO83nr0sWhmiD0HyILt8OQnm8fru0j0B1bBi1y2VjX+oAurxQS6PniymXb3Eaz5R4SOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQFD0/ELK9MtXQYt8JaCoPZNTRJgJ+8sy0WZ/gXQdAs=;
 b=dJ7lCYUhqgjEk4fUbRypiq6i0o2vMoT2saectiTLErYGoK6OkvJ85IErOPfn6lCBX5VVDWRez7m0os8uzx4GjbTggKZxBjmeX9cb2wEGHpGjprtZGGlJk6xsLJa/CIvHyS+YJZ7j98JR+8H3hkEx/XcV7JRLhF9rXY2720wUg+k=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by GVXPR04MB10203.eurprd04.prod.outlook.com (2603:10a6:150:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 13:50:37 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 13:50:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sudeep
 Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Thread-Topic: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Thread-Index: AQHajMWwPzKaKnlwaUWTuAs/m6AnGLFkopsAgAADorA=
Date: Fri, 12 Apr 2024 13:50:37 +0000
Message-ID:
 <PA4PR04MB941680A7FCBCDF926417F6A388042@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
 <20240412-imx95-bbm-misc-v2-v3-2-4380a4070980@nxp.com>
 <20240412133400.GA2282201-robh@kernel.org>
In-Reply-To: <20240412133400.GA2282201-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9416:EE_|GVXPR04MB10203:EE_
x-ms-office365-filtering-correlation-id: 3781dfa3-f4b9-4041-c5cf-08dc5af7887c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RiMcPDN9v2RGu/vs42jvbu53TyabmOfcXk95eNmj4XRNUhyHpNGM8SNc32H6zFHfgjeF+1scpPLit+9Y1HjQ9ZNcqdLO/tnYxR0n/OXuLuaZL6eHCq6zj9KKU80p1vj1iQ/+8k7D3rhJdLToNzexd98a/kVfLEHLlsAYJPyW1f0UlR3hsfU5M6UHOi/tbVApWxSyM8y2a36KJTlz81UflZ6Vq9XRI7OB64R4bEPioafLH7H9JADZ4o+g7BA5KvWWRwomdp3POm11FMdSetnoohxN+R9/FplTvTltNnwdINsJdMcbJ79bxNv8EZIaFmbZxxS7/enkeav9JpZGMg9HJ36KeTKuxnSofrLRYSj30C2ReeRt5JAw9Nt4pcRv0lioZ3fTx03shpqRaOueOK3cqr72ooiZa+62jbbOet0EQU8HbxnXfC8j2+UkYltlyDU7YDZu1l44hpHFUUaDwlPDwQlrqgPXZlacn9U8iKw32Zc2MJwcgiR+raHU/PQp703+ISwkGsEgqjxLWZ1+B4nTRDEjNedZawKR7vdWsWbV18+2kR+lozNEC8hFWDndn0VdR9guvXKv/Dlr0Gi89FyY6yyoZxch4JXWD172Lj/gTo+F3DialX7xInGxHbtF/0hC6sbySuirFpRMqFqBTEJ9yy/tKsSJ8pLsbxnCYXQ2TPhzHTezpU62F2TBnBrI6Zt1pV6bWQmmDdjF9IzueTy8/A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f0G7K+w2C/vl7gES1+xIdfMiFH1KCwa7XZRgyyLNJNrDwmwoMGx49HGjKm6p?=
 =?us-ascii?Q?ZO8ficnaDWPFpgJW1g4V02SoRX8x0gVM2T9s7rdIZmVwHzc2PptVPJODUBB/?=
 =?us-ascii?Q?yHGPZHHz6c2eXqNd51elpNKrKg9q6O/JYZZdP+u5eL14K5Gpoc785Rv1qlAS?=
 =?us-ascii?Q?Tj6sDyfwe6GFkcfVZZjNGL1qpROlrQn/cepBumnBdaC52JveXvTBHOYLd3Hu?=
 =?us-ascii?Q?LPM/6pa8dWd3KX4O1hwmHiYCKNpkwlTQxsyYvr0sRQ41RT0KkAgeasKTYk/b?=
 =?us-ascii?Q?SMOBoR4H4lGkB9vWq719Ef5mIrRd/86pHjYfFy70oeACgH1e5uy2Mi+LhczP?=
 =?us-ascii?Q?ccLg+vCIQuMsqpZnOtb0qNO+I7NjaUOaVUOqtz8mP5FUdq0UZCOSgriOcupW?=
 =?us-ascii?Q?QMXqp7uDBJbJNxL+sBZRoPeqDW5xdNfOMkGczOokKSWccqPcHTrWImdnPbpu?=
 =?us-ascii?Q?UcXBjtyWzfBbupN71dgI98t72TPeWNN4d/bCUg6Gwms0lZ05Ga2fBcHAQ9UA?=
 =?us-ascii?Q?vcx1Ew0HyCXrA9dvCrWxlY4u5Yjnp6HHLKsRJVhoPqCR9ep73i6qsdJJeFA0?=
 =?us-ascii?Q?suqs64jMi/hPuhqiE2dltUb8K9nNoN7IsJ6R4sREHhqRFm1kUqMvpPBxtbky?=
 =?us-ascii?Q?rrVAAA0HBzplC63GSyTkbW4z0C6ulyuvRXNQgy2+vwexRTDcvto/xzonV8VB?=
 =?us-ascii?Q?MEGnv0MgOA3FUUhXcVNg8eK/ZenKYya6FAvqkDeWxkpYIAKT11sm141AkOe/?=
 =?us-ascii?Q?ERdCpmP9cMvQhCSjG5GLqo9rdMcYNUTesl7HdXv6V96ARrhk8tGQwj1eaTNR?=
 =?us-ascii?Q?Ceel4voERV98rUxzbNIYomPdtIDxP0WQVMYtMcqZ6qJLcWpGSTwlEmdibx4J?=
 =?us-ascii?Q?5GuhIjpbEq83bEQZYQZzED1CsLlriA3u42b0QfyIn4hIdbEvuF8kxwTuhvBd?=
 =?us-ascii?Q?aiEMhMnQAf8ttbdyjILalU8bJLi06uToLbb3StdAFC02+VCI2mr8rnMUGKLd?=
 =?us-ascii?Q?+PJ4O7A9MoAXKb8WJq0hnXtEaoeAmsXo2MaTJYd/Z7l1vqGdUFDrsTks2jVi?=
 =?us-ascii?Q?iraYa86Rrg4a7lOf3le3v8pxInYtdcopo9+2oTY1SFO0ZJgX/H85hGxRD9Fr?=
 =?us-ascii?Q?YwuLe1OkgQKKdTuoHVpnGKlqtAKgeSCgRYyPkOUJjkB5WGzP25ubinFy6q7q?=
 =?us-ascii?Q?JRtCv15+l/wwY/asU1c0sMAlG8CfVlnxl9/UQgnXXV5g5NY2knpZe+j3T50h?=
 =?us-ascii?Q?da7tOkS4XPugaa0vxJvkKyRG5oQ9Qk+89k0cmpvfb/R8eugZh7DJHLomgz7Y?=
 =?us-ascii?Q?/nlCqWMyklA3i2UY+ZQ6sYQyYAwsTSSJoSa3/J01WwVSo+kxkT2htSPQ1Mco?=
 =?us-ascii?Q?7lJpHO/0AckjoIEQ8ghJQ3f3qXo4Rsbzj1xwukITE6gU1LVHWtNFZta16n6A?=
 =?us-ascii?Q?OYURj0XxXFM22nfNk9l15oduWzfuIc8ODLG7btF1NdFRdx3pcGDFgmdSLHzT?=
 =?us-ascii?Q?b87RSUOa8ndyrYFWvqmdB30Rysj/N//BFhplS8xN0m9WYhFZC1kdRN2gYOE4?=
 =?us-ascii?Q?1c+XctdIsMrtvRcRN7c=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3781dfa3-f4b9-4041-c5cf-08dc5af7887c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 13:50:37.2715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRoA6f3nRBlcZO1AXLtNrONaevFJzXr2BRSAWqIQq0Qxd+ST/ZjhWcJjmX7I7L0ORnAbozYSHv/Ag1lNfxNksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10203

Hi Rob,

> Subject: Re: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI
> Extension protocol
>=20
> On Fri, Apr 12, 2024 at 06:47:08PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX SCMI Extension protocols bindings for:
> >  - Battery Backed Module(BBM) Protocol
> >    This contains persistent storage (GPR), an RTC, and the ON/OFF butto=
n.
> >    The protocol can also provide access to similar functions implemente=
d via
> >    external board components.
> >  - MISC Protocol.
> >    This includes controls that are misc settings/actions that must be e=
xposed
> >    from the SM to agents. They are device specific and are usually defi=
ne to
> >    access bit fields in various mix block control modules, IOMUX_GPR, a=
nd
> other
> >    GPR/CSR owned by the SM.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 21 +++++++++++++
> >  .../bindings/firmware/nxp,imx95-scmi.yaml          | 36
> ++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 93fb7d05f849..fa2cc910c485 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -247,6 +247,27 @@ properties:
> >        reg:
> >          const: 0x18
> >
> > +  protocol@81:
> > +    $ref: '#/$defs/protocol-node'
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        const: 0x81
> > +
> > +  protocol@84:
> > +    type: object
> > +    anyOf:
> > +      - allOf:
> > +          - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
> > +          - $ref: '#/$defs/protocol-node'
>=20
> If you put the ref under the protocol node, then it's 1 schema file per p=
rotocol
> per vendor. Also, we then have to list every possible protocol node here,=
 and
> every one listed here will be valid for every vendor.
> What we discussed is putting the list of vendor protocol schemas at the t=
op-
> level here and then the vendor schemas can list out all the protocol node=
s.
>=20
> Also, move "$ref: '#/$defs/protocol-node'" to nxp,imx95-scmi.yaml.

In arm,scmi.yaml top level, add below:
+anyOf:
+  - $ref: /schemas/firmware/nxp,imx95-scmi.yaml

And also add a protocol node:
  protocol@84:                                                             =
                        =20
    $ref: '#/$defs/protocol-node'                                          =
                        =20
                                                                           =
                        =20
    properties:                                                            =
                        =20
      reg:                                                                 =
                        =20
        const: 0x84
But here I not add unevaludatedProperties =3D false; otherwise the vendor
yaml new properties will not work.

In nxp,imx95-scmi.yaml:
properties:                                                                =
                        =20
  protocol@84:                                                             =
                        =20
    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'           =
                        =20
    unevaluatedProperties: false                                           =
                        =20
                                                                           =
                        =20
    properties:                                                            =
                        =20
      reg:                                                                 =
                        =20
        const: 0x84                                                        =
                        =20
                                                                           =
                        =20
      nxp,wakeup-sources:                                                  =
                        =20
        description:                                                       =
                        =20
          Each entry consists of 2 integers, represents the source and elec=
tric signal edge        =20
        items:                                                             =
                        =20
          items:                                                           =
                        =20
            - description: the wakeup source                               =
                        =20
            - description: the wakeup electric signal edge                 =
                        =20
        minItems: 1                                                        =
                        =20
        maxItems: 32                                                       =
                        =20
        $ref: /schemas/types.yaml#/definitions/uint32-matrix               =
                        =20
                                                                           =
                        =20
additionalProperties: true

Are the upper looks good to you?

>=20
> > +
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        const: 0x84
> > +
> >  additionalProperties: false
> >
> >  $defs:
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> > new file mode 100644
> > index 000000000000..b84c4a53b78a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2024
> > +NXP %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Ffirmware%2Fnxp%2Cimx95-
> scmi.yaml%23&data=3D05%7C
> >
> +02%7Cpeng.fan%40nxp.com%7Ca73ba3e8c48044f31aed08dc5af538e8%7C
> 686ea1d3
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638485256510784219%7CUnk
> nown%7CTWF
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DMl5yAdb4A0Bmg%2BVKroJTJsE9dAF6B
> h2mbJzgyxB4w
> > +xs%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7Ca73ba3e8c48044f31aed08dc5af538e8%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638485256510797603%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3D6%2FsoexEJRrjL3DaXX5wwtjd1ZSN7nqmh0YjAQEmH5Ow%3D&res
> erved=3D0
> > +
> > +title: i.MX95 System Control and Management Interface(SCMI) Vendor
> > +Protocols Extension
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  nxp,wakeup-sources:
> > +    description:
> > +      Each entry consists of 2 integers, represents the source and ele=
ctric
> signal edge
> > +    items:
> > +      items:
> > +        - description: the wakeup source
> > +        - description: the wakeup electric signal edge
> > +    minItems: 1
> > +    maxItems: 32
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +
> > +if:
> > +  properties:
> > +    reg:
> > +      const: 0x84
>=20
> This schema is only included from protocol@84 node, so how can this be
> false?

Just in case adding other ID in this file in future. This is no need with
per file containing all the nxp protocols.

Thanks,
Peng.
>=20
> > +then:
> > +  properties:
> > +    nxp,wakeup-sources: true
> > +else:
> > +  properties:
> > +    nxp,wakeup-sources: false
> > +
> > +additionalProperties: true
> >
> > --
> > 2.37.1
> >

