Return-Path: <linux-kernel+bounces-52901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499DB849E09
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90971F25BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C812D604;
	Mon,  5 Feb 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="JsWs2zju";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="q7nIOKpd"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2121.outbound.protection.outlook.com [40.107.14.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A92E416;
	Mon,  5 Feb 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.121
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146735; cv=fail; b=W+7J1jbLwBaUJbkYvlHjIjlDm0xp3gMv1REVk51nh+ZhBRdBBr5GobMHGlMiwuLZiXoRbVknY54TBFvz0h9ZB50O7E1y1BJB64dBynMuftVvIu4dIAQKIfYeu6+RznmUvAJkckOpdrvrBN6QQgvEKi7Qtr6tYdLph+ATPKIloIQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146735; c=relaxed/simple;
	bh=lz+ud7YG12b3bZD22rV6jvGwDWVQW+ePNL47ISp3BA8=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4ZNVTt9Bj2Grle3Z5/x2UqNtRLsmU2N8AfNlY5v4hZ61DLaWoXwSdZEM55UUaNlJjiDXAhwpq0koj8XdLUumaj81ddaBKAc1moaefJMZAFirAURb29PC4B4VfWhvsyiG6D2sucl8RljBtd55oDmvmMrERkhCDgmo4Vd7YnXIXc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=JsWs2zju; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=q7nIOKpd reason="signature verification failed"; arc=fail smtp.client-ip=40.107.14.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=nLBLyyqW4xADMCbzP8d1m/RTj/UclXCr1uTX9o573bIEEXAPNdYdiK8VOZ+xqcf2znS3zKojG2YtvkQPhDl71C1FIwxduPPwjotXD5t5DWYWWQ+SkIuXJHfTWCCbqMs5/uqzbIhcZAJFL5muK1qNR68h0H0BpjJIYidHtIn380h8jYpDx4B0e2q8lLciiWv5vvKEttsZL6zwWLrR9m1tWLPngyvFllKkqPNPkHAJmDm0nxDX97IsFxy/E61nksaQBnsbMpQ8kJrP0mUUg90k7z3oFroRmPCBR9YojABRYQ3gF3aQcAFgd00ot85dntznjgKL7BI/3CmPdKZBzWMUIw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IxFiqbYbqXDZi/hy9bCUpcGAp2kX6nDUxL05TDp5EY=;
 b=QB7WdrCYEF2kWjRHxuAKyD/Rya/4/o5Pbn4u8yzI3Ykt6VhHWiC8IBz+UZdMwV84QabQd1xGz+VQbHbiMtymgfrkck/Tfo76H7hGe3aFDkhaJ1LJcRs70+HvvurWazd3PT+am/Oz/c5zQHlTaPjqkfGvoSAXdBC1rKL+upOenhjLywOVXQtsv3P4cEvhrmb2te8V5ZB07avq5e5FJ86bEDtCE0UdVqoJIg0sOC2jEGAykF1bYV/BaW5HNxg9vZYhP+92MkPud60w6ewwswi7rQkuKWa6wHq8fnLCbW4xZEoCzksS4y9KAEswxiyapBJEn3NeKCUTHco/bulHpLfSrQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IxFiqbYbqXDZi/hy9bCUpcGAp2kX6nDUxL05TDp5EY=;
 b=JsWs2zjuDhRPB6jzQ+aOpCJyB8RK/tZVbCU6CZjFlBx4jNYXkUW13z4BviW5zJ9d334BhspkJstC+cKCuPrgX2v58PH/S83Qwy8l5ybTQWMsIN70Wk3AqUYvCQBOQvVtMP9+BG6VWQKR+dWJ70uZmXDHy0rdn0icBDD/0867f+Hm8MGIWx5TZ3Tt6QQOHjuukH7rmOXr2dSKh5LCEc8Z17qZZ7/MGrDaTL+heK86UPpGPHqNnA85UvZT5QVl2HEpi6QNjuZsv/BjyhtOvydb64pvMmlvfAVHUdUJTNVwHOohdijg2PonnkR7mgcmgPZMJi3ibEdyRf4fkIVyP1in3A==
Received: from AS8PR04CA0202.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::27)
 by AM8PR04MB7987.eurprd04.prod.outlook.com (2603:10a6:20b:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 15:25:27 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:2f3:cafe::24) by AS8PR04CA0202.outlook.office365.com
 (2603:10a6:20b:2f3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 15:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 15:25:25 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Feb 2024 15:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cESgBiZSGVWU6ZYreRgCvNoSdLTgYCck8HtFCinQsz9qzqLD2lm/IDfmFZ3ycssecAITle5j7vhckCRjePHE70bUAjmK6dhd49OjDlOe1rv71bk7jRO2wang52zkR2dSk4GPNoZsEgTyCuglO+rupr70JSKpktHbIDWj/7yLuT5CheJm+MLhFoK+qyGpbQdXHn1mBjMqnNA/LsAZBtawJcZiHKrsDL9TcA6jsJ7A2SXlfrlpkuCnNsWusjJbJXNtWxjHWsR0tcXG/d/PagWDmkJdt9w4Jn9ZNcIOtTzuhQB5hjF+34Izw+/q/lzUDReIbcVIU7wZgUIFG6EnB/5BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UhtwgRCPivufs/XiKVa2ihrtUmXw2J/+dBbWf0FyyA=;
 b=UUd0dzYZKqMWaUZyvzN9D0YmibRgVljVNrAS/GuimnyuAEyYKzscJcuyiom3OPEOwl0Lo4OE0MolMhGB4sMj4ehr5Sxx/VHaCHbeyDHIxe1a/aaRzY4n5qTasA7VnoTs4pi1i0m1G6Vnmco3pwEKOLRJBIpqkMXCls1TQG0HzvngHkdggL3AiBL9Qd9qZGYc5qeS9wunkSyhAX+HxsZyWG7PJpsOIWWOU5Lhp1qolojoALehi6tGPYx6Gk0vwHJ8/ow/6YiU1uiZB052hvS5zE7b36XNLCtlwsOHHUwKg6xU+l9OMWx76foEhSFq1V7VAcxLOfxKJ3f9RI/1R7gkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UhtwgRCPivufs/XiKVa2ihrtUmXw2J/+dBbWf0FyyA=;
 b=q7nIOKpdDhMM3TXZBkbtsrGzmuWStZmPuSMVRgdkUmzK8Q65TDyn6u6F7ImslNHXa8mTW6NQaYcgQJJQTIfDaYYKw9QyBVHOgDB3V/DumCBzlAgzfKY8G12jbpmQLy9IPiC9qLoYaVC8ntHbjg5OnJE5CFM+q5hjuwiGqmG3W9rqLV5pwil2fjxL0bCpGWPHcP6KyXWCQZsNbHVG0TRXoKT69OIUaqWbrmOfII0sT5IFhXME26YzZ/y7xpRfC/C++3jGaiET4Ci6yqjI15xmf8subSYCpWyNQvGLQfOL7h/mKDDpcGNmV+WVW5pArkQ/fyHmkFa+44a5rXu3r2Xp7w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 15:25:20 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 15:25:20 +0000
Message-ID: <7d7ea4e4-fcae-4966-b194-e1d328751b6b@topic.nl>
Date: Mon, 5 Feb 2024 16:25:19 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1298: Add driver
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
References: <ZcDo6QvoE_e5s_f1@smile.fi.intel.com>
Organization: Topic
In-Reply-To: <ZcDo6QvoE_e5s_f1@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0035.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::11) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM9PR04MB8210:EE_|AMS0EPF000001AE:EE_|AM8PR04MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaabe1d-b93e-4345-5087-08dc265ead8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 VQSowW7k64VJsULxJxT3Pb5JnexvdaCK/pnVhRng3LZStTpOjW+ZpGSYP+uaGp+CYPG8IUyhH+J6NkVd3bvF1jFOOnU4bHoEvik2NDIdSLKDSDQUsR8HfKXwFDNDK07GPlIgtOeRrFw9uv2CwZUPd7gdH3QRExHR9AQL8Bp8GpUataioJEvFZS1Q9tLg2IIvQzMLEJ4KBQ4nXe9yKZCzKTyN8psR6hxAiaSLpICGN14KdU9YOizX/KI5hgs37PVQUSIywoFI6vZJQwqiTIZ2ULCp8pn4tsvDIR2GV5ejlU/lLurr+JahKcNvh5wxnxBnccpIH2GVYo9vZ0o4g6dvo3j+sgTHq2ePffr6k960+4Zw9Dq3wGWPfZNsLcSeFrLxiPbKpI66afryli25Gi3BAp75/UoxfJUvhQJ/k2A0VUM7sYyAgHObhSmhewaUR9qcuY9AxzSsIfWYzS86G4smmuiSDJiJIXdx7At9GmaovWJ0gkIHyF/VfFoFmO2bg6J4G3EGVDh+tbEGuiNVtfFIrffdYQMzADzrMm12BCleRlZGLsaSVqs5aQ9R3YeH7s0FF9gVb1Dfi2a+1sQGtQEsKstxC4QOU88aolSDtWret1iBwsCsHiwci9/P9j6C5furEM7x/OJQqCYT65d6ZZ1TcVLrXiuuUTRDXXOJ5MwSYOc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39840400004)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(15974865002)(36756003)(86362001)(6512007)(53546011)(36916002)(6486002)(478600001)(38350700005)(52116002)(41300700001)(31696002)(26005)(83380400001)(2616005)(66476007)(5660300002)(6506007)(7416002)(316002)(6916009)(66946007)(44832011)(66556008)(4326008)(2906002)(8676002)(54906003)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210
X-CodeTwo-MessageID: 73e4eb7e-9491-485c-9cd0-3c6f3792f17b.20240205152524@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8da3142d-07b9-4a0d-1612-08dc265ea9e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KE47q2OImjwUM2eP3Vo9wLI6IlohQeNaXVaHCwnVkbXDS+qWum41OIDV0clBHK5FmWucC66uLHJoeEziHAoiRqUBCcWWMK0hWy1YL6U79s1Cd19KvyYAWx64DJnr68rbOkF8ADjNc3PcvTNKxhVornDT5TvfD2H2rnQyZA4Tos3Qk3miJM+1rX9OgtD4zHwJdbNQ83PUmvPwodH1XTHMIkArogUDVpHq3d0DFj9JXHoDimKwe7gHlbTSjKbKqBarp3PBr6ikPvYN4drb21+XqswIlPf5DWloZEs0P5oH727dYiIglypKddO2Deuehx8NfO9MZ8CnkwT9/c2ISuHoJutfEhnFB/DUdJTuXrXEPuXTB8EX4bchX8YHp7G+s6mFEOliSqAhoNahOsQggdh3jeB3PLKp55PR6ow2HeQjKGXYBks6h/6SwqzbJewcRR5/K5mt70Hly17zCevHnfm9YB/mwoB4RNUFU6xnDybyCTxQco4jscNY6KM3FBzK/r1qqDrJcGfVjPwj0KHQfBRk1V9C8C/OWjcxVzUmRxyTHdNDtMvTUWM2da2dYj9P8oIf28VNat1vD/XDlUE/bh72q+mvL1M6FtsbsKPd216TbjFDBQkEGiH+X4FyGnQfb5OCrFXhaZnqTXdkA9zQ209Z1pla87of0sWMIX2SxxsbvjesREMeTjKbWsmVjru1YIkXC6UGc/XeBzrAmnniYhrzZNytt/BizurDy2Ggt7TodbGw1xlOXnQfIf3o7aY92E/5
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39840400004)(396003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(86362001)(31696002)(336012)(36860700001)(53546011)(2616005)(36756003)(6512007)(83380400001)(356005)(7596003)(478600001)(47076005)(6486002)(31686004)(7636003)(26005)(40480700001)(6506007)(36916002)(15974865002)(4326008)(316002)(6916009)(54906003)(70586007)(70206006)(5660300002)(41300700001)(44832011)(7416002)(2906002)(8936002)(8676002)(43740500002)(18886075002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 15:25:25.9396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaabe1d-b93e-4345-5087-08dc265ead8e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7987

Assume "yes" to all suggestions not mentioned below.

I'll send out a v3 later.


On 05-02-2024 14:55, Andy Shevchenko wrote:
> On Fri, Feb 02, 2024 at 04:28:07PM +0200, Andy Shevchenko wrote:
>> On Fri, Feb 02, 2024 at 11:59:01AM +0100, Mike Looijmans wrote:
> Hit "Send" by a mistake, here is the full review.
>
> ...
>
> Why this can't be the part of drivers/iio/adc/ti-ads124s08.c?
> Seems to me the command list is the same, registers are different though.
> Broadly the Q is have you checked other existing drivers if they can
> be used as a base. If not, perhaps a word in the cover letter is good to =
have
> (sorry if I asked this already).
>
> ...

The ads124s08 command list is the same, but that's about all that's similar=
.

>>> +	struct spi_transfer rdata_xfer;
>>> +	struct spi_message rdata_msg;
> Do you use this outside of the ->probe()? I just ask since I removed some
> context already...

Yes, probe() initializes the structs, they're used in the interrupt=20
routines.


>
>>> +	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
>>> +	int rdata_xfer_busy;
>>> +
>>> +	/* Temporary storage for demuxing data after SPI transfer */
>>> +	u32 bounce_buffer[ADS1298_MAX_CHANNELS];
>>> +
>>> +	/* For synchronous SPI exchanges (read/write registers) */
>>> +	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN=
);
>>> +
>>> +	/* Buffer used for incoming SPI data */
>>> +	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE];
> Cacheline aligned?
> I see the cmd_buffer, but shouldn't this be also aligned?

