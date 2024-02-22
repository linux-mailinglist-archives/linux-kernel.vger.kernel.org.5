Return-Path: <linux-kernel+bounces-76290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884D85F540
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37CF1F25DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291B3BB26;
	Thu, 22 Feb 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="HkeexRJv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="a7IfFn/N"
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27043D396
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596314; cv=fail; b=rwkRYJZ3h1sQ492p6M5ejCjDweAH4OwvMYw21eQNrtL9mTfLUVePkGIseiOTd7yeHnWOj07+zWNqH6qCGVYB4KuiTgWV1sLNdxNJz2HvGdSTPfYs3tZ/HBhbGajbOktFV8oR6swZ/Og6Nua+X53Ef+FL1Hz8giz95u3eT+xzVXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596314; c=relaxed/simple;
	bh=7s12crFQF1jr+kFZE4OzeLY1WgH2i4yuxgdLqXENnes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+HxxP+QCs9WXRNBq0HgjRUMu7PBY6z3Z3NEK2QJwlrHX6EyreaFr4TJKCGY8S9US/teOHFJAAZylh4ktwpibrwKn0TBliYBtPcDbMGRI0gVDBpEMrGJ+jO4gnzBUE+41dhgNPcT36RR3HcdklFE9+jm8rFH9S9pFJPFWZYdH6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=HkeexRJv; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=a7IfFn/N reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 0A6AB349CAC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:01:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1708596091;
	bh=7s12crFQF1jr+kFZE4OzeLY1WgH2i4yuxgdLqXENnes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HkeexRJvHCXE8KpTfTaCkVxM1r8arQlvkIy86UWWKgCUycm2ffMRWUKFI3XBc4O1j
	 2083rGwSu6MZzqbmqsi3WQvFFD7hEDgGDSckLwhoG6YT5TCE9WVeWGzXU5y4aEvHYH
	 lydf5HbzkXdR3IRSLx1JewHZf2KMTRSaYuMgt+Ss=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id D0A84349C92; Thu, 22 Feb
 2024 11:01:30 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01on0101.outbound.protection.outlook.com [104.47.24.101]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 64F7C349CCB; Thu, 22 Feb
 2024 11:01:27 +0100 (CET)
Received: from MRZP264MB1896.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:16::6)
 by PR0P264MB2025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 10:01:26 +0000
