Return-Path: <linux-kernel+bounces-55107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0D384B7D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27523B2A14A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8613249C;
	Tue,  6 Feb 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="EmwmCcu+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="oVdjHuq/"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2116.outbound.protection.outlook.com [40.107.22.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37D130E5E;
	Tue,  6 Feb 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229546; cv=fail; b=cPF8h/gshyPLalpJqA3s+FmzDbqsSn55qV2sKKe5HxQegm6V4Sp6rtw08K/ApVVR/daipIuwthGuwIDsfO1TkKBFoCy0bQ7/P1TPS+cuOd67RXA14cyjgusfOv8KzTmna+m/RVh1bdwvJ8dT9s9jE1BhVzckDy1BnsO+n/ArxGU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229546; c=relaxed/simple;
	bh=YWT2m47/3R+jRaXixZjW3XVcPM4Nlp7iHoNKoKV7r5A=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btI8WSgkWDCdYJ2SymRQIGMWYNQT16UuOz+Dpz+3mpqeq1X6k2cBoJg8ck+wLdB61MSg5Vr1TQrN601RAJOmE4OIxl3+Fe85MctowaXqBjh7hes/6ehpEdSagg30NPNsNXW/jrZtCDlrU6Lb6Qb8Vzm0R1rhbYoBkHNuODcLNek=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=EmwmCcu+; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=oVdjHuq/ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=aB4Vtv5TTntwVEI3U6XpQ6Wh1IKiM2/vak28Hh1NNdevZZq2QXx68lmxQqrjluf/vYZ2nkvnU4ve6o9ruQkz4v8Pg2rkKeUsUN6v2S/8SmQhVPlX7RS+YeWnDMIkgY4c9bwSnjahUAVFwhjzRgAzlGQGAYHoj6dVuHaa7dP70/HBYy0lmUUQLn6cRzd3GLzqYJnTtwj5QHmYemnTA6D4aim348x5L48ri1+PZttRn3GaUsc3nMFMeT5k3dZcTtUMSwSzjtDymLNfdIAFs7B4ZZ0VHZ/5hx33HAbNudvogaAuYQA4Rpa/Qhp8Mmg7LXOpVd1KlP4qjMSgiBKh/llT/g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV1Hpgdjpvf/jH3oLCOmmjimjZdddGDZ2t2oVq9sCH8=;
 b=Pz0PdEPZk4rOAS7XIkQLtQdcqLQ/TPlMLMJDBCw5RPNB8K+rtjvlDQ61ExDh213XAYcv3rxH6AZgXXIr2AJItBBgDCn9M5qTH3l3+nGmdjnhbihuQ2fe5AKi8p84Nif2AXwEAGUZb/RzZINq0ecdWEuXl1N0cjmS2RMMdcIYh41fsde70BdkFa4eQtnGBFeOVf/g4Z/zzGTAz3nUivkKB5cxdjQ07akBm7bP69aGR/a5+xf7n18oqKxhMQwCNV6iDciKjFP6A1dLwmsbLmZteCVniXQSWeUtHW5HViaI08HcjI9YL/LUsobUheXxf/PB8RiSjTEXms5PARFy/Rp4VA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV1Hpgdjpvf/jH3oLCOmmjimjZdddGDZ2t2oVq9sCH8=;
 b=EmwmCcu+uzvIRiAUws8GgcP5n0Sh/CQKHLxwd1VVdZ5P5Bma5lt00ZTFkfiQvaTzJ7aknFx5soBjm9kLj4aNIRA1sypjVPAII67OJw3+psRFzG+ksi90wfae4Rvh/iZ5633gqyCnBXdPtKden5jMlc91r/g0YivU/79cWdGUIurfdTsNRT/XgBN2lUtP83DIMByz7Ko25fZTsF3HiP33zXd9EfF6HoI92clCgCZlO/FOY+opdAu5XIuOa4AHSGgnN9cAGGSgKAXjy2u148xRmb/wD5y5BA6c75cs9nB6WmDpAfz4FcMAli6/1KImWM8b7lY3dxj/PwXP+RCzOSxZJQ==
