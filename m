Return-Path: <linux-kernel+bounces-90321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080786FD91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05467283977
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E72224FD;
	Mon,  4 Mar 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="IQCm1pJ+"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2101.outbound.protection.outlook.com [40.107.13.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E191B802;
	Mon,  4 Mar 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544332; cv=fail; b=nQJEVyiGH/Qkt2yZZ5Tc2rmPS1k7QLcbdn39FaXgLOdP1tHZK0BxlQRQdwCizvHOv4tp6Ml/tyUyme4KckBpFyYBJnV5Jp7skm9ktxU41+v6nfmF6IkrTVyfjM5XkeDK6NhudVYuVYntghJsVgHtP6OPkDcWRUN/afhQJ5QAtfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544332; c=relaxed/simple;
	bh=jvvRgKJ7YaGJJiHhFtGVmQRQBRL4v885E4rlYqTf9WE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHy85s45n5lKOM45MTAPflNT3x+V5EFwE4cXbUlmayuCz1Kn9etzdmlzxWEECdekqBtXzTjpchNkgiJsTHlwrD6LmcG2BtaPKhXeH1zky5V/Py8pZ9IpQ9BpRAUUbfHHxFoDY/SsxFuzT0ZX9zXgQNUaVT3jDTMNp/q/ujYL4f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=IQCm1pJ+; arc=fail smtp.client-ip=40.107.13.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ5AILDQBGOXgO6Mlunc+qZbNeQFbkvm7kb8AekVUeYBuOyG/TZqWPhhM0uhXOat8fMfUFzxoSJCKLBClYLHErWZaTSc8kgWeybAx2DJOQyEdRMsZGHqCSLhJITUdYqKb1OgAJQ7ByxuG33MWjtZSqbh4TT/md4enWcfjDIpx9Dask85wfd/Vc4rIqiC5NDIQpVcO74AdjQalydJVN9LyBdgRR/ZaMZUyYq24+rQe+ypTbqX0gBoUSoHUbgEQTr6fBdtXRZbIqPx3uPjM/4QgsT2sjm8/N70F0SDeX0pEMU2A9zLIsvF6aECLUXufALijWntswGvMg1ugtYdtXCoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCk4yLHOberp6vsYFV9gcVFnoz5/ux9aI/jnACld6UM=;
 b=ZjZiBSltOxA9KKAeSp3lo20d3Plum6zDzYGEcQ+crosWnzgGUZePlcWZZjPUEKBanjGLt4hFtfMW4qXFoqf9Diy3MO4B/Eqr4PAWk+PJs+4QXzsFeskYBDcXvFkG/e4nyO5V0OFlNfDpB47fxzqAun2IJU3kFx7I8DiF1AttdNu2eLDl72BX1nmYNDykaURiFPIjqPHujW2Okf/zJTBFg4ViIopoQf/0UeDxmusJrus2/MxEaCzMlGi581MuzNNp5vXdIP0H2eL7ZZU779ygDIJwbBhizp9paDErKcf+sv7CcYSVo+kr1tPGFG+Tt+W8U2za3tsgB6KVrndr8M+gmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCk4yLHOberp6vsYFV9gcVFnoz5/ux9aI/jnACld6UM=;
 b=IQCm1pJ+B8CSaqxwOky7G9X8D8FS6VCscPtoet2a8tXDMA+ybV9k5IEqKYqA6LfEJam5pATkWskhf+LY/i4QzJPxnlw4/MwbTn8dkJMtpt33juCsl1GgdGlnqJiZb9/g+AX8G5bATQdTOCK6jDv55Ig+UlIDH01uzOEi95Cyfvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB8627.eurprd08.prod.outlook.com (2603:10a6:10:3d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 09:25:26 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 09:25:26 +0000
Message-ID: <0e68d986-8834-4586-9525-18ac99a3ce6d@wolfvision.net>
Date: Mon, 4 Mar 2024 10:25:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v13 2/3] media: rockchip: Add a driver for
 Rockchip's camera interface
Content-Language: en-US
To: Mehdi Djait <mehdi.djait.k@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>
Cc: mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
 paul.kocialkowski@bootlin.com, laurent.pinchart@ideasonboard.com,
 Mehdi Djait <mehdi.djait@bootlin.com>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <715d89214d1ed6a8bb16cbb6268718a737485560.1707677804.git.mehdi.djait.k@gmail.com>
 <Zctwo3s9hso6mQvT@valkosipuli.retiisi.eu> <ZdY5KrTfss4lTjPO@mehdi-archlinux>
 <Zd24MhLYJlSTRysr@valkosipuli.retiisi.eu> <ZeMSuihjcS_wXONr@mehdi-archlinux>
From: Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZeMSuihjcS_wXONr@mehdi-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::6) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: ba88e958-0d03-474a-9482-08dc3c2d066d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jmse1vGRVYdYtSu/+YhsRySywu8jCLDXieiQeEfFO3jgwJCKoVtmkQvwt77LzYOfGUS7ybmMa50m/7FtTURcWaHDgIIociF30fT7QmhUQqMsUCbi3aF4f/K82BNS0hBBgouBNidY5sH77sGoPWZgExF+R2T6kt/TbJOObE2Wjx8cLAhcgXlGu/5EKjoEimUfIf1YRjiNtaz877aTkNlulUW96FFXOsK0fCcNpDaP1d5tIEjbYRg8B+4BzHAClldWAis7VNIdJQbg1S0OUXf6JuTKMP8/P+lx+9zsMSTrzXKqC2ZVs5JcO6mTFhzzcmSPHEudkUyDGxQLqLnsV2ALTM/ZU/dsgkkAD3jNouOfDkRFPYhjb7OGEHBfDqBO+T2Q/S2ksuTYnvmljLRMZSAmWNAZHlQmFxHb9YHMIZwkl2UqNhMD+womXsfuiFxrYCZomp0nEj7lHQfjGe+o8syDaGrtk9VwRZnLZ60NsUzTQ0P+Uj4L42uDcCD24PUoqWXtzJDKCQWD2rnuZk8OhQ8LEfy3PwEROGFJUx+OnccWU5AGMbg6//ydyGY1p/32D3khHEgEChax6PLCva9ezcNv4obUvQJTHuvPlC9UdfQk0R4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2lnY0g2cTVnRnB1Z2VjQWtaemcyd2dCVDl1NjJMNFFpUENRaXZ0WHk3bUN0?=
 =?utf-8?B?WUV3R0dubDlobXluNUsybmwybk1RamlSL3luMnNiSW1QSnVxdmhMTU0zWFZR?=
 =?utf-8?B?MzJYTGkxWXZnZVNSZDEvSkZaN0tqeWVHQWlEZDUvNjF2VmF5MnNPVGNsMjB0?=
 =?utf-8?B?QWhwVTlWRlljdFFIZDFSaUhGSXI2V0l3VTdmRGxNSFMrbzRUU1l2VWFiZ3BM?=
 =?utf-8?B?NThzNlBZK0REKzd4TUNlN0dFNitVNkMveWlvcUEwQk41UDNCYjhrcW00bk1D?=
 =?utf-8?B?K0JScll6ZEJtMkovaUpiTTBqQ3BPc29WSFYyTkIwRUZNOTMrU05CU3R5RCtD?=
 =?utf-8?B?YzR0Z1NWTGl0MW5HZGFNL1puWFBlY0lpa0MwR3ZsbjFkN2l3eWNFVTRhYkh5?=
 =?utf-8?B?S3RyWnR2MVljcHF3NXFkT3o1TFYxMTd1SDVRa1Y5Q0dVUGZzeG4rN04xWm9D?=
 =?utf-8?B?QjhwOHpoYnFJWng5RGIxeTdXWVhGeTVSSzFpTVB2ODFWU2R0czhRbmwzRGkr?=
 =?utf-8?B?djY4UkZpaE5nSVkvc2F4SUpkS3lLS2s5ME5wa2dVQjR6UFg5cDJVYy9LOGxI?=
 =?utf-8?B?VGVMd0VGTFVabE56K01saWpyM2N2dDZPYVJmRE9oN3plNjh4YW8rZklpRFh6?=
 =?utf-8?B?L2ZDd3RDQXVyanBpcUY1NE0rWTlmcFNPcjN4RkRhU0c5c2VYbzBxdEJ2MHor?=
 =?utf-8?B?YjFHRTY4OGpMTE1XVEZWNDM4eldMczYxUGh5NE15R0JRL1JRM3U0c1dTWk9Z?=
 =?utf-8?B?aXpuN2lXZmdxbXNtMHFVMkRpNWIyakNuRkRRai9QSEZOdWRkaUg3RytKOXZ1?=
 =?utf-8?B?STZMRFp6Vno2RjBMMkNTWGNYMHl4OTBoMmxRSWJDT2ROUEVpU2tEQlJ2OVRJ?=
 =?utf-8?B?OE03bi9GY0pyMzYzcnpHZnRVQmdoSGZaSGxIdlBTaTlVT21ZR2h1aTQrT1BI?=
 =?utf-8?B?WE9HTWZxd3lnRlhNSTZlN3N1Wm1NRlhZaHZ4UW16Tmx6aVg2ZGFoa1VlQ20x?=
 =?utf-8?B?dERHV2xFSmduZ0MxaXFyRE92ejVnTjljNFFKUjRCSStXbjhwVkVUbmRaRWlr?=
 =?utf-8?B?SlMwOHdkS2RDQ3lRdzd6Q3VvOVR3aXlMbytmcDNkZXFoQllMcWVESkE2TkFY?=
 =?utf-8?B?ZG9kc29iSWU1VGVkVXRPb1VwRXBBRjJvMVY5RzZ6SFNodkpvRnhnMGRoRzRL?=
 =?utf-8?B?SndUOGFVNFlOL3J4NVRzVEV2dk5SYUVzeGg3MHZseFE3aWM3cUtNak9YTVUw?=
 =?utf-8?B?OEZBcnZhNnJ0VmkwSDdkOFBZbEVrcWUyd0lLMkQwWEh4WlI3VWQ1MWJUemZz?=
 =?utf-8?B?Ry9XYUtVZU9WWmp1TkNmcC8yNzZ4Z1pNdVZtdHQ5NFY4U1Fod3hYWm4zTGZF?=
 =?utf-8?B?ZDZSWEgrU3FidlNMQ1BqWUJFVHI2Mko3VE5yc0drV01RT1VOOS9KckJBcDln?=
 =?utf-8?B?T0dHdWV1TUhSQmhxMTI0cWx4Y2xua0ZiUjhoWXZYbUR5WlpuYm5BSmloNFNu?=
 =?utf-8?B?bXEvbFlnd0luVVMvVWNEUU93OVlaRTZFeURTclZ4STRQMVJ3UWl0ZFZJVTIz?=
 =?utf-8?B?S0cvRlJ5cmpUazhwTzdOUEhMeVdCaEJaeUFJTzUxZHB0bDNPQWJ4dHRnUmhQ?=
 =?utf-8?B?b2lIMXZCRXlrQitLdzlUdE1FZDNqK0c5T2VsWnpUcDFBQXZpZDN5b082MzlC?=
 =?utf-8?B?MlRuckpsNmlDRUlOd0RqaUVaa1Z2SVl5SDNuVG1FakkyaWNqRDhsNXBUNlMz?=
 =?utf-8?B?UGhUem5FaUdQd1pWdWQzcjhzV2haRll3OHpwckdxTVljQjI0QW9RdlBXTjFi?=
 =?utf-8?B?Wm90K3p3UVk0b05TUldJanV2QUh2NFBHRlB1UGpQUVRBV0FpRGxMYUZjZWVN?=
 =?utf-8?B?KzhQRmp4NGwzWXUyZ0oxNFdPNGNncW92amVWOVBZMGZ0YXJUMHRzT1VkbDJa?=
 =?utf-8?B?YjhRNVE5Qm1yZGxtV1JCS2R4V0d2ZGMxUHYzRlROVld6T0RwRE9BKy9NMXp0?=
 =?utf-8?B?S205bVUvZDFhT3NMRXpjWktNUXQzelY0S1VadXNVWHg5aDJUK01NYU5neFJU?=
 =?utf-8?B?ejB4MTZoUk96NThjR3ZMMUxVL3oycDdOQ2pSY0UxeFI1c3d0MHhOMGo4c1Rk?=
 =?utf-8?B?b2RVa0YyMEpLSjVWbWV3OGhyL2hZV0s0QWt6bGk3dkxKbittclc1ZHdIWEN1?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ba88e958-0d03-474a-9482-08dc3c2d066d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:25:25.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3IsxwmkDLtqPio3zBPYtNciHlg+RS7Jg0/6fEo5FOnV/G9Tkqm1hvMoo6HWT+oXADcGgD37XIilvsnYQQJNqzS8hL8NRPM/iRpIoELYpJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8627

