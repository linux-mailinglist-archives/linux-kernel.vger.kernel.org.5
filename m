Return-Path: <linux-kernel+bounces-82718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D8868891
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1221F2365A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B392C52F7C;
	Tue, 27 Feb 2024 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="EqtZG98V"
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2137.outbound.protection.outlook.com [40.107.135.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA261B962
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709011401; cv=fail; b=F39wZCT7PYNy+2m8g7nVrlsybDEFjFGOYumvAfgLD0a4RZt7GuDAK3IvxUktc7FuPzNkCh+O8x0teM78OIIIiNQKICzB8QXQ7WVaymCcdQChj79tFFgp6wCOHqIPpTE4pIQZsuxfrjMjz4LlQvgeoOyJ+OyjZn3VCqljH0RzMnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709011401; c=relaxed/simple;
	bh=OOwD86e6P9SxG+SzzN7JGbOZK0D7771hT5e6RJDbaeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTqzJqz/XMUaEpwtIz33sEiLqdB9JoGXcw8jciikzjMHjZsf3+xHrEKdcNRhiHZLFAT2cpWtgm7Lo62A8jEdECE+D35zrR66QoFFLaT4OhLBrYqiRIIIGS/OVrJf3eZDwyZ2/EQb8Bq7bXuirL1S9sgZSEUIWojVqn4RBc22NfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=EqtZG98V; arc=fail smtp.client-ip=40.107.135.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAwV0cc88Jkt9Gvcjti14whKXbFj/SK6FRXlycyRkrPEljbFmWva+nP2FI+2LMQlUZamjPmegkwMBvzujm4/SjwiokHtpxKvqCDxj+14SSQCqukigxoP0+cddH5IhcLtAMo7UZCS4FLDszNtjaCK6gC6p9GlaO7k9bbDDob8QzMzc/HJTQk1f6OywFs6TebAy1FyjsnD9KW/b1r8UL5OEjBW70ZHMpTvvWsxDdkSeAkzu//jqYCF7HbGCpjQXfBVTaig2FOUjKEct0hBq3KNnMsRJCIdhdvzRTYRurVkg+8O9/P4xKFopwVNBGO7jTmK5l0BL/08Uw4nDKZiXo4rpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wmQgKy49GzrTExq8T87qOSKNTULbFbXFFNaOKSvw+g=;
 b=Qri9XIr20H7VO+Ai5PR9Z+vM3TRtwsngAKctb2dyfiRT7/pzlWzFXJxmjuupc3saeDlutCXCVrXq9Ry/bHXR8yJP+5s8MwGmVZ/8hQo35aSYX6LoxMuFs6UzVuruwuoDtyo8wZNfGKBANYWzI3eBjqeomxRjcUAkFHRtJRim5XwfkHvYYuO2UOt2q81QlAT07bGvKCxbIdF4ZAP4NDerTVmHK+Dablo0hOSYjizgdVUSNdbgVi3LZwzUatcvB30LF41+dNzUE9BHFZB1XLfbmhEyHK3xIL9GQW+OwiXiou4Vwiq3s2C6OuZj9LEJhCQq0RamMLTnpLMZVkW15hsftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wmQgKy49GzrTExq8T87qOSKNTULbFbXFFNaOKSvw+g=;
 b=EqtZG98VbfjQSS1YVFC4xrGM5Uk817s/5LLT9OCNDZC8+1U2euPF+CSEdYEcDJcLFbSpqUUcUYHopixN/yr7tIFjlfDq6hyb2UPxFlXiITo0k5nkDd0VKLCEDQxbAXJRfYQYFNzF/QtxzwwvpeHSESeh2QFII10L5AXtMvOfKgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR4P281MB3562.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 05:23:16 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f812:c649:c5e1:509c]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f812:c649:c5e1:509c%7]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 05:23:16 +0000
