Return-Path: <linux-kernel+bounces-152905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526628AC5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DAB1F210B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806904D9EF;
	Mon, 22 Apr 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="S8kalc0j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="I4jaD1Aa"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351A2233A;
	Mon, 22 Apr 2024 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772242; cv=fail; b=mRGEHWMMePFYClT52n57tIWgP+LfMeB34+2NSnLId2pVW+QJMnxEjnctRzyUxuGaNGzwn9bKDPbV69gY9L5L1phYpNTY+59/BRXho/lxSKFXijbEfWTDyHoSU59U3gWhycDFpeRNO0DjgrpfZUU9guF4+qCKSBGA3tC0fvW257Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772242; c=relaxed/simple;
	bh=xSXqb5SnmhKsEC6Sp2Q57Fm96fqZrk1tWaH7X10SLi0=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiZJnEICUoAsFzJnmCKz+AlFeaZncoW1X+AUChLTC3A1KqrNHa2OJnPHpXdZmgCJ0r9eXlIqdZSXrVtLR0W3RU48+6SE/GR1fqZCwrLBaVswOmvpAw9janMHr/O7yjykA+cRk6PpK5ed2+ew91nOz13fzdV1XGfFM/oiwRGzWHo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=S8kalc0j; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=I4jaD1Aa reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=KJ5WvmuvclCFkJSLPHJrpBq8+uhrnJVVExvSohe3L8TGff/ilLJU7qxMdMSxQQsS8eE3RCoG4elBDn6944SXstEb7TJVt4ReIf3qBQhVcMIGqaRAdAV9K3ZRoMTSyn+ACq1b2e4Sd+CrqdpE+7WsIOTHMzlF4Im/SZxaizHLGBD3KtqBozAPnRUSxONeY8cubGeWS/1P/QHrVp6UTFAId0bvgOfsSx1UcQradCB5nHihDyV7Zh65eopMFxFzEE3oBTB+XTeXpgoJkGUonrMkIL5bvQGDtQMcTVpjXhEiOdRDnIR7MF6StrBNL3sXEWIfIgeFj0YzyPjDG6KYaOrFJA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1iTGtnovQBz2+4VVUfj8WBJgXtpIMMUjd4iBAacbCg=;
 b=LvezCB0dirX5HZoua0SjF9jTq+jhX7piwmibBubCPuveaa2x6C2OC9D1pjrfrNYFZrRWUsG5aVnwnA/scQEM8KwZOpM2cjHf5FVndvb5vxSnXPquUjKjhqMDGu2dY1E4UMUVS3Tf0JNrKCL2RnzgoRu8LOzeQ/SkmKZa3ZYOGZVj6KUghM1M2G+q+wfT+APNr2pJjdZl3K+E+HZgXRW6IjceA7A103MeIZzlobE3KZy1Alotfdc+Vq/qvoHRSSe0AWNttpehxMGS0/vJS0jPd84gF9vfMWgoLMRjz/J+Ucfrb6I75NLsNwdlNUP8G/ejtuVzGBtwG6gc4nvujvcQig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=linaro.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=fail
 (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1iTGtnovQBz2+4VVUfj8WBJgXtpIMMUjd4iBAacbCg=;
 b=S8kalc0jKDXNwNlytXw3EZnhhZr97Ac5sWpnpTiBr2Xm7D+GLPTXmtT2KIJiqvKI15rNi14q2+SrJ1Ush2xuDC0H5zqGzAmBafrdmlu89t+1SNn0eJdH3RwnIZsZRPb5D2YygzheYb6NGeEHEUHf+Edglmjyfa1eMJUBUR+aYASxZsMbtLODB1V0c/ciOrd/snLo/iS+vN7hKMl+4qZe6eI0q5DjFWUlv+3wty1KMAZ34HBILdqFDIgfUdFTpuCxSkMR/hkUDKVCkYVnbrQqa62Ypkmb1MD0EhAhY8qRXXXDHi8iFswcQPW8tM4hbpKBz4qUHCycq8brJ+xvAjW9iA==
Received: from DU7PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::23) by AM7PR04MB7078.eurprd04.prod.outlook.com
 (2603:10a6:20b:121::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 07:50:35 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::e2) by DU7PR01CA0040.outlook.office365.com
 (2603:10a6:10:50e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.32 via Frontend
 Transport; Mon, 22 Apr 2024 07:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 07:50:34 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.50) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 22 Apr 2024 07:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qcarp0SFVPVPXL0I8Hhqx+IfHdLXiQ7AyP3Zxammo9PuAaFOKOnMeGb6D6FqeFTf29aVEY+avjQe+5ylnTFIkbhCKU3uCdbFq4pkUxSR8ZV6ucNevpWNZJfB864pN+brueg63/3X8RpYDaOyA3INhBvUK6QI6aa6TFKTmKasI8kPRlgsgMFmIrnWkY4Bwjpg2hVOW5h9O5+4tWmiE4GDMW8HWOSdi9gEqDZXEPkAxr3xeX1NyxIbhFwWeBt1JKu3JJqMJzQhwLVDLtPpswSE5dCENizSQVE2GiP4I49aqWpEjr2NcyUHA6dyx6zHs5OPvNYAIWdOQjzu+zD8yNkUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S69pra91/SiR2iKGE3WC40Gyjk0HXqxTgEXqus6fPH0=;
 b=TQw/ubYRLeW8lIURGVbb5fF+QuoTI0Vs8YcIkvC6j/fzbu1tpFCo8bAlqsyPdzwpvgyW3aSqywBwijb7lP9i7mAHZg0j/R4eOEXoZWvGIdWowRf5T9402cLXB6VifkDXf7PFQf7nPvlDncjfvOFS+VbdH4PDCrQJSM9qFtUyLqiyVNe3D2YnWfEbGJ6jIi2r+yy3iRwZYPm4aYGV3TFDUf1YgvUiuTn53PdMbf5Id2dlSb6XOCdjxWplboYKH73aNO4SCS0XP0iC6hdBTXMWPsACU1hkL54v9SUwsDMeeQHMFpG7O1NBszhY0zgavZYARN5adZXerNahzN/jtE8/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S69pra91/SiR2iKGE3WC40Gyjk0HXqxTgEXqus6fPH0=;
 b=I4jaD1AaHhM+zNd6YdQ6BZEGmeZ6V1OuHhfJr8QLjhP0bTFPabM9tJVfkAGWtE41Ddm0Le4zI9m/56uK9JNqg3O7WUNgm9yzgDDdQ2IVtGoOORCb5TxkOmr0BY4uG+5BzMFsaQJHFh4DEF4bHZbgtWqR2ekzNaTzDDr0f/VVmmP4tQWT/0e3NHYfoxU/tFqM0DrbhXEDmoY+LLyoVhrZPjx7cwlQfHs2YwaC9fCfj/9kd1uta7brzR3HEdcr4ErG/Q4J4dxrazEbXKTjJoP53NUrXm7rp6wZJDfsqYvmVe33j0RmpyOIPMvb/Uo7FGXJR++ly06ec0nY6w2XqrOutg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 07:50:29 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 07:50:29 +0000
