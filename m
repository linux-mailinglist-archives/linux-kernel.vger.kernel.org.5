Return-Path: <linux-kernel+bounces-46761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F118443CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28645B28C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5012A166;
	Wed, 31 Jan 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="LDe8KLox";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="r9PYnMK8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C212A146;
	Wed, 31 Jan 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717428; cv=fail; b=iKj7tXw3oGtueAeS6VRXpiW3GVgp84VSTWokTh+86ClrGZkr6+H40lY6de1zu/y25Xb814gbu8lP52ZSTz77ChRHtlT9ut/+si954/pd0IDPrnw+iXMhbKzL0942i3ldvfUDgRrkU48UGpFF3pOm4fX0/9R51AJugJLqU4PTcWY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717428; c=relaxed/simple;
	bh=hV002eaK20w/QJTvW5h1PybOX0lyMDPyMSvgQyzznZQ=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOcg2ZJ2OjAOryXD8Lv1YxmgAnge7fCaT7petjZHUdKWyQKTp+f1RiqIpRWJ9h/40ADoLFTYgCbsYuKt9eYv4UWBJhOqqVhOdpvYP1DjqJJEnjnUADORyDIxWLe5KWQIgZ5z5ppXpgeIgKI6yiwNotQW1GzJom2LDVYuYVHGepU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=LDe8KLox; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=r9PYnMK8 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=cVHRMxUbVFchABBCccuqkSkvc7oUW4Zw1pgVIt/M3fao1EFeo9lHAijrrQPC284rwI76H8QHZPihieojDytrGtG/8P4WrUbycDJTCqan1gsX9/mbGDl8fvHWY1f1UJxYrkmfaMmKhB0f1kJCcU2TW9+EmBhPZ/70VF3jUjc0LyDl6CRKV9J3hG98+JlYtkFQ/n6GDiNlrah5zPkeRIRAolWVIfuZFx0Z1X1MinGJFtPBlm6WcQJVYL0ZZ9iOHAqcGtvVoUat4eh87nQVDcbMB8QLeC8plnLKDqr0NWgWOjzfmpwPyhXDarbypmivsmHHBhecN0ud9Ct5ZGG6uaFsPw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO6bOE8hNuUbOJ6vl7KxCLHGWS4keveP6JfuH3b/WYM=;
 b=SNdOekehmoOg74djVtXW4pCwfvLmjyQQpuYgkwShiU4+VQR3gq8GGtfMQrIE6NHxz9eIlRDj4pphNJbIJ+nyNkvMW3KNnlSXjEFcbYX7bASyLsKb2aqkUfE2Y4wNk2S2Uq/s/aqJvIdQ0LfdqypIALMd494MLpjG1D0gY8/Mkv0FQ/bjtMe4qWrEl1GYzDJQlKHAOBw1WEtfdBKa56A1ZUXX/zKTedEhA2pnZgO1A+tWKqTeJPXwzUo484rzz5xWgR78Dc8OXjQmDcIXv08xwmOloVYOQMU0tDnyX0ON21JxAeOVKlNfrDh59Jkwr+Ek8OZdo2/ymdKccmuPlpXY8A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO6bOE8hNuUbOJ6vl7KxCLHGWS4keveP6JfuH3b/WYM=;
 b=LDe8KLox6cQUAJR30AZzeNYpm2r4drC8XpLc1a2TnYwqotdcPsXadqcwYXQA6M/pItWhENqwmXB0C9skFSwIWe6bpUZbkFkhdSK6kWgnqv+VwIYDGTIfAyv5qCk0xvwe71hC0L1MuyXzEeG5gl3RTBlb75Da39p1xEr3iHRhxlUSScGT+KmH3oFdLaQJiOY7PkvH8gajcs01fDMDFVV/bMPpNHGXjnCdek2HRISBjy/xBpDTr/TkcJLp4vaNbtnJrDVpPDtsoEe/QbV3kp9hDQv0mAijMeLme4EAmjHWgFegx0p2tAXvKMchcRPytdLdGKnq89dI3efdNlZa5b+IEA==
