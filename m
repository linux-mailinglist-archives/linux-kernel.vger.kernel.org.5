Return-Path: <linux-kernel+bounces-142077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F988A2725
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5F5B24B49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4374652F;
	Fri, 12 Apr 2024 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="qVTIyCDf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="WZytqSly"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07809328A0;
	Fri, 12 Apr 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904851; cv=fail; b=OuEkLwVGhm75BOCOk/uxG5xdnRweGjo/KRUQTJgHq2kQBexzcEfF24KCGPKWz7qZAPRkg7mH8RblYjNHCYiC4v9Y7xmp8jmPDKulT42BML82lLZuhd+Ll5Dnlse849dQC2uDLwacwCCBjtOVpekDv9HookdzSZ55WAeidBd55UE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904851; c=relaxed/simple;
	bh=LcdGjeWuIFoerGd29v3Q/2X5XLhIHXODsLEsZPgLxpg=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCUd3dNTWKI8x612uJOX9ufu0ztTEO2Qq4G0LVCH6f6VmJAJzDoQw/VrtNalHf7g2+jn0mGzsE4DUw7XbRN9QhjBxuKmfjzml0m889gZAK7B76EbGvglBmwJ4TDIa6EcNECoTx1PzpBkVhYDZEDLilrEV1a6vLNI8TTHju+uqrY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=qVTIyCDf; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=WZytqSly reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=MMz958H0rnf77KGoV0IEVXBUakhTC8VFhmRXFlsne/xHD5k+/912jMyO/i/cek9MMInC1pnmpITTnR+e4V0rIukOjwcGwHl3cepwlMjrednEBYpJAE5nvBZR0sCy9EkDYit/LpAB9z4669LoQCVuG8Hh1nicADGIs2re5JZTN44EtIBpr2IDOhGljcso6Huq2qlNgfWrkwNZAUdKqkBthCROawWisTZfc8j/AkbR+pBw+ZittWJkp3qQCT0c0xqRxlJNIJbdaKYQuYL+m4/pbxrNsdDlqwpWVND0E3veWM7keHki8UfNiS1STIFUriG8Bsaq4WPaaCsewDYVNRN0Yg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHc0VKVFOn6Tx33bQH4uBSsmO4ITcwKnzQhFwqyxqXQ=;
 b=ABb/2px59nHtncFCdIR8uOjhJfX3+EE7IbCFfGgGnlZwI2vFmrZfkr+qHHbzqJDhFxAtLdfMyyvc64YmytA9uBaJvmNHVEghm8ihMiAiFYc3Lo9xSoUjSX9XWgV9e/xD8XYX6WQiBsa4fgwgDdE+gNeq18L0JfvKqhk/5ZIl7lXk6iykjs+EtaLeaR/IZhGLdHpNZLP08jDnJwpe1iA3Q0l9ZgQ7GujK/B/jymySnXeilqejsQjMhkd5RrYVPV2IPgTLBxRUf7O6ZO+ANNDz98FBHWvDC5lhdE/IejUSb/txc8xA+oqFzkDcBKuZyljRiA9y1IUl5TcCuHxKIncCKQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=collabora.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHc0VKVFOn6Tx33bQH4uBSsmO4ITcwKnzQhFwqyxqXQ=;
 b=qVTIyCDfgjljRK4h9nOAWljyz64q4JebLSbq3XJyiuUNK5fnejXKWfdz4Zwv7SZ4KXcizvrBkbmLaISt9nQICfd1+4ygEi8u1awFneLG3x8WeDBSnFfccJ0F5Wla+XLVoYPdh2vUH5gMwKMxDpZQDRItQo7ngnaRScyex/W2j17OCad6FZmf3bpy5YOsBXeZQdskN+3wpQH36DIsq5wGgYE0HDftZMaW48/Bf5GAwcfVWmnuqrxepRX0+ZUDUD5f+x6MNMgBA3unWrIi+tGrOkG+MTdG/CpTtwl50c4cVdM7Eqz1nV9EB6z0KNMS8hwdBLz0QLf7PRn0CNrsZUfxtw==