Received: from DB7PR05CA0047.eurprd05.prod.outlook.com (2603:10a6:10:2e::24)
 by DB8PR04MB6780.eurprd04.prod.outlook.com (2603:10a6:10:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 14:25:38 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::8a) by DB7PR05CA0047.outlook.office365.com
 (2603:10a6:10:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 14:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 14:25:37 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.105) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 06 Feb 2024 14:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LW9xhEKf5ppAHCQYsgcT1QbQl1U2H8RPDzxQHPYN8acXfYyD0b2WdQKMfcLK+RBy9v0f3Snifl/d9kncUR/RDBwmAEVxE3soW9+826UnO2TYXmxbmPsWIf/D/LunRsxezbyFAfGMAYhOrgsR3wudNGJbYA9IhtC+v4Jxs5kdOjC5Fyxn5IN10XnE8vNXn6PW4+3KAKcwd1YHaJihsSmOLZ9QFU47wnAZdgZrpb7WcufKMFAwCOdlIBBpFJIabTP+o/vHG3VmEIyI4SKObmWG6xzsUU0JLjOIMNoTWIZ8I6390X80oA/cunyQG+V7QNShIxJzSwjYY678iHiTy4uSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99ZrQLxwYu5D1tNMbU85JHYkWBn0PzEf1yHLKLaBh2g=;
 b=W++epNrC699Ma4TjyIjcHaS4Y25ZjmYl0fY9BawppGLBiuLrMz+IR03PZfCGTNmVNrHZiVhVHqFxo8tNkp7We0SNBsi1xhBDr3fTSG1oPqXPRQjEqlpEWC3Yt4O3tpFNPmcEd5sOHqdhpJUlyXXP0c1aUWCULdBSUKNeT4TjNjxB48Dqu4gbV2+4sDH8gHUj87paSHi4Lm1myiI4UKUi2yjMZEqDZlEyUjuVixqsqKzaQnjW2z9DaF3S+qQ2CpOIZiwbTzLvlzTqPsd6aE97HHrbKQgYyIPhCJU0lySqV+ewCIkRLbpvGlyHucM0SoDrg9kJD/20KVgum171csGNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99ZrQLxwYu5D1tNMbU85JHYkWBn0PzEf1yHLKLaBh2g=;
 b=oVdjHuq/RKpRw8NwEJAPFkKbJtP3uq1jFatssgemOtFOgCCr08lBxMsjKBpDypaXkzARhO5XIg7UO//LMHQN2NKCKnf9+6ud0VT0mH9hfYkDGuA4/8+Y9OvqR8PzxQdUjLdH9lm2gqWPrUZCimdNyx2vRhB56eOtRO+aB0A6Y5uj7xqV+0mhiJ2g03BT661wNvF+M7MXAlaNXBmJtDgqW008i8SuJsycoE4n3ADWoBncwjAAev0gQKG2EUOyfE/d0bDBSSDg3SCsMxkrsLz3xMVnW/V3uPlDxIIku1zBILRQSXYmz/DHfsDJOgGPh8NhWzrRhXh19JLFL9mf6WHdHg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 14:25:31 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 14:25:31 +0000