Received: from AS9PR06CA0481.eurprd06.prod.outlook.com (2603:10a6:20b:49b::6)
 by PAXPR04MB9666.eurprd04.prod.outlook.com (2603:10a6:102:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 16:10:20 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:20b:49b:cafe::55) by AS9PR06CA0481.outlook.office365.com
 (2603:10a6:20b:49b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 16:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 16:10:19 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.169) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 31 Jan 2024 16:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrI7Ydiz2GcwZekYYKEqzv6ItIe+0cczxMC8/xerHhF3Pdv0LJApxhLsUAm+a+hrX4ZexWvKBPAZ62zcdm6g/ws8OsTBCdJSVWbC6u6gtPpjW++QkU8B+/QqKw0fSusot52XIT5+KHLWw2yDh0nv+HiMqsqtH0t9YF+tzi7EkK5LnYsZ2TRIPpeBVT43KCfeVJ/XsNXHQHaazwhdWF9rq7QBU6AtnNvwqji1JvUJgKwwKJ5zZCsC7OCbfYlLHZKALKuNJryUJyBEMk0mTxRCjTT+Nxh9+RgOEePgJosIKKkhdSBxpMmOPU8nVIqa61hJlq1PiMIHFFFKFWSS0+a36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RIAwu/XNrzvfDTjy5w6BMZeWlwtSKP7GGEIFsEGWFA=;
 b=TasscpGlXMURPqlBkjzemUN1V4V6GkU3VISN1wsjpnNsmhUZY8Lac+Pl8EiGHvDjc0EJ3Ul4BQZn0NXhxkBM21KF/PawvY16z5jIuXrcUi2L5GFyV6vEbDwi45Pga4AZife3kbWoYMAmN355X982I8jrmqZ8O/y26z8MSTGSaT6mg56BkKte7kQYTXfOAwLy+0spv0HAVba58aGuliQ7WAJiK0/0GUKvZKVCtb59FjemHW/RImeZRhdz6zSk01MuCfhxlNgRMI8IWV9LV/xZ+biHJ0QaMui4Go2lvqRMUijTmKHZuGheXySjL5EpLhd8/mxXkRQVr4YRU/eGaq6pKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RIAwu/XNrzvfDTjy5w6BMZeWlwtSKP7GGEIFsEGWFA=;
 b=r9PYnMK87EmmpAlljWe2mwsFV7dbYqUrlqHE77AeOESqHNoh6PA6Rq4v3dW5aGxArBKklfd0WKgGUJwtuMbquAx+NXKZRyZYHH2nuE4zWCT3S7SgVyeixy5e4/hGw9TS5HSxeiKv0RQfcO+Z3BsOWU/NPVZzkd4gUeZSTWOxCZsta+zzYVoYMTFdkeQNJtvxe3nmgCysYshX33jnYvcWVtDm6EorQzU4jzgXtFWtdGZeZ5+/71QhfiuIip5m0HaD/0WdnyG3ij5F2GUecUDB6U/QoRn8xyqCucbr/U8Bnyd5m3JckPusUDu0GQv1aNkmqbUMvm5qeWnZFtGZNOu4xA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 16:10:09 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 16:10:09 +0000
