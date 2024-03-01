Return-Path: <linux-kernel+bounces-88632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3586E490
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1299A284175
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116EA7002C;
	Fri,  1 Mar 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqM8OdM7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B216FF2F;
	Fri,  1 Mar 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307744; cv=fail; b=L7MSfdbr6rcDSV/Vtca5i18yPcL/6wWFo5oGxmNWoacEhX8ZuYnG3ERbTYgWUvLeDKKPRsR6S3idP/3xt1WTJ0f97gEHIrSRh6OgzVgq1SRweDtxZKTMzaKz8/k5XGTZwkCXavWk7TfUPvxKqwlDdM4hS1THNgIQuRHg/yR8zjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307744; c=relaxed/simple;
	bh=G5PR5R22ZszAFsbAC2oTk6ImgxhlIDu9Q3wkVbyIdC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RaYdlfMVbvxlhLgBtDG0EDkrM9SM3j1jqg3NsdxqmSt+aDtkC9dmdldTjeOJG6/pZHmqRVITaoCIc/4mn1WY0hAOMVtzxv58saAbYnuo8FQy6hLSc+gOgfAV8JM2vFR1o15udoVamCS45mUaT+NXp4BSrCm9R2K8iWx93rihkUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iqM8OdM7; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvfROWiS4ATmjvgwVKSS8dlDQ7bmSFsY57SHPfj6W0YE4MnJeLf6P9FeikYCHqGLm3c1WMDgTtw8mE6P8spVrG6BLetO1WT+NBncRLzptcKFWl5aduahCZrX1LnZs/fWpZIERTgTqcGyLlIk51WFMISZUhJ0yRvPslzRwqJN1xfZ6KvuXFMRbSb7gdEb9p+jqTzxbmW6N+0cwetmE5aUnxVwkvqXFvAPfNP7WF/pi7Sza24RzPG5l9z+Rugvu09gAJ8rRNDFSPEc9XQXm6Ell316jkjC4axJq+CsiNON2/IjH1ItPIm7NElKkU14tMXza/rlPwtW0BmXM9GT9AgpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4CwAK4tg04p09c1In4F0FEvPZ0DfHb4UXNw6z4XLq4=;
 b=Z3YrbUyXY9Rzm0Y02aSjp+zkjpJNPy0iaotSe83vCOqRNT0oVr9e7rwHaRSG7rywMn1qu299tC/3zXGAnxAE3WveTCN+aSnfxSYJ7qsKvVj2OpnWpI0Of5ymCKLQOzxFWcYdLUpfi+u/dk1SRT2w+FlyG78FE1QsZF9h3K4UQcItX7XPsRG+yi2p600bHE8xtUMwxjer5LYV7XLHg0VJjqR4/6R30tNSkev9qMqvKShEiloZZ5fgDItmRepBEFnB2zB35PinTFleGV4ohKPmSTopozdOycYJ5Q+c1wM26udpLfHdG3rNaBbmn0ZOKLs2hi1Lixsz1K4yRVr24pV8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4CwAK4tg04p09c1In4F0FEvPZ0DfHb4UXNw6z4XLq4=;
 b=iqM8OdM7F4hVzAxWq5l6qBEzxsjxGZ3yH3d01lXHRsxzz2sQNTEoeo6QHf14PAxB7W3nstfCott6TenKGSsKDR4So8rPqMmhYTs489BwfJBSX6jf1CWOqtaN0zO7dyHw22souC1KpnXUYaoXdUKHVh497UFDLVlnR7FcpwEaQr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Fri, 1 Mar
 2024 15:42:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 15:42:19 +0000