Received: from DUZPR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::16) by AS4PR04MB9314.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 06:54:03 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::3a) by DUZPR01CA0009.outlook.office365.com
 (2603:10a6:10:3c3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 06:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 06:54:02 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.168) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 12 Apr 2024 06:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGdyR0y7e9TkRTKmI1NFsCf9Q7flsxKsmryCjR8mN8plBa1L3DLENE3LsCxBLEu8oA2UHtJjSsO1qv4aeGi6knvZmnIBZ58dhQjsjPw7LQfSJ7amZjZpCEx8dgRtxequ0OJ+mITsEUXV6DyejTpX8tJrJv2Fm8kuCTYpNIYXrvzPAOKeSmalb0O6yEIPaqvQcv93LEjuITwYizhlclDj2IKm2NPY+0iVsrYYfFVoYwR6JQtxYjCbyZ9BZOQs+QWW1MKPlRTdqtXLzezPgophQpAdw7+2p6cnpHARQgNydjtVa0NXWbE47shIB5nY1sjGiwYTJ6lF8wI+7Yrb/AMQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+/WJ9KhVAOW+cUtjJCd6r88LPnj/wX9jClY22EPn9c=;
 b=Yf5gSDqUsFwIa6vs162fZjei7fMIVvC7L/k6XBvaVBE8I/3Ed1Ec1dEMSeEFM5a8DDK7TjpfR7Qulhl+GLDlOepjscbWtzYL0LDwhiDM5mX8TYbvsUO8xR20eNQETVOMGY4I/9yGjdaTD88NHMPT6Ncdems8FLzJlicrR7dTnS/3VJX23WiIGLcXqIcn7qpmU9z9GVFOhE3uuCpZ0HalbawMYpbJ39fLBOklMcjiY6c7GMgOcSNMfiuQZjDEYyfkbDHYkEIJFCxa1xQ1b/YM9x44hvZwQ7XHkyECR1ALVd3w7J3aYcIcHGD9t3UUA+UKz/+BVreO1MLXeXqPqRKsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+/WJ9KhVAOW+cUtjJCd6r88LPnj/wX9jClY22EPn9c=;
 b=WZytqSlybHvBFnWlRK8ac+CMN6oKZv8vSif7esx6lFJZqD6L2geDnwNygtR15OBPnm63GTP04BWi8euiugY7anMfJTrSI10l2TRv8WMB/VlHR33rrRm3lJO+qm/57DT1Z4z0j2SAJA56/2gLzpuwxmjpfXapJgvvryZ0k5N0SC/FiPWhKJolQK8AVr4vwMrGrk5Qwqx+6sEn2JFKZR4/wopCyKFtSnUrdMDZ554JWrpBQKkqaT/4Fv/TfGWivUiYhNXjwkZf/jXwzbpxvtJH6vmU7RZQIwmLkBIY0tjr01kbbNI8wiQ/FuzBtXZ3Jb6CRmzQJdKPj+O4+eEq7Ic5Sg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM9PR04MB8307.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 06:53:59 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:53:59 +0000
Message-ID: <efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl>
Date: Fri, 12 Apr 2024 08:53:58 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] power: supply: ltc3350-charger: Add driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409135442.37732-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dab85cfc-973d-4930-8fea-324aa26b5801@emailsignatures365.codetwo.com>
 <20240409135442.37732-2-mike.looijmans@topic.nl>
 <5hpl2kspf667hmmxgg36ahiux5rs364qzrg2itpljspspa47vp@dsbnhdnq5s54>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <5hpl2kspf667hmmxgg36ahiux5rs364qzrg2itpljspspa47vp@dsbnhdnq5s54>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::28) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM9PR04MB8307:EE_|DB5PEPF00014B9A:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3d7cf1-4732-4a2e-5113-08dc5abd5667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 5K5HiO+t5OYRGYuhXTOiNtMOY6a3hdp0dINaG2l0uVXlArT4HHB0GWu9p7u6SnSuEkg4MF0asPoX+3/RT+7EkaiiLMxJ2IHM+95Bsvd4en7up2qho/bhC6AVqEPj33ST8O1jfw/jXLj9ddjOUa/dtTbEcAy0YWqhaEQPWsVypufjCTzm90zosyTMlOlbjFN902+UTrqJ7hy7pSfyP8n4vV24PMOY8KdbHQFbOzUCcmejr0YOT32om/nhMMxJR+4Ilz4q33N2YQ58FVDcsNPcOywUAUzAXyYI7zJNdI3dzwiNS/LXT9fh+Y+m48A8yjI2GahHvUvZvVV5T9CYaAgQFZ9nq4bQrbQY9w5X1HZdGjiI+D0ZJloRhenO5/Sk8tuIe70CQ4uiDLJcv2joDWcNACF9HImjOjyniJPCQrRbKpUEzcXATMXjH83BOwAYOVLWX9Xc/7XJ7BYXuUi4RiUOtggZr2Rdp3NyoHixLzyovKu8oCigjATDRC+2ZqQo9bXFvpNvaigRSwo6eaM3LPvsvhfIDyTFoLAUClwtMksb7BZ5Q6NDrc30Y+DQXKTw34Z1Xywj70eQwzkI7usq8Zuqjo+s1En1Y8RpSXGhZi7lDkbnD/8off+TiURtZ5/XeObAltGmXcM23t/04TFEcnJF3RBM2Dr4zOGXhKaFFqz8fqM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8307
