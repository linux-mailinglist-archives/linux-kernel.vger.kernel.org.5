Return-Path: <linux-kernel+bounces-110328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B6885D49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F901C218AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAAB12CD8B;
	Thu, 21 Mar 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lt+x7Q9x"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286612C7FD;
	Thu, 21 Mar 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038006; cv=fail; b=kocE6+GxmqD+ixvjrE49SoV5X9u27EcjNlt5EIjh0uG0AzEVXlshlszLBBWp8Z8X++BK1hF73uZvYh1xrP5/yeJWJ2vawDp1lNsCLcOI6kNVUeMwmqU3rxi2MCmasblArumSE5C1/LNI4K4uoTEPVZwgP5tV/BxTot7EmI+RAg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038006; c=relaxed/simple;
	bh=kgyEMPgonUWzJycOIvpnxat3X9uV5EKzET2KLq+f85Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SDqtRmRzg59YTk6qKcCl3EsU2lDoPhI6YnYPJQF+/DaYCmQ4PkQCS0aS/eQb2o1TNzr5Lw8Kp6YkHPY1YClLw2nM2V34xlQjyKZ9R3A2JpE3HGS/nG2P+ebjprp3STd0TbZj3ZWAUzRmVtYXlGimQc1GgEv6FQmw75LZ8iZyosE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lt+x7Q9x; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1yQSKxhK20YPcSVBUMdsY6XLiEzNJNwRqdScw8FQeIbWlGAxHOoMfSW6InA3FPOCAK0cSn42ANt7jIv+39jLB8+mqEXntPH2kqQuSd+lWIKnEKOdLqd3YoIrSyY+WT6onC259BCNspXOCS6CS2RtJcR5Tl9j/vPQpW28u8Zg7YcpVlj+wX+vrnoFDBEp5uc4uompVAkNtKDcUPoTA0k58FootLYAoOCWkIlDmlLnxAMLX0D43JrqQVJtmufkLnHkTbclwx91mBsSxGwfCq7m7ixYWtohGjAnGco7JHvh5/OyWvcd3mjBHllHiE97Uk6/i7n019SgVnY+pCl1X5fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH/8o4PzqpqetapH2IywB4EqW+94SU8e2yQxvsXqjo4=;
 b=jIYeLhqv9H3ZOnPA0EI8Qh0OkcRCEa3TRR54baMvgJBbF57uXwSpVDt0ICVI/jXS0P+8BYNTRA7s7EwX+0HwXD/k4X1cBwpQtNFYyvRk3OCYpsCOgIInISr0/xV4BjexyuFMW2GmPPp086oN/TfsTZyczB6TBzvU/FJ5m2HthrouRumk42z1ureruHsfWbZt1f1NgVMJ8eEVTBMFqnWxB607eKAycMSSH8qP0F9pa5yMYankGxOJndafdeo7OeNf7e/hrREUhGr0TEwZ3eNtsQESfgzY5yw4ijzzrEg5BSYAg9cuVBnibv/r9vhcQNVlexUOBWcSRdVYDQsl4i2VpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH/8o4PzqpqetapH2IywB4EqW+94SU8e2yQxvsXqjo4=;
 b=Lt+x7Q9xYVr+B7Q0yKQ9IW4q8LfUNfjGtEmvE8lR3QJqpItZIstjN3DPUnsp2h18sY1sYPDO6MdimaBItLejCS5H7LFy5mUiC0lWH5WOKV60Ra1HuQHZLYstpLe6fT9kF/rtlMC8wyBrymI1i9XLjjpLvi7WIY1gh/zv6tSYQhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 16:19:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 16:19:59 +0000
Date: Thu, 21 Mar 2024 12:19:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to
 yaml