I understood from Jonathan that that wasn't needed... "My" SPI=20
controller is rather dumb and doesn't even have DMA.

Will take a closer look though.

>>> +	else
>>> +		rate =3D ADS1298_CLK_RATE_HZ;
> Dead code (here and elsewhere). You probably wanted _optional clk APIs
> in the probe.

Yes "optional" was intended.

> ...
>
>>> +static int ads1298_reg_write(void *context, unsigned int reg, unsigned=
 int val)
>>> +{
>>> +	struct ads1298_private *priv =3D context;
>>> +	struct spi_transfer reg_write_xfer =3D {
>>> +		.tx_buf =3D priv->cmd_buffer,
>>> +		.rx_buf =3D priv->cmd_buffer,
>>> +		.len =3D 3,
>>> +		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
>>> +		.delay =3D {
>>> +			.value =3D 2,
>>> +			.unit =3D SPI_DELAY_UNIT_USECS,
>>> +		},
>>> +	};
>>> +
>>> +	priv->cmd_buffer[0] =3D ADS1298_CMD_WREG | reg;
>>> +	priv->cmd_buffer[1] =3D 0x0;
>>> +	priv->cmd_buffer[2] =3D val;
> Sounds to me like put_unaligned_be16().

Added comment to explain the first zero is the "number of registers to=20
read/write minus one".

> ...
>
>>> +	unsigned long flags;
>>> +
>>> +	/* Notify we're no longer waiting for the SPI transfer to complete */
>>> +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
>>> +	priv->rdata_xfer_busy =3D 0;
>>> +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
> Use cleanup.h?
>
> ...

Will dive into it, is new to me... Looks like C++ "scoped_xxx" at a=20
first glance.


>
>>> +static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
>>> +				    const unsigned long *scan_mask)
>>> +{
>>> +	struct ads1298_private *priv =3D iio_priv(indio_dev);
>>> +	unsigned int val;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	/* Make the interrupt routines start with a clean slate */
>>> +	ads1298_rdata_unmark_busy(priv);
>>> +
>>> +	/* Power down channels that aren't in use */
> This comment does not describe why you need to write to _all_ channels.

Yeah, need to configure them all. Most common is that the cached value=20
is already okay and no actual write register will happen.

>
>>> +	for (i =3D 0; i < ADS1298_MAX_CHANNELS; i++) {
>>> +		val =3D test_bit(i, scan_mask) ? 0 : ADS1298_MASK_CH_PD;
> With above in mind, this perhaps needs to be one of for_each_set_bit(scan=
_mask) /
> for_each_clear_bit(scan_mask).

Probably more efficient to access the device registers in a natural order.

> ...
>
>>> +	.cache_type =3D REGCACHE_RBTREE,
> Why not MAPPLE TREE?

Reading the description this driver isn't a good candidate - the map=20
isn't sparse and the hardware can do bulk read/write (though the driver=20
doesn't use it).


..


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




