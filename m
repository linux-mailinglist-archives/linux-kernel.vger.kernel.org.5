Return-Path: <linux-kernel+bounces-88173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B2986DE24
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB081F21D09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD721E886;
	Fri,  1 Mar 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fGRJnPT1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398356A03F;
	Fri,  1 Mar 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285086; cv=fail; b=IghOwn78kEv9aZYxvmZh/e+J/qX6c0QMfOkPD2iFLQsN7gzZcuqRifC6shLcMMFu8cmMPzY62TN0xBgHNf0d2CZhxzFezotvwPSm5FoC6pZw1sXq88YwZGFYbsRjq5E0fDoqvvP0PKiXBabvKZseyhK21kgTjycpZqM2ADieYDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285086; c=relaxed/simple;
	bh=gfd2hrBaTK7p5kK6l3MCoECtGXcnGF9JhMfpgshWo2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iF4o3/wI3jo7A9veOMCLOg7RkAd/PzCe4EhM9gFZ3mEzjLqVlI/QG5RJ3cTo0MxnI9Fsiqc4pV1XA1IT3xvLj1YN8b/dmcuSN6BwuuE8OL4IN3f2JgaB2ZMnVLNzCcFWTbAJanoR4fk1eqi3JYv6gizt7R2uymwNnse9eG13C6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fGRJnPT1; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrbeEYnk2nPpiwe4hQdtG9tNkRmTAJyGZMWM0Qv5t12JkdllmYe/aZEvMMFKu9VzBTw9HlOxC5QRTB8ZjfLhGfpY0h+ahLU1iA4OVGXbRYYm8yIr6dWuf36/kJejUjIzmB7WO2cPyKULKao6rjC3ku0pCgbdJmy+oCTkT7tbPa2EfFT+M/sYnH2aT0OSh7XqI94q5yayzUm372ueB9/L9v8RrnsdrA6UydZyP0wf2Nv7XnoBiLPRz9fiW6O2EneovkWO+uaLzLWZYGL0hVxcawSZ4v8+Z42pJD1P4IxC6oNEYSn6ETTTD1NFAw5Ro8e+X/3rKGmfpQ/4coBXZBVowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0kWC8kHv6MtXk2gBcB0tFfRcMOPxnYW72zD+P7VoVM=;
 b=igL/AKqIS1SUREHbJdhP9WcQQJMRzM1m8BX1zAQAcsjhJYTyiB4MRQp+FkBYhEgwc5rSc5fQ6TroK4Ht09mwQ1HBGOSkez34NHHPeM50bwsw4jELbV89gdF6+R57KI0xJulINBrayXFNBypaeQddYan0ptbZvhCiJeHg3i+lx0VPp9XwI0wb3nMsdJeMiT13nT3ZzVHTTWSZzNuMpQumMxM6rk0MFRmO1LI3dmpZ8ynG4D3dNXhPpJZEnf9WUWl9x/rIVM/+mIcP2M9sfzjoC5X3+/l/Ga7UAuUGvj+gJosDccgZd5ywu5GFgipVtqu7lxU+wf3pvW8gcfk9y6AuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0kWC8kHv6MtXk2gBcB0tFfRcMOPxnYW72zD+P7VoVM=;
 b=fGRJnPT1qrz8puBHq28Tn9DwyhaL54XzCBV9oHo2VXq1BnV214FxyP1Z9Lxj0FTx7P2k5yST8JWrEq3MRiKvq3+hdOwXrKhIDJrae1c7SJTfsFg2JIT7WCPIrcNAitsHqDN1u4F9aCceR752vmECbvN8DBg0fOjND+A4tAwFVG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 09:24:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 09:24:43 +0000