Message-ID: <16ff3a55-3d04-46e6-b78c-c1964c062329@topic.nl>
Date: Mon, 22 Apr 2024 09:50:27 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 1/5] dt-bindings: power: Extend battery chemistry with
 capacitor
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-pm@vger.kernel.org
CC: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b2a893bc-f00b-47cf-ae07-b37ec1bace22@emailsignatures365.codetwo.com>
 <20240415081305.316107-1-mike.looijmans@topic.nl>
 <1f94ee56-7f8e-453b-ab86-f640b298d81c@linaro.org>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <1f94ee56-7f8e-453b-ab86-f640b298d81c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0053.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::17) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS8PR04MB7799:EE_|DB5PEPF00014B9A:EE_|AM7PR04MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d437a41-0b13-4437-5ce1-08dc62a0e469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RXZxZGUvQm1hS2MrZHhRTWtmZVVEVTJTcWFrUGN2MTR3bmZCNXd0WUc5S2Rq?=
 =?utf-8?B?YlJhU2l4bjB0YVY1dnFhemhUVVl0cm9OTlc2bEdlYS84ZmhCV1FQaFE5MGpy?=
 =?utf-8?B?RnpuNWVSRnVqZi9zcklrTmp5VHJubDFHbDJobXlBU3RyQXpDcmVTR3N5Y3dz?=
 =?utf-8?B?eG1EL3JRdDk0dlFXRVdOZ0ZlTmFGR1ZwQVhUUmNKWGkzWmJrbFhSejNuajE2?=
 =?utf-8?B?Q2kvT1g2NFlVTXdETjRNa3hzTzlFUStDTHdvQ3NmcGdGZmVZd0hHU1RrVXNN?=
 =?utf-8?B?eCtxdlVxQUcvRFREU2VnbWM5eGJjWUd1RnpzbzZXTkp5YmpnUE5iZ3lNSUtP?=
 =?utf-8?B?NGdtRFRWR2VKalFvT0tEVmFVRzR0NHZOcTZScXB1Q21xUTVYMHkrdGpLT2wx?=
 =?utf-8?B?QlB5RXRCSktjNUVQNFJoQithWEw0c1VsRHpDRlRIakxCYXpkbStyZk9XbDl5?=
 =?utf-8?B?a0Evb3lrQk9PTmhITUFiRjF0MDNpM28raTBTLzNCY25sWWNLeXpHYXVPenFY?=
 =?utf-8?B?NGVCS1FDM2oxSWtYS3ozQXgzSnplczJHMm1IeUphVDc0SFpXKzhCMmZwbjNY?=
 =?utf-8?B?S1I2UDNZWWVqN2tXSUZLYUdCWE5hSU1ISjlXcmJnWHI0ZlBvTkJKR2JSMXU5?=
 =?utf-8?B?MzVYcjB5LzdXVUU0Wmk3YThNMGtyckJ4bEF6TVRGSWNZSWxGSzFNKy80Vm9W?=
 =?utf-8?B?QVMyUDExSUlCNEtiNnRaUDd3bFl6R3NpNDZvcHpGWk8vaUQ5bW1YTnQxaW9Q?=
 =?utf-8?B?aTZmRURBL21mcWRpQVFCZks3RWlOUjVDek5lU2EzR2R4d2E3bWI5TnFhYmZB?=
 =?utf-8?B?SUFSVnV4VTl3NVdRdDk5ZGdUdHJOSGFPZXdaV01LSW5NSGxvVUVCdWNZQ0RB?=
 =?utf-8?B?Z05iUjkyOFh4SGs0c29RQmdNUjhGZ3FiMWtYN0RnbUFBMCtzdjBwM0g5S0ly?=
 =?utf-8?B?cFVQME1QcTluNkVqM29hWnkrZEc3SzlSeC8zK2FWNW0wQmgxK1oyYXViaVZL?=
 =?utf-8?B?eUpraHFqTkQ1S1k2MUZOZXZkY3AzWE05M201dFFyWnRuZ2R4ZE5hcXE3N1hy?=
 =?utf-8?B?RXMyOVVKYmhBelExNWtBTGovZk56UnFHWG54UDdXS3FwMHdxaGFhcklBVlUx?=
 =?utf-8?B?Tmp2VGszSnZETklHSDhrYkRQeEVZQ3orYTh3bFE1bEtTcTJ5OHdmbDFucG1B?=
 =?utf-8?B?NGVBOXVoNnBRbXdHZklFVzFScUdxUTAwS256aXA4M0FlUm9TMDhGdlJHalV5?=
 =?utf-8?B?dmd1c0JNSUp5eEtSaXlQWFE4UVc3OTZKdWhVejFuUzY3Vm55L21Ebkg2Ulpu?=
 =?utf-8?B?bnlVNExnVS9ZbVlEemk1V2xBNUl0clY0d0oxUVlZU2VhVE1pR1Q1elVPZzFL?=
 =?utf-8?B?TEhqRlNzYWtWUjU5cUNkVTcvRCtKQ0tTWlRkeFFmTjNTRGMxK2pReGQxQkd4?=
 =?utf-8?B?Z3NLZUliSFVtYTlwcE9nRFpSLzVzRTRIQnlCc1cvRy93Qnh3eHY3QlFlUm1D?=
 =?utf-8?B?K2hNR0xWYXdqUjZ0NkRNVFQ4TzlUN3lYbWZDSEg0OEZiTmpadlNRSVkvaE12?=
 =?utf-8?B?aS9NcHNTWWsrUTNZZFh1ZXpXa1VkUmR0bUd1K0FhME9oWjFhcFZhWGV6VDBj?=
 =?utf-8?B?V09GaEpiMFF6OXVSNWtvL2szMms2NjZyWVc0dHMzVXBFWmh5SFNZWWZCajdM?=
 =?utf-8?B?T2NEMHNsZDR2eXBBbGN4QnMrbmxaS1pjRGVnTmJRQ1N2anBZazdYT1pnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799