Received: from MRZP264MB1896.FRAP264.PROD.OUTLOOK.COM
 ([fe80::224f:f37a:bdfb:4374]) by MRZP264MB1896.FRAP264.PROD.OUTLOOK.COM
 ([fe80::224f:f37a:bdfb:4374%4]) with mapi id 15.20.7316.023; Thu, 22 Feb
 2024 10:01:26 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <2a6e.65d71b77.5710e.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJmyhEMEZ01srXucmMmoSJYxNFFt9mVp2SWf4K0iPhYFtPIlfi341NApShoDqtVDnXZr0AvH4mOL/ASD4lijMOL2IGafiI6JlA799G/Zxc0zVgTogyVSGhCLqHoqGKif6qN87NZeo+/vl7ky8VemtB+6U8CBnG+vb3+WLJ35LOa7cTX27A1gEBxdWtjDTsczLloz+j0s+P3reUdxJPydrmrN2rNdmalp6A6pk6RfxT6l/RxNjimkNlJV8kpCgenl326oAe3dkqwJkZymgt2troNHuREFNMfMZe221rbvyOcTGPl27RoMxkAlflJuls4HmKF35te+XTFoMQWSwShS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=192FFxbe7Lzoht8qt6lDO/K8b2gMpd050Al+bpxRipk=;
 b=bFHy9Q/5+BWf5GxamlcXcHee62zG1lAe9+ZwjzqGL2rRJ3sk3SXWBBhR68KbFy3j4A/rAwpNNwUoGdH4yGkUmI5C6I0zXU7od9XMlXSpB4tDACRdy3Nh/K5GgS8T4x5XlLDyoZaymgSWbL40TTOZ9A2u7wt8uYC/uhIhBtV/MCU9iCkS3cHGJVFthwEBFauyHFahJxUAhxsrLb1xgRx7P/6pTulKkiiOW/x8+axG40S6gEj8ryu5a8BovFHRUaxHb2ca39LtU7HTMYjMyfCHSIMkeUmyBRUWnMXwYVBaJLnRH1VA4g6+jtMGJUtnl3wKFba6qk0BzgnHIoSnPL0uzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=192FFxbe7Lzoht8qt6lDO/K8b2gMpd050Al+bpxRipk=;
 b=a7IfFn/NouH8n2nN1engiJ+rBJQipSlTOXqM4lfd8arXw/9IzFJ6WCQ+/w56hCI6xdrw7QG9U9cAdcq4nCmjzupjie/Tx8pcqqjqZDmxIh8DmbbODAHknjDTFK/k2kFcAoSF9P2bZR35zfknyBq2n80THBouH3pZmUqAaBp8YG9v0JM0RbRHe2K9y9K7E1CW51K47xI7zqwiYq0TfcSMOcCUb3A5O8lB8Z0vHDbe9JLf8zQBdTT3sYGuReC9HOZtSNc1TVwa3WsoV+hr2/O1fJjAoAhz2ddzBZeDZ+mt4D0TXZnYEWL3T1LTw/RX2x2KGuvIfYjPLmyosfSWdXzBsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <20c84ea4-cebc-82ba-827d-34c956e9faf6@kalrayinc.com>
