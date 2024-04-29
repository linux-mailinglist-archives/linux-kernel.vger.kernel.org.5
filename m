Return-Path: <linux-kernel+bounces-161868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC58B5278
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09AD1C212B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40514AB4;
	Mon, 29 Apr 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SK555hWy"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78984134BF;
	Mon, 29 Apr 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376355; cv=fail; b=k9a9f0T61bmL4jCcLXjUIsarGRaIn4RqmKUK1yd10TOPzS8YC5wm2h1I3Xs+Dkt7gQGNzM1sHWSAt8e85YMiiuH4LywQ2YYRRTMUKUFz/px9H4NockpRN2HPFuldHVdrPiHO/UGqUnaodzMw15SiuVCvf8+jfbnzlhxB6mG3Wfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376355; c=relaxed/simple;
	bh=p7e0WbBydufZJ9LOhGuDbwwtxfIBTnWi2nFtbgIpbcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CX7nDln92MR16b2PojabXWmDRfBcuCvR2T6lDL4gVrQnFbfjHz2R/YTbGv93rcBbPg8EAv9bLWRXm+IWk5lGIVINgJp8hO18j9Xda9hFIivdyUaqGWGqhaZqlltecB7X1qwj1tODz3e92HPHR5MRVTrXksXJNcb9vaMnArzq3As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SK555hWy; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glhh08RSA1i+ZbP9pSoz8QqZfzYE5ty+cTT1MopEyoNbTUZ7tTV/BhL/uMLc+cqFBdrGZkhj08KKnVIhiCzW5nCP2iVmoyl7L8hzasPOWFSLwWmrbo6Q8lyzKZrMicLXtZvO7VJ+f3WGcd/twE9yx7o+sB+WZe7nS82h8bD3aBqDuzE+lWJuvrkxCI9ocFYIiL7fzt6kS/ag6TbUoaWnURInZx9batyHmwsJX0ESwx/TwfaNDJs9Pv9ylSApg4MDMk+3o8JKJrYZoFh70G21ZTqKmRscnr+ZsZK355i+WhACGMFBO4HtDmb1Uzru7gwpqs15JMXjY7+RZ+9ge9aOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7e0WbBydufZJ9LOhGuDbwwtxfIBTnWi2nFtbgIpbcc=;
 b=GpfWx2C9OOJfKVOGdQXT5XXEDqYimzE6imXPpcN4IuxEFi+Q4L56w1Vr3cE5efOXClp5LOYJS1ugbxBVD4Rp6qz/2Q4nQyRRuXeRFOblxT129gFUWmHV8+6Zgy31QQ3lFHtIiU8bBdDKfmWLc1xmotId88RW6XdgtCL7L52AkkTeNex8VDLwJa2EYeOGLYdcMY1IaQ1e1b611i6BlamUz6ZdD9X888Yhln4nJtkFAz8GE84/rSrv1D0P2rLMEG7Lle6OHEyr1F69wgDpS2Ew6VO/qOjwk3Vuh0DjP2Yfrv8DpTVg/bJmlClamuZ1bWQ2lwPOTqUhpbkVyIsrCJjsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7e0WbBydufZJ9LOhGuDbwwtxfIBTnWi2nFtbgIpbcc=;
 b=SK555hWy4gItshvmNWPOp0/K8LSWBZLi5OSxog0R7Bg2mOm0ZvkMgbJceCpN7s8mWW8BzNHwLeFRBH2q8+ASwMyxK1NemBZtQ++7xIH5C1Aa7LrOIKQcHBCtI4ea8so+KnwkPW2ZezKcm48fo1KHuNL5kJstlunMjrVxfDz8XOgPv3GuxKx3t0gJcmCuc6dsgJuVAnixpMV4yjyQWeSbHIu3kKcPsRi65EoGivglSHcJeoC8IVCaSEts9NSX3L0M5hFyLgk0hf0+9Bz32JIINr6NdDwyRlKRr+gsuvobxvPZTOJgnwOT/JSk7qJ89bFT8G1hK+JQsA16PFkRBvH4xg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:39:09 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 07:39:09 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jianbo
 Liu <jianbol@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"almasrymina@google.com" <almasrymina@google.com>, "edumazet@google.com"
	<edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Topic: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Index: AQHalmh2YwjSjfzzmU66VYtjn6H0WLF3q+gAgABPNgCAAKoVgIACipOAgAO0DAA=
