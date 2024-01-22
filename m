Return-Path: <linux-kernel+bounces-34162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F708374BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD3E1C28E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0F47F64;
	Mon, 22 Jan 2024 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYV5qwr2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8E47A6A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957124; cv=fail; b=ShJgRuKHK+iUr0A6T/kxnYVQdauS1gEQJyhRvaPfHQgzqqtNKtLmFsjKhmLYIQ2JORJM8F3I0tKZhlZKi5PHWWKadbzetWyguDrpL5knIxMP80AFse+Rgp34tN1pQq66Xu/sFHvt4/gfWAri47/XHa0bdUzQmHTScwPh6pMyCko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957124; c=relaxed/simple;
	bh=f8L0U6adrBLK4mS09lqoke0M1BCQexPjjm0tNRb5XlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RT/bMnajNC564crv2TY4yVc3+HJncA4zuPSI68N7NgNMXQkMO9O+yAD8d3puJoU7i7NUpHzfobZvyfGjNel5NukB7yveuClyfXYBFuLCZcW8DNH6DEYc4yG9qW5i7QnKHTCU3uxQj99lGzzLR/NEU06ZaLbNFlYcYXV9jNYI1Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYV5qwr2; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705957124; x=1737493124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f8L0U6adrBLK4mS09lqoke0M1BCQexPjjm0tNRb5XlY=;
  b=TYV5qwr2lXyoLD1F5irdhk1jPNaXrHtMZl3ZtIzGMxGnRUbOPcACBDmG
   g0cmsLJA9TLsBjPkj06neZsKoRpFRMpWNKxkvZSvMcQOov7sjy8chwH63
   Xt/3khXYnPWRUk0s98iDlKn+CEht28aq/qsmGbmZ6Q75qZIUz3KRJZ0J3
   qzic9E7nSwDWTIcsoV7PjFlmeGpSmvisTvzoZgqqtAuixp4qZPjf07AnF
   UIUG335UovZykMHjclU88/EysZKnY6BDeqnxptJ2aeoCQunajeOczuCDO
   XNbxiUDyXYXQsfcf5PuQWaU91wLKZMKTgOpTgk/VcsNUFV63sogj+qQta
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="19893468"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="19893468"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:58:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="735301713"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="735301713"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 12:58:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 12:58:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 12:58:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 12:58:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 12:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu5su+DlbYxubLJd3zXA6PcBnD/Whea+pls8QuNKQ0ORWhW4NJmBzIMly420tQMmIBQjjRSWNQLG2ntxPkzLB3dQiwXCnvSUwNbkO7kcV8o9+hzVU4e1MlmgCXqGAmrmZQUjCn3TkSdmnRcdw+g3VRyK8XK5/0ie/XpVWFrNwjtTL3hU34K8rU/b6kve0TUcHbl5jZRV4AAKMU4vCcXDZFKtoHB8ysmDKMknCRfD799nLzXmqCNfvaDQfLZ4i1rcm9T8RVnSRugeYb7AM9GbevvxWzOLfdInLYaEuy1OY1D3JC3kjcECgB/gkjDxNu0s9ZI/Bw3uBZZPjZr3/Ld8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8L0U6adrBLK4mS09lqoke0M1BCQexPjjm0tNRb5XlY=;
 b=kvIzt5Lzi37KbYo4kylW8S3qFnq7eREUFKLHPoOCclGZQS3nVnUMJh2jqH45auskGu5t7YwtldaNDhBiBxfMdYKGmJjBsMcV/QauXhl1VX1+lYsX/marlYD1bwZ98MCIf1kU2QyjtyerkmyiQFB4j2YOFGwEaeKPnsBh4UZWqgSyx3JPbkyXNRxEY6OyXJCf+69GvfJHhRyRm8IAzFJfdX46bIwXedXC8QQd8d/Dxp67g6U0pxvLPj9MMCgXh/e0RCR/L94xWvjfOQlxpwywor9vEz6OSRRQadGg9HaUPFsp+gUHgrQXsIGHxejpzi5MFX7aSSW68JLsulCREFJsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Mon, 22 Jan
 2024 20:58:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 20:58:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, "x86@kernel.org" <x86@kernel.org>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, "Shen, Xiaochen" <xiaochen.shen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Thread-Topic: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Thread-Index: AQHaSlc7bUSCbHYfxkutH1GOiWvBRLDmHd6AgAAIRFCAAAPagIAAAO6AgAAFf4CAAAHtgIAAI0cQ
Date: Mon, 22 Jan 2024 20:58:38 +0000
Message-ID: <SJ1PR11MB6083A27C628E17FB8BBC4922FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
 <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>
 <20240122182121.GBZa6yIYPtHQx44EU9@fat_crate.local>
 <11fc82e0-961f-4c8d-844f-ad4b99067eb3@intel.com>
 <20240122184755.GCZa64W02KXyeaVXJg@fat_crate.local>
