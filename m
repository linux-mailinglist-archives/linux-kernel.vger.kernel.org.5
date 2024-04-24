Return-Path: <linux-kernel+bounces-156814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DA98B088C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16358288188
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C3E15AAB3;
	Wed, 24 Apr 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="hyY8wM+N"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5215A4A4;
	Wed, 24 Apr 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959099; cv=fail; b=SPOtWApdCauyUOPu5InP4VjULAZOMeOhosX1e+iOdYedWjcKbK+R/PgkDlRzH6MkVni0UpfMOnGzi8VmSoYvCvIWUEgTRTn+Q+mj6OGKimz/jnx6WHEL5VJ8b2nMZeiFQy0/NyjoDzXTJZc3WhuLx2kBPByAuM4nnhQqXGPjN7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959099; c=relaxed/simple;
	bh=2avWO2iVD+jSf7215FmUDIyb35RaYnQIOvSD16XuuwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0wDf6Je/nJYc4B9OYpBGZbv5ZMOVwcgXhBalMr7p8LdSUlD2eUUWcX0rr3z71Ph7H7P0dvRO7fPD3cD/XKC39O2SXth+YutO/hrMB5biP2wF0Imwd6WEGjOxQj5K0pu5Av/yfn6tmHskagbMPS4xhU1aR7BPgDa+G1ehGb5am8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=hyY8wM+N; arc=fail smtp.client-ip=40.107.117.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8QCefKw5xWlyBrQKJ5v2Qc2gueC2RV/6xgsr5upMHCsR+gtCMgEKDquBsgMofkR2ykfpVytysYaxcTALT2VqZXrfxgEFpE0ZR66Z1Hfo3EBo5nEoVlMbjdxsxxHSl57wjyLjUqnkn5UMNrskXTJRD6MvU+RpjfJcDNc6RCl/GqohSEU9+nhdcPBirGqOwAXPFmgSleRZ9dX2jpsYEWJpocSyf/89hXLXMotWzZH+PJjMhPjepbbnYujeiTWUPYWBqkC11hQZ7m/PKSUgyxQYbqi4qyTxttOPTxrfW0ZFCo5qgH9fE+mWSRtj+PSLWQ0e25coJtTQkpuqAzONK0w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhgWJl2YQp1nPx5KAAYKPc7sk4JECAu0OEBthrslMvU=;
 b=bm2KcBdNGlaJQOnda6vDLYVw+s94PzDcBIp+XnWybdhExDTS2fU4DID+74nW6ThabEmtXktNAGcwfpLO1FkkJ4JmObwwYmeoxKjZiL3kSSN0V+eWi6n3IOdG9E+qNyZ5RExTq4JBtXU67C8cQX5XaUpGs2Icoz7llRP30mFyiolYLp9fJcqPQCNJYaPgs9HNDBiaHk+ZxQcM2TurlY7hCxNvbvfCWDoZPQ05ljk8bm2Ah5L0LeJatnS3aVEW86wcaZB53sQsctHTzMNPvtZlkd6pTIcGdYKZ2ivtOj6UxZMFp5GgdbqTxe+96CBEoyo7rTrzDx2CcV/p6QGI20KzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhgWJl2YQp1nPx5KAAYKPc7sk4JECAu0OEBthrslMvU=;
 b=hyY8wM+Nfo5WQjhVKseYut61kaLmUlf1C5fm10O9thWKR4UQc4Rw56Rf77giOm/tQQviwtT5LTHSUjwYXyK5XdCCVmfQzKClEwgteOr7bc98Or0ykaVMHRnoutyxmxUml/MNPjEEdL3fGn3yD+m4S4O7DZDih7FT5k+9PydoMFrq2wpvfOUC7gWE7FIoQXPEVpDUO9Elurucmf6PFzQQ/nrDUkhGit6hrGQj6MR3kT661mAFcqN7cwIJx1t04/sEbZ9mHlolj0r2hurx+9xhGmhIsRCMVmynxD/7E9aqeexUGpWI+tQ63w9TcMQUpVgc5IG4P6kCZY43Wgoaok5JOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by JH0PR03MB7344.apcprd03.prod.outlook.com (2603:1096:990:16::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 11:44:54 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::340d:421c:7221:56e6]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::340d:421c:7221:56e6%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 11:44:53 +0000
