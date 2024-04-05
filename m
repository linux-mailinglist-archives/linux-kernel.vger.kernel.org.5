Return-Path: <linux-kernel+bounces-133187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951889A015
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7503F1F21AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626A16F29C;
	Fri,  5 Apr 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdGrQ53w"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2130.outbound.protection.outlook.com [40.107.14.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060DD16F292;
	Fri,  5 Apr 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328428; cv=fail; b=I+GlF2T6I+TzgSlYQqQSWxUPuIgUZB6deF4HjsOgPtKq9HW3VlWi4TqkZytMXiwavSEf/5sjE2URcLSgD+tqK9GBVNYdhOZW5ehRSP4AAVyV54Nu1bKp5FEGuDr7TACCH3DmvA3F+sxZT1oCRW7ce+Rppn/OQHftIVV8lYOs0dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328428; c=relaxed/simple;
	bh=QOWpdv4glV59l0twkisvZUqkr9ajt78houcSMv6NAP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UtSL7TyGRuXeJqawAkZBvVROwsImdpRWz5nKRGWT5tvbUPX5W6oYc57E3X1nPCULNg3F+YxRqwP1xdJFH7CFAXzEJqMcv8xPOT7j+31mYt3kDNNEXZ5sCLELJY1UYFMNZrwJxaIymNMiCaCui6OpHUgUCaFu37N1UKX9scWhpcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TdGrQ53w; arc=fail smtp.client-ip=40.107.14.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jfj+X3cioHtAxm3d8qpsYt0wTpcy9LpYJonmMZoaCV5SPoIgtICIDYgp/+KduvTXELzn0HWMnjfyrw5SBPRl3XChJY3wYW5hBChij5YI1VRb8i0zCWcEVPylj30Rw9+ckTHh+DWuV6RDzZoLPEh9n+8KCTlzky5UHkUMsRXzAJursAn2X4s3vD1kj4zVUML0RNdb1/0itpBk3E9tjfL7YT6FhZCqhRTWgiHtwuDhNMIO8/mkMBvZjexvz+CRw0mR7AzA/FkocvDM+ItD7pWfpLoIt9M48ZddAnq33fM/WQ2bSVOlN2e+w5S8m99NaAIwRJwQNauFbJ+S8jE6eET+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZAZsbhwLpQBEfOedzNQ/szrY2rUpj75SWzkunFYAqE=;
 b=FGjddNWFDX7RmEMjsPzAeurAZT6yDaU7JB5L63Y59ei/Xw7m0C1fo60l19EX3R9D6DUje8jy4vh2ok+UgCzzDU7Ts8sQzYrFLALfXJCXxDODjAvGQGiBNiXYnmdZeFgMQp699t+SK9K5X5BTab3IzEQZqVbtEaJheKpj5z9pN6qSMMyjlh6p9m5tKUFhSWvO2bkzf1X0p4gFZdjMiomngO30ci3ZRzmIaodcQ7U33Ch7StBIsIQsQg27XGJHv+SILkUHzK//bkHwz/nLZQ9HvXZYge45wLzBp+b+LGvmB4saEUNRRHKdr2YshQj77ODDKL08xZSGcumA5ejXHGgpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZAZsbhwLpQBEfOedzNQ/szrY2rUpj75SWzkunFYAqE=;
 b=TdGrQ53w0KzLDYzTy2b0D09h5C2aU4zk6jI5yOB6RHH4I6EFFf/oUVkxqHj2xq5PdOwR5BAyOGPyp1Vt6aBxQOeMNB+tcuT631AOYLCtVF2KejvwCbYJx1OO78eMVs2eRc2lHkeshsaMHXEkf+ep27CFVPpcQ0Glm0MZgs4yMBQ=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 14:47:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 14:47:04 +0000
Date: Fri, 5 Apr 2024 10:46:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962
 and sai[0,1,4,5]
Message-ID: <ZhAO4YWuB8r8k+m8@lizhi-Precision-Tower-5810>
References: <20240404161914.1655305-1-Frank.Li@nxp.com>
 <efc9c624-6a31-4299-a604-8aad1d0cd878@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc9c624-6a31-4299-a604-8aad1d0cd878@linaro.org>
