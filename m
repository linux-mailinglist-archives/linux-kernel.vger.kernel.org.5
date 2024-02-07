Return-Path: <linux-kernel+bounces-57250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221684D5AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CB21F21C30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C86F519;
	Wed,  7 Feb 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B7W6NiBy"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB5149E0F;
	Wed,  7 Feb 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344054; cv=fail; b=uVzn/IMEhmB6h9XBMO7AnL+GIQyJ20PJ9MoWN+gQGfUjmhFEnSPW7u+5D/N7pHUOYghnfkAyF0C7gf8SMVwVYsGbyu/A41zL8eDGA8LkUuKQUXrQZohmgcga3R36phudMGtIHHROM0A2A38BdqbCpQ6Bnt5jSQG4HqLXBLnhaS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344054; c=relaxed/simple;
	bh=AEluH8OaaWtedbQcoGOaUjsY/7jgcWj/UlseFMMjHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=csO3WHlew1zGbfJEZJ669gq6qgQQYdsVzJdUSNXcnqpNLerV12QvCF73yy44LQS6Nwgo6oSr1xnefpxc6vi82/8nIdB2oyAfdEwa5KbSyhcKG0hTtLWFsqO3r8S9P3RURIn18P5qgk7roh+LMTmjH2E2o4YgO7dZFOokeFGqxEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B7W6NiBy; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhWXliAjQFQIMm0b0zLDJh5q7zwKYIq4E+cF6D+IZkYqag7T2aSeaBjqU9wqC8A+aCqZ1izCCJRkNiRQ+ptlSd4a+VZDLCKtUFs2kXZ7VDiiUP+Gil9TwSIofR7Ja8vjQVt/eefRA96vDq2DHUTe88/EoF1iOT8/cen/35p3lXGTejagXP0g+Zm/0YPxxnPXumdxGFvP8Ioz1pz3D2lF4GQvutkwfKD6s8X4SPc9uzD9v//p6aVCzk7BTJ0zE8kR0xFxb0LXWOXBbP5G2VsYCu6Fa1nZvqWPgxHtTAR5vS7h2A4BFbEmJmkpeyxvsltccf37MzUaR3w7umqHdvaHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz7ewzYSHGBmK2P3+LeCuxCv9HlXT8tL7paAMxDAab0=;
 b=KfPY7wKAk9dVBTusBY7sw/W+sCKe2tXK9HPXppip9n/iOO/CmMOqaeo9/NWIC/k3WDa+23s8oB693kX9E+rBRwMXYxfB1QvtHDQHbmOsUsP1+3B9iP25+i6hFrkoNy10QKgQNYSd97iRM/gSFo3h19n35W77LeOAAiigBqnDVpIkdOT4H49cLqUNI+6asJvXlrMaFfHVEz571CIqCgaeaNE/WjT2KuK+rF7hA23acF+kGo5G7OLYmCIJgx8VD0PB8q4jqK2sURxbDawIvADBvSKF4RUrLwux2bAyshYaU+0aQvm2DR9ysN8cNaf3+1IqpW5mRBaBmUVViLzFVrs7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz7ewzYSHGBmK2P3+LeCuxCv9HlXT8tL7paAMxDAab0=;
 b=B7W6NiByjDk0Y4RpiPchSmgYgmVA2egGi3icpVVWgvNqYRKwWUkGtoLyUrIa+FRobsJRR3ZcCBo3KCWBVjELvYUFHMt0iqNHhdH7CHB4sIiHxY5I24XvOqGvCxnfODG3g9+3UNmOo9d8WJI2j2qlLg1uk6nCU7SEmye1YS+XNxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 22:14:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 22:14:09 +0000
Date: Wed, 7 Feb 2024 17:14:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 0/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Message-ID: <ZcQAqVViPHcbgn52@lizhi-Precision-Tower-5810>
References: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
 <20240207-settling-drone-90e6f10a3476@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-settling-drone-90e6f10a3476@spud>
