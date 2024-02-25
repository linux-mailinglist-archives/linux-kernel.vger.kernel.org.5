Return-Path: <linux-kernel+bounces-80048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2B862A27
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA66281BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62310957;
	Sun, 25 Feb 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BvP/dm6y"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2066.outbound.protection.outlook.com [40.92.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE110949;
	Sun, 25 Feb 2024 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862217; cv=fail; b=k7x1S8Tw9t5sRtRVsdUGB+LZJezYlI6dq9R69CJy1KV4DZm65hR+6E7oPRyiO4D90NYwDniL0VuKF0jvxPywStGcCaXoO0xT0eGFmyLPyrgcH2UdfXNmcrwDYSjVQ/Dr9vXfYvudls88N5Oq4y33FjxkHh0z8sfwx9rgfaUS6sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862217; c=relaxed/simple;
	bh=E1xddv760UHhquhoNIcOl3g6fTneUR8YapzhPVNr5ys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N27M/wLwzCtHT5m8geqeWZVgq3kirZsCyj6n5TORULzpzfEl7eolWWD5K/c9vRNpNAezUu3+MHPZvk70OiV2XtAWnSUwwf484Y+196wA2VAuiLOvB6IahZtHISlCxzcmdlKte06416CkvLZLcAfQ6VIyUWgO07H3WMd0ufbRONA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BvP/dm6y; arc=fail smtp.client-ip=40.92.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWA/yBsIGE5iqFvUELfP4MhY7Eh602dWib8tF5TbdnRYjmC3zxo11r8aYedfA/yUVsynYNendv7HxR5ejhj9HSiD4ap+QGdrfFKUQmHwwrVpRZnvTCl5d7O5owBSsiu/3rbrvxpwRQXn4F0qzaKnzTHLazrUt3p2LacgQjvamF5FyqzMo/5fJb2bVxYorNKl1ioh46hP58XHqtkNr6jRqkCjHjT6tWsAWu9RQZCSHvnO/3qQUFti2a7rItKrtsg561pDnrkiQZ+a6G/sgtF1/lXSPNYP5dDjZNrSNwegI3Xxbg4g+Cxl4mRulLmVsobWNDgLXJUhstnghZ8dTTpNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21mcUmN7fW6uCFWlZg5Rbj1zg30jAbPY7AaFmjdG3e4=;
 b=Isr90OLa8Mr0etNGQplh4xxRMQwTwCsJ3BVgWZcb2M7K92Woogp+la5XpoCBiIYf0ECycuahpaHmINwmF+dg6DFEEt8ITHfxY1N49GmE7Fo3V5rT2P+bFklfZOdvFx99O94Wdqw0WLWktOuSQlR5gH9JUiVfNtOswHyUCb6Upq4USEclCGhYL56/vouLbf9t5DsVnAAktVbAk0hQg+4g+Toy8JCQBYLmz0BqtLJN9FzSLhtE+/s3uD5gjgpw9whJIk0zKqLECy9A9xxF4c1pIEUUY+Wnp90DxycLXaUQ5536VgQHidbhr8JW4AprWroCIlWpeZ6T5nDDR0Os/hxt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21mcUmN7fW6uCFWlZg5Rbj1zg30jAbPY7AaFmjdG3e4=;
 b=BvP/dm6yHSiHaKcDRGm6wP+Vwjr29wxGB8fL6rtu3GNRxPb/fM0rcOgp9G8zYkHYn5ERBmCidlVlLc+3jJOe7ipyqn9775WBWsXs87tk/n6lIqQvQujHHdDLfr8WiU6qHQxl4sm77UF/3OpEex9SqewduePQ00lu+gutZpz5BolA0eu2qpZEX4iOX6nVnlri6oB9igPp6UfcUQYIprZEos+9k15r4+PhI72WYEpHczUGSJFHRo8d2S6OnadNOlDMJWt7a9K+1PDrBhqgSnlgUHaWb140kPVhLIH/7MgvihSLTGnWYoeLVmyt2Xjx9VpKWBulLwRNJl9OFEz+0Pxr9w==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB6411.apcprd06.prod.outlook.com (2603:1096:400:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sun, 25 Feb
 2024 11:56:51 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Sun, 25 Feb 2024
 11:56:51 +0000
Message-ID:
 <SEZPR06MB6959206A186224697CD13971965B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sun, 25 Feb 2024 19:56:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/13] clk: hisilicon: Add helper functions for
 platform driver
