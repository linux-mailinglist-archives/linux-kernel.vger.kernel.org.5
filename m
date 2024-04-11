Return-Path: <linux-kernel+bounces-140473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 837EA8A1524
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F7E1F22334
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3821145FFA;
	Thu, 11 Apr 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hqLMUl/q"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2109.outbound.protection.outlook.com [40.92.103.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97E28FD;
	Thu, 11 Apr 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840300; cv=fail; b=YRFgx17A2//AVONOnLv6lFriDwIoEyX18qJMKg3o+s9i+SAClcwqbLJeYLTCSvIa3LLe4cqppTBGF26cSv0dq3fDGRIbz3CQe56x2oMUE7+gNqyLwYfJL/gVaKDO2D01bYZWN6/i92Bg+eZkm1tlBkgMU3oumHYf4SiJxHn9sVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840300; c=relaxed/simple;
	bh=IcsbCcQqwtEaflYnBLhCp6z8BjKYRRm8lVzQSuSs1Ho=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V861zgyDi3e9Rgi2GaXhNwrxRDs0QVn4KurFF/k0KtCW65OMeSJzENwufT3ZI66yPM1tm92Qgo0R+wo83zVKa0zwmYxoZXUENpunUaNoGAI/WZ0HtlWGJI26UAfv2h5GE7MjmPwku3O9VrKgN2Ee7qSk/JSMryjkk8G3qLNV31I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hqLMUl/q; arc=fail smtp.client-ip=40.92.103.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0rmVRCkSB7uY7Qv8kgIRvlsmxO8PjegO46id2Po0evBoLtMLyGD804aidjuagPhEfRzIh3m98giYbH1OjxxdHIgwFr0iSSIfKKw2EzHgIevjvqrOY3l/8kRPDZikf/LPCLvKBXEuQ81RVyv4AsKq/sAEqMaKoxbSzVzIDUzQKfvPRVThxzDUI39ViSyV1XvdacEmiSoY3Y7Kel8aTpxWu69aCgfNBnEyl1N9JJICcZ4Ob35S8XuT9HsuHDuu+mFphf+Ysn7GsVwuxXShufEig5JgopLvSeoC3wzehtTY5zV650Y5XXrTijA7kYRHTzOJhHd7nCAyWswmSoDlv5z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMAwN2wBtFF6gkDJe8BqWPhiteRjwD9J1UVY2M4wgyQ=;
 b=nAzszUYrNioMeMyxe+0/tdbo2mb2KzzTlpSVFdt/0wINNSlI5GWA9qj/kv8r/f4h1IC6/8LdgHemNqbd6fzxa43GNuk0UySBE7/PrBpkjU5AQJjetq8DK+2RImJ+PNwPsizfPkz5Q8EoJa6YtJl0JWjZlxtB5NZfCHL6jrbIpvxdhfNeJsfJaeXeoeOujDfUaKnQJn1z97y++iF0LoYmBxhnKY53NdvBLc87QhNLGAzgDnmQ/7U9m/fxjw9ihupAmz+kfLVwNtzpfOerw4gZqfXXncPsESK56SaOIsMbVbIwj+hDUJwWf7SqXkmEv8koTqUNfSvg/KZ1Fqiu0nX+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMAwN2wBtFF6gkDJe8BqWPhiteRjwD9J1UVY2M4wgyQ=;
 b=hqLMUl/qytARA6RvwbjzGP3MRIuXoH1DrliBRvPOgxDswa4eIE0WJPwlTFsL7vhBpDr0DCjXF3nGci4nY9B1YGuM9FY5YcXxqnHRuHOCaf/HztgvMptqyhI/AxhnkmcXWn6pJA05VKSWXVQuUiHrjT1/xb7Kee+apDk/8xOpkdwW5m3U/7q62fYDWcN+vucFbuZNZIOn//LEEgFbgTCEpnuAV+vGcoZ/VCJyvuzRpU5X/zXHw0lFEvAusqXRettTX2K5UYDisZTKS+eNt3Asr0G7kvSH3m8XPs4hdz4rWeC/ui8uPKg0cInYCek/ZSjBA2tcHDdN9yRtlukiwVUttg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1524.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 12:58:09 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7409.046; Thu, 11 Apr 2024
 12:58:09 +0000
Message-ID:
 <MA0P287MB2822BC109267BD20922FB581FE052@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 11 Apr 2024 20:58:05 +0800
User-Agent: Mozilla Thunderbird
From: Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v13 4/5] clk: sophgo: Add SG2042 clock driver
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com,
 xiaoguang.xing@sophgo.com
References: <cover.1711692169.git.unicorn_wang@outlook.com>
 <816122e9f22ddd9927e81e627be7f4683ba5c9e8.1711692169.git.unicorn_wang@outlook.com>
 <433e01f22ce5472aeb28cf0182d951bd.sboyd@kernel.org>