Date: Mon, 29 Apr 2024 07:39:09 +0000
Message-ID: <c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	 <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	 <20240426160557.51de91f9@kernel.org>
In-Reply-To: <20240426160557.51de91f9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB8595:EE_
x-ms-office365-filtering-correlation-id: 9b7d8be8-66ce-4534-308f-08dc681f74ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rks0bmFaOVhXMGJwcEFkTm5Xem55QUc0UDNaOFBSdm80MWZONzl4d29tZWY3?=
 =?utf-8?B?MnI1K285ZGhvWEk5dkR0SnhtR2UxazdsREpkRVJVcFE1WWZWRndEU1RuM0hq?=
 =?utf-8?B?c2N2MmhOYkNibVMxRmEvR0Z3Mk9VN2ZsMnFSL0lXenRTSVlDek1OZU5FMmVp?=
 =?utf-8?B?YjBQdEZ5RE9HWUJxaTE0WENjbUs3MlBMVXl0dURlaytSWStKWFJpMllUdEdo?=
 =?utf-8?B?T1l4azAyUUZuTVU0bWVMc1VrWWd4Q3pURVAyNzJoOGJFY2dqa3ZVQ1Mva1ZB?=
 =?utf-8?B?WXFwQk5nME42UWVXMU9NYlU3SGRjeU1QQlZGK2wvSGcvNzVLVXBFV2ppbENl?=
 =?utf-8?B?Y3FTbWwxOVhUUG93UUtsTUNoRmpseTg4L3UrMGNub3dNaU40V1dWN2c5ZmNT?=
 =?utf-8?B?ZkFmbEcwT3VhcndIWlduTStYbUY4RXFnbGdmNnBTUmd3NjNZelVkeElFNHVk?=
 =?utf-8?B?RmpuMHF3Q2hjeUUxSy9HYzROdis4ZmUzakhqT3NuT05BVUE5eUwxWXBFNnZB?=
 =?utf-8?B?bGl5RThkaGVZZVlhbVNWZWl5dHQ5RHM2ZUcvTnBlWEFGSVR1NWhBcnlLbVUy?=
 =?utf-8?B?MGJ1VEpUYWJwMHhiYXpnMDQ5c1ZYUEp1TC9TZkRvZUVHRWp0VGxHWmNlRXpi?=
 =?utf-8?B?ZUwwZnRYVnE1dkg4MUpHM0JpQUwxSkk3MGZjLzl5K1UrZlI1cUMrZWdDVkNZ?=
 =?utf-8?B?UVlTV0pxZVJNa2VXQ0c0TkZMdGlxaTVZazl2L3Y3czBCUEovU2d4NWplTnY0?=
 =?utf-8?B?REdmS2lMdzBDQUNLT2p0QkorbnZkYUwwOUdRT3lwaFoyY2pZR0NnUzRwdnlY?=
 =?utf-8?B?eFhvVnJNQzROQW9WTCtnZDNPU2JEUDVLQ3FyeU41Y2txMXZ4eGpZMU5tQ1RS?=
 =?utf-8?B?d2ZKdGJMWHEreTU1dUwxOWk4UHZWSmlFNGxsWWdsRDlIRnY2UTdTQ0pmU2xO?=
 =?utf-8?B?YWp6L1FTVnRvREd0T1FxVFlSbWVoWDhkWFBaTWRPSHcrd0N6ZjhkbEZXLzJp?=
 =?utf-8?B?WEFIUnhjZUI5Z1JpWE92U1RYa3o4MlpwSG4vdEdvM1pwWVNMZlFXZnJUUlNE?=
 =?utf-8?B?MVg2OTJnWFNGOENQbXBsQnptYnZTR3JMUjhqK1crUTFwd1NJRHFjVGZGZVlx?=
 =?utf-8?B?VDljSGp3TmkxOWRvWGFldHZvS3k2RXBOMGV2Q0N5T2x5SS9xTUo5cmJobFV2?=
 =?utf-8?B?bThwUzVvZUdUWTRwMHZWcUxIUWorQ04zYUIvSE92QmQxdmdndmhnRXA0Vlpx?=
 =?utf-8?B?ekJjQlZmQ0FBMlhoaDk0VWZFZ1ZBNXVCTEZCK0ZVeDRZOE5VNmFyMktOSmd2?=
 =?utf-8?B?ZDVYdGMraEdCYk12SDh3M2ErUVdKRVgwSzFFUzF2VVkvdVVZL0d4eFlJeGlt?=
 =?utf-8?B?UHpnTHEyekkwbGxlOWd1QWVVcW5jTERJYm1acG9qaEJHWHJ1VnhGVDhBYkQ3?=
 =?utf-8?B?eFY4ekVtSUFuQVNLOUJUdy9uTFowUy9reEpNRWxoYTBmS29LVG1MMW9UZkdY?=
 =?utf-8?B?SXJ4dDVWTFpkZU42V0hsKzBCUmlYYm8zMkxDTW1naFZ3TWt5cWFJSWcvOGpO?=
 =?utf-8?B?STd2cDZJODk3SlVjd0swNUhJajJUdEh4TW5UWlVaYktsdnJYVklmSW5ONHF4?=
 =?utf-8?B?Vmg3bG9ydlI1MGQrN1lkNXhWV1gyS2U2ZytWMU02a003THgzYXVMTmpnOVhU?=
 =?utf-8?B?dDFSMFVucUVVM3Y2MkFLWE15Q1JYaWNzVlZXaGhqVno5NnE2M3JqbWY3YjFh?=
 =?utf-8?B?d2RtS0VNQzEvSDJlTS92K20zUlMzWitBT3JXbW83YlB5L3hlclRtcjAxSytX?=
 =?utf-8?B?R2FPNjhQL3FOeElNWUJGUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUorYTRDVVF2cEhZQkpibjhIUXdFY0dQMGhNV1RhZnF0enZ3aEFVZFJ5RS8w?=
 =?utf-8?B?cHpLNlRkRkQ5ZzRFZHFtTEhHRlNRTFRIeUpiNlU3cHhIekpPTGhvUkk4bE5p?=
 =?utf-8?B?UTUrZGg3cE1yczdLaWI4eVM2VkF6dzVWMitRQVpQK01ZbVZ2YW44TFFicmt2?=
 =?utf-8?B?c29pMUhZeUE0NXN4Yk1KbWkzWkw1UWNTcTBTRFkzVFY1RlpwMEdiZzJ4aUly?=
 =?utf-8?B?MVk4d3FockhvcWxPUTdxRkdPRnpZa1BrcDZSRitrRnNtdGpZTy9oVlVGQUlS?=
 =?utf-8?B?UXBDTnY3TXpWdkNNK3IrV3lLR0cxQVpZNTNmNFcydzVSUzZ5VU04RWhLdnc2?=
 =?utf-8?B?dVZ0VlVudU5ab00wTGhKN1hjd3B1d09zZkVST3F6cGV2cTdDSUttOWdyQnBy?=
 =?utf-8?B?V0xZVWNzdjlDR3lUOVgxRU1XWk9qWnRzNmdPallIVWFXZlB0dXFYNWpmeWZi?=
 =?utf-8?B?ckQySWhGYk9sRExveENWa09Od2VvT3pSQmJjVnYxaG1GN0VlV2tyQ3RLUnBQ?=
 =?utf-8?B?UXpTSk5zQ0lIY0xQNElHMHgyb3Mwa1BuamU0VUlrb3g5OHgwcGx6RXordlJY?=
 =?utf-8?B?OXlqWXI1SEU4cm8zS1dZVnpLNFk4N3dNM2NtTTZEdFJQVUNjVFF2U2pIRGdy?=
 =?utf-8?B?VFR4azVzMjF0b0JlaTA2eUV1TTJhS1ZieFd6bVkzbFhpcEVIRFVIclpCcElH?=
 =?utf-8?B?OWloT3h5OWhuQkJvTitRekttUksrRmJ2Y0t5RkliNkNaOTlRcjhqSEVzZUZp?=
 =?utf-8?B?SXUrdUdCUG5oSXpNS1RaNUtUWXVvQ3RHYjBrbjN2Vmt4RGV1Zjh1dXdISW5Y?=
 =?utf-8?B?SzM3U1Q1enRoV2gzbkMxbTJibzYrblFnTVJUWU9ld2EveXlJUWNwaWZ6Sklr?=
 =?utf-8?B?T251bFpVVWRkSlRIVUJDTVpQOWhEMENLaTVYMFJMYy9tNmg4OThGZ21hRVlq?=
 =?utf-8?B?NklDWkdIT1lBVjVhaXd1TU1JWkN4MVdQS1JkWmVWck4vTE9Td1BrYmFyVVF6?=
 =?utf-8?B?NUlZVTc3NFV1d3RIRXB3VXp4dHYyVTVIMkszYjF3bVJ0eTU3STVJZ1NRVHFF?=
 =?utf-8?B?aytVVmg5cy9PYm5IanI5eHpFSU9HY0ZOVUwzSjVGL0hUVWJDak9tMWRSMWdK?=
 =?utf-8?B?VjdNbktNN0RoOGFEWjJtVERTcTRYUHpCTHEyRHFrWTRTbHgzS29NUlJRL3B2?=
 =?utf-8?B?K08yRjIxREs0V0EwWHR6aTI4STVQSHFpR0h5am4wbHZ1OC83S3ZQcVVxbHpP?=
 =?utf-8?B?WjZtS0YycFk2eU9MbUh0ajN0N3VjcFJlUi9oNXBhbWxleitrczQwaSs2WVpl?=
 =?utf-8?B?UVVEb28wSzFXQUI0U1ErSm1xY01HOWQyV2lxSzJ1SGlONFhxeEZjMHFETDgv?=
 =?utf-8?B?MFBRWXpkbGVVOS9pTmlLdTNUSFA5QkN0NWhHWHJtVWRndG5hK3FtZnZLb3FY?=
 =?utf-8?B?YVNscEpqVC90MCtIZ0Rxc1BPRG9Cdk9xcmlnSzBzTkFmc01QTXlRcnZmdFBJ?=
 =?utf-8?B?Z1JWSStWa0ZpK2tLM2dkUXZLMDBCM3V5b3ZuT0U1WW9MclF2OFd5Y2Q5T1BV?=
 =?utf-8?B?cnhWdUQwandoRjNRY2I5RFpoOUlsbmpVcmZCRFowRG9UODJ1c01POFpPNkRM?=
 =?utf-8?B?S3p2MHJrNVVEQTEzelJEbnUzNXVNUzdBSWI4QndSNWw5UGQyUmh4aG91VFdS?=
 =?utf-8?B?MXNNZnhXVXR3MmtxYVBsL1hpUm5ka2tReHFJUk51WEN2R0xUT01hR1FDNGZs?=
 =?utf-8?B?Z1FsSDEvcmp2V29JWFJvdm5LL1lpalVacVdvK25JcXY0cHZVZ2o1bUF2cDV1?=
 =?utf-8?B?NjJVemJEc29RKzBFUXk4M3BkbkRzdEwxUXk4OVdjeElDU1hDSDRzbG5FVEtv?=
 =?utf-8?B?WkFsd1lpK3NKWFlNN2ZaUk9BRkEzYmJldGlZNlFuL05sZGhxQ3RTdm9maitN?=
 =?utf-8?B?TTgwa0piU1NXSXd5bTVQV0orT25NQU9DRXJobnJEZmE0VUFPZ3c5cHJMaXk3?=
 =?utf-8?B?dEtZanZ2ZWVGZi9ZK3I5eERGNDJEbTFMS09FdzJRK3FoMG5FUVhBMUdnSjZ2?=
 =?utf-8?B?RXNQdmtkSktIOTNUTll4Q1ZoeCtEVEdzdlNIaTNWVHU5S3pEVVVnQlo2RGtW?=
 =?utf-8?B?NTZ0bmtxVkFFTEorZmlRbXZ5QmMrOXRBVUN4R1Z1YmV6UVB5UlRHOFdvQXJi?=
 =?utf-8?Q?L37rHgfTIG4C5bN1Lkqh4KXe/+aYPZZICLNlbj5UGSnZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5056A0DBE181E469564F7FEDE6D27AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7d8be8-66ce-4534-308f-08dc681f74ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 07:39:09.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttN8dOUwGCT6Arx402ug52rLeIv5ikWSSkq9cayPe4np3G8Au9cbzhHGUomP5nGG542RudlgdZ7UsKptiks/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