Message-ID: <ZfxeJ9dAXtfYW7Qq@lizhi-Precision-Tower-5810>
References: <20240318194535.2274543-1-Frank.Li@nxp.com>
 <20240320152435.GA1753500-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320152435.GA1753500-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d31cf30-fee3-4b4c-a274-08dc49c2c0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZNKUrIZ/rcWF6XAZWEqqjt2c0xDzeYXrXOO83CTRcO4GN0EtZXDb7wOBUByRmunJGaiSVwbkq1RORrjfQx5CI5R5qN4FXEwplVIIiU5eLrKZHr/Y4a2VwL4TvHSZFjTv/y3Jae3b9Mya6RHY8J2K7+kZg68m883UP+Vyxal03JxnhplsQ3dIntPQf879SEN1KW/oN0ZVI21V3lSGPhSl/tIRFt+N3UhFA8EE4e834qxJ2I2PYDGf1Fi93YQUnuIykE4IGA7lUFbG2YuE/Axhu2bUglQcPT7XFwMqTfQ9G1woYl06QaOTfEZHphBQZo/1sa2pj5vjKbJvg3JRxvlfYR2aT/vh6Ue88nKIFoT84CPt/pPxPzizURP8mF2LFD9s7EuPh4FFB4LJyHAq/qG+eZ/EfbRs1bQmOeaPV7Ldu0/pzi2oAoHmRwbIRt1G/SAp1L5fPeS60S4eB+oR5xoBJtCraUiQnYLLHmqxFAe6pQPqciMeWjpLBqWLcweGIxCfeXlA1E7PrED9G9LR1yG7opC5HQxGUPMGFMmRlUFalB0GWSpgCHPPa03X1xIfx4OKT2zg2MVn13IHOHnU881ppgf/CKuINOGQnG1DLdqS0wcDVW9/Pax/pBLcCP+qb/UV1T/g3if46BbjaNWNf7Z5Nw3jF9vmL0hDoqZUkEVMOOI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8XXmDZy+eLahiKkreg/QGIJFQwNIhjU2zgvzZN/q3UYpPpHymQzXD8GaOoP?=
 =?us-ascii?Q?ozCFsinW+kXPBRpFuO2DsZpS1jVhCMR3Di9yFFBE++ChroWyymhE8Y/glxRH?=
 =?us-ascii?Q?QpJwY9GqyTEiALbYZ55/gPcDUqIvFU0mUqHz8m/aiLltlKYHb6Q6i+YfctwB?=
 =?us-ascii?Q?I80YrIn8EEj0AysX3aQqKw6KgQFN1Aj1rwPc+6MmHMeaFY2GS2/zcHQl0VWi?=
 =?us-ascii?Q?nGuvUAsjV817X4DrJcDL1j4P7mQgvfgw2HuVlB0ww5es3Fdh90AnH8eBixCL?=
 =?us-ascii?Q?Rx0SiQ20xoT0R4u1kxnmuoeNLOfpNsZIkGkFdtP7hLY/08zJYol6aeu6/pMs?=
 =?us-ascii?Q?M85juCdXv2NX5QctacOol+pHBv9OIP9L4fCMdztDkiR12HToVJTRtdC5DY+i?=
 =?us-ascii?Q?tT7meY7kYu/a+gC/CnJscpu3wEpS291X83nVuISEItsH5z13973HDK8K92lr?=
 =?us-ascii?Q?6LJMaHo/TY62s8d3DysqbXMnhmTIPnyIm/v/+c2X5veO5hhgEN1aeoHBw6TD?=
 =?us-ascii?Q?z9bEc1x89sy/EVuiIxeOA6KrjyAmFv5JQ4lbOE4sM61frzpQ87yg+sRYzH4U?=
 =?us-ascii?Q?Er1748IQTREylUF328HM1nTrxmnTOe9D0m6tafwppabwTWBMOMJKdePAlhBR?=
 =?us-ascii?Q?c1z9LLl2zc1L+nU/pBbr0LLuMyywW9+mEXs/loRGurbBksWJS7G8C7EfkYWo?=
 =?us-ascii?Q?iHslB7tR4E3EsIwPptqwIMOODWa1IvOLYUB4HRnjqmp4MuChF4vi2Whmz4lf?=
 =?us-ascii?Q?hQMTwyTTmpmkbhFFfRiyXJ5fSCh+M7KDoiPrhKJmN+1DsfW/ESym08+I6ZW8?=
 =?us-ascii?Q?9H/FKZXT9ZsIIoRNUws7Gyw6Gh7EknZxsERYDLEq++RB0/Rt2elsqOdv3gBE?=
 =?us-ascii?Q?HR0lknwRpd6P6k/z+bigJgvb7RhVUrXp6jcRSE0tmR7b1FBw+2UTMNVVVPyh?=
 =?us-ascii?Q?Y44v0cgwDhPgQLkSD5P5JqaTIr0XcrzdufvHJUv1G+oNWXURUJEBIedH43m5?=
 =?us-ascii?Q?cVw44vto1tpgrPRMMRmdROYCyXr9mPZHUTsW2ZaSePCaQ1jGArWIdWXrBfe1?=
 =?us-ascii?Q?/NJ43PuPOrbufGER4vg6niMrSHqJegH9RG46LH3e6bzL/jUN4C0tMuU/rza8?=
 =?us-ascii?Q?1mZbgE5ZMPgyQvfPBVSPvOxi+Y/CBh2jjpJzWa9ALAAMx6Y7Fc/sPSFnONL/?=
 =?us-ascii?Q?bzxbZtOaNRPuVysi6+JaMASDb4+N6/zxWcbzgGacxedaNIxQl66MKs+6JaoQ?=
 =?us-ascii?Q?YO2xvJiVtdtvU2hUIDGeh+4po9JeXzM9kzjSxFGpydmzNdILdwhZAHK825KD?=
 =?us-ascii?Q?fTCtgKV5c+2m6XxXgGfYm6MwgNiOJWu4bxzERDG1liSALkQs0eCCfuL6BC/I?=
 =?us-ascii?Q?FfwjzpBo/kOAorhlP4G27Vei1aj/eHqYZ/EXsXDxkjSDUMSNwRIRLbI2+niv?=
 =?us-ascii?Q?J5qvOwkrLOpYa1QEpW+S63ORq8AlM89qiwZTvpoivGnuvIeI/CpLuIXaEVSP?=
 =?us-ascii?Q?jAP21DWurv2/3MyYHU0rCLRHN9YQgyMGFCt/flwdOg7mCW4jJ5FAdT09itC0?=
 =?us-ascii?Q?9ZD1HmmxUgwCO52Uo8aHslS97IO4GoBzzK/2SBFl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d31cf30-fee3-4b4c-a274-08dc49c2c0da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:19:59.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMUuI1ny/KlbKt/lOJOgTLjp7QZwZyfr3B+JPXw1Pt96c2Qaqaezioe0zYKnU3xU7Seow1PbDPOMdVunGw7KcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051

