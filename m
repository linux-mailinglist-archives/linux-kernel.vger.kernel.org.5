Return-Path: <linux-kernel+bounces-158071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FE8B1B09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525D62841FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7295473A;
	Thu, 25 Apr 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="CHpSNlxZ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FD3EA9B;
	Thu, 25 Apr 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026521; cv=fail; b=DjJhzmFlzYpuQvnyD/Di4i0Fleg8ICIia33Zypab+xq/frvdZqRaY7RHEsPV/1+92voB4L1K5eu8sskTT7+7ngN+qyPd/UMu+Kr20qhRnlsHj8rEs5iCuSryoukKEPvcdBjk4q1J11/km4tqd0INeDNdbs8TmcT9Jc0SpbVrq2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026521; c=relaxed/simple;
	bh=YXzyZjLBqYXsjzAZ2teiWcfZypo7fHV8a1OuEvXr+kQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G9a4tnPYYf3PzwLV6PS5JTS9USuSVOoFrhAfVQwYFgbhOapZuJTsPa9m2+/N0AEv5+3z6quiOlk1MZeNFmqAAqHGJr3QtQTQBa+mUpCvQpfGO1DugSDs99LV++cBjADH3L0iazcNiQI7Qlttxi2w9nu8xndvRjNxIBjc5GezpUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=CHpSNlxZ; arc=fail smtp.client-ip=40.107.255.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqQbqK/Nj1SpfS5naA/5OcwrGIGI/9TmbfNb5dTaOXoDDUNNdypZOMdWZujsvubR+WS3KF0jna7rq0/f1yjysGJ+KzK1Kk56De/lNpj/WaBTjHdnBR5Y581zjYWPj4c9uLWLQZVmXb8muKWkZgqBuVFIgR1KgjiLwDwe3+5PzoDU1VTBhqEIe3WhLhcBzPg+3rPfTkwN/XND7n/EkYj9kbH4Cv16DC2TFUs2eI7RtPsTND+tDqdBUQx5+Y2dr20WcRCE6T3X+qo48kYaA+2FJxUd5wDaumEIb7duk1V/PT+kVV1NCiFUf2MEsg4+Gzippumgk4gtOQHsNf+XFNbuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4I+htJ0sWB6j5qPI4BTJL5RfnU2oduo5QELRVQOB/U=;
 b=Y0pkaM4nXOeLF6QZ42bwoVjn8ZiV3bdFPYG04O7M22n4oQycVdFAqbCyvBFby9SbOzWV+vBeKUyVEQ8lQggLZINw4bn7RSFgN9HEnGA9Gp0fpUg2E8jF7Thl/x2ZKMVroSC/wGW2G13FZjJBsQq9nRSqC/sjWtbPFSfXp6Rc/uILBiJhSrcRHVHaDHqo6d9svan4UxC/6I1nnQbVCEMo0d1gtNNQgDqAekQxdPUAbsvsfH7zUeexsu8LBUN2Jf8iMnwWSVZ6jpCeuz/07cPSozVJp6hWriEM0vT5djNSu+qN5av0QySIvsG5supzaYhCyhd2s9vZMQus9UR414uPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4I+htJ0sWB6j5qPI4BTJL5RfnU2oduo5QELRVQOB/U=;
 b=CHpSNlxZU1b4DZf0BgnC7fYEWB1bgjb0sdhKyolwojVmKunVkqmzyO4MwrAiD7h+43kOV3AYZtZb8l/qezcqxbd8BZbKVRwXJQ4Inmqeezqqm2StjHZu6eRWpr6eY4CHvJW2ZVQGyqVyUm8eAEcuHB/14BSzqJeYXAOg1Q/78j/DSJw2z1MpoAMmT636kkh5SiYDkjCdnGrDjBuCfC9zJ/1GB93OYkb4NPZlBWaLbmcFVlu1IfeWjhh/OnNKBB00ttVfsfQN+EstjVZ/okgGoazNO2IkWXHE0SK8w8x6+RhTKPrneX4w3gvNSFaVxI1exWCol5g+oDuBzW530pF12A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB8639.apcprd03.prod.outlook.com (2603:1096:990:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:28:33 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f4ff:211b:7c34:16c8]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f4ff:211b:7c34:16c8%6]) with mapi id 15.20.7544.008; Thu, 25 Apr 2024
 06:28:33 +0000
Message-ID: <9a9ab302-5da5-47bb-85f1-d2295fa9f8c9@amlogic.com>
Date: Thu, 25 Apr 2024 14:28:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] clk: meson: c3: add c3 clock peripherals
 controller driver
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Chuan Liu <chuan.liu@amlogic.com>
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
 <20240424050928.1997820-6-xianwei.zhao@amlogic.com>
 <20240424200107.GA372179-robh@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20240424200107.GA372179-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB8639:EE_
