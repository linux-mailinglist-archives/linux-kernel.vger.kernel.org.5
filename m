Return-Path: <linux-kernel+bounces-79631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796388624E7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070171F221C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9663D396;
	Sat, 24 Feb 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VRzhH4w/"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2091.outbound.protection.outlook.com [40.92.107.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39A2D600;
	Sat, 24 Feb 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776768; cv=fail; b=Kxhgc7XwmuBUAhThYnDwf5hx7w1Y0ILqm2MOdczYgT2gYByJ11qKxj3F+XXDLzB29FMBtw1dT/VIl8ZtqWMqXnKzETvRqOWGFNkae4rMOn6vrKMh8h9JByL0NSlAEUFynTVtDkh4iJSe6+EXMdZ0bCEPkXGRDRajeaZBh2wPAMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776768; c=relaxed/simple;
	bh=qvMFYzEQsAe7caIyKa9UhZEmHhRkX0WyjQoDNHF+BN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mtw1zco+fFDSDDlx25HFJutI9Zc1mERj3sYf/JJg+x00NDHjSbsOHx5I3aukRLwZr7bCKN5YrHxK0LG4fbtN3Co5sF42B30Dy3PxDsAj8oG4KuMKvN5gCXoqYLkRReRzu0BZRa6ZtanORAz8gnhw3mS6ullal2hhq/sT7wl3C8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VRzhH4w/; arc=fail smtp.client-ip=40.92.107.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+fk4h3Y4v525QMVfZSVqjknQbgP+1xdxdKRL5qLnUeGMGnlWwYKMKroPP+6nm4+z6UvYQ2JRCTKauq5SeOSORs1F2QU9/W8KohAZ2Fz6PLs77sCmBZ+XYibnhyHj5z19m85ygp168XJJOhGlB4wncLlJVmsZKlbasDt6WYpxJ/QwsJVU0h53gmLjGGwtQuqilolUswLMMM0E3J8FAwn4wUdjJtQ//LENVgBulFEdOC14mmRhXO/kqTFazxZ8ikWy4K4VeMZ0rERAEwrg7uHWf/I5GSy8uDjUfPjsqZc53DtFZzToEOCTug3nXYXJZVkLgEvs5mVpngjx1C9grsbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTWVWNR3vnZZ24VeE7kur/XtPPxs6JfvP/v/CwmaB8I=;
 b=WL6HpUFn+xPCCLQsV9zm3VMyWMJwIjFiVq2XGJbg+CRQheY+2uqgAvkmfTNO7cktFnD1qCWa3TEt5R/HPscBOa1ucU7w/yfffKoJhrEUyONAju2GI5HbNQCdsbotWDqNOLHme7vWnUMo6woK+RKmuUDQYCTT9zIbPgsaWn6GxyNL8LpW/3EMYueE2EK9Jjv2oghoA5kwf/2mwBSA2UoDH8o/Ek6mrqcvHIt3mFRwQov7FbMAYXkWUjCeOAu4C5gIRDxO+sSeji3oOhutqhNEmi2i1yBuEbFZthpXHvgypqh4KbY6H0rN2vKzzQHHei/LJdrxkv7URMV5FFCFn8i8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTWVWNR3vnZZ24VeE7kur/XtPPxs6JfvP/v/CwmaB8I=;
 b=VRzhH4w/u1Qg+QAEGiLXZTqghqOmaa5H51Hg1POuGGNZKyEmpB2di1jn0WJXxWj32LoWxg8uicUO1a2oF9R84FN//SVS9BEvAslTO9lRzp4Mz/ZQqshV1PKQfRmNhqBk81inTTxUa9+Ba2VADpiIE6Bcx56wM+5quSsygIA+uRsbnowqtsEgFgL+9sXrlkyxgOiGvtFtZnLo0XFdouuUk3I5u5W4Fo8Xpm98sZkueCJoRPdwkan0/2vg4VJHzxhe2SvpwrTShBhweiDEu0C3HcsaeBeKbFwX9TKJdxzATEq9TSV1ovKqJeveDgCCwtpWDQ+PJ/UBKA8EwHou5efDmQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6334.apcprd06.prod.outlook.com (2603:1096:101:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 12:12:40 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 12:12:40 +0000