Message-ID: <406d445a-3ce3-4253-8966-de2dac6f7c23@topic.nl>
Date: Wed, 31 Jan 2024 17:10:08 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
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
 <ZXnF72wJCAeYWA8X@smile.fi.intel.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <ZXnF72wJCAeYWA8X@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PA4PR04MB9461:EE_|AMS0EPF000001A0:EE_|PAXPR04MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0ecd58-9ffe-442e-e816-08dc22771f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 sjllLHO5ein/2+pBUwB9BmFE/fvVqxOpTchPJnh9yqC8b/GUFo0qNxGtNutJivZyfpZhJY4R2pBl7r2U9dyuVeAFL98KXylYrkF9A9Qzzht2h53swqv4XHPSlEzBgdfzi7VqOsk7KIHQ3bKAJ9ho3HqTKtkgti5hjXEsHpaPNRR9GKKdX16DSWLMZn3rKwCRyQssQ776jM4n8+bkwMzfCyI1UqVUHS9hGw3q4J2GdTVtSVzmdSs3ywNNE35tMiCtxx2fOnYpJKKzcMHr8SGyGlQYCriphWifRTZuhQ09IrvjC+9HkTu0iMBCk/SRz9zr1xIojKAVZFcrdJeRGDjldYTWouqd2M+fAoTeIjHD6n2mOB57dTDv/RTSBXA6pumfV84a5/2ENrQLsoQeAQ5NxIC7yhpkoqNSX1RkuCjr+FjjiY2jbprd8mI0F0m6HUEFtus7ZZMbKkzYUNPnF54pAGN+irCDv5Qdtc+X2mDj9l+M6PwiSEIoCV/6PQH1DA6IiEICyOYQiVQv3Auo/vts1glIxwuVx0mOTv4Amon3BnMZLTJrs51tQnby8jLFjudWcdQYk0WJya+ajWa+QFaXC1tL8vd2ri8InSo+is6qcDbhFru3edcVtJ7glbVLIY2AAJhYizaO3s/LVY7+HWWG3uF95zTKaYCZ/+I3BMnvoRo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(31686004)(54906003)(66556008)(6486002)(66946007)(6512007)(44832011)(316002)(6916009)(478600001)(6506007)(8936002)(36916002)(52116002)(8676002)(53546011)(4326008)(2616005)(83380400001)(2906002)(5660300002)(26005)(7416002)(38100700002)(15974865002)(31696002)(86362001)(36756003)(41300700001)(38350700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-CodeTwo-MessageID: 8f8f5aa2-1a3e-4168-997a-98b8a660b1c9.20240131161019@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	50aa0624-6d02-4883-2f22-08dc227718b3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9v5dPsH+UhWMOLGBw0ZRcgHqcX/YhMzWLaEgK6G1Shc2p4rXknzn9vl0BDyuqw+SkCEcW/2cbUtKGykjK6zRiK2hBhHvI5Z9/EJjzaPeVedP2x5BX+hTnyIzmrPIOVPswV7xf9h1RL9cFgxyWMbn4VLNdlNnVeJMDSugy3FV2dIY9mEY8eVEjwvKhKl6y+dvPYi9Zyn4gpo9oDPLJxQ8H/JrxdLktVffPZa9j/+6HYrahKuh6KBPzFkt5r7KXkys/o6UoZSGByLRKI/7lAqEvhFVIR29A0j09jQapMdctoJO3I8249k8mvmoKby9hvaz23dfgOD1ONxzBzWT6TcZRFXGtc/jd0KVmrRzrj0+I3V+nXglCMGD6iVxhk/wYtAtbYscZhajhXWOt6ywoX2A+gk2ZAdmg+BViYN05fmRidr/eHFVfRDjLdLHLRtZr80GljgZN1TseYz2saNaTY8k/6jKCaoh87OuLE0jfvkNFY8QvSZ/AGfVil1vVhRXERW3DlukWh6TyywgnV6HsV4Nt2R6bvOnjpQupKswNI3scwn+jVVLDvCe6GOmpRRx2ytNBL68+TvoF5l24DmvTYWtBzPAEhcNSUaYQ2r8xfuhmGVu/YcQ0Gj+YZ1qI75OdHxmjc2B1QryQ9wVsDquWLe2D5qfPl8pen8CkKV11tlGjBYmsIWfLBeUS448MFtDpCtfSKs/MdTEJkDGirQAI3EWy9jOQ6JNLd2RwH+DjERibBkQiFlWncDkiR09pcD0l/DVg5qdXQ2OOSJtAbtR23b1Pg==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39840400004)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(83380400001)(26005)(336012)(2616005)(6512007)(478600001)(7636003)(7596003)(47076005)(36860700001)(4326008)(44832011)(8936002)(8676002)(5660300002)(6486002)(7416002)(2906002)(53546011)(6506007)(36916002)(54906003)(70206006)(70586007)(6916009)(316002)(41300700001)(356005)(86362001)(36756003)(15974865002)(31696002)(31686004)(40480700001)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:10:19.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0ecd58-9ffe-442e-e816-08dc22771f25
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9666

Hi Andy,

Took me a while to get back to this. Incorporated all of your comments,=20
except that I seem to be unable to count characters. Most places, I have=20
more than 80 characters in a line it I don't indent as I did. I'll try=20
to improve my indents...


On 13-12-2023 15:55, Andy Shevchenko wrote:
> On Wed, Dec 13, 2023 at 10:47:22AM +0100, Mike Looijmans wrote:
>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>> typically used for ECG and similar measurements. Supports data
>> acquisition at configurable scale and sampling frequency.
> ...
>
>> +config TI_ADS1298
>> +	tristate "Texas Instruments ADS1298"
>> +	depends on SPI
>> +	select IIO_BUFFER
>> +	default y
> Huh?!
>
>> +	help
>> +	  If you say yes here you get support for Texas Instruments ADS1298
>> +	  medical ADC chips
>> +
>> +	  This driver can also be built as a module. If so, the module will be
>> +	  called ti-ads1298.
> ...
>
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
> Is it used as a proxy? (At least for array_size.h)
> Please use real headers in such case.
>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/spi/spi.h>
> This is interesting grouping, but okay, I understand the point.
>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/kfifo_buf.h>
>> +#include <linux/iio/sysfs.h>
> ...
>
>> +#define ADS1298_CLK_RATE	2048000
> Units? _HZ ?
>
> ...
>
>> +/* Outputs status word and 8 samples of 24 bits each, plus the command =
byte */
> /* Outputs status word and 8 24-bit samples, plus the command byte */
>
> a bit shorter.
>
>> +#define ADS1298_SPI_RDATA_BUFFER_SIZE	((ADS1298_MAX_CHANNELS + 1) * 3 +=
 1)