Content-Language: en-US
To: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <20240225065234.413687-1-mmyangfl@gmail.com>
 <20240225065234.413687-2-mmyangfl@gmail.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240225065234.413687-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [aGCSJdmPpWI2qZCsY4BSahyItDtmi10oG9MeLxO8ymTSPSUUpIf8Hs5hV1XhYu6iUi9vMp2b/sg=]
X-ClientProxiedBy: TYCPR01CA0198.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::19) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <54586912-3f1c-4f39-afe9-36b0d2bb4035@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1ea1a2-364e-431f-40f7-08dc35f8d9f7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BAZXnCXqLnEtizaxrkeQ0W0v81GIqd8YNYLBkTZD2icuGcQv7Jpko3VrNg+sDoyTzKRcsx8537Z9GKU2ALF5tu1SQU4QwxgHyAL9QSQvvaPAKCVZmWNzwoGB5zrFo/0JoNhAzxZoT0JhmWFtDSOJQ+vcSCJ6akUmhX22qZO6A0liGSLB6KupsaNIlAMhgeSylnd8pp21GNdUBXJmlx6jbdwBxycTPtkMDNHl4wAsaFxiTvptv+n/aPD+9Vq1WxPHD/6Nm1s98CBaEvnHyHXcCBqGRRxhaqBSDnHTPV7wbeRRhSPWahCj2XU7rWbsVWaO6rOlrW82yMwVt9fZf4SLA/gRwLXmcdgwww8KZan59xiIVDH9A4hDHRFZkOrx42AIhzySozlsTnVonkwPlTi4XevulkR+c6ImVxYXhqYP2AY4RbQTDivFesl3Pd3LNGz8YdMLdAuCVDo4wKEtcEMul/ONcwvFPDy2G323PcsVxwvop3vJli/NqOoCzcGe9XIXHV70YiY2wu20qxOMSHbqZM8euRMDPhTCmkNktClaBd1xlgMIhZXAT3sXYetLmEX2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09nbStHYWo4Q2EwYVlVU20wUDM5ZmRZNU1xbDZVdkxzZ3dPN2x2R1M2ZElY?=
 =?utf-8?B?MTNwcFZ3bUdjUHJzcWk5SWNISWJ0Z1pPb1VpL0lUUG05MXBXSEl2d0o4bStZ?=
 =?utf-8?B?LzkwVHFZZ3BnZCsyUjgxSU1iZlg3MnBzZW55bUEvaXl5bWpSazVra3cvbjFu?=
 =?utf-8?B?MUhlTlFkRGhRemxFSUVITHExQm1tRW5TRWw1RHBOUi9pOWlPS29mZHF1Mklw?=
 =?utf-8?B?Z3JNcFhYdU9COCtqc2ZnSHhHZ1JjOHhSdkpuTmpzQUNwNU5yVSthZU5VK2Rl?=
 =?utf-8?B?Uy9BVFZ3OHNGemY2aUZVYUJOMC9wMVVZbXkxRzNpYVo4YnhuTEIvVlF3ei8z?=
 =?utf-8?B?L2FENzlRcE5oR2l3ZGg5eS9iTlgxTWtSMDJXRFFaUHA4a2d2Zlk3RDFidk8w?=
 =?utf-8?B?TE44UkdZcVZoMnBsTk9vLzIwV2lFK3E2Q1d2d3drQTg4NlFnL00reFJPMWhM?=
 =?utf-8?B?RmF3OXVwRnRya1FKQjhwT2ZvWmZlZ3dEeFh5bUE0UlQ2NGVCUUFGbXZoVDVn?=
 =?utf-8?B?UzUwVGJpakx3Tk5ucWE2Yy85UFhtZ2c1dGRSMG1HbjFOODBQYTVMNmN4aUdJ?=
 =?utf-8?B?NlR3aUY1dUZzZ1BpcW9sRWdwSlFoQTBlMnJEQ1ZhVUMrU3c5RjhZbGZaMllT?=
 =?utf-8?B?dWROWU9ieExRcGNhQi9mU1U4eTJDSGZwUmtscmgzMndhVDFlaksxam9HOENr?=
 =?utf-8?B?Rms3amUxRnljdkFIRklsVTllaGxGMzgzam9qcVdxYXljVFEwdzkzQWNuVkRJ?=
 =?utf-8?B?SWlRNGtQdmF3ajFYS1BEdVM3OFJ0bnVIZXp0Q0VweDJ4eHN0Vjd2Y3VVNlN6?=
 =?utf-8?B?cE1ZbUs0SStHM0c3WC9qVTIyRktXWG9wTG15RERUUlVySHdaU2RHaldkNkcy?=
 =?utf-8?B?djJXZzZwT0tuMTVLSUFhN2FIa3ZyUVBqTUplNng5SytKcThjMElCMVRNa3VL?=
 =?utf-8?B?Y1pkVnJRRDZHWmpDUzNpUTFmeng2Y0djWkhhSWlGM09DMzRubDNTb2VyRk1q?=
 =?utf-8?B?ZnhqZTJsNjlOYjJhc3pUOWd6cjlWa1dUOEVoWkdoS2s3eFVUQVVPSWFmUXZX?=
 =?utf-8?B?blNzbWlXR2ZLcVhnRzBlak5OaUVLTEJMQUdVR2MyeHZ3VEh4MFVrSWFzejF0?=
 =?utf-8?B?d1FLWUszWnNjcXBOVWZkRE5lK00rY2p1NE1jMHNwaG1iWC82ZnFQdXpyUXg4?=
 =?utf-8?B?bFNPTXlmdGRwMTYwbTdIeUdYWWNXOVVFMTh5dGc5aGV3RndCMm01dFh1YkF6?=
 =?utf-8?B?UG5DYTNuQy9PNVF4S0FMVHNaVDFUM1FZNVZEbWxGTGxCbDdYdzRKNmFJTDRi?=
 =?utf-8?B?cFhqem9SVFhPRFoxRWtGK2NSNjRmNDFNZXppdGYyQUdLamZwOW43K0UvcTYx?=
 =?utf-8?B?bklkSG50T0dJT002ZS9FekRVeCttSkwyU2RTQnRSVzRmeGlRdkhLY0ZlV1ZB?=
 =?utf-8?B?a1FUWm9uMzV2bHVzZEpVcndaVzBOaWZaVmFyWnFzQjQ0UG1SUCtPRW0reDhC?=
 =?utf-8?B?L2RXemlTakx5MXVCb0I2NzlNR0VWM2JDNlRROEJZWjBzaGN4TEt4VW0zRXNK?=
 =?utf-8?B?Y1BqQklYdFBOSDJ2bDZMSWs0alYvT0MrTDVHaG1Gd3ZnczVBQjd2NHMwMXZq?=
 =?utf-8?B?Qm9uMnhaQUkwTUx5ZG9INUtQam1RSzk1TzVhQUw2K2ErVTA0RVE5UTQySGhz?=
 =?utf-8?B?OW40U2wvbUJ5UlRFVWlleldYb2UwaFY0KzNHVzJXVVB3dmNkTVpUOXZoaENL?=
 =?utf-8?Q?GBL584SA11QRdWihom3tsDrxTpAqroq4Qta9iT1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1ea1a2-364e-431f-40f7-08dc35f8d9f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 11:56:50.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6411