Message-ID:
 <SEZPR06MB695916F0F1B64E34EF8551E596542@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 24 Feb 2024 20:12:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets
 exclusively
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-b4-bus-v1-2-2803c3ac4673@outlook.com>
 <202402240740.rPfLNrGO-lkp@intel.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <202402240740.rPfLNrGO-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [yfKXVPMry1d+6kZ5xQhxHuwqDmWmqdc1nZgzWZnm4H/DpjNW3Dl9uHzJlPvgOxumQWyAT0pqNh8=]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <f935c56d-d596-468b-9448-e0a526b2398b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab01c8a-6e55-4e0d-0a79-08dc3531e52f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dn4S/t+SYueHp6uqKF8zHKEPdGW97g6TrvIAqVim4zkxi4Suhb73X5s4YwrR0Tpp0Es4XVe5n6pzJFtXlDW89GLWUEozOzMhHmT4tLjDCIYXIUrW2TzvmP0/Q26wLCjwgDosfhgLy5G7JgFr4KZjexN6X8IzEjN1Ep8mu4nLaUsl8ncuH/StrGDw7K5MLr6S/kN+J0dj3Dsypw3wToTYVg2Ys6qJQy2ylXNFhodShK17IR1M3TKpVLO0vus9RGflAQmz2NNsIV+FJBOHE6lAmFJEwUe9y4w1eiATAUaJlhv9ioMJeRKrgfVbErZ3YMczbLm+x7ohSlJTPFOl+HAggHVcHHs0Z70sCzS9/sRhrSnF1hQTwYLyX9Z78mnwTDbLehNEnhM/8Z3eWE9UIYm0XUzhvu84ZY/bBoyx0UjRo1Ska5EpNBQLpkqYtUryqObE7yh+9HB2fbtyFTODzWL5lDgt8GTNBL/F9wnB6M9xQFKCBqW3XbZorjYXxXarQSyT1rXsncsqVL099FGO6+9h1QR8jRWNIXi49Fbfv7r8Zu9Anf7FFkAO+0Fmfb73nPZNDigwlNWIkPFXRUtGlwuMdM5TsU4gMk5ZM/2fkaAYryM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TElWd1psZ1d0NHY2amtRU2tvVzN4bGpuVUdvYzJyelZiWDlpOStLS1ZJRzVM?=
 =?utf-8?B?K0NQdUQ3S1BVVTJLTEVkZEJUMWFmQkNvbXZLOHdYajM4ZVEzWStwUERyZk92?=
 =?utf-8?B?RTZpRThlVlUxNjRoY05OaVBuQkxlaUpxakZ5RWhiYXFpTG9sYS9ONmErTHpx?=
 =?utf-8?B?UVp3bXNRcHdTZDZkV045U0hySTluMVF1QnhFQ2t4bjZMYnZTT3hOdGtLR3pq?=
 =?utf-8?B?Z1h4ZDNBelg5MmNJN0NpeWRQQngvQjBGY2o2SFNFbk9NcVh4UGo0b0wxSXVM?=
 =?utf-8?B?c2ZJaVVIUU05aktQZFlGaGNxeGV1TDVKMjZYbDVkTE0yUFdKQm56Z0xYUitD?=
 =?utf-8?B?ZTR4eUh5cTBSMTNRYTlwSHA1WTVDWWwveFNFYWtJK1VyR0k5S0gwUFh1Wncz?=
 =?utf-8?B?N1FnQ3FFVWk3SzBsamRsWWhvd24xeUVVOUd0cVgrRHZsRWNHYkpMWm9kbTJJ?=
 =?utf-8?B?OGxTb2l2SkJaUS90MUo0cHozY3p1ZU92aG9wTEY1aWF6Umx1T1pHdVc1M05l?=
 =?utf-8?B?anVhZ3VOUjRJZm1Da3NmTFNUcmp5amU4MmNjRWtRd3FEL2RNcnp1eTJjUTlp?=
 =?utf-8?B?MlRyWUZQWkdoWllZSmpROHhTNTNSTTcyelI1ZGUxKzBUOXF4RG0xV294Q1ll?=
 =?utf-8?B?bE1TYzF1RGp4QlFpRDlRQ3hzMmRmRi81R3RZb0svNjBPVnZBbjJqUWx1Uktu?=
 =?utf-8?B?UE93V2VYUFpVc0NtRHhiWlUvNnBDTHJvM1Noa0xqRWh3YWh3K0Njb2dLVGpI?=
 =?utf-8?B?UkxsY1lSZjQ4bEp1bG5yWHBPSGxBcjJYb3pXQmtuckZOMmMzSk1NS1p6R0xE?=
 =?utf-8?B?MWdHcDh1RERnZ3VhYkViWXVvYzZvRnlCK3FsZHgyZjZjejVJZkhYV0lud2t3?=
 =?utf-8?B?RjVRZkFqMU1xekg0KzlkdDJHRFlQaEJvWVB6cXZtS3RxYmlVL2J1ZVFhUWgy?=
 =?utf-8?B?VU13K3JPOTdhc01wVG5GQWhyYld2NVVkWGFVeDZOeXYwT3VtRm1pSHRXWGRu?=
 =?utf-8?B?OG03NUNJdlZ2dkxzdy9mQ2R1QS80a3J3Ulg5R1VZZSt1c0I4RDEyYVo4clpR?=
 =?utf-8?B?VTZ4UFNvU05NNVVJVXFtOHJ2UlR3TUNJL0hjOURPMkR5eERGNi9hRXYwOFlx?=
 =?utf-8?B?MmtwZFNZZ21zaEJvMlRaeW4rbFBUMjlId0lpeDl5TWoxeU1HYitkZk96TnpQ?=
 =?utf-8?B?amNqLy9tWGRkaEZXUnJVSysveTdxa0lyLzBPeElsK0gvcWpNYS9JQkJjY3Nz?=
 =?utf-8?B?bHEzeWY4V3ZiS0xjVnNEUkVNOVlSdkdKSy8wSy8xTXF2UGdUZFR4SWlDSDhJ?=
 =?utf-8?B?M25maEcxNVkzc1ZxcnBrNmtzcDNTRzN2c2h1aUtadDdMQUN5ZjNVSEZsVjdo?=
 =?utf-8?B?bmlZZERzVFlSVGlyZTVmcUxqblNSTEMzVnozRXpBMEZXL2FrSGFmNjR3MVFT?=
 =?utf-8?B?VFBDeGFTaHhKZ2ZJSHZtTzk4N1I2OXlsSVM5RisrekdxdC9tRDcrekNOT2sv?=
 =?utf-8?B?aHJ2dlJqRXB3V3NNM09Eelg5b2ZsVkVwNUh4MFhDZTRnSE9jL2plNVpkeWxC?=
 =?utf-8?B?cU8wVFByZjBWSGZLYkViN3owYkhjY0pVK0dUcDVaZk9yRXZHQ25lcTNVeGJv?=
 =?utf-8?B?SEhldlVnSXRnVVU0eGpUWTZhcm1yWVB1LzdEMjNPcjhHQmtWWjg2d1RsT1RM?=
 =?utf-8?B?cXZvbFhUZGIraENlUTFkd0lyZWxCelBuZ0Vnd0lmaHJUMUhEL2Mzc1h2ZVpN?=
 =?utf-8?Q?QVTXYrrX05y2WMuhWs2EQ3zlBFV7FM2zi32nspV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab01c8a-6e55-4e0d-0a79-08dc3531e52f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 12:12:39.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6334

