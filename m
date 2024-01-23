Return-Path: <linux-kernel+bounces-36159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60A839C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1096287F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D9754F9B;
	Tue, 23 Jan 2024 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ousD+g98";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ousD+g98"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDF537E4;
	Tue, 23 Jan 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050306; cv=fail; b=naHNZ8MRnP4lWpE2wkS9+GsBt/5YJgQJrTfNN8dDhZgw85jyegOkB3aEmiRMMiulmR6xBCFe7CHUrM1Nm3VkMIZ0JICDL1rb2hyUkzXbryGDAktAGSMJKmRINyuruPV79CsOZK8f246AjYLeyZrqwMlvjYTEaCw9pfUjP5ut5lA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050306; c=relaxed/simple;
	bh=BL+wCyu069pdREzTeNtCL3sbaTqIbGofOlCKB74fXJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqfOUUCoL20j052cpwK4OYPPjObwHqGShELuGl0lBFB2bSOAoaEp9jl/xv3kTp6b/7xWhwBeZIwMVSmOmjsjm/qYO2QLjg7Y33ffznTNVSdKRMAFxXGrnT/hjY1ruSe3eoD5sNJ7wlvZUQxG326t9tycNBL2byf5rBkXRaJct98=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=ousD+g98; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=ousD+g98; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Q0zLBxnPwkDeg9Qk4jlfBFNCuoVmGJr7nqtu/0vu2qijMIyue6vCvWUz8OGV7lFE0y1CD8yqEmpUefDhX0q82bduFNXePOwtD/xJMJIclfjqAWF6L7M3TdHzshkMsjvBAsu/H7h0k7b5ez4q0b9fRcMn9wAPr9UFmeIcZZa80/JfzWuif9c0ZwNg5QkqkFisQH+hwy/yARjYWQv+mGXlC7wjSl5Zsa1X6/T0zewMWs30fxnkC2RJsrjNfMLFWt4tVeXS7k4c2l+Q+R0WmM6SV9yZA3YXFF5C+CmaeYkJFbhW019s9uZn6Z6Ydk1jfs968N7BDftAwOjPABwHZXoLDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn3bdx/1ViQbIcXUPw4qs/B3XhdCQuZ0mCdbfnFzMa8=;
 b=bIhX8gJLz+fFCNhzDOiUH3rJKKg5LmhE3nt4DWZQQRpEjCg7eGEvP+sycRg6FWwpVQ70LrM/qXDfW2Fdbqmz/P4u5WN9oseDqzSn+N8RjRnsBtX3yP9GyTNgWCXjOJv9IbOWogAgxmAdI7sw2vGBhO0bk2Gra487eymu1GOd0DKlvm6aSsAf1pASu7keG3N8Biy/oeb5qSdnGwEh1rezQ0Eeq+7VdQedv/neyVB4RCIVeRWFWQS2gDu8iIpuPpekkUjDu4sPA03XnpQb4awKcdG5i0B1WEGs46i9/rVU1wOATQDj0FWKjxd3SgkMazoA6LxYlIiyLn+633DFWK8yMQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=free.fr smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn3bdx/1ViQbIcXUPw4qs/B3XhdCQuZ0mCdbfnFzMa8=;
 b=ousD+g98gJ4zU67AXppLHY68jtALzY6b8fogFBJaRaB79YL8y9If4SI7DK/uGLSEiypYqJ1D7y1j1x5H0HchSDwyCheizBPcm2/IqWgLgl7MD1QbN14Sb+GLluKk8xm5bGAxJfLnGblIC8IjUNIsdhMheNzXqDau3ZfVUjXEeTrPBhgSrpbvzK3oS8UYP50AGjDdyJEglrHLFuLwrfaz1gi9JOSz9dfcAmGWXpgROuGuBPRSf6kN+MEkrL9h89yh2lKv5N0sbjuiW6joL5FO4s6Ly7b9ZD4q8ABhZ0Hi+NpiyEXE37OE+FGZnLca2hlst5aS4qGrOgkvhWxcXwWznQ==
