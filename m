Return-Path: <linux-kernel+bounces-55022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8684B67C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685AEB259DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F2131732;
	Tue,  6 Feb 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="S0hAeeSz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="jEngtK8m"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2122.outbound.protection.outlook.com [40.107.6.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408E130AC6;
	Tue,  6 Feb 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.122
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226442; cv=fail; b=QjZVitOg0J+zkcu40v22jG6lJaJgcbGrt0ECMI4mkgW45Kasg9zPZc5/m79G+u5VzlYqSghSFfXIPkAMI8iy6e028O8K3DRz0ux06CrbEqyqWfNaf7+uAlRDMo4oCADsOxkAFBQFH4BbXnmVG0v2188g3yi0XqBcQdt2BCABZsA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226442; c=relaxed/simple;
	bh=SiEZmL7T8MHv37sxo/pEHNbovgT2UbIPjQV6bRl22Ic=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7xSMgYKlybgNpQNc51n29HIxN7YNSQzVN+ExWeP9JGcKOdEmzJbsCmsSN0Sa/S2lZXyJFTns26Haw/BkC6hPdJ1GwITnurT+JRR7SARZK8GZnBm0folGM7NYK8wWoTczaj0VJ7WwxGdxYWAoHgHLuREzwyN3IjoJbDgwRSBMfY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=S0hAeeSz; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=jEngtK8m reason="signature verification failed"; arc=fail smtp.client-ip=40.107.6.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=mk0ikegXTyNBOyKDvngHXNlN2oGMhlb0e/W0OnucP8ZNmSPPDUwDDqjCe0BvM+bO16mZiIV42ifpOZgXtY4GjP3tQdkwODsyvzJdHs6iu/QGMFs9KoDQSPhwYyx05wuIubydC4eE0Kj1YzZIpA1taZurKsf9Sll3Ad0I2pbwgN4Gkrt+BTE1kLVF0Pz/TaMaL4xqCnlEIXssuQ7+WEv4zql5VHgVV6z3GG3iPYhYj/I6flO6w1cixT3o+4+UL6cXdDB7/hYLuyu0akJpFyNS0Pwf3f09bbLZuqVKA26TOl+DvpcW1eRmoOiiATZy6HOjBHkbaSli7CEyLh1JjwjziQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM1QA/DRsL5oap3Lo8NmPBv7Vs4RU9eRXht8rdEs45Q=;
 b=ACTHSOuKwHtwXV3FQzJojTCr7yZ0kntLiUjg4yj3AyDGFN+rEz2QaXOKr9EvjTyWKjrwE8QZUvzfNwE91LmD1QhPbNlGW8qrrnhdoORpJnBWbZK7nLtDR2hOPYqf7IO8r/tALkpps07auUw4526l/8IbiZ7BLV0AL1RSqy82IlaRvy4ssFdER/U3fTgjAe0SIFTae3sm5hMtVs8p/kEv3vPZFzdzbbQaDlLzyuHGpYtQUbyeehWT8k6nArqQQ6RhqHuuXpUT3J5+p8/rHDdfwSx+9Q1c2EZamznlEOx57iSuo1QAQ7Jb/XNfKUN6qQu8lpaMjaVbt/Mpw7pvU7/76w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM1QA/DRsL5oap3Lo8NmPBv7Vs4RU9eRXht8rdEs45Q=;
 b=S0hAeeSzIm8IVB20H7bCEVzPswnYj1vJkxwgAqnkyuWDkxNnlSW9yawis7699JYo+yzuJa6KDHsQKFi1AIQI4Q1XxZ0f5STqXz0DetYtB03pl2f4ltcCmwzR6swyuNc6eUMTQrufy5oOZPqUMicAw5I0BA0i6HcvIOkOedps8J5smmPTJTPVwWSUYDg9L2kmdKxN+6AEszjnGH2DsC+aM7n0TiyCs0i7zeJUtk3Ff4z7oiH9QmjpgU6iUAYw3Prrnae08sd/kkONQRDbpKFD2nZkO8aBMN9BGYeYrXF5Wl8ZLzongIHRftH8AcpepRM0WsXF8HwjgXYs/+BWNMrhAA==