Date: Tue, 27 Feb 2024 06:23:15 +0100
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] siox: constify the struct device_type usage
Message-ID: <23jxondt6rjrmsxyuvlbe62qx4ke5qwhgkvm7ucqc36bmdji7w@juevvj5xedyy>
References: <20240219-device_cleanup-siox-v1-1-eb32ca2b0113@marliere.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-device_cleanup-siox-v1-1-eb32ca2b0113@marliere.net>
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR4P281MB3562:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e63750-ae28-439a-284f-08dc375433c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U9TLBS6ShNDVCa9U+XyyeASmSFGXN3t+Jz8WjFC5jJGBkCFczYfi05m9nEnfY2QTE/FmZL3UcAGe3WKgT6qQ4eEQWbRRdNX2Dlrthungkfy17BZXbH6LKU0V9yME5vumrNA7FObyOntOHE0CRlo1veLx467JOFoizBYI5r8SDD9h542ONyT/HayHA9U/ElJmemelpQp+r1XRsAHTLXCE22m5jKxHghChe0853knCZYKAw3ZDD0GCZxtt/GTHgmBxr2EvMogsJl7Av8z3YKpSTK0dHtNbaiVjD0aX1ybxD6sRVTASbJlIilD9a1R9ShM4PnTmchtqjJJ2eHFngRhAWRmytytspRK2Klfcf/aUcEe3F6DoS46HxyOy9+h80KiVeW3CxYtaFE3IsTAQN51b/Nfz9j0yUAM8vMJLNdl8dv4wwKfKd6HF6NaE/4eXUdQvS+t0rUj/OZnhfdoLZYV4j5EC6+pm6hdbHCfoJfoH+aAWIu1QkR6JrHorM3DhwOEq0yPYCLCQD2JyCVV6pxhqIqNBY+Bywqg37zCYIV5qPpfUU6l6bmG25+3gnkLzVzfJxgOlMWN03j4ABfPB3Ta53jKH0X7a5wJWeU8rlSGYUxxbV8Ony4DYPPWVDNMsBYAf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIFDa2KLR6CMlWlffnpOAyrr0MLf5NRYl5ZSfkOTnuBtW1Hmhag3CjuRCMFi?=
 =?us-ascii?Q?bVLEzVgxLv8OuEJoBt2CgCHvMSpNdsm4XyHY2EEVcEWY3+dfum6eQCKm8S5s?=
 =?us-ascii?Q?ZNezqPAbhSlx8eOSZgquSXc32yovkUUWQW3EIhAx6oD86FT5x3tmdiYHHU4+?=
 =?us-ascii?Q?zrWztE9mARUykabwab5YrqY/iitT2LDe4fRN88gUkBqlZWrN46m/kQL/IxMA?=
 =?us-ascii?Q?1VLhx1Op8WkRQMGWVdl/45vpI3IMHwBuHRloFFpdJaZoL69A9MvGLIEgh9qD?=
 =?us-ascii?Q?8UM4dK/XYYgJ2cDLSPzvRAFTyXzn7Cv1drixpokKlQC04IkOm3IUjRscZi3U?=
 =?us-ascii?Q?Fo3csyCPQX8rkDHxF9C7977aPItjKL5X+U/CM4PwvB0E10C7lx7mEz8dkLSE?=
 =?us-ascii?Q?BilLFERSuRBHUjKKa4ieLQWu4pUXRaP25Ip4JqBKa+wTvhpjbW/Zes5mIm2z?=
 =?us-ascii?Q?/+mf3UkTOXZNd0sE/uJk9pk0RplmMkw8x0nmbZDcbTF6xz5DHSiXu2hFkceS?=
 =?us-ascii?Q?DKaTQkubW+JBlwZrjiSq7ACNnxP1Gxf3IZ9gD6OwmPPfgBgTVi5OgTtzXg9b?=
 =?us-ascii?Q?fXZDrLdQzYFUDEHKEEvW1HjJm3Yhyty+ixdxQ85nhUdrmNxD5A3WJSpeY5E1?=
 =?us-ascii?Q?hD7AR7jsCszA7yY0PWf7lr+jHxLIipkUX/yT7BxxAcWKItwN7pGLr7w8j5Vb?=
 =?us-ascii?Q?X3BPhjqknXbKZ3zOWI3b8r/Lw4JcLEFTnFiip4LhcdiDqlX/HaMbCGQ1kyJj?=
 =?us-ascii?Q?NQPmiRo53K82UlhemE+txTinQXrKxl6Y6pXJwUth330ZW8zXEeR/kjmRxYdL?=
 =?us-ascii?Q?m+Ko112Uhn0qfpVsDbs+cuyQHFvVlZqFQvLyH9UevystZ9G+3VMoD4tQklzA?=
 =?us-ascii?Q?9Ikkoub/AEy8M0LT2hAMxgzZFCG4Y1Ie44DFuwdpNIqKFstYAdyCAwCy9yRD?=
 =?us-ascii?Q?I7S9Xba0NVwVjViCCU5T5pLvwO6kL+9HV2lNavk0wQ8h9AsHU5Iu8ZUZapg5?=
 =?us-ascii?Q?FcrT6MLwpPBNgHxaDpmBP2DfdErzZuBdtQJz4SO5bdL+FCASHWpotfHI+H+z?=
 =?us-ascii?Q?+g0M39jAbLCA4/0ueoxYvgjTVDOoCrXUo3zF1hwlJJrBGVVpxt6sUiEEIqXY?=
 =?us-ascii?Q?qKjShXdF6zX0wkwCIIYqFCb042O1t3Gg3s1kS/JMw8Ux1EOr+aNTWlBR1o1j?=
 =?us-ascii?Q?ywfLxFPjOuTb4KNgpSHbpMSurNINN151YutquUx+ePbhmxmIVdjpZCCUVGxp?=
 =?us-ascii?Q?Lz6iyV+JT9PDOPvJULOHfjEZRg1qXd0e1qIzzBqULOsavv+FgGjzgNupVRYi?=
 =?us-ascii?Q?3aa0wmOD1k4FyuNnMoYt01jv9YTyte6EWezF592iSR+xZ3COZL8IwmZJ2R0Z?=
 =?us-ascii?Q?by77bRtXtuAD4CdwfDjeN3nsUKSW0RYHqf638QSVw+QEWKxa90M9a6+Ajn5F?=
 =?us-ascii?Q?2pgK6UUjoQXr4y1b/llU1N1OhRfDlc76oYN+W8Ss22PfaXneMHr1jtXq1W0M?=
 =?us-ascii?Q?sialyO0x0LcexnZaML9qMYNJwiESB1Kv3rMGaD8krhMFRp0OMbM3FaGpVhtp?=
 =?us-ascii?Q?BFEdQoKx3FyzEfk7zNOO92V9aH1mGMSdznPxJS/d?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e63750-ae28-439a-284f-08dc375433c5
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 05:23:16.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6HhGJthkzQ83b4m4pvHGh/+Ey9ryonoOD5i2Mnrk9ufDWLLmyl6k7N12A+IaZnmpp1wPLNkAZINO1fdy36qvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3562

Hello,

On Mon, Feb 19, 2024 at 04:49:30PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> siox_device_type and siox_master_type variables to be constant structures
> as well, placing it into read-only memory which can not be modified at
> runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

@gregkh: Could you please pick up this patch?  There already is another
patch [1] from Ricardo.  I wonder if this one flew under you radar or
if I did something wrong...

Thanks to you both.

Best regards
Thorsten

[1] 20240219-device_cleanup-siox-v1-1-eb32ca2b0113@marliere.net