X-ClientProxiedBy: BYAPR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc7de4a-5a50-40be-c65b-08dc282a1b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ALOSiczYzg5djUBr6rA8KKN2r0irI20eGco0p3d4/Kqfsc6m1KeChpoCSZXWnReQinGFF1r5OY0K4BJvQLe2NGtrEqnWo4Mah6fUUo8YGRFnGdHAO3qK8pNt1ZNbmBuw+jdFN5wCRnto/bPDfH4QHF+XzrTFH3X1Nx0aTZnhTt8qwMKDhhue9jao3z/RzmyXQtbD85XXLBjhOETqSBf208dkwxldhGRIa9UVu3uzkmFYntiRolk8CJGsB+fIgD7Eo9aeYyI0j2qeN0If1RyhMjEMjYP9U/Vji7SGYjQ63mN61gDVjDKV7B9s/ecL9EiOm90wMhzA0j+X4optD6AoJVtTaA2SAam0GMtSNcW/0G3xLNu3wUNx5whhJRX/12qQTKv2IZ/vCYwrTONOek2RCo2vgkRcuis87r2Wi6194GjbEDWLtNy4Gp0z3LYEdzVXdX5G0FB5/Px4A/oe1+T9cjs46lI43aTbm9kYmptyE2PnORiNoBL3XphYo5NoAOkhOCfvGJuXPz1nauIiDNRnN16YWmpGiK25OkarzL3Lr2LFppOpakQszavZK8Oo9dBBqxk5ouCszUsh4t4Hk5hMlg2gzZOn4zKFMGMeHiRhzUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4744005)(2906002)(41300700001)(33716001)(5660300002)(38350700005)(86362001)(66946007)(966005)(6916009)(478600001)(8936002)(6486002)(7416002)(38100700002)(6506007)(6666004)(52116002)(4326008)(9686003)(316002)(66476007)(66556008)(8676002)(54906003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORRe1aygBXDEHEafBW+sGZMYF/GIW17ntUORghTMZ/ENplNpRy6CeMGtFZVh?=
 =?us-ascii?Q?9ph3CIdavDvn1ybtXpwBYjmuS7Jctu2l2zWtQTRnPRapaEfegnB2KwttvBrd?=
 =?us-ascii?Q?rI6umN7CEkOQ++6DqKponPDWoqtETR6y2d4q0fmovbRStyhX9LnZwlQXEc6C?=
 =?us-ascii?Q?PkQiYT4rcltFplqdO9z1zjrwaKLjWFXhoAVjVPMXty16JodFRr2Dg/7wl9yp?=
 =?us-ascii?Q?DIRwKSzH997ctQzLFkHjn8f18B6XTxdqz4ew0MV2+4Z/J9kdihZ0IZwkW6kN?=
 =?us-ascii?Q?OHs71dq6dGMoavAY9NiNuweL4EWfeRAf4JlOQ2Sk7RlWSL+R1SuzMxOEiEIN?=
 =?us-ascii?Q?SxuLbxcGcVcljPWCwlG7AVOK2oEGBeYq43pA8r0VU446yWQJcPS+nV4lS/3r?=
 =?us-ascii?Q?mqLWd+lzsVO+pqbg4wFuNrGP5k1ZZIz0m+fwIj9+Ke7jUbpY4c6gIe88MQva?=
 =?us-ascii?Q?hfDIkBU6vmwBXq2FqCXxMgu58bIGnqVhO8zosSb5sTbPdVf8BxkdkwvgRk4P?=
 =?us-ascii?Q?URLDgXftaunC4O8y3+k39R/ZuEF66bNUsvom+MxLQ2b3MjAfMIsJCwUydOeS?=
 =?us-ascii?Q?dZp+ow4nJSIfcIK2NE4KHCN3VOsie+Q5uwsSTR4LM0z0aUKGmvegfDO8EKDW?=
 =?us-ascii?Q?T4W/wk/MAQoO1ZBm9PHETGwy9KtfCGLx1uVsA7hBI+NP6fxhjIjOCSsU9xZO?=
 =?us-ascii?Q?aIToJzeQTk5TR+FTQ2AZMNDMb7D52WwMRcPZESi6eq7xd6hvfaL6YFndBxfN?=
 =?us-ascii?Q?MX1/Yybtq0NHPcLk654vvDwEOW1GWaNpJ9OeuDTOx8JBnyaafCRNWYVcC192?=
 =?us-ascii?Q?5+OMrhAMyEqTpbpL+dtKbDECOwLQUAbzZMRb+b8AegJun5GtARfQm4pidO/7?=
 =?us-ascii?Q?wKqzl47/LyuKrxTovN84Iz7FNQebBa4gWMdRo4OnGPYIPYjzRRRh+/vqf+Eo?=
 =?us-ascii?Q?bLGt0kmTGSWpM6dvCYUs+4LQgdavBNmiK7jufHgeBqxQm3xI1FZ20cTYVj3H?=
 =?us-ascii?Q?LfcPd5NNbJ7WwVTCrWLtK+mMIBcM1rvrk5fdrECP1PYLfJR3z8teQVymuxfo?=
 =?us-ascii?Q?8KTzc31tGQNrVd32zMsvdUXwP5HflnN2Lr0BSHAUHhrsS2nobKGEZ88bt1tY?=
 =?us-ascii?Q?lu6SWCAGowAqiSwHUp5aJlpZyAXEqsuCt4LU0yfoxs7B8o26TD+NojsBnXv5?=
 =?us-ascii?Q?bGyJDrk5E5y/SohN8DEqKCgLx7iBut8iruZgoP3/DdUKwZqZjbnXAlrtseXK?=
 =?us-ascii?Q?7H1a9C+vdmUx8ap4YXCvrrn00LGh0QQFc98TQvFj6DeerD2XbD3l7GWELmiL?=
 =?us-ascii?Q?xLAefM9YOEPjQnfMaCI13LDQtYpCj9gvtP2QF0Iy9qfP8lHpwFbGHFT+2aQj?=
 =?us-ascii?Q?R3folbEo16V4uwwTeEvMSy7uKPBhV2qHoGhFMkbY4h9hqIPAThJtDR0xG85+?=
 =?us-ascii?Q?1w3yXidQVDrnYUkFM5YrtBqcBcLJzUZZgKNSulS18lCAo5ggRHhF5k8yPZA1?=
 =?us-ascii?Q?LdlgR8lvBfar/dTq9XNwTRlEb/nEZe/6XvTVBeMf43Yjyxi3wCd5bX3MruVM?=
 =?us-ascii?Q?4KL5MPIhluWOQZS3uyk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc7de4a-5a50-40be-c65b-08dc282a1b34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:14:09.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 916pL/kkFPw4SpjyIYD/leYtexJeD9FtdUcwM5oDNr1BpW4peRTpzhyqmUP53qFsmD2Yn+Q+tNs8Ll3ytJx93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914

On Wed, Feb 07, 2024 at 10:05:23PM +0000, Conor Dooley wrote:
> On Wed, Feb 07, 2024 at 05:00:17PM -0500, Frank Li wrote:
> > Since dt maintainer give comments at old thread
> > https://lore.kernel.org/linux-usb/20240119213130.3147517-1-Frank.Li@nxp.com/
> > 
> > The patch v4 already merged.
> > https://lore.kernel.org/linux-usb/20240124152525.3910311-1-Frank.Li@nxp.com/
> > 
> > So submit new patch to rename snps,host-vbus-glitches-quirk to
> > snps,host-vbus-glitches to align dt maintainer's comments.
> 
> I thought the last comment left on the v1 was Thinh agreeing that a
> DT property was not needed here and we should be able to apply this
> conditionally?

I don't think so. This is workaround. We can use this track which chip
actually need this. If some year later, such chips already end of life.
We have chance to clear up these code. Otherwise, it will keep there for
ever.

And I am not sure that the side effect for other chips. Workaround should
be applied as less as possible.

Frank

