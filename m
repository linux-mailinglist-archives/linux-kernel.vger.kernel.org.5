Return-Path: <linux-kernel+bounces-156541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC288B044D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A9F283849
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AA015887D;
	Wed, 24 Apr 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H9BijNyJ"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99827158869
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947235; cv=fail; b=YoNVkY/46q4N5GqxgbGr0Jp3SyFawNSKZWA8w7WOzBee8MaX3sdB5St/CtIvYu8Q7j/TpNMJl1fnYhc0LLDp+YLXn3eIwtx6UIw3KtNJvotPnvZoX+0+k+hSsKyJ29pWqT5Rxc7qI8sdF5T61b6s+2nv/Z7BfVgXeYKqEKauido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947235; c=relaxed/simple;
	bh=32K9qv4CD9QhdWUAWyqMPF2fZgNqW52qDTMOuygX9NE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j5FB/4J5xLlkGgSgPAbL53qlGCr/YZjA4oUU8JHd2TgTJZZwqatbGGipdCuEh3M0vH7ZmyiuG4T5sKySkPKQS6b2BUDj64m3dIQkKb+HLTj1K+OkrIJrKrbT+sjpVjtINJU11UQ97B684BFI5fm1ckmsH1V5TcejFInt1ZbfeLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H9BijNyJ; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R99xYTQwM90IOkwFqzkrFyfVPgyiiAfXGe9omaLu9pyo3vSWiLxNOlRzbMSAvG6P/5cbzO3DFOvz8R3DA3p7fODFKN5qxJHtH1FTVpTIq1Jrn50nyZ5VXAslXx+f6BjhrWwomLBtSOXVAVf8Ri653rD+yNI3m2C3nP2KKhEYu8GpBefMumx+S/0/Ea0qtelJimnjt1WrqjI1o4jupLkEOxUdQie4rAB7miMrSGBKH0yTPJXuBsdAOECRt1RRyCOWh0YrtU5UfLK3niqmqEIu3GaQHeASzPasGJNlv9eQJa55Ua4Dql63lAhq9xhI7izp9ijEl74ikyMWghsDSZu3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txPv556qhrHPH6o7uPIIlphxrZW0XrsZkKPYRgTpEwI=;
 b=EBavxfiUmMCxncWunxQ2null+/m8xDyyC+SmYH5z3JYxQAy/g5nLa7SrVmuowukHuKZzdqyxNoq3sWy3ewYhScfHGkRra/XursEBaRMzBjXYjCxS65TCcfpsbiVh/ojWdUyCauWP36HakdZ7R6rKtKmOTopn4BRLUPchcGUMNkPMfHYI+TnPkPYJFbepWHUI8pTMnGVPdlAfNWmEIwnGrSEq6Hp81XcflivR994ug6dApgTgAXgF5qGG1fx/1r5XtLVT/WZTbDoqXsE2DVT0oy2ZdK3q7q0VS57ublK8xH/o9/RyVXEfEP9lHPIrG43GW+s9cOafKb6Kx3v3Pr/+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txPv556qhrHPH6o7uPIIlphxrZW0XrsZkKPYRgTpEwI=;
 b=H9BijNyJd77uw/lf1E8DIU4izgTOiJ4YlfCY4hkg7COPGsiFWLIyUgS66YW2nwlV2a4NQ7sxxUL5CfZHzkm3n0S5ODHiaOfdaRszMc/PNACdsvACO12rXkPM8JXriCHrjLzASpslHn9zuET3HxwWf+XKS+0hTdsytywdFm3MFKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:27:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:27:10 +0000
