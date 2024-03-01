Return-Path: <linux-kernel+bounces-87885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F253A86DA7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7C4283C07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56AD481A4;
	Fri,  1 Mar 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m1bXZYZ1"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8B3A8DF;
	Fri,  1 Mar 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265690; cv=fail; b=TSCnUbXBp1lxr93PmX/TLE+IrIhBz+btM8dAwpiTLoBKLEAwkmcQ6Bo0lYbPQxAzWBY7JS2/Kujupa8Pf8jDehbYxnuIrWIZ1TNRqU4YiUOI1DSrufoozNX01mrkfetQDPgORbl88+w+612ZZjGJTuGLgw7ok/HQWc9FCy2nLDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265690; c=relaxed/simple;
	bh=ehBvNpcHAb9Snh3k6X50gkPyv/feHt0UEfqPSHuXCfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9e1UoNiNUT+Ueu8Ob16wfulPO8SCLLGI/GHvGHMLD6vtIDb1yHfOUu7sIpWTF9YrENVRkPf9MVRXhEmZN5VtwktMa0j7hsUbGaYQhzeIRX9CgQteNOSybNDBjqZE233bFLfW8/aSpOnNJ2JFSev+c9xAk2NHf05M26GmPCEznY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m1bXZYZ1; arc=fail smtp.client-ip=40.107.15.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3awuD3cPg2t1xX2SKil2nhQ2dQ9XDYagh3Mm+vpohAu4wIxJBk9qjmLzk6azetQqP+NXSlx4TE3wEV8xAajJ/PehcGI++0tWxdH9U63X55OxkHP1n56Pr95BbZwgqKK9Rvj6L/OtHP1yWO7JEqChuQSBgWU2PYIZPHIygE1padDYZhg7KCo28P620flDqnYOYOPVEu/+dTg91PESJvOIJutlZheJEr+r0gPLFoCOxtCm2z6X4JD8Me4D+oZVvR5KcPeAYx1LERBjtyyoHT6YxnSD8SqvxXpgdVYpDrvBzcgsjTnZ5aSMFcItBXq6M4SCUJG+dcvxLPZLkIClSwqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNoCP6R4xV3oectVVo/ZxNlN1+GolbnpV0xxtyLKoZo=;
 b=lPlqKaciHj8AZr2EQX0oTWapmHez2MUyQ94aLj9dZFAHbivNUig/GBpm+tbhKzUJD80Fr47vBpq4I3BkszaNGttgLsuFaSGZqZjHIfQ4Rr2NqqSFplpZ6Pca7EkBI4S7FeR9uDOBa9BRGNfcU+EVd9W9CQRIr8ueJpsyNCSGlNo1nxmt1gusXw3Cb/gSBZWXgyOAeXoHUFjlyzA3dP2UN4QCGKZR+2+d7mXS4v/NXHVAstiL9K1QFeNyJemexPGMmGMuKbcJjrasDUEEA6yhcOSUyKU21/hEtomnL9UWa3UVyZ8sPZO+HjDdEfsDlh0gIWdUHJ7Fvh6G7ZDLB1ETWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNoCP6R4xV3oectVVo/ZxNlN1+GolbnpV0xxtyLKoZo=;
 b=m1bXZYZ1TQG76s0pdSmE7ej1lwwTR8zdRvDFa6VDO/cVBlvZZEJlfSZtqmnZhgDlzK9ByXr9xmJ+Tlen+brlMPEPEk2jlRt1g91ThTkW0FghtbaVRq8viZsavxbRS6lbUjmK9CcRazGYzTj7GE825ZOAmX51rwnngvXbpuZbG+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Fri, 1 Mar
 2024 04:01:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 04:01:26 +0000
