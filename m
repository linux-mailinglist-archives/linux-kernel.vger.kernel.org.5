Return-Path: <linux-kernel+bounces-38544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F783C148
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961471C22166
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C4E33CCD;
	Thu, 25 Jan 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CS3Tc1++"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883C33CC9;
	Thu, 25 Jan 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183288; cv=fail; b=nQ9AA1AmayF+gmemynAdjd7fYwdRxtK+oFuYbJysu+1EedPccv3ahj9UN4pANoGJgumUj2GWjCKzLGlWkuIcGvtfyCzSfN+2t84xnI5yEF60e6R15DPjul8q0ZQio7K6879Kp2Ri2vZ3jXuI/QPNlzqMp6iuC34+BBCBIp5tWu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183288; c=relaxed/simple;
	bh=QfnatrJQWFCiwfI7cATft6iK/YPW9VEPEKUSe7wr/BM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HEcoxUdLv5oxZ+iHZ/O4oC7EcOuCj8GBE8p+eJdW8IjAnNztgMokLB14qoFtQx76EPyJY0DguDtjTUCKCWD/rIvZE9y6L1pr1TFayNYK6u5JJKK4YJCB5DpKGhl/jJ/f2JMcxetUw56e/lTXZEWkKMaoZo3241XPQRbYZsCFPpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CS3Tc1++; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq1uK0yO0Bol1B0LweYGkrzVhhAL8C+GWtG/QPP0Gju39YNSUVSNF3IH+zjEw5uKjU7mybVZBsPdft0IvtQjkqRyakvq6ST6qGiEldnO2PZbneDulIsUuObiLQ8OAbXNaUtr+pvJkprcE1kiA8GBv54zGltTx+4cIq37EhVfk8/vuknkF4+wqZ+mG6Rj41bGKbi9226natMQ9VKGC56gfM0L2tvhoPVfKOYtNn4G0AGJcXu+vnvVNKXQTB7ygXXtK3jjtOaukxl4BW/EIOCdlP82joReOjsbySq/T7bq1n2c8kAX2JFIG3PGy3jDUuPkFL/Rzcc3uJwk+ELUPKEI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ash0iV/mw7KylAAQkwk1v/Uc0GYyKtIbnjFDdnGghU=;
 b=EzcC4IG5RBvy33JX+PTdXdO1X/EvVVSUjNHrPLWnxDiILae4tDUXAM6Oz7pKV7YRaJlRGnqmfLVbT+pwvSAtwiqEsQLtUmVhhSrF90zzl67SLPxZz+0yZ2kYG9ybz0K26xjJR8fCDdzYT1S3mlgm1CyhJp+DpZfOF9H66c5yfyqNBfi81yVn9M/FDEpskgQIwHBn/BqkOAntLhypgDZyW9jFTVNu3Yust8Y5CKkuVIbMQV953OyyRPq3pbPVzrtx0tiq/XKfZ6mH4YeoJ/3vILiRNqAyTfsaFTI75Tsr+SbwCGW1x3RhCz5Bvo5aS7PBzeOMlAAMqv1VDq/qp/qBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ash0iV/mw7KylAAQkwk1v/Uc0GYyKtIbnjFDdnGghU=;
 b=CS3Tc1+++q4SGXLu+T9BWIegSHTR47z+OhmFuZ+BfG/xkSMmCrowodnovqVLtBO4umXhoEi8KTH/7XFzdeokbYUoxAtFIthSeHfgvGdC0jWI6bM3AuxOzBzaWAWjyyl9x8LK8c72GXKFcHPvWgDAD9vw5/hzfOwOpNwaZjzdKUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 11:47:52 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 11:47:51 +0000
