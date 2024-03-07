Return-Path: <linux-kernel+bounces-95243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B4874B28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F010B2837F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF683CDB;
	Thu,  7 Mar 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oeqkkEfU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1163134;
	Thu,  7 Mar 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804627; cv=fail; b=dRwdRcTXaIZkIh7hf4NYFc9Dq0DG3MmEUO4hjYqJeX2J5Wr6hEjejJUvt3f+neRSlXIWOT4h/XjjQV6Czm5GhI6oPAItg4NTseQyqbW1Em14cGL4ULYw8Qk/tGiMDymiudrAyDN3Gom1eb9NZyR4xcdRwc6ZWbOsI/VG/vl/ddA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804627; c=relaxed/simple;
	bh=anQNKIY1/i66IFFBlO1AwosC72dU4Y4AiT81UIg3x5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=leW+CLNejIsfwRt34sJaggpcwJpboIXtAOZb2xRNWC9Pvvy1WOc+FTTdOXrXEjAhypFYI2uYkrmhy+wmgOMUvrW7T2IawfXuDvmRCnXu9dvKnev/MmB68QZjw4TQlwMIU48BPTutoCnaDWD19ErkrmsF0beKDCbQKOzTR/vdLNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oeqkkEfU; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHhkkUbjY/N9CyF8ceCAjAAOpQRxuk5R9FSvhWfYTFYhutGT/KD+qU0Hjpw3CmeOnATPmxfIDmTZj09aOP6pgkq3/NLtHI2nNkkE5AjSGUOBdJg5kyE1d6wwmv006R7OD1HijftZjmYL6IskOwZ0azT7XcIssFrYQy0uwbfmmPy1TrouD0jG1w1+AV/zZbrLDWxavbFf70yQaBTOnFOWEQfAWAI57rE2jIkJsZaxIrgzaijKmNlSJOauPWBCchOSbmym9PqB7SN1utuiDUC17i33pFQfilVS1EOXYB8duAgx30F8oOoJ0gfCsGFQKCwqUNjOv/jp8T9pywC2pFq4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypFIazda6dSMVUUzhmLVeueNn6gVCv2dFMwCAKRe6Ko=;
 b=jR24VuVzKHIfUpNYy2ALZKMAfmutiAfD30f3u6E9U3/GiIl5SSkxpRUBzwnOMA/nyLvltETo8JiRc9MYoEdHU+EJ1Li6FJ3oynPoBoDeg91C/VtKUqZG4umadZfa8/3f7CIDiyOIgB6uqcsv4UCncWddhf6Wf73o+PNE+WvvSr58HuZaUBtm1mNNW+Cx0/On0s/BMss2i1pa6LPHAWrimHIXx9Dx9s8o0HCw5X3VzK8q3VjPFrliZRHLwocNb2R+loGrYLT2VD99LZOgMdcuPjMqXWxl6VcnGpgA9d8a60OVWekxSgcYZ2dLMQ/G9fO5jCe4vnwLkF/qvviPfKPe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypFIazda6dSMVUUzhmLVeueNn6gVCv2dFMwCAKRe6Ko=;
 b=oeqkkEfUAdZv/6e0CecklGmNggRac9HKHLTWGjSRJ+2p2L0vADDddXMT54h3modZrRl5JWq2839D9CnnBl0HI6RKC4Cjoi4Vz9Ss0FYfNj6BeS9w+OfTb80nl7n1a00mRD6RV1eXLVAy564ideS0IyxLksmpIkeRgkjINSyRXpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Thu, 7 Mar 2024 09:43:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 09:43:43 +0000
