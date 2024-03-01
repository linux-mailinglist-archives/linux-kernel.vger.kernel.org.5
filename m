Return-Path: <linux-kernel+bounces-87888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2276D86DA86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAD5283CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B84481DE;
	Fri,  1 Mar 2024 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EetYoqUX"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169446439;
	Fri,  1 Mar 2024 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709266020; cv=fail; b=tMknU+fX6/8HoiYdDaMBIXLQojkJu9LiLjb/Ai4rDmZcgNVDK6UbhYkUQ2LpcXb2jXHGk6cnbrFBCt83f07RAP6NE4SNYTlTJzi8XDTX9Ju+a0sbqT6RuTbh4yIFZEz7GsATCPxnY5MeGEaqp/jWBvqOYJpM4ZPIwv4M5yppd0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709266020; c=relaxed/simple;
	bh=Vndd+Z/d6oNP995uTg+p1qho0SEzE1HJy6mOXTVOyY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OCqJ7+t7O9Q5QXs3aF7EaecYh6sASxdwp+BKrU4j/no9KYcximNlufub+1rAUOecllgshOa9dS+Cx3xn55/SPKxaNSoZY2PtiFVtMT9HbDjvea9H7uscoKixscPjfadXSxuH2jZ8WwuYICJ0MfA+ZWZJQU5DuUY+G3Oc0NKfzAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EetYoqUX; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhwUtP/uNFU5M3lwfyq6cjc7ufmYMYUVzmpLwhmYd8qbKBRPzpqTiMIW9lLMxwBGul55ZgIIcvw0nFxJ08TUKqmpqZLKZ5iLPyzFWJsrqiM7vVzf8ulvl8EkWy7laJu6A7i7BQppvjp98UwR7m9rQYFMccO5OR7pNQ8GKCPWMAbrOToeec/HPb+gzJiO57LV0oen2Qa6p8zpo8od0n+x7ot12mqc+UlG8hxbpmeaUXasMciKX68sVlBA9P5aNEzeEJSWqDZsMRFyzKkjCgwu7cOtNPaAL8fpxvqbM2XhNqvHTTWzBFZaH5ZpU3eq4cLBWJuaBqaYkSAle05WmdKyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq+CgZMxf+jd1Vptf5GbUhhAn3LqmUgn0Bh0qh9Jpnk=;
 b=SOoStgeXsHHjNPUMFK6cJ5b8E9YUdaHeDxUorT6WdNLJd+OlOehPaN3PokMbGxyblITgiQfVgzmTwygpsmYyl5bwfc7fqSVuc9n1db9pKTImFCbR6whZx8jYXe71UbQkrLqrPgh19KH/wrNUyAbchBg5AU0y3keazufi5wuNVjp44StnBB2y81HMmk+73T+WTbUo+ApcHCuxcB013JrYoyrC5r9K4jLrTudugWzzNrq7Z51qyZoc0D7nd1S+wuUmeaA7zAXa4wWHRFKgiLKt24MwaisJLcc/ELFdaiFuQyisaPBdacB3E99zaJ+KBB7fFjzc8ev8sTwDosfQ19yjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq+CgZMxf+jd1Vptf5GbUhhAn3LqmUgn0Bh0qh9Jpnk=;
 b=EetYoqUXKHf9AoFVJfvPY3HYwt6r3hcHDYBL3xTzqgyEqgV2b8OMdeiDNnbeeoBMCzUl1rbmjjHzaXdYoxQXscQnCFi6pU48biKuIooj3xZHk+VCas3s1eYwVnuy5BU7cazyW2u5TIm2N8YbofZykgdzoH/gQgMO37BUJHgEOjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7392.eurprd04.prod.outlook.com (2603:10a6:800:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 04:06:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 04:06:55 +0000
Date: Thu, 29 Feb 2024 23:06:47 -0500
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
Subject: Re: [PATCH v3 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <ZeFUV/xFrYnZzXZw@lizhi-Precision-Tower-5810>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-3-d4d5935fd3aa@nxp.com>
 <1251bf21-c65e-4749-ad14-78ddf5cae7ab@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1251bf21-c65e-4749-ad14-78ddf5cae7ab@linaro.org>
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: 14774f4a-7990-4231-6d02-08dc39a50830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rVvKp7PM36HzrkGHk9W+elZRI7CuFB6l1Q40AkWkmQ+I9PoeC3UKqnmw68YgbY0bWddxR57rMqPoxmZnxdwUGS5kVo3NANa/KIkCSdblU1BtsOZrjUZjX/WIgpILI8jp/jZUkAyx3qG6uyf1t5jSDNSJa5idGE8zwiQiEBKyEdAFojCXpXfDUGo2TxKkhFcFlTcyiftUhA383Bsrh9xWYlTfcmSJjZnsjOT88ifYJj+FHh65vNlLiSBMESTQzmGL1WFGbunbWEvBQW1Za0gZVnUyzylIt6C0irEoIwF3KYxeWLaqYl+7jGNnJp0QPTZ8OXtrEZozxxu1taDz1NaCezuecAckznE9zWgAcAtzvIIiHg0gMZuUhC+X+UhBhhMZipuJM3WHS2K1bA/9Iy9ZPV5fO1DyHKf/0OaBwyznYOg2LSyanHEweRU93cHuG41kqCJMFsoFWvFDRmZ7LpyJCAmu5m5aPd72dETTpuL8I2MNnhZimdpHvqYLmVA6bnr+NSDC9Zovn0UWmPPgr1t5PEiFZ38a1moZ0GDhLIGx/n+Rhsf4uH3A/xyC23vReNtMYl4aTyPO1pJWZO/fkSluOJuYWMTiqaWmghzN04MwP9hwYFaYjS56Zjy6MAjsJA5yo9FHFyQrhZFjSyucOVdL5oq9/mqqEtxZtIrxPmO0ptakQFwpwRqDbfvFJzI3LupIE87zRBSWZMz7WmEEUhuF7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+lsMuLX4HTpLxTZmj6ApYvVmeJEqe7QI++kfoboRsOufo1AEgQFmZenhbmyD?=
 =?us-ascii?Q?wo2U6cT6Z9WsGOyZuNu3waqHhzPj0ZBptMIuNTA3BB3R8d0+1sBBnApo0wH4?=
 =?us-ascii?Q?MArlOsQMKfWczlFPH66NiTTc/rTe6+jOMOw3hq0Eo4Z/+o9QBed44xti8TG8?=
 =?us-ascii?Q?l65CGHRCtO3XhoJ0sg/5+TDqqMg2uh/tNr/EBTmwzP/NskCDA2F55eatduk3?=
 =?us-ascii?Q?UH0Wg1plGvnRKVu1EhO8aCZGS/h1HhTVufVTDM5FH5/m+1UACpsJNsAP8eJc?=
 =?us-ascii?Q?Qvn05TvxcvCNZscOXLTN3JA2pfeaqZtxhbxj1Q4+D1SOlQi99O5ZdD4t74V0?=
 =?us-ascii?Q?07bGct7rEgIAIhIgDnF7kyawa7eHgTX+zYaT4E9HwwJlXETSvzoo8e7jBCjv?=
 =?us-ascii?Q?RN2UrM1NN1/mFUOpG6+d0SQQXzRLe/7F0Wq45gdsL246+wnqwc1BRD7ta78d?=
 =?us-ascii?Q?9zTKw0amQS4PWUxqTaGNCe9JGe0plxPjqDvMRyGR5M9fsFVlh53xWRcKmOS5?=
 =?us-ascii?Q?O59cYYcabDye9yOGD775aeuYqFUMdbJ3/6gRLTFUOeX6jVkU7Cj8NM8eMqwD?=
 =?us-ascii?Q?Z0lRJUEyxxRgiq7qvXAVh5Nd36KsZB2kT15PTLxuRkGDG7usUYqCTg3xs7x+?=
 =?us-ascii?Q?OSM1691zHt8GOXOWmE3EmZWjIaphzEW9UGWdhWOPRjUrBqfrCYLa0oBIww4z?=
 =?us-ascii?Q?vwZGFUd0ivcn8L7rrwXjcnKZ39gpcQbGpp/O1TllIJVnfMR7X7Clobj/5XUI?=
 =?us-ascii?Q?c8NGwWSkaZ1X8Olr4zqFPU+HqNAyVtU+3lApUA6y4lp9fsPdBt+TI3Wnix8J?=
 =?us-ascii?Q?v6slDnZYHQ5U4wg8NBjPUSShUCAYckPJp3idV3faMtVQoTltbf5RQO6XdtlA?=
 =?us-ascii?Q?cR2tM0XQBzhqHGB61dl186tSzwI+A4rdhbWv/v2s96ko5i9OqW5b7VhnKY2e?=
 =?us-ascii?Q?dSaAk3+y5Sut6Zgtn0UdFbtLW58Ozy+9fuKak9P99OObCnY8Qz3ffTt0wjEL?=
 =?us-ascii?Q?kpdV5cbrdNL+WxkcUoQ4jdM5UgjiZchfxWVJVY5GHUldfqmwayIP8u2lC5sf?=
 =?us-ascii?Q?8U5if5toxmXWZfdzHJBZuI/Pm2EbgH+Pa0HuaDGpb/o6ROluSyBMKHhhlOdb?=
 =?us-ascii?Q?f3jE+dXoAatix2uIiDqwTrjdAqiHejOHWthdyt7rxjB6mSL8EEgSgo/foo0D?=
 =?us-ascii?Q?xPnYzqdcvt1Sgz97DhL7XZqLqu2ReA2azxkVe5QSVFnnLZx9JySg9x2rFhpb?=
 =?us-ascii?Q?2cOnqrZI33Q+fDOmq7GDH3I47XqpapC5pPkdPAx+ySjqiod3M5HNgHtK4510?=
 =?us-ascii?Q?hPfkEeor4Q++uCp9H0MQc1gPgUXc4q9te3EfxIiT4ATbyytMGEbWm84Lq9rj?=
 =?us-ascii?Q?fVhJo4pu5FZof0nB1KcJP84oTmEz04IGBdKjArBnj1aarVX+3wwCKpCSWNgD?=
 =?us-ascii?Q?MSfpnbaEiui/5s0VX5q7Y4Y/44lyvyR72GUetw6pctg2+E+6BXflRg0pVGzO?=
 =?us-ascii?Q?ZCMQ5Nwdbv1CCPurg16IQdI75MEkC2baYDnhR9UGIly6buBV/zDtdARMgqgr?=
 =?us-ascii?Q?P9Ed9TMZuVeJZqQbgEvaat1DdRhJXOMiYwSetoOL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14774f4a-7990-4231-6d02-08dc39a50830
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 04:06:55.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYZsAJhVsf/UNgHPlOAmKSSY6oJQcibgCX9InV4SDOc+VPDXYQtKNaJGUYqqbMi3zJFO8z8jsiIT/bB7WLCqsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7392

On Thu, Feb 29, 2024 at 10:46:38AM +0100, Krzysztof Kozlowski wrote:
> On 28/02/2024 20:14, Frank Li wrote:
> > Some sai only connect one direction. So allow only "rx" or "tx" for
> > dma-names.
> 
> "one direction" was already allowed. Explain really what is the
> different, e.g. you expect only TX?

Yes, there are one sai only connect tx dma channel.

So TX \ RX \ both TX and RX, 3 kind combination.

> 
> This applies to all your recent patches - they all have insufficient
> explanation. Often they explain what you are doing, but not why.
> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> 
> 
> 
> Best regards,
> Krzysztof
> 

