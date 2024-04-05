Return-Path: <linux-kernel+bounces-133163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A9899FCD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B20E1C22BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8DB16F293;
	Fri,  5 Apr 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MjMUcPS3"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2127.outbound.protection.outlook.com [40.107.104.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95016F0FB;
	Fri,  5 Apr 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327491; cv=fail; b=ovglt2QCMZQVYdn8IVJxrmyxr00eX3CR6+giEJe12FaiKtMR17MInY2jwV/85M213pkHWQ+dq09HsoQUBuTXCh6SvtO1jlPloENWUPpnInGLQ0F12O3S6dfGX779yWNr4wDG/mbI6WHCKEVaCm/W6DDh1Bmg0NvX+7FhVZSowIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327491; c=relaxed/simple;
	bh=ZkyDbPSt9J+mjkR/YmBmmhsR0kFc3f/ryUPYMl/VJ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aqkYCGO1u+uRl6zt4JXtCzSBPfsBApObx2tPbLj9b9p4g+S9xeOz8oRUQlupU/e7C1u4mbJERzacxYFSn8LT2kaouHvOqHPoMh4wqOauVtRaWbekokDawqcu9zajIHjSM3K+KipuU4e9khGaaGUPZWsTex19WecOfBHEIYXHtfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MjMUcPS3; arc=fail smtp.client-ip=40.107.104.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLXRp7ZkheXYegxL0+94yILbGJ7WWdZoo1yN/lUFPwDuqC97Jr8Oid/FgVE0KmN4dgjV1u1D4EQFxQe9NnUKOn+zFZy48qbLWzyQJ1wFpURE4RSsJZlql+yKxuhXXaatbyRQXn4FUW9apUJuNN8oOOiWnupzzEDRgcSU5VJ59KG1ZGc5EVmaYWW6Pfc4+wCBPbUuxnqJYcuDNMddPEdBzUOaLEnTa/tNzV382eBDdKewKRMJmzX6p7Cx4Xl64NfpoibUVGHCP9avEp0nZ35FOfM2bAJPpcS5d+L8gYNSyCPj9j1g5AiTx/+3q90SfbxTu0aG6mrXoBQkTwuWwiZNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8oG/xyY1y6rQSd4iY8dIMktqwje1r/aPomkB6Z5YGg=;
 b=ENJ5VDunPoHWq7FHOh0tp4qQyBkY9sqk/LHNj+C/r9tiorhVl9zhhGCFZG2Sf4nC+bamj7xTVd97iyjUO1359Cs6XXiAmYQ3PuVSh7ruoHvZsrbI8ky/DtnpU7G4vfDFvXrv2bpMKHHxaK+6uDf0VrkX3tLdMUV6481de3NCBehIEHCNsEPX7pJU31OBQD+BUNbzSDMSRv8TaK/BlYRtBmRuzYfOUlryUahpdHnje+zNIuDcmwCUYCrAn5QVqsnB0EtshJY7ma7UFP4C8Xtd4OpTcEWDOt9ShwGV6+F880MJs3dvUZHpA8gKTKaRi+8Y92zKXK9O08chFR2Wa2m64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8oG/xyY1y6rQSd4iY8dIMktqwje1r/aPomkB6Z5YGg=;
 b=MjMUcPS3RLwoxKFCAYj634pOymxbygSlirqXGLN0Ovp0ZBXI8Gij5IDQsIbcSEXKTXKD2d5HDC5muxrynUAGjbX4YnnKhOlmmiiRVAiqCByM0Ki8qcGSjUqsOcvWF2KZ6tQYeD2t9D6uadUx/Zr0GILW5qwxpKgoqAuAHwdNwn8=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6946.eurprd04.prod.outlook.com (2603:10a6:208:186::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 14:31:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 14:31:26 +0000
Date: Fri, 5 Apr 2024 10:31:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <ZhALNGyNTAzN86GF@lizhi-Precision-Tower-5810>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
 <20240319-pme_msg-v5-5-af9ffe57f432@nxp.com>
 <20240405062426.GB2953@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405062426.GB2953@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	THlDhrmixRXwMWsfORUKPiLpj35O/ijX9IWHhaZUGsWpWfrFw0Cj/jVfq6OCxpMl1RppgHXTBl3FWnoueEIF8SXHNy+yfW3GCCU6tiqfRVo3xwkE9M4FYrmNw2ag56QwSSOuJ1x8pw2mg2sc7yZFvAdrCmmz+iY8O/Vp7FVkwdQgJVF3RZ4YiIyPx9OO7sE6q4x2PmXTeVyJWniMSDucd3lpwB/kTub3C3V0VrabGl+/EKskGN+fqpbrSxtrc1LglUAVbMWk3qk53S9kBztY+Sz2JhrjYA/CdzYPdKeno4OKCLSNiasYvVeDvfIL56VXEiwDGBja5oOuG/TJ1BhV1pDD2KD53DTfnHew84Pp9Rdi/FftXGXBa9JFcPU4pgix/B1oWkWKNDdBzxZuBOy08SBqvfwFgDVNljiHbmmO77tax7thoMO1WZmo9lLPBnx/8chcQaeiSXtqRt/g3cTpGK4anHb2lzFwyBRH7cSoQEql3o96vVAQ6aYlpfQex+0ku7zw8OS/MXpRK+Amh65zoaHzHAK/0tHL/8ORSUdgXHi6Q6z7t1Sr7uhR0/u7pR+KKmVVYvFsd7v+L14nkjSF6hqOwTiO6ho5DIwoG2/KVKXXdwvYh9NNH4HEemxFfcw1JjTuNgmNKKpyHUyvc8ClNr9D6iQQO71RjJNlRucVgGoVlT1zb+MkYVpNI5+SgA6Ia3mpOZM0+pn6Nhl3DQML/G4/daSvDL5DUJmdAFk+3vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VitXZEpFSGlsbWhYQkxIeTFzakpJYmFvdlYyaTFPVURROUhDNk15VkdvTUpx?=
 =?utf-8?B?VWpJcGozNncvN2dSZVA0dXBKd21Ranlyd3JSOEdtRTZHM0VpU0RmTGRoS3Bi?=
 =?utf-8?B?cXFmakpERjR6elVidUZWemtudjBONVJndWg5TGVEdWtESE5uTlBxc3BWajA1?=
 =?utf-8?B?ODBVYkpueTg4cU52RExUWWRzUnNiZDErbHRLZUpvVTJlMHJ5YmtZNkdRbzZZ?=
 =?utf-8?B?aW5SdnhIMXpYTFlZQysyMDRmZTh3ZnRKZXRpUHZrVXY0aFlabnU4QTVpbUF2?=
 =?utf-8?B?YndVSVF1cllodWwyRzUzVFA0dXlLZkRsbDg5TTAxNHBOY3Zsa2U5djVlWFJJ?=
 =?utf-8?B?S0tDQ1JFdlFTVE9WTVRUTE5tV3NKUmZWdmVTYlN2YTNPZGlzZWlDOGQwTlVM?=
 =?utf-8?B?aU90T3BKT092K09qa1JIelhUK1JvaEhELzlmT2VGdk9JQTIrSDRDVWt0MFph?=
 =?utf-8?B?UHpIdmpYd1Q5eWQyenYxREN1OGY5R1FRZDVRRHZNeTg4RkZBV3Q4UmZlOEdy?=
 =?utf-8?B?S0lBVEhRS0NSMUFqbXdRUzlEVnZUek9HRmFwMENjTkdmWHVnWVZOaitabW9t?=
 =?utf-8?B?ZWdvYW15Mkw1TVM0alc0bnlYTDlud1NKS0NwdFU1aHAyaS9RUG5LU0xOWUlT?=
 =?utf-8?B?QUJhSWtOMGN1UXBuM2VkaGRXeFFIYW9tZXhHdHhJYlI1L2ZRZmQ4dXpoNXps?=
 =?utf-8?B?Y0lOdElJMS9PSkV4Y2Q5V1lqMjllMFJySXgxMTR1djhyNk5SRzNFM0VycFR5?=
 =?utf-8?B?Y3hUaWNxbTNvM3FMa2tWdTVBSjczNGpEb0owSzcraHRlTXFMSTRTNDBzWm96?=
 =?utf-8?B?VmNIUkJ3SnpWb0ZsdE0zOCtjN3FEc0UrbXF4Ky9WVkxHMC9oYWhqWjM5YU9i?=
 =?utf-8?B?Uk5DNkh1Ti9aNCsvZFlTc3BFeURRSFV1a1JKVTZsS282dXBvMUorNnkvZVJR?=
 =?utf-8?B?MFNEMkRvbk4wRDVkOE92VzJQbjlhV3o1VHI0SXFOV1hDclM4UFgzSDkxM2V2?=
 =?utf-8?B?c0pOaVVML2VBbUJVUlM2OWo3TVJTc1JPSGtydisxeUxrSEhyc3dxVVlsazNV?=
 =?utf-8?B?UEsyeWJOTW5MVTFTdDdrb3FLSTRFS0c1dFo0M3hnQXJORldWVHVnMnZaSS9H?=
 =?utf-8?B?YnphVkZIdGd2bk15dFpuM21KRTRWOWpDUlpON3JkQjdSZ0RTUjVqQUlvUUhL?=
 =?utf-8?B?M2laRzFOTnR3SlhkZUlpUWRYcHZTMHJWUXZCZC9UZk80bGJQV1F0YXMwbGtM?=
 =?utf-8?B?VkxSNEl4UnFDd3c2Nm1IN3lPb2R4WjVod2JkUERYTVFhMUVhSDhTNFJYd1ZX?=
 =?utf-8?B?TFVYbzgxdEJWczB1UDlmZzNTWk1NVVk1RUd5bHBGcWNGMERnWmhyZDBvK0JL?=
 =?utf-8?B?TTYzbGxsNS9uaUhucDRwSHIybnZkdXY5a1BtbU9IakE2MWVkSlNkL1hvVU0z?=
 =?utf-8?B?VjJzNVJITUZqT09FcnpWZ0gzZ0xBdlZOTXZ3WnJUQmtDSDI3Sk1XVXhwamVz?=
 =?utf-8?B?dE9FUFZvbDRMQ3BNeFk4R2pkMStndXQvdUJxT1pyNjZsa1pxMlhjL1djak42?=
 =?utf-8?B?YW9vQkJ5RzNpbXkyalpHdEt1U2ViTFJBODRrUkJaSUZJdlJvL1M2ZWpZVzVj?=
 =?utf-8?B?Uk1kYS9CWUJQc0MrSDZuc2RHVGtzQWpMOG9sRDc2bUxnNzF0RTdlWmlwMWpM?=
 =?utf-8?B?Q09QSERjRHJXT1pwbk85blhjNXM3YUZRcXhONUp5SkZhWTFNMlVQWnlhL3Bv?=
 =?utf-8?B?NXRKRmtPclk0RHJ0WkYzZU1JSVY5Zll0SW53NW5KVjZwN2VtbjBqTFpoVUpD?=
 =?utf-8?B?WlVHeDgrdjVTdUlXWkxsTGMxakdnUmRuRHNuTHlxQVpQWXZCOStoTXo2RE9l?=
 =?utf-8?B?MlRDQTQ5dEtSSWliUktIVGN4TGxBZlNWUXNad0VMYnozY3p3SXNOc1h6SU9s?=
 =?utf-8?B?UVk2UFNPc2VrYmN3a0IwVS9mUWlTYUczNUhmemU1aTN3OW5Va3U0RjcvWHF6?=
 =?utf-8?B?U2tGZlI1ajllY296Qmp0ZndoN0h1RVUrS0djZ01lSVFBdDJxUDhoWHMzaTZH?=
 =?utf-8?B?RG1ndjkwOEVTUVVEczFlenArVnNIRVhadmV5aENrOW9JVDAwNUlOSzNHTVI3?=
 =?utf-8?Q?ldv7P2/Fogbrn46ASptPQykEx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b629c676-1634-44b8-c444-08dc557d1368
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 14:31:26.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HUgMFUU2hph1Zqx7wb1NFR9Xzx5YIwiE6wa9TMXpWDsju7BptMUdt4E7Zgzbi5hd7kAvxuJGAGnvOfyp/8cIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6946

On Fri, Apr 05, 2024 at 11:54:26AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 19, 2024 at 12:07:15PM -0400, Frank Li wrote:
> 
> PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off during system suspend
> 
> > Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
> > window. This space's size is 'region_align'.
> > 
> > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > can trigger a PCI message, such as PME_Turn_Off.
> > 
> > Add common dwc_pme_turn_off() function.
> > 
> > Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
> > dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
> > exist.
> > 
> 
> How about:
> 
> "Instead of relying on the vendor specific implementations to send the
> PME_Turn_Off message, let's introduce a generic way of sending the message using
> the MSG TLP.
> 
> This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
> at the end of the first IORESOURCE_MEM window of the host bridge. And then
> sending the PME_Turn_Off message during system suspend with the help of iATU.
> 
> It should be noted that this generic implementation is optional for the glue
> drivers and can be overridden by a custom 'pme_turn_off' callback."
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> >  2 files changed, 93 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 267687ab33cbc..d5723fce7a894 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	return 0;
> >  }
> >  
> > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct resource_entry *win;
> > +	struct resource *res;
> > +
> > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > +	if (win) {
> > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > +		if (!res)
> > +			return;
> > +
> > +		/* Reserve last region_align block as message TLP space */
> > +		res->start = win->res->end - pci->region_align + 1;
> > +		res->end = win->res->end;
> 
> Don't you need to adjust the host bridge window size and end address?

Needn't. request_resource will reserve it from bridge window. Like malloc,
if you malloc to get a region of memory, which will never get by malloc
again utill you call free.

> 
> > +		res->name = "msg";
> > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > +
> 
> Shouldn't this resource be added back to the host bridge?

No, this resource will reserver for msg only for whole bridge life cycle.
Genenally alloc resource only happen at PCI devices probe. All pci space
will be fixed after system probe.

> 
> > +		if (!request_resource(win->res, res))
> 
> Why can't you use devm_ helper to manage the resource, since the lifetime of the
> resource is till dw_pcie_host_deinit()?
> 
> > +			pp->msg_res = res;
> > +		else
> > +			devm_kfree(pci->dev, res);
> > +	}
> > +}
> > +
> >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -479,6 +504,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  	dw_pcie_iatu_detect(pci);
> >  
> > +	/* Need call after dw_pcie_iatu_detect() before dw_pcie_setup_rc() */
> 
> It'd be better to add the reason also i.,e
> 
> 	/*
> 	 * Allocate the resource for MSG TLP before programming the iATU
> 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> 	 * on the value of 'region_align', this has to be done after
> 	 * dw_pcie_iatu_detect().
> 	 */
> 
> > +	if (pp->use_atu_msg)
> 
> Who is setting this flag?
> 
> > +		dw_pcie_host_request_msg_tlp_res(pp);
> > +
> >  	ret = dw_pcie_edma_detect(pci);
> >  	if (ret)
> >  		goto err_free_msi;
> > @@ -536,6 +565,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> >  
> >  	dw_pcie_edma_remove(pci);
> >  
> > +	if (pp->msg_res) {
> > +		release_resource(pp->msg_res);
> > +		devm_kfree(pci->dev, pp->msg_res);
> > +	}
> > +
> >  	if (pp->has_msi_ctrl)
> >  		dw_pcie_free_msi(pp);
> >  
> > @@ -697,6 +731,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		atu.pci_addr = entry->res->start - entry->offset;
> >  		atu.size = resource_size(entry->res);
> >  
> > +		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
> > +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > +			atu.size -= resource_size(pp->msg_res);
> 
> If you adjust the bridge window above, then this won't be needed.
> 
> > +
> >  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret) {
> >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > @@ -728,6 +766,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> >  			 pci->num_ob_windows);
> >  
> > +	pp->msg_atu_index = i;
> > +
> >  	i = 0;
> >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > @@ -833,11 +873,54 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> >  
> > +/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
> > +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > +{
> > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > +	void __iomem *m;
> 
> *mem
> 
> > +	int ret;
> > +
> > +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> > +		return -EINVAL;
> > +
> > +	if (!pci->pp.msg_res)
> > +		return -EINVAL;
> > +
> > +	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
> > +	atu.routing = PCIE_MSG_TYPE_R_BC;
> > +	atu.type = PCIE_ATU_TYPE_MSG;
> > +	atu.size = resource_size(pci->pp.msg_res);
> > +	atu.index = pci->pp.msg_atu_index;
> > +
> > +	if (!atu.size) {
> > +		dev_dbg(pci->dev,
> > +			"atu memory map windows is zero, please check 'msg' reg in dts\n");
> 
> You are already checking the existence of the 'pci->pp.msg_res' region above. So
> shouldn't that be sufficient enough? Can the size be 0, if the region exist?
> 
> - Mani
> 
> > +		return -ENOMEM;
> > +	}
> > +
> > +	atu.cpu_addr = pci->pp.msg_res->start;
> > +
> > +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	m = ioremap(atu.cpu_addr, pci->region_align);
> > +	if (!m)
> > +		return -ENOMEM;
> > +
> > +	/* A dummy write is converted to a Msg TLP */
> > +	writel(0, m);
> > +
> > +	iounmap(m);
> > +
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  {
> >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >  	u32 val;
> > -	int ret;
> > +	int ret = 0;
> >  
> >  	/*
> >  	 * If L1SS is supported, then do not put the link into L2 as some
> > @@ -849,10 +932,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> >  		return 0;
> >  
> > -	if (!pci->pp.ops->pme_turn_off)
> > -		return 0;
> > +	if (pci->pp.ops->pme_turn_off)
> > +		pci->pp.ops->pme_turn_off(&pci->pp);
> > +	else
> > +		ret = dw_pcie_pme_turn_off(pci);
> >  
> > -	pci->pp.ops->pme_turn_off(&pci->pp);
> > +	if (ret)
> > +		return ret;
> >  
> >  	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> >  				PCIE_PME_TO_L2_TIMEOUT_US/10,
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 703b50bc5e0f1..dca5de4c6e877 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -341,6 +341,9 @@ struct dw_pcie_rp {
> >  	struct pci_host_bridge  *bridge;
> >  	raw_spinlock_t		lock;
> >  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> > +	bool			use_atu_msg;
> > +	int			msg_atu_index;
> > +	struct resource		*msg_res;
> >  };
> >  
> >  struct dw_pcie_ep_ops {
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