Date: Thu, 22 Feb 2024 11:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
Content-Language: en-us
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240221130223.073542172@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:208:55::38) To MRZP264MB1896.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:16::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRZP264MB1896:EE_|PR0P264MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: da60f5b1-2ea6-4b3f-e22c-08dc338d3b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fj9V9JZbIIkTfR2FJk7qTzFihzRzQ0l7b2j827dYH5URHT0O6eYl+fMotsoxbfM13v1DLmpxcK+QX+KEOvfiF/6ra18rGwf+6xrPWqAMn9FcQVw6SceVRbhCI2TBWV3muikEU3EbWBGxzano3b/Qrun9JOUe69R+JOqrofkajyLr/KbQHqJyQ42cQqRGANwWTfg884+vo8dsvmC4eTsjWcrm4I2R4wMaP0BtJdEOzsG+pcy89BWnCB5J5izce5JQ8U0EkqWBjxqm/rHyPqoYmpoVWFP8Kv8k32/r3o6jqiUDOcRCb1fJT1rXFvHXiRYbane0Oj0lZm2C5Mxt/qBeQIkYi8ZyXdzdZUtlMdlqXhfPE5AI4uFGBD54H1Jg/llXW4nsAMeRFSrtLqm/2FtU1199TV1aE0o/Fzn8/vPUvipEKqcRW0pewIyezyXuK8HimnqwUCViJTwzQGadvg1yEbc9dD8FXuALu7+NZUmaHtcBMP9jRncEgQaBHEdDqYyGEfARizCuw+OCBN0IMqE3MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB1896.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: twJu8MGUkEOl6KBnU3E/2J/ua5ONcHrTRb1W6GV6IQy9YZQAAAcWf8GizeTgHmvR1md4dJVaqv7VKpQKSD9g8vCQ5vrPE32/pcgnDTcLsvhrysT+CmtsipaElPrgArQBVO/MbanrBDprxmBOSsjeq+iO9vk8wQ8zG+LlujDMTQabJAbSMBHu11ys+ZgzigE8dMn30/oJykJRdv7d9FUQOiFJMLu84aG+lK+A3d2HQ282M1R4Q11nDFGoDlc+cT4HBox1IB+tB3SEalk7ztr8Le9nbL/nFVRgVpOpgFmr/j1dxQhwj77xdxU4zfiZ/6m9bh/5PeCfR6K4sHV5iw1k13EnxfgY/FMLQ/fn97hRIn4VKzLFWPRPWQrK92TnJ4I0WCH3VgyeWe1qIdhFsghanR/Vxfk17FAjPZ/ogX7KOjAsNxHGmRBPyg48t55KlTubd4raIImcABnbN3Q7z/ga7N7y6cYTjP89LSPXx+Cm+J7SZ5hJp3FE03DLqAmxVVxrAWJsEP273UbDj/yYGNuDRcv2IlR2evQmKxsQK6LZ78cq7qyg62htxUVvRSBOiYe6wuvV1amcFmYWacM2yf44jIoVS7gh5+89ubzpVXUvQYtf+vdqypMLcnBKEFuaJgzvpZMarFjmGFxs2g15nVu/hNek/vSYMDJfbxycesIumNxOg6kuWwbameMMbspgR0jFYzOMJh16wsUp4HEFe/64SzZs9WVC2qRDvZiaNpKPiXtoh7oyTTOSFN5XGe4sGUZkmvnoZWXE68eaY3ALrMcJiRIxYF2Aud6QlWegTD7bCzEXpW+bFgqgN9Q0ewHNtqPGnp2QoCg02dHVMpel6yJ/364eGjtcApHFVOs5zTk/D+o8B6YD2X0MCbg3FZJJGHE0ZA3oHqC8QphjthnSXcd4cKNVDbpM7amJOezpLKLbrWXQeZCCLC0XBQnDlVJe75nT
 Q9b3eg+38s1JFYFjRtvlcczFZCmypj/4ZgCO/VJAxi6YVVa2YkaeSHer6ow012B8iviITPTDPlxe1mmK3iEY765RMB7YGlFWZJOgRRE7e2mYfIP49WSkEQ2F+Bu0l5EPrwlHWNGp0itGG0Bhnuu09MuqTHCRgiGNHl+dWtxrbNO7ZGaYwSE8YVWvYwSCmVbsQm+5sj2Uv/XF+RIQeIZFE7OahLlCWK9A5wmhhgjMI1Ygi0Y5s3YhYo+ETtRyUHunFP5QjNTIyVB71lsGgBlnp5z5OGu26NFju5sDdVLVwUv08/YA0sSrRgtq83K3MLAfkcHJDNJ2kJhipUJE9diK3a56774j9+CeWTB302hSTRZBkZe7rg1WC6yCWsVTffcF6c+PeRUB9JtpYLTxw/+SN3XkmTvWqTngCx/7xq4mruo2reF0rY6eNHJAC9Auw+nZ0vgFPkoijuS/k1qgIISO8W2L8p7p3C5+KnriGLn/ZlFJlr8Nagvbw1l/OL76KFPXz1hoUqWP7QxgQSIkyVPDdIJx8uSOn/inU2VuHhKUXXXvzujlstfMdeP2MRuoCz7jRXI6W6c0xAHqlyGExsg39r0DZcZVj/t3EbGbldyEFbKhOHrNYmGM5XUS1J6SM0tOxUqcCchbbuG9IRG9ARMbwQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da60f5b1-2ea6-4b3f-e22c-08dc338d3b28
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB1896.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 10:01:25.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43y0gLKxWGJTdD5hYYDr7C7B59dWtyJTMdV70egz2XgiinJwNOJDlQb7kY8Sj2ZKmhOnCHTHVUckV0K9X2NrOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2025
X-ALTERMIMEV2_out: done

Hi Greg,

On 2/21/24 14:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.79-rc2 (64fdfe5f1a1d) on Kalray kvx arch (not upstream yet) : I had to patch `arch/kvx/include/asm/jump_label.h` to get it to compile because of the "asm goto" changes but apart from that everything looks good!

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau<ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