X-CodeTwo-MessageID: d075fb59-b4db-4e73-95b6-25d85139c2b1.20240412065401@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fcfc3631-77cf-425f-e5ea-08dc5abd5429
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7TvieX3ktSCC4MZtM4yAsGkl+P044bHU2cWVCYE5pfGJcQLMA8bMIyXhQwY8YcwJngkG6LAExJ0kmcSw7gsnqqpqR7nmjptHM47Hdya9dRVyQDlhbBbhNfOeI3lucGv8/HuxrV+5dB+WqcG1A6iHaHudEYrb6lUvRz0jBFCPUfeVYXwZL+XTptN135qHSQKjx3P4mKD+gbbFQl3aSSPZ3Fv6A/HYxEoNgLlVBloy2UD3hotzQnEFjLlF/1VPRBY3DoSp9Oe6xq7XDaoAHE/w9EkowmFtoUfPsuqAOFO6ZvOAVcxxTtWPjMkk+PCwQhPSIVeVUFCJBmTN+O6QxMVDuAZCpRWsJ532xCi0dPdXQ00/VbMnTcUuvMhwY+VTsWQqWrceNZ5fy8FDB4RIsMs7HDtr1mSY9WA1IROX2cX6d1chkiJFB9n9Hq0vECfMhlfRnLAIl85ZaX0f/99H/DWHm03xcqsvAMOtZV88iIu6xK4bPclH+IUOU4LBBuMGrtvBrW5q3awV5Pr7YZAGB+lmeQYJKb2a0jPuVzVSIILgkl60Ftju9ohhWEzFQxPveR6Vth6E145DTotH6cLj9czY1h8YAJrQsVbM80zeJV0Fc7ilwOOwQaoKz9h5tIAgV2iwuYs56hJfpvtc8Ds9jbCvIJPN3B8qT6PoHdUQY3HQL0BW1CkZdHRQsDWEz4/4S7qkL1JlYlVqF4zQ+9hacYwiHw==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 06:54:02.3291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3d7cf1-4732-4a2e-5113-08dc5abd5667
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314

Assume "yes, will do" to any feedback I've skipped.

On 10-04-2024 09:56, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Apr 09, 2024 at 03:54:41PM +0200, Mike Looijmans wrote:
>> The LTC3350 is a backup power controller that can charge and monitor
>> a series stack of one to four supercapacitors.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
> please share output of
> ./tools/testing/selftests/power_supply/test_power_supply_properties.sh
> below the fold with your next submission. It's useful for verifying,
> that you got the unit scaling correct for the standard properties :)

Will do. Did a quick run on the driver as it is now, that yields the=20
following output:

(Any thoughts on the "arithmetic syntax error" messages?)