Date: Thu, 29 Feb 2024 23:01:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains requirement
Message-ID: <ZeFTDSuLEeYrsbKi@lizhi-Precision-Tower-5810>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-1-d4d5935fd3aa@nxp.com>
 <f8ce39e9-7f06-49e7-92fa-785bd1cd2d1e@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ce39e9-7f06-49e7-92fa-785bd1cd2d1e@linaro.org>
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: bf39a693-19a7-4acd-5fa1-08dc39a44423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/yDoACUeXqtvhq9aOG23Uln2mYZKoM2L+s6MHoB8a4zntEH7csijqXSYXXO7Y7T47hlVvpHx9ev5PgR354Bnh55YI/0W3uEonbgCzp3lCqTQuhacvQeJI+oyMXGQWDoLCWP2qEoIcyfRIzWmzV5CQ5QEcevAUDb8BQuXvqAVjMdgNe9AXhBkvw3hEA8GYmbfLxBlDl/FVdd858x8aLX/4bN3TGAmTPD+hcLEVd4AJ7UetE1v420UBfqqGSd2K6whmAtyR5Vs9qPY0IYVE73NHieXTUR3hj1nYeCb615CGL5yEIvg4gjuOZ1CSzNJlJeBpOAkTT3g3iBc7JAQoRvIb8+AbVGsHB7N1lMVeYqZuGqSkT+mLt9H6lKlwXZXYVICM/CVbqW22rNw6tqCCFptyninj7//8kaPtTPdJ1TF5JLFUVbbL8qwpt3XNrgO5NXw0aGDnoo1d28y8ZJpQ/Hd6sc0/tOUwLMPkTiI1dFvQtJqU+X/2/bGyuIqznnhavOcvnN3gMpco9r7p208ftGIw2CeMv59CNx6cl4aP0xLDQVxRC7fJI+UxDUVjg8s3Bnx3kKHUYx8SQtqPSbDTLBeSlcruE4Oolo6aeoktuDkSXlxeEmlblkqGyb6IAi9t5IYQaTDZukfPTwewjbU3EMd66ghqOFNlK8QoLlTB7jt5q9+Juu/HsAl0XhpfCOAEo/FaiFq2ygzMPfu995Ui8JA4PfN6k8CZiBjtfRMZ3+AtIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NT87iSE9hD91En93ryjJXhUU7OBxfvQ5zRc/2CF5NgAjVOsGJvS66Gu/a8rd?=
 =?us-ascii?Q?OTrqjT/ki47eQCVKDRIrS4eDZm4f4wj2hT/+aPjjbHzosy0ehaq/AW+se+Ug?=
 =?us-ascii?Q?GsBTpciv0PIwB3jqx0LKbZ75eEvyKtNLtc/Qa6et4DAdhnrW8kZUCeKcmveH?=
 =?us-ascii?Q?g50ThgR5FCUaWsrN6bRBSq0uTsHt0j01BQTKWuMIgQp3axd3GDVx9EohJbGH?=
 =?us-ascii?Q?SJddFf+u7JMb5Dg/oSaye7MpEXV2nH+isEPh28fxElK5Gw/bvxMDuUpGAcFO?=
 =?us-ascii?Q?yvnpMLQPeu9Uor96A8kovGxEsJkCfP8yGP6qwoJgMNhQF2aKSTQxO3d/zQqE?=
 =?us-ascii?Q?Z3CNoa+taaa+9uoOiLl3wNGrxsb05MOSHcFTjwvnlLT32FLzktKDnHQUZOgv?=
 =?us-ascii?Q?VjezcqiqwHmrmt91svrpiGkzzwxc+phhqFFGlqeLdW3Bg25B5Gaycu9Tn0lk?=
 =?us-ascii?Q?v/uwlrE2D7Pam11BuOnyfR03KRLc4f17u2ivYUNqIiOUDXgH556EPdt8UFtL?=
 =?us-ascii?Q?1A63qnwsCR2UN6NxBGrz7q/+zjRTQ6QivVivgDsFiCkmXxv9f2Pi8oA1ElEQ?=
 =?us-ascii?Q?E9WubzzXua5MqngplmCY+sgwz0oRr9AmVB4a7xh7I+PDpIkVIJhx2+ZF+mYk?=
 =?us-ascii?Q?U2XKXdXI5oIp1NmkvGerBhNfimi+Tsy7TKHd87u9ZWISQwOfPai+BiVSe3aD?=
 =?us-ascii?Q?VzpxnIcI61WILv1Sc1G8cfiRXregUCyhJCl9oTHx1hkC30tNEH7jXd9k7g79?=
 =?us-ascii?Q?4gSd/Av7NjD3rxK8kepjr+yqdAplgepn3v0BT1FF7xp/0CgvBUvpkKYOGJ/5?=
 =?us-ascii?Q?I8N79KCjXV133rCeW8TJjloNQUR98j1K5a2JhFK7M+a5SZ9lXoNKX090fLrM?=
 =?us-ascii?Q?dhrXYvVNZLtRjgUFhE0fazdHfSQxLzu3VuTzsMjzn9tcW/iVlB8zXZ5f+kTn?=
 =?us-ascii?Q?OhyTV5pEU41W6RSqaIH+IXz1NRZvawdv11zkcKRlDmN3XQijVvDDr3NRSfGU?=
 =?us-ascii?Q?kxP/GR7xFky78Avu4lr0qmdbpJza/pwa7nxNRJ0lArxM9QiLBNLEmHvl7Ue3?=
 =?us-ascii?Q?I2AZeLgOP1/oyrIsTtnPWCNJ5BEF5phgYsOmNp1kRVarwkBwZ96xEkXQ2+pX?=
 =?us-ascii?Q?J2QyI+A4BzqxfbzuglwSCPVITpQfgiFkJM/MKQjlZ2Ir/FwfMyi432Ngl5ZH?=
 =?us-ascii?Q?I0lBEFPQGHi4elLKiBY+ahBvZJuL0dastipmXeXONeV1CMyz7PPn556Am4I1?=
 =?us-ascii?Q?+2khJxNMWYfZpokXXY4pNpg+UMhxvZD/gkCfkmZqI3i+1y9eQQJy0TpzNCDU?=
 =?us-ascii?Q?n3K8EBEQcSS7lZsDkHPLRfpBxps3GEE7gwGj53yolMovvzN7bNYDJaMT8ecz?=
 =?us-ascii?Q?0eLj8upD7EIgWNJllsHs9rrO5A/NFIdgovBJK7UEQmS04vGial51wjKsAtPo?=
 =?us-ascii?Q?FM9Rvt2U0HUJczQlL9j4+jgG4LJXUZz4/9sMsBrdMIZM43SJC0Fc5T/TDTtm?=
 =?us-ascii?Q?gZhRUwJtuqUa1WvLG1FuAia8qrJh4ExJDhx+kNxQTeePSK4fodqHO6mMev9G?=
 =?us-ascii?Q?sB2l97jxVG+POdR6KRg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf39a693-19a7-4acd-5fa1-08dc39a44423
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 04:01:26.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD/GqnHQEMFpnyeqiWJmfixhUZppgbuManWLUkaRqEv911SQvjKFk3ztYB2SACVwWhm3J07RRnAM1ftawlvCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967

On Thu, Feb 29, 2024 at 10:44:20AM +0100, Krzysztof Kozlowski wrote:
> On 28/02/2024 20:14, Frank Li wrote:
> > Add power-domains property for asrc and spdif.
> 
> Why?

i.MX8QXP i.MX8DXL and i.MX8QM need it.

> 
> You keep adding this all over the tree without explanations. Why
> suddenly old hardware became part of power domain?

This part upstreamed earlier than dts part. Because dependency eDMAv3 have
not upstreamed for the long time. I just upstreamed eDMAv3 support
recently. So I can start upstream dts part. So I find binding doc missed it
when do dtb_check.

Frank

> 
> Best regards,
> Krzysztof
> 

