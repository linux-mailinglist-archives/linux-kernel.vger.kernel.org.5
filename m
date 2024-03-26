Return-Path: <linux-kernel+bounces-120002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867688CFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E81C667B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663B13D624;
	Tue, 26 Mar 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="2aziLsek";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Ik475x32"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2127.outbound.protection.outlook.com [40.107.7.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620313D2B6;
	Tue, 26 Mar 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.127
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488352; cv=fail; b=unGoPuVcxCCIAfyanKIm/j0EHOcU8hv302ulaKkfLZOz4M2f4EtSijkO4Uaetu3Q4ZZ9WU8vaq0ANEtYccrH1z/5dgsPPNln53UulTuyYPXfNXNrZtwtqFpjrKtVyhfVDWA20nwDThvo9z53lzIxfeTDU4oh2lLDP5GPIs/C2Fc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488352; c=relaxed/simple;
	bh=nkRAFhKipobv3juPAQj/coHwguwVLtjG6lQGGdwg+10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fDPYvSOmbUIP9muLJ8/wa42Lk7Zhb1nakii1v2a9/heOPP2xySP35+jUW6xIdxg0Zd+cDj4hyyzZxTq2S8B7E2dHlLxdlCitaBwlDCfhZUBzR5VkaVWwWE1XNqDewhx+DVzeh7T/0EV56O7iTEpNadbTzBsqRZ9OVdiMGA379Bw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=2aziLsek; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=Ik475x32 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.7.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=diWYDNj8y8s8ogErN3/Zhhyk6pW3m04z9uDPE1knDFtifYEDFUsraoxrVDbhr6beNosHta9FPkX8vsIrqjtBkdw12FpWIT4SFnwwwM/n5JuX/aXp9b4Ar+4EMVtn/6HM3UMgVuGh891BI2QsZcxkC+cAsiJ/NIk/YiqJXQK7Un/AYjlAmJNBMMR3T06b7jH3EYzUYmP3Nn9JYOjue1ZkIt5ZqMCCK/eSTWs6BmRCKGqS2nq+bqo1C3mgrimw6DlmA4w+lWR8mI2secWD2sawPWbgkHDUeSaVHfZaoOpzUDP4lFhIsay9De0iKAX9MABfP+wJGAkCs6/IRINupHexaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJKMOL6RASuwUV3tjcuqe9Dfor5BbUnn+CFsnYNKstA=;
 b=aISTMDfbxkvkaq4chdj4Rr2gWDdAhIZhYWQAIVJjddRD6/Jn0/PiHSNznD86taS0/K2vh8RSNxI1wttHnN1N81d/pdG6rS2GjJoGfrjtykFwGqWxep4bYdarptf0IAhg6NbiMbGU/9fwDTwOf2BSGvgW8o++aiARbPpgAAfPjuRJGe1GUL1wEEc0O2Iw1w4lzDSeWVbidolD0mSUhrT21E23icxmgHNR1jkm9BT8bqyfxbLiACS22+/tF/bRRr38crAJdxwc8MCdIazlyl4nMsCwouxaowzEF4yYE3sRL6JmVCpw7g/jwbOxxnzJJn6tTpQL4KHBv1UqNBN5GXdSZw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=kernel.org smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJKMOL6RASuwUV3tjcuqe9Dfor5BbUnn+CFsnYNKstA=;
 b=2aziLsekMuSZHvpKr1wYh4jG1FxZxtpFADvJBpMsRbVaUyQIkCgV/KWXecBjCvPujNZliwpVs1vp8EI0PP11/4/bbrIdptuGazQM9J7hu9979WR4QqNHYBQs7ucphQgKLrCAaRLoQZvd1XWryudoxSthyyFLqVA1em65jv9O0mvyubh9JrV3NkvHv0NmP7yBYRnJ4YoweTrJjVXeS4SN6CKYmFRVD1se0OMOVcml+rL2Y0m6n5Lo/xFmUE3tWDUY5e1O1JXtAQeLdd9hAb7GGTHh5ziqndiwqwZztG0DFmh4LSFRkUFp8UIF19+7d1DTix14Y50B2PEln4gSLPGDjQ==