Received: from DUZPR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::23) by GV1PR04MB9184.eurprd04.prod.outlook.com
 (2603:10a6:150:28::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:33:54 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::b4) by DUZPR01CA0108.outlook.office365.com
 (2603:10a6:10:4bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 13:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 13:33:52 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.41) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 06 Feb 2024 13:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0lzDeXRaOIas27pr5TrQwHvwGK7NgFaOE1rUsx81PpyM1pb7FHBYPQxftLvUV8YgqFsE0OV3pSqBX8XojLKNxmrdR7LiBHPYBLXh4hNU1s+E6d7mT4YS2jzloA0c8sVxgoovJ0fRRoWK0fbh5YSoUc3TNFrb0JRprhp01EEvcaCqstXkwN02QIE3bchI5A2gUZCvsrsKL2SNsITl8eW0VL5dg67wFGnGqSj6TIFWCtI3g2FpacD/p12u6diICgC0tgSBa0sSRAts/P/XNUbJiLslFZGYCSOVzP0zDO7r8OIF2OiM+CrURCTJs/P1a33lYE579lSDd/MFkKDGOwoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdK6iIooH2ENLOLz6x3oGaT7AjVz0fRmJQLxN6bjwWE=;
 b=ht1/XI+xLkWgqYFynh5LwV+5shiIOiqN44ex7QdgsEYmSTDq1hDFLsjcs2SPLBM+n0SF55f2EHnezSbgw7LO+I/605Z2amJB/r79RYuF79QktgBCvC1mACpUTZUG2QayjYffvKFBKNY1IwOb4iz9SjGdYWO1i3kvw8/RGini5vHuCPB7aDjJhb0uK8qGz/aFsqVlsK9guDUapvU9NT8zarV1FjdgEAMjEX0wZ57DsmU/EU9UlfFMqvj6Ua2lqLgRuI5Ke0LiSfKtL22Xh8X39Uu7VeAu0aUzRwtHskLOkG/0yKkORA40Hp39PRpzg7eNWC22u/wfv4Wz+/W+8rOWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdK6iIooH2ENLOLz6x3oGaT7AjVz0fRmJQLxN6bjwWE=;
 b=jEngtK8migqiYxVIXIClDVHcKJxU4zfzERqMOAKnd07dBq0uEW7r5UobWZdkvcMkxXv7E2yP+JaJm2dm9DQ/ggVSYDRDdiMd8Rkkqwb9UvvtwMgdYpIGuOUn+w3whyUvfljlepN6gxCdEGKFv43YLfORWYMSsH43Qn+SerEVFHiOgBqWoVUR7zYNJc8gEUqmDIBfZ2pud8RKY2HUkejaIM7TtvRrwIJpxJXh4+YeT6OCq6EF5mssfG0D6gC2IPQ5H8QjuvZ4YYysVHQvDOpeHw5+5rp+n1FfK+t7pM5VVe/rC/nHrNQkSpYTKmsMhrgGUDsunqlxK/lTRo4oYeJ7Hw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS5PR04MB10043.eurprd04.prod.outlook.com (2603:10a6:20b:67f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Tue, 6 Feb
 2024 13:33:48 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:33:48 +0000
Message-ID: <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
Date: Tue, 6 Feb 2024 14:33:47 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Content-Language: en-US, nl
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Beguin <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
Organization: Topic
In-Reply-To: <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::12) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS5PR04MB10043:EE_|DU6PEPF00009527:EE_|GV1PR04MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b92c7f7-628d-4d04-5f72-08dc271842e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 lVBFOywXOD1oGo9aUS+NxClpTg5J/nsJyzVHkTi77aJFXOYR/vsPx8U3vXlNiqVOSABGs5xxNJuNyAC9719C4kYCXVfU7ML4nkpj/TIi9sQMzTMcazBaUbPFylmBpkCgJlffD+iTUjhTg0e630u3IFHqTChw1daqSXOtveTuaiK8lOHVQMVYkXTRprtPSpD1rBANlhQJqLCrBQp5Fb5/9F5poZV97NHbV3fNynzlr+vekGZYvTESjWDosclchWhcbOi/iSkxNLrs4cGupjN0m1O+5P9QFo9Cp6KMLMqEoq1dX1ENK6X457i7rkNMcszkaZH5GB6woxE81uWvJ2M1YBV0XLlBfPhlyhFyCSE8xLh5kHSL23ixUazUH5pm7w9Jd4k2W4BhexY5jpkyBdjD4CPbzF6xCiE0qrwzarDQz0MTL29fEDPy4afQXM41AU0A8gu/mBzYu/UZYib4XpVEbqX3mEkb1u3QPU34T0z5uaXRGE61r2DzGK5cvfB9BDlCmOxCSMQrfSa93zIv23b3pD82ILaT5mZ96M7TIjU7coTOwoSOls5RMF7jqFu1nAX28aiDhYMjAA+qDAdmJwUS2gW+FPr7EXQBHrE2IrYz2IsnGs8poTpbLXkO02u/Lkg1394B0btk1CH98dqjM1w67QqKDPN0TCwGl3kW7u3qJ+A=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39840400004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(2616005)(52116002)(36756003)(38350700005)(53546011)(36916002)(6506007)(6512007)(41300700001)(38100700002)(15974865002)(26005)(86362001)(83380400001)(31696002)(6486002)(8676002)(4326008)(8936002)(2906002)(7416002)(31686004)(5660300002)(44832011)(54906003)(66476007)(66556008)(316002)(66946007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10043
X-CodeTwo-MessageID: 8b0bce26-243a-475a-94b5-8de6178611d4.20240206133351@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c1d034eb-e0ff-41e6-eb2a-08dc27183fe4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+5//xjd6YuTo5Nnq7MJsRdSwtF1LYHruDSXITF17YBH5oFiJYtdQ+iKA8vCCE2+2MFjfZOVJg+z/HEtwQkYQhkqyiihFEovFuqPhYVqNF2UCbz7KWNJVCxyjOQ/GcWKV+s7eHY5GjpDxGMIgMYoJAw1VhGsms/fy88GPCBuoh5gjOyRU9Bv+VqMlfWP9EnSQV5SKbij3Ux7iU3XgKAt9xarfHkCldGPr1SUApLKnHFKbu/CwJPtUHkMik9hgmQlGPNs6R5e2Q/5W6CB+2mDyDSS7GEcQ6zgwiTpOUB5phhODkdadhnc+asqgDinvU6pVMCRSeoVd+OWPvvZ07n3LwXby7SiAxSiHw8DbNQQO3SR+iw4q3m9zUb9Zhl8sGKhddTbDDn+KLRYJ+CiIGbH0LCk+wK2HxoZ65WrnABdUFXHwo9brEoWbq70v88WfncsPP1WHLlHG1B0dyPjjpjg0zF0f8gbVW4RoKSQuxgJTuGn/54u5X9nzSMjrPHs3FBsj9xI8f1zNR58+Ym+QD2ZZcllHoj2KB5i9aFXqRYQkdYbs7YyTLGnvr6mgnYZlJxg+RmIUTk1LQ8QIRK9ESSmYJF7pqlvnnqED82B3z1oNKMMbsWu3nDq00tbXfKyT4I0WsAKYCyclZtUSR3Yg8fx0BpD2Z7xFh+F73p4tFRwW8Wirxr6nQkoicxvdil9qq4pxQDGAPYRSsZ1RlXDkzpUFWWf1FlcKYo/nTc72scQsxo3Jl+EXXvPGIvvbjbPQSeOQhR44647z6CJxi31BgCTPRg==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39840400004)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(36840700001)(336012)(86362001)(15974865002)(2616005)(26005)(41300700001)(31696002)(7416002)(6486002)(5660300002)(2906002)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(36756003)(4326008)(8676002)(8936002)(6512007)(44832011)(6506007)(36916002)(53546011)(36860700001)(40480700001)(47076005)(7636003)(356005)(7596003)(31686004)(83380400001)(43740500002)(18886075002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:33:52.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b92c7f7-628d-4d04-5f72-08dc271842e2
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9184

On 06-02-2024 13:57, Andy Shevchenko wrote:
> On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:
>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>> typically used for ECG and similar measurements. Supports data
>> acquisition at configurable scale and sampling frequency.
> Thanks for an update, I have only a few style comments and a single one a=
bout
> comparison (see below). If you are going to address them as suggested, fe=
el
> free to add
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> to the next version.
>
> ...

Thanks for reviewing...


>> +/* Registers */
>> +#define ADS1298_REG_ID		0x00
>> +#define ADS1298_MASK_ID_FAMILY			GENMASK(7, 3)
>> +#define ADS1298_MASK_ID_CHANNELS		GENMASK(2, 0)
>> +#define ADS1298_ID_FAMILY_ADS129X		0x90
>> +#define ADS1298_ID_FAMILY_ADS129XR		0xd0
> + Blank line? (And so on for all registers that have bitfields defined)

Makes sense... Looks too cluttered as it is now.


>
>> +#define ADS1298_REG_CONFIG1	0x01
>> +#define ADS1298_MASK_CONFIG1_HR			BIT(7)
>> +#define ADS1298_MASK_CONFIG1_DR			GENMASK(2, 0)
>> +#define ADS1298_SHIFT_DR_HR			6
>> +#define ADS1298_SHIFT_DR_LP			7
>> +#define ADS1298_LOWEST_DR			0x06
> ...
>
>> +	factor =3D (rate >> ADS1298_SHIFT_DR_HR) / val;
>> +	if (factor >=3D 128)
> I just realized that this comparison is probably better in a form
>
> 	if (factor >=3D ADS1298_MASK_CONFIG1_HR)
>
> as it points out why this is a special case in comparison to 'if (factor)=
'
> below. What do you think?

The "HR" bit sets the device to high-res mode (which apparently doubles=20
the internal sample rate).

But "128" could be written as "1 << ADS1298_SHIFT_DR_LP" which is the=20
max oversampling factor.


> ...
>
>> +	wasbusy =3D --priv->rdata_xfer_busy;
> Why preincrement? How would it be different from postincrement?

Maybe better write this as:

--priv->rdata_xfer_busy;

wasbusy =3D priv->rdata_xfer_busy;

I want the value after decrementing it.


>> +	if (wasbusy) {
> To me more robust code would look like
>
> 	if (wasbusy < 1)
> 		return;
> 	...
> 	if (wasbusy > 1)
> 		...

wasbusy could have been unsigned.

This code will only ever execute with rdata_xfer_busy > 0 (or the SPI=20
driver called our completion callback without us calling spi_async first)

>
>> +		/*
>> +		 * DRDY interrupt occurred before SPI completion. Start a new
>> +		 * SPI transaction now to retrieve the data that wasn't latched
>> +		 * into the ADS1298 chip's transfer buffer yet.
>> +		 */
>> +		spi_async(priv->spi, &priv->rdata_msg);
>> +		/*
>> +		 * If more than one DRDY took place, there was an overrun. Since
>> +		 * the sample is already lost, reset the counter to 1 so that
>> +		 * we will wait for a DRDY interrupt after this SPI transaction.
>> +		 */
>> +		if (wasbusy > 1)
>> +			priv->rdata_xfer_busy =3D 1;
>> +	}
> ...
>
>> +		/*
>> +		 * for a single transfer mode we're kept in direct_mode until
> For
>
>> +		 * completion, avoiding a race with buffered IO.
>> +		 */
> ...
>
>> +	wasbusy =3D priv->rdata_xfer_busy++;
> So, it starts from negative?
>
>> +	/* When no SPI transfer in transit, start one now */
>> +	if (!wasbusy)
> To be compatible with above perhaps
>
> 	if (wasbusy < 1)
>
> also makes it more robust (all negative numbers will be considered the sa=
me.
>
>> +		spi_async(priv->spi, &priv->rdata_msg);

The "rdata_xfer_busy" starts at 0.

Increments when a DRDY occurs.

Decrements when SPI completion is reported.

So the meaning of "rdata_xfer_busy" is:

0 =3D Waiting for DRDY interrupt

1 =3D SPI transfer in progress

2 =3D DRDY occured during SPI transfer, should start another on completion

 >2 =3D Multiple DRDY during SPI transfer, overflow, we=20
lost=C2=A0rdata_xfer_busy - 2 samples


> ...
>
>
>> +	dev_dbg(dev, "Found %s, %u channels\n", ads1298_family_name(val),
>> +		(unsigned int)(4 + 2 * (val & ADS1298_MASK_ID_CHANNELS)));
> Castings in printf() is a big red flag usually (it's rarely we need them)=
.
> Why is it here?

Compiler complains that the expression is "unsigned long". Probably=20
because of ADS1298_MASK_ID_CHANNELS being so.


> ...
>
>> +	if (reset_gpio) {
>> +		/* Minimum reset pulsewidth is 2 clock cycles */
>> +		udelay(ADS1298_CLOCKS_TO_USECS(2));
>> +		gpiod_set_value(reset_gpio, 0);
> I would rewrite it as
>
> 		/* Minimum reset pulsewidth is 2 clock cycles */
> 		gpiod_set_value(reset_gpio, 1);
> 		udelay(ADS1298_CLOCKS_TO_USECS(2));
> 		gpiod_set_value(reset_gpio, 0);
>
> to be sure we have a reset done correctly, and the comment will make more
> sense.

If used, the reset must be asserted *before* the voltages and clocks are=20
activated. This would obfuscate that, and add a redundant call to set_value=
.

I did forget to use "cansleep" here, will add that.


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