X-MS-Office365-Filtering-Correlation-Id: b3016ab3-4aac-40b8-413b-08dc64f0ee3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzlkTGlZMlhTeGMzSUw0TXN0VzJLY0ttZGNXYy8razNhT0lwQXUwYmQ0Z0c2?=
 =?utf-8?B?dTEvQ1lQM2ZnajhNY2U3K1RHbG9HYUg1M1VaWURWdWI4LzNRbUN6Njh5NlU5?=
 =?utf-8?B?YUhGaUxHbisyaytlZHR1am92U3g2bytBNU5uQ2J2TUJkd3dmR1hZNXFPbkZZ?=
 =?utf-8?B?UWV0SkZlOUFJUUlZdkpZblhSL1BHOUR5OFJIVFU5a1R6b1pvUzZNNW9DQ3Zk?=
 =?utf-8?B?b0g4dXhRNlMxMzlUTmkwdDNBcnNCem9oMVB5STIwL0JQYVY0KzF1dWswdC82?=
 =?utf-8?B?OXdTUThrS3MrV29MUm85dkFGQUhYZFdpQkZueVF2a3ZyWFdiYWFCeHdKSjhF?=
 =?utf-8?B?SUNtaURYNGJFcnJSaTdtdXlOd1k5VmdKSWhZdHZlcWlySDUxZ210WTJ3cWdF?=
 =?utf-8?B?eWZFT3pVU1E5YVJab0g4ZzhDNHdGR1hxYmRLL1NtUGZHbGpQRHQ5NCtLb0pM?=
 =?utf-8?B?OFBUaTArSG5wUG1xcjAvVkZhb0hHZVREV2pnbDYrWUFzUkc2MGpNc2RyaG1Y?=
 =?utf-8?B?S0RqaFFlT3h1c0tNQk1jRDRjM2ZBZG9weG1qcTdnUGFNM29idmFNRVNGSVZK?=
 =?utf-8?B?YkFrdmt2OXdKK0pOdFBFZWZRM2k1R2NYNnQ0Tmc0TkVVWWhhY2xTVkFKMldB?=
 =?utf-8?B?Y0RDbjQxTmx2V1M0WlBySVRGNkJpNVhUdW0vNi9UbytTR2M3SFQxSnUzdWFs?=
 =?utf-8?B?aWhSOUxWcE1nOS9OeC8zMmZiZkpQcCs2QTM4bllROE9qT2xScHZCNXZYb05Y?=
 =?utf-8?B?NmZuU0VFa0hZNzY5V2lPMU45Tmd0L3ZXTXFJblpkdC92OVdzeGFEUFJ0MGJ5?=
 =?utf-8?B?MnpaZTVvRFZOUzQyaHI1TzhsZmwxdGdqQ3N4SmI1U3pkWEJLenZhZUdPVHYw?=
 =?utf-8?B?VXNPK0t4bmlOQ3R4SWpHTXpvRU9EZHA4TVBLYkYrNHVTZWcwdjNFd3g0OTVj?=
 =?utf-8?B?L1lrTWdVQmVNSVlOWk1HbXVTZVdoUG5vN1ZBUFBUR1VvcThGY0x6UTFFaitu?=
 =?utf-8?B?V3BncjhQcTV6NE9JMUNub0hzbzMwekZoRW5oRlNDN2t4dVZCOE8rZEtwOFA5?=
 =?utf-8?B?UEI0aldlNFZhU2Q1ZkJXL1NhMkU2ZFlhTkdoVnlQb1o2eEhkYTVUdGV6N1RV?=
 =?utf-8?B?a0RWOTlXSnptQVVnemJyYXp3RnpuYWVER0ZXNThDeURoM0NEOUg2M2RETFpM?=
 =?utf-8?B?ZzNXNjVQVjVHTkdObDRISlQ3N1FqWnJkOFBhK24ydVQ0Um5hL20vZUFuRmJE?=
 =?utf-8?B?V1AxQ1dNdWxZdWJORGdLMHZka0ZZOWFFZWpTQnhhUHZhSnp4Z0svMndtTEU3?=
 =?utf-8?B?U0FNeXRNZnhkSkp5eWV4ZDB1VkZmbit4bEJMY1VmUkpaRllXeW0rc0pWVHdq?=
 =?utf-8?B?ZWFycDc1eVk1VHZCakcxZE1QY2I4S2FIL2tSYmZYNVFOTWpxMDdVOTdoVXkw?=
 =?utf-8?B?eDliby9Md3Nxa3pMRTVaNU5XUktKUEJhQTZyTlFFdit3U2dJTUZlTDl4RVJI?=
 =?utf-8?B?SmJZbmRiSkNnNmJRdU5oVjl1M1doMlVIYkRTOUttcnl6TWRnQVZITVQza2pQ?=
 =?utf-8?B?K0Zjci8zZVJ3N3FiK2E4QWVPN09CdW5qeSsxcVVhcktKNkFwVXdEUTNEYWlK?=
 =?utf-8?B?WkhlR0hnMFVHY0xVR1Q1eWl3MjN0T0ozQXN4NldUSUIzaVNaeXBwQ09MMnBU?=
 =?utf-8?B?clRacDI1WThRWUs5ZS9tdGY2VmNGVnloNzd5SzhJSmIxZTVWYjJIdUd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm9zNi80QkNiRjNKdkZWK2NqRGVLais4OGJHd1RUOU8rb2RkZWhMYUJxcld2?=
 =?utf-8?B?SVFkVndqWlB6ei9IN1B2Q0N6L1ZBZDFEYWlIYzhyL2NGMi9hTElkTVloZ2VC?=
 =?utf-8?B?bWljRjdrV2sxNjcwZ3BFQmFtTlE4ZG04NXVCTDRWblF4clduekp4dUpESGZV?=
 =?utf-8?B?YmFJWUZqdkFiNHRWZDdMcURybmV5SW1UL09DZlkrWjEwakFxdmpQVmhxRGNj?=
 =?utf-8?B?YW5yTHd1ampxd3oyZHdkSVUxdFRRZk1qMFJ3RGJNajBTNlpnd3l4SER5NUtk?=
 =?utf-8?B?SGhkTzBUWHNrbVNoYzBiK2tiajlma1NNQXAzNzRoR0hXUnE1dUMrbkNEUklB?=
 =?utf-8?B?dW05dWJZTERRZ3JhRzZjNDFyblQxNGRFNXFHemJ3QkJrL2VpU3NRbG5hLytS?=
 =?utf-8?B?ZW13Y01xVDNxSVQ5dHhsbmFYYVVCMFpFWmo0Nzdaeks0YTM0dmFHajlDVS9V?=
 =?utf-8?B?aEJLd1YrSTV2NGRqWlNIcG12YWJwSXArZUJZYUU4djY2NjBwRnp2a3FSMitL?=
 =?utf-8?B?dTV2Ums2djZsV2YwNVhScmdVdWFJdkRhc2Z5c2VNd29NR0hWRWFRRVdZM0t2?=
 =?utf-8?B?VFlvY3JDTUFCWHpWVk5MZm1VMHBETUJUckJ3M2FVdzBrU04xdnh3QWNGYjhz?=
 =?utf-8?B?Q0w5QkZpN00vQmhsQzFQdVMvMDVSc2kvNDg5MjRYREtyTjBHVHpENm0yVTRW?=
 =?utf-8?B?eFpUQTJlOXdUNitIdnpHS05MNkhxYVcvVjRocEJVVENwRlF5QTIvTXMyOXJX?=
 =?utf-8?B?bEtNYVhwZHQzZ3QrNDY2cUVsM3YwTkllcXRWSjA1QmZmS2NVeVJhZVBUa0pi?=
 =?utf-8?B?QzFScGd5UnlHbXlxbWFwMi9IYmZMTGpOVS85ZURjeEczbGVOazRUNW9MMGY2?=
 =?utf-8?B?eWI0bklYbUFKeEdIaFZkZEFyVktUdW8rTUZjL0hzK2g4VGc3OE1jNDFZOFg2?=
 =?utf-8?B?Zm1wNFhvWnUrSWcvM29CcHFCU2dPdm1vM2gvTHh4Um8vc2pSQlJ6cHRDalpu?=
 =?utf-8?B?d0ZJQlVMOGpLRTJvSGh3TVJGUndvWjF5OEpYNWJrQ21QRlpCLzBKNHJONjVz?=
 =?utf-8?B?RmRTTHZLQmszWFcrUGVUN1NKNzRITlczOUZJc01VTGY0aUZsY1F0dFNJZFIr?=
 =?utf-8?B?ZENUTzNWNzRLU0ZnOHhsT0c3KzJPL0c2eS9xd1RJMW5Ld3lTNmwvWjJ2WG53?=
 =?utf-8?B?alIvWU5oUWV6WjNpVzRVRnI5Y2JWMFVDdlMyVWIrdkdkb2xIdmhwWUdLa1BQ?=
 =?utf-8?B?RW44RnhkVnIzam4zMSt0NEJOS2U4QmM0b1hyTlhRNkJmZ2ttYkE5MVp3ZVZ0?=
 =?utf-8?B?c01WaURZVW5TQ3cxTERlZzhxR1JVcTYvQjJlMmpjdG1uL1VCLzhsZm0raTNo?=
 =?utf-8?B?Y2N5L0QzWGxqdlpxZHFYSWNlNElTWjl1aHF0M1JyTXZHUEkxcmpHK3V3ZlU1?=
 =?utf-8?B?MmtiVW1oTkpQYjgraXhBTTlleXFTeWRZb0hHMXdsODkrV1lvTTZ6UENZcGxm?=
 =?utf-8?B?T0VwdlI3cTlYUEQvaVIxSUV0VDBHT3ZJT25kZTNlMkhtWkpGK0draFZBSlF6?=
 =?utf-8?B?RlcvdlMzUVllYjRXcGlkemdHdzFrcTFTbnZoWGZRaVk2SWZXcEVWeDkyMldH?=
 =?utf-8?B?MmFBdzBHQ1lkbzJyVnBJb1NCYncrNHFqbWczN254Qm50SjVDKzVNQlBqcllu?=
 =?utf-8?B?b1dFM3JWbEtxbTV3Z0V2STV5TEpkTVlwTlAzOE5ZaFhpOEplUFZQTjYvSEpI?=
 =?utf-8?B?c2QzL2VxU0RDRGJJd0pDbHdGd2Z2bmozYXN2WDY1NVlkNGdhUm8vU0t0NHVw?=
 =?utf-8?B?a3dPQWRjS2N1eGQzUWFvR1lDRkEyL2FxYXRqcThLKzA0Z21HWDB4WjRWbzFP?=
 =?utf-8?B?OXgzS3lVN2dpZDl1aWVRMW93eXJjVzZzaWw1VUZobU5OZVRYV25mcENraE1S?=
 =?utf-8?B?NFF1OGRRWnFFQU8vb1BSeEhnVENacnB5eHlpeWVUMERrKzhBWGJ4QU50RVl1?=
 =?utf-8?B?dmM0K09Eckt4K0RYdE4zaXllSTEweGxHUWN2ZlhzTDRybGRUcFZSQUxabGhI?=
 =?utf-8?B?alduKzVVbkFUSmhnMlVmNnR2dldyV1QyQTJaSUkvWjNBQnlqRVlMNjFmQnFO?=
 =?utf-8?B?S24wSjFvY3F5T09FNXRuYWRBdFVodGR0aGo0VFBlekdQUStHa3E1OVJ4MjFU?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3016ab3-4aac-40b8-413b-08dc64f0ee3c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:28:33.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Dz2r8mZf8JnZLa2IRlRzsPWJPNuZq8er+PYOrCnv93HhayA4uX1dEPmO3KPiCVQJc/aH7oYGmPukxsUOz7hifiLn2e0o/NnpYf88+YMP/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8639