Message-ID: <6c25f478-644a-4833-97cc-eb7cf5b2b3e9@amd.com>
Date: Thu, 25 Jan 2024 12:47:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: fpga: Convert fpga-region binding to yaml
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <4d87561dcbfab9e4818d7ad99caf89938774a839.1705491050.git.michal.simek@amd.com>
 <20240117214722.GA3176505-robh@kernel.org>
 <1aa2c865-3a9b-441a-ba61-b551f3f7a832@amd.com>
 <20240119233231.GA1290941-robh@kernel.org>
 <ec96c9cd-4734-4265-9693-d997eddccf93@linaro.org>
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
In-Reply-To: <ec96c9cd-4734-4265-9693-d997eddccf93@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::14) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7e82fa-1ace-4ea8-e481-08dc1d9b75fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lsUapyZ/lk40GECUviO7TxMTTIQ1laKEkYxUneRJvKUUUZ7+aJ2DVK81JCChOuDqPDDClRLM/V9sP+b2hNGIuCvbudXEQc0pRvcvgM+zQ1QcaRGiJm3XlfXDHJj54951OJS4/KidYfsLIAACIHy0WSleNBUt6mxU4qBTp8c2erkcKURHeJjAm+E3nimHPmsj0B7OzR7c5c7oXSC9H9tE6jJjdTYe0oo01hQwYK+PsVVnVgcYFGoqz35zq/tNwVYnqR/5tSuWIoK5dCuKOb6iI2Oq0pRZhhxJQdSnpZusAWpyYEFCtaBgr0HMiSI/sCCmQbZvLZMyFJawwsWeLcyKIBgWy3L+o7ybUz38u3fZ5VFc1BQ3bLEOvkdAYMNlmtTH5tTJiE3ukIOBv2D5eMDzzZIsYXXybADs5kh9D0kRtvms0DBxep9TP7JaneJAyiyW4tSz6vPqZi9ByU7bWD2B0mqB8qMKOnN3G+z2OgJmwcGN2lbajWU0azCzkm7R2YXx7Y4tUle5/m3/O6H4CkWWxXrG3mfWe40E0W+Wu8Gs56ozO647nE1SQ2Qg4njw4/ZwJ1tLgC7CIRy+/QwIqfy5NPaW2CVYEoCJQql5qf4trnC5ntoeYL56gfyz6Fw77OJn8yfFfsweuWQJ0B9f+0dQNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(5660300002)(8676002)(44832011)(6666004)(83380400001)(4326008)(8936002)(7416002)(53546011)(478600001)(6486002)(66476007)(2616005)(66556008)(966005)(66946007)(6512007)(6506007)(26005)(38100700002)(110136005)(2906002)(31696002)(41300700001)(316002)(54906003)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG5MaWt6NmUvYmpOWDFUMmFBWnhNNkNaYWNvSU9RbVkvQ2M2QnZhRjJ6L3hI?=
 =?utf-8?B?TkdnUWF6WkZwbWxXNDRFZE5DRjFNRitNL1JCRk9VbEV2R0ZnN2oyZnlRdTFi?=
 =?utf-8?B?NkNiVTk2SXA2VTBSNFBRNnFxYmkwS1Foa2t6R0toa0RUaHBzeU1NZWZPVnRu?=
 =?utf-8?B?MnBYQWFiNWsvYTZ0TlRISTZrVmpqakdYVWlZZXJCUUZRSGxSMWRhNGdsWjFZ?=
 =?utf-8?B?dG9NTFUxN0lkWHRFclV3S1kxem5kakNDNVZibS9NWnVESUl1NGtoK0ViUENy?=
 =?utf-8?B?SUp1V1ZYVFJYTWQ4UnBwNDdqYkVpUlpQUXRYeStvUFhva0s1MDExdDYwa3Nj?=
 =?utf-8?B?TXNTVFZBd0IwVXE5SzdianBFQ2tEazd5bWRaUzNJNEF3b3RwSks0ZHJZaEkw?=
 =?utf-8?B?WExrUU1UMjdGeE9penNsUWZsM1RwYWJQbXdHeHJxTGRhSk1HS2lCNm15Y3dw?=
 =?utf-8?B?aHEzZFpSV3ZjeGlTTTRFdnlXZTRQVk9ObTBuaWhmMC8wZXhWK2kzVjkzY0ND?=
 =?utf-8?B?d3NFQVdjbVdDdFplVEpXNFpWclN5d1BjU3hNWFAxdHVJNGthaGs1UjNJalJj?=
 =?utf-8?B?Qnk0RGpQNFJDYk9OaHg1VCttNU5uN2Fsazl5OGcyZzl2K0gvR0hyZWlzYjRJ?=
 =?utf-8?B?ZHJtM21zYVlkcTBvQXNNRncxUTZ1TW1NaFVsTkh5YWJSeC9DblAxVm9PRkF1?=
 =?utf-8?B?V1ZYYldLSnpQSXgrL1VDaDMzc21tRkFNV1JKdHp6cGwxOHVvV3d3d3NzOHhF?=
 =?utf-8?B?K0hmM3JETTlzNkJ6cEJoRVZ3bmgzQVBVZ21vYituM2ZkNWxCazhiSmtEWDg2?=
 =?utf-8?B?Z0dvRjZDVmZVdDhwdFdqQTF2ZGlxcnJPejA5V3JEQWZCYjY3S3ZJVHVBTi9L?=
 =?utf-8?B?b1kzRGdGRC9WNzVvTERXT3F3Nk9IN3MyZ1dVTUdkZS9iNDY5UnRjZzhzT1lT?=
 =?utf-8?B?czlkTmtMRGVVUFhRaDRpQ1VodXJ1amdVRjVZcGJVYWpZa3dNb3k3MmZGekFF?=
 =?utf-8?B?U2JqdGJqbEQ2OGtsR08wUG5ySmtuRzJRZmpZVWN0UzR3bFdaWC9HeVZjSzla?=
 =?utf-8?B?dEROT3d6anFBckNaeUZkMkJJdnlmSXpIWll4SFdnb24xRmF5eXFEbnNDaFdx?=
 =?utf-8?B?Y2Z2N0FjaTNjeEVhdi8vdEllS2ZRaXQyZFpOamJMclp1MzdSdE9tVFg4Yzh6?=
 =?utf-8?B?NHB5MkpBTjRGVTBDWUZoSEU2WmVDNS9zb05WN3N3NGJLUnA2c2VWd1NjdW9l?=
 =?utf-8?B?RWNLQXNBclF0Y2Y2U3pHWHRSM2c0ZXh4OWZkRU1mYlpuUWlhYTdSdzVMbjJL?=
 =?utf-8?B?WmgwcHdtaEhSUWlLT29MdEZ2OE5MZktrbDBGYU14MVdjMUgrMUVmcnNqZHZk?=
 =?utf-8?B?MmRnZVJ0T3J5bHA5SkRLb1U1VXJ4U3NyaVdjYkt4UUtQSU1EdXVqVUQrTWsr?=
 =?utf-8?B?b1ZKZzNZL2JOUzNXVVhvQVNHYnhmNWpiNkdnZGtWdnZzcnVQR0hpcldsZTJy?=
 =?utf-8?B?M2YzSXJwUzhHOGJYdXN3dGdWa0ZxdXZYNUVaQjFKRW5SM0ZJRmZ6SWg1dzRr?=
 =?utf-8?B?ellTRVNyMm9USXJqYmxaaERLVE13N1NlQWhhSm5hYUVQM3R4TTVvMXRrMXd2?=
 =?utf-8?B?RXVGQjB1L3hVRnFsMGMrdHFLSEpBNHBOVHpHa2FPUkJEV2R0SEZzWEcyNVha?=
 =?utf-8?B?aHU1UFVaRkR3VS9MVnJPRjliRkhxNnk4Q2h6SElvRGFUT2ZCOGJCY3A1QVJM?=
 =?utf-8?B?Q0hkZ2wrU09vcE9kMENzTm40S3RiRDljbjNTOUMwaXJHMEtUbHhyNE83eXox?=
 =?utf-8?B?a3BhUTE5WDJSMHZUMmkySU93S2F1UkNFSDdBZXBub2pZL0R0RWNNeXNHeDY1?=
 =?utf-8?B?amxSd0VtZVB1UytJaVRVYkoxVldmSlRTdzIrdXdUT0Q0YjJSek05bEZFTTJN?=
 =?utf-8?B?VkZJSkJuUmtqbU9YUytkb3BPajZNdUw5RGZYWHVlRWFYT2RDK2pSK0V4RS9k?=
 =?utf-8?B?dkdJWGUvSDlFK2RoZlF1bUh6Z1Z1KzIyQVdWemgwZ0JzaFZUeTEvSmYyNUxF?=
 =?utf-8?B?ZzRtYzhQY2FTZ1RSNTBFRnBKbTloc2tnTGpyUVNVZjlTOEtHdkZmZzQ3SCtk?=
 =?utf-8?Q?b604huSRBMCEJRHZ8ILTDomzE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7e82fa-1ace-4ea8-e481-08dc1d9b75fb
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:47:51.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HDYycqZVqtU0vXY+IiOmepU23UVOocBPzmiHLqInGgMrfp90X5zq3hIh9HR4Kne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370