In-Reply-To: <20240122184755.GCZa64W02KXyeaVXJg@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ1PR11MB6225:EE_
x-ms-office365-filtering-correlation-id: c8d6be73-afec-4aff-dd3a-08dc1b8ce85d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvPwZqFZxPDkZxhri3i29EhwNnE21xaXaIevRIKVkCmRHAeIYylk3aTZ8jjZlnGYY+ufTqdePaHLaqQ2qBJLMjBm94M+M9Lyh4TCOrne8QsyCvQb7FN2SKMdFmZ218w1SGzsh1CYjlcKoY8NXCgb1xzF4eVpbv4p5Sg3cSM1BupvrKWH9mlnQ4ofkHvm0PNZ9vy1u6y977cW9KyqdOH25sJUJyvzgnmTtkYxH/O2EOcdAD2Bq/ds7uCFY6w8UH/+3VHPGFrCkGWnusRwAY+15zV7pzYMNS8Bc4KGxEfH+KW1koBWz7alcQrVj4SnKX7mp9z/G99PVkbVfkwLN5ybdD16oo4FCZyMwvSr+QJaHJdqLuVDrTKcgft+/bYwbo7xv2QGQei7Xa0TR332jAoMatZBO61GAc1uXIlyOUzoayjkrZIvSyhNnbWmsirMzkxTk5rTd09rwNBGXVC5Vo3Au4dAtjN1xrehUEhTcZYLT8B1mnT5hRkkWImOVKru0kOKtbOW/gwM3up35aKFn3wji9palX/12+Dhn/FQQbbs11Jnl1VjFPK7TDzrqYm0HE3OXdwWnScSZxMkKfKtO4jniwh1WWmAjU0qC3O45qcvQS11UQ8LzA/IbNU0iWRUyviq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(7696005)(71200400001)(26005)(478600001)(9686003)(6506007)(6636002)(2906002)(5660300002)(4744005)(41300700001)(66556008)(4326008)(54906003)(64756008)(66946007)(66446008)(52536014)(66476007)(8936002)(110136005)(8676002)(316002)(76116006)(122000001)(82960400001)(38100700002)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVhjM2huRFdESnRqb283Q2loR3YzU1pnY0dibEcrMkpubXlKcFRnL3IwSlJP?=
 =?utf-8?B?NDNNS0tPZFVVZUFWbDAyZERFY1Bub3UzdC96WFNWL2kvWnR6ZTF1Qk10TDc2?=
 =?utf-8?B?SzY4WnU3SzVCUVUzMnA4dHJ3b0NyejhsWnZmbm9wZHlMQnJtaE4vUjZxcDd4?=
 =?utf-8?B?WXdLNXgrcGJGY3Z3cHJ3eHZRU0JsNXo4UnlyMDMxZXowM1RLUi9oNUVjSHor?=
 =?utf-8?B?QkFNRzg0Znc1OW4vSTNmSW1JV1ZTRWtLbys1end6MWRkMWFPeHhyMWpYaXZh?=
 =?utf-8?B?T2RKd0hzbTN4bkpUREtKdE9aZUhRSG53UlRQM2xrSTNkR3FrV3VTVUU5WGh1?=
 =?utf-8?B?dnpyNDIrQ05zbmtpb3RnSUhXL0xISmY2N05LSlhRUGFzbzMydDZqSU8ySEVJ?=
 =?utf-8?B?ZlBhTi9RdGt0cWpyeVp5SHpJY2dPTXMvV3BXSXV3ckVhc2lQbG9tQ2N2M0Mx?=
 =?utf-8?B?Y0F6ZjJpd1ZXSSt3djJpM2VGTkduaWRuVFNONTY3ZUsyMysybHI0ZGpVTFBJ?=
 =?utf-8?B?MzBVVFZJems2STVmNGcyUElNUjhZZmlNV2c4Ui9MMFYyajB6dDJ0Z3doVkEz?=
 =?utf-8?B?L21qaVNHaG9HQnZ1dDU2anUrTGpUenhnaDhiNDhkbU1hdG40OUU1Q0xPclFU?=
 =?utf-8?B?UmJoNWsxd3kxWmZwREZ4RWMvT21sb2licHMwMmpGaHNSdnpOUnBSM2FmRHhY?=
 =?utf-8?B?KzhYVjRXVU04WGMvNjNvTlpKc0xuOUVldmF0NGpVVjRlQnJYRXFkMnJBY3RL?=
 =?utf-8?B?ZWxpY1ZIVG83V1FzbXdjQXVjMm9HTUZ3amhwMmxpYXJKTStGOUZ2WGVZemVD?=
 =?utf-8?B?NzY0SFRndDFuaXVXUTh6eXl0b3hTaS96aUR2RUt5MzRubFNtNUVmRStuSGxk?=
 =?utf-8?B?ZE9VdDg1cmwvVnV2dlp0SFJGeUtHWjRvZ2NWcUpvN2pwWGFrS2txV2xLVlF3?=
 =?utf-8?B?eWNmc2lHK1dXN0V3dFh4UzFBNGRnT1JtS3pKeS9KL243Tko2WEx4dzc3T3c2?=
 =?utf-8?B?L2hmTHByanc0bXZCZU93eHFuTm1zYU9pWWtkSkRhQlI1aDRqVnZRaEpqeCta?=
 =?utf-8?B?cnBaY05RQW1LalRJMlRla2U3L1JncWhZNW1HenZwYzNNQkZQL3hZMmtBQlpB?=
 =?utf-8?B?c2dhaDNNUFQ3bmhFTW9xZEJUS09xaHFEUHpxV0wrbytRb0E3eDVVNDFib2xC?=
 =?utf-8?B?TVdoK2E5TmVyV3BidndycU1LWlFUazVqQ3Z0eDhhNEdXU1VFWEg0QW96QlI0?=
 =?utf-8?B?cFhKbTl6bWNLYnBsK3pmeWtQeEE2bmNoVktud3pTZFJtaVR3WjI4dzFTWGNx?=
 =?utf-8?B?SFgxeVltNERUK3lVUHBhY1NJNTdNVVpwS2RLeHM1MVFjck0wMTM0QXpVQkJZ?=
 =?utf-8?B?THlUUEZkZHYrb3k0YUJvamlVdkIwSW5ZbjhYM1EvTUQyVG5Ub1VOcm5zRllT?=
 =?utf-8?B?dDFLalhJYVNRSUF0YnFpeWJpSGVOQmNNSTFTeUNNYWRvcHBJNkVoS1lXdWZW?=
 =?utf-8?B?UTNLTXo3STFMekNiRHlUZTZoNlUvelg2RzBIaWJoWDROR1QycXVoalh3SWxk?=
 =?utf-8?B?eTF4VnRXUmtORXRRNWxtc1BrcFlqelhiZDdxRGZYOHdWUGlKL1ZuM2tCOXVW?=
 =?utf-8?B?QjRraHFzZnkvUVdBeDRTM1RMQnM0aUpCWjhFWXB2L2dncml0aUlxK1U2UTQy?=
 =?utf-8?B?ajhRY05NZE9wb3Vpd2ozdVVsSzh0L1B5S012dU9JRHpYSllVbWQrNFBtcDMw?=
 =?utf-8?B?TFlSSUxHeUFZSzB5eGlqbi8vZmtSZTVaQ05vVndMSUZtd0NlQWJ1RG92WGV6?=
 =?utf-8?B?cnBLU2QyOE11NCs5Wi9RNHprOUVZeTluMlhuQks0QytvM0NZb2d2VXlOWVVM?=
 =?utf-8?B?aERBNXc5bXVDaEcrRjdsVWN2NFcwcXVIWCt4ZEJ5OXl4a3FBUjhXeHJuNEh6?=
 =?utf-8?B?Y29VaU96K1grY2hDL042TXNxREZFOWhqaHM3b25rTWZjUW1GQ1RvdXFlbmsw?=
 =?utf-8?B?d3dGQ3VJbnVQY2ttSHU0QmNmYmxXdGUyTkYrMHpHTVRiamRGanhkOVFzNXB5?=
 =?utf-8?B?NDljdlRXK09HZHBGMG1GclhqTzliM2crd01iLzdqalBSMG5HSExMdG9aQ2hz?=
 =?utf-8?Q?pVwUvae0K30uQ3TY1KzQtq3Sy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d6be73-afec-4aff-dd3a-08dc1b8ce85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 20:58:38.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7n4M7/mFdzsChZYYrGsApiIr48OfBL5v/cYxAvzKBnkEHsKuAtcTlpCNBMyHDizjeTUWFk03nD9J4b1jFF9WPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225
