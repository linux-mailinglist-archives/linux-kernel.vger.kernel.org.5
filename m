Return-Path: <linux-kernel+bounces-46778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F7844406
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8728C1F27D72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0EE12BE8C;
	Wed, 31 Jan 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="OXzFm6tT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="TaKsxw1l"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308A12BE8D;
	Wed, 31 Jan 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718272; cv=fail; b=le83XTmWSv1oLfKGZJ9daWvvi2qYXpDiCx2UtJtaNBSj3HyNbUap/1GCxVgKIg3L+tm+VEO5NFNjwjxqt2P938CbzboUsNkqSVY8SKERmGsAg4Sf5QK0FEthgOqiPzlsYxUOBYrP+dOW3FVtpiekzKUJbJev9MhD3+vlIsc6Y9g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718272; c=relaxed/simple;
	bh=gxixSCUsvPCU5xQpEIaIysfZIxdF7FjGjz7Q8v+F+rs=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cc58wOORDKrtUqeM5JjRQYxaBHUcMCI8pzhHgYLPC0SDFSpVCCgV6qAwtpUPsT38mS7y/AuqRsLfb070MJbS/4HlIdj4a0rKHXGvshyxFSrMrAIhnc/2nMWA3qbcOLTTHsTRBeIcyAD87fxqb699y9ocKACEAN7r8VFVi6LLbbw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=OXzFm6tT; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=TaKsxw1l reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=JdHBMXKFGpyFJcCLQXsCRDxuUJJQCKcVBlrqaeUoypu9gMNwtGW25yJHUofHZ2Y0h44V6hshnBKP4OjJt5TP+71C6w6V4sBuNaddRscaSgaN5FeDWeeN8jVWRcqKXy0H0r56pHY1HTjcBdsYwvBkOlRqwZNqmjCUCMJzmn7lIncrglVmR+akbKVpVpQkPidu/YsCl1lFQGEhjvqmUT2rbfp+cQUJ2kB/6bLd0NNXJGk/A4FeddaSOrWB3N32mahV7uvwrqlrSOaU7OpS6MkQPHoyQHf77dda4445ZMigFPpbLM1ebN6Abc9zXuDf9cr1Bgc2LKAtE7dRDaAf1IJcew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0yVfSF0b0q0PS/tEcZOXSWc3QR4Y9MTgdxlYuVOkdA=;
 b=RY1FsKYZ5sNbwhosTUmKPIPAZBiyFzLqFH8CKe3/7+jERhemgZZ6b57LYm2rEgdF6T/F71WSig4xKuTgMkPV4NrWHyOapkXlPAj9txdA5bQzBpdffS80SR0IREsTkl1j7fgFYqQnv7ibru5w4TX0v0g0KjdMexdRLGfOZYpqsBWPwZKmBsIGHl4Pgc/AjH4xR8Z5bvb1rygPXEDCp3B+q5L8Qa6B79Mgdr7tM5rYXrQeFJCvccX89GwfJH9OPECC/EgURqpLjY/Y9nwRt4YTI0po7/W19pU8G3/wULzcT3e+9XnCRU5s3TR7n0wOPOOimsI0i4dWHZ3pmktutsPoqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=huawei.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0yVfSF0b0q0PS/tEcZOXSWc3QR4Y9MTgdxlYuVOkdA=;
 b=OXzFm6tTIUcSk6VdSDiNq5Kayn5IxttlQjU2ZsgTpx4NmimzHmVu60lAMIGISyV/adWEo4y2dGqF/763KrmPF49c652568qqKRx//8VaNnxEKc1J6k4+MFCOOwwCvo99jZpKqA6pHZgJXoPo0eIKrmkBMleiL3O4dSE+cg3zl5C8noCZMRzWQ6PqqgnXt73Pg2BpxqUTOF+OmJLb/TLjixwokNJt5XIDFhwcRlX/5urNZ8APSpRvF6BC31tUDSzLfdRxq+ZOOlaMYAa5mjDF7GMhRDrY2CbqDhbf/6Z1nJ52nHGxBM9L/8T/4dxt/6RwdKXkd2K0ESDEzKDedE4Gog==
