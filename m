Return-Path: <linux-kernel+bounces-94345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C3873DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F501C21041
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C213BAF9;
	Wed,  6 Mar 2024 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kFhaOoEI"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE5133425;
	Wed,  6 Mar 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747122; cv=fail; b=SqLfTfVY7xNQGKsvzlcociaXyusHeKC6CKpHThsi64cqwB4AkrQenvRI3OPonvW59uTBZCOqjY+9OsvOoqJc7ZnmlwwKUHsqz5mFtLgKpym3dE7dHUUqte7LE6RITEU2rD2urBsvasuq0FtZTudwlSHXf3U/3xGZekFDPxkbfXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747122; c=relaxed/simple;
	bh=DuGFYb0GYUPYH6cBi30AfkLA4VTzwGYojo+Njg7Y8z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imgF2bLT8iT+LXgpRCbhdqBfgjZQ4PD3kF6oJgJpbwdlgxymh90IyIQJKltiD57PXi020pG//StPP2J+C6sNT4CB7ApQ4kDVYa3GnJ3dJeOvAe9Mh+49eloE4V4p/54lFbypLKIhks3vSzGYXF+PVYnRaR6YXP/inj9Ty+wyJOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kFhaOoEI; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN+D5MnQSrfE471r4/N+CtuUdaGu3H7eIFHubZGytZO+60laKvWb8d2jEgZTVzCSt/rUokCI4YI24O5wfmMCe7/lxbplGPUKCAuDS/zVbw0dF+Zg1TVkePOlVnMzfmXErue74NZUL8+D4iJ3JnaJcvz4a0jvVIDkpaUU4wT4KCWobiC1B9t/CxwJTCfq2Pzp9k0TWIeqF2PTDCKB5kQKDvAO6qM2+fvbRchQgEUomE6MmSbHAMvd1SVMZZhz9MHXBYj8h8wo0DcdJ19/NlNmFJUvv5jBzMfBnj88ZtnruZOaiRkPtR8bldFOtHTWWRrgPxjkXpkUf+cCJ1Zt5qKVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD3y0WSMFYRZjeRlwUvlzeCDkEszK5WtZEqGdMFPTbI=;
 b=dmbPaJ8X5ZoMd+8IU/4VdntaJWogBrciVMPY0A8gTb3Wy3sNiANqj8eq5188ZB9GqhdnaK5i9a78A4+d+D80RmqbKUncd+NwWgvsZrSMmlYWnP4IhrJPbny++LXsoBnYtFsUve+QUcXMYm62yqGBGkCBoo4NvJckc/YqxTW8UAj841PEIsg9MMOOt0HW4+QIutKR9pKcC5q/xFUUXgpEjLQo7b6nYktuT+8JtodZjWZaKwLTgExt39I4ejjegqmHHsz9dYJak1aWUdJl4lBCx2QYSSQrNK5r8Uilh8AMC1SFGOBIhTP276El6UXLba6JwogAnYXLB3V8XuMnw7umdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD3y0WSMFYRZjeRlwUvlzeCDkEszK5WtZEqGdMFPTbI=;
 b=kFhaOoEIK0x6I0Z48+rKNxMHi7XvZVC4YCLLvY016CM60Shid3EYjCuoHgC7xzo5uwA1W1tPk1JK8BWl5u+/mF7DJHKP3uE/mB1CWkTgbDo4J7ISklkVQRGw2kLkwigMvF/KFxeyVP6vzbcUdixF1du30d3q5I1btbi88f4Mehk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7243.eurprd04.prod.outlook.com (2603:10a6:102:8c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 17:45:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 17:45:17 +0000
Date: Wed, 6 Mar 2024 12:45:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"joe@perches.com" <joe@perches.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"zbigniew.lukwinski@linux.intel.com" <zbigniew.lukwinski@linux.intel.com>
Subject: Re: [PATCH v7 5/8] i3c: target: add svc target controller support
Message-ID: <ZeirpIpcsPuBAiIR@lizhi-Precision-Tower-5810>
References: <20240205233326.552576-1-Frank.Li@nxp.com>
 <20240205233326.552576-6-Frank.Li@nxp.com>
 <SH0PR01MB08410A70ABB956DF9DD4DE25F921A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SH0PR01MB08410A70ABB956DF9DD4DE25F921A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b7c992-98b2-41d7-a336-08dc3e052f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lC3MJIyolfYekxnwJ+6nDh3qDdUAXogby2LTY/j5qy3xtIZRfPSDn1r/RYDEFMOSvsrFYJ5biiVvoz2RghQh7oLx4MH7k8L/2sx/zpQtqBTnpadqGefPWqPO2NmHPFTSiGP44NDnJnDCmXLiZxpOj6QNpfFkCeiAGl9uwHzX5klZrA20bgDK7kHsKR+ZuLg1vca75Yc9XhBvLN3RJTufGoO57W/0OKxqDt4fojzWUZ/eFJol45mL+vyNe8PXPRr4GAJd6sKtGv+uBwxcz2BqQAxnP0Wrvlp3LVHzLCVG18CXNptZ0zKXZBMle6APuDLvgCJ+fyeo/5uSvdq/sbzNvn38IG91J0QZ9j6mCpEtOXZFxrHsAS5If0cBhfeSsJDgKgvqoFj6e2lRcmvpr9C9uwbQGScPnDnvcxCFvxWTh7/GDJspQXs+RcM2OLbtCYgoZPIdr8DqFNbFy9culAo1/isEq0vtnSMkiVL9LEmwKVqT8FMfSMGENIBoauKRV+LhWmZ0N4qO3QKSliijJA+kvhuPO0Brrig+pXzApibwaSQvUYCWJdqeCvnQUI9LU09xT+Stmmc0ZjYfLTGvnZBYajdxdQrIt7DUmZt2yOZLMMS5dFIcFr0Z4E2j9XCDsHfP+T/F5RSNPJZE2/XIF7jiARzs2pARk03UKZU3+uY58kJ7NYIMp3ag17k1GDBKv4zVeQflpiSBUxrvwCx7iakdFPtUP4HA1YIMWockYYtBUis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2IZFBL+jLBiZoDB1hIHlyDt3Pkecr7SUSOTsBeGKhIQvo3PDtqxaKRK3M4C?=
 =?us-ascii?Q?r9gfM/myjwBxzGhLuW3DlSN9qAV4G+8x79FsP5AwS0jH2rmh37B2Expe4FXs?=
 =?us-ascii?Q?RnLMZXoTWjbIQk/AE1B4PNWGDqplvucdQ41lsD3OveizDJfFMDBJS18tz/WO?=
 =?us-ascii?Q?dCat6+exOwKBG6cXLDz7NRKb3SPlUkkGbVWXK8bS5WlZEe3d5ZFzOGbSKpYN?=
 =?us-ascii?Q?hwtXjtx3uQp6TunJmHX9E+suTrxZIaOstl87Zmw/7GiEAvFat68+7Xkbr3am?=
 =?us-ascii?Q?G0us8LTSRrjSJnHKDZQndk1MKzO6J6Sktie7MDcBsfgN0U65YfPVQexcecbE?=
 =?us-ascii?Q?nDd29Z55/tQQG/UsqeUK82CtvkPD4fO2T3L301rMsV0lNxybRQ2QD61MM96v?=
 =?us-ascii?Q?xhLmfNERc6i8dgR9hK5WNJNLRb3X8hI+pDSGU8KT3f/xpglL7sOAkIF8ufyY?=
 =?us-ascii?Q?RyPSZukROhQzn79yZN0PY4uU0Yz34rryMCVhfs9QEp9LWQLfuTfO0HHW+38y?=
 =?us-ascii?Q?7el1cWsUUpd0CmylzpyhNujYHH+yPnA3PiPKKX66TBsaP6Mv7FqNWsrUwPlz?=
 =?us-ascii?Q?qsDujrqOMH0SSakotlUbmzWo2FgBe1iB2RyCDUucvnDotMGpAACXkpwihYmP?=
 =?us-ascii?Q?9jOv5Gws/S1+bwzW30mQARsCWzBvdkmRMqHu8Z5NQWQotkPDJBFfaR9gzPJ0?=
 =?us-ascii?Q?K6rc9XdAaLFhez7459aX7y5TD0SELsJ8txaujYb/n9a7zJw8Q6Q3eGo1bZtt?=
 =?us-ascii?Q?Z6yRBzoaK2jtEhvCIU9RmIl3lUrNjWTLeG5l9/a6QVuOkstJMCIX+mPFKG7k?=
 =?us-ascii?Q?RIXkrhrmaBn6hpBC0TJSIITVd9lerFCCbjqcgB+npnhmufeGI00McrWWX+Yb?=
 =?us-ascii?Q?xjDDnXK/rHrOkVmv9ROBUxEY5pVNKJI2mgfeoh7TXBzaQFusu9NkdrDuI5D7?=
 =?us-ascii?Q?iaBAhuDGf4/BX7YDePGcCRjhXsUxbtMorkNymDWkftFtIH6fa+CHJrWgTUX6?=
 =?us-ascii?Q?/KVRk3BjsjOyZVDgPttMQxdgDnucZ45VFJHmWHZEQjNC1LP0BqakAGy7pStq?=
 =?us-ascii?Q?ftq8EqjsgvfjtcALsU8A5kEiLW/TKcPjBddoe8BVlUU5kQPYCFqF/9kYOrlR?=
 =?us-ascii?Q?WNUKfyNGMVDvgOshr+vMMic/mR+fc21lElSggbHoZ5vGviNhota0lq6x7MYE?=
 =?us-ascii?Q?90l9kBfXzIQijbMd445m2SNdUC7QhywkKQtvqwiRo1//dLZihS13Ze+hijmm?=
 =?us-ascii?Q?blcjxN4Hnjvew8VN3XT3tj3ntl9ov7zXp4OEx/dtO5+1vHrqQTsyN0pycMzI?=
 =?us-ascii?Q?PA2l1reW6epCWE6AX18WpggBej3EvawsTs6hvieSjzULSgyM56aQSWE6lfsr?=
 =?us-ascii?Q?Z/FK0hBXQYqlC1vmQS1HXOG/HGdUyUf14GIKn0eZhXjgnT5WILTUrdOx51el?=
 =?us-ascii?Q?FTq7+Ef7oFfkN0jEoCJGsPhfnPrprF03sgUZ3PdX4jqMteAGvInp6dR68+Oh?=
 =?us-ascii?Q?jhcCFRK+Ux/CHF1jZvIGs+58xNVTBIrEVAnB2NCMlCAyNmhowmmz37STdPEt?=
 =?us-ascii?Q?I++aO3khKZwbB4rEqzqmjvOxj+GTiuoZlawXiH6F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b7c992-98b2-41d7-a336-08dc3e052f97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:45:17.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG9S7bqeGBh9sPjheOysWrrKYjbGWyJc3kfmGG2zvjsKF+nUyNq5k5cr5hkF63AqbAy+z3mslQ8c1VRxoZGgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7243

On Wed, Mar 06, 2024 at 04:01:17PM +0000, Joshua Yeong wrote:
> Hi Frank,
> 
> > -----Original Message-----
> > From: linux-i3c <linux-i3c-bounces@lists.infradead.org> On Behalf Of Frank Li
> > Sent: Tuesday, February 6, 2024 7:33 AM
> > To: frank.li@nxp.com
> > Cc: alexandre.belloni@bootlin.com; conor.culhane@silvaco.com;
> > devicetree@vger.kernel.org; gregkh@linuxfoundation.org;
> > ilpo.jarvinen@linux.intel.com; imx@lists.linux.dev; jirislaby@kernel.org;
> > joe@perches.com; krzysztof.kozlowski+dt@linaro.org;
> > krzysztof.kozlowski@linaro.org; linux-i3c@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-serial@vger.kernel.org;
> > miquel.raynal@bootlin.com; robh@kernel.org;
> > zbigniew.lukwinski@linux.intel.com
> > Subject: [PATCH v7 5/8] i3c: target: add svc target controller support
> > 
> > Add Silvaco I3C target controller support
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v2 to v3
> >     - fix build warning
> > 
> >  drivers/i3c/master/Makefile         |   2 +-
> >  drivers/i3c/master/svc-i3c-main.c   |  35 +-
> >  drivers/i3c/master/svc-i3c-target.c | 776
> 
> I think putting target mode files under "master" might not make sense. We might have to
> consider that we may have a "secondary master" mode. Some other ways of splitting
> or handling of target mode is needed here.

I think name 'master' is not good here. Previously only support 'master'
mode, it should be fine. Now many controller are dual mode.

And I3C spec use 'controller/target' instead of 'master/slave'. I think
'controller' as master are quite confused. It can be master controller
and slave controller.

Anyway, slave/master may share some code and resource, even only one file.

So far, I think it is fine put under master now. we can rename 'master'
later when more dual mode controller added. 

Frank 

> 
> ...
> 
> > +
> > +#define I3C_SCONFIG	0x4
> > +#define   I3C_SCONFIG_SLVENA_MASK	BIT(0)
> > +#define	  I3C_SCONFIG_OFFLINE_MASK	BIT(9)
> > +#define   I3C_SCONFIG_SADDR_MASK	GENMASK(31, 25)
> > +
> > +#define I3C_SSTATUS	0x8
> > +#define	  I3C_SSTATUS_STNOTSTOP_MASK	BIT(0)
> > +#define	  I3C_SSTATUS_STOP_MASK		BIT(10)
> > +#define	  I3C_SSTATUS_RX_PEND_MASK	BIT(11)
> > +#define   I3C_SSTATUS_TXNOTFULL_MASK	BIT(12)
> > +#define	  I3C_SSTATUS_DACHG_MASK	BIT(13)
> > +#define	  I3C_SSTATUS_EVDET_MASK	GENMASK(21, 20)
> > +#define	  I3C_SSTATUS_EVDET_ACKED	0x3
> > +#define	  I3C_SSTATUS_IBIDIS_MASK	BIT(24)
> > +#define	  I3C_SSTATUS_HJDIS_MASK	BIT(27)
> > +
> 
> There is couple of space formatting here that requires to be fixed.
> 
> Cheers,
> Joshua

