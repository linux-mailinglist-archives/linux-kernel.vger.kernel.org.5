Return-Path: <linux-kernel+bounces-36161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F168C839C92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BCB1C23279
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6ED5A794;
	Tue, 23 Jan 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="owGlNnnV";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="owGlNnnV"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A05537E4;
	Tue, 23 Jan 2024 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050314; cv=fail; b=b0F3nY7zNCWK0om+U0h7ctszp23iZNZWIpD6UJpwvDRGUC4GgeKC6AHZAhiVHEP1SS/r9giC6aYeX+FP6bnjqw2kcsHfY4J44PoOBsAaCvpGDrsZzzVTx7cEWABS0lfineGNRTpZ5hZpxPFPvKqfds/lp4U2Jc9Wx7M0xl8UXoY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050314; c=relaxed/simple;
	bh=KOjlN/VRD+j9F7LEY27DLPI5jA0bLrRW/apJlN6qXZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aEGC0ht2SbStJLMXVOwg1l8CEMz7RMoCQBJKuMfwzwK+ev9i4fDghbhYfnN3xxCbBeoD7hxzb32GQJ2i+jwbNOpiDDg2mGywscWKM9SgCs91t9ozzOnM3UH1kiJuu/neOhi99U7ifI0IwuxbM9nZz6wgsLljcaE+LQTqIGtTI8g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=owGlNnnV; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=owGlNnnV; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=D+nFyWRB+yj7xaV9EtcsMCRguhkrL1+gYInbbYKqCyA6hHCDmF7ln08RwMbKdhu2KisOwupG+ivdOmrTu+ad1wsJcrPPInjCtOBapFgz0621myoUWeD8C7ep5VUsXoXDqGm+WtFVskxuBat8IQO/pKnMsrgla13M75ln1a0jgenveRQCUMwjZqpaqjeTJeiyqjVq38NmllUiuICy/Bc/2+zFjySauaxddJnS59KzUKD5A3ZFEu80SUU0hjFo1hYiWsMLJXy9TvTLD+dfzPsdeWk/iSzpUfn/FcxO3GkRlH/0jrgkKIRpvFfDmyuhdv5FaTN/zmAm4NQ7tep/XXRtNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQwdF3zdAmdqqJrogk/goljRhoD8cVgWt282GWXQhGc=;
 b=jasmJMVEuPk4fr5pk+Ndjb+N0+2yOFnFj9bTwIEHOFNemAN6oxnaXVr6vhuOP3haIN2/3CnQTsl4Rv8/lehzkFdzt+cama1A6IbqFKwf66o/pUJleXkO2cTkF9s7bQns9TLNvxuqt56YfyS+xtYSf5VS3og0RfB8a6mXUaNdvOx4/CNZv4p3QGGr+9VAWWuBOZhshfWvEQw9KLwZuFEhgdaHC5uwj3g6f0Suv9mG1V3lDjbPsZAQ08/ulkPPh7kS98xPigRwdG5Mai+J7qjKujI/Zks1/pwxdZ44w+bXX9Tz+d3tcoiptyS2IJYJAeE0qItsZYDx+hDMhfQaygAaYw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=free.fr smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQwdF3zdAmdqqJrogk/goljRhoD8cVgWt282GWXQhGc=;
 b=owGlNnnVPSzpgrvsTiSbBToolvozKrFjY22IDKbsu8vCkP5nOv9ZRCCcIhL+ZSmyWSxWP1EIlsC0kzyxSfuTeX/X4PLTnKHC4He0ZY6SrsChZFw2pKuqKREjePUKysP2tgT0f++OFgCs0PbTOai1nDNf9UxNNt08htFqlMiHLcrT+OON2zIVj6ZgW26dyBCozceODf3+nvFMG7Sk8BByS1s5D+mv8ZgPWG3AtBcZjqhcEXsqILFQJahzK+RmC2FRlv/H+UMNwwr6qygNkpQ+cBV0uKLu8fczB8+VmgDCpwZqBtD1p2TvxmtoxePheIl1+owVZoDwXnL8mGIoxuySfg==
