Return-Path: <linux-kernel+bounces-36157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17A839C89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936AA286651
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8C54676;
	Tue, 23 Jan 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="TOHQS+ms";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="TOHQS+ms"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8795025F;
	Tue, 23 Jan 2024 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050306; cv=fail; b=WZhUJRpTNcvvXOf/AHYXUR22Mi+qk5fnGDtbbDLimzxW33ck0mzjYsN3gZaNAuumUJQJ3eQ3aqSzgId49xQYfBfUyVCR6P0J7a0eSuxoE5mYGa9+Iy/pgpExH0jE7npkNE2pEfYBNoUPNFc3YFUIoYwF6Yj2zp7l1yq9LHCK6Vc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050306; c=relaxed/simple;
	bh=Jj4I9VF6KInGiobsXznH2LHxr6rfPwIbS++ZMSEp+Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KWTFSWss0MJBfpgFa4a0+K7FCV/TEfPrY1vhwLftL8nVihTy9HRCXGcM8OaAGbbgDp+kG6QyMrAvKnjRJ3iZTSq/7qkjq9Bm4QSFAM/Oxucfpf+ryDYVyl3q+EONGELyhELUfUrkIeEo5XDEeqEA741DKpl3FCsVu5CmBdq2ac0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=TOHQS+ms; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=TOHQS+ms; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=K3euqvslYEtCOVBn7AzXU/kujcYc2exvEq5jFtp6ykqhdpsGhteCvgzt+sV0o46L4q5fpzY0HcQ+3psTIHPkEXWbWlNIv0ofgTmUbfMK9jLHzytns+LuLw+i0Agn4M5B0TwCFadwyVJRr5F9R5nIilhe9MbMwTUBf5oLxLizw48jf4Cjz3Y22//Z3lupv8AVJHnXYuNyMtU/tSG5x7KETFfhnms9SrIebIyN0tIbKb5mtKOZIVvnmd5AR65vrGRxqbBHFgAkYSFVWt9+bnKvqijt53mSHNZFx5eIQ9vHoa5+r3qfDENn6IToCpkdTbn/5HrglgN8cZZ/LR+S1eetrQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXYnK9NTn8Tim2nFkXSBgM8WEKZcSzwzJQvXZEm32Es=;
 b=YylcteoRg4I3c9d/OC3J7cnpeskxPZutMzbE9Hv+zkfpG0C7WhufUW4s0O0p/KOxbH8RRIgIenVr6PHqc6Ey+kT3Cqtf2RvFCsn+VYog031ZQBRNtptGrLXIB8SbN089f48tRwxAAudlmRQDp31K+JIqeWO89Kz81Zqn7ZgrrYUZisGgqNURMFKjHtnDx05tkez01DpKqMzRlwTaJQEJ3BLw8Ld6ieHKDr47tYyjx1DA40TaIanLEyxnvazCtt2OvMD75rJMktRY/Is55mDZozMqlP63MKI12PpwihFLOtR4igEYSH6DTdQdGfgOfu1yXxvGPFqsYkeVgcRC8pw09g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=free.fr smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXYnK9NTn8Tim2nFkXSBgM8WEKZcSzwzJQvXZEm32Es=;
 b=TOHQS+msL2e4BZO8pRc/8pt0Mq1WuU5ZpeS/q9ZLdFL5dA+9XudBEQHRRnMPIZqvcNYWB4JhmGyEh3ZA9EuFbcuD9D9Ain6vEOkMAyMeuCnK7bsrqwSTGneKIQMThPd/NvGOrNnnZwW3zu7qzjgu7fpCmx7xojIrXLXl1n/diIaguAXvWxYLlZ+IIiRMcpwrldROwlO/IJIssckPNUoLfQYKh/ZTcf3hLw8ysQH0+GhDqU+Tjns3zK95ga4wPbVbdCWPFe38CAnwzkZWGXmoj/SlG042YR+vsFH6mkr9qD7n1/EsgY89eWjGiAJ92wdyRENl7kcpEO0VghewU11s7A==