> ...
>
>> +#define ADS1298_CHAN(index)					\
>> +{								\
>> +	.type =3D IIO_VOLTAGE,					\
>> +	.indexed =3D 1,						\
>> +	.channel =3D index,					\
>> +	.address =3D 3 * index + 4,				\
> Hmm... does this 3 have a distinct definition?
>
>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
>> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> Can be written as below
>
> 	.info_mask_separate =3D					\
> 		BIT(IIO_CHAN_INFO_RAW) |			\
> 		BIT(IIO_CHAN_INFO_SCALE),			\
>
>> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
>> +				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> 	.info_mask_shared_by_all =3D				\
> 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
> 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
>
>> +	.scan_index =3D index,					\
>> +	.scan_type =3D {						\
>> +		.sign =3D 's',					\
>> +		.realbits =3D 24,					\
>> +		.storagebits =3D 32,				\
>> +		.endianness =3D IIO_BE,				\
>> +	},							\
>> +}
> ...
>
>> +static int ads1298_write_cmd(struct ads1298_private *priv, u8 command)
>> +{
>> +	struct spi_transfer cmd_xfer =3D {
>> +		.tx_buf =3D priv->cmd_buffer,
>> +		.rx_buf =3D priv->cmd_buffer,
>> +		.len =3D 1,
> 		sizeof(command) ?
>
>> +		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
>> +		.delay.value =3D 2,
>> +		.delay.unit =3D SPI_DELAY_UNIT_USECS,
> 		.delay =3D {
> 			.value =3D ...
> 			.unit =3D ...
> 		},
>
>> +	};
>> +	priv->cmd_buffer[0] =3D command;
>> +
>> +	return spi_sync_transfer(priv->spi, &cmd_xfer, 1);
>> +}
> ...
>
>> +	/* Cannot take longer than 40ms (250Hz) */
>> +	ret =3D wait_for_completion_timeout(&priv->completion,
>> +					  msecs_to_jiffies(50));
> One line?
>
>> +	if (!ret)
>> +		return -ETIMEDOUT;
> ...
>
>> +	if (cfg & ADS1298_MASK_CONFIG1_HR)
>> +		rate >>=3D 6; /* HR mode */
>> +	else
>> +		rate >>=3D 7; /* LP mode */
> Are those magic numbers defined?
>
> ...
>
>> +	factor =3D (rate >> 6) / val;
> Is it the same 6 semantically as above?
>
> ...
>
>> +	return IIO_VAL_FRACTIONAL_LOG2;
>> +}
>> +
>> +
> One blank line is enough.
>
>> +		*val =3D sign_extend32(get_unaligned_be24(
>> +					priv->rx_buffer + chan->address), 23);
> Strange indentation.
>
> 		*val =3D sign_extend32(get_unaligned_be24(priv->rx_buffer + chan->addre=
ss),
> 				     23);

Doesn't fit, first line is 83 characters by my count...