# ./test_power_supply_properties.sh
TAP version 13
/test_power_supply_properties.sh: line 26: arithmetic syntax error
1..
# Testing device ltc3350
ok 1 ltc3350.exists
ok 2 ltc3350.uevent.NAME
ok 3 ltc3350.sysfs.type
ok 4 ltc3350.uevent.TYPE
ok 5 ltc3350.sysfs.usb_type # SKIP
# Reported: '1' ()
ok 6 ltc3350.sysfs.online
ok 7 ltc3350.sysfs.present # SKIP
# Reported: 'Full'
ok 8 ltc3350.sysfs.status
ok 9 ltc3350.sysfs.capacity # SKIP
ok 10 ltc3350.sysfs.capacity_level # SKIP
ok 11 ltc3350.sysfs.model_name # SKIP
ok 12 ltc3350.sysfs.manufacturer # SKIP
ok 13 ltc3350.sysfs.serial_number # SKIP
ok 14 ltc3350.sysfs.technology # SKIP
ok 15 ltc3350.sysfs.cycle_count # SKIP
ok 16 ltc3350.sysfs.scope # SKIP
# Reported: '3200000' uA (3200 mA)
ok 17 ltc3350.sysfs.input_current_limit
ok 18 ltc3350.sysfs.input_voltage_limit # SKIP
# Reported: '23828220' uV (23.8282 V)
ok 19 ltc3350.sysfs.voltage_now
ok 20 ltc3350.sysfs.voltage_min # SKIP
ok 21 ltc3350.sysfs.voltage_max # SKIP
ok 22 ltc3350.sysfs.voltage_min_design # SKIP
ok 23 ltc3350.sysfs.voltage_max_design # SKIP
# Reported: '711600' uA (711.6 mA)
ok 24 ltc3350.sysfs.current_now
ok 25 ltc3350.sysfs.current_max # SKIP
ok 26 ltc3350.sysfs.charge_now # SKIP
ok 27 ltc3350.sysfs.charge_full # SKIP
ok 28 ltc3350.sysfs.charge_full_design # SKIP
ok 29 ltc3350.sysfs.power_now # SKIP
ok 30 ltc3350.sysfs.energy_now # SKIP
ok 31 ltc3350.sysfs.energy_full # SKIP
ok 32 ltc3350.sysfs.energy_full_design # SKIP
ok 33 ltc3350.sysfs.energy_full_design # SKIP
# Totals: pass:9 fail:0 xfail:0 xpass:0 skip:24 error:0
/test_power_supply_properties.sh: line 102: arithmetic syntax error

>> (no changes since v2)
>>
>> Changes in v2:
>> Duplicate "vin_ov" and "vin_uv" attributes
>>
>>   drivers/power/supply/Kconfig           |  10 +
>>   drivers/power/supply/Makefile          |   1 +
>>   drivers/power/supply/ltc3350-charger.c | 718 +++++++++++++++++++++++++
>>   3 files changed, 729 insertions(+)
>>   create mode 100644 drivers/power/supply/ltc3350-charger.c
>>
>> +/* Custom properties */
>> +
>> +static ssize_t ltc3350_attr_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf,
>> +				 unsigned int reg, unsigned int scale)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, reg, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval *=3D scale; /* Scale is in 10 =CE=BCV units */
> please keep custom uAPI consistent with the general uAPI and use =C2=B5V.

I'll amend the comment to clarify that this is about the scale factor=20
passed into this method. This prevents overflow while keeping all=20
calculations in 32 bits.


>
>> +	regval /=3D 10;
>> +
>> +	return sprintf(buf, "%u\n", regval);
>> +}
>> +
>> +static ssize_t ltc3350_attr_store(struct device *dev, struct device_att=
ribute *attr,
>> +				  const char *buf, size_t count,
>> +				  unsigned int reg, unsigned int scale)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
>> +	unsigned long val;
>> +	int ret;
>> +
>> +	ret =3D kstrtoul(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val *=3D 10;
>> +	val =3D DIV_ROUND_CLOSEST(val, scale); /* Scale is in 10 =CE=BCV units=
 */
> obviously also applied to writing.
>
>> +
>> +	ret =3D regmap_write(info->regmap, reg, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* When writing to one of the LVL registers, update the alarm mask */
>> +	if (reg >=3D LTC3350_REG_CAP_UV_LVL && reg <=3D LTC3350_REG_CAP_LO_LVL=
)
>> +		ltc3350_enable_alarm(info, reg);
>> +
>> +	return count;
>> +}
>> +
>> +#define LTC3350_DEVICE_ATTR_RO(_name, _reg, _scale)				\
>> +static ssize_t _name##_show(struct device *dev, struct device_attribute=
 *attr,	\
>> +			    char *buf)						\
>> +{										\
>> +	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
>> +}										\
>> +static DEVICE_ATTR_RO(_name)
>> +
>> +#define LTC3350_DEVICE_ATTR_RW(_name, _reg, _scale)				\
>> +static ssize_t _name##_show(struct device *dev, struct device_attribute=
 *attr,	\