Received: from AM6P194CA0051.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::28)
 by AS2PR03MB9443.eurprd03.prod.outlook.com (2603:10a6:20b:59c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:48 +0000
Received: from AM6EUR05FT044.eop-eur05.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::f5) by AM6P194CA0051.outlook.office365.com
 (2603:10a6:209:84::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 22:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 AM6EUR05FT044.mail.protection.outlook.com (10.233.241.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22 via Frontend Transport; Tue, 23 Jan 2024 22:51:48 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 04F482009538D;
	Tue, 23 Jan 2024 22:51:48 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.168])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id CF5CA2008006F;
	Tue, 23 Jan 2024 22:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGLxx2Cz6gU2fIpTGcnAyNEO9890J3Cypb+j8ylC6qLWTcRBPlS6D9mpkJ0QsyAwiRqL6gcPj01huBNJGiPiu7CeDzlVpKKj0uTGW0YmjlZ+P0VviTA+RCKz7CAIqiy6pFPcFptq23Gk+YprjJ/STK9yviO/hhcBAw9U4mfuAruhwOySlMyaeK/XCsOZ1G1UVTKXXlleOnR+91ZDUrEDnayVbry/941/npP0oqXnGIbhgGt8xPqXT5f59zWbHZ7ptM4wgt835koZytvK5gS+uqw/9Ho5GMUJ3feVQgDyGS/dWWflezhThXQrcLcex7SrQrEJZMPcMqx3qttGdVmidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQwdF3zdAmdqqJrogk/goljRhoD8cVgWt282GWXQhGc=;
 b=OAJCcMxXI6oSlf32/XBM96Xj/Pm1XidX+eCTHkol6vzrsrRS7apErOPc9mLLQrLD8ni23d2NJGa89gYeVn4jR6E1/KSBVsijeLFY7TahPCskB6sh4mgcJiklqgfeHGxRWaINzxBH/PAG9nFxsP5L2G5J4YOYxALlP6NvFhrsU63fmI8PnJDqx8adfIbF9my5ke0Lh2SX2mPTSFMOqYFD/hoMg2QemvVL8YKuMB/hHTiVkVxM5XMwDgOZh1ZCtuiMYrxdaLwsG+myd115Xx3yxx3dmSqlDmuY1LQJKqm9OkGGFrTQg0ykKNmUmR72D5wndEa2Ckc2nVUgeqowHsajTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQwdF3zdAmdqqJrogk/goljRhoD8cVgWt282GWXQhGc=;
 b=owGlNnnVPSzpgrvsTiSbBToolvozKrFjY22IDKbsu8vCkP5nOv9ZRCCcIhL+ZSmyWSxWP1EIlsC0kzyxSfuTeX/X4PLTnKHC4He0ZY6SrsChZFw2pKuqKREjePUKysP2tgT0f++OFgCs0PbTOai1nDNf9UxNNt08htFqlMiHLcrT+OON2zIVj6ZgW26dyBCozceODf3+nvFMG7Sk8BByS1s5D+mv8ZgPWG3AtBcZjqhcEXsqILFQJahzK+RmC2FRlv/H+UMNwwr6qygNkpQ+cBV0uKLu8fczB8+VmgDCpwZqBtD1p2TvxmtoxePheIl1+owVZoDwXnL8mGIoxuySfg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:38 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 22:51:38 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>,
	Felipe Balbi <balbi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Jules Maselbas <jmaselbas@kalray.eu>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 3/4] usb: phy: generic: Implement otg->set_vbus