Received: from AM5PR0101CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::32) by DBBPR03MB10393.eurprd03.prod.outlook.com
 (2603:10a6:10:535::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 22:51:39 +0000
Received: from AM6EUR05FT047.eop-eur05.prod.protection.outlook.com
 (2603:10a6:206:16:cafe::23) by AM5PR0101CA0019.outlook.office365.com
 (2603:10a6:206:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 22:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.83) by
 AM6EUR05FT047.mail.protection.outlook.com (10.233.241.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22 via Frontend Transport; Tue, 23 Jan 2024 22:51:38 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 55ECA2009538D;
	Tue, 23 Jan 2024 22:51:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.168])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id D6A272008006E;
	Tue, 23 Jan 2024 22:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7vThHk3FRh61rrBMGb752sZMa4T04a0n66LomMHwy7Ygavb943JvR2axU+Kgoo1s8XK9Wm6SejSRTegcCH+fR+E2undC+RhNEW5a2mxobNW4F9sSPbTahLuouXzUhPsglhC4Y4gXXpr9vKNyACSsA4sw2zd2iB3WtZiXz0zoVjFXCevADCubMOC5EbjWy5aDqwj7CihThhJRfn78u8V4MhOnt265rUCNmnpXOOqUYxaDE8ryGKFBkQ1a5kk/vAZ/EV2Vfl5tjWmAUKl26+EP1bocMtvhP/VgtGA7psBtGvKzXlvfFMhzB0ETmP5kkhCPSNWHmj6qbkZ0H0YMgBBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXYnK9NTn8Tim2nFkXSBgM8WEKZcSzwzJQvXZEm32Es=;
 b=RxbFSsFpU7YMtU9GX8F3CsSgSYuus0ILLdMiG6bIyCEIsprdzN8Q4oCrJs3bmK7JeI7Mv8iNM3WlAEZ6M/2RXTJMI0CVSBK6IQFAbjulNXipr2BoV7CGnlaDUeMNPM0lqIxFIzSAj/BmokT++BGUx9rZvcbCVP+y037udePEMK7Ua43iP/E3ldjWuhYXRFNSnV1UCNJH7fQttlm1+y0YN7zY210MavFahNKJ+kaWzdmciDFDoX2ghzMMCWS5u2jRrsIJ6Vxp2vL6znKmFW/DhYhdNAgDI7jxWqYHj/LCvF9CqJasWToE6xhTLMQGvJc627BkzFHr/Hcnqr9bZialyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXYnK9NTn8Tim2nFkXSBgM8WEKZcSzwzJQvXZEm32Es=;
 b=TOHQS+msL2e4BZO8pRc/8pt0Mq1WuU5ZpeS/q9ZLdFL5dA+9XudBEQHRRnMPIZqvcNYWB4JhmGyEh3ZA9EuFbcuD9D9Ain6vEOkMAyMeuCnK7bsrqwSTGneKIQMThPd/NvGOrNnnZwW3zu7qzjgu7fpCmx7xojIrXLXl1n/diIaguAXvWxYLlZ+IIiRMcpwrldROwlO/IJIssckPNUoLfQYKh/ZTcf3hLw8ysQH0+GhDqU+Tjns3zK95ga4wPbVbdCWPFe38CAnwzkZWGXmoj/SlG042YR+vsFH6mkr9qD7n1/EsgY89eWjGiAJ92wdyRENl7kcpEO0VghewU11s7A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:34 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 22:51:33 +0000
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
	Sean Anderson <sean.anderson@seco.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] usb: phy: generic: Support enabling/disabling VBUS