>> +			    char *buf)						\
>> +{										\
>> +	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
>> +}										\
>> +static ssize_t _name##_store(struct device *dev, struct device_attribut=
e *attr, \
>> +			     const char *buf, size_t count)			\
>> +{										\
>> +	return ltc3350_attr_store(dev, attr, buf, count, _reg, _scale);		\
>> +}										\
>> +static DEVICE_ATTR_RW(_name)
>> +
>> +/* Shunt voltage, 183.5=CE=BCV per LSB */
>> +LTC3350_DEVICE_ATTR_RW(vshunt, LTC3350_REG_VSHUNT, 1835);
>> +
>> +/* Single capacitor voltages, 183.5=CE=BCV per LSB */
>> +LTC3350_DEVICE_ATTR_RO(vcap1, LTC3350_REG_MEAS_VCAP1, 1835);
>> +LTC3350_DEVICE_ATTR_RO(vcap2, LTC3350_REG_MEAS_VCAP2, 1835);
>> +LTC3350_DEVICE_ATTR_RO(vcap3, LTC3350_REG_MEAS_VCAP3, 1835);
>> +LTC3350_DEVICE_ATTR_RO(vcap4, LTC3350_REG_MEAS_VCAP4, 1835);
>> +LTC3350_DEVICE_ATTR_RW(cap_uv, LTC3350_REG_CAP_UV_LVL, 1835);
>> +LTC3350_DEVICE_ATTR_RW(cap_ov, LTC3350_REG_CAP_OV_LVL, 1835);
>> +
>> +/* General purpose input, 183.5=CE=BCV per LSB */
>> +LTC3350_DEVICE_ATTR_RO(gpi, LTC3350_REG_MEAS_GPI, 1835);
>> +LTC3350_DEVICE_ATTR_RW(gpi_uv, LTC3350_REG_GPI_UV_LVL, 1835);
>> +LTC3350_DEVICE_ATTR_RW(gpi_ov, LTC3350_REG_GPI_OV_LVL, 1835);
>> +
>> +/* Input voltage, 2.21mV per LSB */
>> +LTC3350_DEVICE_ATTR_RO(vin, LTC3350_REG_MEAS_VIN, 22100);
>> +LTC3350_DEVICE_ATTR_RW(vin_uv, LTC3350_REG_VIN_UV_LVL, 22100);
>> +LTC3350_DEVICE_ATTR_RW(vin_ov, LTC3350_REG_VIN_OV_LVL, 22100);
>> +
>> +/* Capacitor stack voltage, 1.476 mV per LSB */
>> +LTC3350_DEVICE_ATTR_RO(vcap, LTC3350_REG_MEAS_VCAP, 14760);
>> +LTC3350_DEVICE_ATTR_RW(vcap_uv, LTC3350_REG_VCAP_UV_LVL, 14760);
>> +LTC3350_DEVICE_ATTR_RW(vcap_ov, LTC3350_REG_VCAP_OV_LVL, 14760);
> I suppose it would be sensible to expose this as a second
> power_supply device of type battery with ltc3350_config.supplied_to
> set to this second power_supply device.
>
> Then you can map
>
> LTC3350_REG_MEAS_VCAP -> VOLTAGE_NOW
> LTC3350_REG_VCAP_UV_LVL -> VOLTAGE_MIN
> LTC3350_REG_VCAP_OV_LVL -> VOLTAGE_MAX
> LTC3350_REG_VSHUNT -> CURRENT_NOW
> TECHNOLOGY =3D POWER_SUPPLY_TECHNOLOGY_CAPACITOR (new)

Makes sense.

Should I create a separate patch that adds the new properties?


> Also the single capacitor voltages are similar to per-cell voltage
> information, so I think we should create generic properties for
> that:
>
> LTC3350_REG_NUM_CAPS   -> NUMBER_OF_CELLS (new)
> LTC3350_REG_MEAS_VCAP1 -> CELL1_VOLTAGE_NOW (new)
> LTC3350_REG_MEAS_VCAP2 -> CELL2_VOLTAGE_NOW (new)
> LTC3350_REG_MEAS_VCAP3 -> CELL3_VOLTAGE_NOW (new)
> LTC3350_REG_MEAS_VCAP4 -> CELL4_VOLTAGE_NOW (new)
> LTC3350_REG_CAP_UV_LVL -> CELL_VOLTAGE_MIN (new)
> LTC3350_REG_CAP_OV_LVL -> CELL_VOLTAGE_MAX (new)
>
> ...

