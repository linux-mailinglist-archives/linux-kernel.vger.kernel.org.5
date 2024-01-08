Return-Path: <linux-kernel+bounces-20139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6254827A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10FA1C22E38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757256461;
	Mon,  8 Jan 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="G7k2ZBqS";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="G7k2ZBqS"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34912B6B;
	Mon,  8 Jan 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=E7rnx4Uhqcif/09HB6BrWLw4sSrDQ0dbmXyTWkp44HpfmuUij1iwIS8+3pAVhiD3FPyJPFUAL5HJS3oh1TbOPeXmat1aWkm3Y79R73pw2FGH/fE9HXBI3JOinvPw+LH12T5wajd72fJt3GAVuNnHae5T7HReA01F/kq0LPMk3aZu6kvBs6aJ3Cp2p/GAeFR/jRNJpshF7IbfNaGK8FFbMCJcsuaKeVncqUN9tmnBs4EMI5WRXTpBqmV+ookgq+4dVQsLzVy6J8Ra0NrDkqqx9xF9n31sXljqJQ+hpeE+oC7uO8oxWmFDf6Qm5Fr1JO5lzCPE3Sn66/scAscFMZdLxA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYnMLReIpQ8/eeHbUiWDOagmkFsywJiGN6E6hcWujEA=;
 b=l0pLcUTvi/W2R6Aazgijzl2lZHtKqCezWX7sJwMFuslGqxh4J01jjHqMDk+ky8b09tKqhCi15wTRAwYPeQ6TWcHFnxAu5+JPuPSYGdS/q5JzSBJchyqJen8hOe+W/UfXRTZH61GO/xXrcNhBBfjToZYeGml9XxOmZ0ZojxlOQF5iAAqEF91nHD+9BQUoZGOKln3PXCALiSE293gByKKY9GQWql+zp1HJme5kuhnzUWoWBjY2N1cuASo23bL+rTUFjHvRsZO2EGxkK/H14un9F8Z3nLQZgMuHLASzz/yicsYL/5yi5Uw0J9CDwyrqeMi8XU5dnyuzGrLFDSGlvPYBjg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=bootlin.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYnMLReIpQ8/eeHbUiWDOagmkFsywJiGN6E6hcWujEA=;
 b=G7k2ZBqScSoO1LDlVTTjXXK3yaqhhO1F/uk5dv2gREkAn/5/VH0S9WuHeqL4a6bs9ssgtNlcyjRio0hgJCQeOUxKhOTr9dGHiQ/wcgNmQ3HJAOL5WdWbNHSln4iD+G9u9z47GQ8NVYmAPQjKVWc4rBln0o+i89nS/XnZ+ALrtISHkG+K85j0PjsGPtY9E3cyP0jA2PWqGTXy7x9MplK6+LGcOD2Kr/1nnPiordMqSgS0010qEZfodjwoCi7+rHPRHsFQcJIedQP1lr8dd0ZUeeAyLbzm4OW09zcFYGffRRNsMI3GKAU0bQoGvzkhFeWZze0XpIRQ6DF56GgqJcxU6g==
