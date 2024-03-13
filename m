Return-Path: <linux-kernel+bounces-101064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC587A1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD6EB21C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306CB101C1;
	Wed, 13 Mar 2024 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbZ+4SU0"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23251C13D;
	Wed, 13 Mar 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299282; cv=fail; b=QwzciKQcS7xDBM5xiHjn1VwmX3aQX20ttnO2lxh6JftHhve5fk4treuHF284DAyi1Yx+70YLSYnRuA4YwnVPfa4mVt7HTRJW/aMFc+/glONEP7dYMR4wXr8UBISMmHEcgHexInnlyjE3sUs7EV4GE5x+P+GoU98i+x0udyyjgkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299282; c=relaxed/simple;
	bh=6N+UWN0w/w05HcbygYq+cXFnePxiZqRiUjf2F3TM+zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sycAut4weplRQAZBMK3ROZigvpbEy/miIgNszlAuZ3EPeqRj9KoqJVY+oFgtrKOTkcE6uvg/haZgsN58cMc94O/Y4nem8UFa2DIRdeRSNUnQeAa9DZ0R3SV1XZ0a30DR3Gfy3An3SQY8LfVu0ro4p4mrA+5mJuvpN2eRSsAqfiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cbZ+4SU0; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY0TPYJW/fSZvjowQNtsmLy9IWT93/oOoYMx3eiCkFo6+oKJUZ/Qwt5qdBpCJx7e8oQEAGm1xShSqJbyTN4Vn7NpS7Xdw7k2UKE6VlXVo1gWaSlJkgJSQjwLS8UyhG+2KEB16Gn2dF7aadstIcXyRDYXdMm8wYjKXoz2bcczph20z7ujo4Dy6OXOSci4FGUu5eVDAC/ISntBykJ0Xbhc8TPL2L5G6S7Bc/Wbp5mWHhwXRIFsxzC77GCD50RjqOdjfnkVj1DTjvjQL2rUFUdeVQq4gGpWEeZZqaZtg34stqbb/yKgZ41WxF9n/mOyMw11Z3KpjjQ9Inhn0Hvf3SAN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y2+63qkamibIHazfBZkZgLlhqpjaHiCav9zP1+riYk=;
 b=Lhodr49hADEzJfUYPvrYLnBUwmlBQlBmn42EjU3t2RVDAryANOMDSOlXOSbWfyvXKehCEScWI2yCtnykaRPURITT+hOXpPRagMzefgMcD3nlFZjJ4zvAzhBPx9zVwFdtdaseS1Z+yxGVPMp1v8yFlTCSVZ0S6iY6amHV4LobY7MBeHO+oxVIN8jGU0cUK4G27EYKYNuZyuF2wi1Rao+GygtYUh9+1110vkPGCTbfl2U0HFZ/zQNSjN2rniYLTAdcIT5lBAJ2hrOk/Rkaw7gtmufQgo88ejs4XOMk9w3tcVcisCuOy+qy28zWBCyHXOOHfSKE/DvKmEfal297LBpECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y2+63qkamibIHazfBZkZgLlhqpjaHiCav9zP1+riYk=;
 b=cbZ+4SU0lHBri5vu8M77RuiO54uVEGw8IKuc7flzITUL9jD6QEsK++QUBUqPamRjhzFGCA8zpOFPNXyxNHoCZjnjvIpwJsli5ggGCSJbKcemB/PlXmA4RqZaciIMJVCTl7uKnw/B+/kSjMOUgSaKv480hyLY5hzgznmHruNkt6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 03:07:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 03:07:57 +0000