On 1/25/24 12:02, Krzysztof Kozlowski wrote:
> On 20/01/2024 00:32, Rob Herring wrote:
>> On Thu, Jan 18, 2024 at 01:34:16PM +0100, Michal Simek wrote:
>>>
>>>
>>> On 1/17/24 22:47, Rob Herring wrote:
>>>> On Wed, Jan 17, 2024 at 12:30:58PM +0100, Michal Simek wrote:
> 
>>
>>>>> +additionalProperties: true
>>>>
>>>> Why? This should only be used if another schema is going to include this
>>>> one. That's not the case here.
>>>
>>> In v2 we discussed this with Krzysztof. I used pattern properties from
>>> simple-bus.yaml in v2.
>>>
>>> https://lore.kernel.org/all/b2dd8bcd-1e23-4b68-b7b7-c01b034fc1fe@linaro.org/
>>
>> You didn't answer his question. You just picked up
>> 'additionalProperties: true' which is easy because it avoids 'problems'.
>>
>> His question was is this a common schema referenced by other schemas? If
>> so, then use 'additionalProperties: true'. But it is not. You've
>> defined exactly what 'compatible' must be and that means it can't be a
>> common schema.
> 
> Yes, I missed that it has a compatible, so it is not expected to be
> referenced from other schema, thus it should end with
> 'additionalProperties: false'.

I think out of listed properties only nodes with and without regs can be 
present. The only thing is how to encode it.
Do you have any suggestion how to describe it?

Thanks,
Michal

