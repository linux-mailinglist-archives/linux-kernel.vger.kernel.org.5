Return-Path: <linux-kernel+bounces-144583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B88A4817
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAAF281B00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB01171C;
	Mon, 15 Apr 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="F7Egqcez"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570529B0;
	Mon, 15 Apr 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162728; cv=fail; b=hjgrzFBZDgARu9w7Fri7o0jVXsMoigshwqUY+hs6jyjCYxS4mMF5w84REBvB66vnDaqZxTkOqkI7Swm7VECQDEabAVRmgaxmS08hgGTHR3uI96lYq30O4uJcZClRf/ajzQT2Km9K6+gCt2RuH1APNs/jUr+JqGc7RmjwkanjE6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162728; c=relaxed/simple;
	bh=8UCw3b5Y1Z7WlNiQpDlFAhvmQfy0WObFzRcnUj2dpkk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pXmWpRbwwJRZE3LuFGAuJprdKoJm4rVyFLfbRmmHc39ScMtyggmAsm8+35TI3WT8N7fHRVARdCerSXs94VsA7Qa2XX4c2zojF8sufRXng0EyYFqoso799sIn8yFiC99UwA6niE7bTWFfBYJYOEAtfWM/P63eK0TdyZ/h+Ai2AIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=F7Egqcez; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc1t3o34vjv42aa58IWMMJQBCacEva0bUbsqzbtceswsNC0gKxCbmvTchGGvpyJllOcyiMU0O0zLmV4nzdAqWNe185LxddSbrl3K9dH++MEKK+hcZr4g67psw7q2h1Qhgb1oX+AGFDeo30V3Eck7KO/qQ3fsaIsN4WrIP9fFSKWfXwJyl8C8ODYb4GLcyjB1Y8ycO8eu/ut78QqGfO3BZM0nSIHEIi8As/wYz4Mm3qbU5gs3zI4Gy8XPcN98mQ/I81+E+o6M1rcI9Y2fpP9B+VUVKSJJEBjnPx8GreRooOzUxq5WkJxjw9uqxQE7tCevaV6676clLbc+ZGaNtQCeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPo+H0T0wjnGyk8wChRhN2PK0NE6glEEh/NYa9k1yoQ=;
 b=bCe4dZWs5jT4ucYTj+5Mt0UdDCKwhOjLNkxQnvAWJQCOy50oUvhksaazHsIZ9vX8MDpXMCIxWapRuc3qAbtOjh2m0CEqUIlFow8iPotEUmHtjAuW0694dCUWjQaDJJNU0RaOgkkyzhyPBh/pmf6HwI/FYWgTpdOMSSUZDoNKLO9HH/WY++AbshF99ox/4fyYD2k7o/HDea3+9JnqXm3hWP8PmnyoDsv2n0b9BF1j66wXV0FN2vlIM6FaJZMxzxaoa7+i3hnJNp50qMHsYm4BTfeO7F3N+nIa1IcRbWonYhGO76PqGahOEH+N9rgkN1DfMykTNdy2dlr11RIoUxFrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPo+H0T0wjnGyk8wChRhN2PK0NE6glEEh/NYa9k1yoQ=;
 b=F7EgqcezR6rEYOVhRpmk8qiQWTU3I4ApgZdq+hhZgDEo0GuYECUkCVcngB7tav2jEyvA5eh2dGWFEddQd4tSBu/iRcld99XZs96FYviMOmcHIQ0McJltUblrwBiRtgYMhRgwS19SIShgWSqSA+WqnPqs8rfDD0EqJRZDd/k+xiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB8339.eurprd08.prod.outlook.com (2603:10a6:10:3dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 06:32:01 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 06:32:01 +0000
Message-ID: <e8b17c6a-ef89-4b1b-85e9-f2daaf991219@wolfvision.net>
Date: Mon, 15 Apr 2024 08:32:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [input?] WARNING in bcm5974_start_traffic/usb_submit_urb
 (2)
To: syzbot <syzbot+b064b5599f18f7ebb1e1@syzkaller.appspotmail.com>,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, rydberg@bitmath.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000008acb1e061618e68e@google.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <0000000000008acb1e061618e68e@google.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0a70e9-03fb-44e0-c2de-08dc5d15c202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L8nG3zVeWltXy2Ycr1iXo3T1y4JtNcyYESCpXLgF4pKrH9HUKbk/3GPlsxfQySZhG1NyYKoQgg4OBYXcrvGWHwa97Bo15gtlLIMSpIvD9JUXeWifcRVShgLaKOMecglgoAN/c87QxhNhprxB0ZM2kujxu0dP3Q4/UUehGeUL63qUpgkthyVYHrEe4cwBtb9p3ZRYJ7srTMJL3Jr7SJn+2+yOERwo/xozD6K+bJOI3plSngbXh11LspPrff6HTggttTJiXQe54HWChcgCU7bc7nRHLh8EDYlM9ulEumcyM7QEIki/Gl7s5I8W1XEBwVmJ/jvrA1p6qnjQHvStlBdPIODbdlpILatI4AI5ROv8WBedEHcc4Oa0t1hKgn9mnxN2f2q8Cn/VpaWAlLYBUWXsvxrKk6BYU1doJKQisSnx3zWwDvVd+DID21XF1cnS3JAk9EMVrOA2iF33ExQo+SKf10tuUi1Qy6IvoSkSHrhdwMLuzZaLTeJysXHx7olBG1wJHmXTXZ/YUkUbvJgVKQKzI5YQH4QWnXC49JDc7fM56WrX8ZIaQQf4hkTuCWKe8o339cgwdjmPobRPoqNvOOsGYjzHKw5zSvSAugYsPk5vp/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2wxVUxyWC91NU94azV4NTVzTHJMQ2hZWTNkSzhVdnBIeE5qTENqMWk4cUZZ?=
 =?utf-8?B?SjJEdGJWNTBYTFdPUXU2VXdLVGVjUnlORkRObEk5RUJSQVZKU2FJTVZzamZ0?=
 =?utf-8?B?UTFRb2lHakVGSXV4eC9BcnJlRFVoeTFVYmxKZ282SkxidVBOWmRhZFdtaXpu?=
 =?utf-8?B?MWZBYlpTSHJXZVQxK1RsSmpUVmYxdjBGVVBnT2lBVHRicXN6NmxuakVMMUdw?=
 =?utf-8?B?NSszdHdLWkE2YU5TR3ZLZG0zOXBOanRBUWFMQTlCWWtDdlZqVG9EUERYb1JJ?=
 =?utf-8?B?MmpQNlA5TkxJNW5ESmNxcXFCYko2bGx6TGgvNFk4UEQxOWZxYkNUQVVFaXEz?=
 =?utf-8?B?Zkt3VDgwL3QzcUtwRGtGbGY1WHBzSEs5OEJUeFFrRzBGUUJrd0lEYUszMGxC?=
 =?utf-8?B?QlhOWmxCUlFSTjhWR2VQSGlHL3pjOVpDcVlidmVzZHgwbnJjNzVtcUpqWW5G?=
 =?utf-8?B?L0dEL29SdTlEY1c0d1lBWjU2NSs4Y2h6MWJONE9QVVZwSTJxNEFRL0MrQ1po?=
 =?utf-8?B?Uk5wWlJsNHc5TDl2VlBCRjBydmM3cjBUQktXdnlKcnNtcUdBN0RIc2JISXU3?=
 =?utf-8?B?T2QrWm1UUUROaGVTbTlkdE9BdGdxQ1ljWE5MR3psalZRdHNqamV0V0oyZCtM?=
 =?utf-8?B?bS9EVUV4aFlKeDRCSmw1Ukg4RTVyamZua1lBMVV2bmprdVVGUGgrMktzTXpU?=
 =?utf-8?B?blFHcU4rVGpaS0h5d2hRL0dDS1JrZHIxNGc2UGRwQlZNRGhVbGV0K3FUYTRS?=
 =?utf-8?B?VER3bkQxaVpDN0FZSEI1M0drZEo4aHgyVFJwR29pK0t3Zlk0NEhsOW1CckNj?=
 =?utf-8?B?bW10SzRHWnRNRkpvNkJkTDJmNWVGQVVQcm55b0FqaXdwYU9YQUVqaTNadk9t?=
 =?utf-8?B?UklOMUVNVndmSlVYM2NNWXdDVlpwSlJoMUdYT3paWkVUZzM5SkswdnFzSzdJ?=
 =?utf-8?B?bnJ4dFRreDJGR2xJaThZR05QUEdXNWVZTWNVUjFCOG1mckdCY1ptVDRqUmRY?=
 =?utf-8?B?eEs4MXcrSGtUdXNSMW9uTTVreldIN01kNm1wYy9odUxCbmM5T2lPcFdGMm9u?=
 =?utf-8?B?bDg4cmtwNEJhcTBlZnpHOU11SGx5U2ZKZE1NeVN2eFV6d2lZYjY3bFc4M2N6?=
 =?utf-8?B?VHU0ZzJWVkxuOHhqTkxlRGkydXNQL2w5ZEsyS0I5NlNGenJ2SnZOMDdCNGxj?=
 =?utf-8?B?dVhBNFc5b3FjMnE4UHZ0QXprNkRmZXcxNGk2MERBNHlzOG5lNTdrUDFOSEw2?=
 =?utf-8?B?OG5Fbjd0akE4MXYxS1JLYWpZSkxYNytSL25FbUxsYWlYQWFHcGlvRC9QaTls?=
 =?utf-8?B?c1AzYTF6RTlHR0pPU0IzYmhuSmUvbWpmWjVybS9jZlVKR1lKUlZjTnNHc3hF?=
 =?utf-8?B?ZWFsWDFRV0NSc1Y3cG4xUGtlTXlhYXB3T2g3alUrdE1nWFFzUHBpQWdIa0x1?=
 =?utf-8?B?Y1F1SWY0WmcySmhyMm9FcDdhYS9XNUxpalN5ZlhZZ1EzZXBFazI5TXhPcUgr?=
 =?utf-8?B?YnNlQTRJcUtrT1ZOTXQvSlVoYkdjOGI2ZWZJcEJJZ0ZNN0ZqQUlINFN5VmIv?=
 =?utf-8?B?c3poZGR6TFJHc05YMkhELzFXNG8vUFA0c0RMU0svMWVReitJT0dEL2pLWTFF?=
 =?utf-8?B?QnBKcXI2aE4xZExjSnU1bytaeml4OU8wWEtiYlFEaXNVc2RYU0VrMHE4aDRO?=
 =?utf-8?B?QmNwR3Q1cDNwRU91d01mV01uY0JWbklrQTVDSVhQa0NyNE9SUVJqbmc4cjla?=
 =?utf-8?B?M1pkWEw0N0pLUVloUmQwZWxjYzVxdjdVaXRVK2s4TnpVaVNpRUl0NHNpWDN5?=
 =?utf-8?B?SGZoTm5EL3F5SGtsbzRCblc3VnZ0ZmdzcVNJSWVIR2tiYkR4V1VZaldKV3E3?=
 =?utf-8?B?S2dXcTI5U3BBOXJyOHc3WTdadDFheTFSY3hDSDh5bzJVTUtJbWlNZDhmMVAz?=
 =?utf-8?B?aVNvaklUOGNYeGxFajBQaWtEQ1hiaUFXdUxSNThDTkpJOTUyWUhFY1JSQzlv?=
 =?utf-8?B?dHF6RGo2d1pnNi9jU2RSMDFKcWJjS1h4L0QzQTJ5Lzh2YURhT3MxSFRrejdG?=
 =?utf-8?B?RUZZRUFnSUVKRzE2SW1mVnNXTFRHZko4OGk4WlFBY0xyL3U1SnN0U1pXUENm?=
 =?utf-8?B?MUZOc1MvVUJ4c1IrR3pQdlc0K0FqVUl0U1phdlBlMFJBVGJsYkFoV0ZIZStm?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0a70e9-03fb-44e0-c2de-08dc5d15c202
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:32:01.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUIlKMrxe8jcQdtxqnrejTouct6fybNoy8KK5tp/YKYXAx7kQfdAmJc6Js4iSuueZgap6d0HLU4MHvLPtYJiYX4k/thbn76aYVHo4iwbmR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8339

On 4/15/24 03:54, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fec50db7033e Linux 6.9-rc3
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14439bd3180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=560f5db1d0b3f6d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c2c5bd180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cbbf5b180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ab4d6cae2eca/disk-fec50db7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b67542cc5860/vmlinux-fec50db7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3eeebb470b79/Image-fec50db7.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b064b5599f18f7ebb1e1@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 0 PID: 6237 at drivers/usb/core/urb.c:504 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
> Modules linked in:
> CPU: 0 PID: 6237 Comm: udevd Not tainted 6.9.0-rc3-syzkaller-gfec50db7033e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
> lr : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
> sp : ffff80009f8b73b0
> x29: ffff80009f8b73f0 x28: ffff0000d4fee000 x27: 0000000000000001
> x26: ffff80008c6919e8 x25: ffff0000c8bd1fe0 x24: ffff0000c1d45a50
> x23: ffff80008c698500 x22: dfff800000000000 x21: 0000000000000002
> x20: 0000000000000cc0 x19: ffff0000c1d45a00 x18: 0000000000000008
> x17: 0000000000000000 x16: ffff80008ae6d1bc x15: 0000000000000001
> x14: 1fffe000367b9a02 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000002 x10: 0000000000ff0100 x9 : b1573c5f9bab7600
> x8 : b1573c5f9bab7600 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff80009f8b6b18 x4 : ffff80008ef65000 x3 : ffff8000805e9200
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
> Call trace:
>  usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
>  bcm5974_start_traffic+0xe0/0x154 drivers/input/mouse/bcm5974.c:799
>  bcm5974_open+0x98/0x134 drivers/input/mouse/bcm5974.c:839
>  input_open_device+0x170/0x29c drivers/input/input.c:654
>  evdev_open_device drivers/input/evdev.c:400 [inline]
>  evdev_open+0x308/0x4b4 drivers/input/evdev.c:487
>  chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
>  do_dentry_open+0x778/0x12b4 fs/open.c:955
>  vfs_open+0x7c/0x90 fs/open.c:1089
>  do_open fs/namei.c:3642 [inline]
>  path_openat+0x1f6c/0x2830 fs/namei.c:3799
>  do_filp_open+0x1bc/0x3cc fs/namei.c:3826
>  do_sys_openat2+0x124/0x1b8 fs/open.c:1406
>  do_sys_open fs/open.c:1421 [inline]
>  __do_sys_openat fs/open.c:1437 [inline]
>  __se_sys_openat fs/open.c:1432 [inline]
>  __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> irq event stamp: 5626
> hardirqs last  enabled at (5625): [<ffff8000803749b0>] __up_console_sem kernel/printk/printk.c:341 [inline]
> hardirqs last  enabled at (5625): [<ffff8000803749b0>] __console_unlock kernel/printk/printk.c:2731 [inline]
> hardirqs last  enabled at (5625): [<ffff8000803749b0>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
> hardirqs last disabled at (5626): [<ffff80008ae68608>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
> softirqs last  enabled at (2362): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (2360): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

This is a known bug in the bcm5974 driver that was fixed with commit
2b9c3eb32a69 ("Input: bcm5974 - check endpoint type before starting
traffic").

The fix had to be reverted due to a more severe bug that was hidden by
this one and caused a regression: the driver makes use of endpoints that
belong to interfaces it did not bind to (see discussion here [1]). In a
nutshell, any check to make sure that the endpoint belongs to a bound
interface will fail.

In order to apply the fix for the bug syzbot found again, the
inteface/endpoint issue must be solved first, making sure that the
driver binds to the right interfaces.

Link: https://lore.kernel.org/87sf161jjc.wl-tiwai@suse.de/ [1]

Best regards,
Javier Carrasco