Date: Tue, 12 Mar 2024 23:07:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"peter.chen@kernel.org" <peter.chen@kernel.org>,
	Jun Li <jun.li@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Message-ID: <ZfEYg1BVTVMGAUJX@lizhi-Precision-Tower-5810>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
 <20240312091703.1220649-5-xu.yang_2@nxp.com>
 <20240312145035.GA2204647-robh@kernel.org>
 <DU2PR04MB8822976F9F052E18D7951FA48C2A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB8822976F9F052E18D7951FA48C2A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef1b783-9229-4de1-5ceb-08dc430ac877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gS5uti5P1r4zrFdrIKFwTLZC3UM/+FjdhHwHG3cSzLucKrdBSJI6vBAnwm2QvdlkDGDKUVdLIqgaCxysO5X+qPc7xcFBSmb4x7Vc09sDt2Q8dE/7fbqiN6xOWJL4Y4WYT5Xr8aeo9cTxTGEiAIAqkcVQDstdDYmqAV0irSzEdMAMAM3kMOh+ZdJdlTna0BrdIr86hLK0tMWN9NQagh5+nOcbsylxin4VxjMVH0b0QkmMK1+6XlhDC20D/9x0LfK1wM40FIXb4AFVblUJk2Zd3CPugi1gTu7GhAP8qJNTlXM05R/YsYhbu83+LZU3yCpibZ3G+I8+57/Nkl6Jxkb30gtzq+2hgHF/mReQuN2nqLjO+K64Xt59au+JuiluV8S3mRTumP8R+r6abbPoVhHSLQNhSTxpmWR7xP8nhhZot2fg5BZOGs0txBa/lopUPqXmvF+vig/FOgK7j7uLI0ll6ueGqKNHSvvlEcEnlSVqg8NVyOkp1h9AljN5sJwEeD4OMAX3WGIeF0k1lbc5+o7T6oBx/O00u06arSsFsxmWWJdo53lhKcbFxZ65ZpvMhUONvD9WjfmOAssOua2MFfAjlHQC0ivokQ6iBmU+/OeASParzHtfXxT5a8tmRQoU+9O2oPmdUN379U8bNmNHVO8q6pfnXqxVwRPO3Ju3Zij6Hn+nJgWdfHaxVel9yKdB+88mFWJVSTR4OMzabg/0jTDeHRIanqM8FCLKcNrVPvL0Uxs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cdFVkxvAeRw8vMZFHtsc4xAMArMGALauZxe8sR/pabG3BVrvwUVvWaX2Lk5O?=
 =?us-ascii?Q?R90GWXHhKcYlnpgiLu1lmLz7UZtyJxQ4rGnTcK+cHJAGkKOI1P045/WS/2yV?=
 =?us-ascii?Q?bj54n326Mn6zfOwy98TwmGRtehiuxMIygP30am5IvjrjDjaEUMCni8EK9Bi5?=
 =?us-ascii?Q?gpLikAJ+OuSDn7NIX43XGLI5IQKBtMZ4BovyQ7nAPijdxIZsclfsimJP/mJm?=
 =?us-ascii?Q?Qc2HnFPNggQ+EfVMbPMiZynnRZGBBJnLNN70acsrieSgqB0u2vMlylNm/qsT?=
 =?us-ascii?Q?oK59FcVp0gbuGTdjVHuHyYMHkgfj/HVRpf8+YkdViOAOhPGzaqTiNXeI+iNo?=
 =?us-ascii?Q?Zhe0XycXvvtxWcn8RRfiPx/mkA2OEvbP8FErHj/3x2QnuZet8efUQm2c9Q/N?=
 =?us-ascii?Q?HFbHdi0UmWFJu38cXTifC7aZsFz0DsE7d1xrMZ37sTglTXFDnrM7yMaxx9Y+?=
 =?us-ascii?Q?j031aacIUXI2040iH8zoc5H1BhbqXWn32i+ZR9MWT+qaxGdzT+8jRhBoa6uY?=
 =?us-ascii?Q?BAZnP3UJEzJyLYr/Dtvoi/xGRLQralqfBNgRffudd16aJMOfhDKzIYjeWsm5?=
 =?us-ascii?Q?iaMIlkqbT7QJSsOPzh1lZ/ONXsx7MqC1jCbaiKYi7VqSlnp4iv+PR6DUPiHz?=
 =?us-ascii?Q?j+wXTQGHr1pKIvOwLNiE2yJTu4qvbgkflYtTdSqRzZ0LLMA36lVyCgIttXOI?=
 =?us-ascii?Q?u9jT1gfZygsRZXmo/43xpV69LxuL6QBWdRKET6jgKANpF5A1GZu4Ga09MDpE?=
 =?us-ascii?Q?QEzEhf6xGiFhiOtH/knNH86Ba0LV9DIUm6BxTJHyyyotJmeADvvdUIXFi7h/?=
 =?us-ascii?Q?9nXK9XTA88AAdv01iu8ZfmWpWnUk56gOigZyEIvhFRdCpBs7GX4lT4urc6n5?=
 =?us-ascii?Q?XpBvsUzBKvgcdGcqUGzU3rDqlnwZvxrBKW31e/Bc9elv/4vqkqeCLewV8Alx?=
 =?us-ascii?Q?Gh+/ELw120Z3bNZkTa/Qcfu/r7P+1zNCM52fao7F3v5YmVTWZUQY2xdwxHKr?=
 =?us-ascii?Q?pqY/EI29ZxJzJfBaGcjeBD9TnbIECoeeJMv1ebRBVW583OLUfKtuZshDlmK5?=
 =?us-ascii?Q?FWfhdG13QUQ5tKcx6Uz7afp6hcTYTIKUrcEDKnwpkEluNSm+S2WzzGZoQWlF?=
 =?us-ascii?Q?oKGJIIEG4Anw0aUZh2+pp5W07RNRrfFHomz/qBYC/amTbuV2+SVJwMm61iGQ?=
 =?us-ascii?Q?6SysnL100zjPwGCPtnMuSkt9JJi+cVFakuq6IdaFsYkzaz0/WDTQDdxE5YE2?=
 =?us-ascii?Q?2fUFNDcgcIQJ64QgRw7sIAzWFFoCUyv3wXcyBROJ6PXEElk5lOEY3xa6rhYC?=
 =?us-ascii?Q?33BV5Rz+DRPSRgF10npP4Er2U2027goyr/I8iO8u2sd04UoJ7iqcRqW0/eDt?=
 =?us-ascii?Q?HsAm25lvdPRunfDp3m+9kVlb6JymdWwuK7L1Zzz4HaR47Ajfugku5op6wSAs?=
 =?us-ascii?Q?+TuD09FJrTIqQJ98jnBxm5sI+V4MahaMH29YeAMMmSoUmlCkJ+X3ayQ1GDGj?=
 =?us-ascii?Q?QyfljjqDtDRQHkER/LSEL1WPvwdlTW54z1Ab4aZ5741AMW1dnpsgK4Hq5tkJ?=
 =?us-ascii?Q?eqsZP1bNmkvgTQgNaX/ZWTrstZOXXqUzoXLFOsXI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef1b783-9229-4de1-5ceb-08dc430ac877
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 03:07:57.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzAK4Uhb2okolClas4YUmYp/4HAIf6OFxb0JqfQb7DE8sL3qrtQfN/H/v5tX2LumYINlUGnq5f8kNWfBF+RV6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8523