Received: from DB7PR03CA0108.eurprd03.prod.outlook.com (2603:10a6:10:72::49)
 by AM7PR03MB6531.eurprd03.prod.outlook.com (2603:10a6:20b:1c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 21:25:44 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::aa) by DB7PR03CA0108.outlook.office365.com
 (2603:10a6:10:72::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 21:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7409.10 via
 Frontend Transport; Tue, 26 Mar 2024 21:25:44 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id C963520080096;
	Tue, 26 Mar 2024 21:25:43 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.105])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id E0E032008006E;
	Tue, 26 Mar 2024 21:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIbJgMEFAGplDPT8NLpPjpciDgxrZKA6DnHE9GnR3MebqVsFjoBk5pu24xdRhCI97iItK8xNjT4S1Sg9FgsiLVwQZkxJcaS3DZBGfuHWmrG6gzmcaO5aYcgmsn9vC1+rQbf9dZr66iVxodtgxvYmQbB36L9qqDo9Pgk9divemOTi3UlOUy+/+tBdSAg5xC2aPKHnRatXYFYxTJOfn9tm6Q/vS7Vu285q++ttXGriKMDGNL8q7aZFPe5l//LvUXLMDgtdQJqmTSMZJKMJqjt+4h7KCeu5vTl37SwKmrJ33rAsOffW5xli0wfz5Gr6HedEbZ3hRJHz1fdMWwHNp58zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMXnY6OKsKk/6Kfa9wOaSMHeZcPerqKWjrnbcBVCCj4=;
 b=S6Sk/a8wORM2yHjrPeSfkZR2qUfYo/gzf3+vGaGbRmzj8zCQIl2TpbiN/OnPdyapCmEcIO5FMwHu6A9bdsKdA9JyQjvWGatkR1o6vLW8Goiy4mxmkWRtAgbkyNqUOJg4ZUiXfp+TliHijH5ewAEvQxhbYrd/C/7zl9s0O4OYl/TbxrVQCbUc9kBcKgHaTamQE8xNFyC8sA7b8kJ5b3YShGHntviYuGaR2DsLITmoe+yueIIR6JqG3UZkWDAnP/HlbX8C6Mu8p0jsihdOWen8Sja6T1N8vs6tbKMxjjwU7F5vTvdpIbJQayTUq5iVJlA/tTuEfSbjKZ58wlqlKFgqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMXnY6OKsKk/6Kfa9wOaSMHeZcPerqKWjrnbcBVCCj4=;
 b=Ik475x32ojZmX53jFjJXBFWhhAF1XeP4dgb0ZQAvh9WdjHlTrvWF05hBW6mbsLhKEVHpsG0DEQspWJYpUax1ONoBuS1kaGc0JVBRfhf2/VORFQMDGEkDH2Uhj3DygG2sgv+6oJfaVlR3jozT8+sfiWYwonh06KZ++Pvs/8UllE0ARTJ7to+CyeAqL/w3bnYTH6Qo/2GslHSq6SC6dWZfaUFytfqMb5N8AuiaksSeuPYF/yr1ck3ab1lwfW5B++Io2WHpmOVSAoW2BTq81jS/FIW8zuDSqNsSRTK04H/S3MGcBgOsfN2xs8P7mQj0P2WVVPL+RTcGq1h7bXRCQV+arA==
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS8PR03MB7637.eurprd03.prod.outlook.com (2603:10a6:20b:345::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 21:25:36 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 21:25:36 +0000
Message-ID: <df50fd2e-bac4-4e58-98ba-4a7c3de538d5@seco.com>
Date: Tue, 26 Mar 2024 17:25:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 134/148] usb: phy: generic: Get the vbus supply
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: stable <stable@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
 <20240324235012.1356413-135-sashal@kernel.org>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240324235012.1356413-135-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AS8PR03MB7637:EE_|DU6PEPF0000A7DF:EE_|AM7PR03MB6531:EE_
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 CCDzocujdAogocGXrNF70+e0vCw3+oo0MjkJL2Anhv+DXp/BBOMbk+QbiRw7f/F1PUcmeqIG+7RSkO2khHg9/CvZyZl6QbWmYiPsXxg/5PKrmm+jt30ATGxYLUu8g4oSM5rMJ/vM1NOvYZGETPv+0QcpqyFK4UICkguDVZ85Lh1I/xHqZ8EeRTiocHCFm73C7UvyAeduEJUdev4gl2xn//4hhkYCwn/IlPRYCIOo1GlTa7tSjW1y0pR3YEiktgDEGQdA4Wk74KR1npx9k9i6y6giS0WxrC3d0/lacjs46giE1DFktw3OYSPW3eJlGf4/2hsz2jraby/bOih7HAdyNZ22K60131WK+nrXbcEqgWDRnXFSav0ztdgqLbU+E3NkHcGjPwv+Tr1JoIfGA1FP8zGmE5KpB4CA7tHoolykU6opI1agUQoYPXuW5QjJFDjqmsdeol7/Gl4SjNQ09qaFW5iFJqKZYreUCycnxRHi9BvWMbcDb7k6dX50at+dErw6SzJ2NZBbAn2cO5SUjf3OK/V0HYXjisnGpJCbzqmY+p0KNfBZxPsU/L97Blqwg7B62bEHdFhag04RkV8xj/J9SQv/+cd1+9pzwPMht9s9HtOtw+jGRACFtZi42Ph8kV+CkLgaMbwYbV0FNFh5w7Deint93sqyFNJEPlIM6ilb4B4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7637
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f17d371a-599f-41b8-3e40-08dc4ddb4bad
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wOpClJtWAYmCOWRNUHmmjih3mDT5hEc4qfqFxl0KrcTZ2HbVs1GeFhyQzJ6G7nywtQB5Yei2fmE0TIhmO7guXGYA213BVDuluv5yO5bacOpbcwcIYGvuCxvt9qrb1Azr8hlsoi64Jg53ENnJNDCmtLczKMmjsU99hhI0FJ2227B9zxM+KyQmDgBrnrCpkMiCn3Ri5Alx3RDYRMiPqnRv5X31xrwt9ChhAmMgKO0kyUL5e74e9iPXPzBLxaGje+7TOpX+BhtSM/6bmjGFsFsXgkBUIz8XxBeEeBGXT/rZOata9GcpoIlHNmkfXBubhILlzahc2scEobhU4szPSflSNkpagIAOGI/dG0WLDpjyVb7/e14oCPweN9DaAA1h0J/8VQkWGJcyRk6onLpi01sCFOtnvCzETs9KJ2PtshkaP4f8Utg0GugULg3q8MnxNCMWdEgcc6NjJbXVwjMDBchrPj9LM0Cc31zXW6o+FFxwHFtL0fxlLc4YZfPycCUIvxHrRLhi98xK9/n/BkHLh8EJdPza/gDPwqz4HEPadjlGGZlbaD8DCnmhvSSsxnpfOuGT53pTpV7nYXB2dRy4qkMuRaIKD6y6v1tWEiESfRvY8Ju0V/OVcewyY0MnCz86zrZE5cUKEgyLvD4NQpoq6rkjM9KuSYxeYJFMwdTANTm+EVHHwXWMwAub8DxPNFXxa7mGfTkAiKUpNcb7IrHMDD4SFA==
X-Forefront-Antispam-Report:
	CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 21:25:44.1807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17d371a-599f-41b8-3e40-08dc4ddb4bad
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6531