>> +
>> +static int ltc3350_probe(struct i2c_client *client)
>> +{
>> +	struct i2c_adapter *adapter =3D client->adapter;
>> +	struct device *dev =3D &client->dev;
>> +	struct ltc3350_info *info;
>> +	struct power_supply_config ltc3350_config =3D {};
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
>> +		dev_err(dev, "No support for SMBUS_WORD_DATA\n");
>> +		return -ENODEV;
>> +	}
> return dev_err_probe(dev, -ENODEV, "No support for SMBUS_WORD_DATA\n");
>
> But I think this can just be dropped. devm_regmap_init_i2c() should
> generate an error, if the i2c adapter requirements are not met.

It's quite interesting to see what other drivers do here. Most report a=20
message, and there's no consensus on the value returned.


>> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	info->client =3D client;
>> +	i2c_set_clientdata(client, info);
>> +
>> +	info->regmap =3D devm_regmap_init_i2c(client, &ltc3350_regmap_config);
>> +	if (IS_ERR(info->regmap)) {
>> +		dev_err(dev, "Failed to initialize register map\n");
>> +		return PTR_ERR(info->regmap);
>> +	}
> dev_err_probe()
>
>> +
>> +	ret =3D device_property_read_u32(dev, "lltc,rsnsc-micro-ohms",
>> +				       &info->rsnsc);
>> +	if (ret) {
>> +		dev_err(dev, "Missing lltc,rsnsc-micro-ohms property\n");
>> +		return ret;
>> +	}
> dev_err_probe()
>
>> +	if (!info->rsnsc)
>> +		return -EINVAL;
>> +
>> +	ret =3D device_property_read_u32(dev, "lltc,rsnsi-micro-ohms",
>> +				       &info->rsnsi);
>> +	if (ret) {
>> +		dev_err(dev, "Missing lltc,rsnsi-micro-ohms property\n");
>> +		return ret;
>> +	}
> dev_err_probe()
>
>> +	if (!info->rsnsi)
>> +		return -EINVAL;
>> +
>> +	/* Clear and disable all interrupt sources*/
>> +	ret =3D regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, 0xFFFF);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to write configuration\n");
>> +		return ret;
>> +	}
> dev_err_probe()
>
>> +	regmap_write(info->regmap, LTC3350_REG_MSK_ALARMS, 0);
>> +	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS, 0);
>> +
>> +	ltc3350_config.of_node =3D dev->of_node;
> replace with
>
> ltc3350_config.fwnode =3D dev_fwnode(dev);
>
>> +	ltc3350_config.drv_data =3D info;
>> +	ltc3350_config.attr_grp =3D ltc3350_attr_groups;
>> +
>> +	info->charger =3D devm_power_supply_register(dev, &ltc3350_desc,
>> +						   &ltc3350_config);
>> +	if (IS_ERR(info->charger)) {
>> +		dev_err(dev, "Failed to register charger\n");
>> +		return PTR_ERR(info->charger);
>> +	}
> dev_err_probe()
>
>> +
>> +	/* Enable interrupts on status changes */
>> +	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS,
>> +		     LTC3350_MON_POWER_FAILED | LTC3350_MON_POWER_RETURNED);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ltc3350_alert(struct i2c_client *client, enum i2c_alert_pro=
tocol type,
>> +			  unsigned int flag)
>> +{
>> +	struct ltc3350_info *info =3D i2c_get_clientdata(client);
>> +
>> +	if (type !=3D I2C_PROTOCOL_SMBUS_ALERT)
>> +		return;
>> +
>> +	power_supply_changed(info->charger);
>> +}
>> +
>> +static const struct i2c_device_id ltc3350_i2c_id_table[] =3D {
>> +	{ "ltc3350", 0 },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ltc3350_i2c_id_table);
>> +
>> +static const struct of_device_id ltc3350_of_match[] =3D {
>> +	{ .compatible =3D "lltc,ltc3350", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ltc3350_of_match);
>> +
>> +static struct i2c_driver ltc3350_driver =3D {
>> +	.probe		=3D ltc3350_probe,
>> +	.alert		=3D ltc3350_alert,
>> +	.id_table	=3D ltc3350_i2c_id_table,
>> +	.driver =3D {
>> +		.name		=3D "ltc3350-charger",
>> +		.of_match_table	=3D of_match_ptr(ltc3350_of_match),
> Please check what of_match_ptr() does and then drop it :)

Interesting :)


>
>> +	},
>> +};
>> +module_i2c_driver(ltc3350_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
>> +MODULE_DESCRIPTION("LTC3350 charger driver");
> Thanks for your patch,
>
> -- Sebastian


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