Date: Tue, 23 Jan 2024 17:51:10 -0500
Message-Id: <20240123225111.1629405-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20240123225111.1629405-1-sean.anderson@seco.com>
References: <20240123225111.1629405-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AS2PR03MB9792:EE_|AM6EUR05FT044:EE_|AS2PR03MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b9a4e5-d2dc-42fb-416d-08dc1c65e1db
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 dbKl2GSIEU30j42pVyuHNhqMEB33Y6B3qjRH/G1c2CkKPzlClcPQw1/ZIPlVbXG0YVlr183M+bfGxH7fR0W8YABobr7NdIv7SRH6XA/xFWh/SjpntOykhVU8sOme15PhvPQk9nDGCWW43i8WTlHDSJ8Ijhqt8JBAyrw0sj6iReYnzDDGaqrw0Dc+Zs21cc0pMFe/nH3NzgnGiaRjm+e/P7KpA/ZycieEETKg+xFQz+ig4Lf4NNmPKTW9evHlaxTaDqBmqeGnVUEGubiy6iwGlL7zdEnk+rLxXeXr+BO8/bSYafVQoVtaUcpiZiNQizy4q/BJhaKl/HW3j4TPc+pg5oTgdS+1ue/7wDEx1Z6uWyRC08BXCKoZaANFuMDAbScyXGAYhr/6kD/8YZcBFYDYmHSFSigj0Wd+N/eO7MTPQp17ndzC5SmU4PZF1hdCnEsUwXl2nbU9IK8DwW7euueRxXz+BgTSB4jzPfBro3J9GRNAJp8zNNA9JUfv+sDM71HBFeQeqNGXAbTx2rna9RMx0phKZUZFl1wLvxdP4vNWsQaJo242sgylqkvYv16RfYSmmfTo2Rs1PEeV8SzZWg+WFYWWysRrzcjNHQD6kC2w2ihwKP4VOU6PUgdtFBSt/asteUqf+MFf5tqjC1h3vMMbDc64E7kk1O4u0wIXkDjbZqY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(38350700005)(66556008)(86362001)(66476007)(54906003)(107886003)(316002)(36756003)(2616005)(41300700001)(66946007)(6512007)(52116002)(4326008)(8936002)(38100700002)(1076003)(83380400001)(26005)(8676002)(2906002)(5660300002)(6506007)(44832011)(478600001)(6486002)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM6EUR05FT044.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	37430a67-1934-4ee7-4a13-08dc1c65db8f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9cOx/PpJv9OvHS36WoUZvPrpkIMW7sRZE+hLkVUu2vJIwEPQoMzVyO/sEDvkvD/9HCGWgH7LhoWHk0uoZ7GrTVpB/uFEBnmRTaItrJfAWNfHK46PMRQJSkKyDIHC8Wn/1BMGNWT4bL8BfwT6hy9qAd4ugpF6SS26IMbXJXzS8QS69DM35Re3pBcvNgQCMGry1FC7C7ev2KU66wEOD69dn3e3U/DI60HyZsToce0aS2U32oKwg+/SVUy1ZXgIwQF53nhsdoALASNtOXbBua9nWubtCeJHk/sCAhUJsEnXTNZag2JjWcbPgEF2M5snS2LbxNfjQjA0Ykz8ISJp3sCsu1Eij+YTTx+xQ+HVlbZ+TA8MZWY7PTOnhFF9hN2HA1r3nmZQ0fajMP8pEqOBWdCyKiWvT5wQMja8Ju/oezT0uJtrHsLoA0D7JI3RT3xS2zome9Sdk61NxalnsS/UaVEqeDKkM0pZXCIP/vzBUy40lMTK2g135EP/FlGCj9f9s7syEdgCrmtrTJET97OcJqaxlBASbSEipKF9JRd1WNBBe4DLILr5y/rTBM2RISTqme1i5KansY8WSpJt5W+hkDAg7mNiZuI0I2hfp7SitcAmxu9jAQ5e4Emvd7LZheSfv2aXvm8bX4bB2YnFa5ZjNI/88BwKSTDrY76s14YeVoe30S/2wXdqFWWXTVZjJVbtV/P/n1Q67Iq5c07MUdtMwWKRRZ3uvNpE+miOfrP4ibQdOG8K2DUlJJLLsgSrmzfETVtI4Ki0IDdQcYfmg9Bat04UTSycgrdzkQUJEniWz5saLw9iDvBk7GCk4IWXkWQHitc+NYu4aNs+fytJ6T1KrL1fdA==
X-Forefront-Antispam-Report:
	CIP:20.160.56.82;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(6512007)(54906003)(70206006)(70586007)(2616005)(1076003)(107886003)(316002)(40480700001)(40460700003)(5660300002)(336012)(6506007)(478600001)(26005)(6486002)(6666004)(83380400001)(44832011)(2906002)(36756003)(41300700001)(34070700002)(86362001)(7596003)(7636003)(356005)(47076005)(36860700001)(8676002)(8936002)(4326008)(82740400003)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:51:48.5816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b9a4e5-d2dc-42fb-416d-08dc1c65e1db
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.82];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT044.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9443