On 3/24/24 19:49, Sasha Levin wrote:
> From: Sean Anderson <sean.anderson@seco.com>
>
> [ Upstream commit 03e607cbb2931374db1825f371e9c7f28526d3f4 ]
>
> While support for working with a vbus was added, the regulator was never
> actually gotten (despite what was documented). Fix this by actually
> getting the supply from the device tree.
>
> Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Link: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query=
?url=3Dhttps%3a%2f%2flore.kernel.org%2fr%2f20220425171412.1188485%2d3%2dsea=
n.anderson%40seco.com&umid=3Dd6ce00f6-eb02-4c45-a2bb-d42fb98e3d79&auth=3Dd8=
07158c60b7d2502abde8a2fc01f40662980862-664a4cc6c56716c0ff040724728033a1bce8=
7ec7
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/phy/phy-generic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.=
c
> index a53b89be53248..8a04b157f19f3 100644
> --- a/drivers/usb/phy/phy-generic.c
> +++ b/drivers/usb/phy/phy-generic.c
> @@ -283,6 +283,13 @@ int usb_phy_gen_create_phy(struct device *dev, struc=
t usb_phy_generic *nop,
>                       return -EPROBE_DEFER;
>       }
>
> +     nop->vbus_draw =3D devm_regulator_get_exclusive(dev, "vbus");
> +     if (PTR_ERR(nop->vbus_draw) =3D=3D -ENODEV)
> +             nop->vbus_draw =3D NULL;
> +     if (IS_ERR(nop->vbus_draw))
> +             return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
> +                                  "could not get vbus regulator\n");
> +
>       nop->dev                =3D dev;
>       nop->phy.dev            =3D nop->dev;
>       nop->phy.label          =3D "nop-xceiv";

TBH I would rather not backport this if possible. This will increase the
chance of someone using this behavior which is going to change in
562898808cb1 ("usb: phy: generic: Implement otg->set_vbus").

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