Date: Tue, 23 Jan 2024 17:51:07 -0500
Message-Id: <20240123225111.1629405-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
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
	DB9PR03MB8847:EE_|AS2PR03MB9792:EE_|AM6EUR05FT047:EE_|DBBPR03MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b5e533-ed28-4ee7-3d74-08dc1c65dc0d
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 k7gdKpkzgJCEWoAh1NaZVgdJyLlnBYFCaiWOMHefDhMK2wLRjf+ottHeWJMqAQZBPBoBU7vqOmU6bU5zj7wDi0y6OZzfhcZh3KHrKib/ntpnOuKgrAjd2NsVofpl2O7s3QIL249KZXcua7UZnJaeDMA/9SJbe1pYRAlUEYj93rr9L9sqZbXAQtaaiaTl+vXsvYjPwEOeHgLl6jPTKq74r8kuDyiJFLISdgqT8rUO4Sh2yar7P15sDvRKb2GJBUXwOm+gCDgHP1VgktP61ocyCSXkHt5Cc5oNqeSxcZt4npC3HNskO1v2CCSNV8hHmXdFY+dVClvyfw6vEW3i4SwQYP4anMa9e+pvUSbC9orGjHzq8kdHCKSylCOtJ0dWbZO2ch7KbXyZcge4Zqs5180gEohunmfcYBvJ8PPDz0t7ih3J1WmboltxFUksTdqIL1nMP1iFBqDDY5KTL2KQabfQNfE+VXAU8dxyuZm81pkUOVOM2TGQINasiu+JIt62qAeJDihJeF+hAzeSm3IPctjalunVKOISmrTIC6ShLOLwfX0JlXnfNNQSTIv+8DCumFyxRXnTuNvTSRnXK15xxqJ+L3/oAx4C6AdjuVkkBwV+4wpjSEf8LQNCFtNXVobhNg6HK4g5JVYroaMi2P99JSOciv4BHMqHSUu972uYgNKt9uk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(38350700005)(66556008)(86362001)(66476007)(54906003)(316002)(36756003)(2616005)(41300700001)(66946007)(6512007)(52116002)(4326008)(8936002)(38100700002)(1076003)(83380400001)(26005)(7416002)(8676002)(2906002)(5660300002)(6506007)(44832011)(478600001)(6486002)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM6EUR05FT047.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f018b98d-d105-4365-2614-08dc1c65d8e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FIF0PF5O9PjHd5hclMB5yy2zww6vqrdT8JI34t53KxpCaEGzJbwFD51uycl8Objd6avPot4p5I8PJbtmIfHfkWCKtu9Rofy47Eo7fsh9zfa69ljS+P7nHaNK4yvTqR9f6A38owVXoAAhBlL2pMoTL3uqnTYRY38mSxkCGoI03hH0wrDaWQbQnA0xa1Cklc35PIl1HfhQ+hR86hi9xRatvwtArLvXxapT1Oak2UFscyyOnn7Y5PHdlj0AlKPD6oRapvH3abDade1Q8qals0i10uyqBuw+ZU+S3c3eHhkZ/AGEaYapV0AXBXrnJD9rqwv5O84BZsuLMYVbxiT3jgrQPSaKTleJ8/q/vXSb8bdXkaANxd19VuwLmHZMvJCWTzB3OmkBUL+IkEsyyqIuM5GagZuvYP+i0BpoIlrZePM8WtMPxCXQQ65CB+AWMeYGU5TsRhfXufA+vFROvESH2Dw4jW7tmnaybBeeed3aQLWTUtnZpuRDEhhjicmr7zmroD5DgNX5qMPE5aCENHZlCSRFTclFXuJE3oEVQoQtj0Tium+fLTyaQXRTBf2zbkPWL7kjEfGxs3b0Qwmh69ptaqk+Nf12666eFkkG9T15YOTApn3fxazUSraw7Sv7cdVPF5aDj9sKZp+23bZ6mLh5YBWcGiHueITVqpQGV5fSYzqbpTfpeOzntlaS+jm6m0Ge9TZqNjR2g3HX6ipbyO/5iaDJuixECJCA8l0XoA8nkHnn2ZJonaWbBu5I0Nltn7/Y4br3YBxZ4j7GgsVhsKKHXQjNgITGNmC3sKq/r4t4J35x+9os2AqDhDPiMcGSv3LAO8eloUPvH8TcZl40e2zmvCwB5Q==
X-Forefront-Antispam-Report:
	CIP:20.160.56.83;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(346002)(376002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(2616005)(356005)(36756003)(6506007)(86362001)(7636003)(7596003)(34070700002)(8936002)(82740400003)(8676002)(4326008)(1076003)(336012)(7416002)(26005)(47076005)(36860700001)(5660300002)(54906003)(70586007)(41300700001)(70206006)(316002)(6486002)(44832011)(6666004)(6512007)(478600001)(2906002)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:51:38.8428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b5e533-ed28-4ee7-3d74-08dc1c65dc0d
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.83];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT047.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10393

The generic USB phy has had VBUS-related code for a long time, but it
has always been broken, since the regulator was never gotten from the
device tree. However, the support itself seems not very useful, since
e.g.  usb_phy_vbus_on/off has no users and usb_phy_set_power is only
used by gadgets to make sure they don't draw too much current. Instead,
use the VBUS regulator to implement otg_set_vbus, which is called from
several drivers. This results in a change in semantics of VBUS, but
since support was always broken I don't think this will have any affect.

This series is pretty unpopular... I only got minor feedback on one
patch last time. I'll try to remember to ping when the merge window
opens up.

Changes in v3:
- Update description as suggested by Linus

Changes in v2:
- Fix dt_binding_check errors

Sean Anderson (4):
  dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
  usb: phy: generic: Get the vbus supply
  usb: phy: generic: Implement otg->set_vbus
  usb: phy: generic: Disable vbus on removal

 .../bindings/usb/usb-nop-xceiv.yaml           | 11 ++--
 drivers/usb/phy/phy-generic.c                 | 55 +++++++++----------
 2 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