On Wed, Mar 13, 2024 at 02:48:00AM +0000, Xu Yang wrote:
> 
> > 
> > On Tue, Mar 12, 2024 at 05:16:58PM +0800, Xu Yang wrote:
> > > Add restrictions for reg, interrupts, clock and clock-names properties
> > > for imx Socs.
> > >
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > >
> > > ---
> > > Changes in v4:
> > >  - new patch since v3's discussion
> > >  - split the reg, interrupts, clock and clock-names properties into
> > >    common part and device-specific
> > > Changes in v5:
> > >  - keep common property unchanged
> > >  - make if-then more readable
> > >  - remove non imx part
> > > Changes in v6:
> > >  - new patch based on ci-hdrc-usb2-imx.yaml
> > > Changes in v7:
> > >  - no changes
> > > Changes in v8:
> > >  - remove if:else:if:else:if:else block
> > > ---
> > >  .../bindings/usb/chipidea,usb2-imx.yaml       | 80 +++++++++++++++++++
> > >  1 file changed, 80 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > > index cdbb224e9f68..fb1c378dfe88 100644
> > > --- a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > > @@ -49,6 +49,12 @@ properties:
> > >            - const: fsl,imx6ul-usb
> > >            - const: fsl,imx27-usb
> > >
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > >    clocks:
> > >      minItems: 1
> > >      maxItems: 3
> > > @@ -144,6 +150,80 @@ allOf:
> > >              - const: idle
> > >              - const: active
> > >
> > > +  # imx27 Soc needs three clocks
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          const: fsl,imx27-usb
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 3
> > > +          maxItems: 3
> > 
> > The max is already 3, so drop maxItems.
> 
> Okay.
> 
> > 
> > > +        clock-names:
> > > +          items:
> > > +            - const: ipg
> > > +            - const: ahb
> > > +            - const: per
> > > +
> > > +  # imx25 and imx35 Soc need three clocks
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx25-usb
> > > +              - fsl,imx35-usb
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 3
> > > +          maxItems: 3
> > 
> > Same here.
> 
> Okay.
> 
> > 
> > > +        clock-names:
> > > +          items:
> > > +            - const: ipg
> > > +            - const: ahb
> > > +            - const: per
> > > +
> > > +  # imx7d Soc need one clock
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          items:
> > > +            - const: fsl,imx7d-usb
> > > +            - const: fsl,imx27-usb
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          maxItems: 1
> > > +        clock-names:
> > > +          maxItems: 1
> > 
> > What's the name?
> 
> Can I not specify the name since the macro definition for USB
> controller clock in clock.h is recognizable and the driver doesn't
> get this clock by name rather index?

If clock-names is not required for fsl,imx7d-usb, 

clock-names: false

If driver use index to get clock, why need clock-names at other platform?
I supposed these should be the same for all chips.

Frank

> 
> Thanks,
> Xu Yang
> 