> ...
>
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG1, val);
>> +		if (!ret) {
> Why not using standard pattern?
>
> 		if (ret)
> 			return ret;
>
> (see below)
>
>> +			ret =3D IIO_VAL_INT;
>> +			*val =3D (16 << (*val & ADS1298_MASK_CONFIG1_DR));
> Outer parentheses are redundant.
>
>> +		}
>> +		break;
> 		return IIO_VAL_INT;
>
>
>> +	default:
>> +		ret =3D -EINVAL;
>> +		break;
> return directly.
>
>> +	}
>> +	return ret;
> It will gone.
>
> ...
>
>> +static int ads1298_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan, int val,
>> +			     int val2, long mask)
>> +{
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +	int ret;
> No need, just return directly.
>
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		ret =3D ads1298_set_samp_freq(priv, val);
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
> ...
>
>> +static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int r=
eg,
>> +			      unsigned int writeval, unsigned int *readval)
>> +{
>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>> +	if (!readval)
> Perhaps positive conditional?
>
> 	if (readval)
> 		return readval;
> 	return writeval;
>
>> +		return regmap_write(priv->regmap, reg, writeval);
>> +
>> +	return regmap_read(priv->regmap, reg, readval);
>> +}
> ...
>
>> +	/* Power down channels that aren't in use */
>> +	for (i =3D 0; i < ADS1298_MAX_CHANNELS; i++) {
>> +		regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
>> +				   ADS1298_MASK_CH_PD,
>> +				   test_bit(i, scan_mask) ?
>> +							0 : ADS1298_MASK_CH_PD);
> Broken indentation.
>
>> +	}
> ...
>
>> +static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
>> +{
>> +	unsigned long flags;
>> +
>> +	/* Notify we're no longer waiting for the SPI transfer to complete */
>> +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
>> +	priv->rdata_xfer_busy =3D false;
>> +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
> Perhaps switch to use guard()?
> (And scoped_guard() where it makes sense.)
>
>> +}
>> +		/* Transfer 24-bit value into 32-bit array */
>> +		memcpy(bounce + 1, data, 3);
> Hmm... Wouldn't get_unaligned_..24() work here better?
>
>> +		bounce +=3D 4;
> If so, you can iterate over u32 members directly without this +=3D 4.
>
> ...
>
>> +static const char *ads1298_family_name(unsigned int id)
>> +{
>> +	switch (id & 0xe0) {
> GENMASK() ?
>
>> +	case 0x80:
>> +		return "ADS129x";
>> +	case 0xc0:
>> +		return "ADS129xR";
> Can we have these all magics be defined?
>
>> +	default:
>> +		return "(unknown)";
>> +	}
>> +}
> ...
>
>> +	if ((val & 0x18) =3D=3D 0x10) {
> Ditto.
>
>> +		dev_info(dev, "Found %s, %d channels\n",
>> +			 ads1298_family_name(val),
>> +			 4 + 2 * (val & 0x07));
> Ditto for 0x07.
>
>> +	} else {
>> +		dev_err(dev, "Unknown ID: 0x%x\n", val);
>> +		return -ENODEV;
>> +	}
> ...
>
>> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
>> +	if (indio_dev =3D=3D NULL)
> We do !indio_dev in this case.
>
>> +		return -ENOMEM;
> ...
>
>> +		ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
>> +					       priv->reg_vref);
> One line?
>
>
>> +		if (ret)
>> +			return ret;
> ...
>
>> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
>> +				     "Failed to get clk\n");
> Ditto.
>
> ...
>
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to enable avdd regulator\n");
> Ditto.
>
> ...
>
>> +	ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
>> +				       priv->reg_avdd);
> Ditto.
>
> ...
>
>> +	priv->regmap =3D devm_regmap_init(dev, NULL, priv,
>> +					&ads1298_regmap_config);
> Ditto.
>
> ...
>
>> +	/* Avoid giving all the same name, iio scope doesn't handle that well =
*/
> IIO
>
>> +	indio_dev->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s@%s",
>> +					 spi_get_device_id(spi)->name,
>> +					 dev_name(dev));
> No error check?
>
>> +	if (reset_gpio) {
>> +		udelay(1); /* Minimum pulse width is 2 clocks at 2MHz */
> How do you know it's 2MHz? Is it always the same on all platforms / setup=
s?
>
>> +		gpiod_set_value(reset_gpio, 0);
>> +	} else {
>> +		ret =3D ads1298_write_cmd(priv, ADS1298_CMD_RESET);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "RESET failed\n");
>> +	}
>> +	/* Wait 18 clock cycles for reset command to complete */
> Ditto.
>
>> +	udelay(9);
> ...
>
>> +	ret =3D devm_request_irq(&spi->dev, spi->irq, &ads1298_interrupt,
> &spi->dev is different to dev?
>
>> +			       IRQF_TRIGGER_FALLING, indio_dev->name,
>> +			       indio_dev);
> ...
>
>> +	ret =3D devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
>> +					  &ads1298_setup_ops);
> Ditto.
>
> ...
>
>> +static const struct spi_device_id ads1298_id[] =3D {
>> +	{ "ads1298",  },
> Inner comma is not needed.
>
>> +	{ }
>> +};
> ...
>
>> +static const struct of_device_id ads1298_of_table[] =3D {
>> +	{ .compatible =3D "ti,ads1298" },
>> +	{ },
> Drop the comma in terminator entry.
>
>> +};


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