Received: from DB8P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::24)
 by DU0PR04MB9300.eurprd04.prod.outlook.com (2603:10a6:10:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 16:24:24 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::c4) by DB8P191CA0014.outlook.office365.com
 (2603:10a6:10:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 16:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 16:24:23 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (104.47.11.104) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 31 Jan 2024 16:24:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep6ZtGe0edkTmnwAeM+/b8ePQnpI9+xZ1qNRo2wYyGmXHgfl5fAsQybrQl/ixlrqx6fepOJNLIq7mVWt3l2xlXSjnvlFamH1H2anGkYIO6O7XB2jdJgYDVJsObj635w9spIodanK72ZKR4HjDeywI1VBuJcHrp6IthbG5+fJiwapDt2QI09XFOY2lOhlompHoMpqE425SiWbUT+I/l5dYmp5h0w69ZQzpbo9tvLXwBM+vGObvgdcXjzAyYdMTwFsOtcWYne313NQFIX4V+x0j4tKdf2nrlVaC1h2AqaxuWahPgyx9DljnMOrbR4M7hv2p0g7U1IKmqFRWS0oQ0rHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h9Pqx9KnoWZlClbTcJhMFy8ywInPeZphSKprXUHrgM=;
 b=dlxHl9vgef19du+x1/g4heipJAmdRZXo4EjBBSBDlWajrNjz25HFQk//4/PeFKqpg8BjDdS6Y/p/PaIbs9L9i5/+r+q7lLv0hM/ww39OZ4BZ+61T9XWY7wkL6ndzOnPXjqEOqAUG1D7U20TQFVg4q9hY5dI3WigCU4m2NBTLJNgeLKwe4yOxr8gbkjPKQ/ri8vD355zIn3tihCMaFaGLLnOdQ27QTwyZkCshUYeHrZ0GRO8DA4nb4LVT56AB9H4aH1dl5fGPQYcDLUt23tZtw/43tHp1swiIgPpzAdoah38Wfo+5mDNESQnIw260eQZyhpjrxgPNes9oTOxFOfU6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h9Pqx9KnoWZlClbTcJhMFy8ywInPeZphSKprXUHrgM=;
 b=TaKsxw1l/eyLcgOYivFDEmlJhkML0nXhPgXAG4DgB8DCn7yF1RhzASVZQ/BkoAUX8nHSrh1UH/no6sCfP6PLnBCjKd1tUiElw2NI+z3Fr9Urx3t31hYywlKIbflEJz5vepDUX4aym1vehLWEj02cQqQVnSGe2sQVvOBphIUcttQc4d61f9HYtxdSbAWJ3MTQvEOOU52t4REgilXTDWRvqwU7eZ1tbSifzp1mzj8a3OqodYbB2aJi7CBjhjo3aDXogtKzvN1qUDnibIL3g0zo5MN4W8wp0A794Y0DIs+UWhg9QS7h6OHMGkYOyqZG7JFduvwA7o8W7sxkCVoEI49zIw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB8994.eurprd04.prod.outlook.com (2603:10a6:20b:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 16:24:19 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 16:24:19 +0000
Message-ID: <48f3d8cf-3a56-481e-9eab-4fc1573cfe02@topic.nl>
Date: Wed, 31 Jan 2024 17:24:18 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
Content-Language: en-US, nl
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Lee Jones <lee@kernel.org>, =?UTF-8?Q?Leonard_G=C3=B6hrs?=
 <l.goehrs@pengutronix.de>, Liam Beguin <liambeguin@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20231213094722.31547-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.27993507-256d-4b05-88df-c8643e7f1a68@emailsignatures365.codetwo.com>
 <20231213094722.31547-2-mike.looijmans@topic.nl>
 <20231214110618.00007783@Huawei.com>
Organization: Topic
In-Reply-To: <20231214110618.00007783@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::12) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS8PR04MB8994:EE_|DU6PEPF0000A7DE:EE_|DU0PR04MB9300:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e86f57e-8fde-4e2c-dcae-08dc2279167b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 nvhllmv54Sc+yx18tMJPqcmH0WVzogfDMBeTRj7LUYbg9lF1ySvN//jDK0U7mdBxh7Z48kJUSUD0X2sC2L9mFzKBBtZvj+XHMtMKP465vE8y13nCKulqEykmPZ57MExU0MqH3CeJJpmMdxdccViT7myZb6BgylSQSc1gvxucgebNFAA81GooNJVCD8LSqjLHM8BiiD/6SYuaOxsd1UFIDK1ZZtosyQwStkAggMjxFdhRwtYhGkUnCWwO/6/soLffBrl0JiRscN4h9R8mJ71TCzExxgLaHKIqxpinTedpQPByLLrOh6jDrDlQuTKN6fHuCOr/8ZWCXOHwqW59jGMwpJbHSWJDyVDDrBOTF15jNKKkNRTOLrvlb6m+qa4fPmXahtDXeu/hHg/FmzxPmHZ3Hd/GF+JPfJvusexYi7vzT0YbsIPabpwuZEHYkv2SNWTEfC8bggrAvcx1nyKhYX7/QlF9Fzures44A0WNhLBQ2JCjRpFLFDEgqDQ/aH9xwk+uGd4nLXiDQKVhG/QWavYCbEjOGpmGSm0mjxAcxaYGIaxIwpDPcSb69DP5Q3CFbqkYd+OfSe0HcUM/1LEN/EoIz+ZfL7VWCC03+n1S9Bd3gOWXXEaeMDy8KkeVe2z/X6NGevY+0bFpSirOFtB5CwtZtfd2d52IsKngiWeYhII63OKaLn1aVFZI0Ef1KJlKzXQr078mQSa4xCCjsPCv49KWqw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39840400004)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(2616005)(26005)(66899024)(41300700001)(54906003)(6916009)(38350700005)(316002)(66556008)(83380400001)(36756003)(478600001)(6512007)(53546011)(6506007)(6486002)(52116002)(38100700002)(66476007)(36916002)(66946007)(5660300002)(44832011)(31696002)(2906002)(8936002)(30864003)(7416002)(86362001)(8676002)(4326008)(15974865002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8994
X-CodeTwo-MessageID: 0458d23b-4ab9-4140-b8e9-c21a858c432e.20240131162423@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4baf1e94-3ea3-43ae-7d23-08dc2279134c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KV2bqO3HHTcQoxzWfDjblUkbFPrNjzoCu/La0GKFwKzgvkNRuY9hfZjKgTWstlpRpW+4zFr6C3C+w5R2ZJ8GHkN8eNDvqKlPdWQT89f4D+tTcw9w/kbcj9h01oOg+Bh1km6NENGBvK34GrOSy5AEc34fk9cfEre7HxLKz1DSnDUD2n8MgMEbHkXVBnf4uhZj4ZP1NhjpV/oPtglkh+XfHtRbcK2vCHylSmUx2amPeSK272zJq7foaX1XAdV/tZ19VELSumayeu6BJ7Gg2K/Rdrz+MurKUXkHoF2lKveurRLb63RUP/vyYSwctUBFt7aR+Ubltqh+F/v5P/Pw/+tYmxBS+XPzhkODHylAOiH3AbxeBBlpcDZwMaGa4sggOFWPK0pMu7kWlDqwAIAjQ8PP/yHTnrPELu6sWOUrgsB7MfTGFvGyisJqYCdCfl6gzbM/MjQCUxkep5B/+6gwjNvlqv0P6kudoCNadwpUdRRm8cT9LousN0c9eAliZNcJn6Yvuo8bMjYMz01kBKdukOb/0EK4yjv8rzKlbebp93LZSmvLhdunY3V/olW2uW1PHt3HRe1OyxB5l+b66HMbTnWE1zOb9kMGxzymuyQBFfvQi8R1yKlA52LcyHIRDf/n1nqCODRlu0qZhyM5C8C7j9X616fkCTLtpin6JOWUrQYzBAqEnzD1Y80U9gujRItXzxt1YsCXkXHqdNgXaBeWUVpS2OcZmGPIy48NJDSZhVUBE5ZlnKOvmXxaSjXVYUwwroDZyhhrI9NPaGCgbLy6R+Y6AM4pSRcOKg+zRIzgabyns+78Ox+J4+CJ3ba8UgKGiF+O
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39840400004)(376002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(6916009)(316002)(70206006)(6486002)(54906003)(478600001)(70586007)(8936002)(53546011)(6506007)(36916002)(6512007)(8676002)(4326008)(7416002)(5660300002)(26005)(2616005)(336012)(30864003)(2906002)(83380400001)(47076005)(7596003)(7636003)(31696002)(15974865002)(86362001)(40480700001)(41300700001)(36756003)(36860700001)(31686004)(356005)(66899024)(44832011)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:24:23.9308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e86f57e-8fde-4e2c-dcae-08dc2279167b
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9300

On 14-12-2023 12:06, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 10:47:22 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>> typically used for ECG and similar measurements. Supports data
>> acquisition at configurable scale and sampling frequency.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
> Hi Mike,
>
> Various small things inline - some of which probably overlap with Andy's
> comments.


Working on it - Assume "yes to all" as my response on all suggestions,=20
except for the IRQ handling...

>
> The larger one is I don't follow why this does manual protection against
> concurrent handling of the result of an IRQ.  Much easier to just use
> an IRQ threaded handler and IRQF_ONESHOT to mask the irq entirely until
> after the initial handling is done.  If that doesn't work for some reason
> then more comments needed to explain why!

Yeah, definitely needs comments, and a bit of code too...

This chip doesn't have a buffer, but it does "latch" the sample data=20
when it receives a RDATA command (hence I use that in favor of RDATAC,=20
which does not latch and might return corrupted data).

To keep the latency as low as possible, I want to immediately start the=20
SPI transfer when the DRDY interrupt arrives. My experiments have shown=20
a big difference there, when using a ONESHOT trigger, it failed to meet=20
the deadline at even the lowest frequencies.

The next SPI transfer can start immediately after the data has been=20
copied into the intermediate buffer for IIO, the handler need not wait=20
for IIO to process the data.

When the DRDY interrupt arrives, and there's an SPI transfer still in=20
progress, it's not too late yet, the "latch" may save us still. Once the=20
SPI transfer completes and the data is in the intermediate buffer, we=20
should immediately start a new SPI transaction to latch and fetch the=20
next set. (This code is still missing in the current version)

Only when DRDY arrives a second time during an SPI transaction we missed=20
the deadline and sample data was lost.

No further comments below from me, just kept the history for reference.


> Jonathan
>
>> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
>> new file mode 100644
>> index 000000000000..54466285063f
>> --- /dev/null
>> + */
>> +#define ADS1298_SPI_BUS_SPEED_SLOW	ADS1298_CLK_RATE
>> +/* For reading and writing registers, we need a 3-byte buffer */
>> +#define ADS1298_SPI_CMD_BUFFER_SIZE	3
>> +/* Outputs status word and 8 samples of 24 bits each, plus the command =
byte */
>> +#define ADS1298_SPI_RDATA_BUFFER_SIZE	((ADS1298_MAX_CHANNELS + 1) * 3 +=
 1)
