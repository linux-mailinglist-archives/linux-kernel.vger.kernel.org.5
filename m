Return-Path: <linux-kernel+bounces-45194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A99842CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D97928F2D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1EB7B3EB;
	Tue, 30 Jan 2024 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OHghyaGx"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAF7B3D1;
	Tue, 30 Jan 2024 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643006; cv=fail; b=qUyyveOueAJD46eWcxYahG6/+CJk/jlQoyS1nvxsdAvJRi01NSnlnVCpymyYh2q5F1PDB9JBd8ypNQB2haazsCz93f7pNgsFDdSiA9iQjI/JNnXB6jqSaLkWMToNla3EMPINBzPN3kd11dN2CRzdeedV+C6ULWRW6Ex+ePqHcKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643006; c=relaxed/simple;
	bh=BeuVKc7V6MgN65bSmfelaLGvy4HY07zQlvvVP5uGH6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bqA3BYYkiHm7mnzoAmFNxBcKvduSfqtzfyw+JqONZEjscVds7XG7G0VOWYPQ3A8J9eiuKgBDgmfN9SOL8Doe4UQJqVMjjbuMfmMVdHEicVto/ZFMNMEdU260pGgdjjoo/6hQ+hiunfCr1qrywkgjhrIRG6krI2OQhnNpGsikumw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OHghyaGx; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F51cTrFi50lR478cTwYSfctEg0rKGKLEjDwiTA8hUPeSCjNVy8EgF1yHNn7L31aRNNMBi60EV6ifU3TPcoD/2ddI40RbZWC7Mxz+3av5VSV2qKP3WS9dTy8stnX5vE5AX5sbadT/xJxUh8WY37KMeCs3NFu7Wh9qmyM4G3neK27L+ND1fZkCpaFw7s6ZHrccOJas/WjlJBDO1Io3dRse272uT6AH5f43G15vxcpMP2sMlPzsgf26gwut+iKwT1V54Tcmt+wkkJKLmDKiQykiUres4/016hTKf9OTe/l5y9zvki3EiYbhOEwbmolEwrk0mZV5UkgZYCUZzCgk66ZmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlW2/IrnOVuBhUG7+uoAAyLfCUW5Mx8jMzAv92nCGUE=;
 b=MZSQS4LLlw5BSzaoSfZY4XJU7Cn0cE45s5NE2oVjxMBkSlg3kWjayH4Kt44gSNZXQbELf4RSA8OiyU3fXpjA/uK/Kh2hIxQr9i2hvqIkuV/0JV/DsajvLDd2hYy6DF4Zr+Zp15FrSiwq2s66Uf8FssXpSv3aiL5K+w9cFb7eH1TGY2v68S0JCzQMnJjRyFkpCC4wBGXybhElYwq2dPntRrDAp6Tc1Ubp94b36JKV4NBmAllMRCpCjqIgmlZhivdOGowq23OwYHZ5RoOKzPUpcrwAemAAKNw7f6xzsgO4uVZqsmHhtoq5TM3l7XXB1QLVtH6ZhR8qUvBuuVuGN82JNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlW2/IrnOVuBhUG7+uoAAyLfCUW5Mx8jMzAv92nCGUE=;
 b=OHghyaGxtTG5+Bu7YIL6gTg41q1KOZpD0JRdurHgjy2JKrSowD9quQN7VF9HlgIe8rtb7KwjS11Y7pjn1Mypx2cNpmNeVyl1Unf3vefs34diSqJ3MLGtvcty5f53YyonVtZ/RXdsTvIHLE2Q2lrEvHq+VA71WJzRF3Wdwhfata0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:30:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:30:01 +0000