Some USB controller drivers call otg_set_vbus when entering host or
device mode. Implement this callback so that VBUS can be turned on and
off automatically. This is especially useful when there is no property
for a VBUS supply in the controller's binding.

This results in a change in semantics of the vbus_draw regulator.
Whereas before it represented the VBUS supplied by an A-Device when we
acted as a B-Device, now it represents an internal VBUS source.
Accordingly, we no longer set the current limit or enable/disable the
bus from nop_gpio_vbus_thread. Because this supply was never initialized
before the previous commit, there should be no change in behavior.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 drivers/usb/phy/phy-generic.c | 45 +++++++++++++----------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 16494030209e..f7db24b5ed5c 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -74,33 +74,26 @@ static void nop_reset(struct usb_phy_generic *nop)
 }
 
 /* interface to regulator framework */
-static void nop_set_vbus_draw(struct usb_phy_generic *nop, unsigned mA)
+static int nop_set_vbus(struct usb_otg *otg, bool enable)
 {
-	struct regulator *vbus_draw = nop->vbus_draw;
-	int enabled;
-	int ret;
+	int ret = 0;
+	struct usb_phy_generic *nop = dev_get_drvdata(otg->usb_phy->dev);
 
-	if (!vbus_draw)
-		return;
+	if (!nop->vbus_draw)
+		return 0;
 
-	enabled = nop->vbus_draw_enabled;
-	if (mA) {
-		regulator_set_current_limit(vbus_draw, 0, 1000 * mA);
-		if (!enabled) {
-			ret = regulator_enable(vbus_draw);
-			if (ret < 0)
-				return;
-			nop->vbus_draw_enabled = 1;
-		}
-	} else {
-		if (enabled) {
-			ret = regulator_disable(vbus_draw);
-			if (ret < 0)
-				return;
-			nop->vbus_draw_enabled = 0;
-		}
+	if (enable && !nop->vbus_draw_enabled) {
+		ret = regulator_enable(nop->vbus_draw);
+		if (ret)
+			nop->vbus_draw_enabled = false;
+		else
+			nop->vbus_draw_enabled = true;
+
+	} else if (!enable && nop->vbus_draw_enabled) {
+		ret = regulator_disable(nop->vbus_draw);
+		nop->vbus_draw_enabled = false;
 	}
-	nop->mA = mA;
+	return ret;
 }
 
 
@@ -120,14 +113,9 @@ static irqreturn_t nop_gpio_vbus_thread(int irq, void *data)
 		otg->state = OTG_STATE_B_PERIPHERAL;
 		nop->phy.last_event = status;
 
-		/* drawing a "unit load" is *always* OK, except for OTG */
-		nop_set_vbus_draw(nop, 100);
-
 		atomic_notifier_call_chain(&nop->phy.notifier, status,
 					   otg->gadget);
 	} else {
-		nop_set_vbus_draw(nop, 0);
-
 		status = USB_EVENT_NONE;
 		otg->state = OTG_STATE_B_IDLE;
 		nop->phy.last_event = status;
@@ -291,6 +279,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 	nop->phy.otg->usb_phy		= &nop->phy;
 	nop->phy.otg->set_host		= nop_set_host;
 	nop->phy.otg->set_peripheral	= nop_set_peripheral;
+	nop->phy.otg->set_vbus          = nop_set_vbus;
 
 	return 0;
 }
-- 
2.35.1.1320.gc452695387.dirty