Message-ID: <f12831aa-036c-41c6-b3cd-fa1bd86546cf@amd.com>
Date: Thu, 7 Mar 2024 10:43:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: rtc: zynqmp: Add support for
 Versal/Versal NET SoCs
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
References: <70b646d60f53cccc734afbc7f22245d53394075e.1709728587.git.michal.simek@amd.com>
 <20240306-mystify-playset-5b4ae2f955f3@spud>
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
In-Reply-To: <20240306-mystify-playset-5b4ae2f955f3@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: af4c67e6-6f2d-4757-e5dd-08dc3e8b137c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4skumB+s6YOQaMTgmr22fxMJ5I4fFOKZbeOwgG7ZS9FGMYu1QQ88nl2cUGFc8b3KmBysWKZYfvVlSgixnBxG+9lEw99x3ZUIAlWCpiU+GLt+9c4oQ/BgnqjbwZnjdug8a+VIvvefoz/PoW+KSLBFAZLbsjxjiVeocta6i/C8R2le+jr5zlH4Bsc89fYiOLFECsFgHp7sTYM0sbzD53F7Nrxdc3H56zmn0N/nBOa8fOksaIQd76ae8deGme29oQ8Wzx438o3XfdqbZQlinYH8Sc2ebTjO/KQKG2WOd/Be7FlOocxNAK/KwHmcNfDz7zSnqc1oP3G/ra4zKRwgIxAt1LmHqaV2SelOzENiMVzJqUQ52Zh8r4+VLlJaZIUIryZecTXkx0F47OCrb/UnwkMikIRgHAr4dxtg1bMn1MT2aKaBEO2BvZPwhJqwEgMhgMXbkQ6A/xxFknayaJOIX+3shrYo8YI6avSjCcmS3CzAfWqEz6jotCR6RUbwhE8oG1pCpxfxCP55oKTbzhh8Fp18tZCdfgxcmNm7C4KOEQma9feDqMJJXWNIo6LxYks/ErzmfhxXQP6ySbi685vG+G6W0fJC0QCqi40XeFzfehMNo8AcpVCyfiK/ELqtOsA6TnT7pGgl68RPQKP18ORshSxvL0C0EWo/VbXOaYWtU776DxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3RFTkZiM3VOS2VYU3hNZWFSY2krSkdkMGYxTkRtZDNvblV3NXJOSnpDYUo2?=
 =?utf-8?B?WWZjT1ROUEFtQVg3RFVmdGpYLzZ3eGVKMS9HaU51Z3BRM0ZQUktmR0E1YUwr?=
 =?utf-8?B?L016bktSTkx5ZDBOWFFDRHFTbGs0SkV3eXlpZkpKMm5qNHRCeTRJa2srR2ZV?=
 =?utf-8?B?OGw0VHpZSmY2MXVQTTEwQTRZd3dDbEU1eWxySnp1STBGd1llME4yeWRmY1pF?=
 =?utf-8?B?eXFsR2JmMzdBMEx6bTJlQ05YY2lqODB3SmROSEVUZFQrOURiZm9xdEMvVERZ?=
 =?utf-8?B?YUN3aFlVc0VZTzY4aXplaUo1elA4OS9PTjVBdnduVm1TQ1d5ODRqelJleWVR?=
 =?utf-8?B?R0JaN3NrejA5UzZneFZ3RzEwZ0hQRWdjbEZCMzJYSDRVOWQwWXI1VytaZmd4?=
 =?utf-8?B?N1lqMlhVK0VYT3lYZTZXQ3VUbU9mdU1GTFlTM2pTTkxMTkRrSm13Qk5Jd0ty?=
 =?utf-8?B?b0dBSGgxUi9vSGFtaTlWM2JtS0poZCtZQ0hiYi9wNlVnTGRRaFVNc2trbEJT?=
 =?utf-8?B?d3ZnRC9jTVNSclg0c0RMRWVhVVI0bFdTUmZMWERoNGxmZkEyYlEwdSt0bFVl?=
 =?utf-8?B?UmNES3lmNXhFcm1LVHJmeENObDdza2JBV2o3M1BrdDFlbzBrTS80d3dkTGJZ?=
 =?utf-8?B?QkI5NUFtb0czUE83R1VsdWFFZ2RybTh0TTIyZUt1RWpXaXpzV1JMeVlJOHYx?=
 =?utf-8?B?NCtvUUFMVTl6MDMwRmpDKzYwSnZBNWhua3JhMG1MYkRDSkZVNC8yZXNabmVs?=
 =?utf-8?B?di9CUVY4dlEyL2h6RDZxMVRYQ29TazM2SUFvazU2Wnh4ck9Ydkg2MlpKZUIy?=
 =?utf-8?B?STlsUVk0TFM4U0pVYzEvZWFZVHUvL3NkOFcwdGE5U2R1NHdtUmZPV04wMFdH?=
 =?utf-8?B?NWxDT3M4c3orL3RNREJJakVPOXZxRENQMHBBRnBPZ1RRUTYzTFcxVTBINXVq?=
 =?utf-8?B?ZzF3a2FnLzU5djdvNmYvUk9mekNtVlJPOTBQVzRJSkM5SkhiWFRlbVlLeFRU?=
 =?utf-8?B?SzA0YmJIRWdHdEFkanNTV1BsYUlXQ1dBRUtvOG5RK2hoakcxYjhKVERGcU52?=
 =?utf-8?B?aGFSbXduMFR5cWg1cWlHYkNOaXZUVXltZXZYajZEUXRlK2cwRmwxSjhMeUZr?=
 =?utf-8?B?Y3NyKzQvYVgreVdsM1U4d3VWSHFtNGhaaGN2Z0Y1TGp6R2RMb29mMFZ1OUdO?=
 =?utf-8?B?RUQ5cXRiMnZhOWh0czIyamE3YnFKT1RCSHJvSi9yYUtwK1AySGcxVm42UCtQ?=
 =?utf-8?B?bjJWUmpWbm9maUxpNFZwWlRueW11TWYrbUxlYXZXM2loQWlNSHlVQ0RXWUd6?=
 =?utf-8?B?MExWOSs2OGZLd0Y2N0V4T01aQlhrNTY1R0g3b3BibjhYcTd5cW81TkdZckxt?=
 =?utf-8?B?ZmpJRjlFYk1leDVjZUlMR3hWTEIvdCtaRDhNZ0VXa21uK25CNjdWUzVaWFY1?=
 =?utf-8?B?NU5tSkRqQXBWZVZTdGdGa3ZXbkpKbjYwYlFEVFhEREdjd2x4ZGtWR0d5TWFJ?=
 =?utf-8?B?WmtaZ2JJblZKL2tXMzRBeFA4T0x0VEF4ZWRhWDIvMUxGYzhNWWtNdDBjeFli?=
 =?utf-8?B?QVA2TG5qU3F2M1lTTklybzNpTGxIWEtOMzZxR1ZiSHUrbUQvYjVFUGRrWlov?=
 =?utf-8?B?TkY1ZWxVWmJtNm10R09pNFV2OVhwNnN4cFV2aXI4dk9HM1BjTWxpMlhqM0Fr?=
 =?utf-8?B?SVVHcWxKOTVPL3dCSEt1N1lUcjJJNmdvZUljdnYyTEtBb0tQMkNTakRkOXhL?=
 =?utf-8?B?TlRjZWI0MzVJQmExK1ladWJmRG1FUVpqbjRUUi9OelZ5VE1pYU9pemplVGtZ?=
 =?utf-8?B?UlNTRHBtWGs2RjB4NksrTWUwTENKbmcxUi9QV0FDTjNOQWxYSkdMVjZ0T3Z0?=
 =?utf-8?B?OVMydmhSN284VnZLTlRoWXJJZ0pwVEJMTmtEZnFhZjFRWWdVREJQQzNCOW80?=
 =?utf-8?B?b3FhOW03TnlnNTRpZVllcmFIVmdsK2ptTEs1ZHdjeEFBMFdjTE1CU0JkSCsw?=
 =?utf-8?B?SmMyRzFVTURaYVBudHppZ0N0bHM1dmJNZThyNzZ6bXI2K3VEMnpPckk3eGxP?=
 =?utf-8?B?aDRJOWtkMHJ3bzg5TFZiQ0tiK0pnS1Rzblg5L3RxN2ZmMnQ3Ty9uMnFmeG1O?=
 =?utf-8?Q?mLuH1nnCw91hnXm8CgntdEkeo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4c67e6-6f2d-4757-e5dd-08dc3e8b137c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:43:43.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaSRKptU3cIIQQC9+l6+rM+XmJAf6kr3sNjZDrHFvgROTUmMYss1fEj+KqHR/YDV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866



On 3/6/24 18:53, Conor Dooley wrote:
> On Wed, Mar 06, 2024 at 01:36:34PM +0100, Michal Simek wrote:
>> Add support for Versal and Versal NET SoCs. Both of them should use the
>> same IP core but differences can be in integration part that's why create
>> separate compatible strings.
>>
>> Also describe optional power-domains property. It is optional because power
>> domain doesn't need to be onwed by non secure firmware hence no access to
>> control it via any driver.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - Change subject
>> - Add compatible string for versal and versal NET
>> - Update commit message to reflect why power domain is optional.
>>
>>   .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml          | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
>> index d1f5eb996dba..5652df8ec121 100644
>> --- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
>> @@ -18,7 +18,10 @@ allOf:
>>   
>>   properties:
>>     compatible:
>> -    const: xlnx,zynqmp-rtc
>> +    enum:
>> +      - xlnx,versal-rtc
>> +      - xlnx,versal-net-rtc
>> +      - xlnx,zynqmp-rtc
> 
> You sure chief? I don't see a driver patch alongside this adding these
> new versal compatibles there, so should these versal compatibles not
> fall back to the zynqmp one?

works for me too.

Thanks,
Michal

