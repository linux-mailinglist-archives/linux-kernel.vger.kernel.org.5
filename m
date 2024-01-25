Return-Path: <linux-kernel+bounces-39019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3500C83C9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892FCB214D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5D133414;
	Thu, 25 Jan 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="2XyLormY";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="2XyLormY"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DDC131E42;
	Thu, 25 Jan 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202912; cv=fail; b=LFqzGnQyYSZeMDvJmDKxTUhNmBL3+rccximSQqgu6QCU6zB9OPcaCDy14EGDp5xnDJoO78VLLhh3T+LEq27ED9hBd9pzbcHKK84fJitLMGd5DgCi7wGNpQcbOce/RQMnU0EUP3guaL/zc2KGr/nwRPlKVpsNG3LbphCfI8eKKfg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202912; c=relaxed/simple;
	bh=Qpcwij7AfBSErqKKEkMSKSuE+WMJvalySV78ex88MME=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MRAPrAIg6r/nQ07bW3vZteNzYMgkHG9Zw+UBp/15x8DI2IqhFerD6FHIOUPadssMmOwps0H1u2iJY76Yuq+FY9HTX7RDpIW/o1Q3D2uB/8WRZQEWWKW6Bco637SsVXd8JBvPm1D2oTRnLaRn9OQLDRhlQ500hOjIvQPyYJVwgxE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=2XyLormY; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=2XyLormY; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=nQZVSFePDZ+6+T/uhz1PzTOkWnfpYKZFcDxaIhyjWHCbdugzWr0RXsfuh3MxZdLQo4ZiMEtR7l/h/YPED3P6q+O8Hlcb993S2tmU1fVcR1aBpoPM9PwvK8uJTPd6Wqg9GYbb/Qvxqssmwv1fMglbO18HhmPZgvddZCmwo3Ul/mLNmJai4hiCGQQTdsM/AAEvfkMhn5V6FsnInUd2g96ms294lq5++VeSYkjoXPDn3vzosQGhlcI7uDq8dQ00e4QpShyUJV6gs2kzk4dOsq5VmA+J5YJKkwJSkrkCDpdSaxUGzHteWoAV9DbSFCdPye3SPX/cSgs/ErnLaH2uSZBARw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+meKenhdePWJ279lofMLZAQKfj9qbFp0sWmtuhZbs0=;
 b=lNi7ffa0KWqrZ9VEHXAITz91EM368BpsMVhehPeZakE8l/a3zvh41NqZbT2GHuC03Ap3Pl+6mz895KTzvm4Rfw8KgyNqB6OSjlDa29TAGjTxFlfGDt0ytwoa6f2kyhh6kozDTSbZRS8CmLjUZ3O39RkFMQCLH30IcbTtRwbin2rRafWmQ8NFxZBHDjnRW3fHA+0bX+YVSgemzjrm/DhfI5GjsH8qKsdXF2YzR/glo0Q8fTTCQG/8ttm+aVF9FLKCfQax83Dbofl7C0+WeBPoJ1et3m/9xbrFzgaOa84Qsre5UKufiL4gXenuwb/lCvLvlTjYLlj43f/9gmxuucs0yQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=bootlin.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+meKenhdePWJ279lofMLZAQKfj9qbFp0sWmtuhZbs0=;
 b=2XyLormYfCFVmxEifXpD7+cAwH0k+l2SIOFMpuwRPVWTUFp0DhHzSyUsX9q2/ufdjWmf6XrpyEvYHxDgnycTRp6xceHeOMbbZaKxpPiveggEG7CKNMGaGEaDDPVsolAT0OB+c/o4PPrsLmZOZE5rGGNJzclkCwoGdDsTx8h1WtK77lKI96DHC2G2MVC7NhMt2cyNwAaVe4jHKLTBklXFuP+3TqQT+JyeIq1QjnXGT0z+HRnBbWbmYVUHwUIf0FgNyot+sdLm2D/YUFiLpAP60Jz+HXrU7v57ej6NmH/qLFfFBuoEVKZzxL8AlBCVx9Ut261J2/i/fWteufPNvt9tPw==