Date: Fri, 1 Mar 2024 10:42:10 -0500
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
Message-ID: <ZeH3UhbStCTh04Ku@lizhi-Precision-Tower-5810>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-1-d4d5935fd3aa@nxp.com>
 <f8ce39e9-7f06-49e7-92fa-785bd1cd2d1e@linaro.org>
 <ZeFTDSuLEeYrsbKi@lizhi-Precision-Tower-5810>
 <0cc8a370-4497-40f5-9040-1584c0c777f9@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc8a370-4497-40f5-9040-1584c0c777f9@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a38e3c3-9e7b-4f0b-1cea-08dc3a062dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jAseccTrjyaLWABgG+6jTe9720QjT4tvZ/wTGbzbcUrkXqpGLHg0D3c0hLMfFCXjWPE1mhytcGZBy1Hol8SfO2y9FDKgQ1SCzGTVvr8LSuRZ3Ll096PeJhl/3KwmLhjqHLnNoBWT7RWmFGTw9uar/TYjVr2Ss3VxfvU8iRR0fc4d1V+OGzcbyEpD62NK0pSJFox0Jli85TYvLa8np4qjlYD7fMNS24VWjGZAsjRpL9UFZNzOdmFDsdIJLZId4T7s33xc0fMvvkaN/y6kudBxf8fZ25CKC5QzClEhttqKYBO9RbGWiQ69cdrZ6gO+ONZAJibN4yXdQIJVCSKnao/+COeT0tYN6XlLozEVrMuPZbP0PapS3/7RKwj8+atriaGUGUWY79GUo+5Ix6W/Ntybc+1v8cugl7T/TKpi1yKWHivnH0O/zbvdfF692/TeyzAsrJQmBeE/F9ax6BeECkvy1FvXVmJf9lsr6wdGCO9SwcRT1XLE+pgcIMoHRBp2jMs7fj/+9hb78bRxTCiijT89iZtmkuylTEk0Q12jb/COqLK3vj4ARihtnXNAOX+PZs2fHzFOem3/WxnbJTEvRvl/2zqoegaeBkQT/nFGwcwt12u8Agsks1bZCF7RkfnDbhWZFGO0K0d2x/eXNT8iS8b9/l6EYiNFH72T3ujsCESWI8eBK1FElDsBL2RMPKqT05yzbtQIsciQniLBh9g5yTP+r8UQK82j67bZhLsaDBxX74k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SQhFRdEVkNwiRhgyPQCw4ZqTdjEwErpP2kBIOAIS0SZnvk2SqkKgVi07NFek?=
 =?us-ascii?Q?03sZ2l3oZ6cq5p2S20SeF3leUKA4+KfETPJmhbq596+KmZlKBZ4dgIXvnXkD?=
 =?us-ascii?Q?xJyjQ6H7Aml66HQg3rRIl87D8xwZHNM/0CM9a10r+pEo4A6GYrAepLZLw3pn?=
 =?us-ascii?Q?hHqYOAuM8qnvE6WF4bt0GK799Ofa4rbec6P5Q2Dd8YBUVeq4OxVj74c6a4Yk?=
 =?us-ascii?Q?lFax8NpDaV6PUW3GmOzzEa7+WUhmQHKHREcedJXhyCYRj0czZZXXMwglRHFD?=
 =?us-ascii?Q?8k5+dghUkQg5sVJvfSZVJJ2HkoJqVANCS5SyXML/bCTq67shaRs2vNFlp9li?=
 =?us-ascii?Q?xa4OTtjPBXRpKHCNhMADxXcllHSQWWzTJKm4xXVIRRBT5k1o9yVefrs7kohr?=
 =?us-ascii?Q?7zxcNop1ZmbBtN/S7nmZb+AKZmBn4aAAt4zRoejWuO5bX/RISnBRWyUmo0tk?=
 =?us-ascii?Q?I0fRcKZjz5M3mCt47aTgxDtkx2jlwsZxiPmMNu/Hi4EtGorpQPaVQ/tycGlB?=
 =?us-ascii?Q?md1Sv9ynFdmAFpOSlCn1XaW+X8hjrV0Ht61ISYsru/om0rXV2fYqYhtARLqr?=
 =?us-ascii?Q?rrjT8KOA5u/T18cgXF0MR1D9uPd+SOnSvyIS3RUZ3mVPSWCzgm/VNsM5M0Uh?=
 =?us-ascii?Q?rRr9CNbEeO2PRj9Hn6qL2PbR+4OtsUJxMUAkJyhMQxj0nBkB4zZh7eKqAXvG?=
 =?us-ascii?Q?wUMQR1CCKEYtmQ5tAj0g0nOUzjvK37h8veLeXe2J6+dXF3j9ellJPyJWWeTc?=
 =?us-ascii?Q?jehUT00YnpnjT8kqwDGHLt2DE/CYiES1RVtEbFjwkfbGcbmborFyuG/nlyu4?=
 =?us-ascii?Q?P1nVjbrOqyvegG5YT90KH2s+klPN+oDqhm1sRlt0gKQC1Qtb97Df3sfeEx8J?=
 =?us-ascii?Q?B+V5YbFlSo0BA8uMEcJgzxzs0OqQufJOC1WW5hwUm1zj6z3tDoltBoyiS9Xn?=
 =?us-ascii?Q?gqYQD2oFsMR7FdWZt8lryr1OJaRIhnXD56T9n1MdIm/YeMbbIs/WB5YdYAFa?=
 =?us-ascii?Q?fF4qzzTVTw7mHc7e0AzClZKvCDFnBQ1PRnjWAC82gjizxJLCnZL+tvGAgCd8?=
 =?us-ascii?Q?BeT/p5+T1yhQutNuOrCg3/ZEYm6TeAxOFUdokedbe86xp9z/YQlOksHbcQHH?=
 =?us-ascii?Q?2ATrkLmMq5mKzGsPlRuHSxcAX8Q06mZmeEIjLBu7mGXoBEl/GxTQSfMRvePj?=
 =?us-ascii?Q?+67nj3lIz8rl78ZPf1rAdkpqhLN1y9LTSI/MrC5x+CYmLvvvYJ/VMTNZlGrT?=
 =?us-ascii?Q?PECUMm6xCcedHOXQzwmL0AKrltnIGk3N7OMChHJ/NvX80V/TT41DeeW9iND0?=
 =?us-ascii?Q?+MBxK31jkjbiALJYdtGZFv+GagCVuoG4nk37BckEmqOX7hJppZkOdKmAgCYI?=
 =?us-ascii?Q?kDQbBf0vVtJaR8mFGkX3+dWyadKJ5bET1FttWMbL+8dXztSLjlNdFYn4Uptm?=
 =?us-ascii?Q?fFcmO/vlqQzlhOnwz6askdb8mjPaCWVYk2qXwCdSwXGQj/Q1V5XQ6DGqd/tb?=
 =?us-ascii?Q?8t30gHrJ8gETlUg63Rcskj9bO4ei59ca5ehg+XC9qKn5Y4JUNpXhe6vuUJug?=
 =?us-ascii?Q?82zJrNaPIWxzkxdN4008JnC4QUyD3iPGTIAgia/w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a38e3c3-9e7b-4f0b-1cea-08dc3a062dff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:42:19.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mztkGtuhbVkJNw21Y/gTwYrjtIaI9DJGBQLbTRk0kfEnQsolzQ+6cvcpdOFThDTCkh7I7WJrNVYQeyqnXrMUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881

On Fri, Mar 01, 2024 at 07:30:10AM +0100, Krzysztof Kozlowski wrote:
> On 01/03/2024 05:01, Frank Li wrote:
> > On Thu, Feb 29, 2024 at 10:44:20AM +0100, Krzysztof Kozlowski wrote:
> >> On 28/02/2024 20:14, Frank Li wrote:
> >>> Add power-domains property for asrc and spdif.
> >>
> >> Why?
> > 
> > i.MX8QXP i.MX8DXL and i.MX8QM need it.
> 
> Where is it explained in the commit msg? What about other devices/variants?

I will add it. These patches are for imx8qxp\imx8dxl\imx8qm only. If other
platform have problem, it should be fixed by new patch. 

> 
> 
> Best regards,
> Krzysztof
> 

