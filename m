Return-Path: <linux-kernel+bounces-73837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D627F85CC40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE32B22619
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64661552E3;
	Tue, 20 Feb 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EOBeukuU"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8876414;
	Tue, 20 Feb 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472977; cv=fail; b=XAhKYdLqupOuvDsg+N1BuURLOXgGPQkwvC1h2Olyi1p+ZjxlFU+y2kaTsl/5OaNwBHAmaZyjp4WGVQQi9hA0NVREX90wEQUOPPfdKU+GnUnZtdrC0pajGSLfAj3XYa3RW/ED5lAB6/Vv1eAzqmKj3ldRg/pmqYEFRQ8zV+Q1dL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472977; c=relaxed/simple;
	bh=lg4cWZ8lF3pcWIuD1AEvCesPM+D+wNC3Yb1XXdkPey4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BfQMR0AmWwYkEjgmC5ZjmGFmSDL8E50VFV+wfTGgGTK3ViRXEcqK1Z3CkCJxQIkPmq8s/V4R+BjwaPs6z4v/Uj0rEZghlvw2flBitZrxd39P/hbBEwS8sfxXkhlYRXmVKUwrLOk2NhRdZabE+dQqqdJcChDLXSvZQfpOK9UnreM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EOBeukuU; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Piru8LjRHIEPXqrVriIYKjHg1AznYTAAcsxJi7hXVCblpup9dr5ikW+qA0CT3B1IMI1fxOjOljFsAJxZnqXclXGifN+DbIxvDtbpGOgMWftzMEKZ3ft+gYHKC+L9kU1ID7KYMF3MOoNyUMympipNQ3W3vNIcMHgN9ZLOVLaBE409i2Oeuhnh2jzJGPK5l+JRugODWzFi4DJ55HQW+cXiuF0u1oVL4yPjwS4fYdDQIcjG45L4rq/N+PV1Lxjbi6PQ5sX7GcDpeNFa6C0lwhiEJMNFUKwwfPF7gQbjNmCccW3evaEQNNN3NMhmLRxY4gOxSQlhfMoKT3Tv9ai3fwcPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfVJya0Tlw+FZOsVAzdRK/eEv8F8WbqzS3B5KTd35LE=;
 b=ibyeD0ucHlrOv51/8KJ0YBnxcYhbSEwR6e145SLHPyM4H30LqczqX2CVl7dpHFnObUq+Aahy5vI2Xju10Gz0BS/xG8N+Sm6OaOIM8Bm/JEV5RYxeXwJhJGuXSrkkMSyQV/CSTu+MnjlzGKgKH9mW6HVrfiXT4QChRN9aXt4N2vOxkngs0N+dk7axez91OiGhFCSIUWCv1LkXKM6vfkfDDE467Pkl2Gkcl7vvkacI3k7mSubN42jZiAZxEr8tOY6FkZSKhF/0CN7HgaDBBPrTyqp5kt65jZDzg2siysxhSEI/u/rV2dCvJ/vALCnyM+e8lEaHjiQ0ot0DX+7vZrO0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfVJya0Tlw+FZOsVAzdRK/eEv8F8WbqzS3B5KTd35LE=;
 b=EOBeukuUaNWWpw/Rm0sqH36TX8kVFFwhNfISFXsOAA5CTvLUEdjAv2i4F05h/9M+ISSfaVGn9nnmSKHacBmn07fMCyu+YOgC9Fglz6gXqhhH1KCdezm+1CpjYTCZWgwvyg0rsE/XhF0jhg1vsbyuqmpz9AdZ1muocYW7k0qakaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Tue, 20 Feb
 2024 23:49:33 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 23:49:33 +0000
