Return-Path: <linux-kernel+bounces-48219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBC8458B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D84291735
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDB53382;
	Thu,  1 Feb 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b="DNA0fAmc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2134.outbound.protection.outlook.com [40.107.7.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C945B686
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793527; cv=fail; b=oNMcL4kbpmRl8Y0vKdDDKNCC14ld6Yi8JH7Pzvg5Ta7I50Ti4byRNsM82iIV1izTQeE/Z67DIex35SJCL3t7RAnEIW321kkqV1ebcahPkO7nOxjbsE6mewk4/cdd+D3+37eZ/W53VGSp98egY69gBEk/iEKz9TbPe30MUiKX4vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793527; c=relaxed/simple;
	bh=S/aNv2lF06ooFUIcmaegi/4jt++yjayJ5fVpl/t9Ymc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qAdAIEJY4ngrOX0aghIDpnsACqwDHaZh4df6I50ufnd0cdwNsrDV8AFV0aPnpgDzwLW/g6A4CxNB3s/fl/QuPF2RxuCAVvqjdjrjc4Rl90/fSfinnS2fJJ2jzwkoRkHLPDZ7ouCNvcbgoWw5wG2DITNXpdgKgtLmL0+swZaCMco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b=DNA0fAmc; arc=fail smtp.client-ip=40.107.7.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeEt4NPg/T+bC4QONW2AQi/06eWlns+537JushcNi+OikOoIYjq/frtt/EeHEAC05N6LaKOI2hBL+dewPYUT03FAo3uOZ+Ec3Jc/ovu+6qXkcyGDq5xePn1p7z+AebUMaykPLK3zZW4lx4KiuBEvLAVEMojhYA9C1/lsgP73Wy8MjoTq+bDMEShBykybhZl+2aVogSkCLkMhQJmq5eNrLTliya3GlUm36jSGWr+kAJsgr4dpmX2cKppMnAb+aLykvaVxZlAJ6vIU1X6iheKtUOQ1Jpr86lI6PxIfInwYKhQX0ajFVv9hWaTy8UMrDyyxMEk5EiELZExsNM38senA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEE1Q44IuerTAix98C68lkBVz054z7wXlAMnf+3bW8g=;
 b=NjRHgde4xLT8hmAy4f/wm47CBLvXhFPiaaJu7iQPEQyGZc5FRcDrp2ZUheg5hJ6Ue48qCEeF1gjQnl9IdAfhiid7aw0IxcCSvW2vuGBVtrWxOQT4X7RV/ciGYF49xt67uOtCm6e12UBReKvKOEIFfXE5eJi6sgXRulDnCT18QbLk8pZHJr6q1I4kORoWS7q6Nxnp2DtaJetC4ELfFgXOa4BdSTkM44bqO5qMnGN8HHzNDAH5mRq7508pyuJ4aeL3K9EjWS0VW9r1zV0McBkHTDfiat+vDS6Qt2USGorV6GfV40PDMqEnXVNi3LbLLcAXK5MmTV9F3U28pBQcQagKeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEE1Q44IuerTAix98C68lkBVz054z7wXlAMnf+3bW8g=;
 b=DNA0fAmcNdlw2UUDbrA2qcNAPFSyk1I4Ke2+HIYoQvpttR6voOveA5xRL6fRhewC9Z43Z/sm5AH23rdzFhFaAB6ybQPmWJ0cMAYlrJfZ7EsZHp/iSP63JX1gOJoxshSH9RXtRO0ZXJGRDlvXeVSShEHe2mS11r74TJkvnxPuJ7s=
Received: from DUZPR01CA0241.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::24) by PA4PR01MB7248.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 13:18:39 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::c0) by DUZPR01CA0241.outlook.office365.com
 (2603:10a6:10:4b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 13:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 13:18:39 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 1 Feb 2024 14:18:38 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 0/1] mtd: spi-nor: everspin: add em004lxb entry
Date: Thu,  1 Feb 2024 14:17:09 +0100
Message-Id: <20240201131710.797505-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Feb 2024 13:18:38.0573 (UTC) FILETIME=[2B09F9D0:01DA5511]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|PA4PR01MB7248:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 599c823b-f943-4ac5-b793-08dc23284e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vIoYl3V1upuwX5lB7+o+KpNQUqQzezhyiV9YFmIaXF+x3Qf3nDCT2CqlXopr2U4bPLy2Ib2PO6hz/yu1pllaA/KniRoTRkLJ7yPwo5/mOQP4ORJD6QLi7g76MSLXWk1amvik1NZVul4j4FKjEDDwgRMKBkJ9/CsWho1Ts8eFA39QNUupou284mfmSAb/hzFAkwUZe9bQV69LJ1pBUkVkMci3kosMJI+nudoE/n/3g81MM3Jy/HCI3uGsAhkCvr2JMgiFRQFNE+lDRLesq1ZZG1xd3Prh60SkecRvV8cQuIu2++kraV5oT4DmEhUKBZymSOJwPp7wrfZtfPXEhZwv5M5ANR9VNEPZCnoOToW8DjVTl7JxVapq0t78TleSYy6Stx+TvHSh86pZENC/FO7MH7MEgxn4s7HPq8L6HzoQpHr9pzSSig0lDIWdJqfDC2/T66jZb37iEzNWQwcHJ27q1aiHvVW5zliG947AL3n2w4jnnt1q/6FBrRsdBAmFDBbMC5t1FxQdp8qvfEpfbVXkWMzoHgsCtu6Q4XkG5tkNWIntijTPbLV40Bv9Zdhmz0ot06mfCC+ENranZkuhcrAumBmGYRPmU03mVvcdtsgI1CiubLrzrWWxmyX4abe8U5LHntRaTFK/sK6l+1TayC6N1kj92zBOeNRlNRKE/qfVNG9gRX+YfSBl/0DwjM1S6tO+gKh4Jp4r2lbGvYnum2lc7s30yc02fHhXfJ/x53cTCME=
X-Forefront-Antispam-Report:
	CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(47076005)(83380400001)(1076003)(107886003)(26005)(82740400003)(336012)(36860700001)(356005)(2616005)(81166007)(316002)(8676002)(8936002)(2906002)(4744005)(5660300002)(478600001)(6666004)(4326008)(966005)(70586007)(70206006)(110136005)(86362001)(36756003)(41300700001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 13:18:39.2478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599c823b-f943-4ac5-b793-08dc23284e0b
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB7248

Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
Memory.
This device is JEDEC compatible (JESD251 and JESD251-1), but it is not able
to provide SFDP information.

Link: https://www.everspin.com/file/158244/download

I currently use this MRAM on one of our i.MX8MP boards.

Flavio Suligoi (1):
  mtd: spi-nor: everspin: add em004lxb entry

 drivers/mtd/spi-nor/everspin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1