>> +
>> +struct ads1298_private {
>> +	const struct ads1298_chip_info	*chip_info;
> Looks like a tab whereas other cases are spaces.
>
>> +	struct spi_device *spi;
>> +	struct regulator *reg_avdd;
>> +	struct regulator *reg_vref;
>> +	struct clk *clk;
>> +	struct regmap *regmap;
>> +	struct completion completion;
>> +	struct iio_trigger *trig;
>> +	struct spi_transfer rdata_xfer;
>> +	struct spi_message rdata_msg;
>> +	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
>> +	bool rdata_xfer_busy;
>> +
>> +	/* Temporary storage for demuxing data after SPI transfer */
>> +	u8 bounce_buffer[ADS1298_MAX_CHANNELS * 4];
>> +
>> +	/* For synchronous SPI exchanges (read/write registers) */
>> +	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] ____cacheline_aligned;
> Not sufficient on alignment - see discussion on patch series for IIO_DMA_=
MINALIGN
> and use that instead. Boils down to there being a few systems with cachel=
ine lengths
> are different across caches (that's common) AND this value is the smalles=
t one whereas
> coherency is out past a cache with a bigger cache line length.
>
>> +
>> +	/* Buffer used for incoming SPI data */
>> +	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE] ____cacheline_aligned;
> Generally drivers don't allow DMA transfers that will trample on data in =
another
> DMA transfer - as such it's only normally necessary to force the whole se=
t of buffers
> to sit in their own cacheline.  Hence we mark only first one as needing a=
lignment.
>> +	/* Contains the RDATA command and zeroes to clock out */
>> +	u8 tx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE] ____cacheline_aligned;
>> +};
>
> ...
>
>> +static const u8 ads1298_pga_settings[] =3D { 6, 1, 2, 3, 4, 8, 12 };
>> +
>> +static int ads1298_get_scale(struct ads1298_private *priv,
>> +			     int channel, int *val, int *val2)
>> +{
>> +	int ret;
>> +	unsigned int regval;
>> +	u8 gain;
>> +
>> +	if (priv->reg_vref) {
>> +		ret =3D regulator_get_voltage(priv->reg_vref);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		*val =3D ret / 1000; /* Convert to millivolts */
>> +	} else {
>> +		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Refererence in millivolts */
>> +		*val =3D regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
>> +	}
>> +
>> +	ret =3D regmap_read(priv->regmap, ADS1298_REG_CHnSET(channel), &regval=
);
>> +	if (ret)
>> +		return ret;
>> +
>> +	gain =3D ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
>> +	*val /=3D gain; /* Full scale is VREF / gain */
>> +
>> +	*val2 =3D 23; /* Signed 24-bit, max amplitude is 2^23 */
>> +
>> +	return IIO_VAL_FRACTIONAL_LOG2;
>> +}
>> +
>> +
> Trivial: Single blank line only.
>
>> +static int ads1298_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		/* When busy, just peek in the buffer */
>> +		if (!iio_buffer_enabled(indio_dev)) {
> Races - you need to claim direct mode to prevent that.
>
>> +			ret =3D ads1298_read_one(priv, chan->scan_index);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +		*val =3D sign_extend32(get_unaligned_be24(
>> +					priv->rx_buffer + chan->address), 23);
>> +		ret =3D IIO_VAL_INT;
>> +		break;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		ret =3D ads1298_get_scale(priv, chan->channel, val, val2);
>> +		break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		ret =3D ads1298_get_samp_freq(priv, val);
>> +		break;
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG1, val);
>> +		if (!ret) {
>> +			ret =3D IIO_VAL_INT;
>> +			*val =3D (16 << (*val & ADS1298_MASK_CONFIG1_DR));
>> +		}
> Takes a line or 2 more but better to keep consistent style on error handl=
ing
> 		if (ret)
> 			return ret;
> 		*val =3D 16 << (*val & ADS1298_MASK_CONFIG1_DR); /* Note fewer () */
> 		return IIO_VAL_INT;
>
>
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
> Always return early if there is nothing to do.  Makes review easier as no
> need to sanity check what happens for each path if it's already returned.
>
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int ads1298_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan, int val,
>> +			     int val2, long mask)
>> +{
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		ret =3D ads1298_set_samp_freq(priv, val);
> return ads1298_set_samp_freq()
>
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
> return -EINVAL;
>
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
> ..
>> +static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int r=
eg,
>> +			      unsigned int writeval, unsigned int *readval)
>> +{
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +
>> +	if (!readval)
>> +		return regmap_write(priv->regmap, reg, writeval);
>> +
>> +	return regmap_read(priv->regmap, reg, readval);
>> +}
>> +
>> +static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
>> +				    const unsigned long *scan_mask)
>> +{
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +	int i;
>> +
>> +	/* Power down channels that aren't in use */
>> +	for (i =3D 0; i < ADS1298_MAX_CHANNELS; i++) {
>> +		regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
> Always check regmap accesses.  There's a horrible bus under this ;)
>
>> +				   ADS1298_MASK_CH_PD,
>> +				   test_bit(i, scan_mask) ?
>> +							0 : ADS1298_MASK_CH_PD);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_info ads1298_info =3D {
>> +	.read_raw =3D &ads1298_read_raw,
>> +	.write_raw =3D &ads1298_write_raw,
>> +	.update_scan_mode =3D &ads1298_update_scan_mode,
>> +	.debugfs_reg_access =3D &ads1298_reg_access,
>> +};
>> +
>> +static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
>> +{
>> +	unsigned long flags;
>> +
>> +	/* Notify we're no longer waiting for the SPI transfer to complete */
>> +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
>> +	priv->rdata_xfer_busy =3D false;
>> +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
>> +}
>> +
>> +static void ads1298_rdata_complete(void *context)
>> +{
>> +	struct iio_dev *indio_dev =3D context;
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +	int scan_index;
>> +	u8 *bounce =3D priv->bounce_buffer;
>> +
>> +	if (!iio_buffer_enabled(indio_dev)) {
> This can race I think with a transition into buffered mode.
> You should be able to use iio_device_claim_direct_mode
> here().  That will fail if you are in buffered mode but if it succeeds
> it will hold us in non buffered mode until it is released.
>  =20
>> +		/* Happens when running in single transfer mode */
>> +		ads1298_rdata_unmark_busy(priv);
>> +		complete(&priv->completion);
>> +		return;
>> +	}
>> +
>> +	/* Demux the channel data into our bounce buffer */
>> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
>> +			 indio_dev->masklength) {
>> +		const struct iio_chan_spec *scan_chan =3D
>> +					&indio_dev->channels[scan_index];
>> +		const u8 *data =3D priv->rx_buffer + scan_chan->address;
>> +
>> +		/* Transfer 24-bit value into 32-bit array */
>> +		memcpy(bounce + 1, data, 3);
>> +		bounce +=3D 4;
>> +	}
>> +
>> +	/* rx_buffer can be overwritten from this point on */
>> +	ads1298_rdata_unmark_busy(priv);
>> +
>> +	iio_push_to_buffers(indio_dev, priv->bounce_buffer);
>> +}
>> +
>> +static irqreturn_t ads1298_interrupt(int irq, void *dev_id)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_id;
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +	unsigned long flags;
>> +	bool wasbusy;
>> +
>> +	/* Prevent that we submit a message that was still in progress */
>> +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
>> +	wasbusy =3D priv->rdata_xfer_busy;
>> +	priv->rdata_xfer_busy =3D true;
>> +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
>> +
>> +	if (!wasbusy)
>> +		spi_async(priv->spi, &priv->rdata_msg);
>> +
>> +	return IRQ_HANDLED;
> Can you not use the IRQF_ONESHOT and an IRQ thread to deal with what
> you are using wasbusy for here?  I'm not keen on a reply saying we've
> handled the interrupt when we really haven't finished with it.
>
> This looks like a classic data ready trigger as well. Why handle
> it without the trigger infrastructure?
>
>> +};
>
>
>> +
>> +static const struct iio_buffer_setup_ops ads1298_setup_ops =3D {
>> +	.postenable =3D &ads1298_buffer_postenable,
>> +	.predisable =3D &ads1298_buffer_predisable,
>> +};
> ...
>
>
>> +static int ads1298_init(struct ads1298_private *priv)
>> +{
>> +	struct device *dev =3D &priv->spi->dev;
>> +	int ret;
>> +	unsigned int val;
>> +
>> +	/* Device initializes into RDATAC mode, which we don't want. */
>> +	ret =3D ads1298_write_cmd(priv, ADS1298_CMD_SDATAC);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D regmap_read(priv->regmap, ADS1298_REG_ID, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if ((val & 0x18) =3D=3D 0x10) {
> FIELD_GET() and appropriate mask defines.
>
>> +		dev_info(dev, "Found %s, %d channels\n",
>> +			 ads1298_family_name(val),
>> +			 4 + 2 * (val & 0x07));
>> +	} else {
>> +		dev_err(dev, "Unknown ID: 0x%x\n", val);
> In order to support fall back DT compatibles etc, we generally only
> print a message on a missmatched ID.  It might be for a new fully
> compatible device with a DT binding deliberately specifying that
> the older device is fine for matching against.
> This is something we are slowly fixing up in older drives after
> some long discussions with the DT maintainers a few years back.
>
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Enable internal test signal, double amplitude, double frequency */
>> +	regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
>> +		ADS1298_MASK_CONFIG2_RESERVED |
>> +		ADS1298_MASK_CONFIG2_INT_TEST |
>> +		ADS1298_MASK_CONFIG2_TEST_AMP |
>> +		ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
>> +
> Always check return values unless you expect them to fail (in which case =
document
> that).
>
>> +	val =3D ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
>> +	if (!priv->reg_vref) {
>> +		/* Enable internal reference */
>> +		val |=3D ADS1298_MASK_CONFIG3_PWR_REFBUF;
> #FIELD_PREP() and masks preferred for consistency with multi bit fields.
>
>> +		/* Use 4V VREF when power supply is at least 4.4V */
>> +		if (regulator_get_voltage(priv->reg_avdd) >=3D 4400000)
>> +			val |=3D ADS1298_MASK_CONFIG3_VREF_4V;
>> +	}
>> +	regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
>> +
>> +	for (val =3D 0; val < ADS1298_MAX_CHANNELS; val++) {
>> +		/* Set mux to analog input, PGA =3D 6x */
> Use appropriate mask defines and FIELD_PREP() so that 0x00 doesn't
> need a comment here as the define makes it clear what is going on.
>
>> +		regmap_write(priv->regmap, ADS1298_REG_CHnSET(val), 0x00);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ads1298_probe(struct spi_device *spi)
>> +{
>> +	struct ads1298_private *priv;
>> +	struct iio_dev *indio_dev;
>> +	struct device *dev =3D &spi->dev;
>> +	struct gpio_desc *reset_gpio;
>> +	int ret;
>> +
>> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
>> +	if (indio_dev =3D=3D NULL)
>> +		return -ENOMEM;
>> +
>> +	priv =3D iio_priv(indio_dev);
>> +
>> +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(reset_gpio))
>> +		return dev_err_probe(dev, ret, "Cannot get reset GPIO\n");
>> +
>> +	priv->reg_avdd =3D devm_regulator_get(dev, "avdd");
>> +	if (IS_ERR(priv->reg_avdd))
>> +		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
>> +				     "Failed to get avdd regulator\n");
>> +
>> +	/* VREF can be supplied externally. Otherwise use internal reference *=
/
>> +	priv->reg_vref =3D devm_regulator_get_optional(dev, "vref");
>> +	if (IS_ERR(priv->reg_vref)) {
>> +		if (PTR_ERR(priv->reg_vref) =3D=3D -ENODEV)
>> +			priv->reg_vref =3D NULL;
>> +		else
>> +			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
>> +					     "Failed to get vref regulator\n");
>> +	} else {
>> +		ret =3D regulator_enable(priv->reg_vref);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
>> +					       priv->reg_vref);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	priv->clk =3D devm_clk_get_enabled(dev, "clk");
>> +	if (IS_ERR(priv->clk))
>> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
>> +				     "Failed to get clk\n");
>> +
>> +	ret =3D regulator_enable(priv->reg_avdd);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to enable avdd regulator\n");
>> +
>> +	ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
>> +				       priv->reg_avdd);
>> +	if (ret)
>> +		return ret;
> I'd group the getting of this regulator with it's enabling.  That will br=
ing it
> inline with how you handle vref.
>
>
>> +
>> +	priv->spi =3D spi;
>> +	init_completion(&priv->completion);
>> +	spin_lock_init(&priv->irq_busy_lock);
>> +	priv->regmap =3D devm_regmap_init(dev, NULL, priv,
>> +					&ads1298_regmap_config);
>> +	if (IS_ERR(priv->regmap))
>> +		return PTR_ERR(priv->regmap);
>> +
>> +	priv->tx_buffer[0] =3D ADS1298_CMD_RDATA;
>> +	priv->rdata_xfer.tx_buf =3D priv->tx_buffer;
>> +	priv->rdata_xfer.rx_buf =3D priv->rx_buffer;
>> +	priv->rdata_xfer.len =3D ADS1298_SPI_RDATA_BUFFER_SIZE;
>> +	/* Must keep CS low for 4 clocks */
>> +	priv->rdata_xfer.delay.value =3D 2;
>> +	priv->rdata_xfer.delay.unit =3D SPI_DELAY_UNIT_USECS;
>> +	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1=
);
>> +	priv->rdata_msg.complete =3D &ads1298_rdata_complete;
>> +	priv->rdata_msg.context =3D indio_dev;
>> +
>> +	/* Avoid giving all the same name, iio scope doesn't handle that well =
*/
> That's intentional - name is the type of chip, not a unique name.
> If you need a way to identify the device then use the path of the parent
> which will associate this with the underlying bus device and hence provid=
e
> a stable reference.  We deliberately don't attempt to provide a different=
 way
> to identify the device. readlink is your friend in userspace.
> Some drivers got through review with naming coming from elsewhere but thi=
s
> is the part number of the device.  With hindsight the ABI should have ref=
lected
> that to avoid confusion but we are stuck with 'name'.
>
>> +	indio_dev->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s@%s",
>> +					 spi_get_device_id(spi)->name,
>> +					 dev_name(dev));
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>> +	indio_dev->channels =3D ads1298_channels;
>> +	indio_dev->num_channels =3D ADS1298_MAX_CHANNELS;
>> +	indio_dev->info =3D &ads1298_info;
>> +
>> +	if (reset_gpio) {
>> +		udelay(1); /* Minimum pulse width is 2 clocks at 2MHz */
>> +		gpiod_set_value(reset_gpio, 0);
>> +	} else {
>> +		ret =3D ads1298_write_cmd(priv, ADS1298_CMD_RESET);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "RESET failed\n");
>> +	}
>> +	/* Wait 18 clock cycles for reset command to complete */
>> +	udelay(9);
>> +
>> +	ret =3D ads1298_init(priv);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Init failed\n");
>> +
>> +	ret =3D devm_request_irq(&spi->dev, spi->irq, &ads1298_interrupt,
>> +			       IRQF_TRIGGER_FALLING, indio_dev->name,
>> +			       indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
>> +					  &ads1298_setup_ops);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static const struct spi_device_id ads1298_id[] =3D {
>> +	{ "ads1298",  },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(spi, ads1298_id);
>> +
>> +static const struct of_device_id ads1298_of_table[] =3D {
>> +	{ .compatible =3D "ti,ads1298" },
>> +	{ },
> No point in the trailing comma.
>> +};
>> +MODULE_DEVICE_TABLE(of, ads1298_of_table);
> Thanks,
>
> Jonathan
>
>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




