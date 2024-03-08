Return-Path: <linux-kernel+bounces-96640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F55875F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CF8B22298
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA651C33;
	Fri,  8 Mar 2024 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3j/LCsEg"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1162C1A2;
	Fri,  8 Mar 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886042; cv=fail; b=kNaZLTpu7MIIoJ92n+uyqwoTWxFca3YKbi1iD8mghSxtqyNzT5nZxPmqpzW96jVjpZSt5C2kTV5Y53cBgdMJ9SdKdVDIJ9z1Kw9f1q0d3VPnzTThfQZ9IemJI+ATUbBLxB5RG1pnXsVsTcPcAeBIJK4qPH71RwG6aLhTvHstHqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886042; c=relaxed/simple;
	bh=uAwubnHp+S7osnQ1MKvQuv+lXFMceBgH4yeSKCzHg8E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hER6ofafuPZ6KC0PRz6qZNB07sY0PLR+yP7PhhpqwgIintq397WaFUoNvKWK3JGJD0C42sBi6hoZ7n15vZDoK+RMcthi38FR6MLzr7FNSvyMP1QPcB3vDdN7tZuay/bPk63NQrM6WrIAuqjwJCPp6r2u1rkWjAl6fD9bUTcPldI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3j/LCsEg; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxltv0bCD+JcbA/j96LQWzPQ+H39JP0ok2SlZ6rJ27HtmJ9dmKKYcPpbS3hvs0UqOWH7MyQxdzqbrYHYsaKTsf1Ikzl9RG+A470plsLYFrMeCaJAw/cYDB6O++bQljXfMOehxNA2VAsXrgkAcMEr2zPrP6gaDJKe8MHiy+9KVyEcoHYuS1UdKHKWm7Jo1BIsQTYvthUuVUH9dSeb4Py3Asl/8xfyEnNle6kjy51fuLls9Cw3qYJIZjJE7r76UbX+BMkkanCNEVz4P4HvYq624eEXSUZiLsDAg/O+lxXhQcydVgANqG7wUjQkMqxHfVh4LeTAY6+1OHsMJjYvENS+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M5dYFWFMndhZWgCGolfxsPrfuudZN98o8VbNWzU5oU=;
 b=XPI0LKpkMI561A5m3BHjPzSPVxayq9JnrnZBp9WA6Csr1jQoaKRg8LoFDmzD/noyjL5A/b2rJ16bvyOEA4gsjGIBatepfAqsnbHEZCp3w28iGHROVzc/AgftVOor4kiDuKODxT4eZINiNyCYoUKQLFdh4r+xUbxsSjf63raB3wOgofPhVcA203MMwq43CvSoatkhhfaU/WO+ucTKTJVqc3zVNuRIWbJ4RUfQmz/tWo1NVw1SIzMf65Bkee+f0YytFPirXhPPSKTd4w7IdMGVW/XAqIXNO9Ga0Neogc0/VrxXru7p1SWydIVgUQ3A2VUuNcghr1oBOGAJcSoFActVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M5dYFWFMndhZWgCGolfxsPrfuudZN98o8VbNWzU5oU=;
 b=3j/LCsEg4nYxM/UgYzKhgQZVDaRea2IdSryz2PZDBCLSxIj3eGNlgFJuZW2SadHZZydlqta2xPaRYU8PY+RqvZS1d9LR+e6JuM1ZicuVdn6kwCbBMXMdAKDjhG/bNo1Os983Z7tNkPKw9UDr3Us9kgYE5UiyVNjNWhkpMN+uIjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 08:20:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:20:35 +0000