X-ClientProxiedBy: BYAPR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:40::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1IoVZKjVrflE3wm/41ljlp3rgDTp6+9lgwyUwEnNdVk+KilnzngkoEOAVVdXhzKS1wt167kl93CfAfBX9VHGLcZbTGS+lXu2goVCUDDznNIf6gQdEeCWnoeTsXIt/KFUSBxpeH5qdRt7qVRLehtKgUqeSavsOa3GgJNQB0pI6NcXf3JkgrRA3iXfonH3HTon9yNQb7uvXsXXekv086OOoa6Ua8aM0pwuxAOhXHYApkwfoDA21rl3QmH6/olU1rRSKAEGQ1V/RHkf2vRcC1PfmGSa5X8AmzpxhwEY9EtwelOSWRqrGkQ307nWlpRaoSbDQo+PIOxaOW0gBIHTpvsVHDSm5RHS0VD44XUZSfHJ4yc+ArGdVcyiAFnC/+gvUfkV049eySFkfL1SiR3Pt6mwbRWWtq+E/pz2aLPWxUdm7oItdT0N76RwzP0HR93JpVV8xH+sRKERjmbKp2IG0HA+NzPouZRXQlaEIZWpQ16mAFOYPxb1g+LPZFeu4nCe0+ygKk5KoEG5PMD0QO4PNwteMR/GJqBAgXwKcOa8sOmkhhIg56A3i0T8Vr76fJdzn2tePKjLvMBhmkjZ/iOYDjAaE7xboLrDvODlZiaf51WlD3rdUv9s6JH4IS2V+u4cLbbYkFHdfPDTSCBItoZTpReoU6PgMrWffryBBeCx5zjBrvxEDr0Rf6gLJZNUlEO87ykTfjiK/7C0mZLqrkPUxBmdlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ta9K4F7TP0vflHC1ujZqjAtTeymW2wtYBBOS34WrMPI9k6wpm3dlBAs69Lo?=
 =?us-ascii?Q?AzOjPAz8yoq9jopYOgV5r4Ozu5XI25AzGQhi8ZxWJUm5snpS1FMasmApvee/?=
 =?us-ascii?Q?av59HQt1nwIB20PLXcKswLBAwJ3NzuSelzGdZ7Gr0exmh7QNUz0m0d+yvTmg?=
 =?us-ascii?Q?03wktVWqk3E08+NLb8gSiLW94AVofDyxYTwDIWH6741aUX/Dp9ssrr5GALQ1?=
 =?us-ascii?Q?YzhcfIi6vdJTc6U4HdfHExOXuEf0Y93sHx6KgDBB3e+/8j9mVi4BeoeeFIXx?=
 =?us-ascii?Q?AuovNh+GsHfQTnZGgAbFPsNnHKd5cOSA3IEfKnWBGg+wkCMlJlN19eUVHF7t?=
 =?us-ascii?Q?Bq7LCbsic2Ynren6dKAjDp6poAxy10WyV4swHLLwVloLK3zYoa5hRknNhfSZ?=
 =?us-ascii?Q?Jlq/cCqlawN61bXBcWZYQIWpr/BbJqFcbNSJ7yRVSLLhH2bEgo0crwDsJbj0?=
 =?us-ascii?Q?pceciQTqHm8whuw9eyijIw7bV4OndonKpx2Vvb4GM4X8Kw08uXZ4OrXvGCqa?=
 =?us-ascii?Q?zxndt/tjaho7iZnnXgFI+HbdfBIZjWEhHH+2TEfYJZz/D5k8+JjAB3SgYKjU?=
 =?us-ascii?Q?NIX7fhb3r2godszwHDAtfQXk9m8F9LsjiyYFga/oH61Ep9yL3SfjfN+556xj?=
 =?us-ascii?Q?A1MlSGFKURP3bZSeWjG6s7VHAQvAIO0zPGNtV6OBnKwk6qBw4tBLWArClxuh?=
 =?us-ascii?Q?kTtB3Topj33Sw/ER5g9HwaP6vL/1yUHFbHZwBHTyHcON/JvUn30jOQo38dny?=
 =?us-ascii?Q?xS0CeyjR2ojIXQAvrwKPlPhEYX6mTwPg159QK0mM33BhbNgZAzgqmgzH5rsv?=
 =?us-ascii?Q?CDzVQBi8UOkkuNwOFdPMn71fTIpEZzlRFRUGgglW09kHf2cZ4GC+20HkGgJa?=
 =?us-ascii?Q?Mt9jX/NYe7xpdgT/rlHop4ul58XJMxDFNwaKRLOB5oy9U+xH5qrt5VfXWTyl?=
 =?us-ascii?Q?fi7wZ2xG7qmnAVb7vS+mIFmyuXg8Hmu722+QCCII9YCAOeSv0JcTqSaBOevk?=
 =?us-ascii?Q?ceFiDZREsdhCjk9/Mgavt//SODCH5KaytBfMNpukPl5WHcKo3RvbfomnjgOM?=
 =?us-ascii?Q?1Km995b6fFhmpf6bI5ov4tTlvBSo/3RTbn5CcaHmuRv3Hkg/By3TJz8l4KQc?=
 =?us-ascii?Q?GvOzrh1ECwFCRVej5socmD4ImFR2RCooh+wNOvxDehw9KjrVCG99IP3h7DcR?=
 =?us-ascii?Q?TcteMDw+3S8DDw+oF26x0dClaSNWbJMlHOlQDj64GurvnOloN1S3GTgAVmfT?=
 =?us-ascii?Q?Gagp7z5BthElNawYzjA5oYjsi82cbvKRrMXqqwbg8SnB9sNy2fBlyS7smiqm?=
 =?us-ascii?Q?7t9I4udMKB7Z+WZ3dcoubnIK3mbpxBmRK4VumMWJ1SKvj42vUYf2TgHEyQrK?=
 =?us-ascii?Q?noIV7aaXSOoebO42VFy9EY1cXMIO4hIs2dwYcsSd5xOM6Y93luOvkvbr5swV?=
 =?us-ascii?Q?TuMbePbEPg+vKAnDg8XdwNAasMDy85nEeB4KjbzGOPKfeXZn77x1+u9q9r03?=
 =?us-ascii?Q?Cw6qSEA/Amka/IsQvRBb9Q6WAmFjEkFMlD8jdZ6nuAAT0zuSoKcCcRLrxnxt?=
 =?us-ascii?Q?lnmt5Cbf0npv6yNuAyvz+jXUS/67ckVn5JGc8OVd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c4e60d-9ba8-4ca0-6e67-08dc557f4245
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 14:47:04.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWUFUi1xx7mh/FkNf+6NR/rlXjsQJW3nImN5USymTi7okeZsFWShpjfsaHdEdedLg2FbDpWmSprb9LialgSOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187

