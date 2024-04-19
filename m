Return-Path: <linux-kernel+bounces-151740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA918AB33D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FBC1C2197D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51575131193;
	Fri, 19 Apr 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jrhk/app"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660612FB24;
	Fri, 19 Apr 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543545; cv=fail; b=U7fNGXzG5UyoWguVQRnxDUMo7w89zc37irQarRN1B3fn4+PSswdWpZY8+84mAfNFTzFCBR+S5X+B6HMzBkvOVkVmoQLyeuco/ljD59kBrhCuFs7TWx04E4FA1GrzmtkFC7YmN/U5GHzB0Mi74L3ZRGGjO2ydFEVKZuYAEa9YXEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543545; c=relaxed/simple;
	bh=D8CEdjSAuaE/gq18duzvaNTY54jRYGXBk/CDRvXxh/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZHpMHLw2mD1VMZPga5FQoVfmWF8fHF3NAIzpoRS5Y8y48dZpjUrxFb/Py29Sbx+/554zpjGJ0sGnAMI3h7yPOLg8QR0mQZF+QcO9WX7QShORNgSc9YQmREb0yTedjJCHS/RPRFlBAQHUQY93wBEm9DkhZ+2fZcJvlkxIdEwXIjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jrhk/app reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjzMMKsoKhr7DB5YnU2JD8LoYy8w9kRFPKBHlzhlyNH4w5R4iSRV/EUxaagSfIllQFHuiKyXy9CRw41pbiUTQW0G3kkRQ/AO2Me15TKoyBEd/X8ThwbVpTCHQEYnPY/JlgFcCjiOM2dRwcfU8xmoJwVQyjHzLVDH/WKLJ34m/7cqEQSFNcvHeIQepdPr2kCIABh2lKDEnvq+q3zjDECyCVWj2q+LlYtt6fsSsuKiUbb01SElNiGT24eDF5fZCvnb2yz5UJwqSOAEwn4XA71syOqp9rlL+DoC+wm+tM26C7EdH6PDSComzTGxnzY6DU9LQ9kVwCYoA9DLMUZis8781Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec4PX9+yrQKWXJCTA8gTaHoiORqUo2Cxfdqhyhv44M8=;
 b=PLZuLGaeU0PV7QuA75fCEIGQtpDHzeWFYbOqbNylVnWo8wz2LjLh/oJidhXELVBgjE1ZY7/gV53F0wBjKCP1i+XgvWKb9SkFxjZexYJjgbnqqqJhGNDq6V11r8UC09eEiipHBGl9RGJIr/LvE3xTK68MHVLCnfmWLNfFsfTfs4jycRv4YUMXhG0zIru3whtmfNTZquux2Fwz/QpD+A6gGTan7mI3Gfxv39ENp8wg78Afk3275zJI3cutOToky8+THkfdDslp9cOfm0I7h25ONNjFzgoJrKLNLESKUIMSb7YYNTohT+2GJ3WMRv3oPp9LezNHaXB88VoGdVOPAj9SPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec4PX9+yrQKWXJCTA8gTaHoiORqUo2Cxfdqhyhv44M8=;
 b=jrhk/app/anNYv2eKiVkIlh0wgXTAqPaluWwRaU+MLn+x2beYZ3yuAQ+zQAuQfa4JKUavERCAdQhMl3ypXNNurzZp/b7qQfCGVqZ6xXVhg7Za7SWxfzqbCSlNqvCud2FQ2oxcRo+dSk3MnW6yG1oA9Vm66V61Ii2PFWSx97TV8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16)
 by DB9PR04MB9792.eurprd04.prod.outlook.com (2603:10a6:10:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 16:19:00 +0000
Received: from PAXPR04MB8877.eurprd04.prod.outlook.com
 ([fe80::4bf1:2be3:eaa3:4052]) by PAXPR04MB8877.eurprd04.prod.outlook.com
 ([fe80::4bf1:2be3:eaa3:4052%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:19:00 +0000
Date: Fri, 19 Apr 2024 19:18:57 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] dpaa2-switch: flower: validate control flags
Message-ID: <od4mb3t53s4feadbtjc74ayh4phv7yv7p6dqot5ylqockcnqin@vnsdvzn4tmlj>
References: <20240418161802.189247-1-ast@fiberby.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418161802.189247-1-ast@fiberby.net>
X-ClientProxiedBy: AM0PR03CA0084.eurprd03.prod.outlook.com
 (2603:10a6:208:69::25) To PAXPR04MB8877.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8877:EE_|DB9PR04MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdef7c1-101e-4f68-43af-08dc608c6b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?oJ+XYeD4wfXYOKMj8a7yTXOTxGYMPFQZUKDz6VMPgDd8yMFJQYjSs51Utl?=
 =?iso-8859-1?Q?XlurGqfFrvucdZas5LBcXywvfjzEBBynboy+TDCwXhi0cU3zlu8scVCdU7?=
 =?iso-8859-1?Q?unVZR7gSdJVG5R9mNTxyr3HN5s1Pc/mAskYpYlxulv2lxoY+bpugTi+FlT?=
 =?iso-8859-1?Q?IIkm32VJFAjSzIg0O0ObchfCHmOkicnmSo2OeKsriRSyGEleWdlaVwQd7+?=
 =?iso-8859-1?Q?Yx5BqWowSlY8jgOJ7LINeNAZ6vGvacx4T8Z/WVxz5mH2+sf8KfMFroV2Ck?=
 =?iso-8859-1?Q?a4mr7QL+qB395rgNpLkX+EoprDR6PiR75vTCO0GaNEPy9wRdyIHCZPUGyt?=
 =?iso-8859-1?Q?7q8jx+rmqtCuoEztMUDCmhtWpwI4QsabQBqIWU8IeAdxn8L9s95Hn7zM6Q?=
 =?iso-8859-1?Q?rT0oyD7bZpsqWegAlIF7Ma4aaYaV4g3Odx8bHbCQCiz1sw9DPB5nEidemd?=
 =?iso-8859-1?Q?8lFw0AJ9G+MH7HMLHebFvG5p34jThk+iSis/aAEu67RYsa46RiS1VtCtfw?=
 =?iso-8859-1?Q?HxXT+oWHQSL4biNqs7UnXpTFJPy5yuobTpEtJxqqgi8CIdfyEcCSDdtHql?=
 =?iso-8859-1?Q?O96/hVU9rjB8YOf1tjFpQbSSXo0vRI3aWnKr0OCeBFMSOCOROpC6p9xxcY?=
 =?iso-8859-1?Q?R9gNirSlPvnjb8nTkL+cXPWzGKknXGipQzn5zykBEq2u1VsBypjsFAFoDG?=
 =?iso-8859-1?Q?jAdqIdK51EIY4QX6NIunl5a096LIjVxpAfexRYsTl+DAmvyIyN6blC5wjN?=
 =?iso-8859-1?Q?8ReRu02Xx1Dxmh9xS85IS8U4jl5u1Nj3Jmw37Lvp6k8s2xN0y5sqGOaHAQ?=
 =?iso-8859-1?Q?zWdfa/qJHinLMnH3AGexP8hOmnmtkJ4hvdlMi9ABh6nTTMPHCdqHFFgbRZ?=
 =?iso-8859-1?Q?+GToTeVD0vS+7jOIrjoeOa+5GzPhc0feDtXDzpyQ2GoPiMB/v/PoyfIkxi?=
 =?iso-8859-1?Q?+SJmFUOuzK+Bu9KS0VXpbj9cJsox9vMKu8u/vauTyIPknUrK94U5hrdvqB?=
 =?iso-8859-1?Q?aJXyCuLfaTZvkrsmiUG5TxPDHcLACOtWp5RzEeLJs0DjPJf3eE7BVPFacE?=
 =?iso-8859-1?Q?/NhfwYXXc0V3REg1/4Kt2D3/4F8jCpghRN3Y7CeRgXYtwhtwkwBmxNCR4M?=
 =?iso-8859-1?Q?lh5LsU2it9SA2utJZgbDomxL6EMpAmYYpRTCiPxsxOaFJpxjxzsAbhXqyb?=
 =?iso-8859-1?Q?I0GGScgFTikliKFskf4W994m9pKpJqpN/g20EP/NzIc7EZ67KStK/w7kh8?=
 =?iso-8859-1?Q?BOGntzovmQlZ+zFszmBMB7oepB+U1tEHynVPYc6ep4vhjhf79PhjIDj7AK?=
 =?iso-8859-1?Q?bt6RX/FvECE6GhFeepr16OMnag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8877.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CSzgDDTyake/z0lqZ2FDUImpxqKLYXC/rTTqfZe6D8z3Fdv7A4/ehMglhN?=
 =?iso-8859-1?Q?gaM9CIvEJ8CVd9vRSbMMCjhzaByjq2xZG5eB8nzBVvmpLWyO/G/QJeUAS0?=
 =?iso-8859-1?Q?z3HqtCFW7yI4c1v6/o+QdByiSJinBMb6Txh/B2l4O4a9smq6CfVHnLYCFA?=
 =?iso-8859-1?Q?nCMoHJ6RxN6BTxevBsnY/36+LziSrBter+YWdty3hwEGXlYxkzgBV+QUbt?=
 =?iso-8859-1?Q?lQCbsjKgwtC7lXvoaRuWR1W4UdQb7so9j8WoJ9xOqlzkrOdgUzLfH2VUkF?=
 =?iso-8859-1?Q?388ZvUunK84euE1klnSeb3GcRxWHuyN+LrE3yxZpPokuV0F9Fa6Zv8C4ez?=
 =?iso-8859-1?Q?fWihLTYAX5kmr7Q/AZDt5ddCnd90uTd/c3CLcXv9PBP+DH/AhnHQA9l72s?=
 =?iso-8859-1?Q?7dCpP/szFV8HdTt9rWYkWItWL82YDCbt6pxkyMPQSTXcYhswOUQoeKK7e3?=
 =?iso-8859-1?Q?f/vmBJqw6GRHSlolAH40gr6Y7jXCS68hZc6kQiGYEb2NsIRliG2UZEnpWu?=
 =?iso-8859-1?Q?6BjUHOiVEYyrzbRFtePpNjVXWAHUgwlubx8aBt/NHc0XxvLmyhpbzsTSSo?=
 =?iso-8859-1?Q?KEi6pD1kjmldx8xXcEwx+dYnQGw4I5EywDXgC1NVFwAaCrcUph/gBr4I0C?=
 =?iso-8859-1?Q?k+gAVpGQCOKePjWe2qWELfxeI1UisWSK2OBjQapGWy55G8RG663vWZbcj7?=
 =?iso-8859-1?Q?59UmuJOfqu/qaayT4cra6+3CiJXssKcnYrdr25ebQNaIFd+7f5fzEGbXVE?=
 =?iso-8859-1?Q?BI+TeEHF98t8ldvKLKDx1+orkP6qQ3n6jlNcKcLigVLPpgcRYFryh027fH?=
 =?iso-8859-1?Q?gYeW2UZrdA3gorLBYzNq9gTJcC0Dzza5o9gvL4BySz2sw2MEj1WAV0bYH1?=
 =?iso-8859-1?Q?r+tYtVCuLARGc4zxHU7yw2P4dcJRCszElzEvzf0zKOyHtQJ4hp6iKHI/JD?=
 =?iso-8859-1?Q?mLAuXki9cqeXVLz2ugbZiEdpz5MU3uPLqZuELvc5p00vLiZXVfs6cYh58k?=
 =?iso-8859-1?Q?t2F9i2lj1Z0rMGFEpbN7onFqZvMDZ7w3BNIb4oO5yO6V4GpSmJyWtZgX4L?=
 =?iso-8859-1?Q?jtNsCkSiw9LNYx3alX5f2LaLvopmpRo/2xPwQ3ZdzcoZ2TRQQkT0lEvvXM?=
 =?iso-8859-1?Q?YNUxXOvibSAmqNeRLRNxDl6EugDSUsvVBbl7VQ9j0eYthRD7D7hJyZRsXC?=
 =?iso-8859-1?Q?qY7U+W303Mf+xU/oY7tcn1kPwMyFzqDQB/YTr3DouTXYstCNIbcoD0hCxf?=
 =?iso-8859-1?Q?3fbczJpI+Byc+YI/BRU92Ftp43e3HfI/aHzErrI/g6ZZ6bq0Pt6/Wgx51z?=
 =?iso-8859-1?Q?G6l1BzLVc0EdA3UIzGtCKESHW9zrEcL3oa86gyG/AxWYbK+ETryoV/6m/T?=
 =?iso-8859-1?Q?KJWSdsuYT6E5vgZJWnzKBnpAIq4CwMw1pDZwymS21XdYVa7v0t5ljYB+f6?=
 =?iso-8859-1?Q?Spp+BifEFNel1daw1CP3BxfaitFO9mMnNb5glxiARsgBlGvrOvZzyir2v+?=
 =?iso-8859-1?Q?CEb3KpU7WHRCjL85YgRUAM6cF2BDI9CNyAV21V33zoteiKHosTj10uBtLi?=
 =?iso-8859-1?Q?+MEF+CiXw8jKkCs0btjSYbfnInSS3DMgnh/KcapmflNPoBaPk2qMjmyvAn?=
 =?iso-8859-1?Q?mzXtx99FfTJT0t5scLgKTLuyR9vSdhj8d9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdef7c1-101e-4f68-43af-08dc608c6b9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8877.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:18:59.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za5/9CiocfwRSHwm9ZRDmLqOrKASb3stvGqLjT/kvU9rrX/CfEAW95eDWRDjOkNqr4Qh31COUgHID2UKJzVVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9792

On Thu, Apr 18, 2024 at 04:18:01PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_match_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_match_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>