X-CodeTwo-MessageID: 88f15522-ae33-4c2b-9e23-e1eda21dedda.20240422075032@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eba581ec-dfd3-4355-45c7-08dc62a0e0ea
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFRHUTF3NCtIZk1QVFUxMlJzTFJXb2FLelRGNjBHQW1FbVBFVmJUOWlPMGhz?=
 =?utf-8?B?Y3JtS0V2K29XK3dlbEp4cURrZVVnMWxBNXBzUUx3MVNlaVZhRkhiZk8xWnk2?=
 =?utf-8?B?M2hqTGpYN2pMUVVXZVJpV3I0TFlMSCtzZTlBTWlLOGdQSzZUNDF2ek1rRG4x?=
 =?utf-8?B?QVRmMFRBUi9iUWhCa2d3UjJ3YmNBMjVyTmpNZEV5R3U4THBSMGNlR0Rzb1oy?=
 =?utf-8?B?K2RmSHVDRERKdW9XK2F0RlZDMzViMXJxZDVMQW9aWDZoMGx0RGt2blRUVTZG?=
 =?utf-8?B?L2xhdndycmQ1NUJRYTdONlpPNC9Ebzg1cThjTXRFYTd2d2VYUlRqMkJCbDVx?=
 =?utf-8?B?ODVqTFBuQitvaEllU01aY1Jpbk1tS01GdDIwb1NHSGRxVHZyMHdzczQ4YUJV?=
 =?utf-8?B?aWI2RWFpZWVtOHFVa3N1Y2JGTWs2aUpGcXR6YXFUcXp6SXd1Nmp6RmtHd1BR?=
 =?utf-8?B?RWlSdEdJVmkrRTBwZ2FTVVB6aW41NlRiS216cGtuNGRPQURhaXNhdEp5Mlkv?=
 =?utf-8?B?NDYyakpxWnB6MGRlZEtOU0tlNkRqVmpQRWZ6dnJTL0VmV3V6YmwrWm14MVZU?=
 =?utf-8?B?ejZYK3ljVS9RM1FuZnpEVG8vWEprNldBWHVzQmNGREtZb2RURW1LL0hFZkZP?=
 =?utf-8?B?OU9FU0lIZjBGUUNPaHQ0TzR1dXBIaGtjcE9kbnZrYzZZelhUVy9xbE9CdmdO?=
 =?utf-8?B?V0MrbUEzbFZnT2ZETHd6SEFSU3pCc2ZkM3JxSkRFRmxxYTAwbHJuM0oyWGFE?=
 =?utf-8?B?d1JVcEtRT3lxMlMyU08zUklLT3ZmZUllLzB4ZEpTeFNwUW1JaW9paFdYTjlM?=
 =?utf-8?B?a2FDdkNFcUpKS2Y3dGVmWXI4L21KQlZ2eG1OOGhmYVNYSzcyOEZSK05pWFZ0?=
 =?utf-8?B?cU9RNm83TVk1V0xJME8rcUpxcUFoK05nVFNPUVZaZFVPaTVTdEtRWEpEeHBy?=
 =?utf-8?B?M1k5aThaMWM4anZJR3l3b3pRSTFvSFNnTXFxL1psV3kraGtaaFNXZkx5SmJi?=
 =?utf-8?B?V1JiM0hQWktzVU5QS3NqaEwrRHpJNG43L2VWRjdVbXVrODdmZHliUEllTzdH?=
 =?utf-8?B?N1lqM0FVVW90ZHpHUzhxcXQyU0RwdFZoZkNsYWxOSGZoU0FLVDVNR1Nrd0xn?=
 =?utf-8?B?WVdKU0ZZMTJZTm1iTklzOGxmTS9YNURXUlp5T3ViaTVwUVZBeVlKb1Q3ZjJl?=
 =?utf-8?B?WUo1V0ZvbExBMmpYUzN4cHpLckNFaTFSdjZLUzlubHdoVFRuajN1NFFBaWc2?=
 =?utf-8?B?SzYybkJsSVhnNG83MHllV2hQSGVXSms4VW90a0hpVUFwSXJ1SThFVTZITnJI?=
 =?utf-8?B?UWF2MWExMlJBV2tlcTVSaVJQSUxNZUY2L2RhTWpacnBKRlBUK0czRzBlRWJi?=
 =?utf-8?B?UFI4dmxRdTZRSVZPbnd2NGNnWlorN3RuNi8wS3FLMlFOK0xkZHpJUGc2cFFi?=
 =?utf-8?B?YUZ5MytPemFmS1FMaXBTNnhWTFVubDlFeXFXODlxWDNvSW43akNpeHViS0h0?=
 =?utf-8?B?Wk8wTU5aNkJXK0hCemo3YndaenZJYnNybzZtU3crTXBlM0hYcytrMjlPcG53?=
 =?utf-8?B?Y2hpZ2VCbHVjb05YRk5IZFNMZTVFRS9IbXF4NldDdlI2NmJSQUFOUHhVYkdN?=
 =?utf-8?B?YldUNU02MURFbmhvUU0wSlFsTXFvNktsdkR6S052T0xLUDFrWkx2ZFJjMm9n?=
 =?utf-8?B?Z0k1RFF1dVBGbmhQMzdZYnNrdEgvelU2R1ZTTHN0NFB5TWdEVGttcjZiTjk3?=
 =?utf-8?Q?22XXKU5MyfZ5yChGSgB4hgTb7L8JgdWXbfTz8z4?=
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 07:50:34.5854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d437a41-0b13-4437-5ce1-08dc62a0e469
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7078

On 15-04-2024 17:24, Krzysztof Kozlowski wrote:
> On 15/04/2024 10:13, Mike Looijmans wrote:
>> Another technology to store energy is a (super)capacitor.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>> (no changes since v1)
>>
>>   Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml=
 b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> index 491488e7b970..a22c97dfad88 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
>> @@ -44,6 +44,7 @@ properties:
>>         - const: lithium-ion-polymer
>>         - const: lithium-ion-iron-phosphate
>>         - const: lithium-ion-manganese-oxide
>> +      - const: capacitor
> Please keep some sort of order... everyone insists on adding to the end
> of the lists...

Could make it alphabetical, but that requires re-ordering the existing=20
ones so "lithium" sorts before "nickel".

I think the intention here was that the order is the same as the=20
matching defines in power-supply.h


> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
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