On 2/24/2024 7:32 AM, kernel test robot wrote:
> Hi Yang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 8d3dea210042f54b952b481838c1e7dfc4ec751d]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Xiwen-via-B4-Relay/dt-bindings-simple-pm-bus-Add-optional-resets/20240223-115400
> base:   8d3dea210042f54b952b481838c1e7dfc4ec751d
> patch link:    https://lore.kernel.org/r/20240223-b4-bus-v1-2-2803c3ac4673%40outlook.com
> patch subject: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets exclusively
> config: i386-randconfig-061-20240223 (https://download.01.org/0day-ci/archive/20240224/202402240740.rPfLNrGO-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240224/202402240740.rPfLNrGO-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402240740.rPfLNrGO-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> drivers/bus/simple-pm-bus.c:67:50: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct device *dev @@     got struct device const *dev @@
>     drivers/bus/simple-pm-bus.c:67:50: sparse:     expected struct device *dev
>     drivers/bus/simple-pm-bus.c:67:50: sparse:     got struct device const *dev
>
> vim +67 drivers/bus/simple-pm-bus.c
>
>      26	
>      27	static int simple_pm_bus_probe(struct platform_device *pdev)
>      28	{
>      29		const struct device *dev = &pdev->dev;
>      30		const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
>      31		struct device_node *np = dev->of_node;
>      32		const struct of_device_id *match;
>      33		struct simple_pm_bus *bus;
>      34	
>      35		/*
>      36		 * Allow user to use driver_override to bind this driver to a
>      37		 * transparent bus device which has a different compatible string
>      38		 * that's not listed in simple_pm_bus_of_match. We don't want to do any
>      39		 * of the simple-pm-bus tasks for these devices, so return early.
>      40		 */
>      41		if (pdev->driver_override)
>      42			return 0;
>      43	
>      44		match = of_match_device(dev->driver->of_match_table, dev);
>      45		/*
>      46		 * These are transparent bus devices (not simple-pm-bus matches) that
>      47		 * have their child nodes populated automatically.  So, don't need to
>      48		 * do anything more. We only match with the device if this driver is
>      49		 * the most specific match because we don't want to incorrectly bind to
>      50		 * a device that has a more specific driver.
>      51		 */
>      52		if (match && match->data) {
>      53			if (of_property_match_string(np, "compatible", match->compatible) == 0)
>      54				return 0;
>      55			else
>      56				return -ENODEV;
>      57		}
>      58	
>      59		bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>      60		if (!bus)
>      61			return -ENOMEM;
>      62	
>      63		bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
>      64		if (bus->num_clks < 0)
>      65			return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
>      66	
>    > 67		bus->rsts = devm_reset_control_array_get(dev, false, true);


Fixed in v2 before reporting.


>      68		if (IS_ERR(bus->rsts))
>      69			return dev_err_probe(&pdev->dev, PTR_ERR(bus->rsts), "failed to get resets\n");
>      70	
>      71		dev_set_drvdata(&pdev->dev, bus);
>      72	
>      73		dev_dbg(&pdev->dev, "%s\n", __func__);
>      74	
>      75		pm_runtime_enable(&pdev->dev);
>      76	
>      77		if (np)
>      78			of_platform_populate(np, NULL, lookup, &pdev->dev);
>      79	
>      80		return 0;
>      81	}
>      82	
>

-- 
Regards,
Yang Xiwen