Message-ID: <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
Date: Fri, 8 Mar 2024 09:20:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0184.eurprd09.prod.outlook.com
 (2603:10a6:800:120::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: af5b9e13-bb2a-4ade-7a76-08dc3f48a0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ca+WpTg5BGRFOhkNqap7Uv+DQQXu5rT9f+zJKezcg5yQiV/ic4f7xu8WRDXXjevnDOyqiz2ZPlzfU8Y8jw1UuJwMZkcPG61N0NLHeD5XYDgaSTmjL85FmrOD8m3nx9AezjNU6fk8FLhJaw23yRPEWAG9T2TsAlOiOcfpRtvPii00T5mo7lL4a2t/ZmkoYvhNPGHsZckyv+RYihyrZbYhLsCvjjajsA3g29eokWSNb6n9dVmeXjrTgHWw0AAiBOKjCG5jMw/00pH9HfDHv/FxH5KESBJ8VqM1xUbZ0x9UjaNYJIfKRSc9bF9y3G6jx5hpo9qavhTr5Ytu890tRnzO+GRngoC4qTyd3jv9YEsDlyvlYLetLVWSz4onvThyCNvyAyl/cUX/LTt/lGKy/C8OjoOM8KSSkxLG/gk0ZnoPUHTL6E521r+DfgHytVaOkDOBEuV5nEk/5TKLqC8cJ+GzJI+QZIAAo0oSdTf3s3T3www+Xc+tkD+5FvUcBYeZKcg6wDyEqvWSB/rQuJpTzWgRnfI+xhlY0dFV3BhhqCsY3I66hw3i8/mclD47DjnPySjMqKyyTxZMlN3cWppy1C3Vpwazsufn/6J0GKCzb6GPrSsZr6IoUJfj+Bf6geeMSkeqXK2DXETbhmhgv53Ih82OU+/M6RKoeaugTV/98gUarfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWYxemlRRm5DbmQ3bzNhR01mRjFDSGNQYmVCdnJTc2ZncTk1STg3cy9SaDll?=
 =?utf-8?B?WXZLM2RPV3FRME5TMTBVOERVSk5RQnVjdUxNY2NSVk9adGw5Y2dFVHJLVFls?=
 =?utf-8?B?a3Y1N1B5M2RDdUkxd0hMRHZpdlIvbTR2aWwzRzFnN0Z0eTFnSnZDRWJLVjBV?=
 =?utf-8?B?dWd2aUR0K2xWVTZ5VS90cHlSZkVsemhNRnRHY0RQTWQ3NVVVbEd1eXlRaUFn?=
 =?utf-8?B?cHROZ0h4QWt0c2swWEVYRExEczFjMEVkcGxibExQa3JCTFJOTXIrSm5RM0FK?=
 =?utf-8?B?L2J3M283WXJTTEE4RFZxemoyaWxmNjFFVHc4V2N2Z1E5bFJBOG1ZOWFZeHNM?=
 =?utf-8?B?bS8xbXJKUncrM29VN3phUWUybWc1bkRTa0UwUnVhMFkrbDJ5T2wrdFAyMXBQ?=
 =?utf-8?B?SFZySlhTaGtLOTVoL0dYUkpSelJkTXNEd2hXaXp1UmI3UG00cE5ySE5LaWo4?=
 =?utf-8?B?bmYxcllkVmtEQS9vYi83RnNCQ2Q2UGJvM2ZxaVY1cFRaUUFKbDB4UGk4aWVW?=
 =?utf-8?B?cmdrQVNKVXNwMDJJQWJoUFA4c0dxUHhmZVAwckV4SUdtUkNEdFdBYjhhcks2?=
 =?utf-8?B?aEQ1ZXg2TjczTEZsdk5vMXNwV1dBaXFYbzROZEl3T0ZqNmd0OWtTbHU3ZDNs?=
 =?utf-8?B?azhTOUV3STJJL29iZk45VGhtMVQvZ1lOM2NIVjRzTjZlbVF4OHFtWGJXSjJ3?=
 =?utf-8?B?a0JqdVRXUlRVNC94VENUQXhUaCtTa2hHMHN5WFBjTEJvVkxhWWptMVJIVDk5?=
 =?utf-8?B?aUw5YUViWW92SDJTT0ZtR1l1eDFyRHMxSk81RlJZWlhMQ0hIQU5ud1p3SE1z?=
 =?utf-8?B?cEpUVzdCb0d4N0kvTk5tSFlzMkJoZ3pCNEdrSERuS0dOSmRjYytGdFR0NG40?=
 =?utf-8?B?R2FCVVlWYVZCRVMyYVM0bHI1MlA4R1BscXVjYk9LMStNWlVuU1ZaRXRJVVpH?=
 =?utf-8?B?WnV0Y3RqR2wyMEd3a0c4MU96THYyMkJseVNocmNMaDcvbW1VbGxubkZMUXRU?=
 =?utf-8?B?bWpRT0F6OFA2cHhTS25ONEsrc2VQY1BnZFd2UmhSbHFXRHd4NDd4bHMrRHlj?=
 =?utf-8?B?TlJXZmhHeXBZZDVCdjJVcVM4dVlwZ0NhWHNvSGFGQjdvajY2YWovTEJnNExt?=
 =?utf-8?B?aUJ4RmVGaGxtZzA1MGJxVVNraURuUEVFbFlXaDc2ZzVaODcrRWFPT1ZSRlBU?=
 =?utf-8?B?WTEycXp4dHlzNG92bzVFdVR4U3dEckRBNVVoSEtpMmk4N2dsZXdyckVycmg2?=
 =?utf-8?B?eUZMUnprRGZURnNFMCs3WFNiWFdrT2MzenRHbU00T3N1c01QNW9XdHJwNnRK?=
 =?utf-8?B?NDNKNDZuaTlXSVAvOG9ERzFKU0hnWjBRdWswK0ViU0R6MjEwWUdkOC8wU1Nl?=
 =?utf-8?B?K3B6NGhPeWZBMUV5dmtUV2NxbHdxa2J2WElDVldsbmxKYUxjYWJDeWNIQ3FG?=
 =?utf-8?B?ZFQyczYra3RuS29ZMGhKdVdyQVV4YmxEVHU0OUh4bmw4cnF1dzg4eXJneloz?=
 =?utf-8?B?Q1N1eExsK3haUVBKZnhpc0g5YWhBTzB6U3hVUXVCdlhBaWd1RXNIVFVjakUw?=
 =?utf-8?B?MnByQ2s2bzVjNTZpUFhnL3cxOC8xY0xYcGhiSU5zTDlNa0pZejVnRFNUSElN?=
 =?utf-8?B?cUJEbW13Z081WHd2aGFCejB3OXRwc3FneHVWaWY2NWtBb2NEaUovUDRKN3ox?=
 =?utf-8?B?RWpaOTkxZFY0VDJMck5GNW1uaFVxQnF3UjhWN1QwUmVuK3UvYWU5djhVelV1?=
 =?utf-8?B?Z0ZORnB3SENJUGpNWlRhbEJNaWU4WXRCa3JoaEdwd244V2pXQU9uMit5VElS?=
 =?utf-8?B?MUdnNk5rN0ZBUERkampLeGptT0VmYkRxbmV5cHhjMnVzczNTVUljTFhweXFx?=
 =?utf-8?B?SjdBblg3dUh2N0pFVUZTL1h6dVZxSEJvUHdFbk1zbG1lSkJnckgwckphRmxL?=
 =?utf-8?B?NDdYdmg1NkszQWlGSVJVelpQNkw3YVVIK2dudUJYTVVwVmZDRkdPZ3FKUWN0?=
 =?utf-8?B?Qjh1WHFabGtxR0pXeWxUZWlrNjFZb2dmN0tnakZ5Ris5UGgzeVpUYWlBWmhQ?=
 =?utf-8?B?WEU0a2Z4UEdub2pvMFRMTjNUcG5iV1FwZlRKelBuc0NWME90d2xsaTl2QkNh?=
 =?utf-8?Q?2QrKZE3p+qX2yeJPMawXXmWRU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5b9e13-bb2a-4ade-7a76-08dc3f48a0ec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:20:35.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2wU6/1IGEQKuKOyrv8oSzQtKwIrhE2W93otyl0W2NVEWLnAzLLCE4jP+gvAYzDA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181



On 3/7/24 16:43, Andy Shevchenko wrote:
> There is no use for whole 16-bit for the number of chip select pins.
> Drop it to 8 bits and reshuffle the data structure layout to avoid
> unnecessary paddings.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/spi/xilinx_spi.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
> index 4ba8f53ce570..a638ba2a55bd 100644
> --- a/include/linux/spi/xilinx_spi.h
> +++ b/include/linux/spi/xilinx_spi.h
> @@ -8,18 +8,18 @@ struct spi_board_info;
>   
>   /**
>    * struct xspi_platform_data - Platform data of the Xilinx SPI driver
> + * @force_irq:		If set, forces QSPI transaction requirements.
>    * @num_chipselect:	Number of chip select by the IP.
>    * @bits_per_word:	Number of bits per word.
> - * @devices:		Devices to add when the driver is probed.
>    * @num_devices:	Number of devices in the devices array.
> - * @force_irq:		If set, forces QSPI transaction requirements.
> + * @devices:		Devices to add when the driver is probed.
>    */
>   struct xspi_platform_data {
> -	u16 num_chipselect;
> -	u8 bits_per_word;
> -	struct spi_board_info *devices;
> -	u8 num_devices;
>   	bool force_irq;
> +	u8 num_chipselect;
> +	u8 bits_per_word;
> +	u8 num_devices;

all above have 32bits. It means on 64bit cpu you have 32bit gap here.

> +	struct spi_board_info *devices;


It means this should be like this and then there is no gap between on 
32bit/64bit systems.

struct xspi_platform_data {
	struct spi_board_info *    devices;              /*     0     8 */
	bool                       force_irq;            /*     8     1 */
	u8                         num_chipselect;       /*     9     1 */
	u8                         bits_per_word;        /*    10     1 */
	u8                         num_devices;          /*    11     1 */

	/* size: 16, cachelines: 1, members: 5 */
	/* padding: 4 */
	/* last cacheline: 16 bytes */
};

Thanks,
Michal

