Return-Path: <linux-kernel+bounces-36796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85183A6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E091D1F2396B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9018EAB;
	Wed, 24 Jan 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="WnUvEJC4"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9F18E01;
	Wed, 24 Jan 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092171; cv=fail; b=KfHqcl+SuXK0UeyYbZIUJKLjYMdUkqsaDSg+E9jQRkum5RY0P/GIOUTRneyGvK2uZ6x66CzJuC93IIbv9ztngPkKYwn2oI2KY7k2xs/IIZgmgMJAzdJzSiG63gSJRxlk4sSJYCvs5Uf019+UgpmPyGwj9K3gXe6JaCQ1V1R2G7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092171; c=relaxed/simple;
	bh=FVmP+FjzZrYVjuuVfw1MgR/a1Sk5AJx+kvUKieuXwn8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=szljI68x5FCbt4ICj/V0MOKjzCVmVDXVIxKc+WG0uZjsmuxle9joEProooaCE9oeZjr5auMK2zSzq32n7oqBw8CO7sR+PbezzVdxjXG01oLPR17V1kjv1XCyPmVGolzfr+rcTXQ+bqrEBV1l2GZ0RaTcpTwQIBaMaHCBxfxjzkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=WnUvEJC4; arc=fail smtp.client-ip=40.107.6.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja2p+muCzS+MoHLH2KK6itAO1bXCa+ilqjyiYCp5KvH5ykD97EH5l8Rmyljeces7WmvAxCA/tFAlts3hdp/3/tu3T+BblXQ1SEBzqJJ/rIFe8lIgTK2HKIh1v1OmQxC1sC/AitzLWccgeOmYkyHTsR3RjbivIRcT9k0f0ZfXgrSp87Iyv2ZD+kGd6AGsxikHJ31JJbkv8IR4XwPNiWYDREY6Gxt3Jf40vvDk61VrnSHWXxUACjn3idC3+SGsoq8n4HNTX2vE9RO5Tfa7fpzqrU3P4wNfg2o9YmIzRRN9hjm0IN4HBV3o2Mc7gawtt2TWB7bK2EKudia4syvjE8iPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui9eQ3DaHHThCy4XMcIClOnuFKuc7o+wsJq0T9gh+dw=;
 b=jYZ0HEXa/UBwapzJvz3LVCUMMAuVl2stMZSQ2eAzLFQsFdW21MSEjt3Elr+H0ubZjc5IzJ7IUgFDgvMJsYtl+i4ZoFDA6fvq6J2zQ8XKfHSFzybgxaumxCeL9NlthxXuDeiEQAbVByTXgrMqYX7D7/6aYUpu2LKgtTRWto6KcuQZJDPR/ZT8W4SS2cswYplxp2NdudBaQF9ahGSPQxd0977qYK8y6ZjXPA6aEvsXO5eomIrQ979ihM4hRRq3MPNl7g3NW8jEz8sPOTXEeykyPgds2po4PKV6+PH4VxuwBOby90GJSTd7dj6lVFc0iwVWScg+qkPtc6Wns21dCS5A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui9eQ3DaHHThCy4XMcIClOnuFKuc7o+wsJq0T9gh+dw=;
 b=WnUvEJC469BtTgtpptt9398c77TWOBEWRXErG4d2EylYx5tgepPdiP60vmMOBx8za+qirCVnjoz0V67UGg+92eCNSAXMxXQYfvu+akWATNrGF8khUMYioUb8Qw2DC93qVeBGlyZRYr2aCFRDv31+aNDaFdOueQ0uO3jQtiNODVGHQe28+4yPWsfDZ1B4Crtlx2syhkI0qv/LbdKs9yye+bEOMgpaxe/dHO+V3NC5q6PPzYb8gF+yaNUnpIRke8uK+BvARnCX5V+HgrTR2J2PphXMfe2UCttP49aGRQlnMfSSlO2jy3FC+3W/83FSkkG2BZ/9tyotCmR28Nl13IEMEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by VE1PR04MB7246.eurprd04.prod.outlook.com (2603:10a6:800:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 10:29:23 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 10:29:23 +0000
Message-ID: <916bad1d-7f00-4174-ae87-cda0b86d3610@theobroma-systems.com>
Date: Wed, 24 Jan 2024 11:29:22 +0100
User-Agent: Mozilla Thunderbird
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
To: Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com,
 matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com, lukas@wunner.de,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 christoph.muellner@theobroma-systems.com,
 Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
Content-Language: en-US
In-Reply-To: <20200517215610.2131618-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|VE1PR04MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 792d9853-d92f-4a68-e97e-08dc1cc75557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tT9KqSGHoNeqjGRsc6NeTdOIfOtkh0I8myEVqli6yXjsXjdTf2pzvGa/VXZIPr9hqfxZQcu2MQvu+RgfeUH7Z0kB+EDsMIu1evHQpQJAC/t6EEkZnuHh8QcMzvGKUanBZO9rAb6u6EoFp2fJnrdE/qzWsbtkprOvVkJAz/D6keAkLVGfRwiUuNRwvfYFUW42we3dXraK0ifZJgNswiR/MBePNTCylngN0ZyX/xUd4GfumoNThw3uInqUEsfktWmEg02bkWs5H2i4O6B8KoyQJCXVdwfhfGkgZUNooiPNzu+k2zPX9ktoN3dZphXqjjsqUOnRgS7EirVClLsMCaVVl2A0gxgB2ZeaYF6+spfJTfFiQdZiod/J6Mzdz1XEQglPGBvH6gFsGw/9q9PVArhgCSatOXfQR7Ai4KJ2pD8sDOb6lQgRqJpUDLU2X9g8+57rs6CUG5eyMpMzdxbyjncFoQq6+YO67HB6aSNKJvSm3n8YtafZIFsRiMzVp9v4jkhg9CnVy0wGJsbdPNAOzXNrdhtR6RKQy85IfAa7nMrcoKFglDPN0lva1vPB8KoRQz1GYT/cbnNDrN1s8kcAehXi+/P1N1O7lKS18PNFcuOifE3m0srpVHItXAqS+k6fKgNf0W5F0Wf+x+pyaUIuxWYQJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39840400004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(107886003)(26005)(6506007)(6512007)(53546011)(83380400001)(478600001)(4326008)(8936002)(8676002)(44832011)(2906002)(41300700001)(5660300002)(316002)(6486002)(66556008)(66476007)(31696002)(86362001)(66946007)(31686004)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emoya2xPemordE1RelpkVWsxdlprM2p5cFJ5aHRHbHZzbmQ2bWgxeUVjVVlJ?=
 =?utf-8?B?b3NjUURHNzdxcTBDbFRxMXdNS2JMNFR2WlE5MnpWS2NOcUxpanhZT1IrRVho?=
 =?utf-8?B?NXJBQlpFMXNBVzgvM0dUQ0ptdEh0M2hPQjFhRjVCVHZlRHZyeW9EVXdrNkow?=
 =?utf-8?B?cHBTUjU0UWZHNXVpT3hxU28xTG1JOEFFQmdLM09lalp3azNFbVVpZjFjMDlZ?=
 =?utf-8?B?WXBMZVp0c2JkVWI4SHNMOURIeXZBQjcxWXBjNUlSNnlod3RkN1NTVFIyZ25Q?=
 =?utf-8?B?bjhNZCt4SE9UMjRkWi9rRG1UL0htU0RZeXlpL2M1YldUQkhnNjhIWkZTTGhF?=
 =?utf-8?B?ZFloNWFDZ3NSL2l0RGNUWnhoY2I4ejhBWHhZUFE4bFBMSURITzlYS2YvaDRi?=
 =?utf-8?B?VlRiSlU3M0Q2dDlsbENSVlREQ2JRNVk1bEJtck01dGxSMXhSS2sxOWducWxi?=
 =?utf-8?B?c3NyM3JROVUyaTdSVFl2UUhHRDRKa3VlRGsvUFVTVzVuVkdtb3dnaitnMUZV?=
 =?utf-8?B?TGlLRHBXcUJWWUZLWnF4RHd1dllSb1M4cFhJRnRVSEt2WWhCN1RiSDdwUjZr?=
 =?utf-8?B?enN5UEVPSVpJZnhQVHRza0VZQ2VrNEJpWjFQci9EMGFUYjU0L1l0S0thVlA0?=
 =?utf-8?B?bzVMeTRPN21JOGZ5cnpQbkZwTFFSeGtGam1mMFErbE1TWkNJNTF1UEhRRGRy?=
 =?utf-8?B?Rk4rVVoySjBTWkg4Y09lV01JaHMrdW5GTklkc3dkdFhJWHd4YXNFSFpVTURW?=
 =?utf-8?B?ZnVCT29PQ2JVMG82SHk3UFF3cUp2QjhsaTN3cy81bnUvaFlralJkdkc5d2FQ?=
 =?utf-8?B?dUJ2SXJDck1VV0JzTjJzWGdUYjVKRXQ4QnBsVUFXcGNYZkdjTTR0Y0JzbjJP?=
 =?utf-8?B?RHRxN2lxaVp1UkIwTnZPUWRXUnkwcVJNdWsxUjNUeFJScWpIY1BROWF3S3Nk?=
 =?utf-8?B?UWx0eUlScm4zL1luNmt1RWpIeGdaaUdjcGE0UTF2ZzJWT0Qxd3FtL0k2b1lp?=
 =?utf-8?B?ajNRVnBXelErOTgyd1RibURpeXNkUEhFMS81YlRPV3RhS2tKcVJoMzdXMEdX?=
 =?utf-8?B?Z2pMcElRVVdXTW9MYnZ5am5oWVQ1Rm9KUitFdUpiY0o5RjBTY3B6UTJ0ai80?=
 =?utf-8?B?bXRLZEZXODlhempTV2hCYStKZHdUNnVqVjVIT245ZC9vcFpTZUFncVI3bXoy?=
 =?utf-8?B?ci82WjkySjJwUmxETmZuQVFUcDBLSXRzWHh6REFYMWpBdE5aT1hSTmx0MmZG?=
 =?utf-8?B?Y1dKZWZHZGxkT3RlTmI3MklNN3VIVGJVTjdXVytYREFGcGhyZEo5OVdWMGkz?=
 =?utf-8?B?RDIvaFNaVVBpVFR5NnRJdDkxemZhUTdpczZEaWhtYU9nQkMwcEZyV3NzTXYx?=
 =?utf-8?B?TWgxdlF5d1Q5end5Q2hsZ0s5dW1EbmlKWno2VTNGbXVXYk1kbzRkWnZUMk9B?=
 =?utf-8?B?a0RaaHJmZC9VMUlSV0tqV0pydU91QThkcC82Ykl3TGZRQ2FNVjlZUXYyU2ps?=
 =?utf-8?B?bXVJc0hXcloyY0lBcWRZdnFGMFU5a3Q3M25WT3NQNkIvTU4zcDdJbmRhRlBS?=
 =?utf-8?B?ajQ0QnJueE01MkVpL0hpcndWUmdKTEYwakszM0lmYnhKQStEWEZyTlVRMFVr?=
 =?utf-8?B?bzI2Wll4dGxCcXlTZGRKYmJzelY2cS8xYm9KajQzY0ZLNURvdjczZzBuR09Z?=
 =?utf-8?B?alp0bGhrSUxQL3Btc1JzTFU4QW1jbGE4TTZHRVVPc3YrUlY2dE5xSVEyaUxD?=
 =?utf-8?B?ZEtLRVoyeDNzZ2hVUEIyUHpUc0RDeWIybmxUTzlTMEZjUkhvTkJQd3p3Smdt?=
 =?utf-8?B?eWtyK2xST2NtQWdqNnNTM25iM0ZSVFR4VHRqQUdFd3Y1Ym9Oa2pyYTVpYmdy?=
 =?utf-8?B?UlU4TXphUm1ocm9CL2hudFpzMEl3WVF2cnB6NDBMRlBxaHg2Vm90ZE1RZlNY?=
 =?utf-8?B?cjhzanQzdmRBbTNLS1h5UmJuWXkrdEJOeVdxU3R3bDErVG9lb2VKM1BZNjM2?=
 =?utf-8?B?TVJSY0F6bjc0eHVjNVl4dmtHNXlpU2ZnUWpMOFBxK0NKMjRNTklrSVRCYUlF?=
 =?utf-8?B?WXJ6enFwYUJCNDFvOWhOY3A3RW5pc2pUaytGbytNeUdDK0l5UUZnU1hIeDJJ?=
 =?utf-8?B?Z1ArQlpxTGlGbWtCNEQ0cER2ZnhNZjdPYUVlV3ZxVXJ3aVhETDN4T2E0Z2V0?=
 =?utf-8?Q?tl5IFVWAItdPy/R9qDPY454=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792d9853-d92f-4a68-e97e-08dc1cc75557
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:29:23.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OO7Kra6SLlK+RgpprQoEdhT5UI1Peq0aZSoccxN90vL+qAST5Zh2uwWFvp6aPoNCr2ZNunjQ6zsIRHkkUNZi7iH6czYc1cWyAEnQFv+bx32bOabioGNJrFX27CeQomuy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7246

Hi,

On 17.05.20 23:56, Heiko Stuebner wrote:
> From: Heiko Stuebner<heiko.stuebner@theobroma-systems.com>
>
> The RE signal is used to control the duplex mode of transmissions,
> aka receiving data while sending in full duplex mode, while stopping
> receiving data in half-duplex mode.
>
> On a number of boards the !RE signal is tied to ground so reception
> is always enabled except if the UART allows disabling the receiver.
> This can be taken advantage of to implement half-duplex mode - like
> done on 8250_bcm2835aux.
>
> Another solution is to tie !RE to RTS always forcing half-duplex mode.
>
> And finally there is the option to control the RE signal separately,
> like done here by introducing a new rs485-specific gpio that can be
> set depending on the RX_DURING_TX setting in the common em485 callbacks.
>
> Signed-off-by: Heiko Stuebner<heiko.stuebner@theobroma-systems.com>
> ---
>   drivers/tty/serial/8250/8250_port.c |  7 ++++++-
>   drivers/tty/serial/serial_core.c    | 10 ++++++++++
>   include/linux/serial_core.h         |  1 +
>   3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 6975bd3ecb7d..9e8fec85d1a3 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1444,6 +1444,7 @@ static void serial8250_stop_rx(struct uart_port *port)
>   void serial8250_em485_stop_tx(struct uart_8250_port *p)
>   {
>   	unsigned char mcr = serial8250_in_MCR(p);
> +	struct uart_port *port = &p->port;
>   
>   	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
>   		mcr |= UART_MCR_RTS;
> @@ -1457,6 +1458,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
>   	 * Enable previously disabled RX interrupts.
>   	 */
>   	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> +		gpiod_set_value(port->rs485_re_gpio, 1);
>   		serial8250_clear_and_reinit_fifos(p);
>   
>   		p->ier |= UART_IER_RLSI | UART_IER_RDI;
> @@ -1597,9 +1599,12 @@ static inline void __start_tx(struct uart_port *port)
>   void serial8250_em485_start_tx(struct uart_8250_port *up)
>   {
>   	unsigned char mcr = serial8250_in_MCR(up);
> +	struct uart_port *port = &up->port;
>   
> -	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
> +	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> +		gpiod_set_value(port->rs485_re_gpio, 0);
>   		serial8250_stop_rx(&up->port);
> +	}
>   
>   	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
>   		mcr |= UART_MCR_RTS;
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 15ad8737b72b..c0d3ab32b49a 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3149,6 +3149,16 @@ int uart_get_rs485_mode(struct uart_port *port)
>   		return ret;
>   	}
>   
> +	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable",
> +						      GPIOD_OUT_HIGH);

The half duplex emulation can be disabled on-boot or later-on using 
ioctls in systems that can switch between half and full duplex modes. In 
that case this gpio should probably be released as it can probably 
prevent enabling the transceiver-sender mode. I suggest we set the gpio 
to output active in the em485_init callback and stop driving it in the 
em485_destroy callback.

Regards

> +	if (IS_ERR(port->rs485_re_gpio)) {
> +		ret = PTR_ERR(port->rs485_re_gpio);
> +		port->rs485_re_gpio = NULL;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Cannot get rs485-rx-enable-gpios\n");
> +		return ret;
> +	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 108f95411471..dfe18ddb1674 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -253,6 +253,7 @@ struct uart_port {
>   	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
>   	struct serial_rs485     rs485;
>   	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
> +	struct gpio_desc	*rs485_re_gpio;		/* gpio RS485 receive enable */
>   	struct serial_iso7816   iso7816;
>   	void			*private_data;		/* generic platform data pointer */
>   };