On Wed, Mar 20, 2024 at 10:24:35AM -0500, Rob Herring wrote:
> On Mon, Mar 18, 2024 at 03:45:34PM -0400, Frank Li wrote:
> > Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file about
> > esai part.
> > 
> > clock-names 'spba' is optional according to description. So minItems of
> > clocks and clock-names is 3.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Pass dt_binding check
> >      make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
> >       DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
> >       LINT    Documentation/devicetree/bindings
> >       CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >       DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
> > 
> >  .../devicetree/bindings/sound/fsl,esai.txt    |  68 -----------
> >  .../devicetree/bindings/sound/fsl,esai.yaml   | 110 ++++++++++++++++++
> >  2 files changed, 110 insertions(+), 68 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.txt
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> > deleted file mode 100644
> > index 90112ca1ff423..0000000000000
> > --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> > +++ /dev/null
> > @@ -1,68 +0,0 @@
> > -Freescale Enhanced Serial Audio Interface (ESAI) Controller
> > -
> > -The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
> > -for serial communication with a variety of serial devices, including industry
> > -standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
> > -other DSPs. It has up to six transmitters and four receivers.
> > -
> > -Required properties:
> > -
> > -  - compatible		: Compatible list, should contain one of the following
> > -			  compatibles:
> > -			  "fsl,imx35-esai",
> > -			  "fsl,vf610-esai",
> > -			  "fsl,imx6ull-esai",
> > -			  "fsl,imx8qm-esai",
> > -
> > -  - reg			: Offset and length of the register set for the device.
> > -
> > -  - interrupts		: Contains the spdif interrupt.
> > -
> > -  - dmas		: Generic dma devicetree binding as described in
> > -			  Documentation/devicetree/bindings/dma/dma.txt.
> > -
> > -  - dma-names		: Two dmas have to be defined, "tx" and "rx".
> > -
> > -  - clocks		: Contains an entry for each entry in clock-names.
> > -
> > -  - clock-names		: Includes the following entries:
> > -	"core"		  The core clock used to access registers
> > -	"extal"		  The esai baud clock for esai controller used to
> > -			  derive HCK, SCK and FS.
> > -	"fsys"		  The system clock derived from ahb clock used to
> > -			  derive HCK, SCK and FS.
> > -	"spba"		  The spba clock is required when ESAI is placed as a
> > -			  bus slave of the Shared Peripheral Bus and when two
> > -			  or more bus masters (CPU, DMA or DSP) try to access
> > -			  it. This property is optional depending on the SoC
> > -			  design.
> > -
> > -  - fsl,fifo-depth	: The number of elements in the transmit and receive
> > -			  FIFOs. This number is the maximum allowed value for
> > -			  TFCR[TFWM] or RFCR[RFWM].
> > -
> > -  - fsl,esai-synchronous: This is a boolean property. If present, indicating
> > -			  that ESAI would work in the synchronous mode, which
> > -			  means all the settings for Receiving would be
> > -			  duplicated from Transmission related registers.
> > -
> > -Optional properties:
> > -
> > -  - big-endian		: If this property is absent, the native endian mode
> > -			  will be in use as default, or the big endian mode
> > -			  will be in use for all the device registers.
> > -
> > -Example:
> > -
> > -esai: esai@2024000 {
> > -	compatible = "fsl,imx35-esai";
> > -	reg = <0x02024000 0x4000>;
> > -	interrupts = <0 51 0x04>;
> > -	clocks = <&clks 208>, <&clks 118>, <&clks 208>;
> > -	clock-names = "core", "extal", "fsys";
> > -	dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
> > -	dma-names = "rx", "tx";
> > -	fsl,fifo-depth = <128>;
> > -	fsl,esai-synchronous;
> > -	big-endian;
> > -};
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
> > new file mode 100644
> > index 0000000000000..9e31283933d1b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Enhanced Serial Audio Interface (ESAI) Controller
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description:
> > +  The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
> > +  for serial communication with a variety of serial devices, including industry
> > +  standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
> > +  other DSPs. It has up to six transmitters and four receivers.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx35-esai
> > +      - fsl,vf610-esai
> 
> Alphabetical order
> 
> > +      - fsl,imx6ull-esai
> > +      - fsl,imx8qm-esai
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 3
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    minItems: 3
> > +    description: |
> > +      core:   The core clock used to access registers.
> > +      extal:  The esai baud clock for esai controller used to
> > +              derive HCK, SCK and FS.
> > +      fsys:   The system clock derived from ahb clock used to
> > +              derive HCK, SCK and FS.
> > +      spba:   The spba clock is required when ESAI is placed as a
> > +              bus slave of the Shared Peripheral Bus and when two
> > +              or more bus masters (CPU, DMA or DSP) try to access
> > +              it. This property is optional depending on the SoC
> > +              design.
> 
> This description should be split into each items entry below.