Date: Tue, 30 Jan 2024 14:29:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, ran.wang_1@nxp.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <ZblOMQLhtD1Y8j5d@lizhi-Precision-Tower-5810>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
 <20240124-video-lumpiness-178c4e317f5a@spud>
 <20240130181322.GA2079185-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130181322.GA2079185-robh@kernel.org>
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec58fa8-4509-4231-b922-08dc21c9da65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2xZKnfpNCF0Ang1Vtzcy6rwOkz1TSgOqq3FC0WNL8R9BhXMNQdwBGSuy5vvcQfezT46IQCO8yIFSpV3s0DAwjGK8xr9xSaWMDocvB9WnQwLOrbWxoQRVdN2ljRyCUL8b9YPdlRlty+M/byOONeNVt22XBy/cnaNTW0F5SpN2MYNvWfn6sO/ZBngAdVVY7kDyptEbhAuV17bNpYJeKmPm+88w0HZnYSIoPRtdOnVoXwSznC4OVNX3sigXZZbNBPvvgXXF+oJKrTJFNw0N5WM8cXlg3bdFlOITxhoz3VX78WX4PDnXPhc1XxwHA5VTEah8C3CVVsonhxgA/3Qkv763967oV5pOYCwEAjLoHtjSrpYpABef2zTZF90dBOFxXlSOdYkL9pgQEC0NX+Boc0pf89ORyrbgAWVu2UejcRFBods90SB1jQD/S9DWqFKn69pMNCZknSJlOkCFR6bbzKIGCzUJvVZqay95qOqV1SNcNFfMOHk6LHJdsTfjTjMzolSsaQDhcSnqCuBX/ji8W2EC2mnV41GKFmkoMHttoWZzxN73cFeKZiDA0S3hJkfIQ/eynpU82Xw+eRdjIquohfwM8ysJMJwdmpTB8ePrdJawKtexZfkdl/2BnoQkdQfVCaAIfd0yIfWS25bFrF8pL/AqeThCJCu2evwm2sxt0DqoekE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(376002)(366004)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66556008)(54906003)(7416002)(83380400001)(41300700001)(86362001)(38100700002)(33716001)(478600001)(8676002)(316002)(4326008)(66946007)(6916009)(66476007)(26005)(6486002)(6666004)(2906002)(9686003)(6512007)(6506007)(5660300002)(52116002)(8936002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9goPFkDikZcJMSuQUJl2bd/bjD+V/MkhD039jRcR0b3habGMJKwyKpAS+t94?=
 =?us-ascii?Q?ZxavVY2yqHbr+SaBmJ+IAihDVDxjRNuZqjsUBDcTfnO4L3fDQXJtpfLf9Wuu?=
 =?us-ascii?Q?8L75fO/HiCzkfSpQ8twcGiTVlFFVsPWOawpkSOmZQX8yk3SidccQR5KD8tk+?=
 =?us-ascii?Q?f/mVoPWKJzI8exl+hBziPwN88I7oPZB/sY1nWlEeMAXFTNGtaDdnoT5ntUCS?=
 =?us-ascii?Q?ZmWlrVDioDzSBAfS58FV1YQHGG69s2mZ4q2Fos4MjE4s0feZ97WqyNLlHONh?=
 =?us-ascii?Q?0b1ozDjQmwftNwUzMqICapWZKHkGXUfnCHxutE3BmEeiaWNSb0BrkoIDu+vE?=
 =?us-ascii?Q?ZCLeLOfX0nnbjZ6biJVGhkrIeY+J1IVQr64HmsVroU0hjNyDzp7u0AVukrie?=
 =?us-ascii?Q?yk3dr8ZU4sl1Dydi5K+9YwD/U00cw8ieKMizrOIoKb/qFlaH5yKYCjSftPgj?=
 =?us-ascii?Q?NJDKEOGpqJdlud4+P/dzGKG7RfOjLmKcmzv0ojZZGf5/myUFx2kvlDkKUjiM?=
 =?us-ascii?Q?QQ/GdZHVCbEtZJnTmd6Fcoo/FX0HmlGH6dPIblS7GK/xEtrRAY/0HQC8/i+R?=
 =?us-ascii?Q?m/nHLMyV0MxE0hV26EpWQtPQkeBIVTyd4BwCLJz8hwAPY/6xJ+0cPaLgHCEB?=
 =?us-ascii?Q?3sKYBpzJGZpgfxszocLILSwvIifk42ezwz2nYylHPniT+mDpJCCcST72FB8X?=
 =?us-ascii?Q?v5zWj7YM8uBEJTAvk2Lf65wZDAXN/Kx5EH74hYumWsW5RXgHgiD1e0kSUf0M?=
 =?us-ascii?Q?Qvd7SyL36ksrvSo4ZpQAQkFHgKubADYKKdN9p2BnKqN53wtbBZhIhtZf8d7x?=
 =?us-ascii?Q?nWP6RkhIsDAXFe5cbKxc5p0PP6XWg9cIVlThrHHQ1bXZq4hcMAO3632GWZgd?=
 =?us-ascii?Q?g86r4GpSESYfm/rkdFtTCVhr/QP88KON62uKzw8xzjkTlq3lnK+/oGTV/WZk?=
 =?us-ascii?Q?KCJh4FrVAgGv0hoWLiiIwIMRZk+c5wfCLGSeajB2mQ/2ugZ12UovlV4yU2Ul?=
 =?us-ascii?Q?3VJ30ET8ha5wtI912eRKUGkJyAxThN3I9IpVv9heojTiQp2Dc+3ZPzzlFUaX?=
 =?us-ascii?Q?svU++FEaJQf6PZ6KzXft3do6iki6LkKe/4d/uU/N84FGAFBM9VrUfc55gHZ1?=
 =?us-ascii?Q?W7rrWIyf4WEpJYf5rHpV4KMsvJwOh5J5ihVU5WjWaE09SbsHChhgkpQkh2A4?=
 =?us-ascii?Q?+gZW4qop9IJGdPg0uZM8Xp6ILwJ6hnc4+yyTK6nHjZGefcIZkME71o8QPY8X?=
 =?us-ascii?Q?Vgaxb0eLuap9q64i0n0ArF8U8e83p+VEkiN4MHs5r98/CJnfcWi6sKhXEex3?=
 =?us-ascii?Q?WZcdkuqmoKJxHTPrlqKK5HwUbvAqjy/GYWPzYftI+CZe7/HN/ih9GQ+ArBiy?=
 =?us-ascii?Q?S7H8/jTu96Nw/iHXYdcYOLCnzlFcfJwiF6OalBZu8MUul32eYSX/0JEudzTn?=
 =?us-ascii?Q?sgNlaQSCdU8wdF5gl+JvwWPLeQv78UeCa0BKvb8VcGxCH17EB3Mr7BrTaZD9?=
 =?us-ascii?Q?tMzAQ9wZLOyNrV8BGekmpqtyfyikWOoeYmmfisuRJYGXeK7bftIJ6P1p+XUV?=
 =?us-ascii?Q?WZM0TnG1KE8C3pCJLFUfQ4MM7UT+MIguZXrkMGue?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec58fa8-4509-4231-b922-08dc21c9da65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:30:01.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBogE1ho6VpHFc9XiM78BDsvFuRwuI66k+qnfHxPrkyVVNiM+eoo+uNy2eTI93dZ/y9S+G+4BenSiEfT8Qv48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

On Tue, Jan 30, 2024 at 12:13:22PM -0600, Rob Herring wrote:
> On Wed, Jan 24, 2024 at 05:59:00PM +0000, Conor Dooley wrote:
> > On Wed, Jan 24, 2024 at 12:47:14PM -0500, Frank Li wrote:
> > > On Wed, Jan 24, 2024 at 05:36:42PM +0000, Conor Dooley wrote:
> > > > On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> > > > > From: Ran Wang <ran.wang_1@nxp.com>
> > > > > 
> > > > > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > > > > (or its control signal) will turn on immediately on related Root Hub
> > > > > ports. Then the VBUS will be de-asserted for a little while during xhci
> > > > > reset (conducted by xhci driver) for a little while and back to normal.
> > > > > 
> > > > > This VBUS glitch might cause some USB devices emuration fail if kernel
> > > > > boot with them connected. One SW workaround which can fix this is to
> > > > > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > > > > host mode in DWC3 driver(per signal measurement result, it will be too
> > > > > late to do it in xhci-plat.c or xhci.c).
> > > > > 
> > > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > index 203a1eb66691f..dbf272b76e0b5 100644
> > > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > @@ -273,6 +273,13 @@ properties:
> > > > >        with an external supply.
> > > > >      type: boolean
> > > > >  
> > > > > +  snps,host-vbus-glitches:
> > > > > +    description:
> > > > > +      When set, power off all Root Hub ports immediately after
> > > > > +      setting host mode to avoid vbus (negative) glitch happen in later
> > > > > +      xhci reset. And the vbus will back to 5V automatically when reset done.
> > 
> > nit: "will return to"
> > 
> > > > > +    type: boolean
> > > > 
> > > > Why do we want to have a property for this at all? The commit message
> > > > seems to describe a problem that's limited to specific configurations
> > > > and appears to be somethng the driver should do unconditionally.
> > > > 
> > > > Could you explain why this cannot be done unconditionally please?
> > > 
> > > It depends on board design, not all system vbus can be controller by root
> > > hub port. If it is always on, it will not trigger this issue.
> > 
> > Okay, that seems reasonable to have a property for. Can you add that
> > info to the commit message please?
> 
> But if vbus is always on, then applying the work-around would be a NOP, 
> right? So you could just apply this unconditionally.

Supposed yes. But I have not confidence to apply this unconditionaly.
There are too much difference SOC and dwc3 version. Not sure if it brokes
something. I think it should apply workround as less as possible.

Frank

> 
> Rob