Message-ID: <870289cc-84f2-4324-a5b4-e8191ca5cba5@amd.com>
Date: Wed, 24 Apr 2024 10:26:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Remove gcc flag for non existing
 early_printk.c file
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Rob Herring <robh@kernel.org>
References: <5493467419cd2510a32854e2807bcd263de981a0.1712823702.git.michal.simek@amd.com>
Content-Language: en-US
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
In-Reply-To: <5493467419cd2510a32854e2807bcd263de981a0.1712823702.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0217.eurprd07.prod.outlook.com
 (2603:10a6:802:58::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: a32ec7e3-d186-4417-f31f-08dc643855bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUk2ejJyY002SE9hZG9iWkpENE5KN0hKaHc4dGh5eWlLU0xTcGZpaVhYSEtv?=
 =?utf-8?B?SHNvb0ZGUVZrbi9PcFdQMlhPMit3a1FINnJGSS8vbEZoY1ZjbW42OFl2OFN5?=
 =?utf-8?B?ckZISXh5SllTOURoUVh2ZUxNK2hYUXN2RFF3VUd1YS9YdGorUUx3S2UxTndY?=
 =?utf-8?B?djJkT09VQWQyQWtydnA0Vm1KSWJaTE9HL2VCK3B1RGNsWkNqd2hHZzZFNlY5?=
 =?utf-8?B?ZU1aTzd3RzVGMFFOcSs4MTR6S25vN25UVGovWmlNZW5BT3dFNGxEcnk2RGxi?=
 =?utf-8?B?WlVnM0lDQTA0KzFxNy9mMjVIZWxvZUdIMkJZdmkzMTFCWnNKbjVNM3YrVEhh?=
 =?utf-8?B?Vkt0bW1ucWE4QzdZOHJFd3BLbDd6UWwvVng5WjI3b0NIT0N0ZHFMRzA3cGZC?=
 =?utf-8?B?U2JseTRTUGhYaXk1dlUvQVdEaVRIYTMxM091RVM0UWZkbzNKWjRRVW5rUklq?=
 =?utf-8?B?SmhNQnF1WVhVUjd1QkNEY001cDFucWJJUWhsdENUdlpydE9Wa1ZGenpKMXR4?=
 =?utf-8?B?VnJkOWQrN2h4Y0ZENFhYZWxZNmdadTRpWFRDN1ZmMVpNeW5LamxmRlluK1B2?=
 =?utf-8?B?cFQvanpuRmtCS3hNc0ZraGZKbWg5YlF0cGluaUNuZEZRWGNEdnp4QVBBTHNN?=
 =?utf-8?B?S0FOTjkyVExUV1N5MDBhSEgwS1p1dlIvdCtMZkswSjNXSzduSG4yVTFhNG55?=
 =?utf-8?B?SEFQdXIvSlNHWlJzdHgwVDV2NVFpbk5qQUR4MExUSHJGa1FBNGl2ZWlEd2p5?=
 =?utf-8?B?L2J0d1V0U2dlLy9ZR0NzVUNDTm1xOGZFZUpReFIrcldRVTJFWGN2Y1JvQVNs?=
 =?utf-8?B?MjNwS0tvcDZvSFcwY1Z3VTF2Q0R6OHIzS1d4aFpBcW1BMXdEZ0dMR0Zkcy94?=
 =?utf-8?B?Rml2aEtLTDM1WWtpeDh2bUxua2NPT0ZWYlNNS3VndmkzZU1La005cktvR3ZF?=
 =?utf-8?B?eU9EMWI1N2ZnMDNEQWZTcDA5c25iVGRxNWQwb1NObmZubHRSZ21Nc0dLZ0U2?=
 =?utf-8?B?bzFkQmpuRVFmN2h1T0ovT0ZEem9FQlZPOHhEOUVTK2tncWE3eVRKR0FvV2Ny?=
 =?utf-8?B?OUtHS29KT2gwZ0t5MFpLQzJ2blVpSUhZemFQUXNVUldEcytaTFNDYkp2MkdR?=
 =?utf-8?B?blE0QWh3RmxNVDRoemdyaTRWVlpMd3RkdituUDcyemo1dy82QWdXOGt0T3Bp?=
 =?utf-8?B?YnlxWWo0WUdZN2xWUUg0V2JKM0RGZ2VtekFNQ3RrbkMxQTNMZXY1RkJhN1hy?=
 =?utf-8?B?Z1puT0NpY3JtZHlXZGxJQ2xscUlmelRBZi9rckZ4VWhUSWt1N0VTNWRtTFQz?=
 =?utf-8?B?eHA4RnFVYUdSY1dJUE5yaFYxTE5OTmt4WGMvUWlqRTJ4YzBaQXdkU3dLSXpW?=
 =?utf-8?B?L1R1clpRN2d1NWlmaGdxWUx2NS81eTNrMVZGdkRLSWlWYStpaU9YRTlWYXF1?=
 =?utf-8?B?eDR5Skl3SWxrTi9LZVJLdTRjOEMzRGgvVUdNNTA3VjNMcU12V3Zjd1JYNzhn?=
 =?utf-8?B?RWl1ZXhmRWtLMUwyMGU0RUFEWGdVWklSOW0vY28vbzJXRjZhV2RkdnFScUsx?=
 =?utf-8?B?M1FlWDlRVlc3S0l6cGlRU21nNTgxenNWcGVQV3EyblFJOEphcnVjNlBzek9s?=
 =?utf-8?B?RVB4WjU4TnFXOTExcnRRMHdVVGNhOGszc0hUR2hndzQwd3J3VzVBNEU0MUdG?=
 =?utf-8?B?N0lkZ2M3ZTRVMk5qNGVZMGxlRnNTSmVpdHR0bm81VENBbldhWW5Mc1l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SStRWGM3bjdjYUpmbnQwSlBsTGswWVBYM0xhNjhSZ3VYVlljVUJ0R1FkOTRt?=
 =?utf-8?B?VXJQS3RmR0o5cFlGZFdJZmxjN2RMQWphY1NGcFFqZEl2NzdrdFNCdk83TUdw?=
 =?utf-8?B?QmwvY3l5M1pQNEUzdDRVdHFFVWtYY0tyVk5iM1RyVitIdkJZU2laRmJKUzF6?=
 =?utf-8?B?SGhtTUR4ZUZuZFpQMURLaVBCTUpPTjdXMndjS3lEM3BhWUx2NGJTaGpzbndm?=
 =?utf-8?B?R1dyV0Z0STIweEdITmQ0cmdpMTQ1c290V0tVSlBYM1ZvU3BaSmVpRG9pK2xW?=
 =?utf-8?B?eXA0STdEUExjTzNZVk1KVHYrRHpxdlNPYm00UjEzWkxYYnB1SW40cG1jRk9h?=
 =?utf-8?B?QnlIdTZyQTVhWnhuM2QxTWh2Tk9tNWpxamQ4MW56M0xDN0tEKzY3OEw0Rk5X?=
 =?utf-8?B?M201QkZkTDZNQVQ4dFMxU3dHd2tpbWR0Q1RIR3dtTVlzOWduUG9IeWduczJB?=
 =?utf-8?B?cnNYdHlnRXJEWENKa0EzSlNxT2ZDT0M0YkZWQWszcTM5Q2tYSm9lMTEzdE9O?=
 =?utf-8?B?K24vMlB4dXBpZ0Q3bzlkeFR4TFFTcFFJd2pjK2g2ci9LQWhTZC9WRTlWd1lj?=
 =?utf-8?B?RE1FNW5uS3ZyRm8zQll5OWpRdlhxbjlzQ1Z4aERFZUZKdDl4bURycjdreVJR?=
 =?utf-8?B?RU94ZGpKTVVGc1hOZ092cW8wUjN4WHczcHFIY0NDM0c1d2gvUVRWWUVCbHJI?=
 =?utf-8?B?R2Qrd1k2WFN1U2NwV1JqTDk5cEE4MDRkWkJuTDltRVd3aGFvMkVCQ1p1ZTZR?=
 =?utf-8?B?Ly9IeDhOWVROK2dIcENCSEV6RitoeFlBdkh5U3NoRXZ4ay84VDdaQmdjYVZm?=
 =?utf-8?B?MHhLdGdMMWV4WTR0UjRLOC9YUTFTR1JjQUZSZkxOQXd2M21pdWNnNldHYzNn?=
 =?utf-8?B?WDFYeitGZjdCbEN6OXhudmltZEo4L1ZzTWV1ZzdidmdFckhFOHFoWkREY1o5?=
 =?utf-8?B?K2Z6ZS9FVEFyVEpvOHFRTmt6TTkrSDFvbHNqaTM5aFpkbGY3WEZZNGlVcmxw?=
 =?utf-8?B?aVg4YStXVm5jT0dLMXlZQmlySWI5Zlh6WnJQSDU2ODZZQXJDNzNzRWVhdXdY?=
 =?utf-8?B?cDRlVDg4MlNVSzNIaDNZcWQrblhNMkdQQWRhR1hqUXltUHFsMEZSU1dDWXQz?=
 =?utf-8?B?NHM3UmVtajR1Y1NzUktFaFVNNEcrYkkwWWFzQzNwNzlTTmY2bnFVKzRHYXpk?=
 =?utf-8?B?a2hPNjlLRnhaUjZqY21seGpXL3p3MkY3NTNhTTlZV3BTVmN5VDhoaEo4WCs5?=
 =?utf-8?B?NE9YU1Z1ZWQ5UWp2YmNTd3E2akVWVmVZMFlUMmtSQWllUzR6WUo4WGd0Z0kr?=
 =?utf-8?B?K1p1aVo0bnU2UE9heHA0bnFpcytna0xadEhkTDgyZVp1YlJRWjF1SVAraCtp?=
 =?utf-8?B?VzF0Vmx5QTlKVWI1MEo4Und5c2o5eGQ1bDRmVmVManVpWU5leXlndXNoRzNw?=
 =?utf-8?B?NjRvdElsZU5SM0MySkF6L1R6Uk9SY0pOd2p3akxxczhtdzcrNFJya0lzSXov?=
 =?utf-8?B?NU1TeFNWdlU5Z3BqVUMyZXlXWjRaZ0hKaHRSZjlTQWF0NHBGblFscG5qTFVj?=
 =?utf-8?B?d3N1bS9taVliM0tkajZxYUVVK1h4aU5lOG16amk4U0twUUU2Z3dkL2lxRjRx?=
 =?utf-8?B?ZlNGUzB2TEh1UWEzT0pISmdwUGJ2TlN2clh0SjIxdE5YZjBHRTRWOW9PTkI5?=
 =?utf-8?B?ck9oU3pFRG5hczgwTmxPWVh1K1pvOVB1ekowVjdsQXJuMTBDRkp2UjRHTkg3?=
 =?utf-8?B?MnB5M3ZXMDhRaUdFemc0c3BKN2dKVkt0d1UxdkhZWHR3RXh6R1A2Wkp2RVNO?=
 =?utf-8?B?ZzdyVWZ3NTI1RStkK3lXcGFsclAyR01DVDdHQ2owS1V2KzNXQXNMQmhMTFZ5?=
 =?utf-8?B?TkZHR0ZYZ0szWCtXUlN3TEVTYXhyY2VybDZud1BidHhldFQyaTQrQWN5dnFL?=
 =?utf-8?B?MGsxQVYvakZtbFZIOHJlMEVLVTdJQzZ1ZjQ5MDZKRW85UG1lRDRDdk9BM3NC?=
 =?utf-8?B?Rm9va1VXdTdhZTY0Tk04SVA5bUF0RTFNQytSZUFzc2FGTkVhbDd5UUh4aWUv?=
 =?utf-8?B?Y1VpT2htU054eW04OGVzWjdoaE5wdzZMZmpMTWI4OVlWMmErUjU1MUhoWlRs?=
 =?utf-8?Q?mMzoY3TnRCpxJZsKp4r4RtZPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32ec7e3-d186-4417-f31f-08dc643855bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:27:10.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I4Bjpo2LlGVsVLanX7VFXwg/ZF90JMhevX/rWjYvKzCzLM6xBTLBp6X1ucN2Zth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473



On 4/11/24 10:21, Michal Simek wrote:
> early_printk support for removed long time ago but compilation flag for
> ftrace still points to already removed file that's why remove that line
> too.
> 
> Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/microblaze/kernel/Makefile | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
> index 4393bee64eaf..85c4d29ef43e 100644
> --- a/arch/microblaze/kernel/Makefile
> +++ b/arch/microblaze/kernel/Makefile
> @@ -7,7 +7,6 @@ ifdef CONFIG_FUNCTION_TRACER
>   # Do not trace early boot code and low level code
>   CFLAGS_REMOVE_timer.o = -pg
>   CFLAGS_REMOVE_intc.o = -pg
> -CFLAGS_REMOVE_early_printk.o = -pg
>   CFLAGS_REMOVE_ftrace.o = -pg
>   CFLAGS_REMOVE_process.o = -pg
>   endif

Applied.
M