Message-ID: <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
Date: Tue, 6 Feb 2024 15:25:30 +0100
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
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
Organization: Topic
In-Reply-To: <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VE1PR04MB7213:EE_|DB1PEPF0003922E:EE_|DB8PR04MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f64125-ac2d-4087-2355-08dc271f7d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 xrCUI7Jgjs23o8Ej7u312I6zGaCUe7fqBZPiAvIzdTjuRmpTwsT2C0PwF0A5gXMB/OcTxmJFNtx8eBSWrm8zNrE1GOkr3xu7xDBl/eLRqX8GATso5Sf5JsHhAvIZ5VXjrljXxK5koEOkhLMJ1BfI/olc9R2BhZ1b1P5xuZz1JKHBimmCQKDoF4NzLTkIbSeCKlk/b91rG9835o6TSfT/zdSeI/SUDF28HqYcexgHKD5VVrwybacdtBi/WxZfwgNwqe9l3jmpwSJM4XYcv3WYgVDQ20hAGnhjuR+H++RPiby5qOMmBUHu4HRdpdEQaRBkKYjK4czUX06gJmYBxJKFAq6ZXY6YDvwRq8PuvDbu3pc3W7d1xinQbyKidEzkdswvi0vpMpxJBV+usoTtBhEwytab97ElwA0UGxQMAWXpkSvEyCLNYsIcg4ykktdZre9U2VERjEOlgNly+cqhaJpviP5v6Di6ObmNedd5U6uUuYBkohUJ/Bf2vSvrHyZ05gKaWkj4k4J4OH5Nj+GKk7zqwm8wvPQ6/QfAwG/uf5QLghOQwaHRlYqOvwQ3Uvv1Xep+hRUpGP1nFCxyFOdTR9XFxfvMfpm2bZfDKQtOkBLPiH8UmxqfXjSfggSkdj50ubrygIAoNdgLyF83DThB58W6QsxKkVKklMWZW0SUh57XVh0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(346002)(136003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2906002)(83380400001)(38100700002)(41300700001)(26005)(38350700005)(66556008)(6916009)(54906003)(66476007)(66946007)(316002)(31696002)(7416002)(86362001)(4326008)(8676002)(8936002)(44832011)(53546011)(52116002)(36916002)(2616005)(6506007)(6512007)(5660300002)(36756003)(15974865002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213
X-CodeTwo-MessageID: 2d35f37d-0f97-4b54-bfad-0a1c71c834aa.20240206142536@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	983a7879-5b8f-4fe7-67bc-08dc271f7914
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OuUNnY0BKjDsg4pdx6PnNix6uiBm4dW6WSkJrBpugScjIe/19T3gVIDfapMenTWflneRtXt38i//nPkxvyUfVM59b2ThaA0vqeMPsxSgRcUPPYqk5n/1/B9mrHh7zlr+6OiZUnzD63yVp+eB1XQx5KxA592GoUdSQs+mpBFGD2TRlyWjnHlkGiD95pCW+HaRSg4TWsG+CqTQyiTHAkM9aKfGRRNn2oBx1TOZhgHlUTF4HsPJOOD0QdXuwsvDxXZ3mA8yImdoEa1YBtbVZu890HHVVGqTMHRvKs/aa7b8hlQJur44JmB1r9UH8x/fKXCxr94iSsR4RPbenQMpe+Wsd6NQhwtuWXOB6tXDBdslp0GxNoGqC2EaUBupghhOHx674zUGqX3+5hdFHGvbVe2djNYonKEHPXgCRgS9m+W4zvn7PgpvVP1/SZNhEGsg/78qIKPuUY3JMctgWB205sxBaNepDPQX1xoaZ4vjB5mHsa+BYo194otVChBRVZFziVLb8Eopo4uErxZL2XprD1+cqbJwxxMxGFMj1hmd9D8rgcnUkFgEC0eKfowA+zKgRJYDEZlvSDXdBIDcxU8/ivOBs/564ZGGVi0ot1zrub32KJ2N7a1SOeVs5asVGk1YwCP18AZGN82NPNCHixdLSDbZdN3qFGjiWyB0u8hsCwH8KbwClns5DTZIVF66kIjg8+4PDZT58gK/xO6Em+OU4CVljmFLEMBY1us42Tx/H/okKQgiNkmHxP9QZMUG42oZJEoEH54wXTR2GUxqbR3sc1fXYg==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39830400003)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(36840700001)(7636003)(356005)(7596003)(31686004)(47076005)(40480700001)(36916002)(53546011)(36860700001)(6506007)(83380400001)(26005)(31696002)(86362001)(6512007)(41300700001)(15974865002)(2616005)(7416002)(8676002)(8936002)(36756003)(4326008)(336012)(2906002)(478600001)(6486002)(5660300002)(316002)(70586007)(54906003)(44832011)(70206006)(6916009)(43740500002)(18886075002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 14:25:37.5129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f64125-ac2d-4087-2355-08dc271f7d42
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6780

On 06-02-2024 14:50, Andy Shevchenko wrote:
> On Tue, Feb 06, 2024 at 02:33:47PM +0100, Mike Looijmans wrote:
>> On 06-02-2024 13:57, Andy Shevchenko wrote:
>>> On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:
> ...
>
>>>> +	factor =3D (rate >> ADS1298_SHIFT_DR_HR) / val;
>>>> +	if (factor >=3D 128)
>>> I just realized that this comparison is probably better in a form
>>>
>>> 	if (factor >=3D ADS1298_MASK_CONFIG1_HR)
>>>
>>> as it points out why this is a special case in comparison to 'if (facto=
r)'
>>> below. What do you think?
>> The "HR" bit sets the device to high-res mode (which apparently doubles =
the
>> internal sample rate).
>>
>> But "128" could be written as "1 << ADS1298_SHIFT_DR_LP" which is the ma=
x
>> oversampling factor.
> Use BIT(..._DR_LP) and we are done here.