I am not sure how to do that. 

items: 
  - descripton: abc
  - const: core
  ....

I get below error.
 properties:clock-names:items: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'abcd', 'const': 'core'}, {'description': 'abcd', 'const': 'extal'}, {'description': 'abcd', 'const': 'fsys'}, {'description': 'abcd', 'const': 'spba'}] is not of type 'object'
	Additional properties are not allowed ('description' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#


snps,dw-pcie.yaml give example

items:
  oneOf
    - desecirpt: abc
      const: core

allOf
  contain:
    - const: core


but it lost clock-names order restriction.

Could you please give me example about how to add description for const
under items?

Frank


> 
> > +    items:
> > +      - const: core
> > +      - const: extal
> > +      - const: fsys
> > +      - const: spba
> > +
> > +  dmas:
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  dma-names:
> > +    items:
> > +      - const: rx
> > +      - const: tx
> > +
> > +  fsl,fifo-depth:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The number of elements in the transmit and receive
> > +                 FIFOs. This number is the maximum allowed value for
> > +                 TFCR[TFWM] or RFCR[RFWM].
> 
> Not the normal indentation. Should be just indent 2 more spaces than 
> 'description'.
> 
> > +
> > +  fsl,esai-synchronous:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: This is a boolean property. If present, indicating
> > +                 that ESAI would work in the synchronous mode, which
> > +                 means all the settings for Receiving would be
> > +                 duplicated from Transmission related registers.
> > +
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If this property is absent, the native endian mode
> > +                 will be in use as default, or the big endian mode
> > +                 will be in use for all the device registers.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - dmas
> > +  - dma-names
> > +  - fsl,fifo-depth
> > +  - fsl,esai-synchronous
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    esai@2024000 {
> > +      compatible = "fsl,imx35-esai";
> > +      reg = <0x02024000 0x4000>;
> > +      interrupts = <0 51 0x04>;
> > +      clocks = <&clks 208>, <&clks 118>, <&clks 208>;
> > +      clock-names = "core", "extal", "fsys";
> > +      dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
> > +      dma-names = "rx", "tx";
> > +      fsl,fifo-depth = <128>;
> > +      fsl,esai-synchronous;
> > +      big-endian;
> > +    };
> > -- 
> > 2.34.1
> > 