X-OriginatorOrg: intel.com

Pj4gVGhlcmUgaXMgYWxzbyBvbmUgcGVuZGluZyByZXNjdHJsIGZlYXR1cmUsIHRoZSBTTkMgd29y
ayBbMV0sIHRoYXQgVG9ueQ0KPj4gcGxhbnMgdG8gcmViYXNlIG9uIHRoZXNlIGZpeGVzLg0KPg0K
PiBBY2suDQoNCkl0IGxvb2tzIGxpa2UgdGhlcmUgaXMganVzdCBvbmUgY2hhbmdlIGluIHBhcnQg
MDAwNC8wMDA4IHRoYXQgZG9lc24ndCBhcHBseSBhdXRvbWF0aWNhbGx5IGZyb20gZ2l0IGFtLg0K
U3VwZXIgZWFzeSB0byByZXNvbHZlLg0KDQpJIG5lZWQgdG8gZ3JhYiBhbiBTTkMgc3lzdGVtIHRv
IHJlLWNoZWNrIHRoYXQgZXZlcnl0aGluZyBzdGlsbCB3b3JrcyB3aGVuIHJlLWJhc2VkLg0KQnV0
IHJpZ2h0IG5vdywgdGhpcyBsb29rcyBsaWtlIGFkZGluZyB0aGUgU05DIHNlcmllcyB3aWxsIGJl
IGVhc3kgKGZhbW91cyBsYXN0IHdvcmRzISkuDQoNCi1Ub255DQo=