Ok.


> ...
>
>>>> +	wasbusy =3D --priv->rdata_xfer_busy;
>>> Why preincrement? How would it be different from postincrement?
>> Maybe better write this as:
>>
>> --priv->rdata_xfer_busy;
>>
>> wasbusy =3D priv->rdata_xfer_busy;
>>
>> I want the value after decrementing it.
> Yes, looks more obvious.

Having done that, and looking at it again, it's better to just eliminate=20
the local "wasbusy" altogether. More concise.


>
>>>> +	if (wasbusy) {
>>> To me more robust code would look like
>>>
>>> 	if (wasbusy < 1)
>>> 		return;
>>> 	...
>>> 	if (wasbusy > 1)
>>> 		...
>> wasbusy could have been unsigned.
>>
>> This code will only ever execute with rdata_xfer_busy > 0 (or the SPI dr=
iver
>> called our completion callback without us calling spi_async first)
> You never know what may go wrong in the future :-) That said, I prefer ro=
bust
> code against non-robust.

Maybe: BUG_ON(!priv->rdata_xfer_busy)

Adds more code, dunno what weighs heavier... Haven't seen other drivers=20
do this though.

I made rdata_xfer_busy unsigned as it should have been.


> ...
>
>>>> +	wasbusy =3D priv->rdata_xfer_busy++;
>>> So, it starts from negative?
>>>
>>>> +	/* When no SPI transfer in transit, start one now */
>>>> +	if (!wasbusy)
>>> To be compatible with above perhaps
>>>
>>> 	if (wasbusy < 1)
>>>
>>> also makes it more robust (all negative numbers will be considered the =
same.
>>>
>>>> +		spi_async(priv->spi, &priv->rdata_msg);
>> The "rdata_xfer_busy" starts at 0.
>>
>> Increments when a DRDY occurs.
>>
>> Decrements when SPI completion is reported.
>>
>> So the meaning of "rdata_xfer_busy" is:
>>
>> 0 =3D Waiting for DRDY interrupt
>>
>> 1 =3D SPI transfer in progress
>>
>> 2 =3D DRDY occured during SPI transfer, should start another on completi=
on
>>
>>> 2 =3D Multiple DRDY during SPI transfer, overflow, we lost=C2=A0rdata_x=
fer_busy -
>> 2 samples
>
> Maybe another good comment is needed here as well?

I thought I had it covered with the comments... I'll add more.


>
> ...
>
>>>> +	dev_dbg(dev, "Found %s, %u channels\n", ads1298_family_name(val),
>>>> +		(unsigned int)(4 + 2 * (val & ADS1298_MASK_ID_CHANNELS)));
>>> Castings in printf() is a big red flag usually (it's rarely we need the=
m).
>>> Why is it here?
>> Compiler complains that the expression is "unsigned long". Probably beca=
use
>>   of ADS1298_MASK_ID_CHANNELS being so.
> So, use the unsigned long specifier and drop casting.
>
> ...
>
>>>> +	if (reset_gpio) {
>>>> +		/* Minimum reset pulsewidth is 2 clock cycles */
>>>> +		udelay(ADS1298_CLOCKS_TO_USECS(2));
>>>> +		gpiod_set_value(reset_gpio, 0);
>>> I would rewrite it as
>>>
>>> 		/* Minimum reset pulsewidth is 2 clock cycles */
>>> 		gpiod_set_value(reset_gpio, 1);
>>> 		udelay(ADS1298_CLOCKS_TO_USECS(2));
>>> 		gpiod_set_value(reset_gpio, 0);
>>>
>>> to be sure we have a reset done correctly, and the comment will make mo=
re
>>> sense.
>> If used, the reset must be asserted *before* the voltages and clocks are
>> activated. This would obfuscate that, and add a redundant call to set_va=
lue.
> Then perhaps you want reset framework to be used instead?
>
> Dunno, but this comment seems confusing in a way that you somewhere asser=
ted it
> and it's not obvious where and here is the delay out of a blue. Perhaps y=
ou may
> extend the comment?

Could use devm_reset_control_get_optional_shared() I guess, but that=20
would change devicetree bindings as well...

And it wouldn't change the order, as it'd still be asserted at the start=20
of probe()


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




