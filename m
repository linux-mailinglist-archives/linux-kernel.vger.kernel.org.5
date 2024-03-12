Return-Path: <linux-kernel+bounces-99978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE2E87901C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D1D1F2150E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4BD77F19;
	Tue, 12 Mar 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lh01Z0+G"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2082.outbound.protection.outlook.com [40.92.53.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2C79B87;
	Tue, 12 Mar 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233561; cv=fail; b=IXsVV3WuwswjVDsSrOhYkW32bOZGIxIbeStZ2v24dhYpjw/F7rqqPeLx/iMvJTAc+50Vcv5pkkk/iod8oqMPZuo4PO9EORF7WsT66zitgC4eza699tf6zTPRRqHZ+Q1C/vsgpOk8V2uSzbrHYGo/gpCvJ32vCSqqU3BikoHNq/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233561; c=relaxed/simple;
	bh=mAH91xmaUp3ivvjZ9MHIg6sPnGss0sb09Kiddc22y0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gggh27PuHwif6KFLQLH4cidgcNj+JlIzaAwY4R/MN6QjrBWnIBzef4ZMdVYZg/g+bbVluduI/6ymAtp+V0Wigk/TpltlaLlZPjKhrSngMJx3F0+kM+pqxrvEWDaIAb3ojGlhoaHzBKcn4eP5k97NYNiQ01fzcZgsseqeAcy6qNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lh01Z0+G; arc=fail smtp.client-ip=40.92.53.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALo1De+JLi9mXytCOMzPsyZkAtCqbB3ZZCmP4V9X59cunUwxefrpEyO6/EmvQTkx1axbv91Z0xzoioZXiokWB2MQFVlLkiUnVP/vyDsdCLXeKuAlcgcs9bc1ybS+fAcUbjRDz8Hs55hKiO+6LGUGvy+bNqm//PNLo0cKM1XRQ+bA/aQDYBw8e4mWvcUvc33iOqpcyZS3SJBdZ2GX48pdbPcc/GDhlKJEZ6QQkHCQ3u3mUXDGhEBQ2i+KHs1LmKQkcjwJL7absP714klDCV9J57lW8sxn+Z6c3Oukj8bKE930y8mTWi6tG6ttYR8g2tuRVyJgcNvU9tSq55r+TflD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCeZTNtKClxNmHCsyfia/spAIHppSQu6YthNT5swzUg=;
 b=ItkxjYhxWmc94A2tkWYmzjz+glP+FFhHi62Qp2pbx1AZ4HXKcv3Y4/zfet0Zb44hyAzSseabaRyVDsw5wmAeEv33L2pPQEMt2iP8LcJ4GDqRXgWJNjxrd/LEYEzxOLh+bZhrnOzXNbAe7naO+YZvwi5K6DbtOxr3wo++Ctj82qoUhgG76ByrTXbI1Diyi380FeUyJkN12pOEQjUE50kY9QCJmU6Qlm7nL2cmcU3acP5eo3rCt43TJhlttvLj7jXwUL5cU6Jvr64d4A3V+YXjhh8w9eukVqPZN3lIIQAT00SIPHC6wkCyEhqtovPjentuoa3/lZoNf8N/9NNbOyBUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCeZTNtKClxNmHCsyfia/spAIHppSQu6YthNT5swzUg=;
 b=Lh01Z0+G67ppSBFngt5GUC8H1ULzz+8sov1BYhlEdS1wHFl/gkKqjq02uj5nCm93Ih8l0XFwSO0HiF5rgcKcfzqT6X7zIA8CN+ZMIMPA5hv55wosRELfu9GlXymoHzClhdf/298zEl1dPeqRFFUuwuvY3QhHSJJoqE9tOwC0Nec1jHH7Za9+uPL3tkMSk8mzu8/p+OMiBIxvYPG2rqLJTU3+phSPaXnoLfOanSowtcvkxKCQpAxyprt/jcWI8Bt2wzKPZn2+Rx+9YgFUxGWeH8/8oE+pnaSu9FMfLSdE6da1Bq6OPgKLtn6QfNGC/K/pFaneupBCm3Krtgf7opjHvQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB5570.apcprd06.prod.outlook.com (2603:1096:301:eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 08:52:33 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 08:52:33 +0000
Message-ID:
 <SEZPR06MB69597C834C90FE1FBA1F1D83962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 12 Mar 2024 16:52:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: set initial best mux parent to current parent
 with CLK_MUX_ROUND_CLOSEST
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>
 <20240307-hot-hummingbird-of-atheism-87503c@houat>
 <SEZPR06MB6959882F5DA673456A3AA85D96202@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <20240311-speedy-bat-of-art-4facfc@houat>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240311-speedy-bat-of-art-4facfc@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [FtBL2TO2DaLaMyHuT75v55S1cmBlQu6Jlg7g5mNuiEpCZnfQAKZKm65oSvYU6u8s]
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <2c31a102-295d-4afc-a6c5-bfd7293e036a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2065294d-02b5-48a7-2dd0-08dc4271c1c6
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TWU+YiOcCO3KzwBTDGS95vWkeOwGXOxycJlPPuqk+rH+C9OVEztFK6SfcfCuJnRy0o/lSsWYOa7sQu1EDAlonoI1VCiPRjGiEsEObMAxUOzKfho09OiSjdft5X0GgDa7WEMGwbVX8hhFB1uc29UnXkEC4SobkalVFELSSFpH5zAaif5d2mxgL0sv90txiPJUBfjf9Y0QnrsjKivQjhn0rfJLgGAwPXNuvOiC9kb2sDfanv7t9BzT6+BkJoh4z5lu+tWZlWPm1HoIQgSAu9rvkWl3opYCAK/eHfIZhr+DDcgFwjBfit9lSx4S/ZzxxjD8KZR3Twd8BJJ1b7yVWsuaoG4y4UkkwafmBKrO6b75cZQyUAb3MS5UZ9rZn7DSoGO6HOrJe54Txz8k7S+EjLd5LwVUbq/tVe90nv1naUhkWT7r6j1DVNbwi8sNJnEzCcMY2ntIRzeKPOTCqCmOjI0PjVuEh+7KI2bAYCB30I76LkOVEo61+bWBDPaEDu+bZk23ck7mYnJ91UPc+0opSHQgAq14wSPzYJ8cP+xCRjE37a7HVYaDJ5UpPzzv0gOEatNp1dU9vC/EfuQ4w8UrEUE2QcpUHT1qsAQCmaJxIAa5b/Y1+log58xM+nxIzxWbHZzbCmKN0v2L3an3PN6G+/uh8SDca8O6G9U784Y497JYSNexqRsuxEOU/gn6DikVNJyBRvEA6IdTgtJoX45hujS2t+UlGeiBh9+5foi55efI3xqX9TkRrcKHwzev4YADYoqVUpsnl9jJHxCnzq8vi7PkMxuZhOu1UR00jo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Co/Hjpnq6sr4ca2lMO6XZApeXVxA0+rINNiQ6RLOwX6MhZbYAMDGY82TJVDSoCxpdtyURcn0HaeIimH/jZ5kDqhbJBdIdWt1bdBOP0G4EL+boL/NHgYQzJTGQKR1nd+V9teXcTApyiEEKlOQoBVO2KjYBLsaMvAIXhgl/OwCK37iwFkV/9m90Lb5CB3dBbQfItr656zL6dj+25/V+fL1ovoVfos3GaslnEG+raWnZj5X+KYHr2lT8ERUa66G//FpM+qkXhFGvd26SrbVlg5SXnP5CahAos5Gfx2q8gb8HofADriGt78l6W8w84fckinluPQg1hQ7B9q5+pEgCkiBg80wuRGncz2QgoVP6BldrkyZ/tjBlLe2iIuBKH5kuuEnS4NVooJbT36TfoACLH+CQ4Py7hD9/O1F0tMOMlgxnbSt+a+MBd5SVift69b56b3IYSIfF6fE95FfUhsXhI8kEUr+Ko02paWWRcafiSdUpmFjZTaPeIxZ9scw1rt+7XhXgLs+0RToqhhPS/Iv3vfvzi38nssyXVET+HwTkB/cXHyAFCs/w5a5EROO0vhTd37+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFZYWTNMYkhyeElrZlR6aUNhUkRxcDVhVllPdDN3N1h5eUNkK1FTZlF5MzhK?=
 =?utf-8?B?ZTVweVV6SjNEQ2JXcS9XT0Nmd0Y5dy9VWWpVcDNyR21lMXpveHBPMnMzQ2RK?=
 =?utf-8?B?bGxFdmtSaFlQejFOSWgwZkR3RFZuVGY4Y05jajFIMTBRZno2QXkzOWNLby9J?=
 =?utf-8?B?ZHlJS2NSeCtQT2t6QnAycXBFQ3JVSlo1TlNrYWYwUGlUMmNrcXRkNW9FaXRl?=
 =?utf-8?B?VWlHNkY5amFERzlvd1ZIMi9MUmdlcnJMQTNCdkxxaEEvTWwveHc4NkpJZFFG?=
 =?utf-8?B?UHMzVU1Ec3RIY3B3L0IwQURxZ0xHRGNxb2t2N0ljdG93ODBZV0IrQjVicnhC?=
 =?utf-8?B?NDZSbk5uQjZMZ3hmVWRESE9nUzdDd1JpQlAzUHJOcGNWSklkSTBZczc1YitT?=
 =?utf-8?B?LzhWeHdoMUFpZDkwNFFVaC8ralIxaWk2L01oWGREeU91VkNNemFMNkdrYlVi?=
 =?utf-8?B?aDZYQ0pXaWt2UE1GODZPSFJaYS90aTBvd1BTVTBSQzNHNWRNWHJmWFdNQTFw?=
 =?utf-8?B?N1prMExndU9ubVlvOWJVZnFNSzBMbjBUNnBsNGZLY251WWhoRFJKcS84RkFL?=
 =?utf-8?B?d3hiSVV0QTkxU2FSc1VTbEpDNWVFZWxrMWpNTXpoR3ROcjlaOWNCN3RDMVdV?=
 =?utf-8?B?NW5QbjQybnAvVlNkcGFSbldiV2dZM29vZ3pxWVRuWGc2RDZ5Yjhwb2pDaVZV?=
 =?utf-8?B?R2Z6ZDBUMk1SN0w1eTkvcWpNRzlZRGJ4Z2JLazZzbkRZa1pqTW5oODNVenhZ?=
 =?utf-8?B?UTZPbTZ0bE1kaXAzQ0cwbGoxZXZ6QlVNTXNuQWpKc2N6L0NhWGEwNElJZ0ZH?=
 =?utf-8?B?MXh2SGIzWHJoSjFTOUFXczZna21MWGcrbVJoYzZsR0c0SHk5d24yZEdPTlFx?=
 =?utf-8?B?SU1ORllBY1ViOTNIRllnc2NoTVoxc0pIVU1RRkFPSzRTSGxJbWQvcDBYZkJq?=
 =?utf-8?B?LzV3TXR0UmZsU0ZUYkR3elk5cmdMLysrZjBtZ2ZjMk1XemhkZGlTV3pmSkVF?=
 =?utf-8?B?N2dmVzJEbzRmYll2a3pDWlZwemhRUVFsbitrRVU1dG81aGV6Rmk0aFBiNXcw?=
 =?utf-8?B?V3hMYlZ4cndkVkRVSUFlcXl6cExRcmNXQUF5ODFHNjZDMnJiWFdJRjU5VENK?=
 =?utf-8?B?MTBsVU0vdUFlRnUydVZ0OGU5c0lyWlo1YXVlZyswZHJneGRWcFdqYXhCZW9t?=
 =?utf-8?B?M0x5SWJ1SXBOdzlUN1ZIQTBqMy9UOWhpYS8xVHJON0lyUXVrRnNrUjNLRUI3?=
 =?utf-8?B?eUVPYzUrU3FtRktLT2tBcC9YbVNNMEduRnVoSkI5SnpNNFM4R3dXNCtHbkIx?=
 =?utf-8?B?QTh2dnh1em5oNWs5Smk4bEd2bTZ2cDhzSTFvcUtQckhiVnFJZFFYZG1UN0pu?=
 =?utf-8?B?YXJiWCtKUWRkYlhEcW1pTEJ5WDd1dHZ2WUVnWEpIWVRTbEVWQmo4Njl6eUJq?=
 =?utf-8?B?bEhLR2tvMmw3NWl0Z0hjS1EyajhoVy9oK1BtQjJ6bjNaV2lpWjZ6VUlZMFpv?=
 =?utf-8?B?d085anphcGY4MFdQdkhJTDdZZGYvclR2WXlZR2hGOWZpbnJXS1k5UDBBenMv?=
 =?utf-8?B?c0g4WlZKa3c2b0Jjbnk2UDc0bGl0elUrZktseE8vTW54bzRINnBPTkY0bmt0?=
 =?utf-8?B?ZGsrb3ZDNjdUVjBnT0ZtbXF6eUdsaENicTA2TFE4WWFlOEZoeWhtaWxOaGhW?=
 =?utf-8?B?RzhPUkp4eVk0bXZseUpIeUN0bi93VjNxMEoySFM5TEd6NXhhbGUweHZUVERI?=
 =?utf-8?Q?Yvakv2bZwp22coOQRflKVsgNvnVDYQTB88tC1zX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2065294d-02b5-48a7-2dd0-08dc4271c1c6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 08:52:33.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5570

On 3/11/2024 5:34 PM, Maxime Ripard wrote:
> On Thu, Mar 07, 2024 at 07:18:05PM +0800, Yang Xiwen wrote:
>> On 3/7/2024 4:48 PM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Thu, Mar 07, 2024 at 10:03:50AM +0800, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> Originally, the initial clock rate is hardcoded to 0, this can lead to
>>>> some problem when setting a very small rate with CLK_MUX_ROUND_CLOSEST.
>>>>
>>>> For example, if the lowest possible rate provided by the mux is 1000Hz,
>>>> setting a rate below 500Hz will fail, because no clock can provide a
>>>> better rate than the non-existant 0Hz. But it should succeed with 1000Hz
>>>> being set.
>>>>
>>>> Setting the initial best parent to current parent could solve this bug.
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> I don't think it would be the way to go. The biggest issue to me is that
>>> it's inconsistent, and only changing the behaviour for a given flag
>>> doesn't solve that.
>>
>> I think the current behavior is odd but conforms to the document if
>> CLK_MUX_ROUND_CLOSEST is not specified.
> clk_mux_determine_rate_flags isn't documented, and the determine_rate
> clk_ops documentation doesn't mention it can return an error.
>
>> If i understand correctly, the default behavior of mux clocks is to
>> select the closest rate lower than requested rate, and
>> CLK_MUX_ROUND_CLOSEST removes the "lower than" limitation, which is
>> what this version tries to accomplish.
> The situation is not as clear-cut as you make it to be, unfortunately.
> The determine_rate clk_ops implementation states:
>
>    Given a target rate as input, returns the closest rate actually
>    supported by the clock, and optionally the parent clock that should be
>    used to provide the clock rate.
>
> So CLK_MUX_ROUND_CLOSEST shouldn't exist, because that's what
> determine_rate expects so it should always be there.
>
> Now, the "actually supported by the clock" can be interpreted in
> multiple ways, and most importantly, doesn't state what the behaviour is
> if we can't find a rate actually supported by the clock.
>
> But now, this situation has been ambiguous for a while and thus drivers
> kind of relied on that ambiguity.
>
> So the way to fix it up is:
>
>    - Assess what drivers are relying on
>    - Document the current behaviour in clk_ops determine_rate


 From my investigation, it's totally a mess, especially for platform clk 
drivers (PLL). Some drivers always round down, the others round to 
nearest, with or without a specific flag to switch between them, depend 
on the division functions they choose. Fixing all of them seems needs 
quite a lot of time and would probably introduce some regressions.

We'd probably only have to say both rounding to nearest and rounding 
down are acceptable, though either one is preferred.


>    - Make clk_mux_determine_rate_flags consistent with that


I think we must keep existing flags and document the current behavior 
correctly because of the massive existing users of clk_mux.


That's why i'm going to only fix CLK_MUX_ROUND_CLOSEST users. Hopefully 
it won't cause too many regressions.


>    - Run that through kernelci to make sure we don't have any regression


We don't. I run 'tools/testing/kunit/kunit.py run --kunitconfig 
drivers/clk/.kunitconfig' each time before i send patches.


Over all, it seems quite a lot of work here.


>
> Maxime


The situation here becomes even more complex when it comes to U-Boot clk 
framework. They chose slightly different prototypes and stated 
clk_set_rate() can fail with -ve. It's a great burden for clk driver 
authors and maintainers when they try to port their drivers to U-Boot. 
Let's Cc U-Boot clk maintainers as well, and see how we can resolve the 
mess here.

-- 
Regards,
Yang Xiwen


