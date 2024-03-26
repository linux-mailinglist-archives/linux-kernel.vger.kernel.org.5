Return-Path: <linux-kernel+bounces-118213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8357288B618
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3803F2C7EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E7F510;
	Tue, 26 Mar 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="hUrV3hIt"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2184.outbound.protection.outlook.com [40.92.62.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0696CA7D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413016; cv=fail; b=eAgYt2d0axWFZhZGuFNxIYjeivaxfOwYE4q2c9f12PXCXTdn1rKJbB3zNKacpUQIxV62kJLPnkcp9yhKpApuaHC0kRTXM6mi+liwb3dEhtxzJxoSGjpwxYskU+tSGAhZC/ONfuqqnZo5HTzHYDxw6aIwdR/p8AoeLarfFXGmf3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413016; c=relaxed/simple;
	bh=o7FQV+RnrjM3F/HZO4VnNMi1++/tPSZwE6tePYiTE8E=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NrVNKXQpqyu8cWmTRoJ3/5HJvKl8cxEPsy+Ki6q1vu0Dnu92LmR1N5VjSpJt7LjFPhrW97Tcf1YvLBF8AcVbHjiRxYMPdXXlqUOCXGp1AFShrgYBi+/clN8xTQ3mqxidoRb45Yf3XAPAkfvbxFhcBH8qkg7yN7K8zht/qiFHl3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=hUrV3hIt; arc=fail smtp.client-ip=40.92.62.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVm0UpghFf0WVVOHZGq0BD2Tjc+jmJuYk9PI/l77IRlg4Wl79IbA4q4r5gfu7UFi8wleFt6YbAuK+ewxYKP2pxl6R8uxo7p7GQGTGSQJGFlMvz52r8EYPuhJ/4R5uvQU2mA03eoCxi+1Nzbyc3tpC/H7l2cwErCuicNIUw3nFAW0/oYjsCqPEXRrbP86ZBwy1HhK5vjOxP7yevEZKdtzW1/EoXaF8vf5S5F5kRCEY22Yrn4bUSXfq69zdPVW5YahXxpIeSGqqZyWkGEyhBGemTjB+8fdRt1rNqr7rv2VbyYBsGNBOq5d/dOEpto5VFxl13Qvb4Ostp8KJ5QsmqBoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48hJERZAS4KvyY3aqkQoeNhhz653d+DqStmtzrW8pRE=;
 b=ki6VUtruYeqTHf47uEi1VmlnvoixCgk59bVicwprSupNUW0RhFBJq5orZbXt/RgQ1gpwVIR5Erc1pWiPES+KHR9dlmVNxzRrh9a9hSMqzkCC6I9MbaAIW/gfNEz1zyXnaCYL3sFDbDqPLARSkmBABn7ll+RFI2snWOxW0j0BdmGl8fv/JytVEAGfhbmy8Jv8n9vwulDzJ7Kt/oqjmuzCFJZOuiIK0c5UIR/aH+HE55EZHch3rb+61Ov3tljTQY0awY6vzQfSVGnmLwb41o77n7JMu3W3r6amwUJWZf2GD+JWEfiuIr8yo1vSUA2rwBy5QybwmvP5XP0FdOy61Gznxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48hJERZAS4KvyY3aqkQoeNhhz653d+DqStmtzrW8pRE=;
 b=hUrV3hItxa7rOW3IXlJ4t+zpIzsYHA0oJwzEMj8KqM5kZHhVpigkb7fUyWdytqyXXMXHxxQ48etOETtO0SXIhsf/yr5ZpDipMq2DnJ/pK+jCKxX8XOKHuH/9UwZkqGYh8N6G6EalxrY2pfRCbGBiDdY/lsq22MKGCVtMbPIS25/KKpSi1N4GuuIb7zdrwkgDqZyeIP84/Mcz0FSRH6JHejkq8yWblDuC5ORm+FvQGVLpOAx7pZ/qIFAj6MG9EbcAzfFesMsg9pYwBfzxb1AXp0wyvEd9p6Xnxf540IO1GGS3CNgVRofVz4BklDkd0XFsNH5TgRY2lOXE7lChsq9YDQ==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY8P282MB5035.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Tue, 26 Mar 2024 00:30:10 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 00:30:10 +0000
Message-ID:
 <SY4P282MB3063048C537120C8D3477774C5352@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 26 Mar 2024 10:30:07 +1000
User-Agent: Mozilla Thunderbird
From: Stephen Horvath <s.horvath@outlook.com.au>
Subject: Re: [PATCH 2/2] platform/chrome: cros_kbd_led_backlight: Remove
 obsolete commands (EC_CMD_PWM_*_KEYBOARD_BACKLIGHT)
To: Brian Norris <briannorris@chromium.org>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240322102800.1322022-1-s.horvath@outlook.com.au>
 <SY4P282MB3063D447DA09D35F5FBD4721C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <CA+ASDXM9=0jQA=MWpBOttUT7k67wmEDFGoOObQfYm=ca_HL8GQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB
In-Reply-To: <CA+ASDXM9=0jQA=MWpBOttUT7k67wmEDFGoOObQfYm=ca_HL8GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ZIad9W2c41W9p2SajHtWw1DF0sYq/HmQ]
X-ClientProxiedBy: SYBPR01CA0094.ausprd01.prod.outlook.com
 (2603:10c6:10:3::34) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <33b036d7-542c-4f5a-8ce8-d1a1035a758d@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY8P282MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b583d5-d24c-49cb-b710-08dc4d2be4e6