Date: Wed, 21 Feb 2024 01:49:30 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: zachary.goldstein@concurrent-rt.com, Shawn Guo <shawnguo@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Message-ID: <20240220234930.cl3b7yqk3cl6b6bc@skbuf>
References: <20240220145037.kf3avnykjif24kkr@skbuf>
 <191b4477-7b4b-47eb-bb3e-0e4d08b3b32e@seco.com>
 <20240220223706.o7wc5r57omkmgtgh@skbuf>
 <e39c811e-ad9d-4e90-8710-629b822944e0@seco.com>
 <20240220230656.cefvrh6avji2elrd@skbuf>
 <bce5cff4-c1a5-4d71-b6cd-a89c55a628ba@seco.com>
 <20240220234526.fkifmrt63qjcpz7v@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220234526.fkifmrt63qjcpz7v@skbuf>
X-ClientProxiedBy: VI1PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::24) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM9PR04MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdaa1ec-970c-44b2-d987-08dc326e9666
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 71DLoETE5BijO1RCMWO0Q23He6mNPenldQBsRjMeEmnhsYuo8Drx/B4F8HrBttSruDsZ4nIjwpnVpfwrtYqo5PyyCcLhWltVn3dcaqoNawAMwh+8lvRHEpi/QVm9xLu3WfVoEf8ZfP7JiuAByi9BDQ9wxTucQI+9rYzqX/eROtp0wHliaxdV4xOGCYUw7rclTBBJjoA8sEGP8iRE9Ln8qCa0GS7vFyLVcG/ycOmXikK2dmd5q2nM1ielxCvdXMS8Lt4O+Sn28RBQ5Cf2aJff5MWd6J9K5nn7Fp7pgHjK7aqgg17j5irUDXnpYKpYMY9n+YpRO2p2fmFl535zNOI+KQzUj1zUyOyKNWCxYadC7bb/MHSfrIP7p6CAWCIPfUbfNelLKFmJvUPbwsE7w82+4uo1QK+Ecn46ZUMJRUmNVZaIwXhBoIeQ4V1OETTMhqIBlJ7zcZVVQmiwGTa57jjAprbLUqOTiuXti21X0GY45MElLHP6z28OTfX8ozXSXuBUuaFPranlaFe8JhFYap34Jw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?4g6LrPup/z6opSvcKBRmrRNWFst1Vy5bvHWBosnhjZI/xSH7mm3ZJt1IWpJx?=
 =?us-ascii?Q?XRUHlY1CM/2qT+hSYfXlqbcfbMDKFHQtS1sftV3Y5l5U/mS9pGSpO2y58BhT?=
 =?us-ascii?Q?bnlBHEJRKXADcL53xgaPBhvtAAoDO1g8YjRJv1q1jhTHk6M4WGEQyl2FPDTZ?=
 =?us-ascii?Q?YMF8vOAhVp6vZHU2JEPE1CBOSNF6+Y1XFnlBDoJRxaS2br028FDn6ppxfU0b?=
 =?us-ascii?Q?VYMzibMbsLwOpPPAD15YhomIgkCKx4ewL41pSNaqMneK53nuTGOK8dBeuojt?=
 =?us-ascii?Q?AxK6PoMDzaSdEDJrFnXl1B+DCEMGmVKsn+aj9yz0MEAFoe00autC9HGfdFcO?=
 =?us-ascii?Q?JuWfriFN2yYZJ2tOqmJIijk1G/Wu1q5NieVSSLpzausC7j4p2aq93+EiYqGV?=
 =?us-ascii?Q?apnO1JFTb6x20BA7BZPTjt8ZpA11c9Jge3yQEAj1a7LD5LB6ZifDPruRpMgd?=
 =?us-ascii?Q?xJcHdzcwu2xuRPKHpUEDQeSwBQYiGGW7cv76dXi6i+0rGlx5YlTGp/4K8m0x?=
 =?us-ascii?Q?KXatA0LI4syu2KQemH5KQSTpIYuhhQ2TYovlIIqXW8XVk57KmTCjthKBkpXr?=
 =?us-ascii?Q?321zZAPcaxX/nMgRZYvXSdYdK+Nclc2qSxUjEIY0G1dUOzCh4KgHZfqABoBG?=
 =?us-ascii?Q?ZFRqEQIHSoL2ax/L2v9JCA6j/SRlwBkfod5Cz7PKl9ctdJ05sCxM3zc8ctHx?=
 =?us-ascii?Q?rTv3yTCAUtCUXwL4YgKltIglMULBAFnZer1zJop/jvbEl6He3bOhUb9MzLoP?=
 =?us-ascii?Q?OPVwEeh8xnvSDSkw2AMCozVIGvKIfkDWn7Qd4gFNtxZAndQHlXXDwg9N0vVu?=
 =?us-ascii?Q?6oWsUkj7SBJujQRNQrWDo8Pdqi/zFwvZcYw/Cr9q17y15cLhwrUyg8tGwGoK?=
 =?us-ascii?Q?XGTUv/DUslvcPvisBeXKc7Bk3Qcij0Axgghho848L7/73dHDAM1oz54QRDPZ?=
 =?us-ascii?Q?4S8p5ffSPfyd8wQWb57zz0MJN46WdB/c1MVdAh8QMADEMfcJb4379Q7K/y69?=
 =?us-ascii?Q?ZjzS7x3Z/WIZRJ3EB808JbHdu2ynVa0SbIK29HLFQGxUF14RjfmI8A9jKbLN?=
 =?us-ascii?Q?OhReXuIu4rLNSAFqbbAYBc9RSKxEJznckJWUbzAUSA1KXGi5KIBzfhKaby8o?=
 =?us-ascii?Q?7ULe1RlDEoGtjDhcGE7RC6cdCXhi5wsYrO6qGNeeSyrCTEipup3FZ1xYCWSM?=
 =?us-ascii?Q?efdHkyuhLdx3Df9XgpUFj33qGrLGKIElzaFuRO10s0TXU9GDIzI8s4JvSPfA?=
 =?us-ascii?Q?CQPC68OKVQjGl+vpUY0bRrK/LMpJ993qCiMXRKy5E5PG54QK/Hyhs6OVCquy?=
 =?us-ascii?Q?amitrVeLTjMcDXQvTHiVhqqsspXGF1NAfVIPX1TF20ep4N8+zbnVp5BfbZ4d?=
 =?us-ascii?Q?ick2Uik5JP3BpI6XI5epfVbVaYxOSUZ/1SDfxGbraup6yXban8BR3/KFpDr0?=
 =?us-ascii?Q?zjVcFOjvfYLF7ZJ1dAFp5m5i7Rvcat411DHPQWZcr/RnFZhRKTigiwxafry/?=
 =?us-ascii?Q?h70ext6zIqZYJ/Gxr3kCmdPUTNjPnnlGcOlkThgQ/uO+j2UN0ydVAFSHlVX4?=
 =?us-ascii?Q?4Jv8y+0bKItGRvRVXjzFPKXaUcZPimRn+vdaBYd67NbSNwlBML70N2fyNO9M?=
 =?us-ascii?Q?U4w1OjZw54VPqgqC+oBmiRc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdaa1ec-970c-44b2-d987-08dc326e9666
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:49:33.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+Ak42nAZ27MGwBeugXKQQ/IyKq8IL1jDEeZd0nEegGOUN1DGuvlZwf/so5AO+mpBoD14mTW+29wGKI6+g8msg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210

On Wed, Feb 21, 2024 at 01:45:26AM +0200, Vladimir Oltean wrote:
> On Tue, Feb 20, 2024 at 06:17:02PM -0500, Sean Anderson wrote:
> > On 2/20/24 18:06, Vladimir Oltean wrote:
> > > So how did the other Layerscape devices with the same SerDes, PCS and
> > > mEMAC manage to get by and support QSGMII without listing all possible
> > > PCSes in pcs-handle-names? :-/ DPAA2 has the exact same situation with
> > > the QSGMII PCS situated on the internal bus of another DPMAC.
> > 
> > I'm not familiar with them.
> 
> Take the LS1088A-RDB.

Ah, wait a minute, why am I explaining the LS1088A-RDB to you? You've
submitted patches on its SerDes/PCS integration, you even said you
tested the QSGMII ports:
https://lore.kernel.org/linux-arm-kernel/20230321201313.2507539-14-sean.anderson@seco.com/

