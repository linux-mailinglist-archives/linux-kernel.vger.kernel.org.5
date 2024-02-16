Return-Path: <linux-kernel+bounces-68981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D78582F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A18E1C22335
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6064B130AF6;
	Fri, 16 Feb 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XRMG8mQI"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120443687;
	Fri, 16 Feb 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102139; cv=fail; b=k9rZ+sWqfwxPYJ1i4/ReeVK41yekcRGVH5vWYBDWxP+M8k3GUv1KqHPtXh5ULdL1giddh31Nu+AC/v3nKo+IIzCRF6Yvbx8qXoiFMjTjmUn5W8UWM9enapFk4GOgg87YdtBEyp7XlwO/YKewi15E3XOOTnSgFNO1eMLAo8nPYNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102139; c=relaxed/simple;
	bh=nZPh7U8jMpEVfUTkdWCqV/rfgpB+7nzsgrd3WFyMufQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7H2uTxeOCm3r737OH/tdRDe7ITnZuXJrDHTbL9bYNGLBz1lBlLIx8ScqXslSnt5CVA61TkAtYf+MA3gvmJqDYKDuYLB0JGAp/DuPmcZbhitPAx0WqKgoZGtuIyC5Yi3d8xuZid8geZ2FdavTo3elYNXLkhMWyH5ULIFzowdyOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XRMG8mQI; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIIbIEDp9uUzbBr2GhwvxijNIlSDbNNz5cruqXXqCLemIE8kJjnvwfC6/qfOwIfwTg5FFBLB951d7ZQmvqI8AnfwxWPnt2zxkkUn2S5hJmVUckD9fPqkBNWoHUNbpFMowDI477OcMKW83SGgBuZNJ8eEKNQR9rRW7ECzwRMX53qoYUNvLUj1mGHk03jclBFYCL9sQgAoePgdwaw1NHlJYdEcWkd/cICFEZPHrTRp+6uBadE02wnw4S0aJu8cET7RfjxSVV4ihTpC3+dH1JNdV+fJxpIMuYf9KCxUhCKvSRDLBhnRRs29TRbzh7EAaKBbVpaOho6A8LmSso+PCur8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikO3JUPspq4CY46A+RmcWJxQ7DgLwtC9l9rGe+ID0Iw=;
 b=fwvx28xSF6UY7TypQXQv0tjgy6t+uHahySXzxQIsIVzUa+AGwCUIz49DKOVGlCb8WRkSVit/O5uZqa4vCu7PeRMh6dFRXvuThw2xJ9vhH4JioAvaBmHjVHC/RW3Re5H0xd9cT2hTWVHJB1crfQgleu11bFgRb0zwojkzDu5uPTD6y3//1PnmN3l8I0XGP0ys06j9zRrBWwD9nnYxgLzI2IzGxYCnBDmo6Piqun3bVdmXonqKvBcOp9Ml8ixl4ZazFUMl4XdBvMQfLu0xX6Pu92axt7N01r9QDlvuzkPB1skbf86Njgn1dVkR5B9byTiPFhARFYJKxtk8/6Ff5oxXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikO3JUPspq4CY46A+RmcWJxQ7DgLwtC9l9rGe+ID0Iw=;
 b=XRMG8mQIKovw3bUhkzsLwJ0v3vO5VuWLRkS3qR8Tbu2jK7e9NJe1T4IiTcGapH12H/bA6AgtenUk7pKQsAZC8e0SqQFO+gUOmWeBbvkJyLfUll7rJYgd7m6yOOVCZlJ/TuJxzxH5QmJQC27IThftaH4iadQI7jnhQGzI9Jmngq7jAMMj/CWXYCYWAIZe8pZ/70vOr2D7qruJxFA5sXCqu5rcZQVQE2WYRc7HGgeyELCblqSK9lpXJfLue10aZOsWZHKX5l4J6jcP7CllK/L3uMZcIZ5oOXEz4sX7jQlyV4WnSrSCmoC5RDKDBpL5Tae172/PYh2GIRa4mPpNK51xdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 16:48:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 16:48:53 +0000