Received: from FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a0::17)
 by AM9PR03MB6900.eurprd03.prod.outlook.com (2603:10a6:20b:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:40 +0000
Received: from VI1EUR05FT062.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:a0:cafe::93) by FR3P281CA0174.outlook.office365.com
 (2603:10a6:d10:a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 22:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 VI1EUR05FT062.mail.protection.outlook.com (10.233.243.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.21 via Frontend Transport; Tue, 23 Jan 2024 22:51:40 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id E731A20083980;
	Tue, 23 Jan 2024 22:51:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.168])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 246332008006E;
	Tue, 23 Jan 2024 22:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrkiRKitTE/4uPkUeaqQ5Z/Xs63SCgETD4MxAHI+POqlPtw4qyu0mEKUFX6uvJDD2HeJ8dnGLTowg6Db9RmK1q7MgG6TIvcuayzA78pJllCsjFRqWp9FowMWuphZH2Ae48vwcs3R2xS263Gj7dk6aI/An9qDGHK6JiI2bbrcA1ODwpdw6/w45bDwSaV68tGu2oliIudsUNrA107O6HGtoOZh78I3cu7DRXtUUF69jSkeouyFCLeCjTDVc+kQtgq/vvHxowoCeddtC7VexbBtw2CVc4AGFz5qRM5TS8Fl9AiwRQ3UC5pmPfytvMUyc0qewW3p+emtHb7gtjZ069DuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn3bdx/1ViQbIcXUPw4qs/B3XhdCQuZ0mCdbfnFzMa8=;
 b=WJ+3zL99k5ueLaYtWeCd8714xbCnGhdn3YEEaIy8Q/gJTmgSUDkoW84iqRBZhOzUgHJf4lVi7FwNzQxxDtts3Upm7oqE2bpcRFTTZHgOv9iiRpC1CWZRCg05IOMaidyUgrnoVXu+dAMPWk0Jbu9RrFMo6of/Qjuupzm5A95UaELEiDktmXg2nJmKbDewQFFp9ecYxLZf/XOeoGV2jtOIkbW6WFjUI0Psphs+CyA/FBVE9tvxAGiI7XjOuCHYRFQx6D7dLk+O4Fk8FZxSlAWK7oLhZJOhoZVZhvT6Hir4Df4WL4VigK3WR5dlL3HcjiOYnDpwEIZ82EsOjwiNiHO+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn3bdx/1ViQbIcXUPw4qs/B3XhdCQuZ0mCdbfnFzMa8=;
 b=ousD+g98gJ4zU67AXppLHY68jtALzY6b8fogFBJaRaB79YL8y9If4SI7DK/uGLSEiypYqJ1D7y1j1x5H0HchSDwyCheizBPcm2/IqWgLgl7MD1QbN14Sb+GLluKk8xm5bGAxJfLnGblIC8IjUNIsdhMheNzXqDau3ZfVUjXEeTrPBhgSrpbvzK3oS8UYP50AGjDdyJEglrHLFuLwrfaz1gi9JOSz9dfcAmGWXpgROuGuBPRSf6kN+MEkrL9h89yh2lKv5N0sbjuiW6joL5FO4s6Ly7b9ZD4q8ABhZ0Hi+NpiyEXE37OE+FGZnLca2hlst5aS4qGrOgkvhWxcXwWznQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:36 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 22:51:36 +0000
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
Subject: [PATCH v3 2/4] usb: phy: generic: Get the vbus supply
Date: Tue, 23 Jan 2024 17:51:09 -0500
Message-Id: <20240123225111.1629405-3-sean.anderson@seco.com>
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
	DB9PR03MB8847:EE_|AS2PR03MB9792:EE_|VI1EUR05FT062:EE_|AM9PR03MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4e561d-98ae-40b6-75bc-08dc1c65dcfc
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 oIMly5ZVM5Fr7yoeGgh0prds10X6eInq7SUCALcIyAwhPm586Y5NTIkgbv2S/W+/NzPe0mkJKwEODpx+tjHG86WMcrB0+bWe2J0ZAveQ95xeMtF6AvRrKODcRnj4ovJujf+UjSkI8fcmseGLD/D0+9fKk6RSIusvjJ5VDZb1ZXAAB7Jf8OY01czHYn1IOV3JI7yjd97XDB2d4A1ehvHPKNGG+2UY2W5nO79X6L4jzX9uI6vKMI8GD9dVuOY792QNt1gQ2qjxib6BQ3o4hLwB3G8fQQYWkwxDg+X85G7GdAljziaLFZ/U/JSbTQYRl5fyA4J+Ra2Q0Qf4SGin6ogBO/EkZ2FeK8XuTDZynp9zkELxSyVKV4bPHZWDo0pUW96H6mb2BqEgU8JoqKPwtTkZnWn0vOoHBlWieDi/UnNWSM5ewWQfWLUGC4dpHarzz60T9hhU6RMs33tlkSeSb5zTiaStIY9RmWR/mv8opFtaRjZisV9o6Ho6NwFeS36HBM77PAc4n7htLoGILhGUPjeAUbct/Y+6Pz2yvAQTsYMjKLvtLCC8WRhLeyZ5BVZf2H73bqb45Kw94eaWKtoiF8k4lagX4296R/e45GVyHD2N0cNPHQB/OL8hNaeFnqxuZ9D/poQyMzVqzv/uMgMBYdpTqmRd4Xn2FFDVic2Lk2OT28vMdY0HMbrgKrmxJrryBZnxJFtaqtxi889Ci06b5yYucQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(38350700005)(66556008)(86362001)(66476007)(54906003)(107886003)(316002)(36756003)(2616005)(41300700001)(66946007)(6512007)(52116002)(4326008)(8936002)(38100700002)(1076003)(26005)(8676002)(2906002)(5660300002)(6506007)(44832011)(478600001)(6486002)(41533002)(15583001)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT062.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2b6e90c8-9138-452a-2de3-08dc1c65daae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yoLJc14pZ69zF/jtejjospyPPo+gdPCLrGuRM1HgPReZ3H4PlZNHCEsS8+yqUb+etufxElAsG2wFc9x6R7LErXGGB2D1d/92xt5mJ8yOpPGSeaEIXzpvDiLBJrKmmbezls49ve9K0Ozq1azQoq74mUFtlwPJAFWtWv1HXOP8hr1c4n8pIj90rOnefvo6vi1jM4BKIIav8R2YVgFYBX2haQnTQKeQcnBrAylOnyJcfgO/agZ/b2lFLFKiQ6D+zJPH1zG7EePFsrnCW9cOm0vUiin4hSWWO952RYe9eF6xBHO7OFgzOOxY1seVauWUtyMqaB5s3oJoUuQA3KoDLkOFnnwHoboGxx+cvLW80fguFZLFgbpY5fintsxGHCoDokY2c+m+NF+f3/xOng/X65gKxpDfdyLcFaV0qk+83qXOpUASJiyU0R3A4oKT52770IxNXOVeMiDoJxNZpSBWWv9VLPP4xAMctlullNJiPo2IVYtqcqFLW5IoN6mcz9fVWlm5AE/w1ocibMLDRvNay65aHR7laVXOfLP8LdISL7c4Je2MxjwYxqyfFW2va7u9831DeiiMjX9zOZRCdA0EcUd4w/mHk5W9H1bGjRUr0qcLSvSQXdIUPdsronRiV6iVToX40ff50dJ6cdYswOKRKhbeAqqanfsi2lkIqxXSnL/mbcmPoPY5VCICbAlR0fzwbGBJpGPpmACAd+ggEeKR+HeYkYEGMgZFwCTPpKIp2PkZ2Rqali7koO2HRcivCHjTU9NWY5rZujFOExhS2D6LVSHcaL/Cj+kTOB4jBfgMtIb4i4eN7WwEvheB4vj/ycmtGhJFDJPddeoTBwYE4ZHgPQZ5ciN0PkQXGArz7jjUBz17XH8=
X-Forefront-Antispam-Report:
	CIP:20.160.56.84;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(40480700001)(1076003)(26005)(82740400003)(8936002)(4326008)(44832011)(8676002)(5660300002)(54906003)(70586007)(356005)(316002)(70206006)(86362001)(478600001)(6486002)(7596003)(2906002)(7636003)(107886003)(336012)(6512007)(34070700002)(36860700001)(2616005)(6506007)(36756003)(6666004)(41300700001)(41533002)(15583001)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:51:40.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4e561d-98ae-40b6-75bc-08dc1c65dcfc
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.84];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT062.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6900

While support for working with a vbus was added, the regulator was never
actually gotten (despite what was documented). Fix this by actually
getting the supply from the device tree.

Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 drivers/usb/phy/phy-generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 9ab50f26db60..16494030209e 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -274,6 +274,13 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
 				     "could not get vbus regulator\n");
 
+	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
+	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
+		nop->vbus_draw = NULL;
+	if (IS_ERR(nop->vbus_draw))
+		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
+				     "could not get vbus regulator\n");
+
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
-- 
2.35.1.1320.gc452695387.dirty


