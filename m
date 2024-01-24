Return-Path: <linux-kernel+bounces-37586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407883B223
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99761C21A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF713342D;
	Wed, 24 Jan 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X7SYcYpr"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFB6A004;
	Wed, 24 Jan 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123855; cv=fail; b=h14hccwfUVwJVnb9PDyIn9QNIItxtOAjFuqnhG3gWluoT4DGPGjSUbx0a2cn05eByh5JCci9DBeebEJRmXFjaZNQKwtOKzlIK8cR6pb/jkJLyjJv2rhQxJyvCuqbcIm3b8H9hD7RAXVGLB4HEc/avCnEZX/Mu5DaJ0IAnwGTBwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123855; c=relaxed/simple;
	bh=4sIFmmStZYQDBQe9dphds9sUZcLw/8CDAU9cNkRZ5Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAGL6nspydBDVpsDFoEXkvUCwUVapf0E4CCf7kOzOZ1X5O2OgGLosc3STCqi5S7ggTtV26PoKtM1YHXHndu1pASOAZ00ij5KrXPK9RuAt6hnP8NK1nB/5hynTgutH8mkRF3AWatlR968k/5y+uqkA1VD3b7aMZR+d80M6T60lac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=X7SYcYpr; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZi33zKqJMmx8YF/iN4INcd0BL6ECQq6vSh1hhyKoyBH+8ZwbLQVMq2ifLeW9V2JOTLPbn9dsLllZcqkGc4GWrBcRpx0Jo0mNDpjrbIoK6O5EAs5t6ggaEQRXYN9HZpTnn6CvkONhgVYNUWKeID4UHshTnfJWgojs4GyRr5g6l40KZQ4LThbSEhBKTwdNWlw90EfiAGuqYoOCXN5q2D3RNCCpWGsAx2ss6HBDVgZ7ze8nFCUTFKuC9gyhnwknNeJlbfbiXsabTWYb4v7pQvkCBgeHr6MN2TDZsjSoGsKFxz3+a3xkxvBQcoWl2NW0vf4h9cjZyI+OTkzo2IRISe5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q992kzM/sPoX7UYEyQdJmbbflSDpkchG/s7GDsYQxa0=;
 b=enp/OAhVnHt3oIzoG2l8VLbMjglMZc9a0fMRoXSzNLnKpIPi0aRpEV//rBRRPdk2rsDC4T1iY2KNai/azUI0YuaWWcUGsshS09iOjRjhGS91sESoeqnt/MUkJhxGrJ6S7bcfQXgTl9I81GMMdETXaPR+VDKBSTdAUjEPizBp0zIkEG6TnaT8xwaFsEQAKBZK2I5RGnAUzqtov+M7IbvjyDd86SQXgQoeXXA7jHJvJJj6LDjGjw0bwXer06lM3PHDZyMpSp+4lnbWGiA4ymaoFzO8PZy6kDX5UiQtpgwsUVaZYNoF34iGgG73mlVf+1CahazOA+agQLp/dPWbDQgdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q992kzM/sPoX7UYEyQdJmbbflSDpkchG/s7GDsYQxa0=;
 b=X7SYcYpr4EbmtgSWF75F2yEbY1KW8frE0tqbotbg3cSkYsVuw69zC4/9pKkvT+sirppluqX8U3uR9JGGkals4nfXJDqEpnvzOgGjVXp6y+MoM/1Gc1ptfqHkPmTleVktuSrrhG8soUu3djeB9LpoNC2czO906JxU0xT6V8YHUZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 19:17:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 19:17:30 +0000