Hi Rob,
    Thanks for your review.

On 2024/4/25 04:01, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed, Apr 24, 2024 at 01:09:28PM +0800, Xianwei Zhao wrote:
>> Add the C3 peripherals clock controller driver in the C3 SoC family.
>>
>> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig          |   15 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/c3-peripherals.c | 2366 ++++++++++++++++++++++++++++
>>   3 files changed, 2382 insertions(+)
>>   create mode 100644 drivers/clk/meson/c3-peripherals.c
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 9f975a980581..0b85d584910e 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -142,6 +142,21 @@ config COMMON_CLK_C3_PLL
>>          AKA C3. Say Y if you want the board to work, because PLLs are the parent
>>          of most peripherals.
>>
>> +config COMMON_CLK_C3_PERIPHERALS
>> +     tristate "Amlogic C3 peripherals clock controller"
>> +     depends on ARM64
>> +     depends on ARM_SCMI_PROTOCOL
> 
> I may have missed it, but I don't see the dependency on SCMI in this
> driver.
> 

Some clock sources for peripherals controller from SCMI module.
In previous version, Jerome suggest us the clock  that relevant 
registers can only be accessed securely is implemented through SCMI.

>> +     depends on COMMON_CLK_SCMI
>> +     depends on COMMON_CLK_C3_PLL
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_DUALDIV
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the Peripherals clock controller on Amlogic C302X and
>> +       C308L devices, AKA C3. Say Y if you want the peripherals clock to
>> +       work.
>> +
>>   config COMMON_CLK_G12A
>>        tristate "G12 and SM1 SoC clock controllers support"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 4420af628b31..20ad9482c892 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>> +obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
>> new file mode 100644
>> index 000000000000..0f834ced0ee9
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-peripherals.c
>> @@ -0,0 +1,2366 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic C3 Peripherals Clock Controller Driver
>> + *
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
> 
> I don't think you need this header.
> 

Yes, I will fix it with c3-pll.c.

>> +#include <linux/platform_device.h>
>> +#include "clk-regmap.h"
>> +#include "clk-dualdiv.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>