Message-ID: <39b4b28b-8061-4af3-9129-d05a6f050719@amd.com>
Date: Fri, 1 Mar 2024 10:24:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] Input: Fix kernel-doc for xps2_of_probe function
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240301092115.123092-1-yang.lee@linux.alibaba.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20240301092115.123092-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0145.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: d0546979-ac30-4462-5762-08dc39d16d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OZcHTK2FOhOID9gUuJOlJ01k72BVrDb1Udj9t4vHu5nUgTlKwLC3IV8PsgEIHEYO5dHAJR3v5GRb9uriC94uqquaaRJXAH1Pk1zv7d1zQB7TU+q9aPt/1rm5uoMcNmuxofK4DhFr3jdIsjDXWc23yaH3ZvcDbGpTYGWuIF6kKZ17ZTTxVD/ReMruJ+i34dVs1fuCOz2bNIyZwe1sR4UBcLfVVU0y4na1jkQVzEA+OhxtNuAUCnmiilXNl6ILnckyMOu2+CDBJmjmqW2OuY+YZ+rMi9CChHotEvSjE6CiqnHJtFjH78mj4RathQe7sxcbpvzIqax4QaXzwxkUzgBUiJHj9B7GQrJBGY2JP+7jdqHLSz/yGDK64YbJ+KJ4B6h6AI5tNA13znFL5nIGK3oghQOZViyzBBzskTlirZB5mOtrKbzrm4T2xbfK8V1jWTpA658t3MyYMa5C+uNpaowKczG0ZWpEkmmHfNJxpvcvl9n/0tXEt/t7mevUL32f1QicEW4tXtXc5eD+tWAV7XfTahMZ3f6Ck64xV8kjBuj2OrUlTke78E8XhDQs2P78+Dkirrl7K2HBtE0HbGxW2SWN2q7o1EUtzromYhwFon7YM9JWHBbP0al+ON/Y8m7mn5Qx/LNDsoZ8tvgh2id4Mmn9AA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmE2S21xN1FRbTFKSS9wSFhZb3BMbVpTcVJTRG1tVFl2bXllSUExaVgrNGxN?=
 =?utf-8?B?SFJMVjdPMWxNZmpvUG5zbXYwWTVFRnJueVVycUpnNkZDWUhvNEFoSXdJT3k0?=
 =?utf-8?B?UVdFYmlrMTJFcWxzUE5kNVNwdWpSbEVob1VYNGVHRENORjlaZ2NxNzdXdzNK?=
 =?utf-8?B?QUdKQTYvbmdVNyt6NVdLeTRac3Z3QkNpSjJJTG5RQ2ZhVitwMXVyb2swSmpr?=
 =?utf-8?B?anhWL0dncU5FUlQwOHZ5dC9hYUw2N0YyMzh4L25JL0JQbGZRLzNSQU9NVDZO?=
 =?utf-8?B?c3RxNWQrajJrMnFHQ25EdGtLODdhMnJ0OHlXeUh5UGtQbFkwSnJzclU3Z3hY?=
 =?utf-8?B?cnFFZ3dCMVkyS05sZzE5ZVV4SDZlMlVTbFBhdTlRSFFHd2ZsTkVkUGJGQ2dO?=
 =?utf-8?B?OXpBc01ZUjBkUDRZM05UR1RXa2N2YmRNVFpuQzE2UUVIWlNrTTVtMVdVYjdh?=
 =?utf-8?B?bzRvQlVMSVI4d3RqMEZlSndwbkk1UkcycU5lL1VPUnp1V1lkT0pRVGcwTkFi?=
 =?utf-8?B?cnFWN0pEK0hYTTZjOVg4UlgveURwNk5OK1NvV09GNXd0MlcrdmpDMnZ5M3hk?=
 =?utf-8?B?RlRaM3BwSFVoeHZaTTJrRXljRDJpZ2FyeVJJU1l2MTM0UXRUd0N0SytpRnN2?=
 =?utf-8?B?QnJOS1VDcnRsdkdPRDhrL2xVRnpkSjdIYVlmaXJITW5tRXFUbmlkOGc1bmVm?=
 =?utf-8?B?Z3FGY0tkd1FsK2VKWTN2YnoyS0ZMRXRGMjBWTHZjclIxL24reHNERE1kdk5R?=
 =?utf-8?B?K1g1TXNVZU1UN2Ntdkd6WWpydVJobW5FY001ZDJPRHNWdno1R2Z0SHB4YUd2?=
 =?utf-8?B?d05DRVEyYVUyL3hiWVhrM0VmeXpZMXJhcjF6RTAxSVNidmcvOVk5NStvSVhq?=
 =?utf-8?B?Sk1QdkxKNjVvUmRORGdvc1RWTTNNS0xVUDJiT0ZIaEEzdVBlV1RSMGZHdjc2?=
 =?utf-8?B?TkxaUXZ3Wi9hdjhMS2cyQTZaQjVDb0ZWcnpTOUhmZGo4eGlpQzF0RXg4LzJP?=
 =?utf-8?B?d2ZlSDJTTUdrYVZyRktaKzczUXZ2dGR5OHB2VFdkWlZtaWxZaWRCZlRuMVNu?=
 =?utf-8?B?UmRlYVZORWdYeFdmYzVYTXVWcXg0MEgvampHazVTNzlSRWlHbHdzRnM3ZW1F?=
 =?utf-8?B?ZDlJZWJ4T3NtL0VSeUxUejRYWFh1ZlBmS0Zld3dUVEdraVpiRFdyTFAzNkVZ?=
 =?utf-8?B?azV2RDZ4Z3NObTZQeHRNamd0akthMG4rMXpZbUNnRUN4cTlFdzk2d2sxeDVi?=
 =?utf-8?B?UDVlTnN3ZlFSSVUxQ3VhdFZ0a3FDaXJoRjUrSTNBMks4U0xsTks0dHBlb0ZW?=
 =?utf-8?B?emFPSWEzMEF2WUNPTjFVWG55QkNNQ1Frc01SV1QwQXhVUnR1Wk0ySHluWndi?=
 =?utf-8?B?dWdMQm0xdzNRVDJTK3hnanlIYWpSWjdZKzBheEVDVW1mT1d0aWVYTnYyQUoy?=
 =?utf-8?B?K3JpcnV2OWhJUnlyZWE3L3UxTFNLQk40OFlTdzNpNjJ1QmdwMVdmVWNncEsw?=
 =?utf-8?B?dHZjYUdleGxmWFF3V24zb09SLzVuQUJWSFEvaFJiSTJUOTNhcnZBUEVadHVu?=
 =?utf-8?B?elgwaFdHczIzZ2lpSlNXUDhZdDdYNE8vb2JKWnhaZVN4US8wSi9uYmZpb0tj?=
 =?utf-8?B?eElrTlg4ZFJKRkV1aE11eTNPZ1FjUEJpVUYzLzhXSjRNSXhsUDlkWHpmUGRZ?=
 =?utf-8?B?UmlzM2tWZ2FETklEZWpOcUY5VkQ3SWpodDhQTHNwSnppMm5yMmNBMHdoeE1L?=
 =?utf-8?B?c3MrN0VHZHVLLzZ1YXNLMW9EeVpQdGYyL2FlTGlZeWlsejcwMWxUSFFJUVZK?=
 =?utf-8?B?bkhZa2d4aXpVWFJQM1djakRjTjRhVi8rYnBmTWZSRWVYTERRNkExK2hvN3Fa?=
 =?utf-8?B?RWRqUXBvajNzc3F5K2lrbGRQYjRNSjZPdFJKbS81SkZ1bExDNThjQVpJZS81?=
 =?utf-8?B?RGVRWDdodExRa2p3ZmNKSGpXclplMkVHYWQzTlJiZ1VGOWloNEN3dE9aMWxR?=
 =?utf-8?B?Z1Faa1dMazRiWW14RFBRUUNUOFFHVXpoYUhVWDJkV1ZRMTFzVjMvQVBEMzc3?=
 =?utf-8?B?OVoxU0hBZkozTWZKRjViM2w5cTh0dXUvS0dvVExiYmRiZjBSbGMvZCtQTEtW?=
 =?utf-8?Q?j2QiCvRNqtiwp+cJlL19LeqqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0546979-ac30-4462-5762-08dc39d16d88
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 09:24:43.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcEivyznKRrS/hckoy8QI1UNV+HPp5dPiDcfkw0tCpSyvI7Qr6tu8xDhWdxSvsbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407



On 3/1/24 10:21, Yang Li wrote:
> The existing comment block above the xps2_of_probe function
> does not conform to the kernel-doc standard. This patch fixes the
> documentation to match the expected kernel-doc format, which includes
> a structured documentation header with param and return value.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/input/serio/xilinx_ps2.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
> index d8f9faf2b529..bb758346a33d 100644
> --- a/drivers/input/serio/xilinx_ps2.c
> +++ b/drivers/input/serio/xilinx_ps2.c
> @@ -219,8 +219,7 @@ static void sxps2_close(struct serio *pserio)
>   
>   /**
>    * xps2_of_probe - probe method for the PS/2 device.
> - * @of_dev:	pointer to OF device structure
> - * @match:	pointer to the structure used for matching a device
> + * @ofdev:	pointer to OF device structure
>    *
>    * This function probes the PS/2 device in the device tree.
>    * It initializes the driver data structure and the hardware.

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