In-Reply-To: <433e01f22ce5472aeb28cf0182d951bd.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [odXi9fTYkMseVPpNykqV21cWAwssBmP+]
X-ClientProxiedBy: SG2PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:4:7c::32) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <f96e7227-9441-45ef-8c08-95d21d2e78de@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c98875a-ee82-49ba-1290-08dc5a2709b0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d+6lYQV6IMzMB00BeB/FtGaTdjoRDDzGGd6bg1yoTqI2OBdsy6gIojzPpE4rwBxEqePAxn8yxcVgMiVx3viozEjx+/yfHNOPTobDlEStTt5mUcwCXmDJuS2pS2JE0kmK8vYTTXkyY8/FHuA6CCCA9JMS/JaHTlh0klSvOWGIMIo/E62R14FDPXMAh/Eu1pkNlvhH8mrYfSNdcPLrNS24CbLS4ZVwVZOAEr77F7r3iTQOb9sLfw5vvXKM0toQAltxfaldwCP0yg42/eg1A1DG01d2daEQFmgZCV5YDwjLCmdZbnpqfBEdfm6MRWKixiAap7b+AbnhG6ZjAMm2yH1mZsCljwNJz8jnRKzkHaOWGPcM2OiSokm29KwIY23ut+5J6pp3U675VUw/w29UTjKz8nHTE9qpOzXTskWesL2v5eTtkLBgAcY1JeosIalO3w2oV6o+PbYBAc6rqfA8cUMP0vUj5MbCqSng7e8gvzT8AxmryDQz3237Fo0LbNBHe4dVLzMelaEbP+nF8VrYA2nmpZzJmhIblFke/SFULEaTvBCretg7AKqVm1la5nF+xG6L
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJlVDhETjNpSGsvNFFRUGFCaFplc3I2M1pNaThvVHZXM1FLaGZGRGFad1lL?=
 =?utf-8?B?dUk0U25VaU5VNk9tOHRWUXNkZWVRdHNQWnRDaEkvZWk2NGFpZSt5NzAwN29X?=
 =?utf-8?B?Nm41YXZuOVZYbkpxbVgwYnRhU3FrWEZweUNQb0QvbGVFSExwSmFwdFR6b25J?=
 =?utf-8?B?c2p5a0VmOUpnN0xyL1NqYS93VVZvR3hzTUxsSjFqdWZnTXdBMk5zNklmTVBR?=
 =?utf-8?B?WG9BWGJFbXRvVVFwRVorWVdmREVuNlBTUkVHUGY3NDhGUjNmZUlLMEE5NmZ2?=
 =?utf-8?B?UGVlT0ZWcmo4VHZkc2h3VmRvVmwvWjJHTHFBQlRscm94R0crdXJENjlOR3Jv?=
 =?utf-8?B?RVpQZmtscjV4MWhLRHRNMC9qMkRQQkEyWkNlcGdoaDdSQXNFSWRoS2lxdGJp?=
 =?utf-8?B?V3k0SmlzR2gyRFI5ZVV2clBzdHZON1N5MFBpdGMzU0RnQzVuazV3WWZMVnFq?=
 =?utf-8?B?eXJWLzAvWkUvMFhob0xORnZsV0VtclVOSXl2OVBpNVYzdXN5R29NMHg3L3lV?=
 =?utf-8?B?aUNzc1pTR0xFYVZYOUJnd2pqa2djWGNvZVEvbFVQZGh4N1lTTU9XWnBMNm01?=
 =?utf-8?B?dlh0aWlJcG5USEZubjRlRzJFQlZrWDAzSEVyWHRBQnFhRjR1Y2F3YWpYMDN6?=
 =?utf-8?B?YmFKSTdEbk15ejNLbGJPNklzYzZvT2c3dTFrbjZ3RWQ5clFSNSt2a0xYc0tj?=
 =?utf-8?B?UGQ2T3EwVS84dDJjVXQ1RFRvbVc3NHNvWTA5WlV1Yisvc294ZG0yMkFacnRV?=
 =?utf-8?B?RXJCUUk1cFFvb2ZldnhKZFpZZnlvQ1A0QTdXYTk2MktIZnprTkxOZ2NtUDlE?=
 =?utf-8?B?RVdnS0VvQXNneElVS2txaDZmdDkwazNtZ29BMkZQK3Q4REJvUEdMTGhldVdM?=
 =?utf-8?B?Z1o1cmxKOXRkY2JxanRvbkhaNUw2V2krMnVKWFRGOStaekRVRERjMHJPMldO?=
 =?utf-8?B?R3Zka2RpUWtnVGdISHF5TlpNZ2FVOG5wd0hJVThXdmRoenBuNXRDOXlmUVlQ?=
 =?utf-8?B?dlJkNkg4Mmp6Mjh4OTNmUXZ4QlFEREV1cWg0ZCtPbFp5Y0tDME1aSzJlL3Ev?=
 =?utf-8?B?RTVXZUFCamc2elluS29mS2lDNnRjU2hBY3J6ZlBCWjNLSjFHSDN5RGkxZGx3?=
 =?utf-8?B?cVV4UFVyOUF4YW5YY1FYdDBrck1KSVZLKytDMjNrZlloN3MyUllYaG12c3VY?=
 =?utf-8?B?Q2U1b1BacVkrdzRCKzBxUjZIMDJ2US82Mk1FNGZpcjBIUUdwMnExTThiMzFj?=
 =?utf-8?B?ZVJGellXSXQzeFFUU1BaNWpTMTJOVjU0S1JMZVk3N2QwWTFsVWM0bGpiMWM1?=
 =?utf-8?B?eDdiTVhkZzcxTHZBUG1EZEk4ZkltVG8wajJUd00vbmFlL3RMdDdkSVczNDMx?=
 =?utf-8?B?K1dnUmU5K2xGU0R2NnNrZ1Eybmd5U0lSL1RzMXJuK3ExbVNZdTUrSzIyNnVs?=
 =?utf-8?B?dE1uUlRsaHcwSHhoS21qSlpvS3RwLytObkd4TXpqbjZRY0VHdnV1TzV5YUhl?=
 =?utf-8?B?U0ZtSStEV1NOSHRFdFk2MWw5U3ZkeEk3UVg2dGU3eUE1czNnU0RqTjZZckdq?=
 =?utf-8?B?bG1kMzVRVWNhOUtoODJReDVlU0ZoTk56am1oRlg1WjNwdy9nTUt5dXZIOU51?=
 =?utf-8?B?bUx0TC9iTlI1VjdlK09zL1FGWUV6U0FBL0FHeXEwcEk1cXZVRTlFR3FHSzJX?=
 =?utf-8?Q?BDr1xdpgWDEytt2ICAak?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c98875a-ee82-49ba-1290-08dc5a2709b0
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:58:09.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1524