Date: Wed, 24 Jan 2024 14:17:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: ran.wang_1@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <ZbFiQmD1VRVzFSa+@lizhi-Precision-Tower-5810>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
 <20240124-video-lumpiness-178c4e317f5a@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-video-lumpiness-178c4e317f5a@spud>
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ad719a-5efb-48a3-c9a8-08dc1d111c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C36gswx+nbQkqmy3Ojvx3muQGMWhsrPgdxjIua6nYbnVdWrwajBmwk0DjFHBHy6W3HSantm/vaDXgNd2AaTKjKOqDmIHN2SggqywRfDtpp+vrDXC6XfjtehPO8JddzjQiEar3+No5A+Geo+KJ7X713lPESqC4qQmh5vvWFq4+kcM5Wnve+NNrugzDGWeKYuxDRSmggwFIuk/3VBb7m/fUIK2cAIchOCE9BI0U8xypaupIEFNn5IBe8R/+oaTJV0GlEE/O3+a1URxCVVfJwDIu6RUPjDiNCIeHgi12d7V/WoGeo+e0NttwsSkqE9RY82h0AmFjE5apvPgWDjTb3JqlxwwU1M2M9a26m0SWGg6+d77i0cYGHW+66qYcfarvWSO5CgQ6FLDPvTBLUfhosr6cQD00dzS/3dDzR7Orxqt8hH9ofJugnd7H9wFpxuu7gDE1K7ipIFdd2kRd8JSr292xGryXVMUWhHDCKkDd4tP6gIghsCgAwZLUrKMw2TXIH3vj+LJht1nVIIm9JVnp8qX4OFRv2iaYdNBWa8NIroS5YzyP/d9+2wjuWXgkr33jpxY06gNe8/QeATIVp7dEvsNbo2WoFYpP4JrY+5CIumZWOIjZO1RdW1nGH01IPfUX7UZaotA9dahEIo/psHaJUznPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(316002)(54906003)(6916009)(4326008)(66946007)(66476007)(66556008)(83380400001)(38350700005)(5660300002)(7416002)(38100700002)(2906002)(8936002)(8676002)(33716001)(86362001)(41300700001)(478600001)(26005)(966005)(6486002)(6666004)(6506007)(52116002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EbMfxEQNwJf/3I5PBvXGN4y4ta+Xa/BO3ejyENQqdDFwpjVssOPzLa+gplPy?=
 =?us-ascii?Q?yvBk4A8vTZxp3JEtF7MNSpiBAxXYsErApqGksIxcVf+rY+lDgjcUIpZ4tUkc?=
 =?us-ascii?Q?528rLftgjF8rax6RA9UEQLMRvhVz+oJMscyWMJ2jKp3JCzaY7w/1wNK2sWZb?=
 =?us-ascii?Q?ZoIzsnR6fL342YpzQl4P4VulzDZj4W+C4nC6J6IjOfinNfUdCZv2aigSlcdH?=
 =?us-ascii?Q?7BxJl7ecbgbfKgruyEW6sOxndn5BcqzjfKfJOe9fIiPtEixxfxBJB8I2JSD+?=
 =?us-ascii?Q?u1/s/FDD/IEY9L/NvDvsk/sqMvI/6d8H2UZV4xPvzdxK56667DGkOO+7lCPL?=
 =?us-ascii?Q?VwFB70fy4fyN3Fj2JMf/king/prVJZ/nyAkfFkHn24iegp3EBTf7NKxoOanU?=
 =?us-ascii?Q?4HJ/OfVusCNlJVFhav+jT3m0Ld08vz55KaXUp4otC+wPmbM6NY8gLGhuQp0R?=
 =?us-ascii?Q?7w0wFFhoknxlJR7JamYL6rk7Z5DKR/mI9ifSLh+6R2L3dkliuCvAIMxEfScr?=
 =?us-ascii?Q?VqnjN2/9gm8/HYXts9QXMH7mSW9jtyB0+rsvprpclMiCPRMmT8AIlDvZhB19?=
 =?us-ascii?Q?vPDfgr4yyOWjKm4YiY5JxSnNi17okp6uxmOa7EXuYGApM6faQoh8iONT5Cd5?=
 =?us-ascii?Q?n1vpAOM0LrecY5oKeXbPVJ/y5L/XB9VHP4mjlN83yGhcH4Dvo9X3/7fziGbP?=
 =?us-ascii?Q?kZb3wEd6fJWRv5UT+UaG7/eOIdA8LwxvzSNmB9FRnI+9H95jeRBWhH+Rg1y7?=
 =?us-ascii?Q?3BoTuezfz0qWmD65xgFfjQ7AJI8mxcrEwBebbQh+m4fSDhYNU7mTbBscAuG0?=
 =?us-ascii?Q?BZXkyNl6rXEIPW2KjKvWwWwpzK/m+yJySFNkgYlGih7gNAFC4t6jRdW32PBx?=
 =?us-ascii?Q?FId8+tkl8xcFQpPYKsSfydBPT7IbLcS/O0qdn/KG3+o5Xu9ePcfviBnCUp+X?=
 =?us-ascii?Q?29gwHaiwBAmZv9na9bYtbeRM6MbsChUbIr0yyz6RkT60CJLqz5oRdVV7U0J5?=
 =?us-ascii?Q?YouKJcb/nLJHZeSYQQ18B2so2B9LmhvK1FhYkmtkoeAMaOYBk04seixCx5aF?=
 =?us-ascii?Q?r6TPNvwXZRo/X4y7wNYTcIksNmUQzPZNU+k+nw9xBXuaXqC9IThkzlAAEcwm?=
 =?us-ascii?Q?q0k0zZkuPZnAuyjiJD0DWqcs48Xvc6X1KrPl4V6Cy65hmU8b160fNm5412H0?=
 =?us-ascii?Q?/Wa0iRD/3Lwqrdh55K6EFeSq5U2zhkXB45O99vEooc4hQZGIx5E0gAILO1V6?=
 =?us-ascii?Q?OtDByBBPwGAB0UXbbxgmQQVjq+yVRb3b7Ov8AamRqNEgbvv65AeU2F8EqV5r?=
 =?us-ascii?Q?CqlALtFDdfTjYMizZ2SQkvHrmJecRvPhNIVkoNHZPW93GfQ3IznZshAr7DSr?=
 =?us-ascii?Q?e5542rxDsflFwbcAba79dkO5q8LVkQNohsxnh/C59GDXMJBqup0OEsn0q4el?=
 =?us-ascii?Q?LzvkcGY+2kpxm9RO13COvjh69iSkqwRQSzsYfGzulAhgmNoBe0ud+67ojSfL?=
 =?us-ascii?Q?tsN+flFPUGvCYpbsB4Zkvn6/zybS3tOn4ZrCPqBYNboYlQTywZkqPaPlatbC?=
 =?us-ascii?Q?Q7RH7zZ0wnMsxHOpObPdA8hvmIdzcMtLnP/hInk3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ad719a-5efb-48a3-c9a8-08dc1d111c2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 19:17:30.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdqG3q1RqhadmACZMZZyKWgeNCdsn6O8Lu98g/VJIJ4GTWWL3I8CB+p1e8L1//Jll9DxZpBbrtvBNMDOGHcNDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

On Wed, Jan 24, 2024 at 05:59:00PM +0000, Conor Dooley wrote:
> On Wed, Jan 24, 2024 at 12:47:14PM -0500, Frank Li wrote:
> > On Wed, Jan 24, 2024 at 05:36:42PM +0000, Conor Dooley wrote:
> > > On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> > > > From: Ran Wang <ran.wang_1@nxp.com>
> > > > 
> > > > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > > > (or its control signal) will turn on immediately on related Root Hub
> > > > ports. Then the VBUS will be de-asserted for a little while during xhci
> > > > reset (conducted by xhci driver) for a little while and back to normal.
> > > > 
> > > > This VBUS glitch might cause some USB devices emuration fail if kernel
> > > > boot with them connected. One SW workaround which can fix this is to
> > > > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > > > host mode in DWC3 driver(per signal measurement result, it will be too
> > > > late to do it in xhci-plat.c or xhci.c).
> > > > 
> > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > index 203a1eb66691f..dbf272b76e0b5 100644
> > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > @@ -273,6 +273,13 @@ properties:
> > > >        with an external supply.
> > > >      type: boolean
> > > >  
> > > > +  snps,host-vbus-glitches:
> > > > +    description:
> > > > +      When set, power off all Root Hub ports immediately after
> > > > +      setting host mode to avoid vbus (negative) glitch happen in later
> > > > +      xhci reset. And the vbus will back to 5V automatically when reset done.
> 
> nit: "will return to"
> 
> > > > +    type: boolean
> > > 
> > > Why do we want to have a property for this at all? The commit message
> > > seems to describe a problem that's limited to specific configurations
> > > and appears to be somethng the driver should do unconditionally.
> > > 
> > > Could you explain why this cannot be done unconditionally please?
> > 
> > It depends on board design, not all system vbus can be controller by root
> > hub port. If it is always on, it will not trigger this issue.
> 
> Okay, that seems reasonable to have a property for. Can you add that
> info to the commit message please?

By the way, I sent v4 at
https://lore.kernel.org/imx/20240124152525.3910311-1-Frank.Li@nxp.com/T/#t

How about add below sentence?

This was only happen when PORTSC[PP} can control vbus. Needn't set it if
vbus is always on.

> 
> On another note, I like it when the property name explains why you would
> add it, rather than the thing it is trying to solve.
> Named after the disease, rather than the symptoms, if you get me. I
> tried to come up with a name here, but could not really suggest
> something good. If you can think of something, that'd be good, but don't
> stress it.

snps,host-vbus-glitches change to snps,host-vbus-glitches-quirk.

How about use below description:

When set, power off all Root Hub ports immediately after
setting host mode to avoid vbus (negative) glitch happen in later
xhci reset. That may cause some USB devices emuration fail when kernel boot
with device connected and PORTSC[PP] control vbus in board desgin.

Frank
> 
> Thanks,
> Conor.
> 