X-MS-Exchange-SLBlob-MailProps:
	AlkLxVwsndlo1+lFrDZI3pEF+l+HiLrLZstFIgrv3fimowAJMhy+41S1UlNDYOI2KcWZNqgzZxL6VrkxNBtvUEz3z9MI55XwRQU29wKmECsL59KEvIbDjPYVts/f3BF23B0HBFnEFvhVFz4vEpLyu/dhDtlV6m79/BOLcwkl26K/M/XtkwwUlFIs7Wj3SEBe2cPxwe3IyAjcIFIzITIsZYOqyyVlF5cVR+Z/EVNVy+vVi7bx3ic2tlwWW+gMIBKc/roZXcqyCc7LkpnXNbezm+vWqpMOjvMW9h1jB4a2slzPsDp7TY4XuqD5yH6h16RGmPdowA/PDGrjR0ilSMWk1SzCsD5v8F9QbZwSGiIVom+QqZYQAXy1Up0TaOIJ1uIm4ioin+edpBu3zaC06EeZrEBdF7YizweUz85dNcKylyZha2Z55AFQqUEszFAyxb4gRSimFBOcWZgpajsd6he9CzoH8UD7pv4hhIGmL5qcLdIyG5qJ+zlnjI82CB2hIyoHyIDU7lw/9vPyfKSLyDzepu189eTJ1A+3EyU6mLJ9kiKx3++tv0NbYN0bXJzO47QIc8N4Y6bwuyV8eBJQJeliFePgzHW3ROovEMBZn6Ds8hOQ1bmhMLPkyIZuwK8SMD6HX6+kz49+dMRVfQ2Ysr/EpZUV6D9ABpy1glDD6kASiHu976zBaeWU3SczsPkiBrRPuS7ky+EB6BacgqspSNE8KVLUtguhtjjsUdXAQ6ZVsY2o8fIxoUuFZJNOsU4zK2JLEF5We89fxqwZGNuUb35isrtOyMLnPdbx
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s1ccXyS6SzdQeZglRqzhx/2p4iCvG3xjswftys3OZX8liCr/Z5oGGNeLzdXm/pVid8fXHkugEuks8ik4ZH94bjg4jjjv68TuPYunSGzcEYu7FrQqm41dgOS7Lffjrc4l+OvMtxj8bg6olfoGmAXL1GJ/LeWD5R5RLZbDeIwMNRZD0/VUDSBnbeT5qc6nTNwkGi2r/yjy4KGCYJWnDk2IKsx/iHdmZMPzIpEmRwdyLnTSkbOYCstd3keIs1MROwbRpdtZXt2aR1D51ZbCQ3ni7WZiCE/rDw4AKcQiu1TwqOzluDVDktNvBo01CsQECtej0+zOqlI8VdJww132SX3ht339afTAEJmY4Abi9CjR624W52ReKh5STWbR447EPAIwUtmhcAS0VdScI6yQYWQBz12Jm23pWYBvPT9aig9MV2K7YWlXL+hYgia9LtGO/D7an8d2U4Gk9oIVyufhwicxAH2eQDuQqS7PvJSzWNeFbzcs0dJsCc7XOW+UfFbThxihUdGgJx4yYaoSAHqO1vXKNdfvf1rUEHoi/xpdwcPg90SDdYDGzoYSsQBV/SGjjifx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjRrSHBsdXo2S3NNN2ZES0MyU2I4a0VyZzF3aUJYZ0laK3NUWld5NXFDT3hy?=
 =?utf-8?B?WVNMR01MWGFTUkRCeVl0WHFOdHFWVkd3VVJvQjRLdFZrVVVjSXBLYjMwWFRE?=
 =?utf-8?B?NTNPekJKNzFWMC9EajZVbmh6Z01JVkpweVNUUGZDRjQ2N1NkZ2JuTXhDblN4?=
 =?utf-8?B?Z1Y3TVB1RmFEVHRmak5UdDdXMHhCUWRhbGxHYTh5TVo1TkFzVjIvOTJ0bllY?=
 =?utf-8?B?TWJBc1VDQWFDRFBzR2ZGLzZrOTBwb2JBSDEyM2k2RU9LUUJKQ3J6Vmk1L1BJ?=
 =?utf-8?B?ZTQ2bVpKdDJGZnJGc0ZQY1BNQlpDKzZpRXl0NVpTd3BuQTJQWXlmVHR6elJP?=
 =?utf-8?B?Q3ZjazdxcTJPRFBTU215bzVrMDVIQnd5Rmp6M3FKaUlFQlY4anJ5SVoxcjFD?=
 =?utf-8?B?ZVJzYkNTNU92cmdZQjcyc1pXYmVVVVk4dS9oOEUzUkVoTWh4aFJ3czVzempD?=
 =?utf-8?B?SU9mb2tpZk0vdm5YM25xTEJMYnNFQUt0YitwOEpSNjUwK1V3SUFJeHlNSERT?=
 =?utf-8?B?MW1GdnQvWmlJZVVpR0h5YytNVnJZSk1idzNjQ0JxVlBwOTN1VW1WMVRreXlO?=
 =?utf-8?B?RXVNNnNGSU56K3Z2VlNSbFp0anBZQ01sK2xBdlNQcE9wUEJWTmgxRjlpajlo?=
 =?utf-8?B?UndmTUlLRloyNXdSS3BNK1FPSlJxaFFieCtFeFdlS255SVB2a3lPR0FJZkxO?=
 =?utf-8?B?SjRwZ013OUZZOEFYWDc1dk1rVDFPdEt1VkpSTWxUaWZaSXQvVjhIcDcvQm1i?=
 =?utf-8?B?aTFYZGRpRHJtMFg2QlJ5QzFITURRek5oSUxySUtyM1VQZU5sSTJLaFlHWkRo?=
 =?utf-8?B?eFhpSE82VjRtUlhJbGtKUEI4MlUyL212MitYMHNrVWNlZnVBVnhTc2IveFJM?=
 =?utf-8?B?OVJ1blE0M2lkeHAwN0xQYkxRVElzblJGQUNzRHZRQVgwbGNoV2tadmVXaG5s?=
 =?utf-8?B?eTJvNVVzZ1Urb1hQSHZuRHJhMzQ3dWZDdVpqN1A0eXU0dm02OU5KaVFkYWdK?=
 =?utf-8?B?dDJMd1FTSEt3WHg3MThHYWVEbVdyQkUva1pHazZoMHhld2h0TGVnS3RDdEI5?=
 =?utf-8?B?NHM3aU9HeG5obmd0NnFZTlFTMDRZWS9WckQxUExEL3VROVhWdjY5OThCZFlk?=
 =?utf-8?B?cU5lM3laWkNyTUVydDRQd0VPUDFpN3lTNXhjUVk1cGloakJwWFhrZDR4akNI?=
 =?utf-8?B?bWdWemtkQ1daRjhub210amY0OFJJdnZ5TlZreStqcExMbGxZVHdOZXdjUTFh?=
 =?utf-8?B?Wm5JV2JZREVOTC9PMW8vTGRIc2FSeFUzTHl0bjNFYmpTeUxnSUlWSWR2QXJk?=
 =?utf-8?B?eFhGdm1OTU1pUVpiVEJjV3ltanZmeDU1VU96Mm9uL0oxVDN6T05ReHMxZkl0?=
 =?utf-8?B?b0hBNlpad29PWThzL3BWaWdnUk1Cd3F3SzJsQWcrUW5LczNEWk5xQkFVMC9R?=
 =?utf-8?B?My9UdDA1aHVPbzAzWmtsMkU5bjgyUVZQNGQzY0tndGJmOUtPNzRWWDIwdGFO?=
 =?utf-8?B?anlmbU4yNFRSMzBKa2tRQzhhbVdsKzZGd2VmbSt2cFlnMElkUjdCWFJRa1k2?=
 =?utf-8?B?bkhhdzZoTndFMHhmeUNxREZZakM0QXRZNDVZK2lQYS9HVElZMzNOVlFIcmkr?=
 =?utf-8?B?WGpwNnd4RkxSRlFNSFRFRGhhWDlEWVNoYVYyQTB3SHlVYUNpUlJWWktzcGZp?=
 =?utf-8?Q?Q2fua/nqhKv/flthSqsM?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b583d5-d24c-49cb-b710-08dc4d2be4e6
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 00:30:10.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5035


On 26/3/24 04:45, Brian Norris wrote:
> Just because the EC firmware repository marks these as obsolete (and
> yes, we copy that header mostly as-is into the kernel repository ...
> but it's still a firmware header) doesn't mean it's truly ready to be
> removed. I believe the intention is to direct *firmware* developers
> not to use them -- any new developments should be using the new
> commands.
> 
> From a kernel perspective, we could still be supporting old firmware
> on old devices, and so we may want/need to continue to support these
> commands.

Alright that makes sense.

> I don't know off the top of my head which firmware branches support
> which commands, on devices that have such keyboard backlights. (The
> Chromium EC repository is open source though, with various firmware-*
> branches still around, so this information is available.) But without
> a better explanation as to why these are truly ready to be removed,
> I'll say "NAK."

Yeah that's fair enough, my laptop seems to support both so I'll agree 
the older commands are probably the safer option.

Thanks a lot for your feedback!
Steve