Received: from FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:99::7) by
 PAXPR03MB7729.eurprd03.prod.outlook.com (2603:10a6:102:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 22:05:55 +0000
Received: from VI1EUR05FT007.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:99:cafe::fa) by FR2P281CA0165.outlook.office365.com
 (2603:10a6:d10:99::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 22:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 VI1EUR05FT007.mail.protection.outlook.com (10.233.242.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.32 via Frontend Transport; Mon, 8 Jan 2024 22:05:54 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 6B8882008009D;
	Mon,  8 Jan 2024 22:05:54 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (unknown [104.47.14.50])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id A2AB62008006F;
	Mon,  8 Jan 2024 22:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaplvNWlKVC4dc82ZT9bhMCzahMy5X3BFWTOWg4K5wAq9i9w5ssvZaQ40DXOiAN/xo7TCUccTP5uSoO4LE4bonyX5J9DEDqUdj0q/+HA6Vs9k3YHnQYvyZh4pnLzG5J2cVtQLLxsBhPzyPlCFl2ptsmCfSSGa3WscaKyAlFyrpFK3rTv4DKbwK0L1v9hhWSj48O8IQkdbIT9NHJYpVTIoCLUstM5grmGZV1w2BJUX30ve/puegJoFZJDyqSFLMZoOeqBD28IeMIF1lxkO1F5ycSF4b6yMuVmJQ/euAwOO6N6FVBkfmKA4ZIBpyAsPTuPqiAadgaoHSNf7r1J9ElomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYnMLReIpQ8/eeHbUiWDOagmkFsywJiGN6E6hcWujEA=;
 b=YOZiufFtRfxmRbLVWeqeDGTTrZMJesjMkjdzMHmgIhj97wKasCt3G2qg/TFKwkCmR+JqhRXiOprdjUBcgGL1yvuveqNgIZ0y1L9WYKKgo6IGM3OQL6iuxXI4AdvN0yvFPxYWM8J6uFtd3cxRl2pQv+GMKvbhaJJZ5RA2EItguguCQkDPPuonQSLxHkNkcyE10463M1m3FGjIFJp8oxgYQDuVmKxCXP4Hm6SwpxOth+X6JEkXMRdTrp1xKwNrh8H3VOsq/BaK3ETcpTdul+o+8OHXS9iEet57QJCeCOqzy6UAa9lEOp8mrlSA0x4k1qX4PDGL7NyePtrBAXoMENwZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYnMLReIpQ8/eeHbUiWDOagmkFsywJiGN6E6hcWujEA=;
 b=G7k2ZBqScSoO1LDlVTTjXXK3yaqhhO1F/uk5dv2gREkAn/5/VH0S9WuHeqL4a6bs9ssgtNlcyjRio0hgJCQeOUxKhOTr9dGHiQ/wcgNmQ3HJAOL5WdWbNHSln4iD+G9u9z47GQ8NVYmAPQjKVWc4rBln0o+i89nS/XnZ+ALrtISHkG+K85j0PjsGPtY9E3cyP0jA2PWqGTXy7x9MplK6+LGcOD2Kr/1nnPiordMqSgS0010qEZfodjwoCi7+rHPRHsFQcJIedQP1lr8dd0ZUeeAyLbzm4OW09zcFYGffRRNsMI3GKAU0bQoGvzkhFeWZze0XpIRQ6DF56GgqJcxU6g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7631.eurprd03.prod.outlook.com (2603:10a6:20b:412::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Mon, 8 Jan
 2024 22:05:50 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:05:50 +0000
Message-ID: <ff40a221-38b5-40d7-a0fc-cf617853a096@seco.com>
Date: Mon, 8 Jan 2024 17:05:47 -0500
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
In-Reply-To: <c3cda013-eab0-46c0-a89a-ed51ecfd1e1d@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0029.namprd22.prod.outlook.com
 (2603:10b6:208:238::34) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AM9PR03MB7631:EE_|VI1EUR05FT007:EE_|PAXPR03MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: e6587377-1185-4528-fdae-08dc1095fc53
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 X0TerTqr+njOZEwVLAJ1DkFsiGwewuGrt70mFOEiVnYNBL6xpftlrj84D0tT/eQgzNip6qCT+G33e+9pSUpls62Dg4h9cFYaeMq0cSOODjKZJPepHjbloBbWWX0IBJOrOG6L4+wZTlSizJIkAatCMkaovkBcfqwxk3KKthvfUcqNcxGuLRuZZMIdmKOiEHbwy1H5Tv4IgDsCSQ/gYG4eznOge8hDNhx3b+I5QJdbR3xnLrD00qYo9zFYfw4OxShEEqNGHR2ZNMMhirOJQwuCVnfqmjO7VkvXrnS97+4CCh+tgLzA72Cl4GiB24bb1TN2m8fptcdfFq3nniEW+9WR5kTGPvOwqzR+YxuQnGolIoD50eBe6pUQ0p57gK76JOZrGGYT/Y+1rw8S6v2a7UTxBXLyKt+D2ui2zbY5SCxY2J7kF4g0KwVgESOSiMzQ9AeyNsFnyVw9a0nZq+yQS+iy3EASnt/aaueK00kcA6AevIfPAAnLo161pAtYOo3pv77QTkSPB797DDBlaVUNZ2+qbyxKaSTCyXeQiobiBxBzqfDOOxyk8pvH+vdd/Ty2gh2gPZYtO+s0iVhOp7L19YGp/OLjv8ox6jm9SM4ss4CXrn5NFdTe97nU3RSXoTa8MDulnlwwKLF9p8Aj38ByJBoMzr6SZwXFpxSZ1+HifTbq3QHz/iZLNJX7iO0Uhdw66+IwDbOMRkFWJPNJDLpTiCnlO2hsg2jgiB14BT1tDRb0PZNxl2wXNVn/JZDfBuEkpWvetQU0DHa/BzVLLMYyWCEK2A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39850400004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(38350700005)(36756003)(86362001)(31686004)(31696002)(6512007)(6666004)(6506007)(52116002)(53546011)(110136005)(316002)(6486002)(4326008)(478600001)(66476007)(26005)(83380400001)(66946007)(66556008)(2616005)(8676002)(8936002)(41300700001)(2906002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7631
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT007.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	721d1231-fa41-4aee-8ef1-08dc1095f969
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TCdH5RQ+ptRbB7Gs9H8fUPeSUpfcftuCPTLXkT2SpLCw4OQoYmI06xDPzbUlUX+rbFK/SiEveVTcMKEZlBjXQEpbEaE9ULn6r5SO6Fnei0CMSRdpsZQj+HlNKSJPIH4svQwxZg1v5IyXwgyJR90cicIzbBLPwKfaMBh42gk4fg7BD3JorEboOAIgQg5gun67HJvbmCVh5RkVsDOMfckjzDpo+qN1g9FONpFckaIkeg8CQ+0+6ubYTBIXRd+HZkUM3UPZ4ehOsXpQE0j7Bnm9fCnpxHhY5H42schO8qVM87etY5IGvx1T79gVBbw8y4sTP5VKR3DULI8bbLxqjoQMLr/ogA/JyQFu609mDn2LeKmGvLx1fAnHpObF64orO0MZt1I4uTy2xOkbPig7FCUSfzlpOoNKX3XStXaH4hM3Lt5p3nPmjsHYwtalEvqD5USOBQRPFzzSvCEy+d3nBnRzdE9QjiY/CBQuazlw4AVam+WPs/4CScWERBJgJs7hvMDjXmjpLU/1nLGV3Qwt4iNnp8JekJ/trB4+LQdugBiR1xsiWQB/GuCVt9+Zh+F7AS433ntB9iJ7DWq/bWejt7si85bxw7W0SAGDS3qPuksGB3EK7dlC9yQ5uyaNK1/Z+riaXjcT6sIa1WivJvc31uO/5k8dUZ0mpQDwxvJVu4oh0Bw0lzN/iNOrYMi1Wu4ZV7lE0IWsu1BNUUBxMRKAgO/aw3OZMFO4q2D0Grg3e0oT0ZJXtT9bxP40ar2v201D2LnEVk/vZKuqrDPLgK3kIem0B/dmlcUrEI2272azWwFkyyO9HsYx4YXtEgkpmnU3IbdGoYVbyJ5NI4P4bFI1/lVBztszNWmvBlf6Ym/sAT84evA=
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(136003)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(356005)(41300700001)(7636003)(7596003)(86362001)(34020700004)(8676002)(8936002)(6486002)(40480700001)(40460700003)(31686004)(31696002)(2906002)(5660300002)(82740400003)(110136005)(36756003)(336012)(70206006)(26005)(316002)(2616005)(70586007)(36860700001)(6512007)(6506007)(83380400001)(47076005)(478600001)(6666004)(53546011)(44832011)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:05:54.8520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6587377-1185-4528-fdae-08dc1095fc53
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT007.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7729

On 12/11/23 11:03, Sean Anderson wrote:
> On 10/19/23 12:39, Sean Anderson wrote:
>> According to the datasheet, the "oscillator failure" bit is set
>> 
>>> ...on a power on reset, when both the system and battery voltages have
>>> dropped below acceptable levels. It is also set if an Oscillator Failure
>>> occurs....
>> 
>> From testing, this bit is also set if a software reset is initiated.
>> 
>> This bit has a confusing name; it really tells us whether the time data
>> is valid. We clear it when writing the time. If it is still set, that
>> means there is a persistent issue (such as an oscillator failure),
>> instead of a transient one (such as power loss).
>> 
>> Because there are several other reasons which might cause this bit
>> to be set (including booting for the first time or a battery failure),
>> do not warn about oscillator failures willy-nilly. This may cause system
>> integrators to waste time looking into the wrong line of investigation.
>> 
>> We continue printing a message about invalid time data or an oscillator
>> failure. There is no voltimeter in this RTC, so this is the best
>> indication that the battery is dead (or dying) and reeds replacement.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> Note that the following drivers all warn when they detect a problem with
>> the oscillator:
>> 
>> drivers/rtc/rtc-ds1672.c
>> drivers/rtc/rtc-pcf*.c
>> drivers/rtc/rtc-rs5c*.c
>> drivers/rtc/rtc-sc27xx.c
>> 
>> So warning about such an error has good precedent.
>> 
>> Changes in v3:
>> - Use info since this is a good indication of a battery failure
>> 
>> Changes in v2:
>> - Use debug instead of info in the typical case (no battery)
>> 
>>  drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
>> index fde2b8054c2e..f463a58a240b 100644
>> --- a/drivers/rtc/rtc-abx80x.c
>> +++ b/drivers/rtc/rtc-abx80x.c
>> @@ -127,6 +127,7 @@ struct abx80x_priv {
>>  	struct rtc_device *rtc;
>>  	struct i2c_client *client;
>>  	struct watchdog_device wdog;
>> +	bool wrote_time;
>>  };
>>  
>>  static int abx80x_write_config_key(struct i2c_client *client, u8 key)
>> @@ -179,6 +180,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
>>  static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>  	unsigned char buf[8];
>>  	int err, flags, rc_mode = 0;
>>  
>> @@ -193,7 +195,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  			return flags;
>>  
>>  		if (flags & ABX8XX_OSS_OF) {
>> -			dev_err(dev, "Oscillator failure, data is invalid.\n");
>> +			/*
>> +			 * The OF bit can be set either because of a reset
>> +			 * (PoR/Software reset) or because of an oscillator
>> +			 * failure. Effectively, it indicates that the stored
>> +			 * time is invalid. When we write the time, we clear
>> +			 * this bit. If it stays set, then this indicates an
>> +			 * oscillator failure.
>> +			 */
>> +			if (priv->wrote_time)
>> +				dev_err(dev, "Oscillator failure\n");
>> +			else
>> +				dev_info(dev, "Time data invalid\n");
>>  			return -EINVAL;
>>  		}
>>  	}
>> @@ -219,6 +232,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>  	unsigned char buf[8];
>>  	int err, flags;
>>  
>> @@ -252,6 +266,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>  		dev_err(&client->dev, "Unable to write oscillator status register\n");
>>  		return err;
>>  	}
>> +	priv->wrote_time = true;
>>  
>>  	return 0;
>>  }
> 
> ping?

ping again?