On Fri, Apr 05, 2024 at 08:41:59AM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2024 18:19, Frank Li wrote:
> > imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
> > i2c bus mux to connect both i2c devices. One will probe failure and other
> > will probe success when devices driver check whoami. So one dtb can cover
> > both board configuration.
> 
> I don't understand it. Either you add real device or not. If one board
> has two devices, then why do you need to check for failures?
> 
> Anyway, don't add fake stuff to DTS.

NAK can't resolve the problem. It should be common problem for long time
cycle boards. Some chipes will be out life cycle. such as some sensor. So
chips on boards have been replace by some pin to pin compatible sensor. For
example: 
	old boards: use sensor A with address 0x1a
	new bench: use sensor B with address 0x1b.

You can treat it as two kind boards, RevA or RevB. But most user want to
use one dtb to handle such small differences. For this case, it should be
simple. Just add a super set.
	i2c
	{
		sensorA@1a
		{
		}
		sensorB@1b
		{
		}	
	}

It also depend on whoami check by i2c devices. Only A or B will probe.

wm8960 and wm8962 are more complex example.  wm8960 is out of life. But
wm8962 and wm8960 have the same i2c address. The current i2c frame can't
allow the same i2c address in one i2c bus.

You are feel to NAK my method, but I hope you also provide constructive
solution to help resolve the problem.

Frank

> 
> NAK.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 210 ++++++++++++++++++
> >  1 file changed, 210 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > index 8360bb851ac03..adff87c7cf305 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > @@ -30,6 +30,13 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
> >  		enable-active-high;
> >  	};
> >  
> > +	reg_audio: regulator-wm8962 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "3v3_aud";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +	};
> > +
> >  	gpio-sbu-mux {
> >  		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
> >  		pinctrl-names = "default";
> > @@ -44,6 +51,105 @@ usb3_data_ss: endpoint {
> >  			};
> >  		};
> >  	};
> > +
> > +	sound-wm8960 {
> > +		compatible = "fsl,imx-audio-wm8960";
> > +		model = "wm8960-audio";
> > +		audio-cpu = <&sai1>;
> > +		audio-codec = <&wm8960>;
> > +		hp-det-gpio = <&lsio_gpio1 0 GPIO_ACTIVE_HIGH>;
> > +		audio-routing =
> > +			"Headphone Jack", "HP_L",
> > +			"Headphone Jack", "HP_R",
> > +			"Ext Spk", "SPK_LP",
> > +			"Ext Spk", "SPK_LN",
> > +			"Ext Spk", "SPK_RP",
> > +			"Ext Spk", "SPK_RN",
> > +			"LINPUT1", "Mic Jack",
> > +			"Mic Jack", "MICB";
> > +	};
> > +
> > +	sound-wm8962 {
> > +		compatible = "fsl,imx-audio-wm8962";
> > +		model = "wm8962-audio";
> > +		audio-cpu = <&sai1>;
> > +		audio-codec = <&wm8962>;
> > +		hp-det-gpio = <&lsio_gpio1 0 GPIO_ACTIVE_HIGH>;
> > +		audio-routing =
> > +			"Headphone Jack", "HPOUTL",
> > +			"Headphone Jack", "HPOUTR",
> > +			"Ext Spk", "SPKOUTL",
> > +			"Ext Spk", "SPKOUTR",
> > +			"AMIC", "MICBIAS",
> > +			"IN3R", "AMIC",
> > +			"IN1R", "AMIC";
> > +	};
> > +
> > +	/*
> > +	 * This dummy i2c mux. GPIO actually will not impact selection. At actual boards, only 1
> > +	 * device connectted. I2C client driver will check ID when probe. Only matched ID's driver
> > +	 * probe successfully.
> 
> NAK
> 
> 
> Best regards,
> Krzysztof
> 