On 2/25/2024 2:52 PM, David Yang wrote:
> Helper functions extract common operations on platform drivers.
>
> During migration to devm APIs, (virtual) fixed clocks were found hard on
> devm APIs, since they often depended by crucial peripherals, thus require
> early initialization before device probing, and cannot use devm APIs.


We have core_initcall() in drivers so CRGs are probed very early. This 
shouldn't be a problem.


>
> One solution to this problem is to add a "fixed-clock" node to device tree,
> independent to clock device, and make those peripherals depend on that.
> However, there is also some devices that do use fixed clocks provided by
> drivers, for example clk-hi3660.c .
>
> To simplify codes, we migrate clocks of other types to devm APIs, while
> keep fixed clocks self-managed, alongside with struct hisi_clock_data, and
> remove devm-managed hisi_clock_data.


Do we really want? How about leave old SoCs alone and just introduce a 
new set of APIs for new SoCs?


Just like CCF, devm_ functions are simply wrappers of old APIs with the 
help of devres, the old APIs are still available.


So for HiSilicon, I think we can take a similar approach, i.e., add a 
new set of wrapper functions with the help of devres rather than 
modifying old code.


The implementation of officially provided devm_ APIs can be a good example.


>
> `hisi_clk_alloc` will be removed in the following patch.
>
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>   drivers/clk/hisilicon/clk.c   | 157 ++++++++++++++++++++++++++++++++++
>   drivers/clk/hisilicon/clk.h   |  46 +++++++++-
>   drivers/clk/hisilicon/crg.h   |   5 ++
>   drivers/clk/hisilicon/reset.c |  42 +++++++++
>   4 files changed, 248 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
> index 09368fd32bef..e50115f8e236 100644
> --- a/drivers/clk/hisilicon/clk.c
> +++ b/drivers/clk/hisilicon/clk.c
> @@ -88,6 +88,25 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
>   }
>   EXPORT_SYMBOL_GPL(hisi_clk_init);
>   
> +void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
> +{
> +	if (data->clks) {
> +		if (data->clks->fixed_rate_clks_num)
> +			hisi_clk_unregister_fixed_rate(data->clks->fixed_rate_clks,
> +						       data->clks->fixed_rate_clks_num,
> +						       data);
> +		if (data->clks->fixed_factor_clks_num)
> +			hisi_clk_unregister_fixed_factor(data->clks->fixed_factor_clks,
> +							 data->clks->fixed_factor_clks_num,
> +							 data);
> +	}
> +
> +	of_clk_del_provider(np);
> +	kfree(data->clk_data.clks);
> +	kfree(data);
> +}
> +EXPORT_SYMBOL_GPL(hisi_clk_free);
> +
>   int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
>   					 int nums, struct hisi_clock_data *data)
>   {
> @@ -341,3 +360,141 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
>   		data->clk_data.clks[clks[i].id] = clk;
>   	}
>   }
> +
> +static size_t hisi_clocks_get_nr(const struct hisi_clocks *clks)
> +{
> +	if (clks->nr)
> +		return clks->nr;
> +
> +	return clks->fixed_rate_clks_num + clks->fixed_factor_clks_num +
> +		clks->mux_clks_num + clks->phase_clks_num +
> +		clks->divider_clks_num + clks->gate_clks_num +
> +		clks->gate_sep_clks_num + clks->customized_clks_num;
> +}
> +
> +int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks)
> +{
> +	struct hisi_clock_data *data;
> +	int ret;
> +
> +	data = hisi_clk_init(np, hisi_clocks_get_nr(clks));
> +	if (!data)
> +		return -ENOMEM;
> +	data->clks = clks;
> +
> +	ret = hisi_clk_register_fixed_rate(clks->fixed_rate_clks,
> +					   clks->fixed_rate_clks_num, data);
> +	if (ret)
> +		goto err;
> +
> +	ret = hisi_clk_register_fixed_factor(clks->fixed_factor_clks,
> +					     clks->fixed_factor_clks_num, data);
> +	if (ret)
> +		goto err;
> +
> +	np->data = data;
> +	return 0;
> +
> +err:
> +	hisi_clk_free(np, data);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hisi_clk_early_init);
> +
> +static int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
> +			     struct hisi_clock_data *data)
> +{
> +	int ret;
> +
> +	if (clks->mux_clks_num) {
> +		ret = hisi_clk_register_mux(clks->mux_clks,
> +					    clks->mux_clks_num, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (clks->phase_clks_num) {
> +		ret = hisi_clk_register_phase(dev, clks->phase_clks,
> +					      clks->phase_clks_num, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (clks->divider_clks_num) {
> +		ret = hisi_clk_register_divider(clks->divider_clks,
> +						clks->divider_clks_num, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (clks->gate_clks_num) {
> +		ret = hisi_clk_register_gate(clks->gate_clks,
> +					     clks->gate_clks_num, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (clks->gate_sep_clks_num) {
> +		hisi_clk_register_gate_sep(clks->gate_sep_clks,
> +					   clks->gate_sep_clks_num, data);
> +	}
> +
> +	if (clks->clk_register_customized && clks->customized_clks_num) {
> +		ret = clks->clk_register_customized(dev, clks->customized_clks,
> +						    clks->customized_clks_num, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int hisi_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct hisi_clocks *clks;
> +	struct hisi_clock_data *data;
> +	int ret;
> +
> +	clks = of_device_get_match_data(dev);
> +	if (!clks)
> +		return -ENOENT;
> +
> +	if (!np->data) {
> +		ret = hisi_clk_early_init(np, clks);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	data = np->data;
> +	np->data = NULL;
> +
> +	if (clks->prologue) {
> +		ret = clks->prologue(dev, data);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = hisi_clk_register(dev, clks, data);
> +	if (ret)
> +		goto err;
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +
> +err:
> +	hisi_clk_free(np, data);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hisi_clk_probe);
> +
> +void hisi_clk_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct hisi_clock_data *data = platform_get_drvdata(pdev);
> +
> +	hisi_clk_free(np, data);
> +}
> +EXPORT_SYMBOL_GPL(hisi_clk_remove);
> diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
> index 7a9b42e1b027..87b17e9b79a3 100644
> --- a/drivers/clk/hisilicon/clk.h
> +++ b/drivers/clk/hisilicon/clk.h
> @@ -17,10 +17,12 @@
>   #include <linux/spinlock.h>
>   
>   struct platform_device;
> +struct hisi_clocks;
>   
>   struct hisi_clock_data {
> -	struct clk_onecell_data	clk_data;
> -	void __iomem		*base;
> +	struct clk_onecell_data		clk_data;
> +	void __iomem			*base;
> +	const struct hisi_clocks	*clks;
>   };
>   
>   struct hisi_fixed_rate_clock {
> @@ -103,6 +105,39 @@ struct hisi_gate_clock {
>   	const char		*alias;
>   };
>   
> +struct hisi_clocks {
> +	/* if 0, sum all *_num */
> +	size_t nr;
> +
> +	int (*prologue)(struct device *dev, struct hisi_clock_data *data);
> +
> +	const struct hisi_fixed_rate_clock *fixed_rate_clks;
> +	size_t fixed_rate_clks_num;
> +
> +	const struct hisi_fixed_factor_clock *fixed_factor_clks;
> +	size_t fixed_factor_clks_num;
> +
> +	const struct hisi_mux_clock *mux_clks;
> +	size_t mux_clks_num;
> +
> +	const struct hisi_phase_clock *phase_clks;
> +	size_t phase_clks_num;
> +
> +	const struct hisi_divider_clock *divider_clks;
> +	size_t divider_clks_num;
> +
> +	const struct hisi_gate_clock *gate_clks;
> +	size_t gate_clks_num;
> +
> +	const struct hisi_gate_clock *gate_sep_clks;
> +	size_t gate_sep_clks_num;
> +
> +	const void *customized_clks;
> +	size_t customized_clks_num;
> +	int (*clk_register_customized)(struct device *dev, const void *clks,
> +				       size_t num, struct hisi_clock_data *data);
> +};
> +
>   struct clk *hisi_register_clkgate_sep(struct device *, const char *,
>   				const char *, unsigned long,
>   				void __iomem *, u8,
> @@ -113,6 +148,7 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
>   
>   struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
>   struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
> +void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
>   int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
>   				int, struct hisi_clock_data *);
>   int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
> @@ -154,4 +190,10 @@ hisi_clk_unregister(mux)
>   hisi_clk_unregister(divider)
>   hisi_clk_unregister(gate)
>   
> +/* helper functions for platform driver */
> +
> +int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
> +int hisi_clk_probe(struct platform_device *pdev);
> +void hisi_clk_remove(struct platform_device *pdev);
> +
>   #endif	/* __HISI_CLK_H */
> diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
> index 803f6ba6d7a2..bd8e76b1f6d7 100644
> --- a/drivers/clk/hisilicon/crg.h
> +++ b/drivers/clk/hisilicon/crg.h
> @@ -22,4 +22,9 @@ struct hisi_crg_dev {
>   	const struct hisi_crg_funcs *funcs;
>   };
>   
> +/* helper functions for platform driver */
> +
> +int hisi_crg_probe(struct platform_device *pdev);
> +void hisi_crg_remove(struct platform_device *pdev);
> +
>   #endif	/* __HISI_CRG_H */
> diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
> index 93cee17db8b1..c7d4c9ea7183 100644
> --- a/drivers/clk/hisilicon/reset.c
> +++ b/drivers/clk/hisilicon/reset.c
> @@ -6,11 +6,15 @@
>    */
>   
>   #include <linux/io.h>
> +#include <linux/kernel.h>
>   #include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/reset-controller.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> +
> +#include "clk.h"
> +#include "crg.h"
>   #include "reset.h"
>   
>   #define	HISI_RESET_BIT_MASK	0x1f
> @@ -116,3 +120,41 @@ void hisi_reset_exit(struct hisi_reset_controller *rstc)
>   	reset_controller_unregister(&rstc->rcdev);
>   }
>   EXPORT_SYMBOL_GPL(hisi_reset_exit);
> +
> +int hisi_crg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hisi_crg_dev *crg;
> +	int ret;
> +
> +	crg = devm_kmalloc(dev, sizeof(*crg), GFP_KERNEL);
> +	if (!crg)
> +		return -ENOMEM;
> +
> +	ret = hisi_clk_probe(pdev);
> +	if (ret)
> +		return ret;
> +
> +	crg->rstc = hisi_reset_init(pdev);
> +	if (!crg->rstc) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, crg);
> +	return 0;
> +
> +err:
> +	hisi_clk_remove(pdev);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hisi_crg_probe);
> +
> +void hisi_crg_remove(struct platform_device *pdev)
> +{
> +	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
> +
> +	hisi_reset_exit(crg->rstc);
> +	hisi_clk_remove(pdev);
> +}
> +EXPORT_SYMBOL_GPL(hisi_crg_remove);


-- 
Regards,
Yang Xiwen