On 2024/4/11 12:11, Stephen Boyd wrote:
> Quoting Chen Wang (2024-03-28 23:21:40)
[......]
>> +/*
>> + * Note: regarding names for mux clock, "0/1" or "div0/div1" means the
>> + * first/second parent input source, not the register value.
>> + * For example:
>> + * "clk_div_ddr01_0" is the name of Clock divider 0 control of DDR01, and
>> + * "clk_gate_ddr01_div0" is the gate clock in front of the "clk_div_ddr01_0",
>> + * they are both controlled by register CLKDIVREG27;
>> + * "clk_div_ddr01_1" is the name of Clock divider 1 control of DDR01, and
>> + * "clk_gate_ddr01_div1" is the gate clock in front of the "clk_div_ddr01_1",
>> + * they are both controlled by register CLKDIVREG28;
>> + * While for register value of mux selection, use Clock Select for DDR01’s clock
>> + * as example, see CLKSELREG0, bit[2].
>> + * 1: Select in_dpll0_clk as clock source, correspondng to the parent input
>> + *    source from "clk_div_ddr01_0".
>> + * 0: Select in_fpll_clk as clock source, corresponding to the parent input
>> + *    source from "clk_div_ddr01_1".
>> + * So we need a table to define the array of register values corresponding to
>> + * the parent index and tell CCF about this when registering mux clock.
>> + */
>> +static const u32 sg2042_mux_table[] = {1, 0};
>> +
>> +static const char *const clk_mux_ddr01_p[] = {
>> +                       "clk_div_ddr01_0", "clk_div_ddr01_1"};
>> +static const char *const clk_mux_ddr23_p[] = {
>> +                       "clk_div_ddr23_0", "clk_div_ddr23_1"};
>> +static const char *const clk_mux_rp_cpu_normal_p[] = {
>> +                       "clk_div_rp_cpu_normal_0", "clk_div_rp_cpu_normal_1"};
>> +static const char *const clk_mux_axi_ddr_p[] = {
>> +                       "clk_div_axi_ddr_0", "clk_div_axi_ddr_1"};
>> +
>> +static struct sg2042_mux_clock sg2042_mux_clks[] = {
>> +       SG2042_MUX(MUX_CLK_DDR01, "clk_mux_ddr01", clk_mux_ddr01_p,
> Please use struct clk_parent_data or struct clk_hw directly instead of
> string names.

Hi, Stephen,

I understand that for clk_init_data, parent_names/parent_data/parent_hws 
are all acceptable. Why do you only suggest me to use 
parent_data/parent_hws here? Can you please explain?

Thank you again for your careful review

Chen

[......]