T24gRnJpLCAyMDI0LTA0LTI2IGF0IDE2OjA1IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCAyNSBBcHIgMjAyNCAwODoxNzoyOCArMDAwMCBEcmFnb3MgVGF0dWxlYSB3cm90
ZToNCj4gPiA+ICBUaGUgdW5yZWYgcGF0aCBhbHdheXMgZHJvcHBlZCBhIHJlZ3VsYXIgcGFnZQ0K
PiA+ID4gcmVmLCB0aGFua3MgdG8gdGhpcyBjb21taXQgYXMgeW91IHBvaW50IG91dDoNCj4gPiA+
IA0KPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MmNjM2FlYjVlY2NjZWMwZDI2NjgxMzE3MmZj
ZDgyYjRiNWZhNTgwMw0KPiA+ID4gDQo+ID4gPiBBRkFJQ1QgdGhlIGNvcnJlY3QgZml4IGlzIHRv
IGFjdHVhbGx5IHJldmVydCBjb21taXQgMmNjM2FlYjVlY2NjDQo+ID4gPiAoInNrYnVmZjogRml4
IGEgcG90ZW50aWFsIHJhY2Ugd2hpbGUgcmVjeWNsaW5nIHBhZ2VfcG9vbCBwYWNrZXRzIikuDQo+
ID4gPiBUaGUgcmVhc29uIGlzIHRoYXQgbm93IHRoYXQgc2tiX2ZyYWdfcmVmKCkgY2FuIGdyYWIg
cGFnZS1wb29sIHJlZnMsIHdlDQo+ID4gPiBkb24ndCBuZWVkIHRvIG1ha2Ugc3VyZSB0aGVyZSBp
cyBvbmx5IDEgU0tCIHRoYXQgdHJpZ2dlcnMgdGhlIHJlY3ljbGUNCj4gPiA+IHBhdGggYW55bW9y
ZS4gQWxsIHRoZSBza2IgYW5kIGl0cyBjbG9uZXMgY2FuIG9idGFpbiBwYWdlLXBvb2wgcmVmcywN
Cj4gPiA+IGFuZCBpbiB0aGUgdW5yZWYgcGF0aCB3ZSBkcm9wIHRoZSBwYWdlLXBvb2wgcmVmcy4g
cGFnZV9wb29sX3B1dF9wYWdlKCkNCj4gPiA+IGRldGVjdHMgY29ycmVjdGx5IHRoYXQgdGhlIGxh
c3QgcGFnZS1wb29sIHJlZiBpcyBwdXQgYW5kIHJlY3ljbGVzIHRoZQ0KPiA+ID4gcGFnZSBvbmx5
IHRoZW4uDQo+ID4gPiAgIA0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIGdvb2Qgd2F5IGZv
cndhcmQuIEZvciBleGFtcGxlLCBza2ItPnBwX3JlY3ljbGUgaXMgdXNlZA0KPiA+IGFzIGEgaGlu
dCBpbiBza2JfZ3JvX3JlY2VpdmUgdG8gYXZvaWQgY29hbGVzY2luZyBza2JzIHdpdGggZGlmZmVy
ZW50IHBwX3JlY3ljbGUNCj4gPiBmbGFnIHN0YXRlcy4gVGhpcyBjb3VsZCBpbnRlcmZlcmUgd2l0
aCB0aGF0Lg0KPiANCj4gVGhhdCdzIGEgYml0IHNwZWN1bGF0aXZlLCByaWdodD8gVGhlIHNpbXBs
ZSBpbnZhcmlhbnQgd2UgYXJlIHRyeWluZyB0bw0KPiBob2xkIGlzIHRoYXQgaWYgc2tiLT5wcF9y
ZWN5Y2xlICYmIHNrYl9mcmFnX2lzX3BwKHNrYiwgaSkgdGhlbiB0aGUNCj4gcmVmZXJlbmNlIHNr
YiBpcyBob2xkaW5nIG9uIHRoYXQgZnJhZyBpcyBhIHBwIHJlZmVyZW5jZSwgbm90IHBhZ2UNCj4g
cmVmZXJlbmNlLg0KPiANClllcywgaXQgd2FzIGEgc3BlY3VsYXRpdmUgc3RhdGVtZW50LsKgQWZ0
ZXIgcmUtcmVhZGluZyBpdCBhbmQgdGhlIGNvZGUgb2YNCnNrYl9ncm9fcmVjZWl2ZSgpIGl0IG1h
a2VzIGxlc3Mgc2Vuc2Ugbm93Lg0KDQpNaW5hJ3Mgc3VnZ2VzdGlvbiB0byByZXZlcnQgY29tbWl0
IDJjYzNhZWI1ZWNjYyAoInNrYnVmZjogRml4IGEgcG90ZW50aWFsIHJhY2UNCndoaWxlIHJlY3lj
bGluZyBwYWdlX3Bvb2wgcGFja2V0cyIpIHNlZW1zIGxlc3Mgc2Nhcnkgbm93LiBJIGp1c3QgaG9w
ZSB3ZSBkb24ndA0KYnVtcCBpbnRvIHRvbyBtYW55IHNjZW5hcmlvcyBzaW1pbGFyIHRvIHRoZSBp
cHNlYyBvbmUuLi4NCg0KPiBza2JfZ3JvX3JlY2VpdmUoKSBuZWVkcyB0byBtYWludGFpbiB0aGF0
IGludmFyaWFudCwgaWYgaXQgZG9lc24ndA0KPiB3ZSBuZWVkIHRvIGZpeCBpdC4uDQo+IA0KDQpU
aGFua3MsDQpEcmFnb3MNCg==

