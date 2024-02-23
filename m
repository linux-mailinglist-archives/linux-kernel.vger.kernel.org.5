Return-Path: <linux-kernel+bounces-77786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC71860A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF6C1C23850
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42A11CAE;
	Fri, 23 Feb 2024 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UYIVV1+x"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2046.outbound.protection.outlook.com [40.92.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B411715;
	Fri, 23 Feb 2024 05:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666103; cv=fail; b=YlsSWHBkdxSfDcamX+bb27N5nLbuwx4uHS8O/U0e2SLQrGexDsBda9fJHjP5a4aBfXIAex2RMMGaDSD87QL3f2FCJYfC6brtONI4Dh/bnQdrNaLE9XJZ7PBLnzPW5EpscxGGDviGprivU10J0sQxUnZH2ApN6qaxweTYWSWNX1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666103; c=relaxed/simple;
	bh=jqzJdSTCT5461hLZdSP5cR3ySYQD+CUDz6ty016oXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYZQtX+YbZBLZy0LGqbkmYO4xzmoafzonBE5jdlHXctBHcHhdfZSKIA/D0LjpXx9l6MGwbe8dbnRWv1TRoUKHcYYAaqVQfiI4Rjd2Toc//J3/iKyx2M1s9kKp3OQiCBBzLa88XB+i340bZp109J3bGy55ZYMWfTBJ8qZB/v+U2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UYIVV1+x; arc=fail smtp.client-ip=40.92.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfW8GTIcU3LvLkitcqOb49oMYXv5Iw3xF+dGBoShFSl+wxB3LZBkXEARf3Mj5pjt62vicrWAr+Y3OmOx1X7PFG/qmsaK3rCujbPZcoMLzO7A9NBj2DRyhjFiUo4+nbbNLBmAJoogWx9WxKtiGqRz4rKHDvEDxNxqmtPsyydmP/UfHd3BDD5yE1/jMKSEHVsLD2SSg4DRvEoVcsJKIuU2HkrtydRUG0K5b1Mp1kohFUm/cu7cBm3b0hS4uOVWwAtp67zv89auUZWc7R2YNzcHXHUN8FNHFJ8wDygBTKznm7rxjJz8QMO2J2J3teKxLpEMR9FSZvFYlJ8DkyHinGREPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnOZ1fkctMHUQ1n4KD3njZ0jSg9eUw1srX1L9duDUNs=;
 b=WqfGFXiWmmv3lTGZ4dbQzwjsY5FuZDOMirkSzK/b9WYc+UKUVIQnkawy0AKq+9e7Kt7mqm/dGaVIyAqbWr+VVZk5C5e/IEu0ja9xApW/qevgzKvNdYOfegLzNtrBThQwG2rDsbYBG45/Yzj6oBnYCNZrp42IWlcYJ5k4i3JpCH+QiRW7aRKLDjkEODKi1P08urWx67lOwBq7s7T3dxsIow6bUY1wGtK17GQtlr5QGpUtES0meSx1Y9fW7l7ONyU/4A29uYIMnWa5dc2mdK30eLlfWIQc5lK8aJ/uaQdgeZ7ah6O1m0kpyldMs/+u5UDIhGw50HxycTBxY4M8cP0G/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnOZ1fkctMHUQ1n4KD3njZ0jSg9eUw1srX1L9duDUNs=;
 b=UYIVV1+xFY7jQuocXQB0U1AWJyF7NJD6TUvwbA8AXQ2N9GewSsD0lTgCI0Znag37GCpoK+koalA6WRuI0LtIoL+B4tMi/yGXm9th2bI4K53oU6tLj3Ivo10EVrzYQDZfWwjo/efBpI8XJGQkJeV10Q+o92OIUOl/nu1F80XqY0PYcRKYRVzEP8kogJdgh/IlcowJTNY3qPVOIpM5N/YoFaZkzAo3OTrxSk0mXyUgyJmzNT93qD6TpgucENmCeVSHxnEceRChkHGUrJV4Rk9wTSoIksPY3f1sE+n5GPp7OMtQSbKTsoF/gt6CNVM4nFM8BV/iKO5BWZ4wRmUGnAXV+w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB4646.namprd20.prod.outlook.com (2603:10b6:8:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 05:28:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 05:28:19 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	Chen Wang <unicornxw@gmail.com>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: (subset) [PATCH v3 0/4] riscv: sophgo: add reset support for SG2042
Date: Fri, 23 Feb 2024 13:28:14 +0800
Message-ID:
 <IA1PR20MB4953A98C51FA1E9D49200372BB552@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [XQ+8ChO2x1ymu2GRRKYltjSDb8TAAC9V1elF60RwbUY=]
X-ClientProxiedBy: TYAPR01CA0229.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <170866605700.212194.2552276273639061754.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB4646:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4e420c-2c10-4589-ef2b-08dc34303e89
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9qZE+x/5HQrXO6Q9GgOErUOpD0e9uWnw3AJMQYn7qOXLjss51lftdJAujW6gDDJd3K7yOeSoGYaqymxlKV8zqH7VE22Ymxbtj9khnHVaw/D/YTs5x51lIjshSL3VUZ+9g39XlVWCKucs9Gc/AHO8X22p21AU3BsJ8YJNkenG4tNv8dRSYP54z5Peg0fj6i8Gc6BnYWbmUsvFj+Cvf6BDdpmnMtYCQeSKGRyWbvlKIe7D/SmuyDtIjJvFNgSGa2vMGlKmh8oSLphMOijbFT3dMjO5sN18f2cin76rE+Gwq4e3rLSnZMEMKaQnrvxZp6G0YHa46/nzbQFW5BVS3kv0rexJSVkKZAP1vw1flpJJBKDn1fTeDdyxk1naGP4CNrbE/EnksRTdchdaYr2f6JH1VTyotrh9QD25vvvwSoBa/IBpVwp1MYnYclAoWZ5LDMGrCj3PEzih58Fx6gnisAnDvUgTTmlYUqgPqQ3A7XIvT58z1jKQSKrZabN14f6tAYrvgKpJpII+SkaepQm0RDQotpIvjjJyqDb/xRVAD9nwfhk/hs3xoqYjbMEHcqxJqsZBvQ22XBjLNSnw2Fn1lIcd3hOFm6fuuyPys/sXanRJ93mriPRuV1YLggTGhnpJz13A
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTN3MytKaUJ4MjNtSWRjc3M1RHo1ZEkramNnZXRPSGxxOFBhTDZvVXlGMTVx?=
 =?utf-8?B?WXp3MkVHYmc4YlBteUNBSFdJRzlHdWdDNS9ZdjVVZlozbXlzcHd2N3d3U3lS?=
 =?utf-8?B?QzU1Y0xHWGg2d3hCUTBLUU1lR3VkUTNMMVh4VzZRREprRkVUYkhFYVQrZVg0?=
 =?utf-8?B?dU84ZS8zSkJyaFdQRmxsaUJZcXFXeHlqQTFRcHFYRDFldjl1SVAvSDBYbXVh?=
 =?utf-8?B?bTdKY3kxTjNYU1EySFFxNGZtM3l4M2xXOW5HaFBnKzhTUnZkT2FCdDY5VkFB?=
 =?utf-8?B?OXdzVjhXc1hnYitvSk1MSlBrSzJROEsxUVVweHRic0VSN0hGS2NWYmV2QS9P?=
 =?utf-8?B?OWVBclhMODZWV0VBTTV2VnpUa0tzb3BZV28yMmpvWkUwYVgydFlYT3lyVFFJ?=
 =?utf-8?B?SEpUcmhaZFhxT2FKRitpSDdJZnlsa250K2tMclQ1eGp4RVZoQkV5SktBNCtE?=
 =?utf-8?B?T01SNkxHbmR5QnVsMlAwWjVWb2RlTkRMN2ZvUGE0bkxuUDZZVFZ4VkoxQy83?=
 =?utf-8?B?czVtalZobVNLZ3ZsTERST1A1T2c1eFI5eWRDclNZVU1iQlBQODBXNlN3VVBa?=
 =?utf-8?B?Z3pBakNVVjU3QmM0eHFPRFMvajJobmFVb2ZqT0lVSURNY3pLY2ZhSDcxbEgx?=
 =?utf-8?B?dkxzbFRMK1RmRXJvK1U1aXZkR2Q5enJRbDhwcWJOVXZLYUMvbUFzMklETWZY?=
 =?utf-8?B?YWhYT0NRQ1FCL2hpMG5ScEp4RUpkSHlnRHEzMXhNQnpMODV0emxSc1lMWFVw?=
 =?utf-8?B?NG9vQVRqYkJ6RnBjMWFEeHdUejNnV1l2SG9TRlpaQ1hpeml2ODl4dGtXZnFy?=
 =?utf-8?B?Y24zNTZKWkMxNFpka2tYaStEZkNJZExZSkRKdUd2a3pmOTAybUZPRVlmcWJK?=
 =?utf-8?B?cGJsdGdzL1RxbkdJbFBiQUlQTlMzZWZMV2VDMkI0OFRaUTlxV0ZoQ3JXWmIr?=
 =?utf-8?B?N0E5YWQ3bzhkYjZYdzJzMkprR3lRUldLV0svTS85ZEJMbGxBRFdSaURqUmI5?=
 =?utf-8?B?VGxseVd0VDZDLzZMNm1mRjB3NEtQZ1dBc2xkQ2p6aWptRVg3ZnhnbkdxUW11?=
 =?utf-8?B?YVpRaEZMSTE5aGowdUttSEdITkJ6NGxLNVVxc3VFK0ZUZnpmVWV4WVNCeGZO?=
 =?utf-8?B?clBFckVmaFRiamg1WDVma3kwY2E5amM5OFdwSmJ5alFTZFZJRjlxd3Y5bFRx?=
 =?utf-8?B?ZHBVbFVCdHlqZVJHbFVycy93V1RuMmdXOW5vYUJuY3hWWTg5RkM0bFRaTFAv?=
 =?utf-8?B?ZXdwQ3U5OSttdDVmdW5ReEhtRlZETVVrRnF4VExLVFlrT1FTKzlMdy83RVo1?=
 =?utf-8?B?UTFXWEpXbEpDR0RUSFhKNExublVvUVp5NDh1Z3FxZVNxa1NvQU5JbDBta1pJ?=
 =?utf-8?B?R2IxLzZIcklZRno2TkFGTW53Mk02VXRpRTNnOEs2U2E5VjBSUHRIQlRDSkZz?=
 =?utf-8?B?OVNHejMraTRjajk0ZnIvMHJMRXRoRGtpZW9ReVFscGNZZjlybm9ZdmYxZXQx?=
 =?utf-8?B?d2trQlVrZWVNZFp0dnJEaTlOLzRaNzNXRWF1N0dXYTJ3bUptcDVDc3A4ZGI5?=
 =?utf-8?B?S3E2dUE5SUJHVDl2WGYzcCtlQThab0l6dDRjNU94NVZTb0NxNWJ0UklEQ3J5?=
 =?utf-8?B?M3BQVHBEWXBlWHRwUkRRa0tCMlFPZiszN1VKajZaQTRkNGdUVzRUYmZvRXdG?=
 =?utf-8?Q?Eym3xvOe2Yz+3o2mLyi0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4e420c-2c10-4589-ef2b-08dc34303e89
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 05:28:19.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4646

On Tue, 30 Jan 2024 09:49:08 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> This series adds reset controller support for Sophgo SG2042 using
> reset-simple driver.
> 
> Thanks,
> Chen
> 
> [...]

Applied to sophgo/for-next, thanks!

[3/4] riscv: dts: add reset generator for Sophgo SG2042 SoC
      https://github.com/sophgo/linux/commit/1ce7587e507e1762df1dadc22affcd41376040d5
[4/4] riscv: dts: add resets property for uart node
      https://github.com/sophgo/linux/commit/08573ba006ab7bc29c183e0b3c362a0b34f1d87b

Thanks,
Inochi