Hi Mehdi, Sakari,

On 3/2/24 12:51, Mehdi Djait wrote:
> Hi Sakari,
> 
> On Tue, Feb 27, 2024 at 10:23:46AM +0000, Sakari Ailus wrote:
>> Hi Mehdi,
>>
>> On Wed, Feb 21, 2024 at 06:55:54PM +0100, Mehdi Djait wrote:
>>> Hi Sakari,
>>>
>>> Thank you for the review!
>>>
>>> On Tue, Feb 13, 2024 at 01:37:39PM +0000, Sakari Ailus wrote:
>>>> Hi Mahdi,
>>>>
>>>> On Sun, Feb 11, 2024 at 08:03:31PM +0100, Mehdi Djait wrote:
>>>>> From: Mehdi Djait <mehdi.djait@bootlin.com>
>>>>>
>>>>> This introduces a V4L2 driver for the Rockchip CIF video capture controller.
>>>>>
>>>>> This controller supports multiple parallel interfaces, but for now only the
>>>>> BT.656 interface could be tested, hence it's the only one that's supported
>>>>> in the first version of this driver.
>>>>>
>>>>> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
>>>>> but for now it's only been tested on the PX30.
>>>>>
>>>>> CIF is implemented as a video node-centric driver.
>>>>>
>>>>> Most of this driver was written following the BSP driver from Rockchip,
>>>>> removing the parts that either didn't fit correctly the guidelines, or that
>>>>> couldn't be tested.
>>>>>
>>>>> This basic version doesn't support cropping nor scaling and is only
>>>>> designed with one SDTV video decoder being attached to it at any time.
>>>>>
>>>>> This version uses the "pingpong" mode of the controller, which is a
>>>>> double-buffering mechanism.
>>>>>
>>>>> Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
>>>>> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
>>>>> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
>>>>> ---
>>>>>  MAINTAINERS                                   |    7 +
>>>>>  drivers/media/platform/rockchip/Kconfig       |    1 +
>>>>>  drivers/media/platform/rockchip/Makefile      |    1 +
>>>>>  drivers/media/platform/rockchip/cif/Kconfig   |   14 +
>>>>>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
>>>>>  .../media/platform/rockchip/cif/cif-capture.c | 1111 +++++++++++++++++
>>>>>  .../media/platform/rockchip/cif/cif-capture.h |   20 +
>>>>>  .../media/platform/rockchip/cif/cif-common.h  |  128 ++
>>>>>  drivers/media/platform/rockchip/cif/cif-dev.c |  308 +++++
>>>>>  .../media/platform/rockchip/cif/cif-regs.h    |  127 ++
>>>>>  10 files changed, 1720 insertions(+)
>>>>>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
>>>>>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
>>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.c
>>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-capture.h
>>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-common.h
>>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-dev.c
>>>>>  create mode 100644 drivers/media/platform/rockchip/cif/cif-regs.h
>>>>>
>>>>> +static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
>>>>> +{
>>>>> +	struct cif_stream *stream = queue->drv_priv;
>>>>> +	struct cif_device *cif_dev = stream->cifdev;
>>>>> +	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
>>>>> +	struct v4l2_subdev *sd;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (!cif_dev->remote.sd) {
>>>>> +		ret = -ENODEV;
>>>>> +		v4l2_err(v4l2_dev, "No remote subdev detected\n");
>>>>> +		goto destroy_buf;
>>>>> +	}
>>>>> +
>>>>> +	ret = pm_runtime_resume_and_get(cif_dev->dev);
>>>>> +	if (ret < 0) {
>>>>> +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
>>>>> +		goto destroy_buf;
>>>>> +	}
>>>>> +
>>>>> +	sd = cif_dev->remote.sd;
>>>>> +
>>>>> +	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
>>>>
>>>> You should use the format on the local pad, not get it from a remote
>>>> sub-device.
>>>>
>>>> Link validation ensures they're the same (or at least compatible).
>>>>
>>>> Speaking of which---you don't have link_validate callbacks set for the
>>>> sub-device. See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an
>>>> example.
>>>>
>>>
>>> ...
>>>
>>>>> +	if (!stream->cif_fmt_in)
>>>>> +		goto runtime_put;
>>>>> +
>>>>> +	ret = cif_stream_start(stream);
>>>>> +	if (ret < 0)
>>>>> +		goto stop_stream;
>>>>> +
>>>>> +	ret = v4l2_subdev_call(sd, video, s_stream, 1);
>>>>> +	if (ret < 0)
>>>>> +		goto stop_stream;
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +stop_stream:
>>>>> +	cif_stream_stop(stream);
>>>>> +runtime_put:
>>>>> +	pm_runtime_put(cif_dev->dev);
>>>>> +destroy_buf:
>>>>> +	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int cif_set_fmt(struct cif_stream *stream,
>>>>> +		       struct v4l2_pix_format *pix)
>>>>> +{
>>>>> +	struct cif_device *cif_dev = stream->cifdev;
>>>>> +	struct v4l2_subdev_format sd_fmt;
>>>>> +	struct cif_output_fmt *fmt;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (vb2_is_streaming(&stream->buf_queue))
>>>>> +		return -EBUSY;
>>>>> +
>>>>> +	fmt = find_output_fmt(stream, pix->pixelformat);
>>>>> +	if (!fmt)
>>>>> +		fmt = &out_fmts[0];
>>>>> +
>>>>> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
>>>>> +	sd_fmt.pad = 0;
>>>>> +	sd_fmt.format.width = pix->width;
>>>>> +	sd_fmt.format.height = pix->height;
>>>>> +
>>>>> +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fmt);
>>>>
>>>> The user space is responsible for controlling the sensor i.e. you shouldn't
>>>> call set_fmt sub-device op from this driver.
>>>>
>>>> As the driver is MC-enabled, generally the sub-devices act as a control
>>>> interface and the V4L2 video nodes are a data interface.
>>>>
>>>
>>> While this is true for MC-centric (Media Controller) drivers, this driver is
>>> video-node-centric (I mentioned this in the commit msg)
>>>
>>> From the Kernel Documentation:
>>> https://docs.kernel.org/userspace-api/media/v4l/open.html
>>>
>>> 1 - The devices that are fully controlled via V4L2 device nodes are
>>> called video-node-centric.
>>>
>>> 2- Note: A video-node-centric may still provide media-controller and
>>> sub-device interfaces as well. However, in that case the media-controller
>>> and the sub-device interfaces are read-only and just provide information
>>> about the device. The actual configuration is done via the video nodes.
>>
>> Are you sure you even want to do this?
>>
>> It'll limit what kind of sensors you can attach to the device and even more
>> so in the future as we're reworking the sensor APIs to allow better control
>> of the sensors, using internal pads (that require MC).
>>
>> There have been some such drivers in the past but many have been already
>> converted, or in some cases the newer hardware generation uses MC. Keeping
>> API compatibility is a requirement so you can't just "add support" later
>> on.
> 
> I totally agree that using the MC approach is better but this has nothing to
> do with me wanting this but due to constraints I unfortunately cannot control
> it is impossible to convert it now.
> 
> I would say the px30 driver is still very useful and people are going to use it: a follow-up patch series to
> add support for the Rockchip RK3568 Video Capture has already been sent:
> https://lore.kernel.org/linux-media/20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net/

The driver is indeed useful as is, therefore I was rather hoping that it
would be accepted quickly to facilitate further additions (such as the
aforementioned RK3568 support series).

However, I was not aware that the video node centric vs. media
controller centric approach has significant implications on user space
and hence on backwards compatibility. Now that Sakari has pointed out
that one, I am leaning towards converting the driver to MC before it is
integrated in mainline.

I fully understand, though, that Mehdi is not in the position to make
the required changes due to time constraints. Maybe I can fill in and
invest some time in that, provided that
 - it is OK for Mehdi and the Bootlin people that I take over the series
   at hand, leaving the authorship intact of course, but adding my
   Co-developed-by:
 - Sakari (or someone else from the linux-media community) can provide a
   brief overview of what exactly needs to be done to do the conversion
It should be noted that right now I have no clue what needs to be
changed, which implies that the conversion will not happen any time soon.

What do you think?

Best regards,
Michael