Message-ID: <c6a3fc6a-d21e-4b76-bfc0-82de2f729ad7@siemens.com>
Date: Fri, 16 Feb 2024 17:48:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: Add reserved memory for watchdog
Content-Language: en-US
To: huaqian.li@siemens.com, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, baocheng.su@siemens.com
References: <20240117060654.109424-1-huaqian.li@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240117060654.109424-1-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 77632b14-1095-43ed-7920-08dc2f0f28f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kGq/jJOnwQnwB2dnPidi5rWlNkmuWE+DaouIvqlPvpxcyU2LP67c1GKq9IUHG+8yGjnocuMqX3+qLbCtxZeQnKgivxebGOqrT4z2+g/M0mcDkafdWhd4hen0RKKSJ4D0Qe1pv518vOmz557v84iAQGDgcVRTqEY4Ncfk+VTI2isgNFwNEoZ7P3wRFdyp1fqAgmCBu9YtOKsQ39UN2TFzQo9wadEW1Pd64cBWNy0o0ARzFkZLtFTsfyuFWbWo2c69yQaV609CaDaq9xAR4vuj/448j1u2CyM4exHt3HHrTSHOo1vckbXqTOwtmOOX8PVlOGJaHD9GpahKgzInPmoa+d0dRd9A3Z1f/Ga9nTMuIjkn83oQ0X8Lo04m8xl2e8YMBuEs5AjhWy7sh8OxfYJUyG5iDrv33l5CeBl616p/2jmjxMKuTASb8jEHyjSg0ioc+nOF+SE1yhzjldCM8h2L2xeUpL7AoaVG1Ti0NIDFAJolQrtNOHFNlG30uXYfEpHOdku0w0SiAwXzUUtQKrMFNlI/knLnM4CGI53JyPY0r2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(44832011)(8676002)(8936002)(4326008)(66476007)(66556008)(66946007)(2906002)(107886003)(83380400001)(26005)(82960400001)(38100700002)(86362001)(31696002)(36756003)(41300700001)(5660300002)(316002)(2616005)(478600001)(6486002)(6506007)(53546011)(6512007)(966005)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1lJQnh2eGFrVUZEam1jWjB2Z3l4QjVXWWtiK1JKOXNyeTNTZ2FuNE1TMTNV?=
 =?utf-8?B?QS9xT3BtUnJsOEVnUlBCZm00cEswYlBFNmdyZXFUa1Z5czF2dmZoZHJjSzZ5?=
 =?utf-8?B?SCtpMmJGaWN5WFQ5M01oTEQ0VGd2bko1UzBQcmQ2eEhpNjZOd05Jcy8yV25s?=
 =?utf-8?B?cGs3RWE2Mzd3Nkd4NWJvRis0d0V2amxqdE1rcE56S1dVWnJOVmxmYmtCYWxH?=
 =?utf-8?B?THBEN0VSYVhWa1hsOGJpYTQ2TlVSTGM3bWtsUlpYcEIwSkJ4K0lYeU1WVjJC?=
 =?utf-8?B?L3IwOHJNTVdNTGxrcXNpVjJhT0VCeDJsKzhCaUZ2WXJqVkJieUl2WnZhNk05?=
 =?utf-8?B?Z0t6RnJzMkprbEVYZzZveTJCVGZMVGdOZk4waDl0R0xYWFA0N080QkNLYXY5?=
 =?utf-8?B?NlN5ZlpGZFpsMzFLOXhUZzVxQ2krTWRMUXNhUEluZXRocUcrQWVrME5QM092?=
 =?utf-8?B?d0tKd1ZWSmNMcTdKZEZ4N3NqQVJEeGFhazRJSGJYdVdDZDBJYTNrOS8wVVZK?=
 =?utf-8?B?MjRtakM2RVBsSWkzRks0MjVWUU4vVWlWMC84WXltRG9lUVRkN0l1aHQ2QXZ3?=
 =?utf-8?B?am42b2RMYS9lWU84eEk3MmowS0Y3L1ZSTzBMQ1VvVm5IODlkOWM3eUFWZDNp?=
 =?utf-8?B?WTBpUlgrWmpnZWZOL0dkQnNoZ0xySEdnaEJhTXBHa1NIWjdoRlJ0SWVzZXBo?=
 =?utf-8?B?dXhzVkxOVlg3azRPRUJWbkg0RWk1TzQ1Rm9WMHpEeXMraExTV28zUk1tYzY5?=
 =?utf-8?B?T21CeU05N3NGTU1HM3c4SnBNZlMrT2N2ZlhtZ09qakZoMzBuaWFlaHZtUXNq?=
 =?utf-8?B?aWFWV0ZDZVJ4MEpPRE5DaEhMU1RqSmljWmp6NzBIVXlhcTRSeUl1aUZzcGxW?=
 =?utf-8?B?SGw2L0JqQXpDdXllV0JoRmxvSzFubS9xeHBXd3JUWVR4cE9UZGRKQy9RdzEx?=
 =?utf-8?B?c1VPMldjOTFzOVV0OU5uWVcxbStLaXk1cW1UTE5oOVRvTXRtbzZ0SDh0eUI4?=
 =?utf-8?B?TGhGY1dGWWFnUi9uUjY5OSs4N2NFNW9lQ3o2RlVNYjB0elVsSU56RjhDQWJG?=
 =?utf-8?B?c25XMElIZ1NwZHZrWnpIeGljNHMrL3YrelVlcklhd1l4K2lrOTNkeHBrQ0ZC?=
 =?utf-8?B?b3JFK3EvdnU5NUZUTzM1RFh5bXZHZzNsSkF1UDJjTUVsaDRrZm1odDRaRWpK?=
 =?utf-8?B?bDc3cjc5MGttaVZObXZnekkwK2djZGhXNkJmM0JZTmxCcW1QdGlIcWNydEZ6?=
 =?utf-8?B?TVZmdFNzTklsRWQ4QWc4UVZiK1RUbmN4cEF1QmRWRlZMcmNFRUkyUHB2bm1Y?=
 =?utf-8?B?QUtEOHJJQVdabDh5d0M4eGZ0OGxFdExzUUhGVXB1UnJPZmxhK0tqY2Nkd3J6?=
 =?utf-8?B?a2ZXRHBRNGk0Mlk0NmVVZ0pBdHB1NUZJTnNXUnl5a0JVQ2xzaXY0cUl4dXN1?=
 =?utf-8?B?UmlBTHB6M2ErdGhybS9GbzRnVDFoYzlUN081RXFNbGh2YkNRM29NelZBclZP?=
 =?utf-8?B?U3Y5MlJab1VTUStvRWVwQnZUZ1dLTmNDVkFnak0rWjBuZVp2VWZXUXM5YStV?=
 =?utf-8?B?eExPSDF4M29kd3pSQ1Mzd0ZhY3I2R2tkWEs5azFwa2V2SG5sZmY2M2xXQkZq?=
 =?utf-8?B?eEh0NFBIUkxMMkk2dmtKVUg5Um1Yb0xRMkl6eFhzNTNEbXZOZ3NtUTFWZ2lK?=
 =?utf-8?B?VlFzTDVjY1VXREhZazYxeGc5Mkh2anhBenBFNFZvWkl5d1Q2R3A3STZ4c0c0?=
 =?utf-8?B?N2pydHVLbzRLdDh3Y2dwdDkyM0RLY21sZ3Y1cXg1ZEliZ3d3U1hSS0tkODRk?=
 =?utf-8?B?RFFob0V5azJpZE9jZTR6cEJ1WCtMeTZQTlFMRWVGbHVwRDZhTjEwWWovcXMy?=
 =?utf-8?B?NmI3MTJaTC9rbzJTT2hZTnUyck5NN2NaWGRaUGNtUm1EVm9WRjhGN2tHVDNj?=
 =?utf-8?B?UHg3ZVZkRGRkSjAwcmI0VWU0aWp6bTlhcWNwbFNlQlJncGk1djFSdTlCZXZl?=
 =?utf-8?B?SFh1Y2NrdzNXK210V3dGN2VTNDNGVlA4ZS9kTzNtRFhVdUY1Y2RYQ01EZlM2?=
 =?utf-8?B?cDZYcXN3NTd3WkZQNDE4djV5YS9BZ2JnbWI4MTlYbWhTRlp5dGNRYTBsQ0tQ?=
 =?utf-8?B?dDU4NDVwRDZtbTZUcDBmYzBka04wUXlIemF1d3YzbVo5VEFIUDd2ckx4S2hm?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77632b14-1095-43ed-7920-08dc2f0f28f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 16:48:53.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0v4XtenadS2jIGZ+unh0fd2O0nahM4j6nEByQA9Yr92yA4FkblIJ8fqv6f8JoWhh+obEN2npkPTucovxS25rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7101