Message-ID: <d990d835-e4bb-4248-b17e-da8907cf16e7@amlogic.com>
Date: Wed, 24 Apr 2024 19:44:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] pwm: meson: Add support for Amlogic S4 PWM
To: Jerome Brunet <jbrunet@baylibre.com>, kelvin.zhang@amlogic.com,
 George Stark <gnstark@salutedevices.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
 <20240424-s4-pwm-v4-1-ee22effd40d0@amlogic.com>
 <1jil07f3ps.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-GB
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <1jil07f3ps.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To TYZPR03MB5743.apcprd03.prod.outlook.com
 (2603:1096:400:74::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|JH0PR03MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 307286c3-e97f-4493-25c7-08dc6453f4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHl5UlRnZGtlYmZhSmZSVkdSTHZuMGI4dGZZd0RxZm9GMkRTbDEwRGZSR0h4?=
 =?utf-8?B?UmNuWHpUYWZ6RlB5UVI5a3lpYmcrWFZETmxCVjc2TWN1L2F1UzBVRFM2ZlB1?=
 =?utf-8?B?TFJlMXlra3RnTDdlZ3pQeExuRzluc0R1QmI0SnVOZTBnNXFmUXcrUDlyMHNP?=
 =?utf-8?B?STVnM3d0N0s4R0hIbWJJUHlkMzRYb0xpaTBMaVVOdFArd0lrRXl4a2VkTzE3?=
 =?utf-8?B?Q2ptUzBtdEF2K1hvZWlORlhMYjlzWlFQZng1c05pQWlOTVhFWTQ5MFJCYVEz?=
 =?utf-8?B?dkFCR3VINHJZZTYxQ1lReXowdU90WS9INlhmcExiYnVyM0I2OFhNcVlDS29l?=
 =?utf-8?B?bXFBRnhPQStBVzdFYXRacjBoeVNzdXpjS1RjSE5UajJoaXo1VDlCUE12TkVz?=
 =?utf-8?B?RGpDSmQ0cUhaQUhHaVcrWVFMSk1xKzlYS0xNOVBGN0FnQ2VxU1lWcUU0cW5J?=
 =?utf-8?B?c1VBU0ZhSFZxTlB1N2Zva2pMU0RmVnplbmxaYWw3WWpPWTJiUDNPZU5ZdXNu?=
 =?utf-8?B?NVNSOVpqN1lHUTd2T1lQMHlSYklIY2E1amlaaDVrMmtpZk85VXJvSWk0UzJG?=
 =?utf-8?B?bGo5aWo1eUgydGVvWjVBV0tudzU5VFBWTFZBVmh6ZkRpNzAxVUJtdWhjL28z?=
 =?utf-8?B?eTdkcWVOYUtCRlptWURBUDRUUFJCdUxsWkprT3ZqZmFtdzRvVGNRaWlMNG5j?=
 =?utf-8?B?U1paejF0bkF3MVRpajRjUTM5TFJNbmU1OXhSL0tldVQ3OWgzQVNhWGU1NzFY?=
 =?utf-8?B?YkgvRjM3RjQ0SWtwdUplWXQ3YkFQMDhRSDVOTnNUbGM0WkIrTnBwU1orT0J4?=
 =?utf-8?B?eEJybFZGS3hDQXV3S0Q4N3lJL3F3Q2U3UWxUcUx6RGlGYm44UW13aHkxN2wx?=
 =?utf-8?B?Mm52TTE4N0kzeEs5bG9IbUoyaWZwWTVrcEFiOFhRR2VyL1RVNnhUZWg5MFFK?=
 =?utf-8?B?SURMMnQ1dW1EeWVsOC9TVXdLQ3RQV3FnSkg3enR1UU1qdVJEeXcrTmdwRWYx?=
 =?utf-8?B?UkhaSkJoeFRDT0kydk9IU3puUHhHV2RGOXVGeTNGR1dza2EyMDhTOW5sV240?=
 =?utf-8?B?YWxBQ210TCtMNXRIRTd0WW1TVFhKWkM4SHdzT3JXbXdRSTIxRmNWRkpUSWZH?=
 =?utf-8?B?Vmt4ZW8yYUtlS0RBSjJUM1lTMzd6d1djZVRGK3hZdXVsNFNacEZmUURSU0xs?=
 =?utf-8?B?STdEejhCOTVtcmtjNWF2WjZZcHRUZjA5ZGFXVE9ycktGZkpuNWtqQStOMjhJ?=
 =?utf-8?B?dlg0aEVoRWVndHNJd0xETXFGMUFkSDVSY2M1Ni9zelIrR3cvNjdmYUNrNDli?=
 =?utf-8?B?S1gzYmdyRWVad3NOd1FTTk03MGk1WXhrUHpHWVJuVTdwaFZHTytRdEIxUVkr?=
 =?utf-8?B?d3FBQ2g3bks4UFA0VzhTZnlZUk5raysyckFGK1h1ajBkb0loQzNyMWZ6RktB?=
 =?utf-8?B?ZWMyZTRZTis0aHZlc1BMVDZ3bUlvM2ZERHJtTUhkZFg3Y3ViVFR4ZFBmQkFx?=
 =?utf-8?B?T3RDeDFNWFppWXBVMmpqTGd0c3cyMlg2TXRQS0lkR1RBdDN3Ty9OaWNmeGtO?=
 =?utf-8?B?SWlQWVhibytRN011eW5tZkhlL3AzNjlWSUFpM0t0bFhQYzIvMThMaWFFZUdD?=
 =?utf-8?B?b1VQUnF1eFJrK3FOR0EvZkVsaE5mWG1nS2VyY3E0TXR6WGlQMWFHVTBIMzU4?=
 =?utf-8?B?aXpNZDM4LzVYeHpBQ1o5bERYbHorRVByRVVuTXV6ZDBKNXVqdUY5VWZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTJWR1c3ZUpwSEc1M3ZGVzJkL21GNXhLcUN3WTVVYnlUdHdpTnMvbnR1TVRr?=
 =?utf-8?B?VGMyZ1UyVDZBbjhWS3lRUG9IUW9YWEkyYmpGU0hiL1ZqUDM2VUxMcDBmNjlr?=
 =?utf-8?B?SXNCaml3Wkd1ZFVYSFhJYVlsQjlSQUt4VXhWd0xyVCttWTgySGJhYjBUZEJC?=
 =?utf-8?B?ZTlBalhjbmt4c1VGelRRbHNoM3JPS2FUZlREdjdTOE1ORTFnTytSMnRsWEli?=
 =?utf-8?B?OVc1bjQwK1ZoZ1QvNkR3L0ZFWTljaWxxNjNrcEsvRCtscjZYTnBpNTU3WjFG?=
 =?utf-8?B?Q0U3WGozb1Zza3RiSXg2WGpBK3M1di9DQXJCa085bzlrUVh5V0plVGhIMGRZ?=
 =?utf-8?B?UmpzNWd6U3pzZXVvUmk1dnNsM0hQUkpvNnliOGNaTVNyNkszK3QrVW9OaVE0?=
 =?utf-8?B?ZytCQW9ZVG91TlV0ckdFMHBPc00yb3E1Sll2R1V4UFVDcmtUb1dWU2JueTNM?=
 =?utf-8?B?YnQydHBaVGxhS3ViQVZrV1daRkR0TVhhV1ZIZ0J5MG1sL0FzUXNNanZUL0RU?=
 =?utf-8?B?RWh4VVp1MVFMaWEvWldqWGh1OUtrdFl6WWJOK2N1K0JSTmtvNjByVXhkVkZN?=
 =?utf-8?B?bndEazN0YnNRdjZaYkM5RVpCejA5RWtobUIxalBsc3N0YUoxTk93RU9JNEdG?=
 =?utf-8?B?NmZwdE9TMjNpVWl0VkhUNFAyYTI3dk1CY0dyeFpwWmdGUUttMjNYWjZFbnN3?=
 =?utf-8?B?T3J3R0lERGtWYVhqVDBSbWplajE0eDI3V3o1dG5GaDlWdUp6T3VVS0hTRUpp?=
 =?utf-8?B?ZEk2eWxSelNJdlk1c2laV3ozZ2pYRHBPTXZLa25TL2U4ME9QSzFFR3RSSVox?=
 =?utf-8?B?Y0RVZzFFdnBmdGR0dDZlL2N6WlZOeEhEQTdNRXB2aG1XOS9aY1lwdGxNSjZT?=
 =?utf-8?B?OEVYcVlLeTVWS2luZC9sWlJaWHhtRmgxUnlpdlpYYnpMbnJBQm8vZ0Vra2JH?=
 =?utf-8?B?bVloZ0w3RzhpbzJBMHlOdXNIblpLYTM2WlFkblhlNjZqQXBDM00wM3RNSHF5?=
 =?utf-8?B?V0w0ZEhzMDRISk5HQkJ5MURpbXJsbXlvWVdFMjNDaTBhVVA1NWtGajR2QWhv?=
 =?utf-8?B?eFhnOUkzWWU4Y2Nsd043V3Z6UENwdlpQbFd2enN3N0pQMjNXYWVuNUtDREJ6?=
 =?utf-8?B?SkhKSDJnTmNPcW40eUEwSU5EQUF0Q3V4U3dkLzR2dkM5Rk5jMVVuakRLY2lH?=
 =?utf-8?B?YmR1c1ZBZWRQYWdOd0J4Q2ttREJ6cjhDVFVXU0doTk5HOWRVZlYyWEJPRU9j?=
 =?utf-8?B?OHFPaDlnVVNlaURQUzNzdGJmemhvN1lnOTU1UGZESGljMStydDdKK2tsV2d6?=
 =?utf-8?B?UWZzcUxYenc1QnR2ZDhPUitMbURWdUJpMWRYZ09vR29USWZiY2xmSlZCOG9F?=
 =?utf-8?B?NFJtWmxhMWNGQWwvWGdVTnlxd2pDSnNHYXd3M2tyQUxwbGxkc0g1dkRoQ2xP?=
 =?utf-8?B?S0FuZHpqRThubHpRUnJHMk56dzhzOFh1TXdkUktldFViWVh3VUFwVkV4VXI5?=
 =?utf-8?B?VzU5SStCRWdUOEZMelJHMXdDTnRXSDYwS1BLLzJaS1pScHRSYjhyOXIxUlhH?=
 =?utf-8?B?ZGxYYWdJbHcvRlJLS3Nlc3lhcWUyb3RPM1REVTlOYjFQcmF0ZmRqaHQ3U0dM?=
 =?utf-8?B?VU9qQnRrbVpXbWdQTWdPZ0t5aGd0dDRTV2RDUTJBTDdleElXRHlXMlpYTnZC?=
 =?utf-8?B?aFFJaWlsSEVmYzlsVVNlZmJsc2lBZkNubDdUczFLSzZwaFZZYU5vTWhTeUJQ?=
 =?utf-8?B?R096UzZJNkF1SW5yV1haMEEyMFE3aWdKU0p2NURCY0lYdTVSYldqSHdaRHRR?=
 =?utf-8?B?Ym1UMXJqazdTMXlUbHRiVTB6dmRuS1pIRG1CQ1FyV1c4QjY1WWp0Q21pYW05?=
 =?utf-8?B?QytQQ1Q3YzBYVUZLa1Q3R2RzSXdsNVBxWGxFRWFsOSt3VVJaSUkxRzdVa043?=
 =?utf-8?B?dEEreU55RUgxcmRNVkYwUzVtMmx4UUZKc1AwRXZabWxVeXRzZW5lWW5wRDRp?=
 =?utf-8?B?S3pUZXYxZ3JJU3pObi9uYkZZdExLbHIxVmp2d0VGOGNCVnAwOFEvK2J3am9W?=
 =?utf-8?B?SVdGd0kvZzRnSVAvU0toRDFBUGdpanZJLy8rdWkyVnhLdERtRjUzMEhZeDdT?=
 =?utf-8?Q?t2odUm94jR9MmOHg7LAWiEwFV?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307286c3-e97f-4493-25c7-08dc6453f4d5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:44:53.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0C4yg5GuSS7l8CEwI0XSd4sgjlLLkG4c8uwdsNHg/shwyYP99QMd0GVyxrMoFTkgsJW/CiLwJ2pC9BaXQIYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7344



On 2024/4/24 18:32, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 24 Apr 2024 at 18:28, Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org> wrote:
> 
>> From: Junyi Zhao <junyi.zhao@amlogic.com>
>>
>> This patch adds support for Amlogic S4 PWM.
>>
>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index ea96c5973488..6abc823745e4 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -462,6 +462,35 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>>        return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>>   }
>>
>> +static int meson_pwm_init_channels_meson_s4(struct pwm_chip *chip)
>> +{
>> +     int i, ret;
>> +     struct device *dev = pwmchip_parent(chip);
>> +     struct device_node *np = dev->of_node;
>> +     struct meson_pwm *meson = to_meson_pwm(chip);
>> +     struct meson_pwm_channel *channel;
>> +
>> +     for (i = 0; i < MESON_NUM_PWMS; i++) {
>> +             channel = &meson->channels[i];
>> +             channel->clk = of_clk_get(np, i);
>> +             if (IS_ERR(channel->clk)) {
>> +                     ret = PTR_ERR(channel->clk);
>> +                     dev_err_probe(dev, ret, "Failed to get clk\n");
>> +                     goto err;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +
>> +err:
>> +     while (--i >= 0) {
>> +             channel = &meson->channels[i];
>> +             clk_put(channel->clk);
> 
> Fine on error but leaks on module unload.
> 
> Same as George,
> 
> Add the devm variant of of_clk_get() if you must.
> Use devm_add_action_or_reset() otherwise
Hi jerom，but we have discussed before.devm variant such as follows：
devm_clk_get_enable(struct device * dev, char * id)
struct clk *devm_clk_get(struct device *dev, const char *id)
struct clk *devm_clk_get_optional(struct device *dev, const char *id)

after i check api parm ,these api's 2rd parm "id" is string not index.
because dt binding have no name property. could we use devm？
> 
> Could please synchronize this series with George and deal with all the
> supported SoCs ? a1, s4, t7, c3 ...
> 
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>   static const struct meson_pwm_data pwm_meson8b_data = {
>>        .parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>        .channels_init = meson_pwm_init_channels_meson8b_legacy,
>> @@ -500,6 +529,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>>        .channels_init = meson_pwm_init_channels_meson8b_v2,
>>   };
>>
>> +static const struct meson_pwm_data pwm_meson_s4_data = {
>> +     .channels_init = meson_pwm_init_channels_meson_s4,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>        {
>>                .compatible = "amlogic,meson8-pwm-v2",
>> @@ -538,6 +571,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>                .compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>                .data = &pwm_g12a_ao_cd_data
>>        },
>> +     {
>> +             .compatible = "amlogic,meson-s4-pwm",
>> +             .data = &pwm_meson_s4_data
>> +     },
>>        {},
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> 
> 
> --
> Jerome