Received: from DB8PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:10:110::29)
 by VI0PR03MB10225.eurprd03.prod.outlook.com (2603:10a6:800:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 17:15:04 +0000
Received: from DB8EUR05FT012.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::2c) by DB8PR04CA0019.outlook.office365.com
 (2603:10a6:10:110::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 17:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 DB8EUR05FT012.mail.protection.outlook.com (10.233.239.1) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22 via Frontend Transport; Thu, 25 Jan 2024 17:15:04 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id BFD9920083982;
	Thu, 25 Jan 2024 17:15:03 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (unknown [104.47.2.51])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 08D9A2008006E;
	Thu, 25 Jan 2024 17:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPb+9PRtb1Dlla+OdtnZxoktz2wosAEGsCvVYDa61AhVHT41esZke9NuK+sYpNP5cEoKnNJbBwSJxV5UW2sMGm9JatIUqyX1O9gnUdbJ/eGvO1+YYlBF26bPBo/p7QzC9AtQ60Dicl/VLR5RZd7O1724KlWmJNSe9XE24RhnPr+MMDAM+DM2hMsPW0J3A+HZHOc4C/EbBq+SW+KKrkZo5wvGiHSFNnY6XngsikuJB4m5CvyO5IDRXZb8SRqkXIFVEUFVW7E/kU7OUsJCmAEN6+OS4wd7jWiwFFL7hnp61so35MhmQ1KQ5y1XvCtVWDqBm2DQjXtqSK0Ipp08YjvdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+meKenhdePWJ279lofMLZAQKfj9qbFp0sWmtuhZbs0=;
 b=LRbDo8lPOiTJsKoR2kJC4S1PSeu8sVPNGkC2+qxnguotavFAjg4ejPuqUsL55nrRyszw+s0IM6zRwW72IH5mrWMeGhq4QuyJica5AfOiHK9hvkCTkEIXYUgDGNmokYsTR06Ao1gb4qQ7mVwWvS8V3mufAGH6T8L2Iu2rsuqa7ZFkrxEeubpTYTt/wsQRJZ6Qb9nY5WzaxvomxT0I2Ckr8Oh1PGxF9Eml6XnQ5At+ric8vhxKDwJPYoYjLJbPVycsjLzUrLqy2vXuKi0XMZ37zlPLhJDccDTu2QVRb97/pYkK9gWa41QYM1Dogva81TJNBMmheLwK4G7IiSGFaEjA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+meKenhdePWJ279lofMLZAQKfj9qbFp0sWmtuhZbs0=;
 b=2XyLormYfCFVmxEifXpD7+cAwH0k+l2SIOFMpuwRPVWTUFp0DhHzSyUsX9q2/ufdjWmf6XrpyEvYHxDgnycTRp6xceHeOMbbZaKxpPiveggEG7CKNMGaGEaDDPVsolAT0OB+c/o4PPrsLmZOZE5rGGNJzclkCwoGdDsTx8h1WtK77lKI96DHC2G2MVC7NhMt2cyNwAaVe4jHKLTBklXFuP+3TqQT+JyeIq1QjnXGT0z+HRnBbWbmYVUHwUIf0FgNyot+sdLm2D/YUFiLpAP60Jz+HXrU7v57ej6NmH/qLFfFBuoEVKZzxL8AlBCVx9Ut261J2/i/fWteufPNvt9tPw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9492.eurprd03.prod.outlook.com (2603:10a6:20b:598::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 17:14:58 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 17:14:58 +0000
Message-ID: <c7c90be3-8dcd-4737-9fce-01343da01855@seco.com>
Date: Thu, 25 Jan 2024 12:14:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rtc: abx80x: Don't warn about oscillator failure after
 PoR
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20231019163931.3682923-1-sean.anderson@seco.com>
 <c3cda013-eab0-46c0-a89a-ed51ecfd1e1d@seco.com>
 <ff40a221-38b5-40d7-a0fc-cf617853a096@seco.com>
In-Reply-To: <ff40a221-38b5-40d7-a0fc-cf617853a096@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AS2PR03MB9492:EE_|DB8EUR05FT012:EE_|VI0PR03MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fdbf91-20d1-46d1-e2fc-08dc1dc92bd6
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 e7K7ENTghfKmZXARTC+u2emv4pYjdXM+QwUvzYShh/iLb1M3bBCBs19Cu5jQX6bCp+xGnQrlqBaAkzz7IOYLU8Eu6aUO6MSlCehSpvyDtGIzb+vZNqzMBnPrZWMn6yujJ40U58m5XC5hcoupm7loauKU5mjigDRIiSAzgJdCDSh/jYRUVbykvdwsS1+fModu/rVKN3l4aTKGv7PTufkytEMpa/GbeCPIhiuvgkpMyNFZl/f/vwY9pFHQlRJEU3K9Id3z5Pn0U6ROEZmMiUsIs48GGjpC+KNN9LisXfHSWYtzEDjD76PKAgKFHAl/PILFvQx9/vNK+Uz0j/MVdoCpyqFaOcbt/aD8V2I+pm4sOGjgkQpdhcnl4pNGMUa/mcHvMXku3/8keCC+6v72GI/cSe8kO639irXPErrc4u9CNAokPQ86r3HuRa+GtLnlX4daVVrh+9jfRWyZUADKBk7WwuA5kxSFg0ck/c1UoDnMO/QD3iSwPIeJv2lrZWvvTBaONs7giox+AZb+aDf942cof0iqw81yyWTFH3r++DerEW12m7Kcuo//86HkSPWKovOkOXYoXSvNlNjYZv/zyc6qOptlJsSsG4k8GEBbAHUt+kX/ci+yMlXSWK/iMRrPZI8LMSddKHWX00c/ZIzmFHtTg0mkPM8R/f086KVv/fuais0BJDxyQs8oV39DESdJIboOj05aekf/mFoAl8IYUzQOVE8YGF/hzMfOxzJaxv0ouqA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(346002)(136003)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(6506007)(53546011)(38100700002)(36756003)(52116002)(6666004)(2616005)(38350700005)(6512007)(31686004)(2906002)(478600001)(6486002)(86362001)(110136005)(31696002)(41300700001)(66556008)(5660300002)(66946007)(66476007)(316002)(44832011)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9492
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB8EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4e3f7e81-ad89-4abf-0e6a-08dc1dc9285d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qOpOOrERUkRag/Tuo2r6amBuN4TKIiarx5bJx70Jpq+NBP9pdp1jfPu32Rk2DseOSLnx4p7hF3vfPy3Ad5fyYaJMffCLkcL1dyRXNUrtH0oyYctew63pF7WT9UuMulpe0JsK+g6X483MUoTEA+NQb46z33s3+DNTGZljMuxg3xHld8EW+gek4mff9C960s0ds1ypc3k++cuI1Cz10k8q0HyUzP02W2D//GqhGWIrtTbzM+xkxerS4n3oO/R0BHuCDlvIgo7YI3ZyygQrTOkotABxF0DumxfISNIjyLhbCrtQ8Y9FRUsJEW7URrIGEcESrfIqVhFOszc/VYtXFbHf/XSaSrxTPmUeOwFXDU0NLIiks9wVVUJezLs4sHmcHMRWUDZiboCpKt703FHpU3LKBb+qALlavsI6RQOEpupfCu3zPSpyCQqhZHi+G2c1cUN+D6gxHmHCm1UhnuA1z5OTax+M4MaujuT7+9H4cEHLyyHPTEv1qcMmdi8RzOsVNY70ILEuDd6xx+J6KgpzAZrky5ZmjgMW9v9Kx1NsRxZ8PEVhsYcKSppAl95EwfZmlyx+UYCyr4AOgLRKsQ9v8dJoMXDbq1XSxVpKR/7BNeAt/MRwt20y8FNtf+Busn+3n7KTVqsdek8uO1XTs9B4CPrM4ZvOejCn+smrhwpKx8oam8HsT3OhXpVzF+Nx8P8EgpCrZvLfTeD5ovj1s0VvTxQCOcB++3ASv3Xom41j3Al90LAA8tuK4U6NZlSWpSvqAVfzffETU3ARUnzY8vM6jUeACkjQNMv1cylVCVKucGeVe2BE0Wyc0qNw+tlAkStRW4p/Q9N4gLt8MZtD2dSADtsa1QinZsq5jHu8D0yt2F6tMHA=
X-Forefront-Antispam-Report:
	CIP:20.160.56.80;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(47076005)(356005)(316002)(6666004)(31686004)(40460700003)(82740400003)(36860700001)(34020700004)(7636003)(7596003)(40480700001)(53546011)(6506007)(36756003)(83380400001)(336012)(2906002)(6512007)(8676002)(8936002)(4326008)(86362001)(110136005)(41300700001)(6486002)(478600001)(31696002)(70206006)(70586007)(26005)(5660300002)(2616005)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 17:15:04.0121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fdbf91-20d1-46d1-e2fc-08dc1dc92bd6
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.80];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10225

On 1/8/24 17:05, Sean Anderson wrote:
> On 12/11/23 11:03, Sean Anderson wrote:
>> On 10/19/23 12:39, Sean Anderson wrote:
>>> According to the datasheet, the "oscillator failure" bit is set
>>> 
>>>> ...on a power on reset, when both the system and battery voltages have
>>>> dropped below acceptable levels. It is also set if an Oscillator Failure
>>>> occurs....
>>> 
>>> From testing, this bit is also set if a software reset is initiated.
>>> 
>>> This bit has a confusing name; it really tells us whether the time data
>>> is valid. We clear it when writing the time. If it is still set, that
>>> means there is a persistent issue (such as an oscillator failure),
>>> instead of a transient one (such as power loss).
>>> 
>>> Because there are several other reasons which might cause this bit
>>> to be set (including booting for the first time or a battery failure),
>>> do not warn about oscillator failures willy-nilly. This may cause system
>>> integrators to waste time looking into the wrong line of investigation.
>>> 
>>> We continue printing a message about invalid time data or an oscillator
>>> failure. There is no voltimeter in this RTC, so this is the best
>>> indication that the battery is dead (or dying) and reeds replacement.
>>> 
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>> Note that the following drivers all warn when they detect a problem with
>>> the oscillator:
>>> 
>>> drivers/rtc/rtc-ds1672.c
>>> drivers/rtc/rtc-pcf*.c
>>> drivers/rtc/rtc-rs5c*.c
>>> drivers/rtc/rtc-sc27xx.c
>>> 
>>> So warning about such an error has good precedent.
>>> 
>>> Changes in v3:
>>> - Use info since this is a good indication of a battery failure
>>> 
>>> Changes in v2:
>>> - Use debug instead of info in the typical case (no battery)
>>> 
>>>  drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
>>> index fde2b8054c2e..f463a58a240b 100644
>>> --- a/drivers/rtc/rtc-abx80x.c
>>> +++ b/drivers/rtc/rtc-abx80x.c
>>> @@ -127,6 +127,7 @@ struct abx80x_priv {
>>>  	struct rtc_device *rtc;
>>>  	struct i2c_client *client;
>>>  	struct watchdog_device wdog;
>>> +	bool wrote_time;
>>>  };
>>>  
>>>  static int abx80x_write_config_key(struct i2c_client *client, u8 key)
>>> @@ -179,6 +180,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
>>>  static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>>  {
>>>  	struct i2c_client *client = to_i2c_client(dev);
>>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>>  	unsigned char buf[8];
>>>  	int err, flags, rc_mode = 0;
>>>  
>>> @@ -193,7 +195,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>>  			return flags;
>>>  
>>>  		if (flags & ABX8XX_OSS_OF) {
>>> -			dev_err(dev, "Oscillator failure, data is invalid.\n");
>>> +			/*
>>> +			 * The OF bit can be set either because of a reset
>>> +			 * (PoR/Software reset) or because of an oscillator
>>> +			 * failure. Effectively, it indicates that the stored
>>> +			 * time is invalid. When we write the time, we clear
>>> +			 * this bit. If it stays set, then this indicates an
>>> +			 * oscillator failure.
>>> +			 */
>>> +			if (priv->wrote_time)
>>> +				dev_err(dev, "Oscillator failure\n");
>>> +			else
>>> +				dev_info(dev, "Time data invalid\n");
>>>  			return -EINVAL;
>>>  		}
>>>  	}
>>> @@ -219,6 +232,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>>  {
>>>  	struct i2c_client *client = to_i2c_client(dev);
>>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>>  	unsigned char buf[8];
>>>  	int err, flags;
>>>  
>>> @@ -252,6 +266,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>>  		dev_err(&client->dev, "Unable to write oscillator status register\n");
>>>  		return err;
>>>  	}
>>> +	priv->wrote_time = true;
>>>  
>>>  	return 0;
>>>  }
>> 
>> ping?
> 
> ping again?

Does anyone read this list? This patch has gone unreviewed since December of 2022!

--Sean