On 17.01.24 07:06, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> This patch adds a reserved memory for the TI AM65X platform watchdog
> to reserve the specific info, triggering the watchdog reset in last
> boot, to know if the board reboot is due to a watchdog reset.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
> The driver and binding have hit the master, which could be found in the
> following link.
> - watchdog:rit_wdt: Add support for WDIOF_CARDRESET
> - dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29057cc5bddc785ea0a11534d7ad2546fa0872d3
> 
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 61a634afaa4f..88321799d468 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -75,6 +75,12 @@ rtos_ipc_memory_region: ipc-memories@a2000000 {
>  			alignment = <0x1000>;
>  			no-map;
>  		};
> +
> +		/* To reserve the power-on(PON) reason for watchdog reset */
> +		wdt_reset_memory_region: wdt-memory@a2200000 {
> +			reg = <0x00 0xa2200000 0x00 0x1000>;
> +			no-map;
> +		};
>  	};
>  
>  	leds {
> @@ -1427,6 +1433,10 @@ &mcu_r5fss0_core1 {
>  	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
>  };
>  
> +&mcu_rti1 {
> +	memory-region = <&wdt_reset_memory_region>;
> +};
> +
>  &icssg0_mdio {
>  	status = "okay";
>  	pinctrl-names = "default";

Is this not forgotten (now that my IOT2050 series was merged)?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


