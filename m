Return-Path: <linux-kernel+bounces-71136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944885A12F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E7C1F2185A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7D2C19B;
	Mon, 19 Feb 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rqTFRqoB"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9A28DA5;
	Mon, 19 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339233; cv=fail; b=OLqRX2N4cauqxTCWlHh4t5i4i4i6Y7zrd+OIYhRHHCRgDCYWBGZxrbUrf64/RV8WlXn8luBvc0hECWkQkcwzeWoUX4e1uCVy/9Mq27yag+17uJAyZRVsfNBFbUq1RL2ddIXVsDzY79Z6o7GiBSRNJx4ngisx9UPd9bCNwZr9Vk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339233; c=relaxed/simple;
	bh=L6U2OAAwVRKc0gTgQd1TcXCk5W5b1e9KbmbesF5yYw4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sObvG47aQzaFNMxIekciZcAJUYfXaUFWxGnAHRSi4ZYEWDojjur5nY6b/uCetjn7TRiytq587/Ay6sVL+JYwdr076VapWc9UYa8aeRkUlAG9vPTCIP164fOwOWYtETPqAtx2SNr2sfUMLMNeJEbpPc/gUjzrNPlBd2kcekrg0jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rqTFRqoB; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU2VTH1eut77oclSE9R0wcSB+rnozKpoSNk9+pSwWEoAd+fCS9PaOCwJIBXPCTbn7x9N+5Q1D8a0cLYQ0bL/dlREnRbZAn1kl+pmh+IaO6aiV4MUn4MSHG4cLU74P3IoI8Y2ueyXTbDytG0FCnRI5WX2D52IRLTv55SfUA70laiKwNy0ZWv4DGBSf05tnxW+Vbrycd/Wv/V4l3L5zTAXnUqnk4p7UD8R95FN0H5cwUwWHi3wuT0NN87BqOS2S4GFhr/ivDZjE4IG5f6pACEkQ5EQxSZaE5EF175Yta0YkH9QtVkSkxMtKrJwgG13qgbu8lqtOC8BszQXvV+dfZqbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDbCBNu3oeyi5MymT0a6IQczxYyYAYRyEjLwSRNj4Vc=;
 b=ZwrcZqnLK9LuGVddo76C/RGqxWeCuYdt0MzT6pFVC+D48Qb7s6CSp/Tr4NefH+xSXW4YRzNdlnJdiFqVde9AmULYr/BHKa31zJ+Kgqn1S0DvJvbfR38b57lnIAip0BjgZm0PfAtoAe+wvmO83HazR8QVsuPphv7Y9iL5Z8AQR05Sa3W0dUGdRuiahj6TS30R8rePll3qL/umnLCqsvuf1fHp2bcr1wL2DSBR+hx4k8qA9cESazcJ+ecJ7TCnxoEJ2YyuIx8qN0rK1MN9z+FsXoKHI80Hhqs8AnKhcRY24MojahSOjToC7ZlFfHhXXhNQgQWGGAr+6SGw8AyD6CpFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDbCBNu3oeyi5MymT0a6IQczxYyYAYRyEjLwSRNj4Vc=;
 b=rqTFRqoB48C6eY/HNPmSM2YXunaLNeM4Qi4m7Os4fpf3vp0yfSSsifNODnNRYANIRKnTLL3TOeyCPBjyPY41GT4wiL4LWiOpk5xC1cdzOzqiNp9aonoRADAU3Jh460tRUlUE/GjgvsHB6WDqrV658J2g2xQcPZs12ljM6MTuFy8=
Received: from AM6PR10CA0059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::36)
 by PA4PR02MB6511.eurprd02.prod.outlook.com (2603:10a6:102:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 10:40:27 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:209:80:cafe::f6) by AM6PR10CA0059.outlook.office365.com
 (2603:10a6:209:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37 via Frontend
 Transport; Mon, 19 Feb 2024 10:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 10:40:26 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Feb
 2024 11:40:25 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Feb
 2024 11:40:25 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 19 Feb 2024 11:40:25 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id A1D7F149BF;
	Mon, 19 Feb 2024 11:40:25 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id 9D5DE62A1C; Mon, 19 Feb 2024 11:40:25 +0100 (CET)
Date: Mon, 19 Feb 2024 11:40:25 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: Jesper Nilsson <jesper.nilsson@axis.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>
Subject: Re: [PATCH] net: stmmac: mmc_core: Assign, don't add interrupt
 registers
Message-ID: <20240219104025.GM22484@axis.com>
References: <20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com>
 <61bdd802-abe4-4544-8e48-9493a6bb99c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61bdd802-abe4-4544-8e48-9493a6bb99c8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|PA4PR02MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee31ed9-da99-4c0e-3369-08dc31372f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zxdo/kh1rWZBn3lSzFN/H9ixiyoYfzpQZNSXPV1rWjTUUPJBXpqrcfggHt/Yvi1gDUOa48fEO5SsDy1CMoMzS9V2dXr+yP5jpNYbB6XxWpiI57alE5GP+DrJBMPtoR+MlW1GeQt6afWEmCOBcX3wdZY42jxBjUfNT3JfN3ToX1yLe3cyXn9q7Z+xPtSX+GACak6WQvidj52YvBBL7UG9Kn8zT7MziDwQfIfxN9bDb6qmXbzf8VUE19r7jzrPTpmRHyuDqftXu8KKTGwgAQbFtEHQjoolCbg+W8Sp5U4v/i7mOTEGIX7iGOxqQtQyiKw6STYCBQPEaxlgBTq/FBERMI8Zm8YmAtm/dTcQ7RQ6pA9x3k1f/faCu7QIz6y/nYtfscvvdgF1s1Nrpz2LUxiKh2t8ZocEmdAOSP78di235bL/2lj0v6byIZYIsEd3/jkYTUH4IILsX6JIAvqoNXu5jPfVfHIwZrGVTPTV5j3SWqrjMd0gIyXlaNw1eqlnlr5daZsthvqOAPnMguRudLKZT8jAFRCu07Mp5UGBPtn7ghYGV+aNHaW757+Sr59DtuHE9Imz/vfP6a3B688CoV0WxP5gPBkBHnvBugvunk0WRj1ILYA7GieMWrBQZWmH2uipunso5DjZWXS9/BeQ/DDjU+EI+9KGs8XOtUR3+w0ugVY=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 10:40:26.3556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee31ed9-da99-4c0e-3369-08dc31372f49
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6511

On Fri, Feb 16, 2024 at 09:13:51AM -0800, Florian Fainelli wrote:
> So in premise I agree with the patch, that incrementing those is not the
> right way to go about them. However these registers are currently provided
> as part of the statistics set, but they should instead be accessed via the
> register dumping method.

You mean extending the dump register code to dump the MAC Management Counter
registers that are not counters?
From what I understand it's only the Rx and Tx interrupt and interrupt mask
registers that aren't counters. Oh, and the MMC control register itself?

To be honest, I don't think their use can justify the code churn.

> In either case you will get at best a snapshot of those two registers at any
> given time and I suppose this can help diagnose a stuck RX condition, but
> not much more than that.

Yeah, their use is very doubtful. For me, they only introduce more nonsense
data in my logs.

The Rx registers looks to have been added in the first version of the MMC
back in 2011, but the Tx registers never was.
In commit 1c901a46d57 Giuseppe mentions the MMC interrupts as something to
add later (if actually useful).

So Serge's suggestion to drop the entries completely is actually quite attractive.

> Florian

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

